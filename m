Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FEFC433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15C364E13
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhCAPP1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 10:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhCAPOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 10:14:00 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF0C061788
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 07:13:20 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f20so18091924ioo.10
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gH9C5Gb4gSiy/8WR6ka28+BgVPyOM2ngzpWky4YnjcE=;
        b=UnLsswPwje5ZTxkc0/npgIb5/EQj6xZh+gO6deyO6GadpDfCniH2wk9xN2YYJxRsas
         5b16VlNFK+uNWJ3Sk/o/SLjARO2HJCQVdoXKkoySUmXh5Hy6mpKZ6WMQfrFbQJJbPJbl
         9aISN+jTrz0dHTQvqk7318EKCMETzjZNZMPKXa+FEkdNk5jvaZVmIK5wua/s/a4Sav0n
         obKpJUwLMwt+9J1c4Kx3XhE+XuJgj1s8s6EX34MW7RnES87aU3z8Kcm92HVgR54NkIRi
         SpDGtPqKiVKzidlXdO9C/SBxtg7D9u0PkUx53mCZs2GIvT3dVLucKuyhCZuwAIf6ccJR
         R2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gH9C5Gb4gSiy/8WR6ka28+BgVPyOM2ngzpWky4YnjcE=;
        b=qFclPYk0qWxD/i1t4No+X/jzuGe86LeJwZk31OgQqMJo46UQt4X8pMd1dzELzrBXR1
         opYwF4dWVh0YYUde02OgjFJzi5A29ilMJbsznmh5k4gpRKXoqxB+YSt/dtSEG/2VnEjU
         D7wPKOUUqGGD8ENSGWM1N8OcgQMgcyK4QAtm1c5mO1iN7ACAIHLg1vhcAqZMLEuiq5V9
         qoFfcLwGWzi8QpvlpRfk2g4+tOVt/N8V2One/JBqlmSa8mazz03JH+4umpm7h2q7LE+i
         r0+uYjErffQJIo/smDglAc5o/Z5Ohk/8DFi4tL/6qxfYtLs8421i/CodXZPJRS4gcJmh
         p9iw==
X-Gm-Message-State: AOAM532sZ/Sp2Lz/EihzJuCF5Sm6nEddUzmUtK3v+YDXOu4JMzIteswJ
        DsmX60fpSiUHnVY+6VX8/1KXFw==
X-Google-Smtp-Source: ABdhPJwBqwvX3g4gVcT+hTYyQtkNFRbFfl03XmhfympKAQswxo96hz3d1ecBZd3FfrwK5bX3AKAkqg==
X-Received: by 2002:a05:6602:2048:: with SMTP id z8mr1959302iod.143.1614611599810;
        Mon, 01 Mar 2021 07:13:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d135sm10357634iog.35.2021.03.01.07.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 07:13:18 -0800 (PST)
Subject: Re: [PATCH] block: Drop leftover references to RQF_SORTED
To:     Jean Delvare <jdelvare@suse.de>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>
References: <20210301120439.1fd0eb7b@endymion>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7602f62a-f495-4c6e-3c95-d435a016b996@kernel.dk>
Date:   Mon, 1 Mar 2021 08:13:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301120439.1fd0eb7b@endymion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/1/21 4:04 AM, Jean Delvare wrote:
> Commit a1ce35fa49852db60fc6e268038530be533c5b15 ("block: remove dead
> elevator code") removed all users of RQF_SORTED. However it is still
> defined, and there is one reference left to it (which in effect is
> dead code). Clear it all up.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c |    1 -
>  block/blk-mq-sched.c   |    3 ---
>  include/linux/blkdev.h |    2 --
>  3 files changed, 6 deletions(-)
> 
> --- linux-5.11.orig/block/blk-mq-sched.c	2021-02-14 23:32:24.000000000 +0100
> +++ linux-5.11/block/blk-mq-sched.c	2021-03-01 11:06:49.629077653 +0100
> @@ -408,9 +408,6 @@ static bool blk_mq_sched_bypass_insert(s
>  	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
>  		return true;
>  
> -	if (has_sched)
> -		rq->rq_flags |= RQF_SORTED;
> -
>  	return false;
>  }

Since that's the only reason why we are passing in 'has_sched', you should
kill that argument as well from the function and the single caller.

-- 
Jens Axboe

