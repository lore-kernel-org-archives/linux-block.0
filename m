Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C9C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6B720868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v7WLb5TB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6B720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeK3CWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:22:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51077 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeK3CWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:22:55 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so4116569iti.0
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hVDDm375f91NozAnJ/Vpp5CaN0zLcD75sn3guf1ds4E=;
        b=v7WLb5TBqT/xdjBwhsqdB3jMAXloLEjmay5art872SQkrIxc3+ZWVklDcdBE1x/KMa
         zhsYzcuNGW87uEk7Hy5QPXHkCBiQtlV+bJ+/LhvOgW+Lgxdxc8jCYdlCbc3n5zQrkluw
         wVk39j9ovhodCLcTZzExr8F9FKnd7CncxPXzJPzJVU3nLYGw35mFp2LkkyzAfCqLiHK6
         LQLqkk0zHGKoUtbxDiZjJNpOP/463GNdAVF0FPXc/grSM30EvRChImYarVTP4oII5uoy
         uMPXyczXYtc3DDQ/0bFRwkoRmi5T2OJL2eQxc3qWOIGpf6fGP65O9vEk1OaLsLAZypC2
         PAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVDDm375f91NozAnJ/Vpp5CaN0zLcD75sn3guf1ds4E=;
        b=Jmw7TeZbvuQVUU0FY7Rqt0SBfxzcLHgzhrQX5dcd2fvi+hHKqPCGlEzQtUYrZJAKB8
         DeuX+yNH3QN7+5GDRMYNyHzcLmzjdnqYH7AlWhYtH7anFhap5PUS2NmOJ7YgjeQn8dmE
         WYD9u5yYt1kv6JxW7Q6iuLGkDh+kmUG6oyEapfms3CyVpyX2LBihOOpXPCdNdJD9zGBb
         LuUg2HHZNL2vTRW/wrVnDKb9DUdr58q55Gm6B94PCFgVB7FpOg+he86DtNCIwCSqJaQ9
         tnFtFuh3KS1jHTrfh64Oa9bp33c91Zlu0fVX5DdmIGB0NFLksIFcHSc3lOoKlIwdFtnA
         C8Sg==
X-Gm-Message-State: AA+aEWZ7FZYcU6jazZZNTYPl3QRtlLrK2wW3r8NQGp0iYSepc5Z4WtXW
        V21uKkcSgxu2Qf0VuoO1sHA1uHFN+u0=
X-Google-Smtp-Source: AFSGD/Xc2I+sfHtAdEJM+8SH0GjR1h4N+exPPTUO91CZbqeghPHuaKr/WO0Ip/BBhmadREXPZ/sglA==
X-Received: by 2002:a24:d1c6:: with SMTP id w189-v6mr1888176itg.38.1543504632912;
        Thu, 29 Nov 2018 07:17:12 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r85sm872157iod.13.2018.11.29.07.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:17:12 -0800 (PST)
Subject: Re: [PATCH 1/2] ataflop: fix error handling in atari_floppy_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20181129105519.mklhnmx34yjucb22@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c57a937-86c6-70c6-59fa-3e08b1f1de58@kernel.dk>
Date:   Thu, 29 Nov 2018 08:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129105519.mklhnmx34yjucb22@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 3:55 AM, Dan Carpenter wrote:
> Smatch complains that there is an off by one if the allocation fails in:
> 
> 	DMABuffer = atari_stram_alloc(BUFFER_SIZE+512, "ataflop");
> 
> In that situation, "i" would be point to one element beyond the end of
> the unit[] array.
> 
> There is a second bug because the error handling calls
> blk_mq_free_tag_set(&unit[i].tag_set); regardless of whether
> "disk->queue" is NULL or non-NULL.  So if blk_mq_init_sq_queue() fails,
> then that means unit[i].tag_set->tags is NULL and it leads to an Oops.
> 
> It's easiest to call put_disk() before the goto to clean up the partial
> iteration.  Then the earlier unit[] elements are fully allocated so we
> can remove the checks whether "disk->queue" is NULL and the code is
> simpler.

Applied, thanks.

> I hope the Atari floppy disk users are appropriately grateful for all
> the love and effort we put into their software...

I'm sure that one person has you on the xmas shipping list.

-- 
Jens Axboe

