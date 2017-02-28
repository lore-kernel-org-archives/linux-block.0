Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36113 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdB1IZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 03:25:40 -0500
MIME-Version: 1.0
In-Reply-To: <yq1fuj44geq.fsf@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
 <yq1efyq25y2.fsf@oracle.com> <CAOi1vP-amFyFHbPV3FhG3F1Tp+df6V7a4mcP8LLWY0GZx+JsFw@mail.gmail.com>
 <yq1fuj44geq.fsf@oracle.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Feb 2017 09:19:14 +0100
Message-ID: <CAOi1vP_g-MMe9XvWDgkVL4R6UjckMQVC_CDF9+hQEpZbxwx0Jw@mail.gmail.com>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 24, 2017 at 12:49 AM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:
>
> Ilya,
>
> Ilya> Well, blk_integrity_revalidate() doesn't clear the profile, it
> Ilya> just clears the stable pages flag.  Whoever calls
> Ilya> blk_integrity_unregister() to clear the profile can also clear the
> Ilya> stable pages flag -- why not let blk_integrity_unregister() clear
> Ilya> the flag like I suggested?
>
> That's what it used to do.
>
> blk_integrity_revalidate() was obviously introduced to overcome some
> problem. Unfortunately, I can't recall what that was and Google isn't
> being particularly helpful. I suspect it was either in the NVDIMM or
> NVMe camps since that's where the churn was.

Adding more people from 25520d55cdb6 -- does anyone remember the story
behind blk_integrity_revalidate()?

>
> I don't have a problem with your patch as long as we're sure there are
> no regressions. I would carry the gendisk check over, though.

I spent quite some time trying to do basic tests on nvme, since it uses
both nop_profile and real integrity profiles.  Unfortunately I don't
have access to an nvme card with separate-metadata capability and
upstream qemu driver doesn't support any metadata capabilities at all,
so I turned to https://github.com/OpenChannelSSD/qemu-nvme.  It lets
you configure mc and multiple lbafs, but

    commit ff646a5841f743fdd9cfef138ac6be1f0ba4fbfb
    Author: Keith Busch <keith.busch@intel.com> Thu Oct 23 20:02:44 2014

    As part of this, I am removing all meta-data support. It's not well
    supported in any immediatly available operating system, so the code
    is not well tested.

In the end I got it into a semi-working state by checking out an old
version and dropping some sanity checks.  I formatted the namespace in
a number of ways -- bdi/stable_pages_required and integrity/format
behaved as expected ("none", "nop", "T10-DIF-TYPE1-CRC").

Given the above, I'm not sure what the baseline is -- blk_integrity
code isn't invoked for data-only lbafs.  Could nvme folks please look
at this?  rbd regression caused by integrity revalidate change goes
back to 4.4 and I'd really like to get it fixed.  The proposed patch
is attached to my earlier reply on linux-block.

Thanks,

                Ilya
