Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56277 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbdFSMtL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:49:11 -0400
Date: Mon, 19 Jun 2017 14:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 20/30] nvme: add err, reconnect and delete work
        items to nvme core
Message-ID: <20170619124910.GR29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-21-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-21-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:54PM +0300, Sagi Grimberg wrote:
> We intent for these handlers to become generic, thus, add them to
> the nvme core controller struct.

Do you remember why we actually need all the different work items?

We need err_work to recover from RDMA QP-level errors.  But how
is it so different from a reset in that respect?  Similarly why
do we need reset to be different from reconnect?  Especially as
reconnect sort of is the reset of fabrics.
