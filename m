Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39377 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdHPJgA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 05:36:00 -0400
Date: Wed, 16 Aug 2017 11:35:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
        reconnects
Message-ID: <20170816093559.GA24709@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me> <20170816081605.GA29784@infradead.org> <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 16, 2017 at 12:33:47PM +0300, Sagi Grimberg wrote:
>>> This set applies on nvme-4.14 plus 4.13 recent fixes.
>>
>> I can't get this applied at all.
>
> That's probably because this is on top of the rdma affinity
> patches which are already in Doug's tree...
>
>> A pointer to a git repo would
>> always be nice for patchsets as large as this one, especially if
>> the base is a bit murky..
>
> Sure, should I have it on top of the affinity patches or not?

For now get any tree you have out to take a look.  In the longer
run we'll need to decide how we want to deal with the merge
of the two trees.  In general having to depend on the RDMA
tree is a major risk because it's maintainance is so unreliable.

If it's in a branch of its own we could pull it in through and
send that bit through both trees.
