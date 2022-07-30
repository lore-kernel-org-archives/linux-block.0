Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B63CC04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiG3PE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiG3PE1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 11:04:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3848818B08
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 08:04:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso912241pjf.5
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8Zg17xtftYuS9FB0jNunpTdelhne7Uk+B80JlU8kgNU=;
        b=R0OKwNAG6fK7Tb/TDz0NaUKHfL2Iq2jIfk8SO2XXftaYdPCSl7RtRTiJyDcvEQSSi4
         gm0H2OuglhMecO5Eqg9NgtjAAImSyTS/ftKn3z7y/qPbIvnrwkhR2gFgmxgaO3oljm1R
         X9M7GS/W+JnRJxxZ+5sm3PbjMp4oQj870I9iaVQKg1kv4mSTPVa5jhmzYH9ccba0sUjM
         5L1jAA2xKvtOvmorbugCnVr4Oj1I6IicLH4kmtUekkNJF0yE+WRRv2K1Wb/tEMv5TSNR
         tJO4HPLPQ4ZOb9vhovoIp77x3ipiUrOi9MNhonvfV2dxcGp+RIZAPl9AVqorRMdIbqzS
         OKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Zg17xtftYuS9FB0jNunpTdelhne7Uk+B80JlU8kgNU=;
        b=Dem5FZsj9CvYx4LwblRWt66v/XlmUtdC5vWI1pzcsnfyCrrtfFPEQ0NZ3TYkIODF+b
         iVdONIku4J0iyJX07haUckAK6I/LTuDe9Bb4XOYVP6Iqc2vUprZYCFsJV3CagPdwCHCi
         O/MWtwaElsgf1y4HXAf6p0lh8XI/rV9CjBLZf+snBsux4HdhohQzIMdyf5tuY6sNnmpD
         Eyr34b3RM7YtBFFV7djDo0jQr6OHXo/TeruJSyw/ryBIp9Uqgaa6ZF1rEG+LD8KqmHFt
         NpPeMzbzKjPbI3WxPobIuUwAXgQL5W06K/HwLiSQ7CjIf8FppHfLZNWVTFh4dLl3Wpxt
         tryQ==
X-Gm-Message-State: ACgBeo1oh5nzEhrgyHrbMumsrUcioM3AtQWg16/N2aRfEiZUXVdoFJMx
        uIKc3fjfrW/AHA/05uQxhhH8Aw==
X-Google-Smtp-Source: AA6agR616cx6dk9qgxS2Qei2FFrE9KyqXM01Qlm078UDDK0KwseESaAs1XXtPPql20S4rYys0regFg==
X-Received: by 2002:a17:90a:de12:b0:1f0:f213:cb9d with SMTP id m18-20020a17090ade1200b001f0f213cb9dmr9730681pjv.207.1659193465638;
        Sat, 30 Jul 2022 08:04:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b0016d763967f8sm5840312plg.107.2022.07.30.08.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 08:04:25 -0700 (PDT)
Message-ID: <1596ad46-1a21-f7ac-a335-059b7d6732f5@kernel.dk>
Date:   Sat, 30 Jul 2022 09:04:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 0/4] ublk_drv: add generic mechanism to get/set
 parameters
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <20220730092750.1118167-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220730092750.1118167-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/22 3:27 AM, Ming Lei wrote:
> Hello Jens,
> 
> The 1st two patches fixes ublk device leak or hang issue in case of some
> failure path, such as, failing to start device.
> 
> The 3rd patch adds two control commands for setting/getting device
> parameters in generic way, and easy to extend to add new parameter
> type.
> 
> The 4th patch cleans UAPI of ublksrv_ctrl_dev_info, and userspace needs
> to be updated for this driver change, so please consider this patchset
> for v5.20.
> 
> Verified by all targets in the following branch, and pass all built-in
> tests.

This will miss the first pull request, but I've queued it up for this
merge window.

-- 
Jens Axboe

