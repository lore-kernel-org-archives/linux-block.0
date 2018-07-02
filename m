Return-Path: <jthumshirn@suse.de>
Date: Mon, 2 Jul 2018 15:02:27 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
Message-ID: <20180702130227.gjpblurxccjqechl@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
 <1530536157.13674.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1530536157.13674.4.camel@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 09:55:57PM +0900, Minwoo Im wrote:
> No 2nd follow-up patch will be there. �I thought these two parts are
> using a same unit-function to clear the set->mq-map. �Also thought it
> would be great for the future use when it needs to be cleared.
> However, as you mentioned, I totally agree with your point. �It seems
> just churns for churns' sake with no more usage for now.

I actually mis-read your patch, I'm sorry.

You're consolidating two callers of this so I guess this is not so
problematic. I somehow ignored the first hunk in the patch.

You could still evaluate if it isn't worth to make it:
+static void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+}

and put it into 'include/linux/blk-mq.h'.

    Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
