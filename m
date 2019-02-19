Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36463C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 00:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF3C21773
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 00:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBSAvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:51:08 -0500
Received: from SMTPBG357.QQ.COM ([183.61.51.175]:33538 "EHLO SMTPBG357.QQ.COM"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfBSAvI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 19:51:08 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2019 19:51:05 EST
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: eiOkkG+bjm7BokoWLlqPvV5lxlNky3E8WjTKOKrHuFCZDtBGh6QoyTjoBOp0W
        r1PuRqXXNRxQG4WXZ4Gs7O+mpxeSO78ZovfJ7eFLsvLnp4hcgjZ3i1LWGZCKvUwEMoROqAe
        BXRGbJ4swBJarW4HPsJ7GsfQkbEUX4g8ShjFYHE0ulJ+i5jMEd4tMI/LTcSiVgD0kQv53Ef
        23lQtKQmjak8dsulcAtYxHa8GptWibW21AMMNYysJfNwD/TwIRNQiiSD8i9wu1+kH/SmhXy
        ZhFW0y1TwbB9L5gaWUtqLehGs=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1550536947t37589
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?VGhvbWFzIEdsZWl4bmVy?=" <tglx@linutronix.de>,
        "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@gmail.com>
Cc:     "=?utf-8?B?S2VpdGggQnVzY2g=?=" <keith.busch@intel.com>,
        "=?utf-8?B?Qmpvcm4gSGVsZ2Fhcw==?=" <helgaas@kernel.org>,
        "=?utf-8?B?SmVucyBBeGJvZQ==?=" <axboe@kernel.dk>,
        "=?utf-8?B?U2FnaSBHcmltYmVyZw==?=" <sagi@grimberg.me>,
        "=?utf-8?B?bGludXgtcGNp?=" <linux-pci@vger.kernel.org>,
        "=?utf-8?B?TEtNTA==?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?bGludXgtbnZtZQ==?=" <linux-nvme@lists.infradead.org>,
        "=?utf-8?B?TWluZyBMZWk=?=" <ming.lei@redhat.com>,
        "=?utf-8?B?bGludXgtYmxvY2s=?=" <linux-block@vger.kernel.org>,
        "=?utf-8?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 19 Feb 2019 08:42:27 +0800
X-Priority: 3
Message-ID: <tencent_6C5D1EC74B826B1E2F22293C@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20190213105041.13537-1-ming.lei@redhat.com>
        <20190213105041.13537-2-ming.lei@redhat.com>
        <20190213150407.GB96272@google.com>
        <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
        <20190213213149.GB8027@localhost.localdomain>
        <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
        <20190213223711.GC8027@localhost.localdomain>
        <alpine.DEB.2.21.1902140949280.1659@nanos.tec.linutronix.de>
        <tencent_6460D33741AF25B57E7BE493@qq.com>
        <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902141430190.1561@nanos.tec.linutronix.de>
X-QQ-ReplyHash: 839700712
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 19 Feb 2019 08:42:30 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TXkgbGVtb3RlLmNvbSBlbWFpbCBpcyB0b28gd2VhaywgSSdsbCBzdG9wIHRvcCBwb3N0IGJl
Y2F1c2UgdGhpcyB0aW1lIEkndmUNCmNjLWVkIG15IGdtYWlsLg0KDQpJJ3ZlIHRlc3RlZCwg
dGhpcyBwYXRjaCBjYW4gZml4IHRoZSBudm1lIHByb2JsZW0sIGJ1dCBpdCBjYW4ndCBiZSBh
cHBsaWVkDQp0byA0LjE5IGJlY2F1c2Ugb2YgZGlmZmVyZW50IGNvbnRleHQuIEFuZCwgSSBz
dGlsbCB0aGluayBteSBvcmlnaW5hbCBzb2x1dGlvbg0KKGdlbmlycS9hZmZpbml0eTogQXNz
aWduIGRlZmF1bHQgYWZmaW5pdHkgdG8gcHJlL3Bvc3QgdmVjdG9ycykgaXMgY29ycmVjdC4N
ClRoZXJlIG1heSBiZSBzaW1pbGFyIHByb2JsZW1zIGV4Y2VwdCBudm1lLg0KIA0KSHVhY2Fp
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0NCkZy
b206ICAiVGhvbWFzIEdsZWl4bmVyIjx0Z2x4QGxpbnV0cm9uaXguZGU+Ow0KRGF0ZTogIFRo
dSwgRmViIDE0LCAyMDE5IDA5OjMxIFBNDQpUbzogICLpmYjljY7miY0iPGNoZW5oY0BsZW1v
dGUuY29tPjsNCkNjOiAgIktlaXRoIEJ1c2NoIjxrZWl0aC5idXNjaEBpbnRlbC5jb20+OyAi
Qmpvcm4gSGVsZ2FhcyI8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgIkplbnMgQXhib2UiPGF4Ym9l
QGtlcm5lbC5kaz47ICJTYWdpIEdyaW1iZXJnIjxzYWdpQGdyaW1iZXJnLm1lPjsgImxpbnV4
LXBjaSI8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47ICJMS01MIjxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgImxpbnV4LW52bWUiPGxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZz47ICJNaW5nIExlaSI8bWluZy5sZWlAcmVkaGF0LmNvbT47ICJsaW51eC1ibG9j
ayI8bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnPjsgIkNocmlzdG9waCBIZWxsd2lnIjxo
Y2hAbHN0LmRlPjsNClN1YmplY3Q6ICBSZTogW1BBVENIIFYzIDEvNV0gZ2VuaXJxL2FmZmlu
aXR5OiBkb24ndCBtYXJrICdhZmZkJyBhcyBjb25zdA0KIA0KT24gVGh1LCAxNCBGZWIgMjAx
OSwg6ZmI5Y2O5omNIHdyb3RlOg0KDQpQbGVhc2UgZG8gbm90IHRvcCBwb3N0Li4uLg0KDQo+
IEknbGwgdGVzdCBuZXh0IHdlZWssIGJ1dCA0LjE5IGhhcyB0aGUgc2FtZSBwcm9ibGVtLCBo
b3cgdG8gZml4IHRoYXQgZm9yIDQuMTk/DQoNCkJ5IGFwcGx5aW5nIHRoZSB2ZXJ5IHNhbWUg
cGF0Y2ggcGVyaGFwcz8NCg0KVGhhbmtzLA0KDQp0Z2x4

