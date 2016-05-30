Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58922 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbcE3Ghp (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 30 May 2016 02:37:45 -0400
Subject: Re: [PATCH 0/5] block/target queue/LUN reset support
To: mchristi@redhat.com, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, target-devel@vger.kernel.org
References: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <574BDFB7.5000407@suse.de>
Date: Mon, 30 May 2016 08:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/25/2016 09:54 AM, mchristi@redhat.com wrote:
> Currently, for SCSI LUN_RESETs the target layer can only wait on
> bio/requests it has sent. This normally results in the LUN_RESET
> timing out on the initiator side and that SCSI error handler
> escalating to something more disruptive.
> 
> To fix this, the following patches add a block layer helper and
> callout to reset a request queue which the target layer can use
> to force drivers to complete/fail executing requests.
> 
> Patches were made over Jens's block tree's for-next branch.
> 
In general I like the approach, it just looks as if the main aim (ie
running a LUN RESET concurrent with normal I/O on other devices) is
not quite reached.

The general concept of eh_async_device_reset() is quite nice, and
renaming existing functions for doing so is okay, too.

It's just the integration with SCSI EH which is somewhat deficient
(as outlined in the comment on patch 3).
For the async device reset to work we'd need to call it _before_
SCSI EH is started, ie after the asynchronous command abort failed.

The easiest way would be to add per-device reset workqueue item,
which would be called whenever command abort failed.
As it's being per device we'd be getting an implicit serialisation,
and we could skip the lun reset from EH.

But then I'm not sure if we want to add yet another workqueue to the
scsi device ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
