Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A8C3F2D9
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82120CC7
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 03:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mzDV54eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgCDDM3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:12:29 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38104 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387609AbgCDDM2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Mar 2020 22:12:28 -0500
X-UUID: 826440239e364b029ea484cf06901dcf-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7FGKC2CL96iktvyoBP2vbwLVT6EXR3CbHjrpB2EcLgw=;
        b=mzDV54eHbuWv4VhGtBiswDYgZSb8SEZVa6dtiWBj3/ddQrO+9b06Dm0Qe+3Y6d6Hto4hHPV9vDTm/Pnol/wpCpFqO39KiA/pvFNc9nhr8CKBl2st8ikQSSBoA5AbTE53zvR+mzGuJqk9QiKCma7db6IWmx2ZB+5wpJ3QazydLA8=;
X-UUID: 826440239e364b029ea484cf06901dcf-20200304
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1444323461; Wed, 04 Mar 2020 11:12:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:11:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 11:09:47 +0800
From:   <light.hsieh@mediatek.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kuohong.wang@mediatek.com>, <stanley.chu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Subject: [RESEND PATCH v1 3/3] block: set partition read/write policy according to write-protection status
Date:   Wed, 4 Mar 2020 11:12:17 +0800
Message-ID: <1583291537-15053-4-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1583291537-15053-1-git-send-email-light.hsieh@mediatek.com>
References: <1583291537-15053-1-git-send-email-light.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RnJvbTogTGlnaHQgSHNpZWggPGxpZ2h0LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KRm9yIHN0b3Jh
Z2UgZGV2aWNlIHdpdGggd3JpdGUtcHJvdGVjdGlvbiBzdXBwb3J0LCBlLmcuIGVNTUMsIHJlZ2lz
dGVyDQpjaGVja19kaXNrX3JhbmdlX3dwKCkgaW4gc3RydWN0IGJsb2NrX2RldmljZV9vcGVyYXRp
b25zIGZvciBjaGVja2luZw0Kd3JpdGUtcHJvdGVjdGlvbiBzdGF0dXMuIFdoZW4gY3JlYXRpbmcg
YmxvY2sgZGV2aWNlIGZvciBhIHBhcnRpdGlvbiwgc2V0DQpyZWFkL3dyaXRlIHBvbGljeSBhY2Nv
cmRpbmcgdG8gcmVzdWx0IG9mIGNoZWNrX2Rpc2tfcmFuZ2Vfd3AoKSBvcGVyYXRpb24NCihpZiBy
ZWdpc3RlcmVkKS4NCg0KV2l0aG91dCB0aGlzIHBhdGNoLCBybyBhdHRyaWJ1dGUgaXMgbm90IHNl
dCBmb3IgY3JlYXRlZCBibG9jayBkZXZpY2Ugb2YNCndyaXRlLXByb3RlY3RlZCBwYXJ0aXRpb24u
IFVzZXIgcGVyZm9ybSBhc3luY2hyb25vdXMgYnVmZmVyZWQgd3JpdGUgdG8NCnN1Y2ggcGFydGl0
aW9uIHdvbid0IGdldCBpbW1lZGlhdGUgZXJyb3IgYW5kIHRoZXJlZm9yZSBoZSB3b24ndCBiZSBh
d2FyZWQNCnRoYXQgd3JpdGUgaXMgbm90IGFjdHVhbGx5IHBlcmZvcm1lZC4NCldpdGggdGhpcyBw
YXRjaCwgcm8gYXR0cmlidXRlIGlzIHNldCBmb3IgY3JlYXRlZCBibG9jayBkZXZpY2Ugb2YNCndy
aXRlLXByb3RlY3RlZCBwYXJ0aXRpb24uIFVzZXIgcGVyZm9ybSBhc3luY2hyb25vdXMgYnVmZmVy
ZWQgd3JpdGUgdG8NCnN1Y2ggcGFydGl0aW9uIHdpbGwgZ2V0IGltbWVkaWF0ZSBlcnJvciBhbmQg
dGhlcmVmb3JlIGhlIHdpbGwgYmUgYXdhcmVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaWdodCBIc2ll
aCA8bGlnaHQuaHNpZWhAbWVkaWF0ZWsuY29tPg0KLS0tDQogYmxvY2svcGFydGl0aW9uLWdlbmVy
aWMuYyB8IDEwICsrKysrKysrKysNCiBkcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMgIHwgIDEgKw0K
IGluY2x1ZGUvbGludXgvYmxrZGV2LmggICAgfCAgMSArDQogMyBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9ibG9jay9wYXJ0aXRpb24tZ2VuZXJpYy5jIGIv
YmxvY2svcGFydGl0aW9uLWdlbmVyaWMuYw0KaW5kZXggNTY0ZmFlNy4uNjkwODhlOCAxMDA2NDQN
Ci0tLSBhL2Jsb2NrL3BhcnRpdGlvbi1nZW5lcmljLmMNCisrKyBiL2Jsb2NrL3BhcnRpdGlvbi1n
ZW5lcmljLmMNCkBAIC0zOTQsNiArMzk0LDE2IEBAIHN0cnVjdCBoZF9zdHJ1Y3QgKmFkZF9wYXJ0
aXRpb24oc3RydWN0IGdlbmRpc2sgKmRpc2ssIGludCBwYXJ0bm8sDQogCQlnb3RvIG91dF9mcmVl
X2luZm87DQogCXBkZXYtPmRldnQgPSBkZXZ0Ow0KIA0KKwlpZiAoIXAtPnBvbGljeSkgew0KKwkJ
aWYgKGRpc2stPmZvcHMtPmNoZWNrX2Rpc2tfcmFuZ2Vfd3ApIHsNCisJCQllcnIgPSBkaXNrLT5m
b3BzLT5jaGVja19kaXNrX3JhbmdlX3dwKGRpc2ssIHN0YXJ0LCBsZW4pOw0KKwkJCWlmIChlcnIg
PiAwKQ0KKwkJCQlwLT5wb2xpY3kgPSAxOw0KKwkJCWVsc2UgaWYgKGVyciAhPSAwKQ0KKwkJCQln
b3RvIG91dF9mcmVlX2luZm87DQorCQl9DQorCX0NCisNCiAJLyogZGVsYXkgdWV2ZW50IHVudGls
ICdob2xkZXJzJyBzdWJkaXIgaXMgY3JlYXRlZCAqLw0KIAlkZXZfc2V0X3VldmVudF9zdXBwcmVz
cyhwZGV2LCAxKTsNCiAJZXJyID0gZGV2aWNlX2FkZChwZGV2KTsNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9jb3JlL2Jsb2NrLmMgYi9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCmluZGV4IGVl
ODVhYmYuLmFmODEzMTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMNCisr
KyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KQEAgLTEwNDcsNiArMTA0Nyw3IEBAIHN0YXRp
YyBpbnQgbW1jX2Jsa19jb21wYXRfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1v
ZGVfdCBtb2RlLA0KICNpZmRlZiBDT05GSUdfQ09NUEFUDQogCS5jb21wYXRfaW9jdGwJCT0gbW1j
X2Jsa19jb21wYXRfaW9jdGwsDQogI2VuZGlmDQorCS5jaGVja19kaXNrX3JhbmdlX3dwCT0gbW1j
X2Jsa19jaGVja19kaXNrX3JhbmdlX3dwLA0KIH07DQogDQogc3RhdGljIGludCBtbWNfYmxrX3Bh
cnRfc3dpdGNoX3ByZShzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsDQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9ibGtkZXYuaCBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCmluZGV4IDA1M2VhNGIu
Ljc4MTQyOTAgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oDQorKysgYi9pbmNs
dWRlL2xpbnV4L2Jsa2Rldi5oDQpAQCAtMTcwNyw2ICsxNzA3LDcgQEAgc3RydWN0IGJsb2NrX2Rl
dmljZV9vcGVyYXRpb25zIHsNCiAJdm9pZCAoKnN3YXBfc2xvdF9mcmVlX25vdGlmeSkgKHN0cnVj
dCBibG9ja19kZXZpY2UgKiwgdW5zaWduZWQgbG9uZyk7DQogCWludCAoKnJlcG9ydF96b25lcyko
c3RydWN0IGdlbmRpc2sgKiwgc2VjdG9yX3Qgc2VjdG9yLA0KIAkJCXVuc2lnbmVkIGludCBucl96
b25lcywgcmVwb3J0X3pvbmVzX2NiIGNiLCB2b2lkICpkYXRhKTsNCisJaW50ICgqY2hlY2tfZGlz
a19yYW5nZV93cCkoc3RydWN0IGdlbmRpc2sgKmQsIHNlY3Rvcl90IHMsIHNlY3Rvcl90IGwpOw0K
IAlzdHJ1Y3QgbW9kdWxlICpvd25lcjsNCiAJY29uc3Qgc3RydWN0IHByX29wcyAqcHJfb3BzOw0K
IH07DQotLSANCjEuOC4xLjEuZGlydHkNCg==

