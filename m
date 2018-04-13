Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:48478 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeDMHpg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Apr 2018 03:45:36 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 3/4] bcache: notify allocator to prepare for GC
Date: Fri, 13 Apr 2018 15:45:17 +0800
Message-Id: <1523605517-20887-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly

Thanks for you comments.
> Hi Junhui,
> 
> This method is complicated IMHO. 
The main idea of this patch is:

		GC thread						allocator thread
==>triggered by sectors_to_gc
   set ca->prepare_gc to GC_PREPARING
   to notify allocator thread to
   prepare for GC					==>detect ca->prepare_gc is 
										GC_PREPARING, fill the 
										go to invalidate_buckets(),
==>waiting for allocator 				and fill free_inc queue with
   thread to prepare over				reclaimable buckets, after
										that, set ca->prepare_gc to
										GC_PREPARED to notify GC
										thread being prepared OK
==>detect ca->prepare_gc is
   prepared OK, set 
   ca->prepare_gc back to 
   GC_PREPARE_NONE, and continue GC

> Why not in bch_allocator_thread()
> simple call wake_up_gc(ca->set) after invalidate_buckets() ?
In this patch, GC is triggered by sectors_to_gc, and I/Os from front side
continue exist, so we notify allocator to pack the free_inc queue
full of buckets before GC, then we could have enough buckets for front side
I/Os during GC period.

Maybe the code is somewhat redundant, I will try to refactoring the code
in the next patch.

                                 
Thanks.                                                                      
Tang Junhui                              
