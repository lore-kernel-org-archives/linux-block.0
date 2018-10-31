Return-Path: <prvs=835c55f1f=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Masato Suzuki <masato.suzuki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH v2] null_blk: Add conventional zone configuration for
 zoned support
Date: Wed, 31 Oct 2018 01:20:42 +0000
Message-ID: 
 <BN3PR0401MB16406E40E854114A41CB6995E7CD0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181030071405.20518-1-masato.suzuki@wdc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/30 16:14, Masato Suzuki wrote:=0A=
> Allow the creation of conventional zones by adding the zone_nr_conv=0A=
> configuration attribute. This new attribute is used only for zoned device=
s=0A=
> and indicates the number of conventional zones to create. The default val=
ue=0A=
> is 0. Since host-managed zoned block devices must always have at least on=
e=0A=
> sequential zone, if the value of zone_nr_conv is larger than or equal to=
=0A=
> the total number of zones of the device nr_zones, zone_nr_conv is=0A=
> automatically changed to nr_zones - 1.=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
