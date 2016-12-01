Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] block: Check partition alignment on zoned block devices
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <44f7d36a-3212-4f2b-2031-d601efdc06c3@wdc.com>
Date: Wed, 30 Nov 2016 20:59:29 -0700
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
Message-Id: <85602042-E754-4347-A2B1-BAF54EDFCD0B@kernel.dk>
References: <1480551735-9288-1-git-send-email-damien.lemoal@wdc.com> <08af33a8-8705-788f-3b7e-e88eccbc71e4@kernel.dk> <778a9799-fed0-3337-e186-2a761cafa0aa@wdc.com> <3d13eadc-f7f7-3598-f4eb-880c5564301f@kernel.dk> <44f7d36a-3212-4f2b-2031-d601efdc06c3@wdc.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>


> On Nov 30, 2016, at 8:42 PM, Damien Le Moal <damien.lemoal@wdc.com> wrote:
> 
> 
> Jens,
> 
> On 12/1/16 12:03, Jens Axboe wrote:
>>> Martin, Shaun and myself agreed on the restriction. All ZBC/ZAC disks on
>>> the market today match these so there are no problems. And it is
>>> unlikely that we will ever see weirdly sized SMR drives (customers
>>> generally do not want that).
>> 
>> I'm fine with that, my only concern is that part_zone_aligned() assumes
>> this, and it's a bit fragile. If we remove the power-of-2 restriction.
>> Not sure what the best way to fix it is. Ideally it'd have a
>> WARN_ON_ONCE() and a fallback to a modulo calculation instead of the
>> AND.
> 
> I can have a crack at it. Should I resubmit a new version ?

That'd be great, thanks. 
