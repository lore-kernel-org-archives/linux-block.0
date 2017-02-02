Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:26496
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751153AbdBBSnu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 13:43:50 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "snitzer@redhat.com" <snitzer@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Thu, 2 Feb 2017 18:43:42 +0000
Message-ID: <1486060991.2816.8.camel@sandisk.com>
References: <4D024E85-CDE7-4FB0-B8CA-F2B8C86CCFCB@kernel.dk>
         <1485898487.3113.7.camel@sandisk.com> <1485899692.3113.9.camel@sandisk.com>
         <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
         <1485910862.3113.12.camel@sandisk.com>
         <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
         <1485967586.2560.1.camel@sandisk.com>
         <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
         <1485986472.2560.14.camel@sandisk.com>
         <1486056424.2816.4.camel@sandisk.com> <20170202183334.GB26910@redhat.com>
In-Reply-To: <20170202183334.GB26910@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-02-02 at 13:33 -0500, Mike Snitzer wrote:
> I'll go back over hch's changes to see if I can spot anything.  But is
> this testing using dm_mod.use_bk_mq=3DY or are you testing old .request_f=
n
> dm-multipath?

Hello Mike,

The srp-test software tests multiple configurations: dm-mq on scsi-mq, dm-s=
q
on scsi-mq and dm-sq on scsi-sq. I have not yet checked which of these
three configurations triggers the kernel crash.

Bart.=
