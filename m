Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40311C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 13:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiCONk4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiCONkz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 09:40:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F052E50
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647351583; x=1678887583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gI14XkgrkY6S1ktJJaOu9iRSoEW5ReyDXB3DmfRtqhE=;
  b=ddGTVmtDkJIIuLtFfGpjgN7kAJ4RSbW8fH5cBaU1htWyVglhGTMZGaMW
   ypZ+XQXDex91gGptUeWLd9wvcZhce49MrjWULg2wenorpHLJNzmW4tjRi
   GmY0Q0719rB/xr2dqaIgER0m+TR4xXh5+Cte5Q7Qh7B4a00XtppHFjY4E
   JTej4B6DYt+iuQmEPOllgVQEy0UGKFUI29+zYLH5RYBqmlRoaBAnaiNb3
   7kgyXB1p05dceA1jBnIeARZiK/LHqZsTJnCwMCvumHRxunm5cQl17GcZu
   4szXC2DjP16QgJWnzG/vCg43w42s1yn8I21DyM80mRr/G2YgdX9stxwzs
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; 
   d="scan'208";a="299555572"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 21:39:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW0Nn3oXRG4zRGjpNvghPjM/3All+6tW+LEzTfvVJVke7vDPqxtkwVk+J3yM84ayT3vyK3n3jRw+j/ObzRVe/LIdBt0c/NNfdGKZFnrx/zKQU0ooD+ADv+C1Bq9RQZEks0ACBk/4NJdfsmdGspCvPyc1xxb/lJ6omBx/FrJpPO5oenpizvqA9XRrRVqI5ZdvsI3opNOkhmBlPNFBWRfsPZwXWHmTmR2F+tu3pwrO5y+Ks4ZSIurIROmxTrLOyhgMXnwMenAK2n5d39BGnwbbv+skM8Gx0e3KTm5eXeXd0a7Vs7rCTQs+6OXZDyOYPtwXXAvKx2TOMzj1DgrCn5LNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gI14XkgrkY6S1ktJJaOu9iRSoEW5ReyDXB3DmfRtqhE=;
 b=eNFi7A2v+ROc6wgG27yRkwzrha+ZxeoGZ1GkcgmKy0ziVxvVGzPU7m5ApQWSFH6CzjfRvHj/uzRYmmWsiGPEbunznMMoLM7xz97a1qtBdzIa9n1sC39dI7S1kNe9bYBlb0eWGbCcfxbh1jTHdBWM7HYcdssBVoW8G+vzGU29zvJaQVAFOSmB9tYEzyB2K5n72p8isXLQz4O+x0VB57IeKNy40pL+JpcH4OYlrmr2XO4uydxA4LPFynTEAcJcN1CMBcsqiMSN8OIbOGjthV17eumuuWyGAgdG4Z8M1FX5CiTRUzY90VfSUc3Al9kNe/Qh7BbQ4NA4haKQePw9lE2dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gI14XkgrkY6S1ktJJaOu9iRSoEW5ReyDXB3DmfRtqhE=;
 b=k8Guqtg8DUF8bIg0T7IBc86tDfFIwDcV6hYeD+CNSKA8mL9Wtk+20BnwdonJOTg77yzPsHPTkb800Rzum1sNv9ygQms7vUADOjtALT/IuFhDV4hcdfkh3vC2mQw+aEiEUVR4STFIERaJaE2yAaoxPUetZaQNHwGgpdVqBJa8WsU=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by DM6PR04MB4619.namprd04.prod.outlook.com (2603:10b6:5:2a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 13:39:40 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 13:39:40 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
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
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggAB8RoCAAPimkIAAJw4AgAAAYaCAAAVhgIAAAJOA
Date:   Tue, 15 Mar 2022 13:39:40 +0000
Message-ID: <BYAPR04MB4968906F6A373C6FD2A46EA2F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
In-Reply-To: <20220315132611.g5ert4tzuxgi7qd5@unifi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e00eacf2-0c80-4e11-b253-08da06894189
x-ms-traffictypediagnostic: DM6PR04MB4619:EE_
x-microsoft-antispam-prvs: <DM6PR04MB461943FD2CEC065B58171CA5F1109@DM6PR04MB4619.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icf+Ws+5tVctJOSPx930LosEzZGyl2MsKLXdbjZ0SliycykHLirD0CNrtb0gyjYNbShnpiPNQmHzqqNIBz9+opPWUljnEr/DZse2OFpH7/43R+uNsB2dLcoGsSpzXo6PFQPjiSKysyTZAizueBjHrVzloeEQPcFWMNzNyVv9soWFvF5plgDuDTB1TpyogitO82Ec9k5vCzBRYQ4f7jROPkXQ+UZzztV0LGJqTIJVxwY9aotAetfz/kKG1jIA6NneX7DR3qSv/Qr69uUTmfUxyHM2P9ytg2pgcOFfqt2VlK7kzBuDZGHDsfpTfrapbg1ZyZGyneW7Dh2mYh5HW3Br95yTFj5Gk3Eef55y4UfdytS/tt93P8J0LD8CIED2k/NXOLcFTudpGjkSfXim0clr5oCsuaAD7w5Ce/WWSpqNB4cXD3mIC1D2uYM5opTb3j53z7aqwx7uCdazJg4en00biHL+qQu/CLx9PU/P3XYseDS+PavuRRGsjPDuJUN2Ii55QEEUygj/GqnslPssNK87iHqte978glyh3ETO30Ga4FpnrnU2F6Q+iYSelLB3HvYvtFwfMU2oR9VKwfnTSzxRKMRbjh3EGjLL4iiMRg71n26zjW5nXwTGf+8Zp6awiLj0DXgOKe7ReYpa/ca14zbtc/9dVWM32YX1hMNTfcZNyKL96k7Pb99t8cOQo2d2QRmb91dgNzsJve4YWgjxLN8LNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(9686003)(85182001)(55016003)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(53546011)(6506007)(85202003)(6916009)(508600001)(71200400001)(8676002)(33656002)(66446008)(7416002)(82960400001)(5660300002)(8936002)(38070700005)(52536014)(54906003)(316002)(66574015)(83380400001)(38100700002)(2906002)(186003)(86362001)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHhkam4rTEhpdVE0cHZHUGFKWDFhUXNIa2pSZTA1bSswWTV5YkJyQmhPcjJo?=
 =?utf-8?B?VGxmTnFMUW1UczdLQjhDWUk5T01idHBWcTZqcUl4NDVYSXNrcVh0SjhOeElp?=
 =?utf-8?B?bnZTdWwvOWdadkErRk44cDZkSHQ1U3FvV2lZNDdTbjlXL2tibEhiVHN3TFBC?=
 =?utf-8?B?aXZZai8zU1N2bUw0d0JOVUFlNlZOS3RMQkNURnRwTUQydWR1dXduVG0wSHN1?=
 =?utf-8?B?RHQ1SXk4dndMUG5wam1jYWlZK1NuMnVPN29LZlQ3VmQ5MU81ZEljbTNkTDBS?=
 =?utf-8?B?eFNCU2lHMU0rckhmUTdaTnpUandvcGpndE9TOG90Z1RpMThja0lMVit2S3dz?=
 =?utf-8?B?MW1hbWVKb0FoVjkxOFgxbjAzTHFPZlJqVXBram9jVVBMeWRTRGJ1UlY2UUJk?=
 =?utf-8?B?QWxPanJqaDZyUUQwUUIwUU9kZ3IyYXlMWDl6dUFUOHh1RVRZcnZKWGZNSkFZ?=
 =?utf-8?B?Sk5qd0VoaDJrTzFXbEhEWXBDdlZnN3Z1dFpuUHE3aC9mTVVNWU43dEN2eGM3?=
 =?utf-8?B?WDA3ejZuUittTlRRaVZKU0c3SHYwM2dJcnFGOUE5ZHRNNHp4WGZkendlemtU?=
 =?utf-8?B?dTRXZUZJaGtPSklkNnhiSGtuZ1NEQ0lYb3NxT3ovd3ZUVFlFcmczQnRySHdS?=
 =?utf-8?B?MHBRRFRrbmVBOGplalBRMHMxYWJWY2tlYVZsWVpHZGc2VU1paVdieHdwcXpn?=
 =?utf-8?B?NklmUkhVZk1CTTd6WVIyeWtBbUkybHpGVUw4YXdPNFNGQnp5ODFNdnNMZjY3?=
 =?utf-8?B?c2Y2eDVBdko0YkZqR2NwR2tOSy9COTBMZGRPaEhRQWtNU1BqekhRcVRvKzZZ?=
 =?utf-8?B?dDFxWHdSaFF2cTc2bVh3NERNQjBpT2RJdXM1NUtEclV5bS8yZStxNU1oVm9R?=
 =?utf-8?B?emtnRDIwTjZiWFRjTUNoTmgwaEpFWEVtdlNWcU1UVjBCbWM4TS9FMEFCOU5R?=
 =?utf-8?B?VUk0T3Zkci81K0xvODBDdTgramZTUHJwc0FhRlNGTUJXcE1NUTl6TUM1QWZv?=
 =?utf-8?B?QjFFTEZFd3pZeEQ4dC95SE40elVCK1dKYmcvczhzNVJZSGg0YWpXYm9TZit5?=
 =?utf-8?B?L0V2NzBuQWpra1MyaE1lMjY3Sm5uckxEWEkrUWpVVnVkTlN5dkJqbnNrQW9T?=
 =?utf-8?B?K3gyTTB6NHNRQjZxYmNLci84YzR2Q2c4NVY1OHFYRHNzc3ViNks5VklRUjgz?=
 =?utf-8?B?ODhVZWdhWEpYeU9hTnpHVktZQ1Bxa1JEYkovWUZOOFFEN0pGTU9GNkpKNnA0?=
 =?utf-8?B?OURoK3JCaVcwZzVpRzZ6TEFGMzFWa1kzdjZLa29sZWQ4enVodVdUTUxDS3hn?=
 =?utf-8?B?dTNxZFhjejIyRUt1OVFHamtzLzFZSVVXSldNamxYbE9yREQ4R0dYdjdkcG0y?=
 =?utf-8?B?VWU4MFpEeTlBaUwwQ3IwY0JSUFNxS3ZFK0xWSFVhYXk3YXhRRXhDcTBWbUxh?=
 =?utf-8?B?K0tJN0VNQUZtd0tlQmFQby9Eek01NDJoZFF5TksyWG5BUkRCRzZXWS9tb3Yw?=
 =?utf-8?B?ZlJPRGhzYmI5V0ZMQWMybnZpQ2FqcEtBS0hpK1RiSjFGdWNRYjIyWUtqMWds?=
 =?utf-8?B?bzI5Y3N5YSs1ZEIzQkFraFY1WFE3ZENFa25Oa3Bubzc5akJ2NnMvTnI4bEts?=
 =?utf-8?B?MEZ4enEyVFR0V2xzUlNHTmNOYTNnRlR6V0FWdjhrcHpDek1zc0FpaG1wMG5r?=
 =?utf-8?B?OVFEbTVOelZaVE0zZzBuWEZ6SnRBTVgvZUZ6MFN5Q0F5aG9MRGlySTNROUNG?=
 =?utf-8?B?SWJBRlBwZGkxdTl3UzRPeGRJZDNkR2NRS0pWVmZVYlVZNldxWldOaUZaNlFo?=
 =?utf-8?B?Y3lPMDllWVhWQ3Z1ZU1CYW9oQ1RGTzFFdDdIV3VFTlpXTU9kN1c5MjJiV25s?=
 =?utf-8?B?djJPN1JVZlY1aTFpcFY5TUNVbGE4Ny9UVk1MMXlJNW5PRkt3TlZ1OHVoRkNt?=
 =?utf-8?Q?s8dOvEpJ81DStPBvyv3qy6U+/tx89QZe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00eacf2-0c80-4e11-b253-08da06894189
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:39:40.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oywHxQDyEO+lf3UOa2746Q+MXD4+PON1ThjyyKtzp3fwNXtZq1mA04sfq8TDcOFYvDBVeh6wo9iJc0bX8d9tcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4619
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXZpZXIgR29uesOhbGV6IDxq
YXZpZXJAamF2aWdvbi5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDE1IE1hcmNoIDIwMjIgMTQuMjYN
Cj4gVG86IE1hdGlhcyBCasO4cmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBDYzog
RGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPjsgQ2hyaXN0
b3BoDQo+IEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2Vy
bmVsLm9yZz47IEtlaXRoIEJ1c2NoDQo+IDxrYnVzY2hAa2VybmVsLm9yZz47IFBhbmthaiBSYWdo
YXYgPHAucmFnaGF2QHNhbXN1bmcuY29tPjsgQWRhbQ0KPiBNYW56YW5hcmVzIDxhLm1hbnphbmFy
ZXNAc2Ftc3VuZy5jb20+OyBqaWFuZ2JvLjM2NUBieXRlZGFuY2UuY29tOw0KPiBrYW5jaGFuIEpv
c2hpIDxqb3NoaS5rQHNhbXN1bmcuY29tPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsg
U2FnaQ0KPiBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT47IFBhbmthaiBSYWdoYXYgPHBhbmt5
ZGV2OEBnbWFpbC5jb20+Ow0KPiBLYW5jaGFuIEpvc2hpIDxqb3NoaWlpdHJAZ21haWwuY29tPjsg
bGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC82XSBwb3dlcl9vZl8yIGVtdWxhdGlvbiBz
dXBwb3J0IGZvciBOVk1lIFpOUyBkZXZpY2VzDQo+IA0KPiBPbiAxNS4wMy4yMDIyIDEzOjE0LCBN
YXRpYXMgQmrDuHJsaW5nIHdyb3RlOg0KPiA+PiA+DQo+ID4+ID5BbGwgdGhhdCBzYWlkIC0gaWYg
dGhlcmUgYXJlIHBlb3BsZSB3aWxsaW5nIHRvIGRvIHRoZSB3b3JrIGFuZCBpdA0KPiA+PiA+ZG9l
c24ndCBoYXZlIGENCj4gPj4gbmVnYXRpdmUgaW1wYWN0IG9uIHBlcmZvcm1hbmNlLCBjb2RlIHF1
YWxpdHksIG1haW50ZW5hbmNlIGNvbXBsZXhpdHksDQo+IGV0Yy4NCj4gPj4gdGhlbiB0aGVyZSBp
c24ndCBhbnl0aGluZyBzYXlpbmcgc3VwcG9ydCBjYW4ndCBiZSBhZGRlZCAtIGJ1dCBpdCBkb2Vz
DQo+ID4+IHNlZW0gbGlrZSBpdOKAmXMgYSBsb3Qgb2Ygd29yaywgZm9yIGxpdHRsZSBvdmVyYWxs
IGJlbmVmaXRzIHRvIGFwcGxpY2F0aW9ucyBhbmQgdGhlDQo+IGhvc3QgdXNlcnMuDQo+ID4+DQo+
ID4+IEV4YWN0bHkuDQo+ID4+DQo+ID4+IFBhdGNoZXMgaW4gdGhlIGJsb2NrIGxheWVyIGFyZSB0
cml2aWFsLiBUaGlzIGlzIHJ1bm5pbmcgaW4gcHJvZHVjdGlvbg0KPiA+PiBsb2FkcyB3aXRob3V0
IGlzc3Vlcy4gSSBoYXZlIHRyaWVkIHRvIGhpZ2hsaWdodCB0aGUgYmVuZWZpdHMgaW4NCj4gPj4g
cHJldmlvdXMgYmVuZWZpdHMgYW5kIEkgYmVsaWV2ZSB5b3UgdW5kZXJzdGFuZCB0aGVtLg0KPiA+
Pg0KPiA+PiBTdXBwb3J0IGZvciBab25lRlMgc2VlbXMgZWFzeSB0b28uIFdlIGhhdmUgYW4gZWFy
bHkgUE9DIGZvciBidHJmcyBhbmQNCj4gPj4gaXQgc2VlbXMgaXQgY2FuIGJlIGRvbmUuIFdlIHNp
Z24gdXAgZm9yIHRoZXNlIDIuDQo+ID4+DQo+ID4+IEFzIGZvciBGMkZTIGFuZCBkbS16b25lZCwg
SSBkbyBub3QgdGhpbmsgdGhlc2UgYXJlIHRhcmdldHMgYXQgdGhlDQo+ID4+IG1vbWVudC4gSWYg
dGhpcyBpcyB0aGUgcGF0aCB3ZSBmb2xsb3csIHRoZXNlIHdpbGwgYmFpbCBvdXQgYXQgbWtmcyB0
aW1lLg0KPiA+Pg0KPiA+PiBJZiB3ZSBjYW4gYWdyZWUgb24gdGhlIGFib3ZlLCBJIGJlbGlldmUg
d2UgY2FuIHN0YXJ0IHdpdGggdGhlIGNvZGUNCj4gPj4gdGhhdCBlbmFibGVzIHRoZSBleGlzdGlu
ZyBjdXN0b21lcnMgYW5kIGJ1aWxkIHN1cHBvcnQgZm9yIGJ1dHJmcyBhbmQNCj4gPj4gWm9uZUZT
IGluIHRoZSBuZXh0IGZldyBtb250aHMuDQo+ID4+DQo+ID4+IFdoYXQgZG8geW91IHRoaW5rPw0K
PiA+DQo+ID5JIHdvdWxkIHN1Z2dlc3QgdG8gZG8gaXQgaW4gYSBzaW5nbGUgc2hvdCwgaS5lLiwg
YSBzaW5nbGUgcGF0Y2hzZXQsIHdoaWNoIGVuYWJsZXMNCj4gYWxsIHRoZSBpbnRlcm5hbCB1c2Vy
cyBpbiB0aGUga2VybmVsIChpbmNsdWRpbmcgZjJmcyBhbmQgb3RoZXJzKS4gVGhhdCB3YXkgZW5k
LQ0KPiB1c2VycyBkbyBub3QgaGF2ZSB0byB3b3JyeSBhYm91dCB0aGUgZGlmZmVyZW5jZSBvZiBQ
TzIvTlBPMiB6b25lcyBhbmQgaXQnbGwNCj4gaGVscCByZWR1Y2UgdGhlIGJ1cmRlbiBvbiBsb25n
LXRlcm0gbWFpbnRlbmFuY2UuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIE1hdGlh
cy4gSGFwcHkgdG8gc2VlIHRoYXQgeW91IGFyZSBvcGVuIHRvIHN1cHBvcnQNCj4gdGhpcy4gSSB1
bmRlcnN0YW5kIHdoeSBhIHBhdGNoc2VyaWVzIGZpeGluZyBhbGwgaXMgYXR0cmFjZ2l2ZSwgYnV0
IHdlIGRvIG5vdCBzZWUgYQ0KPiB1c2FnZSBmb3IgWk5TIGluIEYyRlMsIGFzIGl0IGlzIGEgbW9i
aWxlIGZpbGUtc3lzdGVtLiBBcyBvdGhlciBpbnRlcmZhY2VzIGFycml2ZSwNCj4gdGhpcyB3b3Jr
IHdpbGwgYmVjb21lIG5hdHVyYWwuDQoNCldlJ3ZlIHNlZW4gdXB0YWtlIG9uIFpOUyBvbiBmMmZz
LCBzbyBJIHdvdWxkIGFyZ3VlIHRoYXQgaXRzIGltcG9ydGFudCB0byBoYXZlIHN1cHBvcnQgaW4g
YXMgd2VsbC4NCg0KPiANCj4gWm9uZUZTIGFuZCBidXRyZnMgYXJlIGdvb2QgdGFyZ2V0cyBmb3Ig
Wk5TIGFuZCB0aGVzZSB3ZSBjYW4gZG8uIEkgd291bGQgc3RpbGwgZG8NCj4gdGhlIHdvcmsgaW4g
cGhhc2VzIHRvIG1ha2Ugc3VyZSB3ZSBoYXZlIGVub3VnaCBlYXJseSBmZWVkYmFjayBmcm9tIHRo
ZQ0KPiBjb21tdW5pdHkuDQoNClN1cmUsIGNvbnRpbnVvdXMgcmV2aWV3IGlzIGdvb2QuIEJ1dCBu
b3QgaGF2aW5nIHN1cHBvcnQgZm9yIGFsbCB0aGUga2VybmVsIHVzZXJzIGNyZWF0ZXMgZnJhZ21l
bnRhdGlvbi4gRG9pbmcgYSBmdWxsIHN3aXRjaCBpcyBncmVhdGx5IHByZWZlcnJlZCwgYXMgaXQg
YXZvaWRzIHRoaXMgZnJhZ21lbnRhdGlvbiwgYnV0IHdpbGwgYWxzbyBsb3dlciB0aGUgb3ZlcmFs
bCBtYWludGVuYW5jZSBidXJkZW4sIHdoaWNoIGFsc28gd2FzIHJhaXNlZCBhcyBhIGNvbmNlcm4u
DQoNCg0KDQo=
