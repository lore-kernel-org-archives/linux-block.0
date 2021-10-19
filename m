Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ECC433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FCD6115B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSGWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 02:22:31 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:2017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229527AbhJSGWa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 02:22:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmLgn/PjZ2AyZUEcUHEb21AZEMST8lAJVjd8/lb82jBwH+Ye4muPWjcbi8PGZXqMSpcuEqWsMkxx51hoEWYklBjN7kkCjbLLWbExzm7SPAMfZZVZ4HHm1MjmyWs8giEzhXIJBAnQyyDBgwRziyC93d8KRZiRbg7opp3VDXRhTn5MnazdzLcYe1/JjQpYD1YjOK6PPVU4H5lpWqxMgkhPBP+WepaBrkFLiJ0G9WVZlfe1mPNa8Hm6qUwU4l6CU3d0kZqAGvD9orKozyuqJeBy858zgF0PnZy7DUO0tJJRY6IB+KLqZMJd6l6OUvIX5ZgGs3T8P+Jt7MVgPTz9ywVLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3WrNlLJu9t2P+wHYbXzMY1vndpNgCFltIKC7d00dNo=;
 b=iQRP5T8rwa6nUGu/FhPmvun3z4SyeVT6mjYjkdvaizr+Q8wxPC5CBq25F7K+Y938V3z3RkU0fHh6jn10aMtQ/d62XJZcxZnahc0q0JKWVRTZXN2vw9JIiEdVg0gIpgslY/lawuqx6MRL4D1KluXlyexVQcCozBeVEoBCjNnC7iiXGHtPgTAHG8wTvyJnfmL5JytQ/slz1sKFhAdiFI8BCcBOk5qogbedUdiYm7AUHpY3+YgfP71PJVqVDXr+YK5xeeIf7NolqEgDv035L6VWRffiMDyPLXCVzNWatDPcHybJXwbixE9nL4Fm23XD9Mqx4FWnfhGyAtgdN3GBzNv24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3WrNlLJu9t2P+wHYbXzMY1vndpNgCFltIKC7d00dNo=;
 b=a/F7Ty7HG1xKJY8BX6GR8noXfZmKWQAYcfScxX7T+4+dZtg0DGCIXn+8LyJvXgnyYHc6uoXj9NL5+VKq++ukNC8FqdDQhSzpNvaJkul3eDiJCUwqnN/eJ0UklwOp55sZjD5gFKbVkN1Al0Uk9NEwj80zMrE7pgFCDLhckDRjsXZ93vYByOcoVREZk3uk7eYk1N4M4rPJCUeHEZ4R89gpWGxStwCBxbZt5oyJcRZqvzB6B6DTcTt+nXcTdTplfDQYE1bUHSiuAF5WG+3HDjxzdw873BgPXj/gUytmP4gy6dzliPDzU17GTwhbJ7zUoM8vhB4JSpuZ98OQv8Eh8A0EFQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 06:20:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:20:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: move bdev_read_only() into the header
Thread-Topic: [PATCH] block: move bdev_read_only() into the header
Thread-Index: AQHXxEfWNm3Gk9Hlv0ywY6K6OeEIzKvZ2jWA
Date:   Tue, 19 Oct 2021 06:20:17 +0000
Message-ID: <0b94f266-252f-7eda-d7f8-ba88d01012f9@nvidia.com>
References: <b737f789-6a1a-19e2-7c1c-6d9d24447af1@kernel.dk>
In-Reply-To: <b737f789-6a1a-19e2-7c1c-6d9d24447af1@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf7b4515-90b1-4d3b-f6fd-08d992c884fe
x-ms-traffictypediagnostic: MWHPR12MB1725:
x-microsoft-antispam-prvs: <MWHPR12MB17254AF76EF074C0BCEB4990A3BD9@MWHPR12MB1725.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO4jipX7wSdCAlxBdox1fXTvtbr5xAcKSrvVc5cRqWE/rYYxnqIyx/WAVLQFbo2yagvGBDX1aHS3kT3UstHJT45YrUIWRoNCFkAG9KOc7RuKOFnsBV+JMD16dLr1G5tHMipOEaw/ydtwfj+6WbU2xSSYj8dxTwZKybiV188PbflGxAwrLsON4R4KKSnu/Y8boTDs7SwW2yu8zmVMcqyE6a3obURqKTFZsyKbKOuoHgjCrSWBIreXOg61v0vobdoKm2vPwoh68y9CYcRsA5E0FYKfMR3OV4sIKRK2hDVDh6O1oIhjs63EDLKzM3pRdNYYitw6x+rERZEzTZxB/nzHxJDrcMu+VfW0MpahzgkU7HIpiJIbnDmkVPzCWxD7K1ZyvKbNaBHM1YboY0TtHCSfi6z4PkoDtOgljSdHRD5DuN9NW3PNx+kb7F5kledn0yoDoA88xB4kOvUUUnrBarM1RGNVDpxMIYuqHwglGQlxXEcvnwAaLrlQMseDCwyWaILnOnAbY2vGrrArWfb1tx+K4wkV4+2OUGNeakgtTgk5pE14YJLd26QODU1Q3R1eI5odVxjoRZWC5rabi2ir+yBZsq1mbH47mnYXR83/chDFRMjs92CKS9kmWzKEyRczWEgsOC3FlgLQpfDexd1utKcRQ5hYp8aLWbJdVGfsHi/HwhaMaKthQCZhPqOEZr3wvRw4K6p/Ayy/i0NfZLJifC15JGQZquUqvymR7PJvpLVV9iFZdSzPY9XTX81eS1KeubWhdhLB+0SI5fT7bwxygDLwsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(36756003)(8936002)(2906002)(31696002)(110136005)(66446008)(64756008)(31686004)(66476007)(86362001)(76116006)(6486002)(186003)(8676002)(91956017)(508600001)(2616005)(5660300002)(122000001)(6512007)(71200400001)(66556008)(316002)(4744005)(66946007)(38100700002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MytHR0x6aFAvczJ5WVNablpZUi83a0tQc3B5TFcrMUdHa3F6Q0tQeEJEQU9L?=
 =?utf-8?B?YUd6ZFhtdGxnM3dPQnk1ODBucXd1M2dIbDRobjVNOUFWSmhqUi9US0ZHZS9u?=
 =?utf-8?B?eW1TYStNWGlDaFQ4OHN0YWVHR2U4NFFEMXN0VmVvYUdYbVJjQzNISHZiSmN0?=
 =?utf-8?B?YmlMQU9YMW1sU2ptcmptRnl6SFVLZmEzZ2lxYlFDOWlBemlUeEhrbUo1YnMw?=
 =?utf-8?B?UjNzM1dNVkgzV21NMVFXOHJoVUcrWExDU2YxQ2ZQTmtKb2tiUEtsckV1elNz?=
 =?utf-8?B?Um9nUElRZUtDWUU5aTZrUzRKQWFQTFkzR0plZFBUOU5CV0MxQkwwSWlJVXJp?=
 =?utf-8?B?cFZodldYeGh5azZVRTVoVkFvRVBiZWE0Q2w1KzdEeXBmU1NPWFVyYnZJTEkx?=
 =?utf-8?B?YXplYm5nK2lnYWxLUXVtUzBETHlnMW5JenA1NXBHakovZGZPVGpmZ0NPbEhZ?=
 =?utf-8?B?a01GZXVIaGpxUU9uY1BhUVFGMnRBSStybC9mbGpqd3ZoMFRMRTl2KzJwOEVi?=
 =?utf-8?B?cU1ITUhqZk1LK2c2RFlFdWhhbHRvR2VQSEZBVWcwSkNlSzRCYmIvTTBSeXdF?=
 =?utf-8?B?TjRjZVZ5eHVLVkhjbHpJa3BsUjlzbTNRT2VKbXc3Sk9iOUFZcXNhYmZZY0Yz?=
 =?utf-8?B?R3Z6SnBrR0Z4b3BCUWhxUDNWbWJXSlBiNGxvWWxmVDJmU1RpUHZxcmNYcnBY?=
 =?utf-8?B?ZWpTaEtBUEpSMjczZ1RjNjQzbjZldEtQQ3FIbzhKeDJ2SkRrTmZvc2YrcU81?=
 =?utf-8?B?dVdROTUxSUlLSlp2dldxNDgzK0lkcVFiYy9pbnN5d0Nqc0huSlhNbXkrRTRQ?=
 =?utf-8?B?K09Gc0JrR2FCVFpRTlg4cEVIbDdlZjdudnVuOTUzTW1nYzN2aXJoTjJCUHgr?=
 =?utf-8?B?VEMzdG1xWlQ3MGFkSDhEMVdPOTJvV0hCNkNka0VyZzZmU2VjWDREbnorU3pP?=
 =?utf-8?B?VUpOMlQ1dWdmdU95U0NsVytISWJhTC9LT2xHNkZpOGhOVE52TnVxeUpoV0NZ?=
 =?utf-8?B?TjJtZWRITGoyclZaYmNFTDdRRktKeTlDZkphZmpVV1NhOWRoV2NQUGRhT0ht?=
 =?utf-8?B?czh5ZE5HeGxscDI0S1JkQkNnRHR1NGJ2Z2FMRTVjcGVocTVnWG5DNWUyem5R?=
 =?utf-8?B?bjdUMnlvVXBXM0F1SDBUTEY3eWY0SlpSWGQ2UUJGRTBSc3pDRm8xK3lxek0w?=
 =?utf-8?B?VXJVTnZTdnNyZXBnWjdwTHR2ZFp4N3AyYmNXdkxBZ2ViTUl3Skt1WHhPcVJ5?=
 =?utf-8?B?eG5RRUpqbS8rL1c3STNCRnB5SnBNcDIrdUk3RWE5R3lxWXZsZmdFSENWUkdI?=
 =?utf-8?B?d2EvUFJQUGhHS0pHSTFrNU9ES0puQ0xPMGdXL2lVRm5lYXN4aFZjdlUxb1Jo?=
 =?utf-8?B?cklCZlN4QVB2Qmw1MmthVFhrUjBwQUtwREVnTDVNSFJkOFNBbkhXUmZwZ0d4?=
 =?utf-8?B?N2oyak00TmZBUDAvTlZtSE02WnJrdFhwZXhwbUpiTXYyUFFlZXVVZW1QV2xV?=
 =?utf-8?B?K0VaQWNiRksyVDFvYi9IRzEyeUVlUk0zZGRrWWdlQ1lQWkdvbnI1TFVHV0Rw?=
 =?utf-8?B?NS9kNWRucC9LbTJGbDR0bjVoK1JabGlMeUw2S2VBQWFibEszbXRLYVl0dTFL?=
 =?utf-8?B?Q1dKMWlaYTZHak9Tdi9TamJqSTEzN2hRN3MxYkNOS25sYldWamVkUjJZRXpI?=
 =?utf-8?B?bkJuUjF4ajViUGk0WFdZa0tTaXNuZEFiMTFpc3pQc0dQd2FBenlrVkoyZGxv?=
 =?utf-8?B?ZHlKLzBnOHVKamw0S3huQU05dU8vYmVVTDcvbXcvN3lQWnVoeHJHUzNWL256?=
 =?utf-8?B?MDA1YTNmQ3BxWG82dHVuYm4wcE1rK3dDMmtubU4zMTV0VW42UDlDYXFwSDh4?=
 =?utf-8?Q?HLYlNVQ6rJ0k8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6F4FFE4DD980D4984A5BDB06AA51F42@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7b4515-90b1-4d3b-f6fd-08d992c884fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:20:17.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftobAoQpWGDhlUhY336kt+5xfsaSyB6qugZPiUmhQEN2UY/g2SRYc/Hpwpcv9CrgqTH3NQAAsJ1mx7WvpP8N1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTAvMTgvMjAyMSAxMDo0NCBBTSwgSmVucyBBeGJvZSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBU
aGlzIGlzIGNhbGxlZCBmb3IgZXZlcnkgd3JpdGUgaW4gdGhlIGZhc3QgcGF0aCwgbW92ZSBpdCBp
bmxpbmUgbmV4dA0KPiB0byBnZXRfZGlza19ybygpIHdoaWNoIGlzIGNhbGxlZCBpbnRlcm5hbGx5
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiAN
Cj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQoNCg==
