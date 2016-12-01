Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] block: Check partition alignment on zoned block
 devices
To: Jens Axboe <axboe@kernel.dk>
References: <1480551735-9288-1-git-send-email-damien.lemoal@wdc.com>
 <08af33a8-8705-788f-3b7e-e88eccbc71e4@kernel.dk>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <778a9799-fed0-3337-e186-2a761cafa0aa@wdc.com>
Date: Thu, 1 Dec 2016 11:38:15 +0900
MIME-Version: 1.0
In-Reply-To: <08af33a8-8705-788f-3b7e-e88eccbc71e4@kernel.dk>
Return-Path: damien.lemoal@wdc.com
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>


Jens,

On 12/1/16 10:40, Jens Axboe wrote:
> This looks better, thanks. Are the zone sizes mandated by spec to be a
> power-of-2?

No, the standards allow any zone size, and different sizes for the zones
too. However, the sd_zbc code down in the SCSI stack limits support to
HM & HA drives that have a power of 2 zone size, with all zones of the
same size, except for an eventual smaller last zone (Seagate drives have
that). This restriction was necessary so that limits.chunk_sectors can
be used to avoid BIO spawning zones.

See 89d9475610771b5e5fe1879075f0fc9ba6e3755f:

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
new file mode 100644
index 0000000..16d3fa6
--- /dev/null
+++ b/drivers/scsi/sd_zbc.c
@@ -0,0 +1,642 @@
+/*
+ * SCSI Zoned Block commands
...
+       if (!is_power_of_2(zone_blocks)) {
+               if (sdkp->first_scan)
+                       sd_printk(KERN_NOTICE, sdkp,
+                                 "Devices with non power of 2 zone "
+                                 "size are not supported\n");
+               return -ENODEV;
+       }
+

Martin, Shaun and myself agreed on the restriction. All ZBC/ZAC disks on
the market today match these so there are no problems. And it is
unlikely that we will ever see weirdly sized SMR drives (customers
generally do not want that).

Best regards.

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
