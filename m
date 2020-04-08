Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0FC2BA16
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 21:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5B9206C0
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 21:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="vtPj/fyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgDHVkL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:40:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45811 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgDHVkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 17:40:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 128so1318904pge.12
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qt5d1Wllu34qbiwv0x1hKb5crlvmMDD9rOUa+Kgq9tM=;
        b=vtPj/fyNb0uKPwTqagPeQtZdcZvZqBUbXcZQnGCefLH1zW9sh3Y2vUAWElXSB6V1S5
         4KBIvcQRDiGim6E4QXKmO3e2NjRGvYKfZ7YkgiyrtiY3rrDNypT6SzlrsPKw86/x4PpL
         QuhVB1KWZuaYpJ01dAXiUmADkWKUyhT8tnSe4zm6sz2xdixBU3FmJ13WbjJGCBwbLNCU
         5p3qimw4FQeZXh04Vji5HtJ0gWfyBND+HNjVjcMn7Z6AAj7eUYHnh+dvkycMyuWWaEgp
         HlFh8XjjTdaCBxLCkX1R6uhnxFJvnC1/f6Qq1F7ipJ4y+brUPqsObUb21K+NQtmzTb/Z
         d1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qt5d1Wllu34qbiwv0x1hKb5crlvmMDD9rOUa+Kgq9tM=;
        b=NVlBLPU4R26YuYHwV22fByPq4bxX89QB5/tJZcrgARHQbMkF7RnSg+FRGJ2qRDjgPr
         zLqaNOtCb5AVBY3vPR0FOADcOAJl2zFRxBXTeGlPu23BgUz3M6819QyAzXL0LeYc+C1S
         +EMIzMng1Zm0/nCZBirTpbIzbrXVGXww8K0HomJizi/AsTVOJAtf1Cw2Kd4usxXxbuwd
         y4PfLyfOt0/j5o1W5FZu544SYmYSiGyoKOV0suT9YFQjbcQhuytn1Vhbih0oIU1arRZZ
         YTSNRAZ/YfznqMyAbuv/8aHFPN2ZdD9Bt+pn+VrkNnt7sxuw7c219FeCQkBqiSfLHtJY
         8FmQ==
X-Gm-Message-State: AGi0PuY2tGm7b4mQf/laAEyqbFUrHQmEDhlrknZSRK/OVaP2mN7BRND9
        /5/Rk7l1Em2JSo0ltYatWY/wICy76OM=
X-Google-Smtp-Source: APiQypJAHs3KmsNA+mY7o3KYiySATEHegZuwoy679ewYpDB0sXDzUdyJQEXfnLeBmKpoooyA8rwI3A==
X-Received: by 2002:a65:5647:: with SMTP id m7mr8558219pgs.371.1586382009595;
        Wed, 08 Apr 2020 14:40:09 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:9008])
        by smtp.gmail.com with ESMTPSA id u3sm17837806pfb.36.2020.04.08.14.40.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:40:08 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:40:07 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktest] nvme/033: add test case for nvme update hardware
 queue count
Message-ID: <20200408214007.GA226277@vader>
References: <20200407141621.GA29060@192.168.3.9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407141621.GA29060@192.168.3.9>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 10:16:33PM +0800, Weiping Zhang wrote:
> Modify nvme module parameter write_queues to change hardware
> queue count, then reset nvme controller to reinitialize nvme
> with different queue count.
> 
> Attention, this test case may trigger a kernel panic.
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> ---
>  tests/nvme/033     | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/033.out |  2 ++
>  2 files changed, 89 insertions(+)
>  create mode 100755 tests/nvme/033
>  create mode 100644 tests/nvme/033.out
> 
> diff --git a/tests/nvme/033 b/tests/nvme/033
> new file mode 100755
> index 0000000..e3b9211
> --- /dev/null
> +++ b/tests/nvme/033
> @@ -0,0 +1,87 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2020 Weiping Zhang <zwp10758@gmail.com>
> +#
> +# Test nvme update hardware queue count larger than system cpu count
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test nvme update hardware queue count larger than system cpu count"
> +QUICK=1
> +
> +requires() {
> +	_have_program dd
> +}
> +
> +device_requires() {
> +	_test_dev_is_nvme
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local old_write_queues
> +	local cur_hw_io_queues
> +	local file
> +	local sys_dev=$TEST_DEV_SYSFS/device
> +
> +	# backup old module parameter: write_queues
> +	file=/sys/module/nvme/parameters/write_queues
> +	if [[ ! -e "$file" ]]; then
> +		echo "$file does not exist"
> +		return 1
> +	fi

Tests shouldn't fail if kernel support is missing. You can check this
with `_have_module_param nvme write_queues` in requires().

> +	old_write_queues="$(cat $file)"
> +
> +	# get current hardware queue count
> +	file="$sys_dev/queue_count"
> +	if [[ ! -e "$file" ]]; then
> +		echo "$file does not exist"
> +		return 1
> +	fi

Again, this should be checked before the test is run (device_requires(),
in this case). Something like

if [[ ! -e "$TEST_DEV_SYSFS/device/queue_count" ]]; then
	SKIP_REASON="device does have queue_count sysfs attribute"
	return
fi

> +	cur_hw_io_queues="$(cat "$file")"
> +	# minus admin queue
> +	cur_hw_io_queues=$((cur_hw_io_queues - 1))
> +
> +	# set write queues count to increase more hardware queues
> +	file=/sys/module/nvme/parameters/write_queues
> +	echo "$cur_hw_io_queues" > "$file"
> +
> +	# reset controller, make it effective
> +	file="$sys_dev/reset_controller"
> +	if [[ ! -e "$file" ]]; then
> +		echo "$file does not exist"
> +		return 1
> +	fi

Same thing here.

> +	echo 1 > "$file"
> +
> +	# wait nvme reinitialized
> +	for ((m = 0; m < 10; m++)); do
> +		if [[ -b "${TEST_DEV}" ]]; then
> +			break
> +		fi
> +		sleep 0.5
> +	done
> +	if (( m > 9 )); then
> +		echo "nvme still not reinitialized after 5 seconds!"
> +		return 1

You're not resetting the write_queues parameter here.

> +	fi
> +
> +	# read data from device (may kernel panic)
> +	dd if="${TEST_DEV}" of=/dev/null bs=4096 count=1 status=none
> +
> +	# If all work well restore hardware queue to default
> +	file=/sys/module/nvme/parameters/write_queues
> +	echo "$old_write_queues" > "$file"
> +
> +	# reset controller
> +	file="$sys_dev/reset_controller"
> +	echo 1 > "$file"

Does this need the same logic to wait for the device to reappear?

> +	# read data from device (may kernel panic)
> +	dd if="${TEST_DEV}" of=/dev/null bs=4096 count=1 iflag=direct status=none
> +	dd if=/dev/zero of="${TEST_DEV}" bs=4096 count=1 oflag=direct status=none
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/033.out b/tests/nvme/033.out
> new file mode 100644
> index 0000000..9648c73
> --- /dev/null
> +++ b/tests/nvme/033.out
> @@ -0,0 +1,2 @@
> +Running nvme/033
> +Test complete
> -- 
> 2.18.1
> 
