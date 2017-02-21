Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Feb 2017 11:11:33 -0800
Message-ID: <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sun, Feb 19, 2017 at 4:10 PM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Please pull! Either this pre-merged branch:
>
>   git://git.kernel.dk/linux-block.git for-4.11/linus-merge-signed
>
> or
>
>   git://git.kernel.dk/linux-block.git for-4.11/block-signed
>   git://git.kernel.dk/linux-block.git for-4.11/next-signed

So normally I'd merge them separately, but since you didn't actually
give me explanations for what the two branches were (ie "block-signed
does X, next-signed does Y") I didn't feel like I could write a sane
merge message for the two branches - so I took the pre-merged one.

Which does bring me to my next issue: *your* merge messages suck too.
They don't actually talk about what you are merging and why.

A merge is a commit, and needs to have a message, unless it's really
really obvious (and they seldom are - merges are generally a lot less
obvious than most non-merge commits). So just saying

    Merge branch 'for-4.11/block' into for-4.11/linus-merge

    Signed-off-by: Jens Axboe <axboe@fb.com>

is simply not an acceptable merge message. What are you merging, and why?

Please. We've been very good at having good commit messages in the
kernel. Merges need good commit messages too!

                       Linus
