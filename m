Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: queue lock must be acquired when iterating over
 rls
To: Tahsin Erdogan <tahsin@google.com>, linux-block@vger.kernel.org
References: <20170201063650.15060-1-tahsin@google.com>
Cc: linux-kernel@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f436a02e-19b6-5c2a-8139-526d9d4eace9@kernel.dk>
Date: Wed, 1 Feb 2017 14:31:53 -0800
MIME-Version: 1.0
In-Reply-To: <20170201063650.15060-1-tahsin@google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 01/31/2017 10:36 PM, Tahsin Erdogan wrote:
> blk_set_queue_dying() does not acquire queue lock before it calls
> blk_queue_for_each_rl(). This allows a racing blkg_destroy() to
> remove blkg->q_node from the linked list and have
> blk_queue_for_each_rl() loop infitely over the removed blkg->q_node
> list node.

Thanks, applied.

-- 
Jens Axboe
