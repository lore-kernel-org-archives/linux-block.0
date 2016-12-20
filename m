Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753107AbcLTCc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 21:32:26 -0500
Subject: Re: [PATCH] block: loose check on sg gap
To: Ming Lei <ming.lei@canonical.com>
References: <1481971751-4016-1-git-send-email-ming.lei@canonical.com>
 <f470bfb2-9a82-dcc8-b018-5697d4694a1b@fb.com>
 <CACVXFVPrauVH0WRbN1OjoiHVsK3SRGuUf1MYcKJhXrDw3FmLrA@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Dexuan Cui" <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Keith Busch" <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a5e0a8cd-2b2e-9719-9d62-9ac7cb0efa48@fb.com>
Date: Mon, 19 Dec 2016 19:31:12 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVPrauVH0WRbN1OjoiHVsK3SRGuUf1MYcKJhXrDw3FmLrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/19/2016 07:07 PM, Ming Lei wrote:
> On Sun, Dec 18, 2016 at 12:49 AM, Jens Axboe <axboe@fb.com> wrote:
>> On 12/17/2016 03:49 AM, Ming Lei wrote:
>>> If the last bvec of the 1st bio and the 1st bvec of the next
>>> bio are contineous physically, and the latter can be merged
>>> to last segment of the 1st bio, we should think they don't
>>> violate sg gap(or virt boundary) limit.
>>>
>>> Both Vitaly and Dexuan reported lots of unmergeable small bios
>>> are observed when running mkfs on Hyper-V virtual storage, and
>>> performance becomes quite low, so this patch is figured out for
>>> fixing the performance issue.
>>>
>>> The same issue should exist on NVMe too sine it sets virt boundary too.
>>
>> It looks pretty reasonable to me. I'll queue it up for some testing,
>> changes like this always make me a little nervous.
> 
> Understood.
> 
> But given it is still in early stage of 4.10 cycle, seems fine to expose
> it now, and we should have enough time to fix it if there might be
> regressions.
> 
> BTW, it passes my xfstest(ext4) over sata/NVMe.

It's been fine here in testing, too. I'm not worried about performance
regressions, those we can always fix. Merging makes me worried about
corruption, and those regressions are much worse.

Any reason we need to rush this? I'd be more comfortable pushing this to
4.11, unless there are strong reasons this should make 4.10.

-- 
Jens Axboe

