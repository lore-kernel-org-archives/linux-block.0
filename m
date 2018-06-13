Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:24582 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934737AbeFMRRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 13:17:10 -0400
From: <Austin.Bolen@dell.com>
To: <keith.busch@intel.com>, <Austin.Bolen@dell.com>
CC: <keith.busch@linux.intel.com>, <yi.zhang@redhat.com>,
        <linux-block@vger.kernel.org>, <osandov@osandov.com>,
        <linux-nvme@lists.infradead.org>, <ming.lei@redhat.com>
Subject: Re: blktests block/019 lead system hang
Date: Wed, 13 Jun 2018 17:17:08 +0000
Message-ID: <4d119d6db0174b39b4e7b0b11ea8d5d1@AUSX13MPC127.AMER.DELL.COM>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
 <20180613154415.GC5574@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 6/13/2018 10:41 AM, Keith Busch wrote:=0A=
> Thanks for the feedback!=0A=
> This test does indeed toggle the Link Control Link Disable bit to simulat=
e=0A=
> the link failure. The PCIe specification specifically covers this case=0A=
> in Section 3.2.1, Data Link Control and Management State Machine Rules:=
=0A=
>=0A=
>   If the Link Disable bit has been Set by software, then the subsequent=
=0A=
>   transition to DL_Inactive must not be considered an error.=0A=
>=0A=
> So this test should suppress any Suprise Down Error events, but handling=
=0A=
> that particular event wasn't the intent of the test (and as you mentioned=
,=0A=
> it ought not occur anyway since the slot is HP Surprise capable).=0A=
>=0A=
> The test should not suppress reporting the Data Link Layer State Changed=
=0A=
> slot status. And while this doesn't trigger a Slot PDC status, triggering=
=0A=
> a DLLSC should occur since the Link Status DLLLA should go to 0 when=0A=
> state machine goes from DL_Active to DL_Down, regardless of if a Suprise=
=0A=
> Down Error was detected.=0A=
>=0A=
> The Linux PCIEHP driver handles a DLLSC link-down event the same as=0A=
> a presence detect remove event, and that's part of what this test was=0A=
> trying to cover.=0A=
=0A=
Yes, the R730 could mask the error if OS sets Data Link Layer State=0A=
Changed Enable =3D 1 and could let the OS handle the hot-plug event=0A=
similar to what is done for surprise removal.  Current platform policy=0A=
on R730 is to not do that and only suppress errors related to physical=0A=
surprise removal (PDS =3D 0).  We'll probably forgo the option of=0A=
suppressing any non-surprise remove link down errors even if OS sets=0A=
Data Link Layer State Changed Enable =3D 1 and go straight to the=0A=
containment error recovery model for DPC once the architecture is=0A=
finalized to handle these non-surprise remove related error.  In the=0A=
meantime, it is expected (though not ideal) that this family of servers=0A=
will crash for this particular test.  Ditto for the test that disables=0A=
Memory Space Enable bit in the command register.=0A=
=0A=
-Austin=0A=
=0A=
=0A=
