Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:63294 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbdCaVAc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 17:00:32 -0400
Date: Fri, 31 Mar 2017 17:09:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com
Subject: Re: [PATCH v3] blk-mq: remap queues when adding/removing hardware
 queues
Message-ID: <20170331210900.GN20181@localhost.localdomain>
References: <20170331204603.GB11462@vader>
 <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9753ebd0c51a9d49f110a6d0d00888170905d97a.1490993257.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 31, 2017 at 01:48:35PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_mq_update_nr_hw_queues() used to remap hardware queues, which is the
> behavior that drivers expect. However, commit 4e68a011428a changed
> blk_mq_queue_reinit() to not remap queues for the case of CPU
> hotplugging, inadvertently making blk_mq_update_nr_hw_queues() not remap
> queues as well. This breaks, for example, NBD's multi-connection mode,
> leaving the added hardware queues unused. Fix it by making
> blk_mq_update_nr_hw_queues() explicitly remap the queues.
> 
> Fixes: 4e68a011428a ("blk-mq: don't redistribute hardware queues on a CPU hotplug event")
> Signed-off-by: Omar Sandoval <osandov@fb.com>

This looks good to me. 

Reviewed-by: Keith Busch <keith.busch@intel.com>
