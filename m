Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40733 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHYGPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Aug 2018 02:15:32 -0400
Subject: Re: [PATCH] block: fix rdma queue mapping
To: Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>,
        Israel Rukshin <israelr@mellanox.com>
References: <20180817223823.19566-1-sagi@grimberg.me>
 <5973cbfe-1466-cf44-c33e-d9b0dbcc9ca6@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1057d15e-ffea-ead8-71b0-58a38174966a@grimberg.me>
Date: Fri, 24 Aug 2018 19:38:13 -0700
MIME-Version: 1.0
In-Reply-To: <5973cbfe-1466-cf44-c33e-d9b0dbcc9ca6@mellanox.com>
Content-Type: text/plain; charset=windows-1255; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Hi Sagi,
> did you have a chance to look on Israel's and mine fixes that we 
> attached to the first thread ?
> 
> there are few issues with this approach. For example in case you don't 
> have a "free" cpu in the mask for Qi and you take cpu from Qi+j mask.
> 
> Also in case we have a non-symetrical affinity for 2 queues e.g. and the 
> system has 32 cpus, the mapping is 16 for each (and not according to the 
> user affinity...).

Can you explain a little better? From Steve's mappings it behaved like I
expected it to.
