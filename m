Return-Path: <ross.zwisler@linux.intel.com>
Date: Wed, 26 Jul 2017 15:32:14 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@fb.com,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] brd: fix brd_rw_page() vs copy_to_brd_setup errors
Message-ID: <20170726213214.GA25525@linux.intel.com>
References: <150103091559.7874.16803761117298861951.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170726201228.GA28444@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170726201228.GA28444@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 26, 2017 at 01:12:28PM -0700, Christoph Hellwig wrote:
> On Tue, Jul 25, 2017 at 06:02:29PM -0700, Dan Williams wrote:
> > As is done in zram_rw_page, pmem_rw_page, and btt_rw_page, don't
> > call page_endio in the error case since do_mpage_readpage and
> > __mpage_writepage will resubmit on error. Calling page_endio in the
> > error case leads to double completion.
> > 
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Matthew Wilcox <mawilcox@microsoft.com>
> > Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Noticed this while looking at unrelated brd code...
> 
> And the real question would be:  where would we see any real life impact
> of just removing brd_rw_page?

I've got patches ready that remove rw_page from brd, btt and pmem.  I'll send
out once I'm done regression testing.
