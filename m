Return-Path: <SRS0=RRdq=EE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00518C2D0A3
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 13:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8031F2075E
	for <linux-block@archiver.kernel.org>; Thu, 29 Oct 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="m4I1ODT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJ2N1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Oct 2020 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJ2N1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 09:27:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581FC0613D2
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 06:27:43 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g7so2947554ilr.12
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BLURH6YCJFBprqjok1CHpUG+s7kh59+b4VJ4bcfHdtQ=;
        b=m4I1ODT52oV4w6KT41GtVUmZggIuGxy/4SrGLyR90MKDdK2RRKyQ+Ydx0kAvW2k2ZR
         jbWetNB1HDEVa4kZUQftVaNybmhORxXCbwVqYkOZ99UKi6RYKznTCGvgr2cUc/mDh/gG
         6thtIGxpHtpCD88wdO18/EXNxIrmbAe/FuprfOeBESSXyxfO+mFMPnFfW2vOdTOcNYcc
         56RY10eeb3M7GbwBzwDj7bi2aQ0UGANrrhiTljiVK5UyOFCZhTEKIiRUWPmgRykrZghD
         aeBvOlRvcxtzsMlPKEtXVre2yD9XqNUczopsjJ/W0ckoiS58HMAiUNwl66rqcRv8ruzb
         /HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLURH6YCJFBprqjok1CHpUG+s7kh59+b4VJ4bcfHdtQ=;
        b=hlOn9nZ8pgrxQhN/cetsxrFHISxYY31zrL5Uv052fJkGdq4yKtKemBtpoVBbcnQO9U
         P9SwqrDY0pxqo7nx0FjoBopA5AX80FbDeyghNa98/uZGWQVwDGfmU+Ob0ejGd7q4yM7X
         DegWsQF06r9R/1s911uprfrRoAAc0bQ4UWly+V/R70yGhZ17wrKfuIwNhyz7F+nNFo98
         AY9K7575QE12GZP+XoJon888Tv/lCDvJs9r+8U22N6EGK8Yoa4aeMkZbKNlIVMAKOe/9
         gxAXpO2Gm1vAAPhR3n8ceo3UeaOI570LnbIQhy/0BOFA1V7xiNFASMCfCTqa4I65LFpr
         cHKA==
X-Gm-Message-State: AOAM533kpIixZ9zXeEAOZPuvuTJ8I5VYn8mOXj/RkTWcZ3cCNozBi+SH
        0ulZtA/nkjWsJ5DyO+lao+Tudw==
X-Google-Smtp-Source: ABdhPJyTJcmTmCdo4C4Jc9CEvsTGu/0xrsm1Qj0vp7PSGEWLBVVrmjGbSluDG5U+oyJvjZX27w5X7A==
X-Received: by 2002:a92:c04c:: with SMTP id o12mr3266219ilf.22.1603978062376;
        Thu, 29 Oct 2020 06:27:42 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm1855724ils.23.2020.10.29.06.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 06:27:41 -0700 (PDT)
Subject: Re: [PATCH 0/2] zoned null_blk fixes
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Kanchan Joshi <joshi.k@samsung.com>
References: <20201029110500.803451-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0dff7464-c7f8-9ce1-7946-cc8896e5e2c5@kernel.dk>
Date:   Thu, 29 Oct 2020 07:27:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029110500.803451-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/29/20 5:04 AM, Damien Le Moal wrote:
> Jens,
> 
> Here is a couple of fixes for nullblk for this cycle.
> 
> The first patch fixes tracing of zone condition in the case of a
> REQ_OP_ZONE_RESET_ALL operation.
> 
> The second patch fixes a more serious problem introduced with the recent
> modification for protecting zone information using a spinlock. A
> spinlock cannot be used when memory backing is turned on as that results
> in potential memory allocations with the lock held and IRQ disabled.
> The fix changes the locking method to using a bit, with the spinlock
> retained only for function local protection. This new locking was
> extensively tested with xfstests/btrfs and zonefs tests runs.

Applied, thanks.

-- 
Jens Axboe

