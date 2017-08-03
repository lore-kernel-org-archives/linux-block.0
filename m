Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Switching to MQ by default may generate some bug reports
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170803094242.wol67mmga3om4gjp@techsingularity.net>
Date: Thu, 3 Aug 2017 11:44:06 +0200
Cc: Ming Lei <tom.leiming@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
Message-Id: <DAC70C00-B51D-4752-8EA7-EA55368918EC@linaro.org>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com> <20170803094242.wol67mmga3om4gjp@techsingularity.net>
To: Mel Gorman <mgorman@techsingularity.net>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 03 ago 2017, alle ore 11:42, Mel Gorman =
<mgorman@techsingularity.net> ha scritto:
>=20
> On Thu, Aug 03, 2017 at 05:17:21PM +0800, Ming Lei wrote:
>> Hi Mel Gorman,
>>=20
>> On Thu, Aug 3, 2017 at 4:51 PM, Mel Gorman =
<mgorman@techsingularity.net> wrote:
>>> Hi Christoph,
>>>=20
>>> I know the reasons for switching to MQ by default but just be aware =
that it's
>>> not without hazards albeit it the biggest issues I've seen are =
switching
>>> CFQ to BFQ. On my home grid, there is some experimental automatic =
testing
>>> running every few weeks searching for regressions. Yesterday, it =
noticed
>>> that creating some work files for a postgres simulator called =
pgioperf
>>> was 38.33% slower and it auto-bisected to the switch to MQ. This is =
just
>>> linearly writing two files for testing on another benchmark and is =
not
>>> remarkable. The relevant part of the report is
>>=20
>> We saw some SCSI-MQ performance issue too, please see if the =
following
>> patchset fixes your issue:
>>=20
>> http://marc.info/?l=3Dlinux-block&m=3D150151989915776&w=3D2
>>=20
>=20
> That series is dealing with problems with legacy-deadline vs mq-none =
where
> as the bulk of the problems reported in this mail are related to
> legacy-CFQ vs mq-BFQ.
>=20

Out-of-curiosity: you get no regression with mq-none or mq-deadline?

Thanks,
Paolo

> --=20
> Mel Gorman
> SUSE Labs
