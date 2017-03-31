Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: constify struct blk_mq_ops
To: Eric Biggers <ebiggers3@gmail.com>, linux-block@vger.kernel.org
References: <20170330203916.122167-1-ebiggers3@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d361b0d6-505e-48b1-1357-cd76a91ae70e@kernel.dk>
Date: Thu, 30 Mar 2017 19:42:41 -0600
MIME-Version: 1.0
In-Reply-To: <20170330203916.122167-1-ebiggers3@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/30/2017 02:39 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Constify all instances of blk_mq_ops, as they are never modified.

Looks good to me, and a nice followup to:

commit f8a5b12247fe18f7fed801ad262a7ab190e1f848
Author: Jens Axboe <axboe@fb.com>
Date:   Tue Dec 13 09:24:51 2016 -0700

    blk-mq: make mq_ops a const pointer
    
    We never change it, make that clear.

as well.

-- 
Jens Axboe
