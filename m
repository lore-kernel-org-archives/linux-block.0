Subject: Re: [PATCH] mm: don't cap request size based on read-ahead setting
To: Hillf Danton <hillf.zj@alibaba-inc.com>, akpm@linux-foundation.org
References: <1479498073-8657-1-git-send-email-axboe@fb.com>
 <00f001d243b1$f489a720$dd9cf560$@alibaba-inc.com>
Cc: hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <2c4651e5-dcab-6cda-cc8c-ad0b9350a240@fb.com>
Date: Mon, 21 Nov 2016 06:12:56 -0700
MIME-Version: 1.0
In-Reply-To: <00f001d243b1$f489a720$dd9cf560$@alibaba-inc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/20/2016 09:44 PM, Hillf Danton wrote:
> On Saturday, November 19, 2016 3:41 AM Jens Axboe wrote:
>> We ran into a funky issue, where someone doing 256K buffered reads saw
>> 128K requests at the device level. Turns out it is read-ahead capping
>> the request size, since we use 128K as the default setting. This doesn't
>> make a lot of sense - if someone is issuing 256K reads, they should see
>> 256K reads, regardless of the read-ahead setting, if the underlying
>> device can support a 256K read in a single command.
>>
> Is it also making any sense to see 4M reads to meet 4M requests if
> the underlying device can support 4M IO?

Depends on the device, but yes. Big raid set? You definitely want larger
requests. Which is why we have the distinction between max hardware and
kernel IO size.

By default we limit the soft IO size to 1280k for a block device. See
also:

commit d2be537c3ba3568acd79cd178327b842e60d035e
Author: Jeff Moyer <jmoyer@redhat.com>
Date:   Thu Aug 13 14:57:57 2015 -0400

     block: bump BLK_DEF_MAX_SECTORS to 2560

-- 
Jens Axboe
