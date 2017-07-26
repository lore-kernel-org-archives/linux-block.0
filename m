Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170726213214.GA25525@linux.intel.com>
References: <150103091559.7874.16803761117298861951.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170726201228.GA28444@infradead.org> <20170726213214.GA25525@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Jul 2017 14:42:58 -0700
Message-ID: <CAPcyv4hyKU4X6OVVn2weKz8h-7v0FKXuxt5MTesDVjzdrg1M9Q@mail.gmail.com>
Subject: Re: [PATCH] brd: fix brd_rw_page() vs copy_to_brd_setup errors
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 26, 2017 at 2:32 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> On Wed, Jul 26, 2017 at 01:12:28PM -0700, Christoph Hellwig wrote:
>> On Tue, Jul 25, 2017 at 06:02:29PM -0700, Dan Williams wrote:
>> > As is done in zram_rw_page, pmem_rw_page, and btt_rw_page, don't
>> > call page_endio in the error case since do_mpage_readpage and
>> > __mpage_writepage will resubmit on error. Calling page_endio in the
>> > error case leads to double completion.
>> >
>> > Cc: Jens Axboe <axboe@kernel.dk>
>> > Cc: Matthew Wilcox <mawilcox@microsoft.com>
>> > Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> > ---
>> > Noticed this while looking at unrelated brd code...
>>
>> And the real question would be:  where would we see any real life impact
>> of just removing brd_rw_page?
>
> I've got patches ready that remove rw_page from brd, btt and pmem.  I'll send
> out once I'm done regression testing.

That would leave zram_rw_page(), is there a compelling reason to keep
that and the related infrastructure?
