Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50367 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdDDG17 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Apr 2017 02:27:59 -0400
Date: Tue, 4 Apr 2017 08:27:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH rfc 1/6] mlx5: convert to generic pci_alloc_irq_vectors
Message-ID: <20170404062757.GA8978@lst.de>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me> <1491140492-25703-2-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491140492-25703-2-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
