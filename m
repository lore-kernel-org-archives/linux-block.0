Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F0FC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 13:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E84C21741
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 13:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MomQd/M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbeLTNHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:07:38 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:44207 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTNHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 08:07:38 -0500
Received: by mail-pl1-f173.google.com with SMTP id e11so861962plt.11
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3/94S2sVPPChaiudj0sYjdspWjnGVDBApri5K5qeXk0=;
        b=MomQd/M1Hy9mQLGqfxC+WfeBCrYEyZkWj99qzFaBjlpDljInvPhbRB0wDeHZu9DFUW
         ejQHeMQTz9WK2wfsmUyH+If65kq8MyZernUVg+NOOyuz1Fb6vN4lIU7vc9++IKZ2KJwQ
         1SwEWlkFycGWazyBrGJ0uHEPKRWIb7GiZYamuajpDsSGZjhk1B2rTMx9O43fVPHwDiRi
         GzkyI1aYWutt7Y/WGPXSTWZyAPCeAU4yo+yHQHaTvC9H61IaUyBoc8ovLK3Lv2ZpqvPv
         Zh8P+6eTZFCldIcmRv6rY85p0cC6W4O718WRcxyz5UBwGHPEHfJRUUK7YaWQ4Q47tbJJ
         Kxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/94S2sVPPChaiudj0sYjdspWjnGVDBApri5K5qeXk0=;
        b=qfCAT4GNlNff02mvEGB8ni8ndqtqHqpxR2XQ/q9+phuLd0D6Vs86tYllJiCGQ7D7DK
         wDm/dlSmJLYOgT5c7YZ2GnkrZJ3Snd6muUolXiSu+V2B2MC6gghhxa8tXAS+Oz0+dqQy
         WXZ5ymweKWXPsrLXtop/DAe2W/q4e4InNfcgGt28/iHQwczz03/W7Ueyd+rViUWxxIOt
         R0v9UBASWxcMkWnfx34PfxFvmgi5XUmLLqYZ44y/Kpb+J9Erx8yQIRDpQjBoAJ6+Xk50
         HXbvxm4248f58eyySDwdjjANhCXTas9mkjOUCKuDXRsjpZTIkhvUSn3yIc9Fpn9UrYDW
         IPLg==
X-Gm-Message-State: AA+aEWYBPjRsmoWcegATov6RHdh23aTxZ7c974R+87Pu/eRcb2f1exjH
        5Tz8MnbIceItiHAt8TEV+51GTZj+FVxkHA==
X-Google-Smtp-Source: AFSGD/XNvdhWP6YtYKur4dgXnh2N/tT/rlNCBzRaEljuLxVEUjA1DLG9Be9ZfF91xKUrM//RDqwiYA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr24435539plb.55.1545311256737;
        Thu, 20 Dec 2018 05:07:36 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d68sm29080953pfa.64.2018.12.20.05.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:07:35 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
From:   Jens Axboe <axboe@kernel.dk>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
Message-ID: <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
Date:   Thu, 20 Dec 2018 06:07:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 6:02 AM, Jens Axboe wrote:
>> I'm afraid this cannot work.
>>
>> The 'tags' here could be the hctx->sched_tags, but what we need to
>> clear is hctx->tags->rqs[].
> 
> You are right, of course, a bit too quick on the trigger. This one
> should work better, and also avoids that silly quadratic loop. I don't
> think we need the tag == -1 check, but probably best to be safe.

Sent out the wrong one, here it is. Bart, if you can reproduce, can you
give it a whirl?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2de972857496..fc04bb648f18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2025,7 +2025,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	struct page *page;
 
-	if (tags->rqs && set->ops->exit_request) {
+	if (tags->rqs) {
 		int i;
 
 		for (i = 0; i < tags->nr_tags; i++) {
@@ -2033,8 +2033,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 			if (!rq)
 				continue;
-			set->ops->exit_request(set, rq, hctx_idx);
+			if (set->ops->exit_request)
+				set->ops->exit_request(set, rq, hctx_idx);
 			tags->static_rqs[i] = NULL;
+
+			if (rq->tag == -1)
+				continue;
+			if (set->tags[hctx_idx]->rqs[rq->tag] == rq)
+				set->tags[hctx_idx]->rqs[rq->tag] = NULL;
 		}
 	}
 
@@ -2113,6 +2119,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			return ret;
 	}
 
+	rq->tag = -1;
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	return 0;
 }

-- 
Jens Axboe

