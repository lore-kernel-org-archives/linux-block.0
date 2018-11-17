Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4AAC43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41DF20817
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LaVSyHxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41DF20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeKRI6n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:58:43 -0500
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:4944
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeKRI6m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jG7QLVBplqADgBVpWHj+wc5OC5iSL6jp9B71im94BY=;
 b=LaVSyHxWm/pzhrxdLL0DCF0sDrr48Sm0ayvbnP+Z/Ge5WRwq46Iep4ljyR1TFxk0WcvNvpkOJJIYzqUH24MfyP+KFxg2SDXe575RaY+D+ANdeUj4t9Ppb/i6bTLEK/AAi30S4PedT3JseveXqTwa8QfMpRTleicKbXJkLnlvEVk=
Received: from VI1PR0501CA0008.eurprd05.prod.outlook.com
 (2603:10a6:800:92::18) by HE1PR0501MB2156.eurprd05.prod.outlook.com
 (2603:10a6:3:36::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.45; Sat, 17 Nov
 2018 22:38:33 +0000
Received: from AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR0501CA0008.outlook.office365.com
 (2603:10a6:800:92::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Sat, 17 Nov 2018 22:38:33 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT019.mail.protection.outlook.com (10.152.16.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Sat, 17 Nov 2018 22:38:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 18 Nov 2018 00:38:31
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 18 Nov 2018 00:38:31 +0200
Received: from [172.16.0.166] (172.16.0.166) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 18 Nov 2018 00:38:30
 +0200
Subject: Re: [PATCH 06/11] nvmet: allow configfs tcp trtype configuration
To:     Sagi Grimberg <sagi@lightbitslabs.com>,
        <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <netdev@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-7-sagi@lightbitslabs.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <12c83c06-4839-734d-15bf-6225b38938b6@mellanox.com>
Date:   Sun, 18 Nov 2018 00:38:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115171626.9306-7-sagi@lightbitslabs.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.166]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(438002)(3190300001)(189003)(199004)(4326008)(478600001)(229853002)(81166006)(8936002)(3260700006)(76176011)(2906002)(106002)(6246003)(81156014)(230700001)(36756003)(8676002)(3846002)(6116002)(316002)(58126008)(54906003)(110136005)(16576012)(50466002)(126002)(31696002)(186003)(31686004)(16526019)(86362001)(106466001)(486006)(64126003)(65806001)(77096007)(65956001)(26005)(65826007)(336012)(476003)(11346002)(446003)(356004)(7736002)(67846002)(5660300001)(53546011)(47776003)(2486003)(23676004)(305945005)(2616005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2156;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT019;1:Fx5FgDb7MemHA/0OnfqY4vHWUg5EIq250nvlQ0v3Yr/vF1nRyrtbDu77Oa7QzRFqG37debdVREiL1WT0GPtcNWvqXvBIIm4ocQ26fpFyA/no13NEq5bVyMZ65e8qWkCy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fcf2103-d661-4f04-6724-08d64cdd676c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2156;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2156;3:181nkJj8/PIC5MxKJ2JB3VLMdxua3Ll/8QnalpPtO1pDGVUjqMN3nCd+CaW2+/JDt6Fo/QaSHTAqDfZ6G0pxmfG5S6NG/BloRBokPCML0PNMP10trQkm1ovgn7cPOHXoy72/M+/MzxpV3FPBE+axzKetv+1nwUQTq1HaUEvb4VD0FzhSRmIY5bJCl1axY0JkNELLrYBV5CQmQ7r3maN8wrogeFjGeZGZmFYOfPixnDVQswDoq4Py4pf67itf5VMLk+9tYIsYxSFmkhhI4oWLG7NR4u1RfUz84Qe1pW5azp0mYxi4fVyiqEedPjUz/8v0GTIh6HZdhu5Q+jMbMMK/Z7NrYLxKbG+IZFZ2hazG+R8=;25:ts7lRzrnb1u3fKUdVnFEwBVHxsNvLPj9AyVXueHr0MiGvnX29LoKV+SV8kaoN5870GacfKbYezGlLLenZ/QBYKrqGmn0KlhVbCVgHmUKIbts3PX05CP7V/cPcE+8TLWdnT9nEe9sLHGfjNuUSZxiEkiQWZHbjAJpq4eRVF1ugn1/iXM48ldaZY85bhL0xGVOyE5LuLfd3a1ja5j04VKdlmTgWxr//XQ+Q0A81EmoNXPfzVuQl85ttv3lVeSROzxln1PbWPQAAeeUNMpePllEOKlFAPDLqKELN/6JBm2sxv04LLk5XVcd1o2FBl+ZphDTh+pC1SkXHn7yJ5cLoydc2g==
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2156:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2156;31:vOZzd9NHqSLveUOI1PuSid8Shxex09TTYUeimYRPuFMqyKXpbU6Kqw8RK+YAIuGWsXxSNIWOyGTeCO2hO/wEkWkRQqHNiB8EcV8T4ExPyQHYvdsKkv6R2uIReJIWbb5e7kNtokuGPsTDuktuOIguR98pkglyYrNPe2X1Ni4uthdSECWH3PCPo/rtb3ajy5NE/aElKvHca0Z1w/cvXR9qVqpJsOWPt8cgCuz5BsDirzs=;20:JjWJmgOaWG6giF2N9URqVWJwlzs2O0ULmRn3kC8xx2E8KLb0UaeVWWMjJ7q4ddbCfqoXCXkyymzKXGqfmHwFDfMaFgmLslsfOG2HBebaatZ0Z7Ykr+S/bPCUv2bM/7qpIjyFBPf+x3PIzOvVKo/EpUbfcEIjGT3yloFcdZHfazSNkVfnjd0mi5ofkZVlHqh3kGvIL0/k39GQ7bRD84hZV545AO5jn7A7xxZOJlzpqp35zzWZnTPcv9ZbPu3AWEkLLW2AHID+apCjnpdGBvf2+V+5D9zJRhCLTI+cz9dfEFddTd3p0eMRYXMvhQFX0sqk36CZ/ZcxS3bcWbEJDFhztIGstLgS5pDNW0c/FmdVsJD+M71lS7tpU0lwZlNAYI/6cWcJSczEMyFACqmNRdlPF1cI6/gxcbJXcYPKms6dhFyq2v2O7Yu/h9XsU3M4f9L3JtBnk9jrZNmz9WbUzLv1ikpbssaI9g9EuqnmQHSlhrWFMt/3xOCR8R1LJy5/nav/
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2156151D5EFD3B0ACC0D0C9DB6DE0@HE1PR0501MB2156.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR0501MB2156;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2156;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2156;4:33o12aMshwJfpkgJ54LwWNQhnqVKZJ67ANB1TUKSTp5o3zrM3eApANvxczQEa/Ql2Ropn87rWhGrRUjSDfPxX0NP5LWZBd1V/iIe5oRBsF7wGTmn/FujEn35HLzb2iaHWYEW5ZoQgzP17s257DHIz07RdliskXUcPz03m1x4dbx7PEv60ONN91N4dGdU5TljaelggvEwYMCO+BHrN/gFOsD6O5noNdWGJPCJgCWLctgX+e691hVAtzQim45X2u6pwe7aJPNDb3dBHW55JuRMiQ==
X-Forefront-PRVS: 085956473E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1MDFNQjIxNTY7MjM6Mnk4eGtOVk1NRTV6QzdiRVJ6cXVYOEU2?=
 =?utf-8?B?djB6MHFERU1yWlJoWGhTbkFlQ0VIS25kckcvNTM1SzdjUWhpVnhQNCt3bnFG?=
 =?utf-8?B?Q3pXUGFyTkh5Y2RoZjMzY2V3ZjZldUVFTStVNDY0MGNNakxRUVk4SE9VZ2Uz?=
 =?utf-8?B?M25GZGtaOWdtNTRUV1BXLythQ21Ceit4bWxrNUEzU3M4WmNrL0hXQStRYXor?=
 =?utf-8?B?OGtTTzhaa3Vwc1ZwVUFoTUlUOWRqTlVUREhrSGtMYlZNMmdUT3NLbXNCeDFD?=
 =?utf-8?B?cmQ0MGlxMC9HOTJJMjQ1Q09GcnBpUmNhbGFMNXdmVVZQOEdSeXhVeHNoTkZy?=
 =?utf-8?B?RXpDWWN2eFpvWGJnc2RZNGdtckZpYlhtUk9jZ1JzbHJLTDVNUXJLZFNyTHJC?=
 =?utf-8?B?bE50TzJISEtvdFZUalYxMFowU2ZUUnlpNkc3K2lKOTBoRWh5RmRpUG9iL0s3?=
 =?utf-8?B?bk9hT1BUenE1QmsyY3FIb3ppS3ljTW9aQXhvakNFb3Axd25MNytuOWdYK0lz?=
 =?utf-8?B?QzQ3ZjFXMi9STGxyZ0RrVk9OUzhWVHE0MkZIbGZOczF0T1pYTFBtWkF4d0VZ?=
 =?utf-8?B?K1JQVllvYzlwSWMxYzZKTTZuN2JYTlUrdjhiZ2RrSWtHQTN0Qlc2MDBGczlL?=
 =?utf-8?B?eG9SbU1wUVdpbXNhMGI2Tno5bm9BRi83RWc2MTBoY1BvVUM4QURUOVdsaU9Z?=
 =?utf-8?B?V1JWKzN2R1QzN3lJaEtYV1pSQmk2aVMzcElRbEtOUCtoT05XK2Q0a2U1N2c0?=
 =?utf-8?B?VlNaOUh4VmNtUGtrMHJwWVdCaEprbzJxb1duRElmNkMxQnFBbVB2eitvRm56?=
 =?utf-8?B?cE9JbUZZOEcrTzlRUklUa09OeGNSR1RzQUhrZzdEZVJ6ZlBiOGIzeGx1UlZ4?=
 =?utf-8?B?R1JKd2Y3V0t5OG4rKzBYemdIaEJOenpVaUZBZWxGcXRNRzRBVy9odWtSN1BT?=
 =?utf-8?B?TTkzRWJWaVBaclJFUnNEbGpXYWFXQUNMMlBRSVlTdG0vOUpWMWE5bnZubXhR?=
 =?utf-8?B?WThRZS8xU1JFNDNWMnIwY0ZlWHlueitxSHJqU2RwS1BvQjdHOEdTd2JqUTY1?=
 =?utf-8?B?U3RMTVkvTzJLcitFOVdtYTdWYUtBY1dFNnpyRWZvNGZ1b3RCdUk3MFNwMXE0?=
 =?utf-8?B?b0QrZHllZ0dnVmNIUk1rZDlJcWV4bzc3R1JMVU83UEZybDhtLytGakVDaGpz?=
 =?utf-8?B?aXdjRTVvSVVDd1A5S0lQZlJlSnhXSGVqbXFmN0ErUWVOQ1o5Z04rMGFTbDhS?=
 =?utf-8?B?VDVMa1ZJbytmdEFFa0ROV2g1MUdXMldubVQzcmsra3VrRlJzVFU2ZjlkRnVW?=
 =?utf-8?B?cENwSHAvT1pCSHFTc3FKbmlmSndXazZZV3ZiQVNuSmNXcWtGMFBKWm5Fenln?=
 =?utf-8?B?VExHbERDczF1bG50ck5LSkk4WU90R2hkRXJBS1U1UkMzcVorYzRwSllTSG5Q?=
 =?utf-8?B?NjU4bEhpVXJtZTBpNm9UZEF4RnFMZEQ0K1pBT3RKRnVrYmMwQVBpMFdNMUdt?=
 =?utf-8?B?Yk1NclZZRURMWTUvZnBRVk1DZUp6VU1KRGJVRFU0a1FIRlhiZmJxU3lWZEda?=
 =?utf-8?B?ZUVZR1RLTGlMZlBYV2g0S3JqdVFmUnFrbnEvRjFRS3FITnZqcG14VCtrV0pq?=
 =?utf-8?B?VGtTSjZWUmd2MktXWWZpdnZJMEFpdW1vUUs2MWxsZ1F1NEx6TmczZ090S3cy?=
 =?utf-8?B?RkVrWEtKdjhORVpkaWRqeHZGVCtFamNadkhMa1VuRUxlTlhSV2lTamxHTm5x?=
 =?utf-8?B?Q2J6NkJpOCt1Y3R4UXVnTFYwK05CMTFGRHRLQW4zcXYwZ2s0eWNNZE9ycmNi?=
 =?utf-8?B?R2RxdE5XSnczQkg2RlpSKzdmeUI2MTRaTVJERDhYck9SZFdDUT09?=
X-Microsoft-Antispam-Message-Info: ner1UnSpktjT/DQy/mWJ/1AYc62gzQaqGk2mU37J+o7lHUIv8BhnpaLP3E3/81mf1/PkwgF00KMPDhb0t539RYq4iPa6nyO1cIx7EiZKOdJ5MapYNSFdoD8H83AoAhETd8X0JcPJjZKzPtn9glleFhMzUUvZLmkBWvzyYdRmJbGG0uKMRFTOq7gkD9hvWacx9Nhm9z3t+IRyJsyDoVLwacAjQwcJXv55GX2OuWXitFn7Cx9f1tDNtrQlNYjxL46qG9Vp543bNzkl6ar/A1CjO5cZf4kPF3FsYlVc/XCDJL1uHCRULigKIBfK0+hMMC/gHAdd6Rv9CXwOAtm229W6qYTFYtqATz3BbM9PftPzvxg=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2156;6:tbdjn6qOEnWMrJb5ikrrrvB+xsuR/Lr0KLiTNXXr7pmlhLorwbE9vBzKIlLUxBRiBl9pAlCh2oJSkZ5XPmrJCrpkXWJ5WLB1XfYGuyxYgNn3SMFBP0wh3ZqVhl8RitLuqosyRQbeOqg8AqXi/OwA2BxPTZ0X7rjPTtiM33JorC1RWTNmf/1U0PPS1lrQqMbZmxNnyu4unj/MCDdlB98ndIEC5klGOAQHmOd8lfkM+c0Ke9rxdko6qAH+RDavhCMcPYCYjuMUeNq8oAimnjVYfdbQqIvg7YHLJ6NooXNtNNqCnzxHqo50h7Uc3pddnUfSFH5WtKqAwqvG3ISDBeasyn732WNv59IRgTsTk2KeIbL7yEevrZyqWI3Q1yymbMjrD0pTendN4bu/BWxPOUk3VfuN8YWX+WodL6JH13QJPxIzYJnLnP8rLndkG0Cy5Xb/K7hLTfgqWrpFY9WEKnifEQ==;5:fi3eT/Q2Vh6jgW+q9wq/X4sHQ6TLROqA7fVQS5tIyA2lAE6OXO4iPbN464IDSpKWqN6lTvqXQQxAcAvjQ8iYevWY1XCIYhw42fshf6Pnf7QiH5gfYewMxYIt4usfjAns8bS3CCgd9nXe98QomY95ldvXj5rBVDJL9Luuw9FuoNQ=;7:31DbMH00dtUuUuigqqp23FreYoD4ty8BjGo9vNIKuC+HW2OcirKqQREJ8OZSWvT9npAvHJdTmRRuQwj2THoCw7Eg+v+JiSCCTzGqaGHz48iOrnvxHg3wBtZwzg/sAmQedxfozwlHDE6DAH2sy5o5Jg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2018 22:38:32.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf2103-d661-4f04-6724-08d64cdd676c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2156
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/15/2018 7:16 PM, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
> ---
>   drivers/nvme/target/configfs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index c2df205096ec..4d28c4d78850 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -34,6 +34,7 @@ static const struct nvmet_transport_name {
>   } nvmet_transport_names[] = {
>   	{ NVMF_TRTYPE_RDMA,	"rdma" },
>   	{ NVMF_TRTYPE_FC,	"fc" },
> +	{ NVMF_TRTYPE_TCP,	"tcp" },
>   	{ NVMF_TRTYPE_LOOP,	"loop" },
>   };
>   

looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


