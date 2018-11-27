Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16162C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BCE21104
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="c8vj+7A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BCE21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeK0LeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:34:13 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:9019
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbeK0LeN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 06:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ0kLdU3VUezlzZLCyuNZqzGbY/QmBi5wNuclp44pVk=;
 b=c8vj+7A2V3saOqsPpfYSLZiFgpGBXnPJPkzgo7gGS/dDZFLz7euNArU66bsyXY2rpoE6IKBggRSwV6bc/n1irhVSsZ9i1QMPSeuzEJmuOtRSfiPgWRSpchDJ3kS2HGv9ZVTzeVknQ1wgiVrKtc3Ax2m8OL2WpM7nxfovn0ftxqg=
Received: from HE1PR05CA0289.eurprd05.prod.outlook.com (2603:10a6:7:93::20) by
 AM6PR0502MB4056.eurprd05.prod.outlook.com (2603:10a6:209:1d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19; Tue, 27 Nov
 2018 00:38:08 +0000
Received: from VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by HE1PR05CA0289.outlook.office365.com
 (2603:10a6:7:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.14 via Frontend
 Transport; Tue, 27 Nov 2018 00:38:07 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT022.mail.protection.outlook.com (10.152.18.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Tue, 27 Nov 2018 00:38:07 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 27 Nov 2018 02:38:06
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 27 Nov 2018 02:38:06 +0200
Received: from [172.16.0.177] (172.16.0.177) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 27 Nov 2018 02:38:04
 +0200
Subject: Re: block and nvme polling improvements
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
References: <20181121162347.17430-1-hch@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2afdac7a-e031-0d51-38cc-b8ce39b91c79@mellanox.com>
Date:   Tue, 27 Nov 2018 02:38:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.177]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(438002)(53754006)(189003)(199004)(26005)(77096007)(16526019)(186003)(23676004)(16576012)(2906002)(76176011)(336012)(2486003)(65806001)(65956001)(54906003)(230700001)(110136005)(4326008)(47776003)(86362001)(446003)(31696002)(31686004)(11346002)(305945005)(81166006)(6246003)(8676002)(6306002)(81156014)(36756003)(316002)(356004)(8936002)(7736002)(966005)(67846002)(486006)(229853002)(478600001)(106002)(126002)(58126008)(53546011)(3846002)(6116002)(5660300001)(65826007)(50466002)(14444005)(106466001)(476003)(2616005)(64126003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB4056;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT022;1:yLWVFcpQmHFUJWdQEB6fdcFOmHRZdL1oOcYWXHiazhidDn5USQYovFV1dEtwEArhJ+l7KVwQSRodZRU48Zn8AOSbFIVKRYzJChtuMHHYRaDk437bjnEi9i1qPKrefYle
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0380ba2-525b-4310-72f7-08d6540099cf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:AM6PR0502MB4056;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB4056;3:kUgtkP+4H9PEONPhZ9AdLRFHohfjCivY3itsZwVklQ5MozDGRvGxHD6L5r8uiCienxNfjhraNx2gpjk+JouU5piUUTTKTHBZ8/rTsdfNY+MwEB9YQIlbjLgrN2CuKWYaIwz8azMyfYpHNLGYrXvFNU3uy1fjMhJEVos4dRSj4GkXUpPgmkKfuxGK4RRe0mtvgLwtfju4VW6Oglc6jPjAMC6cgfs6gxNjldVagAOn/RrgR+vvcNbZZH5PhmlsdWmTvWH7Vb4e+klJCAqRyWS1GzpPNUVIkSxBqwYbzKDMSZMTTZ8RxYFXbBD8mRplV/euWOV+18kHQ9eT0u0MkRtaH1k0N6NGqz3h/GbAPrCRNoU=;25:NVeXU1E+tVoL7gCfUYOnlTle+N4coJ6WaBEiasUPjCP3AoVU1cuTlnfSwgjPVlM+l2b2ekEox2FgzEwmnJdgngXzFdHk9pf+r7LVDL5hCkUSHQi2tOiROEw9jm0A4akDnw+aErrqdEt0MmAQzXvmEiauZ6cRpZxJMdqXDiolmAZmM7BD5xIzk142poTwBqbBYuPrRVxK2jqWW0KdVTeFzz9Y/ZSteKsZnh/IVARNbdsJ24BSfqWRi4eVx1IhQoZlzHFfaT28mf01JFV/EHJ5TYn5fDMmJyBGdNoOUwEb7r1ECcvqj7bDrh1UrJTfz2mUyo7kiUg4djGcTSZsg+LsAmdzKIG+ovtutAffPb1spv0=
X-MS-TrafficTypeDiagnostic: AM6PR0502MB4056:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB4056;31:kFw6CTKF8/oiofPexZgqg6+pd5mDs6lHdkPxuagB7YHHVqmFk32rqgI76EptLdoNW56tHoIj86BZ1+8axom/kx/qukt5VaWFwNhmYqY5u1ImJkuA5VoCX7uSjyYODj76zVJ5J5KAbyZgPO+Yuy6NZ83bJAzlzOCkjg1h/8znvmiTG4DcEhRgUiCUm1gyEvlfrmx/HWDlu96LrTkgUW0t00eCmdZWtSSCfiLTILHM6LE=;20:9B21kaoVfCcDf/idrlF0TanzlRK8iHS839bus/F9dp94aLj3GwEi8sMpBWZjupI7eejkxCN75NYlDDjzFHfZeLvEDyzwuranQ42wzQj8XwesetVTtCQ1mY4mYkm+k2IzQWO3Iu9LxHjeMhQJV0U8PlH2hTejqs6j6V1zsqYSOLIHXVvcHAb/gfJy43DU08AYS9ojbvm4MAO81A9wMpe9gR8Bw+h3//CNy5COnj+4ahMDL9WNkeAiApd6bf3uw9Vjj/oKljUqQqmbhBhbMUhnxMrN+nwndudSUVrxbICFLuLXpTF4aOoA5W2SUUqgmHLYMMgpllTBLMwtyvxSXqkcCxBX/ibAd2GKIEw9HqVWBPttkPFd521RoYMPaUjzR7ulCrH/SmSW3Iap8aFm2ioZM82meiwv7bvc+ONJrQOjC6xiAEa4l0cj5GD0BWQ5woPP5EiAW7AY/MyOBXqyikqDfyberY+Xb1AXh+nGlCwctDLYShH8EKcYfAfCI2xIKB4g
X-Microsoft-Antispam-PRVS: <AM6PR0502MB4056981929FECB27ECDF41C2B6D00@AM6PR0502MB4056.eurprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(944501410)(4982022)(52105112)(93006095)(93004095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0502MB4056;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0502MB4056;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB4056;4:U6X7G+CybwOoeddkFZCt1JBYMlRMAdAwZfD9jl7jAOKR4O2J2xnCDfjTlymxARbQirMNO+Q6W3iy7ll6ro0qLOORSax1ByXV3jEQMxxjVd0ONV7b2yhmSACHKX3S1YhIofv6CIKsqcaoQuY+E2DWH6PjB+Ryo6HdHTOoeIDo7wJaY5MAs6YgbqgcmVcvAz8qLVo2bwK6vEzXy7SKiUs0ITKZyfxkqgSWdJaYyKPS7YDwxeyCYz8/CfU4USzuaemaO/F5bo0omf09eW2BAgy6Eg==
X-Forefront-PRVS: 086943A159
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA1MDJNQjQwNTY7MjM6Qmx4NWNJam9JVlNmMjZDbXkrWlo0YStl?=
 =?utf-8?B?TGJxRzU4VlF5YlhFZTRNa1lyT2wwNnJMaUhJaDU0RkE0amNpWVNadTlUNXk4?=
 =?utf-8?B?c1FPczlVMkNXSU14dU9yODM1UitoTFRGUExHVk5DaG9uOWs2Z0IyOFpxS1lt?=
 =?utf-8?B?Tk9DRW9tNkgyZmpNRFJ5ZWFQd2tqRHdSbzFqRjVIVnNScG1SenRlby9CT0xJ?=
 =?utf-8?B?SGErTndMM1ZUb3dVaFlKM29vT0JoYVcvaDg1YjNSVU01Y2todmVzVUFvTFU2?=
 =?utf-8?B?S1k0N0NERkQzbDgyNmorUnRhT0Y2VzBwMUpQZDNkSVprckRRL3RiRWR0YWJN?=
 =?utf-8?B?QzVFa1JjbElaT09mL2F1SVJiK1RHd2xubTgxWjZieFNhRXVoTjUzTzRZZHBQ?=
 =?utf-8?B?blV3L3VUL2hpbUY4cUJIVlNMN2lTZkxlNExpeVUxSVBWMGQwNUU0SW12bzF4?=
 =?utf-8?B?NmppVmhRWjBxaGpRODBOaFZKeFExdUxVN045NE45T2krRlNSUWFyOFUzbmN3?=
 =?utf-8?B?dFluTVJJaEhORUhmaHJOVTlzelhNaVcyRmtZa040QUtuaXY4SXZoTXZYTjRX?=
 =?utf-8?B?REtDcWFRRVIvSlJXcjBSQVI3RjBGR3U5alN1cnN4NUNvMU53TFBVT3ZEYjlW?=
 =?utf-8?B?UHNQNnl5TUEyaXB2WHpTZ2VDTGxJR2t2dmlxRVg1L2RmQ2pHV1hENDl1cC9S?=
 =?utf-8?B?RU15SVBQb0t2bWwvSVljRnNlMGQ4MklNb3o3aFBPWVFIQ0RmdjRWWEF1UllK?=
 =?utf-8?B?cFY3OXR6ckZHMThSdThmb0NJcDdYVFFieVZyQU05TC9tSFJ5WjRzU0wvK2tQ?=
 =?utf-8?B?K0pOVjljdGlNRFBvMGREWG9mQlFUNXlveWpaWktacnlkdks2U2dTNldlb0w0?=
 =?utf-8?B?SzVNOXJPRjJESkNJaE9zT2pESDJqS3RBSWRsUUNQRm1PbmR2Zk93TGZHbXdS?=
 =?utf-8?B?VXE2ai9heElEVk1KYnljOGtRR3dlOGVlQzh4c3FPMEZ1ZWdpZ1pTVUppNjQy?=
 =?utf-8?B?dWVBSG5FQUhpMmdVamxGdS9keEp5b2JWZkt4N2ZmM0dtTVc4VFRteHVva3hx?=
 =?utf-8?B?Vno2cW5odWUvYnJuQTgxSm5tckRpM2g4am4vRkpFaVViaEVHRENoNGZoRUFJ?=
 =?utf-8?B?WnpSNGNVa1lEWE5Ic2N0RWI2Zm5adXJwMEMyZER2NTZCVXllZ1hPdjJBMDRx?=
 =?utf-8?B?Tllvczg5U1NvdGswU0xzam01RGxSWGt0Z2tyeHA5ODIwbExUdnUrRm1sYTRK?=
 =?utf-8?B?U3piK2ZrV01uTUt1cFZ2OWMzc1BGc0ZKZ2tIeEFYY29TUlIzYjZUKzgyS3ln?=
 =?utf-8?B?TlUwa2ZGeVBnRGtCWjQycXRtbmtnMFZmMmV5Yms5bWM3YjVXR25lNUJEYU5l?=
 =?utf-8?B?ZHp2dThkOHhURko0UnpTTFBYM1dCbC8rYjZlRmpDTmRBQTFLVkxoN0NkTHNo?=
 =?utf-8?B?aXpuRGdPY2tuVEJ5ckl1NSt4Tkx5UWdtOXNVbFp6bC9RWkxMSzllV0o4NVd5?=
 =?utf-8?B?MGxWc0M2ckJWR2xRZkNxbEU0cCtpOU1YMFU1REpYUkNuSkFRQWs3OTVwNFU3?=
 =?utf-8?B?T0RndzBESWxWQ0M3ZDVrcGJPQXJVbEk3L1JwNDBMeU1lOXNQdWJZMzlhQ1VY?=
 =?utf-8?B?QndzZFhtU0NCanIvZEZ1YVg1eEdEQXdISlZWclVWN3ZpYVRmc1lKcW5aeGRm?=
 =?utf-8?B?OWVBNDlpMk1WeWdaZmh0blNOV3lpdEZtQnUvMnRZaTZ3cExGekxHY1o4T2E4?=
 =?utf-8?B?MWhscFpscjF4SDhCWWc5bjR1WUZsVFVPRCtSejFHZUpwM0NmSGdnaHZYOUJp?=
 =?utf-8?B?ZTN0aG9TdHRXeTRJU3RFcDBRTUJ4WjhMemJTS2YwanpERjNydzNWeEtOaCty?=
 =?utf-8?Q?5oDCRX2Oqh8sk=3D?=
X-Microsoft-Antispam-Message-Info: a8paFmBpC2IJKXCpeNW5BAJwD7NbW7fwVM/QLp4x04b/mC3VnzAjAicJignm83o45GSbJ0JDJgikjIzxeK5S34wV+sioLfwEPo7uc+57z+aYYcU2WVzDXDPF6YJXpSVMs2tuizUbAbKvATRgIUs19nAunQSBHtX+xyVh5DtMSfXAEy4KF8qAJTzpNL44QSNfbEwSEBNnQNRx3qcoAqOEedQiy4ug84VhQmL8eBnJIM5PubrhPgRly/S6azLjpS30fx4OhY0Mgy8aX8E77MVi+3+hVnMh11FRPnCZ63ndg7AFzC9UtT1naLV3Vj2bI5oQEQSIEslBgizTLvNmf0CpaWBx7/Z6avb8f3gE9tbGwkQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB4056;6:FhVOyi3PecZxGRyPMLp0gTZecW4jzxxTYw62+n4OIBPCeKtt6oEiNnfxDOqXyjZ9MvahCfbQDhJGsMZyvzXozOJgG0CgGJ8Pf+6xZwuNYvzrcGMuDkTLU65JvzZ9jEiZgWf35Rj1nhmk2NIHmaP6uLXgurSbjyVnIdcAE+bJAUDHcnLjSLXCcrkYnKGEMiZUMBgUTu2etdrpkSum0gRPDIRWKJJ0SYep7tKJwzLULmIFVt+CBAD2qJ6pmR07Ye6EgP+nV1M0g/jXDJeJHRnSRxH4/CA6mw07p0+Gav46pGF1Z3YC6gN1x72/NKrdQsWiO9oYy7TrsK3l0MURRejuoUX+6SBzfnUau44kJyxuomEqrO670xOyYMgm0233BPqaKOX8AiFhLfOjkjBwRYk2Acte19KDd4wZCNUCqu/rKL2AyyGndh8Ygf5/Tl7HQRc3EzvTIIjpoPomm24P7Q/KBQ==;5:7Vsf3YS1hXNgi86OdMwf8fuqTMlqZRrXygpHoq4Bc/7iIhMsAblACgNCqXALGv2RmVC2avxHuFJgziGCstGN/S+d1y4FRsBuJ8lonMCkLA9U8skInsbn3S3nnnKs8dzsU9JxQcPxTCCfDVSRj7U/XRE3o8jgHSchX0FGlbHZSuk=;7:K0JvkR9519LMfLMVpKr3nwBV++A0SB47d/+2c1bidrzE1M0pnQ0ebEEyAGLt0Ke4RLCUkQxMAtCZjTTk3TSlli1LYu2ON+m7CTCNDJZG21SO35XgnU6tvU7DZjOm6txwgfaBvAA476kTF1Soe1MQ+g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2018 00:38:07.4246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0380ba2-525b-4310-72f7-08d6540099cf
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4056
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/21/2018 6:23 PM, Christoph Hellwig wrote:
> Hi all,
>
> this series optimizes a few bits in the block layer and nvme code
> related to polling.
>
> It starts by moving the queue types recently introduce entirely into
> the block layer instead of requiring an indirect call for them.
>
> It then switches nvme and the block layer to only allow polling
> with separate poll queues, which allows us to realize the following
> benefits:
>
>   - poll queues can safely avoid disabling irqs on any locks
>     (we already do that in NVMe, but it isn't 100% kosher as-is)
>   - regular interrupt driven queues can drop the CQ lock entirely,
>     as we won't race for completing CQs
>
> Then we drop the NVMe RDMA code, as it doesn't follow the new mode,
> and remove the nvme multipath polling code including the block hooks
> for it, which didn't make much sense to start with given that we
> started bypassing the multipath code for single controller subsystems
> early on.  Last but not least we enable polling in the block layer
> by default if the underlying driver has poll queues, as that already
> requires explicit user action.
>
> Note that it would be really nice to have polling back for RDMA with
> dedicated poll queues, but that might take a while.  Also based on
> Jens' polling aio patches we could now implement a model in nvmet
> where we have a thread polling both the backend nvme device and
> the RDMA CQs, which might give us some pretty nice performace
> (I know Sagi looked into something similar a while ago).

That's interesting. Can you share more on that ? what is the model 
(thread per core ?)

I'll take a deeper look into polling aio patches from Jens.


>
> A git tree is also available at:
>
>      git://git.infradead.org/users/hch/misc.git nvme-polling
>
> Gitweb:
>
>      http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-polling
