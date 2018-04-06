Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDFGmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Apr 2018 02:42:39 -0400
Date: Thu, 5 Apr 2018 23:42:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Tim Walker <tim.t.walker@seagate.com>,
        Christoph Hellwig <hch@infradead.org>,
        dgilbert <dgilbert@interlog.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Multi-Actuator SAS HDD First Look
Message-ID: <20180406064236.GA17456@infradead.org>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
 <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180406082418.127a0ec6@pentland.suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 06, 2018 at 08:24:18AM +0200, Hannes Reinecke wrote:
> Ah. Far better.
> What about delegating FORMAT UNIT to the control LUN, and not
> implementing it for the individual disk LUNs?
> That would make an even stronger case for having a control LUN;
> with that there wouldn't be any problem with having to synchronize
> across LUNs etc.

It sounds to me like NVMe might be a much better model for this drive
than SCSI, btw :)
