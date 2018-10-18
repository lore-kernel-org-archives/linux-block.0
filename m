Return-Path: <prvs=822a4a090=Avri.Altman@wdc.com>
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: Avi Shchislowski <Avi.Shchislowski@wdc.com>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: Re: [PATCH] block: Make write_hints[] big enough
Date: Thu, 18 Oct 2018 19:44:24 +0000
Message-ID: 
 <SN6PR04MB49258E38E6488FC99448A4CDFCF80@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1539795081-2394-1-git-send-email-avri.altman@wdc.com>
 <28ec8613-09c2-b82d-48da-7750e8ff144c@kernel.dk>
 <SN6PR04MB49250FD0D86034147B72DB66FCF80@SN6PR04MB4925.namprd04.prod.outlook.com>,<c4b59c1d-dfa8-a3dd-4902-1aceb1abe876@kernel.dk>
In-Reply-To: <c4b59c1d-dfa8-a3dd-4902-1aceb1abe876@kernel.dk>
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
