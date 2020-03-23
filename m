Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF1EC54FCE
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6220719
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5Mx9bup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCWQtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:49:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41376 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:49:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id n17so5029452lji.8;
        Mon, 23 Mar 2020 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhFCWeL+rFInk3bPHjEA9ZVNIShgAywBeYzVQNJyjnc=;
        b=d5Mx9bupBBr8PrzmgTgsFR7/M+Ctng0M8cH49sMpfEoTyJ9lcR59HvKbWFdGlb6qoj
         0cWox1slQ/osr/jLC0UjEHib0nVQZFIruWsiGOW3RxjxJhD+Xc2IkxpAOHS6htYXm/Wq
         CNMRpGebCJhE5l4CPkpra8WbC/bme7CjFH/3Dg3zINHS+0JCW6xfTyph4hRpqG/IFzPw
         8iMJ/8xkzVOBG1tFywGL12tolFxrxkw6+rnEBxGj2VLL3WTeypD0aaytJQLEX7FaiC+M
         LH7G/EA1rA+Wssk/fYW4zSjIx6kwB2JMyoB83P2oJaDuQu/ymGogvurNmhRP9gL4/KUl
         YeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qhFCWeL+rFInk3bPHjEA9ZVNIShgAywBeYzVQNJyjnc=;
        b=shAeDRzPPrLrvDAMi+vRtgXi0prn1LhbBBeiuOFaJCj0i0fSu7NymVMM5QxVs/tdD3
         krdAqy2XYKlQbR6Sg8gtL2TahGLMvBawuzugdl8zdX2NHYtHitOg0SdRslRmwVtnpXed
         iIJkxvvfHcq5Enpvpd104cxkKLwIhSLmVSFtWWpl7eXIN5Z3FXE5+v7RC/Cj6jHatp/c
         OQgXDQBF6NjRBzvDosH9DhkZMVxMfob6mz9YgT1nnS/rQb+naqB5rd1oVG0RrJ2ZWUY3
         r4W15/l3y9KWAbLCMqnbqHaeIc4umj7UJFKNFsHx1AbdzihS/52h2dInW1F9cV1EYJLh
         /UMQ==
X-Gm-Message-State: ANhLgQ3tnCwidfHshH0uGS0SUdfofn3+OHUGhN7EYJSWY5+hXWm8KXod
        j2npXqlDBqZ/OJ0dMiKss0xjH82I
X-Google-Smtp-Source: ADFU+vuDnRyR4TA0KiU8EGeB+376glc1HzjE04SBb5yigFJd8YWFX717LqkEyyYiDH/S57kVviYPdQ==
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr14569628ljh.28.1584982178682;
        Mon, 23 Mar 2020 09:49:38 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id k23sm8661150ljk.40.2020.03.23.09.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:49:38 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] Introduce NVIDIA Tegra Partition Table
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200323163431.7678-1-digetx@gmail.com>
Message-ID: <021a340f-e289-b1ee-db4f-ef61ee2b4004@gmail.com>
Date:   Mon, 23 Mar 2020 19:49:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

23.03.2020 19:34, Dmitry Osipenko пишет:
> Some NVIDIA Tegra devices have GPT entry at a wrong location and others may
> even not have it at all. So either a custom workaround for GPT parsing or
> TegraPT support is needed for those devices if we want to support them in
> upstream kernel. The former solution was already rejected [1], let's try
> the latter.
> 
> [1] https://patchwork.ozlabs.org/patch/1240809/
> 
> Big thanks to everyone who helped with figuring out the TegraPT format!
> 
> Changelog:
> 
> v3: - Fixed "BUG: KASAN: slab-out-of-bounds in tegra_partition". Thanks to
>       Peter Geis for noticing the problem.
> 
>     - The MMC boot partitions scanning is now opt-in. See this patch:
> 
>         mmc: block: Support partition-table scanning on boot partitions
> 
>     - The found MMC boot partitions won't be assigned to the MMC boot
>       block device ever due to the new GENHD_FL_PART_SCAN_ONCE flag.
> 
>       This makes us to ensure that the old behavior of the MMC core is
>       preserved for a non-Tegra MMC-block users.
> 
>     New patches in v3:
> 
>         block: Introduce GENHD_FL_PART_SCAN_ONCE
>         mmc: sdhci-tegra: Enable boot partitions scanning on Tegra20 and Tegra30

I forgot to mention that the TegraPT Kconfig entry now depends on MMC,
which was suggested by Randy Dunlap in the review comment to the v2.
