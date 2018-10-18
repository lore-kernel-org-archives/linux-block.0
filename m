Return-Path: <prvs=822a4a090=Avri.Altman@wdc.com>
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Avi Shchislowski <Avi.Shchislowski@wdc.com>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: Re: [PATCH] block: Make write_hints[] big enough
Date: Thu, 18 Oct 2018 19:44:34 +0000
Message-ID: 
 <SN6PR04MB49256CE1F1766351120DD581FCF80@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

>>> Your commit message doesn't really explain what you think the issue
>>> is. We have 4 write hint types, with a fifth being "none". Where
>>> are we exceeding these 5 hints?
>> WRITE_LIFE_EXTREME =3D RWH_WRITE_LIFE_EXTREME =3D 5,
>> will be ignored by queue_write_hint_{show_store}.

>Hmm, wonder how that got broken. But we should just bundle NONE
>and NOT_SET, since they end up in the same bucket on the
>driver side. Making the array larger is not necessary, we
>only have effectively 5 hints.
Done.

Thanks,
Avri

>--
>Jens Axboe
