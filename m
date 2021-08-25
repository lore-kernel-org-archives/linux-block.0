Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAB0C4320A
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 00:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60458611AF
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 00:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhHYA5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhHYA5d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 20:57:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A081C061764
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 17:56:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u15so13284643plg.13
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hDmA88AGRY/vwa+gGKxIK+/H24lAkykEt+wHqqXlCXE=;
        b=P4GuDJeRVVhudmZI0u/uwgue6Kjrok+r6cIijY3U9m3HnBE9NpbWgsfh6G/s0y1bel
         w5+4yfF06qam48qOwPOPuHVgB6hVfowJEdilUzYcWCCURTL4c+gjpl7LjVM6iktCExmH
         ATetYYtz1VgnAipAKAt3kEcaTm2Gf+4TZDyA2FD98rmswB3KYcu5qz/X0ry9U9eRNGqf
         e3g0dPqKML9WiKGRiPYHS0uxWos7MXJ1eebirZMT2TPiB+SDRM6UWiY2gEy6ac0MmyT0
         +fmFhdtMEg/anpcvZtaCgvWFlozXf/mGGbQ0Qz3oUDIv5EwkfWSNvXbZq8aj8yBq7dKi
         YiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDmA88AGRY/vwa+gGKxIK+/H24lAkykEt+wHqqXlCXE=;
        b=EIEdZ8XwEOuFoLLBHmRb5qYVjHtgBQwxNtPnnwTmp3C4Vm40kRHgkKQikOT0mSSuhh
         AeJzs33CIAOIXisUk6UqFKLAxAU5sLL1fznCB443xBNmooIqO4gtLpqxXw1zvkv8xf1N
         ZxH9Cj/5GWRsQUOEzX602LCs5F4wpeRQwcw5ZXWsEqJzV9eT36dl8acwFPE5HirLW64Y
         K9xbbKmGjwAg4qQ69nXDYfAV5XkPPyRNzgIGOu/JoOg43p50b/bVPlAYqOCO6MJq9pFb
         Og4e3n/EDHf0ycm64RLXYEI49RNAW4lh6pu4n1amc33RJZMFHtJCybdUvSQC2A2Gb/GO
         tMgg==
X-Gm-Message-State: AOAM533hWODcTC9jtpO+ApOqgQZYiOHso4O9oG+djvokNU2xJVx5wDBH
        3cG+sPBNe2c6FmO35GCvfMzYfQ==
X-Google-Smtp-Source: ABdhPJzEbsbxIKFkhGP3ddFUby75YgoJoOMwYM1WFQsZCXKHIZkwkFbGXjDml41unr/U4CBZo1Nv2g==
X-Received: by 2002:a17:90b:1897:: with SMTP id mn23mr7361948pjb.61.1629853008633;
        Tue, 24 Aug 2021 17:56:48 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:f616])
        by smtp.gmail.com with ESMTPSA id v63sm23428489pgv.59.2021.08.24.17.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 17:56:48 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:56:46 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] block/001: wait until device is added
Message-ID: <YSWVTjSYegn/wGX2@relinquished.localdomain>
References: <20210824031753.1397579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031753.1397579-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 24, 2021 at 11:17:53AM +0800, Ming Lei wrote:
> Writing to the scan attribute of scsi host is usually one sync scan, but
> devices in this sync scan may be delay added if there is concurrent
> asnyc scan.
> 
> So wait until the device is added in block/001 for avoiding to fail
> the test.
> 
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/001 | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/block/001 b/tests/block/001
> index 51ec9d8..01356d0 100755
> --- a/tests/block/001
> +++ b/tests/block/001
> @@ -21,15 +21,20 @@ stress_scsi_debug() {
>  		return
>  	fi
>  
> -	local host target
> +	local host target target_path
>  	for target in "${SCSI_DEBUG_TARGETS[@]}"; do
>  		(
>  		host="${target%%:*}"
>  		scan="${target#*:}"
>  		scan="${scan//:/ }"
> +		target_path="/sys/class/scsi_device/${target}"
>  		while [[ ! -e "$TMPDIR/stop" ]]; do
>  			echo "${scan}" > "/sys/class/scsi_host/host${host}/scan"
> -			echo 1 > "/sys/class/scsi_device/${target}/device/delete"
> +			while [ ! -d ${target_path} ]; do
> +				sleep 0.01;
> +				[[ -e "$TMPDIR/stop" ]] && break
> +			done
> +			[ -d ${target_path} ] && echo 1 > ${target_path}/device/delete

Applied, with the shellcheck errors fixed and simplified logic. Thanks.
