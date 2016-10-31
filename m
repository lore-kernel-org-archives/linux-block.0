Return-Path: <linux-fsdevel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161031151123.GA3193@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
 <20161031135943.36crigad55hwmmrl@thunk.org> <20161031151123.GA3193@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 06:50:04 +0800
Message-ID: <CACVXFVNYL+1ucYom_gpX4BD6ROm_GXG7-DEs+5_gxgmDCxNWfA@mail.gmail.com>
Subject: Re: [PATCH 45/60] block: bio: introduce bio_for_each_segment_all_rd()
 and its write pair
To: Christoph Hellwig <hch@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 31, 2016 at 11:11 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Oct 31, 2016 at 09:59:43AM -0400, Theodore Ts'o wrote:
>> What is _rd and _wt supposed to stand for?
>
> I think it's read and write, but I think the naming is highly
> unfortunate.  I started dabbling around with the patches a bit,
> and to keep my sanity a started reaming it to _pages and _bvec
> which is the real semantics - the _rd or _pages gives you a synthetic
> bvec for each page, and the other one gives you the full bvec.

Looks _pages & _bvec is better and still a little confusing and not reflect
its real purpose from user view, since both points to real bvec. Could we
just rename _rd as bio_for_each_segment_all_ro() which means the pointed
bvec is readonly and not introduce _wt?


Thanks,
Ming Lei
