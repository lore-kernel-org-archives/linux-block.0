Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51653 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750793AbeAUQTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jan 2018 11:19:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8386F209AE
        for <linux-block@vger.kernel.org>; Sun, 21 Jan 2018 11:19:52 -0500 (EST)
Received: from [10.0.0.24] (unknown [68.175.132.145])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3975D2463E
        for <linux-block@vger.kernel.org>; Sun, 21 Jan 2018 11:19:52 -0500 (EST)
From: David Zarzycki <dave@znu.io>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: blk-mq hangs easily with LLVM+clang test suite
Message-Id: <83F7B94F-562A-44A5-92F9-939FE4FD5A99@znu.io>
Date: Sun, 21 Jan 2018 11:19:51 -0500
To: linux-block@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I think I=E2=80=99ve narrowed down a kernel hang to the multi-queue =
block layer when running the LLVM+clang test suite. Here is what I=E2=80=99=
ve gathered:

1) The hang does *not* reproduce on tmpfs or a SATA SSD drive.
2) The hang does reproduce on blk-mq devices (NVMe or loopback to a file =
in tmpfs).
3) The hang does reproduce with ext4 or xfs, so the filesystem doesn=E2=80=
=99t seem to matter.

How can I help debug this further?

Thanks,
Dave

For reference, reproduction steps:

cd /to/a/blk-mq/partition
git clone https://git.llvm.org/git/llvm.git
cd llvm/tools
git clone https://git.llvm.org/git/clang.git
cd ..
mkdir t
cd t
cmake -G Ninja \
	-DCMAKE_BUILD_TYPE=3DRelease \
	-DLLVM_ENABLE_ASSERTIONS=3DTRUE \
	-DLLVM_TARGETS_TO_BUILD=3DX86 ..
# It only takes a few runs of the test suite on a 48-core system
while true
do
	ninja check-all
done=
