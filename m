Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbdBBTNa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 14:13:30 -0500
Date: Thu, 2 Feb 2017 14:13:30 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170202191330.GA27107@redhat.com>
References: <1485899692.3113.9.camel@sandisk.com>
 <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
 <1485910862.3113.12.camel@sandisk.com>
 <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
 <1485967586.2560.1.camel@sandisk.com>
 <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
 <1485986472.2560.14.camel@sandisk.com>
 <1486056424.2816.4.camel@sandisk.com>
 <20170202183334.GB26910@redhat.com>
 <1486060991.2816.8.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486060991.2816.8.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02 2017 at  1:43pm -0500,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Thu, 2017-02-02 at 13:33 -0500, Mike Snitzer wrote:
> > I'll go back over hch's changes to see if I can spot anything.  But is
> > this testing using dm_mod.use_bk_mq=Y or are you testing old .request_fn
> > dm-multipath?
> 
> Hello Mike,
> 
> The srp-test software tests multiple configurations: dm-mq on scsi-mq, dm-sq
> on scsi-mq and dm-sq on scsi-sq. I have not yet checked which of these
> three configurations triggers the kernel crash.

OK, such info is important to provide for crashes like this.  Please let
me know once you do.

Thanks,
Mike
