Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 1 Nov 2016 10:17:04 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 45/60] block: bio: introduce
 bio_for_each_segment_all_rd() and its write pair
Message-ID: <20161101141704.agxfiturhjhm2znn@thunk.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
 <20161031135943.36crigad55hwmmrl@thunk.org>
 <CACVXFVPmEAUo6KVmKcmQB55jj7q=XRABEZZJS210jeD_W06Uog@mail.gmail.com>
 <CACVXFVPhS3FdzoRfqV8KFza_h0T48_bP-ix7y0_5exKw4iiXfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPhS3FdzoRfqV8KFza_h0T48_bP-ix7y0_5exKw4iiXfg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 07:51:27AM +0800, Ming Lei wrote:
> Sorry for forgetting to mention one important point:
> 
> - after multipage bvec is introduced, the iterated bvec pointer
> still points to singlge page bvec, which is generated in-flight
> and is readonly actually. That is the motivation about the introduction
> of bio_for_each_segment_all_rd().
> 
> So maybe bio_for_each_page_all_ro() is better?
> 
> For _wt(), we still can keep it as bio_for_each_segment(), which also
> reflects that now the iterated bvec points to one whole segment if
> we name _rd as bio_for_each_page_all_ro().

I'm agnostic as to what the right names are --- my big concern is
there is an explosion of bio_for_each_page_* functions, and that there
isn't good documentation about (a) when to use each of these
functions, and (b) why.  I was goinig through the patch series, and it
was hard for me to figure out why, and I was looking through all of
the patches.  Once all of the patches are merged in, I am concerned
this is going to be massive trapdoor that will snare a large number of
unwitting developers.

As far as my preference, from an abstract perspective, if one version
(the read-write variant, I presume) is always safe, while one (the
read-only variant) is faster, if you can work under restricted
circumstances, naming the safe version so it is the "default", and
more dangerous one with the name that makes it a bit more obvious what
you have to do in order to use it safely, and then very clearly
document both in sources, and in the Documentation directory, what the
issues are and what you have to do in order to use the faster version.

Cheers,

					- Ted
					
