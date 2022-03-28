Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 08:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiC1IFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiC1IFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 04:05:50 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEED52E7A
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 01:04:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id z16-20020a05660217d000b006461c7cbee3so9865159iox.21
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 01:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nRtWCn1LjghzIqUfsdVVE+gyfveDudhr1FJxsjtTVEA=;
        b=R2XRJXk+liYGmB0A/SvuB7ggWAPnfK0N0JU2rQGJqRHGrauF9J4nH1fkgYBq4FP2si
         LVpBJot9ARxHbG2zc2gbEYHso4xA2wid19e2Oloy3uoJTn8Mpx197DYjUgosJFwVHe7s
         auPizGFhK42vLOehOjC7Jmd+6IQU53kR+N5O58XcMtSF4NAUTJGm1H1rhyDeYX8aBJwC
         JCQ0ggj1RRekE88jeHbnfKpJeGWzsHM+J22T0UF9xU6QjwtU0CdSIvf22cI38KzGYAB5
         vmJzbISKc65QZHMOhQ3wl8B6QjXb7vBAAY32rDfGHRe+1TRJ6etY3/A/FDNcdszvkX00
         GjoQ==
X-Gm-Message-State: AOAM531jDCDhSndItm39wtw8zcZx7RRN6SVzpiiofKOyFf8E5yxTveFO
        y/LepV1eCqaQiuPyLqy8nvqC5PnSf0AAsle1ZM1oSKKx4edI
X-Google-Smtp-Source: ABdhPJwVCd2V66G46MtzEKodxqyrRt7tEIw3hFbNLQdaE6yWlpPHdwzfmRtSCU55e8P6O5rwVQ1YiZA+UOw1JP+Iuna7UIF1zGmf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164b:b0:323:5dd4:cf79 with SMTP id
 a11-20020a056638164b00b003235dd4cf79mr4604876jat.205.1648454649659; Mon, 28
 Mar 2022 01:04:09 -0700 (PDT)
Date:   Mon, 28 Mar 2022 01:04:09 -0700
In-Reply-To: <7364962.EvYhyI6sBW@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d244e905db42c1ac@google.com>
Subject: Re: [syzbot] memory leak in blk_mq_init_tags
From:   syzbot <syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, fmdefrancesco@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com

Tested on:

commit:         ae085d7f mm: kfence: fix missing objcg housekeeping fo..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6583b67d32c256f1
dashboard link: https://syzkaller.appspot.com/bug?extid=f08c77040fa163a75a46
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120b3e8b700000

Note: testing is done by a robot and is best-effort only.
