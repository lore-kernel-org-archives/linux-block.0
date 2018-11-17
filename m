Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B6C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CCE20817
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 22:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tMtX4k7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CCE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeKRIzJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 03:55:09 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:20203
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeKRIzJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 03:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x1cMDYDhZs/oodrRTAo46zcNZPwXUeQO/zLlWg49rY=;
 b=tMtX4k7rfS6Kmg/njmp0cX/dRnnuNNXrjFC/XGOaQAFQXcdEh5/o3ZcrJnoZmj9OFsxup9T2eonmNOi14H6xu0NJy5/zPzyLW5FrozthUROagG6qA9mfT3c86+MGFRZZQJmeur7DxDZs6Izu71jqVAX7Sc0r28I/HDfHfvrjDqc=
Received: from HE1PR0501CA0039.eurprd05.prod.outlook.com (2603:10a6:3:1a::49)
 by VI1PR0501MB2159.eurprd05.prod.outlook.com (2603:10a6:800:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Sat, 17 Nov
 2018 22:36:09 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by HE1PR0501CA0039.outlook.office365.com
 (2603:10a6:3:1a::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Sat, 17 Nov 2018 22:36:09 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Sat, 17 Nov 2018 22:36:08 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 18 Nov 2018 00:36:07
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 18 Nov 2018 00:36:07 +0200
Received: from [172.16.0.166] (172.16.0.166) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 18 Nov 2018 00:36:06
 +0200
Subject: Re: [PATCH 05/11] nvmet: Add install_queue callout
To:     Sagi Grimberg <sagi@lightbitslabs.com>,
        <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-6-sagi@lightbitslabs.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <af370da9-3d56-e1a8-27db-c0a8e9291417@mellanox.com>
Date:   Sun, 18 Nov 2018 00:36:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115171626.9306-6-sagi@lightbitslabs.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.166]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(199004)(189003)(67846002)(53546011)(478600001)(23676004)(2486003)(31696002)(76176011)(3846002)(3260700006)(6116002)(2906002)(86362001)(4326008)(230700001)(47776003)(2616005)(11346002)(54906003)(36756003)(16576012)(316002)(58126008)(64126003)(126002)(110136005)(6246003)(65806001)(476003)(65956001)(486006)(8936002)(81166006)(8676002)(7736002)(305945005)(81156014)(446003)(50466002)(106466001)(229853002)(16526019)(186003)(65826007)(106002)(356004)(31686004)(26005)(336012)(77096007)(5660300001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2159;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT046;1:wfC/Yv1qsXWTqjfHg7SXS5oKKei3UlzIb5fOWQOuig4Vm0CyKkGrS/ImCvaMlHfpJkTzsJt/qnTq971YUP6oBxEcbo26AfrspNnq6t6X7t+9mw+JM0yxiBGR0dwpnTWc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f99b663-745a-424d-27cc-08d64cdd11e0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2159;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2159;3:R35MKl+Kjcfe+C9zQwH8DZaGDX3PIxPNKepQe94Us45wL1Op2z9J1QE3ZO9aW9pq7pAdWgf2n4Y9xevSofWQlgpGPRVoojuOM2aKSbrY9k4hfY5Nhr3aglXj++9eTlkjYZqAYVQ6c6lKXLA0ejHvebO7bsyI0gyS1nr+ElIUq9H0tvhMT4x0ERGFQgkbmH287gRO3K1fAuzXjrD78TilXLgMxUSsDjDGmkr5IynSGplYU85q93Ak7aSV1YjYBoosA7V6pgYWO3NkwnX0hRJ10Vujf8jqRN54jd/zeHimSA9HkAz1bq1qfvmuXGwOiQsP4xin6ym5x2Tk99uTxA0Wiv2I0TCtWb3vcNNhtqCW/3E=;25:ZpDjhguMwJkxowGw58qVz5gwpGNGxpOPp2uag49XMD85i3jP1Ehm8XIG95sAFpjOpbh8hkaq9TAD6bYlEndrnmbtmucV95BRnSw7ABZYFR2vCNI78ezS9+3draNc7BFomJuuqsJ+48Bftc7BQbjJcKv/4z3wussyFGNj663wva9PjyrGPMMQZngOf4Ui2gBf2s7YqMRrG5jK0NUU6UYFag2qIRSITGbks5+PiO3VBz3JBux/Z2HAsbLch5abb8+pGqr9EaMXkNgbFRWxnjp/lgtsVUMFWWsxupUUMaO2cEF+J2u6prBz6FbGVB67rpYPsL85m50ojMSAZ4CzA6ldCQ==
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2159:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2159;31:ScnVUxDS2VwwG87lns8wG4CrVwpqVHRVIf/dMxgnFPZ5Kc0Hl0VDgQUcVGXuUbpWPQ7dUXN14lIYXUeXCBNdMecDYQsZknuIaaVZAichW/mIsJlU5jnBR4f3GtpQoI28WXX6JTfIfV9Vc+kly0qDrjEJ5K5g0TFzUok03h503yook0CLmnQ4UxU69ku2Q+xBl13zQmcvc2VUnACYOLQFglqPrldDKghSkeKblQTC5ew=;20:uT07CAfWEp+MV6Y5pgfgOl4CHrmACRn48JKIJoGiR8Po9j7uCmN1f/gOADrMsXueslpmRgjYCajJZzuxZsiT0HMbCWnlEtoxNUD2LCjhSqw0+d6Yie1E58WyLOQLurLbTnosXG/1IyKdXoANMJ1LeiSGVB7eWg9tR6wm6CTE9vHEuBRSoDU7phhUnxRXkkjrpjgqoW0OZGZHS5DryFrRrPbCAeuK1kzL22tQQGs4F9+NV3t1DmuhKWgOHFdjWvqSbIPWYIuuCDbYdDhiH1Xn2ftUL2ZV/WwF6xTqIGbPV8ZMWhbCRGeo2MbWqKQ78L6xBCdKVkLZBgyPoPGVBFXBACF7IRXTH5/OZ73TnaimBlrOQx7VNHWlqg5LCrJHmRhKohrlMoosUL3tNlZxGVL3+QX7tZcrPye6cL0ZDxfhwv6Ky1wI16t/VDq7w8ysnY6pDFhEX2dlyk8wvi7Nap1TqjqDOfOUpvySc5znmsYUDehI1YzSziTZQet6AsiS+1zz
X-Microsoft-Antispam-PRVS: <VI1PR0501MB2159BB4A4A2E436201AC1F25B6DE0@VI1PR0501MB2159.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231415)(944501410)(52105112)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2159;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2159;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2159;4:Ra78aLM38K3lQaGAGxHibrO82TrFAwG1c+4mXGt/icFHbGIqtPetqn4HWn5BmbaOmbrxqM+iSqKsOJEvvXGh33bYcXI8sHfIOz6aaWF6H+PNsE+9fICvmvRs4rtMiJEJ5lYDzWHoKs0c5tzEeN6vFadsXMPagzbrTDmjBSlsRlOx+/wNraKkZGCVzXUDpVMOFYoOB1bAch31BiRI4SIiz770NocMk9Y1ry3Acz66RKn5VFAImmgqPlDrNj9Va/bde73Q8VEhhOb+y1nEVzGHese14+jOiONmSbpdwlLs3OhxSwUQ75eL96IIN1bZ+Xv/
X-Forefront-PRVS: 085956473E
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjIxNTk7MjM6bmNsalBGY0NrbHZtcERBUGFlR1MvMG13?=
 =?utf-8?B?U0ZXaUtrSHJEOFhva0I0eTNTcWhPQzJubmR3V1dKZ2J4ek85aXFLdVZnLzhW?=
 =?utf-8?B?RHMwc21YYUFuQkRCR0k2YW9kdmZrZ2h4ZzBkN3dFbktnM2xGYWhMb1h3bldo?=
 =?utf-8?B?K284SE1nbVZHVGFKK1hublJHWS8vclZtTGg3MnlLS0YzTVBUelVYMUlLaG8r?=
 =?utf-8?B?bHQ2NkE2eHJiMHNvMlNFZmZXNURQTkJBY2ZXTlZGVWEyYmhOdGJ4WHoya3kx?=
 =?utf-8?B?WkhVV1NoRHV3M1pMeGx3djNBRGRRdjJaN0FYL0Y5UGdiak9OdVdFUHN4MWpP?=
 =?utf-8?B?K3VXbFZ3RE1icTJLRkNadXVod21jNkg3azhWakFRZnRpR3FPZFZnR21YSWVl?=
 =?utf-8?B?V2hjdGpzd25Pbjd1aE1XZFpYbWhBTFkxZGt2NG5rMlB5UG5DTlBGbU42REJL?=
 =?utf-8?B?cVd0UC92UXBZSUpWODEyUUtjY1oyN3laTEhCVWlPbEtKcWMwZ1RWV0lyRGxi?=
 =?utf-8?B?VFR6ZVdnV2ZvNWR1SDRiZ1RXNzVXSUVpK1JUN29Wa1VGcjlHc213VE5WT2xK?=
 =?utf-8?B?ZHowR1djM1EwR0NkejRCMmFRNEJKMlY0dGlrYU9ldXRJb0xtUWlOeVpZNUVH?=
 =?utf-8?B?MDRXV0Y2YmZsOVhOeU5ONFBHOFNydkora0w3SXVORWJGbjFrUUFHOWFFaWRB?=
 =?utf-8?B?VnNuOXRLYnFITlF6aXZvRStzM2VVUzhqckRYU2FUclp0ZUVQTnJSZGpCc0RW?=
 =?utf-8?B?OU9pU0RBQ3RTNDZRak92RDJuRk5EaUtERXl2dDlMN3pUdzZQK29lNnY3bXNK?=
 =?utf-8?B?Ujc1QmM5YnBKVDBBd2Mya21jRkxXSkFUbHhxMzNQK3FHODRmU05xQlZRNTln?=
 =?utf-8?B?ZXBmU1ZFdHRMK3BBV3RuWFlTK0pMckowSVdtaWY2cTJqVDNTY01wME9reGRG?=
 =?utf-8?B?NTA2Vmd4SU8ySi84VVgzYkZMWnpBUkZqNTR2dXRjUStaeTQ2MkZxeVdaOHph?=
 =?utf-8?B?L1V0U1VkQTlnc1ZtNHFrWktFdTh0KzJweWgyTE4rVEI4L25HNGJKZjA1YzIy?=
 =?utf-8?B?TnZPYWpmVVBCRWsxN2N2T2c5WWYzdEdiNnB6ZVFYZDd0R2lYRlJlWVpzam1E?=
 =?utf-8?B?WlVjSSswMFVaa3FaQkpMNnJYeTJhVkVISGJNZDlDK2t1NW5BcmlaMUh6Y0sw?=
 =?utf-8?B?ckVyVHExejErNy9hemdMcCtKdmNKYzZHT2pHblZibk9VVU9hczdhYWpGempn?=
 =?utf-8?B?dVI4MXFBK2NBZ00vZ3ZTcnBVTEJpNnIrMlNMN2dEVVRwTXJsY05zdmVoQWxh?=
 =?utf-8?B?dXRpUnpEdUp2VDFjRVZuYzV0YzNRd1kyR01YS3FIUm1jWUV1UzBLV1JPRWln?=
 =?utf-8?B?UGFGWEl6UVJ6dEJ0dWd3cXJtNU9vM3JFeVkvUW0wY1o5WWdRUC9QQXZqbGtH?=
 =?utf-8?B?SGs4amVXa0VLMURhMzdLeE5aMjB3SGY2SEpRa1NPNTQ0cU15ZUpya0hrcldX?=
 =?utf-8?B?bytUUldmNXBiTFkyZm9weElLOU1XWUYxWDkrTm9Ba2VXbWJFaWd1L295YkQ5?=
 =?utf-8?B?U2NRZDFBNTNNODNNb0txc3RsZXlybHVTZnZhOXkrUSszNnhSdEgvTVVBblhS?=
 =?utf-8?B?Y0Y4VzZnUElmdU4rYkFNTHZmSURTQm85bjhoWEYveHRWTEhOUm9XUjZNM2VS?=
 =?utf-8?B?Q2RqV05Xcno5dnFibGJwbkwzOWJIS1dLRzRpVGVrakZWZjlhb2o4WG5Bb2Ey?=
 =?utf-8?Q?/cG31oNUYh9gKw70VIn0M4HcEkNW8t1QBloWglo=3D?=
X-Microsoft-Antispam-Message-Info: S0uGMVIuSYh1dMuJSS6vKAQdCpirvw0nSKmTZZwGoza4KqDhlQqJ4s7BFtgncpL4L7iEmnCmOIvbvAWIU2mvjSzwH9cFrNh/VRkhfZp9FF4hNYbaBRrBCNDhF1ryMhPpaHDiSWsYHJrAGZVT+e8YI379rOsOEt+Gj/A5YoHP2nGrbL7RtOYocWi+F6sFkKo3k1n1C52VpOf/xcgiKWsqztzi1617fqkrRBNnIdWywq/aNk7eRQSaY4RIZM7jEnPkv5MlffB3F+GZVTODaD9rMSK6sHJ8l9xbSQHbJuSyLZCIcWudr/Pmmhk1pwMLA+US7XuWhTF/UMc+D82dBROUsmYdC7eLySkbLCsr/FfxKy4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2159;6:wv2NMEyJHgiUwCD/3FH8ve70HiQWW8I8sIFd1J/OLnQXsjOTn4nWjnDWDHPqRD1OCnf6eoafvWGPOVijZTIELvRgbCH1aqQjKfJ7BfIS+OSZgmOYC/Vs/GEekf3pN8hwoSaxb4I2LyqMuajzfUA9o6u+35G5r5VFuv60D1aetcdN3sx0lgt4fIB0p5dK4/KczztCygGGTjd9hvyKOrkXjw2Tyy3vAT21xTwivJLS+ZKHWpMEGd4tEY1aDpJrec+yRpBGPmL91zG0LY3pfkpfzmBZe7GdUl3hUPyQyjt3m/gU8PWTLRmfkowZAQmhsDMLhE5FTlT4mBG1h0aCuS/VP3MJHYp3HqAgcd65laENtXshymrpqpyCzvWOxE8P285ph9kx/gZx2Im3rbtnsBPEV655zeKMl227JsjHjqf+I/t6CYGQ0KsX+X9W1QTyGXyp9Gj7v91yDcFDV3XtuC45dA==;5:gbhNRqFUHUWYllHV5YDbya0jf2e9C8d4wGLPailnYMd7PYAbNDfuqNPWdDaUbmhvJfa/9ycpydKpv+bhtpzgd6XQRM1V/0YAQdATWgIJ4mgzeZdmAGAFMrOvpKYjZVspL3yax3yBSQZciu3i+7KDgaPQMRPWyHhyKwhq+C7PQDU=;7:6O50BA/o7Cyy/upcL2x4bdh9kgKiOQ44SjnxIYaMnIenRH+M655Hk6wGnpsIvXxpvfNMEvBsZRQ+V111gg+M2hVbatw6/M9djTx1x5CmjAd8gV+jwujNF6g1PcFj9TOWSvuN+d6fQU8tSHE1WNE75w==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2018 22:36:08.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f99b663-745a-424d-27cc-08d64cdd11e0
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/15/2018 7:16 PM, Sagi Grimberg wrote:
> nvmet-tcp will implement it to allocate queue commands which
> are only known at nvmf connect time (sq size).
>
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 9 +++++++++
>   drivers/nvme/target/nvmet.h       | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 1f05d8507e35..a84668e8939c 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -117,6 +117,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
>   			!!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));

what is your code base ? does SQFLOW must for TCP ?


>   
> +	if (ctrl->ops->install_queue) {
> +		int ret = ctrl->ops->install_queue(req->sq);
> +		if (ret) {
> +			pr_err("failed to install queue %d cntlid %d ret %d\n",
> +				qid, ret, ctrl->cntlid);
> +			return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;

I'm not sure regarding the INVALID_PARAM rc.

maybe use NVME_SC_INTERNAL ?

otherwise,

look fine,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>


