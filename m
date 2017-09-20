Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: move sanity checking ahead of
 bi_front/back_seg_size updating
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170918235110.GB8600@infradead.org>
 <043c8787-1056-c16d-a38d-a421920742de@oracle.com>
 <20170919143644.GA15944@infradead.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9d058aa6-c162-04e0-7b38-59c9d8775cf3@oracle.com>
Date: Wed, 20 Sep 2017 09:38:03 +0800
MIME-Version: 1.0
In-Reply-To: <20170919143644.GA15944@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/19/2017 10:36 PM, Christoph Hellwig wrote:
> On Tue, Sep 19, 2017 at 08:55:59AM +0800, jianchao.wang wrote:
>>> But can you elaborate a little more on how this found and if there
>>> is a way to easily reproduce it, say for a blktests test case?
>>>
>> It is found when I made the patch of 
>> 'block: consider merge of segments when merge bio into rq' , not from an actual
>> issue or test case.
> 
> Same question applies to that one, I just haven't finished understanding
> all the changes in it yet.
> 
Really sorry for that. I will elaborate the issue next in this mail thread and add
more comment that describes the issue and result after apply the patch in next version.

The issue is as following:
I executed mkfs.ext4 on my ThinkCentre M910s with a HDD TOSHIBA DT01ACA1.
The kernel version is 4.13.rc7.
The max_segments of the queue is 168, and max_sector_kb is 1280.

In the progress of sequential writing of mkfs, the max size of rq is only 168 sectors which 
is far away from max_sector_kb of 2560 sectors. 
       mkfs.ext4-28362 [007] ....   456.607657: block_unplug: [mkfs.ext4] 16
      mkfs.ext4-28362 [007] ....   456.607658: block_rq_insert: 8,0 WS 86016 () 1875915016 + 168 [mkfs.ext4]
       mkfs.ext4-28362 [007] ....   456.607659: block_rq_insert: 8,0 WS 86016 () 1875915184 + 168 [mkfs.ext4]

Looked into the code, found that ll_back/front_merge_fn() do not consider segment merge across the bios in one rq
, but only in one bio. However, in blk_rq_map_sg(), it will try to merge the segments across the bios in one rq.
I used to trace the return value of blk_rq_map_sg() which is count of mapped segments and got following result:

[ 3158.684851] <scsi_init_sgtable> post_handler: p->addr = 0xffffffff97641a38, ax = 2, nents = a8
[ 3158.684867] <scsi_init_sgtable> post_handler: p->addr = 0xffffffff97641a38, ax = 2, nents = a8
The ax is return value and the nents is the segments count of the sg list.

The 0xa8 segments were merged into 2 segments finally.

To fix this, consider segments merge in ll_back/front_merge_fn() whenever a new bio will to be merged into a rq, then 
could get a more accurate rq->nr_phys_segments and merge more fully.
After apply the patch, I get the result as following:
 mkfs.ext4-1359  [007] ....    78.125055: block_unplug: [mkfs.ext4] 1
       mkfs.ext4-1359  [007] ...1    78.125055: block_rq_insert: 8,0 WS 1310720 () 1875918848 + 2560 [mkfs.ext4]
       mkfs.ext4-1359  [007] ...1    78.125055: block_rq_issue: 8,0 WS 1310720 () 1875918848 + 2560 [mkfs.ext4]

Thanks
Jianchao
