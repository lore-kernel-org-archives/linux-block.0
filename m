Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net> <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 3 Aug 2017 17:32:48 +0800
Message-ID: <CACVXFVOPvD+DMT8dXHPG4cVAf4Dhj7nXEnzhqu11sN3m2PxO3Q@mail.gmail.com>
Subject: Re: Switching to MQ by default may generate some bug reports
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>,
	Paolo Valente <paolo.valente@linaro.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 3, 2017 at 5:17 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi Mel Gorman,
>
> On Thu, Aug 3, 2017 at 4:51 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
>> Hi Christoph,
>>
>> I know the reasons for switching to MQ by default but just be aware that it's
>> not without hazards albeit it the biggest issues I've seen are switching
>> CFQ to BFQ. On my home grid, there is some experimental automatic testing
>> running every few weeks searching for regressions. Yesterday, it noticed
>> that creating some work files for a postgres simulator called pgioperf
>> was 38.33% slower and it auto-bisected to the switch to MQ. This is just
>> linearly writing two files for testing on another benchmark and is not
>> remarkable. The relevant part of the report is
>
> We saw some SCSI-MQ performance issue too, please see if the following
> patchset fixes your issue:
>
> http://marc.info/?l=linux-block&m=150151989915776&w=2

BTW, the above patches(V1) can be found in the following tree:

      https://github.com/ming1/linux/commits/blk-mq-dispatch_for_scsi.V1

V2 has already been done but not posted out yet, because the performance test
on SRP isn't completed:

      https://github.com/ming1/linux/commits/blk-mq-dispatch_for_scsi.V2


Thanks,
Ming Lei
