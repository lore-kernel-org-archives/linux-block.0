Return-Path: <vkuznets@redhat.com>
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Dan Williams <dan.j.williams@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagig@mellanox.com>, Mike Snitzer <snitzer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Cathy Avery <cavery@redhat.com>
Subject: Re: [PATCH RFC] block: fix bio merge checks when virt_boundary is set
References: <1458055076-2175-1-git-send-email-vkuznets@redhat.com>
	<CACVXFVMs-fOaNVUyedg66T83MiOc7a+op3LeHVt6ogVBQnYdeQ@mail.gmail.com>
	<87oaae4cej.fsf@vitty.brq.redhat.com>
	<20160316223804.GA6217@localhost.lm.intel.com>
	<87egb94agz.fsf@vitty.brq.redhat.com>
	<20160317163946.GC6217@localhost.lm.intel.com>
	<CACVXFVNrHJcNxcm3+ieOM8f3GzKtTgu38HndWd19ehVDZBev_g@mail.gmail.com>
	<CACVXFVO37O2Yp60E82U_YWCe2yUqsEn1ojMb6kpTDmhBk94dQA@mail.gmail.com>
Date: Wed, 20 Apr 2016 15:48:10 +0200
In-Reply-To: <CACVXFVO37O2Yp60E82U_YWCe2yUqsEn1ojMb6kpTDmhBk94dQA@mail.gmail.com>
	(Ming Lei's message of "Wed, 30 Mar 2016 21:07:19 +0800")
Message-ID: <87shyg1jdx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Ming Lei <tom.leiming@gmail.com> writes:

> On Fri, Mar 18, 2016 at 10:59 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Fri, Mar 18, 2016 at 12:39 AM, Keith Busch <keith.busch@intel.com> wrote:
>>> On Thu, Mar 17, 2016 at 12:20:28PM +0100, Vitaly Kuznetsov wrote:
>>>> Keith Busch <keith.busch@intel.com> writes:
>>>> > been combined. In any case, I think you can get what you're after just
>>>> > by moving the gap check after BIOVEC_PHYS_MERGABLE. Does the following
>>>> > look ok to you?
>>>> >
>>>>
>>>> Thanks, it does.
>>>
>>> Cool, thanks for confirming.
>>>
>>>> Will you send it or would you like me to do that with your Suggested-by?
>>>
>>> I'm not confident yet this doesn't break anything, particularly since
>>> we moved the gap check after the length check. Just wanted to confirm
>>> the concept addressed your concern, but still need to take a closer look
>>> and test before submitting.
>>
>> IMO, the change on blk_bio_segment_split() is correct, because actually it
>> is a sg gap and the check should have been done between segments
>> instead of bvecs. So it is reasonable to move the check just before populating
>> a new segment.
>
> Thinking of the 1st part change further, looks it is just correct in concept,
> but wrong from current implementation. Because of bios/reqs merge,
> blk_rq_map_sg() may end one segment in any bvec in theroy, so I guess
> that is why each non-1st bvec need the check to make sure no sg gap.
> Looks a very crazy limit, :-)
>
>>
>> But for the 2nd change in bio_will_gap(), which should fix Vitaly's problem, I
>> am still not sure if it is completely correct. bio_will_gap() is used
>> to check if two
>> bios may be merged. Suppose two bios are continues physically, the last bvec
>> in 1st bio and the first bvec in 2nd bio might not be in one same segment
>> because of segment size limit.
>
> How about the attached patch?
>

I just wanted to revive the discussion as the issue persists. I
re-tested your patch against 4.6-rc4 and it efficiently solves the
issue.

pre-patch:
# time mkfs.ntfs /dev/sdb1
Cluster size has been automatically set to 4096 bytes.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.

real8m10.977s
user0m0.115s
sys0m12.672s

post-patch:
# time mkfs.ntfs /dev/sdb1
Cluster size has been automatically set to 4096 bytes.
Initializing device with zeroes: 100% - Done.
Creating NTFS volume structures.
mkntfs completed successfully. Have a nice day.

real0m42.430s
user0m0.171s
sys0m7.675s

Will you send this patch? Please let me know if I can further
assist. Thanks!

-- 
  Vitaly
