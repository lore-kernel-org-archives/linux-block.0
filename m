Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7A5C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJJRk5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJRk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:40:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B53E750
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuT1PecfBPmZeimrAd4jl8bwSiAU80Chz2Ph3Hg+TvSQHWcMObf5K/AoNkes+/5fTo69XEKOqe1P49qVDAv6rTjcvm5lG8gJWweZoC1bWUzB8IAEazR6x9kv0/59r1lWZwhZwC+3TcmiFGsZZsaBIo27iLI4dMNeKY3yQ1NoZYXSVsPR1y4KUxcXquITmhIAM97Fgv8R5Wr+bDcvHlv6hIYmvIfekxxxWvRSjGV9xIkImL8t5xK0i7pXY34XKqrmDsCYgT0znQ2RBDrUPEogvVvynHK8TJmLp2m19XjuQ37ep975MhpM4G2DAIPN/lsnQrO+df+ha/IU8t5rV4r8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSrJJKzn2hTwlT4DayMX+AbFiy8pFxYZZnqcN3rH3QU=;
 b=YTb7y8kylMu8AU1roJkoeDkCWpcjib/uwICNiQCb02EA4IMvRRstnRu3mxB4bdu4PvgiA9TmfHMgBMxWqRAO+NUYj73XV99BXPVf94Xcj2LUzylzR8alX2UuDKFaKZ0yCd7hiPFgP6OojeLZZn9Jh/hbYA6J9TCu8+6HZ4mkna6bIJDW9bW92iKc3FnNYuxdU0VhgF+nopPSiD2iGB9xjYvnGJXlnyHVOrIOeWxDP470eyRi/zGMfYk0fwBKTptKbPa5QUJNQafQq2lVywq6UMejsFGpp0kB0dcN7q+y21C8np5r0X06e+6XM8EspCBUi5kYbpLSXagMzcxLris+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSrJJKzn2hTwlT4DayMX+AbFiy8pFxYZZnqcN3rH3QU=;
 b=kmGRA0t3A4nyNlUtv89pJaEG4W/7Buk1RyTQCrOfyqQXQRlPdlZQKsNS12hVISogzKmQ7D+U6BO/r/tJu+Epb2KqMrAwiElJj73tcAqbt+GhfC1h1wYSWkYu3rTIfCJgkam/OV8qQ70XmdwrJvTYX0MZlCVDiVCxPwCXSfdlIvlwMPgfdurhqlhca5I+cxd3Pp8s9w35RI9cpDoFXAQ+VZrMvbPzdCKx3NUjXj8B5w4Knh3ovlGEUpDDMXuHjYZjDtM1XUAhoizgU6RK7G2P7NbEYR4gjakhK3qSJx8SRzbE4Da4myH7wQUXTBH91uLCqbWjw4nB1HTsVfqjRHLQkQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 17:40:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 17:40:53 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
Subject: Re: [RFC PATCH 0/6] block: add and use tagset init helper
Thread-Topic: [RFC PATCH 0/6] block: add and use tagset init helper
Thread-Index: AQHY3Mnd+5T5lvMf706+WNic8StDyq4H5U+A
Date:   Mon, 10 Oct 2022 17:40:53 +0000
Message-ID: <ca1d6d12-4298-c93d-3d1f-88846e80e830@nvidia.com>
References: <20221010170026.49808-1-kch@nvidia.com>
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5234:EE_
x-ms-office365-filtering-correlation-id: 78b68087-8344-4c0c-49e4-08daaae69488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8NCZrdjywktshn2oECrMx1l5TXc2A9MIUk5Na6LO+Jxzv3DcoYj2jRMhWG6TfBCXXIvV4GzsuHrEWFJmUi58yQDF5gncUnnjM/05vHty6i6ZUf4XRafrW9PpGBa50gtHaKiY1k2Z+zlxHlMSfRjjyq9iJlGr/S/2HzciwPDEWzQoip8EwI0eiOlMtvJlPVZVYUq2bU8/S1lyboqF4gzcAuyG2gZj99JFdZs6UV+HJuXScYRI2zxMWaSLFVuuIuysQ11wbicFOLaHyf0pfUDEPbkkvacQQyFf0V9IINHtwVYSx0ImOokBVwq1KsGaUJwflRnWUXO1815BN2D+odIITgXJEArnAJvuP9cAkkkw3BPZh9FcHiKCvfjoCbDdaUdyhLQ6lSG9gojQPzcx4xm33Cq7H2oKOjQV00wa+3JjwaYssdQt/60aiSVk6hKDVZZuEsArfi27Q6/mnvR22q8/CwxL1LGVqzEba+Ryj5piRtltsqVtnE2vaMp0u+ci2mTdAH2fTvwxlWVTC4KlQ3ohOD6d4fgVQgtZt+yeFkrRnD8qA/eF0aA+U/e+tQvaC8uX5KUMXiYSZ91khM1cJpsqdwJS30y50rpT+VzNLE2Ek1s4fiaaUjFA6PO7R/DJXK7j5Veuo95ahnwvCtkg/ToIMXrtbL5/APCFidn9Fd9n9Bk5Jexx+NmjS35uI/MdcBr35QXp3mlYr0mQ3kLPGeVbFsfZUiZyMdcqj/rLnmnRr43DoefC3J2G6DU3NFJI+FpXkCvHMe1RQlVXDgkgaVxk00x+cvaPM6Q53+q9GUEmUIGjCYZwyVmSOJYPPdysl8IJ8wiJ4KctAAklVEkzAvKzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(8936002)(478600001)(6486002)(71200400001)(36756003)(64756008)(5660300002)(66476007)(66446008)(4326008)(66946007)(91956017)(8676002)(76116006)(41300700001)(54906003)(110136005)(316002)(122000001)(66556008)(38070700005)(38100700002)(26005)(6512007)(31696002)(2616005)(86362001)(6506007)(53546011)(186003)(83380400001)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEp3b0E4TnpMK0pGUTFUM1phUmdZTVJQRFhjdk5WY1B5RlNaL0hPdWNidVhY?=
 =?utf-8?B?UWdVRlR4dG9ueDh0c3JJYW1RNEd6NGd4eUR1UUpLZkhyYnd6blA0QXNtSEZ0?=
 =?utf-8?B?RFF2ZHRvNHVJanZzemp5bVA2bndoV2ZvRjhmdmFNVGE1RXlsWFY3T2IwRXpL?=
 =?utf-8?B?ZWN0Z3lRVjJTN3VML3lXbE1YS0NJdzVzOVowbTIyQnhXUEZYWXpmaDVtZ3hp?=
 =?utf-8?B?MFBqcGtrVFFIVXhkcjVxTmNrQ2g4MU9ub3BnNDFmeHlRclJ1UWVXbmxMaGli?=
 =?utf-8?B?YkgwUU9DYjRhdDNNTWcybFYwVnhZUDZvd3lYNGRDNmNJQ0MvMWRLVUpSSnpj?=
 =?utf-8?B?K3RGUkNrK2QwUDhiMWVtblo4SHZ4djhKM2Q5WW1mQVQ2anFzeWJVbzFGLy9p?=
 =?utf-8?B?Wm5GaTA3SVRtb1NieDVUc0VhYk5pT1AxeHRJdkRjRkpBVVFYdnJncFZsOXIx?=
 =?utf-8?B?M0k4VWlTME9Ia1I0cDlHbjVwRWZ2ZGZUK2ltR2piYW5oYzRKU2FnVmJpU1ZH?=
 =?utf-8?B?cXNoSEhONkNEd2dQcGV0dW9WTkQvckNQMzNRdnVJaGc5UGZyTXdHRm4wSkhr?=
 =?utf-8?B?ZlZIYmRVdy8wUmhxQjVQYlJKUHQzQno0TUhGV0VHWnhaZktoRXozbmlYYzlO?=
 =?utf-8?B?a2F4Ym16T0hyMXI5bUFRSkV0TGdjTkc0R2tZdU5MK09IYlQ5NWgxRDlwYzFq?=
 =?utf-8?B?U2c1R1BVbENXUUt0UVN6R2ZpWUlUYVE3V1UvOG5xdmpTNWN5QlhxcjJiZkVm?=
 =?utf-8?B?dWFkL2R2Z2d3UkMvd3hwUkRoUU5sbWRzeUdkVEc3N3RMekl1OHpQT09hVldJ?=
 =?utf-8?B?Tk9YSUlDQ0dubFh5QlNqUVZ4N2ZvY1R5RUNQSFI2YkxXK0I2a3IwcSt4Z1Z6?=
 =?utf-8?B?dWV4ZVlBYVhFTEZIQUZRRitkaEpUU083aGJaWmFhTEJ3UExiQ2kzYnFET0Nt?=
 =?utf-8?B?THN3TlNYVGloYk5sMHc0Zjdmdkg5K0pkcjVIdGRBUjRXaGplSHpWUHpUd3J2?=
 =?utf-8?B?WktlVjFVTlFXYlhKcGZQY2ExLzFZenZjVXhITXhyYzNJUGt2Z3JCdjB5bEF6?=
 =?utf-8?B?c1hhZlhoaU02cWlYeDBMUFgyVUVrRmQvdjhJcEVTd05DVEU3ckhNTlNpWWl1?=
 =?utf-8?B?d1RuRmtCbE5VanRGMTdZVXJlMmwrbzRjeTJyTldyTEhVbmZXb2p4N0lxWE1v?=
 =?utf-8?B?MmJISkJoSlVWK3ZINGxGTThKaXBvVHNhbGVxSnovVUJEaU1iS1pyUVQ4d0VR?=
 =?utf-8?B?N2ZsMDFmS2l1T252am5iNzlURFA2TTQxV0FUUC8wQnBpVFM4bEFQVWU4Kyt4?=
 =?utf-8?B?cTJwVUhBZVhwREk4SVlMNmx0NmNwTDRsYk1lakVsVFIzeit3WGJHWHMvUi9p?=
 =?utf-8?B?VThwc1VpTXNPRWJ5WkFBanVmN3ZPd2trQVhvT3UyT3FTRVVYOHYzUTM1T2U3?=
 =?utf-8?B?WXB1U1pvMXV1c1NuNGdrU2FUUE9RMVFLVjRaQWl3Q3B0RnE3QXVsVjhMZ0Jw?=
 =?utf-8?B?NmI3NEN6dnM2QldWeE1WbGI0UnF3ZHdPOFpFd3VCcGxPK3dKQi9DMWRMTmNV?=
 =?utf-8?B?S0wxcTN3eThia09nMXRXT080b2dDZ1haL3dRTTlFOHNPMHlhZ0pvbUZ1ejFJ?=
 =?utf-8?B?TWdUSmZHSlVydDV0SWk1NXU4Uk1zQ3JXQWd4US81aXc0YVJPV04yakh0U3V2?=
 =?utf-8?B?Z0RnM0dwOFArZ3BESmxhNC9PS0JkeEtCY29hZExzU3dya2lFRWJBYmJKS2pu?=
 =?utf-8?B?bUJyR0h5QmJMNkFxTkpYRXE3RE93bGtvUWpqYzRSNkhSM0R2TXhzNFIvT1dn?=
 =?utf-8?B?NXVGTnc1OWZMczF3Vzk3RlhYNDVtUjZRZldWb0QrakJSdmd4MmJaT3Z3Z2Zl?=
 =?utf-8?B?K1ZqN1p4cExQck0wOGI4RUpkeEN1NE5SRzd2cXlJR3l4emJxcU9GOTBZV2JQ?=
 =?utf-8?B?YW1OK0lUbktBU0JKOEQrd0lYT3VyMVlnRkZpZXc1cU83MU5YQjVOcmNQVndv?=
 =?utf-8?B?VDdnNDRXU1JBM1ExNGdJUHoxS2tGQ1l5cndQTkxGNjA4YitnbVRIb2RlanNL?=
 =?utf-8?B?Tlh3TFpuMkxKT0IwWW83cnRRSTBxQnFlSGorQ2VQQkVaQTRKSWk0UW9jMzhC?=
 =?utf-8?Q?el9GioaOZxXIBbYFyunM1TRu/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF5C4A928776524A9B9E930EBFCD4510@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b68087-8344-4c0c-49e4-08daaae69488
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 17:40:53.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPUbrsEzxCITPp98CZYguoK7pB9NxCG/rgsFZF6vtSTJQwPvNRkg8pR/kGSH5QjPXiYm7s57RVF/s9wKNlp9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTAvMjIgMTA6MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gSGksDQo+IA0K
PiBUaGUgbmV3bHkgYWRkZWQgaGVscGVyIGJsa19tcV9pbml0X2FsbG9jX3RhZ19zZXQoKSByZXBs
YWNlcyBleGlzdGluZw0KPiBjYWxsIHRvIGJsa19tcV9hbGxvY190YWdfc2V0KCkgYW5kIHRha2Vz
IGZvbGxvd2luZyBhcmd1bWVudHMgdG8NCj4gaW5pdGlhbGl6ZSB0YWdfc2V0IGJlZm9yZSBjYWxs
aW5nIGJsa19tcV9hbGxvY190YWdfc2V0KCkgOi0NCj4gDQo+ICogYmxrX21xX29wcw0KPiAqIG51
bWJlciBvZiBoL3cgcXVldWVzDQo+ICogcXVldWUgZGVwdGgNCj4gKiBkcml2ZXIgZGF0YQ0KPiAN
Cj4gVGhpcyBhcHByb2FjaCBpcyB0YWtlbiBzaW1pbGFyIHRvIHdoYXQgd2UgaGF2ZSBpbiB0aGUg
Y29kZSB3aGVyZSBoZWxwZXINCj4gZnVuY3Rpb24gaXMgYWRkZWQgdG8gYWxsb2MgYW5kIGluaXRp
YWxpemUgdGhlIGNvbW1vbiBjb2RlIHRoYXQgd2FzDQo+IHJlcGV0ZWQgaW4gdGhlIGNhbGxlcnMg
Oi0NCj4gDQo+ICogOGMxNjU2N2Q4NjdlZCA1IGFyZ3MtaW5pdCBhbmQgYWxsb2MgaGVscGVyIGJp
b19hbGxvY19iaW9zZXQoKQ0KPiAqIDBhMzE0MGVhMGZhZTMgNSBhcmdzLWluaXQgYW5kIGFsbG9j
IGhlbHBlciBibGtfbmV4dF9iaW8oKQ0KPiAqIGNkYjE0ZTBmNzc3NWUgNCBhcmdzLWluaXQgYW5k
IGFsbG9jIGhlbHBlciBibGtfbXFfYWxsb2Nfc3FfdGFnX3NldCgpDQo+IA0KPiBXaXRoIDUgYXJn
dW1lbnRzIGl0IHNodW9sZCBiZSBlYXN5IHRvIHJldmlldyBhbmQgd2UgZG9uJ3QgaGF2ZSB0byBl
eHRlbmQNCj4gdGhlIEFQSSBldmVuIGlmIHRhZ19zZXQgZ2V0cyBhIG5ldyBtZW1iZXIsIEknbGwg
Z3JhZHVhbGx5IGNoYW5nZSB0aGUNCj4gZHJpdmVycyBzbG93bHkgdG8gYXZvaWQgb25lIGJpZyB0
cmVld2lkZSBjaGFuZ2UuDQo+IA0KPiBUaGlzIGF2b2lkcyBjb2RlIHJlcGV0YXRpb24gb2YgaW5p
YWxpemF0aW9uIGNvZGUgb2YgdGFnIHNldCBpbiBjdXJyZW50DQo+IGJsb2NrIGRyaXZlcnMgYW5k
IGFueSBmdXR1cmUgb25lcy4NCj4gDQoNCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHRoaXMgaGFzIGEg
YnVnLCBJJ2xsIHNlbmQgaXQgd2l0aCBidWcgZml4ZWQuDQoNCkFwb2xvZ2llcyBmb3IgdGhlIG5v
aXNlLg0KDQotY2sNCg0KDQo=
