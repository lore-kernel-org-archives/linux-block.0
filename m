Return-Path: <prvs=833356afc=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Masato Suzuki <masato.suzuki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] null_blk: Add conventional zone configuration for zoned
 support
Date: Mon, 29 Oct 2018 08:27:09 +0000
Message-ID: 
 <BN3PR0401MB164007F504B1DB8C510F774EE7F30@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181022112503.4804-1-masato.suzuki@wdc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/22 20:25, Masato Suzuki wrote:=0A=
> Allow the creation of conventional zones by adding the nr_conv_zones=0A=
> configuration attribute. This new attribute is used only for zoned device=
s and=0A=
> indicates the number of conventional zones to create. The default value i=
s 0.=0A=
> Since host-managed zoned block devices must always have at least one sequ=
ential=0A=
> zone, if the value of nr_conv_zones is larger than or equal to the total =
number=0A=
> of zones of the device nr_zones, nr_conv_zones is automatically changed t=
o=0A=
> nr_zones - 1.=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
