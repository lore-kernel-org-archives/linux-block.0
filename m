Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55876 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753723AbdESPHp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2017 11:07:45 -0400
Date: Fri, 19 May 2017 11:15:13 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: fix race between removing and reseting failure
Message-ID: <20170519151513.GB7850@localhost.localdomain>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-2-ming.lei@redhat.com>
 <20170518141307.GD28520@localhost.localdomain>
 <20170519125244.GB22585@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519125244.GB22585@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, May 19, 2017 at 08:52:45PM +0800, Ming Lei wrote:
> But I still think it may be better to move nvme_kill_queues() into
> nvme_remove_dead_ctrl() as an improvement because during this small
> window page cache can be used up by write application, and no writeback
> can move on meantime.

Yes, I agree that's a better placement for it. I was just concerned
about the reasoning since it would also mean we're still stuck if an
IO timeout occurs while calling del_gendisk. So I'm okay with the patch
as-is, but I'll also look into my other concern.
