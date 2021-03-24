Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0B661A19
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhCXRht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhCXRhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 13:37:17 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43FC061763
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 10:37:17 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r8so22120900ilo.8
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmnkWePYaAItneKkQnUFMVxIWLNwljAU7TsjdgztSlc=;
        b=11vMgQu+1TuSIfQIDrbDYrANrli/PbJozHFwuKEjzo8C3C6nHyiiJHECq52mF8xh+s
         fPDamH9ydfVbtkpEuZrfoKza2p6u9DZrkxEL9Z+c4p+uc+sSQr9vXle/KsE0ePw79HuS
         P69UscKBZZubvd+BuSNwQxCesjnoHBo+mBE5ys6g6XyUaOw01F/UZQnJsTz5YyMhVOGk
         tUnezdUFydsM+ktGviEZDSnob77IBeSGjJ4UbENd0/QzmAqxyrfSnXXv36IQnV2OOJba
         1OfL6L0rxkLFOAF75n0M79Qimpg1Hh3PTOQyvENLXwIibRQPismmWYJU8gditYN4Q+xN
         7LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmnkWePYaAItneKkQnUFMVxIWLNwljAU7TsjdgztSlc=;
        b=Puv2XXkIaBQHSPho2BSd/eu5y8HrxJx/oCBpvcSv4Lxk8PgWvG3oAN1ULojhpr1rQq
         TuG1o3x1M0B2nwdu5eEH6dTBn90mFxTAZ+3aCS9UntoPJ6XMz+TCHD+RCxZXRgs1pP6F
         cwK/8iAfq/kV04xADgC1HHkoyNEk+1TJ4BDYCEQjyzzJdYGP2Q22oz+Uye69Wun0hSTS
         dOdj841B/9NgyueQ/FMxExIUy/zLm5/GRGxs6wPGbRO4eHdm4ckMvuoYLX8Imt2bqBue
         5m8oIuk9TmpX23FsCalzrnwKE+LhIflPZMCLTVd1Eo2KcaxFbv2PWBWs80ykV3LtXSqJ
         TLbg==
X-Gm-Message-State: AOAM533zypCNFyPQdm7SIIt1Lr4xaAbkVEE3Lju4wxwIehGilWSqllf9
        xP9IL4KRWmsUk8pILnSNgPWczNnOrszP9Q==
X-Google-Smtp-Source: ABdhPJxNizclbnGvS/9RUhpI0CA3DY+feQhWofTcKhuIt6lmq7CFarQCL41Cw6sPweRT8XSFBfT7gA==
X-Received: by 2002:a92:6712:: with SMTP id b18mr3772217ilc.181.1616607436498;
        Wed, 24 Mar 2021 10:37:16 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u5sm1374554iob.8.2021.03.24.10.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 10:37:16 -0700 (PDT)
Subject: Re: [PATCH v2] block: support zone append bvecs
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <10bd414d9326c90cd69029077db63b363854eee5.1616600835.git.johannes.thumshirn@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54d9e538-bd9c-6feb-a9b1-fea1e5d459a8@kernel.dk>
Date:   Wed, 24 Mar 2021 11:37:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10bd414d9326c90cd69029077db63b363854eee5.1616600835.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 9:47 AM, Johannes Thumshirn wrote:
> Christoph reported that we'll likely trigger the WARN_ON_ONCE() checking
> that we're not submitting a bvec with REQ_OP_ZONE_APPEND in
> bio_iov_iter_get_pages() some time ago using zoned btrfs, but I couldn't
> reproduce it back then.
> 
> Now Naohiro was able to trigger the bug as well with xfstests generic/095
> on a zoned btrfs.
> 
> There is nothing that prevents bvec submissions via REQ_OP_ZONE_APPEND if
> the hardware's zone append limit is met.

Applied, thanks.

-- 
Jens Axboe

