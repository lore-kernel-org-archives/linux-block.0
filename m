Subject: Re: [PATCH 3/5] nbd: use flags instead of bool
To: Joe Perches <joe@perches.com>, Josef Bacik <jbacik@fb.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com, mpa@pengutronix.de, nbd-general@lists.sourceforge.net
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <1473369130-22986-4-git-send-email-jbacik@fb.com>
 <1473384038.13672.23.camel@perches.com>
 <bda72452-8a5f-8a6a-2409-145585ea41f5@fb.com>
 <1473437068.13672.41.camel@perches.com>
 <9ddc6c54-72cd-b3d4-d7f3-f96dc33164fc@fb.com>
 <1473437700.13672.43.camel@perches.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <26a66a56-2d37-4945-ec68-72f33f203bdd@fb.com>
Date: Fri, 9 Sep 2016 10:20:47 -0600
MIME-Version: 1.0
In-Reply-To: <1473437700.13672.43.camel@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/09/2016 10:15 AM, Joe Perches wrote:
> On Fri, 2016-09-09 at 10:11 -0600, Jens Axboe wrote:
>> The variable is called 'runtime_flags' - if that doesn't already tell
>> the reader how it's used, then I'd suggest the reader go read something
>> else.
>>
>> I'm all for using established APIs where it makes sense. Declaring a
>> bitmap for a few fields isn't that.
>
> Deviating from established APIs makes no sense.

Look, doing set/test/clear bit on an unsigned long is a very well
established API. We've been doing that _forever_. As I said in my
original email, I have nothing against using bitmaps _where they make
sense_. Manually allocating an array for X number of bits (where X >
32), yes, by all means use the bitmap helpers.

This is my final reply on this topic.

-- 
Jens Axboe
