Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbiBNKym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:54:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349443AbiBNKyW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:54:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A97C78F
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+7bITTF17pr7KQl8+EtjlAwFdJtoRXPJGgmK0wwDEeeVk9xNzAZ9fPMElZDssyg/HkK+ToNKGzuuVt6THKnCl8Rvod13xdTqrQ0IFmQoG9IIdUDOiGgEnIflKjnKPhV2Xlf9TidSCBN81ZCBQWwXk0+GwaVUI3mcSHXpDRo806+o7/TUL1wFiplB+qZBL6roBmGqaSBzRIj8aD+rKlKeKrOqnJDcpBwj82aWMZ0GGKLbL7JgvIvfWri9F/ogw1HkFL4Slc/8dDIlLm5gDxWEz9k2FMgPwnEhT7g7HQ6O4iTALtnZmO7MSsQ0JuHg/wT1Zfl6aWDlWsD3frnvPoJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVJRionRIWKLnmGcKJ6VO90w1gD3JcVsbGDgpHpnbBE=;
 b=NjyuDjSEbMl+HLpDwOkAdivxU/ngAfpzv1591HsVMjag3cJQIl9fTSPhM8wrTBDxGnDt2WGRjOupD+zSWnul06ZUxxy0qfk3WtqwQnEMbwWiIrRhaxlxg4f6wuNEMwEqdPEzOH39oh+MWa/NhuMyCF62cMfOdgjdTI5nYbldUWfEWNlq6DzfqfmZNOwM4MKov57T2h3/AFja3Q9l3Dms2/5cuLWingYdQF/e42MxxVaIMRkpbrs0YVgUCY9dcGdqjXKeLq/vK6aydjrRaS8psc87z2n9F/4EEjyOnieEgfrz3oMVlzglvwuUTLjRiBrJP+LEUvO6vR1MRF5RIo2Cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVJRionRIWKLnmGcKJ6VO90w1gD3JcVsbGDgpHpnbBE=;
 b=W87iGnR79+fbhgqHB3tdW66iwRqvy+5SSvc6GKTUkFfvLV2D//YXuXCUrldhTnNpkgh/H9brl5nGnzIeleC8POb8WBLGlh0NHQHdjEFyfoYZuqyZULoCCG09ajb27ew4/C/m39zzlaF8OyGEf2cKYbQ7s896XBCbhMX+x5iECW8neP6vfqnybXTbQarTIwYUr6xY28d1t5XQI65mT6WRHMPWEeGKXEKBkyQss0FvtvTr7sW+bRuqFF69I5x50z+eOg19NP50kRbY2AFYDdxDFg8HV+G4Fl1zREAceyf4Mh0nCXixJIme4uVyGBUlcdNEa8QJpofeWbayQfzv5r2eKA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 10:19:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 10:19:35 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "jiangguoqing@kylinos.cn" <jiangguoqing@kylinos.cn>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/4] blk-lib: cleanup bdev_get_queue()
Thread-Topic: [PATCH 0/4] blk-lib: cleanup bdev_get_queue()
Thread-Index: AQHYIYr1f/GwPi4fEEa3+14jtU5vbayS1aMA
Date:   Mon, 14 Feb 2022 10:19:35 +0000
Message-ID: <5e12a394-031f-51f6-a5f1-39f8d0ee369c@nvidia.com>
References: <20220214100859.9400-1-kch@nvidia.com>
In-Reply-To: <20220214100859.9400-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9113051b-0b36-4326-b6fc-08d9efa37fd0
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_
x-microsoft-antispam-prvs: <DM6PR12MB5534CD34EE90D998BC866BB2A3339@DM6PR12MB5534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPbrdlstX8lAA+SZkLQDkuIQf7XLSUCpzGwkH9WK3Pcdo8d5+hd0jQhw8Ts8RcsRFP2l7u3hJU6/yWrGfN3rdru73I4hsIgWV2Q1pHX159UnF/5RKywUs6JuwVE2U7f5y4pwIdyXelKjf6x2cze4rtKGm80hgj61bqkyb7LwA/FJ1iLl0E85UGwIn5qpgzDwxlPvxRiTJ0CL7g3WkFie+VXQlMLspzs/IAr1So3hEsLd2jIe/o85y6tzR/Z9pX1kqODknw/J7s1uck6tKxF0oNyajKezDEOSnPWfLBxVvWeqkXeeD21j+wwPKxfoRrUyqjwLYnyusuL29UL8+RO58z2FX+7LIOlnju0YVBKH6UZ9qMKQrTj1ZHQT8ywF6DZaZRBAN3TovqnGIPhPKSI18xCun7KSnQeSclgior0zwln7N2Z0qhGpsEQoEm5/OwqT+grPd84/9962TUkwm/7YJ/KY/0WCefc96XeLLv+o9YaG0BLrCPE4fcqMwNDlTMt3HV4vJPiTs5GYW8GCVFDfYubqVPS11O8jzO/YNgwuwr2MriBqGAOmuKMBYHnZJDGmFFAn2AjsFfIgLLtdoamV97lKmo5lTHDQHnUGNzwaXjM8ILOugxZx3IKgDftDjK3UwXQF8fmjkPqEESYiAYJzSd9yOpwDyPQB8VIZrAG5hTZRSIvR0QzC9qAZh8itTg27tU7uUvUxyH6ZK8bR9E8gHlJ6vh3koTO+6gM8ReTcCE+sBmti5vVAifNSFOOM6pmYK0ZnWtq/d1Ux870nB6tBsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66476007)(64756008)(83380400001)(31696002)(4744005)(2906002)(8936002)(5660300002)(8676002)(66556008)(4326008)(66946007)(31686004)(76116006)(36756003)(91956017)(71200400001)(6512007)(508600001)(6486002)(6916009)(316002)(86362001)(54906003)(26005)(186003)(2616005)(107886003)(122000001)(38100700002)(6506007)(53546011)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S01YVTE3c2hPOEk3S0J0cjFqeGZHRGxXbFpiTUo0dmlYTXVhN3NsK3lTMHFk?=
 =?utf-8?B?U1k2QWhlY1FqcllSdkZaN1R6LytYU1d5emx2MWFUdVM0cjI1bGxOVGZtVGlX?=
 =?utf-8?B?QUtFMDkyazBuU1dJQWk0Rm0wZVkxbmp2UlRqMzlNanlZN0MycGtDMlM0MC8v?=
 =?utf-8?B?K2w5dVZyR0k5OFFGSS9ibUdZU3hMMXZ1cURNUkxQSkk1U0VLUldoQ0xicWxK?=
 =?utf-8?B?UFlpQlJxRVZJRFp5a1k4TUo4amNFN0U3dStxRkttQW1BajhUMDJMRzUvV0hM?=
 =?utf-8?B?bno2akhiYk5qZk8xNlRzQUw3T09za21CK2ZZaWx2b3FMdmJtMlYrOGdKdmhv?=
 =?utf-8?B?eVcvLys0UHNNS3FTVUpQY3hiWXhZY1gxV1dlSURINzhqVmhHdmw3c0l1Y1NK?=
 =?utf-8?B?eEsyNW1aaTluQVFkYkdZR3p6TXlrTUFEMnc1OE9GOEY0K2QrQjdvZ2NPSjRN?=
 =?utf-8?B?KzZlVnhScHdWSmU4d0lOTW9SOUpqa2tHaVpJc255Nm9MTURmb1QyME5TbWhU?=
 =?utf-8?B?R05ienJwQmR3K0VpVzBSV0NPOTl6TzFjRkM0NkVOc1k1QXIweHlSV0IzL2tp?=
 =?utf-8?B?NEd5VVNVWU44L2RXRG5rUVRWenMxeGJlVkp3WVVKMjJUZTdWL2lHd0IrOWFH?=
 =?utf-8?B?d1FKSnBwQ3d3aTVndlVDZ25PYjFZTU5JUXlMaUNaampOcWVuNGpyaDZiS3F0?=
 =?utf-8?B?dnFhR2xvejFXclliWkN2S2tLQ09EK2s3cytwYXhETDdlbGRYeFRVT29jSVpK?=
 =?utf-8?B?dndodC9yUkc4b2p4VjlCQzNEajE5RlRWTjlZbThleWtVeUMyQzMwcU1WNTBP?=
 =?utf-8?B?SHZYV09yQ0swaTZqN3VTeVhpWXQ1dVpmczNEYWR5Z2xqSFVzeUZLRDF1UzZo?=
 =?utf-8?B?MTBJQU9NL25hNUVrOURxazBwZklkeUFoV3daN0luKzJGRks0eTlVMFYrWkJO?=
 =?utf-8?B?bmNoMXFqYzBLdENvdUJMMkMyZmNxN2s3cGxWOWFNVDBvbGNVSVRaY3lZUmI0?=
 =?utf-8?B?RHJWOGYxT3ludm9lLzZtTVM2WnVrZ2UwWmJUc1BVU2VDV2tneFdqSWdjOEdq?=
 =?utf-8?B?ZkVGOXp1MnZDUmVCb0hpQi9hUW9kTXlSOGkyNFFFZEV0R29IYjJPdFd6RVN6?=
 =?utf-8?B?NGo1Y1U0RlJPd0RaVVFJQVNoUkYzRWlIL2pXRlQvUG9zT2FMZldVT1FjWVp3?=
 =?utf-8?B?cFVXbmhNdU9DZFA3Qk4xUlNtZUJGUXdPQWsrei9FVHpBb21UdENmc3VUTjgz?=
 =?utf-8?B?YitneU1DWnlLbTUzbWVXdjYvVUJyb3RQRlp5MW1RaUhVb0pFZ09RR1RzUlcv?=
 =?utf-8?B?ZlZLcjRKSmJ3aFBsWHE0WERhdGV2cThTa2RwaWkzY2hTVitMSFFHWWJmUjJM?=
 =?utf-8?B?eXhWY3BYeEV2S3lCaFp0MUJkOWczSTNBQmI5S2JPdWkxZzJkdDlxcnoxOHRP?=
 =?utf-8?B?VTA5RG1PTm9ZMVRTUVpCaGxkamlobXVLZ0E5N0VMSFIwMCtobUZ3STJxSXgr?=
 =?utf-8?B?ZGl5Q3EwOXQ4MThjQnRDb25mdjNQYXAzbnluNXlEeEJlcVNnOGFnNkFOQ2Rq?=
 =?utf-8?B?b0wyUjRmbDFEd2dsNW5hRE5YSm0yS05rbmlRVGpIcnhPK3RRcHlhckVFZW1T?=
 =?utf-8?B?a2RvRmJBbjdHOEZ1L1lGd2lPWHdXcFVnck52T204QWNRTjZEM25yNmxWOWlG?=
 =?utf-8?B?SSs2WXRMWVg5YWZsdWM0RjlSTmw1VTZEQjMwajJBK2RqaEF1ZDNNdit4NU1L?=
 =?utf-8?B?OXhyL2krc0Q1Z3V6WFo5YTRUaVNZZEkxcEsza1JaTTlYQmlWU0p2TERFeHcy?=
 =?utf-8?B?RjBWQjEvdkVyVUlYcVpFTXdaNEk2WlZQNGJMNk1ieEJhSkordldIMk1GSzNl?=
 =?utf-8?B?ekFnTGpsb3REanJ0am03ZWdQTW5PRmN1SzJFbEpia1hITmxDSmNVYmlJVUxt?=
 =?utf-8?B?MnJleDc1M3lEcm10OWtEaWtvUWFoUUJnRjdjbjlPZHFYRVNNWThQUGlOU2NP?=
 =?utf-8?B?cmdhYndnNWFyL0dzdHBuTFNGeUFsL3BMT1NVMFFIR1g1R2dUcWtyTFFxVDZw?=
 =?utf-8?B?ZHR6RzlYY0pQMHN0TllEeFFJZk9uOWpwRzI5cFhrZWVPN3RiQnhMQkdJV1VW?=
 =?utf-8?B?dDNtWDQ4VDIxNGJxLzdBSXA4eDVQUmtvS0dqc0NGNUY3ZngxM1NzN1NOeCtT?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C4B93F1C558EA4AB70FB3418BE40067@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9113051b-0b36-4326-b6fc-08d9efa37fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:19:35.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0ttdqwkOXwqwzb1cCAceBMemuDGeVWFTbN98EDOcBU1j+t3H0xHizD8uHJ71ycIcB7Y8He81WNHs7jzPr64/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5534
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNC8yMiAyOjA4IEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gQmFzZWQgb24gdGhlIGNvbW1lbnQgaW4gdGhlIGluY2x1ZGUvbGludXgvYmxrZGV2Lmg6YmRl
dl9nZXRfcXVldWUoKQ0KPiB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoZSBmdW5jdGlvbiB3aWxsIG5l
dmVyIGJlIE5VTEwuIFRoaXMgcGF0Y2ggc2VyaWVzDQo+IHJlbW92ZXMgdGhvc2UgY2hlY2tzIHBy
ZXNlbnQgaW4gdGhlIGJsay1saWIuYywgYWxzbyByZW1vdmVzIHRoZSBub3QNCj4gbmVlZGVkIGxv
Y2FsIHZhcmlhYmxlIHBvaW50ZXIgdG8gcmVxdWVzdF9xdWV1ZSBmcm9tIHRoZSB3cml0ZV96ZXJv
ZXMNCj4gaGVscGVycy4NCj4gDQo+IEJlbG93IGlzIHRoZSB0ZXN0IGxvZyBmb3IgIGRpc2NhcmQg
KF9fYmxrZGV2X2lzc3VlX2Rpc2FjcmQoKSkgYW5kDQo+IHdyaXRlLXplcm9lcyAoX19ibGtkZXZf
aXNzdWVfd3JpdGVfemVyb2VzL19fYmxrZGV2X2lzc3VlX3plcm9fcGFnZXMoKSkuDQo+IA0KPiAt
Y2sNCj4gDQoNClRoaXMgY2xhc2hlcyB3aXRoIENocmlzdG9waCdzIHdyaXRlIHNhbWUgY2xlYW51
cC4gSSdsbCByZXNlbmQgdGhpcw0Kb25jZSB0aGF0IGlzIGluIHRoZSBsaW51eC1ibG9jayB0cmVl
LCBtZWFud2hpbGUgYW55IGNvbW1lbnRzIG9uDQpkaXNjYXJkLCB3cml0ZS16ZXJvZXMgYW5kIHpl
cm8tcGFnZXMgcGF0Y2hlcyBhcmUgd2VsY29tZS4NCg0KLWNrDQoNCg0KDQo=
