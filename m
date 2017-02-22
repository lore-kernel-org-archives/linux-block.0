Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37055 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbdBVElT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 23:41:19 -0500
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: blk_integrity_revalidate() clears BDI_CAP_STABLE_WRITES
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
Date: Tue, 21 Feb 2017 23:41:09 -0500
In-Reply-To: <CAOi1vP8M91kiF-FnT=EoJgTxfstMEsC-nhLY5KtRkrKROjWPWA@mail.gmail.com>
        (Ilya Dryomov's message of "Mon, 20 Feb 2017 19:45:42 +0100")
Message-ID: <yq1efyq25y2.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Ilya" == Ilya Dryomov <idryomov@gmail.com> writes:

Ilya,

Ilya> could you please explain blk_integrity_revalidate() and
Ilya> its GENHD_FL_UP check in particular?  We have the queue,
Ilya> bi->profile can't be NULL after blk_integrity_register(), and
Ilya> since the latter "must" be used for registering the profile with
Ilya> the block layer, wouldn't the following be sufficient for
Ilya> blk_integrity users?

IIrc, the FL_UP check fixed a registration problem in the nvme driver.

The rationale behind revalidate was that we need to handle devices which
lose the integrity capability at runtime (i.e. a integrity-enabled DM
device is extended with a non-cable drive forcing the feature to be
turned off). The clearing of the integrity profile is more important in
that case than zapping the stable pages flag. But that was the original
reason for not just ORing BDI_CAP_STABLE_WRITES.

I don't have a huge problem with keeping stable pages on if a device
suddenly stops being integrity capable. However, I'd like to understand
your use case a bit better.

Ilya> The alternative seems to be to set up a bogus
Ilya> blk_integrity_profile (nop_profile won't do -- this one would have
Ilya> to be truly bogus w/ NULL *_fn) under BLK_DEV_INTEGRITY ifdefs and
Ilya> hope that nothing breaks.

Can you point me to the relevant code on your end?

Thanks,
Martin

-- 
Martin K. Petersen	Oracle Linux Engineering
