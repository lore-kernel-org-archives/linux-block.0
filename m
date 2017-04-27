Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26192 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdD0EWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 00:22:51 -0400
Subject: Re: [PATCH 00/10] dm: zoned block device support
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
References: <20170421035558.2657-1-damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <cca4fad3-aee4-14d7-f576-b6ceda114941@wdc.com>
Date: Thu, 27 Apr 2017 13:22:24 +0900
MIME-Version: 1.0
In-Reply-To: <20170421035558.2657-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Mike,

Any comments on this series ?
Is it possible that you consider it for 4.12 ?

Best regards.

On 4/21/17 12:55, damien.lemoal@wdc.com wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> This series introduces zoned block device support to the device mapper
> infrastructure. Pathces are as follows:
> 
> - Patch 1: Add a new target type feature flag to indicate if a target type
>   supports host-managed zoned block devices. This prevents using these drives
>   with the current target types since none of them have the proper support
>   implemented and will not operate properly with these drives.
> - Patch 2: If a target device is a zoned block device, check that the range of
>   LBAs mapped is aligned to the device zone size and that the device start
>   offset also aligns to zone boundaries. This is necessary for zone reset and
>   zone report correct execution.
> - Patch 3: Check that the different target devices of a table have compatible
>   zone sizes and models. This is necessary for target types that expose a zone
>   model different from the underlying device.
> - Patch 4: Fix handling of REQ_OP_ZONE_RESET bios
> - Patch 5: Fix handling of REQ_OP_ZONE_REPORT bios
> - Patch 6: Introduce a new helper function to reverse map a device zone report
>   to the target LBA range
> - Patch 7: Add support for host-managed zoned block devices to dm-flakey. This
>   is necessary for testing file systems supporting natively these drives (e.g.
>   f2fs).
> - Patch 8: Add support for for zoned block devices to dm-linear. This can have
>   useful applications during development and testing (e.g. allow creating
>   smaller zoned devices with different combinations and positions of zones).
>   There are also interesting applications for production, for instance, the
>   ability to aggregate conventional zones of different drives to create a
>   regular disk.
> - Patch 9: Add sequential write enforcement to dm_kcopyd_copy so that
>   sequential zones of a host-managed zoned block device can be specified as
>   destinations.
> - Patch 10: New dm-zoned target type (this was already sent for review twice).
>   This resend adds modifications suggested by Hannes to implement reclaim
>   using dm-kcopyd. dm-zoned depends on patch 9.
> 
> As always, comments and reviews are welcome.
> 
> Damien Le Moal (10):
>   dm-table: Introduce DM_TARGET_ZONED_HM feature
>   dm-table: Check device area zone alignment
>   dm-table: Check block devices zone model compatibility
>   dm: Fix REQ_OP_ZONE_RESET bio handling
>   dm: Fix REQ_OP_ZONE_REPORT bio handling
>   dm: Introduce dm_remap_zone_report()
>   dm-flakey: Add support for zoned block devices
>   dm-linear: Add support for zoned block devices
>   dm-kcopyd: Add sequential write feature
>   dm-zoned: Drive-managed zoned block device target
> 
>  Documentation/device-mapper/dm-zoned.txt |  154 +++
>  drivers/md/Kconfig                       |   19 +
>  drivers/md/Makefile                      |    2 +
>  drivers/md/dm-flakey.c                   |   21 +-
>  drivers/md/dm-kcopyd.c                   |   68 +-
>  drivers/md/dm-linear.c                   |   14 +-
>  drivers/md/dm-table.c                    |  145 ++
>  drivers/md/dm-zoned-io.c                 |  998 ++++++++++++++
>  drivers/md/dm-zoned-metadata.c           | 2195 ++++++++++++++++++++++++++++++
>  drivers/md/dm-zoned-reclaim.c            |  535 ++++++++
>  drivers/md/dm-zoned.h                    |  528 +++++++
>  drivers/md/dm.c                          |   93 +-
>  include/linux/device-mapper.h            |   16 +
>  include/linux/dm-kcopyd.h                |    1 +
>  14 files changed, 4783 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/device-mapper/dm-zoned.txt
>  create mode 100644 drivers/md/dm-zoned-io.c
>  create mode 100644 drivers/md/dm-zoned-metadata.c
>  create mode 100644 drivers/md/dm-zoned-reclaim.c
>  create mode 100644 drivers/md/dm-zoned.h
> 

-- 
Damien Le Moal, Ph.D.
Sr Manager, System Software Group,
Western Digital Research
Damien.LeMoal@wdc.com
Tel: (+81) 0466-98-3593 (Ext. 51-3593)
1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
