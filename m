Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48025 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbcFAGFE (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 1 Jun 2016 02:05:04 -0400
Subject: Re: [PATCH 0/5] block/target queue/LUN reset support
To: Mike Christie <mchristi@redhat.com>, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, target-devel@vger.kernel.org
References: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
 <574BDFB7.5000407@suse.de> <574DEC57.7090701@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <574E7B0D.4080401@suse.de>
Date: Wed, 1 Jun 2016 08:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <574DEC57.7090701@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/31/2016 09:56 PM, Mike Christie wrote:
> On 05/30/2016 01:37 AM, Hannes Reinecke wrote:
>> On 05/25/2016 09:54 AM, mchristi@redhat.com wrote:
>>> Currently, for SCSI LUN_RESETs the target layer can only wait on
>>> bio/requests it has sent. This normally results in the LUN_RESET
>>> timing out on the initiator side and that SCSI error handler
>>> escalating to something more disruptive.
>>>
>>> To fix this, the following patches add a block layer helper and
>>> callout to reset a request queue which the target layer can use
>>> to force drivers to complete/fail executing requests.
>>>
>>> Patches were made over Jens's block tree's for-next branch.
>>>
>> In general I like the approach, it just looks as if the main aim (ie
>> running a LUN RESET concurrent with normal I/O on other devices) is
>> not quite reached.
>>
>> The general concept of eh_async_device_reset() is quite nice, and
>> renaming existing functions for doing so is okay, too.
>>
>> It's just the integration with SCSI EH which is somewhat deficient
>> (as outlined in the comment on patch 3).
>> For the async device reset to work we'd need to call it _before_
>> SCSI EH is started, ie after the asynchronous command abort failed.
> 
> Yes that is my plan.
> 
> However, these first patches are only to allow LIO to be able to do
> resets. I need the same infrastructure for both though.
> 
>>
>> The easiest way would be to add per-device reset workqueue item,
>> which wold be called whenever command abort failed.
> 
> If you want to do this without stopping the entire host, you need the
> patches like in this set where we stop and flush a queue.
> 
Sure.

>> As it's being per device we'd be getting an implicit serialisation,
>> and we could skip the lun reset from EH.
> 
> To build on my patches for a new async based scsi eh what we want to do is:
> 
> 0. Add eh_async_target_reset callout which works like async device reset
> one. For iscsi this maps to iscsi_eh_session_reset. FC drivers have
> something similar in the code paths that call rc_remote_port_delete and
> the terminate_rport_io paths. We just need wrappers.
> 
Actually, I was wondering whether we could layer the new async EH
infrastructure besides the original EH.

And the current 'target_reset' is completely wrong.
SAM-2 did away with the TARGET RESET TMF, so it's anyones guess if
a target reset is actually _implemented_.
What we really need, though, is a new 'eh_async_transport_reset'
function, which would reset the _transport_.
A transport failure is currently main (and I'm even tempted to say
the only) reason why EH is invoked.

> 1. scsi_times_out would kick off abort if needed and return
> BLK_EH_RESET_TIMEOUT.
> 2. If abort fails, cancel queued aborts and call new async device reset
> callout in these patches.
> 3. If device reset fails call new async target reset callout.
> 4. if target reset fails, let fail the block timeout timer and do the
> old style scsi eh host reset.
> 
I would suggest to replace 3. and 4. with:

3. If device reset fails call the new async transport reset callout
4. If transport reset fails fallback to the original SCSI EH
   (which would have abort and device reset callouts unset, so
   it'll start with a target reset)

That way we keep the existing behaviour (so we don't need to touch
the zillions of SCSI parallel drivers) _and_ will be able to model a
reasonably modern error handling.

> It is really simple for newer drivers/classes like FC and iSCSI because
> they handle the device and target/port level reset clean up already. The
> difficult (not really difficult but messy) part is trying to support old
> and new style EHs in a functions like scsi_times_out and scsi_abort_command.
> 
And indeed, that's the challenge.
But your patchset is a step into the right direction.
I see if I can make progress with it, although I'm currently busy
doing the next release so it might take some time.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
