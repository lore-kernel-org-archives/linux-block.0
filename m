Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E0BC001BF
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2132260FEF
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhDASRu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbhDASIo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 14:08:44 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BE3BC00F7F3;
        Thu,  1 Apr 2021 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=IMWqcG5DEpdf8+c6+2Rmv2KzMd3Qr2bVAXkr
        IuCz158=; b=m6GHA/rBlvJ3Oxw04oYG2J7cBsbXWAUKTu6T7dl28ofUwFycj6Zm
        SN7Z6mvoAHnppI4lQitWk63Sp1XS5gPpX5Pz87eCVGIZFRJc3wEdtNY3olQzqjSY
        WPFn014sfDOs5xiK5y0YiSLiKEwsv/e9+rjVf0YxfEVuJGWUzP4Us2k=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Thu, 1 Apr
 2021 23:13:58 +0800 (GMT+08:00)
X-Originating-IP: [156.234.142.150]
Date:   Thu, 1 Apr 2021 23:13:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: Re: [Drbd-dev] [PATCH] drbd: Fix a use after free in
 get_initial_state
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
References: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
 <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5b14fa53.26b7e.1788dff8d13.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygA3P28242VgN8+CAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoSBlQhn5pzrwAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIkNocmlzdG9waCBC
w7ZobXdhbGRlciIgPGNocmlzdG9waC5ib2VobXdhbGRlckBsaW5iaXQuY29tPg0KPiDlj5HpgIHm
l7bpl7Q6IDIwMjEtMDQtMDEgMjE6MDE6MjAgKOaYn+acn+WbmykNCj4g5pS25Lu25Lq6OiAiTHYg
WXVubG9uZyIgPGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbj4NCj4g5oqE6YCBOiBwaGlsaXBwLnJl
aXNuZXJAbGluYml0LmNvbSwgbGFycy5lbGxlbmJlcmdAbGluYml0LmNvbSwgYXhib2VAa2VybmVs
LmRrLCBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcsIGRyYmQtZGV2QGxpc3RzLmxpbmJpdC5jb20NCj4g5Li76aKYOiBSZTogW0RyYmQtZGV2
XSBbUEFUQ0hdIGRyYmQ6IEZpeCBhIHVzZSBhZnRlciBmcmVlIGluIGdldF9pbml0aWFsX3N0YXRl
DQo+IA0KPiBPbiA0LzEvMjEgMTo1NyBQTSwgTHYgWXVubG9uZyB3cm90ZToNCj4gPiBJbiBnZXRf
aW5pdGlhbF9zdGF0ZSwgaXQgY2FsbHMgbm90aWZ5X2luaXRpYWxfc3RhdGVfZG9uZShza2IsLi4p
IGlmDQo+ID4gY2ItPmFyZ3NbNV09PTEuIEkgc2VlIHRoYXQgaWYgZ2VubG1zZ19wdXQoKSBmYWls
ZWQgaW4NCj4gPiBub3RpZnlfaW5pdGlhbF9zdGF0ZV9kb25lKCksIHRoZSBza2Igd2lsbCBiZSBm
cmVlZCBieSBubG1zZ19mcmVlKHNrYikuDQo+ID4gVGhlbiBnZXRfaW5pdGlhbF9zdGF0ZSB3aWxs
IGdvdG8gb3V0IGFuZCB0aGUgZnJlZWQgc2tiIHdpbGwgYmUgdXNlZCBieQ0KPiA+IHJldHVybiB2
YWx1ZSBza2ItPmxlbi4NCj4gPiANCj4gPiBNeSBwYXRjaCBsZXRzIHNrYl9sZW4gPSBza2ItPmxl
biBhbmQgcmV0dXJuIHRoZSBza2JfbGVuIHRvIGF2b2lkIHRoZSB1YWYuDQo+ID4gDQo+ID4gRml4
ZXM6IGEyOTcyODQ2M2IyNTQgKCJkcmJkOiBCYWNrcG9ydCB0aGUgImV2ZW50czIiIGNvbW1hbmQi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEx2IFl1bmxvbmcgPGx5bDIwMTlAbWFpbC51c3RjLmVkdS5j
bj4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMgfCAzICsrLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9ubC5jIGIvZHJpdmVy
cy9ibG9jay9kcmJkL2RyYmRfbmwuYw0KPiA+IGluZGV4IGJmN2RlNGM3Yjk2Yy4uNDc0Zjg0Njc1
ZDBhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9ubC5jDQo+ID4gQEAgLTQ5MDUsNiArNDkwNSw3
IEBAIHN0YXRpYyBpbnQgZ2V0X2luaXRpYWxfc3RhdGUoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3Ry
dWN0IG5ldGxpbmtfY2FsbGJhY2sgKmNiKQ0KPiA+ICAgCXN0cnVjdCBkcmJkX3N0YXRlX2NoYW5n
ZSAqc3RhdGVfY2hhbmdlID0gKHN0cnVjdCBkcmJkX3N0YXRlX2NoYW5nZSAqKWNiLT5hcmdzWzBd
Ow0KPiA+ICAgCXVuc2lnbmVkIGludCBzZXEgPSBjYi0+YXJnc1syXTsNCj4gPiAgIAl1bnNpZ25l
ZCBpbnQgbjsNCj4gPiArCXVuc2lnbmVkIGludCBza2JfbGVuID0gc2tiLT5sZW47DQo+ID4gICAJ
ZW51bSBkcmJkX25vdGlmaWNhdGlvbl90eXBlIGZsYWdzID0gMDsNCj4gPiAgIA0KPiA+ICAgCS8q
IFRoZXJlIGlzIG5vIG5lZWQgZm9yIHRha2luZyBub3RpZmljYXRpb25fbXV0ZXggaGVyZTogaXQg
ZG9lc24ndA0KPiA+IEBAIC00OTE1LDcgKzQ5MTYsNyBAQCBzdGF0aWMgaW50IGdldF9pbml0aWFs
X3N0YXRlKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRsaW5rX2NhbGxiYWNrICpjYikN
Cj4gPiAgIAljYi0+YXJnc1s1XS0tOw0KPiA+ICAgCWlmIChjYi0+YXJnc1s1XSA9PSAxKSB7DQo+
ID4gICAJCW5vdGlmeV9pbml0aWFsX3N0YXRlX2RvbmUoc2tiLCBzZXEpOw0KPiA+IC0JCWdvdG8g
b3V0Ow0KPiA+ICsJCXJldHVybiBza2JfbGVuOw0KPiA+ICAgCX0NCj4gPiAgIAluID0gY2ItPmFy
Z3NbNF0rKzsNCj4gPiAgIAlpZiAoY2ItPmFyZ3NbNF0gPCBjYi0+YXJnc1szXSkNCj4gPiANCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNoIQ0KPiANCj4gSSB0aGluayB0aGUgcHJvYmxlbSBnb2Vz
IGV2ZW4gZnVydGhlcjogc2tiIGNhbiBhbHNvIGJlIGZyZWVkIGluIHRoZSANCj4gbm90aWZ5Xypf
c3RhdGVfY2hhbmdlIC0+IG5vdGlmeV8qX3N0YXRlIGNhbGxzIGJlbG93Lg0KPiANCj4gQWxzbywg
YXQgdGhlIHBvaW50IHdoZXJlIHdlIHNhdmUgc2tiLT5sZW4gaW50byBza2JfbGVuLCBza2IgaXMg
bm90IA0KPiBpbml0aWFsaXplZCB5ZXQuIE1heWJlIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gbm90
IHJldHVybiBhIGxlbmd0aCBpbiB0aGUgDQo+IGZpcnN0IHBsYWNlIGhlcmUsIGJ1dCBhbiBlcnJv
ciBjb2RlIGluc3RlYWQuDQo+IA0KPiAtLSANCj4gQ2hyaXN0b3BoIELDtmhtd2FsZGVyDQo+IExJ
TkJJVCB8IEtlZXBpbmcgdGhlIERpZ2l0YWwgV29ybGQgUnVubmluZw0KPiBEUkJEIEhBIOKAlCAg
RGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQ0KDQpPaywgSSBz
ZWUuDQpJIGZvdW5kIHRoYXQgZHJiZF9hZG1fZ2V0X2luaXRpYWxfc3RhdGUoKSBoYXMgY2FsbGVk
IHRoZSBnZXRfaW5pdGlhbF9zdGF0ZSgpLA0KYW5kIHJldHVybiAtRU5PTUVNIGlmIGl0IGNhbGxz
IHJlbWVtYmVyX29sZF9zdGF0ZSgpIGZhaWxlZC4NCg0KU28sIGkgdGhpbmsgdGhhdCBtZWFucyBp
ZiBnZXRfaW5pdGlhbF9zdGF0ZSgpIGZhaWxlZCBvbiB0aGUgbm90aWZ5X2luaXRpYWxfc3RhdGVf
ZG9uZSgpLA0KaXQgc2hvdWxkIHJldHVybiAtRU5PTUVNIHRvby4NCg0KSSB3aWxsIHN1Ym1pdCB0
aGUgUEFUQ0ggdjIgdG8gZml4IHRoZSBmaXJzdCBwbGFjZS4gVGhlIGZpeGVzIG9mIHRoZSBmdXJ0
aGVyIHByb2JsZW0gaXMgDQpoYXJkIGZvciBtZS4NCg0KVGhhbmtzLg0K
