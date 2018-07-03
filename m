Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCT3O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 15:29:14 -0400
Subject: Re: [PATCH 11/14] rq-qos: introduce dio_bio callback
To: Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-12-josef@toxicpanda.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
Date: Tue, 3 Jul 2018 12:29:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-12-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/03/2018 08:15 AM, Josef Bacik wrote:
> From: Josef Bacik <jbacik@fb.com>
> 
> wbt cares only about request completion time, but controllers may need

Please spell out wt^Hbt.
whatever it is.

> information that is on the bio itself, so add a done_bio callback for
> rq-qos so things like blk-iolatency can use it to have the bio when it
> completes.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  block/bio.c        |  4 ++++
>  block/blk-rq-qos.c | 10 ++++++++++
>  block/blk-rq-qos.h |  2 ++
>  3 files changed, 16 insertions(+)


-- 
~Randy
