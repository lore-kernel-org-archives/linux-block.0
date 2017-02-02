Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:60576
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751038AbdBBTq6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 14:46:58 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "snitzer@redhat.com" <snitzer@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Thu, 2 Feb 2017 19:46:49 +0000
Message-ID: <1486064795.2816.14.camel@sandisk.com>
References: <1485899692.3113.9.camel@sandisk.com>
         <2085a3e6-25fc-d104-35cb-38995d154fd2@kernel.dk>
         <1485910862.3113.12.camel@sandisk.com>
         <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
         <1485967586.2560.1.camel@sandisk.com>
         <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
         <1485986472.2560.14.camel@sandisk.com>
         <1486056424.2816.4.camel@sandisk.com> <20170202183334.GB26910@redhat.com>
         <1486060991.2816.8.camel@sandisk.com> <20170202191330.GA27107@redhat.com>
In-Reply-To: <20170202191330.GA27107@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-02-02 at 14:13 -0500, Mike Snitzer wrote:
> On Thu, Feb 02 2017 at  1:43pm -0500, Bart Van Assche <Bart.VanAssche@san=
disk.com> wrote:
> > On Thu, 2017-02-02 at 13:33 -0500, Mike Snitzer wrote:
> > > I'll go back over hch's changes to see if I can spot anything.  But i=
s
> > > this testing using dm_mod.use_bk_mq=3DY or are you testing old .reque=
st_fn
> > > dm-multipath?
> >=20
> > The srp-test software tests multiple configurations: dm-mq on scsi-mq, =
dm-sq
> > on scsi-mq and dm-sq on scsi-sq. I have not yet checked which of these
> > three configurations triggers the kernel crash.
>=20
> OK, such info is important to provide for crashes like this.  Please let
> me know once you do.

Hello Mike,

Apparently it's the large I/O test (using dm-mq on scsi-mq) that triggers t=
he
crash:

# ~bart/software/infiniband/srp-test/run_tests -r 10
[ ... ]
Test /home/bart/software/infiniband/srp-test/tests/02-sq-on-mq succeeded
Running test /home/bart/software/infiniband/srp-test/tests/03 ...
Test large transfer sizes with cmd_sg_entries=3D255
removing /dev/mapper/mpatht:=A0[ CRASH ]

The source code of the test I ran is available at
https://github.com/bvanassche/srp-test.

Bart.=
