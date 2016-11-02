Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33829 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbcKBB6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 21:58:42 -0400
MIME-Version: 1.0
In-Reply-To: <20161101141704.agxfiturhjhm2znn@thunk.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
 <20161031135943.36crigad55hwmmrl@thunk.org> <CACVXFVPmEAUo6KVmKcmQB55jj7q=XRABEZZJS210jeD_W06Uog@mail.gmail.com>
 <CACVXFVPhS3FdzoRfqV8KFza_h0T48_bP-ix7y0_5exKw4iiXfg@mail.gmail.com> <20161101141704.agxfiturhjhm2znn@thunk.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 2 Nov 2016 09:58:39 +0800
Message-ID: <CACVXFVO2o50y_G1gUjakWNiea0o0SWJ6iMZf9cfKNk8C74JL0A@mail.gmail.com>
Subject: Re: [PATCH 45/60] block: bio: introduce bio_for_each_segment_all_rd()
 and its write pair
To: "Theodore Ts'o" <tytso@mit.edu>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@fb.com>,
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
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 1, 2016 at 10:17 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Nov 01, 2016 at 07:51:27AM +0800, Ming Lei wrote:
>> Sorry for forgetting to mention one important point:
>>
>> - after multipage bvec is introduced, the iterated bvec pointer
>> still points to singlge page bvec, which is generated in-flight
>> and is readonly actually. That is the motivation about the introduction
>> of bio_for_each_segment_all_rd().
>>
>> So maybe bio_for_each_page_all_ro() is better?
>>
>> For _wt(), we still can keep it as bio_for_each_segment(), which also
>> reflects that now the iterated bvec points to one whole segment if
>> we name _rd as bio_for_each_page_all_ro().
>
> I'm agnostic as to what the right names are --- my big concern is
> there is an explosion of bio_for_each_page_* functions, and that there

There isn't big users of bio_for_each_segment_all(), see:

        [ming@linux-2.6]$git grep -n bio_for_each_segment_all ./fs/ | wc -l
        23

I guess there isn't execuses to switch to that after this patchset.

>From view of API, bio_for_each_segment_all() is ugly and
exposes the bvec table to users, and the main reason we keep it
is that it can avoid one bvec copy in one loop. And it can be replaced
easily by bio_for_each_segment().

> isn't good documentation about (a) when to use each of these
> functions, and (b) why.  I was goinig through the patch series, and it
> was hard for me to figure out why, and I was looking through all of
> the patches.  Once all of the patches are merged in, I am concerned
> this is going to be massive trapdoor that will snare a large number of
> unwitting developers.

I understand your concern, and let me explain the whole story a bit:

1) in current linus tree, we have the following two bio iterator helpers,
for which we still don't provide any document:

       bio_for_each_segment(bvl, bio, iter)
       bio_for_each_segment_all(bvl, bio, i)

- the former is used to traverse each 'segment' in the bio range
descibed by the 'iter'(just like [start, size]); the latter is used
to traverse each 'segment' in the whole bio, so there isn't 'iter'
passed in.

- in the former helper, typeof('bvl') is 'struct bvec', and the 'segment'
is copied to 'bvl'; in the latter helper, typeof('bvl') is 'struct bvec *', and
it just points to one bvec directly in the table(bio->bi_io_vec) one by one.

- we can use the former helper to implement the latter easily and provide
a more friendly interface, and the main reason we keep it is that _all can
avoid bvec copy in each loop, so it might be a bit efficient.

- even segment is used in the helper's name, but each 'bvl' in the
helper just describes one single page, so actually they should have been
named as the following:

         bio_for_each_page(bvl, bio, iter)
         bio_for_each_page(bvl, bio, iter)

2) this patchset introduces multipage bvec, which will store one
real segment in each 'bvec' of the table(bio->bi_io_vec), and one
segment may include more than one page

- bio_for_each_segment() is kept as current interface to retrieve
one page in each 'bvl', that is just for making current users happy,
and it will be replaced with bio_for_each_page() finally, which
should be a follow-up work of this patchset

- the story of introduction of bio_for_each_segment_all_rd(bvl, bio, i):
we can't simply make 'bvl' point to each bvec in the table direclty
any more, because now each bvec in the table store one real segment
instead of one page. So in this patchst the _rd() is implemented by
bio_for_each_segment(), and we can't change/write to the bvec in the
table any more using the pointer of 'bvl' via this helper.

>
> As far as my preference, from an abstract perspective, if one version
> (the read-write variant, I presume) is always safe, while one (the
> read-only variant) is faster, if you can work under restricted
> circumstances, naming the safe version so it is the "default", and
> more dangerous one with the name that makes it a bit more obvious what
> you have to do in order to use it safely, and then very clearly
> document both in sources, and in the Documentation directory, what the
> issues are and what you have to do in order to use the faster version.

I will add detailed documents about these helpers in next version:

    - bio_for_each_segment()
    - bio_for_each_segment_all()
    - bio_for_each_page_all_ro()(renamed from bio_for_each_segment_all_rd())

Thanks,
Ming

>
> Cheers,
>
>                                         - Ted
>
