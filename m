Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD1C3F2C6
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9CE20866
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CxgAymCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387642AbgCDDCD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:02:03 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387459AbgCDDCC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 22:02:02 -0500
X-UUID: 7856970c358b43a187969ef89e421b08-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4Tp8i81rBL0bV3dcOPyhC4/n91xDQC95NgC/GnLFqIE=;
        b=CxgAymCpfBAymfMsr39rMLtgYcnuIcg5WQyM3Gs6dNOoCBN9zmQHLdJ/v6v8+X/ESqtDqlKP0ArTxvBRH/l3hUxhCjufUxmPjYIZ8tVZbHFwZw1KgNeCc14rfYGrzJvsEy1rj6Kvf5ilnJUOeT5asNRPBuf5K4khzvdEhmOziek=;
X-UUID: 7856970c358b43a187969ef89e421b08-20200304
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 687635306; Wed, 04 Mar 2020 11:01:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:00:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 11:02:36 +0800
From:   <light.hsieh@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuohong.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Subject: [PATCH v1 0/3] set ro attribute of block device according to write-protection status
Date:   Wed, 4 Mar 2020 11:01:52 +0800
Message-ID: <1583290915-9858-1-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
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

