Return-Path: <jthumshirn@suse.de>
Date: Thu, 7 Jun 2018 08:55:24 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: bingjingc <bingjingc@synology.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	cccheng@synology.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
Message-ID: <20180607065524.kohrpiskf4wfhl3t@linux-x5ow.site>
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
 <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
 <8bda8c14-0d38-ca5a-3614-6cfdef099c21@kernel.dk>
 <20180606143307.p7puz56rdcgyk4se@linux-x5ow.site>
 <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 07, 2018 at 10:45:02AM +0800, bingjingc wrote:
> Hi Johannes & Jens,
> 
> Thank you for your information and positive feedbacks on this patch.
> 
> I'm also inspired by xfstests, too. Most conventional filesystems
> have their test cases on it. I believe block layer can also have one.
> 
> I felt sorry. It's first time I realized there is a test suite under
> mdadm project. Now, I am trying to find documentation to get
> it works. I can examine the efforts of migrating them or just
> triggering them from blktests.
> 
> Any ideas from linux-block and linux-raid channels are welcome. :)

Migrating them over would be the best thing since sliced bread. Having
to run only one test suite for the linux block device space is our
long term goal.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
