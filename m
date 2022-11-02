Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4BC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 05:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKBFvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 01:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBFvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 01:51:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19141571F
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 22:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blIWtIHW9YOQYyO8SDt2TZIHFgvqKf1DlgstNck1c/t3tHAiUqY5Ksr3KpyS0YeI79Wn5jupLhOduy+XLUysBAfiJ00k7F5Ew7epqu48OAQlavTZS2g1G6BdotKmtcjPvMmqjz/JxfmA2DtslhUQw07Xj9GbhFm9uNd4WKBdiOMaVTwvrMtfDCHGK2sjAiOPt7Ulue5+HHE8u/p3tvTo+v64nHyitIVfpwbt0pNFISwgcyfC12yG+KDAWswc1T13wQpT+WopoSi2skpDUcbeaecztQmxujAaT93ORfPWw0xnlOv0JJ/ZHye9QUcG/GamiwPtLfNHW8/XaDgaWy9g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vEP/5QuKGVO+TrBJwA5g9wfz5wqKCOpNZ8gVmD43Ww=;
 b=kTV+MahHt+vIfkBxXXImGN0+EqBhPm8L1419EfjOIwFH1z23pm+vAC/f2c6q8hASrTKyCFH36mLGm/bnzOfx9r3ON1fVV7TN2X3JC9W5KN8sY9HugXzcksFSv9O5fjaC/w6IMVKUvKxS9xs54WnmLsGopKmO7EvvrJA5yItysq+2txctwbKLbDp3RculT8XhCbuPEpU/2btWkJ3UOV+vofdg7VNs4kBfEdkpdudKxw1BO0Vi10/QI+MJd46ZjjHwWX4uuivYvcR7lTdOpdvvPKoWiEuKIMGzV43uYyaO6ePGk3WLI8h8cY4Vkuh84HfbPi8cTLM3WFHjQY0ByxrgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vEP/5QuKGVO+TrBJwA5g9wfz5wqKCOpNZ8gVmD43Ww=;
 b=CJVQkLFKjvJFtTorexJotc9Yau5h/Zy1Vm1YV7wvLKfSM6jEDvmKkgUK/8tkqWMMjaj/GpNB0Lw9U/BXRq/rbA4AETTKvPty7yxHBVN3W7k1Ge4Zka8SmnBm6bTisoK+B3duaZTgQpSORxlOgyg29kUPc0o+eNDiZR1/Jt0YPTSMrE80ZdNSU86Bqyp8PrfnX/egGY6GhZ0jZLn0+9OJBb+xMYTnFlNKQHEDOquhCbBkLOtllJdXlHJyqNrZpoklQWtPqRNjoQEssLYki4b/S02srLHmF5twyVeqK+UyG9iMSa1P6gi+11ih1t3Jt5vbBl7jAVQCQDx2+nPe2rwPnw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:51:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:51:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] blk-mq: add tagset quiesce interface
Thread-Topic: [PATCH 13/14] blk-mq: add tagset quiesce interface
Thread-Index: AQHY7gMGwlZAJXJ9gUG3lnotxsVpUK4rIiUA
Date:   Wed, 2 Nov 2022 05:51:01 +0000
Message-ID: <34e0a12a-1010-faa0-379c-43d84c3c7a7a@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-14-hch@lst.de>
In-Reply-To: <20221101150050.3510-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: c90acc62-d8e6-47f0-9ed7-08dabc9638f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIldxQEa9hYpVrEMYW/pZHWbsU7cB2q7j0vXKtCXdaTxhzJcr+NtTO8ddOk4LQ8enk+lu1+AoCwuXxZM18Bfjih5083vDvPZ0e4WlSPnqUWVAVeJ+fEYFFselTRH6jfoQgUSCSXWw3XAlu1kF8f7P5p5dl17eryCa0icrTycIvGra2UC07aJzL3w3bqjg80wMMjgAWNHi3uvT1ck/dZ/CYqeJsZm+QRStFdjVY5+RkL568+szIPFWc07qKHT1AQ5MQio8w9wN18+qIyEeRMxEcyWM7PNVmPHgqRNpZx79c9VlROLSxATWCOxJE2OUg4tKblD7vnJCQPtFHDUJ6ZofVJvKGAkRIJdF8rc+IrlYLjppSQt+SZvv9kB3/sH0jy0d89u0q8YTK8ckP5b2DS64L5MVrgDIlqPZnhkwSFbfFtHwuS9ewCtMNj2ZIYCtdPt1lDJlf0/IBOVseb6pFf3FbSbJZOlm9RmiuXpk6+m0+B2dcJNKVL87IqJiTgvCh8LMXcWZVJYzzrEUpE0Lci/QUdjZCXifVUSgmAEbdg5T7GnJlj15g96krPfOD+CyPEUXVPIbr1/LgP5xOprfyPzLsHPubzWbGW2z+/9tEt+BhNf4G4UUQv+f5tCeQgrSXalN8jZlv4ErM1GI/0IDJXf1g1V/YCO1tQOKkZwf5q/+UZjG/j2oQK9JkKwc6MZkC1L0ouYNsVgEt7uZ/nT2rN/2F3PqC2zIE0/ATMHdK5aEyXG8ueNrj5GBzPqQXT+F6fRpdyziBrRk7qdMJXXaI3310zl/in2pDrknl25kD2tF6OoobJMKVHP51nvk2w2bjifNLtTOtQFtKYx25AdinSQgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(316002)(110136005)(91956017)(76116006)(53546011)(31686004)(8936002)(54906003)(41300700001)(4326008)(8676002)(64756008)(6506007)(66476007)(66556008)(6512007)(66946007)(71200400001)(66446008)(6486002)(2906002)(186003)(5660300002)(478600001)(4744005)(2616005)(86362001)(36756003)(31696002)(38070700005)(83380400001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JxTVJIMmxkeisyaUFsUGR6Zm42UWNDeU8xVFJqdUlSZnZSZTdjWHF6LzYv?=
 =?utf-8?B?cSs0UWl1c2prdTJDQnhUUmpJMW1sVUNic3hCcHdFRHVNZTJSazRodG02U2F5?=
 =?utf-8?B?RjVrK1lQVGgrRGlSNTNFWFZYRmQyQ1VLTlpNZ3B6bjM3YTQ3N3BvWm9TVEJk?=
 =?utf-8?B?RFlhSk5nQXVhVi83NTRtRHVUand2ZUNaWnlmaUxQc3NCVHpyK0QvRmVFRUtk?=
 =?utf-8?B?WVg5RmJNcStLSlk0WnBSdUwwdWJVM2NjUEpON0FoeHMvbTA4T2xjejlOWjVI?=
 =?utf-8?B?SEEybTNMSlRVUUgxOFhTTlkwUmRHT2hMbmtVM1VEWWREWnlYeVIvVnZVcXBI?=
 =?utf-8?B?YUw0OUEwRUIxR29nQjVGNjlwNTBpNkZ0SS9QUUIxOTRndU0zUlNucktKaW9h?=
 =?utf-8?B?T1pPdGkrWmp2YWNmL0tqais2MVUwYzdxSG1ndkcvZXF3VnEra3M4U09VMTQx?=
 =?utf-8?B?NjUzN3NYdTE0S3doczJlUzB1dlEvL2ROL0FJVnpsV3dQRU8yc3ZWS2NqSWVP?=
 =?utf-8?B?c3FocXRDZXNMNGd1U2xrOEsyQjlDSnA5TjBVTUgxems1TGVBUFkyeVlXRHFL?=
 =?utf-8?B?YVhPREMwejkva01SRk5qUlBBb0JOQVh0RG1IeUtWcmN4TEpqMmROcGI1ZTcw?=
 =?utf-8?B?MWdlcnpOZklrSHMvWFFRWGM5djdBclE2eDR2alltWGthL3dqV1JBNVRWTUNY?=
 =?utf-8?B?ekFEUjREU3BIbWo5VDI1VkNSdEJwYnJFL0lGRUxDNGZobzFYS0FWSHZwRndk?=
 =?utf-8?B?ZVlZSlkydndOc2Z1cE81elNQRWpOblNUM2N3bUtDU2hlNlpJYkw1Nk5OL1ZX?=
 =?utf-8?B?RG1VbGYxejZ1ODJUMDVSQXBlUERZMlZuZUNDSGo1T2d1RWY0aXdsRlU0MzlM?=
 =?utf-8?B?OXV6R3FwU1lTSTNsOG9jWmMxQ3ZIU2dZMjhZMzBvSUxzNUJQSjhRSTV6ZW9Q?=
 =?utf-8?B?M0poWjQ4SWRkUjR0NDRldlR6YmdFbjdlM3RZNW5NR1pWcGd5Vnd4WkxTWVNv?=
 =?utf-8?B?SlJndVhQTzlSZ01YQ2VQSnRtWWltb2FpVDlGdHNJVzkyUkEwSEpueDVnTVAx?=
 =?utf-8?B?aDZlRXBRanpBZ3VaR3BuOHNYSnF4b3o5WFZZREVIQ0Erb0JHSEM5d3gxWW5l?=
 =?utf-8?B?bldRUkk0WnlJRmFDNEwxRkV6enBqWFYxb0RwYUR2OEdqTjR1MzNRdzlXYjhG?=
 =?utf-8?B?SDI2RkE0SnREQnZTVEh3ZGxNUm85SlF6NVVhQ05aNGh3K2RvdVErQkFjMTVo?=
 =?utf-8?B?cEQ0OUVIVWxpbkowakN5REtVdHBXWGhJWjhCK0VraGRVV0k5ME1Zd0Qrck9z?=
 =?utf-8?B?eHZYQjcrWTFIbE5MbERRcm4zcklvaVRpc1VxQUhJZlczUlRwQ3YxMzY4TDBk?=
 =?utf-8?B?aG05anZXUDh0M2NLRXdiUzNVc0NZVW1WV3hiL2pJZDVKNkdKRHlDMkx2UkNG?=
 =?utf-8?B?c0p2MlJsenB1SU1PVEpvVjkxWHlITlVldXZON2ErL05ocGVuakNUam9RVXpM?=
 =?utf-8?B?MHRmRWkyTnVjekJibXpDbEZWcXdMOUN2TGZmOFZ0aXZjRnlndE8rSlRyeE55?=
 =?utf-8?B?K3N2clNVT3BENkV1STZuZGdBR0w3K2kxa2JkMHB6TVQxbU1rdjBsMkk0STNs?=
 =?utf-8?B?NzQrdGhUOW5mMml1Qnc4U3Q1YW5mckhWK0dhL0d5SDRkbWUwK21yRUJtY05l?=
 =?utf-8?B?bGFVM1lGTVd0SkYvb3AzUXlDZjF5bFM0cFNhZTMrMkdlQm02UFdMM2Z6V2VR?=
 =?utf-8?B?cDB1S3cvRnVmemNteXJTZzJXV1dYc2pXUTI1VGNaQ2dJME0yVFNldGdwdU9m?=
 =?utf-8?B?RHVWMlBjVHJraDZvZEg3QkZkRTJwNFJ6Uzc2YmZQWW5rZ1lQdTNFZEpBdmlL?=
 =?utf-8?B?eU0rSEY4bk40Ymt3TzVQQ0lVZ0NoU2t1Q3VYYklrblpGZ25UbGlKaFdaako0?=
 =?utf-8?B?UittTjh6V0dJRlJ2cTBkSkg1R0xjN0RyWittNEIxR3BlbHVrR3NNQ1Bnck5N?=
 =?utf-8?B?V3RvOTBZZFIyUjc5RTJNcVV2NlNKaG9MNlBtWWo2VDVXN2MxN0V5bjduYTB1?=
 =?utf-8?B?NFpXTldEZkdiUEpuY0Z4Qzh0RWxVWG5xZEtuRWV5V1VtZ1FWQ0NGVzFLTWRz?=
 =?utf-8?B?d1c3YktNaGNuVU8zL0xnNGZnWTY0Y1BhSHF6UDNxODdFZ3BHWGlhMHJQZW9v?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2321E3CB4EA79A4DB646EC91292EE88A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90acc62-d8e6-47f0-9ed7-08dabc9638f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:51:01.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Ukrlwpu0BHBl6kGsCRjBhzxqzYX/46eMeBNacWUoin0l5kBYdlryPnpjNLNRSj51/VGONXfQZa2uTszN5RVzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEZyb206IENoYW8g
TGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4NCj4gDQo+IERyaXZlcnMgdGhhdCBoYXZlIHNoYXJl
ZCB0YWdzZXRzIG1heSBuZWVkIHRvIHF1aWVzY2UgcG90ZW50aWFsbHkgYSBsb3QNCj4gb2YgcmVx
dWVzdCBxdWV1ZXMgdGhhdCBhbGwgc2hhcmUgYSBzaW5nbGUgdGFnc2V0IChlLmcuIG52bWUpLiBB
ZGQgYW4NCj4gaW50ZXJmYWNlIHRvIHF1aWVzY2UgYWxsIHRoZSBxdWV1ZXMgb24gYSBnaXZlbiB0
YWdzZXQuIFRoaXMgaW50ZXJmYWNlIGlzDQo+IHVzZWZ1bCBiZWNhdXNlIGl0IGNhbiBzcGVlZHVw
IHRoZSBxdWllc2NlIGJ5IGRvaW5nIGl0IGluIHBhcmFsbGVsLg0KPiANCj4gQmVjYXVzZSBzb21l
IHF1ZXVlcyBzaG91bGQgbm90IG5lZWQgdG8gYmUgcXVpZXNjZWQgKGUuZy4gdGhlIG52bWUNCj4g
Y29ubmVjdF9xKSB3aGVuIHF1aWVzY2luZyB0aGUgdGFnc2V0LCBpbnRyb2R1Y2UgYQ0KPiBRVUVV
RV9GTEFHX1NLSVBfVEFHU0VUX1FVSUVTQ0UgZmxhZyB0byBhbGxvdyB0aGlzIG5ldyBpbnRlcmZh
Y2UgdG8NCj4gc2tpIHF1aWVzY2luZyBhIHBhcnRpY3VsYXIgcXVldWUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+DQo+IFtoY2g6IHNpbXBsaWZ5
IGZvciB0aGUgcGVyLXRhZ19zZXQgc3JjdV9zdHJ1Y3RdDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogS2VpdGggQnVzY2ggPGti
dXNjaEBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmlt
YmVyZy5tZT4NCj4gUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPg0K
PiBSZXZpZXdlZC1ieTogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPg0KPiBSZXZpZXdl
ZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
