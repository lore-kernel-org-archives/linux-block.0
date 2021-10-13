Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE84C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F066103C
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 04:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJMEXl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 00:23:41 -0400
Received: from mail-sn1anam02on2065.outbound.protection.outlook.com ([40.107.96.65]:25217
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbhJMEXk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 00:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXkUAWDxrhgLYebiDQrHnFNo7C/LKPgEdQLHFaWCqsnoGyRR+OtuzKmABctxPwqKo4D9ENTFSCCjXgkv5Jw0sr2sakGA/jLG5oNKJMFO5RRsEtSofEmlORoO9fpfyrTFicyPMl5bGo7FP6Ai+aiQASvR3RWBBGeVPl/G0qMIob7u8PG3RyEi6q0s5LNOHDfhMKoPhyTnRgESpUaEnLg1AmKEptWHK5Lm7CJ4ci4ISi5ytQcKP2x4nRs9SQSulEDTXJUQWRlICWo2sgvTZx18D5gV9wMQ2KdJHNd3+wg/0JqMb3bhDHQ/0E8Wd24nyDxhlBLgpgNK3VvJDqJx3kNhfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NRSysQg4Pr/2YQSHKOB0Ype8An5QBOtW55k5EWrIOA=;
 b=YlbRq/UQWTlS063qpo2XEu1IHMb1MhkguezZmEXcxHxyD0G04NJlA8iiGP81ykMu0SQRdFzx0TvbyIY4egWI9YlzjDyHxVKxwZLyshSpNjic7n+1ylJ7O+YOf0iIYghRnv0ItXQSLvIZ5dOwRx+dbJLdICdjjZJlJUblxI9+3cXBaKikHH6zfE9wOJTzAvYSmxi46d3jWpr1YxV+MjcbMIgwD24Os9KD4g15AzdIwFTH3PRlal3h8b2wlQGwlWmVtmZute7cRx8Ml3+GnK/787pgxopRXoQph13WDZzapMgHoIfbf0qrqK08nQMcVt/BoRG5RsM7QjXi3ARqBC0yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NRSysQg4Pr/2YQSHKOB0Ype8An5QBOtW55k5EWrIOA=;
 b=du05VGPS3c+L4eF/dO9u9H7GxBeO2k4kKOb2PTOt+haVYh0UTfgckrgeKBt+izqMrGAQ5DXiir1jcpBV0AYBIaAPRmi5wesEM7jKCEitIUMRCINh3bkcsf6C/aYVbKKqZepa45ccYLdnLmlizOhsNqfy0HGdtny1Qs9fJQckO6XGZ5J5taa0Xk9d8XC8QHgIhWSXrC/Rpb97MyuOfULbqfArGDckY2/Tplx2zTEZZ+aIPtx187K0SupRV+LUEgd8Utap2HOJafnoJ62dv9h+RLT6MFIoZjy4fl1s7Av1H0cN6ExRz8xnYfi7Fckp1shU1pA6vfLznkg5cM8rVTmnbw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 04:21:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 04:21:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 7/8] block: move bio_get_{first,last}_bvec out of bio.h
Thread-Topic: [PATCH 7/8] block: move bio_get_{first,last}_bvec out of bio.h
Thread-Index: AQHXv4X8G3wusDPIUUSQdnfT3YKTsavQVJaA
Date:   Wed, 13 Oct 2021 04:21:37 +0000
Message-ID: <ba0b4179-a01d-5fea-1935-69b21c67dc92@nvidia.com>
References: <20211012161804.991559-1-hch@lst.de>
 <20211012161804.991559-8-hch@lst.de>
In-Reply-To: <20211012161804.991559-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b3f3e50-7aaa-49e2-e160-08d98e00f2cb
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB43960A520BCF323846A86DB7A3B79@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:339;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yL4lxsK0Hq5yYy02YC1Eny1uOcqE4N132pysz4P1en+8pzVnWV/R9/Y+6qDwyt45E7K+v+XFCWbUN4ys2RDNqgHyMTsUXz7dtxSvenpND2E15yqL4ARtNZRTYUHdfAJk/s8pTAwv55WGD0Zy2YQV7NDExfs7FrNu08HaXMCXz6i6VhDzriaazoqAw15qRqlSqyHoCsOY7AFMVRH64pn9LU2jtz5YbJayGMobk9KvA94thzytO+f8yTwUkQZhiHMmfOCQKaimHAt/n1Ji3iyvnVBgxgOPpa79LUw8Qj2PsKUj30ggr+gHcceTJXZsutGv8PGcFbt+l3OQXsJQAc8fA3+P8KE16Kxo63jr52QGj8V+99llQ/+wnwgh4BOu9Q+qrKrL2XP5QWabmVbtrlRwM5RrGnZtsGjdD9zBRv3cNv5zLzTIVJ9jlzZyZ1mmC45ozIFq0XsahTb5N46WB8t2F5kzHwzYt1vsQ5xg2kD2gh08VhiIeKwNJaUtmKfIV6lJIT+FVPCwCY2jSg3Key/zZ4jwu4XOqhkD/my9Jbw6b5uvMP7LdWUDDUKIaUTpGocaz+oCky/BsAiCJs+dVC1dNJQ5U2aT0LP6oVGLMrHM0LwwzrTEGJ6FNWt/sb0VZrKn9x00+FU+nGMmbO85XkNpCIlt21rlUGSfJf+Pp5JrusSH/G4cIAeyZGu4xI3VT01M7t9v72FjEm9WVQuAVWoSSqpWjBwXE1pebqf7aLfKW95CnKunTmx1sGUtKF2EDVoSNwah2zzW45g9E69LKOmoxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66556008)(64756008)(76116006)(66476007)(4326008)(6486002)(36756003)(38070700005)(8936002)(86362001)(186003)(71200400001)(6506007)(91956017)(508600001)(53546011)(66946007)(2906002)(122000001)(110136005)(66446008)(316002)(31696002)(2616005)(38100700002)(558084003)(5660300002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JpakdXelVQQk5STnArMWhVc1RuaDZ3Y21ETmUyS2NKeFFRVi8zeVd3WlBJ?=
 =?utf-8?B?Z3dFMnpPQllkQnVnL2FFZnMrMW5SSk5WQXpPdlBTKyt5M3RzcU53NWl5L3l4?=
 =?utf-8?B?TllaZFZ2MFByQWtuaDFpQ1JLTGpjOGhJdlc0S3kxL21qaVFTZG9DcEVNMUJz?=
 =?utf-8?B?VXFyWTY3U2lLb0FuWFJrb1BuREJHazNVd1NCMDhNNHZOZGJIUmMxOGc3N1M2?=
 =?utf-8?B?ampSZmg1YktGcERmQWZ5dThqSGtPRG1TTU9qbE85RktWa2RKeDg1dHd6YnpF?=
 =?utf-8?B?RFg2UXpyS01kRlRUUjQ2RWNiWFJtT0g5cnhIMDJvTGt1TEZUWnVmRElISlRC?=
 =?utf-8?B?L0xjN2s3clpMYlJyV3FleHVHdkY3V0VEbHJ5N0FhNjdQOTlkbVVNVkFCaXdI?=
 =?utf-8?B?VTNjMzNFdU9iY3dXOTMvUmtuWk1qM3h0ZVBmVURud241SG1oVFZUVk5zUVJ1?=
 =?utf-8?B?OG5OT3A1dTExUTVLd3RDOTlITXlpSnhTeXUraGl6MmVyTXFxakhwaXFvcjhY?=
 =?utf-8?B?S2xaVHQways2SDNPMitKZGFuRnN1NjdVTmNOZExFUURrWlNLR3I4K1ZLUEZh?=
 =?utf-8?B?dW1XUGpibm9xZFcyMlV0SjhPSVVQd0lKL2JEbUdjcURLb0s2MG9PQVFlM0tC?=
 =?utf-8?B?VjdCYXQ0UDVTMXhUOGdIaU5uVU1GZkdFckp4eEMxSXdlTm81NmEzYysydlMx?=
 =?utf-8?B?bmxGK0paVjZleXlYVUlwVmo5NkpwdEZhR2ZoaWE5OVNpOEExaXVTZ3krb29k?=
 =?utf-8?B?azd4ZUVzN3BMY2JKM01wdXUycktGM3MrdThMYUdLNDEzK0pmMHk4c2tDMFV2?=
 =?utf-8?B?cXpkd1ViZGlKWW01dVYzN0FtRDVIUjRXMlRvZ1lyWEdobVVBZTdVVEVvZFFj?=
 =?utf-8?B?Yng3TlZoTFBBY2VyVUVBL3N6QnRyb3E2S0xMUm9MU3h3eWRPQTYxL0JleGxp?=
 =?utf-8?B?VVZISXpROUdYN0NaYzVBdHhVdzVrejFkTFdnTTVoenNhWS9xUkE5WDQzTkND?=
 =?utf-8?B?Q1hQVXhncmZTdHN3V250ZG9Rb1VBU29TTnNoMnBocnJ5OHlJK2R0aDdEeEtK?=
 =?utf-8?B?YXJ3LzVyVlRnaEc2RWlBUFpsSHM2MjNidktiVmp6TzVrSjI4WEEvV0QwWnFx?=
 =?utf-8?B?VGtsWHhPZmpnK2taNmMrU1RiU1Uxem9rVmI2RzNPMzNCUGc0Uk9nbTJkYVg0?=
 =?utf-8?B?eHpMKzNrY2FSMnE3SDRzbFB2Mm9LMXJ0ZWlGdXdQUDJ1UjRkZmxkZ1hXVVl2?=
 =?utf-8?B?NXRySGtTTWpVWnZ2RG5zUmtoR21DSGRWYVk5ckFKNW9vV2krbDRMTnF6bVZn?=
 =?utf-8?B?R3ZucG4zeTJIdXVUUUd4cS92dVFWclhvZ2ZScUF2ZWxsendWZXB1ZnlOdXNI?=
 =?utf-8?B?bjFqOVFZRk9rTklvYmV3L0k4TUZZUGl4cXN1dWR1ZlJ2cFJlZVdYejFldGRv?=
 =?utf-8?B?c2dTM053V1NHMmdJUkdCTnVsclVVQllyZjlzRUVyTWxwQjZoQUZhek1ucUUv?=
 =?utf-8?B?YkloVWQwd2laNEZMOWZER3RiSlRnWlNkYUVFeHZNZ25YZHpuUnBSbHZzaFp6?=
 =?utf-8?B?SUJlT3k5NUczRXFOTnNCUmtzRTRTaEVXTzUyNlIrdzVTd011WWlYTDFPYTJD?=
 =?utf-8?B?WW1jYnpraGhDS2pRRi9MWWRReC9mWDFOV1Z5b0p5RXNqRTR2amRTdkNTdjU1?=
 =?utf-8?B?aS9HUWlyUWZQRGY3cW1PczVMdjZtbHU3OGZxdi81bW1LR05WY1hOd2JqV0NO?=
 =?utf-8?B?d0xHdjZ6dk1CMExiWCt3UzdCelVaOFdjcllSYmNPL0JQTU5rQU1BbUErUVM3?=
 =?utf-8?B?dDZUNjFNbkllOTJ0RVhMMldZczJhTFdXZTdCcW8xb0tUN0tsamJMd3pVOVNZ?=
 =?utf-8?Q?YHxy3Dht0bnOR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA2C4B2A701EA5409050C66087292F28@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3f3e50-7aaa-49e2-e160-08d98e00f2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 04:21:37.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F3Yz6ri1L1+2AZefMZXuikaR6vayPAEjtG7mYpmh0aRrsQ/kKibuFjXGFNMM+XbdiMjknebxD/+/LVtJoG7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTIvMjAyMSA5OjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gYmlvX2dl
dF9maXJzdF9idmVjIGFuZCBiaW9fZ2V0X2xhc3RfYnZlYyBhcmUgb25seSB1c2VkIGluIGJsay1t
ZXJnZS5jLA0KPiBzbyBtb3ZlIHRoZW0gdGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
