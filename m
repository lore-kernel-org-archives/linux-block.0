Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Mon, 9 Apr 2018 02:25:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Douglas Gilbert <dgilbert@interlog.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Tim Walker <tim.t.walker@seagate.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Multi-Actuator SAS HDD First Look
Message-ID: <20180409092522.GA9394@infradead.org>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
 <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
 <20180406082418.127a0ec6@pentland.suse.de>
 <20180406064236.GA17456@infradead.org>
 <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <361c204d-f9be-978a-5778-81ecaeb143e0@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 06, 2018 at 01:09:08PM -0400, Douglas Gilbert wrote:
> So you found a document that outlines NVMe's architecture! Could you
> share the url (no marketing BS, please)?

You can always take a look at the actual spec:

http://nvmexpress.org/wp-content/uploads/NVM-Express-1_3a-20171024_ratified.pdf

But in summary: while in SCSI your Nexus for any command is with the
logic unit, in NVMe it is with the controller.   Many admin commands
operate on the whole controller.

> And a serious question ... How would you map NVMe's (in Linux)
> subsystem number, controller device minor number, CNTLID field
> (Identify ctl response) and namespace id onto the SCSI subsystem's
> h:c:t:l ?

I wouldn't because the scheme already doesn't make any sense for SCSI,
nevermind should we try to map NVMe into a scsi specific worldview.

> 
> Doug Gilbert
> 
---end quoted text---
