Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Check partition alignment on zoned block
 devices
To: Damien Le Moal <damien.lemoal@wdc.com>
References: <1480551735-9288-1-git-send-email-damien.lemoal@wdc.com>
 <08af33a8-8705-788f-3b7e-e88eccbc71e4@kernel.dk>
 <778a9799-fed0-3337-e186-2a761cafa0aa@wdc.com>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3d13eadc-f7f7-3598-f4eb-880c5564301f@kernel.dk>
Date: Wed, 30 Nov 2016 20:03:28 -0700
MIME-Version: 1.0
In-Reply-To: <778a9799-fed0-3337-e186-2a761cafa0aa@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 11/30/2016 07:38 PM, Damien Le Moal wrote:
> 
> Jens,
> 
> On 12/1/16 10:40, Jens Axboe wrote:
>> This looks better, thanks. Are the zone sizes mandated by spec to be a
>> power-of-2?
> 
> No, the standards allow any zone size, and different sizes for the zones
> too. However, the sd_zbc code down in the SCSI stack limits support to
> HM & HA drives that have a power of 2 zone size, with all zones of the
> same size, except for an eventual smaller last zone (Seagate drives have
> that). This restriction was necessary so that limits.chunk_sectors can
> be used to avoid BIO spawning zones.
> 
> See 89d9475610771b5e5fe1879075f0fc9ba6e3755f:
> 
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> new file mode 100644
> index 0000000..16d3fa6
> --- /dev/null
> +++ b/drivers/scsi/sd_zbc.c
> @@ -0,0 +1,642 @@
> +/*
> + * SCSI Zoned Block commands
> ...
> +       if (!is_power_of_2(zone_blocks)) {
> +               if (sdkp->first_scan)
> +                       sd_printk(KERN_NOTICE, sdkp,
> +                                 "Devices with non power of 2 zone "
> +                                 "size are not supported\n");
> +               return -ENODEV;
> +       }
> +
> 
> Martin, Shaun and myself agreed on the restriction. All ZBC/ZAC disks on
> the market today match these so there are no problems. And it is
> unlikely that we will ever see weirdly sized SMR drives (customers
> generally do not want that).

I'm fine with that, my only concern is that part_zone_aligned() assumes
this, and it's a bit fragile. If we remove the power-of-2 restriction.
Not sure what the best way to fix it is. Ideally it'd have a
WARN_ON_ONCE() and a fallback to a modulo calculation instead of the
AND.

-- 
Jens Axboe
