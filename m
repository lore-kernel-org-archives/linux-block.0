Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738BC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB1F208A3
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLDBnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:43:49 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:47460 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeLDBnt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Dec 2018 20:43:49 -0500
X-QQ-mid: bizesmtp20t1543887820tyf77hx2
Received: from Macbook.pro (unknown [210.22.22.130])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 04 Dec 2018 09:43:40 +0800 (CST)
X-QQ-SSF: 01400000002000F0FL51B00A0000000
X-QQ-FEAT: Ngtn/3KK5eqQH0wmonB9HmbmCTviEUv0aKolIF3J+RmcBenNIfXy4X133KqYr
        di0Ut7Y6gOQd3edGuY9ksmrg5gEn4rwW9XWUvaWPUUhvApZJVYxZcSc5VN8WMkA8akuaPY5
        pJIs6cCc4c/qWico5QuKZcTsNcnYeX0wq5WpHwww1vEL1u5jNlJpYbn3PRQl05D5IFp/qVp
        7uezWaKldk7+1bKYY8sroPSV0xBxi0Of95YfDpbR5m1Zga2Zj6TdCEfPjPTwomGxO5xyGgB
        e4FBf7aiB5l/Q556qZqnXSBEc=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm extension
Date:   Tue,  4 Dec 2018 09:43:21 +0800
Message-Id: <20181204014323.1438-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v6:
  neon-intrinsics.h: change _NEON_INTRINSICS_H to __ASM_NEON_INTRINSICS_H.
  neon-intrinsics.h: add header LICENSE declaration
  neon-intrinsics.h: explain part of the code with comments

Jackie Liu (2):
  arm64/neon: add workaround for ambiguous C99 stdint.h types
  arm64: crypto: add NEON accelerated XOR implementation

 arch/arm64/include/asm/Kbuild            |   1 -
 arch/arm64/include/asm/neon-intrinsics.h |  39 +++++++
 arch/arm64/include/asm/xor.h             |  73 ++++++++++++
 arch/arm64/lib/Makefile                  |   6 +
 arch/arm64/lib/xor-neon.c                | 184 +++++++++++++++++++++++++++++++
 5 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/neon-intrinsics.h
 create mode 100644 arch/arm64/include/asm/xor.h
 create mode 100644 arch/arm64/lib/xor-neon.c

-- 
2.7.4



