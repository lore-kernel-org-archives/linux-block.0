Return-Path: <jthumshirn@suse.de>
Date: Thu, 6 Apr 2017 20:15:56 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
Message-ID: <20170406181555.GA8215@linux-x5ow.site>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
 <20170406152000.GF3768@linux-x5ow.site>
 <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 10:32:43AM -0500, Eric Sandeen wrote:
> Full-blown xfstests doesn't have /that/ much in the way of deps,
> on debian it's ostensibly just:
> 
>                 sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
>                 e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
>                 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
>                 uuid-runtime
> 
> and lots of that might not be needed for non-fs tests.
> 
> Otherwise well, you do need bash ... ;)

Yeah that's OK. Maybe I misphrased it a bit. No more additional dependencies.
Currently xfstest is "small" engough to be run in an initrd and that's good
for qemu -kernel .. -initrd .. style test runs.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
