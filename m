Return-Path: <mgorman@techsingularity.net>
Date: Thu, 3 Aug 2017 10:42:43 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: Re: Switching to MQ by default may generate some bug reports
Message-ID: <20170803094242.wol67mmga3om4gjp@techsingularity.net>
References: <20170803085115.r2jfz2lofy5spfdb@techsingularity.net>
 <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <CACVXFVP3M64ebQQM-aaBs8-TKFqkgVCvO2TQbB6xLcp9_5Q3Sg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 03, 2017 at 05:17:21PM +0800, Ming Lei wrote:
> Hi Mel Gorman,
> 
> On Thu, Aug 3, 2017 at 4:51 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> > Hi Christoph,
> >
> > I know the reasons for switching to MQ by default but just be aware that it's
> > not without hazards albeit it the biggest issues I've seen are switching
> > CFQ to BFQ. On my home grid, there is some experimental automatic testing
> > running every few weeks searching for regressions. Yesterday, it noticed
> > that creating some work files for a postgres simulator called pgioperf
> > was 38.33% slower and it auto-bisected to the switch to MQ. This is just
> > linearly writing two files for testing on another benchmark and is not
> > remarkable. The relevant part of the report is
> 
> We saw some SCSI-MQ performance issue too, please see if the following
> patchset fixes your issue:
> 
> http://marc.info/?l=linux-block&m=150151989915776&w=2
> 

That series is dealing with problems with legacy-deadline vs mq-none where
as the bulk of the problems reported in this mail are related to
legacy-CFQ vs mq-BFQ.

-- 
Mel Gorman
SUSE Labs
