Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 07:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbiEKHby (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 03:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiEKHbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 03:31:52 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6BF73575
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 00:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkqfH4dXMGblE8czMWSUJIOD/rnyaaEhUf/BoOzO9Uv2aOhaVLKJo36eWWB8oWonPM8Cr/fljHbhxJE9GgCYn/DGJj5433qtpza1meQtoaCQeFEiULxOvam2XyNDGbw0unDPmggrFQAXXUOH/ox6do72LaPwKPc0uGSrDPzZgBAGTUjyyCch2cq3fc11S00z2Pr7pHo8asNyi37NR5k7FrDxx5Kb1VSXstwjCLJoTRkEbQTajPoZCVB/ARqs3AoivUZAlDiuDy/cKLbCDBKv0UJ3lTyju+8iekxW6g+/AHNaoLKRQ6sgt1mu4nBVOUxZivFBgU1MkjEUSm3J3QQf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1/GJ1xyPPOGW5wAi6SyBFw3mc3mUMqtCf9iHGsJrbk=;
 b=TaEYdf0psfap339w/6rFQ7Os3u80Hm+C3bS8rdNJ61F/5D49RD9bdJ/jgs1LBf/ELNnhjIFE8PBlTox0CpHbVdUdOqpr7LonjCMR1YI7Bwc+pTj+aGSsr94IuA7CnhwoRRAJ1JUUlw7UyGqe/Ru+a5A7UeWkD/DTFvOAcQ6jTI9xl5B3UZ3Ak7BqveAswqtUye0mK5l2pMZ5cZvOXFur0zGh9cAZsajQ6M5D5V792TE6dOn8o9JMboTEJGHIQQxSbMn/vSsrHoUklQ6lHiMn7bkmSHCKxUrH9aU5Q9XXGQFYl0MUBGqAa3vHVwwRcKGEtzASe4RuJNvHD79QNJo43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1/GJ1xyPPOGW5wAi6SyBFw3mc3mUMqtCf9iHGsJrbk=;
 b=UIZxRux/t2zpazetOznioDOIafEXqW0gVJour3pPikTaQVDhId/wKDlXNsxYtE4+e/PWUgBbkQ3dCMcVGkxR0puxAw/rcL1OyR8/59cB2cm+G8JMTPCgRFEb091haSm69eaCtePoNgd0tX6yI6wtqItujBCmK63sxln7VRKWEkYP+HyQTIvBuz919667ohwpF0NtBEzTUBe825/MAMVuu6TJQmTzGxxW4iyB+c/ETdUsGP+EyGe7upWSN7C88I9OjQKaXo2q5aWOYlYGZbG1cf2YFam9vxXEyf+dg0WVK3YIJdtFxpLRc8bUrFGfTYsm+VOS6tJj5Qdfckg8HMvSPw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:31:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:31:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: reorder the REQ_ flags
Thread-Topic: [PATCH] block: reorder the REQ_ flags
Thread-Index: AQHYZG4IRsh5qaHwiEKH0bb2O93LHa0Yu2aAgACOFYA=
Date:   Wed, 11 May 2022 07:31:47 +0000
Message-ID: <b35e786e-3e38-ce08-efca-912b33c248d6@nvidia.com>
References: <20220510130058.1315400-1-hch@lst.de>
 <09a72de2-c171-63d8-ff0d-13050aa40c87@kernel.dk>
In-Reply-To: <09a72de2-c171-63d8-ff0d-13050aa40c87@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c091b42c-0542-42a1-868b-08da33204ed1
x-ms-traffictypediagnostic: CY5PR12MB6299:EE_
x-microsoft-antispam-prvs: <CY5PR12MB62993242EB14D481500ED1CBA3C89@CY5PR12MB6299.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbUozf4d9sENxHOnJehr/O3tdu5ekfe5j8f1kXhfaznjAJXRNs5d1JddnuxtOUqx/JH8XLhF1JODheVOgZwhrKzOqfoR+xnesawfzrp1wiMlG3tky8MUx/u5TD/gl50WQZWCvXFeuZ+9dVPFdQICX3iTo7GVStelMadjgP0zg6mgVsrUo9SeVk033KmN7/IxC7IpF4TsAWntUbyX3lZrAaylWNEPAy/PfIGxmEst+C+3XbAdnpy/h9jnyBEwBr9PTZW3baw54rTzrXbs3u4xFV1rKu2XUCPgtOyhUfbLfCVwwSZRUz7cWkoFH5mmqLadHCtlI6aJgKPNkIC1kTnjr/T5eOuK9Xiaa1w/yeDpDHUFeGleTmYZ+N410cSpuJQ5lLlYfzLXZv88oSfdouZvbtSsvrfi1UEWTLqayV0Q28ZUmJZTvKNNldLGl+hYybxSw23/+BfUJDVyE47RIXpo2DAwnxfyMuigbH7Ist0PIknWKqgPmLFLd4fWi7kP1qpMG/+F2jofZr/iDzVZGeXO/0HAh96jhOcLxvNmbAhWZTVwbAT0web1Lolg/j214cV0IhLm1Eu8VCSbfU8Ptcz+r7LwTSFxM9BwLuvuOrkHT7tRKdGzSoungcax/kVqq4e/GK6Y1ZpXYQvjiDZ3SpR+bu7idg63LXwuedZQ5SZnqC5fm2wjzU4m2iAD7qQjfQqjmRmoTEim94mECszXlhDszxpxc+c2dQxrSK9mOucJt9rS1nmsrXKdfeWci/ufk4oZA1dRpuG6wHBWehuQ8qgPbn8Drj7G5VGxtduNugWc5Uc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(66556008)(66446008)(4744005)(76116006)(2616005)(8676002)(66476007)(64756008)(5660300002)(122000001)(4326008)(38100700002)(31686004)(110136005)(8936002)(316002)(508600001)(36756003)(31696002)(6486002)(71200400001)(6506007)(53546011)(86362001)(2906002)(83380400001)(38070700005)(6512007)(186003)(66946007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0ZnOU4zcXNTcXNFZFFka3lEdFJiN0JBVjZaZ1dISHpGcmNpWFRIR3hmbnpm?=
 =?utf-8?B?cCtDZ3JWNXNCMFpoM2xyM3hCeXhVUWN1Slp2VUFBcFQrdE41dnpBN1NCWXMw?=
 =?utf-8?B?clR0UnNwKzB3Zm04clF1SGwzbmg4dVRUQlFCNGRCaHRBSkk4elRXbEtIbm9D?=
 =?utf-8?B?R0Rkem01c2NJMHNrMk1vdi9LWGNZcHpMcmtsMVRJY0VKK3NYMEdsc3pSR00w?=
 =?utf-8?B?NlFoUlpoUFdPQW9tNUpYT05pa2pnVnNKdmNsSjZtTngzREdsdGhWM2lJMzNQ?=
 =?utf-8?B?OEZSUGVmU2tQcG9vOEFUVDRLeFMzY3g1TDM1TkY4Y1RUblMraUZacGs3QVhY?=
 =?utf-8?B?cGd3K1VuVkhSYWU4aStheUorbzVsT1lSbDRXOXNiZEQ2QXBvVUcyNkNQSDhr?=
 =?utf-8?B?MGp1TEZpTDhXN0VkUnZNT2ZBWkw2VjMrZDNab2kyNzEyaGt6L2lRZms1MWYw?=
 =?utf-8?B?TmhOM0NZTXpla2I1SGc5aHJ0bTJ4czRaWVRZTFl4Nk11QkpqQWY1ZTdHSEsw?=
 =?utf-8?B?RExSSFllcE1lMnlscVdaV20zUWE0NklQN1RKYlJNMDZxaE96QVlzeGFhL1ly?=
 =?utf-8?B?MkJPQkxjdm9paUZtNDd3aG5hQ0ZnVzRFd04wTGI0aHd5cGN1ejRJd29XSVF6?=
 =?utf-8?B?eDlFQWJVV013RW5qdDZRN0tsZkdiakY2SFFpSUZoYUc0VWs4OVRzeWpObC9w?=
 =?utf-8?B?OHVvWENNeDdORk0yTkVVMEw4MmZFdVN3ZlN3d3RWRW9oY2pVWm1IRkhnaENC?=
 =?utf-8?B?d0J1U05SODdUVUNOUkhwK3ljMXdRSitxVmJMUkZTMkM5d1hKd2N6TVhRKzNi?=
 =?utf-8?B?MzVVK3VoVmlQeXgvSVcycFAzSWlsTk5ySnhROWpqZzRySm9CTVlRVlJ0Snht?=
 =?utf-8?B?OEYwNEFzNVE3Z2I1bmtRdUNlazJqUGUwc0cwaXcwbUVJNFRkSTUwa21KeDlF?=
 =?utf-8?B?dlpINGpIbEFpbktwb0hMRzBPRUk2aWtBbkJaMWVzZS92MUVDV004SGZyYmNK?=
 =?utf-8?B?VjM2NU9rbklxSkhQRTQvSCtWN0hxaXlJd0Z1VFZnanUvcUxEb2xZSUp3cys2?=
 =?utf-8?B?eVhKVkRnYlJmNHNFR0dWVDhLT01XeXpsMWtJbjB3SkE0aHRYbzUyVmFDNTk4?=
 =?utf-8?B?cm1WdVptRlVBRTA0bmRtWU53RVpGbVZvTUNQWUFySzB0cVk3dklOQlltallM?=
 =?utf-8?B?eWUxOTFvRjVWandFcTE0WnZiVjlhWktSUW1KbVptSmlIVWthamxydTZYUWFS?=
 =?utf-8?B?c1JzYjZEcUZMRTlsaFVLeEJXbHMxZnVmWEhkTmFjejhQYmFrNVdiZFRFb1po?=
 =?utf-8?B?aXg0QWh3Q2phTitpZzg1U3UwbWt4UE9wOVB0UC9ZV1J0Si9tSTFCN0g1SWxM?=
 =?utf-8?B?SHFsQVVodldZSEp3dzM1U1c5aGxIQzkwelF6RlEyWkIyR3ZXK25SODVnQTla?=
 =?utf-8?B?K0NoWE1QTnVSMG5Ua0dJbHdGV1NPM3ptbWh5Nzd4elBlcm80dTJlR0hxSFdL?=
 =?utf-8?B?djNoamtsbjhZdi9hNGxJNnRmdjA3eXJoc04wMTVkYWZoMU9SOVJjRm41MHhS?=
 =?utf-8?B?WDlURnExN3JneWZ6N1l1TFVkUXIrNUFGVlhLcWMrZzZ6dmpLSGxZYXRETko4?=
 =?utf-8?B?R0o4dGJKU0YxZmdyTnZsMEF3YkcrWENWTklSalk0bFo2VzREelFnY1FRWVcx?=
 =?utf-8?B?TGZyYUxBdTZQRE5SZWtjS2ZUWDNISDh6QkcveTNIS0N6ejhJTmpXWS9tU1U3?=
 =?utf-8?B?VngraGxpbWdaY1k3UDhYTHpmNnhOOERacmdZZHNaZjZtWktxTzRYUVZvU1V2?=
 =?utf-8?B?aVRlSGRpd3VJK2dCYXB4RWxlNXNUUHVQOEg5aGZDaEtITDcvaWtRc0VDUDhz?=
 =?utf-8?B?MVBSQkxTSzY2cTN2WC9jV0xJRDNpMEl4aGV4VFZGM3pORzFnNjdMbXdHTnBr?=
 =?utf-8?B?M3Rmd3cwSnVPTzlFZytwT2F1UGhLYTdsSmo0WDZPOGpEaTY2VHE5a1FpRkJO?=
 =?utf-8?B?eVdlRkZDWkFCY2ZtZEtTNGZnaFgzNk5CSXMyMTYrTGkvZTVGcnpvWUhDeklm?=
 =?utf-8?B?L2tVM0R0WG1kRzUvVnkxMXY4VmRlN0ZVMDRHcXprR3NhUm02SVRzeC9NNzR3?=
 =?utf-8?B?MlpCVy9CeUIyTTY1RXZiTjFaa0hYVDlUZnhBQy9ydHM5YjVWREp0Zkp3SVVn?=
 =?utf-8?B?OWRPbHJZNnMreCtURFNVblJHL2FRMkMwM0VlQUZKWlIxb2tpdVVzVkxyNHRE?=
 =?utf-8?B?cGFvWnRYaDhRbkpTRkkzS1UrNmxtbzVhRk5nSGM5ZWVrMDhZTWVTQndFRGRw?=
 =?utf-8?B?ZHMwR3pnY0hoUU5UaFZNYmprS08wbEhnNW5zdTFJZWpjelRMZTZVNU9qM0NW?=
 =?utf-8?Q?InS7cKE3NMIVHRPegBrfXNaWUG5ptR9wjYAL0CWK6JtdP?=
x-ms-exchange-antispam-messagedata-1: 6CPwFCXC0YLK3g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D1954451B186644810D84A81E807E22@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c091b42c-0542-42a1-868b-08da33204ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:31:48.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arT+t/X1C4MGkEJOJ7hRX2sOSqng2v5+m7dJ5HBJnlSKiSy/u/bXG1gg2YG8nQYuwHdR5EgqkeLtDoVsWJc79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNS8xMC8yMDIyIDQ6MDMgUE0sIEplbnMgQXhib2Ugd3JvdGU6DQo+IE9uIDUvMTAvMjIgNzow
MCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBLZWVwIHRoZSBvcC1zcGVjaWZpYyBm
bGFnIGxhc3QuDQo+IA0KPiBOb3QgdGhhdCBJJ20gYWdhaW5zdCB0aGUgcGF0Y2gsIGJ1dCB3ZSBy
ZWFsbHkgc2hvdWxkIGhhdmUgc29tZQ0KPiBqdXN0aWZpY2F0aW9uIGluIHRoZSBjb21taXQgbWVz
c2FnZSBhcyB0byB3aHkgdGhlIGNoYW5nZSBpcw0KPiB1c2VmdWwgb3IgbmVlZGVkLg0KPiANCg0K
U29tZXRoaW5nIGxpa2UgZm9sbG93aW5nIG1pZ2h0IGJlIHVzZWZ1bCA6LQ0KDQoiQ3VycmVudGx5
IHdlIHN1cHBvcnQgc2V2ZW4gcmVxdWVzdCBmbGFncyBvdXQgb2Ygd2hpY2ggb25seQ0KX19SRVFf
Tk9VTk1BUCBpcyB1c2VkIHdpdGggUkVRX09QX1dSSVRFX1pFUk9FUywgcmVzdCBvZiB0aGUgZmxh
Z3MgYXJlDQpub3QgbmVjZXNzYXJpbHkgYXNzb2NpYXRlZCB3aXRoIHNwZWNpZmljIFJFUV9PUF9Y
WFguIEluc3RlYWQgb2YgbWl4aW5nDQp0aGUgcmVxdWVzdCBzcGVjaWZpYyBmbGFncyB3aXRoIHRo
ZSBub24tcmVxdWVzdCBzcGVjaWZpYyBmbGFncywgbW92ZQ0KcmVxdWVzdCBzcGVjaWZpYyBmbGFn
cyBfX1JFUV9OT1VOTUFQIGF0IHRoZSBlbmQgZm9yIGJldHRlciByZWFkYWJpbGl0eQ0Kc28gZnV0
dXJlIHJlcXVlc3Qgc3BlY2lmaWMgZmxhZ3MgY2FuIGdvIGF0IHRoZSBlbmQuIg0KDQpGdWxsIGRp
c2Nsb3N1cmUgSSd2ZSBub3QgdmVyaWZpZWQgb3RoZXIgZmxhZ3MuDQoNCi1jaw0KDQoNCg==
