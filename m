Return-Path: <tomi.p.sarvela@intel.com>
Subject: Re: linux-next scsi-mq hang in suspend-resume
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
 <20170713071220.GA19972@infradead.org> <20170714124424.GA28150@infradead.org>
 <d455b080-13ff-af9c-c793-7a47356fee6f@intel.com>
 <20170717075341.GA19733@infradead.org>
From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Message-ID: <6831a724-3b4b-be48-c561-8fd1e8c7ebe0@intel.com>
Date: Mon, 17 Jul 2017 13:30:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170717075341.GA19733@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 17/07/17 10:53, Christoph Hellwig wrote:
> I still haven't gotten hold of an i915 machine where I could
> run the actua ltest suite.
> 
> But I did some audit of the code, and it seems blk-mq is lacking
> support for the RQF_PM flag.  While I can't directly see how
> this would cause the hang your caused it's a least easy to test.
> 
> Can you apply the patch below and test with the use_blk_mq=0 parameter?
> 
> Note that implementing RQF_PM for blk-mq shouldn't be too hard either,
> but if we don't get rid of the nr_pending counter somehow it would
> be a severe performance penalty for all scsi devices.

First, tested that next-20170717 still triggers the problem when no 
extra options given. Adding scsi_mod.use_blk_mq=0 makes tests work.

Then I tried with sd.diff patched next-20170717. Works (still) with 
use_blk_mq=0. Also works when no options given, so this patch avoids the 
hang when using the new block-mq.

These tests on generic Haswell 4790K desktop machine.

Best regards,

Tomi
-- 
Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
