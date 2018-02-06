Return-Path: <oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 06 Feb 2018 08:44:57 +0100
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org,
 linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
 alban.browaeys@gmail.com, ming.lei@redhat.com, ivan@ludios.org,
 169364@studenti.unimore.it, Serena Ziviani <ziviani.serena@gmail.com>,
 efault@gmx.de
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
In-Reply-To: <20180205190510.5499-2-paolo.valente@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
 <20180205190510.5499-2-paolo.valente@linaro.org>
Message-ID: <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
List-ID: <linux-block@vger.kernel.org>

Hi, Paolo.

I can confirm that this patch fixes cfdisk hang for me. I've also tried 
to trigger the issue Mike has encountered, but with no luck (maybe, I 
wasn't insistent enough, just was doing dd on usb-storage device in the 
VM).

So, with regard to cfdisk hang on usb-storage:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.
