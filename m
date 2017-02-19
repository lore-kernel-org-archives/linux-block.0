Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33738 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdBSGFk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2017 01:05:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170217082752.GA18258@lst.de>
References: <1487257943-72264-1-git-send-email-hare@suse.de>
 <20170216170519.GA9630@localhost.localdomain> <c889eed7-6262-2e54-0b1e-1d833c033324@suse.de>
 <20170217082752.GA18258@lst.de>
From: Mike Snitzer <snitzer@redhat.com>
Date: Sun, 19 Feb 2017 00:59:06 -0500
Message-ID: <CAMM=eLfpNCxj4yegh3vNGYawh0X+-ya3ZHjoPC9ogRKGa8azFw@mail.gmail.com>
Subject: Re: [PATCHv2] scsi: use 'scsi_device_from_queue()' for scsi_dh
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Bart van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 3:27 AM, Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Feb 17, 2017 at 09:06:14AM +0100, Hannes Reinecke wrote:
> > We could, but why?
> > ATM we're only having SCSI devices able to use device handler; adding
> > another layer of indirection doesn't solve anything here.
> > Moving the infrastructure one level up will only make sense if we're
> > getting non-SCSI device handler (ANA?), but until then I'd think it's
> > just overengineering.
>
> Agreed.  Independent of what does the balancing between queues hardware
> handler should be attached by the low-level driver for any future
> transport without any control from DM.

But doesn't Keith's abstraction makes a lot of sense given that you're
providing a device handler interface for NVMe?

The most important part of scsi_dh that DM uses is its calls to
scsi_dh_activate.  Attachment isn't interesting or the issue (DM's
call to scsi_dh_attach is purely legacy now that SCSI attaches the
proper scsi_dh during SCSI's device scan).
