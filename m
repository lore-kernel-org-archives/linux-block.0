Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38162 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbdFSHtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 03:49:19 -0400
Received: by mail-wm0-f47.google.com with SMTP id u195so53708952wmd.1
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2017 00:49:18 -0700 (PDT)
Subject: Re: [PATCH rfc 01/30] nvme: Add admin connect request queue
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-2-git-send-email-sagi@grimberg.me>
 <20170619071314.GA13168@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>
Date: Mon, 19 Jun 2017 10:49:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170619071314.GA13168@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>> In case we reconnect with inflight admin IO we
>> need to make sure that the connect comes before
>> the admin command. This can be only achieved by
>> using a seperate request queue for admin connects.
> 
> Use up a few more lines of the available space for your lines? :)

I warned in the cover-letter that the change logs are pure
negligence at the moment :)

> Wouldn't a head insertation also solve the problem?

the head insertion will not protect against it because
we must invoke blk_mq_start_stopped_hw_queues on the admin_q
request queue so the admin connect can make progress, at this
point (and before we actually queue up connect) pending admin
commands can sneak in...

However, you raise a valid point, I think I added this before we
had the queue_is_ready protection, which will reject the command
if the queue is not LIVE (unless its a connect). I think the reason
its still in is that I tested this with loop which doesn't have
a per-queue state machine.

I'm still wandering if its a good idea to rely on the transport
queue state to reject non-connect requests on non-LIVE queues.
if/when we introduce a queue representation to the core and we
drive the state machine there, then we could actually rely on it
(I do have some code for it, but its a pretty massive change which
cannot be added in an incremental fashion).

Thoughts?
