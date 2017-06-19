Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56178 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdFSMkn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:40:43 -0400
Date: Mon, 19 Jun 2017 14:40:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 08/30] nvme-rdma: cleanup error path in controller
        reset
Message-ID: <20170619124042.GH29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-9-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-9-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:42PM +0300, Sagi Grimberg wrote:
> No need to queue an extra work to indirect controller
> uninit and put the final reference.

Maybe my memory is a little vague, but didn't we need the work_struct
for something?  At least it would serialize all the removals for example.
