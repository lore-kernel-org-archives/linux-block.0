Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65075 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbdCXRpb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 13:45:31 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "axboe@fb.com" <axboe@fb.com>
CC: "tj@kernel.org" <tj@kernel.org>, "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2 4/4] block: block new I/O just after queue is set as
 dying
Date: Fri, 24 Mar 2017 17:45:09 +0000
Message-ID: <1490377493.3312.11.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
         <20170324123621.5227-5-tom.leiming@gmail.com>
In-Reply-To: <20170324123621.5227-5-tom.leiming@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-03-24 at 20:36 +0800, Ming Lei wrote:=20
> +	/* block new I/O coming */
> +	blk_freeze_queue_start(q);

As I have already mentioned two times, the comment above
blk_freeze_queue_start() should be made more clear. It should mention that
without that call blk_queue_enter() won't check the "dying" flag after it
has been set. If that is not mentioned in a comment the next person who
reads the blk_set_queue_dying() function will wonder why the
blk_freeze_queue_start() call is really needed and whether it can be remove=
d.

>  		/*
>  		 * read pair of barrier in blk_freeze_queue_start(),
>  		 * we need to order reading DEAD flag of .q_usage_counter
> -		 * and reading .mq_freeze_depth, otherwise the following
> -		 * wait may never return if the two read are reordered.
> +		 * and reading .mq_freeze_depth or dying flag, otherwise
> +		 * the following wait may never return if the two read
> +		 * are reordered.
>  		 */
>  		smp_rmb();

Please fix the spelling in the above comment ("two read").

Thanks,

Bart.
