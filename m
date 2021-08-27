Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26555C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 11:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0438D60F58
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 11:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhH0LeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 07:34:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60871 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhH0LeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 07:34:19 -0400
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17RBXBbw099775;
        Fri, 27 Aug 2021 20:33:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Fri, 27 Aug 2021 20:33:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17RBXBOW099772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Aug 2021 20:33:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 5/8] loop: merge the cryptoloop module into the main loop
 module
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Milan Broz <gmazyland@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
References: <20210826133810.3700-1-hch@lst.de>
 <20210826133810.3700-6-hch@lst.de>
 <977860f6-efc4-a55e-50e3-c5204fc762c5@gmail.com>
 <20210826163422.GA28718@lst.de>
 <ebfe4404-e251-ec0d-e46d-0a02b031bcb2@gmail.com>
 <20210827064505.GA23147@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3a2fcf7b-f5d6-bb12-65c7-c2ebc5975383@i-love.sakura.ne.jp>
Date:   Fri, 27 Aug 2021 20:33:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210827064505.GA23147@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/27 15:45, Christoph Hellwig wrote:
> On Thu, Aug 26, 2021 at 06:44:32PM +0200, Milan Broz wrote:
>> Yes, I know that removal is far disturbing thing here, if it
>> can be planned for removal later, I think it is the best thing to do...
>>
>> And I would like to know actually if there are existing users
>> (and how and why they are using this interface - it cannot be configured
>> through losetup for years IIRC).
> 
> We could just try to drop it entirely and see if anyone screams.  You
> are probably right that no one will.
> 

I recommend that we only add a patch to deprecate cryptoloop module with
a printk() when people actually try to use cryptoloop module, and then
eventually remove cryptoloop module. But that is absolutely after my patches.

You are repeatedly failing to fix this problem because you are trying to fix
a different extra thing simply because you don't like the nasty locking interactions.

I posted "[PATCH v5] block: genhd: don't call probe function with major_names_lock held"
( https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp ) for v5.14 (and also stable),
and "[PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock"
( https://lkml.kernel.org/r/2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp ) for v5.15 (but not stable).

Any of your further series that claims to fix this problem is invalid
until you review and fully understand my patches. You are still missing what
the loop_ctl_mutex is serializing. The loop_ctl_mutex is used for serializing
"idr_alloc() + add_disk()" sequence versus "del_gendisk() + idr_remove()"
sequence.

Your assumption in PATCH 7/8 is broken because idr_alloc() will succeed and
add_disk() will be called as soon as idr_remove() is called, and you wrongly
assumes that the Lo_deleting state can prevent further lookups. No, idr_remove()
cannot prevent further "idr_alloc() + add_disk()". In other words, idr_remove()
must not be called before del_gendisk() completes. That serialization is currently
handled by the loop_ctl_mutex, and my latter patch safely removes the loop_ctl_mutex
(at the risk of possibly changing the userspace's behavior; that's why my latter
patch is not for v5.14 but for v5.15. My former patch is for v5.14 because it has
no risk of possibly changing the userspace's behavior).

Don't try to merge the cryptoloop module into the loop module now; it makes
backporting the fix difficult. After applying my patches, applying your PATCH 1,2,3/8
will be OK as a cleanup, and your PATCH 4/8 would be OK given that several weeks
of testing are done in linux-next tree. But never your PATCH 5,6,7,8/8. You can't
fix this problem now if you try to do a different thing together.
