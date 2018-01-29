Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbeA2MQf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jan 2018 07:16:35 -0500
Subject: Re: [PATCH] bcache: finish incremental GC
To: tang.junhui@zte.com.cn
Cc: mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1517227093-25602-1-git-send-email-tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Message-ID: <ed937ba2-63b3-f4ee-b900-8fec8fcba412@suse.de>
Date: Mon, 29 Jan 2018 20:16:24 +0800
MIME-Version: 1.0
In-Reply-To: <1517227093-25602-1-git-send-email-tang.junhui@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 29/01/2018 7:58 PM, tang.junhui@zte.com.cn wrote:
> From: Tang Junhui <tang.junhui@zte.com.cn>
> 
> In GC thread, we record the latest GC key in gc_done, which is expected
> to be used for incremental GC, but in currently code, we didn't realize
> it. When GC runs, front side IO would be blocked until the GC over, it
> would be a long time if there is a lot of btree nodes.
> 
> This patch realizes incremental GC, the main ideal is that, when there
> are front side I/Os, after GC some nodes (100), we stop GC, release locker
> of the btree node, and go to process the front side I/Os for some times
> (100 ms), then go back to GC again.
> 
> By this patch, when we doing GC, I/Os are not blocked all the time, and
> there is no obvious I/Os zero jump problem any more.
> 
> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>

Hi Junhui,

It sounds great :-) Currently I am not very familiar with gc code, I
need some time to understand how bcache GC works before providing my
feedback. Please give me some time, I hope I am able to provide my
comment after Chinese Spring Festival.

Hope other people may have a look before I am able to.

Thanks.

Coly Li



[code snip]
