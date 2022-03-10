Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F264C433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 15:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbiCJPJz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbiCJPIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 10:08:14 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4DDFD6
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 06:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646924292; x=1678460292;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1kQN4a4PXnMrACZZeCpPBA2Hug+/qyW3VSu/l+psKww=;
  b=RlS5GH3YOWpx3FZwLBMZDv2mmiAQaP/JAmd/nIdYsuf3niz9O0zqldZJ
   2DrU9H1PdhUHpAdVa57r+b1TghBN0j6PAZzpHT0AXXEXuTTaX4cJXxA7+
   QhK2fSLFUFgTWj+CiRBvO/XGo4X5eSSceI71nk7PAEBB7bj9CCn8DpDOF
   5YN68pOio7xRgHBQr0/IlNkUUPwELPPoS/4bi5djBMHO/cR7zzq8Wq+lD
   1611qyjFZ5WPU6tQwYGcFFOeOoNX2FL2chdbbxHme3dWpLafSab8T7hhJ
   zcK4EoR4YQ9WFfUF61uxpoaZrJq1UV9PQt3XWPsR34CTmO6EtnFkLa34Y
   w==;
X-IronPort-AV: E=Sophos;i="5.90,171,1643644800"; 
   d="scan'208";a="194976354"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 22:58:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khx4dJD3cKZjGfIzez15JgcWFvi4B/gHClxFd36hptYbRCQ1nvgM5Ts5zXl08Y3NZLSQ1upEtoW/sGF1a/68I0LyrmDV/DLsadyiMejEPgHksX3cKFrn6n/Hncnb00XPkRwDbqf1hIaO1cT5j2wM3o4nwNe8PzBzlnl5SNPOwg29V8zIBBsIY+bGxGUeo7dhg5fo8O8Ok99XDEGAqr9WGuZu52R++l6v2Uh077csIQl38uo5xVH204cY1NfUctaoi71paOSDacHUncQuSerP8v9dtSDK4K69LUBZJMcdn3XD9SJ0dAYSkoaKeahR8K8eQaYavtfDjFM6bu7Ttti9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kQN4a4PXnMrACZZeCpPBA2Hug+/qyW3VSu/l+psKww=;
 b=DBy7faIskuJiOa+JSM5knYcOqwEYCG8Fp7pStvNB5cZxWCnuXfWT9ey/GCvrsLK8uYtfZvhsXJZmSSGsTtAMStBodDqSTV7/Nlq+qNb6kqEepvIQHz1QVyQepBofgJBbrNNmEbUYodudQRxCB09IwlRf1NWlZLH80eP7FHkw7r2MTizDbWCvseHE+OltUEz2ir/YC78O0f5jVQSpZtZFhr0JEgAjy522MJqmTnc7yzhG2IQSh93qmwn8c7mwahRLACe7ExOB1cEhnc0H+Q9YJI7LCebHEbN7hvptMrhVo9DoPs2FrryT8MzfUtZZYLLsOkwm6/IBZnweQ2W7vKAysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kQN4a4PXnMrACZZeCpPBA2Hug+/qyW3VSu/l+psKww=;
 b=xq/z04yxmnHN+TKjpH+4ZaZaq37jj06iwXCCd1REnsUbz8ClyJxgZuQwt+umTxdtnrIh5MXHQWKELmqZl1Lrc8nBFjAmlZz3sDe6GFtFXYvFT6tcwDlIHKc+7HF/E6Xa2xu2RajWEZ1ULljV5qKjL7UZGj41v4N9a5luIx1e+kA=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by BY5PR04MB6659.namprd04.prod.outlook.com (2603:10b6:a03:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 14:58:07 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:58:07 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAAGMgIAAAy0AgAAZaiA=
Date:   Thu, 10 Mar 2022 14:58:07 +0000
Message-ID: <BYAPR04MB49684A8C6FEDA0B999ABCBB2F10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
In-Reply-To: <C2710A6C-340D-4BFC-A8DB-28D456095468@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45464894-d2a1-471d-28dd-08da02a662f3
x-ms-traffictypediagnostic: BY5PR04MB6659:EE_
x-microsoft-antispam-prvs: <BY5PR04MB66598E1C02C5B46180E02C5FF10B9@BY5PR04MB6659.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hsar7y5zRvNS1RSLiPNc+YHWugn0Fb49NSgpsU4u6gOPNYJ5G6/DT0eSM2vRE0PbFvQhOCvSomlf/M8AkULni+WR4CU7YSEy0XwL7KmBVrGOX5E1GUdxH1tnW1mi8v+zNs65Mcc2VjsXHgsRZP61gBa7TEJZmeLxeRG25e+OjoM98jucmSHKNoX4u8USEVRpIIhZVswn3+SJbI0j4/pUeiBNuJD5uCcQN8W/ahV8Tx+Oz2CU5JwXFgEeGb8zrLWERzurajbbWuUA4sA3XdEvC9s2gKYjJseCxoYEtBotgB/qu2WEz2sPwCRkk3tquaohlntuuWu6wlWH15c45KArjbAz1ucqVt9MlJHykr5WzxB8d7JmiACZIRt8MQrd3DjV4f4sUczsqqWAJlKObnJ5E0EvyLkOUZnzblnrsTmQHw+63QEDhwsJqBuW+VGp3cnbq2AUmSTGal9x12RwJigEfHj8NJgRvCRBQ379QHpLb9TKvSEPKv57/gW5pTFuivbMfi0+8yaCO6ZyOcCqs1w2EnVNeTwQzIuZvZ5Ymo2kRNflGdl1nUy3slnQj8o3QzUP4X4eBeYHHSEoMyoQFXP6GX/a8ajeeFl56fDMjyGODZFihVLNkUWrjDaAtnkQoxNmeHlu4k7mWS9qzXsMWgZE1dRcIRLoWKwRT19wWjQtLtcpifejPsL+Vyst19bovmx0zy85Yu7Um3Y3PIpxCm1Iow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(186003)(82960400001)(85202003)(54906003)(85182001)(6916009)(508600001)(122000001)(55016003)(71200400001)(6506007)(7696005)(9686003)(38100700002)(33656002)(2906002)(4326008)(76116006)(66946007)(8676002)(64756008)(66446008)(66556008)(66476007)(52536014)(8936002)(83380400001)(7416002)(5660300002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TktXYTB1OWZLUUpsSmc2TStSSjBZbGI4OFZUQ3NmWlRPUUFUSFZFNFhadUJa?=
 =?utf-8?B?cE1tMkNUVTJHQ2xleE9nQmR4cThnWHdxWTR5ZDRKWEQ3L2JNeW52bktrakFm?=
 =?utf-8?B?UjNGR1BDTDNKbDB4aDdZVCsvbnlwMWtHMVc5c0tHRzBoQWZNTW44OXFUREU2?=
 =?utf-8?B?eEg0SE9sd1dCa0dPcHpBc09pMmgwRktIdnJmVDFjY3V1TldaR0t2WTVreHpB?=
 =?utf-8?B?WkV5R2UrV3JrenJ1U3J5WDVLRStHS1F5ZlZlZ21aQStUUFQrQTFzaXdsY2xL?=
 =?utf-8?B?RVhJTStPZTFBekNqcVJDSHI5VnZSWDk5Mzd3eklWNFZxejY1WGtFM2hrbUtC?=
 =?utf-8?B?Mld4YWtpYytxVzJHOTU1L3p0cWp5bWpTRUFxMkpoNkIyanpsa1BxMFhiWFc2?=
 =?utf-8?B?ajJacnFKTG54SGxIOU8vTTA0T1hocGVqM3ZnNUpNZ0lmWU42UXo5QTJNQWFF?=
 =?utf-8?B?RnlNcnordTFTZnNoSDBHNm8rOEh2am84NnMwSWN4ekRuSVA3dHFiT1JqUmwr?=
 =?utf-8?B?WUtKNHV1M1hEK1AwTktzRFRVS3VGTXB4dEx6WUpRdXlxV1F4WGhndDRNUnQw?=
 =?utf-8?B?MkpSQXc3bWhqSHN2V0ZXWTZCN2RNU1loQy9IU0ZhZy9TSDZrL1hVZ0Z3cWQ5?=
 =?utf-8?B?ZlVyUGp0c0hnVjIxNm5RcHhGWVpFUkFEZ1ppSE9pWjJCSjJHZVVxUzFnN0ZW?=
 =?utf-8?B?ZTU4VjliTURGRWZtVXhWbnRnL1AvaTdZNnduMlJmeEdzaTNvSFhMY0tURTRC?=
 =?utf-8?B?Yk96ZTVZbjVoNzdIVGhxVmx6amJ5amRZWUNVVjg4MFpDbDFuV1FhWFJjRzZN?=
 =?utf-8?B?NGRMcUdTVS9Ja1BTVkwzMFcxQzRsbW5ybHRIQ1M3YkRJcTNxdFpEV00vVTZ1?=
 =?utf-8?B?K1BFaXBwbnE4Vi9pT0JlaUtlR1h1NFZiNXRPaWptWko5bWwzZmxFOFRTS2dk?=
 =?utf-8?B?ejFMQkhwckVxWmNhNk50ZnVQdGRENERWL3dVTlcyUlYzVFN0RGF2S3lSZjVU?=
 =?utf-8?B?NENzd1FoU3VrSkl3QXVhR0RVL1JqUWhqWkxKMmpENFdlWnBUYnZMdk5PdlBa?=
 =?utf-8?B?RW1PdmY4R21mckhJZWdRNEtQdDhGRXZCdXhxYnVRNklvTElxWThSU0xCUmVt?=
 =?utf-8?B?RmZnek5Dd052bTYzK2ljVXB5WGlQTUw2UVd3azdzQVlwWCszcnluczdURUdJ?=
 =?utf-8?B?MFNlc1BJbHBWZW0rTEprZVFzOGpRY0t3eTZqb3JPUE5GV3FnRHA3bnF6dHpJ?=
 =?utf-8?B?ME16TExrWVhaWFE5b2E2ekdzL2dtSk5pQ3pwb0dxcWJ5ZmxYa3JEQlFxZzcr?=
 =?utf-8?B?emE3Y2FvaVRrMWFsMzB6NkxBZmRUZEpLQm5SNS9MYVJDTUp5Y2xRb011Nmd3?=
 =?utf-8?B?eTNMTlV3Ym40a0hWYWd5NjliWkppd3hoank2ZllmT2Q3MnZoaXE2azBpRWdQ?=
 =?utf-8?B?ZC9xZ2pWSmoyTDFuVjYrSmxQWHY3ekRyQ3MwU29HNjRPbmdVSno0Ukl5eVRs?=
 =?utf-8?B?QXdRQTRoMk1yMWlqMzRqeHE1VTAvSVpXZFZBRzlkZnpOKzM1K1hwRktaL3hk?=
 =?utf-8?B?VzJiOFBVMlYvVnV0T0pjeUxTN0dJOEdoV0laRzFqTDluZlFKNWF0YWhWWm9r?=
 =?utf-8?B?bS9NZXV0TnVORG8vVTZmUUVTek5sZXRZemh0QTVvVWw4RVBDZUorWS9vTFRj?=
 =?utf-8?B?aDFhaThEY0ZjVWp6WWJpQytoOHJYQmpXenJzeFVNd2VMZEJlNEtZK3pXL3kx?=
 =?utf-8?B?RVFNaXhwSWdwYjRmaGZDU1ZHVHJCMEthWkdOTDg3VnVQMzhRcDlDQm0zVmxN?=
 =?utf-8?B?THRKY2IyK2lWcVZzVkxNMlBwblkwVE1scStsOEsyUG5PWU1ielphenViVXZj?=
 =?utf-8?B?VGE3cUhNWUdoS0RmUUNrWnFvc1dZMktCSlhyRERZQk9xdTVtTEhCczU1Ym0w?=
 =?utf-8?Q?qnlONkoAqevaTwK45kt/sLPDuOTUV/Tw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45464894-d2a1-471d-28dd-08da02a662f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:58:07.2401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3MCkY6bwqduoyxIvWIvrVhMoG8kiRPMSLK2TomVIRpkfrUxprdrzXJyW42KLl36prNs1fF2YWH+I9XfNObllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6659
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ID4+IFllcywgdGhlc2UgZHJpdmVzIGFyZSBpbnRlbmRlZCBmb3IgTGludXggdXNlcnMgdGhhdCB3
b3VsZCB1c2UgdGhlDQo+ID4+IHpvbmVkIGJsb2NrIGRldmljZS4gQXBwZW5kIGlzIHN1cHBvcnRl
ZCBidXQgaG9sZXMgaW4gdGhlIExCQSBzcGFjZQ0KPiA+PiAoZHVlIHRvIGRpZmYgaW4gem9uZSBj
YXAgYW5kIHpvbmUgc2l6ZSkgaXMgc3RpbGwgYSBwcm9ibGVtIGZvciB0aGVzZSB1c2Vycy4NCj4g
Pg0KPiA+IFdpdGggcmVzcGVjdCB0byB0aGUgc3BlY2lmaWMgdXNlcnMsIHdoYXQgZG9lcyBpdCBi
cmVhayBzcGVjaWZpY2FsbHk/IFdoYXQgYXJlDQo+IGtleSBmZWF0dXJlcyBhcmUgdGhleSBtaXNz
aW5nIHdoZW4gdGhlcmUncyBob2xlcz8NCj4gDQo+IFdoYXQgd2UgaGVhciBpcyB0aGF0IGl0IGJy
ZWFrcyBleGlzdGluZyBtYXBwaW5nIGluIGFwcGxpY2F0aW9ucywgd2hlcmUgdGhlDQo+IGFkZHJl
c3Mgc3BhY2UgaXMgc2VlbiBhcyBjb250aWd1b3VzOyB3aXRoIGhvbGVzIGl0IG5lZWRzIHRvIGFj
Y291bnQgZm9yIHRoZQ0KPiB1bm1hcHBlZCBzcGFjZS4gVGhpcyBhZmZlY3RzIHBlcmZvcm1hbmNl
IGFuZCBhbmQgQ1BVIGR1ZSB0byB1bm5lY2Vzc2FyeQ0KPiBzcGxpdHMuIFRoaXMgaXMgZm9yIGJv
dGggcmVhZHMgYW5kIHdyaXRlcy4NCj4gDQo+IEZvciBtb3JlIGRldGFpbHMsIEkgZ3Vlc3MgdGhl
eSB3aWxsIGhhdmUgdG8ganVtcCBpbiBhbmQgc2hhcmUgdGhlIHBhcnRzIHRoYXQNCj4gdGhleSBj
b25zaWRlciBpcyBwcm9wZXIgdG8gc2hhcmUgaW4gdGhlIG1haWxpbmcgbGlzdC4NCj4gDQo+IEkg
Z3Vlc3Mgd2Ugd2lsbCBoYXZlIG1vcmUgY29udmVyc2F0aW9ucyBhcm91bmQgdGhpcyBhcyB3ZSBw
dXNoIHRoZSBibG9jaw0KPiBsYXllciBjaGFuZ2VzIGFmdGVyIHRoaXMgc2VyaWVzLg0KDQpPaywg
c28gSSBoZWFyIHRoYXQgb25lIGlzc3VlIGlzIEkvTyBzcGxpdHMgLSBJZiBJIGFzc3VtZSB0aGF0
IHJlYWRzIGFyZSBzZXF1ZW50aWFsLCB6b25lIGNhcC9zaXplIGJldHdlZW4gMTAwTWlCIGFuZCAx
R2lCLCB0aGVuIG15IGd1dCBmZWVsaW5nIHdvdWxkIHRlbGwgbWUgaXRzIGxlc3MgQ1BVIGludGVu
c2l2ZSB0byBzcGxpdCBldmVyeSAxMDBNaUIgdG8gMUdpQiBvZiByZWFkcywgdGhhbiBpdCB3b3Vs
ZCBiZSB0byBub3QgaGF2ZSBwb3dlciBvZiAyIHpvbmVzIGR1ZSB0byB0aGUgZXh0cmEgcGVyIGlv
IGNhbGN1bGF0aW9ucy4gDQoNCkRvIEkgaGF2ZSBhIGZhdWx0eSBhc3N1bXB0aW9uIGFib3V0IHRo
ZSBhYm92ZSwgb3IgaXMgdGhlcmUgbW9yZSB0byBpdD8NCg==
