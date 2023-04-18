Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2441C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 19:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjDRTku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDRTkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 15:40:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A676659B
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 12:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj8h1EDILOGsr7rPjVqD6q4gOZyFcMw3JfctQ7lPsc6ymV0vSrlz9U0JJGnJaGvKRadv8YsySnVUhKF+7xnGz8CYv5kJ2/dRiOEE42ElSLrYQiU6CAguHG7uh9l9iMSm9vmYscAr6777nqn2oEwje7blQEv5wig4lvDMfb0EbrDCgh/e/fsKD7Eu4M/mAmCb7+wDJm0IWnguVwLapQPXs5X+KSxuIbWmu/Qqo+8/W4PpWefKOtMhredgFmkA2ESf4XxB5i+IDSPLVsVTbNCHQSZf9F2SPDUPucJcQ3mFeNLdjvhngs8cCoT12v6W1bnmQPmdA92dSQ582X2DvBbXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OKi+f7Vr254ez70vQYKhLbvCNUQxZc3+p+VhleVI/M=;
 b=cG1jyS0XQVQD4EOcZL20JJCqpq4f1I/0j53q1n6+72YNkEv1pZfkRKE4yKXMvVKA2+ZQqEyjRzuINds0YxOOvhQu5F1dB9QD1RfiD10kfCMz5H1xNjBhMZZUJ3feM5sDjIYqIiXBcHE6ATpUixxLHiDfoknMNK7bYxu3EN5c4n/zio73EFiB/CDe4Mlz9eiIHseERcv4mGmBNhdWLAilMKE2adLBF4BTYRPuu8nw8dtsFkSzqXT2BHDlBNV5hO1K6yMAVjRvABlEybJtjCcn76bBCTJcOUk4RW3idW5HeC6tAThkCLyqTIRiE3jZB3EppETxc8fE1n0O+TDcK2TcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OKi+f7Vr254ez70vQYKhLbvCNUQxZc3+p+VhleVI/M=;
 b=fJcSNi87V/eqTj0ygAyJ0SfhLHCPhXzUfTJwRhsjESoGYCbTI+2qrz66YUoUuhRsf5fbX9GQUZy49xm/+Dp3qgyh7Ic0UCptEYMD4LqO8Wbl0miN6Pr1TfRbyqZL50Z+v9vXss/tyAVIn7HCvWUZVeKumg8gHHr7sSI5UsClO2GWD1TonjCkrcmeQq1h5GnMGl76wY+1MoAP9iEHmrtraNyNyrQpZgrqDZbz0LjIhQXHHzmmCOGRDjVTvzqczCC64Tt48xoHc5e8Uw833Wkn5kYX78dfCkgQtigmm1r2tMvFFpwG4rYQbfxGfu4aaem/45gEj4xVIj3Bj7wZ3xi74g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 19:40:44 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 19:40:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Topic: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Thread-Index: AQHZbRuBGnDoA0PLrUmq3zDXdDqS5K8w+yaAgACF9oA=
Date:   Tue, 18 Apr 2023 19:40:44 +0000
Message-ID: <d34a63e7-d1fc-ea25-c203-47d987ce2f3c@nvidia.com>
References: <20230412084730.51694-1-kch@nvidia.com>
 <20230412084730.51694-2-kch@nvidia.com>
 <CGME20230418114947eucas1p2350d60e2643c11bd01964805ef9baded@eucas1p2.samsung.com>
 <20230418114115.zhcabb5lelbeyyeu@blixen>
In-Reply-To: <20230418114115.zhcabb5lelbeyyeu@blixen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6574:EE_
x-ms-office365-filtering-correlation-id: c5c670b1-f1d9-4676-3c4f-08db4044cce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3R8mHEwjQuk5Hwj7aO+eE3rIt6IlRG03w/WhKT2zSwEDn1sJ3fzLTp86+CAbQDDtL/bcEAZCZ22PoIaA2uSZJ4REuh/yEn9/cELtKbs3dzZwKisNux3LGIo43nrJjzvVlbkaMrv3zP/NJ4MapEZ86Ufks9g/hMrJsngtiRB5cWISuWCH2L6Ijt3aQ0FLL6o1WlAGJd5hQwKfJwjk/l2bHZUpyP8MUPMEixYCsdG0W/XHORxro1PZqY962vWIeFDgQO117SaE4DWDyBO/wzSaYFwBUTlnGEjZw1xeRNyTS8ooP4Ncb8YIqY06H5RURaSLwgd2+gnP19qG2rILDPnnkG3ZJp5K3y5RqHtHcni5VRNMpcuOhobiwVFDo8vdJ6kmclunC3HFe49Fbv7xYwGdGFDMYXigK/oY5ifqxR9078hbeCEH8jvoHBiF4cPxhJnsGzIwnSZ+DGldLDtbPi2Z3DmsoOgACdXyZlHWYSpDijv/7Cfb4eizkOYZzL1tF8rqFrjAbKczYqSMrUXg0EldRQO3tQYddYGn2YeJLP60a5DTEsSFel/g2mf+U0IsjoSb8cueF1eqCNlYgZREIWVMa6HrsWR/xwKwdQzcwvAtTKi+ZjpzHS3W1JJA5WhIru3m6HQ7q/Todgn9RcnTTCVj6W4Y0Y9HzIoz7BXSOVVU+lTXoMraMOhh4yuyfTuqKX6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(186003)(6512007)(53546011)(41300700001)(6506007)(110136005)(54906003)(91956017)(86362001)(83380400001)(2616005)(4326008)(31696002)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(2906002)(8676002)(8936002)(6486002)(122000001)(31686004)(36756003)(38100700002)(38070700005)(5660300002)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhPVE52MkJ4SmQ0RkEzbkF0eUl2bHlDM1U0QjM3K1JiYkwzaEtZRHJuWlYw?=
 =?utf-8?B?YzJ3Z0x1SjdIa29qNFNhTWlmcnA4MmZ0VDI2bUZHdUpnaEFRMGpBeTJFS1RH?=
 =?utf-8?B?bWhDWTJMa2duanRUS3pEOW1EN05zN3E4d1E3WmQ4NnRQcmxQaVJnRkVjK3hV?=
 =?utf-8?B?aW0vTnhJaEFGOFlCeFlCSFhleC84YjBJMjZXc0ZST01iNk1ycUFsODBTS0ht?=
 =?utf-8?B?VUZKdjZjVFB5RTdqZW9LSnJsY3VLRnJObGJIQi9KTkVkbTlxWEpZbmM2SXR4?=
 =?utf-8?B?bFdwTDg3dm5rclZzR3N4Zm1hQzFvYzhyZjFoTW5rOGJyQXEvQlNxK3A3VXRI?=
 =?utf-8?B?Q0twSW5GVmhrTy9KbHprcU5VZkxsYkNWTVg0UkUwSmR4RGR6TzdmSU84bTla?=
 =?utf-8?B?MTRvWVUrRHE2eTM3R2R5VU9oNlM0VEN0ZktXd0RjeGNjSi9iTlZrNE1iQkJk?=
 =?utf-8?B?WldHdzdCNXR6M0VXeTkxZmNFVzJ3ejlSZEwydUFIa01OK0VkVnBJSk1PVGpi?=
 =?utf-8?B?WWExZ29GbVU1Y3k1ekRyNVNRZG1HSld0WWEwUnpBVFZYNnJjOXJ5VE1OYVM3?=
 =?utf-8?B?UDZiREhTaFArYUFDZUJwYUcwY3BqaVh6TFVqSEtxQlZITFpOVEdjaTlmZGxq?=
 =?utf-8?B?UUxoR0wwT2d6Snc3YXVTOEI0dVI3d2tITjBQVlVjdjBYNUhCWGdsbjZyVHlZ?=
 =?utf-8?B?S3hIQ2orYWw4anMxSzJFRVErVXdzYWhnR2hnY3FYdW1nbThtSVQwT203bzRY?=
 =?utf-8?B?M0FmM2tmS2x3QUNFSThNcnR6aVlSVnZtY1hvVW1PVm9QanpoOTFhRnVROXhG?=
 =?utf-8?B?RFdQV1JXWFc2Y3pLNUdHQXhEOXRxbUhqRkJ6MzQ5WXdHSXFUQmZKUElhL3dz?=
 =?utf-8?B?V2pTd3FZV29sK040dDZQVUdNTVhHY2lIUXNKeUJZRXlpV2Q5RGl1amdaWGVk?=
 =?utf-8?B?a0trZ3ZyM0Z6SG1hT3JEajFMQ1B1RjY0TWFyMlhYRzZpWTlZelRjOWJZRmY5?=
 =?utf-8?B?QTliL2FNY1I3S2w1UjhoSkh0VUxCZ0R5L21nSUQxeC84ZHFvb2VKMlNKY2xj?=
 =?utf-8?B?Tlhta01vOURaZFlrTDJ0bEl5TkQzMHpsZ0hPWTFrUW1OdjFSeXVQZlZjNXhV?=
 =?utf-8?B?cW5XWUNsT3hQaUpCb1RTbFRid3F1ZmhHWlNpczF6bk5wcGJSUVNMUHR4VVpS?=
 =?utf-8?B?dzdDUGpkbHpjS1hoSnhFcVFySG5EWjcveXVZNGtTVE56MGNrY01iK1lEREdl?=
 =?utf-8?B?MHN5dzdJbVo2SzZNWjFST2FmaVZLRlZMc3dhTjFHYUQxTlBmWUtqcE40c2NR?=
 =?utf-8?B?bzRJWUpCUVhCaGFzcWprSjA4WGp4NFNqQlhocVd1N2UzNVBsYW9hazhOVGd4?=
 =?utf-8?B?cGFTWE1GaVVjbUwwOXNJK29xOXhzZ1g4eEVJbk5rckk3cE1DK3BpeEhFV2NG?=
 =?utf-8?B?MXlUZlpVTmlmNVM2Z0gxTVhtRjVyYVREVEo2ci9VZUsvSUdrQ1N4VWViWHlo?=
 =?utf-8?B?NU1xeXp3cHhDLzVOeGsrY1ozUTFwU1Z3UHZmUkwrNlU0MkFwMHhWK3RiOHpQ?=
 =?utf-8?B?U2JJbWpZbXEvVHZ5ZnVPVnpGNnp2a0RUUjkxY05xLzFHZm9pUU5kbXZrVGc1?=
 =?utf-8?B?eUczak9lMCs2UkpoaWlCSFBZZ3Q0R3FYMWRYWHprZUxZamlrUVJoMVpMdkVQ?=
 =?utf-8?B?VVZkcW1ZSjBOK2dtT0JFN2I2YVQ2cXlIWHpOV3V6b2g1M1BXUk9sT2UyYnRy?=
 =?utf-8?B?Zmt6NEFqUXJ6RUJLMFZSNzVyS3NjQko0U0JjMG1oaVo1bkRlKzY3YXFnQk8z?=
 =?utf-8?B?VjV1U3Bld2Fqa29ranE1VFFOeVE0ZzVFRjA0Y28xS3laWURyOFRraVRVZjUv?=
 =?utf-8?B?MXhCeVlmMG9vWEd4RHMxR2g5djl0cWhWL1o5QXhaUTNiY0g1bkE1UHdzdnNP?=
 =?utf-8?B?L1NJUHkrK2xQeUxyMTdiVEU5MmRUdFNBK1VyL09XNFl4OHhMeWdINCt5ck42?=
 =?utf-8?B?OGoybGZVT2ViMmZlWkdlb2c1bmllUjRpK0RsRXovY25jTlJCeDhPdy90Z0tk?=
 =?utf-8?B?NnBMRnIrbVh5YXBMampIYlJ3OVluemRZYWx0Q1VUOWg2MUkwZVczcDRJSENz?=
 =?utf-8?B?L1pKUmtZZi8vYWNsclAyMWw1Q0NZcTM0RVJqaVNLc0hhbmlUeTlVaVdMUWlz?=
 =?utf-8?Q?LFnhU+N5K+LDVqFok4IftIWYVLPxkIJsmGTNdD0V8t6m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <676C1D8455464242ABFD19E89A3FF096@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c670b1-f1d9-4676-3c4f-08db4044cce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 19:40:44.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WPgNULeWarzYqIpzG3G5dOUttF+SFc/Rk3Ds06sCg+qhlhzf1v/1VdUqbVuP80XyKRTmn+rZmOfXnwCpy7ESg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gNC8xOC8yMyAwNDo0MSwgUGFua2FqIFJhZ2hhdiB3cm90ZToNCj4+ICtzdGF0aWMgYm9vbCBn
X25vd2FpdCA9IHRydWU7DQo+PiArbW9kdWxlX3BhcmFtX25hbWVkKG5vd2FpdCwgZ19ub3dhaXQs
IGJvb2wsIDA0NDQpOw0KPj4gK01PRFVMRV9QQVJNX0RFU0ModmlydF9ib3VuZGFyeSwgIlNldCBR
VUVVRV9GTEFHX05PV0FJVCBpcnJlc3BlY3RpdmUgb2YgcXVldWUgbW9kZS4gRGVmYXVsdDogVHJ1
ZSIpOw0KPiBDb3B5IHBhc3RlIGVycm9yLiBNT0RVTEVfUEFSTV9ERVNDKG5vd2FpdCwuLi4NCg0K
Zml4ZWQuLg0KDQo+PiArDQo+PiAgIHN0YXRpYyBib29sIGdfdmlydF9ib3VuZGFyeSA9IGZhbHNl
Ow0KPj4gICBtb2R1bGVfcGFyYW1fbmFtZWQodmlydF9ib3VuZGFyeSwgZ192aXJ0X2JvdW5kYXJ5
LCBib29sLCAwNDQ0KTsNCj4+ICAgTU9EVUxFX1BBUk1fREVTQyh2aXJ0X2JvdW5kYXJ5LCAiUmVx
dWlyZSBhIHZpcnR1YWwgYm91bmRhcnkgZm9yIHRoZSBkZXZpY2UuIERlZmF1bHQ6IEZhbHNlIik7
DQo+PiBAQCAtOTgzLDExICs5OTAsMTEgQEAgc3RhdGljIHN0cnVjdCBudWxsYl9wYWdlICpudWxs
X2luc2VydF9wYWdlKHN0cnVjdCBudWxsYiAqbnVsbGIsDQo+PiAgIA0KPj4gICAJc3Bpbl91bmxv
Y2tfaXJxKCZudWxsYi0+bG9jayk7DQo+PiAgIA0KPj4gLQl0X3BhZ2UgPSBudWxsX2FsbG9jX3Bh
Z2UoKTsNCj4+ICsJdF9wYWdlID0gbnVsbF9hbGxvY19wYWdlKG51bGxiLT5kZXYtPm5vd2FpdCA/
IEdGUF9OT1dBSVQgOiBHRlBfTk9JTyk7DQo+PiAgIAlpZiAoIXRfcGFnZSkNCj4+ICAgCQlnb3Rv
IG91dF9sb2NrOw0KPj4gICANCj4+IC0JaWYgKHJhZGl4X3RyZWVfcHJlbG9hZChHRlBfTk9JTykp
DQo+PiArCWlmIChyYWRpeF90cmVlX3ByZWxvYWQobnVsbGItPmRldi0+bm93YWl0ID8gR0ZQX05P
V0FJVCA6IEdGUF9OT0lPKSkNCj4gVGhpcyBpcyBub3QgY29ycmVjdC4gWW91IG5lZWQgdG8gdXNl
IHJhZGl4X3RyZWVfbWF5YmVfcHJlbG9hZCBiZWNhdXNlDQo+IEdGUF9OT1dBSVQgc2hvdWxkIG5v
dCBibG9jayBhbmQgdGhpcyBXQVJOX09OX09OQ0UgZmxhZyB3aWxsIHRyaWdnZXIgaW4NCj4gcmFk
aXhfdHJlZV9wcmVsb2FkOg0KPg0KPiAvKiBXYXJuIG9uIG5vbi1zZW5zaWNhbCB1c2UuLi4gKi8N
Cj4gV0FSTl9PTl9PTkNFKCFnZnBmbGFnc19hbGxvd19ibG9ja2luZyhnZnBfbWFzaykpOw0KPg0K
PiBJIGFsc28gdmVyaWZpZWQgdGhpcyBsb2NhbGx5IHdpdGggeW91ciBwYXRjaCBhbmQgd2hpbGUg
ZG9pbmcgYSBzaW1wbGUgZmlvDQo+IHdyaXRlIHdpdGggc2V0dGluZyBtZW1vcnlfYmFja2VkPTEu
DQo+DQo+IFdBUk5JTkc6IENQVTogMiBQSUQ6IDUxNSBhdCBsaWIvcmFkaXgtdHJlZS5jOjM2NiBy
YWRpeF90cmVlX3ByZWxvYWQrMHgxMi8weDIwDQo+IC4uLg0KPiBSSVA6IDAwMTA6cmFkaXhfdHJl
ZV9wcmVsb2FkKzB4MTIvMHgyMA0KPiA8c25pcD4NCj4gQ2FsbCBUcmFjZToNCj4gICA8VEFTSz4N
Cj4gICBudWxsX2luc2VydF9wYWdlKzB4MTg2LzB4NGUwIFtudWxsX2Jsa10NCj4gICBudWxsX3Ry
YW5zZmVyKzB4NTg4LzB4OTkwIFtudWxsX2Jsa10NCj4gPHNuaXA+DQo+DQoNCnRoYW5rcyBmb3Ig
cG9pbnRpbmcgdGhpcyBvdXQsIHdpbGwgc2VuZG91dCBWMyB3aXRoIGFib3ZlIGZpeC4uLg0KDQot
Y2sNCg0KDQo=
