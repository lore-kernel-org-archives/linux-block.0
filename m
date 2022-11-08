Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF5AC4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiKHHp2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKHHpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:45:06 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574DCC21;
        Mon,  7 Nov 2022 23:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893505; x=1699429505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Nth+0+q5/Cs4wMBfIbIfAYXDNs7aTDY96MGbYQCvNQ84qnPS8UOaEfYo
   6bKhrrCWMeygHgtEZ/lj8r7zir2M5oAkWtTCYjcf4QJo4Ckgv+A7fints
   nljrxuVcx0RjbZjT7qAVHzqozT6gYOqRhcTEMpQiS0QcjZJ34bgdZZqE+
   2r6PhdT+1LF8x8z2sJ1Y3zw+2clh14RtX3H3tKCOl3kjMfr2Qvwa7Y5Ln
   Jy1PKSRHjhXPP5AMy/4ivDqbUeLbEPUkL1fBkchWjjIWjHJ5DZArLmupw
   fAYdKzhm0BtajCeSRYksGKg9RTS11CLlmaA98/umIvUsEF+P0cWNscIve
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="216075956"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:45:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEFebxaB+WHtIoRgOyyjgxRpY+W2+6ytFLNi6HLq/R4nR+K2xZMmHMq5u8UMbHmtZ83BRRUQ17yeUgLjbL/s/A2PoueyDqR+Uxl/UGo5WLK133Woy26fo4vkaUVTpNXPmhNJXcslBjJfEIV/durOZWjqVrvA1eUndjsrEhJ2x96tBIyWbnXTudkGoimhkNV338mklwzcAoqksiL/pPQGPa/6Cuc/CdZR6aM5VzEPxLQ8XGv11KN4yBcYiRUy76+oTjd7WJD8rSxrIkZ2ohSRQF3dngg2Ve7XWggPfQwgtAN85aoPNF0Znte3xhagRuc6BKkVFzIKNsZq+Qv5fbgHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Ik19RlWThkxGmWJXckUHuCIKRJg+GQPRPfqEDCNP3axXrB3/7rYnjK6VrClu2FqteCT4EDlA+ASQX8Jgmtf3k1l4Ox6zjy+UW63RO+4A01kdNlxWZ+zYUGXJ0ce6ke0hkfUe23DOyQamAb6Y+uK7S49qz1VIta1mgjeKe+aNwl+yKPSJKghxTMsSkHdKuy08ZdE+PBm/YDdNOOD/S5sN5WNC5mHBP/WqituIylo7R/sw0MzMcTtnipP0qQUp/wVYNKq0mNsZ76EAokDIItwLVbbHrIjEGdR//m5n0dhsWcnn1gtV9lCweyl0HMWL9YeQSaqXk+QccWZugUafb6ECIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dqh1q4lpz4dfiVNw4eZHWs1rBj0wjCSaZWOHto+Vh3RZRIN5X6e/LcLFsFs3XQyPgM2DP8I9MmVH3BhSu5HjLTQcS0/M4YysncQ4RVKA4TWrElkzLsGWP7UiPyxXRE61TztRU5Swhfy0uSiTCHoqbwNoeS9pUWov/cKHF72yTtU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0277.namprd04.prod.outlook.com (2603:10b6:404:1a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:45:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:45:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 6/7] ata: libata: blacklist FUA support for known buggy
 drives
Thread-Topic: [PATCH v6 6/7] ata: libata: blacklist FUA support for known
 buggy drives
Thread-Index: AQHY8zbm6ygKah5N8UaF/XDJQwAzUa40pZQA
Date:   Tue, 8 Nov 2022 07:45:00 +0000
Message-ID: <ad714839-7cbd-ab60-30f1-8535bd564236@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-7-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0277:EE_
x-ms-office365-filtering-correlation-id: 185b25a6-ca6d-4698-3631-08dac15d23f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+J0DKiDipivgzPTYP5AUl1Dc7adDDGf7UYFiRrsKpNPXa5PMC+bQviTlfpGWRaI7fLGJW1itoLhzihZDkjDaozmcStD/+hz17DgB5e6Y5oZDoux7mWUEhQPlvUjW1buC7GUfdvwA6d50Jz9262kuRVvG1BHo+GvCb3QnPnnWbmsQMRFH/t2bVt8nz4EpB7eVrhptRlTl7eHYfq/+O+8iN8Ny7Tr0Zdddj3d9QV6md3mT5eIcbOq6HuR4XBHXvGzYWwYX5cel6ljtfN9q4kGDNAGBSjMFrDXtRdmCIE15uZMEAV7iiMdjN/1U0sMQ1W5oafpWKd3AX2W5qAiNMbVnXOnS+6j41lt4E7La4Zm8xQzuvN//FRBYg7ldspmw0YP4TqFPHHaWe0knGWR2e9uukE4XdJ/CAMMw8eIsYBCEDcCFkSpPK6bcmB7Co2E3CBiHDZHk0Un1DxeP1l3GoT5kZLc+4Q4km9lNqtOxm9BktsOn0Ud8ig5a/Rfe3qem+8Agm1gw3g4bTB1z8Xs+834onc9QOHEGMRyE/Q2gWBFEcSHR9h+1XC5SNDfbkkvN2d6ObJ3Oyt08T+di44/7375xhcFJzu4WO3+B4Ymzli2vf4DMxqgg2hAuUVdX0TADS9SmvPjoDd33szbR/dFUQQzAgbydOckRNw+T/inY/uAi2MureZWrcEW/8GiK1bkDrgU4yoDDul8U3F9Vm8l/pD8kxnExqnQaIGzIFGBN1fXl18kTtO8m6cQTSdmg31u0s28+OfBYHqCRO8kfRcwazReCwzitSfOcsLhMiqACStLIiKedJwI0FYqHNWTHN/zWWRNdAuFRr0HrsgqUDdkyJmgyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199015)(558084003)(110136005)(316002)(2616005)(54906003)(4326008)(4270600006)(8936002)(5660300002)(41300700001)(91956017)(6506007)(66556008)(186003)(66946007)(36756003)(8676002)(64756008)(66476007)(76116006)(66446008)(122000001)(82960400001)(38070700005)(38100700002)(2906002)(19618925003)(6512007)(86362001)(31696002)(6486002)(31686004)(478600001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW01eGFPb3RoNTEyNlkxSStkNU9SUFJiM0FrZEt0WXFscGRydzlFelV2MVI1?=
 =?utf-8?B?bnVjbVh0ditiWVVWeWprWmdIMWRqYkdaNlArYjA0S2QxOGlxWXBtcVZHYVR6?=
 =?utf-8?B?UFNESlJoMnZLVWdFYUYwQjEvSjc3TUV1aGw4L3hDdlFsQTI4Y041aVAyeEZG?=
 =?utf-8?B?cUp2Nk51SXZzN3gzVWcybll6aGc2blFFUXlJMW1kZGx4RnN4SVBDZ2NqbWVN?=
 =?utf-8?B?NUh3WlBRT290TzBDZDZWM0syeHl6enN3WW40VnZob09TU1N2UTVRNGNZdFlT?=
 =?utf-8?B?YXhaci8vNEFpbVZ6YllGMHZZaUw1WEFkb1FRSDBnVm5pak9MeW95UXdhQ29V?=
 =?utf-8?B?YXQ5ckxWT0tPN2ZMd2E0U1VtSVlraW1vZUxjRXJwS1ZsVUxUYTg4Y2VrMjdV?=
 =?utf-8?B?aTU4RUFoQ0tMMGlXNWJJUUZmVVZYb2NxVGNKWk5NN0lXR3dTRzNhdmJZNjMr?=
 =?utf-8?B?Nm9SdHZlUHRwNUFIY0duT251cDEvSGgvdmxjSjFTVmNnbUxhNUNPa093d3lq?=
 =?utf-8?B?bkNKOTJYeHN6cGJZcTlVYUI2QWI0OWNWcHJYQUROMDdRRCt3VzFLa2tma0Er?=
 =?utf-8?B?Ty9mTjdPalhWSzBpeVhwdG5XNll0R0hkY1RBQ0VTN01IMXR5bW90MXp5L0k1?=
 =?utf-8?B?U01vVUV4ZWJKaC9BTzEwSXZXanlOekphYUdkczVaWWk4NDAwTGFhQjFGMi9z?=
 =?utf-8?B?VmRQaGFmb2ZlRTZ1NHVFT0ZWVWVBOHlKVmk0WTNVMGZNSjVpOTN5TnppdjQ3?=
 =?utf-8?B?NS9jcVE3cDJZVGwwYStlOHRuZ1MwKzRWbEtrTUM2UlB2Umk5R3psbFNRbEox?=
 =?utf-8?B?SVF1a01GMGpZQlFpeEtFU0pwSTFCZk9mYldPTllVRDhjQXl6bFZ0VXFoNFNl?=
 =?utf-8?B?L2Fmb0RFUUhYQnY3ZU5Eejc2alhreEN4aTUvV1dlRksvYVVoWmJwU2pMRXJD?=
 =?utf-8?B?WnpTbEVHakwrNHV4TFlkSk9UdDV5aGYzSndvR2hteUMyYzZxczFBY0lSZW45?=
 =?utf-8?B?SGlQK2hDVTk0UDdIMkZsRzhBQ2hLL2lCTXl3Yk1JQnhhcmtsQURuKzRQWjNz?=
 =?utf-8?B?bnVTczM5TmpoaXVlcFM2a2prQWduMnRZVEJ4V2JuVXQ0RHJqZ1k5NUdiRElz?=
 =?utf-8?B?RWFPRkRNdEVwZnVoRjdxTFczSUhjVmlRcXphUTdJN1JDdlhlTnd0bmFhZFBR?=
 =?utf-8?B?dzQ3Q2JnTmE1OWR6QnJ0dmJRUDd4a0RpZlRhUjFtZklWNnV4cEVCVWVka2FQ?=
 =?utf-8?B?KzhlVDNrb05ibjFxczFaTUF4M2VCUlFPWWp4VmQ1SEVRbXpDWWlRV0JmTjhq?=
 =?utf-8?B?V2lzTGhsOXpZRE0zTjEraXZadktXUmoxU1NiSXFxRUt1VnFjbTlnTitVWk5q?=
 =?utf-8?B?TGdweFhLZ1VPdm42eEtsMjB3ZnBOQVFjQk9BeUlxcndTNEQxVWpXVFRDRThw?=
 =?utf-8?B?aGJmZm84QkRaeDZXQXc4NnM2VlJ1WG1MMFlST1pWT2ZNWU1JTHRndmVKNjVS?=
 =?utf-8?B?eVYwZzJYZ1RNcncwNyswcm9adEQ1ZzNGV2NhREpnblpaZWJJVGRCa1hqR2Zr?=
 =?utf-8?B?SFRFOWhPTXVybURpQ0ZrKzB4bGVhaHU0WkgzR1lhREVsdnh4emxDVW0zaExO?=
 =?utf-8?B?TW9YemZwRFNkbjJjZnk0T0sxeFJYODlSd0hhbE5sQ0R6QmJPRlJSRElUV3Ra?=
 =?utf-8?B?RHc0ZGtEd2VMS1FyNTJ0VUR6ajBGSi9CaVcxWmJOYkt4OTBQdWxhR0VxLzlY?=
 =?utf-8?B?Slh6aE9BZThVWlB1V2VYRDhraXN5VEVnWUpVd1V4dUtEK0oyRDV0WFFEank4?=
 =?utf-8?B?YTA1dzFOSko1c0ViMFhhK1poWWJ1VzdBMEhoYTVlNW96RHpRQUxTR0EzYzVE?=
 =?utf-8?B?VzhjVnBuUG1uRGFDQzRkNDF0UFpJOVBvemFqUWU2M09mUlZTaGZ1T0VPVFlk?=
 =?utf-8?B?UllyZ1RRNDkwdXJEU3orcTFKQTRQZi9LN25YQ3JVRTl2RjBWb1BFNW5jdTdS?=
 =?utf-8?B?UC9Mb3pnYjhjNzhOcVJUZ2YwdXhpdTJGdkFGOG9iSTlGZUYxOFVWUkhXR29Y?=
 =?utf-8?B?bnZ5QW9OWEVZZmRBOU54aFQzUjBqQ2VmYWtNOFBIOUx6MFhRRzdlWGdGeUph?=
 =?utf-8?B?S1pnUHRkZnBNWGhmLzZlNHlSelVHcGkwZFJSQXZ5blprQWZTbEdESDMzZEZT?=
 =?utf-8?B?dGVKU0pkbUljTW1aSEVUZE5hUGpEQ2duZU55QzBUeDB6L1hmdE9XU2p5MmI3?=
 =?utf-8?B?alBtL0dEdi9Zcjh5SUpyVjdXS1Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CEBDFA7F2219488260BC353E9C81B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185b25a6-ca6d-4698-3631-08dac15d23f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:45:00.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXVDo4CriQXpd3nbKd9fBoObzA1Y0uLZ3bJxShPTzi+s2YOIUImVG+a6jTnr4ei86SkGNZI7wfoVJWBYFtc8G/6hsyEOW2nMr/t9GS7OhUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0277
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
