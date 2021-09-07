Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2C1C433FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074EA610FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhIGOnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:43:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54278 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGOns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:43:48 -0400
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 187EgVeN033731;
        Tue, 7 Sep 2021 23:42:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Tue, 07 Sep 2021 23:42:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 187EgUc9033725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Sep 2021 23:42:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] block: genhd: don't call blkdev_show() with
 major_names_lock held
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
References: <18a02da2-0bf3-550e-b071-2b4ab13c49f0@i-love.sakura.ne.jp>
 <75efddd1-726c-4065-709c-0c88c03c38ed@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0123937a-2e94-a1f8-110a-ecd0d3d7f0c6@i-love.sakura.ne.jp>
Date:   Tue, 7 Sep 2021 23:42:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <75efddd1-726c-4065-709c-0c88c03c38ed@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/07 23:36, Jens Axboe wrote:
> On 9/7/21 5:52 AM, Tetsuo Handa wrote:
>> The simplest fix is to call probe function without holding
>> major_names_lock [1], but Christoph Hellwig does not like such idea.
>> Therefore, instead of holding major_names_lock in blkdev_show(),
>> introduce a different lock for blkdev_show() in order to break
>> "sb_writers#$N => &p->lock => major_names_lock" dependency chain.
> 
> Agree, that's probably the easiest fix here. Applied, thanks.
> 

Sorry, can you update the patch title to:

block: genhd: don't hold major_names_lock in blkdev_show()
