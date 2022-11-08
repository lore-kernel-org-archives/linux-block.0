Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD16C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 07:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiKHHnH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiKHHmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 02:42:43 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A9E40447;
        Mon,  7 Nov 2022 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667893346; x=1699429346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=dx9Ui2e7dTuTzpeaFR0F1xcwMPuSGx9cG+DESAR3z1eR2hljTb0kI7KF
   hrOaobHPtfIT923nMUVWk2YwNqzchCcophcVps7qvo3xy3iG41XFbbhC0
   nh8KEEd58Nfcp9/Xp6ybOPWZ7y3dI3kTXChP5cb4GmtnC7tan6eRAqlzu
   kX0xED2LJ1iK21LntT2/hMB4YWXHEqFnd553M1RMV9Fb91CoDp0NkbbNy
   bYZHKYZS+0EfL8xQhsDw7SNOB8LtDDEZ6sL10JlRSDarm4Q2tPtcnO4TO
   hy34m3P/W8wDU80bsgZxtng7OICR1D9b5HgEgp+JJ4hnf8Aj2XExpmh37
   g==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="320074677"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 15:42:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0wCKK1CFtMGDqGWLYO/BNhM9ta8CJzSbWXcw4LkBQBza4XLpMbAzNDO2+1FxzQ/d/bybLGFBku+ZLakPaWibspNiBkgE0a3JHXMQ2rx24t+ueYGGaFmZh0VSKp/fQ4zrWYlEwtjpRURlMNTt5A5WMLF4Se+96TVyzSkhE2XXXjbl7efbexXc0l6/YgbIgK/mVBu/qjxjD+QzxjDp+2n148hvz0CiLSQikBR/AiZab4ntL718Z+NJfo9rv0NejQE3jdVZQtuIN37LZYbCZKx4vKXqnQ4ntarf6DrgHhhGC26vCWWPsEsT38TeAcZLAHsWQTUeGczP+zbAJ1FXS4cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=U6UNSGtWzZVykZYoNWPU2U9uyPc1imKIcskkBcZtK4D8yxg4b4WY8tYAHu1RICQAJ3XvnhXVbDoGcUu+BvLOQEdg9/xNZOdDxPI9wxxGfpahJEJQvDDV9vYJt2jQRls2uM3ZmD/Y52FdgJO9HnAYR7/ET9rAO3uK/o1LcmUPtB0ICos7s7oxk5tbCNuJpUTT/IMTyiyrQzO3rtiL1Ao8qgoyOXCqCk6RsmukB1yKkJkXf4YNlxDcrc98i9vBYXytYHr3J+oijZCyrzSPBD9+pD911SnyFAtpXu3k4li9/FXFLjrfyXkI7HaJBtZ22vzCL3xvlWc28oOi+DQPEEA2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nLgSackkAPJouMwmVM7sj8LGpfppGz0vkMz/VSkD/1eSWGq6uYqbI65/UUDbf8rXPiKDFY2uUFVaNe4wahT/+QACzVDRUnEB21WIOGYmUZp/fg+Tkl/W3/EIeuOhFx1igsEo0UK4+Tx0Xv8ELNhmLLRka5/mzcHgp5niorI717A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6960.namprd04.prod.outlook.com (2603:10b6:208:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 07:42:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 07:42:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 4/7] ata: libata: cleanup fua support detection
Thread-Topic: [PATCH v6 4/7] ata: libata: cleanup fua support detection
Thread-Index: AQHY8zbKYv4ZajA+okanwl4MwI8PHq40pNeA
Date:   Tue, 8 Nov 2022 07:42:22 +0000
Message-ID: <cbf5ba22-50ee-f2f4-489e-f0f79310584c@wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6960:EE_
x-ms-office365-filtering-correlation-id: 369faf42-efbe-48c0-d84e-08dac15cc5c3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Kr7Cy02sf6t4j7495IevM5ToTKUs2J6wEXy7V2MeXRVW2PlH4Twt75E5h8EVG3SPevSOt1CKF2AluL8N8uZijKSs8kvevoM7IZ+bJqfar6mVAiPUNeQAE6G7OVztoQB+vWhAtngbOPFsCFhQ0bLhNVHxVqqeXtIB3MomN4Axa6AtvEeVNwQ1HozNOU754E92kDuxAoAcS8rQbUcB45ZpOW9CMymmMgwA2z+NV7j7ruFn48We9QvfscnaWlt9ZmwrlwO96c3s4wQPqIo/KZTbXLWxHxR3vyCuQ38s+sCMdIMYG/0ms9hvz0Gh/+Bk2stshFZkKXkUqHKWr+Va4B6OgiFJjvrMwHMjMoF0YCBXIs+byNn9XL6Y9OubmivbnkaPsrOtFeQIA68sMd2hL5od6Q7Y+t3Pb7pVh/7E6nhyL3CvP2pNQ8WLa7fWuanT0eNPS6KAG4Q/Ag+ckr4Qo+DDa1VuVWF+RkCYTb71Qx3bnc7Zf5oDE8L20+j0qtcQhu7nUtufSrk/xUv1WqOEu6LAPiYaxSR82ehmwlPY9T7LEdYePQpYk8dJzUsC54kZkTvOcA8duh0WSx6fTtsqXtx4V7vV2f8/P4d1AhJuehR/HazXAM/M8BZFOjrt/BWOALGS50i7+twZb90McLIXjDLP2boJAfHlusFmhtr3+BQZiB0+HWxirC2B9o1nYqmPsDy7cYl5h4O8Sgc/4Oq9gRBi4dNDAaCnLYmlQ3Lpu8RA/rQqlaMhd6iVm3CSq08vuqFrjU9WKg7cejE23YeYsrt0b4VG53f1vy6FMo+5d2enYQQz9PhtuEHw8/92my9iwucpjMpD5MS/2nBDRRUa3MNcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199015)(186003)(4270600006)(2906002)(6512007)(6506007)(122000001)(2616005)(19618925003)(110136005)(71200400001)(54906003)(478600001)(6486002)(38100700002)(41300700001)(5660300002)(316002)(76116006)(8936002)(91956017)(4326008)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(36756003)(558084003)(38070700005)(82960400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RwYys0NVpYZXd1NWx4Yy9CM0l2bHFXbDhNQzhzakkzZXRFdDRGWDkxVVFm?=
 =?utf-8?B?TVFiM245dVdLeW81UEpZR0dsQ2Z5MW5qNExVRmIrQSt5ZUhraGRGL2Y1UkVD?=
 =?utf-8?B?Tjd4UmdaOFl3LzJhUUlaZURUYkZ0VWtRdzJmT1dsMjZleURNV0xyRWRHa1Fh?=
 =?utf-8?B?NStwMjhQNXVQVU1wWmlZdkVuS3FPMkNXSHFUTGZ6RFZTSUdnd2hpZjhxd3lU?=
 =?utf-8?B?S2UxYS9vcFltV3N3ZHgvcHVxbTJwL0FFY1RLc0xLUkZRbjN4SGdVNjVZWHZ4?=
 =?utf-8?B?eGdVdGVDbTk5dko2Uk9kT2hnVmxLblRxOFlia1d4NlZHeUErdmRIL3UxZFBj?=
 =?utf-8?B?SmROcWV2ekJvVkQvYmNobURsQVZIWTd0dVFDdjJqTzB1VEtjQk5EenRNalNu?=
 =?utf-8?B?Z2hjK09EbzIwL1JpN1hYMWl4U0Y1Zy9hL3lDdllxdTVlL3Y1WWF1dWx2WWo2?=
 =?utf-8?B?TGtBNEFMeDh2WVh2SytGeUp3V0R5VEUxaGl4a281Q3YrNjFuTGgxeklNbkVs?=
 =?utf-8?B?WmNYWkdWRklmMkVDWExKTHlvSEkrVklyRVR4NUdPVXowVEdaRk5KZW9VaFEy?=
 =?utf-8?B?TEptb0FReXNUYnBSVVpDUldzSkZtM1VOdXB4NE91SHhWWUxMWmR4NitFMHFP?=
 =?utf-8?B?UlpTeHZ3RmJpQmNuRmo4dTczL2ttR2JXUDhiSGJyV21KSWtVdkJUck5iZ2VC?=
 =?utf-8?B?SHZGbm5BN3pEZjE0ejZQVTFJbXM1a0FNZi8zejlSSStOYTFpUTYwOWM0d1kr?=
 =?utf-8?B?a2ZwSmt6RGZlR24rQWFCZkxCTkVEWUUxM2l5dmtlVDB2dGZhbHBlWlJZbUJU?=
 =?utf-8?B?amZXNmZ1cWYyQzBZeUQ2TGhYZUtFTEZpQXpCU29GZzViaXE1VVdBZytZVUlV?=
 =?utf-8?B?WXZNTWtXbWlHSWN1NXZRK0dYL2tkRjVTRy9DcDMycEFoS1lGbUc1SUNFMDVy?=
 =?utf-8?B?NmlSMkxSaitsNkExVmIvbWtraUdjU2FoMVlIQit6SVZMNHRCQUkrWTQ3dFI3?=
 =?utf-8?B?aVVpNXFiOGtWS3NwUjcrYVp0anJOT2M3MkI5b3pBRUNacmJFd3BENkJUYzF2?=
 =?utf-8?B?VjFHa1ZqZ1JibzJSRnFQNjJnQ3M4TVZrY05xQUVhdm0yVEpxWlZKOVI3M0c4?=
 =?utf-8?B?U3JRR1VxSTZhazFwWG5xSkdtRnJHSGJUQkJZYVVxUnN1VWtlSjJ3bGhFQ1k4?=
 =?utf-8?B?OHliakoyTmNWVEdjUzZsTmRzTElvU3M3SzBNWmJsaXVJTHJKSmFXNXBIMnh5?=
 =?utf-8?B?NnhDTVY2RFVVSVJrMDJYM2o5cmk2ei9LcXY0N0VXRzc2ZER6TUF1bVo5MWpT?=
 =?utf-8?B?Qyttd1BTQitMWE5OV0xqcVR6SGdCcHc3ZUsyRTFiOStYQWdjUGdSU00veDRD?=
 =?utf-8?B?V1Mvb0Z6d016SVJZeU5IYmxtMGQrOEFMSVRYaDVZMTJBSDRuY3M2VzJadjBB?=
 =?utf-8?B?SHNUQTg0VlJ3Tm5MVVZWbDk3dlJyRldEeFg4Y25CQnJxRlZqUWVKc0MzTGZq?=
 =?utf-8?B?TmJSSzY4V3drWTdQNFBOV3lmV2lHK0VESGFGYkNVV2d5ZWZUaURDbGdBbC9O?=
 =?utf-8?B?RkNzWTlnN1o3OUwvUG9hZlVUK0FiRlZiSDlsZ1B6K283VEZkM3A2d3UxV0ha?=
 =?utf-8?B?U2QvUFRpdzl1cSthRXRTS0FHeXJYQnBrbmM4bTdQOXRyNlpQdjVmSmRJRUdB?=
 =?utf-8?B?Sm40cThtbnNOd1BhWjNUNnB1MisxOVBWUno2WWdaZU5UbFJFY280VVVuV0FD?=
 =?utf-8?B?cXdMMlluTlJZZnAwMzF4YWNubkdYUVVLV2JrMWszRnE5OUNEWUM1bVNDdzc5?=
 =?utf-8?B?eG9Ucm5LUVdKZC9KR3NtL0xpU2dFYkpqOXpLMFhYeEc5SFBWbHNIUzZTc251?=
 =?utf-8?B?NmVTamJZektpMzFqWit3M0o5UVhVSkxoZUlvUTJSWkRvdVJ6b3k0NDJkTVdH?=
 =?utf-8?B?aFl0TGwvVEs5RlVMVmFRdm5kVURVTnM0ZVpGSEVmMmpTUkdTZHFRQ3dXZmxF?=
 =?utf-8?B?MU1YMmwyU1Z0VjlPOHJmdVhlbGhYNHA0NW5vZ1g2S2RadENmcTdZV0FMSDRs?=
 =?utf-8?B?Umw1MlpNOExGZTdvbWRMeFArU05sMEZabElVdWVIMkhDQURvZWxRVXgxanlk?=
 =?utf-8?B?U2lDZDdPOXFZeWJtT1lIOVAwUTVzQ3VsZDZWQWNuTlV6QmUzQmR5MFJrL1pM?=
 =?utf-8?B?dEZud3M1a3RPSUdoeEppVFNPd2JoaTlEMW9uWW14M25nVjBaWEZQY3VaOWVs?=
 =?utf-8?B?SVc0WmdKTzBqSUJzV0pvSk1ncmx3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <344E46BC1DF8F945BABF635615362855@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369faf42-efbe-48c0-d84e-08dac15cc5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 07:42:22.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTmugB4RWofQdwAJEIH7pEpwayljs8p7Gb+TOl/LxBHkbvgfNpC5RxUoGjvngF8qFE54ovUN5iNaVUc9CLtA1rko1Q4A8GvfP0+YPQYLBXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6960
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
