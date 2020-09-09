Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B1C433E2
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 01:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F26218AC
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 01:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJq9fp+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIIBTe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgIIBTe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 21:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599614373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gf75B6Udqf9iPOzPF2w9rijRVVDFIq7lsR+ojBwz+4k=;
        b=eJq9fp+nYhAbk4mR9vYT/DT1bs8snBCuFGPKatk+mbC3WMaEk+obb1wSmrPYRRyeG095HZ
        WCdDIkRGptirKDyhwthGwJn2k3gBBG0P60J7rlug7vwlbBfs2jkOXoHOitZYqJ6daYAWHm
        V76qoD45U3nEE7VQMs7gLM2ocgyA94k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Ceczz7n6PMSNJVVC4SLU4A-1; Tue, 08 Sep 2020 21:19:29 -0400
X-MC-Unique: Ceczz7n6PMSNJVVC4SLU4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B7D109106A;
        Wed,  9 Sep 2020 01:19:27 +0000 (UTC)
Received: from T590 (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDF91002D5A;
        Wed,  9 Sep 2020 01:19:19 +0000 (UTC)
Date:   Wed, 9 Sep 2020 09:19:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200909011916.GB1465199@T590>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
 <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908153108.GA3341002@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 08, 2020 at 08:31:08AM -0700, Keith Busch wrote:
> On Tue, Sep 08, 2020 at 04:15:36PM +0800, Ming Lei wrote:
> >  void blk_mq_quiesce_queue(struct request_queue *q)
> >  {
> > -	struct blk_mq_hw_ctx *hctx;
> > -	unsigned int i;
> > -	bool rcu = false;
> > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> >  
> >  	mutex_lock(&q->mq_quiesce_lock);
> >  
> > -	if (blk_queue_quiesced(q))
> > -		goto exit;
> 
> Why remove the 'goto exit' on this condition? There shouldn't be a need
> to synchronize dispatch again if a previous quiesce already did so.

Hammm, this change is supposed to be done in next patch of 'blk-mq: add tagset
quiesce interface'. The tagset quiesce interface starts to apply async quiesce,
so synchronize dispatch has to be done in blk_mq_quiesce_queue().

thanks,
Ming

