Return-Path: <axboe@kernel.dk>
Subject: Re: question about request merge
To: Zhengyuan Liu <liuzhengyuan@kylinos.cn>, shli <shli@fb.com>
Cc: linux-block <linux-block@vger.kernel.org>
References: <tencent_2DB1C4E822C7BE2363B8A451@qq.com>
 <tencent_4B199E7C402C9C6F6664BDE6@qq.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b00cefb6-d267-57f5-442c-1105ce15d39a@kernel.dk>
Date: Fri, 20 Apr 2018 08:34:11 -0600
MIME-Version: 1.0
In-Reply-To: <tencent_4B199E7C402C9C6F6664BDE6@qq.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/19/18 9:51 PM, Zhengyuan Liu wrote:
> Hi, Shaohua
> 
> I found it indeed doesn't do front merge when two threads flush plug list  concurrently.   To 
> reappear , I prepared two IO threads , named a0.io and a1.io .
> Thread a1.io  uses libaio to write 5 requests : 
>     sectors: 16 + 8, 40 + 8, 64 + 8, 88 + 8, 112 + 8
> Thread a0.io  uses libaio to write other 5 requests : 
>     sectors: 8+ 8, 32 + 8, 56 + 8, 80 + 8, 104 + 8

I'm cutting some of the below.

Thanks for the detailed email. It's mostly on purpose that we don't
spend cycles and memory on maintaining a separate front merge hash,
since it's generally not something that happens very often. If you have
a thread pool doing IO and split sequential IO such that you would
benefit a lot from front merging, then I would generally claim that
you're not writing your app in the most optimal manner.

So I'm curious, what's the big interest in front merging?

-- 
Jens Axboe
