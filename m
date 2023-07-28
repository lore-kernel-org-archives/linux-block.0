Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E2C001DE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjG1LMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjG1LMC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:12:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC2FC
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542718; x=1722078718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FwkBfaGT8UmdbHjIGwpqigUm/3ipvtZoyjwDLCysN+w=;
  b=U8WV8EYn7z6/7GhvdfxKNF0UgftZKm+vIM0fILvMzay+ajWlul0Ov1UG
   E5OqZSZgwBuibb75v0c/SJGgABeCz19yJS/d+494C9q5KsMPNU7/0emCF
   OaArMW3lgjH4sHZCTnoupxY6FTAbnneIFBQrMSdOzPloJ0EncvUxxk5Pe
   Vk/mAKZWVKh7B+AH8fY0RGPvr32e9ClDBnosIkbQsgZn6itUWAKjnDa2Q
   DHBHuRCJAAXthjKNGWUhktDe8GdchTBmr4x+SZurFLF/AWJIyWMONgyFk
   cgGsniINv4IrMmGIGjMTKmDzjL/2hRGq5lYzmTTO9uSf6I5x1ejsrAayH
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="344481397"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:11:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADaLBmbWkhDw3lhei7F8pdHlAabqdhAH+2DUTwBBTrwE6moyFbXyYQV3NvVr/yPho7uCvQdTyTEjURLjwk2kTtua1eRSXhXTHs1/nCwycSkqSeo2I2claPmtGdcnvzFqALIhXSY/T2nPb+haiViwPQ5ejRQA5gVGMuKvfVnV+zsdCdG+gHHXxBE5wpmgCtP7AECSpH6glCtVduWCa+z1/1lqqH2rKETyQelVaOW7MSnvnZbRDvtCeHo+ASIB/Kxa30typ0lzSYNLELIXOxSKpnCe8yhBfMTaDl1Mc8WwgeuYBQw++pMrkE+C2guTlnV1A0YCnALyBOvmPOLavrILuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwkBfaGT8UmdbHjIGwpqigUm/3ipvtZoyjwDLCysN+w=;
 b=HIdtbHvsfA2/tA8/R2VdW1JE4JRX6gqz2lDX+xgRoe9aQqLwUjvcVLeGJc1CY4VcRr6zAxhxoJt667WT7q/dI0SNnCD1FkGhFBvn5+O0uEYD+i/xay9/lyaKEbDdwLVrMaKGu+1HSkHw/tJm8pd46w2iBeS0TkFpt3ypbpJDsPjP5cRQZDGgQUo5NyvVGg6YkBKX/LhufXnqKP2jxIjgvUB/2K7PD8XaDDXAD2VwKQtZjk0/qAPJJzYZSekZ4+TjlehQF6zp4c+UJEizXayWUsq6tEaWlag2eSJMdlJ9r9qfgn95L7V6uNGUWUGASxjUdCSBjPm91j1tBRFuEOgRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwkBfaGT8UmdbHjIGwpqigUm/3ipvtZoyjwDLCysN+w=;
 b=qeyeYl1hok5bGE1I7DeAmw6b/D9VdH5BvRPTuBlT/M1TGI0lZigpZjJdlHoQqo0+ZEKC1zy979JZ9gtM2rIIvsf3atHesZRjtmSszPrHxVwGoNT6OSBKTlmdciMwzSOQxdlOXXM0/J+kMDS+Xc9oEKwPI2d0MJyDvwmq/6rOp80=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7455.namprd04.prod.outlook.com (2603:10b6:a03:293::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 11:11:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 11:11:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 0/4] clarify confusions in blktests contributions
Thread-Topic: [PATCH blktests 0/4] clarify confusions in blktests
 contributions
Thread-Index: AQHZwUO2EaVbRrmB40m+GRuZWMPOeq/PBhuA
Date:   Fri, 28 Jul 2023 11:11:55 +0000
Message-ID: <0235cb46-1e22-0f1f-52d6-8f8b8e46bd3a@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7455:EE_
x-ms-office365-filtering-correlation-id: 2ffe1481-95aa-4b27-ebe6-08db8f5b741d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BV5C19cptu+hydPiGOxqWzQ7IMGcX+TUL3Gm6X+iiP6Z8T0F6swgbo/s1C7H0sbatGnpY+3ZbHENNoFHROohJZHO4Dk2BUXg4aKqwPH/Ztnb0JsVs8mjRYKL8r9HFRTYoviyOykmMz8l7tgpwXsNRFegChPfzu7rQvQXzkUGEMMbZ+0zWeRINd3vBc9F7dzcPZSP34KrKPiIhU83N1tqTthGqaf9L8ujmXJk6QPjUb2beaIJHwUN5qPU4D4Wtqw/TXmH7Qh7tupDGb3w3RcUgELyBLLN105YembQQCZRVojBFkJXteLxaxCjIC4b14LRHn9ZiMnQ19T0ioKsjNAfUS8ybiEHerP87T1w45u5iTbELflEcvvHu6jIDU+a2/SuHmoRvDttkIDDlsBNUDXg1yMjgO7Ut1FIfZ4F3A3nsZeTj+TEh3bmG7/oY8RbvLN31lmoZTAW+cfTZxDWhc8F/YGgrt46yyBbN3hShP3U94c5zzJH0tSjBtlGhdm9Qkk7Vld4qmVYSrNMNA9GsCa9GJuH59OLRgQIKjAh/5Q/RlEZmDmcbu0RTDPU/gNlX6C6Cd0JrV6iC0lTzW5V3jyMLIz93he8N3r1uV5uzrrrbZmu8wUgaRkI/udLYhfKCBdLbX2WUiGp5xVK28Nxl0tveq8iCKCMHuqPzfeIRS9x72NV6/ltWxigAeHMG3QQtPOa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(31686004)(66899021)(6512007)(6486002)(54906003)(110136005)(478600001)(83380400001)(36756003)(31696002)(86362001)(38070700005)(122000001)(4744005)(66476007)(66446008)(71200400001)(66556008)(186003)(53546011)(6506007)(2616005)(82960400001)(38100700002)(2906002)(4326008)(66946007)(91956017)(316002)(76116006)(8936002)(41300700001)(8676002)(64756008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVQxT0FjQjhnRW5xVVIxNzVxUzNxWjczVHZ0SnhzTFVHZmdFODJIb25CSStI?=
 =?utf-8?B?VmxXMHFVbzNEb2ovcW15Q2JmK1JPZWJpSGlpeWhFRGJUNHdQWGhCM1BKbGJk?=
 =?utf-8?B?RjdFckZwSUtmRGF5eFlMaUJjRndRSjRIL3ptWStxRnNMcktUSDB6RDF2ZTBM?=
 =?utf-8?B?THRNdWE3ZzhtOHk3a0RUSzAyNVNwaEZiYy9yQzdkQzdTK2lXbHF4dEZ6c0lW?=
 =?utf-8?B?dHRxTXZEd215MGlnQW9ja08xYTl2eWs4WGNYd2pFQkRUczFLRjVIK3BYM1NL?=
 =?utf-8?B?MWlIRWdJN1RCS1NjUnM1KytIeEpOSXZJR2F2TFpZaS9NVGFZOEtHY1kxQTEy?=
 =?utf-8?B?UVRUUUlkOU0zd2NuaVFlcjhrMkhPZk9FU2grZ1gxc25KSDI2c1VRaEhwalNF?=
 =?utf-8?B?clBGdGg3RVRqdFJDeXVETUltdmN6UzhKeEkyZzl5Y2s0dHlTRExtdlJCdUh6?=
 =?utf-8?B?SUp0NkJVaHZIcnFHMGJkaEFxamFpQVFnVGlnMU5Vd0I2a2QxbnRQU1FWaVZH?=
 =?utf-8?B?aUFzOFlNbEtMR2Zlc0N5enU4bm9BWnZybG1Dd0tXc2xHanhJdzZkbVVaRlk4?=
 =?utf-8?B?SHVxOVN5eW8yMGY5bkp6Y0NnRWJrWEVuQ1pPMjBEU1crNnRzK09pckZOeFdn?=
 =?utf-8?B?L0RhMGdvc25PRS9XSmR0MURGaCt6MklpNjZoWlBhbG9qUUh5Q2V2VXpYNzFZ?=
 =?utf-8?B?U3JkZmpqVXppYzExNi84QjRldXdLVHBEMy9MdFd2Z1kxYXhyTjBqQUJJUkRl?=
 =?utf-8?B?RFhSTDBiTlhpY1JZREpxRjBXYnkybEluN1BUY3A0QWVGR1pUN3NPLy9NL1VR?=
 =?utf-8?B?SmVSbEhQMmxxekt6emhyZlFmcGRQMWM2T1ZQd1dNQkRZaDVuNjYva3NnRXpj?=
 =?utf-8?B?OFlhMW9ORDY3enFjU1pDMVd6dzhNbzI0cVFyTVhxankycmZaRTRWb0VrRHZh?=
 =?utf-8?B?RDBKMUhxc3Q1eldFWWovczBLWnh0NDdFckJVcGNEdGowQ2pzbmEvcm1iN01G?=
 =?utf-8?B?RkdJM2QrZnVvK2Z1cmttbkZaQzMxemEzL3ZlZnBDYmxJdXYyVjlMU1pGbkw5?=
 =?utf-8?B?MUFiY2pMTENGU0duVXN2REtaNTZ2NllHY1pDOW8wTjA0NHZhbllFaFhxbXRt?=
 =?utf-8?B?Ni9UNGxLUnAyNGtDMmpUbXBDcVVhMEhMRFR5YWxUTVZ2YXJac2p5V3g4QUtx?=
 =?utf-8?B?cGpHMFp3MkttTmMwdWJnT2N0eUNhUzhYb3Q0ZWdMcUxrOVFaTjI2MWJrZ2lD?=
 =?utf-8?B?L1BjSVVxSWtxYjJFVUpuQmpPS0UxQ3hqZUhETWxtb2lxMkdKWFp2eVpBa21X?=
 =?utf-8?B?N3V4ZDE3RXlOT25odkxLQnllMUtMSVBxeThBSzRWcTVqU0kwZmY3Y2E3SVFX?=
 =?utf-8?B?d1g0MzF4c2M4OE4yVko3QzlSckpwZkI4enNhMytmSUh2b3R5U01IcDFUNFRp?=
 =?utf-8?B?bVg4N1JHTHFMb1c4bXdCVEF6amJDV1Y1a2RsejlpSXpndGNOdjh6RjBxVitk?=
 =?utf-8?B?K0RnY3o2VHpyTmJodVpObGk3cGNubmhqaXp5Q1d2OHVySVpna0xQWmRVbHY2?=
 =?utf-8?B?NmZLbW5lNzFnMUZST1d4MFF6K3hBZFNiclZiUTJmVktGL29seTFwSG1VMkc3?=
 =?utf-8?B?VVQ5YjhQeDNSVlN6VFk1N3c5NGNlaWpYSG9oak4xS0t6VENMV3dobUdQelVn?=
 =?utf-8?B?UEF5Y0NpbHAwaFVDaTVCelRYMC80NXpWdndrVFR4NEhqNjFPbEZubVZKRUtv?=
 =?utf-8?B?a0drR1g5RzZJaDZDWmhVWFp5RjNHczNzeW0zZVhvbUtNSUhZYzF0a24xckZs?=
 =?utf-8?B?UW10KzBiWFFzYUdtUlZTeTcrV1RmNDhNZ0Y0WnB3RXpkNW9hMTd4MXJabmVF?=
 =?utf-8?B?Mjl3MlpCdjVVdDVNUUZ5bWJURVNlOFRuZ01OSGFsczZ2S2hXSEZENmJxSWQw?=
 =?utf-8?B?NWxod2tybWU0bmo0NjF1TmJTM0grNWlNQTQwUEgxKzZ3QnVRb3F3bkM3UmNm?=
 =?utf-8?B?OVc2a2lMd1l6VHZ1UFBKRDJ6UkRBR3NZVXpMVUlPUldkOHdMa2tQaGVGb2Rv?=
 =?utf-8?B?Nk4rR25KWWdNQm1NN3lOZ2JKcG9sQUR1SHlKYmMwUjVveHNRVG15YW5nT3l5?=
 =?utf-8?B?S2FGYjRGNTdTTjA2eDZsOXFBb2dYdEl4aXB6cFFGd2pIdVBwZ0FHOHNxdW5J?=
 =?utf-8?B?T0tIV2ppWHJhMTJRY3FmRTFRTVRPMVAvUURPeEsybXZFTEJsM214b2cySzBD?=
 =?utf-8?B?bXJlbC9JK2U3SWt3c00vRFBvMW5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21AECD56099F2642A6A71E8E7D7B6B56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9A9RT+mH+3eQC19O0HV/mRx1WqnCxiY7mbUS84eE91ZljjReva+PUeJmBFc3hCgbXViVtHt0vYeMORUWk3UzEalXyDpNaTykz6Qe5m7CiW2MvYCjqXDp+Nr/fDDcG9BFdJuCHzIairIOll/FvYm3P66c/GGL+bn0mu1MM3SOdhtxSorxJhHe7i/gYg5jDnIX/ADSJB+TXP1+DMaTDPRMp4E+u6TKyVv0bjeRsMvdbfN9hkaY/Dj5nWT3On6Ynm8FAtGrghvylnU4zZePGEpzyzfNDtRXDGa/QYquBelKNFMzCAvst3iOn3wO3UVh3aKo8t6z8V0QAWd4G227XtiwLRjzJhje3bXMq9oHXqzHeM+GmulAJVULXSy4TA3xw45nfY1m4sT1gBVEPy4A7LUpY9LAwVwmXaJ0bZerWrFlvumrLut0x4EWSDV0qhBT62un1uSahxxsGeuKfNj4q6b+prkF1VQTFOWpjpURJ/TrcdxhdRCV2HwqjzaCGI4N6aaV/sRH149yXdCRT26otccBujcC/24AVTr0QWG344evANFOvuINY0X07jvMmU5qPZ3wWO/mhgtxCppEJfYbTnfFHuB5CLdHlRPv54pC+vbnHdLMrbS3ZTZ+XmFmq47fgMN3FqigbscCMQS+PSV8O7XH6yygHzU2t52pei43/oN2ekianv1LCAonAvkE84l/ndmMGrpy9MW7tiTWpvbTUwZvkG7srJXB6gVBzrLBKGHKK92cuaLcWx0XuVpSH6uUPjM7E5rVuPFpc/8oyJxDF89nQHOZfJPEdAK8q6UQmQQBKYX5DvfRliNElyZsH9mwZr9MGMLWEJ/2yMdhGL0HZKsYCFwNwOQ5Nzfrzm/J4BS0vAM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffe1481-95aa-4b27-ebe6-08db8f5b741d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 11:11:55.5563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hTYdLDKPjtquMYJxosokUTKUYjn2UpopoQGF6810llbOF4HidRA2GgNUHY+R1ZoNLmCL7w6LcDoddM0AUWfYrXDk5aN85JrxXyMXUJDGHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7455
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMjguMDcuMjMgMTM6MDcsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBJIGhlYXIg
c29tZSBjb25mdXNpb25zIGZyb20gYmxrdGVzdHMgY29udHJpYnV0b3JzLiBUaGlzIHNlcmllcyB0
cnkgdG8gYWRkcmVzcw0KPiB0aGVtIGJhc2VkIG9uIG15IHRob3VnaHRzLiBDb21tZW50cyB3aWxs
IGJlIHdlbGNvbWVkLg0KPg0KPiBTaGluJ2ljaGlybyBLYXdhc2FraSAoNCk6DQo+ICAgIG5ldzog
ZG9uJ3QgbWFuZGF0ZSBkb3VibGUgc3F1YXJlIGJyYWNrZXRzDQo+ICAgIFJFQURNRTogZGVzY3Jp
YmUgd2hhdCAnLi9uZXcnIHNjcmlwdCBkb2N1bWVudHMNCj4gICAgQ09OVFJJQlVUSU5HLCBSRUFE
TUU6IHJlY29tbWVuZCBwYXRjaCBwb3N0IGZvciBjb250cmlidXRpb25zDQo+ICAgIFJFQURNRTog
Y2xhcmlmeSBtb3RpdmF0aW9ucyB0byBhZGQgbmV3IHRlc3QgY2FzZXMNCj4NCj4gICBDT05UUklC
VVRJTkcubWQgfCAxNCArKysrKysrKy0tLS0tLQ0KPiAgIFJFQURNRS5tZCAgICAgICB8IDE1ICsr
KysrKysrKysrKystLQ0KPiAgIG5ldyAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPg0KQXBhcnQgZnJv
bSB0aGUgZ3JhbW1hciBmaXggaW4gcGF0Y2ggMi4NCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
