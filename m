Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E272C433EF
	for <linux-block@archiver.kernel.org>; Sat, 12 Feb 2022 08:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiBLI2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Feb 2022 03:28:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiBLI2b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Feb 2022 03:28:31 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55526AF9
        for <linux-block@vger.kernel.org>; Sat, 12 Feb 2022 00:28:27 -0800 (PST)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21C8SFv8067107;
        Sat, 12 Feb 2022 17:28:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 12 Feb 2022 17:28:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21C8SE4h067104
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Feb 2022 17:28:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cf0d2a39-3301-ecc6-12b5-e8e204812c71@I-love.SAKURA.ne.jp>
Date:   Sat, 12 Feb 2022 17:28:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] block: add filemap_invalidate_lock_killable()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <0000000000007305e805d4a9e7f9@google.com>
 <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
 <YdPzygDErbQffQMM@infradead.org>
 <8b2a61cb-4850-8bd7-3ff3-cebebefdb01b@I-love.SAKURA.ne.jp>
In-Reply-To: <8b2a61cb-4850-8bd7-3ff3-cebebefdb01b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/04 22:26, Tetsuo Handa wrote:
> On 2022/01/04 16:14, Christoph Hellwig wrote:
>> On Mon, Jan 03, 2022 at 07:49:11PM +0900, Tetsuo Handa wrote:
>>> syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
>>> minutes with mapping->invalidate_lock held. Since fallocate() has to accept
>>> size > MAX_RW_COUNT bytes, we can't predict how long it will take. Thus,
>>> mitigate this problem by using killable wait where possible.
>>
>> Well, but that also means we want all other users of the invalidate_lock
>> to be killable, as fallocate vs fallocate synchronization is probably
>> not the interesting case.
> 
> Right. But being responsive to SIGKILL is generally preferable.
> 
> syzbot (and other syzkaller based fuzzing) is reporting many hung task reports,
> but many of such reports are simply overstressing.
> 
> We can't use killable lock wait for release operation because it is a "void"
> function. But we can use killable lock wait for majority of operations which
> are not "void" functions. Use of killable lock wait where possible can improve
> situation.
> 

If there is no alternative, can we apply this patch?
