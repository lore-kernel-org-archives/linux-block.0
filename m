Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56303 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753960AbcLTCH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2016 21:07:58 -0500
MIME-Version: 1.0
In-Reply-To: <f470bfb2-9a82-dcc8-b018-5697d4694a1b@fb.com>
References: <1481971751-4016-1-git-send-email-ming.lei@canonical.com> <f470bfb2-9a82-dcc8-b018-5697d4694a1b@fb.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Tue, 20 Dec 2016 10:07:55 +0800
Message-ID: <CACVXFVPrauVH0WRbN1OjoiHVsK3SRGuUf1MYcKJhXrDw3FmLrA@mail.gmail.com>
Subject: Re: [PATCH] block: loose check on sg gap
To: Jens Axboe <axboe@fb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Dec 18, 2016 at 12:49 AM, Jens Axboe <axboe@fb.com> wrote:
> On 12/17/2016 03:49 AM, Ming Lei wrote:
>> If the last bvec of the 1st bio and the 1st bvec of the next
>> bio are contineous physically, and the latter can be merged
>> to last segment of the 1st bio, we should think they don't
>> violate sg gap(or virt boundary) limit.
>>
>> Both Vitaly and Dexuan reported lots of unmergeable small bios
>> are observed when running mkfs on Hyper-V virtual storage, and
>> performance becomes quite low, so this patch is figured out for
>> fixing the performance issue.
>>
>> The same issue should exist on NVMe too sine it sets virt boundary too.
>
> It looks pretty reasonable to me. I'll queue it up for some testing,
> changes like this always make me a little nervous.

Understood.

But given it is still in early stage of 4.10 cycle, seems fine to expose
it now, and we should have enough time to fix it if there might be
regressions.

BTW, it passes my xfstest(ext4) over sata/NVMe.

Thanks,
Ming
