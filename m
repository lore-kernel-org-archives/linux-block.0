Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44AC4332F
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 19:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKITpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiKITpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 14:45:17 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE391DF0E
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 11:45:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlEeIG2cR8SSyd7HzQOFpR3KDumA4b6wGmCGYNUTnbWl2fTNobe1PBKZ9DM7UZGcRbNmTBbJ5RpTCDSGh4Sz0Jj35wNwaCFybzQSZhwZu89t8Uo62lufeU6N63IV6z4i/8QFiKmuIYNYC9S9tdpDRiXmCIHqldFMIQnJZF1N1gvbzIxdaC1EGWj0LO8oooDabyhn5XbIBWVNRPWGWy+q+B5DbtykIs0OkX+a8xS4qepKDuhq6vW4rVN2PviYjoeXO5PhTX3Ss+FMMDRyw8U6G3d4aakdi87JQCmpODmHCgr9ZqamCJrBK6kXAnIKeyekccRmoZ6icKNPKLTMoR1EIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y0tBp/PfBeITX9wj62R6UM8Nak4aZvWrLzHXnDEh4M=;
 b=ieaBJ9ChUDVpznicWDov0MFOTmGa4R9dgRgXf3gHZ3U0j+Rh74mMwHz1PcRafsWud7vjpwbzHImnxGFfZDBjWmvPOEN7L8JRNNJU7QpSY6TVUagDkesHqVjqRVGtHdKKJ2dNtGubcZEFNT331AgISHOORzWWbareISOojutTX3X7/HSM+yq0r3nkAWiKJlHMsz709tEmtBgYYGwRkIFvSx4vVY+bmoY8oX9m7+h+AsPRRr4pa1SHRk7Od6p2CshP1INy1Ayhg57kmwtEpB6JA6DkUXVxr5vcfvEbE4THYh4veZWfC/yynOWNlYgRGvXuwpDNEIeG2FHiAy7iauc7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y0tBp/PfBeITX9wj62R6UM8Nak4aZvWrLzHXnDEh4M=;
 b=ZnepY6wSp8mYpgzDzNzp+PalmRmjRSjAcCfRgmOGeeh4b01l3QZQmChOOzgD07FFfkcwRm7YNyoRO+04PKsLAhR1iMR9WcfZci/kVMlZWdZ1y3eFdg2Ljp6JKebHxo5Y1MFgqgJChlvn4h+f3nz0XeuWERb+jlAP2F9fqtTxbEhy/ySWYvhPHK+ZHak0QhA3MPF28njGruOtBDdIWENoDEBKC2elF6gyPhQIKYxn3ejLfyPJ9gpu2Tz/L8iKWNjAU3OO8Hoj0h6z8nlPpAuO00FD4Tjlll6FbTz1zLa3tNq0oa62286wjFVvQNfEHR2mVyUJmwvLECuKZbgvMHLKsQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Wed, 9 Nov 2022 19:45:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 19:45:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: remove blk_mq_alloc_tag_set_tags
Thread-Topic: [PATCH 1/2] blk-mq: remove blk_mq_alloc_tag_set_tags
Thread-Index: AQHY9CMzxBgDFI0Q506fZlOE4NGdt642/0kA
Date:   Wed, 9 Nov 2022 19:45:13 +0000
Message-ID: <efe4692f-c3cf-a2a8-5610-3665b7a0b8fb@nvidia.com>
References: <20221109100811.2413423-1-hch@lst.de>
In-Reply-To: <20221109100811.2413423-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6423:EE_
x-ms-office365-filtering-correlation-id: 4ddbbd29-b670-4fa5-fead-08dac28aeb14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1KhJDL7sCblp1WFuquN+PQmq3QdtfCapd3SHejQJG+e9Ay9DUh6Jl64rRTo/GkKEeIQjYZWt5P6sWwxrGlec+1C3jMIdw1O7S4QTRTxsL42naxKmB1td0eRZmIFhz2CwsJUBepoqJS7MYAMal1C7+GOy36tUgBtqOtbUjDsb9z0hnM5GLQLqMXNRPKrAp7XqgaNsiAhmureYJk3ST6StNYkVwGxYXW+0fREzpySGU9dK8p2ie1DKtg5eVCr98TnnrUs66Q7uW0U056db94KRWhTVFBVtCb5PCncTqEpxXIs5T5FHBDE+c9mj7dn+TzErbTWONSxDgMPVmMf8Y8qqHr1/ELqDUmJR10CQC8Az8NZ1aRZheUapl0rUWqxZYsrJqiZJDsAop7rmKL7cQmyF2ApCYqra7hhf9cvMrxjUkMULfGG+gBEMJXU223dOrI1u49TJcGmASyyQLyjFlYbI3pIbV3kbl+Bx/gxZEbkj1rhhGStDlMaNs9JB4pdp7KY4eqHFxhX0L8MrITCEQPV+gOkPfAOteCGm8QQnXjYEzNFRKc9Vblleuy4cnGgdrNVhd1U1Vn+uy1FtBbY6K1au4gtli1yp3axKcwWrBIs0t6TNKrXhjltSZr6XDQTDb/7IzUGtfLdoJc8q/d+++kS3mGnMGlMLUZAvyraxJ97LjEzdh4Ib53cAxr4bMStzoCDrqPpi/od9+llccxNcxDratGbbvmvENz5Y69ZsaM4x185PMEJOXP/dCmaZTE7vPtaxIetKoLWCZEHIhnVMcpX/fJoqgPTX+KCQOJjhQFL7VstcpgcCqHdLVsaEdTOZ4rdnqai+vdc7FrYj1SUsJBHFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199015)(66476007)(64756008)(66556008)(4326008)(66446008)(8676002)(31696002)(91956017)(38100700002)(76116006)(53546011)(66946007)(316002)(6506007)(2906002)(558084003)(41300700001)(186003)(86362001)(6512007)(5660300002)(122000001)(2616005)(8936002)(36756003)(71200400001)(6486002)(478600001)(31686004)(38070700005)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3NNNHRKRXRCMm01dmVaeVlmelIrTU1kb2c1Z2VBUEowMTdTeGRRcTRSNHRz?=
 =?utf-8?B?ckJTWXJudyt0SkxWTHlFSU0vMHVxTXFjcVBucUtEVkZkY3pEZFBNWk9IMmJK?=
 =?utf-8?B?RGM2VjJoNS9CNGowVFR0T3BVb040L3dZdTljQnVHVXdyUDRDUU1yZEM0Q2o0?=
 =?utf-8?B?azhGeE0wVkFTRUUxNW5yWW1nZkhJWXZ2UEhyTEdUUmhQUFBEb2d5SkpYUWRu?=
 =?utf-8?B?cHVoSEJ6Ui96bncrRkpkMitsS0E0Rm4zM0NvdmVjZkhZcmxJcUtzbHJHaXpq?=
 =?utf-8?B?VHhEeEluZmE1cVo2S2ZIRGMxSzNGSnNnVUp0enVRNmlGeFlwdVVqZkdZNDZ6?=
 =?utf-8?B?cy9PaUFmZ1NFQWdKWGRQeHlldlRmODBLbzZmN24vSmNTUW16czZiMnIzYXRn?=
 =?utf-8?B?R0U0M0JTSjlxb1JoSkNzSUN0ZU9HMTNWMlFQaE9tQ1pJRVhpV3pHZWZoNXdi?=
 =?utf-8?B?aGRoTTZQRnRDTjRnUy9qdVpodllaYmhNRjJiSDNUYUdtL0Z4M3hGeGFXcmpM?=
 =?utf-8?B?aVlmeWZEQXNpL2g2K3RRZ0RXWldvUytodS8vRnA5UDBUbVZTY1F0cXZJQlZY?=
 =?utf-8?B?VWk1Y1hrU0I1cFdtNGFFTDhyaDVBTW95ZllBdVZET1pqMHYrU3NFVXhaVDV6?=
 =?utf-8?B?UXNvajFKbWZTNUdodHMvUmJBZ0l0NGRGdERLeFBmRFErQThmWUVoKzdqajRQ?=
 =?utf-8?B?MVNYMFFrdmxIOVBIeFRrVS9QeDZyTWhkOERYWkl3K2g5TkNiS1NaOVcyVlVV?=
 =?utf-8?B?OGNEQkVuS1V1Qi9MQXNUS1hTRCtBekRNbzBZZ21uME9kU3lpQW9YNS9XL3lK?=
 =?utf-8?B?QUhrZTNPTnNvaE5XL1UrZEFqK09zV3dIc2FVMlVJOE1UajFtK2xBNzVteWpS?=
 =?utf-8?B?NmZFRE50akJlQXVMeURWeWJqZTBmVUw5UzNuVGVXeXdhNjVnR3J0N2ZYSHkw?=
 =?utf-8?B?WjMxTE44TFRvU0NsQ1h0Ty9qNGxFUnpOeHEvM3JheEZlbmdVY1JET1ZhMTZM?=
 =?utf-8?B?SkZpWklCYUNDcktTbnVYY2lKa3g2SlFaQ1duak1zbVY4c1E3bTB3UUdEM2FR?=
 =?utf-8?B?VlN0djUxWlpiM1JJcVAwVHo4Z2tZZ2JYSFZuRXZLS2pHNXoyalUzaHVHeDNl?=
 =?utf-8?B?dnBKZld5ZTE3WTNtOTNwY0dXWDRqLytHaEJDQnVVNXV4YzA3M3M1dWduYmg5?=
 =?utf-8?B?SW5KY2J4bFZ3amJYK3k1Y2xEdnFpNVllVDhjbVJScCtVZTV2SmQrRzhoVnIr?=
 =?utf-8?B?RXBZc0YvYWNWN1VKcjRSTkFIWDgvb24xcmhFNzZSZWVKcGtFU25qeTM2eEpq?=
 =?utf-8?B?N0FLYVNsNEt6MTNwZ3FYMHcwRm5vZ1R6NlhWdmhtTmFDay9lbEZUeXFOcXNI?=
 =?utf-8?B?S3d0akJQL1ZEOUZ1LytKbUh0TTdXdWlSVkUxRGdjOFNIKzd5NlFFdnprU0F0?=
 =?utf-8?B?NkkrZ3lYMWxHcU9aSGNZL212a3JYaE9GeTJRZ0tWS0o3WFlyV2JQV3pKMSs5?=
 =?utf-8?B?SldrcTI0bWJqOUtmTmhOakdpUC9tU09GalFhT1p6d3ZXUzgxTHRRa0d1eUhH?=
 =?utf-8?B?dGtIUVN1czBoWks2QVh3QXozNmJ4WkxwY1pqKytFODl0ZU54RWN3aG9JcHl6?=
 =?utf-8?B?ei9zVlFCUHJqRVl4WkhyVzh1S25QMGlXVnVtTCszL0N0ekxjTzRONEFxZEta?=
 =?utf-8?B?akZSRloveGsra1FqdmNqQ2lTWUFZYlVITG83eUtQYk5HVHNoeWd4ZjFWZTRa?=
 =?utf-8?B?d0VncFo0N1JEZDRqd3RLR0dvZUpsL0h2UFpHRlI3SWRpdWVnb05PUk5iRHBQ?=
 =?utf-8?B?VDhobWJxak41b3B2SGtsZzNiOGhuSm5RQ3haaFhiNEFaZ3VvWjhRR0xSQlps?=
 =?utf-8?B?RDhTRjBreStNQVp5NnUyWndnei9IbGFiczREdzdsZW12YnM3SzR5c0hOWFpt?=
 =?utf-8?B?VkZad3dtK3gwVUpNd0pRTHArTEJSSmdyK1YwNllQREJEd2JlanZFdldsWEtq?=
 =?utf-8?B?MDRFNm9wZjAvYjJEYm50OGFEM1NzTG1jSTd0bDNrQ0VOM1I3Wk16VWx0YXBj?=
 =?utf-8?B?QUxKSGVmbnFxakEreXpTOW10VGg1YndmeVJrZDNsVWZRcHlwVXFsS0d6SjlE?=
 =?utf-8?B?UmpNSFdxZWlESGJPNVhkZUN1ZC95NmMwanY1VndQUFVsdWVxSFIyZFQxUFd6?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE7AD4EA55433F428071AB8B078BAB15@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddbbd29-b670-4fa5-fead-08dac28aeb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 19:45:13.1018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aALhytoofHBBXwoWoEBGgkJ5NkDbIaq9WQmNxa0lbtAVASBrPW6ROc5aVdCVyFV+RNdIXkcCeNzXDXXpGLYqzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTEvOS8yMiAwMjowOCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXJlIGlzIG5v
IHBvaW50IGluIHRyeWluZyB0byBzaGFyZSBhbnkgY29kZSB3aXRoIHRoZSByZWFsbG9jIGNhc2Ug
d2hlbg0KPiBhbGwgdGhhdCBpcyBuZWVkZWQgYnkgdGhlIGluaXRpYWwgdGFnc2V0IGFsbG9jYXRp
b24gaXMgYSBzaW1wbGUNCj4ga2NhbGxvY19ub2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg==
