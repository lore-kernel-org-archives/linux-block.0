Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] null_blk: Add conventional zone configuration for
 zoned support
To: Masato Suzuki <masato.suzuki@wdc.com>, linux-block@vger.kernel.org
Cc: Matias.Bjorling@wdc.com, Damien.LeMoal@wdc.com
References: <20181030071405.20518-1-masato.suzuki@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad1881bc-6259-fd8b-a0f0-ad98ccea2484@kernel.dk>
Date: Wed, 31 Oct 2018 08:47:00 -0600
MIME-Version: 1.0
In-Reply-To: <20181030071405.20518-1-masato.suzuki@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 1:14 AM, Masato Suzuki wrote:
> Allow the creation of conventional zones by adding the zone_nr_conv
> configuration attribute. This new attribute is used only for zoned devices
> and indicates the number of conventional zones to create. The default value
> is 0. Since host-managed zoned block devices must always have at least one
> sequential zone, if the value of zone_nr_conv is larger than or equal to
> the total number of zones of the device nr_zones, zone_nr_conv is
> automatically changed to nr_zones - 1.

Looks good to me, I'll queue this up for 4.21.

-- 
Jens Axboe
