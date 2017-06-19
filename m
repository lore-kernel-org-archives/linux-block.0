Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49559 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753791AbdFSP4H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 11:56:07 -0400
Subject: Re: [PATCH rfc 01/30] nvme: Add admin connect request queue
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-2-git-send-email-sagi@grimberg.me>
 <20170619071314.GA13168@lst.de>
 <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0a807073-ac1d-aa15-f8c4-1b6d6cfb2c35@suse.de>
Date: Mon, 19 Jun 2017 17:56:05 +0200
MIME-Version: 1.0
In-Reply-To: <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/19/2017 09:49 AM, Sagi Grimberg wrote:
> 
>>> In case we reconnect with inflight admin IO we
>>> need to make sure that the connect comes before
>>> the admin command. This can be only achieved by
>>> using a seperate request queue for admin connects.
>>
>> Use up a few more lines of the available space for your lines? :)
> 
> I warned in the cover-letter that the change logs are pure
> negligence at the moment :)
> 
>> Wouldn't a head insertation also solve the problem?
> 
> the head insertion will not protect against it because
> we must invoke blk_mq_start_stopped_hw_queues on the admin_q
> request queue so the admin connect can make progress, at this
> point (and before we actually queue up connect) pending admin
> commands can sneak in...
> 
> However, you raise a valid point, I think I added this before we
> had the queue_is_ready protection, which will reject the command
> if the queue is not LIVE (unless its a connect). I think the reason
> its still in is that I tested this with loop which doesn't have
> a per-queue state machine.
> 
> I'm still wandering if its a good idea to rely on the transport
> queue state to reject non-connect requests on non-LIVE queues.
> if/when we introduce a queue representation to the core and we
> drive the state machine there, then we could actually rely on it
> (I do have some code for it, but its a pretty massive change which
> cannot be added in an incremental fashion).
> 
> Thoughts?

I very much prefer this solution, ie rejecting all commands if the queue
state is not 'LIVE', and make the 'connect' command the only one being
accepted in that state.
(Actually, we would need a state 'READY_TO_CONNECT' or somesuch to make
this work properly.)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
