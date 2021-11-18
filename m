Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4262C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D16601FA
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 07:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbhKRICP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 03:02:15 -0500
Received: from mail-bn8nam08on2053.outbound.protection.outlook.com ([40.107.100.53]:11872
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244152AbhKRICL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 03:02:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRbA/r1FdP0cuF2QSOzz24+8ZZm9OlQc7Ka6MEr5sQSGxBic4Ts49KqyFegKS92BV1Ml6q1+XS5EHSxYZ3NFYHZA4NCP8FJmavbRH7Kf/o02o1VVwws35JsnMmRa2C3BKozxhUN4O8MQSGhzQ+OsTsczT8xTrXkommP9lW4bvNoh37D26JuPGSbW3Rbe61KE4wd7DwVDCKzJSE/CkJfepxy7t075GHhf39ZueQucBsIiJamt39Tjf2Fba/g8zLeQohp3wah38AgoYrg8fzUfojleiBAoWe7GsygZKqjqQ9euI9l6jEMPGO7CRsf0ufBgzF85vYVQjNcJbOxG/5r/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMl96cE1ZTYkxRKPXL3URMuFyIyR8gH94Q9LHAXKfIg=;
 b=VIsXAv1W0fxBrbBqt0OapBSz9Q5b2r2i637c4nRN7qGU1pGW+AOI5LQIS9wX2/cBJexbHxFM3pRBATSA8ZQTL7maLLpoEIwCH/ou2WpMmMfqeJihJQpkQxJ4T5zGm+TxTL3uzKxz1HMiB9U3MYJoH11UIac9z1Th5upKDtgPvzy4RTeHl+0+1bYrKb9hm6YVlFQj2gLJAbtZYqf2DtNBDnSyXCX2U9CdCykKjvMKEKjnMIWn+UTfbRDdBRdiTTpO+bR2ZNpXx1eFRKzX5qst49td5S7vtoXhZTqDPaoK7MgWL5RBepHEj9cf2Wx/Kvjg1mMPv1WT/jhE19dBjDF6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMl96cE1ZTYkxRKPXL3URMuFyIyR8gH94Q9LHAXKfIg=;
 b=gzVYMzabRECCSY1CtEAR6BIlkKCoF50ULb+WUQbADWrhfd/nZFhM+EFsd9kAaM5G81Mw/KEdIoymnyBq8SuCmz+YU4tJlKWbNaRggWVTp+5FrmRDHsC1zOVHmV2GKnq/+t5XLTWxgPatKmre88fFwxFFp7uDutq8rnSC282kFXrn8KvEhfeXZDqr0Jj8pYLajtvUTdKEWbG/G1dZt1lc6fnOUdvAkUlS3jWXD74m3OnMGX5hHzPOTR+pKH5OWvAjfJf2cOxNRpcRXza56A7J4qieoocq6bmRsjalIXDFmcVyW+y8Wrv8ESySEPhlYpsv7DqH578s/Ih05XNdiRXwqg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 07:59:08 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 07:59:08 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
Thread-Topic: [PATCH 3/4] nvme: separate command prep and issue
Thread-Index: AQHX22SPwNMXoMNSIkyJ+d1XEtbjVawHPs2AgAGuvQA=
Date:   Thu, 18 Nov 2021 07:59:08 +0000
Message-ID: <53eae428-2b1f-d03d-e16f-774e03e69fab@nvidia.com>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-4-axboe@kernel.dk> <YZSedy1bGe30XEHW@infradead.org>
In-Reply-To: <YZSedy1bGe30XEHW@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4ab67d-f8a2-45b9-1fce-08d9aa694cc2
x-ms-traffictypediagnostic: MW2PR12MB2572:
x-microsoft-antispam-prvs: <MW2PR12MB2572E015C9197C34E1208EF0A39B9@MW2PR12MB2572.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ts+MpuagjGuylkJHzI5Z+fbUwQrQyNkaKRFGcgwBUQx99mGEOvqLZd/op3cE1kpFp7q8w1CihcK2hk4XpVcqyumQG0XuEm4j9EKyDUlXmP3KMJ+8P90MmMdRGWgiW28Vo+69h1EEChLrjAEm9FWuq2tsSh1gpQSvTEHZRS/glohVIMBkhWBJpjOntl5N4Jp3/2L8UqirOp11sicTk3+idVL06YwODUEMplCh3w8r16mXVgmVICENbipRdu86BJpNuKp71Bi8f4gp/4D+jO7Qh/h3UCLUVXwNngN2FC0IvxAsIlqe7zs9gxYhxjE4P0Xagb9aHFlYAf9pQ90bxiRgStiSXvsDKsV9c7NwDrM+Kl4fWADGXjXqjgC8XeQfPb/No825zTHi+R4dHwqesJtSqCQEPXeY3l1TPZ1FLL0/hqJFx9MoXs9QiUApwsYFBW+xSWQEi5wYF7OyAad4DBWHmdFnb3yH6Zd/yVP6eOK8zgB/U+qVNMx8H3f0MqqdHRrU8A75ayH2CBpxyP1w9XZVNQTXcum6x/goGrMOY1Ap4KPCOt/NHMVxv2SJuhrrODauUujyarUlzsiIt0KUJ8n9knKJAEwL+HhYBDoB4nXg5yCLIoarO0M/AtETgZ8tEK6V9fM7LBEnRS1M/X464d+haZKAydf37+A0LWQhdRXy5LYbGXwxHQ3SrIGkOHpFMby1gULZ1YgS36J/nMw/mZA3/2BSdchBn8NY/hu5cOM0rUX/Vfnw1k9Gh4V3Kmsia63PSwtHtwFKzjdKoaGN2M26pP4H0wyP4E1Ii5Pb9C7qe8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(508600001)(31696002)(2616005)(110136005)(2906002)(6486002)(122000001)(316002)(38100700002)(91956017)(66446008)(8676002)(8936002)(86362001)(4326008)(66476007)(66946007)(76116006)(83380400001)(53546011)(64756008)(38070700005)(6506007)(186003)(4744005)(71200400001)(5660300002)(6512007)(36756003)(66556008)(87944003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFo4Q2JoQVZUK2grMDUvK29kMVVjNlR0NHlPcTVOOHZhaEh5Vyt1K0c0Tmh5?=
 =?utf-8?B?eE52SmQrdXRVVElrOVdLLzZNTG1EazJCS0xhR2Q1MFRNai9LWGJLV0J3SU9t?=
 =?utf-8?B?aUNoVkVSVWJrZ1MyMHBYaENJY0hVNUE0bFg4WndHQUVWK2lXZlV1TXZuaHZt?=
 =?utf-8?B?UnUyVGt2UjlNdkVkMU95R2VZb2h0L1p2RmFNNmVvRkV5azZUaWFwblRrakFT?=
 =?utf-8?B?L0ZLY21aQmZWZ1FhckRYNUY1SnpSY3VaWUtrc0piT21iU0JCT0xySDZ5SUdP?=
 =?utf-8?B?VEhjdjg3T29IVG9LR3AvMGdNV3VyMk1FMHNnMkNYS1RkQ2gzSnNOQnRMMlRm?=
 =?utf-8?B?NEg0S3dyeTZCS3cwRDBJbm5ibG5yS3lQbjFDRHYvVE55WWNMTHczMzN5eXVT?=
 =?utf-8?B?a3o4dUVXTWZocGRCT0FKb2huUHZHWVN6S0NtZG4wL25nNE1YQ0JnTUgvYjBx?=
 =?utf-8?B?N3hjR1NpY0pWZ0VlQ3dWSnFSckJLT2RrcXNQSGJvdGZFTzVXUlgzUERNeURY?=
 =?utf-8?B?M21iT0NOditFZENucW1CMWpZdTlIWlovUDRxMnF6aUJIU0pPME1vVW16WG9R?=
 =?utf-8?B?NnVRUytJb002N2NnMmJ3NzV4Tm1Ka1hGVGo4QjZ6U3BRQWxySkQzT2lFYlVT?=
 =?utf-8?B?Y2F0WE81MXNNY1BLbjRROFhLUXhvRmN5M3RSU1RyeDl2dmttVWdNWXNWckF0?=
 =?utf-8?B?dUNucUkwOVVSUUpiN2k0bGR6cHlyVDArbDJzU1c4ZGNxOHdVUW0xaWNRMlh2?=
 =?utf-8?B?cEZPYlBNd0VJdjAwWS9zb2xCanhiRkFXRlNzOEwvWDE3K3NWTXJFdXRSZjdo?=
 =?utf-8?B?b3N5S1RaV3phMEczQW84ZGY5NWNWSEVNVmtidmRCdFhVMnNVMmZLaldQUHJz?=
 =?utf-8?B?ZzhhQzkxNlFuQXdNQVhVbUxScWZMMEZYZTFRSmswWDFwcVRWemF2MWZ5Wkho?=
 =?utf-8?B?YlhBdjYvMzEzdWt2VVFPYlJ1V1p6QW9Eb0RJVFdaRVBUcVU0cGtQWFZLVWRj?=
 =?utf-8?B?eE43VFZHTGp5SUkwb29MM3I1a2JYaENVeDBzdmtxNWFNZEc5eCtDUTJLdVdn?=
 =?utf-8?B?T0VXc0djYmszd0FkSCtxMENOYWsrMlBoTU9UaWxWU2wwa1BZbWQ4ZWhCL243?=
 =?utf-8?B?dGpsQVQ3U3RNR0hZbklvbHlBTVFxcXRTT2gwVDA1M3RPa3NwM0dVV0tFZkpa?=
 =?utf-8?B?SDUxNWxBeWNSOFN3YitpQ1g5cE0vSTZmQWVLRWFZRFljTTczYmEzUEhhcHgv?=
 =?utf-8?B?QVN1MjZxdWNiYW0wcFNDTXU0djZjVnJMZkxMRll4aUZ1UElGT3UzVnF2eENr?=
 =?utf-8?B?WUVQS1NZRk9zYzlnUWRkM0hIQjR3cjk2UEtGaHFRVS9lUlFWbUsrTTByWDk4?=
 =?utf-8?B?UEFBeUNESVMrS1NnNU5OVUFabUpybmZYWm1rZHJYaVlZY2d4eU1ZUzFUQzVF?=
 =?utf-8?B?SjJubGd3a29YWkREa1R1eStqTStmWGpiaUZxbzBOUkp1bE5wZWFJNklQODcw?=
 =?utf-8?B?WnRoK2lPZGgySjZDWmpRWkVCMUkwVWxVMDBDN2FrY2tlMjlUcmVBRFRDcFY4?=
 =?utf-8?B?OEgxTDhWei8rbWhoQXU3Y0VUdVpZeWNrcDBBaHdBZ0VEekFGenJJOGh6RjM4?=
 =?utf-8?B?aUdOT253Vms4NGdqN09zL3RnV0w3ZGxsTTBRWCtXZVBZRlpTcFMwQm90YVNO?=
 =?utf-8?B?YW5tZldPM2pCOGt6SGFCY0FNWnVsemVuUUNBUUM3UWhuWUx0c1A5c00vNjJ5?=
 =?utf-8?B?RGJLaVVIaVJWcmI1VmkwTE90VjNrTHdxcGJPK2NPMUwzVEQ3bGlJd1ZIMElP?=
 =?utf-8?B?NGdCRjh4WFJQdjM5VGNrY00zNnBTZDQ4WS9Pek50Zmx6MmVOaFZDdlliVGF1?=
 =?utf-8?B?UWpiVXk4SERzQmtKMk85dUR4dXl0eEZoejE1MEs1emRGUDhOTG4vWkJ6cFY0?=
 =?utf-8?B?ZDI0SVl4Q3lqNXhhcXo4THFnb2IzN3ByQjFDU0tKQkVDWCtkNElreGY0R3N4?=
 =?utf-8?B?WlY1T01rQkZ1bVQzU1hhRDk2RTdpTVhQTFd1ckJpVDMrL0MwWHNlUzRvT1dl?=
 =?utf-8?B?S3YrWG1pNzJRdDYwL3FyWmNyVWwxaHQxRFBZdk5tNEx2eTh3bFUyMzJyMXky?=
 =?utf-8?B?bUNZQ3N3c2NPY2NkWUpsTHZmM0hkZTdDdkg0SXpXQ3QvSzNqOWthS1lYOGlw?=
 =?utf-8?B?SDRtVWpZSEpSL08zcmt2eXp1b0dVVVlOR1ZySWhyc1hHaXN3cER0dVlSajJC?=
 =?utf-8?Q?11CDcMUA1bmOZc5smlbaaajwg5D+27DB0fwKXWkwkc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4828E51DF791A45BE4B9FEACB7BE528@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4ab67d-f8a2-45b9-1fce-08d9aa694cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 07:59:08.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yu7/OWm4DuRz4OHyK7otlnESSKRXPdCPHWXGNwJcWI1HWwRDKlbCP56yJ1Bdw1aJYLph3Z12In2i3ngfM0etcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMTYvMjAyMSAxMDoxNyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFR1
ZSwgTm92IDE2LCAyMDIxIGF0IDA4OjM4OjA2UE0gLTA3MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+
PiArCXJldCA9IG52bWVfcHJlcF9ycShkZXYsIG5zLCByZXEsICZpb2QtPmNtZCk7DQo+PiArCWlm
IChyZXQgPT0gQkxLX1NUU19PSykgew0KPj4gKwkJbnZtZV9zdWJtaXRfY21kKG52bWVxLCAmaW9k
LT5jbWQsIGJkLT5sYXN0KTsNCj4+ICsJCXJldHVybiBCTEtfU1RTX09LOw0KPj4gKwl9DQo+PiAr
CXJldHVybiByZXQ7DQo+IA0KPiBJJ2QgcHJlZmVyIHRoZSB0cmFkaXRpb25hbCBoYW5kbGUgZXJy
b3JzIG91dHNpZGUgdGhlIHN0cmFpZ2h0IHBhdGgNCj4gb3JkZXIgaGVyZToNCj4gDQo+IAlyZXQg
PSBudm1lX3ByZXBfcnEoZGV2LCBucywgcmVxLCAmaW9kLT5jbWQpOw0KPiAJaWYgKHJldCkNCj4g
CQlyZXR1cm4gcmV0Ow0KPiAJbnZtZV9zdWJtaXRfY21kKG52bWVxLCAmaW9kLT5jbWQsIGJkLT5s
YXN0KTsNCj4gCXJldHVybiBCTEtfU1RTX09LOw0KPiANCg0KcGVyaGFwcyBjb25zaWRlciBhZGRp
bmcgdW5saWtlbHkoKSBmb3IgdGhlIGVycm9yIGNvbmRpdGlvbiBhYm92ZSA/DQoNCglyZXQgPSBu
dm1lX3ByZXBfcnEoZGV2LCBucywgcmVxLCAmaW9kLT5jbWQpOw0KICAJaWYgKHVubGlrZWx5KHJl
dCkpDQogIAkJcmV0dXJuIHJldDsNCiAgCW52bWVfc3VibWl0X2NtZChudm1lcSwgJmlvZC0+Y21k
LCBiZC0+bGFzdCk7DQogIAlyZXR1cm4gQkxLX1NUU19PSzsNCg0K
