Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56162 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753348AbdFSMia (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:38:30 -0400
Date: Mon, 19 Jun 2017 14:38:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 05/30] nvme-rdma: introduce nvme_rdma_start_queue
Message-ID: <20170619123828.GE29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-6-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-6-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:39PM +0300, Sagi Grimberg wrote:
> This should pair with nvme_rdma_stop_queue. While this
> is not a complete 1x1 reverse, it still pairs up pretty
> well because in fabrics we don't have a disconnect capsule
> but we simply teardown the transport association.

Looks like we are going to get one sooner or later.  Not that I'd
like to send them if we can avoid it.

But the patch itself looks fine to me.
