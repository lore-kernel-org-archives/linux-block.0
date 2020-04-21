Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC897C54FC9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47A02076C
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 13:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUNQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:16:10 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:9717 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1728337AbgDUNQK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 09:16:10 -0400
X-ASG-Debug-ID: 1587474915-0e4088442b28caf0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.203]) by bsf01.didichuxing.com with ESMTP id qOX4xHi6bpReJhP8; Tue, 21 Apr 2020 21:15:15 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Apr
 2020 21:15:14 +0800
Date:   Tue, 21 Apr 2020 21:15:09 +0800
From:   weiping zhang <zhangweiping@didichuxing.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Weiping Zhang <zhangweiping@didiglobal.com>
Subject: Re: [PATCH v3 4/7] block: free both map and request
Message-ID: <20200421131504.GA19549@192.168.3.9>
X-ASG-Orig-Subj: Re: [PATCH v3 4/7] block: free both map and request
Mail-Followup-To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
 <e6368cfce3dca5238e8546e5624bbcab17824083.1586199103.git.zhangweiping@didiglobal.com>
 <69f621d2-2e88-e920-813f-cba97dbe3cd3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69f621d2-2e88-e920-813f-cba97dbe3cd3@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.203]
X-Barracuda-Start-Time: 1587474915
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2377
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.42
X-Barracuda-Spam-Status: No, SCORE=-1.42 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81316
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 01:58:54PM -0700, Bart Van Assche wrote:
> On 4/6/20 12:36 PM, Weiping Zhang wrote:
> >For this error handle, it should free both map and request,
> >otherwise memleak occur.
>             ^^^^^^^
> Please expand this into "a memory leak".
> 
> >diff --git a/block/blk-mq.c b/block/blk-mq.c
> >index 4692e8232699..406df9ce9b55 100644
> >--- a/block/blk-mq.c
> >+++ b/block/blk-mq.c
> >@@ -2990,7 +2990,7 @@ static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
> >  out_unwind:
> >  	while (--i >= 0)
> >-		blk_mq_free_rq_map(set->tags[i]);
> >+		blk_mq_free_map_and_requests(set, i);
> >  	return -ENOMEM;
> >  }
> 
> The current upstream implementation is as follows:
> 
> static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> {
> 	int i;
> 
> 	for (i = 0; i < set->nr_hw_queues; i++)
> 		if (!__blk_mq_alloc_rq_map(set, i))
> 			goto out_unwind;
> 
> 	return 0;
> 
> out_unwind:
> 	while (--i >= 0)
> 		blk_mq_free_rq_map(set->tags[i]);
> 
> 	return -ENOMEM;
> }
> 
> The pointers to the memory allocated by __blk_mq_alloc_rq_map() are
> stored in set->tags[i] and set->tags[i]->static_rqs.
> blk_mq_free_rq_map() frees set->tags[i]->static_rqs and
> set->tags[i]. In other words, I don't see which memory is leaked.
> What did I miss?

Hi Bart,

__blk_mq_alloc_rq_map
	blk_mq_alloc_rq_map
		blk_mq_alloc_rq_map
			tags = blk_mq_init_tags : kzalloc_node:
			tags->rqs = kcalloc_node
			tags->static_rqs = kcalloc_node
	blk_mq_alloc_rqs
		p = alloc_pages_node
		tags->static_rqs[i] = p + offset;

but

blk_mq_free_rq_map
	kfree(tags->rqs);
	kfree(tags->static_rqs);
	blk_mq_free_tags
		kfree(tags);

The page allocated in blk_mq_alloc_rqs cannot be released,
so we should use blk_mq_free_map_and_requests here,

blk_mq_free_map_and_requests
	blk_mq_free_rqs
		__free_pages : cleanup for blk_mq_alloc_rqs
	blk_mq_free_rq_map : cleanup for blk_mq_alloc_rq_map
		...

The reason why I rename some functions in previous three patches is
that, these function not only allocate rq_map but also requests.

How about rename them like this:
__blk_mq_alloc_rq_map	=> __blk_mq_alloc_map_and_request
__blk_mq_alloc_rq_maps	=> __blk_mq_alloc_map_and_requests,
blk_mq_alloc_rq_maps	=> blk_mq_alloc_map_and_requests

Thanks

> 
> Thanks,
> 
> Bart.
