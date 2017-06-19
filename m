Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56187 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbdFSMlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:41:05 -0400
Date: Mon, 19 Jun 2017 14:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 09/30] nvme: Move queue_count to the nvme_ctrl
Message-ID: <20170619124104.GI29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-10-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-10-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks fine.  I'd be happy to take this as an early cleanup.

Reviewed-by: Christoph Hellwig <hch@lst.de>
