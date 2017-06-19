Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54748 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFSHU7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 03:20:59 -0400
Date: Mon, 19 Jun 2017 09:20:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 24/30] nvme-pci: rename to
        nvme_pci_configure_admin_queue
Message-ID: <20170619072058.GD13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-25-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-25-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:58PM +0300, Sagi Grimberg wrote:
> we are going to need the name for the core routine...

I think we should just pick this up ASAP as a prep patch..

Reviewed-by: Christoph Hellwig <hch@lst.de>
