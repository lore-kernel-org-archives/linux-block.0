Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
 Prabu Thangamuthu <Prabu.T@synopsys.com>,
 Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
 <3fc7786c-af85-d047-047f-44d4eded6124@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C3020BFC2@IN01WEMBXA.internal.synopsys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <af1db53d-9a02-6cf5-f87a-c23ab43478ea@kernel.dk>
Date: Fri, 1 Jun 2018 11:30:54 -0600
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020BFC2@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/1/18 12:27 AM, Ladvine D Almeida wrote:
> On Thursday 31 May 2018 04:46 PM, Jens Axboe wrote:
>> On 5/31/18 1:47 AM, Ladvine D Almeida wrote:
>>> On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:
>>>> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:
>>>>> This patch introduces new variable under bio structure to
>>>>> facilitate inline encryption. This variable is used to
>>>>> associate I/O requests to crypto information.
>>>> Hard no on this, for two reasons:
>>>>
>>>> 1) Any additions to struct bio are scrutinized heavily and
>>>>    need strong justification.
>>> Thanks for sharing your feedback on the patch.
>>> I am providing reference to an earlier article related to inline encryption support below:
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_717754_&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=m8U0bg9QiswO2oVJgJKq3MmJpqPPK_tN667XwsjojcM&s=9VPcl80YTKwbf8T-oCxWTRahYzS2xNDHZMexpFbuepY&e=
>> Took a quick look, and this looks like a classic case of something
>> that should just be a cloned bio. If you clone, you own the bi_private
>> field, which is what you need.
> 
> Cloning the bio gives ownership of the bi_private variable which i can
> use to refer to the crypto context.  But i have the following problem
> here:
> 1. In the dm-crypt subsystem, we clone the bio and assign the
> bi_private variable. Afterwards, generic_make_request() is done to
> submit I/O request to block device.
> 2. The bio will be cloned further in the below layers. The reference
> in the bi_private variable is now lost as the bio_clone function will
> not copy the bi_private variable.
> 
> Also, the bi_private variable is already used in the dm-crypt layer
> for storing its private data. This prevents me from using the same.

If you clone or allocate a bio, you are the owner of bi_private. If
someone further down the stack clones it again, then they own the NEW
bi_private of the newly returned cloned. Nobody will mess with yours,
that would be a layering violation. That is the way to store data on a
per bio basis, not by adding a new random field to the bio structure.

-- 
Jens Axboe
