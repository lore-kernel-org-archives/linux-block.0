Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [GIT PULL] nvme fixes for 4.20
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181109065654.GA12805@infradead.org>
 <6b8d8562-a31d-bf11-557b-7f33a17d6e60@kernel.dk>
 <20181109132011.GA2706@infradead.org>
 <e1f4b4f5-6679-941f-638f-cdf3394ce773@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <332dc27f-96a9-e171-1f07-54961d443400@grimberg.me>
Date: Fri, 9 Nov 2018 09:10:00 -0800
MIME-Version: 1.0
In-Reply-To: <e1f4b4f5-6679-941f-638f-cdf3394ce773@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> That is because your for-linus was still 4.20-rc based when
>> I created it.
> 
> It's never been 4.20-rc based. After the initial merge, it got based
> on a random commit in the merge window:
> 
> commit 3acbd2de6bc3af215c6ed7732dfc097d1e238503
> Merge: d49f8a52b15b de7d83da84bd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Oct 25 09:00:15 2018 -0700
> 
>      Merge tag 'sound-4.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 
> and has been ever since.

That was because I rebased it when your for-linus didn't include Ming's
buggy version of the brd commit. Sorry for the mixup..
