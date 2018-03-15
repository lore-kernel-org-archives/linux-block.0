Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:48664 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbeCOIZF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 04:25:05 -0400
From: tang.junhui@zte.com.cn
To: kent.overstreet@gmail.com, colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Ask a question about size of ca->heap in bcache
Date: Thu, 15 Mar 2018 16:29:26 +0800
Message-Id: <1521102566-27784-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Mike, Coly, Kent,

As far as I known, ca->heap is used to sort buckets by bucket_prio,
and it would be pushed into ca->free_inc queue after sorting.
I find ca->heap is double the size of the ca->free_inc.
	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
I am puzzled about, we only need the size of ca->free_inc buckets, 
Why do we alloc ca->heap the double size of the ca->free_inc?


Thanks,
Tang Junhui
