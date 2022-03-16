Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD34EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiCPN0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 09:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbiCPN0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 09:26:02 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C51081
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 06:24:47 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22GDOOBG057582;
        Wed, 16 Mar 2022 22:24:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 16 Mar 2022 22:24:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22GDOOFQ057578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Mar 2022 22:24:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <dd4e3821-24cf-8b65-4851-f90b395a4557@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Mar 2022 22:24:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 8/8] loop: don't destroy lo->workqueue in __loop_clr_fd
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-9-hch@lst.de>
 <20220316112522.7fvzz7hgnyogbkxj@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220316112522.7fvzz7hgnyogbkxj@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/16 20:25, Jan Kara wrote:
> On Wed 16-03-22 09:45:19, Christoph Hellwig wrote:
>> There is no need to destroy the workqueue when clearing unbinding
>> a loop device from a backing file.  Not doing so on the other hand
>> avoid creating a complex lock dependency chain involving the global
>> system_transition_mutex.
>>
>> Based on a patch from Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>.
>>
>> Reported-by: syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I don't recommend this change.

Since this WQ is invoked when flushing data to disk, this WQ had better use
WQ_MEM_RECLAIM flag when creating. A WQ created with WQ_MEM_RECLAIM flag has
at least one "struct task_struct" in order to guarantee forward progress, but
results in consuming more kernel resources. Therefore, it is preferable to
destroy the WQ when clearing unbinding a loop device from a backing file.

