Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED8C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E783218A1
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfDOSHC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:07:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58368 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfDOSHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 14:07:02 -0400
Received: by mail-it1-f198.google.com with SMTP id j203so17042905itb.8
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 11:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sWDXitSXlziTm+++5hupMV/gNlZiFqZLcHdxBDIQI/g=;
        b=jAH3RBh+rPMp0mriDF5R8d4SrpO5J7bA4Z9K8pbnDGblPQvVP4lNT8m10Kv9bPbolS
         LjbE9sBjDf/IEtyi0Rdmbi38n8+6mhv0uBbiUNdhUM8mZttUfi/yunxM2JKlUcDWi0pF
         KQSKoX8IEZZXt407NcBupkGtPviIf3ScoqEluKxnsOdpFSbQiSOJKbcCNgq1jLjr3aCS
         ZVkdmAP+Lxv7DHzuoxHCBryglXD0zWYjd5Zw1PMHth75QBj/KIST9U5ftdk8Z9hovkWn
         u58aYLS0JPDvVEP1WEl6xw/fOJSpOzWudcWiyu8WQFKjYAD5z3aRS8gpEJIJSz4unn4p
         p58Q==
X-Gm-Message-State: APjAAAWFTQ1tEKbX3DvmFiz0eRvYBvjjn4CCIcefmSNvD44sD9jEk0wv
        E0RhuEEBM+/JAdPUNAW8NUv4LQEKyx0RhtiJC6Hyfg3kLno9
X-Google-Smtp-Source: APXvYqx0gY6g+2OoPZQ584Plr9254eaEc4NfCwE81pXgQZQ90f7wBQk1ajxCYplrhDsHPSEaMJ4M0gcCIUSpM+gPrC1Hij3C9kuO
MIME-Version: 1.0
X-Received: by 2002:a24:4155:: with SMTP id x82mr6251777ita.34.1555351620851;
 Mon, 15 Apr 2019 11:07:00 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:07:00 -0700
In-Reply-To: <0000000000009c60fe058665c584@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dca3e3058695845d@google.com>
Subject: Re: INFO: task hung in __io_uring_register
From:   syzbot <syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hare@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 6c271ce2f1d572f7fa225700a13cfe7ced492434
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Jan 10 18:22:30 2019 +0000

     io_uring: add submission polling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161ab467200000
start commit:   dc4060a5 Linux 5.1-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=151ab467200000
console output: https://syzkaller.appspot.com/x/log.txt?x=111ab467200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=16dc03452dee970a0c3e
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eb47ed200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112175dd200000

Reported-by: syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com
Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
