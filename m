Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Subject: RE: [GIT PULL] Block pull request for- 4.11-rc1
Date: Mon, 20 Feb 2017 01:09:58 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
In-Reply-To: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/19/2017 04:11 PM, Jens Axboe wrote:=0A=
> - Removal of the BLOCK_PC support in struct request, and refactoring of=
=0A=
>   carrying SCSI payloads in the block layer. This cleans up the code=0A=
>   nicely, and enables us to kill the SCSI specific parts of struct=0A=
>   request, shrinking it down nicely. From Christoph mainly, with help=0A=
>   from Hannes.=0A=
=0A=
Hello Jens, Christoph and Mike,=0A=
=0A=
Is anyone working on a fix for the regression introduced by the BLOCK_PC re=
moval=0A=
changes (general protection fault) that I had reported three weeks ago? See=
 also=0A=
https://www.spinics.net/lists/raid/msg55494.html=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=
