Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA7AC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDD208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="sOleE9mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EDD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeK0LCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:02:14 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:63290
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbeK0LCN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 06:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQOQ4fc3rYoEkdcOrTTfcBYiKSqa5eTMVV03ytHwgm0=;
 b=sOleE9mhaFSdU48NGOFa4ojCcutX1bCVFJrNb+kvC5xVAiX4VdDhpi5Y9zOUAmevbRD0ynPV/IRUSNUgt/3xXWoV9DUFmgf01qf1Ihr80Z3euiZNXy3+oe7UtefUQGwfZenVDOXjr1j6LPoWvhs9hsP5Kc9Rh1FIDbyRk3TYTYI=
Received: from DB6PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:6:14::31) by
 DB6PR0501MB2151.eurprd05.prod.outlook.com (2603:10a6:4:7::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 00:06:12 +0000
Received: from AM5EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by DB6PR05CA0018.outlook.office365.com
 (2603:10a6:6:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.14 via Frontend
 Transport; Tue, 27 Nov 2018 00:06:12 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT022.mail.protection.outlook.com (10.152.16.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Tue, 27 Nov 2018 00:06:11 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 27 Nov 2018 02:06:09
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 27 Nov 2018 02:06:09 +0200
Received: from [172.16.0.177] (172.16.0.177) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 27 Nov 2018 02:05:16
 +0200
Subject: Re: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
 <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
Date:   Tue, 27 Nov 2018 02:05:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.177]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(51444003)(189003)(199004)(8936002)(58126008)(86362001)(81156014)(31696002)(356004)(81166006)(316002)(65826007)(47776003)(478600001)(50466002)(106002)(6116002)(3846002)(110136005)(336012)(5660300001)(16576012)(65806001)(64126003)(6246003)(54906003)(93886005)(2906002)(77096007)(16526019)(31686004)(2870700001)(4326008)(7736002)(305945005)(23676004)(486006)(65956001)(2486003)(67846002)(126002)(476003)(446003)(229853002)(2616005)(26005)(76176011)(106466001)(8676002)(186003)(14444005)(36756003)(11346002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2151;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT022;1:g3D6pcA1xhdpdccn8inrRs7QmQKzEzXadO5UzBIL7zAu9p+SNlHkHRDo16PShjnUe/hqNsa2CgG1X6YZZZn896RC68dAHv9iU1T0LWSQ6ND84bKlbXAGFigEA6NWN0g/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43a48cf1-e066-4e4b-eb07-08d653fc2396
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2151;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2151;3:yLpuSSOtOcKuvYy+TAxA8HH//vmerWFWzjsbfsV32MItW2i/9bOQcgUUhh0tPEMqXAOt4yEU1shRJE8iiPsVCXQfG5h92dkD5qF0OGrgDX2N/lxA91lDKuj2zOKLEyTlRZ6D1isDTnwAHhA9DBD6F/IFKzmNKFd0OxaKdlIzrPKUrIM9prDQlNe5Nbd7/dIh4umNFqkfXeLfKcK5LSHITyfkdT461ESQi8Ld+s510vcHXzkWuURTpA1/CccZ1Y3kbd6DYM50dG8KVBHzdP4R/Q3us4nAQ/2G9oWXtOkP0KR7/q04Dtp1IjC6DUQqUImCdC+R+9TaVLd9yT5k0YO+O6FbytOPphqyo+CbBX3e67A=;25:GGj8LgxQ0nCPc+Kvi2/QFacKVqyPl5z1JDLgH74k4PXbfmFm9T9djfsAK9jipAjkEciKTMQSvMStdjmL9VGfpKw89E1Y8YKJReTp+IZ5d1GMU+sb3ipXlAa4TCaitCRSUEWiVwIlSbUbIKbBjnXsnmhjH3ryf5YI4ocwdnNb9X8/x39yybrFknq6Ii6BIumICVx8JfiGRf9e/2ejScXWZpNqtOivuG9oj7AQMdgAAQGxYWG1+P5zZzvEm5xCdNP3cctCaFRIyuSMi6XMcoZWc6sCbnmBNoj73WFS1hzgqLRb1hxKOp99Ym+vF8Wv6kd3DewZQdHetAX/hnXxraPL9Q==
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2151:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2151;31:t+yacBvnNg+4Uwhp0ufa/upcINH5d7DpDTWZh3yTpEjksjPbcgOHebfZAFWCT0omPGw2u0n55T8FCLosZabp9KxZNEaF/OCyB4gM9llx/1wEBNpJ8eLgZ9YUV1U299FX8vZD66q6BvmxyW0g37iE4Js1uZG0squFcbr6Qz0917MirGkWUf9IQ241bq3DRv/4/LupqXcmRr7oO/FbDk14gPlSKCtIaLtKe/vElbt2h+A=;20:tgzfTrxRU5UnZ8adSGm5r2Zm+WEa8ZIdrgFDyQkKKbdYBzpk/hB2bAweiTx5jA5ENag9cqWWxR+zakd8a/rRrUaXI8WAdZi3XMXFECpSTUMa+CBchhSrhdW5CF6v5mZTIp9RiLPQIYKZcKW6aq+6qT7cm1gEvpJ9cyWy5sNjZ9E/7OORT72m66e6FEQmlBJQjrJ/y5px8pabwDKa0ACqFw7rIBlRrVfk8s1ZXSDQHf4oMo+8A33MgkMZ0CrQUOtuChR2jI37vVBY2nBUp9QpIYuTf/pBMc2gROYqOtuZ9kt9ti21gt4GHxVq6JVHDOq70q7eEJu4eq/EUuCciLzviM4kF2xR3Q0EExNdrxV6oGDyutPpnJsnrAW97Y9XQuWUngQo1Whcko6KVdWVyFYpptXLp6FOXC9Y0LQnAMw2VYR145QzSVWhaPoa06NyIgAzfAV1j3i2ZlYhdW5xtkBHG614+H1h+hHx3tWcc2q5nqB7N7OCAL61t9qSTUBhhefa
X-Microsoft-Antispam-PRVS: <DB6PR0501MB215151A50EF5A5FE07DA49A4B6D00@DB6PR0501MB2151.eurprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231443)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2151;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2151;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2151;4:rhIhyuUd9mPWvQsUHJxIiqFdT+seYvUrIWGU3qgVRwaulyNnJp511m2FQeJGnmi33Vwm070BVMkMefOlhnI4w07F8Igz2KRXdxDKu9aMyzhakAUS9haDHp4WOl4kBmRvgoIeMHNw+sNBSpIMkUIFtqIJ621EI3iZf86QDTh48V9NzbFw4DKck6p/xoLeEmKXfbbvYTSAYK70R+pyZgRzJ/d8pfAxRJikeR8/PL8c/f7eGOv2Gmriz7Hj6RPDVtHmZiJnLZixJQIZddPdZo2THg==
X-Forefront-PRVS: 086943A159
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjIxNTE7MjM6Z2p3djQ4OGQxZ083ZWhoS0JoenYvSk9J?=
 =?utf-8?B?LzdrM0IydER2KzJ0aWdQNDQ3KzNZbktUa3kwUDZudlNjbjdRZVRaRzc5SE1j?=
 =?utf-8?B?UjZlV295cHlqYjR0ejVkUUJkbVFyTXZncXBKMkp1d2VxNW9ESWw1Q2N1NVlw?=
 =?utf-8?B?T1pnNWJVTUxVM1pxN0dYS2JkSDc4ZlJQZjZxeGl1Y1dNV3NUOGNyTjFhTEZ5?=
 =?utf-8?B?b2FVYkpFRjdoSEJVRXEwRkFXQ2pGdzQ4Smg1U2syKzY1Yzh3VEdwZndISGFJ?=
 =?utf-8?B?bFFtOFNlRUtybk4yaDBFVXVKZXQrTjliRUdBUWpLUStNU0w1THJyQ2dEajJC?=
 =?utf-8?B?TEVDcWJaRGpuQzB0b29UbVc3aEVIVkJpQmdGUXVNQWoxYVdtMldkeDNQcGVX?=
 =?utf-8?B?aDl1MU5wVm5PSnVkSlNTMldXMHJ4WmxsWlc5SGI0Ly9McC95WktBZDQ3d3Jx?=
 =?utf-8?B?KzdYRURnVHJvZWJWZmFpaEpMK01Fbk9TOU9PNndUc1owTmg0cEV0QU10eUxK?=
 =?utf-8?B?WHoyd3NpM21iRTZLeXhWOXJmSk9tZTYzbVQ1VzRBOExiM1hJT0dtRFBsNk9C?=
 =?utf-8?B?ZTR1SFhtamFpZHRuUDZKVFRMTGliOWVaM0QzaUZWR2wrWmdKdTJIb3ZMeUhz?=
 =?utf-8?B?VDJFS0trcXd3a2RJOXRQVmtEazc4TjBoQ0FVaU0rRW5TK3lFS3BvZGlnS2FQ?=
 =?utf-8?B?ZkJKOE1sVDFxck9KdnlOSVJRWm5tYkpPcVMyNlFUWkRYRzJDMGgrM0JkR2dQ?=
 =?utf-8?B?MzJ4Qlg2dzZGUzV5eXEwTnY0Z0JqVVlqWHBMRzdmMENsdlhWQmNLWUpPOUxS?=
 =?utf-8?B?WmNQTFh6cmd2QUtCOW0yK2xraXlRclh0bFpvTEozU2NiTEdxc2RIQjVVNGVE?=
 =?utf-8?B?U1JjVGZEd0NidUtLenFST21odEcrS1ZnVHdtNkpsMzF5SnVqSlZLN0l0Tlpj?=
 =?utf-8?B?RjRmYS9QemJCUWllMFhLY2RISU05MFZJRjBtMms3d1BHUVhxRjd4ODIramRW?=
 =?utf-8?B?WFZFUHM2VklJWk9sS3ZwOFRRUE5tTHdSa0pPSnNDNWkxQ3RmdDQ0REhNVk1Z?=
 =?utf-8?B?U0dBSW0ySkpNT3Qra3RkWGl3VmIrU3dESkJRdXJpU2ViQTdnVjNWb3VCQURz?=
 =?utf-8?B?bkk1QXJMRU5NR2VnMW9BaENlZnpxdFVYNHI3N2svcFhsVGpiL1QxYWdQOWNR?=
 =?utf-8?B?dG1xK2VrOWdqcDhMcHVvVlhMWHc2VGhST2R0QTBDUWE4dzlNc2cxclhLZzNp?=
 =?utf-8?B?STZBd0liOG5wS1BNSWVETjJ1L1ZpV1ZLOEI2ZXZ4MWNnWktNVXpMenorUVRC?=
 =?utf-8?B?TjFqOHlLSmNwT2tPbzFNc2hrTkNTek1sUHAwUjNIWDZUT2lhZkNyL2hJOWRJ?=
 =?utf-8?B?L3NXeFV6d3pPTXlIeUFXaTd6VitjbUZrS2VTeXc5VmJCZHQyYWQ3dzJyOGdJ?=
 =?utf-8?B?THdWVXRuMUI3ZUt4alQ5TEk3Sm12RDBiQlJYOHdvekF5b2ZmV28vbHVMck5F?=
 =?utf-8?B?eGl1blZzdmgvOEs5WGRoVUJGL2Z3d0FBSytRbjhxNmhxQnc3L0l3MjJtblBw?=
 =?utf-8?B?aUZmOEZmdkFFYWYvcTR2bGtZS2Z1bENySExSczI1ZjF5cGRrN25FZHFMNGkz?=
 =?utf-8?B?anhSdUZJYUhyZDgrQkdFRHV3UWtKTUNwUVRDWWdlRVFWd25uRk1HWE13M0hj?=
 =?utf-8?B?MHZ4amFEaEZBTXp0UGRIMmF0cldtZ08vR1NMT3hkblJiVytTaEVTZFZqdHRT?=
 =?utf-8?B?cFEyTVVEOEcrZHFrSGpSWlM0UXhvYkVKZVlvMUtzZlk4MnI3VnA1cGZkZS9V?=
 =?utf-8?Q?7dIUiR5wseZ6Y9b?=
X-Microsoft-Antispam-Message-Info: oSlHMNI3ZWw6BpZ72DET59gYAK+xyrelYmcUyYz8A9OM+msoeJaTL96sBASQA22Y3vQoBKUayyZVe2wHpMtwHfCNA9qU0chEIzZk5Jq7cw1ZYy707KboTBchX0hgvmY+2XbLSMo4LCS1qL66/1uQLSE/sRNFIFmyeye7Xt3PrsArqK2UwWBOVwshUaKYORe+teDrVavdqmoB15CRxq7L3tM25NditLrKjsD/DKNIhPkxuDaqCIx2J/LavGVZnnlndLpSNQxQRbIn3zK+q3ZnxkQCpwtw0hY674q3KuMdDYAusVJWsfeZGZJJCEpohHf3ETGzNfImgQVA37qJPvNgzt1Wlpb2wKQ1hlIg+nWmCgY=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2151;6:rkJ2EMOHJ9hjebE4I9URXWh96hdrN5vh7uzpjca44BAR/R680QdCn2x3QWW7jI6Jw8bBzkgNQf1xWaInWQ7ZokQ8xx3J1IPZwApy0iytd53XVyHv3L/t8+LyL0CdZL0+J7POZ8HQ4qTI0nXmgparKsUStF2GviAfodF8Z3HzLgekiUNqxaWgJpjUNzhJ+eTd6lQK0ec+ie+FIIpzWQB58N47od0KfI08UW7qvwQrJ+v/0roIhHJ0ulh/+08g6s25LIcbdP5E9m5mokncksGZSuI9k0r7M/1J/vdgzE//jWdQakBO2Cxjuwgl4J+qehue9JR2yi51rLEjP1zm2Tf9l3vJIrFUNqMUggU+aEnPICwtmFbsyWOu+p20Mn4XEgACitD7U+FXxBBch9Ple1kJeV7aF7tpsPz5v3kG7ev3Xmj9I5/CWW5EzqVcIunyXnbDGOBCXwnl/fehwtIMx4OVTw==;5:4VnyFxub8646FtAw9EzqUbAqGXoQqcuFOZoqXyvsIwuxNdA6DdSovxunz2dOBw+PHW2CBK3V/OT5jQjo/YQSDAaHumjt6THjpfKQs/6zVTkzYQAkdktzwQ5JeeMK4Pex5cYjPc0DpO4AFeDIkUMFNzGtRKeQBHDbW76Ky1txI04=;7:84FP1rWzAXZ1mIvbF4wMbCLUY4QkqAyLaablR0uvKKnwKldS0VRR3JhQEI+maRgyKPDt31wh0aFCUpj+Rf5KDuP9orOz3oMS2By77YLy0u3NCVPYUF1C7zMh/4KQ+zz5qXPkYWShigey/+8ZzuZC+w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2018 00:06:11.1117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a48cf1-e066-4e4b-eb07-08d653fc2396
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2151
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+static enum blk_eh_timer_return
>>> +nvme_tcp_timeout(struct request *rq, bool reserved)
>>> +{
>>> +    struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>>> +    struct nvme_tcp_ctrl *ctrl = req->queue->ctrl;
>>> +    struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>>> +
>>> +    dev_dbg(ctrl->ctrl.device,
>>> +        "queue %d: timeout request %#x type %d\n",
>>> +        nvme_tcp_queue_id(req->queue), rq->tag,
>>> +        pdu->hdr.type);
>>> +
>>> +    if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
>>> +        union nvme_result res = {};
>>> +
>>> +        nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
>>> +        nvme_end_request(rq, NVME_SC_ABORT_REQ, res);
>>> +        return BLK_EH_DONE;
>>
>> This looks odd.  It's not really the timeout handlers job to
>> call nvme_end_request here.
>
> Well.. if we are not yet LIVE, we will not trigger error
> recovery, which means nothing will complete this command so
> something needs to do it...
>
> I think that we need it for rdma too..


yes we do. and we've patches in our pipe.

I'm thinking on a wider change in the error/recovery flows but might 
send it "as is" meanwhile.


>
> ...
>
> The rest of the comments will be addressed in the next submission..
