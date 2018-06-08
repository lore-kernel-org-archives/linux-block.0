Return-Path: <antlists@youngman.org.uk>
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
To: bingjingc <bingjingc@synology.com>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
 <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
 <8bda8c14-0d38-ca5a-3614-6cfdef099c21@kernel.dk>
 <20180606143307.p7puz56rdcgyk4se@linux-x5ow.site>
 <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 cccheng@synology.com, linux-raid@vger.kernel.org
From: Wols Lists <antlists@youngman.org.uk>
Message-ID: <5B1A97A9.1050003@youngman.org.uk>
Date: Fri, 8 Jun 2018 15:50:17 +0100
MIME-Version: 1.0
In-Reply-To: <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/06/18 03:45, bingjingc wrote:
> I felt sorry. It's first time I realized there is a test suite under
> mdadm project. Now, I am trying to find documentation to get
> it works. I can examine the efforts of migrating them or just
> triggering them from blktests.
> 
> Any ideas from linux-block and linux-raid channels are welcome. :)

Take a look at the raid wiki.

https://raid.wiki.kernel.org/index.php/Linux_Raid

Not knowing anything about raid tests and stuff at the moment, I can't
add that to the wiki (hopefully I'll learn soon), but if there's
anything you think belongs on there, either add it yourself or draft it
and send it to me.

The wiki is currrently being actively edited (by me), but I'm always
wary of adding stuff I don't understand. So if you and the other test
maintainers could create a short page about the test suite, with
pointers to it, it would probably fit neatly under the "Kernel
Programming" section. Then hopefully more people will find out about it.

Cheers,
Wol
