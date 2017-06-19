Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34930 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdFSOOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 10:14:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id d64so16624975wmf.2
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 07:14:36 -0700 (PDT)
Subject: Re: [PATCH rfc 20/30] nvme: add err, reconnect and delete work items
 to nvme core
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-21-git-send-email-sagi@grimberg.me>
 <20170619124910.GR29061@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <81f50d91-1df2-5da9-5576-e64f892f9ab3@grimberg.me>
Date: Mon, 19 Jun 2017 17:14:32 +0300
MIME-Version: 1.0
In-Reply-To: <20170619124910.GR29061@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> We intent for these handlers to become generic, thus, add them to
>> the nvme core controller struct.
> 
> Do you remember why we actually need all the different work items?

I remember documenting it at some point, but either it got lost
somewhere or I don't remember...

> We need err_work to recover from RDMA QP-level errors.

transport errors usually detected in soft-irq, so we queue up
err_work to:
1. stop + drain queues
2. fail inflight I/O.
3. queue delayed reconnect (reconnect_work)

> But how is it so different from a reset in that respect?  Similarly why
> do we need reset to be different from reconnect?  Especially as
> reconnect sort of is the reset of fabrics.

Hmm, resets and reconnects are indeed similar, but one difference
is that in resets we do not fail fast inflight I/O as the expectation
is that the recovery should be immediate (it also matches pci with
that respect) while we consider reconnect something that can last
for a while so we fail fast to allow failover and continue reconnect
attempts quietly. Another difference is that failed reset results in
a controller removal while in reconnects we have to exhaust
ctrl_loss_tmo.

We could change things, like merging reconnect and reset and introduce
a concept of "on-host reset". Not sure it will be any less confusing
though...
