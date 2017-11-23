Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:47228 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbdKWBJE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 20:09:04 -0500
From: tang.junhui@zte.com.cn
To: huarui.dev@gmail.com
Cc: colyli@suse.de, mlyle@lyle.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, tang.junhui@zte.com.cn
Subject: Re: Re: [bug report] bcache stucked when writting jounrnal 
Date: Thu, 23 Nov 2017 09:08:45 +0800
Message-Id: <1511399325-3617-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hi, RuiHua:

> I have met the similar problem once.
> It looks like a deadlock between the cache device register thread and
> bcache_allocator thread.
> 
> The trace info tell us the journal is full, probablely the allocator
> thread waits on bch_prio_write()->prio_io()->bch_journal_meta(), but
> there is no RESERVE_BTREE buckets to use for journal replay at this
> time, so register thread waits on
> bch_journal_replay()->bch_btree_insert()
> 
> The path which your register command possibly blocked:
> run_cache_set()
>   -> bch_journal_replay()
>       -> bch_btree_insert()
>           -> btree_insert_fn()
>               -> bch_btree_insert_node()
>                   -> btree_split()
>                       -> btree_check_reserve() ----here we find
> RESERVE_BTREE buckets is empty, and then schedule out...
> 
> bch_allocator_thread()
>   ->bch_prio_write()
>      ->bch_journal_meta()
> 
> 
> You can apply this patch to your code and try to register again. This
> is for your reference only. Because this patch was not verified in my
> environment, because my env was damaged last time before I dig into
> code and write this patch, I hopefully it can resolve your problem:-)
Thanks very much, your advice and pathch gave me a lot of inspiration,
I will do an further analysis, and apply this patch then have a try again.

Thanks,
Tang
