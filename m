Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E0C49ED6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D0220872
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfILAKO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfILAKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 20:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB348308A9E0;
        Thu, 12 Sep 2019 00:10:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D5BE5D6A5;
        Thu, 12 Sep 2019 00:10:04 +0000 (UTC)
Date:   Thu, 12 Sep 2019 08:09:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@osandov.com,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH V3 blktests] nvme: Add new test case about nvme
 rescan/reset/remove during IO
Message-ID: <20190912000958.GA1553@ming.t460p>
References: <20190911085343.32355-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911085343.32355-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 12 Sep 2019 00:10:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 11, 2019 at 04:53:43PM +0800, Yi Zhang wrote:
> Add one test to cover NVMe SSD rescan/reset/remove operation during
> IO, the steps found several issues during my previous testing, check
> them here:
> http://lists.infradead.org/pipermail/linux-nvme/2017-February/008358.html
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010259.html
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> 
> ---
> 
> changes from v2:
>  - add check_sysfs function for rescan/reset/remove operation
>  - declare all local variables at the start
>  - alignment fix
>  - add udevadm settle
>  - change to QUICK=1
> changes from v1:
>  - add variable for "/sys/bus/pci/devices/${pdev}"
>  - add kill $!; wait; for background fio
>  - add rescan/reset/remove sysfs node check
>  - add loop checking for nvme reinitialized
> 
> ---
> ---
>  tests/nvme/031     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/031.out |  2 ++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/nvme/031
>  create mode 100644 tests/nvme/031.out
> 
> diff --git a/tests/nvme/031 b/tests/nvme/031
> new file mode 100755
> index 0000000..31db8a5
> --- /dev/null
> +++ b/tests/nvme/031
> @@ -0,0 +1,75 @@
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
> +QUICK=1
> +
> +requires() {
> +	_have_fio
> +}
> +
> +device_requires() {
> +	_test_dev_is_nvme
> +}
> +
> +check_sysfs()
> +{
> +	local sysfs_attr="$sysfs/$1"
> +
> +	if [[ -f "$sysfs_attr" ]]; then
> +		echo 1 > "${sysfs_attr}"
> +	else
> +		# QEMU VM doesn't have the "reset" attribute, skip it
> +		[[ "$sysfs_attr" == *reset ]] && return
> +		echo "${sysfs_attr} doesn't exist!"
> +	fi
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local sysfs
> +	local m
> +
> +	pdev="$(_get_pci_dev_from_blkdev)"
> +	sysfs="/sys/bus/pci/devices/${pdev}"
> +
> +	# start fio job
> +	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
> +		--group_reporting  &> /dev/null &
> +
> +	sleep 5
> +
> +	# do rescan/reset/remove operation
> +	for i in rescan reset remove; do
> +		check_sysfs $i
> +	done
> +
> +	{ kill $!; wait; } &> /dev/null
> +
> +	echo 1 > /sys/bus/pci/rescan
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
> +	fi
> +	udevadm settle
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/031.out b/tests/nvme/031.out
> new file mode 100644
> index 0000000..ae902bd
> --- /dev/null
> +++ b/tests/nvme/031.out
> @@ -0,0 +1,2 @@
> +Running nvme/031
> +Test complete
> -- 
> 2.17.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
