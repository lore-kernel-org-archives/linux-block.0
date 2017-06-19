Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbdFSIGj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 04:06:39 -0400
Date: Mon, 19 Jun 2017 16:06:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when
 reallocating io queues
Message-ID: <20170619080622.GA396@ming.t460p>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-29-git-send-email-sagi@grimberg.me>
 <20170619072148.GE13168@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170619072148.GE13168@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 19, 2017 at 09:21:48AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 18, 2017 at 06:22:02PM +0300, Sagi Grimberg wrote:
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Could use a changelog.
> 
> Ming: does this solve your problem of not seeing the new queues
> after a qemu CPU hotplug + reset?

The issue I observed is that there isn't NVMe reset triggered after
CPU becomes online.

It may take a while since the test need to apply the whole patchset.
Or is it fine to figure out one fix on this issue? Sagi?

Once the test is done, I will update with you.

Thanks,
Ming
