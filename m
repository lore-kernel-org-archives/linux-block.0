Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60421 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbeCaLDv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Mar 2018 07:03:51 -0400
Subject: Re: Multi-Actuator SAS HDD First Look
To: Tim Walker <tim.t.walker@seagate.com>,
        dgilbert <dgilbert@interlog.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
Date: Sat, 31 Mar 2018 13:03:46 +0200
MIME-Version: 1.0
In-Reply-To: <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/30/2018 03:07 PM, Tim Walker wrote:
> Hi Doug-
> 
> Currently, the dual actuator firmware safely spins the drive down if
> either LUN receives the START STOP UNIT command.  In other words, if
> LUN1 receives the command, it will flush any dirty data from LUN1l and
> LUN0, then spin down, taking both LUN1 & LUN0 off line. Alternatively,
> we've had input that either:
> a) Both LUNs must receive the START STOP UNIT command before the drive
> will spin down, OR
> b) Move the storage to LUN1 & LUN2, keeping LUN0 (with no storage) for
> device specific commands such as START STOP UNIT that do not directly
> access the media.
> 
That will get interesting when suspending the device; physical
interactions between independent LUNs are always tricky. And I don't
even want to imagine the implications when assigning each LUN to
individual VM guests; shutting down one VM will also interfere with the
other VM ... shudder.

Actually I would propose to have a 'management' LUN at LUN0, who could
handle all the device-wide commands (eg things like START STOP UNIT,
firmware update, or even SMART commands), and ignoring them for the
remaining LUNs.

I guess that would make the whole setup easier to handle.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
