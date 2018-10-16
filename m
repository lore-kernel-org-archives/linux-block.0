Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42197 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeJPIwh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Oct 2018 04:52:37 -0400
Subject: Re: [PATCH v2] block: fix rdma queue mapping
From: Sagi Grimberg <sagi@grimberg.me>
To: Steve Wise <swise@opengridcomputing.com>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
Message-ID: <c14b6091-781d-580e-833f-d2c6db54a5d2@grimberg.me>
Date: Mon, 15 Oct 2018 18:04:46 -0700
MIME-Version: 1.0
In-Reply-To: <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> Can we please make forward progress on this?
>>
>> Christoph, Sagi:  it seems you think /proc/irq/$IRP/smp_affinity
>> shouldn't be allowed if drivers support managed affinity. Is that 
>> correct?
>>
>> Perhaps that can be codified and be a way forward?  IE: Somehow allow
>> the admin to choose either "managed by the driver/ulps" or "managed by
>> the system admin directly"?
>>
>> Or just use Sagi's patch.  Perhaps a WARN_ONCE() if the affinity looks
>> wonked when set via procfs?  Just thinking out loud...
> 
> I think we should take my patch. While ideally we'd like to have
> perfect linear irq based queue mapping, people apparently really like
> to modify devices irq affinity. With this, at least some of the queues
> are assigned according to the device affinity. Its not ideal, but at
> least better than blindly falling to default mapping.
> 
> Christoph?
> 
> If there is strong resistance to the patch we should at least start
> by falling to the default mapping unconditionally.

Ping?

Would you prefer we fallback to the naive mapping if the device is not
using manged affinity?
