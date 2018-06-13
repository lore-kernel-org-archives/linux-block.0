Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:8787 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935006AbeFMSYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 14:24:16 -0400
From: <Austin.Bolen@dell.com>
To: <keith.busch@intel.com>, <Austin.Bolen@dell.com>
CC: <keith.busch@linux.intel.com>, <yi.zhang@redhat.com>,
        <linux-block@vger.kernel.org>, <osandov@osandov.com>,
        <linux-nvme@lists.infradead.org>, <ming.lei@redhat.com>
Subject: Re: blktests block/019 lead system hang
Date: Wed, 13 Jun 2018 18:24:14 +0000
Message-ID: <2bbfd07208a84856a2d4dcb833671a82@AUSX13MPC127.AMER.DELL.COM>
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
>=0A=
> This test does indeed toggle the Link Control Link Disable bit to simulat=
e=0A=
> the link failure. The PCIe specification specifically covers this case=0A=
> in Section 3.2.1, Data Link Control and Management State Machine Rules:=
=0A=
>=0A=
>   If the Link Disable bit has been Set by software, then the subsequent=
=0A=
>   transition to DL_Inactive must not be considered an error.=0A=
Forgot to mention... this PCIe requirement to not treat Link Disable =3D 1=
=0A=
as an error is a requirement on PCIe hardware and not from platform=0A=
side.  So if you want to test this PCIe spec requirement then you need a=0A=
way to ascertain whether PCIe hardware or platform is causing the=0A=
error.  Additionally, setting Link Disable is not what is causing the=0A=
error in this specific case.  The error is coming from a subsequent MMIO=0A=
that is causing UR since link is down.=0A=
=0A=
-Austin=0A=
=0A=
=0A=
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
>=0A=
=0A=
