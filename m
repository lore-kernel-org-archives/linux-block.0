Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk> <CA+55aFw-SYg8nOqEx=i1meGzifojYWVbLtVHEnVqQxPsvus7qg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Feb 2017 15:02:37 -0800
Message-ID: <CA+55aFxr-jpdwViA1Y7AiP9WEh4Eutad0_XDnBH2BNtyGYPd5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hmm. The new config options are incomprehensible and their help
messages don't actually help.

So can you fill in the blanks on what

  Default single-queue blk-mq I/O scheduler
  Default multi-queue blk-mq I/O scheduler

config options mean, and why they default to none?

The config phase of the kernel is one of the worst parts of the whole
project, and adding these kinds of random and incomprehensible config
options does *not* help.

                  Linus
