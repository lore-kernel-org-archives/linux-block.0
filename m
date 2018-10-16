Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH 0/15 v2] loop: Fix oops and possible deadlocks
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 omar Sandoval <osandov@osandov.com>
References: <20181010100415.26525-1-jack@suse.cz>
 <a40fcf62-85a4-a6be-0803-d99dedf8cc61@i-love.sakura.ne.jp>
 <20181010114227.GA12977@linux-x5ow.site>
 <20181010122809.GE11507@quack2.suse.cz>
 <20181016113654.GG18918@quack2.suse.cz>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <224dcf7b-1da2-6ee2-1ead-b41e73cd97c0@suse.de>
Date: Tue, 16 Oct 2018 14:04:08 +0200
MIME-Version: 1.0
In-Reply-To: <20181016113654.GG18918@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 16/10/18 13:36, Jan Kara wrote:
[...]
> 2) For the oops (use-after-free) issue I was not able to reproduce that in
> my test KVM in couple hours. The race window is rather narrow and syzbot
> with KASAN and everything hit it only 11 times. So I'm not sure how useful
> that test is. Any opinions?

Personally I think a test that has varying outcomes depending on how
often you run it (just to hit the race) isn't really suitable for a
suite like blktests.

But that's my personal opinion only, Omar what's your opinion here?

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
