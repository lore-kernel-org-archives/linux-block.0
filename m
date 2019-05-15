Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47DC04E87
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3068E2089E
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfEOLc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 07:32:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56840 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733107AbfEOLc4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 07:32:56 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4FBWPRh046477;
        Wed, 15 May 2019 20:32:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 15 May 2019 20:32:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4FBWOeM046474
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 15 May 2019 20:32:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __get_super
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
Date:   Wed, 15 May 2019 20:32:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515102133.GA16193@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/05/15 19:21, Jan Kara wrote:
> The question is how to fix this problem. The simplest fix I can see is that
> we'd just refuse to do LOOP_SET_FD if someone has the block device
> exclusively open as there are high chances such user will be unpleasantly
> surprised by the device changing under him. OTOH this has some potential
> for userspace visible regressions. But I guess it's worth a try. Something
> like attached patch?

(1) If I understand correctly, FMODE_EXCL is set at blkdev_open() only if O_EXCL
    is specified. How can we detect if O_EXCL was not used, for the reproducer
    ( https://syzkaller.appspot.com/text?tag=ReproC&x=135385a8a00000 ) is not
    using O_EXCL ?

(2) There seems to be no serialization. What guarantees that mount_bdev()
    does not start due to preempted after the check added by this patch?
