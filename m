Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CAC433DB
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B03B64EDF
	for <linux-block@archiver.kernel.org>; Sat, 13 Mar 2021 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhCMOAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Mar 2021 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMOA2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Mar 2021 09:00:28 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6BFC061574
        for <linux-block@vger.kernel.org>; Sat, 13 Mar 2021 06:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=/h6+dfdMs2Y8MMBCOyqNy/auBd4YmVWNTtGI
        v0Jvnjg=; b=npYAsQgDQiRLKKps41gukZ0DknzLMZLr4wVCFk6Cnfo5u3sLudT+
        KhtIPTISY81kAuwCTZa2mtsZZ8eJxnlp0oWnQbLffCQfyTGGfApzI8nNxbKkUdZt
        FWTacY35B8+15TXX80FSfD6FEBUHShahpQkAtRafs8TA0LNDOsW4V7U=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Sat, 13 Mar
 2021 22:00:08 +0800 (GMT+08:00)
X-Originating-IP: [114.214.216.33]
Date:   Sat, 13 Mar 2021 22:00:08 +0800 (GMT+08:00)
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
In-Reply-To: <275344D4-8DF4-4F7B-A3C9-592CE2DB0AC8@linaro.org>
References: <24de85db.8011.1781a216e77.Coremail.lyl2019@mail.ustc.edu.cn>
 <275344D4-8DF4-4F7B-A3C9-592CE2DB0AC8@linaro.org>
X-SendMailWithSms: false
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3c562db4.1111e.1782be320c5.Coremail.lyl2019@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBnbBxoxUxgDvEbAA--.0W
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/1tbiAQoTBlQhn5DiAgAAsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCg0KPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tDQo+IOWPkeS7tuS6ujogIlBhb2xvIFZhbGVu
dGUiIDxwYW9sby52YWxlbnRlQGxpbmFyby5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAyMS0wMy0x
MiAyMjo0NzoyMiAo5pif5pyf5LqUKQ0KPiDmlLbku7bkuro6IGx5bDIwMTlAbWFpbC51c3RjLmVk
dS5jbg0KPiDmioTpgIE6ICJKZW5zIEF4Ym9lIiA8YXhib2VAa2VybmVsLmRrPiwgbGludXgtYmxv
Y2tAdmdlci5rZXJuZWwub3JnLCBzZWN1cml0eUBrZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtC
VUddIGJsb2NrL2JmcS13ZjJxOiBBIFVzZSBBZnRlciBGcmVlIGJ1ZyBpbiBiZnFfZGVsX2JmcXFf
YnVzeQ0KPiANCj4gDQo+IA0KPiA+IElsIGdpb3JubyAxMCBtYXIgMjAyMSwgYWxsZSBvcmUgMDQ6
MTUsIGx5bDIwMTlAbWFpbC51c3RjLmVkdS5jbiBoYSBzY3JpdHRvOg0KPiA+IA0KPiA+IEZpbGU6
IGJsb2NrL2JmcS13ZjJxLmMNCj4gPiANCj4gPiBUaGVyZSBleGlzdCBhIGZlYXNpYmxlIHBhdGgg
dG8gdHJpZ2dlciBhIHVzZSBhZnRlciBmcmVlIGJ1ZyBpbg0KPiA+IGJmcV9kZWxfYmZxcV9idXN5
LCBzaW5jZSB2NC4xMi1yYzEuIEl0IGNvdWxkIGNhdXNlIGRlbmlhbCBvZiBzZXJ2aWNlLg0KPiA+
IA0KPiANCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgYW5hbHl6aW5nIHRoaXMuDQo+IA0KPiA+
IEluIHRoZSBpbXBsZW1lbnRpb24gb2YgYmZxX2RlbF9iZnFxX2J1c3ksDQo+IA0KPiBJJ3ZlIGNo
ZWNrZWQgYWxsIGludm9jYXRpb25zIG9mIGJmcV9kZWxfYmZxcV9idXN5LCBjb21tZW50cyBiZWxv
dy4NCj4gDQo+ID4gaXQgY2FsbHMgYmZxX2RlYWN0aXZhdGVfYmZxcSgpDQo+ID4gYW5kIHVzZSBg
YmZxcWAgbGF0ZXIuIFdoZXJlYXMgYmZxX2RlYWN0aXZhdGVfYmZxcSgpIGNvdWxkIGZyZWUgYGJm
cXFgLg0KPiA+IA0KPiA+IFRoZSB0cmlnZ2VyIHBhdGggaXMgYXMgZm9sbG93Og0KPiA+IHwtIGJm
cV9kZWFjdGl2YXRlX2JmcXEoLi4sIGJmcXEsIHRydWUsIC4uKQ0KPiA+IHwtLSAgZW50aXR5ID0g
JmJmcXEtPmVudGl0eTsgICAvLyBnZXQgZW50aXR5DQo+ID4gfC0tICBiZnFfZGVhY3RpdmF0ZV9l
bnRpdHkoZW50aXR5LCB0cnVlLCAuLi4pOyAvL2hhcyBhIHBhdGggdG8gZnJlZSBgYmZxcWANCj4g
PiB8LS0gIGlmICghYmZxcS0+ZGlzcGF0Y2hlZCkgLy8gdXNlIGFmdGVyIGZyZWUhDQo+ID4gCQkN
Cj4gPiAgDQo+ID4gfC0gYmZxX2RlYWN0aXZhdGVfZW50aXR5KGVudGl0eSwgdHJ1ZSwgLi4uKQ0K
PiA+IHwtLSAgLi4uDQo+ID4gfC0tICBmb3JfZWFjaF9lbnRpdHlfc2FmZShlbnRpdHksIHBhcmVu
dCkgeyAvLyBpbiB0aGUgZmlyc3QgbG9vcCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLy9lbnRpdHkgaXMgdGhlIHNhbWUgYXMgYmVmb3JlDQo+ID4gIAkJaWYgKCFfX2JmcV9kZWFj
dGl2YXRlX2VudGl0eShlbnRpdHksIHRydWUpKSB7DQo+ID4gDQo+ID4gfC0gX19iZnFfZGVhY3Rp
dmF0ZV9lbnRpdHkoZW50aXR5LCB0cnVlKQ0KPiA+IHwtLSAgLi4uDQo+ID4gfC0tICBpZiAoIWlu
c19pbnRvX2lkbGVfdHJlZSB8fCAhYmZxX2d0KGVudGl0eS0+ZmluaXNoLCBzdC0+dnRpbWUpKQ0K
PiA+IAkJYmZxX2ZvcmdldF9lbnRpdHkoc3QsIGVudGl0eSwgaXNfaW5fc2VydmljZSk7IA0KPiA+
IA0KPiA+IHwtIGJmcV9mb3JnZXRfZW50aXR5KHN0LCBlbnRpdHksIGlzX2luX3NlcnZpY2UpDQo+
ID4gfC0tICAgYmZxcSA9IGJmcV9lbnRpdHlfdG9fYmZxcShlbnRpdHkpOyAvLyByZWNvdmVyIGBi
ZnFxYCBieSBlbnRpdHkNCj4gPiB8LS0JaWYgKGJmcXEgJiYgIWlzX2luX3NlcnZpY2UpDQo+ID4g
CQkgYmZxX3B1dF9xdWV1ZShiZnFxKTsgLy8gZnJlZSB0aGUgYGJmcXFgDQo+ID4gDQo+IA0KPiBG
b3IgdGhpcyBwdXQgdG8gdHVybiBpbnRvIGEgZnJlZSwgYmZxcSBzaG91bGQgaGF2ZSBvbmx5IG9u
ZSByZWYuICBCdXQNCj4gSSBkaWQgbm90IGZpbmQgYW55IGludm9jYXRpb24gb2YgYmZxX2RlbF9i
ZnFxX2J1c3kgd2l0aCBiZnFxLT5yZWYgPT0gMS4NCj4gDQo+IERpZCB5b3Ugc3BvdCBhbnk/DQo+
IA0KPiBMb29raW5nIGZvcndhcmQgdG8geW91ciBmZWVkYmFjaywNCj4gUGFvbG8NCj4gDQo+ID4g
VGhlIGJ1ZyBmaXggbmVlZHMgdG8gYWRkIHNvbWUgY2hlY2tzIHRvIGF2b2lkIGZyZWVpbmcgYGJm
cXFgIGluIHRoZSBmaXJzdA0KPiA+IGxvb3AgaW4gX19iZnFfZGVhY3RpdmF0ZV9lbnRpdHkoKS4g
SSBjYW4ndCBjb21lIG91dCBhIGdvb2QgcGF0Y2ggZm9yIGl0LA0KPiA+IHNvIGkgcmVwb3J0IGl0
IGZvciB5b3UuDQo+IA0KDQpJIHRoZSBmaWxlIGJsb2NrL2JmcS1pb3NjaGVkLmMsIGZ1bmN0aW9u
IGJmcV9yZW1vdmVfcmVxdWVzdCBnZXQgYmZxcSBieSANCiJSUV9CRlFRKHJxKTsiLiBDYW4gd2Ug
YXNzdW1lIGJmcXEtPnJlZiA9PTEgYXQgdGhpcyB0aW1lPyBBZnRlciBiZnFfcmVtb3ZlX3JlcXVl
c3QgDQogZ290IHRoZSBiZnFxLCB0aGVyZSBpcyBubyByZWYgaW5jcmVhc2Ugb3BlcmF0aW9uIGJl
Zm9yZSBjYWxscyBiZnFfZGVsX2JmcXFfYnVzeSgpLg0KDQo=
