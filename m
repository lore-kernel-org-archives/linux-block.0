Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E270EB64D8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjFTNZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjFTNZa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:25:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D509F1734
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:24:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25eabe8b5fcso753332a91.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267498; x=1689859498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdzIdsumWt8w6tgcLa7JYNOj4SBOWfYBxidEV06J4CI=;
        b=lXHAJxXQo1IxWBtyAzKVYQNkyeyShY73a0a1dyt2x8+hwrBcr+Di4YXgEAFePohBXJ
         c4YhOC8xc/lacMFDqn2bkueiKmew5cZCvXNL4ao5hawEaUHveNZ100NXE07TC9oYmy+G
         zdmD6SwgneakVwIzYCYVBcH8GSxZTz+ZPvqnoXh7PQeEkCQm+tyTUnmb0QGFGANsXNu8
         HVB87wzk5a8VUwhteiGbcAXUNr9MZ9nCsSqHa+y8XSLoQqfJO4itluRjSMlZCJjRvP21
         ws4muT8ppkfoXNR9p5LcUT89EHMHzgZ7UH41In3uxXgbi0romrbROEd0wPBBKexQVu3e
         HA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267498; x=1689859498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdzIdsumWt8w6tgcLa7JYNOj4SBOWfYBxidEV06J4CI=;
        b=dOhagwmgcaFNiNTahsT1rF5dbxvf4Cg1I+9lQZMJ0T9eytsX6PxUeaLWddjyTizzRp
         tJZwrCL8GCZrB66kZ3ugBHBn+wcgVuKSw29j4dlbWfxoQhwDDlNvS8PNERgl5tgfR+xC
         ye88ADJ+wurHGXQ23FwkJZwfYuYJJ2WTy7VWF14hyDAaUM06eVKeP8aPrHcAifHpjcES
         GoZcW6ZVs7gEWjUis+LyODGtu6xndLXE/HauDAdezn+iGsynt1G549rh2GqmRq/G5In1
         Jowzpu+y1k6NSiLbWmEAPST2787AaZC6nlqLdMSDukl4vFtkMcWAcEt6FS/DrUT8qhFh
         G1AA==
X-Gm-Message-State: AC+VfDwLwBlMkypLyagDfC9ZJZCM1Oz6W8c5ztGPJgmrwjnNjYpt3yRl
        Ru3K+rGd6YcHsjYSDcnmUnYyJY68ZNxCgSY5ISk=
X-Google-Smtp-Source: ACHHUZ4iXL0ojL9vp6/E8ffxzHW/r8TZGDt8cfJCpsRBDgUZ9HFpqRpY9i8GA4iW/B/A0x8pyi88jw==
X-Received: by 2002:a17:90a:e7d1:b0:260:d8fe:4de3 with SMTP id kb17-20020a17090ae7d100b00260d8fe4de3mr903505pjb.4.1687267498321;
        Tue, 20 Jun 2023 06:24:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gm14-20020a17090b100e00b00253311d508esm7342008pjb.27.2023.06.20.06.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:24:57 -0700 (PDT)
Message-ID: <a7a1dcc3-5aaf-53bc-7527-ba62292c44cd@kernel.dk>
Date:   Tue, 20 Jun 2023 07:24:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] block: mark bdev files as FMODE_NOWAIT if underlying
 device supports it
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20230509151910.183637-1-axboe@kernel.dk>
 <20230509151910.183637-3-axboe@kernel.dk> <ZFucWYxUtBvvRJpR@infradead.org>
 <8d5daf0d-c623-5918-d40e-ab3ad1c508ad@kernel.dk>
 <ZJFEz2FKuvIf8aCL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJFEz2FKuvIf8aCL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/23 12:18?AM, Christoph Hellwig wrote:
> So it turns out this gets into the way of my planned cleanup to move
> all the tatic FMODE_ flags out of this basically full field into a new
> static one in file_operations.  Do you think it is ok to go back to
> always claiming FMODE_NOWAIT for block devices and then just punt for
> the drivers that don't support it like the patch below?

I think we need stronger justification than that, it's much nicer to
have it in the open path than doing the same check over and over for
each IO.

With your new proposed scheme, why can't the check and FMODE_NOWAIT set
still be in open?

-- 
Jens Axboe

