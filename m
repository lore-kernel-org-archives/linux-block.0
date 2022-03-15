Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84877C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 14:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiCOOFF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349079AbiCOOEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 10:04:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B236176
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647353006; x=1678889006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BC0tXo/xnxdzYnTfT4MNLMO4IG3KDs+IbwM57do5QjY=;
  b=Ss3IKQviA8PsA25MlfeFWKylBDum/wgaMGRGS8yX43ImWozs6G40DSuz
   4MAddbC2GiCtjnnp9VHCmNYfNhRNp4t2nDl6MVoEiHMdcSql4MBSO+fjt
   4Z4ohMo1NN6yqvgBR41n/HaK6LE4/DEXK6RpZTlRhg+MJA9HbctPxmyKa
   Xrl0WiO9KaY14c086XdQgHRLTE+O33OeO54EGhQ11JdAwRhK72t0NOekO
   fIyfcnduVWQ4EbGlJLD0JeTE9Jqb/zHMWCWHEmHhNfE1Bq8ll61mGha6j
   REr/A45DB4SXkxwUXSFsP32QU7xnH8HJHhsWF5RzTqg/QS6cy8XhssR6m
   w==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="196351022"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 22:03:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4+teDgMedLm9fqI0nHy/KSX4tTAJthAJrFB5rYe1S+r2gwPYLYadhvn4j0MvMZhFyBcGQFX/zXlFLSNIfilmfewgAxSJb9cZwBJ5jVmEDrUGV5DEpNoeL/MnQVSODXo98F0FXxuWr7bVI0Qxk4drWO3WzKAzs8K1niVlr+HJOi5Lp62WEqRtSXMKcimPWLFrSP7Vsb76S78K4+P2FEXlJDU628KANlzaH99l1rD46h2x4HIZi7lqH9crERf6V1YeTMjCDGLJx0C/unmyxMiBCTOSiOJIo9c9KeWuoLlFIxeJeguiqfQbSdzEysEvfreW4AeTewcwZPYAsZ5o4ZZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC0tXo/xnxdzYnTfT4MNLMO4IG3KDs+IbwM57do5QjY=;
 b=X7nDZayL71+5v1sNWBZSHe3Mr5jPRiiBSgEUmtbxIeYCpCQBbJaVJWMbQcSHtrkyChfWm0q5mws6tbd5L0GwYizIiSDKPNJthsq+jiJ+aNpr/ca1g1t+FW4Bch96jSVdc/0caoF+zHFlpG7SOa3eD/lQZ8DDiBmEpZPfImYJeGQz6QClkCGjkYEcg2CWPXgzZqW1Mi0gj929N1N9guU2IrhoJEVVJuhBOQL3COEjMP5d9nBWv7T1r7ZXI074z1UVyuJVfOMGsK1Dhm77/vw0LNXRVg81acC0jwlgOMYjZLTiVyBf2R0U5mJniokCDhFwp3z/em5ct74D1977A49Eyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC0tXo/xnxdzYnTfT4MNLMO4IG3KDs+IbwM57do5QjY=;
 b=ebYt9r+8gYiwWZfWc7wERzLLCgDwAQcJdZ/cuy5bELbxKIuKlZ1XgYLPZd4JOhY7AOzI5HJ5w7q/cTpuOQn/Z13tAaupvSZSvgGG0N3IzxZJ74LR4oEa8XBwIUkOtyQ11vgH9leQak1cI4wLY+nkTPMKOFh0qaHtSlBNBs2OxoQ=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by CH2PR04MB6885.namprd04.prod.outlook.com (2603:10b6:610:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 14:03:15 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 14:03:15 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggAB8RoCAAPimkIAAJw4AgAAAYaCAAAVhgIAAAU8AgAAGHYCAAAB3IA==
Date:   Tue, 15 Mar 2022 14:03:15 +0000
Message-ID: <BYAPR04MB4968346E792FA179EFC85A43F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
In-Reply-To: <20220315135245.eqf4tqngxxb7ymqa@unifi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc0cf02a-ad53-4f06-7cf4-08da068c8d0d
x-ms-traffictypediagnostic: CH2PR04MB6885:EE_
x-microsoft-antispam-prvs: <CH2PR04MB68851EE9690C1E5A356BDA02F1109@CH2PR04MB6885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bm/jXI1elItDScZTQeBHYeO+Ew3NszP7R7JNgqgqsduM8rKdytulRn0K+0mUfn7R5o+80FIsbKNk/9vvzMbRpa7na8/zEYRSPCXZ802QYCLiy2sAkUyPUAabeTcf0K0yeTxomH+1wSzysr160FXL+nDeMp3Vn9aN2rtFbtkxJgwS7lGzpntfsmDsLMFlrWrSwM4V7rYiqqM9Yvu2UrnmGulKDPhdZABuyOVccFr+b945uvITw3Y63LgC5JeSGfNap7qvYkuZZJ4x59q9z+tlGheXduRjHFnPpt97Q6Sq+60gCyw4NfRI1rpqIIDM+t+h9mWdQYn1IHKxBW0oFvKj4CfwSA8HqGnrxP8eOr+uYc1PgCn0EgNwkfGMM9PCWP2aV4nkU8j25gIdCrM76rtykSqFV6cpTOt+ejbMyZwebymRn5hGDG45/HLHr2kaTvCHeuVaW3NvJmr5DAoc33cE8/SHioT3R1F8048hCdnC/y8aMrSDIbsYUJtL+pzf4+9u2SR+843LDR7EB05KGJVXKtar5aiQmYgiWoXN4k6k7A/GBQaziS1CKMPGT+7BVoYNF6wonWqr/SfWi5IVaFNXp93p8ABkTcRiXL7oDdEuWXNeFlwJsqw6JKE5S7YNefqxq33ElFF4e9+/ldfINtudBuKEQe2lITZBtbEfzExBwr/Tr1Bs5aB0STyO2cL5FINlrLnJxQIMtjrwA5DZIwumTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(86362001)(8936002)(33656002)(5660300002)(508600001)(7416002)(9686003)(2906002)(53546011)(7696005)(6506007)(55016003)(122000001)(82960400001)(38100700002)(66574015)(26005)(110136005)(186003)(83380400001)(64756008)(38070700005)(66946007)(66446008)(66476007)(85182001)(66556008)(4326008)(316002)(85202003)(8676002)(54906003)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGxaUkNlT25PMm5neG5vNjc4cDI1WXRQbWdlQUJndjdCNEZrZzJLSE9RUXpE?=
 =?utf-8?B?a3p5MjNKYnJrVlhjSTYxVnJnSFJnUzg5YitRVks3cko5ZkRkWW14MUg3VVBO?=
 =?utf-8?B?MWZuVktnNmE1dU4zRXBoaVhyVnJ4OXFLcjZNZXc5K3NiMUtqOVBWVEx1QzMz?=
 =?utf-8?B?UWt4V1VOQ2tsRjEwczNaZGpPQkVEdDRhZ2pONDJZUHpCNFNkbUM4WVliNEgz?=
 =?utf-8?B?RlBJWEJmKzI1UFk3L1FzUTlhQmNTaDIrVWorZEhuS0tLb29jRmJmZEdWY0VD?=
 =?utf-8?B?K3plbTBkVGM4ZFZiS09CN2VYZ2VTTEZQODdoQy9YbFdCWTR2OWVweUN2VWho?=
 =?utf-8?B?QTNXckh6Y2czQ2NBOFNWTEtlMVVLU2NZczVRbzBnZzdYTTJRcm5ZRUtaUFFP?=
 =?utf-8?B?cHcvZys4R1hnanZoMzZ3ZkpjN2tBdFdTbFNqUlY1Q0I2WUxGSzBXTmx6T2gx?=
 =?utf-8?B?L0VuMFpkSmZvek8rVGhmNzBETmhEM2pMeTdlY1o4Nm1RWmt2WUVNRldjQWxD?=
 =?utf-8?B?LzZVUUJEVVhQVk91a3pSTU4rVVUrVU14NHltenZaNmR6OXNkNkdEYWFVc0lx?=
 =?utf-8?B?cGcwSTkwVUdxWC9TeFdBeWRNbmpqWFVYb29zaGQ5MHUrQXo4bzVHU243Zkts?=
 =?utf-8?B?SWZOdWV1bTl3eGNpSk96Y2UyOTJHQktMRTdsKzVhazcyMW9hK1RPaVVjdUZC?=
 =?utf-8?B?NzJuMjIydng0VExYbmNIOWRtbnVkci9GVHdTRjFNNkdBR1FzRFVoa3pQZmoy?=
 =?utf-8?B?MmFQN1IrUTJTK0RxaDIwNmQ0YXRES01qOEdnM01IUjJwMzJ0amNVMERqNzZZ?=
 =?utf-8?B?bTZKdnN6RUlxVGtlajM0WjZHRzc3NElrTzlOUjV4VzFDeG9zejBXbWNjenhs?=
 =?utf-8?B?aTZLT2Z0Snk1anE2ZDUvRmwwR0Y1ZkF6cWQ3WWlGQXRLM3o0R3VGZUhEaHlt?=
 =?utf-8?B?M09vbDNjMEdLakRlanc2cGd1VDlZN2R3RnV5NzJTZ2Y4NDhmUnU4Z0QwRHNW?=
 =?utf-8?B?SU1wc0lyb2lIT0FRbnpYNmxpQWNFSVNuSy9xcWJGZzl5c1hsR1VUOE5qM0ZW?=
 =?utf-8?B?NVAzV3lSblR6WXJoelB3Z2pCRTFmS21LVjQrU1hBRnNSNGRiS0FHK2JHR21p?=
 =?utf-8?B?VzFYamFuMm5NTk02Z1E1NktIakFlejFtMEJYWXEvajNCWEtKL1d1NkhvTGxV?=
 =?utf-8?B?WXpRWVBOS09WWmZodlZWZ1libXJnRjV0M1hubjQweXJ6Vjd5OUNoci9iQ3Nj?=
 =?utf-8?B?Qyt5SkQyWlMwcy9ocm5BK2grbXRIdzdtSmZ3Y0FjQ21ndUx6MDdlMmswTEJw?=
 =?utf-8?B?bktQQk9RN2NFNFVVdWE1eklNa1M1NzRmY0xtVDh0TXBoSDBQdlRrbHhEeWY5?=
 =?utf-8?B?V2F1Z25wejN6ZGdnb3FMMU8xeXFKNW9HSlUwYlNEL0RBeTVZT1FRclV2ZklE?=
 =?utf-8?B?M2NwdzgrbGk5L2t2U0Z1QXNOK1h1MlZRZ3pvQndOdnZMRUZwMnEwUUtsNkNI?=
 =?utf-8?B?S091ZSs0c0RWQ1VFQVZnSGpob3hTTVlybEZNaGVaZHZFMURYaHR3TjB4TVhh?=
 =?utf-8?B?WG5oUGVSa3pzMUIyemlveHRHcWlMWjE0QWVoV0NnaWpOTHVPSk9JZmpQeEMv?=
 =?utf-8?B?Y0x6WW5obi9iT3p0TnhBY2I1ZC9ST0FMTWZiSWZoSnhIbnB1RjNQd0gzSnov?=
 =?utf-8?B?MFdDcTNXbDI2M0lsVVJ3a3FtL0IvUkJNRUdwZjNCdmRUcE55aVhhczdCc2Y4?=
 =?utf-8?B?TlAyME9OZW4yMFR2M2MwcHljdmVhV29ZVWdUQURVZmlOSm56YUtNZmZLb1hk?=
 =?utf-8?B?YnNVZ2NTdGk3R09QUzQ3YVhRV2pHa0MzZEdnbGM2Q2gyQ2N1WFBIQWRMWkor?=
 =?utf-8?B?LzVFL0Z2VVoyZ25hTXRneEdYaklob3hRV0p2U0lIOW5Odkt2UjVPcWtDcDhP?=
 =?utf-8?Q?anhT5PBnn1bcolc8dZt3E0JM83i+8N6b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0cf02a-ad53-4f06-7cf4-08da068c8d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 14:03:15.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q4LvgFZVuFTtxyrm8rHcu+UUiSf7EjWM8H6a9svfmpnXlEITAeaGRxxa022uywXpU8nobnNA3ctHb1Pd4VtOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXZpZXIgR29uesOhbGV6IDxq
YXZpZXJAamF2aWdvbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDE1IE1hcmNoIDIwMjIgMTQuNTMN
Cj4gVG86IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogTWF0aWFzIEJqw7hy
bGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+OyBEYW1pZW4gTGUgTW9hbA0KPiA8ZGFtaWVu
LmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+OyBMdWlzIENoYW1iZXJsYWluDQo+IDxtY2dyb2ZA
a2VybmVsLm9yZz47IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IFBhbmthaiBSYWdo
YXYNCj4gPHAucmFnaGF2QHNhbXN1bmcuY29tPjsgQWRhbSBNYW56YW5hcmVzDQo+IDxhLm1hbnph
bmFyZXNAc2Ftc3VuZy5jb20+OyBqaWFuZ2JvLjM2NUBieXRlZGFuY2UuY29tOyBrYW5jaGFuIEpv
c2hpDQo+IDxqb3NoaS5rQHNhbXN1bmcuY29tPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
PjsgU2FnaSBHcmltYmVyZw0KPiA8c2FnaUBncmltYmVyZy5tZT47IFBhbmthaiBSYWdoYXYgPHBh
bmt5ZGV2OEBnbWFpbC5jb20+OyBLYW5jaGFuIEpvc2hpDQo+IDxqb3NoaWlpdHJAZ21haWwuY29t
PjsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC82XSBwb3dlcl9vZl8yIGVtdWxhdGlv
biBzdXBwb3J0IGZvciBOVk1lIFpOUyBkZXZpY2VzDQo+IA0KPiBPbiAxNS4wMy4yMDIyIDE0OjMw
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPk9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDAy
OjI2OjExUE0gKzAxMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6DQo+ID4+IGJ1dCB3ZSBkbyBu
b3Qgc2VlIGEgdXNhZ2UgZm9yIFpOUyBpbiBGMkZTLCBhcyBpdCBpcyBhIG1vYmlsZQ0KPiA+PiBm
aWxlLXN5c3RlbS4gQXMgb3RoZXIgaW50ZXJmYWNlcyBhcnJpdmUsIHRoaXMgd29yayB3aWxsIGJl
Y29tZSBuYXR1cmFsLg0KPiA+Pg0KPiA+PiBab25lRlMgYW5kIGJ1dHJmcyBhcmUgZ29vZCB0YXJn
ZXRzIGZvciBaTlMgYW5kIHRoZXNlIHdlIGNhbiBkby4gSQ0KPiA+PiB3b3VsZCBzdGlsbCBkbyB0
aGUgd29yayBpbiBwaGFzZXMgdG8gbWFrZSBzdXJlIHdlIGhhdmUgZW5vdWdoIGVhcmx5DQo+ID4+
IGZlZWRiYWNrIGZyb20gdGhlIGNvbW11bml0eS4NCj4gPj4NCj4gPj4gU2luY2UgdGhpcyB0aHJl
YWQgaGFzIGJlZW4gdmVyeSBhY3RpdmUsIEkgd2lsbCB3YWl0IHNvbWUgdGltZSBmb3INCj4gPj4g
Q2hyaXN0b3BoIGFuZCBvdGhlcnMgdG8gY2F0Y2ggdXAgYmVmb3JlIHdlIHN0YXJ0IHNlbmRpbmcg
Y29kZS4NCj4gPg0KPiA+Q2FuIHNvbWVvbmUgc3VtbWFyaXplIHdoZXJlIHdlIHN0YW5kPyAgQmV0
d2VlbiB0aGUgbGFjayBvZiBxdW90aW5nIGZyb20NCj4gPmhlbGwgYW5kIG92ZXJseSBsb25nIGxp
bmVzIGZyb20gY29ycG9yYXRlIG1haWwgY2xpZW50cyBJJ3ZlIG1vc3RseQ0KPiA+c3RvcHBlZCBy
ZWFkaW5nIHRoaXMgdGhyZWFkIGJlY2F1c2UgaXQgdGFrZXMgdG9vIG11Y2ggZWZmb3J0IGFjdHVh
bGx5DQo+ID5leHRyYWN0IHRoZSBpbmZvcm1hdGlvbi4NCj4gDQo+IExldCBtZSBnaXZlIGl0IGEg
dHJ5Og0KPiANCj4gICAtIFBPMiBlbXVsYXRpb24gaW4gTlZNZSBpcyBhIG5vLWdvLiBEcm9wIHRo
aXMuDQo+IA0KPiAgIC0gVGhlIGFyZ3VtZW50cyBhZ2FpbnN0IHN1cHBvcnRpbmcgUE8yIGFyZToN
Cj4gICAgICAgLSBJdCBtYWtlcyBaTlMgZGVwYXJ0IGZyb20gYSBTTVIgYXNzdW1wdGlvbiBvZiBQ
TzIgem9uZSBzaXplcy4gVGhpcw0KPiAgICAgICAgIGNhbiBjcmVhdGUgY29uZnVzaW9uIGZvciB1
c2VycyBvZiBib3RoIFNNUiBhbmQgWk5TDQo+IA0KPiAgICAgICAtIEV4aXN0aW5nIGFwcGxpY2F0
aW9ucyBhc3N1bWUgUE8yIHpvbmUgc2l6ZXMsIGFuZCBwcm9iYWJseSBkbw0KPiAgICAgICAgIG9w
dGltaXphdGlvbnMgZm9yIHRoZXNlLiBUaGVzZSBhcHBsaWNhdGlvbnMsIGlmIHdhbnRpbmcgdG8g
dXNlDQo+ICAgICAgICAgWk5TIHdpbGwgaGF2ZSB0byBjaGFuZ2UgdGhlIGNhbGN1bGF0aW9ucw0K
PiANCj4gICAgICAgLSBUaGVyZSBpcyBhIGZlYXIgZm9yIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb25z
Lg0KPiANCj4gICAgICAgLSBJdCBhZGRzIG1vcmUgd29yayB0byB5b3UgYW5kIG90aGVyIG1haW50
YWluZXJzDQo+IA0KPiAgIC0gVGhlIGFyZ3VtZW50cyBpbiBmYXZvdXIgb2YgUE8yIGFyZToNCj4g
ICAgICAgLSBVbm1hcHBlZCBMQkFzIGNyZWF0ZSBob2xlcyB0aGF0IGFwcGxpY2F0aW9ucyBuZWVk
IHRvIGRlYWwgd2l0aC4NCj4gICAgICAgICBUaGlzIGFmZmVjdHMgbWFwcGluZyBhbmQgcGVyZm9y
bWFuY2UgZHVlIHRvIHNwbGl0cy4gQm8gZXhwbGFpbmVkDQo+ICAgICAgICAgdGhpcyBpbiBhIHRo
cmVhZCBmcm9tIEJ5dGVkYW5jZSdzIHBlcnNwZWN0aXZlLiAgSSBleHBsYWluZWQgaW4gYW4NCj4g
ICAgICAgICBhbnN3ZXIgdG8gTWF0aWFzIGhvdyB3ZSBhcmUgbm90IGxldHRpbmcgem9uZXMgdHJh
bnNpdGlvbiB0bw0KPiAgICAgICAgIG9mZmxpbmUgaW4gb3JkZXIgdG8gc2ltcGxpZnkgdGhlIGhv
c3Qgc3RhY2suIE5vdCBzdXJlIGlmIHRoaXMgaXMNCj4gICAgICAgICBzb21ldGhpbmcgd2Ugd2Fu
dCB0byBicmluZyB0byBOVk1lLg0KPiANCj4gICAgICAgLSBBcyBaTlMgYWRkcyBtb3JlIGZlYXR1
cmVzIGFuZCBvdGhlciBwcm90b2NvbHMgYWRkIHN1cHBvcnQgZm9yDQo+ICAgICAgICAgem9uZWQg
ZGV2aWNlcyB3ZSB3aWxsIGhhdmUgbW9yZSB1c2UtY2FzZXMgZm9yIHRoZSB6b25lZCBibG9jaw0K
PiAgICAgICAgIGRldmljZS4gV2Ugd2lsbCBoYXZlIHRvIGRlYWwgd2l0aCB0aGVzZSBmcmFnbWVu
dGF0aW9uIGF0IHNvbWUNCj4gICAgICAgICBwb2ludC4NCj4gDQo+ICAgICAgIC0gVGhpcyBpcyB1
c2VkIGluIHByb2R1Y3Rpb24gd29ya2xvYWRzIGluIExpbnV4IGhvc3RzLiBJIHdvdWxkDQo+ICAg
ICAgICAgYWR2b2NhdGUgZm9yIHRoaXMgbm90IGJlaW5nIG9mZi10cmVlIGFzIGl0IHdpbGwgYmUg
YSBoZWFkYWNoZSBmb3INCj4gICAgICAgICBhbGwgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+ICAgLSBJ
ZiB5b3UgYWdyZWUgdGhhdCByZW1vdmluZyBQTzIgaXMgYW4gb3B0aW9uLCB3ZSBjYW4gZG8gdGhl
IGZvbGxvd2luZzoNCj4gICAgICAgLSBSZW1vdmUgdGhlIGNvbnN0cmFpbnQgaW4gdGhlIGJsb2Nr
IGxheWVyIGFuZCBhZGQgWm9uZUZTIHN1cHBvcnQNCj4gICAgICAgICBpbiBhIGZpcnN0IHBhdGNo
Lg0KPiANCj4gICAgICAgLSBBZGQgYnRyZnMgc3VwcG9ydCBpbiBhIGxhdGVyIHBhdGNoDQo+IA0K
PiAgICAgICAtIE1ha2UgY2hhbmdlcyB0byB0b29scyBvbmNlIG1lcmdlZA0KPiANCj4gSG9wZSBJ
IGhhdmUgY29sbGVjdGVkIGFsbCBwb2ludHMgb2YgdmlldyBpbiBzdWNoIGEgc2hvcnQgZm9ybWF0
Lg0KDQorIFN1Z2dlc3Rpb24gdG8gZW5hYmxlIGFsbCB1c2VycyBpbiB0aGUga2VybmVsIHRvIGxp
bWl0IGZyYWdtZW50YXRpb24gYW5kIG1haW50YWluZXIgYnVyZGVuLg0KKyBQb3NzaWJsZSBub3Qg
YSBiaWcgaXNzdWUgYXMgdXNlcnMgYWxyZWFkeSBoYXZlIGFkZGVkIHRoZSBuZWNlc3Nhcnkgc3Vw
cG9ydCBhbmQgdXNlcnMgYWxyZWFkeSBtdXN0IG1hbmFnZSBvZmZsaW5lIHpvbmVzIGFuZCBhdm9p
ZCB3cml0aW5nIGFjcm9zcyB6b25lcy4gDQorIFJlOiBCbydzIGVtYWlsLCBpdCBzb3VuZHMgbGlr
ZSB0aGlzIG9ubHkgYWZmZWN0IGEgc2luZ2xlIHZlbmRvciB3aGljaCBrbm93aW5nbHkgbWFkZSB0
aGUgZGVjaXNpb24gdG8gZG8gTlBPMiB6b25lIHNpemVzLiBGcm9tIEJvOiAiKFdoYXQgd2UgZGlz
Y3Vzc2VkIGhlcmUgaGFzIGEgcHJlY29uZGl0aW9uIHRoYXQgaXMsIHdlIGNhbm5vdCBkZXRlcm1p
bmUgaWYgdGhlIFNTRCBwcm92aWRlciBjb3VsZCBjaGFuZ2UgdGhlIEZXIHRvIG1ha2UgaXQgUE8y
IG9yIG5vdCkiKS4gIA0K
