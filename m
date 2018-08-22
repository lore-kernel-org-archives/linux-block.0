Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35315 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbeHVQei (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Aug 2018 12:34:38 -0400
Date: Wed, 22 Aug 2018 15:11:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20180822131130.GC28149@lst.de>
References: <20180820205420.25908-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820205420.25908-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 20, 2018 at 01:54:20PM -0700, Sagi Grimberg wrote:
> nvme-rdma attempts to map queues based on irq vector affinity.
> However, for some devices, completion vector irq affinity is
> configurable by the user which can break the existing assumption
> that irq vectors are optimally arranged over the host cpu cores.

IFF affinity is configurable we should never use this code,
as it breaks the model entirely.  ib_get_vector_affinity should
never return a valid mask if affinity is configurable.
