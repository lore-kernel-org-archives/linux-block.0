Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 03:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiDTEAF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:00:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8D2A265
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 20:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJqDUKo3cc0DsQicAKpGKe+I/BCM/owPboXG3iA+t2juoaqYWe3WfH/hZWknIQPnC5FYS6EdzjzYjIoeZ2p/U8gc0kmMeLlv/7BWFFhqIzEoT6AKOfG3jl7iwOJtsv18A73r3NCBAjUKnv1pCf07me0f1ZuiGWRgAac0OVtl9W6t6LFfFNI/+3m4QLbKPpqRaFGwyUB79oQVCIek9m21Fwu5F37yrUSDIVZuiJUBotXxZEJFIMA4j08kbRC5YQjahR0KVt8A/RVhQRSSKBnIMc8nvtFhEQlhHaIrTXJi7sfF72gdjL/ElRHCddM0nShRCyJ9+I8JbyniNEwA8tA1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhsKDLSVQ7ng8/dKh/HarXx46NQbnC+LKR0r6Xn1Sjw=;
 b=HIXwj59Blc9bhoh0OB9I4ga7y5nedzsYMW4eNedXPB4whNo5ogZqnRV2/Wu9lf/3P8BKqKWLg2n1hwUcmpX2etuFhKofQMctUT5rXKvrwxaegut8h0OfakSs2OzVz4hpDGEfNOP2E6MEeAw+i9uDDDtUoWoqWF20CxapJTAlf8mOS/lwW9EL3CKU87LcqoLvf5CZrmq4cu+LdgxKGVvVWTfSh5bTprbIFo651+eiF4NdDMN5Lr9JnPT0HTH5iKrhYRXRN3eBEeEBBFE61TJkSIqP7SJMzGADhXDwJ/KwxLxatMwVzDP9TEU9hTMvWcXflswyEZ7oYN7dZ46ntB/23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhsKDLSVQ7ng8/dKh/HarXx46NQbnC+LKR0r6Xn1Sjw=;
 b=M6RLcjWpYQKK4uwo8mERHduPneonQE34p35eRJQCYd3jklF9oCdm/MAiIqjtLetIIS8AowRr8E79sw/Wl/xPSQ0a65xad9Evvkbef7404m8soobEcFBFUD1PrXNPVdh4pH7Xu3wY42wZ5uGGg+b16G6Jffjy3nR+hgL2QVKvrGTB4VGDTbiKisbWAmylcsKv98pKJGuXj/NdyLYmCod9nTfCYZmrmQIkG78ZLVljabRKOzBXkpckNRr2QpDcrsIB40oiAKkrEmiY2CWzYu+SvOWcI0zREI7b5/UToUFlF+uiOd2KoESLG3g/bgt8HTaLKkLMo635lvIRm96tZD8iXw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3942.namprd12.prod.outlook.com (2603:10b6:610:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:57:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 03:57:18 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 3/4] block: null_blk: Cleanup messages
Thread-Topic: [PATCH v2 3/4] block: null_blk: Cleanup messages
Thread-Index: AQHYVFHOc51iTYi4qUSejLMc7MpOhaz4LNCA
Date:   Wed, 20 Apr 2022 03:57:17 +0000
Message-ID: <8413d847-fbdb-b209-1062-88439b24ccc4@nvidia.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-4-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420005718.3780004-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d467275-db95-43a9-4f89-08da2281dd0a
x-ms-traffictypediagnostic: CH2PR12MB3942:EE_
x-microsoft-antispam-prvs: <CH2PR12MB3942202E3E5FF6B683CF06F2A3F59@CH2PR12MB3942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1lxwWc7/6ev/95nMCpheUDgCYzQ5cD7em3NO6LlWj3droF1MZy9GJ4YZAifDUIMmB8SMvDjvd0ZB/p0vh28tmMhRBk71Y+MetPq4cUEzzo6TxWfOxuirEtmJ2iHt3gqydfxTX6PH8D+p762a4qOxP247kE7TzDGa7++4xuwNw9IkzAOZrgyEd/dHDTjit2P1/6JrXbWYf8OI/r+Pce0GLfC9MUFJdzWoixXPRkSxtsr9Fn3NnnFQcr2T1xfPkE19yjan37fyKFrWip1Q9pu1d62bRZ6II/pQfnoSnkuV/p4RebjPlnxWmYjMazQPQ7Sxahy3oLcnpl2jnSTy1odubSpMnA8yoo4epaqNxxoR7HWz6O6z21z+WOyUcFcnh8DO3bSgKy5N1a3mDAEGtXAPmTw2sH8N4Zb3z66okuXol2ruBDhQSKxL4YIPsUfZ4FHGuiGDTK29UO1/ccAQQmGJZD3hpnrlhF23xemYFxWOe1J7CympraiFeCDadziQFTcAxjlfjcPXAcYkm9QUR6MwRM8aEwfxTjGtDDswwS00jhRyipK81wO45J9vdS8FK2ziw/3WGwq002+HJ/n7WkLXJOrivELXdtQwsYF7sfHtyBd4dP5zfKNFm8jUsdMZQ9wiLyHHcZ8RDY5iP6rEB6j/2iU7QDPLB6MqR5t0FNTJJcBDk4p6PN55iA55liWJywxn8U0cbdWXogRqLgog7ru6Up/VYCZ8tzkMuPtH0hEq550T44NOG3PbJeCPBarluaqaVK4Pv7OdE1F9JZfIKJ1L6PfsBq6rQWjkPDzI+VGQwA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(15650500001)(71200400001)(2616005)(4744005)(122000001)(186003)(31696002)(38100700002)(86362001)(91956017)(66446008)(508600001)(76116006)(8676002)(64756008)(38070700005)(83380400001)(66476007)(66946007)(66556008)(5660300002)(31686004)(316002)(6512007)(6486002)(6506007)(53546011)(110136005)(36756003)(4326008)(2906002)(8936002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmVMRUtBcm5lNlBBQXVySzF3QllXd2VJcjZaODArZldZYm1PTVFzRFg5NW9q?=
 =?utf-8?B?L1BSeXRQZCtPaVk3WGFHMDM0ZURDZWtrRk1TYk5raE1sRHEzdzc3RHBmNEFX?=
 =?utf-8?B?VTA2YmhCUkVMUyt6ay85Y21yRDlVYVprUjcxamxYYXM2WDVmTUhzQzNPT3or?=
 =?utf-8?B?clpnTWtVdnVMQ3lib1dzc3pTTUt3YktaWmdaakg0REprY21MM0huNVJPU0M5?=
 =?utf-8?B?K3RLVmw4b3NycUl3QUJKWjlEd3ZSS2VQY3hMUnBuZmtsSG5HUFB0dG1NVkZ1?=
 =?utf-8?B?amVlOFZQUUlvV1Jxd2lIa2I4MEZHbjJnQmtQaWNLVDR2ZHBIZVNJWXF3d08w?=
 =?utf-8?B?N3JZOGJ0SGdhaTlXWGM4V25hNUJla0xwRFdiaG05d2d3bnVmSVNlNTAwSyt1?=
 =?utf-8?B?Rk9tTDlDcXNrd2dDVEQ1bncyb09vTFk5bEhtN3dPUnJkZ0V0aGxBNjZBZ2dt?=
 =?utf-8?B?amgvN0tDMVRNbFlMVGxoVTRENDlQSGEwUVA2aUVUaUNKNmdzZHBqYS9PdGlN?=
 =?utf-8?B?WVpNNEZnYWdYeW1BVmMyWTY0WkI5UjRwSzNWalI3VmdKRDIybjNIN3JEWFFF?=
 =?utf-8?B?cjd1KzVpWUtaSFQ5aExFOW81bzJCc3RKblJtd2trbnNKdHBqemVsSnY3dFNm?=
 =?utf-8?B?c1pySnJEUjNyRG1YYzUxMCtndlVkdnhKTzJzeEs5RWpLZEU4Q0dnOEh3MnZh?=
 =?utf-8?B?aHZNdDFvR0cwOVA0VElmZnhLWDI1RzVwMlZMZTN4Tk9Kd1kwUVIvQzBzdUxu?=
 =?utf-8?B?czA5emVFbmlMYjY0MDNrYU5Uei9Bb3lGQTBodnZleWMyYWdyaU5oVGd4cWI5?=
 =?utf-8?B?VytPVGJQVTh5bkpoM2tOWERER3cwbm9XNUFRRmxNdmpaM2NkWjA1a1ZiWFJh?=
 =?utf-8?B?V3JzTFlQd0R4ODF4c3BJdG5wRFMrSTVVOEF3eHI4S0ZMQTRGYzlCcmJSL3hP?=
 =?utf-8?B?ajJzYzc3bTZuSitPQWpOcm5ETUhySDRWL3ZmcDBkWGFpLzh1Q0o1eFQ1aDRP?=
 =?utf-8?B?UlVUdVlLbmZBTFBrc3kwODdvNm1EYmRoRXJHVk9sOGFLLy9FWlB4Nk92S0NE?=
 =?utf-8?B?NmVYMGhnNzVSWHkrS2R1N1ZLdmhYcGx4Mnkra2pLMWJQRElWQi83VXlreFY2?=
 =?utf-8?B?bXJEVG45enpZbG80WThkZFBMY1VBdmYxeWhvKzh2dC9NZlJJK0dIRHJmTDhT?=
 =?utf-8?B?Y3Bicmc2cVQ3VFBpYkRpdFVuR1BUSDJhdGZtdmYydXJBWVZUaU52WGdqYzFQ?=
 =?utf-8?B?d2hieWV6ck0vWTdTOCszODUvTzNBOUdTaUdWY0NjSlErYVBJNjFEZ1ZYWWNO?=
 =?utf-8?B?YUUyNkhyQzZHam90YkhBOHNQc0JXRksxWm5USWtLTkIzMU5wZE1QREk0RmZX?=
 =?utf-8?B?bXlRWURtR1d5VTBtY3VNNVVleExaU2pKaEM5dmNrSU82c3JMdUNJblVWZU8y?=
 =?utf-8?B?bkpXdnFNaGgvOFZ0aEtCc1dYZHZZMFh3aGlHc0lXbVlWTkFDTVd3T1IyWEFG?=
 =?utf-8?B?U3dRNVk0a0ViRHhLb084bUZ4ZDNOUFozYUVrUVdNZ2JFT09Yc0htUUQxWWpr?=
 =?utf-8?B?eDN4WmE0NFhSb3Znb1I2L0JzQ05RckhCWWkxaVp3Um5vQmdhTTcxTVNtMDZE?=
 =?utf-8?B?NnUvTTBxcG1MTW9pZ29SZnpMSlNsMnR4QzM3Tm8vQnRheGNzL0ptZktrR3Mw?=
 =?utf-8?B?L3ZzaisyR3VadDNhSHoyeGk5V1UzSEJWVTFnZXdQVnVxWnZqRVNNSzdsNU1J?=
 =?utf-8?B?U1VPNDJnSGRYY09aN21FQytWZElEajArQitSMlZISnU4eGdZMGdGV1diaGQ5?=
 =?utf-8?B?YzZ0Vy9RTGl1Qm9NWVpRU2U4UW9HUVA3Wm5MNmE1OHpQNFUwNHptbloyTGt2?=
 =?utf-8?B?K0M1ZGpxOXdRTE1TMTdZQldZRnI2elJYdWNWOTBwd1RvbXpCSHkrdmhnWnhW?=
 =?utf-8?B?M0YvQ0Vocmg1YnlUT0ZxbWZzQUVVdGdndlJKZ1hqYmZBTUdPSXU0a0xISTF0?=
 =?utf-8?B?UmVmNHRrNWRFczBlUVAycVJCYkhFVFNqUVFiTDdWUS9WRDhLcFJRcGV5WGRm?=
 =?utf-8?B?bmJjUHdidHZCWlV3TnI2andDL3hTTUU4SUNGcTlldVhza3hCUEFXMFV1dWtp?=
 =?utf-8?B?OTN2MkxNOEljU2IrQTRMS3dNcmZoQTVRT3pIbGEzM2RBZHFONTFpNG5HaTZt?=
 =?utf-8?B?TEJQR1FsOWM4RzRrckhSWnhVaTF1RFc0TVdLeER6cVBFRFBpanM0TVFZL2ZB?=
 =?utf-8?B?RnNnM0tRQmVsNVdLUytUUURjQTdlMEEwVHE4K2xUallpOFNhVkttcFRXelZ4?=
 =?utf-8?B?dW90YzFWNEZqUFBtK21mSWgxbGZoTEd2OGs5QUpteDNGWk5jakJlRExyZ0Ix?=
 =?utf-8?Q?seKp0+Kd7MBx2pnsLfWu7yUFXXFVOqs/u4g5N4K2s9+gD?=
x-ms-exchange-antispam-messagedata-1: /u3VJwTe75MRPg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <81579593689023499EFB0E9E71986FD9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d467275-db95-43a9-4f89-08da2281dd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 03:57:17.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovmnxtjGCzuPZriFYWtirruwAbRPTeyrrK4nBQuWj/U1jrKuGwleeCKjK95WMdyo8dKLzwYMkZLI4v3zgjKecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3942
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOS8yMiAxNzo1NywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFVzZSB0aGUgcHJfZm10
KCkgbWFjcm8gdG8gcHJlZml4IGFsbCBudWxsX2JsayBwcl94eHgoKSBtZXNzYWdlcyB3aXRoDQo+
ICJudWxsX2JsazoiIHRvIGNsYXJpZnkgd2hpY2ggbW9kdWxlIGlzIHByaW50aW5nIHRoZSBtZXNz
YWdlcy4gQWxzbyBhZGQNCj4gYSBwcl9pbmZvKCkgbWVzc2FnZSBpbiBudWxsX2FkZF9kZXYoKSB0
byBwcmludCB0aGUgbmFtZSBvZiBhIG5ld2x5DQo+IGNyZWF0ZWQgZGlzay4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNv
bT4NCj4gLS0tDQoNCndoeSBub3QgWzFdIHRvIGtlZXAgI2RlZmluZSBwcl9mbXQgYXQgb25lIHBs
YWNlIGluIGhlYWRlciBmaWxlDQppbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIGl0IGluIHpvbmVkLmMg
bWFpbi5jICA/DQoNCmlycmVzcGVjdGl2ZSBvZiB0aGF0LCBsb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KWzFd
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL251bGxfYmxrLmggDQpiL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaA0KaW5kZXggNzhlYjU2YjBjYTU1Li40NTA4
NDlmYjMwMzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL251bGxfYmxrLmgN
CisrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsuaA0KQEAgLTE2Nyw0ICsxNjcs
OCBAQCBzdGF0aWMgaW5saW5lIHNpemVfdCBudWxsX3pvbmVfdmFsaWRfcmVhZF9sZW4oc3RydWN0
IA0KbnVsbGIgKm51bGxiLA0KICB9DQogICNkZWZpbmUgbnVsbF9yZXBvcnRfem9uZXMgICAgICBO
VUxMDQogICNlbmRpZiAvKiBDT05GSUdfQkxLX0RFVl9aT05FRCAqLw0KKw0KKyN1bmRlZiBwcl9m
bXQNCisjZGVmaW5lIHByX2ZtdChmbXQpICAgICJudWxsX2JsazogIiBmbXQNCisNCiAgI2VuZGlm
IC8qIF9fTlVMTF9CTEtfSCAqLw0KDQoNCg==
