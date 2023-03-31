Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317BEC761A6
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjCaPmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCaPmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 11:42:24 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AA61E72A
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:42:23 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so13374968iog.7
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277342; x=1682869342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJYq+ZywDnRhStLXmh3DG5Chtbh5S+arEYAqRS8jFIw=;
        b=S0T+0DITG+3vqMTEc1WhZaI4pmLGWo4ub/6QG/XcMo4sUcfovr87YgDA+dHiJRSPKT
         KwbrNdcJ2iLplc0gLTDVgNxACSmBhQm/x/D8Kj9boG1F+esN01xBKzlA+7xaluhur2xX
         GMpGMLRIswiRZIW1QpWgVWDG4oANLkQDYRXrUO+ApVMsaLHZhh1BywQMDWh1bBjlgfTn
         t59Lhd22I2AeHhIjQ4idYGoZL5locTseGeumDwev6s/vJ6qLeKtzoIyDZ2Zl3DdsTXMK
         x4QSo1v2ecTTQBLc8au3fB3PcUjFFpSc0bS73ZlkRV+FM/q4ClvfbIVfzxrs7Y3PPn9K
         Nw/w==
X-Gm-Message-State: AAQBX9domf7yDq6F08wF4J3AnJvfWou/nZywZIJoh+G2RnUnqVyILby5
        OH1MG1MoXXDGP1rTFP8lC0ADHYVKYWsKH6lbTaiAcoDV+lB1
X-Google-Smtp-Source: AKy350ZZCOGDTvEy1d2vlO0/N8RFSfkcATk9zogGNoG5lCrg25Fl7BHt9IN9NRb0wcblmMp8Gja+mV9pY/NUE+aAYXo5MlGHY0uW
MIME-Version: 1.0
X-Received: by 2002:a92:3005:0:b0:326:17ae:47b9 with SMTP id
 x5-20020a923005000000b0032617ae47b9mr8063319ile.1.1680277342571; Fri, 31 Mar
 2023 08:42:22 -0700 (PDT)
Date:   Fri, 31 Mar 2023 08:42:22 -0700
In-Reply-To: <000000000000a5c9be05ed85b31b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020d46805f8340e6b@google.com>
Subject: Re: [syzbot] [block?] KASAN: use-after-free Read in netdev_core_pick_tx
From:   syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, gakula@marvell.com, hdanton@sina.com,
        jiasheng@iscas.ac.cn, justin@coraid.com, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.swiatkowski@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit f038f3917baf04835ba2b7bcf2a04ac93fbf8a9c
Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Date:   Fri Mar 17 06:43:37 2023 +0000

    octeontx2-vf: Add missing free for alloc_percpu

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133a3d2ec80000
start commit:   42226c989789 Linux 5.18-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=10a7a8ca6e94600110ec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ed1369f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166b22cef00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: octeontx2-vf: Add missing free for alloc_percpu

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
