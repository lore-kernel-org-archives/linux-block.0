Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DCEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB706138E
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbhI1Uqb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:46:31 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:28008
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242572AbhI1Uqa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 16:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJLBr2JwyAgJyI+Kfz4b6ioSgy5ywardmE/R+dNv6B4aocS4HfD+oforCw+paUcocj19O4qM7AtEmlRg6Q17IFGF8UrTOPauXAFPJStwUhiXmvL4jQq4S2TQDJqR5gkNY2WpGSPTes+mEYl6n+BQtZ7/hyd1AUt/JHNVhuDqZieF/zOxcUsGCjm72nVm8wKOqxmdl2gf4sU45SYwOvRbYOd1qm1f46uXV8Jk9QX+umcU8x+jDSLmmby0ilkgwKRbbxONy4XFVSIevDlQGPGrTILdBme+RKGDUcw+9YSuhQprbjsx8F8pgUgdMPQKf2UjV9RSATbiXOKxAXmvbb6i7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YVeJedpvnO5XvcKxCs3vWR8LOm0SYL0jmsDllxTmRxk=;
 b=l+DvPb6VynIapVJIHnXHA5z/lvcFOjykBTb4cogBPQ21glN0rFliVFPHlrJxHUSGf22ssIP/PMf9q+SP3je8mRYBHyLNyhF+/qXZ2gW1KOJmdOqCxgDT4on/+Q6I9iN9jtWBNAHcgEY3dql5LUDOwiU9b+FYOCGoZih0Zo50EbPDWcNL0MIwvOPhFhuCl0CaInMh2UQaR1UAmyukkVYdTixn/RUWvhR3Szu6t7BZIcaLxz3sy/DOS6i1k7w9rTRtx8k8JMn0IWpnh+2JOELDj9Icx61QYpfhl1gjyPA6Id4kzWeGKucTLCRPu1U8me42/SoKAspmztIgLQX7Kav9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVeJedpvnO5XvcKxCs3vWR8LOm0SYL0jmsDllxTmRxk=;
 b=oCTyEAJGBPf1tO40x3D3dKFkIiXA0e7CAAgt1BUpTvOF05C0meH5sZDoH/EeRApZNZI2snow94noCP7cEM+yCxwQ/uXcGe1Krav0lFJA7W7hSA6e8jhqS2VFY36bW159EGvWiCEC96ivW0kNM8XP3zZ2EBRguWVDqozUBBOc04b0/ztDiZMtIpXLWGX0FJj6jWYyY2+K5ABlkmvP/ayhJdm24pluFtNncAaKCHlRcS2NVHbJCCtFbn4HV5tdBaavV3gq9l1e/k3GJCzANABLCvhBhaTRaq82lGGdGm4KPPNriy34xb7UwtGBuc3uMN0E+MrzUR4/rJWTi1RHZxshyQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 20:44:49 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::8931:3580:e129:7d15]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::8931:3580:e129:7d15%7]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 20:44:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: print the current process in handle_bad_sector
Thread-Topic: [PATCH] block: print the current process in handle_bad_sector
Thread-Index: AQHXtCmxRNAzAncZYEyOOf4DGDJjYqu56wiA
Date:   Tue, 28 Sep 2021 20:44:49 +0000
Message-ID: <01d99526-effd-cbed-160d-82a7e5f3d5c2@nvidia.com>
References: <20210928052755.113016-1-hch@lst.de>
In-Reply-To: <20210928052755.113016-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 250e9fed-f254-4b5b-b608-08d982c0d0d2
x-ms-traffictypediagnostic: MN2PR12MB3951:
x-microsoft-antispam-prvs: <MN2PR12MB3951A25192A300CBC1BBDE88A3A89@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kB6CV2AszCaDPqHRpD4TlrMggDh+dudPS9PvyMuzGs4dvmQP0qL4rkGN/APnBJ5sL5JJ63s+VwcA4vHjpDkAySwrrKhLvfhhgVcbXmcsGik7rOPmU/+nefqcqYsXOdcVY+GnRbGwTSYCo6nbHOs0+mafNNT/TD1OXrFve3G3NvGFV7owHrMjQWopdfb+o5zv6BnPdRnFds5nRKJUkA+s+CmgKTkj6VSXhGjctp/DtGyUsWHnaEATdTl7EnM3eWMqcDDRNxgS3JqVl8cTPEOGD0N/Mzv5uWao6Uah496zo+BEU+h7GJeUdoXqLXgTp3D1k9RGeoBCqXm2QWrn3vPPTvAEl7nQF4kZOMiyZ1AERHWhPkbxlr6pm/o9fVLcYe2cldDW04S84eqIMyap2HyYyWgNENEqha3NSBOHVGigFWNxtCw4MbtL/6x4jJab8Ja/zPAJCQG8qLF4+UXyNttf4T/OhNqQnItK3eQ0hIqYorD8iI3irKwhP7ulqn9wpF1G3QTcArK8PaZFHdLNh/Op1KjkdNZutqXAkXS002Pceph5fI0Ip2Kd9456A1br2jg2mdZ1qan7WiYuUM8strFEUZJg/o1OakwbH1n+nU88TCaboDVU8+VjXOBYxhZUp1SwfPQaPiSeW2XpJ3zxQeBnfcubjxhlXNdMiIEe76ix+TdtTytcRpkghQAHN/YTAr1jwXDHTOjKQLoTfaKP952hoxwuzPv2HfCpmcf7fw/fNBoN9AOgdKQukeetN8F8QAC5Rv3pA11wrqs1mAT21o4vmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(53546011)(6486002)(38100700002)(5660300002)(8676002)(71200400001)(8936002)(186003)(508600001)(6512007)(316002)(122000001)(558084003)(31686004)(66476007)(110136005)(66446008)(38070700005)(66946007)(66556008)(91956017)(76116006)(2616005)(36756003)(4326008)(2906002)(86362001)(64756008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjlBWlE3Y29mR3dlRHZ0UjVxUEljL1R2djd5TGdibm5ad2lkVHdWOWtjM3ZW?=
 =?utf-8?B?MUdEZzdMZHV4aTlBRXprK2NhR2xPakM2bzhyYjE0dU5STjNNU3hSUnNmdjZB?=
 =?utf-8?B?SlVtcmJZcmp1TFpFbm9UWXJPY01XV1k3NUVpamtrbjFubWVCTm1XRUhnU0dY?=
 =?utf-8?B?ZWl3aEI4eWpxckxoV1NlSjhkQkpURVJMQ2pHMjRJbERBOEYzQ0JERHpndWh1?=
 =?utf-8?B?RU5sVjNsVm5hN2xVajQvRjkvVkFWZEt1ZWRGSDZWTHdya2JZQ2hvcG1RVTZu?=
 =?utf-8?B?WHNCVFdUQkMyblRtMG9IbzhtSkxjaDlycTB3UGtxZGRNRjQ1cE5nTWRIMDJG?=
 =?utf-8?B?NXkwVUw5SndYbVBJeUJSVXJTelAvdHIwVFdoM0RzU3dWZU1qY2RHYURNUGJv?=
 =?utf-8?B?UEVLdE0zZDVlN1FrVGJ3TklBUFRvZUF3cHFPYjBoU1pMbWphVTZXdGp4QzY5?=
 =?utf-8?B?WVgxaDVSeFJ6SU8xUXJkSm14RVJFbXNLR2dPNlJBenlTRVdzbUhLVGZtWE5D?=
 =?utf-8?B?RnBKb2o5NWpCODY1SGcvdFJIS3VuK1JYaVJaR1hOUTBnRS9xWXE4dEdGNGF6?=
 =?utf-8?B?cDFEdk9RMkoxendRcWZNNmRKbEgrcS9JclRFRmwzeDhPTU9GOSt6VnFsYmhE?=
 =?utf-8?B?ekltM243a2NqY09Hci9SMEZsZHZoUWNkNW8rSW5PdUFuV1RBbGMwUkU0S0ZV?=
 =?utf-8?B?M29ZY0szZ0Rpb29tY3ZkWUluTTZqWFdHMHZjQXZpUnJKbzNlYWZYTUt0OHZx?=
 =?utf-8?B?cWJHT0c3RTBlNXJIRXpiZXNkU3d1N1dvLy9oa0xkZGt1Z0NiT0txb0d0MVBI?=
 =?utf-8?B?eHdaT1RYSU5tbDRPdjREdjFYbmoxUTVXQ2p6THNFZ3RBRUMyUnA2NnRvd1dy?=
 =?utf-8?B?aVVZQVJCYnpvUXN3c3lzSGN3VXF2cDQvSUVucllXSFhtQnBpelBoY3dPbmMz?=
 =?utf-8?B?VWdlRTNsVExDYWloUEJKcW80SGFFUGJuVU9CbHBBOGZUMXVCUlR1ekZCN1pm?=
 =?utf-8?B?MllkeFRUT3gxUlNRUTUwaU9nWmZKc2xidCtEY2pGMnNlZUhxR2M2bWpUa3hr?=
 =?utf-8?B?ak8rN1hNdHpPMk12TXpUdlE2ZWF3d1MrSkZTb25wSGpHbGdyak4xQ2trL1lj?=
 =?utf-8?B?NXIybHNxUURxWWttNll4MEMxeUVYU0ZtVXBqMXlaV0hDSTN4bHZmZkdxUU1x?=
 =?utf-8?B?ODRFeHhYd1hBaTE5NlR2T20vZFlTUWg5VFlMb3RqdUtGUnNrT1phMm8xVWhr?=
 =?utf-8?B?UGRjSjExYWFKb0Jldk9qcDNYL2gwYlAwK3kwZmpxMGlRbFZQK0x2YWFmNXFL?=
 =?utf-8?B?dGxRL0J4c3lwWGI2WU1XOFlxalZiWGZmT2d3cVNNKzRwb1Q1eUZ4V2FCTmQr?=
 =?utf-8?B?S2pXZjYrNmdZV2hZcDk2VDQxWEFTY1BnZDhDVzFYNWxRZlJ2TnhrTVAyYmlP?=
 =?utf-8?B?OTFZaTJGbVMvV2JDbU1Ra0R6UUhOdUt6R2UrcUFPZ3NLdHFKWmtoWUs1VENM?=
 =?utf-8?B?K25aYzR4QWRSNmdVR1BzMVN2N2dNYS8yMkZPVGFiOUx2UlFSNElpWUVoZkph?=
 =?utf-8?B?aUxnMTcrSDQ4VnVuVVlYa1lPU01qR3k0OHF1YTlsUndPZ0Fsa0FQbmppZjJU?=
 =?utf-8?B?bk9JcVY3WE5qMFRCNVIvbG5OVDhYdHJYTUEvMS9TcGJGRkxRQnU1K2RTRVRx?=
 =?utf-8?B?ajlReEZ1ZWVPUTRIVkxrRmloaHlNSUZub1ZMY2t2SVN4dDd3aHcrNGRycTR2?=
 =?utf-8?B?ZVRXaGcrNHA2eFVwdkh0ejY0d3dGZHd4bjNYYmFpY1p3dTFpYXdnZHBFaGx3?=
 =?utf-8?B?bzJpYnJUNUU4dDlZYmNPdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E48FCD73CEC7BF408E5298C98C9D9274@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250e9fed-f254-4b5b-b608-08d982c0d0d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 20:44:49.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sh+ECCcpbmrC5rxQh8Q1t57oSHiz0uFX0xeFZs6RYgL5BoBzdBRaqlQ9mM/nPxwX37jVS27BZq9v2RHviIyQ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gOS8yNy8yMSAxMDoyNyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE1ha2UgdGhl
IGJhZCBzZWN0b3IgaW5mb3JtYXRpb24gYSBsaXR0bGUgbW9yZSB1c2VmdWwgYnkgcHJpbnRpbmcN
Cj4gY3VycmVudC0+Y29tbSB0byBpZGVudGlmeSB0aGUgY2FsbGVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
