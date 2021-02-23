Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB12C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0972364E31
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhBWHNT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:13:19 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55960 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhBWHNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:13:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UPLAMgz_1614064353;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UPLAMgz_1614064353)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Feb 2021 15:12:34 +0800
To:     linux-block@vger.kernel.org, dan.j.williams@intel.com
From:   JeffleXu <jefflexu@linux.alibaba.com>
Subject: [Question] Question on blk_freeze_queue()
Message-ID: <31f4af05-89d9-90a4-86f9-5b61387dfef2@linux.alibaba.com>
Date:   Tue, 23 Feb 2021 15:12:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I have some questions on blk_freeze_queue() and related functions. I
would appreciate if someone could help me.

There's only blk_mq_unfreeze_queue(), without blk_XXX version (e.g.,
blk_unfreeze_queue()).

As the comment (introduced by commit
3ef28e83ab15799742e55fd13243a5f678b04242 ("block: generic request_queue
reference counting")) of blk_freeze_queue says:

```
void blk_freeze_queue(struct request_queue *q)
{
	/*
	 * In the !blk_mq case we are only calling this to kill the
	 * q_usage_counter, otherwise this increases the freeze depth
	 * and waits for it to return to zero.  For this reason there is
	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
	 * exported to drivers as the only user for unfreeze is blk_mq.
	 */
	blk_freeze_queue_start(q);
	blk_mq_freeze_queue_wait(q);
}
```

I can't understand why blk_unfreeze_queue() is unnecessary for bio-based
devices, in other words, why q->mq_freeze_depth won't be greater than 1
in blk_freeze_queue_start() for !blk_mq cases. Is that because in
!blk_mq cases (bio-based devices, e.g., dm), blk_freeze_queue() won't be
called in a nested way?

If that's the case, then I can see
blk_mq_freeze_queue()/blk_mq_unfreeze_queue() are used in pair in
blk-iolatency.c:iolatency_set_limit() and
blk-sysfs.c:queue_wb_lat_store(), for example. Though I'm not familiar
with iolatency or wbt, an intuition shows that they shall also apply to
bio-based devices (e.g., dm). Please let me know if I'm wrong.


-- 
Thanks,
Jeffle
