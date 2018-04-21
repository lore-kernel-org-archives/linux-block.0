Return-Path: <axboe@kernel.dk>
Subject: Re: question about request merge
To: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc: linux-block <linux-block@vger.kernel.org>, shli <shli@fb.com>
References: <tencent_3EE363D56CC01F783CB5D300@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1b30a9a0-fffe-4a02-e9f7-95b28501dbb4@kernel.dk>
Date: Sat, 21 Apr 2018 10:23:17 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_3EE363D56CC01F783CB5D300@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/21/18 8:07 AM, Zhengyuan Liu wrote:
> 2018-04-20 22:34 GMT+08:00 Jens Axboe <axboe@kernel.dk>:
>> On 4/19/18 9:51 PM, Zhengyuan Liu wrote:
>>> Hi, Shaohua
>>>
>>> I found it indeed doesn't do front merge when two threads flush plug list  concurrently.   To
>>> reappear , I prepared two IO threads , named a0.io and a1.io .
>>> Thread a1.io  uses libaio to write 5 requests :
>>>     sectors: 16 + 8, 40 + 8, 64 + 8, 88 + 8, 112 + 8
>>> Thread a0.io  uses libaio to write other 5 requests :
>>>     sectors: 8+ 8, 32 + 8, 56 + 8, 80 + 8, 104 + 8
>>
>> I'm cutting some of the below.
>>
>> Thanks for the detailed email. It's mostly on purpose that we don't
>> spend cycles and memory on maintaining a separate front merge hash,
>> since it's generally not something that happens very often. If you have
>> a thread pool doing IO and split sequential IO such that you would
>> benefit a lot from front merging, then I would generally claim that
>> you're not writing your app in the most optimal manner.
>>
> 
> Thanks for explanation, I only consider the problem through the code's 
> perspective and ignore the reality situation of app. 

That's quite by design and not accidental.

>> So I'm curious, what's the big interest in front merging?
> 
> If it's not something that happens so much often, I think it's not worth to 
> support front merging too.
> 
> By the way, I got another question that why not  blktrace tracing the back
> merging of requests while flushing plugged requests to queue,  if it does
> we may get a more clear view about IO merging.

Not sure I follow, exactly where is a back merge trace missing?

-- 
Jens Axboe
