Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD901C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiI2NYa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiI2NYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 09:24:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964371879D9
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:24:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lx7so1348097pjb.0
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Jh11f7XFxgLcjLMTxBqWYvrFysF6FfTDXPAMMOs13Zg=;
        b=u1tgSOlCt5YC0rcThkifU39yO5J9myFKvRuXdxGIKkE/X3+Uvy57hJ/pU+ykcD/rDo
         lYV6jN2LJHSlTz/wUv4o+/Pa3aoBzelAKkyBnJP8HZxDpHYqQoGesOVRDPKksfhr8R0K
         xlJBDIxJsJwHCg6CNzwfQQrxg411pPXoIXeLGmhyTSErYuExTc4RmTYXvUtb10y5nk07
         wFiC7RkUYZKHHK5k0jj1o9Fx1RcmBbkq6EvGHhvdId33OkxcgJtRcV0god//o/oST3A6
         bVObw6W60DhWVEOsaJG6NXJvyaF8eUl8ywlrs/0y2Q2nyvraW2wMDIa/1tAQ+NJt2RxS
         LiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jh11f7XFxgLcjLMTxBqWYvrFysF6FfTDXPAMMOs13Zg=;
        b=vuStBp/pxY1FzhWoBFlvbWY2apgEvHlIy7B5wQ/jbKtb0ck1fEcPIeEb9VoqfqRfNE
         h2a7C79qw8bx8aZ/HSfuEHgFv3EeHAQlPT1PmWEtU+Nx6aoZPKF4aA1ipRODm6I0+neU
         KeUbZFJAkk/kpU5AoIVlQM4AUSmuzn96MNPnDoscpCsykpPSJ9ala/mXzS0s6NVh7byQ
         phQWrlt5kfRL4VCYB/f74g1DV1nnkBbU+KtmPZy00mtAp7mNj6/rJZO/i9MOvPSvLJFw
         s0i94pjQM+yFzIaVSDobpyTpqMn3duzKMKLZZhFM+wX2OdPclp0e/n+FdGlFKJsOs1MR
         JgwA==
X-Gm-Message-State: ACrzQf0TSVv2vIeHwuOoi2q1XRISraul28JrY3tIty55nJOag6u73f3r
        udDMlyE+nDH4H1rWq4RdntNDQw==
X-Google-Smtp-Source: AMsMyM4hDdf8vKhnD/xuWyZgnQbUbCYYt0QPmCWCaaoKMysv/wQ/4UdNr2nNUREhejrZ5baSd55XGA==
X-Received: by 2002:a17:902:7482:b0:179:eb77:98e6 with SMTP id h2-20020a170902748200b00179eb7798e6mr3536305pll.84.1664457847680;
        Thu, 29 Sep 2022 06:24:07 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 37-20020a631665000000b0041c35462316sm5521914pgw.26.2022.09.29.06.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 06:24:07 -0700 (PDT)
Message-ID: <d9a86bdd-bcba-51e9-16d4-287b333e18ad@kernel.dk>
Date:   Thu, 29 Sep 2022 07:24:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
 <20220929074745.103073-3-p.raghav@samsung.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220929074745.103073-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 1:47 AM, Pankaj Raghav wrote:
> Use blk_mq_plug() wrapper to get the plug instead of directly accessing
> it in the block layer.
> 
> Either of the changes should not have led to a bug in zoned devices:
> 
> - blk_execute_rq_nowait:
>   Only passthrough requests can use this function, and plugging can be
>   performed on those requests in zoned devices. So no issues directly
>   accessing the plug.
> 
> - blk_flush_plug in bio_poll:
>   As we don't plug the requests that require a zone lock in the first
>   place, flushing should not have any impact. So no issues directly
>   accessing the plug.
> 
> This is just a cleanup patch to use this wrapper to get the plug
> consistently across the block layer.

While I did suggest to make this consistent and in principle it's
the right thing to do, it also irks me to add extra checks to paths
where we know that it's just extra pointless code. Maybe we can
just comment these two spots? Basically each of the sections above
could just go into the appropriate file.

-- 
Jens Axboe


