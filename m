Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Mon, 11 Jun 2018 09:48:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180611164806.GA7452@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180609123014.8861-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

І think the new naming scheme in this series is a nightmare.  It
confuses the heck out of me, and that is despite knowing many bits of
the block layer inside out, and reviewing previous series.

I think we need to take a step back and figure out what names what we
want in the end, and how we get there separately.

For the end result using bio_for_each_page in some form for the per-page
iteration seems like the only sensible idea, as that is what it does.

For the bio-vec iteration I'm fine with either bio_for_each_bvec as that
exactly explains what it does, or bio_for_each_segment to keep the
change at a minimum.

And in terms of how to get there: maybe we need to move all the drivers
and file systems to the new names first before the actual changes to
document all the intent.  For that using the bio_for_each_bvec variant
might be benefitial as it allows to seasily see the difference between
old uncovered code and the already converted one.
