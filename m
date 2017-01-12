Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdALCyO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2017 21:54:14 -0500
MIME-Version: 1.0
In-Reply-To: <MWHPR03MB26696887EF248C5D2FC260D2BF660@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1481971751-4016-1-git-send-email-ming.lei@canonical.com>
 <f470bfb2-9a82-dcc8-b018-5697d4694a1b@fb.com> <CACVXFVPrauVH0WRbN1OjoiHVsK3SRGuUf1MYcKJhXrDw3FmLrA@mail.gmail.com>
 <a5e0a8cd-2b2e-9719-9d62-9ac7cb0efa48@fb.com> <MWHPR03MB26696887EF248C5D2FC260D2BF660@MWHPR03MB2669.namprd03.prod.outlook.com>
From: Ming Lei <ming.lei@canonical.com>
Date: Thu, 12 Jan 2017 10:54:10 +0800
Message-ID: <CACVXFVOa40tuELzX=VMjUXeEbwJfPnzSCDeVdMS0NtDOd9SZhg@mail.gmail.com>
Subject: Re: [PATCH] block: loose check on sg gap
To: Dexuan Cui <decui@microsoft.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 11, 2017 at 1:10 PM, Dexuan Cui <decui@microsoft.com> wrote:
>> From: Dexuan Cui
>> Sent: Tuesday, December 20, 2016 11:41
>> To: 'Jens Axboe' <axboe@fb.com>; Ming Lei <ming.lei@canonical.com>
>> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-block
>> <linux-block@vger.kernel.org>; Christoph Hellwig <hch@infradead.org>;
>> Vitaly Kuznetsov <vkuznets@redhat.com>; Keith Busch
>> <keith.busch@intel.com>; Hannes Reinecke <hare@suse.de>; Mike Christie
>> <mchristi@redhat.com>; Martin K. Petersen <martin.petersen@oracle.com>;
>> Toshi Kani <toshi.kani@hpe.com>; Dan Williams <dan.j.williams@intel.com>;
>> Damien Le Moal <damien.lemoal@hgst.com>
>> Subject: RE: [PATCH] block: loose check on sg gap
>>
>> > From: Jens Axboe [mailto:axboe@fb.com]
>> > Sent: Tuesday, December 20, 2016 10:31
>> > To: Ming Lei <ming.lei@canonical.com>
>> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; linux-block
>> <linux-
>> > block@vger.kernel.org>; Christoph Hellwig <hch@infradead.org>; Dexuan
>> Cui
>> > <decui@microsoft.com>; Vitaly Kuznetsov <vkuznets@redhat.com>; Keith
>> Busch
>> > <keith.busch@intel.com>; Hannes Reinecke <hare@suse.de>; Mike Christie
>> > <mchristi@redhat.com>; Martin K. Petersen
>> <martin.petersen@oracle.com>;
>> > Toshi Kani <toshi.kani@hpe.com>; Dan Williams
>> <dan.j.williams@intel.com>;
>> > Damien Le Moal <damien.lemoal@hgst.com>
>> > Subject: Re: [PATCH] block: loose check on sg gap
>> >
>> > On 12/19/2016 07:07 PM, Ming Lei wrote:
>> > > On Sun, Dec 18, 2016 at 12:49 AM, Jens Axboe <axboe@fb.com> wrote:
>> > >> On 12/17/2016 03:49 AM, Ming Lei wrote:
>> > >>> If the last bvec of the 1st bio and the 1st bvec of the next
>> > >>> bio are contineous physically, and the latter can be merged
>> > >>> to last segment of the 1st bio, we should think they don't
>> > >>> violate sg gap(or virt boundary) limit.
>> > >>>
>> > >>> Both Vitaly and Dexuan reported lots of unmergeable small bios
>> > >>> are observed when running mkfs on Hyper-V virtual storage, and
>> > >>> performance becomes quite low, so this patch is figured out for
>> > >>> fixing the performance issue.
>> > >>>
>> > >>> The same issue should exist on NVMe too sine it sets virt boundary
>> too.
>> > >>
>> > >> It looks pretty reasonable to me. I'll queue it up for some testing,
>> > >> changes like this always make me a little nervous.
>> > >
>> > > Understood.
>> > >
>> > > But given it is still in early stage of 4.10 cycle, seems fine to expose
>> > > it now, and we should have enough time to fix it if there might be
>> > > regressions.
>> > >
>> > > BTW, it passes my xfstest(ext4) over sata/NVMe.
>> >
>> > It's been fine here in testing, too. I'm not worried about performance
>> > regressions, those we can always fix. Merging makes me worried about
>> > corruption, and those regressions are much worse.
>> >
>> > Any reason we need to rush this? I'd be more comfortable pushing this to
>> > 4.11, unless there are strong reasons this should make 4.10.
>> >
>> > --
>> > Jens Axboe
>>
>> Hi Jens,
>>
>> As far as I know, the patch is important to popular Linux distros,
>> e.g. at least Ubuntu 14.04.5, 16.x and RHEL 7.3, when they run on
>> Hyper-V/Azure, because they can suffer from a pretty bad
>> throughput/latency
>> in some cases, e.g. mkfs.ext4 for a 100GB partition can take 8 minutes, but
>> with the patch, it only takes 1 second.
>>
>> -- Dexuan
>
> Hi Ming, Jens,
> Did you find any issue later when testing with the patch?
>
> May I know if it's possible to have it in 4.10 considering the above impact?
>
> Is it on some temporary branch of linux-block.git? Looks not.

Dexuan, Jens has said that this patch may land v4.11, so just wait a release
and let it expose into more tests.

Thanks,
Ming
