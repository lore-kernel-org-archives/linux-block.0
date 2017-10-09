Return-Path: <kyle.fortin@oracle.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] block: remove unnecessary NULL checks in bioset_integrity_free()
From: Kyle Fortin <kyle.fortin@oracle.com>
In-Reply-To: <20171006222629.GA30627@debian>
Date: Mon, 9 Oct 2017 14:34:18 -0400
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.levin@one.verizon.com
Message-Id: <F0FE45F7-5B2F-4028-A38A-865A58FE8529@oracle.com>
References: <20171005180920.GA121296@debian> <a1d52c34-6d06-1142-0d3e-2604e15ed993@kernel.dk> <20171006222629.GA30627@debian>
To: Tim Hansen <devtimhansen@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Oct 6, 2017, at 6:26 PM, Tim Hansen <devtimhansen@gmail.com> wrote:
> On Fri, Oct 06, 2017 at 01:04:25PM -0600, Jens Axboe wrote:
>> On 10/05/2017 12:09 PM, Tim Hansen wrote:
>>> mempool_destroy() already checks for a NULL value being passed in, =
this eliminates duplicate checks.
>>>=20
>>> This was caught by running make coccicheck M=3Dblock/ on linus' tree =
on commit 77ede3a014a32746002f7889211f0cecf4803163 (current head as of =
this patch).
>>=20
>> Applied, but I had to fix up your commit message. Please line wrap at
>> 72 chars, otherwise it turns into an unreadable mess when people
>> try to view them.
>>=20
>> --=20
>> Jens Axboe
>>=20
>=20
> Noted! Thanks for the heads up on the char limit.

scripts/checkpatch.pl would have caught it too

--
Kyle Fortin - Oracle Linux Engineering
