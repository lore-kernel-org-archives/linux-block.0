Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E6C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 04:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDRE3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRE3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 00:29:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C03A8
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 21:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG6HxJcJlc+ROvvMn+lhM+ujmmOY38qVpbo3fHQoQFJod4Da/FouXRhhEIqaEKP76yde85I03+2ZxyxQ01Vv999tYyimnh27hg7V3SMDKOkBKHIB9lXZIRUYpNmb4f0fruHjUQDbLsXVRaY1S41Ooli6CkCaFvf4CmAlv+wEqLYWi0u0V9xkHeO9ae1W/MVKajfJUI3g2XnCjAJybQPg/i4qoG7X1FR1GPCtKVBD5acgKT4O5qNPsbrW1gA4zpv5YvBuTvf/1du1rLbKEHbkSsq0SoUz+WiEETrLSCktVvUO8oia+4R7g+0jnXUt7iXMUc6FXo3sbUQi5YXk1qll0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUufWcbKa94OAH6nVaGwincB+wzFepjjgL2SGzXSUsE=;
 b=gmJ/qh4ng2PYACnPGoIucu63sdcHLvvWIPphfQLsEWdw+0Wa5PGl1s5RAsVboD3NPpQjc0F25vvXlxHZpzxOACVSWX9Afe6796jOMHjZMjmQuUdZVW0XiAW0JDXwlfmIdMLeoRaUgoYiEdEaoiBEMdDF7VYKwQ9Te4CXW7j+B5bA+SPwi59VuwK9KJGIHHptJ8kKxkda3qE0O9fAzxuGqYf7xrb3ohKoDJhzyeCQaRhM8q05QlPfrF4kRLCrI/8ECIKX3VEOZMFQByAGT9gdeq8tVBC8Ova28GU4L0nX5wh9plupNjY6pwa2hFn1wr/4jsxrB0wyGvUaEFLDgCn/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUufWcbKa94OAH6nVaGwincB+wzFepjjgL2SGzXSUsE=;
 b=GIDHkxiXoalPaNfEW9sPZG70x5WmFbqJ3heaAtgQADn+ZjZN9yjh5HWaVJJK7eCZnV03/JJggMHwGd9q3m+2WjmtEOBZN4GSKWjBhA48xVsDkHf45+hjPOpQ+784kewJeIvxsoKaalkXPtAvldiSJDzb/NfHKshTxqfNqopREi9ZJsODFi5t7yjkjUmITs/MjneuYv2YPG90m1A6WTlnm556h3F1Zp82yP9wDhnXXAMC1WGLXlvaexCNWqs/lFvrZCq4V2Z1z+KCrdQA6OyLvxBkXGgYBhLeYE4AyY49PDaXpLrLSV/dcQ3AX8qcZopcN9UO//6kpGAHqY3CZNFhug==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:29:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:29:30 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH V2 0/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH V2 0/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZca2xYugBeVTozkmbf7tBOkXhuK8weV+A
Date:   Tue, 18 Apr 2023 04:29:29 +0000
Message-ID: <f7572514-7ec6-fcd8-c3a4-7bfe5f188e86@nvidia.com>
References: <20230418042420.93629-1-kch@nvidia.com>
In-Reply-To: <20230418042420.93629-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5081:EE_
x-ms-office365-filtering-correlation-id: 09e89b96-1fbb-41c7-1f54-08db3fc58086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+L7WYQdWEb9ad4oHS28+vqOyWG6rENSwY30yAyZ0WPE650zIFcn+KqGQ0RFV3WuJOdBtML3pOQFUSruU/7E7p8HUZOLM6fvuhKcoxAUoc49Awlu+UltwVIpB1BMWxRgt27p2N7fePElC/TC1KLUeZ1snhSe8b2/Ow3B/2nzYv38snMBI1x+9AHyOUMHCcLmpTHGaybTYwFREnAz8iukGopcRL3z/AlHxQKA7wWpIIoM0DJIIIBXIf8PyA4/9zFq0/32KtcpdQMXYV2xC7Aeax93FqaZqG4B6qJTF33QBLd+PSGsCaQ7sB4tJE2d4lpKl/po9k6Z34WeJtcut7uXihnkBKys3Gfgf9kqmIw4v7X3N9L0yz5RDB0CnccJ0RZV1bKYxvFkNjDrEQm1JMaoZ8gFTnZ0dkp81YlXdyK5u/CT9cu6mJThez0D3qmvSOfxYQbSCWwXWDxrJdQe8kExF3AfzukzdiVx3NcGkxtCM/nZ00Ktb+G5vtOHCFPpMv/fp/fLzwR4D2VNHOZatf+FppcjPD++dZknkAA0xMS4011YycsJkgCXCCZgrQqNN0TxSfU4TBZ9xviau2WspjLWHTXnbGxCv/c5zCPCJs8FVWTu11YZ0JGDokWF5FspT6KPItbKt67xnwJMD3F0xJ3mc/G73tuSauhYxBSgUSUvHa8QpBWyI1RDAMP6EsxubSh9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(36756003)(38070700005)(2906002)(4744005)(5660300002)(8936002)(8676002)(41300700001)(122000001)(86362001)(31696002)(38100700002)(31686004)(478600001)(110136005)(2616005)(6506007)(53546011)(6512007)(54906003)(186003)(71200400001)(6486002)(4326008)(91956017)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHBJamlLU1VvUWlNYkxLcCtPMlBKV3hjY3NseTlidXA0SDVxY2twTVJrdHRy?=
 =?utf-8?B?N3FpeEJ3ZE5TOWI1MmNJbFJFdWFEL0JZZDJXRXRydG9wUmh5T0VlWVVpMXBE?=
 =?utf-8?B?NEF5U0Rib2JKM2Rxd2VMOFlGZzhmTkp6WmVud3J2UTZrY0ZwRHNxL3J2NU8w?=
 =?utf-8?B?TjBJYVEvZ2QyZERHcGRHQUpoajZKZkFGamx3ZllGM1dkMXQ4K2pSQ0RjYVhv?=
 =?utf-8?B?cXdZYzlSMWVHRkVZQnp2Unc3UjJza0cxZ2ZRdEQ0ODVCWnhaN2t2c1NBc2Rs?=
 =?utf-8?B?MkhWWVNobG1lS3pEbGlNaHV3Y0gzNlpOMEFKTmQwakZJaTRFVUR4TEZJNzVD?=
 =?utf-8?B?MHRwaHlpb09iQVBURi9zVys4VWNnSnpwdU1JZ1ZEQ0REODRaM2trK2p5SDRE?=
 =?utf-8?B?Z3c5MHdFYVNEV0pDd1VIc3lKMlRObDdkbjJlL1dIY3Y2N2xyQUpteXBDUFht?=
 =?utf-8?B?VkdkdWh6TTB3dnJFbEhMbERnVmwrVTBlWTRlRVNzQk83Y2pjaG9GcnBnQzN0?=
 =?utf-8?B?WXlaMXZWLy90UncyQTcvNU12V2gyTTZmc0xkS2VBaHFhWTltTHIvWnJkcTJV?=
 =?utf-8?B?VDVWVEV2eWVSbGt3dk5YN2pjbXNuQWxxNVlWODh2QndUSmh4dG1WeG1WY1VE?=
 =?utf-8?B?WEc4UlBieHVZVk0ra09jcjBQSVdMMHVOeFdpMmF6c1BoZ3JvSHoxK2FmSnJ6?=
 =?utf-8?B?ajlVTUljYTI2RDRNTi93Ty81ZmJSRlRQUWhVanhHUkdCLzBZL1BMVmNmOWIy?=
 =?utf-8?B?ZUM2M2tiemZQR1Fsci9neFk0Lzg0QkRmWHJ6U1dGL1YxbVZNZWVwdnhVaE12?=
 =?utf-8?B?S0tCSm1DZHBMeXJwcE45RUZ5Z0hWNVdYSW41WldiY0pCZHhFT3VXWnl0Szdv?=
 =?utf-8?B?MkV0OFdlLzdBem1PSUNQNGZFM0FGTUxtWUJOL0k0N29iM2d3dDBxR1UzQUlD?=
 =?utf-8?B?dGk2bHJhNEVwYk81SitRRlZMcGtmdXBPTVRmUm1pNjdyQVpmUjJqa0xaTGJy?=
 =?utf-8?B?cVl2TWh3V3k5d2dHTmJzQWE2TURORGpJTmdHTG5PRjlpVXJRa3hxZDNsa21U?=
 =?utf-8?B?WVZ6WkpIV0E2a21DRDNKSDhBSlNCS2MrRDFVZ0dDMHoySlJGV3VFVUNQZTZu?=
 =?utf-8?B?d29BcEJSa3lhWmJqa04vWnA1dSsvYXo4Z29TZGhzZDdYUWVZUHl1WWhxSEYr?=
 =?utf-8?B?WEd3TXZVVWxpTHk1ZVdUcTNSZFVTeGN5YmlMWFVOekEyWVlSbUhPQnVXVzFv?=
 =?utf-8?B?TjFZbTNLUWNlTjlQQ2QwWWxIK0dIdXdFUG55eTVKcFZxejBWcm1oY3M2bWF0?=
 =?utf-8?B?emRScktPa2IxVEQrcDNNRVRZQ3E5eEpBN3doek1IL2IxOUpaVUlLemJWbXow?=
 =?utf-8?B?TktVS3c0TlBKWExOY2owTlZEZ2RsdXVDZmhJV2xjNFl2cG9PMm1WSEJyY0xm?=
 =?utf-8?B?RUFGNW1ZY3MwZHUvdmFTWE9YTWc0dUdlNi9ocWZuYUgxck1XK2dzVEtlajdP?=
 =?utf-8?B?Z3pPYWtHWlR5OHhPYmlIMmZqVWt0aDU2alI0Zm81M3lpNk5pVDl4dWNLZHpC?=
 =?utf-8?B?K3RRWGVPQTlHUVVSNGdkL1JFdVJ1WDU4OU9DTWZDVmNzb2hsTkpUdENVdUU2?=
 =?utf-8?B?dEN6emVjUy9iVGZGUW9TVHNhNFZUcTBrU3luV1JuTlpSeFZxNnprUnZpalAv?=
 =?utf-8?B?RmsrcGdhVXVMTXA0TU1vNjZ0WWVYaUtqeGdDSDJ2K1B6a25zYnJMTXBNQnpJ?=
 =?utf-8?B?K0JGZ0JVdEQrYmFhZzdEa3hVWjZqOVphSlcxV0tnVVBRZUFhdGxibkVTcjBT?=
 =?utf-8?B?MXd3OEN0MGt5MHI4aW9Vc25wMG1CZ1Rxc0tNMTJPUXpqWEFiZmxxRzc3YXZF?=
 =?utf-8?B?M2dQK0ZYR3cycUJBTTFWNjh3OEFCTE9jZU9ReUFZWnJma01vK1BhMkZQWmd2?=
 =?utf-8?B?VU1RVFVHUnJ4S3JZQXQvaTJCeXcvWUtLUlRZWE1nSlpFeFZOdmhsUjZLMFJZ?=
 =?utf-8?B?WEt0djByRm5PdW1pVGM0TmZYdkU3ei9FSW9ZNmxlK3lVN1JKU0x2eW5qNk5E?=
 =?utf-8?B?M2hZRWdVQmZ1em1VS2JHOCtXeXJKdEJTNGpHZWsrckhlREtYUDV1aC9ERDdO?=
 =?utf-8?B?VC93ZWlNelFSeGdrcDhoWXlNcVpqMHpRUms4dFgvZkZsamRhUzNBaHY0WCtn?=
 =?utf-8?Q?rpd9BWVeFfwPXpImbaIGDReUvu5HU0DqsC4WofDSK87P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE25359B7D5D834F8E4C00A9CB8A5C7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e89b96-1fbb-41c7-1f54-08db3fc58086
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 04:29:29.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfoqgknRn/1alo0P0IzZ+lGpaUZFtLN2ul47VQ9u1tJaL7Rj9FxtGOCbqhSMwnJm6aGtkzMkZePAIgW7O8KPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xNy8yMyAyMToyNCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBRVUVVRV9GTEFH
X05PV0FJVCBpcyBzZXQgYnkgZGVmYXVsdCB0byBtcSBkcml2ZXJzIHN1Y2ggbnVsbF9ibGsgd2hl
bg0KPiBpdCBpcyB1c2VkIHdpdGggTlVMTF9RX01RIG1vZGUgYXMgYSBwYXJ0IG9mIFFVRVVFX0ZM
QUdfTVFfREVGQVVMVCB0aGF0DQo+IGdldHMgYXNzaWduZWQgaW4gZm9sbG93aW5nIGNvZGUgcGF0
aCBzZWUgYmxrX21xX2luaXRfYWxsb2NhdGVkX3F1ZXVlKCk6LQ0KPg0KPg0KDQpQbGVhc2UgaWdu
b3JlIHRoaXMsIEkgZm9yZ2V0IHRvIGNoZWNrIGZvciBCTEtfTVFfRl9CTE9DS0lORyBpZiBpdCBp
cw0KY29tcGF0aWJsZSBvciBub3Qgd2l0aCBHRlBfTk9XQUlULg0KDQpJJ2xsIHNlbmQgVjMgc29v
biB3aXRoIGNoZWNrIGFkZGVkLCBzb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQotY2sNCg0KDQo=
