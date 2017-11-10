Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] ide: ide-atapi: fix compile error with defining macro
 DEBUG
To: Hongxu Jia <hongxu.jia@windriver.com>, hch@lst.de,
 Bart.VanAssche@wdc.com, linux-block@vger.kernel.org
References: <1510300757-21098-1-git-send-email-hongxu.jia@windriver.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <36db4737-bad5-384b-0db3-486abb7483ce@kernel.dk>
Date: Fri, 10 Nov 2017 08:30:07 -0700
MIME-Version: 1.0
In-Reply-To: <1510300757-21098-1-git-send-email-hongxu.jia@windriver.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/10/2017 12:59 AM, Hongxu Jia wrote:
> Compile ide-atapi failed with defining macro "DEBUG"
> ...
> |drivers/ide/ide-atapi.c:285:52: error: 'struct request' has
> no member named 'cmd'; did you mean 'csd'?
> |  debug_log("%s: rq->cmd[0]: 0x%x\n", __func__, rq->cmd[0]);
> ...
> 
> Since we split the scsi_request out of struct request, it missed
> do the same thing on debug_log

Thanks, applied.

-- 
Jens Axboe
