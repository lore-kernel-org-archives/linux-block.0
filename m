Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44597 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeDZX3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Apr 2018 19:29:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id 82-v6so42531pge.11
        for <linux-block@vger.kernel.org>; Thu, 26 Apr 2018 16:29:12 -0700 (PDT)
Date: Thu, 26 Apr 2018 16:29:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] Add surprise removal block test
Message-ID: <20180426232910.GA20826@vader>
References: <20180426225224.3601-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180426225224.3601-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 26, 2018 at 04:52:24PM -0600, Keith Busch wrote:
> This test is for PCI devices in a surprise remove capable slot and tests
> how well the drivers and kernel handle losing the link to that device.
> 
> The test finds the PCI Express Capability register of the pci slot a block
> device is in, then at offset 0x10 (the Link Control Register) writes a 1
> to bit 4 (Link Disable). This occurs unbeknownst to any of the drivers,
> just like a surprise removal. Drivers will find out about this through
> the pcie hotplug handler, at which point it's too late to communicate
> with the device, therfore testing how well we cope with the condition.
> 
> The link is reenabled at the end of the test.
> 
> Note, this is currently incompatible with NVMe Subsystems when
> CONFIG_NVME_MULTIPATH since the /dev/nvme*n* names don't have a pci
> parent in sysfs.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Awesome, thanks! Applied with a couple of minor changes mentioned below.

> ---
> v1 -> v2:
> 
>   Incorporated feedback from Omar and Johannes
> 
>   Included the 016.out file
> 
>   Updated 'fio' parameters so we ignore the errors that will inevitably
>   occur with this test so they don't muck with the output.
> 
> Just an example of what to expect in a dmesg on a capable platform:
> 
>  [ 77.850030] run blktests block/016 at 2018-04-26 15:40:19
>  [ 82.890360] pciehp 0000:5d:00.0:pcie004: Slot(0-3): Link Down
>  [ 82.911102] nvme2n1: detected capacity change from 400088457216 to 0
>  [ 82.911117] print_req_error: 67 callbacks suppressed
>  [ 82.911120] print_req_error: I/O error, dev nvme2n1, sector 12481728
>  [ 82.911156] print_req_error: I/O error, dev nvme2n1, sector 315938512
>  [ 82.911163] print_req_error: I/O error, dev nvme2n1, sector 86586144
>  [ 82.911171] print_req_error: I/O error, dev nvme2n1, sector 297252456
>  [ 82.911175] print_req_error: I/O error, dev nvme2n1, sector 266779224
>  [ 82.911179] print_req_error: I/O error, dev nvme2n1, sector 57643584
>  [ 82.911182] print_req_error: I/O error, dev nvme2n1, sector 561615936
>  [ 82.911187] print_req_error: I/O error, dev nvme2n1, sector 199511192
>  [ 82.911191] print_req_error: I/O error, dev nvme2n1, sector 613858480
>  [ 82.911194] print_req_error: I/O error, dev nvme2n1, sector 2027136
>  [ 87.918781] pciehp 0000:5d:00.0:pcie004: Slot(0-3): Card not present
>  [ 87.937184] pciehp 0000:5d:00.0:pcie004: Slot(0-3): Card present
>  [ 87.952707] pciehp 0000:5d:00.0:pcie004: Slot(0-3): Link Up
>  [ 88.064187] pci 0000:5e:00.0: [8086:0953] type 00 class 0x010802
>  [ 88.064216] pci 0000:5e:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>  [ 88.064242] pci 0000:5e:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
>  [ 88.064251] pci 0000:5e:00.0: enabling Extended Tags
>  [ 88.064491] pci 0000:5e:00.0: BAR 6: assigned [mem 0xb8800000-0xb880ffff pref]
>  [ 88.064495] pci 0000:5e:00.0: BAR 0: assigned [mem 0xb8810000-0xb8813fff 64bit]
>  [ 88.064506] pcieport 0000:5d:00.0: PCI bridge to [bus 5e]
>  [ 88.064510] pcieport 0000:5d:00.0:   bridge window [io 0x8000-0x8fff]
>  [ 88.064515] pcieport 0000:5d:00.0:   bridge window [mem 0xb8800000-0xb89fffff]
>  [ 88.064519] pcieport 0000:5d:00.0:   bridge window [mem 0x38c001000000-0x38c002ffffff 64bit pref]
>  [ 88.064987] nvme nvme2: pci function 0000:5e:00.0
>  [ 88.065060] nvme 0000:5e:00.0: enabling device (0100 -> 0102)
> 
> 
>  common/rc           | 19 +++++++++++++++++++
>  tests/block/016     | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/016.out |  2 ++
>  3 files changed, 75 insertions(+)
>  create mode 100755 tests/block/016
>  create mode 100644 tests/block/016.out
> 
> diff --git a/common/rc b/common/rc
> index 1bd0374..8115b66 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -171,6 +171,25 @@ _get_pci_dev_from_blkdev() {
>  		tail -1
>  }
>  
> +_get_pci_parent_from_blkdev() {
> +	readlink -f "$TEST_DEV_SYSFS/device" | \
> +		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
> +		tail -2 | head -1
> +}
> +
> +_test_dev_in_hotplug_slot() {
> +	local parent
> +	parent="$(_get_pci_parent_from_blkdev)"
> +
> +	local slt_cap
> +	slt_cap="$(setpci -s "${parent}" CAP_EXP+14.w)"
> +	if [ $((0x${slt_cap} & 0x20)) -eq 0 ]; then

I changed this to the bash-style [[ ]] tests. I can't get shellcheck to
warn about this, so I'll see if I can hack something together that does.

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
> index 0000000..0d54238
> --- /dev/null
> +++ b/tests/block/016
> @@ -0,0 +1,54 @@
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
> +DESCRIPTION="break PCI link device while doing I/O"
> +TIMED=1
> +
> +requires() {
> +	_have_fio && _have_program setpci
> +}
> +
> +device_requires() {
> +	_test_dev_is_pci && _test_dev_in_hotplug_slot
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local parent
> +	local TIMEOUT
> +
> +	parent="$(_get_pci_parent_from_blkdev)"
> +
> +	# start fio job
> +	TIMEOUT=10
> +	_run_fio_rand_io --filename="$TEST_DEV" --time_based \
> +		--continue_on_error=io 2> /dev/null &
> +	sleep 5
> +
> +	# masks  the slot's link disable bit to 'on'
> +	setpci -s "${parent}" CAP_EXP+10.w=10:10
> +	sleep 5
> +
> +	# masks the slot's link disable bit back to 'off'
> +	setpci -s "${parent}" CAP_EXP+10.w=00:10
> +	sleep 5

I added a `wait` here to make sure fio is done/doesn't hang.

> +	echo "Test complete"
> +}

As a separate patch, I'm gonna make _run_fio handle --runtime if it's
explicitly given so we can use that instead of having to override
TIMEOUT.
