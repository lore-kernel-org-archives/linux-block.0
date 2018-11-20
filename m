Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C517FC43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D26E2089F
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lOCIHEAe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KY0n4uQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26E2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeKTMNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:13:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55252 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTMNr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678432; x=1574214432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6PdIDPaBvQOzxrbQ+FJ1pHjEIg59SKlj6rWz3Re/8fM=;
  b=lOCIHEAe7/r42Pjb69gPWQ5j7qOehWSowss9s1hVILi9hf4TvlFA2nEO
   34er0hLpkbPA0VoziJQmd+EB5fC3yiExSpXfOyZRl4cs+ZBhRqI09s60q
   KOPJNFh+E4RMRdUfs3Q43tX2dJFAIr31idtoupulCdBc/WYgJPs+H6S0S
   AW0wTEylaXmLfA53qf5kc86agqvdy6Jc6xMGGADDDb/RQ2bUKav+o2RrP
   W26dSkNoiQlVfYne2+OqSa+uUEY85BkCYNM45p25bIq+R2h1CXbCcpVDO
   Y0TWg/rkOAE2GV5+lA22TgYAH/cirgYCHJ3KyGlQo9QiAhBsrA4fs4s4b
   g==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="99455677"
Received: from mail-bn3nam04lp0113.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.113])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:47:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PdIDPaBvQOzxrbQ+FJ1pHjEIg59SKlj6rWz3Re/8fM=;
 b=KY0n4uQsbPmiwnmhczwXrdTonJks1aDH8MonStQLfcyzsm2qqLR0g7gmO19nozTmeXJYgj6vuNYGuUZI9NL4oVQNIqMG5m/673kkrGB0+1j/vRvb1nvZHAEzF07Vi/RYGB6Hq9dNNWDL1mg6oSSwPYv4fPK6v1lbIBp8x5r8FfU=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1622.namprd04.prod.outlook.com (10.163.36.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 01:47:07 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 01:47:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Adam Manzanares <Adam.Manzanares@wdc.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/7] block: Fix get_task_ioprio() default return value
Thread-Topic: [PATCH 3/7] block: Fix get_task_ioprio() default return value
Thread-Index: AQHUf7tErV0mes1nT06Hj2/6l+MnSKVWwOiAgAElgQA=
Date:   Tue, 20 Nov 2018 01:47:07 +0000
Message-ID: <26656d88acec98d1e08c034ec87315cf917ce279.camel@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
         <20181119035131.11255-4-damien.lemoal@wdc.com>
         <20181119081635.GN9622@infradead.org>
In-Reply-To: <20181119081635.GN9622@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1622;6:Ng+LykHtZN3TYv1NYDbwaaIRo/s4M+HwuDt030VWlT04C10WDlBtqpx07lqrpCoEvA9noGUM7Axl7hAMidWJmt0Dfitf3dZXg88ip0dU5NzwJJJV/WM8baBY4xRuvBrVPXzP4tSKC6k/Zof7djJ1pF+pZ/GBaEe9G/96iSAXtbg9KQhUy3p1/RsszZl9StXsYgWJdIf7uCqPpp0OkPrAHBQy8Zl3vGvOlT0es/0H8GxapHkhn2la/0wkav1CDEnN9eg+XqHb6xWJ/+D7qgMfnW9llFZsOl0fFUuAeZJ6swjK6f/VpbGt71N8ysNPm2rEBHuSQhymD8UX7D06G19mplyQvUm4sM5/esLjlm03kXyg2ugRNDq3RVA0zvLghl4q+Rf5fVZbaSmnsa7Ghdi+IO0Bj+39QJXVnCgh/INefauLJiHLyjtVn8g+sf+8H79zOPs63ToahQnUm9d4mv34kg==;5:UaTvI+UYU3+5tXIWq2gqc1piynwrjiuUCDDc3YuVy04MAAELMPlqKXq2HSXaQsZ5Ypf2qege4rJa91rn83xRqSWgIgzVF63E4j7RUcz1Hpoi+QezzklD/ckdpVhKlW4s5OblVczdz0gOYkAt2wtK3KpP875RXu+icTCM3SGsISE=;7:iFPPRHYuriwaBiR1YIEXuvNUifWbhul45lTsNWuIGN61pMQgyQoBavf82/i/0/Br1onoh1SA8qES+LX9W8PuZDsIoGNXuk2x+/kmSvatibJEnb2H8GbxLqU2neleS82ClyYME8earVKo84N65daQvg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b6aeb1fe-6316-4556-8ae2-08d64e8a144f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1622;
x-ms-traffictypediagnostic: BN3PR0401MB1622:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1622866F64F140AEBCDA4272E7D90@BN3PR0401MB1622.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1622;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1622;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(11346002)(3846002)(36756003)(446003)(6116002)(6506007)(6916009)(5660300001)(106356001)(5640700003)(6512007)(118296001)(2351001)(26005)(186003)(486006)(2616005)(99286004)(2900100001)(76176011)(14454004)(6246003)(6436002)(2906002)(476003)(102836004)(2501003)(8936002)(478600001)(105586002)(1730700003)(81166006)(7736002)(256004)(8676002)(81156014)(305945005)(97736004)(229853002)(53936002)(316002)(25786009)(71200400001)(71190400001)(58126008)(6486002)(72206003)(68736007)(54906003)(4001150100001)(4326008)(66066001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1622;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7eq51xuvBeQ8es0kD0SjRo4Aw1+ZPergSV5TuRRqBMl74Ka3lAMnW9YGQzfzd55vY9uzOzJxnL6TdMwo8q0yCKRcOyYcTtJhFlD+GP5dEBZMZ99w/45T1e/YcajiRp0MnhiF6TUpN10RhD+zg13A9WbYDvadXUJIdPvqE/h2Ex4129Gs3StlBmWIuQxWvIsbNYC1dAd9Mw5IVI3Gt3NtoMDHanFGlKDaGWbXgwhaA/orxVe3FoMmUzXf9Bzvs6vDfPUXLmMKMhT50QCc71bfJ6RQ6ezq+phDCfOkjgJvu8s+8Be5p26sIBfrfloPQmRcwBtPN5k8ofuPkdfC1jLwKAwJYJEBcBdbbZM+QiSaOWw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7935F8CCCF182429D30C8E34C21930D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aeb1fe-6316-4556-8ae2-08d64e8a144f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:47:07.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1622
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDAwOjE2IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMTksIDIwMTggYXQgMTI6NTE6MjdQTSArMDkwMCwgRGFtaWVuIExl
IE1vYWwgd3JvdGU6DQo+ID4gQXMgZXhwbGFpbmVkIGluIGlvcHJpb19nZXQoKSBhbmQgaW9uaWNl
IG1hbiBwYWdlcywgdGhlIGRlZmF1bHQgSS9PDQo+ID4gcHJpb3JpdHkgY2xhc3MgZm9yIHByb2Nl
c3NlcyB3aGljaCBoYXZlIG5vdCBzZXQgYW4gSS9PIHByaW9yaXR5DQo+ID4gdXNpbmcNCj4gPiBp
b3ByaW9fc2V0KCkgaXMgSU9QUklPX0NMQVNTX0JFIGFuZCBub3QgSU9QUklPX0NMQVNTX05PTkUu
DQo+IA0KPiBXaGlsZSB0aGlzIG1hdGNoZXMgdGhlIGRvY3VtZW50YXRpb24sIHdlJ3ZlIHJldHVy
bmVkIHRoZSBjdXJyZW50DQo+IHZhbHVlcyBmb3IgMTAgeWVhcnMsIGFuZCBiZWZvcmUgdGhhdCBw
bGFpbiAwIHdpdGhvdXQgYW55IGlvcHJpbw0KPiBtYWdpYy4gIEl0IG1pZ2h0IGJlIHNhZmVyIHRv
IGp1c3QgZml4IHRoZSBkb2N1bWVudGF0aW9uLg0KDQpPSy4gV2lsbCBzZW5kIGEgcGF0Y2ggdG8g
Zml4IHRoZSBtYW4gcGFnZXMuDQo=
