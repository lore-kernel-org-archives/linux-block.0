Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Add conventional zone configuration for zoned
 support
To: Matias Bjorling <Matias.Bjorling@wdc.com>,
 Masato Suzuki <masato.suzuki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20181022112503.4804-1-masato.suzuki@wdc.com>
 <6214367c-7f58-bdc1-f5b7-f4e4dca60813@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1caba871-ebc4-8b25-8a18-bbd7b2d77e14@kernel.dk>
Date: Mon, 29 Oct 2018 09:27:49 -0600
MIME-Version: 1.0
In-Reply-To: <6214367c-7f58-bdc1-f5b7-f4e4dca60813@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:11 AM, Matias Bjorling wrote:
> Looks good to me. One nitpick, might be better to rename the sysfs 
> attribute nr_conv_zones to zone_nr_conv or similar to keep the zone 
> attributes grouped together.

Yeah I agree, that's the only real way to inject some sanity into having
a growing number of sysfs attributes.

-- 
Jens Axboe
