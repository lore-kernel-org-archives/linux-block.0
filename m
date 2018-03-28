Return-Path: <dedekind1@gmail.com>
Message-ID: <1522217751.9730.80.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Thorsten Leemhuis <regressions@leemhuis.info>, Ming Lei
	 <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	 <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Date: Wed, 28 Mar 2018 09:15:51 +0300
In-Reply-To: <ff7c4fd9-1685-05b9-8082-676aa4ae921d@leemhuis.info>
References: <20180308105358.1506-1-ming.lei@redhat.com>
	 <1520515113.20980.31.camel@gmail.com>
	 <ff7c4fd9-1685-05b9-8082-676aa4ae921d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-03-26 at 10:39 +0200, Thorsten Leemhuis wrote:
> Lo! Your friendly Linux regression tracker here ;-)
> 
> On 08.03.2018 14:18, Artem Bityutskiy wrote:
> > On Thu, 2018-03-08 at 18:53 +0800, Ming Lei wrote:
> > > This patchset tries to spread among online CPUs as far as possible, so
> > > that we can avoid to allocate too less irq vectors with online CPUs
> > > mapped.
> > 
> > […] 
> > Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
> > Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com
> > 
> > this patchset fixes the v4.16-rcX regression that I reported few weeks
> > ago. I applied it and verified that Dell R640 server that I mentioned
> > in the bug report boots up and the disk works.
> 
> Artem (or anyone else), what's the status here? I have this on my list
> of regressions, but it looks like there wasn't any progress in the past
> week. Or was it discussed somewhere else or even fixed in the meantime
> and I missed it? Ciao, Thorsten

Hi, it is not fixed in upstream.

I got an e-mail from James that the fixes are in his tree in the
"fixes" branch. There is no word about when it will be merged. There is
also no stable tag.
