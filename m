Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33493 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdFSQVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 12:21:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so17368482wmh.0
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 09:21:13 -0700 (PDT)
Subject: Re: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when
 reallocating io queues
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-29-git-send-email-sagi@grimberg.me>
 <20170619072148.GE13168@lst.de> <20170619080622.GA396@ming.t460p>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e8698703-fcbd-bbfb-9904-c8af86b26cd1@grimberg.me>
Date: Mon, 19 Jun 2017 19:21:10 +0300
MIME-Version: 1.0
In-Reply-To: <20170619080622.GA396@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> Could use a changelog.
>>
>> Ming: does this solve your problem of not seeing the new queues
>> after a qemu CPU hotplug + reset?
> 
> The issue I observed is that there isn't NVMe reset triggered after
> CPU becomes online.

This won't help with that.

> It may take a while since the test need to apply the whole patchset.
> Or is it fine to figure out one fix on this issue? Sagi?

No need, all this doesn't even touch pci for now...
