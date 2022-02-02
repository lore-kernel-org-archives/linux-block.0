Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3622C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Feb 2022 23:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBBX2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:28:03 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42135 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiBBX2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 18:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643844483; x=1675380483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ve3cKYkObvnUd8vLaeha9ZjG1eTIEvBdvZnHJsAfzy8=;
  b=I94kzV2hyNxt0BwgXOFMlwfk1oLcfdfRcvTaR/M1dz66B3uVIdKHfzib
   YHfW5CUvcQWVkbfOZwZH6/ZYVD4HpgNLUbupW6ujd3hRjD1JvBEIRkFe0
   7AgT9ESPVbhKyqLXebK1ET/2ZumsBx4vTHrW6yLroxoO+PxAUzKk9c6th
   iG/M3sR6icB/hnxiB/EoacT1k1QNHhmbfVOh01ztLKXpZ18qZfXVIOxSU
   9SwdnRf6Dka+JlH+UAD1I+/1K91TojZWLYGPfE1mvyPmJIv/iit5O4TTT
   LXXdgDa1jIYr9tkGx4XAWgTpmD6VG+rof9enynLt6DxWKa4YlP1j+N66U
   g==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635177600"; 
   d="scan'208";a="193005777"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2022 07:28:02 +0800
IronPort-SDR: BpVj4oaN1XJzJ/oJ7YLfsXnn4vzlqfA71W8HF7M5arnkVXaxcyVV88z5qycymnAt/aiL8otYRM
 mtr7oeXRRIzBkQM4lF/GVeSVWlYvb1VMES8+iixGNwGTlGJYlEdZ+l5wWbrGn4ETR6yILvcyhU
 RzSu8vid/Bdz18yQQy7qHZU6JEeOHteCb9unWijCI1+veV0tgxNeG2I2wsLtLyPSpJtJmOHrNa
 3nWkZ4RyLo9L4SgrAdG7bjkFkpMtAQqneZKQdx3qd2ysmxIctKtxmdzLVQtIW1b6SZbvEUdRpe
 tx/wYbYl2+J+oZHCK3Z8WLJT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:01:10 -0800
IronPort-SDR: Crdh4xVc47jQecFwDU+rrdXq+0AxVAxorLQS5/22fj6otcUGQl8q0ZDAdKYO/ZLFNOQwCkbwCT
 tiYmKsy6subCELJ5dTIpcISeAU+nrXkwxeVwej9VPAYuMxXEc8L+Xq+haViPKts4g2EB9N/NCm
 caHUDWkNtXOdCgnxH2C5FhnvbnNn6yiOzdi0wlFwppJlopAjw9t736DKqWej2j98uxFAK3/NOh
 6oM5qmPYYa5YmH4wPpl5Sj4KyFxuVLreUKNnUAnrC7+Jqzc4KFV/KSJ40/G97dhglf4IwRunzT
 OGs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 15:28:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jpyds39syz1SVp2
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 15:28:01 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643844479; x=1646436480; bh=ve3cKYkObvnUd8vLaeha9ZjG1eTIEvBdvZn
        HJsAfzy8=; b=gjQzFtBIDvK5lq7EnijqtRGGRdCzyFCKjZHy+cVhSc2C/i48R2Z
        QJQVRlGlRJ2ecjEsmcJx99f7irZZOav2y7wIAYfYkmiWCVTryOSLWHLJRpDxNcVp
        ZxCI50yW2o2/FADIxdLI4PBs+KvYjsz1ZhNmNXF8wgC1CtPprSdQVA3geINE5xDs
        eBX+i1YzpXL3v973EwIQJJf3j3GOa8sacIsGacaBPyvXEfy1WWGbsgVTn4Hmd/cE
        H4FBwdXnu8UsyewOlf9gr0ClVhvQPviEPVYwmgCz3QISsLZkTpq6EUyhlbdgvlSQ
        LZndXu565gmfwFJ5Nls2wm98qzLaxVaZrMw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jz_WE5Yj1JjV for <linux-block@vger.kernel.org>;
        Wed,  2 Feb 2022 15:27:59 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jpydn6pJPz1Rwrw;
        Wed,  2 Feb 2022 15:27:57 -0800 (PST)
Message-ID: <01a707d8-4a52-fe44-d6c5-ecd72fee18b6@opensource.wdc.com>
Date:   Thu, 3 Feb 2022 08:27:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] remove the paride driver
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ondrej Zary <linux@zary.sk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org
References: <20211223113504.1117836-1-hch@lst.de>
 <202112232334.46631.linux@zary.sk> <20211224055644.GA12208@lst.de>
 <202201302114.43437.linux@zary.sk> <20220202141340.GC24276@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220202141340.GC24276@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/2/22 23:13, Christoph Hellwig wrote:
> On Sun, Jan 30, 2022 at 09:14:43PM +0100, Ondrej Zary wrote:
>> Here's the first version that works somehow. Detected LS-120 drive (epat) and
>> even mounted the filesystem and copied files! The code is crap (missing error
>> handling, unclaim/dicconnect, unregister, oopses on reboot, etc.).
>>
>> The pata_parport_* functions are copied from libata-sff.c and modified not to
>> use ioread/iowrite. The pi_* functions are copied from paride.c and slightly
>> modified. The original paride protocol modules can register without any
>> changes.
> 
> Nice!
> 
>> I'm not sure about the device model integration (required by libata?).
>> It currently registers "pata_parport" bus with a "new_device" sysfs file
>> which is used to create new devices. I wonder if it's the correct way - it's
>> not possible to simply modprobe something with parameters to get a working
>> drive.
> 
> Not sure.  Maybe Damien as the new libata maintainer has any idea what
> to best do about that.

Well, that is a first, no other driver define their own bus :)
Given that new_device_store() gets the port, protocol, delay etc from
the user, I guess that there is no way to automatically probe the
parallel port adapter to find out what devices are on it ?

If yes, then I think this is fine. I cannot think of any other method to
do it, unless your platform uses a device tree file, in which case the
setup should be passed using that file (like so many other platform
ata/pata drivers do).

> 
>>
>> [  130.605256] paride: epat registered as protocol 0
>> [  132.363939] xxx: 0x378 is parport0
>> [  132.374746] xxx: epat: port 0x378, mode 0, ccr 0, test=(0,256,0)
>> [  132.374777] xxx: Sharing parport0 at 0x378
>> [  132.374918] xxx: epat 1.02, Shuttle EPAT chip c6 at 0x378,
>> [  132.374922] mode 0 (4-bit), delay 0
>> [  132.374950] pi_init ok!
>> [  132.377377] alloc_ok!
>> [  132.394447] scsi host4: pata_parport
>> [  132.394623] ata5: PATA max PIO0
>> [  132.613339] ata5.00: ATAPI: LS-120 COSM   04              UHD Floppy, 0270M09T, max PIO2
>> [  132.694550] scsi 4:0:0:0: Direct-Access     MATSHITA LS-120 COSM   04 0270 PQ: 0 ANSI: 5
>> [  132.729748] sd 4:0:0:0: Attached scsi generic sg1 type 0
>> [  132.760779] sd 4:0:0:0: [sdb] Media removed, stopped polling
>> [  132.792602] sd 4:0:0:0: [sdb] Attached SCSI removable disk
>> [  151.142037] sd 4:0:0:0: [sdb] Read Capacity(16) failed: Result: hostbyte=DID_ERROR driverbyte=DRIVER_OK
>> [  151.142090] sd 4:0:0:0: [sdb] Sense not available.
>> [  151.204874] sd 4:0:0:0: [sdb] 246528 512-byte logical blocks: (126 MB/120 MiB)
>> [  151.226471] sd 4:0:0:0: [sdb] Write Protect is on
>> [  151.226514] sd 4:0:0:0: [sdb] Mode Sense: 00 66 31 80
>> [  151.320880] sdb: detected capacity change from 0 to 246528
>> [  152.090211]  sdb:
>>
>> From ddfc09664e5800c57cda4908ccf1ba4db92e94c4 Mon Sep 17 00:00:00 2001
>> From: Ondrej Zary <linux@zary.sk>
>> Date: Sun, 30 Jan 2022 21:09:39 +0100
>> Subject: [PATCH] pata_parport: first preview
>>
>> ---
>>  drivers/ata/Kconfig        |   6 +
>>  drivers/ata/Makefile       |   2 +
>>  drivers/ata/pata_parport.c | 688 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 696 insertions(+)
>>  create mode 100644 drivers/ata/pata_parport.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index cb54631fd950..f2e130ff67d9 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -1161,6 +1161,12 @@ config PATA_WINBOND_VLB
>>  	  Support for the Winbond W83759A controller on Vesa Local Bus
>>  	  systems.
>>  
>> +config PATA_PARPORT
>> +	tristate "Parallel port IDE device support"
>> +	depends on PARPORT_PC
>> +	help
>> +	  Support for Parallel port IDE devices.
>> +
>>  comment "Generic fallback / legacy drivers"
>>  
>>  config PATA_ACPI
>> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
>> index b8aebfb14e82..77145834a585 100644
>> --- a/drivers/ata/Makefile
>> +++ b/drivers/ata/Makefile
>> @@ -114,6 +114,8 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
>>  
>>  obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
>>  
>> +obj-$(CONFIG_PATA_PARPORT)	+= pata_parport.o
>> +
>>  # Should be last but two libata driver
>>  obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
>>  # Should be last but one libata driver
>> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
>> new file mode 100644
>> index 000000000000..1edbbe9d9687
>> --- /dev/null
>> +++ b/drivers/ata/pata_parport.c
>> @@ -0,0 +1,688 @@
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/libata.h>
>> +#include <linux/parport.h>
>> +#include "paride.h"
>> +
>> +#define DRV_NAME "pata_parport"
>> +
>> +#define MAX_PROTOS	32
>> +static struct pi_protocol *protocols[MAX_PROTOS];
>> +
>> +static unsigned int pata_parport_devchk(struct ata_port *ap, unsigned int device)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +	u8 nsect, lbal;
>> +
>> +	ap->ops->sff_dev_select(ap, device);
>> +
>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
>> +
>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
>> +
>> +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
>> +	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
>> +
>> +	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
>> +	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
>> +
>> +	if ((nsect == 0x55) && (lbal == 0xaa))
>> +		return 1;	/* we found a device */
>> +
>> +	return 0;		/* nothing found */
>> +}
>> +
>> +static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
>> +				      unsigned long deadline)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +	/* software reset.  causes dev0 to be selected */
>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
>> +	udelay(20);	/* FIXME: flush */
>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
>> +	udelay(20);	/* FIXME: flush */
>> +	pi->proto->write_regr(pi, 1, 6, ap->ctl);
>> +	ap->last_ctl = ap->ctl;
>> +
>> +	/* wait the port to become ready */
>> +	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
>> +}
>> +
>> +int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
>> +			   unsigned long deadline)
>> +{
>> +	struct ata_port *ap = link->ap;
>> +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
>> +	unsigned int devmask = 0;
>> +	int rc;
>> +	u8 err;
>> +
>> +	/* determine if device 0/1 are present */
>> +	if (pata_parport_devchk(ap, 0))
>> +		devmask |= (1 << 0);
>> +	if (slave_possible && pata_parport_devchk(ap, 1))
>> +		devmask |= (1 << 1);
>> +
>> +	/* select device 0 again */
>> +	ap->ops->sff_dev_select(ap, 0);
>> +
>> +	/* issue bus reset */
>> +	rc = pata_parport_bus_softreset(ap, devmask, deadline);
>> +	/* if link is occupied, -ENODEV too is an error */
>> +	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
>> +		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	/* determine by signature whether we have ATA or ATAPI devices */
>> +	classes[0] = ata_sff_dev_classify(&link->device[0],
>> +					  devmask & (1 << 0), &err);
>> +	if (slave_possible && err != 0x81)
>> +		classes[1] = ata_sff_dev_classify(&link->device[1],
>> +						  devmask & (1 << 1), &err);
>> +
>> +	return 0;
>> +}
>> +
>> +u8 pata_parport_check_status(struct ata_port *ap)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +//	printk("%s\n", __FUNCTION__);
>> +	return pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
>> +}
>> +
>> +u8 pata_parport_check_altstatus(struct ata_port *ap)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +//	printk("%s\n", __FUNCTION__);
>> +	return pi->proto->read_regr(pi, 1, 6);
>> +}
>> +
>> +void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +	u8 tmp;
>> +//	printk("%s\n", __FUNCTION__);
>> +	if (device == 0)
>> +		tmp = ATA_DEVICE_OBS;
>> +	else
>> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
>> +
>> +	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
>> +	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
>> +}
>> +
>> +void pata_parport_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
>> +//	printk("%s\n", __FUNCTION__);
>> +	if (tf->ctl != ap->last_ctl) {
>> +		pi->proto->write_regr(pi, 1, 6, tf->ctl);
>> +		ap->last_ctl = tf->ctl;
>> +		ata_wait_idle(ap);
>> +	}
>> +
>> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
>> +		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->hob_feature);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->hob_nsect);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->hob_lbal);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->hob_lbam);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->hob_lbah);
>> +	}
>> +
>> +	if (is_addr) {
>> +		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->feature);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->nsect);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->lbal);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->lbam);
>> +		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->lbah);
>> +	}
>> +
>> +	if (tf->flags & ATA_TFLAG_DEVICE)
>> +		pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tf->device);
>> +
>> +	ata_wait_idle(ap);
>> +}
>> +
>> +void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +//	printk("%s\n", __FUNCTION__);
>> +	tf->command = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
>> +	tf->feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
>> +	tf->nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
>> +	tf->lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
>> +	tf->lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
>> +	tf->lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
>> +	tf->device = pi->proto->read_regr(pi, 0, ATA_REG_DEVICE);
>> +
>> +	if (tf->flags & ATA_TFLAG_LBA48) {
>> +		pi->proto->write_regr(pi, 1, 6, tf->ctl | ATA_HOB);
>> +		tf->hob_feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
>> +		tf->hob_nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
>> +		tf->hob_lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
>> +		tf->hob_lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
>> +		tf->hob_lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
>> +		pi->proto->write_regr(pi, 1, 6, tf->ctl);
>> +		ap->last_ctl = tf->ctl;
>> +	}
>> +}
>> +
>> +void pata_parport_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
>> +{
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +//	printk("%s\n", __FUNCTION__);
>> +	pi->proto->write_regr(pi, 0, ATA_REG_CMD, tf->command);
>> +	ata_sff_pause(ap);
>> +}
>> +
>> +unsigned int pata_parport_data_xfer(struct ata_queued_cmd *qc, unsigned char *buf,
>> +			       unsigned int buflen, int rw)
>> +{
>> +	struct ata_port *ap = qc->dev->link->ap;
>> +	struct pi_adapter *pi = ap->host->private_data;
>> +//	printk("%s\n", __FUNCTION__);
>> +	if (rw == READ)
>> +		pi->proto->read_block(pi, buf, buflen);
>> +	else
>> +		pi->proto->write_block(pi, buf, buflen);
>> +
>> +	return buflen;
>> +}
>> +
>> +void pata_parport_drain_fifo(struct ata_queued_cmd *qc)
>> +{
>> +	int count;
>> +	struct ata_port *ap;
>> +	struct pi_adapter *pi;
>> +	char junk[2];
>> +//	printk("%s\n", __FUNCTION__);
>> +	/* We only need to flush incoming data when a command was running */
>> +	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
>> +		return;
>> +
>> +	ap = qc->ap;
>> +	pi = ap->host->private_data;
>> +	/* Drain up to 64K of data before we give up this recovery method */
>> +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
>> +						&& count < 65536; count += 2)
>> +		pi->proto->read_block(pi, junk, 2);
>> +
>> +	if (count)
>> +		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
>> +
>> +}
>> +
>> +void pata_parport_lost_interrupt(struct ata_port *ap)
>> +{
>> +	u8 status;
>> +	struct ata_queued_cmd *qc;
>> +//	printk("%s\n", __FUNCTION__);
>> +	/* Only one outstanding command per SFF channel */
>> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
>> +	/* We cannot lose an interrupt on a non-existent or polled command */
>> +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
>> +		return;
>> +	/* See if the controller thinks it is still busy - if so the command
>> +	   isn't a lost IRQ but is still in progress */
>> +	status = pata_parport_check_altstatus(ap);
>> +	if (status & ATA_BUSY)
>> +		return;
>> +
>> +	/* There was a command running, we are no longer busy and we have
>> +	   no interrupt. */
>> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n",
>> +								status);
>> +	/* Run the host interrupt logic as if the interrupt had not been
>> +	   lost */
>> +	ata_sff_port_intr(ap, qc);
>> +}
>> +
>> +static struct ata_port_operations pata_parport_port_ops = {
>> +	.qc_prep		= ata_noop_qc_prep,
>> +	.qc_issue		= ata_sff_qc_issue,
>> +	.qc_fill_rtf		= ata_sff_qc_fill_rtf,
>> +
>> +	.freeze			= ata_sff_freeze,
>> +	.thaw			= ata_sff_thaw,
>> +	.prereset		= ata_sff_prereset,
>> +	.softreset		= pata_parport_softreset,
>> +	.postreset		= ata_sff_postreset,
>> +	.error_handler		= ata_sff_error_handler,
>> +	.sched_eh		= ata_std_sched_eh,
>> +	.end_eh			= ata_std_end_eh,
>> +
>> +	.sff_dev_select		= pata_parport_dev_select,
>> +	.sff_check_status	= pata_parport_check_status,
>> +	.sff_check_altstatus	= pata_parport_check_altstatus,
>> +	.sff_tf_load		= pata_parport_tf_load,
>> +	.sff_tf_read		= pata_parport_tf_read,
>> +	.sff_exec_command	= pata_parport_exec_command,
>> +	.sff_data_xfer		= pata_parport_data_xfer,
>> +	.sff_drain_fifo		= pata_parport_drain_fifo,
>> +
>> +	.lost_interrupt		= pata_parport_lost_interrupt,
>> +};
>> +
>> +static const struct ata_port_info pata_parport_port_info = {
>> +	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
>> +	.pio_mask	= ATA_PIO0,
>> +	/* No DMA */
>> +	.port_ops	= &pata_parport_port_ops,
>> +};
>> +
>> +int paride_register(struct pi_protocol *pr)
>> +{
>> +	int k;
>> +
>> +	for (k = 0; k < MAX_PROTOS; k++)
>> +		if (protocols[k] && !strcmp(pr->name, protocols[k]->name)) {
>> +			printk("paride: %s protocol already registered\n",
>> +			       pr->name);
>> +			return -1;
>> +		}
>> +	k = 0;
>> +	while ((k < MAX_PROTOS) && (protocols[k]))
>> +		k++;
>> +	if (k == MAX_PROTOS) {
>> +		printk("paride: protocol table full\n");
>> +		return -1;
>> +	}
>> +	protocols[k] = pr;
>> +	pr->index = k;
>> +	printk("paride: %s registered as protocol %d\n", pr->name, k);
>> +	return 0;
>> +}
>> +
>> +EXPORT_SYMBOL(paride_register);
>> +
>> +void paride_unregister(struct pi_protocol *pr)
>> +{
>> +	if (!pr)
>> +		return;
>> +	if (protocols[pr->index] != pr) {
>> +		printk("paride: %s not registered\n", pr->name);
>> +		return;
>> +	}
>> +	protocols[pr->index] = NULL;
>> +}
>> +
>> +EXPORT_SYMBOL(paride_unregister);
>> +
>> +
>> +
>> +static DEFINE_SPINLOCK(pi_spinlock);
>> +
>> +static void pi_wake_up(void *p)
>> +{
>> +	PIA *pi = (PIA *) p;
>> +	unsigned long flags;
>> +	void (*cont) (void) = NULL;
>> +
>> +	spin_lock_irqsave(&pi_spinlock, flags);
>> +
>> +	if (pi->claim_cont && !parport_claim(pi->pardev)) {
>> +		cont = pi->claim_cont;
>> +		pi->claim_cont = NULL;
>> +		pi->claimed = 1;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&pi_spinlock, flags);
>> +
>> +	wake_up(&(pi->parq));
>> +
>> +	if (cont)
>> +		cont();
>> +}
>> +
>> +static void pi_claim(PIA * pi)
>> +{
>> +	if (pi->claimed)
>> +		return;
>> +	pi->claimed = 1;
>> +	if (pi->pardev)
>> +		wait_event(pi->parq,
>> +			   !parport_claim((struct pardevice *) pi->pardev));
>> +}
>> +
>> +static void pi_unclaim(PIA * pi)
>> +{
>> +	pi->claimed = 0;
>> +	if (pi->pardev)
>> +		parport_release((struct pardevice *) (pi->pardev));
>> +}
>> +
>> +static void pi_unregister_parport(PIA * pi)
>> +{
>> +	if (pi->pardev) {
>> +		parport_unregister_device((struct pardevice *) (pi->pardev));
>> +		pi->pardev = NULL;
>> +	}
>> +}
>> +
>> +static int default_test_proto(PIA * pi, char *scratch, int verbose)
>> +{
>> +	int j, k;
>> +	int e[2] = { 0, 0 };
>> +
>> +	pi->proto->connect(pi);
>> +
>> +	for (j = 0; j < 2; j++) {
>> +		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
>> +		for (k = 0; k < 256; k++) {
>> +			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
>> +			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
>> +			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
>> +				e[j]++;
>> +		}
>> +	}
>> +	pi->proto->disconnect(pi);
>> +
>> +	if (verbose)
>> +		printk("%s: %s: port 0x%x, mode  %d, test=(%d,%d)\n",
>> +		       pi->device, pi->proto->name, pi->port,
>> +		       pi->mode, e[0], e[1]);
>> +
>> +	return (e[0] && e[1]);	/* not here if both > 0 */
>> +}
>> +
>> +static int pi_test_proto(PIA * pi, char *scratch, int verbose)
>> +{
>> +	int res;
>> +
>> +	pi_claim(pi);
>> +	if (pi->proto->test_proto)
>> +		res = pi->proto->test_proto(pi, scratch, verbose);
>> +	else
>> +		res = default_test_proto(pi, scratch, verbose);
>> +	pi_unclaim(pi);
>> +
>> +	return res;
>> +}
>> +
>> +static int pi_register_parport(PIA *pi, int verbose, int unit)
>> +{
>> +	struct parport *port;
>> +	struct pardev_cb par_cb;
>> +
>> +	port = parport_find_base(pi->port);
>> +	if (!port)
>> +		return 0;
>> +	memset(&par_cb, 0, sizeof(par_cb));
>> +	par_cb.wakeup = pi_wake_up;
>> +	par_cb.private = (void *)pi;
>> +	pi->pardev = parport_register_dev_model(port, pi->device, &par_cb,
>> +						unit);
>> +	parport_put_port(port);
>> +	if (!pi->pardev)
>> +		return 0;
>> +
>> +	init_waitqueue_head(&pi->parq);
>> +
>> +	if (verbose)
>> +		printk("%s: 0x%x is %s\n", pi->device, pi->port, port->name);
>> +
>> +	pi->parname = (char *) port->name;
>> +
>> +	return 1;
>> +}
>> +
>> +static int pi_probe_mode(PIA * pi, int max, char *scratch, int verbose)
>> +{
>> +	int best, range;
>> +
>> +	if (pi->mode != -1) {
>> +		if (pi->mode >= max)
>> +			return 0;
>> +		range = 3;
>> +		if (pi->mode >= pi->proto->epp_first)
>> +			range = 8;
>> +		if ((range == 8) && (pi->port % 8))
>> +			return 0;
>> +		pi->reserved = range;
>> +		return (!pi_test_proto(pi, scratch, verbose));
>> +	}
>> +	best = -1;
>> +	for (pi->mode = 0; pi->mode < max; pi->mode++) {
>> +		range = 3;
>> +		if (pi->mode >= pi->proto->epp_first)
>> +			range = 8;
>> +		if ((range == 8) && (pi->port % 8))
>> +			break;
>> +		pi->reserved = range;
>> +		if (!pi_test_proto(pi, scratch, verbose))
>> +			best = pi->mode;
>> +	}
>> +	pi->mode = best;
>> +	return (best > -1);
>> +}
>> +
>> +
>> +static int pi_probe_unit(PIA * pi, int unit, char *scratch, int verbose)
>> +{
>> +	int max, s, e;
>> +
>> +	s = unit;
>> +	e = s + 1;
>> +
>> +	if (s == -1) {
>> +		s = 0;
>> +		e = pi->proto->max_units;
>> +	}
>> +
>> +	if (!pi_register_parport(pi, verbose, s))
>> +		return 0;
>> +
>> +	if (pi->proto->test_port) {
>> +		pi_claim(pi);
>> +		max = pi->proto->test_port(pi);
>> +		pi_unclaim(pi);
>> +	} else
>> +		max = pi->proto->max_mode;
>> +
>> +	if (pi->proto->probe_unit) {
>> +		pi_claim(pi);
>> +		for (pi->unit = s; pi->unit < e; pi->unit++)
>> +			if (pi->proto->probe_unit(pi)) {
>> +				pi_unclaim(pi);
>> +				if (pi_probe_mode(pi, max, scratch, verbose))
>> +					return 1;
>> +				pi_unregister_parport(pi);
>> +				return 0;
>> +			}
>> +		pi_unclaim(pi);
>> +		pi_unregister_parport(pi);
>> +		return 0;
>> +	}
>> +
>> +	if (!pi_probe_mode(pi, max, scratch, verbose)) {
>> +		pi_unregister_parport(pi);
>> +		return 0;
>> +	}
>> +	return 1;
>> +
>> +}
>> +
>> +int pi_init(PIA * pi, int autoprobe, int port, int mode,
>> +	int unit, int protocol, int delay, char *scratch,
>> +	int devtype, int verbose, char *device)
>> +{
>> +	int p, k, s, e;
>> +	int lpts[7] = { 0x3bc, 0x378, 0x278, 0x268, 0x27c, 0x26c, 0 };
>> +
>> +	s = protocol;
>> +	e = s + 1;
>> +
>> +	if (!protocols[0])
>> +		request_module("paride_protocol");
>> +
>> +	if (autoprobe) {
>> +		s = 0;
>> +		e = MAX_PROTOS;
>> +	} else if ((s < 0) || (s >= MAX_PROTOS) || (port <= 0) ||
>> +		   (!protocols[s]) || (unit < 0) ||
>> +		   (unit >= protocols[s]->max_units)) {
>> +		printk("%s: Invalid parameters\n", device);
>> +		return 0;
>> +	}
>> +
>> +	for (p = s; p < e; p++) {
>> +		struct pi_protocol *proto = protocols[p];
>> +		if (!proto)
>> +			continue;
>> +		/* still racy */
>> +		if (!try_module_get(proto->owner))
>> +			continue;
>> +		pi->proto = proto;
>> +		pi->private = 0;
>> +		if (proto->init_proto && proto->init_proto(pi) < 0) {
>> +			pi->proto = NULL;
>> +			module_put(proto->owner);
>> +			continue;
>> +		}
>> +		if (delay == -1)
>> +			pi->delay = pi->proto->default_delay;
>> +		else
>> +			pi->delay = delay;
>> +		pi->devtype = devtype;
>> +		pi->device = device;
>> +
>> +		pi->parname = NULL;
>> +		pi->pardev = NULL;
>> +		init_waitqueue_head(&pi->parq);
>> +		pi->claimed = 0;
>> +		pi->claim_cont = NULL;
>> +
>> +		pi->mode = mode;
>> +		if (port != -1) {
>> +			pi->port = port;
>> +			if (pi_probe_unit(pi, unit, scratch, verbose))
>> +				break;
>> +			pi->port = 0;
>> +		} else {
>> +			k = 0;
>> +			while ((pi->port = lpts[k++]))
>> +				if (pi_probe_unit
>> +				    (pi, unit, scratch, verbose))
>> +					break;
>> +			if (pi->port)
>> +				break;
>> +		}
>> +		if (pi->proto->release_proto)
>> +			pi->proto->release_proto(pi);
>> +		module_put(proto->owner);
>> +	}
>> +
>> +	if (!pi->port) {
>> +		if (autoprobe)
>> +			printk("%s: Autoprobe failed\n", device);
>> +		else
>> +			printk("%s: Adapter not found\n", device);
>> +		return 0;
>> +	}
>> +
>> +	if (pi->parname)
>> +		printk("%s: Sharing %s at 0x%x\n", pi->device,
>> +		       pi->parname, pi->port);
>> +
>> +	pi->proto->log_adapter(pi, scratch, verbose);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct scsi_host_template pata_parport_sht = {
>> +	ATA_PIO_SHT(DRV_NAME),
>> +};
>> +
>> +static ssize_t new_device_store(struct bus_type *bus, const char *buf, size_t count)
>> +{
>> +	struct pi_adapter *pi;
>> +	int retval;
>> +	int autoprobe, port, mode, unit, protocol, delay;
>> +	int fields = 0;
>> +	struct device dev;
>> +	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
>> +	struct ata_host *host;
>> +	char scratch[512];
>> +
>> +	fields = sscanf(buf, "%x %d %d %d %d",
>> +			&port, &mode, &unit, &protocol, &delay);
>> +	if (fields < 5)
>> +		return -EINVAL;
>> +
>> +	memset(&dev, 0, sizeof(dev));
>> +	dev.parent = bus->dev_root;
>> +	dev.bus = bus;
>> +	dev_set_name(&dev, "pata_parport%d", 0);////
>> +	retval = device_register(&dev);
>> +	if (retval) {
>> +		printk("register failed\n");
>> +		return retval;
>> +	}
>> +
>> +	pi = devm_kzalloc(&dev, sizeof(struct pi_adapter), GFP_KERNEL);
>> +	if (!pi) {
>> +		//device_unregister
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (!pi_init(pi, autoprobe, port, mode, unit, protocol, delay, scratch, PI_PD, 2, "xxx"))
>> +		return -ENODEV;
>> +
>> +	printk("pi_init ok!\n");
>> +	pi_claim(pi);
>> +	pi->proto->connect(pi);
>> +	host = ata_host_alloc_pinfo(&dev, ppi, 1);
>> +	if (!host) {
>> +		/* pi_deinit??? */
>> +		return -ENOMEM;
>> +	}
>> +	host->private_data = pi;
>> +	printk("alloc_ok!\n");
>> +	if (ata_host_activate(host, 0, NULL, 0, &pata_parport_sht)) {
>> +		/* dealloc, pi_deinit??? */
>> +		return -EIO;
>> +	}
>> +
>> +	return count;
>> +}
>> +static BUS_ATTR_WO(new_device);
>> +
>> +static struct bus_type pata_parport_bus = {
>> +	.name = "pata_parport",
>> +};
>> +
>> +static __init int pata_parport_init(void)
>> +{
>> +	int error;
>> +
>> +	error = bus_register(&pata_parport_bus);
>> +	if (error) {
>> +		pr_err("failed to register pata_parport bus, error: %d\n", error);
>> +		return error;
>> +	}
>> +	error = bus_create_file(&pata_parport_bus, &bus_attr_new_device);
>> +	if (error) {
>> +		pr_err("unable to create sysfs file, error: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static __exit void pata_parport_exit(void)
>> +{
>> +	bus_remove_file(&pata_parport_bus, &bus_attr_new_device);
>> +	bus_unregister(&pata_parport_bus);
>> +}
>> +
>> +MODULE_AUTHOR("Ondrej Zary");
>> +MODULE_DESCRIPTION("driver for parallel port ATA adapters");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("paride");
>> +
>> +module_init(pata_parport_init);
>> +module_exit(pata_parport_exit);
>> -- 
>> Ondrej Zary
> ---end quoted text---
> 


-- 
Damien Le Moal
Western Digital Research
