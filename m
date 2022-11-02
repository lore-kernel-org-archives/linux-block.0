Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF26C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKBBYR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:24:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC192183
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avZcgRQlx62+58iLtX8xSpgjwcwRfajPsD9ABUlJejL0soFaE6e97hRGDYrzhq/Bw6LL7VKpS/bdwrGYBVh7GoRnFa00ShfCoBZI4mq5lzp8KkN5GNHmtp4iqX1vM9eSjb93+XKnQLZXS8mpXmUlzB9rXvTFHxILIlHCKdtDIlLe4Vylj/wOJIqvsxwtQCCvRt6f7vH+KXCnHY/2tFt6mSQBLFQYeVhcBPlX8cqQqcBGrngqfnnAJAcqbOSH2OVuQtvTNthNUzERAhiX6h6ZJuc4xwXvKBLb501BIx92G2vDqmuyoAvYdpbDWp1QYfzGGd+VH6JNypCZvdKucvRuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL1x6TPYd+xi6aRLJZzpO2Jbksqm3gW3YLnPLWTwNt0=;
 b=CVWR1GGjQ6PrkaJFc35ohe0NZA280tLr7oEUN5Aef2SKmZmeAjA6u7h8zomgunWZHkcxlk2ztUSEGPR1gwZKn+pRn/VcK5yA4+o9rvIIHe2QZyxdMdcFChoyyNXTu5jL5iftj+ejxEK0xFxyOAEtY6GkkYVGS7d54BSWmBzzUkdStlplMO2iPsRApQKdlvM38xRQDkcx27+kk2HE4BZwru02HSF+3TGCTox3b0yHXIcvp4UOx5v0v8M14FVlD81jLWLqMZQFCjHoCiHhKWBJh6ZGD934EldhfhpFZndKnyc04zykMgFh6F4Sz+Ej/NpcoQ16wVk2352niQQZpVN77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL1x6TPYd+xi6aRLJZzpO2Jbksqm3gW3YLnPLWTwNt0=;
 b=PHqHt/n1Zy8ZqAGywgQc2Vt9JUz3kRP07AFICD0d5Wdy3ICJwJi7tVVl91VLhctYKGtUrF3aY0VZq3UYULQQTsOeAWOj8D8SZcuN2JjVUNGKzf8p9xt0w126LgAHrqzAzxHSnxwxwYn+ouUOu/f++m18/l+zyFAe1UvPMsvzfSpLI+SNpSZn5f9R7ZzldOqvjphgitQV4sgaHlKsNUzsv1O5ld8TG0Lte7oQcIaS4MeP5vAd3e4ajfTc6+U+Jy2DB6ZNZw7OfK7dlcy3lFIYTCaX0XQ+I0PkudfTRxtuC/A1X9u8silIvekd3ynCG4G3PENjDaYXvD/+CASyULbuXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5264.namprd12.prod.outlook.com (2603:10b6:5:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:24:10 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:24:10 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 06/14] nvme: don't unquiesce the admin queue in
 nvme_kill_queues
Thread-Topic: [PATCH 06/14] nvme: don't unquiesce the admin queue in
 nvme_kill_queues
Thread-Index: AQHY7gLt7MR/uFNCSUGm2rfNhcsLPK4q15aA
Date:   Wed, 2 Nov 2022 01:24:10 +0000
Message-ID: <b9226179-261c-b6f3-4b3c-91d2fbe02013@nvidia.com>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-7-hch@lst.de>
In-Reply-To: <20221101150050.3510-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: a8f228ab-e9ae-4b6c-8632-08dabc70f1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrTT8Gz3U6KVtzb8YX2g1NmUdMzoXY+iNumOpHogL4jkTmoy9eniU8jWuxglUeFnRLeoDjRqSiIBslMswTNClC011CLBCFQRM9x2659lmNz2oSxxs/DVl7gZTxFluGBbLZmv3wZ2+7AHjqI/rRhaG9XccBHUXK5vqmClu2apNfbLHDdB2VKgVXRUHb0tPU2SbkfNWg3GfRf08UBOjxQTJHVs6YwLtBoqIvsU2QadbNEhRoOiCP8g6vCPhnGnQTnBhGgRQw2LhQxviwTUtneITDTDJmU/yCFiiWxaAUh/4zbtMXfbUP7/2pYy91uwzqRB94pC+7qoN4Lp14WlCfj1JTuyjHr4/ORvJUQrN834f1yE/psWqIzQ19LCQADM3iGDUkEDuyMlK1KIWvF3xUBir9c/5o7IgUKSkrRB+WONIvDVj8NOcOSRBeJT7Hp+CRv8zqO4t5Jgcx/7K1I5cglv9WdLf8lo7MUQy/MOi5mk5gsHJR+Cv0n+V/mw+cF16ZqI+xy2FnGAK/Z4zmFA5ByYga0gmAyOdCWw+QGT4M9QDDgCSHyJrvgW8OkELGa4Tl/gP5czHjsOkTRUHbLwNEB64rmTEkyR0wsraKcXUhlq8vC324r4irryU4JuJOX/3TBlHzFLo5j10SkCwxyKug0ZYpcbZvbrGtxBWJ1Ss37jJq/fOCWLJ3f7viAaOfM8mc+CFo9xhkHuxM4GPOrlyZ1qKV+z4YhgKSVMJGxLSdgvyzBaYiYysrlzUjiWu6TdSMrsXsZhKimY5UY5Xlm+K19cqdQbjIzvDWqANZ3oP5YJ18WVTyqmtI6MMmhoVxpChrfFPxi/G6T811wEmOqqSuFVTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(76116006)(66946007)(91956017)(110136005)(316002)(36756003)(54906003)(66446008)(66556008)(2906002)(186003)(122000001)(83380400001)(6512007)(41300700001)(8936002)(53546011)(31696002)(64756008)(6506007)(4326008)(38100700002)(86362001)(8676002)(2616005)(5660300002)(66476007)(38070700005)(6486002)(31686004)(478600001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TitabmptbDhwMTZlQndXRjVrZXVFbjRLUnpHUzJYVk1leUZ4TS9ZRDNHK2xT?=
 =?utf-8?B?ZExUNVZLRUZIOGROeHhzV2I2NmNwRDJYN1VNcERFVndrRUd0U2tNeTNyb3Jm?=
 =?utf-8?B?RUlIT1JZZTQ2N00rRzdHQWMyVDAzMTMvNDRMR1o3WWhaMmNIVnh1UVZJTXEw?=
 =?utf-8?B?Sy85bFpQRGZ1SSsyblZBNG5QVEZ4Mjl5cUlMTzRBS0k5UitZaUU4d1lUUy9Q?=
 =?utf-8?B?VUdnOFQ5OXRnZ0UySGR3c0VqSjFseGpLTi84dVJrb2ovbXZDQ1ZCNFhLSWhC?=
 =?utf-8?B?Q0J2Q0tsMEM0eVdGKzludzlnQXpUK1F2ZjRkT3hwc0lMY1VtZDB5WDdxNm9j?=
 =?utf-8?B?cHJVVW5yV0dzZ1l6Nzl1NldSOTJCVWVwUjhpc3lGWWhWOG9LUDkyZTFHUkNQ?=
 =?utf-8?B?NXVXanpJUDVYSFFhMk0yZHZzcjU5UGtOS0ZPVE93eS9QWXBkU056TzROa1NF?=
 =?utf-8?B?ZHJYVHlENlEweU1LZUt0SDNRSnNsbitLOStyazlJYWtPL2dmaUZxb2lUdTd6?=
 =?utf-8?B?bXpNVXlNNDN0Y3k1N2hucWdoTmQxSjVEdUJBRUVEc1VXY2ErZ3JnUys0T01X?=
 =?utf-8?B?Ti8yRlNldlkvWGVXam9EYzU0QXc1QmoraHdsUTB4TDNkV1NWS3RCd2pjWDhS?=
 =?utf-8?B?anFiVWx4L2VLUENtRkdBTlBPb1M5b3pWdXlWNHBaamtpWTBlZWVWZFFpdTRB?=
 =?utf-8?B?N0pZcFgrRG5FRm03NGhkbWl6QzlwZXpNUXZIakUzZ0hhVkVhSFQrZ2JFZHpp?=
 =?utf-8?B?L0R6UTZmSGdKaDRKU201Mms2QkM2Q2FSUFY3YXpuWmIrOENyb29hRjdNR2NM?=
 =?utf-8?B?dFVjZS9aQ29uTWFrekQzc3VpenRMUTlKNUtVZUVQMG1DWTh6MmdFaDU0MXhQ?=
 =?utf-8?B?MWQzc0h0RGtUbkhaYm5uNmN1VHBQZDI0SUJlSTZrM2pSWGM2TkdxTmk4UVFr?=
 =?utf-8?B?VjlJNW1nUXNIU1lWeXN0TDhHMmM2K1pZTVJQNkFOams4bWdWdVZXWWFZRWVM?=
 =?utf-8?B?SlhvUG0yekpmRkFYUklZc0R1Zit1WFZsc0NuRHFZcUpESG5ZbWVLVE5sYyta?=
 =?utf-8?B?WlJLVlNOSjBGZ00vcEdyRDFPM3NENWRPdE1QT21JK2djVS8wSTl4VzNveVV4?=
 =?utf-8?B?V2xlaEpzWXlBZlQ0M2R3Um9ZMU1pc0RBbXRBeDkwS2VlRmJiMDQrbjZSYk5r?=
 =?utf-8?B?Sk1ITVp3Q1UvblNLN2FMd2x5ZGo1TXdFY1g1aHpITWJjSTFGdU5QWGlMOWs2?=
 =?utf-8?B?QzhVU1VLbVdQWCt5T01IU0VWR2xpeWgvbllXOWNVcWVsMkVLazMyV1piVTNn?=
 =?utf-8?B?R1cyd1ErNk0yS3JiR2hmem5rSjRyUk9FZzdaZU1qVTBSWVlMUmJJcEhVaWgr?=
 =?utf-8?B?dEpTbGUrS212Um1PME5LRStqS2dZT2dQOE5kZ2hwaFAvTnl1ZDBIZmlnU2ZE?=
 =?utf-8?B?Vmh0cE9yR09PN3pRUHdUTTBYNGxaUGhHUW5sd3ZFcWRKSXRSSWhRR3RWSzlI?=
 =?utf-8?B?OFJEV0xzMkIvUzJwQ0d3c2MrUythdTlFUTRYY3NBeDQzUVh4ekxQZEJSY0JI?=
 =?utf-8?B?ODdtc2dNcGFNbnRXQ25wcFM4MzhkcmV0Z1BPdXRNWU4zZ1hTdnRJVlhEU09P?=
 =?utf-8?B?S3BuZWF5WUUrdzZmcS8zbHg2WTErTXNQbW54UVJMTUt0YjRPLzU0SlM2Q1N4?=
 =?utf-8?B?amNKOFJocFNmSzVJaGVEb3hJeWcyQjZtMkg4ZVNKT0t4ZE5Sd05NdHVGUnYv?=
 =?utf-8?B?RjVIeFB2ZmgwQmpCM3BVU0JJYnNXaWhsaHdvRTROOStWRmtab0xzcHZqM2hQ?=
 =?utf-8?B?RUIySHM0MGNJOWZMMWRMU254UVVsa3kvNm9XVURaNE1hOUJRQStxUDNwMFUz?=
 =?utf-8?B?dmpNWE4yVjFTVC90bmJSQU9mQ2VHOHJZSHlKaVJqWmF4NXVZLzNsdXNSVjJ2?=
 =?utf-8?B?aitVY2d5OFEvMXZjR1AybTZvazI5L1FkcjQxWTFNZ0RpQTRDYkdrYkVmM3hS?=
 =?utf-8?B?d1ZDdEpMTW5HOWhiL2xWTVpFMjdsMkhmTzhHWUw4SnJGOXR6YUVUemZkTERo?=
 =?utf-8?B?MVAxNlMrNVU2cGpHeTBJQ3hiWUVaMS8vWFNiblNPZWIzdDhrUU5iVkQ3ZGJr?=
 =?utf-8?B?Z2U2aGdaUmUyd3VLTHZPTkJRT1VySEhoT0M0Um13KzhNWE5HUWkvT0x4QkJs?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57B7B69AE45B04428CD07302F22580A6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f228ab-e9ae-4b6c-8632-08dabc70f1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:24:10.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //QEVTSgsast8mRys9pP4ZwkeeufqGZ2WwWyDW8L9D6SgMJB06kyq5AAfuPF9+wEMTI5jvy5owKwj7B4rw5BiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvMS8yMiAwODowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE5vbmUgb2YgdGhl
IGNhbGxlcnMgb2YgbnZtZV9raWxsX3F1ZXVlcyBuZWVkcyBpdCB0byB1bnF1aWVzY2UgdGhlDQo+
IGFkbWluIHF1ZXVlcywgYXMgYWxsIG9mIHRoZW0gYWxyZWFkeSBkbyBpdCB0aGVtc2VsdmVzOg0K
PiANCj4gICAxKSBudm1lX3Jlc2V0X3dvcmsgZXhwbGljaXQgY2FsbCBudm1lX3N0YXJ0X2FkbWlu
X3F1ZXVlIHRvd2FyZCB0aGUNCj4gICAgICBiZWdpbm5pbmcgb2YgdGhlIGZ1bmN0aW9uLiAgVGhl
IGV4dHJhIGNhbGwgdG8gbnZtZV9zdGFydF9hZG1pbl9xdWV1ZQ0KPiAgICAgIGluIG52bWVfcmVz
ZXRfd29yayB0aGlzIHdvbid0IGRvIGFueXRoaW5nIGFzDQo+ICAgICAgTlZNRV9DVFJMX0FETUlO
X1FfU1RPUFBFRCB3aWxsIGFscmVhZHkgYmUgY2xlYXJlZC4NCj4gICAyKSBudm1lX3JlbW92ZSBj
YWxscyBudm1lX2Rldl9kaXNhYmxlIHdpdGggc2h1dGRvd24gZmxhZyBzZXQgdG8gdHJ1ZSBhdA0K
PiAgICAgIHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiB0aGUgZnVuY3Rpb24gaWYgdGhlIFBDSWUgZGV2
aWNlIHdhcyBub3QgcHJlc2VudCwNCj4gICAgICB3aGljaCBpcyB0aGUgcHJlY29uZGl0aW9uIGZv
ciB0aGUgY2FsbCB0byBudm1lX2tpbGxfcXVldWVzLg0KPiAgICAgIG52bWVfZGV2X2Rpc2FibGUg
YWxyZWFkeSBjYWxscyBudm1lX3N0YXJ0X2FkbWluX3F1ZXVlIHRvd2FyZCB0aGUNCj4gICAgICBl
bmQgb2YgdGhlIGZ1bmN0aW9uIHdoZW4gdGhlIHNodXRkb3duIGZsYWcgaXMgc2V0IHRvIHRydWUs
IHNvIHRoZQ0KPiAgICAgIGFkbWluIHF1ZXVlIGlzIGFscmVhZHkgZW5hYmxlZCBhdCB0aGlzIHBv
aW50Lg0KPiAgIDMpIG52bWVfcmVtb3ZlX2RlYWRfY3RybCBzY2hlZHVsZXMgYSB3b3JrcXVldWUg
dG8gdW5iaW5kIHRoZSBkcml2ZXIsDQo+ICAgICAgd2hpY2ggd2lsbCBlbmQgdXAgaW4gbnZtZV9y
ZW1vdmUsIHdoaWNoIGNhbGxzIG52bWVfZGV2X2Rpc2FibGUgd2l0aA0KPiAgICAgIHRoZSBzaHV0
ZG93biBmbGFnLiAgVGhpcyBjYXNlIHdpbGwgY2FsbCBudm1lX3N0YXJ0X2FkbWluX3F1ZXVlIGEg
Yml0DQo+ICAgICAgbGF0ZXIgdGhhbiBiZWZvcmUuDQo+ICAgNCkgYXBwbGVfbnZtZV9yZW1vdmUg
dXNlcyB0aGUgc2FtZSBzZXF1ZW5jZSBhcyBudm1lX3JlbW92ZV9kZWFkX2N0cmwNCj4gICAgICBh
Ym92ZS4NCj4gICA1KSBudm1lX3JlbW92ZV9uYW1lc3BhY2VzIG9ubHkgY2FsbHMgbnZtZV9raWxs
X3F1ZXVlcyB3aGVuIHRoZQ0KPiAgICAgIGNvbnRyb2xsZXIgaXMgaW4gdGhlIERFQUQgc3RhdGUu
ICBUaGF0IGNhbiBvbmx5IGhhcHBlbiBpbiB0aGUgUENJZQ0KPiAgICAgIGRyaXZlciwgYW5kIG9u
bHkgZnJvbSBudm1lX3JlbW92ZS4gU2VlIGl0ZW0gMikgYWJvdmUgZm9yIHRoZQ0KPiAgICAgIGNv
bmRpdGlvbnMgdGhlcmUuDQo+IA0KPiBTbyBpdCBpcyBzYWZlIHRvIGp1c3QgcmVtb3ZlIHRoZSBj
YWxsIHRvIG52bWVfc3RhcnRfYWRtaW5fcXVldWUgaW4NCj4gbnZtZV9raWxsX3F1ZXVlcyB3aXRo
b3V0IHJlcGxhY2VtZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPg0KPiAtLS0NCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA0IC0tLS0NCg0KDQpU
aGFua3MgYSBsb3QgZm9yIGRldGFpbGVkIGV4cGxhbmF0aW9uLi4NCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
