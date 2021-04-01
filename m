Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C3C07318
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D0561277
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhDARqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhDARlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 13:41:02 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06FD5C022584;
        Thu,  1 Apr 2021 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=wmXPJkyyre8yO1CKTCpRZz7wLSxkpPRR5WXx
        /hPtxME=; b=O6wPq+OUGRCgMtesXvQuGSmHShhvPTLjDIyX5nTgJUupZw3E8LGR
        gTxfyFFCtH5BAVhDK9tHdGKkgcpsTKvuBuf1YB8Pkz6KmeQHu3/926K5wQHszJhQ
        Cg2E7yRLhostKVH6pb06B7B4KmZ5Z2y4vqVPTCvqvjV1tnLx1Zd0G0U=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 1 Apr
 2021 23:17:27 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Thu, 1 Apr 2021 23:17:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     lyl2019@mail.ustc.edu.cn
Cc:     =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: Re: Re: Re: [Drbd-dev] [PATCH] drbd: Fix a use after free in
 get_initial_state
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <5b14fa53.26b7e.1788dff8d13.Coremail.lyl2019@mail.ustc.edu.cn>
References: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
 <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
 <5b14fa53.26b7e.1788dff8d13.Coremail.lyl2019@mail.ustc.edu.cn>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <17336352.26b99.1788e02bf3d.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBnbkII5GVgfdWCAA--.3W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoSBlQhn5pzrwABsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogbHlsMjAxOUBtYWls
LnVzdGMuZWR1LmNuDQo+IOWPkemAgeaXtumXtDogMjAyMS0wNC0wMSAyMzoxMzo1OCAo5pif5pyf
5ZubKQ0KPiDmlLbku7bkuro6ICJDaHJpc3RvcGggQsO2aG13YWxkZXIiIDxjaHJpc3RvcGguYm9l
aG13YWxkZXJAbGluYml0LmNvbT4NCj4g5oqE6YCBOiBwaGlsaXBwLnJlaXNuZXJAbGluYml0LmNv
bSwgbGFycy5lbGxlbmJlcmdAbGluYml0LmNvbSwgYXhib2VAa2VybmVsLmRrLCBsaW51eC1ibG9j
a0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIGRyYmQtZGV2
QGxpc3RzLmxpbmJpdC5jb20NCj4g5Li76aKYOiBSZTogUmU6IFtEcmJkLWRldl0gW1BBVENIXSBk
cmJkOiBGaXggYSB1c2UgYWZ0ZXIgZnJlZSBpbiBnZXRfaW5pdGlhbF9zdGF0ZQ0KPiANCj4gDQo+
IA0KPiANCj4gPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+ID4g5Y+R5Lu25Lq6OiAiQ2hyaXN0
b3BoIELDtmhtd2FsZGVyIiA8Y2hyaXN0b3BoLmJvZWhtd2FsZGVyQGxpbmJpdC5jb20+DQo+ID4g
5Y+R6YCB5pe26Ze0OiAyMDIxLTA0LTAxIDIxOjAxOjIwICjmmJ/mnJ/lm5spDQo+ID4g5pS25Lu2
5Lq6OiAiTHYgWXVubG9uZyIgPGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbj4NCj4gPiDmioTpgIE6
IHBoaWxpcHAucmVpc25lckBsaW5iaXQuY29tLCBsYXJzLmVsbGVuYmVyZ0BsaW5iaXQuY29tLCBh
eGJvZUBrZXJuZWwuZGssIGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZywgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZywgZHJiZC1kZXZAbGlzdHMubGluYml0LmNvbQ0KPiA+IOS4u+mimDog
UmU6IFtEcmJkLWRldl0gW1BBVENIXSBkcmJkOiBGaXggYSB1c2UgYWZ0ZXIgZnJlZSBpbiBnZXRf
aW5pdGlhbF9zdGF0ZQ0KPiA+IA0KPiA+IE9uIDQvMS8yMSAxOjU3IFBNLCBMdiBZdW5sb25nIHdy
b3RlOg0KPiA+ID4gSW4gZ2V0X2luaXRpYWxfc3RhdGUsIGl0IGNhbGxzIG5vdGlmeV9pbml0aWFs
X3N0YXRlX2RvbmUoc2tiLC4uKSBpZg0KPiA+ID4gY2ItPmFyZ3NbNV09PTEuIEkgc2VlIHRoYXQg
aWYgZ2VubG1zZ19wdXQoKSBmYWlsZWQgaW4NCj4gPiA+IG5vdGlmeV9pbml0aWFsX3N0YXRlX2Rv
bmUoKSwgdGhlIHNrYiB3aWxsIGJlIGZyZWVkIGJ5IG5sbXNnX2ZyZWUoc2tiKS4NCj4gPiA+IFRo
ZW4gZ2V0X2luaXRpYWxfc3RhdGUgd2lsbCBnb3RvIG91dCBhbmQgdGhlIGZyZWVkIHNrYiB3aWxs
IGJlIHVzZWQgYnkNCj4gPiA+IHJldHVybiB2YWx1ZSBza2ItPmxlbi4NCj4gPiA+IA0KPiA+ID4g
TXkgcGF0Y2ggbGV0cyBza2JfbGVuID0gc2tiLT5sZW4gYW5kIHJldHVybiB0aGUgc2tiX2xlbiB0
byBhdm9pZCB0aGUgdWFmLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogYTI5NzI4NDYzYjI1NCAoImRy
YmQ6IEJhY2twb3J0IHRoZSAiZXZlbnRzMiIgY29tbWFuZCIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMdiBZdW5sb25nIDxseWwyMDE5QG1haWwudXN0Yy5lZHUuY24+DQo+ID4gPiAtLS0NCj4gPiA+
ICAgZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfbmwuYyB8IDMgKystDQo+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMgYi9kcml2ZXJzL2Jsb2NrL2Ry
YmQvZHJiZF9ubC5jDQo+ID4gPiBpbmRleCBiZjdkZTRjN2I5NmMuLjQ3NGY4NDY3NWQwYSAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMNCj4gPiA+ICsrKyBi
L2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMNCj4gPiA+IEBAIC00OTA1LDYgKzQ5MDUsNyBA
QCBzdGF0aWMgaW50IGdldF9pbml0aWFsX3N0YXRlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBuZXRsaW5rX2NhbGxiYWNrICpjYikNCj4gPiA+ICAgCXN0cnVjdCBkcmJkX3N0YXRlX2NoYW5n
ZSAqc3RhdGVfY2hhbmdlID0gKHN0cnVjdCBkcmJkX3N0YXRlX2NoYW5nZSAqKWNiLT5hcmdzWzBd
Ow0KPiA+ID4gICAJdW5zaWduZWQgaW50IHNlcSA9IGNiLT5hcmdzWzJdOw0KPiA+ID4gICAJdW5z
aWduZWQgaW50IG47DQo+ID4gPiArCXVuc2lnbmVkIGludCBza2JfbGVuID0gc2tiLT5sZW47DQo+
ID4gPiAgIAllbnVtIGRyYmRfbm90aWZpY2F0aW9uX3R5cGUgZmxhZ3MgPSAwOw0KPiA+ID4gICAN
Cj4gPiA+ICAgCS8qIFRoZXJlIGlzIG5vIG5lZWQgZm9yIHRha2luZyBub3RpZmljYXRpb25fbXV0
ZXggaGVyZTogaXQgZG9lc24ndA0KPiA+ID4gQEAgLTQ5MTUsNyArNDkxNiw3IEBAIHN0YXRpYyBp
bnQgZ2V0X2luaXRpYWxfc3RhdGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldGxpbmtf
Y2FsbGJhY2sgKmNiKQ0KPiA+ID4gICAJY2ItPmFyZ3NbNV0tLTsNCj4gPiA+ICAgCWlmIChjYi0+
YXJnc1s1XSA9PSAxKSB7DQo+ID4gPiAgIAkJbm90aWZ5X2luaXRpYWxfc3RhdGVfZG9uZShza2Is
IHNlcSk7DQo+ID4gPiAtCQlnb3RvIG91dDsNCj4gPiA+ICsJCXJldHVybiBza2JfbGVuOw0KPiA+
ID4gICAJfQ0KPiA+ID4gICAJbiA9IGNiLT5hcmdzWzRdKys7DQo+ID4gPiAgIAlpZiAoY2ItPmFy
Z3NbNF0gPCBjYi0+YXJnc1szXSkNCj4gPiA+IA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIHBh
dGNoIQ0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHByb2JsZW0gZ29lcyBldmVuIGZ1cnRoZXI6IHNr
YiBjYW4gYWxzbyBiZSBmcmVlZCBpbiB0aGUgDQo+ID4gbm90aWZ5Xypfc3RhdGVfY2hhbmdlIC0+
IG5vdGlmeV8qX3N0YXRlIGNhbGxzIGJlbG93Lg0KPiA+IA0KPiA+IEFsc28sIGF0IHRoZSBwb2lu
dCB3aGVyZSB3ZSBzYXZlIHNrYi0+bGVuIGludG8gc2tiX2xlbiwgc2tiIGlzIG5vdCANCj4gPiBp
bml0aWFsaXplZCB5ZXQuIE1heWJlIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gbm90IHJldHVybiBh
IGxlbmd0aCBpbiB0aGUgDQo+ID4gZmlyc3QgcGxhY2UgaGVyZSwgYnV0IGFuIGVycm9yIGNvZGUg
aW5zdGVhZC4NCj4gPiANCj4gPiAtLSANCj4gPiBDaHJpc3RvcGggQsO2aG13YWxkZXINCj4gPiBM
SU5CSVQgfCBLZWVwaW5nIHRoZSBEaWdpdGFsIFdvcmxkIFJ1bm5pbmcNCj4gPiBEUkJEIEhBIOKA
lCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQ0KPiANCj4g
T2ssIEkgc2VlLg0KPiBJIGZvdW5kIHRoYXQgZHJiZF9hZG1fZ2V0X2luaXRpYWxfc3RhdGUoKSBo
YXMgY2FsbGVkIHRoZSBnZXRfaW5pdGlhbF9zdGF0ZSgpLA0KPiBhbmQgcmV0dXJuIC1FTk9NRU0g
aWYgaXQgY2FsbHMgcmVtZW1iZXJfb2xkX3N0YXRlKCkgZmFpbGVkLg0KPiANCj4gU28sIGkgdGhp
bmsgdGhhdCBtZWFucyBpZiBnZXRfaW5pdGlhbF9zdGF0ZSgpIGZhaWxlZCBvbiB0aGUgbm90aWZ5
X2luaXRpYWxfc3RhdGVfZG9uZSgpLA0KPiBpdCBzaG91bGQgcmV0dXJuIC1FTk9NRU0gdG9vLg0K
PiANCj4gSSB3aWxsIHN1Ym1pdCB0aGUgUEFUQ0ggdjIgdG8gZml4IHRoZSBmaXJzdCBwbGFjZS4g
VGhlIGZpeGVzIG9mIHRoZSBmdXJ0aGVyIHByb2JsZW0gaXMgDQo+IGhhcmQgZm9yIG1lLg0KPiAN
Cj4gVGhhbmtzLg0KDQpJIGZvdW5kIHRoYXQgbm90aWZ5X2luaXRpYWxfc3RhdGVfZG9uZSgpIHVz
ZXMgZXJyID0gLUVNU0dTSVpFLCBzbyB0aGUgZmlyc3QgcGxhY2Ugc2hvdWxkDQpyZXR1cm4gLUVN
U0dTSVpFIG5vdCAtRU5PTUVNLiBTb3JyeS4NCg==
