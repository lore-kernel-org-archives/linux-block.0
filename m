Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbeDCHqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Apr 2018 03:46:43 -0400
Date: Tue, 3 Apr 2018 00:46:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Tim Walker <tim.t.walker@seagate.com>,
        dgilbert <dgilbert@interlog.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Multi-Actuator SAS HDD First Look
Message-ID: <20180403074637.GB13259@infradead.org>
References: <CANo=J14FGXJO4O6pwRpKTceE6RgmiKn2Bp16UxP0SDCbJDiqnQ@mail.gmail.com>
 <20180326170840.0130f366@pentland.suse.de>
 <1c800f70-0d50-bc5b-3b73-e36a1cea0eec@interlog.com>
 <CANo=J149RC8eYDecihdUdOsxNsaz0jMxCo==whbwEUOkAu-yPg@mail.gmail.com>
 <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1957da6-04af-d336-e4c9-440dbed1c1a9@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 31, 2018 at 01:03:46PM +0200, Hannes Reinecke wrote:
> Actually I would propose to have a 'management' LUN at LUN0, who could
> handle all the device-wide commands (eg things like START STOP UNIT,
> firmware update, or even SMART commands), and ignoring them for the
> remaining LUNs.

That is in fact the only workable option at all.  Everything else
completly breaks the scsi architecture.
