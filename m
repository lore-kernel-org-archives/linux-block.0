Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37159 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755655AbeDYP4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 11:56:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id p6so15585031pfn.4
        for <linux-block@vger.kernel.org>; Wed, 25 Apr 2018 08:56:05 -0700 (PDT)
Date: Wed, 25 Apr 2018 08:56:02 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests] Add surprise removal block test
Message-ID: <20180425155602.GB30070@vader>
References: <20180424214146.31168-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180424214146.31168-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 24, 2018 at 03:41:46PM -0600, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Hey, Keith, thanks for the test! Some comments/questions below.

> ---
>  common/rc       | 17 +++++++++++++++++
>  tests/block/016 | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/block/016
> 
> diff --git a/common/rc b/common/rc
> index 1bd0374..979c8c2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -171,6 +171,23 @@ _get_pci_dev_from_blkdev() {
>  		tail -1
>  }
>  
> +_get_pci_parent_from_blkdev() {
> +	readlink -f "$TEST_DEV_SYSFS/device" | \
> +		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
> +		tail -2 | head -1
> +}
> +
> +_test_hotplug_slot() {

I'd call this _test_dev_in_hotplug_slot().

> +	parent="$(_get_pci_parent_from_blkdev)"

I haven't been consistent about asking people to do this, but could you
make these variables local? I.e.,

local parent
parent="$(_get_pci_parent_from_blkdev)"
local slt_cap
slt_cap=...

> +
> +	slt_cap=$(setpci -s ${parent} CAP_EXP+14.w)

Missing quotes around "${parent}" here (and elsewhere). `make
shellcheck` will catch this.

> +	if [ $((0x${slt_cap} & 0x20)) -eq 0 ]; then
> +		SKIP_REASON="$TEST_DEV is not in a hot pluggable slot"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  # Older versions of xfs_io use pwrite64 and such, so the error messages won't
>  # match current versions of xfs_io. See c52086226bc6 ("filter: xfs_io output
>  # has dropped "64" from error messages") in xfstests.
> diff --git a/tests/block/016 b/tests/block/016
> new file mode 100755
> index 0000000..4c2e294
> --- /dev/null
> +++ b/tests/block/016
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +#
> +# Do disable PCI device while doing I/O to it
> +#
> +# Copyright (C) 2018 Keith Busch <keith.busch@intel.com>
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
> +DESCRIPTION="break PCI link while doing I/O"
> +TIMED=1
> +
> +requires() {
> +	_have_fio
> +}
> +
> +device_requires() {
> +	_test_dev_is_pci
> +	_test_hotplug_slot
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	parent="$(_get_pci_parent_from_blkdev)"
> +
> +	if _test_dev_is_rotational; then
> +		size="32m"
> +	else
> +		size="1g"
> +	fi
> +
> +	# start fio job
> +	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
> +			--ignore_error=EIO,ENXIO,ENODEV &
> +
> +	setpci -s ${parent} CAP_EXP+10.w=10:10
> +	sleep 10
> +	setpci -s ${parent} CAP_EXP+10.w=00:10

For the sake of people of me who don't speak PCI, what do each of these
commands do? :) Should we make the fio job --time_based instead of using
--size so that we're sure it runs long enough for the sleep?

> +	echo "Test complete"
> +}
> -- 
> 2.14.3
> 
