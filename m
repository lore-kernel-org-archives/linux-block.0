Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] lightnvm: Convert timers to use timer_setup()
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
In-Reply-To: <e0955c0b-2599-b028-99bb-726e7f03569f@kernel.dk>
Date: Wed, 25 Oct 2017 20:28:42 +0200
Cc: Kees Cook <keescook@chromium.org>,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <D225C63B-0CE2-4F70-AD6C-64EA2C7063AE@lightnvm.io>
References: <20171024153004.GA112705@beast> <05041A94-19A4-42DC-9DA7-5CB0730F4B01@lightnvm.io> <e0955c0b-2599-b028-99bb-726e7f03569f@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> On 25 Oct 2017, at 20.24, Jens Axboe <axboe@kernel.dk> wrote:
>=20
>> On 10/25/2017 01:53 AM, Javier Gonz=C3=A1lez wrote:
>> One thing though: The patch does not apply on top of Jen's for-15/block.
>> It is trivial, but here you have a version that applies.
>=20
> Jens's...
>=20
> It won't work against that tree, as it doesn't have the necessary prep
> patch. We can do this after the merge window opens.

Yes, I had to pick the prep patch manually to test it. Just trying to help, s=
ince I had already adapted the patch...

Javier.=20=
