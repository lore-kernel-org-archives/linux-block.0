Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570EAC64E7D
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3AA2242B
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TqIGKvJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgKTSxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgKTSxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 13:53:11 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5FC0613CF
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 10:53:10 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id a19so3663471ilm.3
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2020 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KGmpqHXl2E5s58RjENuxxIDXzRsrZkrBKU0UphW/tR8=;
        b=TqIGKvJKPK0LUXhmilcXhOka1tg1kLUiKi7ISSNktbKjbiSOicJEmiktUi4xgS5AtU
         r4lUrkGPrs2z3TiS++cbxgGVVEbsMvv/VcpQUW4h/j0skRqbCqZOXp94MTnRUUrMQy8k
         h/ojIxYkFV7aT7omVFBOgZj88t7rtja7EjX1OQdkgV97PgSbQCxW+Ek19iAnxyK1ARgU
         TlAZtWadfNPWmQVIcHPo3gKGqh2XqjVTueMhzeQNJqBoFyddCCjAVS4dcprd8IBrS/5e
         K+pKJSnypocwmHXxMZAnmklUw3a9kISwnFnpyKOuiUDQCkBJ1zzxvGsyge+OUA8D/9U9
         Nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KGmpqHXl2E5s58RjENuxxIDXzRsrZkrBKU0UphW/tR8=;
        b=ooaEclJmDu5Ca8+3duawaNo6/v1+WJHBXkQDBqCMQOCGCKJBzdk8qYdCRr25SCIEzs
         r9stHzL5/D8vqIkhH01g5o0jdmoVkA3Xbj6ZE9FqpBSf5XLoVLao5EpD0mGX9DEk8Hix
         52Q1TuAdwdzTHPcOQK8j5KN/vIku1RfnJhZbRBbWwtiN3Rv//MskFaPTdnC/wCy2GD+s
         er6F2YiZ2rkUKI+qau3gfeg3HQbx0+XxDbd28OtodvNSL174A916XaGhUraoukR/ogIL
         KExHGSAWYgwU34rwGJDS6d56F3inUl0SJzulY7z3V4DkIlJiHF1p7/dkIIRCeynk86r/
         XYpA==
X-Gm-Message-State: AOAM530ecj1mfBF+am8dOxubebT/CjB4b5YPRYgmNCeoJO/D1sgzmq+V
        EUoWHseMOOxsFz+eOeQwakjnSw==
X-Google-Smtp-Source: ABdhPJzq+otmd5dEMF2vstKk7rtHVtNtjfOIqW98HYZS9XU3pcHjmdZBIcCVxu3T75f3CJnw7ARc8g==
X-Received: by 2002:a92:cf51:: with SMTP id c17mr28414694ilr.113.1605898389924;
        Fri, 20 Nov 2020 10:53:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c13sm2177021ilr.39.2020.11.20.10.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:53:09 -0800 (PST)
Subject: Re: [PATCH v2] block/keyslot-manager: prevent crash when num_slots=1
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, Satya Tangirala <satyat@google.com>
References: <20201111214855.428044-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0d64133-1d4f-fa50-18c1-8f3d09bb2a70@kernel.dk>
Date:   Fri, 20 Nov 2020 11:53:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111214855.428044-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/20 2:48 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If there is only one keyslot, then blk_ksm_init() computes
> slot_hashtable_size=1 and log_slot_ht_size=0.  This causes
> blk_ksm_find_keyslot() to crash later because it uses
> hash_ptr(key, log_slot_ht_size) to find the hash bucket containing the
> key, and hash_ptr() doesn't support the bits == 0 case.
> 
> Fix this by making the hash table always have at least 2 buckets.
> 
> Tested by running:
> 
>     kvm-xfstests -c ext4 -g encrypt -m inlinecrypt \
>                  -o blk-crypto-fallback.num_keyslots=1

Applied for 5.10, thanks.

-- 
Jens Axboe

