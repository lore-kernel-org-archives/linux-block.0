Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F7C6FD1E
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCGXYC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCGXYB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 18:24:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADE3647E
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 15:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A54iXDR7UF6ZFfEwF2D7YTwBK3xawRz6GXej7vOvf18Voavjg2k9RuF7tnfimd56RWO6crlAimHxVS/7VUJxm3yeER4j58IUTv6hdWRy7AUwUnoPj09kgxC23PAMc9uRO6A+4WaK+KPvmlr/8Schs0AGLaBYbIDvJH2oBfDhI/m9vCdXdqZUcrcoZJYcz/bhztAQcVUSjgPW2L7TWyVyfVXn0a7fwU009K1lydtqTjoql2hnNAR140gWzk2/tUHGczYeuybCnw9XoxucKxP1cMTcZIWc4tNgGmKKDvO8UAGWEJ9ekMZFRWcMRSSgsiHkSQmzYd9WOjGjIGRCMd4LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSxJBaPo1QQ0uFxE+ya5fekjcNUL/svjjgvHVi3zJIk=;
 b=V1MhnNshadFCAhqoizvpFQqM+Jta5JbphHfMr543+qclbqjFdWBUZdJaNPqiupxFWhRBHxHMZjTbIrv3LRUqn/gaByXVStRYNjG3x742oY1UgDFyUx8R6jE1rklKiKnEDTvhlTBL5eCEiPRYSQfW7VG1AE4GMBd0PIkdnqhsj9bNJ043aLboPDbbAUHFUpPra+mf+SFxfERtFguwoPJKBoufQw+Xtee5a1Gae5CbHCe8uEGbK49y4Vs/1vjWlAAL8QNz6BsImf3qGH20eHU7X+7R34dAjsml4mTLi3HoqAO+wsPGryXIYpvZSzTKVFuQRX9uNrbxltUB+MiPb6ROuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSxJBaPo1QQ0uFxE+ya5fekjcNUL/svjjgvHVi3zJIk=;
 b=JPIy+EEbpqaHLdJJGCRcfPrTLdyt1bmjIQByaveym/i6IGomybZnwDx1yCDIMaFUG62s7mEGnJFWi+FCX1gutwz/OrhLKtHAhcTfsCrRKyHuaJAT4M0WhPalshYLsGR90Nh+vkcaXLZKI3iUjKzj7BJqJBjSlz81LQnZGrwMJoPx3OtJodHo7IcysfJeKx+eGSeEZbKRcKccJFlfYV/JO2/ZxNcts2mcSYvd05E6Rqr64nLZyL2e7cOx9/W34/E7sC3IZx9aroUlQefozLzbtXq+1aoQ9lUI6at3AG3g5pVqWeZQKLIwD5OccGj40yUifPCS17gHBGkiVDrwNwzQVA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Tue, 7 Mar
 2023 23:23:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 23:23:56 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] docs: sysfs-block: document hidden sysfs entry
Thread-Topic: [PATCH] docs: sysfs-block: document hidden sysfs entry
Thread-Index: AQHZTaw9B02v7D9GPE2YE8rBkqzS267v/GyA
Date:   Tue, 7 Mar 2023 23:23:56 +0000
Message-ID: <78959cd6-795d-6fe1-40fa-7adf7c7615af@nvidia.com>
References: <20230303084323.228098-1-sagi@grimberg.me>
In-Reply-To: <20230303084323.228098-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH0PR12MB7861:EE_
x-ms-office365-filtering-correlation-id: 7c07f049-2ce4-4479-cbd3-08db1f6305d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndoViLEtVmPNaYNEFFnD2Mfav29AGpNIczDI7ZA1r4Oo6ZTJMIYaiwSRuqzU8Gmxt9w7VrJR93+rDCfq4WDp+KvSIx9Bq8PGU0osyY6xFL+2fqB+FrLTbEhFDlAXdX9/q8eBat3cGkW5xSBWL1tLvbJQywoVCNNy1Ht7Q8rYasS7ixDaqLnnyJLUSaSsss+U4cqGa6ROflRB5Zni6Dyg7F55z6Tqyqjco51/WcgN3ivdNup88GCbF5g1phzR5EhvEyczIJHHOtKDunb1119w+X62L4vdgrmbgvDMmOvNocFdvgHy0A0/PC/mdP0Lqbs8VmA9G+aT+PFofgRoUlAh2QANR1wjm/SOK2BbxUm575PR9ycEOmcXs+K+PgtmDALczc9AS69Y8ILr36e22SYqRvFfFsrZWQfj8cHlAw3QBF7n1rxJzkcTsSauBwOuXCOuOV3CsnIqwlcBmFgvSS3QWW+mMoFtNOmypEerQLIncayUWn2lYbZ0ssYKN6cuO9xEdqsTLHZj90WqG9j4wc/DfJS0ivPl0zkDCMfYcR7YO7CocXkMPodE8NykiKj7Pt2Z0zz167+hmgeU6YfA7Xub9gklTu9J0Bjelg+aa5bSXdcYp8txswWdXthZhYVsTIGocOZI7efH/DOEk/rsdrSxPzE55I/yM1pB9lT3zR9v7+zKJBYNQc6PZkxu7/vJFEXUXWpeMUAxJolFzoxbo7KpvIyDqk8gRD6c7tew80Tns7Pmr7RzgeCaLG3HbywjpMlTpXv7BpUWvCU/5qug76BlxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(38100700002)(4326008)(66476007)(91956017)(66946007)(76116006)(41300700001)(83380400001)(54906003)(558084003)(86362001)(110136005)(8676002)(64756008)(316002)(66556008)(66446008)(6486002)(122000001)(5660300002)(8936002)(31696002)(36756003)(478600001)(2906002)(186003)(6512007)(6506007)(53546011)(38070700005)(31686004)(71200400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJIdVFRZ1FDWGRZRWh4cmM3d2pRODQzbm8wNnVGZ2EzZFUwMWNLRkxoUUFH?=
 =?utf-8?B?cVVUNGZzSEZtTDVLaUV5ZnFCMWo1RWN3eHlEYnRJVkpsQ3hTdkxTMmZFSDhN?=
 =?utf-8?B?NGU5a0w3N1c0cmtNMThuT1Y4QStYeE1hbXY2NmxhY1lpcmRoYkRIL0FJYkly?=
 =?utf-8?B?cWRYVzd3SFRWK1VqQmhia2trVjhneG9Tc2IwUHFadDNpWVhnd1F4MXZaUzNn?=
 =?utf-8?B?MXkzeS9ZY0lxZWxPeEp4SGFIZVBkV0YybzFWUTlURnNrUjNVTmFTZDA3RzBI?=
 =?utf-8?B?SU1Zc0JnaW1iNHdnL3JSWkY2QjZLaHNZUG9WbUxTME5HTkUvazhkNTdIZ0FY?=
 =?utf-8?B?djI2M21zVkxjOVMyZktkZEJacURkdnZ0WkFpbXJJUUJkSnBwYWx5NFgzcEF3?=
 =?utf-8?B?OWV6VzV2K1pwMGI5Ujgwb0RxSlM5aVJFWk1pMVVYcHNnVWJoejJtQ0lDOC93?=
 =?utf-8?B?VzhnS2hmY3Q5VXorbGZGSWdLUUZaS2lKTzJmN0t1UWlFRTl4SW9qcnA5b1dl?=
 =?utf-8?B?ZTk0Z1VEU1lQQzkzQmI0cm0vbnJPZWZ4V0dhY0U5UnVEQ05pMWtRL2pVaVc5?=
 =?utf-8?B?bVV2VW83ZTUyUDhSUDdzSkRCa3BPemhxcGwrUXhSaDNiU3NiQVAvZEJDS2Ux?=
 =?utf-8?B?K1VBVHk3YWNtZEVIOTVkRVFKT2Z2bWx5a0lEVmRSWkdZbGxOaHVWdENHNUg2?=
 =?utf-8?B?YWlLMHhOZlRoTU9wUHU3TGFOM1I4Q2Uvb0ZyOVpjTlZCd3lnZnlwTytOZzJk?=
 =?utf-8?B?eDhqK1pmS0htZzRDbkFHWDNmK2pHVStHS3NiVmVid012Mlc5OTYydGM3UFla?=
 =?utf-8?B?OEJnNmtHT3l1WC9Fb21wcTlQeXJUZ3VxbU9nQitnQ3RBT0tSRE1OclhpZWFi?=
 =?utf-8?B?alBoZHZEZzNaMVNncm5ySG9yN0Vvc2wybmpuSW4wMjZaQjVYZW52bUVueVFl?=
 =?utf-8?B?WGZVWEY3UnBNTTczcUNkY0xaSFBKYU5nbnV5OHQrMXU0S2d0RGE2VUU0NVdN?=
 =?utf-8?B?OWxPRHNyWHJrWW5LbTJPK3k5RWEydWFwS1BJL3ZWa2hqS1lQTmF6MUZnaExs?=
 =?utf-8?B?LzhTa1ZVWkhzMVcyMlM1UGtwMmdiM0k1S05iYVNGbmF2TlBjSG5HMUYwOHpD?=
 =?utf-8?B?TWFCQU5vdzhYdUZlUFMzMnRCYnlacWZxSURWRWdwME54K3k1cm9iejBJZERo?=
 =?utf-8?B?SmRmRThVOXpUV2RzZnlDZnpld3h5MysvMzhuaXVsZ092ZjhwUVdkeUdia01v?=
 =?utf-8?B?Vmhsblo1ZVFYWFlDd2tXWkdweXdTbHFiL1RPVDB1QWpNZHRudHhISnJIbFNK?=
 =?utf-8?B?SGp3M2lnc1FHYVdnQVNML1BFbGJFcHRoZjQ4OHg1ZXRXNXNGY2l4VXQ0MHVh?=
 =?utf-8?B?bkt1WTg2eXdvTytzYjd5U0I4UEw1Rmg3bjBWY3RnbURQc01OWGlsSm5VZ2hM?=
 =?utf-8?B?SnU5bTNaSUUvNzBoTThFcE5XaXJNY3o1dG1MN1Z0cXlBcjBqOHZZOXpxcFJh?=
 =?utf-8?B?NTBQeURBYzRlTTVsY3RkOFByczNDM1A4RWxoeisvZjFZRk01OVU0TVRzYURT?=
 =?utf-8?B?N1U4QTBNVzBqZWg1YnNRZXdzenprTUFBVkFpTGxzZmNHWmswU1ZXY0N1L1Uy?=
 =?utf-8?B?OHBXTDRIdVg1YkViRkZWLzNmVFVmdnRDbG5wbi84aTB4L2N4eFRUeEpxT3Ar?=
 =?utf-8?B?c0JlWnVDR0gzeUI3VW9QaTNMaFl0bGs5bS9iSTFxcFlkRW9saFdyMGFaVEdK?=
 =?utf-8?B?VmNyT1pNZjNTY3VCTjVYTDlGZFZ0a1pBWXRUc0lJWFNLdnJoai9nZ3FEZ3Ft?=
 =?utf-8?B?YXlEREwweFAvd09aM05rb3JKRTEybWcxZUNhTm0zQ09IZUN4MHhacGU4T2Fw?=
 =?utf-8?B?OGZnZmZFeVJPNHQyRXBMWjl5MEFBS3A5OUsrT3ZHNWdMVWovbG85VWxUUEpW?=
 =?utf-8?B?dlhBUlR1cCtic2Z5RnlyNXppbjFwTk5Mb1lSQ0duZWFHWkl5Y05jM3lDa0l4?=
 =?utf-8?B?Znc0cnM2OU5RWGIxQytWM2NGL0t4d2N4aDM5ckhBYTdETytRbkU0bTZUQnJh?=
 =?utf-8?B?UUNwV2JIU28zRDcwN090SDlmUVlaK1pwOEprRTBqNC8wYm9iUUp3b1VkWEY5?=
 =?utf-8?B?VDYxZ1h0azFnSjBRaU14eVdWR21uZXhuU1RDZ1Rab0VyNDQ1blpwa25QcExF?=
 =?utf-8?Q?Lln7IlUD9tuxlFyDKKcYMU6wlfM0AsM30PxLE14zvBBc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76ED19F3B42DE74E8175516527B9ABAA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c07f049-2ce4-4479-cbd3-08db1f6305d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 23:23:56.2512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSgwHgwvgtR9xI/m6WJjDW8MiGobEyYA/PM3b7gEgmXpX5SrthGOnIIfWkmNO+Ftca7dssEypRUQ02V6QiFp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMy8zLzIzIDAwOjQzLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiAvc3lzL2Jsb2NrLzxkaXNr
Pi9oaWRkZW4gaXMgdW5kb2N1bWVudGVkLiBEb2N1bWVudCBpdC4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQo+ICAgDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KLWNrDQoNCg0K
