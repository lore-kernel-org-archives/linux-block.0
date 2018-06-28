Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32833 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936267AbeF1XnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jun 2018 19:43:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so3318625pfi.0
        for <linux-block@vger.kernel.org>; Thu, 28 Jun 2018 16:43:07 -0700 (PDT)
Date: Thu, 28 Jun 2018 16:43:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
Message-ID: <20180628234305.GB14953@vader>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627214908.26379-4-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 27, 2018 at 02:49:08PM -0700, Bart Van Assche wrote:
> This patch adds the following tests:
> 001: Create and remove LUNs
> 002: File I/O on top of multipath concurrently with logout and login (mq)
> 003: File I/O on top of multipath concurrently with logout and login (sq)
> 004: File I/O on top of multipath concurrently with logout and login (sq-on-mq)
> 005: Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M
> 006: Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M
> 007: Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=4M
> 008: Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=8M
> 009: Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M
> 010: Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M
> 011: Block I/O on top of multipath concurrently with logout and login
> 012: dm-mpath on top of multiple I/O schedulers
> 013: Direct I/O using a discontiguous buffer
> 
> Other changes in this patch are:
> - Document required kernel config options, user space packages and
>   multipath.conf in README.md.
> - Add file tests/srp/functions with shell functions that are used by
>   multiple SRP tests.
> - Add file tests/srp/rc.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> ---

Thanks, Bart, happy to see this making progress :)

The tests currently fail like this for me:

srp/001 (Create and remove LUNs)                             [failed]
runtime  18.238s  ...  17.925s
    --- tests/srp/001.out       2018-06-28 15:18:36.533835920 -0700
    +++ results/nodev/srp/001.out.bad   2018-06-28 16:21:53.187213618 -0700
    @@ -1,6 +1,6 @@
    +Unloaded the ib_srp kernel module
     Unloaded the ib_srpt kernel module
     Unloaded the rdma_rxe kernel module
    -
     Configured SRP target driver
     Unloaded the ib_srp kernel module
     count_luns(): 3 <> 3
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
runtime  6.680s  ...  6.640s
    --- tests/srp/002.out       2018-06-28 15:18:36.537169282 -0700
    +++ results/nodev/srp/002.out.bad   2018-06-28 16:21:59.930603931 -0700
    @@ -3,5 +3,4 @@
     Unloaded the rdma_rxe kernel module
     Configured SRP target driver
     Unloaded the ib_srp kernel module
    -Unloaded the ib_srpt kernel module
    -Unloaded the rdma_rxe kernel module
    +/dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000: not found

And everything else fails like srp/002.

Some more comments below.

>  README.md           |   71 +++
>  tests/srp/001       |   71 +++
>  tests/srp/001.out   |    8 +
>  tests/srp/002       |   49 ++
>  tests/srp/002.out   |    7 +
>  tests/srp/003       |   50 ++
>  tests/srp/003.out   |    7 +
>  tests/srp/004       |   50 ++
>  tests/srp/004.out   |    7 +
>  tests/srp/005       |   40 ++
>  tests/srp/005.out   |    7 +
>  tests/srp/006       |   40 ++
>  tests/srp/006.out   |    7 +
>  tests/srp/007       |   40 ++
>  tests/srp/007.out   |    7 +
>  tests/srp/008       |   39 ++
>  tests/srp/008.out   |    7 +
>  tests/srp/009       |   40 ++
>  tests/srp/009.out   |    7 +
>  tests/srp/010       |   40 ++
>  tests/srp/010.out   |    7 +
>  tests/srp/011       |   44 ++
>  tests/srp/011.out   |    7 +
>  tests/srp/012       |   52 ++
>  tests/srp/012.out   |    8 +
>  tests/srp/013       |   48 ++
>  tests/srp/013.out   |    8 +
>  tests/srp/functions | 1288 +++++++++++++++++++++++++++++++++++++++++++
>  tests/srp/rc        |   54 ++
>  29 files changed, 2110 insertions(+)
>  create mode 100755 tests/srp/001
>  create mode 100644 tests/srp/001.out
>  create mode 100755 tests/srp/002
>  create mode 100644 tests/srp/002.out
>  create mode 100755 tests/srp/003
>  create mode 100644 tests/srp/003.out
>  create mode 100755 tests/srp/004
>  create mode 100644 tests/srp/004.out
>  create mode 100755 tests/srp/005
>  create mode 100644 tests/srp/005.out
>  create mode 100755 tests/srp/006
>  create mode 100644 tests/srp/006.out
>  create mode 100755 tests/srp/007
>  create mode 100644 tests/srp/007.out
>  create mode 100755 tests/srp/008
>  create mode 100644 tests/srp/008.out
>  create mode 100755 tests/srp/009
>  create mode 100644 tests/srp/009.out
>  create mode 100755 tests/srp/010
>  create mode 100644 tests/srp/010.out
>  create mode 100755 tests/srp/011
>  create mode 100644 tests/srp/011.out
>  create mode 100755 tests/srp/012
>  create mode 100644 tests/srp/012.out
>  create mode 100755 tests/srp/013
>  create mode 100644 tests/srp/013.out
>  create mode 100755 tests/srp/functions
>  create mode 100755 tests/srp/rc
> 
> diff --git a/README.md b/README.md
> index 78a41567416e..d8df938700cd 100644
> --- a/README.md
> +++ b/README.md
> @@ -6,6 +6,38 @@ filesystem testing framework.
>  
>  ## Getting Started
>  
> +Make sure that at least the following symbols are set in the kernel config:
> +
> +* CONFIG_BLK_DEV_DM
> +* CONFIG_BLK_DEV_NULL_BLK
> +* CONFIG_BLK_DEV_RAM
> +* CONFIG_BLK_DEV_SD
> +* CONFIG_CHR_DEV_SG
> +* CONFIG_DM_MULTIPATH
> +* CONFIG_DM_MULTIPATH_QL
> +* CONFIG_DM_MULTIPATH_ST
> +* CONFIG_INFINIBAND
> +* CONFIG_INFINIBAND_ADDR_TRANS
> +* CONFIG_INFINIBAND_IPOIB
> +* CONFIG_INFINIBAND_SRP
> +* CONFIG_INFINIBAND_SRPT
> +* CONFIG_INFINIBAND_USER_ACCESS
> +* CONFIG_INFINIBAND_USER_MAD
> +* CONFIG_INFINIBAND_USER_MEM
> +* CONFIG_NVME_CORE
> +* CONFIG_NVME_RDMA
> +* CONFIG_NVME_TARGET
> +* CONFIG_NVME_TARGET_RDMA
> +* CONFIG_RDMA_RXE
> +* CONFIG_SCSI_DEBUG
> +* CONFIG_SCSI_DH_ALUA
> +* CONFIG_SCSI_DH_EMC
> +* CONFIG_SCSI_DH_RDAC
> +* CONFIG_SCSI_SRP_ATTRS
> +* CONFIG_TARGET_CORE
> +* CONFIG_TCM_FILEIO
> +* CONFIG_TCM_IBLOCK

Why don't all of these have _have_module checks in
group_requires()/requires()?

>  The dependencies are minimal, but make sure you have them installed:
>  
>  - bash 4
> @@ -13,6 +45,10 @@ The dependencies are minimal, but make sure you have them installed:
>  - GNU awk
>  - util-linux
>  - fio
> +- gcc
> +- make
> +- multipath-tools or device-mapper-multipath
> +- e2fsprogs and xfsprogs
>  
>  Add the list of block devices you want to test on in a file named `config`:
>  
> @@ -20,6 +56,41 @@ Add the list of block devices you want to test on in a file named `config`:
>  TEST_DEVS=(/dev/nvme0n1 /dev/sdb)
>  ```
>  
> +For the SRP tests, merge or copy the following into /etc/multipathd.conf and
> +restart multipathd:
> +
> +<span></span>
> +
> +    defaults {
> +        user_friendly_names     yes
> +        queue_without_daemon    no
> +    }
> +    devices {
> +        device {
> +            vendor       "LIO-ORG|SCST_BIO|FUSIONIO"
> +            product      ".*"
> +            features     "1 queue_if_no_path"
> +            path_checker tur
> +        }
> +    }
> +    blacklist {
> +        device {
> +            vendor  "ATA"
> +        }
> +        device {
> +            vendor  "QEMU"
> +        }
> +        device {
> +            vendor  "Linux"
> +            product "scsi_debug"
> +        }
> +        devnode     "^nullb.*"
> +    }
> +    blacklist_exceptions {
> +        property        ".*"
> +        devnode         "^nvme"
> +    }
> +

Does multipathd have any way to run with a custom config file, so we can
just start it on demand instead of having to do this?

[snip]

> diff --git a/tests/srp/functions b/tests/srp/functions

This stuff should just go in tests/srp/rc.

> new file mode 100755
> index 000000000000..8fe654711613
> --- /dev/null
> +++ b/tests/srp/functions
> @@ -0,0 +1,1288 @@
> +#!/bin/bash
> +#
> +# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version 2
> +# of the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc.
> +
> +have_brd() {
> +	modinfo brd >/dev/null 2>&1
> +}
> +
> +scsi_debug_dev_path() {
> +	local bd d
> +
> +	for d in /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*; do
> +		[ -e "$d" ] || continue
> +		bd=${d/*\//}
> +	done
> +	[ -n "$bd" ] || return 1
> +	echo "/dev/$bd"
> +}
> +
> +vdev_path=(/dev/ram0 /dev/ram1 "$(scsi_debug_dev_path)")
> +scsi_serial=(ramdisk1 ramdisk2 scsidbg)
> +memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
> +max_ramdisk_size=$((1<<25))
> +if have_brd; then
> +    ramdisk_size=$((memtotal*(1024/16)))  # in bytes
> +    if [ $ramdisk_size -gt $max_ramdisk_size ]; then
> +	ramdisk_size=$max_ramdisk_size
> +    fi
> +elif [ -e /sys/class/block/ram0 ]; then
> +    # in bytes
> +    ramdisk_size=$(($(</sys/class/block/ram0/size) * 512))
> +else
> +	echo "Error: could not find /dev/ram0"
> +	exit 1
> +fi

If brd isn't enabled, I get hilarity:

$ sudo ./check srp
./check: line 451: tests/Error: could not find /dev/rc: No such file or directory
./check: line 410: tests/Error: could not find /dev/ram0
: No such file or directory

At the very least, this check should be happening in group_requires(),
and brd should just be mandatory. Or even better, is there a reason we
can't use the persistent mode of null_blk instead of brd?

[snip]

> +# Load the SRP initiator driver with kernel module parameters $1..$n.
> +start_srp() {
> +	modprobe scsi_transport_srp || return $?
> +	modprobe ib_srp "$@" dyndbg=+pmf || return $?
> +}

These modprobes (and all of the other ones in this file) should have
matching _have_module checks in group_requires() or requires().

[snip]

> +	# Load the I/O scheduler kernel modules
> +	(
> +		cd "/lib/modules/$(uname -r)/kernel/block" &&
> +		    for m in *.ko; do
> +			    modprobe "${m%.ko}"
> +		    done
> +	)

All of my schedulers are built in, so I get:

+modprobe: FATAL: Module * not found in directory /lib/modules/4.18.0-rc2

This should handle that case and go in check instead of here.

> +	if [ -d /sys/kernel/debug/dynamic_debug ]; then
> +		for m in ; do
> +			echo "module $m +pmf" >/sys/kernel/debug/dynamic_debug/control
> +		done
> +	fi
> +
> +	start_target
> +}
> diff --git a/tests/srp/rc b/tests/srp/rc
> new file mode 100755
> index 000000000000..f5de9610dc2b
> --- /dev/null
> +++ b/tests/srp/rc
> @@ -0,0 +1,54 @@
> +#!/bin/bash
> +#
> +# Copyright (c) 2018 Western Digital Corporation or its affiliates
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version 2
> +# of the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc.
> +
> +. common/rc
> +
> +is_lio_configured() {
> +	(
> +		cd /sys/kernel/config/target >&/dev/null || return 1
> +		for e in target/* core/fileio* core/iblock* core/pscsi*; do
> +			[ -d "$e" ] && [ "$e" != core ] && return 0
> +		done
> +	)
> +
> +	return 1
> +}
> +
> +group_requires() {
> +	_have_configfs || return $?
> +	if is_lio_configured; then
> +		echo "Error: LIO must be unloaded before the SRP tests are run"

This should set SKIP_REASON instead of echoing.

> +		return 1
> +	fi
> +	_have_module dm_multipath || return $?
> +	_have_module ib_srp || return $?
> +	_have_module ib_srpt || return $?
> +	_have_module sd_mod || return $?
> +	_have_program mkfs.ext4 || return $?
> +	_have_program mkfs.xfs || return $?
> +	_have_program multipath || return $?
> +	_have_program multipathd || return $?
> +	_have_program pidof || return $?
> +	_have_program sg_reset || return $?
> +	_have_root || return $?
> +
> +	if ! pidof multipathd >/dev/null; then
> +		echo "Error: multipathd is not running"

Same, set SKIP_REASON.

> +		return 1
> +	fi
> +}
> -- 
> 2.17.1
> 
