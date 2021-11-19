Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C688BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967FB61248
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 17:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhKSSAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 13:00:09 -0500
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94]:31359 "EHLO
        esa.hc4959-67.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhKSSAJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 13:00:09 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 13:00:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1637344628; x=1668880628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A3+yjKKOWUv9AVeRrdmAfel/3Oftb9QSUaYUZ9R6dYU=;
  b=eTp/ARgCfD3wPaMt65Dy7WF7JV3ZSIGvCh+EtKc5WzlnOdbefFg0BXu/
   tSSBoZWmS4rnY7Aq6YuaYlk8XrHNy7stwq3FYzxz/ss/gQKdqBEkIh+bI
   OizhXq0Db94kDXY4yTj8ThHkcNkn13p7j39Q8FwSZ7gVvFlQVnYaaHggY
   w=;
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 09:50:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUN1ltHdZ7b4ttQGi3eYtNtvNljfi3nh02IPyvA5aUU5qk6bSU0C3ibgAdG8l1h/EJagxtGxT/G1StsYzQvmVqMgV3fYOIFyHCNIGlCW3/8FtnbqBU53P9INCECVRFbgbMau1hM6TB2gVeTo+pEM2D803DEpalBZ+UemvdqfZ2OihBvPLRNV3VCsszGoxKxDSnw5js8L7yhfLNNbn/DR8mvx15TzJnseJI8t08KxpojqDdWE+5KO7MA1uixlg3d+p6Bw3Sqg69R3nRyiuAwMuYkeGN4X1Wnp5sNOsM/hUkw8MNV97ky3X4bSECwW+Ncbx6B9EWOd6FeMOQJ6qVfSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3+yjKKOWUv9AVeRrdmAfel/3Oftb9QSUaYUZ9R6dYU=;
 b=HywpRquNfY/K3W78Lho3kgHXnGNEfT+E/ya3U9bqxb8Fxu3QDawQB5mVAHrnYOG/JtCpU7oImy811y0d2H9jNAxZcgT3Ynu9rjP4i1YOWyWdvelhnr3LviO5Dpsx7axi4Isptq/TqJmwryxvlRu9oXMtxoEtA9lBB7J7GwnTOZh2P+ANRgHxoPEcDk2uqgkth/b3QHrev/9OYky4cQFVfa3rAcsB6NrGfKnG9R49m+jKLMXxL63V+2wIJj/NBXKINFa+ZpKvyOWdSgR8FAsswcvN/today7rVdGZB7uZ8F/XOa6ADrDpcfOuXgUYWPG04p8HjQsML0Jrrn4ZPxqgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3+yjKKOWUv9AVeRrdmAfel/3Oftb9QSUaYUZ9R6dYU=;
 b=Q3TGfQF3tDaeVAjZI83VzSvxUWHSnShUTJHFT0cDPrwrKbvgeuRBdyuKAN1IQXsvMGc7izrDqXkL6arIlboFllz5V/Sa9bbBb58hjBSuYpgzitOFlcLzt174WvMcDJ9pO2xZLZll7SfXdmSD0L8DQuEl7Go3OEz5fGcdMCZ2f+Y=
Received: from BLAPR20MB3954.namprd20.prod.outlook.com (2603:10b6:208:331::13)
 by BLAPR20MB3857.namprd20.prod.outlook.com (2603:10b6:208:30f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Fri, 19 Nov
 2021 17:49:58 +0000
Received: from BLAPR20MB3954.namprd20.prod.outlook.com
 ([fe80::9c10:4bdc:7f1c:6351]) by BLAPR20MB3954.namprd20.prod.outlook.com
 ([fe80::9c10:4bdc:7f1c:6351%3]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:49:58 +0000
From:   Tim Walker <tim.t.walker@seagate.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into scheduler
 queue
Thread-Topic: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Thread-Index: AQHX3JFMHVHpph1UsEOPk1igXvdaHawLE6aA//+7IIA=
Date:   Fri, 19 Nov 2021 17:49:58 +0000
Message-ID: <F7F89CB0-2B5C-47C1-BDB7-671DBEC31DC6@seagate.com>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
 <163732851304.44181.8545954410705439362.b4-ty@kernel.dk>
 <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com>
 <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
 <20211119165627.GA15266@lst.de>
In-Reply-To: <20211119165627.GA15266@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.55.21111400
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83a26fc4-49fe-494d-0ae9-08d9ab85010c
x-ms-traffictypediagnostic: BLAPR20MB3857:
x-microsoft-antispam-prvs: <BLAPR20MB38572AD575C58930E4B781BAD79C9@BLAPR20MB3857.namprd20.prod.outlook.com>
stx-hosted-ironport-oubound: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6jrXTNm0XgfO/JRaPHd2RtmR5xy7vN9VpeD/kcsmXTxxs0BZWtGdeLMsqjtHzOx6s4qmnG+LQ3FPPtC707eqDYKLoXLeErfy7F65piOWHMhXkwRoNQS0DVTHE3Y+Rhzt6MBremOPhgZlRQAwoD+weeVBK7cpOO41F4/KGCvVHYP8o3r44Bba8EEBCo8wrZrQNZK8wTJzqNL3h6g46OKKnoCDqCrJQ5Cm0fZ/EtgzDLeAW2TQzJJXakf1hBPvigZ1ROAd7smywXjQO6X6TGyR0jphpnsKoPXEGjXLbF/H5cnR1AG3WyRx35D3wdg9Vzodr47NU7Tw7GGBO4jeFggWzubN1QqEdErqHiMM2H3A/6xgj80eBKnEtriw5EdKnvNogop+dvu8vXDy7UPvGgI9aYmuPcqEsZmhW6QVY4XMAoYq9i1f/dL4B09MiGOiD6Qp3tauAD4Z5xeUA6ZH7/943GhaXYOjufoXLsjWpPPR/CY2YTUMcUIYinDrAhckKIQKwEXVdhswvTsMN76k5D1YzLO1m47s+BrLAAmDKd8bVDSP8ZngvJX25/kltQ/Ncv1AnkCqkexQKGEKYcL7Hepd8w5FtXJULbWHRyS+W9cMrzXKYtRsORQAo54K/gaSqlDnywhEvT2Aq4kw8Gatn7RNgc1BJuj+X9cTt/prYA6FahKKMFHXcOhbi77mbdl8/0pl58yCJYXDQs7Q2YOf9JbJBFciYPDVXt0UNdx4GFS34sYAiHwJyS3t8Ko8McM37iI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR20MB3954.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(2616005)(86362001)(66556008)(91956017)(76116006)(66946007)(66476007)(64756008)(66446008)(8936002)(2906002)(53546011)(6506007)(508600001)(54906003)(71200400001)(316002)(26005)(6916009)(8676002)(186003)(38100700002)(122000001)(4326008)(36756003)(6512007)(5660300002)(33656002)(4744005)(6486002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZDN1E2di9mU1dEUHVUc3A5RTVlS3Z0dmcxai9EeVpCSnIxcmgyVkZCeXgz?=
 =?utf-8?B?eFVhVzBSbXl2RHJoQXNqTE1tbWtoMnBqdnFkRjJRMXdXQ1k3MXJNK0RMZTMw?=
 =?utf-8?B?MDg3b3M3WGUxbnNSRTUvUS83OHVlWXJkUVJPMVNZVW5lbmFWRExoaU5aY0hj?=
 =?utf-8?B?d29zTS9IN1dqQS9vRUJzMldFZ05JTXBzTWVoaVFpL3NSbDVLYjRZZ1NSRXFH?=
 =?utf-8?B?ekJxbWFEY2V3R0ZnK1JUYTZBWjBUTVh1WTR2YklrOEd2TExWT28ycFcxSlp5?=
 =?utf-8?B?STN1TDh3dmpldW5Sb2pGVm9hSndzbE1NRFFPc0UzbXVNQU5WVVptNktrQTJ2?=
 =?utf-8?B?TWRvR1VzOHNvbTFxcjNTOVE2bCtTazlIZm4yZnVOMC9yUFQ3VExlREpOSVZE?=
 =?utf-8?B?WFEzd2N4NXJzRjNBVjFpL0tyWkhPOU15NXdGeE9NckdyNVVXenhiN1Btb2Uw?=
 =?utf-8?B?cEZRekVzQWd0K1kvbE1HbTNwc0x2Q2NYLzRoUnhjNEpudXE1dzh0WHk5UTJ3?=
 =?utf-8?B?bDA2OWliMzJqcklNVlVTazZlN29RcjluZmFQa01nWU5YODUxTGc4bXAwRFZ2?=
 =?utf-8?B?SjM3UDNXWG40K2trS2loN2RqcmdXNHFyb0VxLzNMaHBrbDVZY0czcm5sRHZO?=
 =?utf-8?B?SG1kWlRMVW5EM1JBNlArejZCWHlNVlltK25vTzBQNXJoNmNpU2UrbGViVWRr?=
 =?utf-8?B?UExZMDhKR1RjSEVqZUl3VFNBVzBFOUpmV21mZGZsbEJ3QXFZY1k1ZDE4RjNK?=
 =?utf-8?B?THNRRWxSaU84Z3c3eFlnR2NKOEt5K1JqTXN2VThRWjVtUiszQ3JJRTBSZkpV?=
 =?utf-8?B?azYxa1JDNk9MdFV5OFdaUkY4RkFvTWlGYTNsYUU0c3RBZ2F0QSt6ZlFRVjJy?=
 =?utf-8?B?WTh5V0luUGxxT29yUFNIMkZ2dC9MUWVoSnp4YzBQeU9LcFpOVkpBNGJJVmFY?=
 =?utf-8?B?YlhZZlJMU0FSOVhFWHFMY2x6cngrNDV4ZU42My9UWHlSTmZKekNEVUhPSEI4?=
 =?utf-8?B?VDVhTDNrV3pURkJMYU1TbXRzeDJrRWYvTmFGY3liVW9yZmsrbytJZHp6blFq?=
 =?utf-8?B?eVpnaXBpSDBtUmU3ZGlYQWk1SDhEekMzNXIzTHIzQ1ZIR1RsYWFpQzVtNStO?=
 =?utf-8?B?RUNVOFh4ZG1BUEpxNnhhSzhPOGZhR0EyOGQ3QXVkSS84NHdSRUdRSGcxSUdZ?=
 =?utf-8?B?V2xpaHRNVk9XSVdZYzhpeDJTb3FSbjZhS1d2UzBqb2Z0MnhXbUVZOERnYTgv?=
 =?utf-8?B?VzdOenFzamt2SmVkYUh1eDd6N0Q1a2oyQ01iaThUb2lEa2swNjZ6dFlQOFYx?=
 =?utf-8?B?SXZ6OEs1OHBxa0c4RGcyc3RrZDJLZUdDKzZkRGxCckJGUGt0UEpOWW02cVRo?=
 =?utf-8?B?eWVOVnNTNVc3WXh2SnBXUWs2b0VTRVNhL0ZRR3psellaRUxSMzhIbVZONzRr?=
 =?utf-8?B?K3ZLSWFIUUFGQUxES0kzVmpoL0s4a1VrdmNESDFic0xIWXVrazVoc3VnUGp1?=
 =?utf-8?B?N2F2bjFHdVErZkJVSVdaazBKR05GNFFoaDJPRjRsR3RYVjRkMERxcHV0M2ky?=
 =?utf-8?B?Vm14U3RhRjBzV2FjMDk1WWxnS2tWRGlKS1FKODZUMmU5TUQvYXZYRlRBT2Rk?=
 =?utf-8?B?YW9mb0k5YmZWTnlOdVdUZjFsUWJadk1JOVJMek1XQmNDL2NTbjdra1p3NDFp?=
 =?utf-8?B?T1JORjZzVGpvcDVxVjU4RUVLR0JqUWhkSThXNVBLNldPSnlkUFJLVnVtajM4?=
 =?utf-8?B?MWhZajZzRkFhMmxlemhNNkg1bnNCSU4rbWdKT3pxYk5oaGQ4WURSS1NSUnp3?=
 =?utf-8?B?SzErd1prTHE2TDRsTFl6dHhvSXJwcklMKzVFc3pqd2RHbDJEOUZacGJDT3d2?=
 =?utf-8?B?WVVXdFRPTXZPb29UZmgxUFc0dERGYmRZaG1sNHRTc2YyQTk0ZmV3Rjc3Ry9J?=
 =?utf-8?B?RTU5dkl3ZGl5WnhRcXBCMEpSWlliM2pidjArWDhCUWxLbGEwa2lOOTZTc2p0?=
 =?utf-8?B?dXRMcDJTSmk3NXZaR1IvUzhiV3RKUWU3R0ZaWXpxYjlrMlRtektWT0o4WldZ?=
 =?utf-8?B?L1RPaUpHVnZ2ZkJ5V0krSXQyKzB6ZS9YMlNrUE1rQ3FuSkRFUTRObEljanB3?=
 =?utf-8?B?MHAxRmNTWjdYZHFYZExtMFRtdkQvcEFMbWZhZlNTSTQ0SVlYZUlIWitCUXZ0?=
 =?utf-8?B?aGhSU3UzaUx0Z3VQZnEyYzRBN1BNZTBSYkwxV3lqZjJkOTVSem1tenRrcG8x?=
 =?utf-8?Q?5MaDyD7sDUycyBoXuchr7Hupci3PPGy8otoR54tJwk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <440A665D997B024A976D05405BCA50BB@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR20MB3954.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a26fc4-49fe-494d-0ae9-08d9ab85010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 17:49:58.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqFWpBojqqwhLppwNl9Q8QXt13yE8VQv6U4wROobwqrun4wsoTC11GLRTv7u/bpoDCCuzbYBPO26nvdVuIQfr8HnNJGjjewI1Y9bIoo5y2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR20MB3857
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DQpPbiAgRnJpZGF5LCBOb3ZlbWJlciAxOSwgMjAyMSBhdCAxMTo1Njo1NSBBTSBDaHJpc3RvcGgg
SGVsbHdpZyB3cm90ZToNCg0KPg0KPkRpcmVjdCByZXBseSB3aXRob3V0IGEgcXVvdGUgYSB0aGUg
Zm9ybWF0dGluZyBvZiB5b3VyIG1haWwgaXMgY29tcGxldGVseQ0KPm1lc3NlZCB1cC4gIA0KDQpT
b3JyeSBhYm91dCB0aGF0IC0gaG9wZWZ1bGx5IHRoaXMgaXMgYmV0dGVyLg0KDQo+V2UgZG9uJ3Qg
dHJlYXQgYSBGVUEgYSBhIGZsdXNoLiAgSWYgdGhlIGRldmljZSBzdXBwb3J0cw0KPkZVQSBpcyBp
cyBqdXN0IHBhc3NlZCBvbi4gIA0KDQpEb2VzIHRoaXMgbWVhbiBhIEZVQSByZXF1ZXN0IGZvciBh
IGRldmljZSB0aGF0IG5hdGl2ZWx5IHN1cHBvcnRzIEZVQSBpcyBldmVudHVhbGx5ICJwYXNzZWQg
b24iIHRvIHRoZSBzY2hlZHVsZXI/IA0KT3IgZG9lcyBpdCBnbyBzdHJhaWdodCB0byBkaXNwYXRj
aD8NCg0KPkJ1dCBpZiB0aGUgZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgRlVBIGl0DQo+aXMgc2Vx
dWVuY2VkIGludG8gZG9pbmcgdGhlIHdyaXRlIGZpcnN0IGFuZCB0aGVuIGEgZmx1c2ggYmVmb3Jl
IHJldHVybmluZw0KPmNvbXBsZXRpb24gdG8gdGhlIGNhbGxlciB0byBndWFyYW50ZWUgdGhlIEZV
QSBzZW1hbnRpY3MuICBCZWNhdXNlIG9mIHRoYXQNCj50aGUgY29tbWFuZCBuZWVkcyBzcGVjaWFs
IHRyZWF0bWVudCBhbmQgYmUgaGFuZGVkIG92ZXIgdG8gdGhlIGZsdXNoDQo+c3RhdGUgbWFjaGlu
ZSwgYnV0IGl0IHdvbid0IGRvIGFueXRoaW5nIGludGVyZXN0aW5nIGlmIEZVQSBpcyBhY3R1YWxs
eQ0KPm5hdGl2ZWx5IHN1cHBvcnRlZC4NCj4NCg0KWWVzLCBJIGNhbiBzZWUgd2h5IHRoaXMgZmx1
c2ggbG9naWMgaXMgbmVlZGVkIGZvciBkZXZpY2VzIHRoYXQgZG9uJ3Qgc3VwcG9ydCBGVUEuIFRo
YW5rcy4NCg0KDQo=
