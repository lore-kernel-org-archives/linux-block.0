Return-Path: <linux-block-owner@vger.kernel.org>
Received: from opengridcomputing.com ([72.48.214.68]:42952 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbeJDELw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Oct 2018 00:11:52 -0400
Subject: Re: [PATCH v2] block: fix rdma queue mapping
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, Max Gurtovoy <maxg@mellanox.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
From: Steve Wise <swise@opengridcomputing.com>
Message-ID: <57ef6cd1-2813-4534-c75c-75965dd2bf4c@opengridcomputing.com>
Date: Wed, 3 Oct 2018 16:21:51 -0500
MIME-Version: 1.0
In-Reply-To: <66c41a1a-e57d-8526-366c-e15dcded7cec@grimberg.me>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 10/3/2018 4:14 PM, Sagi Grimberg wrote:
> 
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

Perhaps we should still add a WARN_ONCE if we don't get a linear
mapping?  IE admins are now tweaking this because in the past the
default affinity could hurt performance, and adjusting it via procfs was
the answer.  But now we're making the devices and ULPs smarter, so we
should maybe let the admin know when we think the ideal affinity is not
being achieved.

Steve.
