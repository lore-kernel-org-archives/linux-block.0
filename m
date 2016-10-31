Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34485 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946934AbcJaXvb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 19:51:31 -0400
MIME-Version: 1.0
In-Reply-To: <CACVXFVPmEAUo6KVmKcmQB55jj7q=XRABEZZJS210jeD_W06Uog@mail.gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
 <20161031135943.36crigad55hwmmrl@thunk.org> <CACVXFVPmEAUo6KVmKcmQB55jj7q=XRABEZZJS210jeD_W06Uog@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 07:51:27 +0800
Message-ID: <CACVXFVPhS3FdzoRfqV8KFza_h0T48_bP-ix7y0_5exKw4iiXfg@mail.gmail.com>
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
        Bart Van Assche <bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 1, 2016 at 6:46 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Mon, Oct 31, 2016 at 9:59 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> On Sat, Oct 29, 2016 at 04:08:44PM +0800, Ming Lei wrote:
>>> This patches introduce bio_for_each_segment_all_rd() and
>>> bio_for_each_segment_all_wt().
>>>
>>> bio_for_each_segment_all_rd() is for replacing
>>> bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
>>> is accessed as readonly.
>>>
>>> bio_for_each_segment_all_wt() is for replacing
>>> bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
>>> need to be updated.
>>
>> What is _rd and _wt supposed to stand for?  And speaking more
>
> As Christoph replied, _rd means read, which said the bvec pointed by
> the iterator variable(bvec pointer) is read-only, and the bvec table
> can't be written into via this usage any more. Maybe
> bio_for_each_segment_all_ro is better?

Sorry for forgetting to mention one important point:

- after multipage bvec is introduced, the iterated bvec pointer
still points to singlge page bvec, which is generated in-flight
and is readonly actually. That is the motivation about the introduction
of bio_for_each_segment_all_rd().

So maybe bio_for_each_page_all_ro() is better?

>
> On the other hand, _wr meands write, which said the bvec pointed by
> the iterator variable(bvec pointer) can be written to. Maybe we can use
> original bio_for_each_segment_all() for it?

For _wt(), we still can keep it as bio_for_each_segment(), which also
reflects that now the iterated bvec points to one whole segment if
we name _rd as bio_for_each_page_all_ro().


Thanks,
Ming Lei
