Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC26ECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 13:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiHaNdJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHaNdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 09:33:04 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A712D2906
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 06:33:03 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id u18so5633173wrq.10
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 06:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VbxL7FuResP2O2vtoux7WkwTT7ypL+Tnt5KBx5E45Sw=;
        b=6qiPCKjCRKL6dUqePbUtXi3kNQVT3VmxrGLMwkpJljKXlbm/1lzU6Sf9rIRUKJpTWF
         /KxSoUU9xhaqhJS3OculFmwavXVPhn7LBQfVfUbP1kN3DxVFIsIXm9RKBbq5RPnHDt24
         Fa/PILspSuYCqcNN0cor5b6S9tgG6zWV4Ls8TwJ6rfEH1cOa/rBcfJSGRyFfZZvt2mPl
         c13hbVAvjOfT032JneOrFlbrO0rL1l7ofVEpEwhssTISUIQBcd4DWJWDxInGBube+CkS
         eiDHVce899ixWM56YGbdVColQ3EF2L/LLbf95bN8ha+jX7IEZCJC2wZOCiq5NihTEWTb
         OyFA==
X-Gm-Message-State: ACgBeo0hi8muPlPHGqRE9mmil6S3HDLT4ZYy5KzFp+VbBmpTGZxwnRoL
        HBLjlyRllWh2QJ9R79U7clVZK1Q3070=
X-Google-Smtp-Source: AA6agR7z37H5pLYqkqMz2eR/yxcnVJpQcOcDuRez4dsTUGwAL/hbU5C1Y/WgRNdZ07wUUfHLpkcZEQ==
X-Received: by 2002:a5d:6b44:0:b0:225:fbb:678e with SMTP id x4-20020a5d6b44000000b002250fbb678emr12103751wrw.482.1661952781406;
        Wed, 31 Aug 2022 06:33:01 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm12353669wrs.74.2022.08.31.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:33:00 -0700 (PDT)
Message-ID: <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
Date:   Wed, 31 Aug 2022 16:32:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Hannes Reinecke <hare@suse.de>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
> module. When the module is built as a loadable module, the test cases
> fail since the module is not loaded at test case runs.
> 
> To avoid the failures, load the dh_generic module at the preparation
> step of the test cases. Also unload it at test end for clean up.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for authenticated connections")
> Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
> Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/
> ---
>   tests/nvme/043 | 4 ++++
>   tests/nvme/044 | 4 ++++
>   tests/nvme/045 | 4 ++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 381ae75..dbe9d3f 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -40,6 +40,8 @@ test() {
>   
>   	_setup_nvmet
>   
> +	modprobe -q dh_generic
> +
>   	truncate -s 512M "${file_path}"
>   
>   	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
> @@ -88,5 +90,7 @@ test() {
>   
>   	rm "${file_path}"
>   
> +	modprobe -qr dh_generic

You should not do this, dh_generic might have been
loaded unrelated to this test, you shouldn't just
blindly unload it.
