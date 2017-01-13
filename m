Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdAMU0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 15:26:43 -0500
Subject: Re: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
 <1483569671-1462-3-git-send-email-keith.busch@intel.com>
 <20170108100152.GA26025@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Marc Merlin <marc@merlins.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <76b3779d-18e3-51c4-84c9-efdbc68f6d84@grimberg.me>
Date: Fri, 13 Jan 2017 22:26:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170108100152.GA26025@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>> The offline CPUs need to assigned to something incase they come online
>> later, otherwise anyone using the mapping for things other than affinity
>> will have blank entries for that online CPU.
>
> I don't really like the idea behind it.  Back when we came up with
> this code I had some discussion with Thomas if we should do the
> assignment only for online CPUs, or maybe for all possible CPUs.
>
> Except for some big iron with physical node hotplug the difference
> usually is just that some nodes have been temporarily offlined.  So
> maybe we need to bite the bullet and move the irq and block code
> to consider all possible cpus.

I tend to agree.

Would be great if we could have a cpuhp_register() for external users
that would get ops + state mask structure to act on (this case would
need CPUHP_OFFLINE, CPUHP_ONLINE). We do have something similar
for mmu (mmu_notifier).
