Return-Path: <BATV+0dcb2ced70f4a2e24250+5076+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 17 Jul 2017 03:35:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tomi Sarvela <tomi.p.sarvela@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: linux-next scsi-mq hang in suspend-resume
Message-ID: <20170717103519.GA13473@infradead.org>
References: <21128504.iYAzanzLsA@fractal.fi.intel.com>
 <dd9daa92-0c9c-51dd-95b5-961cfd1fca36@kernel.dk>
 <20170713071220.GA19972@infradead.org>
 <20170714124424.GA28150@infradead.org>
 <d455b080-13ff-af9c-c793-7a47356fee6f@intel.com>
 <20170717075341.GA19733@infradead.org>
 <6831a724-3b4b-be48-c561-8fd1e8c7ebe0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6831a724-3b4b-be48-c561-8fd1e8c7ebe0@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 17, 2017 at 01:30:00PM +0300, Tomi Sarvela wrote:
> First, tested that next-20170717 still triggers the problem when no extra
> options given. Adding scsi_mod.use_blk_mq=0 makes tests work.
> 
> Then I tried with sd.diff patched next-20170717. Works (still) with
> use_blk_mq=0. Also works when no options given, so this patch avoids the
> hang when using the new block-mq.
> 
> These tests on generic Haswell 4790K desktop machine.

Thanks Tomi,

this seems to confirm it's runtime PM related, although I don't
really understand why that's an issue.  Let me spin up an implementation
of RQF_PM for blk-mq and give it to you for testing.
