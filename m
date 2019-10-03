Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3298C10F14
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F73820673
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbfJCQvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:51:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:48708 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406074AbfJCQvl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Oct 2019 12:51:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 09:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="196402028"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2019 09:51:37 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 3 Oct 2019 09:51:37 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.164]) with mapi id 14.03.0439.000;
 Thu, 3 Oct 2019 09:51:37 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array
 init.
Thread-Topic: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete
 array init.
Thread-Index: AQHVeZGOx590o4YCj0qZLXpmr8hr1adJl4GA
Date:   Thu, 3 Oct 2019 16:51:36 +0000
Message-ID: <dc6f05ed66c8485f647f741a1ef0c80a713b205c.camel@intel.com>
References: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
In-Reply-To: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6080979DB8FF3C40A3FB842FE62BD31A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTAyIGF0IDE5OjIzIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IEZyb206IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gRml4IHNw
YXJzZSB3YXJuaW5nOiAobWlzc2luZyAnPScpDQo+IC4uL2Jsb2NrL3NlZC1vcGFsLmM6MTMzOjE3
OiB3YXJuaW5nOiBvYnNvbGV0ZSBhcnJheSBpbml0aWFsaXplciwgdXNlIEM5OSBzeW50YXgNCj4g
DQo+IEZpeGVzOiBmZjkxMDY0ZWEzN2MgKCJibG9jazogc2VkLW9wYWw6IGNoZWNrIHNpemUgb2Yg
c2hhZG93IG1iciIpDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZy
YWRlYWQub3JnPg0KPiBDYzogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiBDYzogbGlu
dXgtYmxvY2tAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKb25hcyBSYWJlbnN0ZWluIDxqb25hcy5y
YWJlbnN0ZWluQHN0dWRpdW0udW5pLWVybGFuZ2VuLmRlPg0KPiBDYzogRGF2aWQgS296dWIgPHp1
YkBsaW51eC5mamZpLmN2dXQuY3o+DQo+IC0tLQ0KPiAgYmxvY2svc2VkLW9wYWwuYyB8ICAgIDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gLS0tIGxueC01NC1yYzEub3JpZy9ibG9jay9zZWQtb3BhbC5jDQo+ICsrKyBsbngtNTQtcmMx
L2Jsb2NrL3NlZC1vcGFsLmMNCj4gQEAgLTEyOSw3ICsxMjksNyBAQCBzdGF0aWMgY29uc3QgdTgg
b3BhbHVpZFtdW09QQUxfVUlEX0xFTkdUDQo+ICAJCXsgMHgwMCwgMHgwMCwgMHgwMCwgMHgwOSwg
MHgwMCwgMHgwMCwgMHg4NCwgMHgwMSB9LA0KPiAgDQo+ICAJLyogdGFibGVzICovDQo+IC0JW09Q
QUxfVEFCTEVfVEFCTEVdDQo+ICsJW09QQUxfVEFCTEVfVEFCTEVdID0NCj4gIAkJeyAweDAwLCAw
eDAwLCAweDAwLCAweDAxLCAweDAwLCAweDAwLCAweDAwLCAweDAxIH0sDQo+ICAJW09QQUxfTE9D
S0lOR1JBTkdFX0dMT0JBTF0gPQ0KPiAgCQl7IDB4MDAsIDB4MDAsIDB4MDgsIDB4MDIsIDB4MDAs
IDB4MDAsIDB4MDAsIDB4MDEgfSwNCj4gDQoNClJldmlld2VkLWJ5OiBKb24gRGVycmljayA8am9u
YXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo=
