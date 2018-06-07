Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests 1/9] blktests: add hepler functions for new md
 tests
To: Johannes Thumshirn <jthumshirn@suse.de>,
 bingjingc <bingjingc@synology.com>
Cc: linux-block@vger.kernel.org, cccheng@synology.com,
 linux-raid@vger.kernel.org
References: <1528272400-7128-1-git-send-email-bingjingc@synology.com>
 <20180606084402.vmx4qi42bmj5tmb4@linux-x5ow.site>
 <8bda8c14-0d38-ca5a-3614-6cfdef099c21@kernel.dk>
 <20180606143307.p7puz56rdcgyk4se@linux-x5ow.site>
 <c55cae7e78b069afe98cb5e485fe67b1@synology.com>
 <20180607065524.kohrpiskf4wfhl3t@linux-x5ow.site>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <40c842bf-0413-d385-2c24-5e28604609a1@kernel.dk>
Date: Thu, 7 Jun 2018 06:59:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180607065524.kohrpiskf4wfhl3t@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/7/18 12:55 AM, Johannes Thumshirn wrote:
> On Thu, Jun 07, 2018 at 10:45:02AM +0800, bingjingc wrote:
>> Hi Johannes & Jens,
>>
>> Thank you for your information and positive feedbacks on this patch.
>>
>> I'm also inspired by xfstests, too. Most conventional filesystems
>> have their test cases on it. I believe block layer can also have one.
>>
>> I felt sorry. It's first time I realized there is a test suite under
>> mdadm project. Now, I am trying to find documentation to get
>> it works. I can examine the efforts of migrating them or just
>> triggering them from blktests.
>>
>> Any ideas from linux-block and linux-raid channels are welcome. :)
> 
> Migrating them over would be the best thing since sliced bread. Having
> to run only one test suite for the linux block device space is our
> long term goal.

Fully agree. And don't feel bad about not knowing there's an md test
suite, I didn't either. Which is one of the reasons why having
everything under the blktests umbrella is so important.

-- 
Jens Axboe
