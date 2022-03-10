Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB487C433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiCJNIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbiCJNIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 08:08:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28B14ACAF
        for <linux-block@vger.kernel.org>; Thu, 10 Mar 2022 05:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646917638; x=1678453638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R1ND1k3F3qBT5yPTvEO2JgJCf+tFyHv4sopyR7+K3nc=;
  b=AlFG0IXAS3Zj0szNZ+/1qX9/7iaNmFggtyal/X4IdRjdY/CPCS+jGPf2
   92rCj0l0bHngsfDn1JOeCtmPct04H2hAq4sB4/KBadFzXQCnNkERJ7ZEY
   CiawkL8GlSLsNsMZ6XuP2TEETfc5+m1rydkgffxgKAaLqPOUyHBc2DxcE
   eeMeltk5r1wj/N7SrifdJ4dG4RJ3DMxNbin0Lz9kMEzL85o3LyK4nXbPi
   MeV7ohnlojbeb41rpGzBLZ1B45d/6518dKpcsHHbtzr9VReUWH8Nxxi7h
   w/6eD7+NFo8UY+kAx+Sjhp5sNWXA4tex17MF8AydlvbLCL0FOBMN5hCi6
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643644800"; 
   d="scan'208";a="306921347"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 21:07:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbPXxTGJ9fgCzCw41r2sp5MXoBfiSN/NyxseQU9KXhTycroPTZX5Yr8QuNdA/WNxT9KQIZl7Xqo3/l9YFE67dnNDZYd8bEK0Qp1RRiqBCPw6oA3W0xterpTxzU+UOjbuB0djJQmwzwU9vX783lcC00/mCU7B16OJ7ART+3x/4iKeLTNqe4eEzhCbcwOg6ocLQPPzygT+KS6c5GDygDTGJ5Hqyn39IvzS6HNkxVzyvqJTVFlBP9LpB48uwBltdfEOAkUNsWHBQESiCcOpOVX7iP/H/OHtMhj8nGcDQww4FSJ4f+ofZlz+f13e4auF5mgfxnY+WlBpUj+MVTBOuVdaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1ND1k3F3qBT5yPTvEO2JgJCf+tFyHv4sopyR7+K3nc=;
 b=U3JmRrhS3nB+ZnItPwzf1A6C+aiWwkWRRESGkUcKVJobS3rg/BxJysV/romUCaL6BaEkcpvafscM6IaavtGhbie1fdYOIOvbjIz2NR5+CCmLlTbVqk76wXXzZxA3UB/T+RJ+6STS4VoBPvz9FwTovqhPvMwunk1Y7KzSacnPtelL7jaBVv35+X0T8PqZ1GHiJFQslycyiYEfzduouREtDODzQVy1acJQL1UA9HIWsqcxHFoCzhEifKwHht/H/c9xZH0AW0pf5tejE04m18a6VFE09V+HufGNGfahyRAmpF7/Q+HUKyxlDhGKUrEI+Mrh5TplScP4UYprQ4kEOrzhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1ND1k3F3qBT5yPTvEO2JgJCf+tFyHv4sopyR7+K3nc=;
 b=J9v53y4Va/F04rO1FtaKx/tx5GL2DiJI9x6W6NvYPvQnJ0qBE/qPkqnbVtEIwUHxf5FQ95H6frZCImmCIJ4ooWxm7argtnOx3ntUr+sFa4FLzeWRBYZZ8RDZtj/aPpoZueIfqG6h4vCtPO98puB+TimU+vUeWLLojsaG05KbBOw=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 13:07:13 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::5cb9:fb30:fba:1e1c%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 13:07:13 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
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
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAAGMgA==
Date:   Thu, 10 Mar 2022 13:07:13 +0000
Message-ID: <BYAPR04MB4968FA68FA8B670163EEC1EFF10B9@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
        <20220308165349.231320-1-p.raghav@samsung.com>
        <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
In-Reply-To: <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18d4e1ab-66a5-410d-2517-08da0296e4d6
x-ms-traffictypediagnostic: PH0PR04MB7320:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7320C9A4EE97A663812ADCF3F10B9@PH0PR04MB7320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4AJv8L6q7XBinok1YgeCUP7I8M5+gjoNMCk/WL94dErEIW34p3gTXsZkfH2NANo1iWLoZVCo51svjfVnmpySNDrJ5HMCjFXN5Cv8h0bowZqEOw5N24F1VYHvwT+e8ZbkwvCVV/dn/ddJmOAQkb7bVR4w8SlTecJ8LXE1dEciu9Gagl044ajarqipi/kCGp4Q/jK7f1ALulNP2Xg0KcoTHr6zf67MaPN1N6IG9uDh+dvytguRCcXphHT/yz9qPS9j/qHtPryl3riL9+DaMeUDOtSDT/WTYMAIFl5znGLwEbLjulzz6G/l1ACkLgeprMMSO0JD8hs9i7wKUsdp0U/B0zkPGicmfPJbHtMRt+LcFJ1mlgqQCulJCCnTZz3DnwTG6EXcZuzblG3cLy88loytyux+fxDDbp1nZ0xB8duoJgNjBnfMWz2sxZQq/jcvCRpf5clx7xWtF8fHfSnPvmbADbzBhSX/hwhGYHf9ece7pWoNfy5zTW2Uo+baaBcqFBOiDsMBOsImxHl5vDF9UY6kP2DS36eNn11RGrKSdcf4Phvb8Eb+6suq8xHzzoLg2q2Y2VHnFg9RL6G8iINmtw/qwmk+0g5L7d+O76rNyrqB73hZIczTTzqkGRNYVWjvPCL3VkGvZvbsStviN0Tw78FTZb7bLQZzgisAO/dpg1417Q4PFdJucWGsu87VFU4X7UOrfAFrs1t3Y1mY9VmzBJOow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(82960400001)(85182001)(316002)(71200400001)(8676002)(2906002)(85202003)(86362001)(66556008)(55016003)(66476007)(66446008)(76116006)(66946007)(83380400001)(9686003)(7416002)(122000001)(110136005)(5660300002)(508600001)(4326008)(38070700005)(33656002)(186003)(64756008)(8936002)(6506007)(7696005)(38100700002)(4744005)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmVrTkZ1ekl0d0syWHhxTmhEWHJ4ZTFhVVFxRDh1MUJHUUR1MkcwTXhpcHdk?=
 =?utf-8?B?SzFDYXpHQ3ladGtHTU9LSzEwUTFxVTBzL0UvWmlqMWs4ZU9OS04rRlRJSCtL?=
 =?utf-8?B?cEpQWGJ3U0Uxa3dyQlRQVFhTOHE2ZzFKdG5ES2JFb3VSVjdNQVZySWlIdDlG?=
 =?utf-8?B?dnpudGZRbVpQbkdiWEdUQ05yVG5TUnVnQncyUmNtanBvM0RveDh1ZkRWb3BZ?=
 =?utf-8?B?Z0NtbXpsaW10TEordUd6dkFSNHlXZ3V1WllwSzFPTXlWamRYWDBodnZJME5I?=
 =?utf-8?B?bGswZHUvSW11VlNSWWZzWGNVa1crbnhRTDU2RW0yc05oTkxDdHo1OVk4d1BI?=
 =?utf-8?B?UnB6T0xCczJ2VVFyOGREelJQcWFQN0pQTkJaM3JxakNiY1ovckhZdmRGY0hM?=
 =?utf-8?B?QTRRN1RuZWY0eWFhTmlBZmd1ZVZqVFlHV3Fvb21uRm9mNVQ0L2VNblh5SjF4?=
 =?utf-8?B?bW1RMFZ2MFQ1aWUvS3BXMzB1N2I0WVkydXE3YWk2Lyt6ZC8rMEY0S1NZMEcx?=
 =?utf-8?B?N1F5b0FKNEpOS21qZlVQM2d3QW82RGRPZ0diL3phN0lvYk9yWmJlMHJqZFhp?=
 =?utf-8?B?bFI1TG5SVnlZOVFPenlpZURKcUtnUU1DdjZLN2luM0tUYndldHY5b2tKZGFx?=
 =?utf-8?B?STd1VElDcmxudmJNaXkzbEF1dHJscFdTaFljbzNwOXJiZnpyaW8zRUNmOERN?=
 =?utf-8?B?cEtFV1VDZktwRnQyMFQwbHRmbGJveDl3Skc5a2YvamtrMm5hZUl5VDRVR0hN?=
 =?utf-8?B?Y1hrSGNWa2lodGE3c1lMMHNFL2hsc0ppM2ZEUk8yQ1dyblkyUnRISDNoaGhG?=
 =?utf-8?B?VlFEZUZETXBDU2xieHV2NG1NN3g1SjdEQW5DUnQvSWJqWXNoODI0MVZKcG9r?=
 =?utf-8?B?MHNqaHVWQ1cxbkhCb29tS3NCWFhlU0NBSHI5SFEwQkdGZm03UVZqZzBmWWR5?=
 =?utf-8?B?VnNqc1RzU0ZXWFNpV1lta3BLK3VWSHA4bWJXREswTEdFdU9PWEhDUHU5YzVZ?=
 =?utf-8?B?bjJDZTBLTSszYWF5TzA3K0l5L2pHT2h6OXUxTGt0UytiZ09uVXFVQnZSY1pT?=
 =?utf-8?B?aVQxU0diT0N0aitmQkNPR1JxVTJwTU9HKzFENUo5MUxqSmV1YmVVVTZyam81?=
 =?utf-8?B?a01jZWhjOWdPZEdtLzRjb0tPOXV3RXptZnJ3Q25PUUlqdzZQMFM2M09zR0ZL?=
 =?utf-8?B?RFVwaEs0eTdDZ1lrbG1OV1BqOUpJQUdWL0dkNHM0T2c5UUxJc2ttSE9sRHh3?=
 =?utf-8?B?T1JhcTdZOWRYOEVDckRreGJOSlRNcUIyRjFqeWMyNzlMMFdBRlNQbWlMUUc2?=
 =?utf-8?B?QTBLL3p4SUM4UGRCbjBpKzBsK1pYd2Q1NDlQUTRaWjc3NVNvL0VLUFA0MGor?=
 =?utf-8?B?YUdBRHQ3d1FETGN2SWltaGwwS3U3ZGFaUUUwOGtBSWlWaHEvWTZiNGtlenVJ?=
 =?utf-8?B?UjVZRXBDNUM2TjE2cVF6bjNRR21BQ3FsUk14T21IM0Q1RGNjYU93ZHlsT05y?=
 =?utf-8?B?VWhOdXJ5TWtuZ1lWbFp2MUZXZHYxQ29tZFhxaXFhV3c5REhJQTVpdVE3SldM?=
 =?utf-8?B?dGxsaEhNZm1sZDRCN3FvNm9XVnkvMVp5RHVTZ2tOWGVyQVJQSzFzYnF3RnJ4?=
 =?utf-8?B?OGx0UjJ6TU9PL2M3SCswZ3d3SEVuNEV3UnZ4d2owNVJzSkZoOVViZEZ2SWlq?=
 =?utf-8?B?UzVNU0QwTzIwUnJvdHppYVR6a0EwSDBqK0o1RFhsNklLK20zT3dTV1BPaG5u?=
 =?utf-8?B?SFVBSCs0SkNIT0NXU003RFphT1V5UU5TQmp4VVp2bHRPMUNBZ0xza3ZSc3o1?=
 =?utf-8?B?TGdPRnNCUW94RlgrTHc2d1ExUXVEa0dSckh6RFlTK1VzTUxjWXFJQVBDdnVO?=
 =?utf-8?B?WXBFcXJHYkZ4M3h2YzdFL21xVlA0Z2p0OUdoU0doMmloN2o1MEhUZERuaHRJ?=
 =?utf-8?B?UDlXV1RGb0lzNk0vMDRidFVIMGVhOWV2SnFhVWZRM0g4TWlaei9PUHZBa25G?=
 =?utf-8?B?MzVUVGwwL0toS0h1azVxQnRkTHNrNzhPUU5IMHR1d25qV20vWDVWU1VEaTVm?=
 =?utf-8?B?ajhPV2Rhb2NpSE9oZTl2bklaRG5xeU5peUxzTmpkRklJMkgyUUZxWEk5OGgz?=
 =?utf-8?B?NXVHWnNKUTdCcVgzdXFpWWxoelNWbG9BWDZ4OGdwbzVGamRWMlNkRFJYUStH?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d4e1ab-66a5-410d-2517-08da0296e4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 13:07:13.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjPBnPmNLuEyV/LQTIB2O/EmYHxp/lNoOryTQTQ1+ZjBUJ4e3Go54zgohbokVikGHBuHs951cbEk+HWDJazZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiBZZXMsIHRoZXNlIGRyaXZlcyBhcmUgaW50ZW5kZWQgZm9yIExpbnV4IHVzZXJzIHRoYXQgd291
bGQgdXNlIHRoZSB6b25lZA0KPiBibG9jayBkZXZpY2UuIEFwcGVuZCBpcyBzdXBwb3J0ZWQgYnV0
IGhvbGVzIGluIHRoZSBMQkEgc3BhY2UgKGR1ZSB0byBkaWZmIGluDQo+IHpvbmUgY2FwIGFuZCB6
b25lIHNpemUpIGlzIHN0aWxsIGEgcHJvYmxlbSBmb3IgdGhlc2UgdXNlcnMuDQoNCldpdGggcmVz
cGVjdCB0byB0aGUgc3BlY2lmaWMgdXNlcnMsIHdoYXQgZG9lcyBpdCBicmVhayBzcGVjaWZpY2Fs
bHk/IFdoYXQgYXJlIGtleSBmZWF0dXJlcyBhcmUgdGhleSBtaXNzaW5nIHdoZW4gdGhlcmUncyBo
b2xlcz8gDQo=
