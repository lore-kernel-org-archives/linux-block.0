Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.infotech.no ([82.134.31.41]:42679 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeDFAvq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Apr 2018 20:51:46 -0400
Reply-To: dgilbert@interlog.com
Subject: Re: Multi-Actuator SAS HDD First Look
To: Tim Walker <tim.t.walker@seagate.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
 <20180403074637.GB13259@infradead.org>
 <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <4f0eb1fb-7073-e1eb-4386-7813ce662b26@interlog.com>
Date: Thu, 5 Apr 2018 20:51:39 -0400
MIME-Version: 1.0
In-Reply-To: <CANo=J15RFeMiqudiS_+dAuyVsgoPYn2U=iJZh3EhamtX56atWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018-04-05 07:43 PM, Tim Walker wrote:
> On Tue, Apr 3, 2018 at 1:46 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Sat, Mar 31, 2018 at 01:03:46PM +0200, Hannes Reinecke wrote:
>>> Actually I would propose to have a 'management' LUN at LUN0, who could
>>> handle all the device-wide commands (eg things like START STOP UNIT,
>>> firmware update, or even SMART commands), and ignoring them for the
>>> remaining LUNs.
>>
>> That is in fact the only workable option at all.  Everything else
>> completly breaks the scsi architecture.
> 
> Here's an update: Seagate will eliminate the inter-LU actions from
> FORMAT UNIT and SANITIZE. Probably SANITIZE will be per-LUN, but
> FORMAT UNIT is trickier due to internal drive architecture, and how
> FORMAT UNIT initializes on-disk metadata. Likely it will require some
> sort of synchronization across LUNs, such as the command being sent to
> both LUNs sequentially or something similar. We are also considering
> not supporting FORMAT UNIT at all - would anybody object? Any other
> suggestions?

Good, that is progress. [But you still only have one spindle.]

If Protection Information (PI) or changing the logical block size between
512 and 4096 bytes per block are options, then you need FU for that.
But does it need to take 900 minutes like one I got recently from S......?
Couldn't the actual reformatting of a track be deferred until the first
block written to that track?

Doug Gilbert
