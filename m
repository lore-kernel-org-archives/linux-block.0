Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C44C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 03:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiDTD4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbiDTD4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 23:56:07 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB527CDD
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 20:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPagUcLls5pj8ZLT6IDuGGi8pK6PMSu+eKPf+3w44sGCZDpe+o/YMdUMqMAah+NIAum0s1jzLIcuACwxMM49qvXwT514SaFqTwi4hcWKvWKFollIb0Fk2p2FdH4T67DDGPZLJ7N738vyGBSYZaE7UvdocpOjBAP3WLbvNmpCsPeQPhaEY/r9z2hjZavw0H7j1PzFXl+S44Q7bBzHQl3Bmlj/7kvgTT/vzLkk3RzdZjCSC0TVKfdGbRv6S4UC3b9oO/t7kSMhJw0LsWxOI+aoIO1+EO+NYdwoUruK+FLDVJfhGsBdWhnU3/zQJwCrN74RCqtFJMo1hAT/A1lfAS0opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgP/wQKNhTwScHRO+nbLZpAekTfHxA4qtn8w7hKmjSA=;
 b=J14VaMM24AsXS349EnjnUUcIk0GZdWhgZIo79Kp//VU5MDOENsQQx7cU/hsgLXegSm7i398BmQTv8eaZkD8EYVpBTh980UohJcQubbFsocleGkUHTxHSQhjfqz29lVwkpiR2L+VcuSs2rU/v7szgFHFjfzPq9uzuVBmxBcqmJ5If2nSDxvuZAAC0chGLfcpIFV9IVEZjst/NsaGIwUlzdVP4UQLUUIBDalXyGQAxOoCIp5brVMhG7/NIn7HuovmrI4QH82eNuXjyxNBkQh2f2CZdc+xxENQ7C93B9j+sjOv5xI7oCqKtYAQEeNL/yQzT+l7pccIJKgJID0sa6/oV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgP/wQKNhTwScHRO+nbLZpAekTfHxA4qtn8w7hKmjSA=;
 b=sJ9Hs92vNXuCa1zDHadv38Z24+KKoeQcH9F+dvLi7kiJ8uDeTg2z+XPDtIrZk7kfTG2jCnhaMFRuuxdfSczGfUIatcrjfbPPrA5To7s8005qwC1Nf+CFil+Ir0lYjQg+fMM8zPiV0ri7xpJbWQ0SRmu49+G0oT3BwUmRvMYFNgIkKD7xRAZ+/D5p0CNnPl3kII61nLCKt9XVG69jz6WBsgZ23r2Oe5ur6QI7HxFcSkCHuqVr+V5qRx51OLKU5RYbtZx9qMQr6+AQzPFKFlFGb8XBx3jz6aiXD30TyMF2IaW7QHXq8X1FfOaMu5CzsajRqVG3N0UxS4FDesIaDDqpgw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB3942.namprd12.prod.outlook.com (2603:10b6:610:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:53:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 03:53:21 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/4] block: null_blk: Cleanup device creation and
 deletion
Thread-Topic: [PATCH v2 2/4] block: null_blk: Cleanup device creation and
 deletion
Thread-Index: AQHYVFHOsMXb2hgLA0enn6+W0O31aKz4K7UA
Date:   Wed, 20 Apr 2022 03:53:21 +0000
Message-ID: <aab0b853-3070-196b-ddc7-7ae5b58a107a@nvidia.com>
References: <20220420005718.3780004-1-damien.lemoal@opensource.wdc.com>
 <20220420005718.3780004-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420005718.3780004-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a4ba97-999b-4330-3632-08da22814fdc
x-ms-traffictypediagnostic: CH2PR12MB3942:EE_
x-microsoft-antispam-prvs: <CH2PR12MB39429DD2DA463B4C69192C87A3F59@CH2PR12MB3942.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JC/YUpG7FRFhd9KsNTFhm+1k61oTGp2yN60UkR5vwLfh4RCCOMAdJfycPrOqWj895Q7y/oH7+yz/Sq58Urhks3wPrkzLACxBOQqA7yT+jCiUg3dLfHUEXI/crStctJGXLuGPm+5lb2+A4NQ2euYoBeu6szBu4D286gqCqv4GZUjDae6V7cfK+8CZgl0MAuLHZXlkL5RcD3joLRqK72D7RMUWu4ytqU/5vrKGh+fG7WQPyfnHHwPZTYWZT8BhPBkf2F6U7yqXm6HQOIjptqutXusOiYyhU5bgJIluv/Fk3r6QLJq5NjJnZ5pEwJiwamxwqvQfg05qDX7Yq3lna9BhBw0w4iNqC7Up2oEDzPm5lQNZjGvJOYSb68u9edNUvlDjVZIy7fQGerQpUNoKM8xPG3qJJoooBzLqXAIflOD8P5RNl2MhDKnTbHx8wUWdMq0+CivysHCjW8tNUOwp92REEncMe4aC4L7TGp8teCd7Tu4cW66xwVG2k6/DPkSfDpjYBLj7YX1H6M4r9LPHPUnt5VupHJXaBYc42nIvt3Yz48ok0fmLN9QMN03BaGZQJXxrWxpCeq/r45fF1Qy/ozlxRtONRbPXg5ukU05mdq+BYwJ8s3lu5lrSCloKEYGFYW3WsMUW0b/0OdFUVK7B7IsUo/ipPj2px9+/98GrGELy7/T0vCnwzNKS/jOjYaqTReobiknpc9UXeijsBRVx1MRFulxBeD2VwIYY3fTaCi0DFhZTz5UDfJfn7GtZ5Khj3WzDgbn6DYGSp5Od08nokCF/cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(2616005)(4744005)(122000001)(186003)(31696002)(38100700002)(86362001)(91956017)(66446008)(508600001)(76116006)(8676002)(64756008)(38070700005)(66476007)(66946007)(66556008)(5660300002)(31686004)(316002)(6512007)(6486002)(6506007)(53546011)(110136005)(36756003)(4326008)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1ZESU5mbWxWenMyemY4SytuSldyd3IxWk1aY2ZaMTlXNTlucm5IeTJUU2ZB?=
 =?utf-8?B?MFFwbkVuNmtrTVJUYTc5M013MUd2enBDaE90bVBybjRWTzFwdGxtMFZQOGQ5?=
 =?utf-8?B?VDA2SWRRSWN4eHF0YWlkUmx2bGlMeWNRZUgzUklkRXhYV25LS2xnbmhtMExu?=
 =?utf-8?B?djFlaklXNDN4RFhFVmNrckVaWkhJeGRvaG1sUGltQUNvcEVUSWhFeUhpVHRQ?=
 =?utf-8?B?bCsxOUR4dXVSSGdsRjNERWl6T3o0S0lqRTZ6Tk1Ma0FMQmYzRFZWTlVjZHRW?=
 =?utf-8?B?TUk5ZzdkcllIR3Z0TG5ZaHk1TUF0SUpiSjdIZURqZVNCY3grdm45WnkxSjl2?=
 =?utf-8?B?Rm1JZ09GQ3hKS2ZKQjlIcVZmeGJqcThudXIvLzMrbUVZY0VZTW1oOFFKUHQv?=
 =?utf-8?B?T1JOWkVTYWVRQmlBWG1TNjBRZVl3cHo5THZmK1UxUlExN3cyTThLRmhBNHpC?=
 =?utf-8?B?R1lrdkE1RlFBVHRib1lWUld3dlpIczNUc2ZUREprTkxmdCswbjB6bVRnb0xl?=
 =?utf-8?B?L2NySFRZU3Ryb0U0NkJ2bVdBMVNzbVZSY1lPTC9yb3VNREhQcGhOa05ya3Uv?=
 =?utf-8?B?RHVXaXVBMmt4WnFOaG52YzBVa2tSYThKc0wrY1pzRldQMTZqRFlORjE4c2p2?=
 =?utf-8?B?aVltRldkRUNDQXdXV2I5VS9qejlBb1ZaZ3ZMcWdzNzg5SVEyNnNGUCtJU3M3?=
 =?utf-8?B?L1cyK2hndm1xaStUS1FLQ0I1U1JOQjhMeWxxVVF3eGtldjRFekg0ajRFVlpp?=
 =?utf-8?B?SFN0RCtCZ0c0RlJkKzFDb1dZR2kyd0Zhem9oSlNxMVE4RUZQSEtWMlhRY3ZC?=
 =?utf-8?B?NWlZb20zdzdEbGhkcFMzaW5NVTFpN0ZuaUxPbnI4Q2dhcHRvV253ZG1STEdR?=
 =?utf-8?B?YzNFbTVhaGlxSjdxc0cvWTFaTzNXN3llT3dMNHVLeUZjdUFVMTA1enlUaFB2?=
 =?utf-8?B?MkhBUkNvbUlqR3pKUXJQSklLMW8xUmMzREdtNkozZ3IrbU5qTTB2b3Q4NE4w?=
 =?utf-8?B?YnU3czNhM01aMllDaElsS2ZrdVE5MTNHOStTdXBnNUJvbytkdndEUk41S3da?=
 =?utf-8?B?aGxUbllVMXJFWXZDTnVUUTJxc3FzcWV3bWRiNHlDTE1tYThqdnhvNXF2Y2pB?=
 =?utf-8?B?UXlwcklHSEtqMnhTSXFJbTVjZTZhaHlWb0hZU3NQcHpNRWNwZVlNTGE2MWVi?=
 =?utf-8?B?c2xmdW5zeEF6OUJTSWJBL2s2UDJJUm1YQk11VThBWG0rYjlqTjQwTXJLdWo4?=
 =?utf-8?B?TmpUVDJSL0pMYkxlWENHd1k1NTFTYnU5QXZPNTh4TTZiOFJjRjg5TkdaVUs1?=
 =?utf-8?B?azU2K1JsNGhsc0tQazlrc1I0NUkyYjYrSXRKQ1F6dlY2U05BNnVkWGR4ZGJF?=
 =?utf-8?B?ZVhHOGFqVEltVDhxanB1QUw0OVNLQ3pqNUZRWUIxZm5xemttUXZtdVMxK3B1?=
 =?utf-8?B?Yk12VnBtT2xLK05KVjR3L1J1VDVPS3V4MXh4RzRDeHdxaWpxMVlabk8xcHFv?=
 =?utf-8?B?QjJOWFZBRXpzZE1NWTkycjc0UXBXZGg4OFczc2ErUU5kOENKMTF1dW9IaHpq?=
 =?utf-8?B?UEE1WVB6TXh6MzhkbFFZSkliNEZzVmVXQURxakc3dmtuWm4rTis0VDYyNVUv?=
 =?utf-8?B?dmF4ZHQzRDhoM3pObEliZWM1QkNhWEE1eitiUjBZSHNuQk8xMXNxbndqTDhM?=
 =?utf-8?B?NW9DVUpMWnplaFJ1VndoL3p1T1dhVFM5MHIrUm1DNlEwakl1VTFIOXY5Z0xL?=
 =?utf-8?B?WmRnU2RYYUlyeGpBOWI0ZVdTTmhjbHJZT1kxOVNMNEhjR2lTOE5ta0RjMEE4?=
 =?utf-8?B?VndlaG9YMWFZNVpZTHFUQkFDaWE1b2lGMXhocS9LNHhGOStBL1RCOWI2WFFa?=
 =?utf-8?B?UmhnSSttVXJaNEh1czY3MnRidjlpMDdpOFdNazJBM1c3YjJOdkRyMTRxSVBO?=
 =?utf-8?B?M1JrMUZQTStBNU9paXRXNlJxNXBkdVVmazFaSW1TMkYxWnhWVkIwK0RNOFVR?=
 =?utf-8?B?K2xsMEdTeWNkaGRRNG9SQzZrUk5PNGJjU0U3ZEtFaWpKSHNWMWlZSnlCUi9u?=
 =?utf-8?B?R2lBWldFQlBBQU1SalZsYXNPWXg3MktaUXBrZTNJbG5aTVN5YU44ZmJmWWx0?=
 =?utf-8?B?OEpsZmhFZUw1SXVHR05HY3VsU0YzNm5KbzFQVkNJbG9MU0dlbHdhZ2tuR1NI?=
 =?utf-8?B?U1FQOW1IbFZrQVZSWUtUY3dtbUhTaFNDdWdnODc3Zm1SUGRmREYzVGZHZkJh?=
 =?utf-8?B?Q0xoZ3laa256MkJqYkJQWmVUU1VYVCtBcXJLMjhTRDhNR2lzamUxV05WbTRS?=
 =?utf-8?B?UHlFOGVDcm55bHcyNGs2aVZmSm4vYjc4bHlGdHRFQjM3WFV6WEUvYlRsb3lh?=
 =?utf-8?Q?xyjzh17muPrT5YTViCuebynfM34X4dOIsWtKQ712v+y4V?=
x-ms-exchange-antispam-messagedata-1: CEJBzbHiryTyWw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA4C196E6998D4FB77F709B0BA72E53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a4ba97-999b-4330-3632-08da22814fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 03:53:21.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLLfbBTXcfTuXAi5C/unsbD+Mif6EtSY2aLlAqKuA6/vw1QshrGkvgqEAkFK62UrbMmBSpj0jkoWx9ToFgNVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3942
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOS8yMiAxNzo1NywgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IEludHJvZHVjZSB0aGUg
bnVsbF9jcmVhdGVfZGV2KCkgYW5kIG51bGxfZGVzdHJveV9kZXYoKSBoZWxwZXIgZnVuY3Rpb25z
DQo+IHRvIHJlc3BlY3RpdmVsIGNyZWF0ZSBudWxsYiBkZXZpY2VzIG9uIG1vZHByb2JlIGFuZCBk
ZXN0cm95IHRoZW0gb24NCj4gcm1tb2QuIFRoZSBudWxsX2Rlc3Ryb3lfZGV2KCkgaGVscGVyIGF2
b2lkcyBkdXBsaWNhdGVkIGNvZGUgaW4gdGhlDQo+IG51bGxfaW5pdCgpIGFuZCBudWxsX2V4aXQo
KSBmdW5jdGlvbnMgZm9yIGRlbGV0aW5nIGRldmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBE
YW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb20+DQo+IC0tLQ0K
DQpuaWNlIGNsZWFudXAuLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
