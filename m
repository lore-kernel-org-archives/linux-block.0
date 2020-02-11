Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35825C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44F2073C
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="x71SarPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBKWE2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:04:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35276 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:04:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so103776plt.2
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofdE0/BkV9/IevyyDrVK7PvogL7v8E+hcQz5pcDIuYw=;
        b=x71SarPt20Wb73D4ygd5wAwFOcbzeVdtXl2McQyfkupXZBS1PZc+M3zBBEOXnX1Lpb
         87Lu0kSBHGHsz2u4e3BkN0xEy/crVlDfCHzjPlpenvhl+IGS0mRvvC4jp162aGwOeGD2
         2pA5onubyuXO+64KU4RmozW/frriPEDTu2MfAWto9ZKDxj0QJ87jP9jcHoEAkrzPodaw
         xKSwIszJ/mw+oLBP2/U7/Lic8QML4HehKsyRJjJN6CXEUVMokMB+ulK/F4Xgpe6NZdqR
         Jx3F3CdMksVaT0GZjhDA2H1O4ZfrV14s7X6Xz6cL1tR768+E3Zk5x1E378Xex7Cue4iM
         4D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofdE0/BkV9/IevyyDrVK7PvogL7v8E+hcQz5pcDIuYw=;
        b=TJfGmoJqJQ3A8PL17SwDuI7qUv4kHJDDluvFKZe0x4DTYWSU4MiuI6bmcYgMcHmBBt
         JCUZRcfX8imkpX1PVTwhi5K6evQ8dEHkrqvdIhBHvUiNgdXMwEV+cwKEy0/l4xzYlQ8N
         KdEmCzcHfroCiZo07/44wJw+ocY31/S6gU5Yl+pHLxaN4lVC5GNmJhyCtdi253X32PTI
         KtWcsnpN2C7BOspqMJVAJqyEgIvllHkMakphiyxDAWtCRgnk8KSBSkCekq03nSkGyGMp
         stP1Sm7Sy65YhRqqUBC/c/aKzeLBraB8LYkBrHS3mKewykiAW3XQj+jn2uHWMjrclNxL
         juGQ==
X-Gm-Message-State: APjAAAXaVj6WZ//xiYTFK2Zd0yW6px17qRTjZjb0wbgNSWj1aLjszd74
        3z+1zv7ee6RrVLCfHmkxb3UMbg==
X-Google-Smtp-Source: APXvYqyVIg6t3k7ZDhQl+hAAYZNEZ7XKDQUBG1fRRv6+Pai/Qrk6AF9zfIjDsczSOVzqAaSLRt3SHA==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr6022270pjv.143.1581458667555;
        Tue, 11 Feb 2020 14:04:27 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id d4sm4451197pjg.19.2020.02.11.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:04:27 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:04:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5 blktests] nvme: test target model attribute
Message-ID: <20200211220421.GE100751@vader>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
 <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 29, 2020 at 03:29:20PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attribute for
> NVMeOF target.

Model, not cntlid, right?

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/034     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/034.out |  3 +++
>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/nvme/034
>  create mode 100644 tests/nvme/034.out
> 
> diff --git a/tests/nvme/034 b/tests/nvme/034
> new file mode 100755
> index 0000000..1a55ff9
> --- /dev/null
> +++ b/tests/nvme/034
> @@ -0,0 +1,60 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
> +#
> +# Test NVMeOF target cntlid[min|max] attributes.

Same here.

> +. tests/nvme/rc
> +
> +DESCRIPTION="Test NVMeOF target model attribute"
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local port
> +	local result
> +	local nvmedev
> +	local loop_dev
> +	local model="test~model"
> +	local file_path="$TMPDIR/img"
> +	local subsys_name="blktests-subsystem-1"
> +
> +	truncate -s 1G "${file_path}"
> +
> +	loop_dev="$(losetup -f --show "${file_path}")"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}

Since the cntlid doesn't matter for this test, maybe you should be able
to pass them as "" "" to _create_nvmet_subsystem so it can ignore them?

> +	port="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +
> +	nvme connect -t loop -n "${subsys_name}"
> +
> +	udevadm settle
> +
> +	nvmedev="$(_find_nvme_loop_dev)"
> +	nvme list | grep ${nvmedev}n1 | grep -q test~model

Can we do

	nvme list | grep "${nvmedev}n1" | grep -o "$model"

And have that in the test output rather than checking the return value?

> +	result=$?
> +
> +	nvme disconnect -n "${subsys_name}"
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +
> +	losetup -d "${loop_dev}"
> +
> +	rm "${file_path}"
> +
> +	if [ ${result} -eq 0 ]; then
> +		echo "Test complete"
> +	fi
> +}
> diff --git a/tests/nvme/034.out b/tests/nvme/034.out
> new file mode 100644
> index 0000000..0a7bd2f
> --- /dev/null
> +++ b/tests/nvme/034.out
> @@ -0,0 +1,3 @@
> +Running nvme/034
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> -- 
> 2.22.1
> 
