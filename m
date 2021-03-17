Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A1C433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516AE64F64
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhCQLjF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 07:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCQLii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 07:38:38 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71DDDC06174A
        for <linux-block@vger.kernel.org>; Wed, 17 Mar 2021 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=wd68+pibuSXbQrmYJADKzxbs/owPcJv3zKOt
        OoJlJRo=; b=VnsyivwRh/NOH6PghLtexN6EsZ9YeyL3ZVy8AVlMovWCqmDQg2+a
        zj11HshmfH4OB6K0/N4xW8Q4ardYirk3dv2DyeAN2oTT2Cs2+JU7ae/DKEv6wHgs
        Qy8oJULKTVEab6GSm0MjA+YPt4+/2vdZF0/0nt+BDjJ4mmnetnqeuTE=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Wed, 17 Mar
 2021 19:38:23 +0800 (GMT+08:00)
X-Originating-IP: [202.38.69.14]
Date:   Wed, 17 Mar 2021 19:38:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   lyl2019@mail.ustc.edu.cn
To:     "Paolo Valente" <paolo.valente@linaro.org>
Cc:     "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org,
        security@kernel.org
Subject: Re: Re: [BUG] block/bfq-wf2q: A Use After Free bug in
 bfq_del_bfqq_busy
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2021 www.mailtech.cn ustc-xl
In-Reply-To: <369719A6-7C64-451F-89C9-1A36436F9B82@linaro.org>
References: <24de85db.8011.1781a216e77.Coremail.lyl2019@mail.ustc.edu.cn>
 <275344D4-8DF4-4F7B-A3C9-592CE2DB0AC8@linaro.org>
 <3c562db4.1111e.1782be320c5.Coremail.lyl2019@mail.ustc.edu.cn>
 <369719A6-7C64-451F-89C9-1A36436F9B82@linaro.org>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <183ded8e.1c1f4.1783ffacaab.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygAHBRUv6lFgzVE3AA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQsDBlQhn5LpHwADsC
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T2ssIGkgdGhpbmsgaXQgaXMgYSBmYWxzZSBwb3NpdGl2ZSBub3cuDQpUaGFua3MgZm9yIHlvdXIg
dGltZSBhbmQgcGF0aWVudCBhbnN3ZXIuDQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+
IOWPkeS7tuS6ujogIlBhb2xvIFZhbGVudGUiIDxwYW9sby52YWxlbnRlQGxpbmFyby5vcmc+DQo+
IOWPkemAgeaXtumXtDogMjAyMS0wMy0xNiAxNTo1NTo0NCAo5pif5pyf5LqMKQ0KPiDmlLbku7bk
uro6IGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbg0KPiDmioTpgIE6ICJKZW5zIEF4Ym9lIiA8YXhi
b2VAa2VybmVsLmRrPiwgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnLCBzZWN1cml0eUBrZXJu
ZWwub3JnDQo+IOS4u+mimDogUmU6IFtCVUddIGJsb2NrL2JmcS13ZjJxOiBBIFVzZSBBZnRlciBG
cmVlIGJ1ZyBpbiBiZnFfZGVsX2JmcXFfYnVzeQ0KPiANCj4gDQo+IA0KPiA+IElsIGdpb3JubyAx
MyBtYXIgMjAyMSwgYWxsZSBvcmUgMTU6MDAsIGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbiBoYSBz
Y3JpdHRvOg0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+PiAtLS0tLeWOn+Wni+mCruS7ti0t
LS0tDQo+ID4+IOWPkeS7tuS6ujogIlBhb2xvIFZhbGVudGUiIDxwYW9sby52YWxlbnRlQGxpbmFy
by5vcmc+DQo+ID4+IOWPkemAgeaXtumXtDogMjAyMS0wMy0xMiAyMjo0NzoyMiAo5pif5pyf5LqU
KQ0KPiA+PiDmlLbku7bkuro6IGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbg0KPiA+PiDmioTpgIE6
ICJKZW5zIEF4Ym9lIiA8YXhib2VAa2VybmVsLmRrPiwgbGludXgtYmxvY2tAdmdlci5rZXJuZWwu
b3JnLCBzZWN1cml0eUBrZXJuZWwub3JnDQo+ID4+IOS4u+mimDogUmU6IFtCVUddIGJsb2NrL2Jm
cS13ZjJxOiBBIFVzZSBBZnRlciBGcmVlIGJ1ZyBpbiBiZnFfZGVsX2JmcXFfYnVzeQ0KPiA+PiAN
Cj4gPj4gDQo+ID4+IA0KPiA+Pj4gSWwgZ2lvcm5vIDEwIG1hciAyMDIxLCBhbGxlIG9yZSAwNDox
NSwgbHlsMjAxOUBtYWlsLnVzdGMuZWR1LmNuIGhhIHNjcml0dG86DQo+ID4+PiANCj4gPj4+IEZp
bGU6IGJsb2NrL2JmcS13ZjJxLmMNCj4gPj4+IA0KPiA+Pj4gVGhlcmUgZXhpc3QgYSBmZWFzaWJs
ZSBwYXRoIHRvIHRyaWdnZXIgYSB1c2UgYWZ0ZXIgZnJlZSBidWcgaW4NCj4gPj4+IGJmcV9kZWxf
YmZxcV9idXN5LCBzaW5jZSB2NC4xMi1yYzEuIEl0IGNvdWxkIGNhdXNlIGRlbmlhbCBvZiBzZXJ2
aWNlLg0KPiA+Pj4gDQo+ID4+IA0KPiA+PiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBhbmFseXpp
bmcgdGhpcy4NCj4gPj4gDQo+ID4+PiBJbiB0aGUgaW1wbGVtZW50aW9uIG9mIGJmcV9kZWxfYmZx
cV9idXN5LA0KPiA+PiANCj4gPj4gSSd2ZSBjaGVja2VkIGFsbCBpbnZvY2F0aW9ucyBvZiBiZnFf
ZGVsX2JmcXFfYnVzeSwgY29tbWVudHMgYmVsb3cuDQo+ID4+IA0KPiA+Pj4gaXQgY2FsbHMgYmZx
X2RlYWN0aXZhdGVfYmZxcSgpDQo+ID4+PiBhbmQgdXNlIGBiZnFxYCBsYXRlci4gV2hlcmVhcyBi
ZnFfZGVhY3RpdmF0ZV9iZnFxKCkgY291bGQgZnJlZSBgYmZxcWAuDQo+ID4+PiANCj4gPj4+IFRo
ZSB0cmlnZ2VyIHBhdGggaXMgYXMgZm9sbG93Og0KPiA+Pj4gfC0gYmZxX2RlYWN0aXZhdGVfYmZx
cSguLiwgYmZxcSwgdHJ1ZSwgLi4pDQo+ID4+PiB8LS0gIGVudGl0eSA9ICZiZnFxLT5lbnRpdHk7
ICAgLy8gZ2V0IGVudGl0eQ0KPiA+Pj4gfC0tICBiZnFfZGVhY3RpdmF0ZV9lbnRpdHkoZW50aXR5
LCB0cnVlLCAuLi4pOyAvL2hhcyBhIHBhdGggdG8gZnJlZSBgYmZxcWANCj4gPj4+IHwtLSAgaWYg
KCFiZnFxLT5kaXNwYXRjaGVkKSAvLyB1c2UgYWZ0ZXIgZnJlZSENCj4gPj4+IAkJDQo+ID4+PiAN
Cj4gPj4+IHwtIGJmcV9kZWFjdGl2YXRlX2VudGl0eShlbnRpdHksIHRydWUsIC4uLikNCj4gPj4+
IHwtLSAgLi4uDQo+ID4+PiB8LS0gIGZvcl9lYWNoX2VudGl0eV9zYWZlKGVudGl0eSwgcGFyZW50
KSB7IC8vIGluIHRoZSBmaXJzdCBsb29wLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLy9lbnRpdHkgaXMgdGhlIHNhbWUgYXMgYmVmb3JlDQo+ID4+PiAJCWlmICghX19iZnFfZGVh
Y3RpdmF0ZV9lbnRpdHkoZW50aXR5LCB0cnVlKSkgew0KPiA+Pj4gDQo+ID4+PiB8LSBfX2JmcV9k
ZWFjdGl2YXRlX2VudGl0eShlbnRpdHksIHRydWUpDQo+ID4+PiB8LS0gIC4uLg0KPiA+Pj4gfC0t
ICBpZiAoIWluc19pbnRvX2lkbGVfdHJlZSB8fCAhYmZxX2d0KGVudGl0eS0+ZmluaXNoLCBzdC0+
dnRpbWUpKQ0KPiA+Pj4gCQliZnFfZm9yZ2V0X2VudGl0eShzdCwgZW50aXR5LCBpc19pbl9zZXJ2
aWNlKTsgDQo+ID4+PiANCj4gPj4+IHwtIGJmcV9mb3JnZXRfZW50aXR5KHN0LCBlbnRpdHksIGlz
X2luX3NlcnZpY2UpDQo+ID4+PiB8LS0gICBiZnFxID0gYmZxX2VudGl0eV90b19iZnFxKGVudGl0
eSk7IC8vIHJlY292ZXIgYGJmcXFgIGJ5IGVudGl0eQ0KPiA+Pj4gfC0tCWlmIChiZnFxICYmICFp
c19pbl9zZXJ2aWNlKQ0KPiA+Pj4gCQkgYmZxX3B1dF9xdWV1ZShiZnFxKTsgLy8gZnJlZSB0aGUg
YGJmcXFgDQo+ID4+PiANCj4gPj4gDQo+ID4+IEZvciB0aGlzIHB1dCB0byB0dXJuIGludG8gYSBm
cmVlLCBiZnFxIHNob3VsZCBoYXZlIG9ubHkgb25lIHJlZi4gIEJ1dA0KPiA+PiBJIGRpZCBub3Qg
ZmluZCBhbnkgaW52b2NhdGlvbiBvZiBiZnFfZGVsX2JmcXFfYnVzeSB3aXRoIGJmcXEtPnJlZiA9
PSAxLg0KPiA+PiANCj4gPj4gRGlkIHlvdSBzcG90IGFueT8NCj4gPj4gDQo+ID4+IExvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIGZlZWRiYWNrLA0KPiA+PiBQYW9sbw0KPiA+PiANCj4gPj4+IFRoZSBi
dWcgZml4IG5lZWRzIHRvIGFkZCBzb21lIGNoZWNrcyB0byBhdm9pZCBmcmVlaW5nIGBiZnFxYCBp
biB0aGUgZmlyc3QNCj4gPj4+IGxvb3AgaW4gX19iZnFfZGVhY3RpdmF0ZV9lbnRpdHkoKS4gSSBj
YW4ndCBjb21lIG91dCBhIGdvb2QgcGF0Y2ggZm9yIGl0LA0KPiA+Pj4gc28gaSByZXBvcnQgaXQg
Zm9yIHlvdS4NCj4gPj4gDQo+ID4gDQo+ID4gSSB0aGUgZmlsZSBibG9jay9iZnEtaW9zY2hlZC5j
LCBmdW5jdGlvbiBiZnFfcmVtb3ZlX3JlcXVlc3QgZ2V0IGJmcXEgYnkgDQo+ID4gIlJRX0JGUVEo
cnEpOyIuIENhbiB3ZSBhc3N1bWUgYmZxcS0+cmVmID09MSBhdCB0aGlzIHRpbWU/IEFmdGVyIGJm
cV9yZW1vdmVfcmVxdWVzdCANCj4gPiBnb3QgdGhlIGJmcXEsIHRoZXJlIGlzIG5vIHJlZiBpbmNy
ZWFzZSBvcGVyYXRpb24gYmVmb3JlIGNhbGxzIGJmcV9kZWxfYmZxcV9idXN5KCkuDQo+ID4gDQo+
IA0KPiBUaGUgc2NoZW1lIGlzOiBhIHJlZiBpcyB0YWtlbiBmb3IgYSByZXF1ZXN0IGFycml2YWwg
aW50byBhIGJmcV9xdWV1ZSwNCj4gaW4gX19iZnFfaW5zZXJ0X3JlcXVlc3QsIGFuZCB0aGVuIHRo
YXQgcmVmIGlzIHJlbGVhc2VkIG9uIHRoZQ0KPiBjb21wbGV0aW9uIG9mIHRoYXQgcmVxdWVzdCwg
aW4gYmZxX2ZpbmlzaF9yZXF1ZXVlX3JlcXVlc3RfYm9keS4gIEluDQo+IHRoaXMgcmVzcGVjdCwg
YmZxX3JlbW92ZV9yZXF1ZXN0IGlzIGludm9rZWQgZm9yIGEgcmVxdWVzdCBvbmx5IGJlZm9yZQ0K
PiBiZnFfZmluaXNoX3JlcXVldWVfcmVxdWVzdF9ib2R5IGlzIGludm9rZWQgZm9yIHRoZSBzYW1l
IHJlcXVlc3QuICBTbw0KPiB0aGUgYmZxX2RlbF9iZnFxX2J1c3kgaW52b2NhdGlvbiB0aGF0IHlv
dSBoaWdobGlnaHQgc2hvdWxkIG5vdCBsZWFkIHRvDQo+IGEgZnJlZSwgYmVjYXVzZSB0aGUgcmVm
IGNvdW50ZXIgc2hvdWxkIHJlbWFpbiBhbHdheXMgaGlnaGVyIHRoYW4gMC4NCj4gSWYgeW91IHRo
aW5rIEknbSBtaXNzaW5nIHNvbWV0aGluZyAod2hpY2ggaXMgcG9zc2libGUgYW5kIHdlbGNvbWUh
KSwNCj4gdHJ5IHRvIHdyaXRlIHRoZSBzZXF1ZW5jZSBvZiBldmVudHMgdGhhdCBsZWFkcyB0byB0
aGUgZnJlZSB5b3UNCj4gc3VzcGVjdCwgYW5kIHRvIHNob3cgdGhhdCB0aGUgY291bnRlciBhY3R1
YWxseSByZWFjaGVzIHplcm8uICBSZWNhbGwNCj4gdGhhdCBhIGRlYWN0aXZhdGUgc2hvdWxkIGJl
IHBhaXJlZCB3aXRoIGFuIGFjdGl2YXRpb24sIGFuZCBhbg0KPiBhY3RpdmF0aW9uIHNob3VsZCBh
bHdheXMgY2F1c2UgdGhlIHJlZiBjb3VudGVyIHRvIGJlIGluY3JlYXNlZC4NCj4gDQo+IExvb2tp
bmcgZm9yd2FyZCB0byB5b3VyIGZlZWRiYWNrLA0KPiBQYW9sbw0KPiANCg==
