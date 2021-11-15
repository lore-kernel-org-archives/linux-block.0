Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BB0C433F5
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3463214
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 11:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhKOLGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:06:43 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55753 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhKOLFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 06:05:05 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AFB1xi2049193;
        Mon, 15 Nov 2021 20:01:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 15 Nov 2021 20:01:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AFB1xOX049188
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Nov 2021 20:01:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0b9d0710-4f0e-01ef-242b-6b52b4daf5a3@I-love.SAKURA.ne.jp>
Date:   Mon, 15 Nov 2021 20:01:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [syzbot] WARNING in nbd_dev_add (2)
Content-Language: en-US
To:     syzbot <syzbot+5e8112c15ddb3db8416d@syzkaller.appspotmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <000000000000342e7105d0ba10d0@google.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000342e7105d0ba10d0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

#syz fix: block: add __must_check for *add_disk*() callers

