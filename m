Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] elevator: allow specifying elevator by config boot param
 for blk-mq devices
To: Alex Ivanov <yourbestfriend@openmailbox.org>, linux-block@vger.kernel.org
References: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0661f4cc-a5dc-5747-dd38-de78586843a2@kernel.dk>
Date: Wed, 12 Jul 2017 16:51:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170712185708.5987-1-yourbestfriend@openmailbox.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/12/2017 12:57 PM, Alex Ivanov wrote:
> It's now makes sense to use elevator boot argument when blk-mq is in use,
> since there is now a bunch of schedulers for it (deadline, kyber, bfq, none).

No, that boot option was a mistake, let's not propagate that to mq
scheduling as well.

-- 
Jens Axboe
