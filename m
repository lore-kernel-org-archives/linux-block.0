Return-Path: <axboe@kernel.dk>
Subject: Re: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: Kyungtae Kim <kt0755@gmail.com>
Cc: jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
 DaeRyong Jeong <threeearcat@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
 <fcad3085-6801-71f9-b2cf-4c1702889d70@kernel.dk>
 <CAEAjamtJrbLZyN+f97Y+LOMbogveYNBdxM-pVvfqUMhaGsH2uw@mail.gmail.com>
 <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ad9f11b6-1e3c-8412-ecce-d04a1c8c317a@kernel.dk>
Date: Wed, 24 Oct 2018 03:27:15 -0600
MIME-Version: 1.0
In-Reply-To: <CAEAjams3Y4PE-yDP0FyipCAohOepSF9WgXw3h_CEd1YW+mjS0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/24/18 12:33 AM, Kyungtae Kim wrote:
> Corrected.

You'll want to read Documentation/process/submitting-patches.rst as
your patch is lacking in several areas.


-- 
Jens Axboe
