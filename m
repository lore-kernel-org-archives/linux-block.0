Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35174 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdCaTCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 15:02:03 -0400
Received: by mail-pg0-f46.google.com with SMTP id 81so79249390pgh.2
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2017 12:02:02 -0700 (PDT)
Date: Fri, 31 Mar 2017 12:01:08 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com
Subject: Re: [PATCH] blk-mq: remap queues when adding/removing hardware queues
Message-ID: <20170331190032.GA10042@vader>
References: <52fb0623a8496808622c718f0f6372d37574dbe1.1490986618.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52fb0623a8496808622c718f0f6372d37574dbe1.1490986618.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 31, 2017 at 11:59:24AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> blk_mq_update_nr_hw_queues() used to remap hardware queues, which is the
> behavior that drivers expect. However, commit 4e68a011428a changed
> blk_mq_queue_reinit() to not remap queues for the case of CPU
> hotplugging, inadvertently making blk_mq_update_nr_hw_queues() not remap
> queues as well. This breaks, for example, NBD's multi-connection mode,
> leaving the added hardware queues unused. Fix it by making
> blk_mq_queue_reinit() optionally remap queues, which we do when updating
> the number of hardware queues but not when hotplugging.
> 
> Fixes: 4e68a011428a ("blk-mq: don't redistribute hardware queues on a CPU hotplug event")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> The only callers of blk_mq_update_nr_hw_queues() are nbd and nbd. I *think*
> nbd_dev_add() also wants this remap behavior.

Uh, I meant nbd and nvme, and nvme_dev_add().
