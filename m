Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB6EC04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 03:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiG3DZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 23:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiG3DZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 23:25:12 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF8B7F
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 20:25:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id o5-20020a056e02102500b002ddcc65029cso3776059ilj.8
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 20:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Le6CaLI6B5guGWuq3Gyd/hvNCiyTuMEnCMic+ruQwAg=;
        b=mecafTnAqmdP467vYwNv+lrxl7btmJHZR22JiY97qJpt4Xa1iZSYTpxLaXBsnHDGlk
         7kcnc7EUHAE1tsSu6dgVUMsai6iO8ljcHUNpv/lIrLCkgtmt4f0SvubQJctPfiE1VjpC
         AFrpXLBxlboNItIW70uWbHb4DVPgkwOPIXAu4nZ2R+lHD55JBWhhhc6vbWnCBe6Nk545
         6tZI4ApR6P1uER/VKw5ywyM5S5iTIi6w8IFAig/c81YzaNGvaH8fbophMaFk8Sw1i7Ln
         3ZwButyDGJsoriF60fncKl0vpzE2e4CXbnzxWuz9zhZakuitJXpUjSK56q6P4cV2h9jW
         JlHQ==
X-Gm-Message-State: AJIora/Db5Re3Orx3xKhOWfnRFPFU76esQh5cqbeyOUnfzkvnrZBMeGt
        sz/y6zt9Gk7ivqKKrtJzB330f72nPbpCv9frptS+q/8Q8PBs
X-Google-Smtp-Source: AGRyM1uZmbuimnvUNNN7eYgZxebUEc8abU1NLOXrLNTLjgqi426QKsMvgCMdvZuw8bnYIkGGZLa27J5FmS+eqomTrhDSEVcJwthc
MIME-Version: 1.0
X-Received: by 2002:a92:c884:0:b0:2dc:bd44:84bf with SMTP id
 w4-20020a92c884000000b002dcbd4484bfmr2389723ilo.86.1659151508737; Fri, 29 Jul
 2022 20:25:08 -0700 (PDT)
Date:   Fri, 29 Jul 2022 20:25:08 -0700
In-Reply-To: <000000000000921fd405db62096a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e96a405e4fd5051@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 0a9a25ca78437b39e691bcc3dc8240455b803d8d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Mar 18 13:01:43 2022 +0000

    block: let blkcg_gq grab request queue's refcnt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c3cfc2080000
start commit:   cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c3cfc2080000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c3cfc2080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17713dee080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d24952080000

Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
Fixes: 0a9a25ca7843 ("block: let blkcg_gq grab request queue's refcnt")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
