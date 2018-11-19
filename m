Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C57C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D802820870
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbyJUAoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D802820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeKSU3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeKSU3R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 15:29:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0728120831;
        Mon, 19 Nov 2018 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542621968;
        bh=cZeSgYi1n9rqBNie/SFcmdBqLrz9po+z4D6FT7GfABg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbyJUAoh3uWU7KRM2hLTmk1im9kWNt24+QwP1ocvj0mGr2rCI6Iomjix/sx+CXxD+
         leLzO/OOP8KwLPM6jqrS1oH1t3tMFlUZijiSPwe6MLZlenQL2ALisWFZZb9E4hXBLf
         6uypg2VPW/hbcpSe8x6NyzAG/9mpxgHSmLXfHbvo=
Date:   Mon, 19 Nov 2018 11:06:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
Subject: Re: [PATCH V2 for-4.21 1/2] blk-mq: not embed .mq_kobj and ctx->kobj
 into queue instance
Message-ID: <20181119100606.GB19910@kroah.com>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-2-ming.lei@redhat.com>
 <20181116140521.GB4595@kroah.com>
 <20181117022637.GB8872@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117022637.GB8872@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 10:26:38AM +0800, Ming Lei wrote:
> On Fri, Nov 16, 2018 at 06:05:21AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Nov 16, 2018 at 07:23:10PM +0800, Ming Lei wrote:
> > > @@ -456,7 +456,7 @@ struct request_queue {
> > >  	/*
> > >  	 * mq queue kobject
> > >  	 */
> > > -	struct kobject mq_kobj;
> > > +	struct kobject *mq_kobj;
> > 
> > What is this kobject even used for?  It wasn't obvious at all from this
> > patch, why is it needed if you are not using it to reference count the
> > larger structure here?
> 
> All attributes and kobjects under /sys/block/$DEV/mq are covered by this kobject
> actually, and all are for exposing blk-mq specific information, but now there is
> only blk-mq, and legacy io path is removed.

I am sorry, but I really can not parse this sentance at all.

What Documentation/ABI/ entries are covered by this kobject, that should
help me out more.  And what do you mean by "legacy io"?

> That is why I mentioned we may remove this kobject last time and move all under
> /sys/block/$DEV/queue, however you thought that may break some userspace.

Who relies on these sysfs files today?

> If we want to backport them to stable, this patch may be a bit easier to go.

Why do you want to backport any of this to stable?

thanks,

greg k-h
