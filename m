Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00EC77B7F
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 12:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEPMBS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEPMBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 08:01:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707330F6
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684238477; x=1715774477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lATdYdTuPzQpSey8KWSn9XNdqhp8vif9Nb2H8Js7HjQxVe8ZeC4nYeA9
   LxccK2fOqNS9EO1aY03vJF5VB9/BM/cq9JGad/8wUNP2iqUTB1KkijEY1
   BVsfoyG7BZJy20bde+WSvxQm41crLQ0P4S3u+JteGbUKhHSu3cMfrur+p
   4g7PwAlbmrjWfDMStHKqH4/BdRhIUNjWUXFki9I0htxXs61MITZep3B40
   g20EcdIgClk+A7FQjLPiX7uZK8Ot/rge/8/oDxNXRFPd8hVquOUeb7C+O
   kp3Gb6j9UZp1QqwW2COAdPETtLhJFcEjRi+2hqWDHN4cbT/xchI2kjbOe
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="230826704"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 20:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dewbItZmyFLhjFYWsKj+Hr0UsNG4UmnPUm2aVljiTP/+9xB3eMOmhIJ7gXoyh7sBa58UIp0WpjSRLsFN4G05dfBqMX871HEuG66oBvkyu29RZYTvcRra7XNsmzEO+4psrkxhaqcCjx4o7DeqJyRtYoBMcajHNSupDK+ivLUMArKg63ulisRrxA9Q5sOLney8adgFHrmCVcHZ/jUT4ACQttiKw46UqoSRcSy/lC1NSLjVR/Icjy8x3AmBfWRSrpaDrzWWFt90v0zQq292p2uFtoqRCxVdZWDCn4N1CsURwu/Eh3n8gaTQGZNsaLMKP8OUHzbRUfDUSjWtN+lrw3Am7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PeZaZN0XipV3+xPft+kvsQnFi+3TpBER9t9ze4sRAaJOAhsKCO99xO9pnxZxPWZ2Mr3Rrvag+f8X/vRj87+JXqQdW37dACenOb6HPup7nb46ZKNHHn9exAuTGU0vVMQW0sLu2ompBMZpnG0T2RkzQEKfE9LTnVbzV3cKrxEXcgQopgGR/gPROVsyIOaN2mdvazhJnBKvoMWHRj/EScGZydeJwtaFJuLINbXS4YIPg6BrKb4J6EqY/BElgnIkzDl1vLjLqXpYmy1pcXBfe42l0YWP8T5XMqYU1xG+WEJNg2mK771jVunpOX6LQle6v1mv1YF83wklDRWMu9g28E5ZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nglZP3HY6LT9aw69cSJbMuu3qiAJOVJf2/i19GtVEXZUMaVmf3Qraq+StKe4aSELDJNfbIEiYsxTXGy0Q30aJqGPTLzNIZfxj5Sr+poiFyGWnCxZc/24QPvKnqqCXneI6YxiT1PVopSXbrQCXI1HiQf1QmwjWAxKUjscdJsvC8w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by IA0PR04MB8889.namprd04.prod.outlook.com (2603:10b6:208:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:01:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 12:01:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jinyoung Choi <j-young.choi@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/8] block: move the BIO_CLONED checks out of
 __bio_try_merge_page
Thread-Topic: [PATCH 3/8] block: move the BIO_CLONED checks out of
 __bio_try_merge_page
Thread-Index: AQHZhNcvnSswWnGgnUeyEpNum70T1a9c0oWA
Date:   Tue, 16 May 2023 12:01:10 +0000
Message-ID: <60466153-dfc9-09c6-2640-59fb36eef29a@wdc.com>
References: <20230512133901.1053543-1-hch@lst.de>
 <20230512133901.1053543-4-hch@lst.de>
In-Reply-To: <20230512133901.1053543-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|IA0PR04MB8889:EE_
x-ms-office365-filtering-correlation-id: dcdd8a3f-36f0-4b5e-f1c8-08db56053d0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSmm0UKnQ/2stVtVCQNDTqJcCHFeqrZS0tLc2tGPs2aCt5dEwaaj6HMCTetMiUhNWb+R+vf5/9+NfFQpm6MGujFsRhLrTNaXZ9tJOGCXeCfdFWP7CUceMx4MGZ/kNjgWAjo++R+TxBrUoJdXLnqBACKoM32+XDGix3TVFT1gKWOqYzZfppNbqb8p7BapWPqkYEdf/HeIYyKqTNf0R24UkvDYOzOYRNBLJmucWL3nnMcBK302EH+4WYF9Q7dy+Wc7ba6IG6aSWriEITMQvT7M3IdfA3t/LBEIo42Z8O+tCYNWY5NaVfcJxzbBxiPi43zPLvyhkTLv6NKFD9yIbE5oNaF8r0r4uVLb5tGYItQdKdkTnfIdfx52lMCluHkgKVCso5D84jjQ4yyvUvwAsm5exLBADRd9TRWbqdhxClhrPmk6dhD80+35SXTA9PFEti/9mOz0y/C/GmdrUeFwGwFOYhuatf19Crs84wmcNcu45VGbYAEAKOtMmpvFx5+xNBKiVWIfPuf4463nvxHocMKDXJiT/PBHhb//G4j7TCtlBm13WMmO8qOZxR8Yz055uaMJK+lIGFTMGCB86C5I8GEX6r5g5GIk09pKKYB094hyDH63tKXIm9IUnKS8HRkCgfkxFz9nZyVEZWUvXbh4TqFHp4AyfWxMBN3Q/odNyB5KB7foD6WsLfPooNgrLwlb5fwb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(36756003)(38070700005)(558084003)(86362001)(31696002)(6486002)(110136005)(54906003)(316002)(91956017)(76116006)(66556008)(66476007)(66446008)(66946007)(4326008)(64756008)(478600001)(71200400001)(19618925003)(8936002)(8676002)(5660300002)(41300700001)(2906002)(38100700002)(122000001)(82960400001)(4270600006)(2616005)(6506007)(186003)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHhuaVB0TVNuNGtCNVE2RjBteFgxMEcyMnl4aEVYTkZXWWlBVWJyc1ZReURn?=
 =?utf-8?B?U05VbHBFak05KzJRSlFvaHBibDFORHZYQ0RWWFNMSjBkMVEvMnNmU3JQRUkv?=
 =?utf-8?B?YWhVR2ZpNVQ3RmVqcms5UWhUUkFZbmQwZjRpNEV5aFdML1pTRzB2V0pERDFh?=
 =?utf-8?B?S2VMZ3FQUGFuOUVIU3VSbjg4V2hIMG83d1FTYlI2V3JhaFlRR1l2UUNDZk9C?=
 =?utf-8?B?NVQ3OGpjN21DWThIYUZqb0ZPeVl0V01WNHByaXdqYllxekFpamlicTViUDZ0?=
 =?utf-8?B?MUxGZDFrNFhPdEhrYjVra3lHdFhreWdYb21kd1ErZVVyV0EzR2ZDMVErQnJx?=
 =?utf-8?B?K0ZocEkzRjMyYlFNcTRPZ1pkZFhBNWRTVzBEQ0lxMEk5NE9hTUY2RlZUWkFV?=
 =?utf-8?B?K0NZNlo4U3VHNlVSYVpCWDVwdC84aFZnNitYaHNJTGFjSXlaVnFmUHhrUlcy?=
 =?utf-8?B?Q29JTlg4VDh5Y3NKbWdOOWl2cittSGd3MlUvd2kxelRLY3VmTUxldEl3aVhC?=
 =?utf-8?B?d0hORTZaNVI4K0lOT1dtVnUyaEZaQ1V1Yi9md2FsRllqeFRmbGViUHJNUnVJ?=
 =?utf-8?B?c3VxQzZBTGVJWkZ0enN5MWFsS3NBUkx0bXpIUks3TWd5bGExUmlUMS9CU0dT?=
 =?utf-8?B?NS8ydzdmSVFpSzVLbk5oT2oxbGdrdFF5UERjTEVMTkZIOFBoeGlBQ0pNeFp5?=
 =?utf-8?B?Y1MvSldpZ0o2UG0ycHNNSC9nNnlydFdHL1h4VGRMd3BhYlhPRk9qRDVUSFlF?=
 =?utf-8?B?RzhIRVBKRkErNUlWK1RSYUhZTlVPRkJRZW1vTWhNcmpCTkloYUdkc3p1N0dh?=
 =?utf-8?B?eUVBdzdMUmFmSURvTFRCdUZHWHA1QW13UUdtMmtKMzdnVlIyVTUzU1hCMy9y?=
 =?utf-8?B?bFF6cmdVNkxGWVF4b0x5OGxYUDQwdlNndDJnYzBtbEdvL2JzTVBjcFNlT3hy?=
 =?utf-8?B?SGZSTzNnRmY2VFlaalJ2RllhdERaZzdZTk9HSFhaLzRMZ3JrcXN3Yjh1Wmt6?=
 =?utf-8?B?Uy9YbXNXY2FLeW14WWpsZ3hNd3IzWVJmSVkwb2ljcjYwa1V0cENQSnd3Skc4?=
 =?utf-8?B?aDA0QXliSTg3cVpiRS9zZ2NDOWdHTGoyRW8yT3hjMjV3dUwvVXI1c1pMTFVD?=
 =?utf-8?B?REVsTzBua3lQTGo5N3ZjdlYxaGdZVmE4WVdjOXRvNVI2YXFMbXhFMUlycWw5?=
 =?utf-8?B?b3dZZ3NTeUFsMjR2OG9VME5rcUxITVBiZUF1RkxxeDdwQmFHd0NXUmFzMG5s?=
 =?utf-8?B?RnpXN2JCcFdrRE1uTXRoa0pKbFBwb3pLN0FpTmQ1NytoUkoyWGJwS0YwVkdp?=
 =?utf-8?B?Tk1EcU96NzZRMWp4SGJjSjllVGFIcytZQ09BRGVxS2NFSWtSMWhxRm1HNmxx?=
 =?utf-8?B?UjF5b1hNQXRjM3p3Mkh3LzM0V1U3WGJFODhkU01DaHVIMENGTXA4ODlNa0Ny?=
 =?utf-8?B?L2xQUkhZT1A4cDBEQlE4YW9HV2tTWHR1WkJCWCtjbEQ1NjlNdHhkN0tRWjZz?=
 =?utf-8?B?R1RCTXVKMlBTdGdoU1NmN005Y0xhdzVtcUxRUEEyOG85ZTBNWjNBanBEZFpB?=
 =?utf-8?B?OWtROWFtZG5yRGVid0ZncmpPNFJpcGRmMktJdUFVUUNNVVZteTRzc1JWMXN3?=
 =?utf-8?B?TzV3dTcvV0lCV1UwbkVKZ2MzVDZRcUJkU2JzbWkxQTE3ZWxvVURLNXh1OERR?=
 =?utf-8?B?WDFLRzVwTGQ3VGNWdWUzOHZWZWhraEduelErMy9md21Wa1A1ZndsRE1qWXBy?=
 =?utf-8?B?YTBtaktLS1Q4YzJSUy9pQk5WekZ5SS9RcGdjT2JvcC9IdlpiVUdGa0ZWUWV2?=
 =?utf-8?B?b2lpOHBBZzhtSTJWNkk5eDh5SzNsS0F2eTRlT3dtMjJkMlRlL3l4Wm9nRUpv?=
 =?utf-8?B?djJQV3J0b1JzNW82K1FKR0FMN3Q0WHNFbnF6K0FDSWtXWUZwcHl0RFNHTUJO?=
 =?utf-8?B?aEErUDFOdzI5a2tUK0dsL01HNzVJQTFNaEtWLzVDVVUwWExQeWx6NU5GWTBK?=
 =?utf-8?B?cDJTdUZIRzd6Q25lMjVpSktpQSsraUtRandnaTdDV1BDQU8rd28xVlhMSGxD?=
 =?utf-8?B?aEZwT3lRMFk3S3M5TGptMDZLWkdTc2FLbEk1Um14UVNjdGwySHRiRE5qRHhV?=
 =?utf-8?B?ekJ3ZkxRV1pQeGlhcXB0RGx5QmFENUMxVU96THFTZWtuVnF1UXZDcW5yNm82?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5935C8191495FA4FA7C871CECC7BE07A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vm3rGzcKueMDFQc8dJLXk1jvXqBrvosraAayslCaCEL7kAFBX++zcl1SK7pr9hz6fH4VU4LGhzG84oWvw2cRo887zmj5m1B56XjL64CfPKten/mLWxvpfya3cEirQyWeE1sQ99qN3hBCEFrfHDp544oDPuOZLvfIlfHpZ+LL2vH0HnlxzrFz6+caxGCSJa87sVA0DrModxJ3CfefNAdCgKEwVR0SA5b47kYTiIYwR86nstVxXevkwsIRf2iZEdVNrewbJjhCjZqZkVhYdg+Okma0ccCQokMXBns1Febrzsa/2aYjl7dSHyRm1wtm90DUc4A7BgqWh0CfijAMREM1Ii6uqSh81eGn/5FMx/H3zCeWNwBHhC1F3+yMSdVeiDF/edaCDwoW8ak9OIWkLDXKCK8hfVCrWL5aQEEmJivPuC77gg544/8Mi2YljKeuoJnoeCUNclyI5ozlnL5nPVZLuNkl0cRRzzN8LIjypNyFleBbGXQbGfNUV0qzPPZVzv1DUoNsW96UVUf6DqTgM5oC+zUU9gER7dB2hgCGc4tV/4c0+XUe7hkmvUQDxl06N0gp86zvPj96qGSpDqrqopOO13y24N1qRvWEvz+auEwzwSCmdjlcKSSKEzbIk1NVjFh/uQ7wMeiWKcFEo8DiIBUU2jmX1nmsZFsXqOjjTrScmNR6EzpKW9yjPlj5zLOiuya4LQsZRwDMkjnBQoXmPZCU0RRgH5u96LgIug1aEkKU0oOeqCErtYh4pjhHRPzJaOXft23dsp+9UxC77G2GVYs7DhGhknGYYIj6/JOZ3yMwMV+Fwf5Fn314DZ6pbsOMhdCPv+6PhdgG+eUGHlCzLzrn0DYLO99pYxMjZ70in3B9iz8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdd8a3f-36f0-4b5e-f1c8-08db56053d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 12:01:10.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hikcbwuGRbX5L9mN4jfvPGdfAFwpbtqdVsO0n1Ypf/nzEPE7u3VlNN5dVCsaMrclkb2JgtXvLX6g4V7HGIdtYfQ6HdVKGbPmIRDNrbmgmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8889
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
