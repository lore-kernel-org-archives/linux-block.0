Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE518C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A77520851
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A77520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKSUoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:44:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47039 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSUoO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:44:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B23325D60C;
        Mon, 19 Nov 2018 10:21:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3373B600D7;
        Mon, 19 Nov 2018 10:20:59 +0000 (UTC)
Date:   Mon, 19 Nov 2018 18:20:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
Subject: Re: [PATCH V2 for-4.21 1/2] blk-mq: not embed .mq_kobj and ctx->kobj
 into queue instance
Message-ID: <20181119102054.GA18231@ming.t460p>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-2-ming.lei@redhat.com>
 <20181116140521.GB4595@kroah.com>
 <20181117022637.GB8872@ming.t460p>
 <20181119100606.GB19910@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119100606.GB19910@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 19 Nov 2018 10:21:03 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 11:06:06AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 17, 2018 at 10:26:38AM +0800, Ming Lei wrote:
> > On Fri, Nov 16, 2018 at 06:05:21AM -0800, Greg Kroah-Hartman wrote:
> > > On Fri, Nov 16, 2018 at 07:23:10PM +0800, Ming Lei wrote:
> > > > @@ -456,7 +456,7 @@ struct request_queue {
> > > >  	/*
> > > >  	 * mq queue kobject
> > > >  	 */
> > > > -	struct kobject mq_kobj;
> > > > +	struct kobject *mq_kobj;
> > > 
> > > What is this kobject even used for?  It wasn't obvious at all from this
> > > patch, why is it needed if you are not using it to reference count the
> > > larger structure here?
> > 
> > All attributes and kobjects under /sys/block/$DEV/mq are covered by this kobject
> > actually, and all are for exposing blk-mq specific information, but now there is
> > only blk-mq, and legacy io path is removed.
> 
> I am sorry, but I really can not parse this sentance at all.
> 
> What Documentation/ABI/ entries are covered by this kobject, that should
> help me out more.  And what do you mean by "legacy io"?

After blk-mq is introduced, there are two main IO request paths:

1) blk-mq, IO is queued via blk_mq_make_request()

2) legacy IO path, IO is queued via blk_queue_bio()

The legacy IO path will be removed in 4.21, and patches have been queued
in for-4.21/block.

> 
> > That is why I mentioned we may remove this kobject last time and move all under
> > /sys/block/$DEV/queue, however you thought that may break some userspace.
> 
> Who relies on these sysfs files today?

I don't know, actually the question is from you, :-(

https://marc.info/?l=linux-kernel&m=154205455332755&w=2

Even we remove q->mq_kobj, the same kobject lifetime issue is still here in
kobjects embedded in 'struct blk_mq_ctx'.

> 
> > If we want to backport them to stable, this patch may be a bit easier to go.
> 
> Why do you want to backport any of this to stable?

For this report from Guenter, it should be enough to backport the 1st patch,
and it shouldn't be very hard to backport both. 

I can help to backport them if patches can't be applied cleanly.

Thanks,
Ming
