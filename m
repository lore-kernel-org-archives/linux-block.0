Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbeDFGYU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Apr 2018 02:24:20 -0400
Date: Fri, 6 Apr 2018 08:24:18 +0200
From: Hannes Reinecke <hare@suse.de>
To: Tim Walker <tim.t.walker@seagate.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        dgilbert <dgilbert@interlog.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Multi-Actuator SAS HDD First Look
Message-ID: <20180406082418.127a0ec6@pentland.suse.de>
In-Reply-To: <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
        <20180326170840.0130f366@pentland.suse.de>
        <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
        <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
        <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
        <20180403074637.GB13259@infradead.org>
        <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 5 Apr 2018 17:43:46 -0600
Tim Walker <tim.t.walker@seagate.com> wrote:

> On Tue, Apr 3, 2018 at 1:46 AM, Christoph Hellwig <hch@infradead.org>
> wrote:
> > On Sat, Mar 31, 2018 at 01:03:46PM +0200, Hannes Reinecke wrote:  
> >> Actually I would propose to have a 'management' LUN at LUN0, who
> >> could handle all the device-wide commands (eg things like START
> >> STOP UNIT, firmware update, or even SMART commands), and ignoring
> >> them for the remaining LUNs.  
> >
> > That is in fact the only workable option at all.  Everything else
> > completly breaks the scsi architecture.  
> 
> Here's an update: Seagate will eliminate the inter-LU actions from
> FORMAT UNIT and SANITIZE. Probably SANITIZE will be per-LUN, but
> FORMAT UNIT is trickier due to internal drive architecture, and how
> FORMAT UNIT initializes on-disk metadata. Likely it will require some
> sort of synchronization across LUNs, such as the command being sent to
> both LUNs sequentially or something similar. We are also considering
> not supporting FORMAT UNIT at all - would anybody object? Any other
> suggestions?
> 

Ah. Far better.
What about delegating FORMAT UNIT to the control LUN, and not
implementing it for the individual disk LUNs?
That would make an even stronger case for having a control LUN;
with that there wouldn't be any problem with having to synchronize
across LUNs etc.

Cheers,

Hannes
