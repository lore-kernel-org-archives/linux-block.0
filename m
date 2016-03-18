Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160317163946.GC6217@localhost.lm.intel.com>
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
	<CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
	<87oaae4cej.fsf@vitty.brq.redhat.com>
	<20160316223804.GA6217@localhost.lm.intel.com>
	<87egb94agz.fsf@vitty.brq.redhat.com>
	<20160317163946.GC6217@localhost.lm.intel.com>
Date: Fri, 18 Mar 2016 10:59:32 +0800
Message-ID: <CACVXFVNrHJcNxcm3+ieOM8f3GzKtTgu38HndWd19ehVDZBev_g@mail.gmail.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is set
From: Ming Lei <tom.leiming@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-block@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Sagi Grimberg <sagig@mellanox.com>,
	Mike Snitzer <snitzer@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Cathy Avery <cavery@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 18, 2016 at 12:39 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Mar 17, 2016 at 12:20:28PM +0100, Vitaly Kuznetsov wrote:
>> Keith Busch <keith.busch@intel.com> writes:
>> > been combined. In any case, I think you can get what you're after just
>> > by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the following
>> > look ok to you?
>> >
>>
>> Thanks, it does.
>
> Cool, thanks for confirming.
>
>> Will you send it or would you like me to do that with your Suggested-by?
>
> I'm not confident yet this doesn't break anything, particularly since
> we moved the gap check after the length check. Just wanted to confirm
> the concept addressed your concern, but still need to take a closer look
> and test before submitting.

IMO, the change on blk_bio_segment_split() is correct, because actually it
is a sg gap and the check should have been done between segments
instead of bvecs. So it is reasonable to move the check just before populating
a new segment.

But for the 2nd change in bio_will_gap(), which should fix Vitaly's problem, I
am still not sure if it is completely correct. bio_will_gap() is used
to check if two
bios may be merged. Suppose two bios are continues physically, the last bvec
in 1st bio and the first bvec in 2nd bio might not be in one same segment
because of segment size limit.

The root cause might be from blkdev_writepage(), and I guess these small
bios are from there.

thanks,
Ming Lei
