Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36087 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752257AbdDNTwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 15:52:47 -0400
Subject: Re: [PATCH] block: fix bio_will_gap()
To: Johannes Thumshirn <morbidrsa@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Omar Sandoval <osandov@osandov.com>
References: <20170413160626.14635-1-ming.lei@redhat.com>
 <CAGH8bx4F3qptbxyLevB49NUBRw7rG5U7Yn4NNW9-MtA3mFc8aQ@mail.gmail.com>
CC: <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <aa4c6a6c-0c27-dcfc-07c3-e12f6fe484d6@fb.com>
Date: Fri, 14 Apr 2017 13:51:54 -0600
MIME-Version: 1.0
In-Reply-To: <CAGH8bx4F3qptbxyLevB49NUBRw7rG5U7Yn4NNW9-MtA3mFc8aQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/14/2017 05:26 AM, Johannes Thumshirn wrote:
> On Thu, Apr 13, 2017 at 6:06 PM, Ming Lei <ming.lei@redhat.com> wrote:
>> Now commit 729204ef49ec("block: relax check on sg gap")
>> allows us to merge bios if both are physically contiguous,
>> this change can merge huge of small bios in use case of mkfs,
>> for example, mkfs.ntfs running time can be decreased to ~1/10.
>>
>> But if one rq starts with non-aligned buffer(the 1st bvec's
>> bv_offset isn't zero) and if we allow to merge, it is quite
>> difficult to respect sg gap limit, especially the segment
>> can't be at maximum segment size, otherwise the segment
>> ends in unaligned virt boundary. This patch trys to avoid the
>> issue by not allowing to merge if the req starts with non-aligned
>> buffer.
>>
>> Also add comments to explain why the merged segment can't
>> end in unaligned virt boundary.
>>
>> Fixes: 729204ef49ec ("block: relax check on sg gap")
>> Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
>> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
> 
> 
> Hi Jens and Omar,
> 
> I know Jens is currently on vacation, but can maybe Omar get this fix to Linus
> before v4.11? This would be highly appreciated.

I'll pick this up now. I'm back early next week, so we're still fine for
4.11. But I'm glad I pushed back on the original change for 4.10 now.

-- 
Jens Axboe
