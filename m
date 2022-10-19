Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58842C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 06:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJSGRq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 02:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJSGRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 02:17:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848FF65268
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 23:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlpXAeaiI/E3NeVVCa//P5L/KaScPhed7xnN19UEn3l3qTDQQju/rT0YZZ+02I8ZLrCWATT5sPxjRivSHEv04fUDGr8UJTiBtbDE6XDnbZesCpuVeyhH6yKkQ1oB1jcL+sEyLzpjA7vkqTR9m3svGgiGent5Le1y/liNz6qQu2R6EgeEazCOAfa/ZhiM6H5SeZKDVkIvwG8cij1N0W83o4f/MQzdFZU68EpUrtrRw/CMmdNpsyyVpIIo67y5NVVX76I5Ktkd6jom7HR+LuRatvy3CT26y5H+8E8hcFsHW89a7cirTd6aLhNIvo9tqXT6iKAY5lWQ/ZLk+dCPos3Ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oN/Tf18Jc2nZPh5OBE8HEp9DV6m15gIJME04HhEk8A=;
 b=YLjPjf7UFgWZwknHdq8yTXkQTHkv4b//frB1oRU0fML8Dw7b/StLqu9BnESFcGQriN8ygDVpUTiJxfE+oxBUpO6zZJ0h5WzG2AucFNmNJcMy2/afSgy594RxFaQOpXQSeXkLfW0bJ+nr1xrJVkkWKlfayEFIElJJacobwsklJHYvsZGPK7vUeP8+RvsTRhuUYJC5a3q3GBLXRfOIKcgkvPECzNbyVivYrxc/ArVRmUw6GYBkImKvkiu2f9L7x6ZLfwxA6msoH015vfzWrbSv9c7F0Gf/uGiuXpwc4J05cUY9Xp7ok/jNt7pNGCJAjwjXQ6i+czC36jqhH1JckyHrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oN/Tf18Jc2nZPh5OBE8HEp9DV6m15gIJME04HhEk8A=;
 b=hIaykl7pkBBFHIOs8olAAdrvNgZNOEMb62LEhpiRge+2qExcjz9K3SS+ERE5SvdFxWHh7ZdDbVbwfIwLSHGKr0z4Q+fex4yfmNH8NZbR8VxjqEl5qr868MdHBAIBYczmzfz0eIltp8+29UIHCGJ/pnL39MrLOBGZaOgLWYbRwTxtrgsvJu2uzsICgKZYdE/wYhE2dOS31tMDSb1RKPFCb+2tALrYf/4SCMG2xySWcS3C1C8NjmcOcL5dgEcVBWeD2hhcrDo44t8Vklwnfbl4K6+wH4p/SZIFM8Tkl/u4dkOQdK5BFAGo7bq/TPSYd8gXdtlM/Z6rWMoyJGTk3IFkJQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 06:17:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 06:17:31 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Topic: [PATCH] null_blk: allow REQ_OP_ZONE_RESET_ALL to configure
Thread-Index: AQHY2UFEkIAKE36ytU6H0HwdEAigoa4A0sEAgAGYy4CAAAhCgIAS3p+A
Date:   Wed, 19 Oct 2022 06:17:31 +0000
Message-ID: <03102f4c-fcfe-ec47-0878-bc25c8a1a5bb@nvidia.com>
References: <20221006050514.5564-1-kch@nvidia.com>
 <0ac14f65-d8ac-8d50-ccf1-010ec7bcaad9@opensource.wdc.com>
 <50136c06-498c-4058-731e-01938ad011de@nvidia.com>
 <a54a9c84-0dd6-4af6-6c6e-d67d9e5a8695@opensource.wdc.com>
In-Reply-To: <a54a9c84-0dd6-4af6-6c6e-d67d9e5a8695@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5247:EE_
x-ms-office365-filtering-correlation-id: 3065fda3-e57b-4f63-8e62-08dab1999b0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3Qd7UlcqYs3KDYq6OdbqxjNzBAQbVfVAhRHQ87B50+yAAUOZjX6zhwVjWDfi9Hr5Sko/dP86gh9tTBW0qiPZBIQ3bFVmN4i0sOfUKjE7DbNljfLJdCM0rjvtcdITE1rPL1s5EI3Nsug3gARF1oubTHwolMarBCdWXkd62KBoEAaS+K0vuYWwJQaZdTV6uGIZt7drvEnLmlj/x955xTxSbQOaBDkt5c4CsR52F135k/tZJV3/YEE0fnLI2TG1bTb3HS+GDPt4yaY0QUz9H0uoCDsN/3ivYprHra/zSHH8tPSun1/BKaUKvnpkA9cTD7eOe9MGyCBBhO+9uNK+JHrtP94sXq+0oWyJI+8FsGiFhxfI8dJx6Yvw+a0RdOGzmKBk0ZaU2L7SA4u4kbCX6DSW4F3A2fXmkC0KumS5ya6NiJSPzgur6RQqSO/gDNidSH08vqoGUL2VYSo35h4q7lM6xLYfCyiNWJKGSMmzvlx1mIFpHj8acZ78gnQOJ1a/V8vf/4k0jJI1D6gulETXy+NVOthbowmH268cv5cj2Vb7QpkembJqaJezLRDCZKNzPDvC2iWa6mlnq6yi5ixNumCm8zN+7LNr/tE8vWzmqkvZF2UvQ7fwdc5RkVrzVMjqPcsJjqkSv9OOdPPzBZRP3fie44qKeBlhdDYDTX4zpKrytdwxRrn2u2j3zW3uXckl9C+aHWi4dT5hBGC/tDLkyvnGvCpJpCRM1ODQtosfEd5mqgh7+ygETYegxBhROnikI7BflfRFnkcxWhGhi8VAWP3c8B618fjbc7+TRhj4Nl0ALhord4YEU3+uRkdRDMJo20v/3eLTdy3zcwhqbJM89z4Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(31686004)(478600001)(71200400001)(66899015)(83380400001)(86362001)(31696002)(6486002)(76116006)(66946007)(36756003)(91956017)(66476007)(66556008)(66446008)(8676002)(6506007)(316002)(41300700001)(6512007)(8936002)(6916009)(4744005)(4326008)(5660300002)(2616005)(2906002)(186003)(64756008)(122000001)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhxMUJ1MUc4YjgycmRBY3NsRkxjR21vS3NiSlp1UnhzdTNsSkNmZUhlb2R4?=
 =?utf-8?B?dHh6Mm5XdDFMR2ZvS1NIOUpyaFljQW9IOFpDLyt2NG9ZVUtXOHArL1lTajVa?=
 =?utf-8?B?NWRqZFJqckVyaHFBMWg2MTAzNjJ0YmtnVWxRWnVJQVFOTjhXM2JkLzBRS2hw?=
 =?utf-8?B?UktPT21EWmRwTVE1TWw1YldhU2lET1RURXI3SjBFUmZSMnp3SGh2SEtvdHBk?=
 =?utf-8?B?KytSbzMybGdTYWFmVjl6Q2xZRVBZN2ExaGZwSlNMODFxMWs4VmdsdVVoM1RM?=
 =?utf-8?B?WEJ6WWtFeFN2RHVqTmZiMnBmRlBNdnQraDF1cWoyLzFCb01GbUJJOE9rT3ZH?=
 =?utf-8?B?dUZsaDgzTFZGRHdCTkFwOExZby9vZVRQZHhlZ29hdCtVS3dhSmozdFFsMzY3?=
 =?utf-8?B?cHRNMVAycU1NNkhXdGpBbktacEkwVnNTN0lnVVA2Z3ZrZXQvdHc0V0VTSFB6?=
 =?utf-8?B?ZTNIa3FYRVNBWWplZm93cGQwSTZobXlrRzYyVE9pK2V4d3pNZzhkQVg5QzhO?=
 =?utf-8?B?STJRTzNyalhxdTdVTEw3WmMzNkVBMWVjaHUrT2h5ek9yUHVCYU13b1JScjB5?=
 =?utf-8?B?OWNXbUZjV2RzWUw2ZXcva29ZTXJRZzRjT3dSdWtFWXIxdEJvQ01zQXFoZXVl?=
 =?utf-8?B?d1N2Qjh2RHJuZUFEeEhiZEl5bk9QeDZ5R1U3WlAzdmxsS0tmTDFQSmE1SHYy?=
 =?utf-8?B?SHo3d0owaWk1SHdmMWpVWWtBMU53eVVNYVNUWUFOOEtxVmlKUjkzNENNQ01B?=
 =?utf-8?B?Y3NrZnIzRExnd05Sb1d5K0lnd2ZHYjUwQldoSkl0UlNBOHdFQWp0dXNnMW52?=
 =?utf-8?B?VnNiM0M2VzJsdjZhWjhkbDJUd29RZTBUSlA4VFp2cmNPdm9temxGb3lxMzlF?=
 =?utf-8?B?WU1Ta3VCN0kxMUhuY3I1SWNIL1grUjZRVWorSENpQmhMNjBRaCtqUzlmRUNG?=
 =?utf-8?B?Ui9UbWNjd1NKZ0NvWW0xeUJxQy9jN094aGVsc0ZrOTJ1d0pBdlBBVkJUdjV6?=
 =?utf-8?B?LzhnSzJseTN6d2QxQUdvK1ZWMWhvb2gwNzdjRHVvQWx1SWtORFJBT095SlZp?=
 =?utf-8?B?QUJGNjg4SmoyWHpKZURobi9yOFM2YUdOY0N3MWZXWGkxSzN4VTlDQW9tTG9q?=
 =?utf-8?B?Tm80K2ViSEk4SktOaGJsSlg2dTQweXRkTVM2Um5YdDNhaW0zNk8wZlZvVE5r?=
 =?utf-8?B?RjMrQ2Q5TkxZb2JsOURnOXVNelpuNFQxdUpjV3lIVE5MNTBqOHBUSGVOMlQw?=
 =?utf-8?B?bzlWdzlGdndnMjFIK1AzcDR5cWl4RzdVL3RhSDhJUjNkRkEweTBPYmQxMDVY?=
 =?utf-8?B?ZGVjVzYwc3psL1o1azBvQ09HTnhiOE9yeWt3TURXZ2dEamFaa0hCeXBtRC9x?=
 =?utf-8?B?U3IxdWFvbWtQeWtydjdNYmVoS0ExaGQ3ZEZxanhqaXlMSG1CRFpTT0hmNlVV?=
 =?utf-8?B?bTlVZ1QyR3h1cW1EaVlxQTJPWVRKY2FXbDdHanJzQ09mMy9Zb2xQK1UvaitQ?=
 =?utf-8?B?eVVmOHF4SnBFcnZYMlpLWis0cDMzQkRPL0xQaXBMTnllakVEbVVIdGszdVF5?=
 =?utf-8?B?RnVNTlpCR1hLOTRIbU9yVkVYNjROckZTRjlpejNsTWlROFB3ckhjV1dhM2Vt?=
 =?utf-8?B?NjhqRlhlNzV3Nk5xbWRtajd5NTd0eForOE5JYW1Mcmg0R3NqV0FRNmtYeDhT?=
 =?utf-8?B?YjRzdmdudnpiVnkwSE5YR2p1V3lLSFkyVkY0VUtnWjhzWWM5M0ZUNmRJdDZX?=
 =?utf-8?B?aGpyRThIcG1GMlVDTHUxelorWGNVdDZiQmI3dUI1SjRwVjFrN1l3V1UwLyt4?=
 =?utf-8?B?N0pOUndsL2x0bGhUK1RoQjBpTkpFeWdEM3lvTFcrM3BIWlRRQVgxdnZxdWJ6?=
 =?utf-8?B?VHluYjR2MUNRRXBzcTA1ZkJRVGVYcGxHYjNqRWZic2QycGFRMXJ1QlVNNmRa?=
 =?utf-8?B?M0lib3FuVm9jczZpOHpYOWR2L3oxYW5nK2VUczAwL2ZvNFFGdlI0VG9ZUVY5?=
 =?utf-8?B?WENzQ244SUZJenduZmxUYkpPMjVCYTZpY01CUzlrVytMUkVrcFNkTlBKdU9m?=
 =?utf-8?B?bHhENnl1U0VveFd3QlhPRVd0d2hmbUQzdEdueHVlV1hBQk1zUkh4bHpsaVZz?=
 =?utf-8?B?UmtGVkRtSzNFUkJjZGdyTHBoN21PYmh3Qkd1eWtOWkM4TkhFT2x1MHVVTXFK?=
 =?utf-8?Q?aiZJuqjcPRoYbDAkG4Ipxdl4iy3udOVkLryQ5R2Jt608?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42735BFDE9945C4EBFE75FEDF206664A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3065fda3-e57b-4f63-8e62-08dab1999b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 06:17:31.5659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQDANsbxWvRGRwA2fZkvPYKtFVMPlD2o9X8oeVAVGqjai1u+K26+2ocIdmPgJucN68V9NKLW22s2sUMma5zZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

RGFtaWVuLA0KDQogIE1PRFVMRV9QQVJNX0RFU0Moem9uZV9tYXhfYWN0aXZlLCAiTWF4aW11bSBu
dW1iZXIgb2YgYWN0aXZlIHpvbmVzIHdoZW4gDQpibG9jayBkZXZpY2UgaXMgem9uZWQuIERlZmF1
bHQ6IDAgKG5vIGxpbWl0KSIpOw0KPj4+PiAgICANCj4+Pj4gK3N0YXRpYyBib29sIGdfem9uZV9y
ZXNldF9hbGwgPSB0cnVlOw0KPj4+PiArbW9kdWxlX3BhcmFtX25hbWVkKHpvbmVfcmVzZXRfYWxs
LCBnX3pvbmVfcmVzZXRfYWxsLCBib29sLCAwNDQ0KTsNCj4+Pg0KPj4+IE5pdDogV2h5IHJlYWQt
b25seSA/IFlvdSBjYW4gbWFrZSBpdCB3cml0YWJsZSB3aXRob3V0IGFueSBpc3N1ZSwgbm8gPw0K
Pj4+DQo+Pg0KPj4gU29ycnkgSSBkaWRuJ3QgdW5kZXJzdGFuZCB0aGlzIGNvbW1lbnQuIEluIGNh
c2UgdGhpcyBjb21tZW50IGlzIGFib3V0DQo+PiBuZXcgem9uZV9yZXNldF9hbGwgbW9kcHJhbSBi
ZWluZyByZWFkb25seSBhbmQgbm90IGFsbG93ZWQgdG8gc2V0IHZpYQ0KPj4gY29tbWFuZCBsaW5l
PyBUaGUgdGVzdCBsb2cgc2hvd3MgSSB3YXMgYWJsZSB0byBzZXQgaXQgdG8gMCBhbmQgdHJpZ2dl
cg0KPj4gY2FsbCB0byBibGtkZXZfem9uZV9yZXNldF9hbGxfZW11bGF0ZWQoKSBhbmQgZGVmYXVs
dCBiZWhhdmlvciBlbmRzIHVwDQo+PiBjYWxsaW5nIGJsa2Rldl96b25lX3Jlc2V0X2FsbCgpLg0K
Pj4NCj4+IC1jaw0KPj4NCj4gDQo+IElmIHlvdSBjaGFuZ2UgdGhlIHBhcmFtIG1vZGUgdG8gNjQ0
LCBvbmUgY2FuIGRvOg0KPiANCj4gZWNobyAwID4vc3lzL21vZHVsZS9udWxsX2Jsay9wYXJhbWV0
ZXJzL3pvbmVfcmVzZXRfYWxsDQo+IG9yDQo+IGVjaG8gMSA+L3N5cy9tb2R1bGUvbnVsbF9ibGsv
cGFyYW1ldGVycy96b25lX3Jlc2V0X2FsbA0KPiANCj4gQnV0IGdpdmVuIHRoYXQgYWxsIG51bGxf
YmxrIHBhcmFtZXRlcnMgYXJlIHJlYWQtb25seSwgbm90IGEgYmlnIGRlYWwuDQo+IA0KDQppZiB5
b3UgYXJlIG9rYXkgd2l0aCB0aGlzIGNhbiBJIGdldCB5b3VyIHJldmlld2VkLWJ5ID8NCg0KLWNr
DQoNCg==
