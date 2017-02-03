Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdBCAmH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 19:42:07 -0500
Date: Thu, 2 Feb 2017 19:42:06 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Message-ID: <20170203004206.GA28599@redhat.com>
References: <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
 <1485986472.2560.14.camel@sandisk.com>
 <1486056424.2816.4.camel@sandisk.com>
 <20170202183334.GB26910@redhat.com>
 <1486060991.2816.8.camel@sandisk.com>
 <20170202191330.GA27107@redhat.com>
 <1486064795.2816.14.camel@sandisk.com>
 <20170202210434.GA27548@redhat.com>
 <20170202211014.GA27604@redhat.com>
 <1486081190.2816.26.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486081190.2816.26.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 02 2017 at  7:20pm -0500,
Bart Van Assche <Bart.VanAssche@sandisk.com> wrote:

> On Thu, 2017-02-02 at 16:10 -0500, Mike Snitzer wrote:
> > Care to try moving the dm_get(md) at the end of dm_start_request() to
> > the beginning of dm_start_request() and report back on whether it helps
> > at all?
> 
> Hello Mike,
> 
> Sorry but I don't see how that could make a difference.

Yeah, I thought about it further after I suggested it and agree that it
shouldn't make a difference (request isn't actually issued during
dm_start_request).

> While we are at it:
> since dm_start_request() calls dm_get() and since rq_completed() calls
> dm_put(), calls to these two functions should always be paired. There is
> only one dm_start_request() call in the dm-mq code, namely the one in
> dm_mq_queue_rq(). However, if map_request() returns DM_MAPIO_REQUEUE then
> rq_completed() is called twice: a first time by
> dm_requeue_original_request() and a second time by the dm_mq_queue_rq().
> Do you agree with this?

Not seeing it.

DM_MAPIO_DELAY_REQUEUE will call dm_requeue_original_request(), but
dm_mq_queue_rq() won't call rq_completed() in that case.

And for DM_MAPIO_REQUEUE dm_mq_queue_rq() will call rq_completed().
