Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] nbd: fix -ERESTARTSYS handling
To: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
 linux-block@vger.kernel.org
References: <1506975728-30910-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee3c62f9-eaaf-0364-6f4a-d7d14e5037e1@kernel.dk>
Date: Mon, 2 Oct 2017 14:29:31 -0600
MIME-Version: 1.0
In-Reply-To: <1506975728-30910-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/02/2017 02:22 PM, Josef Bacik wrote:
> Christoph made it so that if we return'ed BLK_STS_RESOURCE whenever we
> got ERESTARTSYS from sending our packets we'd return BLK_STS_OK, which
> means we'd never requeue and just hang.  We really need to return the
> right value from the upper layer.

Applied for 4.14, thanks.

-- 
Jens Axboe
