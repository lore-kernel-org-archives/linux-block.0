Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B34BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 07:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiC1Ha4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 03:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiC1Haz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 03:30:55 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB3427C5
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 00:29:12 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m4-20020a924b04000000b002c851e73720so7278921ilg.23
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 00:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KF6RRSv0UEz8tSzbeuXx0815Teuk0m5QkpVJdIXOy1A=;
        b=BCYX7XHByiOgf7EfWGdPuUTV7wqtTtQPxloH7VB7tA2PTMSM9IidNR67bNUXWmTtVv
         ZjbZZqcqK0+5X53giVuMONj0QfvkJntfn9S8hHKei7TquT8iGpXIXMAGgmlAXi+SWh6g
         dsVjTpGp2Eiq/LRcmMHCgDoLsHXIS+hCDmDjGtjp0pacu5haSXXPO6rFqouShPK5AKdX
         YQ5GU4h7TohwGOl3U0hV6aJ3w3y4nsN2NoAzbDsg4R2p3hxw+OItYDikSDv7m0J6D0tE
         IAqYq8i0dDh9XWRwiCE45HoJKFCufyMXNg2cN/zsyKwIZGcO70jn+/YN4aZ76Xk5mKuN
         RlQw==
X-Gm-Message-State: AOAM531E1WvGDaJPEsYH7SKdEGrFqxJ6XVHgPjeh9Eex83XXIWfQPHi2
        lfNBMC09lqCthYkFwKhDFT/BjEkQzBwai6txokrdm0AytXsV
X-Google-Smtp-Source: ABdhPJylgre9J6aJ68nKejMHlxOmxK4+mEFWQQBbyeS+ASnoUYOMmCmdSz/22WytKSqAWnOGc3TqFAKHkQbHRRqzDsr0ElUtrNTs
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4089:b0:319:b60c:3c3d with SMTP id
 m9-20020a056638408900b00319b60c3c3dmr12553389jam.120.1648452551957; Mon, 28
 Mar 2022 00:29:11 -0700 (PDT)
Date:   Mon, 28 Mar 2022 00:29:11 -0700
In-Reply-To: <12985729.uLZWGnKmhe@leap>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9dfe005db4244a9@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1461d105700000

Note: testing is done by a robot and is best-effort only.
