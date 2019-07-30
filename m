Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B615C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6417A20693
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 10:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfG3KQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:16:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61027 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfG3KQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 06:16:38 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x6UAGNlK066838;
        Tue, 30 Jul 2019 19:16:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 30 Jul 2019 19:16:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x6UAGJHQ066824
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 30 Jul 2019 19:16:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
To:     Jan Kara <jack@suse.cz>, Kai-Heng Feng <kaihengfeng@me.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Lenton <john.lenton@canonical.com>,
        jean-baptiste.lallement@canonical.com
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f7e6717f-be46-1dfe-80ed-f85a18065c85@i-love.sakura.ne.jp>
Date:   Tue, 30 Jul 2019 19:16:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730092939.GB28829@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/30 18:29, Jan Kara wrote:
>> This patch introduced a regression [1].
>> A reproducer can be found at [2].
>>
>> [1] https://bugs.launchpad.net/bugs/1836914
>> [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836914/comments/4
> 
> Thanks for the notice and the references. What's your version of
> util-linux? What your test script does is indeed racy. You have there:
> 
> echo Running:
> for i in {a..z}{a..z}; do
>     mount $i.squash /mnt/$i &
> done
> 
> So all mount(8) commands will run in parallel and race to setup loop
> devices with LOOP_SET_FD and mount them. However util-linux (at least in
> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
> retries with the new loop device. So at this point I don't see why the patch
> makes difference... I guess I'll need to reproduce and see what's going on
> in detail.

Firstly, why not to check the return value of blkdev_get() ?
EBUSY is not the only error code blkdev_get() might return.

 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
 		bdgrab(bdev);
 		error = blkdev_get(bdev, mode | FMODE_EXCL, loop_set_fd);
-		if (error)
+		if (error) {
+			printk("loop_set_fd: %d\n", error);
 			goto out_putf;
+		}
 	}

And try finding which line is returning an error
(like https://marc.info/?l=linux-xfs&m=156437221703110 does).
