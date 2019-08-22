Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ACFC3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A23216F4
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 02:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="khiF0THt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bsa/Fp2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfHVCXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:23:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12701 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfHVCXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 22:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566440603; x=1597976603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NfORPzMIqJClTuBlFRla5HdMWScUENAlnxtkQMhVHw0=;
  b=khiF0THtY60cUkPt+6Yava/3Q/HN0cY/HZyRDhd/X5b3De1cTmuu7OQ7
   hjtJuVHqfUiOdlJwTcZKvcSotY+L8fcTH3LGGg2+qQzS2pNOSlPVEKGnF
   lilwpwMJwmsnwN6nHgpPN64VRn1Z1JaX0Q12hpF2AJKDSoGv7dNgj1Mtt
   6G3t1WPJcjipxfIhhNQo9e/X7GcUEdXg2a6Btyr48zLi6TErlwuEhz6EK
   smLIWEVAuNmi0Fgp29+yblG90/DHycRXidRRU7YVhHtImhB38FgkR2NcF
   BH9kvCWM/ySJqW2auR+FKnJsUYo7m+qISI/neq6ER2HwPwmIqbP9+a+nF
   Q==;
IronPort-SDR: nF2dKQ82F7Zd9HGbJB0/F7uiQN3qiTInLpGT7FJOof7TP+rX3Ys9r9i8YLLgoCqrY9Huf9jLtw
 ydhkaxFMqouJEI9WYLtLwHwKH3ozg/tJ1qAEk4C7gZymY/p8yy1DpAPkPpoXTrPHVx3LbFKTQo
 cxPU8vRnpS+646488+/RPmWYjuahr1J+tQTRssICNGegTN8oik5vZORds9azU64r5dNLchayp+
 FbKFroQfxyxXj8yotTO6gY8uBJGgZhm+gA5eED2/E71GInrqhrGywEVUKlFWoNgIxZRyNBrag7
 DWE=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="216810266"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 10:23:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEA7jUj7EGGJmxuXs/JCkZfjnp6xy6gDKJmFnTC8u4GznnJK/qaivl2SQDBd2LNPnHp0srjMghaAWEdyyIxS1EijSGtEgs9qmdx+Nua40g0nzmyY3h9prtwD4WQzDU2HuhKAVzjwiNOJC3NTmsga8JRc+Ge88TX2KbPb6F5twNX31LuwaL71z945mUTVWtxeqfBkGXTgJMFX249dnybHVn19Ceecp6VUFBmfPeer5agR6uZm8nK1CRQh7HL5LJFuMW3aogQ6PlROgbxkLU1jAOr2htb74AeyJmXyb1Qn63EJEYarXGTT8PUtGKW+oYQp0ThN4e+eboRU/PocXbBV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfORPzMIqJClTuBlFRla5HdMWScUENAlnxtkQMhVHw0=;
 b=Ltj+XDZBhCTz0WN4BmKkIpWEFBTSgj/2pI0NViCg57JY0j9fTtN06vTpvus8hrkdei32lqTuCT+kKIgYm4XKQI45AJ+L/1Dv9vCwmlLH5sMu4hCENCncBbrFUcv3zj+YHbBTm5twEuFBjNtrLY6o0DCI5EHfnf8lO7g1V0RTn5pDBVqQeOZVprotoUEPvQ/pVlmT8OLFcOlyrTSMZBnEd4PoVRwi/Ra1+ST3+9fSfbMzlnBz0emh+UTqpr0Fw+RVgc4ecAaBy5AWVaw1rXV9tQJ55GN0UFqr/X14ck7jNKjZSTiI5G4+dlM4+HlrvUCef/8vBJqw1NWHOAxlp+8yLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfORPzMIqJClTuBlFRla5HdMWScUENAlnxtkQMhVHw0=;
 b=Bsa/Fp2Ir1WcWYAr2cK0bhRwI1xJl47RvGYQhn7zyHcM7FprIAHvjmhmzFNSD3YhzG1gYIKAT9bYE8c6nj9OyRKaMi2O0fgPqE9TKfiBXtX0cdd0jFh3cup2uPTjlZlAXi8S149g+ytVIyNjgxih7+Qt2DHORrzxWBvBg9tlbjY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6039.namprd04.prod.outlook.com (20.178.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 02:23:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 02:23:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 5/6] null_blk: create a helper for zoned devices
Thread-Topic: [PATCH V3 5/6] null_blk: create a helper for zoned devices
Thread-Index: AQHVV+egJXg4VTaHwUOHG9YVupoctKcGWaIAgAAXqAA=
Date:   Thu, 22 Aug 2019 02:23:14 +0000
Message-ID: <f2e84620-237f-2414-77e8-7f474c5c9dad@wdc.com>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com>
 <20190821061314.3262-6-chaitanya.kulkarni@wdc.com>
 <20190822005834.GF10938@lst.de>
In-Reply-To: <20190822005834.GF10938@lst.de>
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
x-ms-office365-filtering-correlation-id: d607c312-7c7d-44af-dcf8-08d726a7afc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6039;
x-ms-traffictypediagnostic: BYAPR04MB6039:
x-microsoft-antispam-prvs: <BYAPR04MB603930B382B394551A2FE4B386A50@BYAPR04MB6039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(256004)(26005)(71190400001)(31696002)(478600001)(86362001)(53936002)(99286004)(25786009)(11346002)(446003)(486006)(6436002)(6486002)(76176011)(6246003)(6916009)(66946007)(6506007)(66446008)(66556008)(66476007)(31686004)(14454004)(229853002)(305945005)(64756008)(6512007)(76116006)(66066001)(65806001)(65956001)(2906002)(4744005)(36756003)(3846002)(6116002)(53546011)(186003)(5660300002)(54906003)(102836004)(8676002)(7736002)(4326008)(476003)(316002)(81166006)(2616005)(8936002)(71200400001)(58126008)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6039;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q1JxjYhb763xBAe7MZBg1P7habK5uI7ZKBLyC/SECPk8incRC2XKaPb9opfsMxWtSDpQKUDxMVUcGiF90QwqSwZltRYgc8CCklIOXqz0w3IcQVKd1W5w5x6bzO0IJ7HZ6M3Xv5y2RSD6CirM9O90CKy1/cMDFQfSFml/pMPZLHXbC/c2pDrjxuMGSooxG9/S7AdJ88oSNJPmozl3ndD3GT4kEK7xUWQGXJbeRTVZpiez15K2jEoG+YnGog9tXWv8KxHU7xntLwtJ9v5il+SJF68gr2QaUmM+qZid4aESsm1d3vkFJkvaLBT1BefX4dPoJiSHcsTj8nsFe/OOv3NfBbVaswYDBxT2RzFUArmRTSe18mKKw2BL3Sri5iDkrXLNlA26jdJrgYGDDYG1lCbHWHd1o/nCFoNRzOAqHHNFuKQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB4980B4F1ABB47926EE96CF9CF01B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d607c312-7c7d-44af-dcf8-08d726a7afc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 02:23:14.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuqrfCgJ+s0iLlUSFDIjPQjI0EhmOuyk6aJoo0ymRNGVWv2S9aL9mKLmWuRCq3fQEhpBJPYrR4fF3Y8tfPkhx68LINElUTMHEwe5xGorDG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T2theSwgd2lsbCBzZW5kIHRoZSBuZXcgdmVyc2lvbi4uDQoNCk9uIDgvMjEvMTkgNTo1OCBQTSwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiArc3RhdGljIGlubGluZSBibGtfc3RhdHVzX3Qg
bnVsbF9oYW5kbGVfem9uZWQoc3RydWN0IG51bGxiX2NtZCAqY21kLA0KPj4gKwkJCQkJICAgICBl
bnVtIHJlcV9vcGYgb3AsIHNlY3Rvcl90IHNlY3RvciwNCj4+ICsJCQkJCSAgICAgc2VjdG9yX3Qg
bnJfc2VjdG9ycykNCj4+ICt7DQo+IFNob3VsZG4ndCB0aGlzIGdvIGludG8gbnVsbF9ibGtfem9u
ZWQuYz8gIEFsc28gdGhlIGluZGVudGF0aW9uIGZvciB0aGUNCj4gaGVyZSBzZWVtcyBvZGQuDQo+
DQo+PiArCWJsa19zdGF0dXNfdCBzdHMgPSBCTEtfU1RTX09LOw0KPj4gKw0KPj4gKwlzd2l0Y2gg
KG9wKSB7DQo+PiArCWNhc2UgUkVRX09QX1dSSVRFOg0KPj4gKwkJc3RzID0gbnVsbF96b25lX3dy
aXRlKGNtZCwgc2VjdG9yLCBucl9zZWN0b3JzKTsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIFJF
UV9PUF9aT05FX1JFU0VUOg0KPj4gKwkJc3RzID0gbnVsbF96b25lX3Jlc2V0KGNtZCwgc2VjdG9y
KTsNCj4+ICsJCWJyZWFrOw0KPj4gKwlkZWZhdWx0Og0KPj4gKwkJYnJlYWs7DQo+PiArCX0NCj4+
ICsNCj4+ICsJcmV0dXJuIHN0czsNCj4gV2h5IG5vdDoNCj4NCj4gCXN3aXRjaCAob3ApIHsNCj4g
CWNhc2UgUkVRX09QX1dSSVRFOg0KPiAJCXJldHVybiBudWxsX3pvbmVfd3JpdGUoY21kLCBzZWN0
b3IsIG5yX3NlY3RvcnMpOw0KPiAJY2FzZSBSRVFfT1BfWk9ORV9SRVNFVDoNCj4gCQlyZXR1cm4g
bnVsbF96b25lX3Jlc2V0KGNtZCwgc2VjdG9yKTsNCj4gCWRlZmF1bHQ6DQo+IAkJcmV0dXJuIEJM
S19TVFNfT0s7DQo+IH0NCg0KDQo=
