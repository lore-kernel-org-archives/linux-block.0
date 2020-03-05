Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F66C3F2CE
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E620866
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="LC5kWgn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgCEBaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:30:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45077 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCEBaN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 20:30:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1870553pls.12
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 17:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2thFv659sj5d5Ni5yvxP9gN4h9QVhmEBZCNJK4/mccw=;
        b=LC5kWgn4gVrcc3CXLwwUflPsmsrXBAFgvX6JoZ19giCkmkr9PCA8UdwIEqJy/Akoq1
         j6bMTALPVmIrLpToXZNyjrMh2MjA6z+fcI+2Ggn/BZxvjrEkmdi4ARMDB9fXDmBXcNcf
         6LUt2pjTI3biJBSQyuZop/+KpDpscB2RX1dFyF33KC5Ts9UF54BjgceFI8owpjDZa3iw
         SGALYYVoR+lQxsUrITkJ9KinfidM5Kwz+L2GWZGfr8zF9+jjhVSoCe1gYYrfcnd9dQXh
         8ioecMxkIa/w/MxVQnWgEQ52BgzYC3yhmNOLG8XXzs/mtmJj9EXU8mzxHMWdbBRrEV77
         mgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2thFv659sj5d5Ni5yvxP9gN4h9QVhmEBZCNJK4/mccw=;
        b=XJgkjnCUZycMZlfekBrnieN+ZioxPl4vwGVQUI5IVWLwW/ZtA2V01OM6GBnnKunWmx
         o2zGLQSJfUAsZY5W3mSkUpTWK5q1XjvuzdOmTvAZjDWdchZ2YsyJxVbizBjnrOK096sS
         mARZ0H24WcI66BLx6KA5Vxu3OSQ2IVNhG/BCzKVrBMJnv+ui7pvHePKjGJ/YJC3AGwmu
         AlBHJaV5PJxry9HyQB61dlj87Z36+tw3I0J8NYGX7zAYjn5P/Y9OQ9Mtz9X2iPLYQm/2
         eW5Y4dveSYy9QSgi7XZf0U1kmXuO0dnpeAQZH7M1C7nIcNCxG85AASpMcjtwWqwbqwKr
         ZC6w==
X-Gm-Message-State: ANhLgQ03UstWw8qM/rYuJfFS2uWjK8eUW1Cp+zXifsbVJVflPPm4UhDo
        9+OFhmovNZO/0AVjeK/k6uCtCg==
X-Google-Smtp-Source: ADFU+vt+xtLO79oB84p7YASWE2WmLbGoCdm+hk/v+HYCths5SJYrRkJ4dp6xdWmregj7/mqFdlCLeQ==
X-Received: by 2002:a17:90a:2e05:: with SMTP id q5mr5788717pjd.68.1583371812000;
        Wed, 04 Mar 2020 17:30:12 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id a71sm14651551pfa.117.2020.03.04.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:30:11 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:30:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Message-ID: <20200305013010.GA293405@vader>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
 <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 05:38:30PM -0800, Chaitanya Kulkarni wrote:
> The new testcases exercises newly added cntlid [min|max] attributes
> for NVMeOF target.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/033.out |  4 +++
>  2 files changed, 65 insertions(+)
>  create mode 100755 tests/nvme/033
>  create mode 100644 tests/nvme/033.out
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> new file mode 100755
> index 0000000..49f2fa1
> --- /dev/null
> +++ b/tests/nvme/033
> @@ -0,0 +1,61 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
> +#
> +# Test NVMeOF target cntlid[min|max] attributes.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
> +QUICK=1
> +
> +PORT=""
> +NVMEDEV=""
> +LOOP_DEV=""
> +FILE_PATH="$TMPDIR/img"
> +SUBSYS_NAME="blktests-subsystem-1"
> +
> +_have_cid_min_max()
> +{
> +	local cid_min=14
> +	local cid_max=15
> +
> +	_setup_nvmet
> +	truncate -s 1G "${FILE_PATH}"
> +	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
> +
> +	# we can only know skip reason when we create a subsys
> +	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
> +}

Sorry, I wasn't ignoring these patches, they just made me realize that
we really do need a way to skip a test from the test function itself, so
I wanted to implement that first. Could you try rebasing on my skip-test
branch (https://github.com/osandov/blktests/tree/skip-test) and
reworking this so you don't have to split the setup between requires()
and test()?

> +
> +requires() {
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
> +		_have_configfs && _have_cid_min_max
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	PORT="$(_create_nvmet_port "loop")"
> +	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
> +
> +	nvme connect -t loop -n "${SUBSYS_NAME}"
> +
> +	udevadm settle
> +
> +	NVMEDEV="$(_find_nvme_loop_dev)"
> +	nvme id-ctrl /dev/"${NVMEDEV}"n1 | grep cntlid | tr -s ' ' ' '
> +
> +	nvme disconnect -n "${SUBSYS_NAME}"
> +
> +	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
> +	_remove_nvmet_subsystem "${SUBSYS_NAME}"
> +	_remove_nvmet_port "${PORT}"
> +
> +	losetup -d "${LOOP_DEV}"
> +
> +	rm "${FILE_PATH}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/033.out b/tests/nvme/033.out
> new file mode 100644
> index 0000000..b1b0d15
> --- /dev/null
> +++ b/tests/nvme/033.out
> @@ -0,0 +1,4 @@
> +Running nvme/033
> +cntlid : e
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> -- 
> 2.22.1
> 
