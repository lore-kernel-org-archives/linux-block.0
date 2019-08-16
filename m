Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C739C3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418C6206C2
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565943137;
	bh=5yl8SISuD6M0MkJkW+bqzIjHJWlXPU5dB12YNrXITe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DNk7M/pzY4+xzgwDLC3ronrfAzksbziphVUaHr/7fiGlGI9hRsKi0yjpSsd55XZh4
	 zQBFojjx1bqXjd30mo9Psp5uVDuYp0Lt5nk2v9EMtWVj0O3z18s+uDh3Hvbi9YHsoY
	 fZN5djgZyQz27V7BW+M8i4Upgg1vG08IN0RTyNNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHPIMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfHPIMP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 04:12:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B40021655;
        Fri, 16 Aug 2019 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565943134;
        bh=5yl8SISuD6M0MkJkW+bqzIjHJWlXPU5dB12YNrXITe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbXAw9lBflo993t/+ekxNS8oR4dh0CjzFRrGweM9OgfvZ5kxm+XdOYgSyo9L1Euqb
         2VMS3mNNYgtZgTrFcHBbFrztyxQmW2+n6N+uYpnIzYmiySz6xu+KiZ9yCR6m7S6iAR
         AIvFWOjf8E+Rs1kLzHFxGrBZLNlkmETVZePMOKh0=
Date:   Fri, 16 Aug 2019 10:12:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>
Subject: Re: [PATCH] blk-mq: remove blk_mq_hw_sysfs_cpus
Message-ID: <20190816081211.GA7007@kroah.com>
References: <20190816074849.7197-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816074849.7197-1-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 16, 2019 at 03:48:49PM +0800, Ming Lei wrote:
> It is reported that sysfs buffer overflow can be triggered in case
> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
> blk_mq_hw_sysfs_cpus_show().
> 
> This info isn't useful, given users may retrieve the CPU list
> from sw queue entries under same kobject dir, so far not see
> any active users.
> 
> So remove the entry as suggested by Greg.
> 
> Cc: stable@vger.kernel.org
> Cc: Mark Ray <mark.ray@hpe.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sysfs.c | 23 -----------------------
>  1 file changed, 23 deletions(-)


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
