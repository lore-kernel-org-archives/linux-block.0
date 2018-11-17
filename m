Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4136C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69820815
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Xz1iywte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E69820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeKRJIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 04:08:13 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:40224
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeKRJIN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 04:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyE3ItkC32VpBYlHLVUs3s4q2JSJ9UdfseTCbEmxve4=;
 b=Xz1iywtesVgtp7yzoVX2OOOUhQrf0ro8dbqVnZSL5rIAqbPiNoOHfFWdVVDHrdSM7iOWRO+e0zwmQH0amjwZbEiJ1jVluQgDsWaOfUF14h9Wo/BGi8CQQSHNg8e9oh5DUUooUIHizMcB1OC3NfZS/yNApxaK3Kil7bhXgvme18U=
Received: from VI1PR0502CA0010.eurprd05.prod.outlook.com (2603:10a6:803:1::23)
 by VI1PR0502MB4064.eurprd05.prod.outlook.com (2603:10a6:803:25::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.31; Sat, 17 Nov
 2018 22:49:53 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR0502CA0010.outlook.office365.com
 (2603:10a6:803:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.23 via Frontend
 Transport; Sat, 17 Nov 2018 22:49:53 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Sat, 17 Nov 2018 22:49:53 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 18 Nov 2018 00:49:52
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 18 Nov 2018 00:49:52 +0200
Received: from [172.16.0.166] (172.16.0.166) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 18 Nov 2018 00:48:58
 +0200
Subject: Re: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
To:     David Miller <davem@davemloft.net>, <sagi@lightbitslabs.com>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <netdev@vger.kernel.org>, <hch@lst.de>, <keith.busch@intel.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>
Date:   Sun, 18 Nov 2018 00:48:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181117.121510.1754018619653365187.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.166]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(438002)(3190300001)(189003)(199004)(6116002)(229853002)(2906002)(356004)(8936002)(3260700006)(4326008)(7736002)(53546011)(65956001)(476003)(31696002)(486006)(126002)(65806001)(86362001)(36756003)(5660300001)(3846002)(478600001)(47776003)(2486003)(23676004)(230700001)(106002)(54906003)(6246003)(2616005)(67846002)(336012)(31686004)(110136005)(16576012)(50466002)(65826007)(77096007)(26005)(106466001)(8676002)(76176011)(305945005)(81166006)(81156014)(64126003)(16526019)(58126008)(186003)(446003)(11346002)(316002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB4064;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT027;1:gVaMLIaf52ZVWXingGxzgwokZzLXHG76OhEf25XxFvj4PmN54RqrdKuosrx73NtcR47qN1rCwTRGkeUvDNYwPD/X4yG5U5cdVmS7E96SRcAfa5shdRjc4h+R2OzJzVhL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f3b722-44a9-4f39-8b93-08d64cdefd3a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB4064;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB4064;3:kAXem7Ayy9YdWIxUhGd4gCJKfzdtFLzKdLt+7xTLpPhfQhL0O49fR9v89w4YInDZ2/rb2ePbgcTbYj2dAwRTWS+VniAUKZf4IhheD1fH2Pq7A3ga1tOjwVAU+nXZw+HXmkMDc6xlgZv3wLFNOVPKYBPRVO2DNCCZOX/tXUfCMRWKeqRr8rKx0xYuKqCSlWuOahqDchaN70nbAOe+O+4LdYjiqxIi18yZ+2aInv6ipMYQI9OeS83PSvz1qXC4L+1sk9APEyD4+IeQv9jA0LuQdjQjIyTRl0e27hDYnpR0NxaTB1DWqAANSxTHnj2rXhW65kTfe2EXwj9unpKSHQx290lH96BDB3gWLbxD6Er5Ixs=;25:qDjufSDjG0Glw7iKLSn5tkYO0IivK5Hcbqu7j2LJoL+r51UShbIe5xhJauAH9hE2WMmvPEcm6SS5UDkZ8uYvGgwXGznpfnkl4skpib5rJNvyYDjPYpnU/oYlGmrtIr9CS7jkfmEDuxqsnWyqHnmKhYKOk+WdfX5xyb3RtObLntYzadRChnU7gtfpS6YNiL4tlzFsaQx9IKTfZT/HCFVC9PjGusmbwLGz8w7Pv9OigsxNo9DXSiTBcg3Do8fXDdPtEU9PgTIT6p00HBNFiZY4C0vZxkFItDWXJ1JCmOC1SEcARM/kKfoe/Ol3klNKbmzoXJvahu6fPVyFxscc6KH+qA==
X-MS-TrafficTypeDiagnostic: VI1PR0502MB4064:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB4064;31:CwXcmXl9udV9ZnvnRCZbkMKpphmSoDVQWJw97w3wx5Lme1ZTZcUtLzUEiti8jtFLy3dTt9CNvi3z7Dzg7EfP5zJM0XBtHLkw+9XN51wEW1Xc4ztrNclfs1H07onwS0AK5TrvDpvON+IZqK0xImMK5Rp3HQQRglYbk0twGw20f1L4pFZOL//J/EHqVrMoP5wLaMDcvIMSk5gBqaV4RL+DAG6wSmVvSXRYHhb7lXB5cBQ=;20:ufOiE/jQms7zgAQ+ZGY7Sj+cZeVJJXl8FeakEHl7GcD3MKCIkiIM+g6NjnIa86/3Q+bAoxKQruBNnZVRqc0ojhNOxyyPS1fiTZ1Hj67RQGCd9jXrzvM8ZP8YVC++VB6htVNlVMO7tJ9TVqNlqhMbYTLP0jr7NgNPnFWUnuwGCp+Jz3CbF6EnAtrV7F3UXx1eZv5EDH78bB0VhtnVBaQwAX6HodZmFm7ckilZJG3jGOPDZ9MyD2Nwk63sL9hu7jVyVsfSklQbMGyyqWNsjhGTj8aCUEFJ6AE7JX5AP7o1taua0aVTsSlDfvLLT7LDh5p8MRYwSu/bci1YOLGPDf6o01NgUjnvD+blGg6DA+uyS82vryU8DGyoQLQRFBsVP42BqMu5aLaQjx7EcJHHchk5Dep9ZQLsAkhUYnZ1elR0B1a947eKzyd+QTWnLCbza6L4hto8cgkDDYclyc805ttCiFcCoG0UqGA7NZGV82XFswZn/GGShcE8qdMmHennH1hV
X-Microsoft-Antispam-PRVS: <VI1PR0502MB4064597D387F69E93C63AA5EB6DE0@VI1PR0502MB4064.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0502MB4064;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB4064;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB4064;4:hfxTUobFnxYVmu8yMN4VHdpb2XlHgWe85bbeLsgRBS4OOuUobSShWIX6cR6ZcUWg90QVqLMgvxWeIFvXxh/9rBn8b4ubUQglyfHBoB+AjMEuLqblpFeePa7cj8Jhh4FL+/KAfFyhpFj4GxV9ic2/vuz3VxiclP6zvCE/VHkhqFkcTl8QYAKxQ6KjJFoOOoTOfy40eMlesXweCdm2O597/N0WG5pXdi3V4+jQ44RczdPOGVftLY+iut74yFxt1kehEcsalWoIW8HHQO9ar3YhKg==
X-Forefront-PRVS: 085956473E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDJNQjQwNjQ7MjM6S1lmT2RkU3ZXWW1pSE5VS2xFZkttUEdD?=
 =?utf-8?B?cXEwUmdOdllLY3A1cE9rYk94d0dkNGdrMjlFTGI2UUxLRWQ4NFV3OFFVdEF6?=
 =?utf-8?B?YjNPUkRBbU9VeFhPSDVGQ2trenV4THlSNEpxMDRWVWxsbWFMZytrSmUzVEMx?=
 =?utf-8?B?U0ZPZkJnTjJRd2pvMm5SN25WZXpYZGozMTJGV0xiTjJZcDdqaVZwOXlucHVi?=
 =?utf-8?B?MGNGQnl3QVlUeENTZld2L0wyMnE5Snh5ZzJIcVB0c3BnZWdPTnlHaHVDZU9w?=
 =?utf-8?B?N0RIbDZMWjhzclRlZG9ac295cVZHYVZyRFl5Y1NHaTV1S3k3VHFSejRQVVBy?=
 =?utf-8?B?dlZlNFQ3RkZFWENHZklINTFGYkVkZW52VDRTaENiL1A0N0FobnB4enJQREc1?=
 =?utf-8?B?Z2V1MHlIT1NuUGJ4cW9WTTRyWncyUTI5NDNLanpwd1psMzBWU096bllTc3ZH?=
 =?utf-8?B?d21wb21JNFhhZTBObzFZcGFFdDY0Ti92OGp1aHBVTTNaOFg5THl6Snk1dTE4?=
 =?utf-8?B?UUhSTlQzK1hreUs2SUF4ZUV4c2o2SmwzNXZ5QXBDRDIwZk41YTZoK2M2bUJB?=
 =?utf-8?B?N0cvK01NMjVMNWZhQ2dFRnhoejhoWEluZnNpSzZ1a3ByMDBxelVFcGRVaG45?=
 =?utf-8?B?QmdRMGF4Rm9vcENWUnRKbGgzeEY3UWU1MGZSK0VsMU5GVUFpWjhXT2Nta2Qr?=
 =?utf-8?B?OVR2cDc4WklYc05Qd25XNU9Ga21CSWdOeEg4UkJSWVZUdWRlMkxzWmJ1Rktu?=
 =?utf-8?B?a2FHUE5GNjhhSE9GUFJCdUFLcjZ5K1dITjJBSUFJMlJMWVJjZDZUTFMwaU1O?=
 =?utf-8?B?MUtiM29Kd2ZVLy9hWFh2eUg3dWJMQ2lweFgyOWpwMjZDK2REWWtoa0xDeHBX?=
 =?utf-8?B?QWtLYmd5ckxwMXVPVE1tQ0FrcTVpTi9OSFdtMFlmZHgzTm1vYTVCMFA4YnJn?=
 =?utf-8?B?emNCVXd4WHVJS2dLUktLOUZHcEFjSXg2RytzdnJKcTRUaE1hQ2UzbC9CT3Uy?=
 =?utf-8?B?S1owN0ZTcFgrR2NYTTNGak5OU1ZVVWV6SmlXSjd1QkQreGJxdGF4ZkR6K3pN?=
 =?utf-8?B?ZSsyaU9MdmluRko4aC9FZVBzUzU1S0Y5RW5VQ0dwRUNtWHNPU0Q5dWQ2STU4?=
 =?utf-8?B?ajk3eG1MOHIxeWNrblVsUHJPN01GTHhyMTJOT0xqQ0xTZ2p0cTJHUUhkQzRj?=
 =?utf-8?B?clFtZHZ0bnpvdmlLQ3FHSFFuZURZU05sTXNlTVpady84Wk9zOXJ4YWxmditx?=
 =?utf-8?B?bCtaOTlzSUFnY2QrWFJnWDQ4ZWhLdHU3Qi9vV0Q3WFJFMlE4M01KdEp6UHNZ?=
 =?utf-8?B?bWtFZENEWlNkZC95TWQwb2dhV21yWmRJWkZIajRBZlhHWXo0Slc4SlpwRmE1?=
 =?utf-8?B?RStjdm1uMXFublVDL0NmZ2FFUFlpM3BWZ2g5K1pZclJHcTEzRDQ0K0hTc0Z0?=
 =?utf-8?B?RHM4Z2ljM3lTejg0ZmlwZnFvTGpHbm9pOS90SGZvRlJkK3RidWFCWTc4aUpz?=
 =?utf-8?B?VmtWTzQzVlpoS3JpK3FyOUpkRC9HSVovS0Z6TFlVRTAwME1FdWVWR2RaNGFw?=
 =?utf-8?B?VVBPQzdMSExWT1dSa3d0NUpuOVRBWVN3cnFMWjc4QWo1R1ZvcXk1ai9GK1Rm?=
 =?utf-8?B?ZW5pZGRMeUFOUVpLbk9TUGNhMmtRRVZ1bWV0a2pDTVRKTlRKdHVBMEYxckF2?=
 =?utf-8?B?YTZRRVdSeVhqMWVwV2dpWVZDQTlRZ0paRnN2ZVNacTVSWURZa3d6N091ZUlQ?=
 =?utf-8?B?Q0tYVXY1RVFWVlhySGJxNDh0eFVDVFBBcnJEcEcyRFVzZThQQVJUanAzT3NS?=
 =?utf-8?B?ejlyeS9qenBFV05pZVAwcTJjazkyY3dlOS9peXQ1MXNBUWRPdz09?=
X-Microsoft-Antispam-Message-Info: z8+43ESEYR9Nu/AJEuwHADBjuE8/1XSEGDXdUsWHRv2Cr4/rKzUr2cbnjAx8u1rVwnsXieZlK26+f11oTz4eYig+xb94r+DzmwjJwAHUemsx67r5u/6bSAxJTwHHbfnRx+Zr679fG43Tm2jls33Rs5kDyspCPDjf9FNUAXMAU+4moMOuFx4WShi3vtcVfxs9zkZ3UB09k3RrB2ZFJSya4RmBbaP/nm4L1QrSjFMT//1YqlNSBJESHg/V5Wo4vTwiNrvkt9wTEc7OaaizfgZ48hMjd5cZSoIgZsHbalmOlvGkRtJF0PL30m9Op63qjLxDg2Gn72pz8ZBWaBwCinFEwTVxAPGCWvTy91yH9YCK8b4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB4064;6:s/rHlK0AGB8ZLH/MWBeH2sHEVskNXgoyR84NeWPJszx/crI6Pu4aF4AB5j77GUVCX/shlM/CAOFcXP2CI1m9EwJIDbTnVg6i5bgCtHqtchVJ9rVXNLjM0jomd8WrIO+QqocGZTEO/IfxRVtaGiCNYZTTbI2xfr7oXZ82LsAyXyXQLT0tOZlznr5zRONBjpZwo+ZzpdiZVEJPes8xz+N3TP2EXPfSBZzxNIKqOV21gWGjEABLDjsaUDCiAyYXU6XHYI2g9hZPR72ZXBDp1TcWBSJ2z9IejjCpYPG8WnEE/tTsMPIlTSoZ5HGeNF+ER6HnbwWepXO8/HA1NvPaMVpGO9k3Fi0dNaT/wFse63suRgvEmN/8dQ+4zlxWx2nUjWZ2MQn6FhTY9BqLLl+AyndM4xfb715MenBnFYmDxrNGWVPwj4exBWXdYTURpdSuc9r/dMMvskOm/V5x9JkScO/79g==;5:dhee/4R8YlMKhoJUaK2A3hJ8rgaqpuv6tIZ8TAFNC8sPxc2a+bZYbo5VekyQp0aKQ2snELW6H0CaBrnqRCZWUUwNHxeyk+EqOquNW2UyX6+Kmoi2uGgPq0Wdejrmwcjp92Tm1XQrmNyUpGvKFIpgYUaNw6xr42Uf712GiqPLjno=;7:LKxjkltUoI4la1N68yf0GDJ9bgjELQ4gl8LsUoRHxoz0Yj7fBhcGBAg0BXElvY0dNBr1nvczmyVkP1xyOAQG5OpFRzypFwlcngyKJ0s1TCOS8s3NOEjHEX2L635sbjCQEIzGhdyF4cLyhPwzLJqmvQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2018 22:49:53.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f3b722-44a9-4f39-8b93-08d64cdefd3a
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4064
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/17/2018 10:15 PM, David Miller wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> Date: Thu, 15 Nov 2018 09:16:22 -0800
>
>> +static unsigned nvmet_tcp_recv_budget = 8;
>> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(recv_budget, "recvs budget");
>> +
>> +static unsigned nvmet_tcp_send_budget = 8;
>> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(send_budget, "sends budget");
>> +
>> +static unsigned nvmet_tcp_io_work_budget = 64;
>> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(io_work_budget, "io work budget");
> I strongly suggest moving away from module parameters for this stuff.

agree here.

also, Sagi, can you explain about the performance trade-offs seen during 
your development for these values ?

are they HCA/NIC dependent ?

should send/recv ratio be 1:1 ?

should total/send/recv ratio be 8:1:1 ?


>
> Create a genetlink socket family and allow run time configuration of these knobs
> by the user.
>
> Thanks.
