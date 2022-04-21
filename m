Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F241C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 21:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379609AbiDUVyF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbiDUVyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 17:54:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0F94DF58
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 14:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qhv6KzbW2Lgxki6z/eppoNjxWptwWQrYVlFfc3SVFPnWevdFENHSNIEArcZn9ea6cic9+9WpgN+CVJdpU6i+hgjygthhSYirnEPaX4KmYSeGBvusUD9ZLSPWJX5oWDuzJeIOQmfEgQ3IPSqvb0ltuH02C1jzK3DgmbpEU8KkZrVUhbfry25mPDP2ndPCtd6UDHYRJbH6h1jxHEAgpTUIy8HEHTY1vfu3bsdYJ31hTaQfaTxbFHvO6XQzK3THFE56tEvXd8AofwewXgy86AnSSAOF/3wJIk+8RHTH0KVbfHGlxDbRyUesbBkn0oB7xR8sU878/04iV49ekHBtBaQEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcTskZYSkSUNywq9sjweVS/ivK6bQUs1GVnXQoWY7q4=;
 b=g0sYCgTrCgr9Z9Py13fSnUvedpeAutCFbQrx75/4S37Q4DARIZGS7O6tam09SOoRPZ2uSyW25+2386OfkqiIsZpf5IA4vXC/CW7pqY3DtYt/8gdlaHJHHGj18eR7EmMkFDn+gl+iQBQlqjjcse4Gbqr8nUUdOsnsPOcyRo7n54y6uDCCOQ4Int/R7HiDW12g0LntJ2SUZM+9D5H2ky1RHuYtVNeHVNaD3P/uXiHpk7eFh2bAewbkxi+DS9Fe86zQ/lbn2BM5Js62suj39kGX9NN45jQgMisF/xEsCeIUBU4+NupCHK42m3eVrz5Eh5vmbkPKgKO+m9CcNYJ8KFK7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcTskZYSkSUNywq9sjweVS/ivK6bQUs1GVnXQoWY7q4=;
 b=Vbt7Q1e2jMDXKf4qz3u1u80VvaNberi2C1BSEf9hSqipQzf7Zc1SRNUZIW9nem1ypzTRa+jmfWy/NYW4facmUPgFNBP8eyDUrhZ25xjy7iAyD2DlcW/q1EndztZY05tUVvpoUr7ZNf8JUBkCd1rjNcGKCB4+aauhuX7Hpv8eZxueDGvi7vW18Uefnjed0OC9zXodrwleIuron6vJpNC13bL9C+Zrq9uTzN6WjVc80OYcbYm+dsiuQ8U/xGmTcO1gHJAf4uR6vWvlLMCOmCqSH9CQvzBiK9drBhZ4KoBHi704WeRBYPMKdELuwQLWzOWd9nP6oaUmLRaXoF2LjEuqmA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 21:51:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 21:51:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/4] virtio-blk: remove additional check in fast path
Thread-Topic: [PATCH 1/4] virtio-blk: remove additional check in fast path
Thread-Index: AQHYVGy0HppMKVi080uYrh7DydUODaz45COAgAIG14A=
Date:   Thu, 21 Apr 2022 21:51:12 +0000
Message-ID: <442b9d25-c370-0045-3f70-16a3636878c9@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-2-kch@nvidia.com>
 <YmAekwHPRy8sfaEs@stefanha-x1.localdomain>
In-Reply-To: <YmAekwHPRy8sfaEs@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3b29dd-f399-44e8-941c-08da23e10d34
x-ms-traffictypediagnostic: MWHPR12MB1280:EE_
x-microsoft-antispam-prvs: <MWHPR12MB12800B5920E63F3433C1BFA9A3F49@MWHPR12MB1280.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mY5c0OeXmC8o/l+lKRL1nfPg/ZDo2OBecwxQWYwLSOUs3RHKegdUfSHfQIP8U9lOmHT4hjVH0X39GynInsEOiE4gIMmTUJN8cCYiBsfQWe/iNC1r5YFGaNPcrEhwxm0T+0J0ONMNx17IAIdrFam5htEfRyYJfcqK66JObOa6q3iUQVlV9wLqJP8URjNEYU5CdYTzre2pohiVHENK5bAmzwj73OYk3Gi188o6NgUdgtaW5Oz9TA1u4Z5maxNPrDQ0HXKPo0LcUrbJ8nAcdQW9bqWbDRz1PdrPxDfRPIJwfvFnG+8N3pn+5fgl6DMWtPsGcBhIh9UWq70DrmHUegzBduwU88JXDmkAPs9cUxGa0A//n04vRAVw64HTtaxem4rJMjY1UR20JQxo9q7Hs1P/wAFrEw9Q5Ur82pSFfmNCBiessZ8qVkHg9G2QX3zAd7l1eKNulGXUZzJaHWXVntvcjebyMXFh4iGen/ygKVqDcklPE1X2h1x6nPDNm0EMd+Hky6cK8ZRxlCmzDsPqgELfzJK6WrItTxFE7Ntbjzj13yUenP4HYe54+q+yNBuQ6Lb0+Avc5+S8M+g5O2E2T2QTgUq+c0HdhhTv43sO0fgOEFm7DcFtI7g3pwH5sVIW9hBxxIf2VC2lJl8zGo2ZBhGg6f4uXoLKJkMcJq3cm1gFGaGek6/Je0LySRQzbHmKzaWFn6PnXKlqIWtpwGHh07gVsyF4mmm5R0IMIz4PtK5gmoJp+5p49tisT5wkob5G87kYS190dpfvxRzfUZZcHcSI0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(107886003)(2616005)(508600001)(6512007)(6486002)(71200400001)(26005)(4326008)(53546011)(2906002)(6506007)(83380400001)(122000001)(38070700005)(38100700002)(76116006)(66556008)(64756008)(66476007)(31686004)(66946007)(66446008)(8676002)(91956017)(86362001)(54906003)(5660300002)(31696002)(316002)(36756003)(8936002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEFDaXBVNDdSclRrOTluNnN1WXZsZUIxWnNidzRidUZnajBKMVRNb0UySEdW?=
 =?utf-8?B?MDdRbndYaHlieURrVk9sSW5GQzRPS2dmZThNcW5HcFh2eWZNQmRMQkhiY3pz?=
 =?utf-8?B?TmxOZmxPWlNwRUxVOVdyd0h2UEVUOHBMSTNUdUpaa3Iya3JjdU52NUdSSVNO?=
 =?utf-8?B?Sk1OcVRRS3N5dTFlb0ZEZDgzenI1ZmlqMWtNL3grV0VKMmMwRTVrRDVBZ09R?=
 =?utf-8?B?M29vWGF1aldRRG9Ka2FDaHo4YmhRMEZpdmJYeUpjb2VxUWhnL3pxZU5OTkI4?=
 =?utf-8?B?YlU5UWRrNUI4NSs4S0M1UlBxNG0rLzkyRy9nUUVIRXVwcHdYa3NLSEtrRGtr?=
 =?utf-8?B?VWVMQjdwRmtxU1NTdDMwdFJSMSsxMndDTGc2MTN4K0pBVzZCUXhCYmRPcUJj?=
 =?utf-8?B?N1R3aVlBaTFuNXpZRmJJR0wyWGVsUE45U0VmalBTQWYrcjFIb283V3FUUE5L?=
 =?utf-8?B?bkpwc0ZrVHRTZ01KSGs4eXdFb1FGQWd1ZStrRllZU3FUdnMyV1lmaHAxTW9u?=
 =?utf-8?B?VnlMUnNUbTYrTkdpQ0ZBbnF2bDBTbTZwQzBMVzVIeDY3WDVBSEx3K0pRRkJm?=
 =?utf-8?B?WkZhVG9DeDZzNjdnMHBwb2xoZEwwVG0vc1hUTEdYQmJadWkrbGExY2VQV3o2?=
 =?utf-8?B?NWhYa210enVvc3R0dHBKVDIvNjFOQVZ2bDB2bkV6ZDI1SzhYQ3B2U3lxalBl?=
 =?utf-8?B?WllXZWxXTDVoZWRZOWd5amloQ21tOU9pVGI0N3NlMHB4NlBzSmVZUkRVQTRX?=
 =?utf-8?B?ZjFtQlFQR0VoS1R0alhLWkdoSEtLQVNFckZIdHVpNlBUNyttbE9EQklLaE9k?=
 =?utf-8?B?dm1LVmVEQVBjSUV0bDczdlZjUU0rampxQXUrNDBzUk9ISnhvanFxOFpsQzVz?=
 =?utf-8?B?RjNnK1A3YXV2WkR3UVFTb2lUUEFtRUpvcjZwSmpwYVg2SUxZd00wV3NFUlNn?=
 =?utf-8?B?ajhrNFRVSis5NGZzSk9HOEhJdGRvdTBEUzhOcmxsTUZzYUNQWVA1OGpNcmhL?=
 =?utf-8?B?cnVHazcxVnowK3NDNS9xb082ck5XOCtNVEFWa3Z5eVV2N2RUc0E4SGhsakpD?=
 =?utf-8?B?OEU4ZSt1QldRZWhWT1JTRk95SGdjeXZWQ1BCNTMxSjVoa2I1Y0NWV1VYOG5m?=
 =?utf-8?B?MXhBblRoSTlLREZFN2xkdzdLUm96bVg5cDJndmNhdnZzUVZ5a0dCbjlpTS9F?=
 =?utf-8?B?TlhaazlKVFY1b1ZKZWo0SXlSYXRsL21lSCtCM1RpK1paRGlueVF5c1Qrc294?=
 =?utf-8?B?VHhMRWc2cGEzcGVZS3V5dEdFeFo1dlJQSGlWM01qdWJySnFqaEp1UzFJcDRH?=
 =?utf-8?B?UVNPQkhQUWVzRHgyaDhwOGJabUIrdXF5U1k4dENNTjZxck5uR2lKai9KcjM4?=
 =?utf-8?B?VHcxU0tHTnkwd0hkRDdtV1BrQlZtNWg2UTMxOE9CNjlEckZUc05EanBlTlM1?=
 =?utf-8?B?aEdGZEFxdXdzTVBtS3FMS2NmZVFiUHAwSWZyMytwdmFnSllXb0x6RVZiZGY0?=
 =?utf-8?B?eVQzSmR2eEwzTGNVZ0UwOFlkQ3hvRjJFSzRneUJpbDFxUytZYm1lVERDTGxa?=
 =?utf-8?B?d0FsVm9HaFh1YWZnSVRpeUowaW5PZjBnQ1lKd2o1UENEbjRCb2RaY2IwdjJL?=
 =?utf-8?B?Qm1qUURXWVFDZy9yVFBrUkUwV3VoaHZDd2dLd3BicWZIdU1VTzVUeUlRVWt4?=
 =?utf-8?B?Tm96S2hFWFBxc2w2YlFjdXpWL1J1VnJKYWtrM2pvc09yaU1TZ1A2UCt2aVd4?=
 =?utf-8?B?a1hZeFZ4RTdCeTN1SjJCRUtqWDFyTXBVb3gvQU84OTBlaE53TzNEb3VNNUpj?=
 =?utf-8?B?SXZNenQrMjIrLzdhVW9sb2NWUnRFQytXdjF5enphR251bnVUakx0OTNuMUpm?=
 =?utf-8?B?K3hXWDhtYjF6WDJWR25iQjRsRldtYllyeGJkQmlGeE54c0NHbTY1cGYwZ3Rj?=
 =?utf-8?B?SlVnR1l0eDRRWWk3ZmJENmVGYkIxUGhDeTVwMU1lK0s0cHFneWFzeU9XTk51?=
 =?utf-8?B?M24wcFBRdnE2U1dVc09QdzRvdWJFbGgwTklYYWlRWDBiQ0lJc3lPZzB2MGJo?=
 =?utf-8?B?WGJHY1dNajlsVXFYTnpNRkJWSElkalQ0VFJwMDRCK3ZWTmpDZ0c4RStrOS8r?=
 =?utf-8?B?dVJvckJ0VW9xaU12dHpsZWU5ZWNUZy8rODMyRlNTZ3lBSjY3TUJxeGM5Yy9n?=
 =?utf-8?B?clJvNFBjQkdrNGRyWGRycElvbHNaSmhnSzA4SmtPdWRrSExJaXJIWmpFSi9K?=
 =?utf-8?B?OXNZV3Vqb1loRnVndStvbTM0NHhJU2c5Sm9nblBSZXJKTjNndG5hUUxKbW1w?=
 =?utf-8?B?UkxxKzNMUmhoTGFUMkRiejJtdGJ3YWoyQ1ZneCt5bllmWk9BWFA1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <257783CC6E57AB45AF7BF4FDDA3FC0BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b29dd-f399-44e8-941c-08da23e10d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:51:12.1728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3XGsrWXcrZURL4/EWkRM8PFhVAQ1dLXkgf7cLPhC1EzLOcWKFwBZKdKquBXa9f0iX1qFbd5tCkrBdIWSy3B9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8yMC8yMiAwNzo1NCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBUdWUsIEFwciAx
OSwgMjAyMiBhdCAwOToxMDo1MFBNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
PiBUaGUgZnVuY3Rpb24gdmlydGJsa19zZXR1cF9jbWQoKSBjYWxscw0KPj4gdmlydGJsa19zZXR1
cF9kaXNjYXJkX3dyaXRlX3plcm9lcygpIG9uY2Ugd2UgcHJvY2VzcyB0aGUgYmxvY2sgbGF5ZXIN
Cj4+IHJlcXVlc3Qgb3BlcmF0aW9uIHNldHVwIGluIHRoZSBzd2l0Y2guIEV2ZW4gdGhvdWdoIGl0
IHNhdmVzIGR1cGxpY2F0ZQ0KPj4gY2FsbCBmb3IgUkVRX09QX0RJU0NBUkQgYW5kIFJFUV9PUF9X
UklURV9aRVJPRVMgaXQgYWRkcyBhZGRpdGlvbmFsIGNoZWNrDQo+PiBpbiB0aGUgZmFzdCBwYXRo
IHRoYXQgaXMgcmVkdW5kZW50IHNpbmNlIHdlIGFscmVhZHkgaGF2ZSBhIHN3aXRjaCBjYXNlDQo+
PiBmb3IgYm90aCBSRVFfT1BfRElTQ0FSRCBhbmQgUkVRX09QX1dSSVRFX1pFUk9FUy4NCj4+DQo+
PiBNb3ZlIHRoZSBjYWxsIHZpcnRibGtfc2V0dXBfZGlzY2FyZF93cml0ZV96ZXJvZXMoKSBpbnRv
IHN3aXRjaCBjYXNlDQo+PiBsYWJlbCBvZiBSRVFfT1BfRElTQ0FSRCBhbmQgUkVRX09QX1dSSVRF
X1pFUk9FUyBhbmQgYXZvaWQgZHVwbGljYXRlDQo+PiBicmFuY2ggaW4gdGhlIGZhc3QgcGF0aC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIHwgOSArKysrLS0tLS0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
DQo+IElzIHRoZXJlIGRhdGEgdGhhdCBzaG93cyB0aGUgcGVyZm9ybWFuY2UgZWZmZWN0IG9mIG1v
dmluZyB0aGUgY29kZSBvdXQNCj4gb2YgdGhlIGZhc3QgcGF0aD8NCj4gDQoNCkkgZG9uJ3QgaGF2
ZSBhIGRhdGEgeWV0IGJ1dCB0cnlpbmcgdG8gbWluaW1pemUgZmFzdCBwYXRoIGJyYW5jaGVzDQph
cyBJIGNhbiB3aGVuIEkgd2FzIHJlYWRpbmcgdGhlIGNvZGUuLi4NCg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMN
Cj4+IGluZGV4IDZjY2YxNTI1M2RlZS4uYjc3NzExZTczNDIyIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4+ICsrKyBiL2RyaXZlcnMvYmxvY2svdmlydGlvX2Js
ay5jDQo+PiBAQCAtMjIzLDEwICsyMjMsMTQgQEAgc3RhdGljIGJsa19zdGF0dXNfdCB2aXJ0Ymxr
X3NldHVwX2NtZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwNCj4+ICAgCQlicmVhazsNCj4+
ICAgCWNhc2UgUkVRX09QX0RJU0NBUkQ6DQo+PiAgIAkJdHlwZSA9IFZJUlRJT19CTEtfVF9ESVND
QVJEOw0KPj4gKwkJaWYgKHZpcnRibGtfc2V0dXBfZGlzY2FyZF93cml0ZV96ZXJvZXMocmVxLCB1
bm1hcCkpDQo+IA0KPiB1bm1hcCBpcyBuZXZlciB0cnVlIGhlcmUuIFRoZSB2YXJpYWJsZSBvYnNj
dXJlcyB3aGF0IGlzIGdvaW5nIG9uOg0KPiANCj4gcy91bm1hcC9mYWxzZS8NCj4gDQoNCnllYWgs
IEknbGwgZHJvcCB0aGlzIHBhdGNoIGZyb20gVjIuDQoNCi1jaw0KDQoNCg==
