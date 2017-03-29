Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block-mq: don't re-queue if we get a queue error
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <1490733472-3088-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a489d39e-d651-a961-9714-6ccb41b01f73@kernel.dk>
Date: Wed, 29 Mar 2017 13:19:25 -0600
MIME-Version: 1.0
In-Reply-To: <1490733472-3088-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/28/2017 02:37 PM, Josef Bacik wrote:
> When try to issue a request directly and we fail we will requeue the
> request, but call blk_mq_end_request() as well.  This leads to the
> completed request being on a queuelist and getting ended twice, which
> causes list corruption in schedulers and other shenanigans.

I think this is purely a cosmetic issue, as it should cause no
corruption. But it doesn't make sense to issue a requeue trace,
for instance, if we're just going to end the IO anyway. I have
applied it for 4.12.

-- 
Jens Axboe
