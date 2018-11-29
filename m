Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF7CC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 00:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CA62081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 00:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TYRBZ8fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CA62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeK2LT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:19:58 -0500
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:11392
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeK2LT6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 06:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwTVImYd8mrtVu0gepbmpZXvOu0cJa2EmgS2VxFpkj4=;
 b=TYRBZ8fc9u67e40bVLN4R72zHegWRrMfh8fQYPZxcvd/7cAASEwx/o6IURAkWCRDF1Tez8SV2RocuvrnGWRkrBNNpKdSHX50RAXvijzHGqxGSm3JRj7qT1SvjdvmmQM1gT4sIOY3yDqeJIre8GZpanBSI1oth2MhDuULn74CvLg=
Received: from HE1PR05CA0343.eurprd05.prod.outlook.com (2603:10a6:7:92::38) by
 HE1PR0502MB3019.eurprd05.prod.outlook.com (2603:10a6:3:d9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 29 Nov 2018 00:16:26 +0000
Received: from AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by HE1PR05CA0343.outlook.office365.com
 (2603:10a6:7:92::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.15 via Frontend
 Transport; Thu, 29 Nov 2018 00:16:26 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT032.mail.protection.outlook.com (10.152.16.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Thu, 29 Nov 2018 00:16:24 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 29 Nov 2018 02:16:23
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 29 Nov 2018 02:16:23 +0200
Received: from [172.16.0.142] (172.16.0.142) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 29 Nov 2018 02:16:21
 +0200
Subject: Re: [PATCH v4 11/13] nvmet-tcp: add NVMe over TCP target driver
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <netdev@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181127231615.9446-12-sagi@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>
Date:   Thu, 29 Nov 2018 02:16:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181127231615.9446-12-sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.142]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(51234002)(2616005)(478600001)(476003)(11346002)(446003)(486006)(36756003)(5660300001)(126002)(65826007)(356004)(229853002)(305945005)(336012)(7736002)(76176011)(16526019)(4326008)(2486003)(23676004)(77096007)(186003)(26005)(64126003)(14444005)(50466002)(31696002)(67846002)(86362001)(47776003)(65806001)(65956001)(8936002)(81166006)(81156014)(6246003)(8676002)(106466001)(3846002)(6116002)(54906003)(110136005)(58126008)(316002)(16576012)(106002)(2906002)(230700001)(31686004)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3019;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT032;1:43eaKZFeoxY57a2v1JyAUQjU5SmOhRelLqSCz8iFojv2BCIn+EQnYZrv07aCSFh9l8eOqCa5hicuHvDHwtkOGa2E75SjeT+DOmrZDsorkxqn1RBbhrFepiWLp5TTfdzP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc824abf-d0d3-453a-5453-08d6558fe629
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3019;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3019;3:D7cKJiAsdwyeT8JwggloTEV5RwhpWQ3W3C71c1ZscuMsVj8fxiSWZApYPhN/Ctl8ZeZp8iMUCzqXYugxnL3CouYuVsC/XDWhpQCreWd86WB6gVtRcTAM/m28rajbV3dv5z/rqgiYKbdyNwApuR9f9x4ZPWDSGcscjDLR682B83ZCTG8ElrL78QShrJpMuj+eJABS0eZmrQmkFySP9AVvT8nWIMBUvxoncLmJDYBYBcRjMOvyCHIhCHBZU4VdEU5YNzUROR9A+5h2A7GMD54hTRtC9oxfh+S2Sc0w6lFWY0w6kfq/8sUB81IWhbMlNz/HgW+MnXsZJdB1HRRvAvIjW/Cs1R9wRNPUJyHYGnR+IO8=;25:SFB+L3LUgmfInp3N8wqtaHBaLLY3AdvJiEqjzOkwd6U3RUV6/2/Qu0Imj95WeHfcULBa3MD5I1YSDuVO99tM+fR/SxI7E2yZOn8jLRADgFyJLPuyaClTa0lM4Pn91R+Cd3aMsQbNqV3Ji/N/hYPx4fuRbVkd9pUpNWeclwX8Oi3W0j7hWTzBsA6TvRx4dIjPkpvtTStWSY/87//XZr60alsIJzzQsTLPfYwnlp3eQqTaTvedHF+rIbaVFOOy1hLLJRZ1Cwq1Yv8m5FQOv7rZ8pnQfTYNxp77d9l/vqj9fgbUAIAE3qWDUMTQTXYQgtcW3Le76u3q/LHOA0lYG98gFQ==
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3019:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3019;31:+rBJmnmSpUeY5PrkgIyum5McOWb4aPNxVCIc9FtJCSDpmTBb09VkrDNAadzuoeTr5PexcNNidNOU32aJaIvTYS3ZhBwJPyepFjTpW3dy1MmQmzRlXR+A2huJPYPq0LZfSXnUBK4T8Oa+zsRCKHY5zJTEx9yWMD76E6Oz8EMF/+SIfNrV14ZXPqc1BInHjiEDgLcrUS8v4GN/u1r4JkHqN5Y6I3YKBL1kRDDr6byeTLo=;20:RWgmN2nym8mIZ2HoKquDvZwDHlFeL+0MUVDAAUu0mSJ30A3dlYkDEfJM4PRfDtYKjeJgHsrHy0Xm0uKKYJtkHM133DBkl3UY+M9NKaqvZaj/J+qb8T0KErmwiFUD7psLZMT7299G1chDBeO/YXtWvaPLYY2Faga0IcrxZ1nHqGLT4tLQk9lai4y5y7tjkzHfp9Lh1VOvTGt9vCSsTbxVpJhUiKw3UuSSrkICcf8p5qu+kZY1FmJnsSPA33+ZNXZ50ealusAg7rrGdRQCry37XLi/u25hGMlExUxzemHYh4HAN/ADBuWLHGhGwKoNCt1sP1jrxCqR1hegus65F2lrqztPguNWc5V5w/EYbes6p/ispZo2TqHbVXC/M0ZEwsEDLKTdZWD3X8MTwUvmZRz7n+c1Pi8tFuOLhUncDEcjdSiS2bJ5A5HPTQJT9N3MSib/GL61U11wZwNftxi1PMe/YDIjqZNzOxNm1HosxKopd+BZbTitt5yt939w2w00JUem
X-Microsoft-Antispam-PRVS: <HE1PR0502MB30199613CA97D6FB9490D39DB6D20@HE1PR0502MB3019.eurprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(999002)(944501410)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0502MB3019;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3019;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3019;4:hKMb7+DZjSPcYtC9XxDSNPy78ZEtKh7oBR8jcFyrp749U/JfUMWRVxd6s0LIPGNnkYieQ1aad0GAYLi90lG4oRA0+tMWN/+2Cnd1ex2Xq9xQGZ+aFF6zJtuwayaF9g+PXGEZqNv1tJgzAE25SlIc+61hbH6kEOBnkU5Pn5jZohm84qHioZSLZUtpoO3ZgzXQwaC4z6MSK5akZT9n6Q5JOKqGD67sIQvJVlZSWgz1iodQvvkk+fr32T/vHCRdMUjb+4+2PX5DHku9N4nEXFEyRQ==
X-Forefront-PRVS: 0871917CDA
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1MDJNQjMwMTk7MjM6NDR6RGhsMGFUMWQ0MDc1Tm1VbUc1RWhB?=
 =?utf-8?B?YVRQM2pLWlJpczc0RmU2SUF0RW4xdVQzNitzZ3g4dkdUZXFvazNFZm9hQ1E1?=
 =?utf-8?B?SjFuN3kwMlUrU3duUURCSWxFem5OZTdzUkx2dG9qdEYrVGV5OWNld3c3d3RP?=
 =?utf-8?B?S3haWlh2RmpKanJQaEt0OUpRU0RwcG92Y1BGem90aWNNSTVoQW5aaW5oY09p?=
 =?utf-8?B?UnBQTFVjNlZnV3dLQk5mOVhZcHN0N3d0dFFqa0x3eHNHaFhQbnF6Y1RZWE10?=
 =?utf-8?B?anBNQlFEWTd4SW81WlVlazB4UFpiV1ZHeE93bEw3cndsc0VDQk5BUkhEWjkr?=
 =?utf-8?B?ZVlpa2xjMm1CTm1zSkNwakdKQ1hsNVJUNEhVR1dPTTYvZVcvd0tQby9KSE9J?=
 =?utf-8?B?YzlFZjFYZUZjWElqY1pKUDk3S0FueTcxYzQzVHJyNXRFaC9YR1pRM3p0SVlp?=
 =?utf-8?B?YlVFMlZ3Z3hYQTZNNUFVbDYxS3FoMEhUQWRNWkl6ak1OL01BZTNIQTIwZDV2?=
 =?utf-8?B?WDR0L2p6aGpKcnNXQURTMVlmVGdGMzJvSEM4RE1EcURGaDFnbE1XQ2F5dFlp?=
 =?utf-8?B?ME9LYTJFVmN6b2pMbnUwNjR2ajZsazkzQlFjNllrKzJHM1ZFdFZham4yRGlr?=
 =?utf-8?B?ZUhGbUhFaGZmbE9mbmlJZ3cyWnlpRFo3NjhYVmg5YkpPcG1UOXFHelA5ZmpW?=
 =?utf-8?B?MnloVDJzSi9PMnNUWC9iSXhyQ2g4MDU2Qmo2Y2JZQlpMbGRrL2puaC95ZWc0?=
 =?utf-8?B?R3NNcTJpRmljNkd4M1hPY2crNGxzVjJiWG1Za2hkZnVEOGFtdEVRZEtuck5K?=
 =?utf-8?B?cnIrRjJRVkJxQ0lYc0lzN084VFc3VUxCYm5oc09ZUy9hcDRYeGc2c1dXWFhI?=
 =?utf-8?B?NGtEOEwzUHdseE9BK3VxTlplUnFQY0trYnZXOFhSdWdRa2xpZ2J0VWpTY21I?=
 =?utf-8?B?cm9acmQ0cHM2OCtlK3ZkeDdDRWFCMnR3NklmVVNRTTB4RGVYMDNzUTlxRzkv?=
 =?utf-8?B?WFpXNE5PL3M1SFJGcXB5elJLc2V6cnB2OGhsTlprVjIxZG12ZGJobzdyNTVt?=
 =?utf-8?B?S1NFUk9yaXArbjV6QTRsQnFKUE1IakhQL3NNYlcxellDNS8zYnJvWkYxSFBL?=
 =?utf-8?B?a2xJTkZ3d0JaL0pGYUlyVnVpd0Ivd0hjWTBQWVZBZUd0R2hOdmUwK3BVU1VD?=
 =?utf-8?B?QzJHNG1sQWFrMkh3TU81b01RNkxDM1ROaEY2RHJ3ZThWWnZobkE0YVlZZGJJ?=
 =?utf-8?B?TnNJQ2tjd29INGhUYUk2Y0todS8yMTNYUWV3dzdEeW4ySWFlRzA1R3lnRTZr?=
 =?utf-8?B?V0NPQTRreTdnMHdwT0lKVEd1UXhBWVhXSXArU1gwY1hRSXlyalhNQTRkY0dt?=
 =?utf-8?B?NXgyQWVMWkk5TnphWi9uVm5mNlBRbTV5SkRNWGIrTUxCVTAvd0lxTkYwdW9P?=
 =?utf-8?B?djRnTzlLekNLU1M3eTR3eFlNdGRWUG8xMVgzcm9PSlVxblVOUytEUUMzWEtq?=
 =?utf-8?B?NUEzU0M0SkNyOGpwTUErSkVLTkpvbFc5VGpYQk5lNkxWeGU3MzNJQmI2Z3dR?=
 =?utf-8?B?U0lTTmZYOExkdkZZYnBSbk4wYU8wNVI3UDNKN1BJc2JUaWhKZzJ2NUZkaWt0?=
 =?utf-8?B?RS9BYlppb1lKcytFMDBnNDJBdmpkY0RzS0NHZjU1ZHRkd1IraTJVUm9YRGxW?=
 =?utf-8?B?YzFsZUx1TXBzeXo3UzdNaFhidW5zdEFtc0dtMXJRNkEvN0ZTbUo5QmRkaFk5?=
 =?utf-8?Q?yLHAghZhYv9CyrLkk6c0s470AsmZOga0ZFSNEVQ=3D?=
X-Microsoft-Antispam-Message-Info: jN2X1G1MAUfiZ38hoTELC8KM6fEq1ObdASuP0qKhC+tG87QoDIINTU+6Lpqa3rDIQsc0ryuhcDYKP1ItL1320wY/PZa5ujABWvV+9kAtEAAJPKQRS2Mmlx0s2hwpSwiWGYuY6mccl9Aff0r4BXXl9PHPT5uQ9jHB/XfMIcmSOUFmGl7zD3CCpAYysTgCGsVrL1ZpBoZCJWNVWm5HQqhgVcrQJPg4k33rs3GkCpI0/PDnzsLcuAs0UXq5ZLJy6OeQKCfoEveN96zt9M9XEYXtSMNjqecBp09gZVJhle/rMsLGpeHBHdnCEtKTN3cmGnO4lWw661RaR/ATTOIqMdPAJtvvmmoH0GR700hOCT4Zbks=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0502MB3019;6:NKpkFLi68pWrQKB7h6TcO+d1Wql7ySIm9d3ss89PeCH1q1xmqRZVPdzhzzfmNYpw+rIZrqer7HYfvm6/QiSLpkjlknROtrxlkMtCB8VN8bnwjRcKcHvDSl9ijZ6quVwSV4ivBPU+RoOfWVrR+9BMJm1LcygZ5yMVVFcI0Hp87Zxu8Qe7CCuQhPtYQY/xf/ABO3pvGbBky5wSi2RrLB6+/hnIkb5NHAhiZxDGQ4XnFDr97YRR/mjWzncHU2dX4AOD8QeBAW7z4/xO01yW6Atf9t1weyFjt78GtNSYFDvRzmvlOOTe2m3n+gdrvSVmGpAtfCh/5scBjEfBcPLuk5ca7FhJFzosQcPJDizA8TUNyiTuD/JFyg+RdL4Q+bfpVDHkjLl2Zd2+OP7CzNGVqZyaXOUiy3CjyMWkXBM6erRNzcIOQZhyegcWFJDnxaW9ymUKRR0CQkDG4Ou2kVwPACs+yA==;5:QHnr/zwqjC6lD9m2G5QTtTcVVfFyp96usg7RA70LxX+m7QqAGOpNvEIQGpr2DQmvGYq8siLZfP7+sDszG4+UVkIFVFCrIHMdiac2FlR1RzdNGTlXx8K/9lzu54Ukm6vz881VFhTl6xUEbQngeVii02ZJCBcrRv9YuCUoQLkdSfw=;7:h9O2YbfeLxCX6JupO4Eipp8suNa546HRTNuCJbVGiecv9XtA2j1jwpX/sGTLRQkWLwElbgV51yTZt3Ejc0/yhCjo+887mGXNXXIa9+KyxHmL8b2T9GDV8fg4p6Ee8YsT8ES1IDymrcLW07lXz9s6Sg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2018 00:16:24.6843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc824abf-d0d3-453a-5453-08d6558fe629
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi Sagi,


> +static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
> +{
> +	if (unlikely(cmd == &cmd->queue->connect))
> +		return;

if you don't return connect cmd to the list please don't add it to it in 
the first place (during alloc_cmd). and if you use it once, we might 
think of a cleaner/readable way to do it.

why there is a difference between regular cmd and connect_cmd ? can't 
you increase the nr_cmds by 1 and not distinguish between the two types ?

> +
> +	list_add_tail(&cmd->entry, &cmd->queue->free_list);
> +}
> +
> +static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
> +{
> +	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
> +}
> +
> +static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
> +{
> +	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
> +}
> +
> +static inline void nvmet_tcp_hdgst(struct ahash_request *hash,
> +		void *pdu, size_t len)
> +{
> +	struct scatterlist sg;
> +
> +	sg_init_one(&sg, pdu, len);
> +	ahash_request_set_crypt(hash, &sg, pdu + len, len);
> +	crypto_ahash_digest(hash);
> +}
> +
> +static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
> +	void *pdu, size_t len)
> +{
> +	struct nvme_tcp_hdr *hdr = pdu;
> +	__le32 recv_digest;
> +	__le32 exp_digest;
> +
> +	if (unlikely(!(hdr->flags & NVME_TCP_F_HDGST))) {
> +		pr_err("queue %d: header digest enabled but no header digest\n",
> +			queue->idx);
> +		return -EPROTO;
> +	}
> +
> +	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> +	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
> +	exp_digest = *(__le32 *)(pdu + hdr->hlen);
> +	if (recv_digest != exp_digest) {
> +		pr_err("queue %d: header digest error: recv %#x expected %#x\n",
> +			queue->idx, le32_to_cpu(recv_digest),
> +			le32_to_cpu(exp_digest));
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
> +{
> +	struct nvme_tcp_hdr *hdr = pdu;
> +	u8 digest_len = nvmet_tcp_hdgst_len(queue);
> +	u32 len;
> +
> +	len = le32_to_cpu(hdr->plen) - hdr->hlen -
> +		(hdr->flags & NVME_TCP_F_HDGST ? digest_len : 0);
> +
> +	if (unlikely(len && !(hdr->flags & NVME_TCP_F_DDGST))) {
> +		pr_err("queue %d: data digest flag is cleared\n", queue->idx);
> +		return -EPROTO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	sg = &cmd->req.sg[cmd->sg_idx];
> +
> +	for (i = 0; i < cmd->nr_mapped; i++)
> +		kunmap(sg_page(&sg[i]));
> +}
> +
> +static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct kvec *iov = cmd->iov;
> +	struct scatterlist *sg;
> +	u32 length, offset, sg_offset;
> +
> +	length = cmd->pdu_len;
> +	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
> +	offset = cmd->rbytes_done;
> +	cmd->sg_idx = DIV_ROUND_UP(offset, PAGE_SIZE);
> +	sg_offset = offset % PAGE_SIZE;
> +	sg = &cmd->req.sg[cmd->sg_idx];
> +
> +	while (length) {
> +		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
> +
> +		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
> +		iov->iov_len = iov_len;
> +
> +		length -= iov_len;
> +		sg = sg_next(sg);
> +		iov++;
> +	}
> +
> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
> +		cmd->nr_mapped, cmd->pdu_len);
> +}
> +
> +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
> +{
> +	queue->rcv_state = NVMET_TCP_RECV_ERR;
> +	if (queue->nvme_sq.ctrl)
> +		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
> +	else
> +		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
> +}
> +
> +static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
> +	u32 len = le32_to_cpu(sgl->length);
> +
> +	if (!cmd->req.data_len)
> +		return 0;
> +
> +	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
> +			  NVME_SGL_FMT_OFFSET)) {
> +		if (!nvme_is_write(cmd->req.cmd))
> +			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +
> +		if (len > cmd->req.port->inline_data_size)
> +			return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
> +		cmd->pdu_len = len;
> +	}
> +	cmd->req.transfer_len += len;
> +
> +	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
> +	if (!cmd->req.sg)
> +		return NVME_SC_INTERNAL;
> +	cmd->cur_sg = cmd->req.sg;
> +
> +	if (nvmet_tcp_has_data_in(cmd)) {
> +		cmd->iov = kmalloc_array(cmd->req.sg_cnt,
> +				sizeof(*cmd->iov), GFP_KERNEL);
> +		if (!cmd->iov)
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	sgl_free(cmd->req.sg);
> +	return NVME_SC_INTERNAL;
> +}
> +
> +static void nvmet_tcp_ddgst(struct ahash_request *hash,
> +		struct nvmet_tcp_cmd *cmd)
> +{
> +	ahash_request_set_crypt(hash, cmd->req.sg,
> +		(void *)&cmd->exp_ddgst, cmd->req.transfer_len);
> +	crypto_ahash_digest(hash);
> +}
> +
> +static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
> +	struct nvmet_tcp_queue *queue = cmd->queue;
> +	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
> +	u8 ddgst = nvmet_tcp_ddgst_len(cmd->queue);
> +
> +	cmd->offset = 0;
> +	cmd->state = NVMET_TCP_SEND_DATA_PDU;
> +
> +	pdu->hdr.type = nvme_tcp_c2h_data;
> +	pdu->hdr.flags = NVME_TCP_F_DATA_LAST;
> +	pdu->hdr.hlen = sizeof(*pdu);
> +	pdu->hdr.pdo = pdu->hdr.hlen + hdgst;
> +	pdu->hdr.plen =
> +		cpu_to_le32(pdu->hdr.hlen + hdgst +
> +				cmd->req.transfer_len + ddgst);
> +	pdu->command_id = cmd->req.rsp->command_id;
> +	pdu->data_length = cpu_to_le32(cmd->req.transfer_len);
> +	pdu->data_offset = cpu_to_le32(cmd->wbytes_done);
> +
> +	if (queue->data_digest) {
> +		pdu->hdr.flags |= NVME_TCP_F_DDGST;
> +		nvmet_tcp_ddgst(queue->snd_hash, cmd);
> +	}
> +
> +	if (cmd->queue->hdr_digest) {
> +		pdu->hdr.flags |= NVME_TCP_F_HDGST;
> +		nvmet_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> +	}
> +}
> +
>
snip


> +static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> +		struct socket *newsock)
> +{
> +	struct nvmet_tcp_queue *queue;
> +	int ret;
> +
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
> +	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	queue->sock = newsock;
> +	queue->port = port;
> +	queue->nr_cmds = 0;
> +	spin_lock_init(&queue->state_lock);
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	INIT_LIST_HEAD(&queue->free_list);
> +	init_llist_head(&queue->resp_list);
> +	INIT_LIST_HEAD(&queue->resp_send_list);
> +
> +	queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
> +	if (queue->idx < 0) {
> +		ret = queue->idx;
> +		goto out_free_queue;
> +	}
> +
> +	ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
> +	if (ret)
> +		goto out_ida_remove;
> +
> +	ret = nvmet_sq_init(&queue->nvme_sq);
> +	if (ret)
> +		goto out_ida_remove;

please add a goto free_connect_cmd:

nvmet_tcp_free_cmd(&queue->connect);

to avoid memory leak in error flow.

> +
> +	port->last_cpu = cpumask_next_wrap(port->last_cpu,
> +				cpu_online_mask, -1, false);
> +	queue->cpu = port->last_cpu;
> +	nvmet_prepare_receive_pdu(queue);
> +
> +	mutex_lock(&nvmet_tcp_queue_mutex);
> +	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
> +	mutex_unlock(&nvmet_tcp_queue_mutex);
> +
> +	ret = nvmet_tcp_set_queue_sock(queue);
> +	if (ret)
> +		goto out_destroy_sq;
> +
> +	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +
> +	return 0;
> +out_destroy_sq:
> +	mutex_lock(&nvmet_tcp_queue_mutex);
> +	list_del_init(&queue->queue_list);
> +	mutex_unlock(&nvmet_tcp_queue_mutex);
> +	nvmet_sq_destroy(&queue->nvme_sq);
> +out_ida_remove:
> +	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
> +out_free_queue:
> +	kfree(queue);
> +	return ret;
> +}
> +
>
