Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE42C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E9E216F4
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HfKMggRW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zoTOmhV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfHVCSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:18:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1513 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbfHVCSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 22:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566440299; x=1597976299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M9pigB1tRB0UkvYG/dsrOJXr/EPaGZJQDKQ9P7I+nlo=;
  b=HfKMggRWAc4RvZzSQNCzW8LkElrFOhyVZ6VO3zVWvtF8BbyyxcQ6n+NJ
   4VI/KyQDeZoeerfMw3qRpGFiADK50tUGdRiHVvY1U7ibXixNNqEKuG6yF
   PcFs3DCKkVXxuEO44xYDC22kqBzalX+P86nbVW1OMU4gQ9T0fFJxXDKB2
   f7hmbb0Is9STAAtiObgu7muHvicGIXZKECxInJLDSpcFBMF/bVSx8QyB2
   fl5H1yHMiXiTJEfMETCOjSJ8YiLaexPU/sfcNmi5X0Qq567kJJfaRNwPR
   w7iWz8jmZN8ANFCZi1weL2CPd5AMsg3dnMAM78KQgwAjI6mHRblGtGjWq
   g==;
IronPort-SDR: bfH54kabhYTUnjUvAp4tfb+JkY9mOz5YlRASQnXw/Q2QXKCaZPbFWuMCxQ5yRl5O9ppMKSx8Ou
 +iWu5/ngtxsB2J+bwYeYcH1n4QoAqC6f2C58UNmm6CgFjsG1hX3ce7CBfr0LoZ6WXkth1LPK1k
 kubOa6MO0GZFrLrQHeq/CSt1tQ563nrDi154ZYdVnq4AWFHiB1kdaXX3uGiEHSSZQ5rrx/mZh3
 Qa3Ex9mBhVliaEsbFhfMDOspL9dzqAZd1h00VkSVvo0+vRjhrGGaANiSTqUgefKhOAWGnhvxNr
 r8I=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="222970743"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 10:17:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3PAgEZVhBjwdNwr1we2hIG4IxLuUO+U44YYLtShZquXOdVYbsj3vvYF0jQeEMvt720ENFVcLe2ZWNIXI/mGJrUpjc0EvWYk23hh6VoFjjGgkbaU7ViCUjgl1gChKoxVAF910S/gBEWtmvlyXl0Lo9/LR/vY81s7DDPyIHzuUOu0824IY/yK3Xg7ydZ2Gr/eTuvM1ydpu9KxLKMCCEW9ocuiYH3MjR0kWxt+mWZGliAFDkBGKgT1MZGn/W4lekPT3/wlnl+Kmzzagd5RcuAdI2EJHSbFyWn2MhnJxrCl6nmpKzof13PbfvrRGutrTuh+AiDKxveg+NWxZiadM5YGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9pigB1tRB0UkvYG/dsrOJXr/EPaGZJQDKQ9P7I+nlo=;
 b=eSDvnI9OCI37VGt0aLKiNrztplBzKTwensTqfKeT+X7xL8d2mox6EGaOoqaQa+qhn1sHTWREIh8c06vJrLc6ZSxSQpYGEG/3mfA7YDFSYRgVXgDBggkhG2KRqrPMWCqaQaN34ISh3wkHyPwhGW4Pvq9ys+nvsdRYVMyYfOqpkT89y7Ma9hnyIMmB0SGx2uMso0u8o8p/gJQRmshiGrpUWcJnhmDBIVxEqhYWIHZmYbE7PdaNKKgc/0VsTp6QX+TcxJb83PZdRyCXQaLkpRTttkPyF+eKhJSZNqeJnyQeW1i7mIzUIMJ/VF6OtQzCesmX8YXUJga4/h+U9zORs8FODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9pigB1tRB0UkvYG/dsrOJXr/EPaGZJQDKQ9P7I+nlo=;
 b=zoTOmhV3PzHGrGxW6RZXOn+6G41Hgz9MUl+/jTn8JRPDs63XcIhs3+p6Lx2/xgJUiy82sdfV+Qr7rFc1/S/7YhahTMa16rI9EYob357jmWb/DgdTg82SJbMf9dQYsxM3/he8CCpBrMK6b0/L+nR94Z4/S1OsCfSVTefuwFdz1ZU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4727.namprd04.prod.outlook.com (52.135.240.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 02:17:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 02:17:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 6/6] null_blk: create a helper for req completion
Thread-Topic: [PATCH V3 6/6] null_blk: create a helper for req completion
Thread-Index: AQHVV+ehSFr0LyKLP06atCOeXLpHTKcGWdQAgAAV+QA=
Date:   Thu, 22 Aug 2019 02:17:55 +0000
Message-ID: <44b9bd7b-94b9-c89a-69be-07707cd0bd39@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
 <20190821061314.3262-7-chaitanya.kulkarni@wdc.com>
 <20190822005916.GG10938@lst.de>
In-Reply-To: <20190822005916.GG10938@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f897a56a-944f-4583-c2ed-08d726a6f1a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4727;
x-ms-traffictypediagnostic: BYAPR04MB4727:
x-microsoft-antispam-prvs: <BYAPR04MB4727A3E54E64995E7C02B60686A50@BYAPR04MB4727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(81156014)(81166006)(99286004)(25786009)(58126008)(8676002)(4326008)(36756003)(54906003)(76176011)(8936002)(6916009)(316002)(229853002)(2906002)(478600001)(65806001)(65956001)(71200400001)(71190400001)(66066001)(14444005)(14454004)(256004)(3846002)(6116002)(305945005)(5660300002)(53936002)(6246003)(6512007)(7736002)(6486002)(6436002)(2616005)(476003)(31686004)(66946007)(76116006)(486006)(66556008)(66476007)(66446008)(64756008)(446003)(26005)(186003)(11346002)(31696002)(6506007)(53546011)(86362001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4727;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eX/hZGq5rsoI/BVws6UrYib0XcYuxBBEfgrdfE1dYGvbriQZ+wmmNdfwV35C0jXhdVQQq70B8A9GFyu0UvLFc7NfVKaUQBPDgMOhL81SEm0p48TVBGH/bArsevzabWLNYmsUhsxxHxdkh+DteGTUZelzNW4Kxwgh+t6NWvo1V73nd7iq18muVtavqxjl7mcrVS/hGUra4VGkfyWqEPIRqUVkOvRGn9gZ9l3on1M57GizVcFxJBI7b+VU1SEpj4+DaMYct0IFjFZh9nDoXg8T219C2Pa+kyq22AdIWhYYGEhqhjiNc6SQaO3bMJQhUqYTyd3kKqSwtwx8SlmfOwofRPuzgZNG8cK2JgHb2wpL/bVXANFqiOkuBq9fXD8p4AZPjUP2tW/O1hhE/Adj+wyOVbOVPiRRMDTO7+Rk85HANjM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <54EF9170CE35C24DBD9566F228049358@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f897a56a-944f-4583-c2ed-08d726a6f1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 02:17:55.4489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCCYtd28Kqx7f59k+YIr1duKrl94Q9AwuzJzQmKEqiuKYVy6Rb0DpztjI3dkidVB8nZH89vFYWG3luf1ZAp6SZRnrkFF7pV4BQGcohdJ39I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4727
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOC8yMS8xOSA1OjU5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMjAsIDIwMTkgYXQgMTE6MTM6MTRQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3Rl
Og0KPj4gVGhpcyBwYXRjaCBjcmVhdGVzIGEgaGVscGVyIGZ1bmN0aW9uIGZvciBoYW5kbGluZyB0
aGUgcmVxdWVzdA0KPj4gY29tcGxldGlvbiBpbiB0aGUgbnVsbF9oYW5kbGVfY21kKCkuDQo+Pg0K
Pj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPj4gU2lnbmVk
LW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYyB8IDQ5ICsrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNl
cnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bG9jay9udWxsX2Jsa19tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYw0KPj4g
aW5kZXggNTAxYWY3OWJmZmIyLi5mZTEyZWM1OWIzYTYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrX21haW4uYw0KPj4gKysrIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa19t
YWluLmMNCj4+IEBAIC0xMjAyLDYgKzEyMDIsMzIgQEAgc3RhdGljIGlubGluZSBibGtfc3RhdHVz
X3QgbnVsbF9oYW5kbGVfem9uZWQoc3RydWN0IG51bGxiX2NtZCAqY21kLA0KPj4gICAJcmV0dXJu
IHN0czsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgbnVsbGJfaGFuZGxl
X2NtZF9jb21wbGV0aW9uKHN0cnVjdCBudWxsYl9jbWQgKmNtZCkNCj4gTWF5YmUgY2FsIHRoaXMg
bnVsbGJfY29tcGxldGVfY21kIGluc3RlYWQ/DQoNCk9rYXkuDQoNCkplbnMgZG8geW91IHdhbnQg
bWUgdG8gc2VuZCBuZXcgc2VyaWVzIHdpdGggYWJvdmUgZml4IG9yIGl0IGNhbiBiZSBkb25lDQoN
CmF0IHRoZSB0aW1lIG9mIGFwcGx5aW5nIHRoZSBwYXRjaCB0byBtaW5pbWl6ZSB0aGUgZW1haWxz
ID8gZWl0aGVyIHdheSANCkknbSBmaW5lLg0KDQo+DQo+IE90aGVyd2lzZSBsb29rcyBmaW5lOg0K
Pg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0K
