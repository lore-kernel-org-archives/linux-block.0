Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155EC433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbiDSWfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiDSWff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 18:35:35 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5E27B2A;
        Tue, 19 Apr 2022 15:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEmJKgLGYaYaewKkdyQk+oflMY7v68kQBlfJstFyI0+gdwcq4RKDecxBXzF7Sv6T710QLiHxbQ9a0ERQU29INYtgh0jeBT5UNV+U/bxKr3bBc6R2xNYbfha4ygQ4fKvRTLgsAoVAl/F0aEu/PbKKO0y8gB/fDqB22xEp57CRKzi6Dok9/0re45nhZ8P0c6tkuBoKN60OFx4Z/nVHLG2ANzMsMxcjPiFypF9BRxB2RBnySOABsSb2V6xK5q1YefypvoCVOItGrp4O5o3ybVl6C4VTv5dhcPZ4jlRyl1p8MBYcvt/Q+SHzTggBMELBaQcGp0bjDReATBhHXoZvhfVd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHjo8bRmX85TuefGEmmmyCjXJIAWxhFm0z33Sc/HUh8=;
 b=eZFGeRedgTk0oS7qOtilWKY8qDrWdfW6R/Vm5zDamu0opVgklTBjYEDM/Jxh/XxoAco8Ir6FvJyNWqYmMVagGve8d+/bCkm1zqQsmqGxzQjLsOOpCb1KftBP8vSmyXqOwIb6FNEFAFK7hAADCVGoaVUsS5xkl0kaIpDe1kNzqVjfZGPlqJWZyA7naXF9sTGn41VaV9LUPe13J5LGaPFv4uFiD+LduOKleJsfeE9fRaJKEbz5KrpoUyDPQ/+A/SuK6LwGoSTVzIns/Gz3CREos/+KdyiPMgN5/QvcjfOwMjAna6hXBc7CDOIRxDV3JXvkff5Ns+7/kkh/L9KfnQms7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHjo8bRmX85TuefGEmmmyCjXJIAWxhFm0z33Sc/HUh8=;
 b=TMHxM0p3wDv342rvXEqC2YGii/xobltMRF7wBGR2N1Zzwbj30COQsYmGlkR/FUk9IQzCC6m60PJuTgrFnWPMoXX+jdzLdpN3NQE7EHPaX1sYzXVv10FQKGOFnd0h+1xGvOv+DqswsXszsGH/uwlrL0MftiWjIMMKPJsc/CP9QVL6B3scjbdvZR8amrCHpfj4DnF2o/vOZ2Jmls/0QhP9jZDPqxYB99kD7WWOxt+DfQ2Awt+WL8hXQgKIJbYrdH+4HfpNHltL35JhW+KPbY+IsP/GAfNwRz1FO/aD8aIEV3pSAPwoIJQT3omDTu9txutygziaX4W/P0ba3xqKrJ2Arw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:32:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 22:32:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Subject: Re: [PATCH 1/4] loop: remove loop.h
Thread-Topic: [PATCH 1/4] loop: remove loop.h
Thread-Index: AQHYU7dZrGDDd6NupUu3tWkemnaP46z3014A
Date:   Tue, 19 Apr 2022 22:32:50 +0000
Message-ID: <4455ccd7-8f4e-afcc-fcce-876ec8a6448b@nvidia.com>
References: <20220419063303.583106-1-hch@lst.de>
 <20220419063303.583106-2-hch@lst.de>
In-Reply-To: <20220419063303.583106-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ef5be4-c98e-4bf8-8bc3-08da2254899a
x-ms-traffictypediagnostic: MW3PR12MB4411:EE_
x-microsoft-antispam-prvs: <MW3PR12MB44117CFE35A4E763C6E44C63A3F29@MW3PR12MB4411.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idonQ9JhfRHitKa+6fOn5hgNCl2woqZ95F2JgVxCNG8RUGu46tSHVcxaUjEq+MD32M3ggpgNGvOcWcFceHdd6xyhtM5iVllHHzxBVKo/UoUT6U3HYwBYTcfnvOVB32nKQEDxpfVIBbzBFOvV+e9nHONG0a8oM/Bv/+lcM5xWiLYVRW5Ayv3lMriw94bEA554T6eg5w2spegL8WSHSWbqVy4sf5/xjZjTm5ThhdongDvM5Ve8yOj8GCaudN1+CsGqM+qdV3pcK+h0RD5ox/dANB3fshkEVuHIhgw23HzOyl5bjVJB1qvwEmsGT4eLKhLaILq8PY5OVvWYX5XrWfUbZssIhq5R9sEu/2GQSgjYvJHgBvOl4iynOBf5jDoxWYhlmiOGvVIqgcRDERyjUuULIur3jDTtHmfw4H3pdBnSYFsx/x6ms5sMuan1k/Sk7LMubV1QWUDURnKXBJiiBs54SC4X3yPtl3gAqAftj+ziCRvtLzFENUBDekiemBJ9E4FFmRMyHyzmvA4QXeN3uxN5mmnA9KEWAiiqG9zYhw9dWW7WXgCHuc5V0nKtI/0jVAbAtWAuJZ8Iq6vqjBFuGGDMaoV3HJoHTtBvv0zuP7EZgOxSq6HBbjsvAAbNqMcK7cfYu1STuISZ9OSJLxQgOuY2ZEZHLzYpxFnvKaviO1CIByYlCPtX60koM1BY3iI4evf/mNXaMpVVzAjkfs83itnd21fltTtTnGkKS8wzGzN8eo21QsJn/7TqVaqnJy4Vw35ruT0ZnW3Y8ddvvj7v8oVmnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(64756008)(8676002)(86362001)(71200400001)(122000001)(66476007)(66446008)(2616005)(2906002)(558084003)(6506007)(8936002)(6486002)(38070700005)(53546011)(6512007)(38100700002)(31696002)(36756003)(110136005)(508600001)(66556008)(76116006)(66946007)(31686004)(186003)(316002)(4326008)(54906003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzRGRmNIdS9URHlCMTlBR0Z5bWd6cDZTbmxHaFQ2THcvazFaQmtkMzlnYlFj?=
 =?utf-8?B?ZXU4Q3llSlBGWVRiak1KdFd2clVOc0xwdFZYYTZ1VzFLdC92ZzY0WUlCMFQr?=
 =?utf-8?B?VXlGOUhGbFpka1ZYSHY0R3lxUzRvVWF6cW1ZdEhyQkhJTWJ0Q0t0OWY2ZEx5?=
 =?utf-8?B?Q2N3VURCMUV0OHJ2M25HZlNiQXQxWEZoZXk2TWU0cFJKNWM1QkJDdEY0YXhU?=
 =?utf-8?B?aEpFZFZXN1NMSVd4MmZLMG5QTlhwRWlhdWlYKzd1NERXeVpnNGZ4SVkzWUJ1?=
 =?utf-8?B?RHN2cFdjeTAvdkF6a0RUV01qcXVkOG5QVUFJU1IrSG1WVHRwTVNBZmtKS0xZ?=
 =?utf-8?B?NjJhZmxkclRXNE45bk9EbHp2bS9EOC9ISzY3ZkJnZHd2Yk92WVpCVjBKc0sw?=
 =?utf-8?B?cUF3dHR2UjVvdnp0aEZBRStyUFNZUmJTQ0xsK1YxMHRoY1pTd3E5T0Z1ZVRW?=
 =?utf-8?B?bDlDVDBoUjh4WDI5Vk9PcUFxVWNFN2toRHN0RVJLdUtsSzJFeTF5akJkK0NE?=
 =?utf-8?B?cWVZN05GbUZHVlFZU1A5N2pLZkR3eXd0djVZNlBIM0RwOEFyYi9CbkxiT2dO?=
 =?utf-8?B?Z21QbXdPTU9tcTZ0V3RjK2wyek1ibHNyMDI4SzR4ZDBsS1hsRHBPaVhabGw3?=
 =?utf-8?B?STRMeExKbGJDQ2dmcUp2WXFSdmNtVzlzTzNsMHZTUmtNK1p1UWQrNmpubmww?=
 =?utf-8?B?RFBFdlNIeHhMbVFURk14TjNtUWxiaFhwMXdSck5SWVh4djJ1N0lzQnJiUTlH?=
 =?utf-8?B?cnNIL0U0Ympmc0xyVElWSENwQUJrMXR5a2RUVXZweVp4UzA5V0xtOSs2TE1H?=
 =?utf-8?B?Qy9weERhY1BQdDVjTmJneG9PUFB0NzgrRC9JU1loZ3RPV3J4akVtVFRvUkF4?=
 =?utf-8?B?RFlFS0Zicm5FY0szNEFJZERpL1ViWW5YTzFjMWpMNWtNRktSK1B5L2hTdy9I?=
 =?utf-8?B?enN0RFJDL2w2QXVsdWFnVHdxRHk3YzFSWDN0U1RtWjBYaUltWGhrTDRteE41?=
 =?utf-8?B?UlRjb2xpYkowMlVyS0JUenhKQU5VNXZ2ZFBocDduWUV3N2JzU2VtUjZ6VkNy?=
 =?utf-8?B?MnZpYXJDQVV0THRRbGNPcnhma1RjZTZYYWgrSVFYZFBYQ0hQU2JYaFozN0xE?=
 =?utf-8?B?Rjl0amdsQmZIeU8yaXJMd04ybHNCSmZOYVU2Vk9kS2FnU0orcVZIL0RaSklv?=
 =?utf-8?B?RHJLMit2c3EyT0MrMVJRKzI0L1BNQ2x3V0ZybDZLcHlmeTJyMTllRHJXMTJY?=
 =?utf-8?B?K3FieDJSTERMY0NtZlpDRkFnVXJHOWQ0OU8rMXBwNlA5M3VvakRUanliWDBl?=
 =?utf-8?B?b0srN2Q4NHRXcVFGbmM5WFE3Q0VBRjN5Tk9teERwYXJwcmh2djhaZXRYcHZ1?=
 =?utf-8?B?VUdmZWxWa21VZndqWU5sVDUraXZHVWdxT2RnUjBHT2pTZ1JaREtQanE3b3Ux?=
 =?utf-8?B?NmZvcXpvR1FySlpJbGs5ZXY3aW9nNGhzVmltV0xZSkFaYkgvVGNreTBmQk5R?=
 =?utf-8?B?dmJYeFRzUkRwZ2RIcDNGOGVkU2dTc28zRFJ2V2V2cTlKSGw2bU1VZFRmSEhq?=
 =?utf-8?B?cW9BTVlGMjZPZ0FXZS8rV2FNRUVrYTVMdFlFc1Awc3Z5MlpTeTVEZ09ERzlm?=
 =?utf-8?B?RjFlVjkxckRsUHBnNWlIcUZxMkRyTVZpdmQ2cFNNOXlQOG12Z3BjMDVseDdJ?=
 =?utf-8?B?NFI3eVdGdys5NDIwbUxTa3VNVkJxK3hncW1SOG9kdUhtOGx3aElCem15TDNs?=
 =?utf-8?B?Q1FrNXJ4RzVCZWxWeVVUeHdLcVBwM2dGc0V0cWo4WlN1eDNaSWhWQjlwVk53?=
 =?utf-8?B?aGxpYXdDVE9reThqMG04aFd4NXVrRzBaMXdrUmE2RUYwSWRUMTc2SGQ0cHEv?=
 =?utf-8?B?OU1ZN3h4NkZhN29hOXhoTG4rWXl6bGN6VEVYVTk3ZFQxTnlQaWVHUXZIeCtB?=
 =?utf-8?B?SVpqckRnYndCZno0Vkh0SXNUK3ZTa1NzdXhnQ2liUkRZbHA5VVpuNlVBNHVX?=
 =?utf-8?B?RFZYcTh5eGU0b0gxem5CcXB5OTU2enNsQ1l2U3NEU29hSEF5RzNYR1JVUWwv?=
 =?utf-8?B?eGp1MmNJZ21rVTU5bUJXUDl4RDRhemM0ZFd6aE00RXgxWXFoTTBTQ3VaRUlo?=
 =?utf-8?B?YlN0blhHaS96b1lWVTdNVFVEakF5SWpMekNEMzM4S25MV1FXOUJOY2pZVEVP?=
 =?utf-8?B?eFMzb0lLL2FMN1dIQmc1UjFjWWtrRmNtWnRzVzZla2oyUVNBMEM3RVZZczFm?=
 =?utf-8?B?TTRIcDAyYnA5cDJiK3JLajZRd29HcmR6c3N3RXhTSUV2SlRGRSsrWU1ReDBx?=
 =?utf-8?B?ZmxubS8zVU9BRXRlZWNBNHpFN3lTOGZOSnYvenBEVG1PSVYxdWpUMmZjSUpU?=
 =?utf-8?Q?nXDBSZaye49TZ4J4PSzSbo43VZzm8SvCaD0ZFeYASb9yQ?=
x-ms-exchange-antispam-messagedata-1: X+cj/JNHTeRhPA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ECC8867973ED1468D6E1C22F7269575@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ef5be4-c98e-4bf8-8bc3-08da2254899a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 22:32:50.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUXJBf4IBamjKsz1WgmmEtinIrofJapZAESPV2l/M2mzp/h2ebQNOb30hnNXo48hm8DPAbuay2pHcEUf+NK4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMiAyMzozMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE1lcmdlIGxvb3Au
aCBpbnRvIGxvb3AuYyBhcyBhbGwgdGhlIGNvbnRlbnQgaXMgb25seSB1c2VkIHRoZXJlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
