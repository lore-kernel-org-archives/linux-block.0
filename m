Return-Path: <bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 07 Jun 2018 10:45:02 +0800
From: bingjingc <bingjingc@synology.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 cccheng@synology.com, linux-raid@vger.kernel.org
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
In-Reply-To: <20180606143307.p7puz56rdcgyk4se@linux-x5ow.site>
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
 <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
 <8bda8c14-0d38-ca5a-3614-6cfdef099c21@kernel.dk>
 <20180606143307.p7puz56rdcgyk4se@linux-x5ow.site>
Message-ID: <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
List-ID: <linux-block@vger.kernel.org>

Hi Johannes & Jens,

Thank you for your information and positive feedbacks on this patch.

I'm also inspired by xfstests, too. Most conventional filesystems
have their test cases on it. I believe block layer can also have one.

I felt sorry. It's first time I realized there is a test suite under
mdadm project. Now, I am trying to find documentation to get
it works. I can examine the efforts of migrating them or just
triggering them from blktests.

Any ideas from linux-block and linux-raid channels are welcome. :)

All the best,
BingJing

Johannes Thumshirn 於 2018-06-06 22:33 寫到:
> On Wed, Jun 06, 2018 at 08:29:25AM -0600, Jens Axboe wrote:
>> Hopefully this can be the start of migrating over those tests!
> 
> Yes this would be great. I just wanted to connect the submitter and
> the md developers and make them aware of possibly duplicated efforts
> ;-).
