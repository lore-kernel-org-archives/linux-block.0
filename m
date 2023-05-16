Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57590C77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 12:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjEPMIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjEPMIM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 08:08:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C978C469A
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684238891; x=1715774891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IknBvslCJ9G2T/y/asQ+A7dk5VrGhcLGVyfSOQOeR59YCOByVw6URYRR
   88Mi5EVBHC5f60fNzVAonQyhRn5yVrvxq4wFsUome7fjTDp2ZYRznZ5q4
   PGSKBogWfb9O/dNKtzCDGNNHENww9hbM7rBnWJf/6+luLv1ubjc0izIcu
   AnHyBXFDvkWNo1e9mCZa9/h+Ao08L8SF+yCswjobd6TauiuDGpe+2ZxM0
   ekxJjoiXaAlmNkOpA45u+fZ1JQ2BrRkqLexTXcnekjG/lJawwW4gIpF92
   k3yhj7Tp2S7FI6s6uZF9iU55llIc8Uy3MQRDtMMkr6msRnadnbzxYOl8i
   g==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="230827172"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 20:08:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4vDueKxtzD6SsAHnTcX5HAUDXA6KlwUpIoIVoeZxRx/fTF9qpu1afq6n4OoJEnvLlQSbdrtIFVrudV9NvFdmctZOxTh2D3lS62MErtrHMf5VV5nb0eGNmGeL98eBE32hBf+P7C6+oUMglUfqVVAG9Yby2MzKo1b/4qR6OgDFCtpqHArq21N5qRVXyLSt1lUqyq9e6mV16xAU9jiQZAapGZHJsiCa0jJIS3HkpzRiCVRD7YddBddCS+YQKmtAlMCzpl/NNmveC5Q1SQE3e2EmPdK/6s8YuXhZ+NM/nxu5On8BH4ni0cxCNyiwe0bF4hgtAqKskg+v0nXhen9IkmMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LX66AAZC8bApHBghShHlccFyWMvd4V4lfJ5u9GdBNSHJidaEvT9KTKsY8IFCCacFh7chCdtu8r55zJQLiKQneR4v3MFM081cwA2w92EOxbhdqmxZoNIU2uHlIc5HrzHFZ4c5Hpvbd3O/Iv92Z1O6j/jYUMOkld+42q/C1Rp/cn30vSFVMI9mcxv5BgTDBbDav2Ifsn5MGD36Aq37WHbyUXAURPG8WDV7JDe0GHH8+08ypfgt3D+ZLizoV50Ps9T5Qlzzy7gF+IUgu2HsdtzMwOaMyStnWFl4B7aREei4q0Fjh/9SL/J8biw+U9SO7dkHT2V28gMTjhdTSxy77B7Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=u9pyqFxTYHF7p6/8SUnzCqnYoq58JS436sXLHHmg1yyRN0e3rj6v0K9ymttG6nmKGsfn5xnqIYar83lg3XoLrYa/+GLQgSPjCfDzXxB5W+NB0M/EFTW1d0cqI30JINQOG4ufB5I2cP0sbEqv2AUgzWVhFK11QLKqXbVbaeBfl/Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6432.namprd04.prod.outlook.com (2603:10b6:208:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 12:08:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:08:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jinyoung Choi <j-young.choi@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/8] block: move the bi_size overflow check in
 __bio_try_merge_page
Thread-Topic: [PATCH 5/8] block: move the bi_size overflow check in
 __bio_try_merge_page
Thread-Index: AQHZhNcwMZtDAgG4H0q9QXNQd0lUTK9c1HYA
Date:   Tue, 16 May 2023 12:08:07 +0000
Message-ID: <202dcd51-c680-0eab-dbef-d40d105898aa@wdc.com>
References: <20230512133901.1053543-1-hch@lst.de>
 <20230512133901.1053543-6-hch@lst.de>
In-Reply-To: <20230512133901.1053543-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6432:EE_
x-ms-office365-filtering-correlation-id: 6ce74453-6614-401f-5a63-08db560635e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6p0Vy6GTGFegdBDY+XqbNZFQceuSzJY4rsLv75rMR9eMPhVwcuKKaU8E+6X5gkASfNDR7fbSKH1odR1sG5bAPfizQEjaYd17TclZpgbcRTEEQ8sc5qTJSvDZHn6m86wxPa/NAF1MnK002A8VrO6CaiNPFN5tOeDq8vvVmkCTFpGtSy7wwL8sGStZxVgmoauyH/iyB28v12sQxpJfzCtHPssHEHS19ijnGb7GniO9i+EChzmXPLh6fl0TUixM++nbVQGT/8duj31FloC/SFLXWHoZaRSJw3C3GY5HWeDd1kv5Fxs2AyKl2HTKFgmem1B0+KsvRXipP7/ucFRQJ0suaDGTYJRy2nvlBMzabohfIqMzrNoGofTBnnCnu3E6ciUa7f50zj+AMJA/psvbmmgjhr5UhC6cN1qUhpxcr9puYaCfzHCfAWjM0lRbuwbAv3SUWDCi3ruVYZDMBRQjZRwZyjJv4GkOzK9+FgEfw3TOoZnngLKIjJmRCRPKiAgHWc8lPB+eRu8luK4ykLOUKvzvZIQN5DR4US98acDSb62jpvuN2+dg6jYUPROq+6ckuM83rbPsEto3EoGAMjyP40F3U5rmx9Vme+o2ktlTeEzckHcHO2sBP57hG7ngO1A14XEyV0yEqs6B4hWO1e94TjQdJKMJ3DKKjHg4v7+h9/5d4TcFLZNwrUVeNnK+YwULgclt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(4326008)(54906003)(110136005)(478600001)(31686004)(66476007)(66446008)(64756008)(66946007)(91956017)(316002)(66556008)(76116006)(6486002)(5660300002)(41300700001)(71200400001)(86362001)(31696002)(36756003)(122000001)(8676002)(38100700002)(19618925003)(8936002)(186003)(6512007)(6506007)(26005)(82960400001)(4270600006)(2906002)(38070700005)(558084003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTUzS001dS9sNE9KdzBvU3hGNDQycS8xelNJOGJrcGVlbFQxRVhsVGxUOW1Y?=
 =?utf-8?B?NG1DKzVNMk9zUmx3TlNGRnhRdVNRdHFRd2F0VTRsZDlqWlo1bElOc1hiS2Jm?=
 =?utf-8?B?UWt3cTI3T0svR0t3dit1K0tPdzJHM2J4eDBIN1diRnRxRitVY21LV3ZTdjZI?=
 =?utf-8?B?a3g5aEtXaTFlb3RhM1g4WVgzTEx3ZVIrdU4wTDFpQUZVTDQzNXc3NHNyVXNE?=
 =?utf-8?B?RTROLzh6NkZIY2ZSMlF1WHNlUXhsL2R1ZTZ6OUc1cG1rcW9TVUR3OEtkWmdq?=
 =?utf-8?B?R1dIaUZzM2hacWZLLzNoeGU3MENMMW5yK1NHY2hYYVh2VHhza1lrV0NYSm9I?=
 =?utf-8?B?NzBQNDRveFFObGFPaGU0UEwwOFl5WUFiRllES3BJOFN0cUx3SEdhRDJtNWl6?=
 =?utf-8?B?MDdoTDh5THVDMXFRMW1BemRiWGF0U2NHcnlTKzhFZnVzaGVia2MzVmRJdmda?=
 =?utf-8?B?dUtrdmwzT21hTnlMQVVLcGJKNjVUWWx0N2dtanI5MTlXcFVaRmpnRFFPM3la?=
 =?utf-8?B?Vk14UUhqR0tpcWpuL3AyWnlpaWJRZGlRbWpsQ3ljVWtIV00vNTRZMUNZNytx?=
 =?utf-8?B?YXl4VHdIejU0MFIxMVQ5bFVKN2tmTHZMTmdJcVJKZmRWb1ZmeXBXQVlrK21t?=
 =?utf-8?B?MGJYM0xIc2kzTjFkWHRTVVJNNmJXWENrcXZnSHYwcDZISUZIZHdZZE1QVkU2?=
 =?utf-8?B?bnJRL0NoNnhQdnV5QVlOeHJmd0pIbVpSaENxVlRxaXBOVWFuaDlqQ0pGVEQ3?=
 =?utf-8?B?b0RPQWFuM3FxejVHRERxM2Eyem9tdC9RU1V4NmZJZHRybTI5dnd5N1V1NWky?=
 =?utf-8?B?ZmQ4ckdycTVFL1pwMnVtZ3BGVElXRjFCbEtTaXc1NXdjV3FqSk1kSUZjekJt?=
 =?utf-8?B?M2hCbW56Rll5RW0zVkZDQ0M5bUNTTmlOSnVWbTdYb2xDSVFabXpQTkRDL0lj?=
 =?utf-8?B?V2pRb2RoMkorN3ZvQnpjUXFDMVhEOWI5azg2a3d1bkFiYjVxdDU5UUk1U2lj?=
 =?utf-8?B?dFBHekNid0VNYjhCb3BySVFsbERERkduSmFxYy8xMW4xVW16SWY3L3FQUTVD?=
 =?utf-8?B?bFp5bHdzWGNGaXcxYUtJRDNmNmZiQzNaeGlUd1ZPTU9QT052ZHFJMEJJZUdq?=
 =?utf-8?B?K0pnaVNwUzFUazFmMnVGTUlqMUpJdWttUEpRdS9nQzFpZi9PQmRKTGxGSFFP?=
 =?utf-8?B?cysxSHlnWUt4MU0wRTc3NUtOVFNQd0xQdUc5bUdYT1BRZ1VBeHlYbWp5SW5i?=
 =?utf-8?B?cEdhb2FvNDVqTXZ0dEVsTFpuN1VlVkZaV1E0YUo2NURPT3NQSE1JZ1JHMExw?=
 =?utf-8?B?ZTdwUGFRbjlGS3pPU1ZCQ0pob1lXNVZDbFFodER2ei94ZGJtMEwzd0lVUzZW?=
 =?utf-8?B?N3ZxT0ZpYnIvcXB1RkNTVVV0Y2hwTmtxb0FkTUY1akUxd0R4Tk1xWkhva0U4?=
 =?utf-8?B?ajVkQ2U4ZFlIZVYwUXBuZDVZS2xWS1Bnc3NOdkZZVEZCR1pUSDdPcFE4enpL?=
 =?utf-8?B?U1VQbFJWYkxUakxrZjNramRMMzc4UjAwWHFqT3UyakFEbElsQk5ueUlVY1ZT?=
 =?utf-8?B?NExUZFh1RmtYc0J0Q2YvOUVORTF6ZjlxRnV2cTdOajhMNkdqbENiTllUU2pY?=
 =?utf-8?B?bXEvdnBXbFpoRXFIOVhGOVNNNE1WdVhlbFQvcSt5aVprSE90ZkdHeVlrNXVO?=
 =?utf-8?B?dW5XV0ZOWm02elMzaTVvK2JrNTBqTkdpLzhLdWZCd3p5REI5ZkloRGFMQitJ?=
 =?utf-8?B?OWJpTDcrMGU5OEtDQ3ArNE5UZnBaN05NdThqTXVVNFZGTlpVempCQVRKVmk3?=
 =?utf-8?B?R1VUYWFkNFNIMTFVS2xMaFdBNEdiZ0MwOFIrbE1LVnM3dG1YZ2lTTjIzMno3?=
 =?utf-8?B?MUlwN0pjTFpaeUZjSCtsaUZ0TWpvTEFXT0hlaU5CYmNCeXBiaEo0V0lHT05t?=
 =?utf-8?B?Y1MreTU5dkFhRXpRNitkaHVldjlvVGIwNmdUYmpIWGVReDBpY2s5UjJrbkJ2?=
 =?utf-8?B?TkhKOUcvMXdIanF3MzRqZU1HN3hsdlJGdUsxSWx6UUx5bGFuY21xaUdZWm1Y?=
 =?utf-8?B?dFg1V3AwRGpvMndIOHFETUJWUHI4TlFtTjRNaHpsdVRVOWRBdHk3SXdERVZW?=
 =?utf-8?B?T0RtelovTUFvOTZqRlFPdTczbytLcVp1VzhxVkRsdytzSVI3dm1PR28wMmZ3?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5B914A82F6B25448869C99922908D11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 03Xv0QJ5Iub4TJ+O89vEeDIzieEylMdrmWFks0IR9pva0pniFCd99lvpTyQZjXwwUkioTrrVhtgvtMDLRtqrwZD1QFkmj36BBmDcSdMo/+DSNuXq56Aa6rPv3WXRIgtPJ3529MRaktwnAL/4tIEImGq/Byx9w5/l6EKJOI66cu8utGNlLohRsF87B1cW6rDy0TL8lg7XyEWtf/9/koQbliAXPiyDVyxyIMO/nEsrur9Pcb/18iNwbLWbW6Yl5MvCQRYswF6KW/y0Jp4Dx+xxRy2LITGtkUtVDjbxlk03ZSiCRHImVPXtQ9lh5k4+tFlSo7GVSrGtxjyql7hgnfxryI/ApLfAVvS0QmodmzWrb06Nf5LGNI0VQddEgS7dSxEN6V7OiZGBhA9iKFSJB22C6bKfwg2ZSciTgfobshrESEZwnhM650+ZtxMZT/Ao6G5HEos1SU7zxNcnCdc5nmPEUR8pYtoHpEDPxgtVZnmUp4ochBVMWRonAIErkVofRluZl0YUHRLhdAXjWIXVauEB6Tjnyyg1oRWxI+0TAh+8r6iQy0riaumpDpAR1olm+pmgkH/uqPuvy6TzMeAcSQqiANxjxemJkjfdeh4D83QSGryHS0etttHf8HIHs5wz/hZ3wkWpfhcOkiShp6rzgfXZNTJs5p+07OOuP89wsabn+/oheo6X7kC1EiOP7+0gyjIY6fMy40ySY4EFRvSA/qkFThMbQSzvr7cTCGFo4yuHVw/Z6j+pkzIzPN3+LYSiI7oS0pGpHC3al6Y2ZUpCWlKhpsjb06HNqf2hoitofR5CrjiyvmCh9A6k/XmW9rKWW4+Fbgjy0U6Dy3sw7Zo6we9JPk8fIRKHDkSPSAGwO5QPfZ4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce74453-6614-401f-5a63-08db560635e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:08:07.6620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DO/qzGj12zMJDGbPi8bcHiwyYK/hBYeRwrhu/yGT1EiGHV754T9US9WVgckomel/ylZ7DsMHnEUP5zz+1e5C2DqgGbABoChhaOWKQYqLhq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6432
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
