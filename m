Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FDEB64DD
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 21:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGXVMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGXVMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 17:12:45 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE6E56
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b9ceb5cd7eso9763531a34.1
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 14:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233163; x=1690837963;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPnHeXIwNFVyZ0AE0V37vyCdAnCc/H92GAheB3cJ/4w=;
        b=bQlvwW5SQ6CH0aVw3kr/sxi++5feujP3HbSaMpqsFqRm0WEILh+avXEP4H7KXWvYH4
         e7QjVi5z0UR2DFzsYuI6JE1C7eZP82QxyzXL0HkZnFw/FnXkImGnbQbixRsnMhEVpqih
         aPRPGhqg1qyOxmMt1DahHJo7GGFdKv5/VoRhQHBhfxOWll5HSQsL96Nc/PzMMSFq/irZ
         pKOMjx+10y8qKiThdTpPp9yujTGWvNu7R7o8NugL02nJaYG9VlFyg9xdYratlFwCuhgB
         2hRxB0+OwsjxfqziLQjSEIR7XQ4/WE5s0IGYT/CVrh8gDsDYlHrvexs56ekFMSpboqfb
         apuw==
X-Gm-Message-State: ABy/qLYbqLMg8zcag0+H3DIT1aJtv1IkHURMfoYatbghVJBh/72K8Q1d
        mQHwcBxKihJ8OQj53sZZBHaANEr/+ZrWkoqIoECuW4vShmcd
X-Google-Smtp-Source: APBJJlEZpLKV/q4LE1/Q6WrdC8aon0BK6TGJhCbOn7xtLIBXrY8K3tRXJk7fN+kSn3DROS/NbpXFthJZJvUNqcYGhZ07hm7fnWGG
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1519:b0:6bb:2244:cb72 with SMTP id
 k25-20020a056830151900b006bb2244cb72mr7592465otp.2.1690233163775; Mon, 24 Jul
 2023 14:12:43 -0700 (PDT)
Date:   Mon, 24 Jul 2023 14:12:43 -0700
In-Reply-To: <19655.1690233158@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050862c0601421343@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     dhowells@redhat.com
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> #syz dup: [syzbot] [ext4?] general protection fault in ext4_finish_bio

can't find the dup bug

>
