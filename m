Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33064 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdHPNvf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 09:51:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id n88so3199746wrb.0
        for <linux-block@vger.kernel.org>; Wed, 16 Aug 2017 06:51:34 -0700 (PDT)
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816104935.GA30525@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <de413980-1382-7567-b0d4-3207a4476719@grimberg.me>
Date: Wed, 16 Aug 2017 16:51:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170816104935.GA30525@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Did you get a chance to take a look at converting PCIe over?

I started to play around with it, not anywhere near getting it in
shape though...

> A lot of the design decisions seem to be driven by allowing PCIe
> as well,

That's true.

> and I'd like to see if that's possible / useful to start
> with.
 From what my radar got, it seems feasible. If you look at the nvme-core
routines, they really consists of the abstract part of the controller
initiation. From what I've seen so far, PCIe will require some extra
hooks on top of what we have now (some portion of nvme_pci_enable will
probably need to be added as well, and we'll need some generic
representation for pci device error states). I do expect nvme-core
changes for PCIe, but I don't expect the teardown/initiation structure
to change.

The only real design choice taken to accommodate PCIe was to manage
admin and io queues in the transports instead of nvme-core as queues
release procedure is different in PCIe.

I think its a very desirable goal to have PCIe consolidate with fabrics
here, so I'd like to shoot for that and backoff later (and change again
where makes sense).

Having said that, I'm very much open to suggestions if you have anything
better in mind...
