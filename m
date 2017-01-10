Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754191AbdAJL5g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2017 06:57:36 -0500
Date: Tue, 10 Jan 2017 12:57:31 +0100
From: Lukas Czerner <lczerner@redhat.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, David Lehman <dlehman@redhat.com>,
        Jan Tulak <jtulak@redhat.com>, paul evans <pevans@redhat.com>,
        Justin Mitchell <jumitche@redhat.com>
Subject: Re: [LSF/MM TOPIC] [LSF/MM ATTEND] FS Management Interfaces
Message-ID: <20170110115731.godeks2onue257hi@localhost.localdomain>
References: <c13ef7f9-e687-5fcc-6fdb-5dd6f1122227@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c13ef7f9-e687-5fcc-6fdb-5dd6f1122227@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 10, 2017 at 09:44:59AM +0000, Steven Whitehouse wrote:
> Hi,
> 
> This is a request both to attend LSF/MM and also a topic proposal. The last
> couple of years I've proposed a topic of the block/fs interface. I'm happy
> to do that again, if there is consensus that this would be useful, however
> this time I thought that I'd propose something a bit different.
> 
> I had originally thought about calling the proposal "kernel/userland
> interface", however that seemed a bit vague and management interfaces seems
> like a better title since it is I hope a bit clearer of the kind of thing
> that I'm thinking about in this case.
> 
> There are a number of possible sub-topics and I hope that I might find a few
> more before LSF too. One is that of space management (we have statfs, but
> currently no notifications for thresholds crossed etc., so everything is
> polled. That is ok sometimes, but statfs can be expensive in the case of
> distributed filesystems, if 100% accurate. We could just have ENOSPC
> notifications for 100% full, or something more generic), another is state
> transitions (is the fs running normally, or has it gone read
> only/withdrawn/etc due to I/O errors?) and a further topic would be working
> towards a common interface for fs statistics (at the moment each fs defines
> their own interface). One potential implementation, at least for the first
> two sub-topics, would be to use something along the lines of the quota
> netlink interface, but since few ideas survive first contact with the
> community at large, I'm throwing this out for further discussion and
> feedback on whether this approach is considered the right way to go.

Quota-like netlink interface was what I propesed in the patch [1] a
while ago. There was not any real opposition to this idea and I think
that this would be acceptable for the community and widely usefull.

However the real problem is what the interface should really look like.
I wanted to make it extendable, almost generic so we can later add more
things into it. But getting people to agree on the interface like this
will be the hardest thing.

I'd me happy to discuss this on LSF as well.

Thanks!
-Lukas


> 
> Assuming the topic is accepted, my intention would be to gather together
> some additional sub-topics relating to fs management to go along with those
> I mentioned above, and I'd be very interested to hear of any other issues
> that could be usefully added to the list for discussion.
> 
> My interest in other topics is fairly wide... I'm, as usual, interested in
> all filesystem related topics and a good number of block device and mm
> topics too. Anything relating to vfs, xfs, ext*, btrfs, gfs2, overlayfs,
> NFS/CIFS, and technologies such as copy-offload, DAX, reflink, RDMA,
> NVMe(F), etc.,
> 
> Steve.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
