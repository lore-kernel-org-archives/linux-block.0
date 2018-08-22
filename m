Return-Path: <ming.lei@redhat.com>
Date: Wed, 22 Aug 2018 16:06:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: SDHCI Regression with 6ce3dd6eec11 ("blk-mq: issue directly if
 hw queue isn't busy in case of 'none'")
Message-ID: <20180822080556.GA31467@ming.t460p>
References: <855d68f2-17ed-eaae-2f13-d0ff95b6834f@linux.intel.com>
 <2f4d5335-15dd-1dea-5d80-36b79455577a@intel.com>
 <fec7b30c-6cfe-b419-1e2a-d81a3ff6d9fa@linux.intel.com>
 <20180821135725.GA28835@ming.t460p>
 <741127be-7d37-695c-15a9-47186959e639@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <741127be-7d37-695c-15a9-47186959e639@linux.intel.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 22, 2018 at 09:06:40AM +0300, Jarkko Nikula wrote:
> On 08/21/2018 04:57 PM, Ming Lei wrote:
> > On Tue, Aug 21, 2018 at 04:45:41PM +0300, Jarkko Nikula wrote:
> > > On 08/21/2018 04:03 PM, Adrian Hunter wrote:
> > > > On 21/08/18 15:37, Jarkko Nikula wrote:
> > > > > Hi
> > > > > 
> > > > > I bisected some kind of SDHCI regression to commit 6ce3dd6eec11 ("blk-mq:
> > > > > issue directly if hw queue isn't busy in case of 'none'") causing dumps
> > > > > below and one or more systemd-udevd processes being in uninterruptible sleep
> > > > > state preventing safe reboot/shutdown.
> > > > > 
> > > > > This is from an Intel Baytrail based tablet with integrated eMMC but my
> > > > > up-to-date Debian/testing rootfs (with systemd) is on USB stick.
> > > > > 
> > > > > It doesn't revert cleanly on today's head 778a33959a8a but issue is gone if
> > > > > I go to a commit before 6ce3dd6eec11 and occurs at 6ce3dd6eec11.
> > > > 
> > > > This was discussed here:
> > > > 
> > > > 	https://marc.info/?l=linux-block&m=153334717506073&w=2
> > > > 
> > > > Coincidentally, I just sent the fix patch:
> > > > 
> > > > 	https://marc.info/?l=linux-mmc&m=153485326025301&w=2
> > > > 
> > > Cool, it fixed my regression. I tested both on top of 6ce3dd6eec11 and head
> > > 778a33959a8a. Maybe you would like to add into your patch another fixes tag
> > > and my tested by:
> > > 
> > > Fixes: 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case
> > > of 'none'")
> > 
> > If you read the above links carefully, you'd see it is wrong to add the tag of
> > 'Fixes: 6ce3dd6eec11'.
> > 
> Hmm... why? That commit 6ce3dd6eec11 was clearly regressing on my setup
> while Adrian's fix for 81196976ed94 that has been present since v4.16 fixes
> my finding too.
> 
> I don't know well enough MMC and block layer but if commit 6ce3dd6eec11
> revealed an issue from MMC under my configuration I'd call it still a
> regression.

6ce3dd6eec11 just makes the original issue to happen easier, and the
root cause is that MMC's stack doesn't support concurrent dispatch for 
SDHCI.

Thanks, 
Ming
