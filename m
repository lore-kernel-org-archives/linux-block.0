Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3309C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642E1208E7
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YRtXpmH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeK0VSY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:18:24 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:39756
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbeK0VSY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 16:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/pIfQbsq64YiW4u/+puM7mYFEem3HYGI4hGaqGCoHE=;
 b=YRtXpmH4T5dYxIF7lqDOh24sh3HshCX2DNKcYzHkgNA2WlHcM2s+66g+55Q6qz2MSvL0DBYOQxyA1aTojdEo8YdP6yycl7GoPoaD7YQMdF0HnMJ3AyUY9Z0qX7gr79CxSNZx2Us44lqpop/OCyEFgRXcxoyr44/sOKcIE4AmGhc=
Received: from HE1PR05CA0191.eurprd05.prod.outlook.com (2603:10a6:3:f9::15) by
 DB6PR0502MB3013.eurprd05.prod.outlook.com (2603:10a6:4:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 10:20:53 +0000
Received: from VE1EUR03FT038.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by HE1PR05CA0191.outlook.office365.com
 (2603:10a6:3:f9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.14 via Frontend
 Transport; Tue, 27 Nov 2018 10:20:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT038.mail.protection.outlook.com (10.152.19.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Tue, 27 Nov 2018 10:20:51 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 27 Nov 2018 12:20:50
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 27 Nov 2018 12:20:50 +0200
Received: from [172.16.1.70] (172.16.1.70) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 27 Nov 2018 12:20:48
 +0200
Subject: Re: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
 <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
 <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
 <43ad34a0-799d-5f78-a07f-e2c51f64a854@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <6431353b-cacc-55a4-f8f8-696e4bb26bf8@mellanox.com>
Date:   Tue, 27 Nov 2018 12:20:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <43ad34a0-799d-5f78-a07f-e2c51f64a854@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.1.70]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(51444003)(76176011)(305945005)(356004)(6346003)(8676002)(7736002)(81156014)(6116002)(3846002)(86362001)(64126003)(4326008)(53546011)(65956001)(2870700001)(2906002)(229853002)(65806001)(47776003)(316002)(23676004)(65826007)(336012)(2486003)(6246003)(54906003)(110136005)(31696002)(486006)(36756003)(50466002)(186003)(93886005)(106002)(8936002)(81166006)(478600001)(5660300001)(126002)(67846002)(106466001)(16576012)(11346002)(476003)(58126008)(2616005)(77096007)(26005)(14444005)(16526019)(446003)(31686004)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB3013;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT038;1:KuT+wEVKQkLQuM5onDnY3JOiz8mudkP/Aqh0KGa7m1Saj8H8nF2xlFlFBZTcXIWeXrhjLUNHCn42OAUo9EVhW5MpWHmr2q4VA18i6fzFlyYTm2qzj5QcSB3WHxu3NXxk
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fccd6da0-f5cb-48ee-d2cd-08d6545201dc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB3013;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3013;3:VLdbQ/ftTW9bl9sU89azh9wzFL2xHyWNdYFWEU5N3XfbefV52eSRa5hAuq+99tLQse+3Gt/y6ayei1E3CW9byGurZip7BTzBjOHzwGsqkPZv43tv8oqA89RcmPbnXeG0SbDaGZ2HcdawtlrVsP+zJ0rhOUiekoecTG3bpWhRpRoul5GeU9jR8pzbqwjzvqmI09E94kjrxHm6RHJYtskfDo0HLoQ/dzPd9FE8ZFb7TNtv+6Cdzyev/enUAmY1xjEHhy+alhvJNjo+Wj4Z6ddZXMz0UCCU2OfhOXEbbqulYzq33AA4d/2HXWQXB4Bm5pLSkL0eay5xZVYBzRxKoYdwhNPK+O9NOczHsOKJk/sWAHQ=;25:vBHQZG/sw48ZCzE5xVsfjZe+icr/+OzLtOQo53hP85Rwm4vpNmKO1pwGpdZ6hENl/uXfnKazC7lBZVlrBMUspPgpFJWbHsAAIIK8j1osuD2cj374xdUCQ7wLw3zCltZbcsEY5i4oL7mztGFB588M8ZohtJHBXImb3Y1Zhp+VB5sce3onk8ORFNw4XylW/BBi/IZxWFn7kpAjcoUUOZo0tH66Q6HQG09YGlieKnWYP0UEJCQDjuksgxao2+jl7ZrzeFR5t6bsWVPty0r0FosikmmT7ULnr5PY7RgMmyYEAPYJeVd/J7ewFKSmUVS52ln6VL6avf8P9COOCfYllvlwRw==
X-MS-TrafficTypeDiagnostic: DB6PR0502MB3013:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3013;31:4RWj2EhENvqg1h3x+PfrP2yLP/KhCFsBQcS4z10Zehm8OxnqPpmw5+ybyORb/q9ROFZ3ioAj+NERyxMHTlTEZNDRmqz+7o7ZvDaVIQ5wELArNgfMym0u4BeTfY4wdKJA3o410HoSSwZFPaC3mBy9sZxbsyBTg6s5ASFqT/YvbH3sqzG23ILtdhmRA51RW1V3AgqGBy3VfQqVgJeoDrVu2zZ4X5CRQIlv+KifxCnZGLU=;20:DVmBYJ4bzMSt9r22VBjoetNm11skfhU2K9NTHsLuQlbP++2JzFNp9BbzJlgvD66sOIVNKj6n/OpG9vWAUH2GNkJXeOXM01eaP7qYjiPbjeQT1dEY4bmQLRho8+xAGuHae4vvlTfzO1SHG9dh4qKs5HC5IQX2QQDMxaEvmuTY01JbdH00txn89rkkbx8Y9V2XyoAkxcwqhkYcBfzt+4vS6e/5dbpyCPW9gD1y9ZfdgzZkI6LbGwa9WuNgoCUZa+9tmeitk22eAuSwatUXhwIffnZBCKoF8Z2/mBjSfIGsGmChaMIPupIOLHXC6eoHxrNDbUpetCQZEWukAZ63TqZXWcZiwzsC9jPr0JxgVmI39cxiEVxcY70u1PGK/iIZF31bWPYsJKw5Cew/YhUU2MjOxcawXsftuaNtt0om9Nm7jeAqMO4jOUGD9t+/XSUvx/SSxGYSd4OUuUv61+Ug37icXwS809hfAkY+L/EGRtLzFDiSW5jL8Ktd+lkfATaE1rks
X-Microsoft-Antispam-PRVS: <DB6PR0502MB301358FC988F02F32E5A983AB6D00@DB6PR0502MB3013.eurprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB6PR0502MB3013;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB3013;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3013;4:klEIeIQ+uCIg/UOn2/01lOLPO+Qdj8RIshEux/ZhBYuA4mz2jW3scIL3T2gX8+2vBBVYQSu1A81FuyZTC2iSOtfudR/DZc1BbfkPgfrXEylT+sAalS36xfCjIRLSHIoQAJ77W6coNkJUZHDHv0xK1Ud3EuOnCJGzclVNGfbcck9/Q0+PANwnLdDNy+arrMYPXhV5ZPQZnmh8TVcWEpSQHHqRQYf90VB6JZ9s89FHJh+uJieivmYA5E9sCYOdtt/IGBmk14+kQLUlwH5vxP42+w==
X-Forefront-PRVS: 086943A159
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDJNQjMwMTM7MjM6RCtwWHdGVEJjQ09STGJtNTR1bTBKNXhB?=
 =?utf-8?B?UU5walhoUXBBNXhrL2tGRDFNQ24rQTVZalJiM2szVFBhaGRuTmZ6QTdaQ3p2?=
 =?utf-8?B?MGpqZCtJTXYrWkhsdWVrUXN1anpOb1hFaUhjWEpoVHVxRk0zS0tLOUVRL29H?=
 =?utf-8?B?QkhRbE9STnNQQTVmWjNRWFpKNm5rOFlPaEV5NGFDMFU0TTVpdWVDaUxIT3hG?=
 =?utf-8?B?SG1xaUFrVWNPcGQwOStjcmJNVUZjS3FUdzBHbGw1ZUVzQ2pMOWdsWnNsMjJV?=
 =?utf-8?B?TUlubEE1U0RCc3k0WTBsOStpTkR5TEhBV3RuNmw5SCs0QzRkZHJYT04zcXFo?=
 =?utf-8?B?RUtHcEhIQ25iU1pjSEFzR0JocVVEVVlVTHk1cHNGZGRuZi9na1BmRk83SUU4?=
 =?utf-8?B?VGVhcXAraTNKZndPZms5bForTXFIeFQ0NDA1R0creFVHQjZrQnEvRjJ2eXV1?=
 =?utf-8?B?eVNMZkxEVU1LK1R4SHpmazlKMnp1YkJNMkdteS9mbUc3WXZKOWxpTzVQYmJh?=
 =?utf-8?B?NmhjQTVkQmRzYlJVMGU1RVBCR1Q3RVFwMmxEcU5VLzE0eG0vSWNNSmJuSG9x?=
 =?utf-8?B?eHN6MGczajJ2dEQ3MmJncFRuK1VKSDR2U0FsTE1HaDBoamZySmZXazZXQjVv?=
 =?utf-8?B?VlZ4dDVQOXFldWN3RGl4bDllVS9YVGRXWXpTbE93ajgxalB4N09uT2FXMXky?=
 =?utf-8?B?MWNudkxDSGdKNkxOenhNTVJyRVJ3d3E5NUl0M2lXL2Jpb3pjc3JoL3FlQklB?=
 =?utf-8?B?ZDZwRzhMbVVJR2hiNjdzZDlPU0MzZ216REdiazR6SkNTZ0VzOWxOaFhDSEJW?=
 =?utf-8?B?OUpiMzltQ2NEdEpsc2pHTFdueW02SHdKVUNSdUNtVGdzUXk4dng1TGRyaDNi?=
 =?utf-8?B?LzRSc0h3YVdzOTJlMmhUa0VNd296SlRBOVdHL0J5dnYyR2t3ODNJOVVqb1lX?=
 =?utf-8?B?UDVUeVdIeUhlTU85S1REa0xXYVBpU3M2T0ZTQUJlbUFwSG85YURlVUJDWFQ2?=
 =?utf-8?B?U256NWJiVVZzcGxmZEIwUW93MzFCZVJrYW1vUGQyS2hoQ3FNZnAvUlZWbFNN?=
 =?utf-8?B?dXJrb2hVOU10YWRZVDk5T2tiUEJHNk1FM1VHMmdDbG95enZkMFYyRDR3TTlR?=
 =?utf-8?B?YUNGUitpMmprUEpqRUl5b3ZJVlVFR2VIcXJnYW03emZsNFdSdU5oS0E3YVpm?=
 =?utf-8?B?bWlkdVdqdFZlQ1NkZCtiY1Ntdno3KzhmdTJVZlRyallXaEQ5ajNPdWx4ak9B?=
 =?utf-8?B?d28rbW9Jdkd2RmRsQk56dDlaUXdJZEl0dW04NXFINVpPVXZLdTNXT2dKKzQ1?=
 =?utf-8?B?WlhrWjNwMnVuSGw5REZXUDJYdEQ0VStnMGh6TkFhMm1lM1NOQUN6S0FPN1d0?=
 =?utf-8?B?UVJmdEhHR1pRSlYvbE5UVEh2dFdTb0hNWGxwS2phY09aMVdwRFlvdWJGUTRl?=
 =?utf-8?B?bW5yV0h2bi8wZzVQYVhIcnlLSVVFOHVWSXMyZ2lVeXlXb0hXektUQis5U3VL?=
 =?utf-8?B?Z3hsejlwMVZoUjhHMFZ1dDQyaGtWNVJpdkNHKzllTVlPQlVDQjRJNGdSWlZL?=
 =?utf-8?B?Y3dUNjJWRW4vVDcrMG13bG92Ny84SDM5V1lZL2p6WWZ1Qk1LUHNFbEZVV1M5?=
 =?utf-8?B?S2hZcWgwelNWSlRvKzdJNDZBbmRicXlFTkVvTXFKRklLUnBsU2pKVUhaNXlj?=
 =?utf-8?B?bVNRdTJqZngzYWpFUi9lZ05kU0FhWkFXamFKU3FuN3FJWFNKajBReG4ycUdR?=
 =?utf-8?B?YVpPNHdtdGY2aEhSWWZiWWYyRU5ZL21QZXhwZnZTakhIZmN1VnNFQmlsbzdP?=
 =?utf-8?B?SHRMZ3RVcVpsRnluOVpqS09NS0NiRGlqOEk1cTBhZkwvSzg4SlNtZFhCaGFy?=
 =?utf-8?Q?odG1XGPdwxjkY=3D?=
X-Microsoft-Antispam-Message-Info: AqpO/XC/51D6P19xqtce4UkcF5EgsK1P0iNBAGMKFJKoeaTdo6qWGcKwHlCiJHeX2uQwd649VF4HULq82ZV5bVDjXtlp6WN1lgvTJxkYuz+FpsNLUmfH3c0xmvaXko5rUu91p1jV2WiHWNy8MEfLm9fnixh/RtucXLMXNirrVZRnEielbCkp4hpEJl7wjxZ9PH1NR69KHBMownCEsw94a2JBoDmJY1C6xzJxiTWUo6Nxnt9oOa2i7k290Iex/Xw+pgP6hat3CneUVjf/iMscIWFp1FPf5CxNMw7Yji8ltN3BhmyD/iLu80YYVKWnl/YS7nMcnDI22yt43IaScaCOz5X1VSbfZddxLcUVhDwI2mw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3013;6:gMQtKvqcYL7GWVCHuVBQ7qAYH0Wp3CjsA+FPLcvElUjCR4r+XRDwP9gKOons158RSd0Xy/HDhRgp97+n9I4u+koQHMAl9FTX7HIVwmwkl6TrrCyr/eeh7FB8m0ceDJ61KIQ3h3qNaBkTIjqYQ6WQIAgo4FUEZ70S8Nrboh5jvt9qJ5WDcxXZbKnX7YIBvS2cdDri1fN2mLJ2CF710jX7AtMEEsMzrLCzi07x2ksGMkOVW91M1/sQaC20ryON3WpovIwmiquLWpUl9qEYByHUvezcf4OgG4P6QP5eGcj5a8cbIiFYPPPoRYG+htDCqbw7AJ8fpIsqaigCZAmrdE3HHH20Ys0ATvTDwuBM9/CawWCmzS8nvEgQV0Em/B6rFpXwDPhiImt6SYQxwZ75REt40rKQCS6N8Ceap5YzvIxAvx2BQOZsRrWEbMGH+L0uFvh/I8mpQRZrEIR/JaAu55mT0A==;5:pMDXj+IgQQIEWc8kQAsfhSuDfUSaHSrpJMPsYQszug7BkcoBHspmT8LOBD/2iP0KvCpbqixz05Gi6hlqxooMm2JUlBAqQ7n9T9vSSpG6m60tK3rEcHKkcFtrqwrIKNwxeJDTpMYrJZWCs4n7Ndl+ikWpFdMJz8rJy8ixJIPNjIM=;7:Zbpo7vqQ4+opADjOASN0Xuof3PVY7cSwHUjQ+n93BQEp3nPzyxK5Ca96EOYf6tQPMpFsDp/BfMZPu2Qpl+t4yi7n9bVravJeQ/GB1S5X6L+etqYu9MLkFHeI2XyXIptl0tFdt1vswYSimVeznT6iZA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2018 10:20:51.1523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccd6da0-f5cb-48ee-d2cd-08d6545201dc
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB3013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/27/2018 9:48 AM, Sagi Grimberg wrote:
>
>>>> This looks odd.  It's not really the timeout handlers job to
>>>> call nvme_end_request here.
>>>
>>> Well.. if we are not yet LIVE, we will not trigger error
>>> recovery, which means nothing will complete this command so
>>> something needs to do it...
>>>
>>> I think that we need it for rdma too..
>>
>>
>> yes we do. and we've patches in our pipe.
>>
>> I'm thinking on a wider change in the error/recovery flows but might 
>> send it "as is" meanwhile.
>
> I have it too in the pipe. Do you want to send it out or should I?


go for it. We've several patches that are under testing and review 
currently.

