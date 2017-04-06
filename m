Return-Path: <sandeen@sandeen.net>
Subject: Re: [PATCH 0/6] RFC add blkdev tests v2
To: Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
References: <1491484750-9164-1-git-send-email-dmonakhov@openvz.org>
 <20170406135524.GA12230@infradead.org>
 <74f90aa0-bb3f-ba74-cdbc-d6e96be51376@kernel.dk>
 <20170406144741.GA27776@infradead.org>
 <bb45e36c-93af-9565-1dc0-a4850aec393c@kernel.dk>
 <20170406152000.GF3768@linux-x5ow.site>
Cc: Christoph Hellwig <hch@infradead.org>,
 Dmitry Monakhov <dmonakhov@openvz.org>, fstests@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <b7b785ef-21a6-19f6-07c6-5dcc3053f274@sandeen.net>
Date: Thu, 6 Apr 2017 10:32:43 -0500
MIME-Version: 1.0
In-Reply-To: <20170406152000.GF3768@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>



On 4/6/17 10:20 AM, Johannes Thumshirn wrote:
> On Thu, Apr 06, 2017 at 08:51:36AM -0600, Jens Axboe wrote:
>> On 04/06/2017 08:47 AM, Christoph Hellwig wrote:
>>> On Thu, Apr 06, 2017 at 08:33:55AM -0600, Jens Axboe wrote:
>>>> That is exactly what my recommendation was at lsfmm as well - fork
>>>> xfstest, prune bits we don't need, and off we go. I'll get around to
>>>> it soonish.
>>>
>>> So you volunteer to do it?  I was -><- this close to offering it myself,
>>> and than thought of all the other backlog I have on my plate :)
>>
>> Yeah, I'll get something cobbled together next week.
> 
> Yay!
> 
> But please keep the dependencies small. It'll suck when we'd have to pull in a
> gazillion megabytes for perl/pyhthon/whatever.

Full-blown xfstests doesn't have /that/ much in the way of deps,
on debian it's ostensibly just:

                sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
                e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
                libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
                uuid-runtime

and lots of that might not be needed for non-fs tests.

Otherwise well, you do need bash ... ;)

-Eric
