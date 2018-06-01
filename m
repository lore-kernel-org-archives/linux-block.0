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
	"Joao  Pinto" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Date: Fri, 1 Jun 2018 06:27:04 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020BFC2@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
 <3fc7786c-af85-d047-047f-44d4eded6124@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thursday 31 May 2018 04:46 PM, Jens Axboe wrote:=0A=
> On 5/31/18 1:47 AM, Ladvine D Almeida wrote:=0A=
>> On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:=0A=
>>> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:=0A=
>>>> This patch introduces new variable under bio structure to=0A=
>>>> facilitate inline encryption. This variable is used to=0A=
>>>> associate I/O requests to crypto information.=0A=
>>> Hard no on this, for two reasons:=0A=
>>>=0A=
>>> 1) Any additions to struct bio are scrutinized heavily and=0A=
>>>    need strong justification.=0A=
>> Thanks for sharing your feedback on the patch.=0A=
>> I am providing reference to an earlier article related to inline encrypt=
ion support below:=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lwn.net_Articles_=
717754_&d=3DDwICaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3Dz00zRD9ARrwHpe-XSl1OtUp1u=
NKGYoXI1G2DhOaDDBI&m=3Dm8U0bg9QiswO2oVJgJKq3MmJpqPPK_tN667XwsjojcM&s=3D9VPc=
l80YTKwbf8T-oCxWTRahYzS2xNDHZMexpFbuepY&e=3D=0A=
> Took a quick look, and this looks like a classic case of something=0A=
> that should just be a cloned bio. If you clone, you own the bi_private=0A=
> field, which is what you need.=0A=
=0A=
Cloning the bio gives ownership of the bi_private variable which i can use =
to refer to the crypto context.=0A=
But i have the following problem here:=0A=
1. In the dm-crypt subsystem, we clone the bio and assign the bi_private va=
riable. Afterwards, generic_make_request() is done to submit I/O request to=
 block device.=0A=
2. The bio will be cloned further in the below layers. The reference in the=
 bi_private variable is now lost as the bio_clone function will not copy th=
e bi_private variable.=0A=
=0A=
Also, the bi_private variable is already used in the dm-crypt layer for sto=
ring its private data. This prevents me from using the same.=0A=
=0A=
>=0A=
=0A=
Thanks,=0A=
=0A=
Ladvine=0A=
=0A=
