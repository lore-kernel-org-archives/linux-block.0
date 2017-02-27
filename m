Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35222 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdB0R14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2017 12:27:56 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so14466525wmu.2
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2017 09:27:55 -0800 (PST)
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
To: Keith Busch <keith.busch@intel.com>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
 <20170227150107.GA5789@localhost.localdomain>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Marc MERLIN <marc@merlins.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
Date: Mon, 27 Feb 2017 19:27:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170227150107.GA5789@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>>> If the block layer has entered requests and gets a CPU hot plug event
>>> prior to the resume event, it will wait for those requests to exit. If
>>> the nvme driver is shutting down, it will not start the queues back up,
>>> preventing forward progress.
>>>
>>> To fix that, this patch freezes the request queues when the driver intends
>>> to shut down the controller so that no new requests may enter.  After the
>>> controller has been disabled, the queues will be restarted to force all
>>> entered requests to end in failure so that blk-mq's hot cpu notifier may
>>> progress. To ensure the queue usage count is 0 on a shutdown, the driver
>>> waits for freeze to complete before completing the controller shutdown.
>>
>> Keith, can you explain (again) for me why is the freeze_wait must happen
>> after the controller has been disabled, instead of starting the queues
>> and waiting right after freeze start?
>
> Yeah, the driver needs to make forward progress even if the controller
> isn't functioning. If we do the freeze wait before disabling the
> controller, there's no way to reclaim missing completions. If the
> controller is working perfectly, it'd be okay, but the driver would be
> stuck if there's a problem.

OK, I think we can get it for fabrics too, need to figure out how to
handle it there too.

Do you have a reproducer?
