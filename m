Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D8E61152
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 22:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhKJWPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:15:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61195 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhKJWOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 17:14:03 -0500
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AAMB5nR060911;
        Thu, 11 Nov 2021 07:11:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Thu, 11 Nov 2021 07:11:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AAMAwo5060883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Nov 2021 07:11:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp>
Date:   Thu, 11 Nov 2021 07:10:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Content-Language: en-US
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
References: <00000000000089436205d07229eb@google.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000089436205d07229eb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

Commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with lo->lo_mutex held, and syzbot is
reporting circular locking dependency

  &disk->open_mutex => &lo->lo_mutex => (wq_completion)loop$M =>
  (work_completion)(&lo->rootcg_work) => sb_writers#$N => &p->lock =>
  &of->mutex => system_transition_mutex/1 => &disk->open_mutex

. Can you somehow call destroy_workqueue() without holding a lock (e.g.
breaking &lo->lo_mutex => (wq_completion)loop$M dependency chain by
making sure that below change is safe) ?

@@ -1365,7 +1365,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
        /* freeze request queue during the transition */
        blk_mq_freeze_queue(lo->lo_queue);

+       mutex_unlock(&lo->lo_mutex);
        destroy_workqueue(lo->workqueue);
+       mutex_lock(&lo->lo_mutex);
        spin_lock_irq(&lo->lo_work_lock);
        list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
                                idle_list) {

On 2021/11/11 2:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cb690f5238d7 Merge tag 'for-5.16/drivers-2021-11-09' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1611368ab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7259f0deb293aa
> dashboard link: https://syzkaller.appspot.com/bug?extid=63614029dfb79abd4383
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

