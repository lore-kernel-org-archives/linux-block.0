Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623B7C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35902208C3
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bRdeliBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbgCDC5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:57:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45822 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387543AbgCDC5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 21:57:43 -0500
X-UUID: 70527d2412e8458d932c019c061a2315-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4Tp8i81rBL0bV3dcOPyhC4/n91xDQC95NgC/GnLFqIE=;
        b=bRdeliBMsJYguedrqxZYnh7RXR6U15ACA4oD7raeOqem42as4vqXnGIny+kdUIm9mdVlIg5H1GYS2SYvDNOMywCSJsHWzNnEue/A2cVAsASg7ZLff8nfU/UNNXbkVxZq9cgLNHcx1GxCyOtvgE/7LcjCSMduX4v3IQFl8Rs0dC8=;
X-UUID: 70527d2412e8458d932c019c061a2315-20200304
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1051547790; Wed, 04 Mar 2020 10:57:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:56:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:58:16 +0800
From:   <light.hsieh@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuohong.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Subject: [PATCH v1 0/3] set ro attribute of block device according to write-protection status
Date:   Wed, 4 Mar 2020 10:57:32 +0800
Message-ID: <1583290655-7858-1-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E978A8E0381A4EFA74F0521E4BB358506639EA9010A2EA3F0FCB60A953564A212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogTGlnaHQgSHNpZWggPGxpZ2h0LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KKioqIEJMVVJC
IEhFUkUgKioqDQoNCkxpZ2h0IEhzaWVoICgzKToNCiAgbW1jOiByZWNvcmQgd3BfZ3JwX3NpemUg
YW5kIGJvb3Rfd3Bfc3RhdHVzDQogIG1tYzogY2hlY2sgd3JpdGUtcHJvdGVjdGlvbiBzdGF0dXMg
ZHVyaW5nIEJMS1JPU0VUIGlvY3RsDQogIGJsb2NrOiBzZXQgcGFydGl0aW9uIHJlYWQvd3JpdGUg
cG9saWN5IGFjY29yZGluZyB0byB3cml0ZS1wcm90ZWN0aW9uDQogICAgc3RhdHVzDQoNCiBibG9j
ay9pb2N0bC5jICAgICAgICAgICAgIHwgICAyICstDQogYmxvY2svcGFydGl0aW9uLWdlbmVyaWMu
YyB8ICAxMCArKysNCiBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgIHwgMjE3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL21tYy9jb3JlL21t
Yy5jICAgIHwgIDE2ICsrKysNCiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oICAgIHwgICAxICsNCiBp
bmNsdWRlL2xpbnV4L21tYy9jYXJkLmggIHwgICAzICsNCiBpbmNsdWRlL2xpbnV4L21tYy9tbWMu
aCAgIHwgICAyICsNCiA3IGZpbGVzIGNoYW5nZWQsIDI1MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQoNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

