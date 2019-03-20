Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13DAC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EC72146E
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 11:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfCTLma (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:42:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24513 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTLm3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 07:42:29 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2KBgBxK064631;
        Wed, 20 Mar 2019 20:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Wed, 20 Mar 2019 20:42:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126094122116.bbtec.net [126.94.122.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2KBgAst064627
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Mar 2019 20:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Jan Kara <jack@suse.cz>, Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: loop: Too many partitions and OOM killer?
Message-ID: <f817788e-d228-67bd-1bd2-14a12bd76d0b@i-love.sakura.ne.jp>
Date:   Wed, 20 Mar 2019 20:42:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

syzbot is sometimes generating corrupted reports like
https://syzkaller.appspot.com/text?tag=CrashLog&x=14f62a8b200000 .

The report includes flood of global OOM killer invocations, and I suspect
that the reason of global OOM killer invocations is a lot of "blkid" processes
(invoked by uevent?) after manipulating loop devices with a lot of partitions.

Can "blkid" be invoked asynchronously upon manipulating loop devices?
