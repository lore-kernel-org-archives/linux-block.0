Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DDFC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4291720C01
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+zu7xfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4291720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbeKTSTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:19:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKTSTi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 13:19:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5283D208E3;
        Tue, 20 Nov 2018 07:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542700312;
        bh=6GCS43V8awYkBugZseUHHbkEXc1GQV8mg6BZ2jqoBhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+zu7xfpgEnbfealCnLtt0/54tD5PMXLJq4U7gW2Jldi1ZygtxZ3lQ9o0R/U1jpyR
         bnb0ZgQylu7C8RqYpYDkwNgsTUYKXXZIvwaZaMBFGFk3/GOIPsC4AhCtOe8qDbuxJc
         GkHMjSoXBC0kqBuviem9SWsjuOifa0+S/4zeWukI=
Date:   Tue, 20 Nov 2018 08:51:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org
Subject: Re: [PATCH 4.21 V3] blk-mq: not embed .mq_kobj and ctx->kobj into
 queue instance
Message-ID: <20181120075150.GF15276@kroah.com>
References: <20181120014435.3339-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120014435.3339-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 09:44:35AM +0800, Ming Lei wrote:
> Even though .mq_kobj, ctx->kobj and q->kobj share same lifetime
> from block layer's view, actually they don't because userspace may
> grab one kobject anytime via sysfs.
> 
> This patch fixes the issue by the following approach:
> 
> 1) introduce 'struct blk_mq_ctxs' for holding .mq_kobj and managing
> all ctxs
> 
> 2) free all allocated ctxs and the 'blk_mq_ctxs' instance in release
> handler of .mq_kobj
> 
> 3) grab one ref of .mq_kobj before initializing each ctx->kobj, so that
> .mq_kobj is always released after all ctxs are freed.
> 
> This patch fixes kernel panic issue during booting when DEBUG_KOBJECT_RELEASE
> is enabled.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- keep to allocate q->queue_ctx via percpu allocator, so one extra
> 	  pointer reference can be saved for getting ctx
> V2:
> 	- allocate 'blk_mq_ctx' inside blk_mq_init_allocated_queue()
> 	- allocate q->mq_kobj directly 

Not tested, but seems sane from a kobject point-of-view:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
