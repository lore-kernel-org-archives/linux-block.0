Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
Date: Fri, 24 Feb 2017 21:15:39 +0000
Message-ID: <1487970922.2575.10.camel@sandisk.com>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
	 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
	 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
	 <20170220073539.GA17687@lst.de>
	 <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
	 <f9b3b2ca-b19b-7c4a-52bb-789c3e2b39e5@kernel.dk>
	 <1487957968.2575.6.camel@sandisk.com>
	 <CA+55aFw7T8hsZpMfWuo5e=DnsuRjp8cfQzGb8Qeng=RRR61fYA@mail.gmail.com>
	 <0af4ed69-a9d0-44be-701c-ced76b84bfef@kernel.dk>
	 <0dc039e5-58c5-d328-0b81-bf9e7d782675@kernel.dk>
In-Reply-To: <0dc039e5-58c5-d328-0b81-bf9e7d782675@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-02-24 at 13:22 -0700, Jens Axboe wrote:
> Bart, I pushed a fix here:
>=20
> http://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-linus&id=3D61febef4=
0bfe8ab68259d8545257686e8a0d91d1

Hello Jens,

The same test passes against the kernel I obtained by merging your for-linu=
s
branch with the same version of Linus' master branch I mentioned in a previ=
ous
e-mail. Feel free to add my Tested-by to the patch "dm-rq: don't dereferenc=
e
request payload after ending request".

Thanks,

Bart.=
