Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D7C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BA3610C7
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbhHROfV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:35:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55252 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhHROfV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:35:21 -0400
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 17IEYI7E095353;
        Wed, 18 Aug 2021 23:34:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 18 Aug 2021 23:34:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 17IEYIY1095350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 18 Aug 2021 23:34:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <20210818134752.GA7453@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
Date:   Wed, 18 Aug 2021 23:34:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818134752.GA7453@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/18 22:47, Christoph Hellwig wrote:
> Hi Tetsuo,
> 
> I might sound like a broken record, but we need to reduce the locking
> complexity, not make it worse and fall down the locking cliff.  I did
> send a suggested series this morning, in which you found a bunch of
> bugs.  I'd appreciate it if you could use your superior skills to
> actually help explain the issue and arrive at a common solution that
> actually simplifies things instead of steaming down the locking cliff
> full speed.  Thank you very much.

I posted "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex"
which reduces the locking complexity while fixing bugs, but you ignored it. Instead,
you decided to remove cryptoloop module (where userspace doing "modprobe cryptoloop"
will break). That is, you decided not to provide patches which can be backported.

Please do review my patches carefully instead of posting broken random patch series
at full speed. "[PATCH v3] block: genhd: don't call probe function with major_names_lock
held" is a revertable patch which we can revert in future after all locking dependencies
are simplified enough. Applying this patch does not break userspace.

Then, if you review "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and
loop_removal_mutex" carefully, you can easily figure out why I used HIDDEN_LOOP_DEVICE
magic. You are not aware of why loop_ctl_mutex is held during entire add/remove/lookup
operations. Since reducing the duration of loop_ctl_mutex might break existing userspace,
this patch is not suitable for backporting. We can apply this patch based on agreement
for future kernels and userspace.

After "[PATCH v3] block: genhd: don't call probe function with major_names_lock held"
and "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex"
are applied, you can propose changes which remove cryptoloop module (of course, with
cares added for not to break userspace).

