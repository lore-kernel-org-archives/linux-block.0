Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E6AC433C1
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A62619B4
	for <linux-block@archiver.kernel.org>; Sat, 27 Mar 2021 15:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0PHy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Mar 2021 11:07:54 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:54021 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhC0PHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Mar 2021 11:07:41 -0400
Received: by mail-pj1-f47.google.com with SMTP id t18so3949703pjs.3
        for <linux-block@vger.kernel.org>; Sat, 27 Mar 2021 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/kLoYzr2iJCoYjrslAcROzzo7q4ivZK9tHkftx5J6s=;
        b=iuo8/g4SwtmUK9qUutdzIy8+X57eDcCBwtoyJ8qvy+rpOHPCUd5ylK/6cNhrKp2DpX
         pfH2hiyHEMUulayNCSYMYU0Ax9l+CVeDUekgp8xyKgmymfqHrephDSVkaYI2j4AhWDMN
         2Qz0miV4d+icqthaxlygq6zzl5Pf1GAJdjmL7b2BnMeZOQTzzd4f/YmNvmb3ZQCMh8ZN
         MU3Kq3tz44BFcCBugn43nK9UwYW2NK/GEbKaHEnDUyyeZQMBJit9XqIIUMg/OhTryyDP
         K0RL5pngg62zf77HEj/Xehzw0CqY4B/LBZxevaiC2o6V5vv/qImUPh2E+wjl5IG7hvH9
         A+yw==
X-Gm-Message-State: AOAM531k3aMaaTduImeGLEGIME56D6692w2X1bGOhmcu6WI7giPoJ1Gf
        dFXzO9hFa2t/nCguwX/dGJI=
X-Google-Smtp-Source: ABdhPJwvWp5Sj7C3QDPpbSNtSU2lFqJOkpQF9elGqR4vFg95+HNsOM5YP18YEj+nQx36GmPUFOF61Q==
X-Received: by 2002:a17:90a:4498:: with SMTP id t24mr18833897pjg.78.1616857661172;
        Sat, 27 Mar 2021 08:07:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:250c:9f5c:fb74:abf7? ([2601:647:4000:d7:250c:9f5c:fb74:abf7])
        by smtp.gmail.com with ESMTPSA id t6sm11208833pjs.26.2021.03.27.08.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 08:07:40 -0700 (PDT)
Subject: Re: [PATCH V2] block: not create too many partitions
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
References: <20210327071309.553557-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bd40894d-cad5-c4be-0502-87a9567ba6cf@acm.org>
Date:   Sat, 27 Mar 2021 08:07:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210327071309.553557-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/21 12:13 AM, Ming Lei wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") drops
> check on max supported partitions number, and allows partition with
> bigger partition number to be added. However, ->bd_partno is defined
> as u8, so partition index of xarray table may not match with ->bd_partno.
> Then delete_partition() may delete one unmatched partition, and caused
> use-after-free.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
> Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- don't check disk_max_parts() which is supposed to not zero
> 
>  block/partitions/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a7558917c47..46f055bc7ecb 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -322,6 +322,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	const char *dname;
>  	int err;
>  
> +	/*
> +	 * disk_max_parts() won't be zero, either GENHD_FL_EXT_DEVT is set
> +	 * or 'minors' is passed to alloc_disk().
> +	 */
> +	if (partno >= disk_max_parts(disk))
> +		return ERR_PTR(-EINVAL);
> +
>  	/*
>  	 * Partitions are not supported on zoned block devices that are used as
>  	 * such.
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks!

Bart.
