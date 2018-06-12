Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:34778 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934383AbeFLXl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 19:41:56 -0400
From: <Austin.Bolen@dell.com>
To: <keith.busch@linux.intel.com>, <yi.zhang@redhat.com>
CC: <keith.busch@intel.com>, <linux-block@vger.kernel.org>,
        <osandov@osandov.com>, <linux-nvme@lists.infradead.org>,
        <ming.lei@redhat.com>
Subject: Re: blktests block/019 lead system hang
Date: Tue, 12 Jun 2018 23:41:54 +0000
Message-ID: <5a3a2565a81543b5837672e01580a5b5@AUSX13MPC127.AMER.DELL.COM>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 6/5/2018 11:16 AM, Keith Busch wrote:=0A=
> On Wed, May 30, 2018 at 03:26:54AM -0400, Yi Zhang wrote:=0A=
>> Hi Keith=0A=
>> I found blktest block/019 also can lead my NVMe server hang with 4.17.0-=
rc7, let me know if you need more info, thanks. =0A=
>>=0A=
>> Server: Dell R730xd=0A=
>> NVMe SSD: 85:00.0 Non-Volatile memory controller: Samsung Electronics Co=
 Ltd NVMe SSD Controller 172X (rev 01)=0A=
>>=0A=
>> Console log:=0A=
>> Kernel 4.17.0-rc7 on an x86_64=0A=
>>=0A=
>> storageqe-62 login: [ 6043.121834] run blktests block/019 at 2018-05-30 =
03:16:34=0A=
>> [ 6049.108476] {1}[Hardware Error]: Hardware error from APEI Generic Har=
dware Error Source: 3=0A=
>> [ 6049.108478] {1}[Hardware Error]: event severity: fatal=0A=
>> [ 6049.108479] {1}[Hardware Error]:  Error 0, type: fatal=0A=
>> [ 6049.108481] {1}[Hardware Error]:   section_type: PCIe error=0A=
>> [ 6049.108482] {1}[Hardware Error]:   port_type: 6, downstream switch po=
rt=0A=
>> [ 6049.108483] {1}[Hardware Error]:   version: 1.16=0A=
>> [ 6049.108484] {1}[Hardware Error]:   command: 0x0407, status: 0x0010=0A=
>> [ 6049.108485] {1}[Hardware Error]:   device_id: 0000:83:05.0=0A=
>> [ 6049.108486] {1}[Hardware Error]:   slot: 0=0A=
>> [ 6049.108487] {1}[Hardware Error]:   secondary_bus: 0x85=0A=
>> [ 6049.108488] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x87=
34=0A=
>> [ 6049.108489] {1}[Hardware Error]:   class_code: 000406=0A=
>> [ 6049.108489] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, =
control: 0x0003=0A=
>> [ 6049.108491] Kernel panic - not syncing: Fatal hardware error!=0A=
>> [ 6049.108514] Kernel Offset: 0x25800000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xffffffffbfffffff)=0A=
> Sounds like your platform fundamentally doesn't support surprise link=0A=
> down if it considers the event a fatal error. That's sort of what this=0A=
> test was supposed to help catch so we know what platforms can do this=0A=
> vs ones that can't.=0A=
>=0A=
> The test does check that the slot is hotplug capable before running,=0A=
> so it's supposed to only run the test on slots that claim to be capable=
=0A=
> of handling the event. I just don't know of a good way to query platform=
=0A=
> firmware to know what it will do in response to such an event.=0A=
It looks like the test is setting the Link Disable bit.  But this is not=0A=
a good simulation for hot-plug surprise removal testing or surprise link=0A=
down (SLD) testing, if that is the intent.  One reason is that Link=0A=
Disable does not invoke SLD semantics per PCIe spec.  This is somewhat=0A=
of a moot point in this case since the switch has Hot-Plug Surprise bit=0A=
set which also masks the SLD semantics in PCIe.=0A=
=0A=
Also, the Hot-Plug Capable + Surprise Hot-Plug bits set means the=0A=
platform can tolerate the case where "an adapter present in this slot=0A=
might be removed from the system without any prior notification".  It=0A=
does not mean that a system can survive link down under any other=0A=
circumstances such as setting Link Disable or generating a Secondary Bus=0A=
Reset or a true surprise link down event.  To the earlier point, I also=0A=
do not know of any way the OS can know a priori if the platform can=0A=
handle surprise link down outside of surprise remove case.  We can look=0A=
at standardizing a way to do that if OSes find it useful to know.=0A=
=0A=
Relative to this particular error, Link Disable doesn't clear Presence=0A=
Detect State which would happen on a real Surprise Hot-Plug removal=0A=
event and this is probably why the system crashes.  What will happen is=0A=
that after the link goes to disabled state, the ongoing I/O will cause=0A=
MMIO accesses on the drive and that will cause a UR which is an=0A=
uncorrectable PCIe error (ERR_FATAL on R730).  The BIOS on the R730 is=0A=
surprise remove aware (Surprise Hot-Plug =3D 1) and so it will check if=0A=
the device is still present by checking Presence Detect State.  If the=0A=
device is not present it will mask the error and let the OS handle the=0A=
device removal due to hot-plug interrupt(s).  If the device is present,=0A=
as in this case, then the BIOS will escalate to OS as a fatal NMI=0A=
(current R730 platform policy is to only mask errors due to removal).=0A=
=0A=
For future, these servers may report these sort of errors as recoverable=0A=
via the GHES structures in APEI which will allow the OS to recover from=0A=
this non-surprise remove class of error as well.  In the (hopefully=0A=
near) future, the industry will move to DPC as the framework for this=0A=
sort of generic PCIe error handling/recovery but there are architectural=0A=
changes needed that are currently being defined in the relevant=0A=
standards bodies.  Once the architecture is defined it can be=0A=
implemented and tested to verify these sort of test cases pass.=0A=
=0A=
-Austin=0A=
=0A=
=0A=
>=0A=
> _______________________________________________=0A=
> Linux-nvme mailing list=0A=
> Linux-nvme@lists.infradead.org=0A=
> http://lists.infradead.org/mailman/listinfo/linux-nvme=0A=
>=0A=
=0A=
