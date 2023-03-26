Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C406DC7619A
	for <linux-block@archiver.kernel.org>; Sun, 26 Mar 2023 23:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCZXJS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCZXJR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Mar 2023 19:09:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18ED468E
        for <linux-block@vger.kernel.org>; Sun, 26 Mar 2023 16:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBfzMQroasq/FKSDni4EXbbd13RJcuuPABGnqepnXbgpw4Aaqj3RqICShmT2Xe44jrhcgojQaVnfFoFbTsKTjZjgNKOOd8MA9goS0p56+t020sOANFRKT5E26Mp/REVxxgJefH149aS1cNgsqjQm7TILnZ7xjbxeSfQ8RCzec+qnWwdu369DDJytvsF+8ihXl6bh1obg6b3yeJTtsmhlo1oVW243pRQVHBgpQtJMR2brXF9ak5ohrKJVwuAw9jN7mk0k1QZqtrr2COv1/VXqvDyEyNVWUOM5v5qypGUXIcW2DlHJ87/P2J6kGhiLrP6ICmdZqmpq0M2ouo7tMp4Ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6OAeju5zTF/XHonIqxuX+YPk6fRHpFRoSnfHwIIPCQ=;
 b=DzSSFD4Cj1sTyw1D53NNY+0DqaTcqTxeUqMpo5yU/3k56YAZOYjS0EI33Tg+i06wIXr6Jd0Be30bKqpgl//Fii2deLUejyvRxxLZSeRxWK1JmNl0c3QRo7n9jjZcRrkOjF0zPiGqs1sUXeft1ju6b+j7q95Z8s36SXO7Dh2rQ1ehXo1uWPFm+UMTSL1GBc8HHHAWxUKr5wNKi/em/eo9drOCzgl4yriQ0WkZi27xtDZ+6Wxd0D43jpnS9wy7nEax5AUxhX4IVg78gFXdTDD1GqJTBRKj7/bu3UlFLdOmphRX2eF88o7eiOh25SX1He/Jhj93jg4HoQwiercePMg75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6OAeju5zTF/XHonIqxuX+YPk6fRHpFRoSnfHwIIPCQ=;
 b=rTx4JuxsyU/8IrcR68YaqSTx1PgklmXVj/kWcWG9V2ziD15m/kxsvEP9AWtILDrHMTI/vVW9OqUq061p8AiLkK5jRanpMrlA2H7XLPpSyW5PTNKEKBmNlv6wBs06ialZP9hAbb9YefRf5rLndxS78CW5Bcg97k8kXBw/d8/Hyk+NA5a26UDpD0R0I7ZM07q89PAhRsla/E01CybVDjRrDCnB5hzqA1vmGpIfisqgcMKeikZLAifDor7+Cno4cxqJvpcGVYTAIoC7fGVcMLyXBVmh/HNNUKz6RYoSXkuYLI6MpXW2xUR6gf79jOC4SrcqdwaNBjahgeDXSUvbYdMBAw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 23:09:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.041; Sun, 26 Mar 2023
 23:09:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hi@alyssa.is" <hi@alyssa.is>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] loop: LOOP_CONFIGURE: send uevents for partitions
Thread-Topic: [PATCH] loop: LOOP_CONFIGURE: send uevents for partitions
Thread-Index: AQHZWytozYciLIbhwkShDpDdCHUWIq8NuZ0A
Date:   Sun, 26 Mar 2023 23:09:12 +0000
Message-ID: <21c2861f-9b7d-636e-74e1-27bd7bbb1a4f@nvidia.com>
References: <20230320125430.55367-1-hch@lst.de>
In-Reply-To: <20230320125430.55367-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4165:EE_
x-ms-office365-filtering-correlation-id: 153ce044-c47e-4748-fba3-08db2e4f1d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTPQtD8TQzUtijwTte8U+JVzE5u51Mzyu1/ma3fXztrbED4Eic8JYNI62yTRNKQsqeM5AKwBEkUtmcx42oULviSVHb/Sxrol1GRDH8BnTznkEmoKH7FL0/xBPCPjEmMnkG2DNx1aFJPk6ndkrNCqowC5Fz0540+EQO77kAoSuA+uKoxntWCDEJiZlg6WO69TjsCEvQNAjf1sU2zgfr8igzwwII2ds1eUcfZs+trzfQFZ1+1OwxZuWeezdhy+A25/8d31hW8DwLJkDcN/fjV95DuCg/qNLEquknJbCnyN7uFeuepTfNH3ufo4f1Zp+bxdmZyrhN9YGhymrzJxeH71m9J1wpu5UGGqH6YkCwvr2LX0pVNcofAwQHE7vzjdCEKhhOA1JT2moztDHv9yA4YqbDd6dPUIJFahj8fJFFzsEBdZ4StO9D/Nkbu/DuwAEaqEsmhw+OfRA8qeLqweby7lMF9muRI/P3+80gADjXab8BYWx16WK4UKRGzhUTIZ7WIYVAr9QGkY095fmhDlQtzKsrkSrHX6HS3/zC9G1mxiUfSw6uzXRYn4sU6KYqiarak4Rk3nuTsO1zaD9kNOCcPPqcC1QYvYXoBHYvuThCpxJVOUny7GFk6bufwfGha4ydHRf9XEAokbYC2CSYVWZCP3Xn9IdijaEIcFSkWiVe8MEOmNmF8AU9FptNr5JjADDeUQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(86362001)(31696002)(83380400001)(186003)(2616005)(122000001)(38100700002)(38070700005)(36756003)(53546011)(8936002)(5660300002)(4326008)(8676002)(64756008)(66446008)(66476007)(41300700001)(66946007)(76116006)(66556008)(6486002)(6506007)(6512007)(316002)(110136005)(91956017)(71200400001)(478600001)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z05PbERBWm1DUUE4elJrTzdRME8rdnlhRnBlUkxNL0k1R0NGcmh0ZmFHUW5D?=
 =?utf-8?B?eklUbDVxcmluVE1QZXdnMW91SUpxMnUxSThFL21sTmFmM2Z1K2orMWg5ajZm?=
 =?utf-8?B?SU9UOGRMK2orY1pDZ04xR0J3YjMra0ViVmU4TnVxWE5TMk5YSnhoYzN1dDVy?=
 =?utf-8?B?SzU0a29Va0ZGTzMrZVdocFZTN0FkMENUMFR3R2RsRDl0d0RKRTkzOEpUWlV1?=
 =?utf-8?B?ZlJmTjlvRmJSWENFK0d4bW5RSys4VlV3QlZiTXFCSU9zbWJlbHpIbTlDbWxh?=
 =?utf-8?B?eGhNM0NPVlA1WEJTV1ZPejNrQlVJWGhGS2QxVzl6d1VBQkFnY0QrM3k1WnhU?=
 =?utf-8?B?aHU0a3UvaWpUaDlWRVA3Rjl3RmpLN1lzNHlUS3RNV05WbitzVVlucTJ2SVF1?=
 =?utf-8?B?Z0lxcDlSNk0xbHNHZ1Q2M3ZkLzR4SzRUNm1IaEdHYWVDOS9nODNmL2p3TkNC?=
 =?utf-8?B?QTNmWUYrWFZicCthSk1GbGFvRithRnVBSmVNUEFOc1pQYW1qeEd1SERJcnJD?=
 =?utf-8?B?cWhKVXYwdXgrQTMrZVlWT1FsVEE0VTQzazRSRlhIdlA3aFl0ZW5ub3c5eGdj?=
 =?utf-8?B?U09ad0hWMWhZd0ZFWmExY1hmcElhYUMyajhCUGFaR0c0OHV0Q1F5VHFFdGEz?=
 =?utf-8?B?aGQrZCtLRXBqQ1V0NXAvY0Z3SzNidVRZUDQ0cHN2NllnLy9VZlVDOTdCUFU4?=
 =?utf-8?B?eDM4SUNNV0c4UGk5OTJ4ZkJaM3pSTEE3L0Q2WWdxSzR3VHJpUzh0SnYrWTNv?=
 =?utf-8?B?UG5HbDBrTkliWWhvYW55UmExQm1HdnVxL3Rhb1V1Mnp2YmREZ3AzQS9UbzEy?=
 =?utf-8?B?aGs1dEJhRjdWTDVqU0pMTnVFbUJubTVQVENFNTh4TmxuR1haRVNVTm8veU1y?=
 =?utf-8?B?a0UzOWliaFhqRloydnpPZys2b2hkZEFQbG9xbXc2Q0V2NHZ0cVordGJBaTY4?=
 =?utf-8?B?NTU3cXEwV0ZPSG5lVjVZTW5GUVZReHNzUWtOSzE0dU8vUWNsN1RtUnFKOWVo?=
 =?utf-8?B?REVuSXBPOHkyL0tyTlpuc2twNngwSURMeHpPaWdRN2JYMy9xSGtaWW5ycm45?=
 =?utf-8?B?WXc4ZGU4a3ZiWHNrT2pPcXc5UXAyckNZUFUyanpmejRDZDJUS1AzY2J3K3Fq?=
 =?utf-8?B?Vk53b2JYY0pHNU8xalV6eGFQa1UrM3ZDZzlzbmpVbC8vcHBhYWZwbWFaODV2?=
 =?utf-8?B?MDdTaGlqdXpKYjdzUUdGZXpyeWV3VzFnUWxZUGlRenR1L2hraXpuSGpJVWhT?=
 =?utf-8?B?RnNBeDNkVGhSTm5rL3JtNlAvcWpLamMyS3A0aHRDSnRoNFVzanc2bWIxS3pv?=
 =?utf-8?B?OXhxUnNrRlpWS2JlRnRFbDR5cWRHUGFFV2xhTVAxcEY4YkRJdnZOcGxYOEdQ?=
 =?utf-8?B?Y0VkUnFFcUcwNzJOTDlub2JMRzVPQWVuc1Uyb2l6VC9vd2ZMcW5oSlJEc2Zs?=
 =?utf-8?B?T2lVOFU3UENjeTIwNlY0Ykd6L3FQQyszTlMxUVIvbkIxRVV1VTlGL28yVTRl?=
 =?utf-8?B?djdHY1lxaEp1amtYR25xM2JzdjdMOHo1bE1wQmRpc3M4eW1mMEI1RG0xMHRP?=
 =?utf-8?B?MTdqeVJ0VkxSUUg5dC96dDMzSlY3dTZBZ0RibnNPT2UweWFGcThaL2k5TFdw?=
 =?utf-8?B?d01jOTZ0cTlBZnl0MlpsaGtFajB1eE9TbTVaTGtnQlJLMGQvWlhWVkdrMStv?=
 =?utf-8?B?VDlKamwxVkIvWEJlZHY3U2xpOXpwL0hUS0tJSjNMRVFwSGhEcGFGek5BVVFL?=
 =?utf-8?B?Z0hLRTZTbDdHREh5ZVF6WlRkMTBPODg2MTF2VFdSc1FCS1NlNVdvREwxZ3Nx?=
 =?utf-8?B?b2R6MEV6bUVhSGZ6TTU1Y2ZKcFVqT3NnWWxrZzdxajl4cFVNWWhjNVRFYXA5?=
 =?utf-8?B?N250YytBNkVEK2x0N09uSlNHcUtVaU5tdERaNjI4R1pIS3pTVkJ0U1pQc0NL?=
 =?utf-8?B?QXkzdW01SmZTUnE1Mmk1SkVDN0xOUnBzKzlYamdpUEordHZjdlpVTVhXUmZM?=
 =?utf-8?B?MUN3T0orN1dpMG5iYjNiK3ZhY3dEdmNnU0dSUzN5VUZLMWNwQkhoTFlvQlpC?=
 =?utf-8?B?NVRmOHp4TGs0MkYrUkYzTkJ3QVhLeEw5U1luODdvMTI4TGNxdmFRY0NmRC92?=
 =?utf-8?B?ZnBMZDlUWVEzR3Z1Y29MN2dQQzRVL0ozY1RPTURxVkJLSldFbDYvUTlNclI0?=
 =?utf-8?Q?s8WUGEpcFSeU2tMuZ9ypQlnToLEXH9mZ5xlCKdi18dzx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEF6D6A72CEADF4BA0286F90D5A73609@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153ce044-c47e-4748-fba3-08db2e4f1d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 23:09:12.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhon2uHHVY1RV28zfWpURdAH5LtWe9lpEPpFJ4G1JcUPvmJ9Em8hKAwt4aE7oZq0X88K/CbP9VM8wyB43B8xLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QWx5c3NhLA0KDQpPbiAzLzIwLzIzIDA1OjU0LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4g
RnJvbTogQWx5c3NhIFJvc3MgPGhpQGFseXNzYS5pcz4NCj4NCj4gTE9PUF9DT05GSUdVUkUgaXMs
IGFzIGZhciBhcyBJIHVuZGVyc3RhbmQgaXQsIHN1cHBvc2VkIHRvIGJlIGEgd2F5IHRvDQo+IGNv
bWJpbmUgTE9PUF9TRVRfRkQgYW5kIExPT1BfU0VUX1NUQVRVUzY0IGludG8gYSBzaW5nbGUgc3lz
Y2FsbC4gIFdoZW4NCj4gdXNpbmcgTE9PUF9TRVRfRkQrTE9PUF9TRVRfU1RBVFVTNjQsIGEgc2lu
Z2xlIHVldmVudCB3b3VsZCBiZSBzZW50IGZvcg0KPiBlYWNoIHBhcnRpdGlvbiBmb3VuZCBvbiB0
aGUgbG9vcCBkZXZpY2UgYWZ0ZXIgdGhlIHNlY29uZCBpb2N0bCgpLCBidXQNCj4gd2hlbiB1c2lu
ZyBMT09QX0NPTkZJR1VSRSwgbm8gc3VjaCB1ZXZlbnQgd2FzIGJlaW5nIHNlbnQuDQo+DQo+IElu
IHRoZSBvbGQgc2V0dXAsIHVldmVudHMgYXJlIGRpc2FibGVkIGZvciBMT09QX1NFVF9GRCwgYnV0
IG5vdCBmb3INCj4gTE9PUF9TRVRfU1RBVFVTNjQuICBUaGlzIG1ha2VzIHNlbnNlLCBhcyBpdCBw
cmV2ZW50cyB1ZXZlbnRzIGJlaW5nDQo+IHNlbnQgZm9yIGEgcGFydGlhbGx5IGNvbmZpZ3VyZWQg
ZGV2aWNlIGR1cmluZyBMT09QX1NFVF9GRCAtIHRoZXkncmUNCj4gb25seSBzZW50IGF0IHRoZSBl
bmQgb2YgTE9PUF9TRVRfU1RBVFVTNjQuICBCdXQgZm9yIExPT1BfQ09ORklHVVJFLA0KPiB1ZXZl
bnRzIHdlcmUgZGlzYWJsZWQgZm9yIHRoZSBlbnRpcmUgb3BlcmF0aW9uLCBzbyB0aGF0IGZpbmFs
DQo+IG5vdGlmaWNhdGlvbiB3YXMgbmV2ZXIgaXNzdWVkLiAgVG8gZml4IHRoaXMsIHJlZHVjZSB0
aGUgY3JpdGljYWwNCj4gc2VjdGlvbiB0byBleGNsdWRlIHRoZSBsb29wX3JlcmVhZF9wYXJ0aXRp
b25zKCkgY2FsbCwgd2hpY2ggY2F1c2VzDQo+IHRoZSB1ZXZlbnRzIHRvIGJlIGlzc3VlZCwgdG8g
YWZ0ZXIgdWV2ZW50cyBhcmUgcmUtZW5hYmxlZCwgbWF0Y2hpbmcNCj4gdGhlIGJlaGF2aW91ciBv
ZiB0aGUgTE9PUF9TRVRfRkQrTE9PUF9TRVRfU1RBVFVTNjQgY29tYmluYXRpb24uDQo+DQo+IEkg
bm90aWNlZCB0aGlzIGJlY2F1c2UgQnVzeWJveCdzIGxvc2V0dXAgcHJvZ3JhbSByZWNlbnRseSBj
aGFuZ2VkIGZyb20NCj4gdXNpbmcgTE9PUF9TRVRfRkQrTE9PUF9TRVRfU1RBVFVTNjQgdG8gTE9P
UF9DT05GSUdVUkUsIGFuZCB0aGlzIGJyb2tlDQo+IG15IHNldHVwLCBmb3Igd2hpY2ggSSB3YW50
IGEgbm90aWZpY2F0aW9uIGZyb20gdGhlIGtlcm5lbCBhbnkgdGltZSBhDQo+IG5ldyBwYXJ0aXRp
b24gYmVjb21lcyBhdmFpbGFibGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFseXNzYSBSb3NzIDxo
aUBhbHlzc2EuaXM+DQo+IFtoY2g6IHJlZHVjZWQgdGhlIGNyaXRpY2FsIHNlY3Rpb25dDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBGaXhlczogMzQ0
ODkxNGU4Y2M1ICgibG9vcDogQWRkIExPT1BfQ09ORklHVVJFIGlvY3RsIikNCj4NCg0KQ2FuIHlv
dSBwbGVhc2UgYWRkIHRoZSB0ZXN0Y2FzZSBpbiB0aGUgYmxrdGVzdHMgdG8gdGVzdCB0aGUNCmFi
b3ZlIG1lbnRpb25lZCBiZWhhdmlvciA/DQoNCi1jaw0KDQoNCg==
