Return-Path: <linux-scsi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180403074637.GB13259@infradead.org>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de> <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de> <20180403074637.GB13259@infradead.org>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Thu, 5 Apr 2018 17:43:46 -0600
Message-ID: <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
Subject: Re: Multi-Actuator SAS HDD First Look
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, dgilbert <dgilbert@interlog.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 3, 2018 at 1:46 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Mar 31, 2018 at 01:03:46PM +0200, Hannes Reinecke wrote:
>> Actually I would propose to have a 'management' LUN at LUN0, who could
>> handle all the device-wide commands (eg things like START STOP UNIT,
>> firmware update, or even SMART commands), and ignoring them for the
>> remaining LUNs.
>
> That is in fact the only workable option at all.  Everything else
> completly breaks the scsi architecture.

Here's an update: Seagate will eliminate the inter-LU actions from
FORMAT UNIT and SANITIZE. Probably SANITIZE will be per-LUN, but
FORMAT UNIT is trickier due to internal drive architecture, and how
FORMAT UNIT initializes on-disk metadata. Likely it will require some
sort of synchronization across LUNs, such as the command being sent to
both LUNs sequentially or something similar. We are also considering
not supporting FORMAT UNIT at all - would anybody object? Any other
suggestions?

-- 
Tim Walker
Product Design Systems Engineering, Seagate Technology
(303) 775-3770
