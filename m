Return-Path: <BATV+571d1a5c9d9a9c8ae375+5072+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 13 Jul 2017 00:12:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: linux-next scsi-mq hang in suspend-resume
Message-ID: <20170713071220.GA19972@infradead.org>
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 12, 2017 at 10:50:19AM -0600, Jens Axboe wrote:
> On 07/12/2017 08:51 AM, Tomi Sarvela wrote:
> > Hello there,
> > 
> > I've been running Intel GFX CI testing for linux DRM-Tip i915 driver, 
> > and couple of weeks ago we took linux-next for a ride to see what kind 
> > of integration problems there might pop up when pulling 4.13-rc1. 
> > Latest results can be seen at
> > 
> > https://intel-gfx-ci.01.org/CI/next-issues.html
> > https://intel-gfx-ci.01.org/CI/next-all.html
> > 
> > The purple blocks are hangs, starting from 20170628 (20170627 was 
> > untestable due to locking changes which were reverted). Traces were 
> > pointing to ext4 but bisecting between good 20170626 and bad 20170628 
> > pointed to:
> > 
> > commit 5c279bd9e40624f4ab6e688671026d6005b066fa
> > Date:   Fri Jun 16 10:27:55 2017 +0200
> > 
> >     scsi: default to scsi-mq
> > 
> > Reproduction is 100% or close to it when running two i-g-t tests as a 
> > testlist. I'm assuming that it creates the correct amount or pattern 
> > of actions to the device. The testlist consists of the following 
> > lines:
> > 
> > igt@gem_exec_gttfill@basic
> > igt@gem_exec_suspend@basic-s3
> > 
> > Kernel option scsi_mod.use_blk_mq=0 hides the issue on testhosts. 
> > Configuration option was copied over on testhosts and 20170712 was re-
> > tested, that's why today looks so much greener.
> > 
> > More information including traces and reproduction instructions at
> > https://bugzilla.kernel.org/show_bug.cgi?id=196223
> > 
> > I can run patchsets through the farm, if needed. In addition, daily 
> > linux-next tags are automatically tested and results published.
> 
> Christoph, any ideas? Smells like something in SCSI, my notebook
> with nvme/blk-mq suspend/resumes just fine.

There isn't much mq-specific scsi code, so it's probably an interaction
of both.  I'll see if the bugzilla has enough data to reproduce it
locally.

Although I really wish people wouldn't use #TY^$Y^$ bugzilla and just
post the important data to the list :(

> 
> -- 
> Jens Axboe
> 
---end quoted text---
