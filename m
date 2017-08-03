Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170803104759.h2e5ubgh3zk2ucco@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
 <20170803094242.wol67mmga3om4gjp@techsingularity.net> <CACVXFVMdQHgAkc8yZW7tE=2_6mrB=t6-eHeBT_KUWqcMz+_MtA@mail.gmail.com>
 <20170803104759.h2e5ubgh3zk2ucco@techsingularity.net>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 3 Aug 2017 19:48:44 +0800
Message-ID: <CACVXFVNC7cbk7kv6NbfJ3WdCWLUaGsnH59k=88GqjL9AjM8YZg@mail.gmail.com>
Subject: Re: Switching to MQ by default may generate some bug reports
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 3, 2017 at 6:47 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Thu, Aug 03, 2017 at 05:57:50PM +0800, Ming Lei wrote:
>> On Thu, Aug 3, 2017 at 5:42 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
>> > On Thu, Aug 03, 2017 at 05:17:21PM +0800, Ming Lei wrote:
>> >> Hi Mel Gorman,
>> >>
>> >> On Thu, Aug 3, 2017 at 4:51 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
>> >> > Hi Christoph,
>> >> >
>> >> > I know the reasons for switching to MQ by default but just be aware that it's
>> >> > not without hazards albeit it the biggest issues I've seen are switching
>> >> > CFQ to BFQ. On my home grid, there is some experimental automatic testing
>> >> > running every few weeks searching for regressions. Yesterday, it noticed
>> >> > that creating some work files for a postgres simulator called pgioperf
>> >> > was 38.33% slower and it auto-bisected to the switch to MQ. This is just
>> >> > linearly writing two files for testing on another benchmark and is not
>> >> > remarkable. The relevant part of the report is
>> >>
>> >> We saw some SCSI-MQ performance issue too, please see if the following
>> >> patchset fixes your issue:
>> >>
>> >> http://marc.info/?l=linux-block&m=150151989915776&w=2
>> >>
>> >
>> > That series is dealing with problems with legacy-deadline vs mq-none where
>> > as the bulk of the problems reported in this mail are related to
>> > legacy-CFQ vs mq-BFQ.
>>
>> The serials deals with none and all mq schedulers, and you can see
>> the improvement on mq-deadline in cover letter, :-)
>>
>
> Would it be expected to fix a 2x to 4x slowdown as experienced by BFQ
> that was not observed on other schedulers?

Actually if you look at the cover letter, you will see this patchset
increases by
> 10X sequential I/O IOPS on mq-deadline, so it would be reasonable to see
2x to 4x BFQ slowdown, but I didn't test BFQ.

Thanks,
Ming Lei
