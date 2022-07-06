Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F13C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiGFNzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiGFNzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:55:46 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282517060
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 06:55:45 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id o12so878204pfp.5
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 06:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F47fXxjWOZ7U8POrQlmPk/Gs1ng8ZOhxfgrwF9jhYQw=;
        b=xyB78+SmlyboIG4m43QI/89Rr7nSPdxZgH/U0LyOs8FobeJgqDn2OfX1DLqJP9afh+
         xW2PZezRnG+KtLnS4os8Q2KcjIyHb5YFIgigkVBjRmIjYcnYpV9ndBd3nZctf2hvJXSF
         XtikcSWfovphyVFww6xbKX/+eHsXP0xGWbFtmqLjWHGBNuA1Jr84qOqmSiofROm1myc0
         b2aQ2QYa4jKirDdWzbTEZcFc1TamzbQpCtMu7RoboPfllbiLnS6IkOydFK07LYZxbsKu
         yVUChroaOFYzgvIO4fW4JYCfVqu9kkseNpjNXsJkFVanbMpwwdl6OOabsbA7nqJvnws5
         kd4w==
X-Gm-Message-State: AJIora82nC92/+F1I4QdJFD0mHYSPMXJEcLrrSNSPuTWjjptC7dYjUnb
        bBf8baF151dRTT73q+GkhI4=
X-Google-Smtp-Source: AGRyM1t/lHTxNA+K5DeSBX/daTWAE1wEDwR0JdDoTAU4alArfH5tRz/JfNyOYY5p5lNLqzggh0dOWw==
X-Received: by 2002:a63:501c:0:b0:412:6080:1c66 with SMTP id e28-20020a63501c000000b0041260801c66mr10854424pgb.558.1657115744762;
        Wed, 06 Jul 2022 06:55:44 -0700 (PDT)
Received: from [192.168.51.14] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902b68900b0016be02d2a44sm7212783pls.133.2022.07.06.06.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:55:43 -0700 (PDT)
Message-ID: <521c76db-1c3c-07f5-8b00-7fc5385fbd4a@acm.org>
Date:   Wed, 6 Jul 2022 06:55:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH blktests] block/008: avoid _offline_cpu() call in
 sub-shell
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>
References: <20220704111638.1109883-1-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220704111638.1109883-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 04:16, Shin'ichiro Kawasaki wrote:
> The helper function _offline_cpu() sets a value to RESTORE_CPUS_ONLINE.
> However, the commit bd6b882b2650 ("block/008: check CPU offline failure
> due to many IRQs") put _offline_cpu() call in sub-shell, then the set
> value to RESTORE_CPUS_ONLINE no longer affects function caller's
> environment. This resulted in offlined CPUs not restored by _cleanup()
> when the test case block/008 calls only _offline_cpu() and does not call
> _online_cpu().
> 
> To fix the issue, avoid _offline_cpu() call in sub-shell. Use file
> redirect to get output of _offline_cpu() instead of sub-shell execution.
> 
> Fixes: bd6b882b2650 ("block/008: check CPU offline failure due to many IRQs")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-block/20220703180956.2922025-1-yi.zhang@redhat.com/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/block/008 | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/block/008 b/tests/block/008
> index 75aae65..cd09352 100755
> --- a/tests/block/008
> +++ b/tests/block/008
> @@ -34,6 +34,7 @@ test_device() {
>   	local offline_cpus=()
>   	local offlining=1
>   	local max_offline=${#HOTPLUGGABLE_CPUS[@]}
> +	local o=$TMPDIR/offline_cpu_out
>   	if [[ ${#HOTPLUGGABLE_CPUS[@]} -eq ${#ALL_CPUS[@]} ]]; then
>   		(( max_offline-- ))
>   	fi
> @@ -60,18 +61,18 @@ test_device() {
>   
>   		if (( offlining )); then
>   			idx=$((RANDOM % ${#online_cpus[@]}))
> -			if err=$(_offline_cpu "${online_cpus[$idx]}" 2>&1); then
> +			if _offline_cpu "${online_cpus[$idx]}" > "$o" 2>&1; then
>   				offline_cpus+=("${online_cpus[$idx]}")
>   				unset "online_cpus[$idx]"
>   				online_cpus=("${online_cpus[@]}")
> -			elif [[ $err =~ "No space left on device" ]]; then
> +			elif [[ $(<"$o") =~ "No space left on device" ]]; then
>   				# ENOSPC means CPU offline failure due to IRQ
>   				# vector shortage. Keep current number of
>   				# offline CPUs as maximum CPUs to offline.
>   				max_offline=${#offline_cpus[@]}
>   				offlining=0
>   			else
> -				echo "Failed to offline CPU: $err"
> +				echo "Failed to offline CPU: $(<"$o")"
>   				break
>   			fi
>   		fi

Has it been considered to move RESTORE_CPUS_ONLINE=1 from _online_cpu() 
/ _offline_cpu() into the callers of these functions instead of making 
the above change?

Thanks,

Bart.
