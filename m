Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35617 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdFZV1b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 17:27:31 -0400
Received: by mail-pg0-f48.google.com with SMTP id j186so5779872pge.2
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 14:27:30 -0700 (PDT)
Date: Mon, 26 Jun 2017 14:27:24 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests 2/2] block/011: Perform PCI reset while doing IO
Message-ID: <20170626212724.GF6710@vader.dhcp.thefacebook.com>
References: <20170623142951.17189-1-jthumshirn@suse.de>
 <20170623142951.17189-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623142951.17189-2-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 23, 2017 at 04:29:51PM +0200, Johannes Thumshirn wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This test-case performs I/O with fio while doing PCI disable/enable
> cycles.
> 
> In the results we don't care for I/O errors but for hiccups in dmesg only.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/block/011     | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/011.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/block/011
>  create mode 100644 tests/block/011.out
> 
> diff --git a/tests/block/011 b/tests/block/011
> new file mode 100755
> index 000000000000..b0de35816d48
> --- /dev/null
> +++ b/tests/block/011
> @@ -0,0 +1,54 @@
> +#!/bin/bash
> +#
> +# Do disable PCI device while doing I/O to it
> +#
> +# Copyright (C) 2017 Johannes Thumshirn <jthumshirn@suse.de>
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +DESCRIPTION="disable PCI device while doing I/O"
> +TIMED=1
> +
> +requires() {
> +	_have_fio
> +}
> +
> +device_requires() {
> +	_test_dev_is_pci
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	pdev=$(_get_pci_dev_from_blkdev)
> +
> +	if _test_dev_is_rotational; then
> +		size="32m"
> +	else
> +		size="1g"
> +	fi
> +
> +	# start fio job
> +	_run_fio --bs=4k --rw=randread --norandommap \
> +		--name=reads --filename="$TEST_DEV" --size="$size" \
> +		--numjobs=8 --direct=1 2>/dev/null &
> +
> +	while kill -0 $! 2>/dev/null; do
> +		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
> +		sleep .2
> +		echo 1 > "/sys/bus/pci/devices/${pdev}/enable"

Test looks good, but one question: do you want another sleep .2 here?
Like this, you immediately disable it after enabling it, but maybe
that's what you want :)

> +	done
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/011.out b/tests/block/011.out
> new file mode 100644
> index 000000000000..8e067df63097
> --- /dev/null
> +++ b/tests/block/011.out
> @@ -0,0 +1,2 @@
> +Running block/011
> +Test complete
> -- 
> 2.12.3
> 
