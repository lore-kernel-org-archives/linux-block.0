Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5972C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 12:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiCVMn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiCVMn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 08:43:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93685960
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 05:42:28 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22MCg6fn047424;
        Tue, 22 Mar 2022 21:42:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Tue, 22 Mar 2022 21:42:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22MCg6WP047421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Mar 2022 21:42:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3af48f01-eaca-f17a-a18b-5279c7a4a691@I-love.SAKURA.ne.jp>
Date:   Tue, 22 Mar 2022 21:42:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 8/8] loop: don't destroy lo->workqueue in __loop_clr_fd
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-9-hch@lst.de>
 <20220316112522.7fvzz7hgnyogbkxj@quack3.lan>
 <dd4e3821-24cf-8b65-4851-f90b395a4557@I-love.SAKURA.ne.jp>
 <20220322111017.GB28931@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220322111017.GB28931@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/03/22 20:10, Christoph Hellwig wrote:
> On Wed, Mar 16, 2022 at 10:24:20PM +0900, Tetsuo Handa wrote:
>> Since this WQ is invoked when flushing data to disk, this WQ had better use
>> WQ_MEM_RECLAIM flag when creating. A WQ created with WQ_MEM_RECLAIM flag has
>> at least one "struct task_struct" in order to guarantee forward progress, but
>> results in consuming more kernel resources. Therefore, it is preferable to
>> destroy the WQ when clearing unbinding a loop device from a backing file.
> 
> Whіch then gets us into lock dependency problems.  A previously used
> but lingering around device will use some resources, so what?  If you
> care about the least used resources the only way to get there is to
> destroy the device.

There is no dependency problems and there is no resource wasting if we choose
task_work approach, for that approach runs in lockless context and allows
destroying "struct task_struct" as soon as device is unbound.
