Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0045.outbound.protection.outlook.com ([104.47.42.45]:15136
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751570AbdBCAUO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 19:20:14 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "snitzer@redhat.com" <snitzer@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Fri, 3 Feb 2017 00:20:07 +0000
Message-ID: <1486081190.2816.26.camel@sandisk.com>
References: <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
         <1485967586.2560.1.camel@sandisk.com>
         <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
         <1485986472.2560.14.camel@sandisk.com>
         <1486056424.2816.4.camel@sandisk.com> <20170202183334.GB26910@redhat.com>
         <1486060991.2816.8.camel@sandisk.com> <20170202191330.GA27107@redhat.com>
         <1486064795.2816.14.camel@sandisk.com> <20170202210434.GA27548@redhat.com>
         <20170202211014.GA27604@redhat.com>
In-Reply-To: <20170202211014.GA27604@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-02-02 at 16:10 -0500, Mike Snitzer wrote:
> Care to try moving the dm_get(md) at the end of dm_start_request() to
> the beginning of dm_start_request() and report back on whether it helps
> at all?

Hello Mike,

Sorry but I don't see how that could make a difference. While we are at it:
since dm_start_request() calls dm_get() and since rq_completed() calls
dm_put(), calls to these two functions should always be paired. There is
only one dm_start_request() call in the dm-mq code, namely the one in
dm_mq_queue_rq(). However, if map_request() returns DM_MAPIO_REQUEUE then
rq_completed() is called twice: a first time by
dm_requeue_original_request() and a second time by the dm_mq_queue_rq().
Do you agree with this?

Thanks,

Bart.=
