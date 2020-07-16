Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A838C433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 05:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E58207BC
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 05:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgGPFAH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:00:07 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33179 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgGPFAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 01:00:06 -0400
Received: by mail-il1-f197.google.com with SMTP id c1so2899190ilr.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 22:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cE1hhRVuLf2gZer2Ucpnx9HKI06D31CoZ/RNlVo8Pe0=;
        b=bQpOY4mY1E1iYufWcPhT7woUTbvNrq/WclKoopKgzfjcH6lldf6pf19TgJDHF9sJAe
         nxyjEke7xgoM3fQfI7CiRZ70ipyLPrwiZdhS048jYfJJem4nwzrKzuR0c7niEjoVTCy5
         6X3d3Tv71S0bMHuLY2CXaqmGkLVBKqcDz84hGTuTwZ0qimN37gN/Qg7cjWZTrbjXswJN
         Qvmo5xCFoo0olBJKVd7BNc9tpWb6qeq+yMHejEL6N4T4qMiABOCnkQp7F5psfChaC4Fp
         AWaK+w7UI2eD0Pm4e3O9F8fzkytZJjPeyKiCA+pkZPUeFs4l1+5nRyQej+Tm5cOQ2e9s
         xjww==
X-Gm-Message-State: AOAM532UJQKVCPgGaBmMAxWEfhQdjVVaOo3ZLX/ENH0XNTx0RXSwIpwE
        q/nv3/Z7hPn5/anWhysJsOsvtgtf/yGyhaleQVCwmgQINlJm
X-Google-Smtp-Source: ABdhPJwrtEU1PwKJDwMkynoxse8GDaDxlNH/e4aaSkK3f5Z72MwWHALTn6uAryXSscOV5ZuIi1/gjdhbEGKyVnlXGRdUASMWb0gi
MIME-Version: 1.0
X-Received: by 2002:a6b:7c02:: with SMTP id m2mr2790747iok.49.1594875605629;
 Wed, 15 Jul 2020 22:00:05 -0700 (PDT)
Date:   Wed, 15 Jul 2020 22:00:05 -0700
In-Reply-To: <00000000000029663005aa23cff4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef406d05aa87e9ba@google.com>
Subject: Re: WARNING in submit_bio_checks
From:   syzbot <syzbot+4c50ac32e5b10e4133e1@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, axboe@kernel.dk,
        bkkarthik@pesu.pes.edu, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ebiggers@kernel.org, hch@infradead.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 449325b52b7a6208f65ed67d3484fd7b7184477b
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Tue May 22 02:22:29 2018 +0000

    umh: introduce fork_usermode_blob() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fc4b00900000
start commit:   9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fc4b00900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc4b00900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=4c50ac32e5b10e4133e1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111fb6d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1218fa1f100000

Reported-by: syzbot+4c50ac32e5b10e4133e1@syzkaller.appspotmail.com
Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
