Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4CEB64D7
	for <linux-block@archiver.kernel.org>; Sun, 18 Jun 2023 21:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFRVGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Jun 2023 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFRVGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Jun 2023 17:06:33 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E4E44
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 14:06:32 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77e23d23eccso138192039f.1
        for <linux-block@vger.kernel.org>; Sun, 18 Jun 2023 14:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687122392; x=1689714392;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGPCsyVCjaMdb5zctZvXHEEDcHJ/Z5rO2/FLB/BsIJI=;
        b=iNUqmklxQJgE/Xit5kPyNYvCn/eZrYjPd8FMjEWT9aKbZ47f70TBgCfAjnc2QFj9sE
         oGsLEOnYFFd+7smOWmTCFEWk5KnQwsSQe/5ptsF+hZf6F0kLChq0Fvb/FlpFd+l2J6JK
         FxJj4SCxIZDPUrvSX0MswTrSq80HfkjB+mSH7LhACjy9UT5rcSeadKrW3JNSIWCAIWgl
         5HhW/V0Vb4dEBaZhgLQdHSZToPFy3WfKm51Mk3wJ75xdL5JMpRpgjZ+9HHACkS3IWRF8
         32AXWBYEtGi6Oi7WdIOLz1CiIw1KE3sVLo6gzq2baq/k31InXvrGtewuY8Edm1liJ0x/
         MhpQ==
X-Gm-Message-State: AC+VfDz+GHJ55eVbq7pE6yWrbG9yw//GEgPlYpIFUL7be7YCq6Rc7XBg
        8+HT+gNNlYMYajNCk5SIDHuDvZYXvzWQkI6ZeEnpxFkW/064
X-Google-Smtp-Source: ACHHUZ7xSr4w6krwjQPockQqELqyYqRd9bokpQafWNXKhNDv0G3b/mUPdU0P2k3tDRz7L758vvswpWfxwmv/yRNxFreCGHk5VisC
MIME-Version: 1.0
X-Received: by 2002:a6b:7c0b:0:b0:763:7dfb:27b2 with SMTP id
 m11-20020a6b7c0b000000b007637dfb27b2mr2282322iok.0.1687122392334; Sun, 18 Jun
 2023 14:06:32 -0700 (PDT)
Date:   Sun, 18 Jun 2023 14:06:32 -0700
In-Reply-To: <0000000000007ca70405fe4f149a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e34c0505fe6dca7a@google.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (3)
From:   syzbot <syzbot+04625c80899f4555de39@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, brauner@kernel.org, hare@suse.de, hch@lst.de,
        hdanton@sina.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 2736e8eeb0ccdc71d1f4256c9c9a28f58cc43307
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Jun 8 11:02:43 2023 +0000

    block: use the holder as indication for exclusive opens

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1713d65b280000
start commit:   f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1493d65b280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1093d65b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=04625c80899f4555de39
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1600684b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b484f3280000

Reported-by: syzbot+04625c80899f4555de39@syzkaller.appspotmail.com
Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
