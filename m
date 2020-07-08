Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D027C433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9CD206DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buWruZcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGHWHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:07:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgGHWHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594246033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02z8p0fSkRkHwTNhR8eTO/BfPTfN/4Ugd2vD3aI9kV4=;
        b=buWruZczz3vkMNu1rInqV6FCD0f+KByMiiVhDLserjxeZ13y5m8NQhDCMEhzItgVDqSDXr
        TGvbcN1X89tFgl3rY9fTJhzgks2erj9Se20ikUSuF/Nml9eopLo5seAQEkM4pv28NRp+tL
        bjMmpeu3SyANrbOfvFW784nL1sgeaAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-mHjTdVaDNkCjwtrHODlUIA-1; Wed, 08 Jul 2020 18:07:11 -0400
X-MC-Unique: mHjTdVaDNkCjwtrHODlUIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 666DB1084;
        Wed,  8 Jul 2020 22:07:10 +0000 (UTC)
Received: from T590 (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 254037981E;
        Wed,  8 Jul 2020 22:06:59 +0000 (UTC)
Date:   Thu, 9 Jul 2020 06:06:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] blk-mq: centralise related handling into
 blk_mq_get_driver_tag
Message-ID: <20200708220655.GB3348426@T590>
References: <20200706144111.3260859-1-ming.lei@redhat.com>
 <841c8170-f082-814a-70cc-b0e3e8b5be54@huawei.com>
 <20200707071652.GA3269442@T590>
 <ad3e6c97-dae9-7e21-30ba-33c06e1fe7b7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3e6c97-dae9-7e21-30ba-33c06e1fe7b7@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 03:07:05PM +0100, John Garry wrote:
> On 07/07/2020 08:16, Ming Lei wrote:
> > On Tue, Jul 07, 2020 at 07:37:41AM +0100, John Garry wrote:
> > > On 06/07/2020 15:41, Ming Lei wrote:
> > > > -	hctx = flush_rq->mq_hctx;
> > > >    	if (!q->elevator) {
> > > 
> > > Is there a specific reason we do:
> > > 
> > > if (!a)
> > > 	do x
> > > else
> > > 	do y
> > > 
> > > as opposed to:
> > > 
> > > if (a)
> > > 	do y
> > > else
> > > 	do x
> > > 
> > > Do people find this easier to read or more obvious? Just wondering.
> > 
> > If you like the style, please go ahead to switch to this way.
> > 
> 
> Maybe I will, but I'll try to hunt down more cases first.

You are reviewing existed context code instead of this patch!!!

One more time, please focus on change added by this patch.

Thanks,
Ming

