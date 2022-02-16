Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A70C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiBPJOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:14:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiBPJOr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:14:47 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F9206026
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWXQca8lKc1De4DbhW7/XuWB10n2dvKsLvo8WVpsYbFrLNRp11D6Zv7IkIXbgXaNNbSTaJPhCF/f4vEDZYe+hmcSa9DMNeK96wcT71DfnuImQbQbe51YaQ4zimZuX3+TBOy48ejgDsvctZl8nBXoOys9zr3OyGpX2v4YYEsaGse43R/dnn1wwvWrRqQudL+a1u3HITAdqGbutrAWIhZxiMI3W5Es/4RWjon7+4XXv2W5U39eZpGvIHM4toYA0gIhOAHSA2Y9AkdWKK5qADYtaRvSXe/J5E+Eeif6yXKdUFi2LMMQ9Y7Qyf1M4le0CrQeUzXb+1u7zu6/t1hgGHBAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Xra/1VFDWuFK5ZvAkQvv8IcbS0UW7VVDoNDyi+Thao=;
 b=hVgoE4hkjHRUBv6Lo1vSgcaBYkl0tGoLzs25zt60Gf83egqg323qluGErwW0q78MSQKJL0v3CFnEUnxeHKfxBsy0CPEzgXHZl7kmgySUIFneDZ6Pw+rWZIHqQYc8mgUjxjhMjly8YEIepHXBlEvJwm3RKxH5dWzp57ecvVxBVqz9Yqc+ug27k3nSyiXyF47lF7JqKQk2xfJrlu6BfnOo2boBNILCA1tHJNW6VVc4ZwehyBUDTNLqkK6K6d4X3BLTswxf74jtYhdBegR7rZZwxG4wQsL1vh0etBF/jOz/Vlis2H40xX0xGmLLMhfrWrq+rY7CQjBbdy9A8EXuQsAdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Xra/1VFDWuFK5ZvAkQvv8IcbS0UW7VVDoNDyi+Thao=;
 b=GdwyWSvikmcuLPOOwTr/qmujvL4fdjiL9v62uP3ML9osRqRZHleYc50U8wcUIYC7oM3wUB3JXmuAGTrkOj33hPUo09dkMZGC1ay+4BetuZP/gxAWGHOCVYfVJYrZtKjYDQdRDG65M9hDKuqcSi2UThAOTEYYU1F2WUf6qWO1uoYLtkxI+wTD1+jG9WccAfraauRRl4SxITDJKZ1b+/RMlsF+u5VZx9PNXtvVmiiVwfSwLhQGXFzwvH6cfdvkYjG2XkkbU2qv00x6btgSGYJLknJwNSLdqspaVWSSyOe9adD0LMK+E+H3H21G28GbIotNjLKRBgzZFH5+WQnN9SvclQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR1201MB0069.namprd12.prod.outlook.com (2603:10b6:910:1a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:14:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 09:14:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ning Li <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 1/8] block: move submit_bio_checks() into
 submit_bio_noacct
Thread-Topic: [PATCH V4 1/8] block: move submit_bio_checks() into
 submit_bio_noacct
Thread-Index: AQHYIvAcWANJTO3MTEy8efzr+6VbDqyV5ViA
Date:   Wed, 16 Feb 2022 09:14:33 +0000
Message-ID: <ebb67707-eabc-9bb1-e030-b87dfa81dd10@nvidia.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
 <20220216044514.2903784-2-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 598e902c-016b-4434-83be-08d9f12cbf5a
x-ms-traffictypediagnostic: CY4PR1201MB0069:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB00691509F2B4400C4FC27D38A3359@CY4PR1201MB0069.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAvnYUVMMCw6d9p9PKVBUIHQUsBJbQD4K/4IL6mB/Qm6WsEqeYJvmczjdjWHbwIf8Vp+MJRx7rqgsRksnxaOXJrd7yE8OJQ8RP157v1Vx8UYYfakslDfDzLAmXUZIdzo0i5u/o8Do5UeTDfh99jFdcExtRo6Npy1rF2vJukYo9dyYhvadCcNvDcym94Xb+lltEpP4dC1iGrbByX3E1a8yBHIrtVk2y5xNJsm/2edJ3r87i1w+SBah5Rz3Ic7zJoGBdwmbqNpxAu4seXIgpKesO8SBHbZ+zvuKc9ljIoD0YnZjtsx1ahxjxEx+0nMH/KV4aW/wEUTaA5CzbE2QsQPwlUAaiYLHapA7ATRARYAHMN0LIp5aByneeYPFHd/uzZbohVamDpmSsvCELAFTYgqlSlVD/zXRXNRpdu+JjCtMthqr0evx/jaoZWa91jEOcj3bwlpCoLoRLMKPliscp5ojmJi6/ADINFlUceZ1/SDMxLu3VsU8YIH4RLn971ytdpNoeCbMA9C0KAevEqe7gGR/7KBM5UBAVBbUmgll+v63ESgy76Yh9hx5ZBtTxG9wB2LKJj4xhRvHbGALPxgg1NgxQY3Sny5r/8AvnMi5u6CwKavelSS0fH5uxFkiuDONX5SqSOTyJS+8t6uj2sRk9hoHMgRu3ep/b7d3PT9FE6Rb0mTJnTWxejoR4GLKFD7lidSfQdZVXgeJyFEYtyb+DNCKYXjr6gLbwuLWq3DFbSRUpU9GXuP/S9Fq+CzNqXJDaQkAR3s8vt9dFqmg0zfwwprjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(36756003)(71200400001)(110136005)(38100700002)(54906003)(2906002)(38070700005)(316002)(6512007)(6506007)(186003)(6486002)(8936002)(53546011)(76116006)(91956017)(5660300002)(66556008)(2616005)(66946007)(66476007)(4744005)(66446008)(8676002)(86362001)(64756008)(4326008)(508600001)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmZWMDMzYjBoMDkzM2RrbU9VR1RlRmcyNUM4aTBSbzJGalFDU0xQRGIxMVdE?=
 =?utf-8?B?K3V5UWpxR2x5UU9tUlhwbExCNmxBSWhzKzBDSTBzL0llZTZFS1lTVVhtQlln?=
 =?utf-8?B?YWI0OWxDVXZscmEwZjhINHMwaTl0L2JRY1d3amhDMzJRc1RqSUN3Q01SRmZs?=
 =?utf-8?B?VWFZQXVQbllyVDlxNW1wZ01ZU1hqbENMblE3NEFFdVpGNUU1U3FyQzYrTWs1?=
 =?utf-8?B?clcwdGJjb05vblZ2dXNOZ0pLL1pzTnUrKzhnb1c4OHVmNkNRTHVlNzVZUVFu?=
 =?utf-8?B?b0MxS2JMbWI3RjRrdnBTeUkzU0dyWDREaUUrL2pCY2VIQkhnL1dkRm9DbnJI?=
 =?utf-8?B?czBNYXlhcEhOdktlUGZxWlJrU1VaTnNDSW1VMUlFdFY0OFhnOGo5L2xRcnlt?=
 =?utf-8?B?bmJPMjlSdEx2SkkxM0plU0I0T3JCVngvWnhxUU9SQVFTVGJYNGk1Z042NEU4?=
 =?utf-8?B?ZUJyem02VUw4VEpiV0JSSlo1cUR1Qm5YbnozODdoUVhQSTBGZ0dUVjFtVDBL?=
 =?utf-8?B?ZGVVMUszRFlBTTZYaDQ3ZnZFVGtpQ2RsZEhTYVQvTExZK2d6WW9TNlZBcGtP?=
 =?utf-8?B?aEtjYXEzZi8xSHoyWTl1Z1lacUJSckJlbzE4ekh6MVVydUpLQzlVK2NuRGFk?=
 =?utf-8?B?TFM2MktGZGpkVjB2eGdBekRXbVp1UEU2dVpBZ21JT3NDN2lEbTd2RmJmV1or?=
 =?utf-8?B?K2taRnhieUJoaFFXMzQwV3FtN2RWeE1vc0NGNXI0UDY1OVY2MVdVNi9Yck5n?=
 =?utf-8?B?cEI5ellMQ0F0NnJpbXUwelAvZnQxbHdrVWhLNzF6SnNkOThhS2wzNHNUTk9z?=
 =?utf-8?B?SlNKY3RuRUxXT09hajNzYldJU1FvUmx6M3RYOXdpTUZSV1pCMXJIZGpZNjFX?=
 =?utf-8?B?cytHSENOYXpQbURVdzZkZVZMM1NVM1lPQmpadFMybnBaaUFRdkFaeDZ5TzIv?=
 =?utf-8?B?UWtxN29DK09xc1FtRnFkaGo1c2pQdjNZQ0NoOXNyT1BYTHhCcmJOWFhOajZQ?=
 =?utf-8?B?ZHhjODJPckRyeUxkcEdRMjMzYndybmRYVFhFTm9mZSs1ek83WkJua25ZVUtS?=
 =?utf-8?B?eUtGSEFMUUlmVkRPNnR6Z1NxOHRYdTE0bjdVQzlwYlJsQUhuUFJRMGYvVWFH?=
 =?utf-8?B?YXRZSThXN0htY21ocTZoU2xiR1J5djZFaEYvMHBqM0pOQnNlazI3cjVydTY3?=
 =?utf-8?B?NUd3OGl1eDNOSmQvdkVXUWFHQXl2WU4vSnFhRjArK3A2V05mRzVTcUxjbXNU?=
 =?utf-8?B?aUpidmU2cEluWlQvU0dhSzc1cGtqQ1N3RitqY2M1NWg5d0dwa2w2bDRWdkNT?=
 =?utf-8?B?OGhvRFZ3aUR6UlRpM0FRbVcxM1JJL0JCVFJ1YzE3ZS9vS3hKZEpkSTJqakV6?=
 =?utf-8?B?ZGFGQ1FBbldDOXI4UlQySllpTTNvUVpkSjlXdmdnWXN4VGJQS1ozQ3A3djR4?=
 =?utf-8?B?b2xEUWREZDR5ajNHNUptaU8yaFRJWmdCTlBaNnVWTG9HUEx4QXJ1bmZ2N05y?=
 =?utf-8?B?SlpQTlJtYWNuMjJYem5tWWtZN1FPcWVFd0VhRzNYQmNNZ0MrVFI0NGoxTzNY?=
 =?utf-8?B?b1Z4dlVhZG1DT1hCeERqMTNFK1QvYUNyUjdWbVlKa3RRN3hBWVVkeW1BM3dX?=
 =?utf-8?B?VlRnY0NVdFF6ODdXQXZCdmdYWmQzR3dlNitBNk5NcndYYmJvWnJrdEt1L3VH?=
 =?utf-8?B?VWZCZlRmemVZZjZ1UUxDdVVTcysyUE1Qb1BhL0ZhbmJneDZ0K2gzdlZtaUlN?=
 =?utf-8?B?R2pxWHFqWTFNeUx6Sjd5ZDI1ejhONTIzNCtSUnBYRnV2ZXR3UVdWL1JoL05M?=
 =?utf-8?B?cWlKWDZoZVZucGk2a3N0MksxOEljUDZNTTNtdkM5eHJQWnpWZG40OGZEMlNM?=
 =?utf-8?B?UzFzRjB5YUlvL0gzQngxYmtwdkRNSFA2K1BONytuK2hFS2dVTVh0Nlo1dUJ0?=
 =?utf-8?B?aXlvcmR4OEtnSHVNTmpSNWxDeWNUUWllSCt6RkNMRHFXZUFpYUVUSVRCV0tC?=
 =?utf-8?B?SEg5RmZiSDlKOUN3Y3l5U3B2Q1NEU1M2eVA4T2dqcTgzR3oyaTV2ekNuSWdv?=
 =?utf-8?B?ZW0zeGh0dmt3ejlXTUNwV2xaY1lLKzljWWNoTXpNZ0tFZ2d1Mnp2NXN4UkNp?=
 =?utf-8?B?YlBqWG16czVIeU9ZU2ZneHRYb0dPUHVYbGtRZVBOZEJzU05vSmM3WDZlZEJ4?=
 =?utf-8?B?d0ZpVVI5M28rM1g3THBWVWxLZG56R3dEYzVKcjkyYU4rL3dkYkY0L1dmS0Rv?=
 =?utf-8?B?UUNJTElDOVY3YnRCeW0xa2xNNzV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16764783C1910843B2A900A32F62B98D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598e902c-016b-4434-83be-08d9f12cbf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 09:14:33.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkP5t42bpyof79hoV6CEe6LTv8Hz6CrG/SaY7X8e2ef/Qda0pp2gXkkGKCCbvbyNk68EpbbgVPnOAy/onZATTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0069
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMi8xNS8yMiAyMDo0NSwgTWluZyBMZWkgd3JvdGU6DQo+IEl0IGlzIG1vcmUgY2xlYW4gJiBy
ZWFkYWJsZSB0byBjaGVjayBiaW8gd2hlbiBzdGFydGluZyB0byBzdWJtaXQgaXQsDQo+IGluc3Rl
YWQgb2YganVzdCBiZWZvcmUgY2FsbGluZyAtPnN1Ym1pdF9iaW8oKSBvciBibGtfbXFfc3VibWl0
X2JpbygpLg0KPiANCj4gQWxzbyBpdCBwcm92aWRlcyB1cyBjaGFuY2UgdG8gb3B0aW1pemUgYmlv
IHN1Ym1pc3Npb24gd2l0aG91dCBjaGVja2luZw0KPiBiaW8uDQo+IA0KPiBSZXZpZXdlZC1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IE1pbmcgTGVp
IDxtaW5nLmxlaUByZWRoYXQuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
