Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B849CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 16:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiCaQ4D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiCaQ4C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 12:56:02 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B9DE909
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 09:54:15 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id a9-20020a5d89c9000000b0064cb68a9ba6so77882iot.11
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 09:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lAU3Wth5raowPe6hr9BcwEouOu/KFzD0omZlx82ZzhQ=;
        b=T6b/MsW+V9sQ8/ng7Xn1v02x2spng4J9ZGVop65t22tTZacW1qfzlFScwQ6joYZISk
         ez4BjEETeIqKjKNVikXSLB7OWF5hf/yuI7JZu4fRIEYe//3XaJe5wfdLJ/G/FtjQ4w/S
         PA7OosILIYEp73UWPQToK/SoJcFfZNIe/hpYPMQ9hXlojx7tK17TbEsFesaNQquOeEMw
         eWJ/E+DpgoP7AmGH3n/Go3hwpHBTYYNY22KZEuvYfc2e62UjLSaGOZlxadUmy60UiDE8
         hCklZvxhoDQR3m+NzH74W3JIuTq2ZuP7SBTozTPlhfCoOhkxFgWgBQn83U4ULV0xmX+5
         SeBQ==
X-Gm-Message-State: AOAM531DQNVjuj4hXy71mIPgEe68++OQPPT11AK+lFJXxt8Rm6lRUU0g
        SjhORTWCdEWY+hfqbU52/yTAUvZg2c13QIJofqCWn/NA7j8A
X-Google-Smtp-Source: ABdhPJwmJ9AzvPYeGAfkPFM7NlFTob2+QRp3K6k3IYckOOrGwTagSa4rhrpDwa3c7WBsNsTiOqz5dCc3PpdqYZs8p+YNEMVAidFz
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:2ca:47:4364 with SMTP id
 h1-20020a056e021d8100b002ca00474364mr1503158ila.80.1648745654584; Thu, 31 Mar
 2022 09:54:14 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:54:14 -0700
In-Reply-To: <20220331164358.GA30565@lst.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000110d5805db868373@google.com>
Subject: Re: [syzbot] WARNING in bio_free
From:   syzbot <syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e08de3db8be67b2a01b0@syzkaller.appspotmail.com

Tested on:

commit:         ea32d892 squashfs: free bios allocated using bio_kmall..
git tree:       git://git.infradead.org/users/hch/misc.git squashfs-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a82c1abd4cbb9ee
dashboard link: https://syzkaller.appspot.com/bug?extid=e08de3db8be67b2a01b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
