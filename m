Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64244C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199AF218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 22:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbeLTWUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:20:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40935 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732857AbeLTWUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 17:20:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1564720pfo.7
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 14:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iftm6Jf6cAYAWhZDRpPw22Emx2uCStquR0MzOqs3k3A=;
        b=PNImLJg0na50LGcS9j/it28iIlaP3my9qrf8OgcTYqzUGe40zAvtrprxF5rtqWIf4x
         RMdSVKEZ+k9m0En+SQ/JT5ID8pxuE9Weif51DROhRefK7N/WRzs1ZSfVooEV9OmLNZ4W
         zT+HskipD71XixBc6UWFkitqduK0GN6QSM+rRyPciw4P+M2B/n2/Sew54vp8pO5svrFB
         HhAM9XJ6aZNGX5Xn1l+Vj9T8he4Ll0lF6Ya/492SFQtqOz+U1/A3MhrgLoay7Gaqet1E
         RdPdBR8RpAYTqhEAEWLEuXUmacn56qqL06D6q7QlzMaDaQ9AGzIZX+qT0uHmnYVk0gVF
         vv0Q==
X-Gm-Message-State: AA+aEWaUOHSi7+2roFfxxifXBEn9ALsrV/k/EmK3CvSzhK7YWo3Z0VH8
        WKethdc/nHL8xtbNyV1XueU=
X-Google-Smtp-Source: AFSGD/Vb+W+x6pB1seqgbtFmryq8scnj0nVeuwD5yS1slLFvjEyWE78dyrfWVh0tKo/jrmzzJJkSeg==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr24701148pgb.249.1545344399913;
        Thu, 20 Dec 2018 14:19:59 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a17sm26516658pgm.26.2018.12.20.14.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 14:19:59 -0800 (PST)
Message-ID: <1545344398.185366.531.camel@acm.org>
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 20 Dec 2018 14:19:58 -0800
In-Reply-To: <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
References: <1545261885.185366.488.camel@acm.org>
         <1545265001.185366.496.camel@acm.org>
         <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
         <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
         <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
         <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
         <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
         <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
         <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
         <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
         <1545328865.185366.508.camel@acm.org>
         <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
         <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
         <1545339362.185366.511.camel@acm.org>
         <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
         <1545340987.185366.515.camel@acm.org>
         <120bb59a-af93-7d8c-9afc-7087973632bf@kernel.dk>
         <1545341470.185366.519.camel@acm.org>
         <61515137-0565-e3b7-e6de-554af7d49753@kernel.dk>
         <1545342043.185366.523.camel@acm.org>
         <60b4819c-4c19-a4e3-41f3-e21b0544c9a4@kernel.dk>
         <68c73daa-10e7-29da-b890-bf167ec164c2@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-20 at 14:48 -0700, Jens Axboe wrote:
+AD4 -void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4 -		     unsigned int hctx+AF8-idx)
+AD4 +-static void blk+AF8-mq+AF8-rcu+AF8-free+AF8-pages(struct work+AF8-struct +ACo-work)
+AD4  +AHs
+AD4 +-	struct blk+AF8-mq+AF8-tags +ACo-tags +AD0 container+AF8-of(to+AF8-rcu+AF8-work(work),
+AD4 +-						struct blk+AF8-mq+AF8-tags, rcu+AF8-work)+ADs
+AD4  	struct page +ACo-page+ADs
+AD4  
+AD4 +-	while (+ACE-list+AF8-empty(+ACY-tags-+AD4-page+AF8-list)) +AHs
+AD4 +-		page +AD0 list+AF8-first+AF8-entry(+ACY-tags-+AD4-page+AF8-list, struct page, lru)+ADs
+AD4 +-		list+AF8-del+AF8-init(+ACY-page-+AD4-lru)+ADs
+AD4 +-		/+ACo
+AD4 +-		 +ACo Remove kmemleak object previously allocated in
+AD4 +-		 +ACo blk+AF8-mq+AF8-init+AF8-rq+AF8-map().
+AD4 +-		 +ACo-/
+AD4 +-		kmemleak+AF8-free(page+AF8-address(page))+ADs
+AD4 +-		+AF8AXw-free+AF8-pages(page, page-+AD4-private)+ADs
+AD4 +-	+AH0
+AD4 +-+AH0
+AD4 +-
+AD4 +-void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4 +-		     unsigned int hctx+AF8-idx)
+AD4 +-+AHs
+AD4  	if (tags-+AD4-rqs +ACYAJg set-+AD4-ops-+AD4-exit+AF8-request) +AHs
+AD4  		int i+ADs
+AD4  
+AD4 +AEAAQA -2038,16 +-2061,9 +AEAAQA void blk+AF8-mq+AF8-free+AF8-rqs(struct blk+AF8-mq+AF8-tag+AF8-set +ACo-set, struct blk+AF8-mq+AF8-tags +ACo-tags,
+AD4  		+AH0
+AD4  	+AH0
+AD4  
+AD4 -	while (+ACE-list+AF8-empty(+ACY-tags-+AD4-page+AF8-list)) +AHs
+AD4 -		page +AD0 list+AF8-first+AF8-entry(+ACY-tags-+AD4-page+AF8-list, struct page, lru)+ADs
+AD4 -		list+AF8-del+AF8-init(+ACY-page-+AD4-lru)+ADs
+AD4 -		/+ACo
+AD4 -		 +ACo Remove kmemleak object previously allocated in
+AD4 -		 +ACo blk+AF8-mq+AF8-init+AF8-rq+AF8-map().
+AD4 -		 +ACo-/
+AD4 -		kmemleak+AF8-free(page+AF8-address(page))+ADs
+AD4 -		+AF8AXw-free+AF8-pages(page, page-+AD4-private)+ADs
+AD4 -	+AH0
+AD4 +-	/+ACo Punt to RCU free, so we don't race with tag iteration +ACo-/
+AD4 +-	INIT+AF8-RCU+AF8-WORK(+ACY-tags-+AD4-rcu+AF8-work, blk+AF8-mq+AF8-rcu+AF8-free+AF8-pages)+ADs
+AD4 +-	queue+AF8-rcu+AF8-work(system+AF8-wq, +ACY-tags-+AD4-rcu+AF8-work)+ADs
+AD4  +AH0

This can only work correctly if blk+AF8-mq+AF8-rcu+AF8-free+AF8-pages() is called before
INIT+AF8-RCU+AF8-WORK() is called a second time for the same bkl+AF8-mq+AF8-tags structure
and if blk+AF8-mq+AF8-rcu+AF8-free+AF8-pages() is called before struct blk+AF8-mq+AF8-tags is freed.
What provides these guarantees? Did I perhaps miss something?

Thanks,

Bart.
