Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BFC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D496115A
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhIUNfV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:35:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55220 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232953AbhIUNfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 09:35:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LCw4IF022594;
        Tue, 21 Sep 2021 13:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FwsV6RM1x3nBohWE8Ul/Yf42DlgLDtJF6a02X7th/G8=;
 b=0OAVoQH1P9in99/BEE/NUfJtFBI1ln/88LV/8r/4tLIIZPb4+pdeepHAoxZCn4LxhoZd
 NzirZuJMhFj47UOPQl5BO0c1HbOIL9uN2W4DKocd9SEfy223RuAISMQkEIIuS9+LMItX
 acjYccb1O1C/Oq4M5lcyAJiYAa85apK+8nphDxxufOeUk24vt+hUAOGXuKEMq+MpHxYT
 rvOcwMCn6KgXD415jc3XwfSwUeQ8VHCQyMll9Iwcq6PsEG4m8x4NBHSBrLz8dWl3Lg0V
 WSusIvPveUTCukW5DwBzMyA2rAJMF3EUSvI9e9GSFjCN/7y0riU9x9tizAfrdSDsGNNm 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7814j622-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:33:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LDK1ug013654;
        Tue, 21 Sep 2021 13:33:49 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3020.oracle.com with ESMTP id 3b5svs7q2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 13:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W34/3pB8K5ga82ETFQq1leBzZcZ4vFmls021Q2EdKvw8LusKqEjIwl8u7+/FJLO8PV9fF5C8GzoHiW6xD+9WFo8mCdYi7ybNODYEu70b92gz34EIAN63FI9iARcDyKtV/RUrJJ37tc6J6Z0kXe8aHhLzsjvr71rXT5owByDWzPSh5s+xwszyJ50mFNOrfkTdb8bca60drrBDB+vDaw0/EH7oYi87V1mDSaFss/haA0ms+hs3V4oaToDZIbh8zc5/7uFQbaIt3N+Xqq2fkdcXM5UEQ4PY0IWVDyK5uMAp3Hus9h7ssKCUSTfZLHUca+WEBsbmTjQFy7olIjxqmsTKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FwsV6RM1x3nBohWE8Ul/Yf42DlgLDtJF6a02X7th/G8=;
 b=fu12TbutHI8zmv288793xzZddc+fBTNUtYWWBfp8HmdD1FmbiQ1RKLvamd5qmOmxIIemY0uKcWP5fh9D+amuZ/kJvkVjhFLYd3Yz3NrEYx/5I6IWYzKPCZSQIocKJnMctV8qklSZAnypR87ntKB/Y/ACwIoT4sx9zhVAjqXSW1E7cR4+nEK31jRjpZy9ozT1nO/BWXHTiSoTcKv64Y6QaSbCnVpOLw5lJ8m9MG/s7LoRh2iZknG9DwGFbOd2xhMW/IAFU/LOZZtuKmUpVHXLgkVLpYfINmaBuUSsLaQPYEB1t+ywkmgvciRyaw8GQ19YURRujVX+CSw8BegNGyeK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwsV6RM1x3nBohWE8Ul/Yf42DlgLDtJF6a02X7th/G8=;
 b=UWQaEvIwCNAopZW306kIjciHkglSMwGi0TlWuWKmN8GwvaJsx7gqoURkp8wo0+CA/F/Us8Lb9k2+0Pqt+dRkm1c/tZ5XOBIAOU4+r8a+vQDNS2NFCXL37bvfY7Rwcc93+gPhoVrD2cZXA/z6LE/xer+slJoETv9W5L69BIC3No0=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2909.namprd10.prod.outlook.com (2603:10b6:805:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 13:33:47 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 13:33:47 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/8] loop: use sysfs_emit() in the sysfs offset show
Thread-Topic: [PATCH 1/8] loop: use sysfs_emit() in the sysfs offset show
Thread-Index: AQHXrsobNs9Acn+86Uq6If6lVMrtN6uufQQA
Date:   Tue, 21 Sep 2021 13:33:47 +0000
Message-ID: <759AF0F5-B424-4F96-800A-45E8DF944296@oracle.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
 <20210921092123.13632-2-chaitanyak@nvidia.com>
In-Reply-To: <20210921092123.13632-2-chaitanyak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f9aabe-bfaf-4c1c-c85f-08d97d0470c0
x-ms-traffictypediagnostic: SN6PR10MB2909:
x-microsoft-antispam-prvs: <SN6PR10MB290906781A05AE98AAC27693E6A19@SN6PR10MB2909.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmW+zly9kwuqVOCBLihOlyH9AVQOw+Y5TB/jI6BjGnTZZ7JIYbYh1M3NpbHCzm302ckDovVFZ5eetJrS8SJNCghNHZhyt16j+E79JM5UQFLSTiOvWl7Q5RSBW4jLGUtSBSAIdtZKiSxQuW79W6P8QyWYfDDqcZ9kvFciUBBG00fsPNZSggIqKBs6r54BnWLLU2U6ftKTn34HtlKF6ZB4M74zR7G1xKrv8CVvgCPMOy4igrmPupTiHlzfJbS/ncfMTjpPvgwKTWh3n5zRYBz2C07firlHsK1+V8Z0hfr4/8+AFdNkmy2Kd8KzQgcbJDripB0WUt2RydbyeIuz1jvGH7dlR7XY36bkpZgysaS1UbqJOf7E3z+z9K6Uv2BzBJMMhuTBnLeYG4kQsNIoJsKNFmgW8rR0xOFh02hPg/HNDB+6ALAmqKrwzA5CGbV5vRj0BrlQnJR3zz/TxMDMH4CQGd022BPAswYUGG/k+YatsEOJRCbuAIroP05vKeZ6SbH2TSloc74DiH3dqLvOg3U1amZAAHEMDSTRgXeKEP52XhTpTmKXYzYkBWEhGRc4jSun1Vk9Jb88KypO+RX33fzDJ3eA7t76buHtCzWJhIuYGg4VQ8c4iHEBWwi2ZXRoY04KKuDvqG/uDqRV0O4ykxPPTh4wUGvzOInb1FfnQQjI2b9vfxqeaMFeiOJ+NAkUjH8Gz/JJy/0wylm4Fh1ShaGKiU5HjUe1n6lNz5BxJcjP1BJJlEpG/NrYFhFdmW5WiFMP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(33656002)(8676002)(54906003)(36756003)(6486002)(26005)(122000001)(5660300002)(38100700002)(6506007)(53546011)(6916009)(38070700005)(186003)(8936002)(6512007)(2906002)(44832011)(2616005)(83380400001)(4326008)(66476007)(76116006)(64756008)(66556008)(66446008)(71200400001)(86362001)(508600001)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hJa1FOTDUxRHVkMDg0MWNnL3B2TGhDVy93NUtWZ1FpVlo4Y2hjYk1DcVQx?=
 =?utf-8?B?T3BCKzRkQkxoR1NVT1ZJQktVaWtxZ0dpa1BtakVONFpjZy9XS2pVM2xSWFk2?=
 =?utf-8?B?eDFHNVNaelhKd2I5d213RDQzWWFEMVhIbkZmUFFDV21DYzR1QUN6NVVya2JV?=
 =?utf-8?B?WlFCbE9JOUFKelBNUHhzQWIyOG55UnRpRXRPeGIwLzhkbytFV3lCWlo4Lzc2?=
 =?utf-8?B?VjBaVElRcDB5NUdDWVhKMTRDaVZFLzVzLzRoanRPVDRINllkUmIrSmR0dGty?=
 =?utf-8?B?dkNtWDg3Vk9xVHVBRUlydlp1UU9PWCtMM1dwSzI3d1FqMXppOUlaRzM0cUJ5?=
 =?utf-8?B?MWpQdnJzaDRUbGtKeXByNXdPdkI2UU1FZnVhL2thc0lwY1l5QUMrMXdGblBI?=
 =?utf-8?B?Ti9yZ1E3d2k0UEhoeWdoc1poTER5ckpJb3hUZnlSN2pGY01JUmhkNEl3dXdr?=
 =?utf-8?B?YlViMDY1SjNNNjdidTZHY2NNN0RkVEZoQXp2dXMzWEEraWhpamZqQW1xUm45?=
 =?utf-8?B?Ly9oK2I3bnNWV1ViVDdpR2krVE1sbGdPUHc5VzR5VUZMUFpwYklkRHZDN0FT?=
 =?utf-8?B?MTlwQ3AycFkzSXFnQVU2MFMzbHJibXlSS29rZjJxZEd0bXFZUXlZZTdQU1J3?=
 =?utf-8?B?ZHhnV21lK3NlRmZpWnBIcDJZR0NwWGlNVzUvaWZzYjNTTThxZTQ5S3g1Z3dB?=
 =?utf-8?B?SmtRdSs3Y2ExaCtPVzdQN1lsekpqTTVuVWZsMnBuWXZTUzNJWnZ4cURKOG9R?=
 =?utf-8?B?SWJhTUJ5U1ladXhOUzVST2c1OTdwazQ2Z3A0VllCdnpOczFsTjhiTEZCQm1x?=
 =?utf-8?B?d040SlU2RVpZemJ5WEYvWS9GZDFNY1o3Qi83TWVxZmpKY1Z2MFhieUd1NHZo?=
 =?utf-8?B?QnVqVFRDUHBZYmZaK0YxOFo0QTA0UE9hRmxPWCszZkpoNHhGQjFsLy9nN21l?=
 =?utf-8?B?QVJMMkJjS0tPcDV6MXBoMVNGUFRYSGhLOWJjS2pLblNyZ1FRT3RaV2I5RTZJ?=
 =?utf-8?B?WkVCNm5rZmtHL2hJVEZkNE5KMGUrbWp1WGgvOE80eS9OTFAxOXNvZm9rVmk1?=
 =?utf-8?B?SWw0T0dJK2FkV01GZ2Q1OUoySnVCTkNaazNmS0Vwd29LM2JwMkphdnhpOVNO?=
 =?utf-8?B?MEk1L1ZXZ2xTNFZBLytTU2VoRURUemlYeEFLRGhmS1RIeGozT0N3c2x0RjNl?=
 =?utf-8?B?T2IrS0NSS2czRVh3UDd3VGhOaEZBSHJTOEpHZmw4V29EZVc2MmtlU1Boc1Q4?=
 =?utf-8?B?azMwc09majVuMm42b2VCVUwvdHNRc21CS1h2M0NGcmZvRjQrWFFFVWJtcEhy?=
 =?utf-8?B?SFJ0a2Q1WlZJYTZKVzZEbmo0dGRHT1N5VEhXZE5ITmpETnVlbzFVQ1lXcEtr?=
 =?utf-8?B?ayswMWxsNjkrem0rNkJsVGVJNS9mNjBoTmRjSUVIQk9MWFRCU09FQ3pnSFJN?=
 =?utf-8?B?TGk4eWlmWjdBNUtHVDVLUDVjR1B3WUdCc0JScjZXSjRwQ0ZPS1d5Q0U1LzNN?=
 =?utf-8?B?VFc4ZW9CWC9QUnBwTHRoUStzWldNRndFS3dKNnRpc2xaRFE1Q1M2RFIwV2dv?=
 =?utf-8?B?bU5QWGdDVDhCQVNOb3puUmpTdEMzMS83dTUwQU14blBwT29hNkVUSUNYTGJw?=
 =?utf-8?B?NVFzeE1lYVpzdmRrQ1RUdVJrWHdpRC83TkFLeVdYS3l4dHhKbFRnc0EvTXRm?=
 =?utf-8?B?S01SRXhjZzQ2RnZjU1NNblU1d2Q4dTU5d2k1dktVQkUrUndGZUJhV21UTkFl?=
 =?utf-8?B?dm1mdW9zRmt1L0p5NmhQM0V5K1hMMlAzd0F5TjE0Qy9PdUdoZU12cnRsbHJS?=
 =?utf-8?B?N0J5WFduck5ZcVhQYVVFQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <96542048F756914A8F20249B20A1E881@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f9aabe-bfaf-4c1c-c85f-08d97d0470c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 13:33:47.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ikGK/5ZVH7dTEoY7vZzfR7bWhhPpHta5ldsx8yxywI2UnWONINbdxDVTBGZcxWeVpDlVcXhtGEwv52dHK8Ybg87NwYcu4HA6npXHhnEyYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2909
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210083
X-Proofpoint-GUID: NyPhb3aWgFXbCW06IhHVy-s6gG1Zpsr3
X-Proofpoint-ORIG-GUID: NyPhb3aWgFXbCW06IhHVy-s6gG1Zpsr3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQoNCj4gT24gU2VwIDIxLCAyMDIxLCBhdCA0OjIxIEFNLCBDaGFpdGFueWEgS3Vsa2FybmkgPGNo
YWl0YW55YWtAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBGcm9tOiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KPiANCj4gT3V0cHV0IGRlZmVjdHMgY2FuIGV4aXN0IGluIHN5
c2ZzIGNvbnRlbnQgdXNpbmcgc3ByaW50ZiBhbmQgc25wcmludGYuDQo+IA0KDQpTbWFsbCBuaXQu
LiBJIHdvdWxkIHJlbW92ZSBhYm92ZSBsaW5lIGZyb20gcGF0Y2ggMSAtIDUuIA0KDQpCZWxvdyBj
b21taXQgbWVzc2FnZSBkZXNjcmliZXMgaXQgYmV0dGVyLg0KIA0KDQo+IHNwcmludGYgZG9lcyBu
b3Qga25vdyB0aGUgUEFHRV9TSVpFIG1heGltdW0gb2YgdGhlIHRlbXBvcmFyeSBidWZmZXINCj4g
dXNlZCBmb3Igb3V0cHV0dGluZyBzeXNmcyBjb250ZW50IGFuZCBpdCdzIHBvc3NpYmxlIHRvIG92
ZXJydW4gdGhlDQo+IFBBR0VfU0laRSBidWZmZXIgbGVuZ3RoLg0KPiANCj4gVXNlIGEgZ2VuZXJp
YyBzeXNmc19lbWl0IGZ1bmN0aW9uIHRoYXQga25vd3MgdGhhdCB0aGUgc2l6ZSBvZiB0aGUNCg0K
QWxzbyBpbiBhYm92ZSBsaW5lLCBJIHdvdWxkIHJlbW92ZSBzZWNvbmQg4oCcdGhhdOKAnSAoc2Ft
ZSBmb3IgcGF0Y2hlcyAxIC0gNSkNCg0KPiB0ZW1wb3JhcnkgYnVmZmVyIGFuZCBlbnN1cmVzIHRo
YXQgbm8gb3ZlcnJ1biBpcyBkb25lIGZvciBvZmZzZXQNCj4gYXR0cmlidXRlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gLS0tDQo+
IGRyaXZlcnMvYmxvY2svbG9vcC5jIHwgMiArLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL2xv
b3AuYyBiL2RyaXZlcnMvYmxvY2svbG9vcC5jDQo+IGluZGV4IDdiZjQ2ODZhZjc3NC4uZTM3NDQ0
OTc3YWU2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL2xvb3AuYw0KPiArKysgYi9kcml2
ZXJzL2Jsb2NrL2xvb3AuYw0KPiBAQCAtODU2LDcgKzg1Niw3IEBAIHN0YXRpYyBzc2l6ZV90IGxv
b3BfYXR0cl9iYWNraW5nX2ZpbGVfc2hvdyhzdHJ1Y3QgbG9vcF9kZXZpY2UgKmxvLCBjaGFyICpi
dWYpDQo+IA0KPiBzdGF0aWMgc3NpemVfdCBsb29wX2F0dHJfb2Zmc2V0X3Nob3coc3RydWN0IGxv
b3BfZGV2aWNlICpsbywgY2hhciAqYnVmKQ0KPiB7DQo+IC0JcmV0dXJuIHNwcmludGYoYnVmLCAi
JWxsdVxuIiwgKHVuc2lnbmVkIGxvbmcgbG9uZylsby0+bG9fb2Zmc2V0KTsNCj4gKwlyZXR1cm4g
c3lzZnNfZW1pdChidWYsICIlbGx1XG4iLCAodW5zaWduZWQgbG9uZyBsb25nKWxvLT5sb19vZmZz
ZXQpOw0KPiB9DQo+IA0KPiBzdGF0aWMgc3NpemVfdCBsb29wX2F0dHJfc2l6ZWxpbWl0X3Nob3co
c3RydWN0IGxvb3BfZGV2aWNlICpsbywgY2hhciAqYnVmKQ0KPiAtLSANCj4gMi4yOS4wDQo+IA0K
DQpSZXZpZXdlZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aGltYW5zaHUubWFkaGFuaUBvcmFjbGUu
Y29tPg0KDQotLQ0KSGltYW5zaHUgTWFkaGFuaQkgT3JhY2xlIExpbnV4IEVuZ2luZWVyaW5nDQoN
Cg==
