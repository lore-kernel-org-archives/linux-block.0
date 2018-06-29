Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9937 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936275AbeF2QNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 12:13:54 -0400
Subject: Re: [PATCH blktests v2 3/3] Add tests for the SRP initiator and
 target drivers
To: Omar Sandoval <osandov@osandov.com>
Cc: Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
 <20180627214908.26379-4-bart.vanassche@wdc.com>
 <20180628234305.GB14953@vader>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <90b8682d-7010-5f57-9ecd-3a4c733ccc18@wdc.com>
Date: Fri, 29 Jun 2018 09:13:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180628234305.GB14953@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/28/18 16:43, Omar Sandoval wrote:
> On Wed, Jun 27, 2018 at 02:49:08PM -0700, Bart Van Assche wrote:
> [ ... ]
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
> runtime  6.680s  ...  6.640s
>      --- tests/srp/002.out       2018-06-28 15:18:36.537169282 -0700
>      +++ results/nodev/srp/002.out.bad   2018-06-28 16:21:59.930603931 -0700
>      @@ -3,5 +3,4 @@
>       Unloaded the rdma_rxe kernel module
>       Configured SRP target driver
>       Unloaded the ib_srp kernel module
>      -Unloaded the ib_srpt kernel module
>      -Unloaded the rdma_rxe kernel module
>      +/dev/disk/by-id/dm-uuid-mpath-3600140572616d6469736b31000000000: not found
> 
> And everything else fails like srp/002.

I think that indicates a problem with the multipathing software on your 
setup. Was multipathd running? Had the proper multipath configuration 
(/etc/multipath.conf) been provided? Was multipathing enabled in the 
kernel config?

>> +Make sure that at least the following symbols are set in the kernel config:
>> +
>> +* CONFIG_BLK_DEV_DM
>> +* CONFIG_BLK_DEV_NULL_BLK
>> +* CONFIG_BLK_DEV_RAM
>> +* CONFIG_BLK_DEV_SD
>> +* CONFIG_CHR_DEV_SG
>> +* CONFIG_DM_MULTIPATH
>> +* CONFIG_DM_MULTIPATH_QL
>> +* CONFIG_DM_MULTIPATH_ST
>> +* CONFIG_INFINIBAND
>> +* CONFIG_INFINIBAND_ADDR_TRANS
>> +* CONFIG_INFINIBAND_IPOIB
>> +* CONFIG_INFINIBAND_SRP
>> +* CONFIG_INFINIBAND_SRPT
>> +* CONFIG_INFINIBAND_USER_ACCESS
>> +* CONFIG_INFINIBAND_USER_MAD
>> +* CONFIG_INFINIBAND_USER_MEM
>> +* CONFIG_NVME_CORE
>> +* CONFIG_NVME_RDMA
>> +* CONFIG_NVME_TARGET
>> +* CONFIG_NVME_TARGET_RDMA
>> +* CONFIG_RDMA_RXE
>> +* CONFIG_SCSI_DEBUG
>> +* CONFIG_SCSI_DH_ALUA
>> +* CONFIG_SCSI_DH_EMC
>> +* CONFIG_SCSI_DH_RDAC
>> +* CONFIG_SCSI_SRP_ATTRS
>> +* CONFIG_TARGET_CORE
>> +* CONFIG_TCM_FILEIO
>> +* CONFIG_TCM_IBLOCK
> 
> Why don't all of these have _have_module checks in
> group_requires()/requires()?

Adding such checks sounds like a good idea to me. I will look into this.

>> +For the SRP tests, merge or copy the following into /etc/multipathd.conf and
>> +restart multipathd:
>> +
>> +<span></span>
>> +
>> +    defaults {
>> +        user_friendly_names     yes
>> +        queue_without_daemon    no
>> +    }
>> +    devices {
>> +        device {
>> +            vendor       "LIO-ORG|SCST_BIO|FUSIONIO"
>> +            product      ".*"
>> +            features     "1 queue_if_no_path"
>> +            path_checker tur
>> +        }
>> +    }
>> +    blacklist {
>> +        device {
>> +            vendor  "ATA"
>> +        }
>> +        device {
>> +            vendor  "QEMU"
>> +        }
>> +        device {
>> +            vendor  "Linux"
>> +            product "scsi_debug"
>> +        }
>> +        devnode     "^nullb.*"
>> +    }
>> +    blacklist_exceptions {
>> +        property        ".*"
>> +        devnode         "^nvme"
>> +    }
>> +
> 
> Does multipathd have any way to run with a custom config file, so we can
> just start it on demand instead of having to do this?

multipathd can be started on demand. I will look into this.

> [snip]
> 
>> diff --git a/tests/srp/functions b/tests/srp/functions
> 
> This stuff should just go in tests/srp/rc.

OK.

>> +vdev_path=(/dev/ram0 /dev/ram1 "$(scsi_debug_dev_path)")
>> +scsi_serial=(ramdisk1 ramdisk2 scsidbg)
>> +memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
>> +max_ramdisk_size=$((1<<25))
>> +if have_brd; then
>> +    ramdisk_size=$((memtotal*(1024/16)))  # in bytes
>> +    if [ $ramdisk_size -gt $max_ramdisk_size ]; then
>> +	ramdisk_size=$max_ramdisk_size
>> +    fi
>> +elif [ -e /sys/class/block/ram0 ]; then
>> +    # in bytes
>> +    ramdisk_size=$(($(</sys/class/block/ram0/size) * 512))
>> +else
>> +	echo "Error: could not find /dev/ram0"
>> +	exit 1
>> +fi
> 
> If brd isn't enabled, I get hilarity:
> 
> $ sudo ./check srp
> ./check: line 451: tests/Error: could not find /dev/rc: No such file or directory
> ./check: line 410: tests/Error: could not find /dev/ram0
> : No such file or directory
> 
> At the very least, this check should be happening in group_requires(),
> and brd should just be mandatory. Or even better, is there a reason we
> can't use the persistent mode of null_blk instead of brd?

Development of the SRP test software started before null_blk had a 
persistent mode. Anyway, I will see what needs to change to switch to 
null_blk.

>> +	# Load the I/O scheduler kernel modules
>> +	(
>> +		cd "/lib/modules/$(uname -r)/kernel/block" &&
>> +		    for m in *.ko; do
>> +			    modprobe "${m%.ko}"
>> +		    done
>> +	)
> 
> All of my schedulers are built in, so I get:
> 
> +modprobe: FATAL: Module * not found in directory /lib/modules/4.18.0-rc2
> 
> This should handle that case and go in check instead of here.

OK.

>> +	if [ -d /sys/kernel/debug/dynamic_debug ]; then
>> +		for m in ; do
>> +			echo "module $m +pmf" >/sys/kernel/debug/dynamic_debug/control
>> +		done
>> +	fi
>> +
>> +	start_target
>> +}
>> diff --git a/tests/srp/rc b/tests/srp/rc
>> new file mode 100755
>> index 000000000000..f5de9610dc2b
>> --- /dev/null
>> +++ b/tests/srp/rc
>> @@ -0,0 +1,54 @@
>> +#!/bin/bash
>> +#
>> +# Copyright (c) 2018 Western Digital Corporation or its affiliates
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License
>> +# as published by the Free Software Foundation; either version 2
>> +# of the License, or (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write to the Free Software
>> +# Foundation, Inc.
>> +
>> +. common/rc
>> +
>> +is_lio_configured() {
>> +	(
>> +		cd /sys/kernel/config/target >&/dev/null || return 1
>> +		for e in target/* core/fileio* core/iblock* core/pscsi*; do
>> +			[ -d "$e" ] && [ "$e" != core ] && return 0
>> +		done
>> +	)
>> +
>> +	return 1
>> +}
>> +
>> +group_requires() {
>> +	_have_configfs || return $?
>> +	if is_lio_configured; then
>> +		echo "Error: LIO must be unloaded before the SRP tests are run"
> 
> This should set SKIP_REASON instead of echoing.
> 
>> +		return 1
>> +	fi
>> +	_have_module dm_multipath || return $?
>> +	_have_module ib_srp || return $?
>> +	_have_module ib_srpt || return $?
>> +	_have_module sd_mod || return $?
>> +	_have_program mkfs.ext4 || return $?
>> +	_have_program mkfs.xfs || return $?
>> +	_have_program multipath || return $?
>> +	_have_program multipathd || return $?
>> +	_have_program pidof || return $?
>> +	_have_program sg_reset || return $?
>> +	_have_root || return $?
>> +
>> +	if ! pidof multipathd >/dev/null; then
>> +		echo "Error: multipathd is not running"
> 
> Same, set SKIP_REASON.

OK, I will make these changes.

Bart.
