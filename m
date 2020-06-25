Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D78C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 03:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB3EA20706
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 03:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbgFYDBM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 23:01:12 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56583 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389500AbgFYDBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 23:01:11 -0400
Received: by mail-io1-f71.google.com with SMTP id l22so2922054iob.23
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wKHziB1HTjinXOROzU9x8QSF9UVTTl5CGULxlu3fS2A=;
        b=ElwUpiaGTszub7eOSzSHbqpYdi+YTRbRnYAB9XwdqqpvhoNBimlojXJvJZCUxqtS72
         DZl8agl4Zv2eEr8nOqpvoFfE7uzL15ENWKcvSGlF414/6RNeKcGREM6f/u35NBq8TTmJ
         qag8j+gWJOGALRbPvKC/ovCuSm48JtNX5d7bBB4ZE9WM7FxlV+ZDm8ZTnysLxsTu145b
         3suPCRTZ2iuMEGN+TRzoKGR3QMsQmKOi9Lcsp2f4OhqFJJhlsYZVy1Uc4pQJsnEmrlXK
         fa8U4BDlv2jOuNfYtTjbxuvQ01Emj7YVovQ5ZRaSXob/Go1DnRxZ0hYuw15L7a5ewY0n
         tkJA==
X-Gm-Message-State: AOAM532yT95vgTTnX+eW2ziFF2HhEDwPLeUGuqpPIEqchIsT9L12zD2p
        VEPpzal2mgVR0z0c/YXlFtfm2sFvc5HvqMT/cLn3BSP+MdXF
X-Google-Smtp-Source: ABdhPJxbs1SAyL/M/fgk3l40cIJl7wJzsJfAm+GKPt/0zA1RuUK6bKXZkytrERisRhBiK2xMcbSQIrQom47jw0jbMN8Qdv/m0rQo
MIME-Version: 1.0
X-Received: by 2002:a92:290b:: with SMTP id l11mr31731641ilg.145.1593054071282;
 Wed, 24 Jun 2020 20:01:11 -0700 (PDT)
Date:   Wed, 24 Jun 2020 20:01:11 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e0ff05a8dfce2d@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        bvanassche@acm.org, davem@davemloft.net, dongli.zhang@oracle.com,
        hdanton@sina.com, jianchao.w.wang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This bug is marked as fixed by commit:
blk-mq: Fix a recently introduced regression in
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
