Return-Path: <regressions@leemhuis.info>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: dedekind1@gmail.com, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <ff7c4fd9-1685-05b9-8082-676aa4ae921d@leemhuis.info>
Date: Mon, 26 Mar 2018 10:39:25 +0200
MIME-Version: 1.0
In-Reply-To: <1520515113.20980.31.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Lo! Your friendly Linux regression tracker here ;-)

On 08.03.2018 14:18, Artem Bityutskiy wrote:
> On Thu, 2018-03-08 at 18:53 +0800, Ming Lei wrote:
>> This patchset tries to spread among online CPUs as far as possible, so
>> that we can avoid to allocate too less irq vectors with online CPUs
>> mapped.
> […] 
> Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com
> 
> this patchset fixes the v4.16-rcX regression that I reported few weeks
> ago. I applied it and verified that Dell R640 server that I mentioned
> in the bug report boots up and the disk works.

Artem (or anyone else), what's the status here? I have this on my list
of regressions, but it looks like there wasn't any progress in the past
week. Or was it discussed somewhere else or even fixed in the meantime
and I missed it? Ciao, Thorsten
