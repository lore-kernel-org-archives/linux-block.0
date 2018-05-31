Return-Path: <Ladvine.DAlmeida@synopsys.com>
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Manjunath M  Bettegowda" <Manjunath.MB@synopsys.com>,
	Prabu Thangamuthu <Prabu.T@synopsys.com>,
	Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Date: Thu, 31 May 2018 07:47:35 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:=0A=
> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:=0A=
>> This patch introduces new variable under bio structure to=0A=
>> facilitate inline encryption. This variable is used to=0A=
>> associate I/O requests to crypto information.=0A=
> Hard no on this, for two reasons:=0A=
>=0A=
> 1) Any additions to struct bio are scrutinized heavily and=0A=
>    need strong justification.=0A=
=0A=
Thanks for sharing your feedback on the patch.=0A=
I am providing reference to an earlier article related to inline encryption=
 support below:=0A=
https://lwn.net/Articles/717754/=0A=
=0A=
In the Existing approach, the crypto transformation happens on the I/O requ=
ests before=0A=
they are actually submitted to the block level drivers for the payload tran=
sfer. This is=0A=
accomplished using the software algorithms or crypto accelerators invoked b=
y the=0A=
device mapper or the file systems.=0A=
=0A=
The inline encryption engine sits inside the controller(unlike the crypto a=
ccelerators). The=0A=
challenging part now is that we cannot perform encryption outside controlle=
r and there=0A=
is a need to communicate this crypto information to the block device driver=
s so they can=0A=
use the same for forming the transfer requests to the controller. This is p=
ossible=0A=
only by associating the bio to the crypto information, because the crypto c=
ontext is=0A=
different for individual I/O requests.=0A=
=0A=
This modification is generic that it can be used by any host controllers wi=
th the inline encryption=0A=
engine like UFS Host Controller, Mobile Storage Host Controller etc.=0A=
=0A=
>=0A=
> 2) Without an actual use case, any change is always denied.=0A=
>    This is just a stand-alone patch.=0A=
=0A=
The Use case is supporting the Inline Encryption Engine inside the UFS Host=
 Controller.=0A=
UFS Host Controller has multiple key slots available for use. Each key slot=
 can be used when=0A=
we setup disks for encryption using different keys with the device mapper.=
=0A=
When the I/O requests happens on each disks configured, there is a need to =
associate the bio to=0A=
crypto context before submitting the bio to the block layer. UFS Host Contr=
oller driver will use this=0A=
information from the bio to form the UTRD requests with associated Key ID(d=
ifferent ID for different=0A=
key slots). The actual encryption happens inside the controller for the I/O=
 requests making use of the=0A=
key programmed in the key slot associated to same.=0A=
=0A=
The List of patches related to the Inline Encryption support are shared bel=
ow:=0A=
https://lkml.org/lkml/2018/5/28/1027=0A=
https://lkml.org/lkml/2018/5/28/1153=0A=
https://lkml.org/lkml/2018/5/28/1196=0A=
https://lkml.org/lkml/2018/5/28/1158=0A=
https://lkml.org/lkml/2018/5/28/1173=0A=
https://lkml.org/lkml/2018/5/28/1178=0A=
=0A=
The implementation has been tested for Full Disk Encryption using the UFS H=
ost Controller=0A=
with inline encryption engine on Synopsys HAPS-70 FPGA-based Prototyping Sy=
stem. We seen=0A=
a considerable performance improvement over the traditional approach of usi=
ng crypto=0A=
accelerators that much overhead involved in the device mapper layer can now=
 be avoided.=0A=
=0A=
>=0A=
> On top of that, you have it inside BLK_CGROUP, which is=0A=
> probably not what you want.=0A=
=0A=
Yes. It has to be corrected.=0A=
=0A=
>=0A=
Best Regards,=0A=
=0A=
Ladvine=0A=
=0A=
