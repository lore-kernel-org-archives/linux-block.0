Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60395 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeJRAdv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Oct 2018 20:33:51 -0400
Date: Wed, 17 Oct 2018 18:37:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2] block: fix rdma queue mapping
Message-ID: <20181017163720.GA23798@lst.de>
References: <20180820205420.25908-1-sagi@grimberg.me> <20180822131130.GC28149@lst.de> <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me> <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Oct 03, 2018 at 02:05:16PM -0500, Steve Wise wrote:
> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
> shouldn't be allowed if drivers support managed affinity. Is that correct?

Not just shouldn't, but simply can't.

> But as it stands, things are just plain borked if an rdma driver
> supports ib_get_vector_affinity() yet the admin changes the affinity via
> /proc...

I think we need to fix ib_get_vector_affinity to not return anything
if the device doesn't use managed irq affinity.
