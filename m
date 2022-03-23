Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73337C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 00:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiCWAij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239295AbiCWAii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 20:38:38 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF2532C1
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 17:37:10 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id u10-20020a5ec00a000000b00648e5804d5bso13511951iol.12
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 17:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=94hmLNLc4Qa65xhXJkCqKMKovw/2rdLlaroN12E6w9I=;
        b=XLWVdjKItfhPLmgGbbdsG5iHcgRcYdgX7sQxJwuQi9NlP5VcrpbrrRctBvx5cgcKXd
         CwjQuRqsxvRKpTwUvoWxMs8YpA4GnrGPL1+XpB+akM//YUbzhAkVv+Vq5hMDrXgbBjN0
         McoRU/jct35GRxIKszNrtYNqZ9Px9BHp/IZOaVrKY1Cqol/VEdVn9GHiNu1yB+baODY1
         g37UlHN223igkHNtdP7clVuzKjs43c1DTEf+cLt8p+hOYSBHXQbbNKR6xSKAvYV7uNNZ
         lIR+B/j+OjYCRfrZF/d1ZOfiZtPtvvjq85Lef3BuH4PLmvxMJL8aGTFyBim6I7y8qB0C
         2/0w==
X-Gm-Message-State: AOAM530yUjJzx2Wks+3P/cH+4Hw/ND5dAkbGKUSb92eqX5d+zcpmAv96
        IuneNlmd1lE5pzNo7PqsQm76Cy+web43b2bk5dP6GkCosEEA
X-Google-Smtp-Source: ABdhPJxgGzn9M+W85C5QQyqaGER567i8Ni0Wh0pm/fQ8jNr/jrNrGVKqaTeS0VR6UsigXFb6xbZUilrXBgVl1VfFlwPUIINOPwZx
MIME-Version: 1.0
X-Received: by 2002:a6b:b806:0:b0:646:1c7b:bb01 with SMTP id
 i6-20020a6bb806000000b006461c7bbb01mr13365275iof.105.1647995829453; Tue, 22
 Mar 2022 17:37:09 -0700 (PDT)
Date:   Tue, 22 Mar 2022 17:37:09 -0700
In-Reply-To: <20220323000702.3445-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000018dde05dad7ee2e@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in blk_release_queue
From:   syzbot <syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bbea00057d3d55c4889b@syzkaller.appspotmail.com

Tested on:

commit:         f9006d92 Add linux-next specific files for 20220321
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=949ef165e81e8114
dashboard link: https://syzkaller.appspot.com/bug?extid=bbea00057d3d55c4889b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d673db700000

Note: testing is done by a robot and is best-effort only.
