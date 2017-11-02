Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:40334 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdKBCPr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Nov 2017 22:15:47 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: Re: [PATCH] bcache: correct journal bucket reading
Date: Thu, 2 Nov 2017 10:15:31 +0800
Message-Id: <1509588931-25262-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Hello Mike

> > that will be detected immediately and we'll leave the loop with l=0.
> > We should add a comment that we need to try the first index first for
> > correctness so that we don't inadvertently change this behavior.
> > 
> Yes, I read the code again, it's true that hash-search begin with the first
> bucket, so it's OK when circular buffer has wrapped, but another scenario:
> NNNYYYY, I think the last bucket would be lost, since it would get the 7th bucket
> as an invalid bucket (due to return value of 
> find_next_bit(bitmap, ca->sb.njournal_buckets, l + 1)), and would read journal 
> start with the 6th bucket in reverse order, how do you think about?
> 

I read the the code again, and found that find_next_bit() would return 7 in this 
scenario, but the bucket number begin with 0, so the 7th bucket's number is 6, 
so it will take the last bucket as the first bucket to read journal, 
so the 7the bucket would not be lost. I will change this patch to a annotation patch, 
other readers would be easy to understand these codes.

> > One thing took me a long time to convince myself was safe with the
> > original code:  If we have 'YYNYYYYYYY', we'll start at l=0, and then
> > we'll search across the N;  I think this is OK because sequence
> > numbers will cause us to do the right thing.
> 
> As I see, this scenario is OK, because in the step 2, it will try to get the third
> bucket, and then read journal form the second bucket, so no invalid bucket reading 
> across would happen, the reason is in step 2, these buckets after the third bucket 
> can not satisfy the condition:
> if (seq != list_entry(list->prev, struct journal_replay,list)->j.seq)
> so it would get the third bucket as an invalid bucket, and the second bucket as the
> latest valid bucket.

Thanks,
Tang
