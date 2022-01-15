Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8000C433EF
	for <linux-block@archiver.kernel.org>; Sat, 15 Jan 2022 00:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiAOAej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:34:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59067 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiAOAei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 19:34:38 -0500
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20F0YCXA066023;
        Sat, 15 Jan 2022 09:34:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sat, 15 Jan 2022 09:34:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20F0YBR8066017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Jan 2022 09:34:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp>
Date:   Sat, 15 Jan 2022 09:34:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
 <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
 <20220114195840.kdzegicjx7uyscoq@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220114195840.kdzegicjx7uyscoq@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/15 4:58, Jan Kara wrote:
>> Now that commit 322c4293ecc58110 already arrived at linux.git, we need to
>> quickly send a fixup patch for these reported regressions. This "[PATCH
>> v2 2/2] loop: use task_work for autoclear operation" did not address "if
>> (lo->lo_state == Lo_bound) { }" part. If we address this part, something
>> like below diff?
> 
> Please no. That is too ugly to live. I'd go just with attached version of
> your solution. That should fix the xfstests regression. The LTP regression
> needs to be fixed in mount.

Yes, this patch is ugly. Since disk->open_mutex => lo->lo_mutex dependency is recorded by
lo_open()/lo_release(), and blk_mq_freeze_queue() by e.g. loop_set_status() waits for I/O
completion with lo->lo_mutex held, from locking dependency chain perspective waiting for
I/O completion with disk->open_mutex held still remains. Therefore, this ugly patch kills
disk->open_mutex => lo->lo_mutex dependency via not holding lo->lo_mutex from lo_open()/lo_release().
Waiting for Lo_rundown device after lo_open() is a freebie till a fixed version of /bin/mount is
used by many users ( https://lkml.kernel.org/r/20220113154735.hdzi4cqsz5jt6asp@quack3.lan ).

>> I think lo_open() and lo_release() are doing too much things. I wish "struct block_device_operations"
>> provides open() and release() callbacks without disk->open_mutex held...

Christoph is not a fan of proliferating the use of task_work_add(). Can we go with exporting task_work_add()
for this release cycle? Or instead can we go with providing release() callback without disk->open_mutex held
( https://lkml.kernel.org/r/08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp ) ?
