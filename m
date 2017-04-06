Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35347 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdDFIeH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2017 04:34:07 -0400
Subject: Re: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
To: Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <86ed1762-a990-691f-e043-3d7dcac8fe85@mellanox.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <09b4dcb4-d0ab-43b7-5f1c-394ecfcce2f0@grimberg.me>
Date: Thu, 6 Apr 2017 11:34:03 +0300
MIME-Version: 1.0
In-Reply-To: <86ed1762-a990-691f-e043-3d7dcac8fe85@mellanox.com>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> Hi Sagi,

Hey Max,

> the patchset looks good and of course we can add support for more
> drivers in the future.
> have you run some performance testing with the nvmf initiator ?

I'm limited by the target machine in terms of IOPs, but the host shows
~10% cpu usage decrease, and latency improves slightly as well
which is more apparent depending on which cpu I'm running my IO
thread (due to the mismatch in comp_vectors and queue mappings
some queues have irq vectors mapped to a core on a different numa
node.
