Return-Path: <SRS0=kXjy=ZV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF2C432C0
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D712176D
	for <linux-block@archiver.kernel.org>; Fri, 29 Nov 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="of9ZBTMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2QJP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:09:15 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56521 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2QJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 11:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575043754; x=1606579754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vY3yNMWl4XxQ52Yeor3pYOFSHJJULyJ7C6zSK/m4n5c=;
  b=of9ZBTMbGXnSVTtc4e4PX5s4zw2XL8sVrj46+9Ln7NBRThOuufR9iHZm
   PK+ytev3iQkuZJPFxU8EaVAAo8xvu6JB86wEPr3lbAOFUxcFk2wKlfrYu
   SCFsGyl8sWsylwMK2OOE0qWB0B5Yel/5MH3zcIfxpCi/zp+jrjWQUPo3H
   8=;
IronPort-SDR: 2urBnlx6vJFe4PyaljmGlh5Eq0qnF4U/v9BYgul+T5A8y+NZySfdY8CEwS8wDSZsKleKRG5Qxb
 3dJ9FoBMDjgw==
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="2195830"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 29 Nov 2019 16:09:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id C3443282274;
        Fri, 29 Nov 2019 16:08:58 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 16:08:57 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 16:08:57 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Fri, 29 Nov 2019 16:08:57 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     Jan Beulich <jbeulich@suse.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [PATCH v2 1/2] xen/xenbus: reference count registered modules
Thread-Topic: [PATCH v2 1/2] xen/xenbus: reference count registered modules
Thread-Index: AQHVprryE0ZNGXJKYUWnOWAGzywoqqeiTuoAgAABo6A=
Date:   Fri, 29 Nov 2019 16:08:56 +0000
Message-ID: <42cc372e0ada4267bdf4038a0202d95d@EX13D32EUC003.ant.amazon.com>
References: <20191129134306.2738-1-pdurrant@amazon.com>
 <20191129134306.2738-2-pdurrant@amazon.com>
 <599c254c-035b-33a0-9f32-866ffe644ad5@suse.com>
In-Reply-To: <599c254c-035b-33a0-9f32-866ffe644ad5@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.244]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gQmV1bGljaCA8amJldWxp
Y2hAc3VzZS5jb20+DQo+IFNlbnQ6IDI5IE5vdmVtYmVyIDIwMTkgMTY6MDENCj4gVG86IER1cnJh
bnQsIFBhdWwgPHBkdXJyYW50QGFtYXpvbi5jb20+DQo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVu
cHJvamVjdC5vcmc7IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVs
Lm9yZz47IEJvcmlzDQo+IE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+OyBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MS8yXSB4ZW4veGVuYnVzOiByZWZlcmVuY2UgY291bnQgcmVnaXN0ZXJlZCBtb2R1bGVzDQo+IA0K
PiBPbiAyOS4xMS4yMDE5IDE0OjQzLCBQYXVsIER1cnJhbnQgd3JvdGU6DQo+ID4gVG8gcHJldmVu
dCBhIG1vZHVsZSBiZWluZyByZW1vdmVkIHdoaWxzdCBhdHRhY2hlZCB0byBhIGZyb250ZW5kLCBh
bmQNCj4gDQo+IFdoeSBvbmx5IGZyb250ZW5kPw0KPiANCg0KVHJ1ZS4gT3JpZ2luYWxseSB0aGlz
IHdhcyBvbmx5IGludGVuZGVkIGZvciBiYWNrZW5kcywgYnV0IEkgZ3Vlc3MgdGhpcyBzaG91bGQg
bm93IGJlICdvdGhlcmVuZCcgb3Igc29tZSBlcXVpdmFsZW50IGZvcm0gb2Ygd29yZHMuDQoNCj4g
PiBoZW5jZSB4ZW5idXMgY2FsbGluZyBpbnRvIHBvdGVudGlhbGx5IGludmFsaWQgdGV4dCwgdGFr
ZSBhIHJlZmVyZW5jZSBvbg0KPiA+IHRoZSBtb2R1bGUgYmVmb3JlIGNhbGxpbmcgdGhlIHByb2Jl
KCkgbWV0aG9kIChkcm9wcGluZyBpdCBpZg0KPiB1bnN1Y2Nlc3NmdWwpDQo+ID4gYW5kIGRyb3Ag
dGhlIHJlZmVyZW5jZSBhZnRlciByZXR1cm5pbmcgZnJvbSB0aGUgcmVtb3ZlKCkgbWV0aG9kLg0K
PiA+DQo+ID4gTk9URTogVGhpcyBhbGxvd3MgdGhlIGFkLWhvYyByZWZlcmVuY2UgY291bnRpbmcg
aW4geGVuLW5ldGJhY2sgdG8gYmUNCj4gPiAgICAgICByZW1vdmVkLiBUaGlzIHdpbGwgYmUgZG9u
ZSBpbiBhIHN1YnNlcXVlbnQgcGF0Y2guDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBzdXNlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIER1cnJhbnQg
PHBkdXJyYW50QGFtYXpvbi5jb20+DQo+ID4NCj4gPiAtLS0gYS9kcml2ZXJzL3hlbi94ZW5idXMv
eGVuYnVzX3Byb2JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3Byb2Jl
LmMNCj4gPiBAQCAtMjMyLDkgKzIzMiwxMSBAQCBpbnQgeGVuYnVzX2Rldl9wcm9iZShzdHJ1Y3Qg
ZGV2aWNlICpfZGV2KQ0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gIAl9DQo+ID4NCj4gPiArCV9f
bW9kdWxlX2dldChkcnYtPmRyaXZlci5vd25lcik7DQo+IA0KPiBJIGd1ZXNzIHlvdSByZWFsbHkg
d2FudCB0cnlfbW9kdWxlX2dldCgpIGFuZCBkZWFsIHdpdGggaXQgcmV0dXJuaW5nDQo+IGZhbHNl
Lg0KPiANCg0KUGVyaGFwcywgeWVzLg0KDQogIFBhdWwNCg0KPiBKYW4NCg==
