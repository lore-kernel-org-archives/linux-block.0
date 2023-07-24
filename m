Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610CC001B0
	for <linux-block@archiver.kernel.org>; Mon, 24 Jul 2023 17:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGXRUs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGXRUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 13:20:47 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCE10EF
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5ad0720d4so4060132b6e.3
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 10:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219245; x=1690824045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jjikWmr9FsKFO5O1AtxhVTUjXG2I5Qke3uz5AVbRGY=;
        b=Tjm4hfGj2p5JYfPAPgY4na7T0P3eMYnvWQu4Lo6gPqF1ryOSNu9uQofnCSNx3Z5owr
         hV377hHNY80hCcfS3nbTw5hOkBlWJMYi3hDoTWiqaysMbJidWF0d+ssaNRSzRZWtWfs5
         zritozHxk4krBvhmmwIOsq+htFySz9M6i4c4/QNJ6l6nrcsqKqF5tDGgRNCo/Qwnj25e
         bkq1EzKHozPyIgMfjwp0J7XTX2RBGbXsn8bUvfOgcQ6bmy+jdFqJM1VTLHxIu/MSH1Oy
         1e9hsbHD02SldxA2txWDG1MTelAXVMfOdHv64fQ3pyvLUv5qfpl8qmy7NdGVaWW6x0Na
         7/Vw==
X-Gm-Message-State: ABy/qLarM1YhQBuazLX8lBglayR6JZeqPbtqQROVH0438+3yU/zY6uNK
        025vJG4HzJh3Kzhb1Es0iQk3PwBT4jYMMMIMCB70So8aHOEw
X-Google-Smtp-Source: APBJJlGNrlcAkikspfqaXegtQje/gdLFHH41Sfqg3J9deU/xIOfiC7rK5IxmHznQSyVncseLGB9s/gSmn2HTbokqPrRS8hoXjQMs
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2019:b0:3a4:2943:8f7 with SMTP id
 q25-20020a056808201900b003a4294308f7mr20378188oiw.5.1690219245817; Mon, 24
 Jul 2023 10:20:45 -0700 (PDT)
Date:   Mon, 24 Jul 2023 10:20:45 -0700
In-Reply-To: <13125.1690215929@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd577706013ed580@google.com>
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
From:   syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com

Tested on:

commit:         0b7ec177 crypto: algif_hash - Fix race between MORE an..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157554a1a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bccf8d7311b80058
dashboard link: https://syzkaller.appspot.com/bug?extid=6f66f3e78821b0fff882
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
