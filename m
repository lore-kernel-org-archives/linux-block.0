Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C41AC3A5A8
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2349A20882
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 18:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="tRoNPbpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389500AbfIDSVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:21:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33236 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387878AbfIDSVE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 14:21:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8702789pfl.0
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BC0W8gVR8nr+ywA1XU/dSNIOA5fh8+NVvu22c6Msxow=;
        b=tRoNPbpVkpTry8+7UTGW8zLNnlf2+r3uiX1dDy5/EJ/330T9ktYJwmEKJa0DAYnzte
         PTMfZp7btZuTxx9v6L9thW4a4vd6o09EY0ZxVifhJdYW711Qg4Q31I9fWLdxs7fXDA4S
         XFCsE8iV4S68jBDb++8zSA3OjdHMFoucPKtS2AvKdMR90lE+pFn1phYzlGwSHbURU8Va
         TiV1yGs4tTmdO4dDlectzikFEUfB9mEAWzMd+Rz8AQYMXnoTUH4PiayzMTgpWEB7nO6d
         jPFuCIeiGGOgm5tAtNn8PZJyIg45f5x1qcaSODuCFVOLcumCjJJ6AtuPqJA3edxfVE+T
         ZSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BC0W8gVR8nr+ywA1XU/dSNIOA5fh8+NVvu22c6Msxow=;
        b=RZcdXno2T3Dy6v7MpjW1S21lqJ5Tl/xVYmSU3FSB6p6tcYQv6RFxvJvm51pSrTAs34
         9ruIclMCTmuTg5Kpgqc2+2TIDCtoQTNsFHty5EntgdV2tT0fJxzQZF/WvTYCVJYlZ75g
         6wM488cbohzyDqfy2lVX11OHql2f1NSnoAMsVwi9nbxCpCaLCJEvgLsXG9m2dRb2GuMG
         /JnV8sUn3PGjkKa9Bkzrrt/oHZE1hHljGfdQCUIxxzE/XoYQEPBBUZCQrUGJ/Fn11q8B
         xFfCvf110wpQVK5wQ+8UHHCq3rgyv/x5/REAeGs3/GBJGPkTtCb1+M2YRkeP6HcoofDV
         jX5g==
X-Gm-Message-State: APjAAAXq0qYqkwlCf/3CGpm/ceEb2tjWWJV7Da+Sej8wXYtyQUEk9W1O
        xMFSo9cNi1CI8x0298a0HH28Xw==
X-Google-Smtp-Source: APXvYqyXEzdne2D+FItAKrOtEseUbh4VttYjTNcn58+lcHOi2c4pzjIO7d7o1imU7yGqMMNU7VNGvw==
X-Received: by 2002:a63:1d0e:: with SMTP id d14mr36371373pgd.324.1567621263225;
        Wed, 04 Sep 2019 11:21:03 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id k36sm19713797pgl.42.2019.09.04.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 11:21:02 -0700 (PDT)
Date:   Wed, 4 Sep 2019 11:21:02 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, ming.lei@redhat.com
Subject: Re: [PATCH blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Message-ID: <20190904182102.GE7452@vader>
References: <20190903081752.463-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903081752.463-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 04:17:52PM +0800, Yi Zhang wrote:
> Add one test to cover NVMe SSD rescan/reset/remove operation during
> IO, the steps found several issues during my previous testing, check
> them here:
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvme/031     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/031.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/031
>  create mode 100644 tests/nvme/031.out
> 
> diff --git a/tests/nvme/031 b/tests/nvme/031
> new file mode 100755
> index 0000000..4113d12
> --- /dev/null
> +++ b/tests/nvme/031
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>
> +#
> +# Test nvme pci adapter rescan/reset/remove operation during I/O
> +#
> +# Regression test for bellow two commits:
> +# http://lists.infradead.org/pipermail/linux-nvme/2017-May/010367.html
> +# 986f75c876db nvme: avoid to use blk_mq_abort_requeue_list()
> +# 806f026f9b90 nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
> +TIMED=1
> +
> +requires() {
> +	_have_fio
> +}
> +
> +device_requires() {
> +	_test_dev_is_nvme
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	pdev="$(_get_pci_dev_from_blkdev)"
> +
> +	# start fio job
> +	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
> +		--ignore_error=EIO,ENXIO,ENODEV --group_reporting  &> /dev/null &
> +
> +	# do rescan/reset/remove operation
> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/rescan
> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/reset

My QEMU VM doesn't have the "reset" attribute, I'm guessing because of
this code in pci_create_capabilities_sysfs():

	if (dev->reset_fn) {
		retval = device_create_file(&dev->dev, &reset_attr);
		if (retval)
			goto error;
	}

We can skip the reset if the attribute doesn't exist.

> +	echo 1 > /sys/bus/pci/devices/"${pdev}"/remove
> +	sleep .5
> +	echo 1 > /sys/bus/pci/rescan
> +	sleep 5

Instead of sleep, we can kill and wait for fio.

Thanks!
