Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DDC4CECE
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 20:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05E521721
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 20:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uXvJR6So"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfJNUKs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:10:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38766 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbfJNUKs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Oct 2019 16:10:48 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so40669533iom.5
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2019 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7/UqpvX8ZaF3l7u44TPOFcLaTTY3E0fY+ZCnKZIX0C8=;
        b=uXvJR6SoWAlMDz5zdcuMgJF9Xpm2u9AEbNbB6gePMgM6zSaPm5DBWYA/HMSqCY4qzr
         x+YwhDdjFkfu4V/udSDJHUbBAv19UGegp4hxv/8s+h86XePKHChGdmvf+hsjU1lmfhfH
         XDzuUgBuDsIhQlh1s0Dr/+Euj9Cg6QdsU+LM40cQEcmEcdEGxpvDfH9L/qFCmlXQmuhs
         CCVffceavAK2N0To7BS/EoXio9gMtVNGCqrEUp11WuReQx7q4dO7wwOGebEmFC/n5nxl
         YT0dOsuV7Q8MGaJ2D0n8agKW430RXucWfzX6OnwanBXkIH1rt9ex1rCw7eFFZ/BbRAFZ
         2jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/UqpvX8ZaF3l7u44TPOFcLaTTY3E0fY+ZCnKZIX0C8=;
        b=BJikdG5KayLS3WMN288jBYQ35oZqxgj8+SpVX1ET3V+37TzZjDu0/ckuXvW8ulqxfL
         wmC2RoE2egHC35aG3DAwwPJh5peLOpUMiSKeu3nJdtsoTQtmib2Xdmu14smEox63EisG
         TTzb0JFq/ivB1Snh8KJt5xdhEtt7T0dDMNSJEE7hWfq7CJmtMeu4O4lufbcSInzty3sx
         vwNiYzHkdcHrr9HU2gM2pmRBRCMuZ+Im6lEqYyuhwGCBlt7OLncb08fR7jYYhP2gPTAL
         GkQ18waQ7TUvuDXgpAf0qqiIF3g2hjIpuAJVEH1ZKvycJLWdOv/mcm5L7ggC+UOBSD4D
         jeHg==
X-Gm-Message-State: APjAAAVDxnBj008RXAD3vpBgyYqjBmlMbKFl9mzWR7vXgEGf4lHW84/V
        K8FhdFVoDK3k+qz99IeALhg47g==
X-Google-Smtp-Source: APXvYqxhVtzFf9kExGyK0EzLx8kEEAbWHhi0c4q+2NTSU1Ux2svtNVolv/D3JEqkbt4As5EPMd2njg==
X-Received: by 2002:a92:1604:: with SMTP id r4mr2253281ill.253.1571083847222;
        Mon, 14 Oct 2019 13:10:47 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o16sm1777892ilf.80.2019.10.14.13.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:10:46 -0700 (PDT)
Subject: Re: [PATCH V2] io_uring: consider the overflow of sequence for
 timeout req
To:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com, houtao1@huawei.com
References: <20191014115156.43151-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5143060-81b5-c6de-f5f9-f8d9a2186fdc@kernel.dk>
Date:   Mon, 14 Oct 2019 14:10:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014115156.43151-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/19 5:51 AM, yangerkun wrote:
> The sequence for timeout req may overflow, and it will lead to wrong
> order of timeout req list. And we should consider two situation:
> 
> 1. ctx->cached_sq_head + count - 1 may overflow;
> 2. cached_sq_head of now may overflow compare with before
> cached_sq_head.
> 
> Fix the wrong logic by add record of count and use type long long to
> record the overflow.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/io_uring.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 76fdbe84aff5..c8dbf85c1c91 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -288,6 +288,7 @@ struct io_poll_iocb {
>   struct io_timeout {
>   	struct file			*file;
>   	struct hrtimer			timer;
> +	unsigned			count;
>   };

Can we reuse io_kiocb->submit->sequence for this? Unfortunately doing it
the way that you did, which does make the most logical sense, means that
struct io_kiocb will now spill into a 4th cacheline.

Or maybe fold ->sequence and ->submit.sequence to reclaim that space?

> @@ -1907,21 +1908,39 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>   		count = 1;
>   
>   	req->sequence = ctx->cached_sq_head + count - 1;
> +	req->timeout.count = count;
>   	req->flags |= REQ_F_TIMEOUT;
>   
>   	/*
>   	 * Insertion sort, ensuring the first entry in the list is always
>   	 * the one we need first.
>   	 */
> -	tail_index = ctx->cached_cq_tail - ctx->rings->sq_dropped;
> -	req_dist = req->sequence - tail_index;
>   	spin_lock_irq(&ctx->completion_lock);
>   	list_for_each_prev(entry, &ctx->timeout_list) {
>   		struct io_kiocb *nxt = list_entry(entry, struct io_kiocb, list);
> -		unsigned dist;
> +		unsigned nxt_sq_head;
> +		long long tmp, tmp_nxt;
>   
> -		dist = nxt->sequence - tail_index;
> -		if (req_dist >= dist)
> +		/* count bigger than before should break directly. */
> +		if (count >= nxt->timeout.count)
> +			break;

Took me a bit, but I guess that's true. It's an optimization, maybe it'd be
cleaner if we just stuck to the sequence checking?

-- 
Jens Axboe

