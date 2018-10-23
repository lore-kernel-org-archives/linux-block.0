Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35855 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJWOYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Oct 2018 10:24:42 -0400
Subject: Re: [PATCH v2] block: fix rdma queue mapping
To: Christoph Hellwig <hch@lst.de>,
        Steve Wise <swise@opengridcomputing.com>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
Date: Mon, 22 Oct 2018 23:02:46 -0700
MIME-Version: 1.0
In-Reply-To: <20181017163720.GA23798@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
>> shouldn't be allowed if drivers support managed affinity. Is that correct?
> 
> Not just shouldn't, but simply can't.
> 
>> But as it stands, things are just plain borked if an rdma driver
>> supports ib_get_vector_affinity() yet the admin changes the affinity via
>> /proc...
> 
> I think we need to fix ib_get_vector_affinity to not return anything
> if the device doesn't use managed irq affinity.

Steve, does iw_cxgb4 use managed affinity?

I'll send a patch for mlx5 to simply not return anything as managed
affinity is not something that the maintainers want to do.
