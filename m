Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568BEC433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 09:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B33207ED
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 09:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe3Id1lQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgERJVk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 05:21:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38120 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbgERJVk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 05:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589793699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HJOQ32HxxivL7XPB08WBMg9tKCFVDtjphY0EUF7GMo=;
        b=Pe3Id1lQYX0nijTdnaerajxSIAGszLcWEwKvk6uVD64EgxKI1vPwu8MdjEGOP2y3H2u+Gq
        3NvolbuUOzfzVaCd9Y6ez9topq60WQJty5lZA1Ua88HuahSD4AGX7EnZSv9kVZLmn3mfVG
        zfnyRp4IIKG6VaCFsArfU6s8ox4i33M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-iE7nGx_rO_6Oc8iGyMpcFw-1; Mon, 18 May 2020 05:21:37 -0400
X-MC-Unique: iE7nGx_rO_6Oc8iGyMpcFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750D3835B40;
        Mon, 18 May 2020 09:21:36 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D2D110013D9;
        Mon, 18 May 2020 09:21:29 +0000 (UTC)
Date:   Mon, 18 May 2020 17:21:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 9/9] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200518092126.GA35380@T590>
References: <20200518063937.757218-1-hch@lst.de>
 <20200518063937.757218-10-hch@lst.de>
 <8057f6f6-60ab-b0ae-fb41-8ccdc59aff93@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8057f6f6-60ab-b0ae-fb41-8ccdc59aff93@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 09:42:57AM +0100, John Garry wrote:
> On 18/05/2020 07:39, Christoph Hellwig wrote:
> > +
> >   /*
> >    * 'cpu' is going away. splice any existing rq_list entries from this
> 
> Do we need to fix up this comment again?

I think we don't need, now blk_mq_hctx_notify_dead() is only for
handling non-inactive hctx, and requests from the dead sw queue need to
be dispatched to other online CPUs.

Thanks,
Ming

