Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F6C07E85
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 10:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A62145D
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cuNizU7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556A62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbeKNUVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:21:33 -0500
Received: from mail-eopbgr00054.outbound.protection.outlook.com ([40.107.0.54]:8384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeKNUVc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 15:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plc0XeYl1c2e8v/9/mLblN0cD1TsGzbFLOkhVcPnW3I=;
 b=cuNizU7Du2wtjCOCvwAIJxkjD9wwGMTDeARJEcUdKpehOfzlg+O2IIGcBNi+s+g17TzwHqcpxR8AtW3CvfKR8sDYsLX1cZtjY/bu2AWRI48PHVF6wYnsPwaNb7STy7hnOYEBikDukCXemJmZCF0OmR75n2yKx641uh7itJojA6g=
Received: from VI1PR0502CA0006.eurprd05.prod.outlook.com (2603:10a6:803:1::19)
 by VI1PR0502MB3021.eurprd05.prod.outlook.com (2603:10a6:800:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Wed, 14 Nov
 2018 10:18:45 +0000
Received: from VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0502CA0006.outlook.office365.com
 (2603:10a6:803:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Wed, 14 Nov 2018 10:18:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT022.mail.protection.outlook.com (10.152.18.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Wed, 14 Nov 2018 10:18:45 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 14 Nov 2018 12:18:44
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 14 Nov 2018 12:18:44 +0200
Received: from [10.223.3.87] (10.223.3.87) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 14 Nov 2018 12:18:05
 +0200
Subject: Re: [PATCH 1/6] nvme: don't disable local ints for polled queue
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     Keith Busch <keith.busch@intel.com>,
        <linux-nvme@lists.infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bef68ece-948c-026a-dd17-260cfd1409d8@mellanox.com>
Date:   Wed, 14 Nov 2018 12:18:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181110151317.3813-2-axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.87]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(50466002)(7736002)(58126008)(6246003)(77096007)(106002)(16526019)(31696002)(16576012)(230700001)(229853002)(316002)(186003)(305945005)(76176011)(14444005)(53546011)(5660300001)(106466001)(478600001)(31686004)(26005)(2906002)(36756003)(6346003)(2486003)(67846002)(23676004)(65826007)(8676002)(356004)(3260700006)(81156014)(81166006)(64126003)(336012)(4326008)(6116002)(8936002)(65956001)(126002)(110136005)(2616005)(47776003)(65806001)(54906003)(476003)(86362001)(486006)(446003)(3846002)(11346002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3021;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT022;1:7XYAEQOh/vT1+H/0rjgio04ScMupvXajBA1h7o1k2mOMPy7ovIcnV2GJah0RU8GOs4kYqpNWGx8LTbRsahZ6yTkm/Vtjb9KmJWNgJt67mNWs6IG+Y0It3RXhpUlgHtf7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ba61b4-2eaf-4470-141a-08d64a1a8f74
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3021;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3021;3:ebus26katk3jTXfNgmLkDkXk/KWu75VSTHv5n9TeZcx6YugHb+IuRA+9YH9CQNRBm+iMa4oZXW4P3kaVGBhJUM3nSx4cm1U7TGU/s6wRuoNz+/aPf2UhXoNJ5CMFBHKnvg4+Thr+jG0yw/MkHmsrjE3cB2c8wEJqOiR2FK0FaggjbClvINyU07idRf6KG8h/3hSbvoCCGCro0ma36hfJ5FUxknL0uwfRfy64bz4wI+tqJC7coNtBKWbrFmuwpZBETL3r3yBZ2eu1tNbgVOfyxlWw0La/BKaVTy93C1lQjO/Ypx4yoMAS/ua4eLdXiGwVnT7IUFfESn8JgkaouZvf1C2w2LwwyxL7ANb/jjP+F0s=;25:UHwONTaw+r18IDotXTwfaspW2fJ++WwXPDrrOGrrQ4TTNL2/LkfdMQeFHdF1a9X0q/fTVFYMlm3e6HdMrWwj/whAcIBk/tgVFgme+lAFqm1kwcT20dIgA5vWQEvd39XkZfzp10ITA3Vixx16hCc4Kk2XLuGPYOER9kIFf73f2GIFs4ox73YRD0ByTV0F67eHYjiI2BKwi6JvbqK6BzCHm1wCsx5MdjzloSL4GIG85GAF3b+I+SAKo4+jHjqVZX0FmlZ+8VYXpOMcf5cl1s+4U0weFVnfSkoRsl8HO1KTMHPn47+I4D/JQB+6ccYKgunPLr7c6ne/8yj98ho1h2AVFcegPer6bkgMyKyenLadmCc=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3021:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3021;31:3Py2T+5OuqBLWmNypewmraeZYGrCoLj0j4W/aiRVHT9OSIZTQQjVajr9+c0gsxIk7IEtw/btpExrqyxGk8BGHaRB5TKXYfjGH715amIYzYPHG6aBc529yV+Gx2SokeB9d1IOLz0sDxhjuAkPSnWiQ84oVPIjYf2CrsTbaiCVch440LKGmyyboWWCYQ0Lbf5RWBFQKXfKmdHudWQWgU+L6X8+RdEAMoyNq2FqgKLKyLg=;20:nSkAk993CX/CHhBP2+jcOCqMtffCsA4qJXWP0Ecm/o1utdFkwuFIbeQEdg2oP0dUl5zjFPKzSb7ys3Mucb3mFTnUb8/nwCDdVNESuPiM8+z614qLJ1DbVXFBhc4rTEGIrGO36UUZ1YtpaDefcdDz/4u/JPKI30Kdz1aIL7lsLEX3Ef9QJO7Q7hIZij6hAAuTOCe5fq6+Mfdn0CdKUK5IEjmhdv3qq0WXGgY5kmp/graFyODbrAMF6KGx7s26XF+lBEvLJwEKrT1IAUvk3qZBBi0WMADKbSDr9TqDc0B6jLOarfOPwMwSQRiI4SItms5T3exVlU+El9AbWEgngxrytEbTfXemrd30HlPdoyXYbmHItXOOMZqsEni5/e91iX1d7+CySfbgfr70aS0O4Zy8jDJfOD8Ev6nWoHyZaxj/eIwhwO3MFa2H7E/5uRnV89dLaDXigh5Y/e6AXITkD+R3FEnpCaheYh4+FMlHBNg4PpO26SDZfyawB0LCYlRB3JAz
X-Microsoft-Antispam-PRVS: <VI1PR0502MB302176A75FF51A11A2AAD44EB6C30@VI1PR0502MB3021.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231410)(944501410)(52105112)(10201501046)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0502MB3021;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3021;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3021;4:4LFjwEWykEwO07rvQYfIRKLCCgUs3f0wCtreroxRgg0rySgrf1uorZrKQmfRf06YpI3uiN1OwIES41iP5BoFz+PhIfZFiul36bUjRE7IIxpmWynHxjL7mN0HHhwXwnEhvqnW99/KkomxeMYOItYyp0PSy+LvLfAKqXYc/qhCGCMOKYCZROwdyWFoRppopBNd9dNMg5NWdmKH8KLuC+mnBtZD7NMTKaNiCaYNtF/UiuqCNbnZLJIjCpfbevaJqXhXu0MOTKO6tQMEhM+E5c/6LdU8uVsNLnvF08UnkkMKFcf2c4v5+lDTUnpOLLNtU8/2F9Zhy4hqyC9EhaRHFcnYMnBG37S8PEZ1mFbWRceuJsQ=
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDJNQjMwMjE7MjM6dVZvbWpjUlZqbzJwbHc3VmFTUXhLNzM2?=
 =?utf-8?B?ZzJrLzlNMmtmSGovK1VzOG1HRC9GamdQOUZaSU5xQkpyK1VuczJ6R3djak9V?=
 =?utf-8?B?aWZOaVFtR3ZCb3JVNEV0a2x3aHZTV2tya29IVDZuRWs1N2JxWXJGWHZXUU9o?=
 =?utf-8?B?c2l5c01rL0RKOXBLYjBlQXk3UlVnbTk3NE5xMG8vVm9hbWV2RGtzc0pvV05Y?=
 =?utf-8?B?SHhSMXp5dzNBRG5vK1Vma0o1c29maDQrZ0NwSllxZ2ppdHp4Ny9GbnJyK2hu?=
 =?utf-8?B?KzVqRy92MmZZWlgzQnZKZmFOLzJFM3lyM1kvNGQrdEU1cG54RFpUSHEyd1Y2?=
 =?utf-8?B?REFHbXZIOFpmVHlpZ0c0K1VhS1E4UW83YmRzaUZ3NERFZXBUUEc1bjFEbzNL?=
 =?utf-8?B?MlVqTDNSNU1FcTl2TXM2Q3RCNkd2RkZEWVExRkZkRnJyM1VGMkNlS2N3SjNR?=
 =?utf-8?B?YlE0NmUxbW44c09FQnJWVzc4SmtHWDRCVHRjaDZqaE5DeEkyaXRBTG1mdjUy?=
 =?utf-8?B?SUR2ZHlURTk0Y3E2bndHNi90dW5JZEdoTjRWaDBCZU1VdnArWGpxZ3E1WjN6?=
 =?utf-8?B?RnRmVk5ZRXZxQjY4TmdVS2JzMElDMjZBMkdVZ3BqVEh1RmpPUUo0OFMvb3hJ?=
 =?utf-8?B?cTVmckNpVXZxaXNSZmhXMCtISjh2Vys1Y1kwUTBkRUJ0cEZpaW5lcElKQytp?=
 =?utf-8?B?ZEhYc0h4MWtYZVBzdEtCZnN3NFNYbWRhV1Y0dGRRTkpBU1hsc1ZsdC9aZzJK?=
 =?utf-8?B?czRRNDRuemZmSFJ5VFVzNFFqTXNJbE42WlJ5eGc2NHo4R1NDZ3dQU2lGYVVI?=
 =?utf-8?B?TTBqQzI0QXcrSE40WXVTMDdSU1Rnekx1U2VNaHkrTUJxb2x5S3hMMDBtYXIv?=
 =?utf-8?B?SkhyQVcrd0tEeDVycGdESXFxZmRFMXQ1MDBjSkZ2MU9zS1R3a0ZwSS91RDRk?=
 =?utf-8?B?dHlkd3Z5VkJ5ZXdOdTkwd2VpSms2clJ6UFJVNXdJcHhHZDk0R2RROTZ5QlVj?=
 =?utf-8?B?ak1yZzBHNXFHZkt4b21VTENDckUyQUdvWGp2MjJ0dko4azg4dDFWWGZLVUhS?=
 =?utf-8?B?d0RTbjVkR0pvME5sckczcDBZUzJQZ2NzL3ZaU08vWWEyRkYxQUxPemMrbHNZ?=
 =?utf-8?B?cUtDbHJpVmxBVXlmVVBwOGxFNkMyVGQ3V0JWdDlaL1VyOENvbXRXczFLWmRy?=
 =?utf-8?B?emVJYVhOQzBWZFJtT1loUzR5Y0xMc2FUWHFzaW03cU12QnQ3UXVidktkZXB6?=
 =?utf-8?B?MVAwNnFNVCswMER4aEFlTmhrVklWL2hGR0x5YnZzeGk1dWFrQUg3Q2I2YTRU?=
 =?utf-8?B?OHIxSnBXbUFXYlFiZkdyMnJJNWRhZWVDMXRsbExWalNiUVcxa1dKUUVlQkxy?=
 =?utf-8?B?aU5VYXlsVmFOaVdQSHJQREM4Yjg1aVltYzZkZHhXdXAvVkwxZWIzVjRaekR6?=
 =?utf-8?B?UmxHZWZTdzJEUndhSE1weDk5N3FSa0ZoWEJxbEMzdXVyTEhlTkw5cW91Tklx?=
 =?utf-8?B?akEyVGlhOXVCVnJhdXNRU0Jsc3Z2MzRHWXpmWVlpMmJRSDZSOTh6TGxRTXRS?=
 =?utf-8?B?YjJidDhvWklmbW13a2c5OHBOV1l2bTJ5K3NncFRFd3JoY3FSdWxtUTRIcGN5?=
 =?utf-8?B?eVZFWDNPQ2dvSmt4SjR4TVI2YnZHdnBlS3RiZXVDaGliM1ZNTG5XZGJKR21X?=
 =?utf-8?B?QWNjcWJrWm5laTFRNmhUZUZtZnhsNXZhbzVCMitSOWduUERLTEVSazlsZkxD?=
 =?utf-8?B?NlBuOTFUbU00SHhtQTU1bTQwQ2NjVkFLM0VvUlpkeVgyc1FlbTBucUt6WFp2?=
 =?utf-8?B?TFJseWNwZVA3amZKdHo4TXVSeHVuMkpYb0U1QnB0Zi9zc2hnQT09?=
X-Microsoft-Antispam-Message-Info: EdMftgnDZJzEBoZ1m8oMfXwHZkn6CAXOVNsVhUP74OSJAVMTSTS6s6JtBdpAvTvie6cHWrAJxf0LO0gKAWE/qA2D/ftBR4Mn1ws9UI1RfDyau17aGGHjJx3TviMsWXsMG+OjsjZRgqx5c4bB9yIJI/XiOkAP0vSNC69qzR0POu/fK17rkb4skAO1VUq8EIqj4oMQ1ERbrPS9qdLuIa0G03QLsxjpF05CvlovHVnt0AznZr0X8f9XKoo0g0Hlm3cxm/8HECQg8Nren+MPP7rOLMGCYHlB2FSfBARAE0H1Z8Xy97hgYZrv6d+O6cyWZxIYUhiSNpq1rKh9ygSpOaXRQVI+z9Hq3jAFxQqi/+gEwYA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3021;6:TKpLYx8GSuVJnlDidcTbQ8ZwNzmRbJ25Mwzn0jbsua1GOTdAyygt2YG67b+w9vmoYzj8nbRSHOADtu01JvzF9m3qtaPTYEZu0xWi8Pc6lPuqc+E0UBTiUwYnWLvHFw7eAABKirkzkxlmsqwfqJkXjkaWrjlOLGJb4Xxc0Bs19Dzt7DBEGYvV1B6vI36fPPj7cglCuqWrNBWsn4HS3TDmZNxyHg0CCmWM7lhhZ/XW0A4DGW/ufu1srCIj4KgRfG4HSmp/mpZ/sGOozn7ZhMhgFYDAvUX4FX3Kyt2pLAlBzD5hWF7fz1lx5ZBPPHy6gWn0YlZ6YixJkr/AxFC9oAqFpM4/4aYfxin0cnv1SiJoj3ewVbClyzWr4js3tvt2rc+kaY5sPBCXUz/umLKvoVHtKzBkoJZkXHZ4FqPVHbtqznT38u4TvgdoCnFf9wgRX1fY7J54WEiPf+3vyUWxo6FPRA==;5:uT+qk4fNNHaJO5isip3kCccui2cZd9sw0Dic6XdD6CvhjMtbIXKZR01s2TyKtwOYvFgCj4Guay9/Td2+rL+44YEyCfJq1zfaBvVoMiIbYnyM4esS4QoqYqkg/ettG1dYq3cvSV+d1eMxVoZF9XvKMDZ7YY21iOBbcGgw6oBV5kM=;7:v0t5Mg8ZRR7u/C7+BYVg0f60vxPLQp69mzbYXt8H3Ku0QmAanJnA4m4MfkahBMVv33dCon1BZm/byYDXfaTrPYDs+wSCq+nStnQN2hUYIb+KraXs4NhBmwD7iqXeYc84NEHfkG1qyKwSmnRme964WQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 10:18:45.3514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ba61b4-2eaf-4470-141a-08d64a1a8f74
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/10/2018 5:13 PM, Jens Axboe wrote:
> A polled queued doesn't trigger interrupts, so it's always safe
> to grab the queue lock without disabling interrupts.


Jens,

can you share the added value in performance for this change ?



> Cc: Keith Busch <keith.busch@intel.com>
> Cc: linux-nvme@lists.infradead.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6aa86dfcb32c..a6e3fbddfadf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>   
>   static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>   {
> +	unsigned long flags = 0; /* gcc 7.x fail */
>   	u16 start, end;
> -	bool found;
> +	bool found, has_irq;
>   
>   	if (!nvme_cqe_pending(nvmeq))
>   		return 0;
>   
> -	spin_lock_irq(&nvmeq->cq_lock);
> +	/*
> +	 * Polled queue doesn't have an IRQ, no need to disable ints
> +	 */
> +	has_irq = !nvmeq->polled;
> +	if (has_irq)
> +		local_irq_save(flags);
> +
> +	spin_lock(&nvmeq->cq_lock);
>   	found = nvme_process_cq(nvmeq, &start, &end, tag);
> -	spin_unlock_irq(&nvmeq->cq_lock);
> +	spin_unlock(&nvmeq->cq_lock);
> +
> +	if (has_irq)
> +		local_irq_restore(flags);
>   
>   	nvme_complete_cqes(nvmeq, start, end);
>   	return found;
