Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D735C4332F
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKOTsF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKOTsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 14:48:03 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C41EACA
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 11:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTaK2eEm1l0W0CuoyaLNSMl2XcdxJTB5m5r/gPPjFruXhRQRK18nd4m4WPtUsqhGjV7dD4ipBr7yspXbglAvqdeIdGcsAX1ZqeXLAb0K9/RdC+NadAikwuHHgxoH63nyv4IcmBN8JiQMHkcoJiFHBgGLaPNANYvRxIvScWNf9OWhofPRRd1A1G5swgmaXf/x9LDkYMa0Eh5WT71YqVOkQhjCvuiVkld2fq/AJqkhNmfl4AbiDlhi4AOKlN1d8FjcXt+1Pn0drfx++ieYUEM0CjWK91L4VzH/je/Z7aso/3f0uO67pWFvlqOkokREDclt6jmuq867jqP1JGJlhLZoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNt3lyhcUml69R2DrRURVznwYAt+/Y5bnyILOx6sjTQ=;
 b=b20hdiFdmokgcHNX5QMxqtVCPBY3y86LdkLrbZZ9IQvWdz11zDS4+PBNVXDjZoIXg20wPFCWxpDsVM+YB29aZxPBN0NQWlaPojSpk7Fb3k4Ylf23U+U01FtDZZLOF2vMTGQSJqKdW6Vz2uKo6Lnm7Ihq5TecBQT7NuRAQOKDIFCpmklVMYCzJQt55QJYGzRvFXr4skwfYVJ2cuoxaiJmchcIjXfUtr5wzT9oP38Z2R4U5pIfT9TIK6aVXtxuKhM/o6Mqk/hcF4t4DLpWR1fm2ORsZ/QqnETPrX/fwS/H9DthBfi+F59/p4v64ISSHkn/13ZKl4tmh4VMMIO6Em1AkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNt3lyhcUml69R2DrRURVznwYAt+/Y5bnyILOx6sjTQ=;
 b=jt6M8tPGCjmcGWsj2oJLekS0aSyFoLsbxbb6SXo/mBJtD4DAOMO5nsnizDCIV9CNiU+F/pZmodBEivwBNzuEiqcNtmfRRVXW4xzGXF37WsufX1ZY/bxXTkxHXYySFvjoudX2/3jgQXqjqan7OgOh/d4ptgfuA43uAlzZ31xdcBd+EV7gma/2s/oysFzrh0mjPxn//NulqY7G7QHOBKOcU8GCyZF/uGi5eVDi2da2Ap+arKGVNil9oJ4Tq4o2UcZxcdv1bZwlh58GbxopOZojsXjzpAQoAkeUTfZYxzFAx35PiqfWLpz8XXAQJPxiIR4mYQRPIlFGvoAzTEfzXZwI3A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 19:48:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 19:48:00 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blktests 002/029/030 error report
Thread-Topic: blktests 002/029/030 error report
Thread-Index: AQHY+Ir0s7dvwA9xikK2tKxkR8tqiK5AZT8A
Date:   Tue, 15 Nov 2022 19:48:00 +0000
Message-ID: <7f58627a-3b8f-a609-3f8b-362fd01ad2b3@nvidia.com>
References: <5183bc2c-746b-5806-9ace-31a3a7000e6d@nvidia.com>
In-Reply-To: <5183bc2c-746b-5806-9ace-31a3a7000e6d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5079:EE_
x-ms-office365-filtering-correlation-id: 6f0485c1-d7c0-48c3-2675-08dac7424d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVeoJXLeQDULjOC2UlgqjZKzkY5mUEN64csOVgeJYrADt/POwJMiSMrm5KWqCnar+ZLphEDDVP1s95o9gFGGZVSD4kkzkEUc1qYUh0olEUbrbg60RDoYfEG16L1qQM0AGFhoXffJPUEP2z79pKziolXe4Qn7fxRLaBplHSb7eHfTvKyYtHA0p1FQc4y6hooRMo1mP5+jofYDb1Bk1tOWno5DFdYDJP6lTIHx3Ml9WJd2RJS5w5P9u6+SsQtEWTDiJKPqkWFNxRFawyj76H2MTr5FaTptbhMyBty7oBGvFitHOmUdT8OZv40Qvnfo1lNThp94vD/8kdwvrSWu0FKuyp2u16vwlqTCNqBikfAkY8NiKKkezblaQaG/0l95X5OyrTecf/VyfgYFE9m4DsentbHcjl9A5LYYarSBVxeBFxq7pUSZXPwMBzAGzfF1qgYavEb3iBE5wDCiXlJTuXWyJU+FauWWp0Syh/p528bXPhQyvW0xK5dJv/5l8LfWLjoJV4pSVULyO8Cn2I+fChOa6wHnUam1BYOB8teU6EyATIifsgbe+cnnliwYDdD31sXKl991nwpLsWZknz/Uqv6Kd1jBzelm/lUOzMETvIbwshozeaAhANY8W4AnBLxy+0DOHkTNSoEp4NFBem1hw2U2OomRVZV8hQBWW3GDiJHfZ3VjSamihcp3fMfzN+em6YlUEhPBCgQmRjFlva9O/3YE4ccMlVX2Cdx8dKARFvSyyH3xYKka0pKo0Ht6QV4YUBcnNopZdxYRYvJ7M3/kV55jNyZVYdXKKC6iYZpeecIIBiVkmrhHYAyVwH6qF0GYdNjZl5oKQnOKc0jHrtbAL5SpwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(6512007)(86362001)(31696002)(316002)(83380400001)(558084003)(2906002)(66446008)(66946007)(66476007)(76116006)(66556008)(64756008)(8936002)(91956017)(41300700001)(4326008)(8676002)(38100700002)(36756003)(5660300002)(186003)(2616005)(122000001)(71200400001)(478600001)(31686004)(6486002)(53546011)(6916009)(6506007)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEN4RUQwMG1uc2RrVVIvaHZ6WUY3SGt2MDlFVEtCY2d6T2M0SXRWOEpMNVFQ?=
 =?utf-8?B?SjI5MEd1cG9FUGJiNVAwd1MvLzhCZW9USThkcDVyUG9lMDg5SUM5SExQRkNE?=
 =?utf-8?B?cS9ybDhnNkJkQTFNV2tZbmxrcWt0cys1aUtmbHZ4M3BBdlBKOWY5RVdhS0ZQ?=
 =?utf-8?B?UjhYdnR1bDh4ZXphakV3d2d4aDZiVXdDK1BDRGtOS1ZZM3FRTHA2ZG1xL0cz?=
 =?utf-8?B?YmptWTUwTGl6TzI2aUFOQjJJQ1BsSzIxcTRUUXVCTlhjQVllZVZydFZxVjFH?=
 =?utf-8?B?eW5Hd2RVU0YzeHk4ak9NNnc5Ykw5N285d0Y1eW5DSjROanJPNHpxdUFiM3Fw?=
 =?utf-8?B?aG9MZVhRdGdkQk1mQmo4R25JY09YWmhZUjZTOW1zMHVRL2pxeStYUCs2WGRE?=
 =?utf-8?B?Zm1GbEQzaC80S1BnOFd5QUs2NmJsQzFaeDE5Ynh5SjM5SUpJQW1Ebm10emxx?=
 =?utf-8?B?c0IzeFBGOXNWTURnOTJrOXlPdVVxYnJ5QlV5WFpWY0NDUUtFRnUvNHZPWWtQ?=
 =?utf-8?B?Y0ZUZU9iVWIwdnNNTFlSTmJBV3hTa2ZsWlJoVk80NTdLeUVnWUNpVVM5R1Z5?=
 =?utf-8?B?d1VqS25VQWwwTVlxL01EN25mS2lMMDdZcWRjQUcwTElDaDhTSThSeEdoSk92?=
 =?utf-8?B?TnFjWkRIMVVxRkZ1YmVHbHd0eGJNTmpuSlpUZW41dkhrdFhscDY3Y2x5eDJh?=
 =?utf-8?B?WXdxOUZxSFlzbFRaLzVSU0QwUGtTbkg2U3dibm94bUZvbGFlYk4zUGVEREZ4?=
 =?utf-8?B?ZzhrSDdjVXpsa1ZGOWo4MTlhd0xwNHhVYlByc0lXcmgzL09pNDEyU2NjWU95?=
 =?utf-8?B?L1N0NjdvWG8wbmhpSTFZOW13c05XMGR6OGd2UTdmQVhBRTVCSlZNNUhjMm03?=
 =?utf-8?B?N2wxcXdEdkRpY0grRE8rYWlEUXhtT1puM2EvdjIxY3BGNEd2ckdVZ3Q1RDY1?=
 =?utf-8?B?T3JDRnRyUFpGdEkyZkJPaXZlOUMweU5rUFNIVU4yQXhPRVpUY3FkeHk1dzFz?=
 =?utf-8?B?RE82cW05Vk9BQ3VMaHNwc3orNkRYTHFGUW8yc2tFRGRtMklXbDdiVGFDTE1X?=
 =?utf-8?B?cjNLcEtwTllaWmdDMDl1UjROUTUrNTlzODhjQ2pDRXNoU3ZFSnVmSlJ1VENN?=
 =?utf-8?B?bk91RmhTS25Vai9qR3Z0UWJWN0VsTlBENW1tQUZhWWRpN2w3Z1hVRTlLQkV5?=
 =?utf-8?B?b3lQS09tRnZJdDBCdTA1dTBzSmdNQkRqV1liSHRTaGdvTlFZMktoYVRsUW0v?=
 =?utf-8?B?QXZIcmt6bTJZbnhwVXFtM2gwd2ltdTZJMjdja05XbmhQVmF3U0VtbHg1MldN?=
 =?utf-8?B?VFNQeHFPWElEY1hFNERFck1yNVBscmY1anZ5OW8yVmxDT05Ya0hzN1E3YVVv?=
 =?utf-8?B?NitmMDdDVHZHVmR5bHJGUDFvZlVGN1ByQ2NEdk5DOEM4aXdSWGpRRlVMK1hP?=
 =?utf-8?B?b2Q2VTVhYk1KRFJtSktpL3BjV01INTFJRmFZNThNaHpTUmxDdDVRMk5vVkF0?=
 =?utf-8?B?WDZ0WU1vSzdMTm1pcG0wazJ3UURueTFuZTVnS3ZrSW5TUnFzd0Z1TDVaMG9n?=
 =?utf-8?B?Q1duWGRGT3pLYTFYd3B5enpQRVljNlN1ZnR3RzNoMW5pYlF4NE45YjVHRlQz?=
 =?utf-8?B?eWYxc3FsWE55Z1NMdzFRbzJEZ2JQYjdEMm9HcTkyckh1YjNwVTRVNGZ3MWln?=
 =?utf-8?B?NE1EdWRNZGJFTlF0K3FoMGJFUDE2cDlYQXNRMSsrWmx5Y2pGMlJlcG1vRmpm?=
 =?utf-8?B?bUc3RE40YWRVZGFPK0o5MjNmV0tnTi9IUnd5MXkzMWhNYzhISzdHbm9iZTFz?=
 =?utf-8?B?WHF1RnVMS3Y3a242Z3cyTFlJcXZOTWNDWEExdk0rOTdHTUlNUzRNMkd0ZEtF?=
 =?utf-8?B?TDBIL01tYTFQdHZiRm5GRUtOT1RKY3ppeEQ0UWRBeXZpMVVrMmZWd2RFNlIv?=
 =?utf-8?B?YUVVbElRQjlxU0xVUHJ5ZGU2RHVObUd3STljck1qWjFwYi9iY2NzQWRtTnZJ?=
 =?utf-8?B?amw4RmZlNTk2b2lac1p2amNzZ204QVRjbGhlTVhBN0hPcXdlMm50YUVQTWJz?=
 =?utf-8?B?aVlBS1FpNEtFS0dTNmlzV25lYVlVUDJjL283Sy95b3RUeU0yZy9xWE1IY2Js?=
 =?utf-8?B?dzNEK0M0ajdrUXVxL21pdlh0bUp1ZVhGeSt4N0M4aEdlU3c3Nm42UDhFL21j?=
 =?utf-8?Q?ji1QwBxp1q+K+ZvgFcDNBrBPRgos1hrPTGNN9DB6/bi7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1026104B4B33DF41AB8196170EB4E3B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0485c1-d7c0-48c3-2675-08dac7424d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:48:00.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H81o7sqLf/mM97k2M6SnwcXgS/ksARYq1nq8Dgb3n9Xd2q4RKTHhjBGGO6hVPzUDokBMJOKr/upP9gGARZVD4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

U2hpbmljaGlybywNCg0KT24gMTEvMTQvMjIgMTY6NDEsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90
ZToNCj4gSGksDQo+IA0KPiBibGt0ZXN0cyBvbiBsYXRlc3QgbGludXgtYmxvY2svZm9yLW5leHQg
YXJlIGZhaWxpbmc6LQ0KPiANCg0KRG8geW91IGFsc28gc2VlIHNpbWlsYXIgZmFpbHVyZXMgd2hl
biBydW5uaW5nIGJsa3Rlc3RzIGJsb2NrDQpjYXRlZ29yeSA/DQoNCi1jaw0KDQo=
