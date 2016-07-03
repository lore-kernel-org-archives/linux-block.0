Return-Path: <linux-block-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:34176 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbcGCTwk (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Sun, 3 Jul 2016 15:52:40 -0400
Date: Sun, 3 Jul 2016 20:52:32 +0100
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, shli@fb.com,
	snitzer@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't ignore -EOPNOTSUPP
 blkdev_issue_write_same
Message-ID: <20160703195232.GA15570@sucs.org>
References: <1466751651-9900-1-git-send-email-hch@lst.de>
 <1466751651-9900-3-git-send-email-hch@lst.de>
 <yq1furwsi0t.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1furwsi0t.fsf@sermon.lab.mkp.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 29, 2016 at 01:04:02AM -0400, Martin K. Petersen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:
> 
> Christoph> WRITE SAME is a data integrity operation and we can't simply
> Christoph> ignore errors.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

Along with the first patch this resolves the problems I was seeing when
using the script below when applied atop of axboe/linux-block.git branch
for-4.8/core (commit e118e4be8a96c6b89307ee3d360d954249981b8f).

The only snag is that when userland manually disables
max_write_same_blocks on the base device (by echoing 0 into it) stacked
devices will not set their their own queue/write_same_max_bytes to 0
when the BLKZEROOUT fails to use write same (but they do correctly zero
the device). If the base device somehow internally toggles this to 0
itself during a write same then dm devices seem to set
queue/write_same_max_bytes to 0.

Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

#!/bin/bash
# Check BLKZEROOUT behaviour

modprobe scsi_debug write_same_length=131072
dev=$(lsblk -n -p -S | awk '/scsi_debug/ { print $1 }')
dev_kname=$(lsblk -n -S ${dev} | awk '{ print $1 }')
sys_dev_mwsb_path=$(realpath
/sys/block/"${dev_kname}"/device/scsi_disk/*/max_write_same_blocks)
pvcreate ${dev}
vgcreate vg ${dev}
lvcreate -L4M -n lv vg
lv_dev=/dev/mapper/vg-lv
sys_lv_wsmb_path="/sys/block/$(lsblk -n -o KNAME
"${lv_dev}")/queue/write_same_max_bytes"
orig_max_ws=$(cat "${sys_dev_mwsb_path}")
echo "Stacked device's write_same_max_bytes prior blkzeroout: $(cat
${sys_lv_wsmb_path})"
echo "Forcing base device's max_write_same_blocks to 0"
echo 0 > "${sys_dev_mwsb_path}"
size=$(blockdev --getsize64 "${lv_dev}")
tr '\0' '\377' < /dev/zero | dd oflag=direct bs=64K of="${lv_dev}"
count=$((${size} / (64 * 1024))) 
status=none
blkdiscard -v --zero "${lv_dev}"
dd if="${lv_dev}" iflag=direct bs=64K status=none | cmp -b --bytes
"${size}" /dev/zero -
verification=$?
echo "Stacked device's write_same_max_bytes after blkzeroout: $(cat
${sys_lv_wsmb_path})"
lvchange -a n "${lv_dev}"

-- 
Sitsofe | http://sucs.org/~sits/
