Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5749FCA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EFA222BE
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1B1aB/XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfJYUNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:13:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37013 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJYUNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:13:19 -0400
Received: by mail-io1-f66.google.com with SMTP id 1so3831281iou.4
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LaDwK1dBttysDgy5bmxI9pUnrsAfuTXtGo4oQWJvTuo=;
        b=1B1aB/XKR2hoUehFzatf43yf5JyHVsS9QniYqRSNVWhJJMNHLhoDW6Qxffwo7D7UeT
         E/sCm7IvAR+E3t5MWxVRePyRnKzC0/nu0eWplzHtvh4qhseX64nyhuiv6rg/O3GYTzAj
         qvrDbJMQTIuaQwbfVSX9stRJ2m34mMGvVHCIO1XTWCBIkkDyXO2mlas76/C7hcXmlRYS
         46Mx8m/SPKPnPaY6C4fBILqB5FRtGMAe0kkNl1T9DCqu8RoKmznK0RNIK2SpzjICGsxn
         mZcL8vI06/FTOtWy5Zkfo9LGKUIKg86OnaweLmOQA8SSUSg7RJRxcgWOUhlfTal51SDy
         c8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LaDwK1dBttysDgy5bmxI9pUnrsAfuTXtGo4oQWJvTuo=;
        b=KMlT1tBDVxsFApCdLvVzgVZtrweYAxW7iDUtq7nc4kO5CUcUQdpF1qV+DAoMEX5+02
         /Q5WAqwuzyU6aa/ipoMusfdvIWaI4+7PQLs+xg3exXCwX+gxVtAxp0mHSCzbLvmYnJdT
         giqttnMUmh476NerPUyFj4gUNXhtF2FjpM9wzn1lg0CZQmU7wbbhTjwuB9lqspqItKM/
         VVHlXBFS+biIgvJSq2d73kvmzSAi0wA9CTl5/SW0Yb1tMlXWgpQatPVLOwP2y1XkYsWR
         DJg2pNZLROTguHPQi8W8ZT3nBui8Of4tEZv4lkIwVA7EaA5Z37W1cKVqQFdnV9h53qCl
         HG9w==
X-Gm-Message-State: APjAAAXAcj7EQGe5Y59FlfCQXJ9r4P7HXqGXFvjXeXOvXDpqLXjvJYBa
        IsIg92wiYDCKz6QOQeyITm+DuT633ZyE4A==
X-Google-Smtp-Source: APXvYqxcg3NgljBqDEU2ihms35rqgcd43Vqply3q2sn0L6SichFAavwJ77YN/EeTdh/9IOGjyX8PHw==
X-Received: by 2002:a6b:18d:: with SMTP id 135mr5704503iob.201.1572034397771;
        Fri, 25 Oct 2019 13:13:17 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm436047ile.77.2019.10.25.13.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:13:16 -0700 (PDT)
Subject: Re: [PATCH] block: reorder bio::__bi_remaining for better packing
To:     David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org
References: <dacdf91e8d1af60ce5675a87615bdf271e9a3e17.1571938064.git.dsterba@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a5fb3f1-3f6b-1023-3653-2aeb456928a1@kernel.dk>
Date:   Fri, 25 Oct 2019 14:13:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <dacdf91e8d1af60ce5675a87615bdf271e9a3e17.1571938064.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/19 11:31 AM, David Sterba wrote:
> Simple reordering of __bi_remaining can reduce bio size by 8 bytes that
> are now wasted on padding (measured on x86_64):
> 
> struct bio {
>          struct bio *               bi_next;              /*     0     8 */
>          struct gendisk *           bi_disk;              /*     8     8 */
>          unsigned int               bi_opf;               /*    16     4 */
>          short unsigned int         bi_flags;             /*    20     2 */
>          short unsigned int         bi_ioprio;            /*    22     2 */
>          short unsigned int         bi_write_hint;        /*    24     2 */
>          blk_status_t               bi_status;            /*    26     1 */
>          u8                         bi_partno;            /*    27     1 */
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          struct bvec_iter   bi_iter;                      /*    32    24 */
> 
>          /* XXX last struct has 4 bytes of padding */
> 
>          atomic_t                   __bi_remaining;       /*    56     4 */
> 
>          /* XXX 4 bytes hole, try to pack */
> [...]
>          /* size: 104, cachelines: 2, members: 19 */
>          /* sum members: 96, holes: 2, sum holes: 8 */
>          /* paddings: 1, sum paddings: 4 */
>          /* last cacheline: 40 bytes */
> };
> 
> Now becomes:
> 
> struct bio {
>          struct bio *               bi_next;              /*     0     8 */
>          struct gendisk *           bi_disk;              /*     8     8 */
>          unsigned int               bi_opf;               /*    16     4 */
>          short unsigned int         bi_flags;             /*    20     2 */
>          short unsigned int         bi_ioprio;            /*    22     2 */
>          short unsigned int         bi_write_hint;        /*    24     2 */
>          blk_status_t               bi_status;            /*    26     1 */
>          u8                         bi_partno;            /*    27     1 */
>          atomic_t                   __bi_remaining;       /*    28     4 */
>          struct bvec_iter   bi_iter;                      /*    32    24 */
> 
>          /* XXX last struct has 4 bytes of padding */
> [...]
>          /* size: 96, cachelines: 2, members: 19 */
>          /* paddings: 1, sum paddings: 4 */
>          /* last cacheline: 32 bytes */
> };

This is great, obviously been too long since this kind of thing was
looked at by myself. Thanks, applied.

-- 
Jens Axboe

