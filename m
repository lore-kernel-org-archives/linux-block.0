Return-Path: <linux-block-owner@vger.kernel.org>
Received: from lithops.sigma-star.at ([195.201.40.130]:33524 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbeGXJY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 05:24:27 -0400
From: Richard Weinberger <richard@nod.at>
To: Per Forlin <per.forlin@axis.com>, linux-block@vger.kernel.org
Cc: linux-mtd@lists.infradead.org,
        Artem Bityutskiy <dedekind1@gmail.com>, derosier@gmail.com,
        Per Forlin <perfn@axis.com>
Subject: Re: [PATCH v2] UBI: Add volume read and write statistics
Date: Tue, 24 Jul 2018 10:19:07 +0200
Message-ID: <1633152.d3eLNIHx7g@blindfold>
In-Reply-To: <1532360342-52055-1-git-send-email-perfn@axis.com>
References: <1532360342-52055-1-git-send-email-perfn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[Adding linux-block]

Am Montag, 23. Juli 2018, 17:39:02 CEST schrieb Per Forlin:
> Simple read and write statistics.
> * Number of reads
> * Number of writes
> * Bytes read
> * Bytes written
> 
> This is useful to find out how the storage is being utilized.
> For block devices this already exists here:
> /sys/class/block/<device>/stat
> 
> For UBI it now exists here:
> /sys/class/ubi/<volume>/stat

Please document it also in Documentation/ABI/stable/sysfs-class-ubi.

> Example:
> /sys/class/ubi/ubi0_21/stat
> 864 0 3106756 0 1057 0 2144256 0 0 0 0
> 
> The output format is same as for block devices
> except that not all metrics are supported yet.
> Unsupported values are set to 0.

Let's ask block folks what they think about.
Per, did you check, which tools use the stats file in /sys?
I checked iostat, it seems to consume only /proc/diskstats.

To give more context, UBI and MTD devices offer access to raw flash
storage. So, we have filesystems on top of it.
Since these devices are not block devices, almost no tool know
about these.
With this patch we'd like to offer a interface to userspace such that
tools will also discover UBI devices.
Maybe MTD devices later too.

> ---
> Changelog:
> 
> v2
> * Question: Translate bytes to sectors? iostats format expects sector unit.

Not sure. I'd wait for input from userspace and block folks.

> * Align with iostats format
> * Only count successful reads and writes
> 
>  drivers/mtd/ubi/eba.c | 11 ++++++++++-
>  drivers/mtd/ubi/ubi.h | 19 +++++++++++++++++++
>  drivers/mtd/ubi/vmt.c |  8 ++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
> index b98481b..c9a88b2 100644
> --- a/drivers/mtd/ubi/eba.c
> +++ b/drivers/mtd/ubi/eba.c
> @@ -731,6 +731,11 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
>  		}
>  	}
>  
> +	if (!err) {
> +		vol->stat.rcount++;
> +		vol->stat.rbytes += len;

Can we please have a helper function for that?

> +	}
> +
>  	if (scrub)
>  		err = ubi_wl_scrub_peb(ubi, pnum);
>  
> @@ -1091,8 +1096,12 @@ int ubi_eba_write_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
>  	ubi_free_vid_buf(vidb);
>  
>  out:
> -	if (err)
> +	if (err) {
>  		ubi_ro_mode(ubi);
> +	} else {
> +		vol->stat.wcount++;
> +		vol->stat.wbytes += len;

Same.

> +	}
>  
>  	leb_write_unlock(ubi, vol_id, lnum);
>  
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index f5ba97c..0cb00f0 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -293,6 +293,23 @@ struct ubi_eba_leb_desc {
>  };
>  
>  /**
> + * struct ubi_volume_stat - Volume statistics
> + * @rbytes: the number of bytes read
> + * @wbytes: the number of bytes written
> + * @rcount: the number of read requests
> + * @wcount: the number of write requests
> + *
> + * This structure contains read and write statistics.
> + *
> + */
> +struct ubi_volume_stat {
> +	u64 rbytes;
> +	u64 wbytes;
> +	u32 rcount;
> +	u32 wcount;

Does the wide of these integers also match with block devices?

Thanks,
//richard
