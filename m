Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40337 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbeAVXbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 18:31:24 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BE68219E2
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2018 18:31:24 -0500 (EST)
Received: from [10.0.0.24] (unknown [68.175.132.145])
        by mail.messagingengine.com (Postfix) with ESMTPA id F26AD24697
        for <linux-block@vger.kernel.org>; Mon, 22 Jan 2018 18:31:23 -0500 (EST)
From: David Zarzycki <dave@znu.io>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
Message-Id: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
Date: Mon, 22 Jan 2018 18:31:22 -0500
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I previously reported a hang when building LLVM+clang on a block =
multi-queue device (NVMe _or_ loopback onto tmpfs with the =E2=80=99none=E2=
=80=99 scheduler).

I=E2=80=99ve since updated the kernel to 4.15-rc9, merged the =
=E2=80=98blkmq/for-next=E2=80=99 branch, disabled nohz_full parameter =
(used for testing), and tried again. Both NVMe and loopback now lock up =
hard (ext4 if it matters). Here are the backtraces:

NVMe:      http://znu.io/IMG_0366.jpg
Loopback:  http://znu.io/IMG_0367.jpg

What should I try next to help debug this?

Dave=
