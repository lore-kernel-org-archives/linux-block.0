Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6AC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347606AbiCOKuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348021AbiCOKss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 06:48:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116051E63
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647341164; x=1678877164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n7iDW7JTJJwi++BAB1Bp1pIo4Z1S9QQXC/EeSPCZ3lQ=;
  b=MXUMMEzAN6q8yHV1q3cF3ItTF+zFYTRTNa/WDkgzvP3Egt3xEYANS6h2
   bbn0u7kTt3RsxB9+eBG1xVtynv8Y77iS+ualm4W2y+cNCCYjup96+x48t
   Din1lfniGdEcT8qnxkeITqA4WS4DvwBI5pMUaSXS1uMBE6hOXrXJzXaFB
   O/YMKvqIxRMgQU/+tM61yPLtse58mKsAY7VZA3gTp1b94C7r7O06psbxv
   QjnFn82oRjWAZRfi0Jd2EYShAh2Fy8lT72oULJrBJgPzfcRY4AP0jfiwd
   DNgn939ymY/eWA5kPWgmGJ/xNqSfdRisaPN5iMInAnDSVsxLsDUOMqnxz
   A==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="194317212"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 18:45:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6pU2G90xJXZs5vqC1hzI5IcRWO7xUYphqDKkns0E8C3vQKTq79gawARMWGLnnlV8nRT5lQOSiDk27B9kGdInc9XkmMyPLoaqt/WezTNHTutyDrZj4Pm3/9XSFg1OIyNGTk0XzT4bBpiD0BhPcdF/f0KJBMDXU20o8YTxXL7Q0tS8ZY2rcW7sKQDzEbxT3+VM+28h/FOdPua44fp5dzZz91e4/KS4va0sg/KgYb/NmpdF+crEcocjSltg3Fv9/JuK6QpZB7ZH6ORncMNaVFWvVHafl1qFNPt844XosZuKDFRiLIpY1fvqYq9mHwo91C/OdI8B8AWm7ub7lwX3pCiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7iDW7JTJJwi++BAB1Bp1pIo4Z1S9QQXC/EeSPCZ3lQ=;
 b=Rw1Z1VuaHK8p9u9zJp8UECIed0OzZsBmCApkYEtv6Pb9IvC4GStaF1KNB+RomiiT8SoPgSKrsYbhKmRnqoIkKofkFabZ12LSGrV/MW5HZT6ZEDBssRtOxXxjC+Xm2rmjMWiL2hwy55ReaPogcp87XTmBlGrbWEhR7VpXC61p6Fob9imGnehzr6Wh9SXJbtPXe8gp/JjkzadLc+8iEI8WWXtvXFmgxrJ8GRxWI2OMT5vEUddDQxj8iI4zlpB2hTtkXSCrrNakZQe6VBNGJS8m5HiZOsCYe9TBDIingFvAvtfEMt34PNI+Bz3Zyuy6bki/DBhJ0SrX0REPnBMagruB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7iDW7JTJJwi++BAB1Bp1pIo4Z1S9QQXC/EeSPCZ3lQ=;
 b=nw6WfgyfRxzKaD5C4NSJxlFUNoD4dsEL3/aFZDbjQPsLT4sybw0oQqnLEHxWsRYmrWkUqI/s17KKlpKykAYGTKfnlkJCbGoUTWxTpCA+Ml1uu9SeMxBuKW0DyT7zvSfC6vRkkSsPDq5tWSZFyTzVx5sLUzFtnUbOAN6VDo8PuTQ=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by MN2PR04MB6095.namprd04.prod.outlook.com (2603:10b6:208:d7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 10:45:43 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 10:45:43 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
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
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggABBCgCAAAuaUIAALnMAgADwd+A=
Date:   Tue, 15 Mar 2022 10:45:43 +0000
Message-ID: <BYAPR04MB4968D747742C5B8264BC298AF1109@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <Yi9sFmQ3pN6+drKE@bombadil.infradead.org>
 <BYAPR04MB49681A28DEBF815225019BECF10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <Yi+cyIHeaTzc/cpq@bombadil.infradead.org>
In-Reply-To: <Yi+cyIHeaTzc/cpq@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 024a95e6-8c31-4765-1b0c-08da0670f4c0
x-ms-traffictypediagnostic: MN2PR04MB6095:EE_
x-microsoft-antispam-prvs: <MN2PR04MB609504E875937315E568F0E3F1109@MN2PR04MB6095.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +izw8aLucLfjOx9pnvfwpQj8eMfPhaNNNs6HVHXYiJpyKLkMvTie2T2Gck60FZU0mSKONO/v5aGKzdqQBPIPVAtWvdrgTZJ96IjZFMGy4fyCKu4q9YkEX8/KguFYcKyKMelQIQ/i60C0u0k25iD7F1OKBoTFFj7NuZLUSixsE8qeOnwKSiA51pwia0kAI9S0Scywu0AGd++XwAZU7ZaBEIREI45Fu5QDBW0q1D4Q1MkAJbDZoERn/0el8BFH7NnH9rg1kzpBZy10FtP1Xo8j0Ie0MsHwiHlMdl/KNzn5cHoANzLPbYjev0dJYBqGOyXksc2VBY8lnFCIJWNh04eTEy/gAsVH7zbTlzcSXut2fkfoPN51PrulHO8JGY1rNjm592i4B0p4/hRHAsggl6/l8rxbg09C2HaeK7pIlFG8SSa2aljQ1MXGImbwCvCOOqaGd0qnJMCD9hAwlyZS4EkvOViLFCRm3GMJfQx/a2pYvAVYLXLwLTg7qXPzc6QFaVX1xfAdbflP2pmHDys4zk8mWU+ZFsX+0aBy4M2XMG38EBP4E5jw7CBGOuRfGNsV2QXx4UUwxI/DVUVQNQYJUnhuBin/fo50+pjfORWJVp+FfXQ3nxrLBiZx6ghTn3aQjHsU+46hBv97fcUXqEhCx9pqHmTzVy+yDNqYt33Hj3WyNVLWPo3oQjpBwnxxX48j4/TrCqbNh0DvMBevYtYGvJmULg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66574015)(316002)(83380400001)(2906002)(86362001)(55016003)(38070700005)(4326008)(8676002)(66946007)(66476007)(66556008)(66446008)(52536014)(64756008)(6506007)(38100700002)(508600001)(7696005)(76116006)(8936002)(85202003)(71200400001)(9686003)(6916009)(54906003)(122000001)(26005)(5660300002)(33656002)(186003)(85182001)(82960400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5CbXo1OWo1OTNHaDJBNUpUWDVwV0tBTlVRV3RJMmF3MGN6SlEvTUt6dnpo?=
 =?utf-8?B?M1BYZ08vdklSUS9CRE9RbjJlWkhDblJxUUE1am9SUkVNY0pERTUxUHFFRGox?=
 =?utf-8?B?Z2ZGTGZVZW5iTzdUSUFJQUlmRzlUYjB5QW5NRE5VUzdPU3l4LzBSc0NETmxE?=
 =?utf-8?B?Z2ZrT090eXJ5SmRYSGl1b3I5Y09QODJ6U1pzeGJONFFaV2lCdzJwd21jaXdv?=
 =?utf-8?B?SDk5Y0grNUhJMjNmSkMvcXZIS2RMMEtsUjFsektKWWVmZFV1QkI4RzZkU3Bj?=
 =?utf-8?B?cCtuby83Z3M1c3VyRmFIQjhPQ2xZRVdFTlVuZGVMVElhOUNJUEl3Q2lJMmI2?=
 =?utf-8?B?ZWpsZ0dxaE01Zm4wK0lyU00raVBicFc0ZnQwZmdsQ1Y4UE5Oa2dTYjgrZDRi?=
 =?utf-8?B?bWZiVTZ5R2xidjJxZW43SmVRUDJ2RWlRdDRRRnl3d1lGV2ZKcjF1a1ROOElz?=
 =?utf-8?B?QmhnbDZhUTdRejdlZUg1Z3VyRThsdTBzamxtTTNRU2pWTERodXdYNmVJMmhO?=
 =?utf-8?B?SGdzUmZZb3NPQXRZeGdpSHl0UWI3LzNZbzR4VDZiblQ1bDVSWHpjZEp3RVov?=
 =?utf-8?B?clBGMm9nbmg2QmNrM0xDa01KOEZrTnhMYTZLY3NmUFJkMCt6dlNJRllVV1JQ?=
 =?utf-8?B?UkRmMThOWmg3Qk0wOEROaDd4MVBEN1pKSmh2cUVlNmJsT0NCYVh2NllSUS85?=
 =?utf-8?B?RnFwcWNZaE8xd1dNYTJpS1V4ajA5RWxFV2p1TENhUVVkVTZNS2RkWEoxQWhy?=
 =?utf-8?B?STZkb1RZUzB5aHA4ZzhEZ1NPZHdZKzl3ZUplbUQ1YUQrYkVjTnBoRTRyeG5y?=
 =?utf-8?B?S3FMYmZiRHpRWnhMcE12K3duMXg3NHFiaXd1MCtuL3UwTlNnMCsyUmFMdEM1?=
 =?utf-8?B?TWRiRy9ZbEJxbVFpTWphL2htMSsvcm9ZQUZpZ1NOVW54cnlxbm9ndzZIZGJq?=
 =?utf-8?B?QUZFeHllaTZDN0dSVkFPdlZ4Um9GTG40VjFBU010cEx3WGNEMnFrbXRlS0RZ?=
 =?utf-8?B?T3pIK3ZOS0t1YU1qODVqVGNvMVlUQXZ4TXFQSVI1Sis5RU02c2kyU3dIWk5D?=
 =?utf-8?B?MmQyV01wT0FLem5ENFc4U0YxQXhtTldJQXhtbGo1dlp3bDY1bHBIc0RHNCti?=
 =?utf-8?B?UXIyL2djR2NwNFJDcGRIL01BcTdHM3d1WnY4amhCRlRodCtwZ2p0SlVVQjUw?=
 =?utf-8?B?RWZWSFJzRG1ZMGpLaGZBT0FON1AvRUpkd3dOUjZkNjJYVkQ1eWN6TXVraUJR?=
 =?utf-8?B?djNuS2wzUFk1ak40NUFSWFJKa05BSVlpVGI2Wm9vL0lNQWVHLzQ3NGs3RDJO?=
 =?utf-8?B?bDNqUGVNUmlNcnZvZlJMaWhPTFh1Z0RzVmhpeWM5WDlBYVI5LzRRMHZKL3Zs?=
 =?utf-8?B?TC9JVUVLY0lMWEN1S2Joc0VLL21mWllmaVlzK3Z6MXpsWjNPN2xyRUlFOG83?=
 =?utf-8?B?K2t4ZHFFVzdwdU5SWkpjNEJKQTZaQlh4bU80VVA4bitTaFdJcDZ0eW9mT3FE?=
 =?utf-8?B?ZmgvbVlCVHQxcllwWXFCSXllNE5aN0lOcFF5RTE2YVUwalI3cFNwSnh2RE5q?=
 =?utf-8?B?TGVTLzhjRVd3RXM3WUtGR2ZIKzdwTGVKZzdiSVNrS0xyYUt1WlhEM2Y4Ky9y?=
 =?utf-8?B?V21ZUEZLZGxINEpDdDdabWtnYnlJVlNRQ3hhQythdUg1dVhiZTVYR3VaRWNC?=
 =?utf-8?B?Q2NBazFGdWpFS1RreU02UHZqM0NPcTJ4ZWVWN3lTLy9JbVpIV2E0Tm05TnlE?=
 =?utf-8?B?SlVwT1ZHZk9OUm5aNEZwNXJsTE1ZMVQ5MXA1SXJoZ0FYNis1T2lXY0NkbmdF?=
 =?utf-8?B?OGsrQkdZNjdCeEZSa3V3RXdDanVkWlVZZFp3T0VxOFk5TzlzUXJEQjRGNUZJ?=
 =?utf-8?B?aFNjUkNGcDBTbHQ0SU1oa3ZFUE44STBucWJraksxangzTEM0LzZwb0JsZ3dx?=
 =?utf-8?Q?Ld8iuCP22dKdKf7g7ZIslsO4Tqf0iHGP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 024a95e6-8c31-4765-1b0c-08da0670f4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 10:45:43.7587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrpM+0vRlXx8EXZXSsTHCEspsfR58r5fxWEBEKgNltMNdc81ecZtDNlLcXBMonp3HK1/keQ17BvGKpZNocQ9PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6095
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiA+ID4gT24gTW9uLCBNYXIgMTQsIDIwMjIgYXQgMDI6MTY6MzZQTSArMDAwMCwgTWF0aWFzIEJq
w7hybGluZyB3cm90ZToNCj4gPiA+ID4gSSB3YW50IHRvIHR1cm4gdGhlIGFyZ3VtZW50IGFyb3Vu
ZCB0byBzZWUgaXQgZnJvbSB0aGUga2VybmVsDQo+ID4gPiA+IGRldmVsb3BlcidzIHBvaW50IG9m
IHZpZXcuIFRoZXkgaGF2ZSBjb21tdW5pY2F0ZWQgdGhlIFBPMg0KPiA+ID4gPiByZXF1aXJlbWVu
dCBjbGVhcmx5LA0KPiA+ID4NCj4gPiA+IFN1Y2ggcmVxdWlyZW1lbnQgaXMgYmFzZWQgb24gaGlz
dG9yeSBhbmQgZWZmb3J0IHB1dCBpbiBwbGFjZSB0bw0KPiA+ID4gYXNzdW1lIGEgUE8yIHJlcXVp
cmVtZW50IGZvciB6b25lIHN0b3JhZ2UsIGFuZCBjbGVhcmx5IGl0IGlzIG5vdC4NCj4gPiA+IEFu
ZCBjbGVhcmx5IGV2ZW4gdmVuZG9ycyB3aG8gaGF2ZSBlbWJyYWNlZCBQTzIgZG9uJ3Qga25vdyBm
b3Igc3VyZQ0KPiA+ID4gdGhleSdsbCBhbHdheXMgYmUgYWJsZSB0byBzdGljayB0byBQTzIuLi4N
Cj4gPg0KPiA+IFN1cmUgLSBJdCdsbCBiZSBuYcOvdmUgdG8gZ2l2ZSBhIGNhcnRlIGJsYW5jaGUg
cHJvbWlzZS4NCj4gDQo+IEV4YWN0bHkuIFNvIHRha2luZyBhIHBvc2l0aW9uIHRvIG5vdCBzdXBw
b3J0IE5QTzIgSSB0aGluayBzZWVtcyBjb3VudGVyDQo+IHByb2R1Y3RpdmUgdG8gdGhlIGZ1dHVy
ZSBvZiBaTlMsIHRoZSBxdWVzdGlvbiB3aG91bGQgYmUsICpob3cqIHRvIGJlc3QgZG8gdGhpcw0K
PiBpbiBsaWdodCBvZiB3aGF0IHdlIG5lZWQgdG8gc3VwcG9ydCAvIGF2b2lkIHBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb25zIC8gc3RyaXZlDQo+IHRvd2FyZHMgYXZvaWRpbmcgZnJhZ21lbnRhdGlvbi4N
Cg0KSGF2aW5nIG5vbi1wb3dlciBvZiB0d28gem9uZSBzaXplcyBpcyBhIGRlcml2YXRpb24gZnJv
bSBleGlzdGluZyBkZXZpY2VzIGJlaW5nIHVzZWQgaW4gZnVsbCBwcm9kdWN0aW9uIHRvZGF5LiBU
aGF0IHRoZXJlIGlzIGEgd2lzaCB0byBpbnRyb2R1Y2Ugc3VwcG9ydCBmb3Igc3VjaCBkcml2ZXMg
aXMgaW50ZXJlc3RpbmcsIGJ1dCBnaXZlbiB0aGUgYmFja2dyb3VuZCBhbmQgZGV2ZWxvcG1lbnQg
b2Ygem9uZWQgZGV2aWNlcy4gRGFtaWVuIG1lbnRpb25lZCB0aGF0IFNNUiBIRERzIGRpZG4ndCBz
dGFydCBvZmYgd2l0aCBQTzIgem9uZSBzaXplcyAtIHRoYXQgd2FzIHdoYXQgYmVjYW1lIHRoZSBu
b3JtIGR1ZSB0byBpdHMgb3ZlcmFsbCBiZW5lZml0cy4gSS5lLiwgZHJpdmVzIHdpdGggTlBPMiB6
b25lIHNpemVzIGlzIHRoZSBvZGQgb25lLCBhbmQgaW4gc29tZSB2aWV3cywgaXMgdGhlIG9uZSBj
cmVhdGluZyBmcmFnbWVudGF0aW9uLg0KDQpUaGF0IHRoZXJlIGlzIGEgd2lzaCB0byByZXZpc2l0
IHRoYXQgZGVzaWduIGRlY2lzaW9uIGlzIGZhaXIsIGFuZCBpdCBzb3VuZHMgbGlrZSB0aGVyZSBp
cyB3aWxsaW5nbmVzcyB0byBleHBsb3JlciBzdWNoIG9wdGlvbnMuIEJ1dCBwbGVhc2UgYmUgYWR2
aXNlZCB0aGF0IHRoZSBMaW51eCBjb21tdW5pdHkgaGF2ZSBoYWQgY29tbXVuaWNhdGVkIHRoZSBz
cGVjaWZpYyByZXF1aXJlbWVudCBmb3IgYSBsb25nIHRpbWUgdG8gYXZvaWQgdGhpcyBwYXJ0aWN1
bGFyIGlzc3VlLiBUaHVzLCB0aGUgY29tbXVuaXR5IGhhdmUgYmVlbiB0cnlpbmcgdG8gaGVscCB0
aGUgdmVuZG9ycyBtYWtlIHRoZSBhcHByb3ByaWF0ZSBkZXNpZ24gZGVjaXNpb25zLCBzdWNoIHRo
YXQgdGhleSBjb3VsZCB0YWtlIGFkdmFudGFnZSBvZiB0aGUgTGludXgga2VybmVsIHN0YWNrIGZy
b20gZGF5IG9uZS4NCg0KPiA+IEhvd2V2ZXIsIHlvdSdyZSBza2lwcGluZyB0aGUgbmV4dCB0d28g
ZWxlbWVudHMsIHdoaWNoIHN0YXRlIHRoYXQgdGhlcmUNCj4gPiBhcmUgYm90aCBnb29kIHByZWNl
ZGVuY2Ugd29ya2luZyB3aXRoIFBPMiB6b25lIHNpemVzIGFuZCB0aGF0DQo+ID4gaG9sZXMvdW5t
YXBwZWQgTEJBcyBjYW4ndCBiZSBhdm9pZGVkLg0KPiANCj4gSSdtIG5vdCwgYnV0IEkgYWRtaXQg
dGhhdCBpdCdzIGEgZ29vZCBwb2ludCBvZiBoYXZpbmcgdGhlIHBvc3NpYmlsaXR5IG9mIHpvbmVz
IGJlaW5nDQo+IHRha2VuIG9mZmxpbmUgYWxzbyBpbXBsaWNhdGVzIGhvbGVzLiBJIGFsc28gdGhp
bmsgaXQgd2FzIGEgZ29vZCBleGNlcmNpc2UgdG8NCj4gZGlzY3VzcyBhbmQgZXZhbHVhdGUgZW11
bGF0aW9uIGdpdmVuIEkgZG9uJ3QgdGhpbmsgdGhpcyBwb2ludCB5b3UgbWFkZSB3b3VsZA0KPiBo
YXZlIGJlZW4gbWFkZSBjbGVhciBvdGhlcndpc2UuIFRoaXMgaXMgd2h5IEkgdHJlYXQgWk5TIGFz
IGV2b2x2aW5nIGVmZm9ydCwgYW5kDQo+IEkgY2FuJ3Qgc2VyaW91c2x5IHRha2UgYW55IHBvc2l0
aW9uIHN0YXRpbmcgYWxsIGFuc3dlcnMgYXJlIGtub3duLg0KDQpUaGF0J3MgZ29vZCB0byBoZWFy
LiBJIHdvdWxkIG5vdGUgdGhhdCBzb21lIG1lbWJlcnMgaW4gdGhpcyB0aHJlYWQgaGF2ZSBiZWVu
IGRvaW5nIHpvbmVkIHN0b3JhZ2UgZm9yIGNsb3NlIHRvIGEgZGVjYWRlLCBhbmQgaGF2ZSBhIHZl
cnkgdGhvcm91Z2ggdW5kZXJzdGFuZGluZyBvZiB0aGUgem9uZWQgc3RvcmFnZSBtb2RlbCAtIHNv
IGl0IG1pZ2h0IGJlIGEgc3RyZXRjaCBmb3IgdGhlbSB0byBoZWFyIHRoYXQgeW91J3JlIGNvbnNp
ZGVyaW5nIGV2ZXJ5dGhpbmcgdXAgaW4gdGhlIGFpciBhbmQgZWFybHkuIFRoaXMgc3RhY2sgaXMg
YWxyZWFkeSBiZWluZyB1c2VkIGJ5IGEgbGFyZ2UgcGVyY2VudGFnZSBvZiB0aGUgYml0cyBiZWlu
ZyBzaGlwcGVkIGluIHRoZSB3b3JsZC4gVGh1cywgdGhlcmUgaXMgYW4gaW50ZXJlc3QgaW4gbWFp
bnRhaW5pbmcgdGhlc2UgdGhpbmdzLCBhbmQgbWFraW5nIHN1cmUgdGhhdCB0aGluZ3MgZG9uJ3Qg
cmVncmVzcyBhbmQgc28gb24uIA0KDQo+IA0KPiA+IE1ha2luZyBhbiBhcmd1bWVudCBmb3Igd2h5
IE5QTzINCj4gPiB6b25lIHNpemVzIG1heSBub3QgYnJpbmcgd2hhdCBvbmUgaXMgbG9va2luZyBm
b3IuIEl0J3MgYSBsb3Qgb2Ygd29yaw0KPiA+IGZvciBsaXR0bGUgcHJhY3RpY2FsIGNoYW5nZSwg
aWYgYW55Lg0KPiANCj4gTkFORCBkb2VzIG5vdCBpbmN1ciBhIFBPMiByZXF1aXJlbWVudCwgdGhh
dCBzaG91bGQgYmUgZW5vdWdoIHRvIGltcGxpY2F0ZQ0KPiB0aGF0IFBPMiB6b25lcyAqY2FuKiBi
ZSBleHBlY3RlZC4gSWYgbm8gdmVuZG9yIHdhbnRzIHRvIHRha2UgYSBwb3NpdGlvbiB0aGF0DQo+
IHRoZXkga25vdyBmb3IgYSBmYWN0IHRoZXknbGwgbmV2ZXIgYWRvcHQNCj4gUE8yIHpvbmVzIHNo
b3VsZCBiZSBlbm91Z2ggdG8ga2VlcCBhbiBvcGVuIG1pbmQgdG8gY29uc2lkZXIgKmhvdyogdG8N
Cj4gc3VwcG9ydCB0aGVtLg0KDQpBcyBsb25nIGFzIGl0IGRvZXNuJ3QgYWxzbyBpbXBseSB0aGF0
IHN1cHBvcnQgKmhhcyogdG8gYmUgYWRkZWQgdG8gdGhlIGtlcm5lbCwgdGhlbiB0aGF0J3Mgb2th
eS4NCg0KPHNuaXA+DQo+IA0KPiA+IElmIGV2YWx1YXRpbmcgZGlmZmVyZW50IGFwcHJvYWNoZXMs
IGl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gdGhlDQo+ID4gcmV2aWV3ZXJzIGlmIGludGVyZmFjZXMg
YW5kIGFsbCBvZiBpdHMga2VybmVsIHVzZXJzIGFyZSBjb252ZXJ0ZWQgaW4gYQ0KPiA+IHNpbmds
ZSBwYXRjaHNldC4gVGhpcyB3b3VsZCBhbHNvIGhlbHAgdG8gYXZvaWQgdXNlcnMgZ2V0dGluZyBo
aXQgYnkNCj4gPiB3aGF0IGlzIHN1cHBvcnRlZCwgYW5kIHdoYXQgaXNuJ3Qgc3VwcG9ydGVkIGJ5
IGEgcGFydGljdWxhciBkZXZpY2UNCj4gPiBpbXBsZW1lbnRhdGlvbiBhbmQgYWxsb3cgYmV0dGVy
IHRvIHJldmlldyB0aGUgZnVsbCBzZXQgb2YgY2hhbmdlcw0KPiA+IHJlcXVpcmVkIHRvIGFkZCB0
aGUgc3VwcG9ydC4NCj4gDQo+IFNvcnJ5IEkgZGlkbid0IHVuZGVyc3RhbmQgdGhlIHN1Z2dlc3Rp
b24gaGVyZSwgY2FuIHlvdSBjbGFyaWZ5IHdoYXQgaXQgaXMgeW91IGFyZQ0KPiBzdWdnZXN0aW5n
Pw0KDQpJdCB3b3VsZCBoZWxwIHJldmlld2VycyB0aGF0IGEgcG90ZW50aWFsIHBhdGNoc2V0IHdv
dWxkIGNvbnZlcnQgYWxsIHVzZXJzIChlLmcuLCBmMmZzLCBidHJmcywgZGV2aWNlIG1hcHBlcnMs
IGlvIHNjaGVkdWxlcnMsIGV0Yy4pLCBzdWNoIHRoYXQgdGhlIGZ1bGwgZWZmZWN0IGNhbiBiZSBl
dmFsdWF0ZWQgd2l0aCB0aGUgYWRkZWQgYmVuZWZpdHMgdGhhdCBlbmQtdXNlcnMgbm90IGhhdmlu
ZyB0byB0aGluayBhYm91dCB3aGF0IGlzIGFuZCB3aGF0IGlzbid0IHN1cHBvcnRlZC4NCg==
