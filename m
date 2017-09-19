Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: move sanity checking ahead of
 bi_front/back_seg_size updating
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170918235110.GB8600@infradead.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <043c8787-1056-c16d-a38d-a421920742de@oracle.com>
Date: Tue, 19 Sep 2017 08:55:59 +0800
MIME-Version: 1.0
In-Reply-To: <20170918235110.GB8600@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/19/2017 07:51 AM, Christoph Hellwig wrote:
> On Sat, Sep 16, 2017 at 07:10:30AM +0800, Jianchao Wang wrote:
>> If the bio_integrity_merge_rq() return false or nr_phys_segments exceeds
>> the max_segments, the merging fails, but the bi_front/back_seg_size may
>> have been modified. To avoid it, move the sanity checking ahead.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> This looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But can you elaborate a little more on how this found and if there
> is a way to easily reproduce it, say for a blktests test case?
> 
It is found when I made the patch of 
'block: consider merge of segments when merge bio into rq' , not from an actual
issue or test case.

Thanks
Jianchao
