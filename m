Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD3C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 07:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D00460F6D
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhIGHGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 03:06:40 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:19424
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233576AbhIGHGj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Sep 2021 03:06:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3oKUW7EiD3A7WJY9HCn8SscSnoljzc0ZLeGzYqiu1k2Ydf8DYXp7rLF2JBrrTxDBeHLUOT3F1ahURigDyg7iJVCQFpGvv/7HsO8aAfYkLrbhrCfDBAG/gf1OUv2oU7HCYeId+FxXY2WmH3J3oRZDI37JB4cDfn5Is5Qy2Mqu6KMGgg5hxwcuCYCLeYcHOk3E+XmBpDk4223Lerpnj+TKyPEDuoqhlCbdajBkKvu/UCPQPTVrEOHqBcQVEyUSfJWfIhTicsr2Ox9HIPLyoqQg5mCE2wtn9VxcCB8bQreAXy2AmsT0XJ89IFdh+u2U3FYmpAcaqs7xz6q0TxZqZbCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yS3mprLQ+YOxMcQASRGey5iBqnhbBMeEVqyzn1eLXqk=;
 b=dRFj4zzSCRaw4jLpes83iIMZ43/fLaWm3vfCSQXWL4XurxiS1UgOKFmN/iL/649xhjYAoi/Li6aRCOs82PDt2H73O/U1fNodxkQCRKKYZ8w0tN76eAqvo1QIlVZek8Z1FPTD6FIFnFHwmV1JGKpaGeV2qQo5uPqo/FXOvTEN3fsKLOEPT9DynfHsaSupcejmrzB8BK58HDfWmAyrzQCk8mY1hxpbOTlKH18Pd/aMeavt+Ri29aFEH//WjXa5E+CUpQAznY+10QgJg2l+1lNsKawRJsc8k3kuj+nvSqsC+5QBKsXeRGm1SWD7icvUM5poKkUd9l3Am+pmcDxBuMQ4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS3mprLQ+YOxMcQASRGey5iBqnhbBMeEVqyzn1eLXqk=;
 b=kOJ+CQfuQABhwMjtwjQiMdvS5O87woTxAmi7hLJHHhYhCNH4OyxcxYTjKlixrYxvs2UJNjHfLf1NBPz7ZH+My+5M/zLTHfaS3juhixYEPUzWwDR0ik1UqakM7FMmfdxJZExn9kaBQwwsfm0l6XjrrylN3iARPil/xzOY6+MAKQ9yYlxhE/n19myUVaybRBsGf8Nn+nS3fINXt3ZK/aA0VsQo6gKczOpBxZlrq9HdM4f7YmQH3o4cZal8+ZZvGmg5XcRQF3+z5efcJlTuuqMZaIuZPTbXjCYOrJsEcAP4N1dOs2XwFthDTB8L9Dg3je2/iAWuT1iGbOgmlzVRZJkOcg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0014.namprd12.prod.outlook.com (2603:10b6:300:e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 07:05:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 07:05:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Zhu, YifeiX" <yifeix.zhu@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "Li, Philip" <philip.li@intel.com>,
        "Ma, XinjianX" <xinjianx.ma@intel.com>
Subject: Re: blktests nvme testcase error
Thread-Topic: blktests nvme testcase error
Thread-Index: AQHXotDIQ1BReCa/Bkq4w9G+UpzGzKuYJ90A
Date:   Tue, 7 Sep 2021 07:05:32 +0000
Message-ID: <b26b4808-fd69-04fe-dbd4-fa45fa75b5fe@nvidia.com>
References: <DM6PR11MB39327C5E42F053888DA37BDB84D29@DM6PR11MB3932.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB39327C5E42F053888DA37BDB84D29@DM6PR11MB3932.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5f6cf97-9610-4721-da3c-08d971cde221
x-ms-traffictypediagnostic: MWHPR1201MB0014:
x-microsoft-antispam-prvs: <MWHPR1201MB0014B63063289F00D0629A8DA3D39@MWHPR1201MB0014.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+CGKsSKyVb3jh398m3x9IFA0lAfJm9gIZpgFdZRcAIO1/ZPSBOnCYFlNaCr1A3t8UWEzOaePHmVCXf8WH34Y87Mxv8vjtPgJ01h5nslTYFEiHGIMpUBaJG0amfZhdJZsm37NL9fMjffahmiVBeJpTjAa7B/0+h9vCdtLs7XYm06HKeh2pYkCppFIEla+kqNRVm8q0NGsqoNhjGuR08Sh0Z4oHWoGrHbeaaxtpmb925W0dE4Fym9jiU/LLiRsM1lm7u+1/+Y874bmaC8wYBqvzedU5/i+jKVUl5NFcBqZZTD1uVxBlxtcMbywTgZVfo0GJCQzbWYdoag3Y6KL3LmNTpyC8mhLpKjPhrNTvBzFKHxgdn57YIaO68/iqf0hVJCRMJafYcDbtEoNbVpYXFNbP5kI7CAItZHHpLoEgPEAEX3n2ycSAV3eDFxq6kLxSQUIpIquUt7EJD0LHq0V8/SqDKmkNX+/NxwdWhfBEoVsuD8xI/YG5G8drWcruTJtM2eR+Yutpkwir+C0O877ZQaEoda1moffbJ0mkLC4dulM/bnh2Ynk0KF7msHlZbVdFlXSc0ZR+XKD1+SpJs4r2jH0HBbGXKB613hOJCFVGHhwY7voVYxzcU3GDe+mDBRwXUSP0YMTMLfR3uOp/KnAklO1/r5v+2dUpQgweokqNsExjIVr2bO2n3O+UzHwtA5YSLvFYhFP3qsqPZu596CdABPpABzYXKu6wLXoZIofWxr3rui+f3rDtJSo2ijOeLSeuS3yN/OIZP0MHNmwwLmxbYOFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(86362001)(6512007)(6486002)(2616005)(64756008)(66556008)(110136005)(6506007)(31696002)(4744005)(76116006)(478600001)(186003)(66446008)(5660300002)(54906003)(3480700007)(2906002)(71200400001)(31686004)(316002)(36756003)(38100700002)(38070700005)(91956017)(8676002)(122000001)(66476007)(8936002)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?U1pnTUVWb0pwb0dJdElZclpkL0VuejBBTkg0NDBHK3NsQ3Z3MzBqQU9n?=
 =?iso-2022-jp?B?c3BuL2FBWk5PdGhCaUlENlUwdnJLd0xpWmR2dTgyaUpjTVN5aWVTRnNK?=
 =?iso-2022-jp?B?UnVsbTRqZ0RVT1hyV0pVa21FTzdPWlM0ZHZBTklncDZlMVpIZW4yYlRI?=
 =?iso-2022-jp?B?RVdEQTRXcUlWWnNNU3JhWkNVdUJrMG90VWw5R01MREs5T3phbXhnMDM5?=
 =?iso-2022-jp?B?azhBeHVKY25LM3RBUHc3cmJqNmNNS3NZWHFQbzhYdWUyWTdOVk5wSm1V?=
 =?iso-2022-jp?B?UXY0NitibUFvclRFUG9UdGVZdVFoODdVLzRDUVkrNFhRdURQS3F3Qkdo?=
 =?iso-2022-jp?B?eUEzQVNaV3NqY1Q1andkVHVXYzRtL0tQQUpzaExvdkFPNm9RQitDbEFX?=
 =?iso-2022-jp?B?YjQxQVZUTTJVcmVMWmF3MDlSSDFRam1rcEFUVGtERDlDbUQ3SmFiTEFt?=
 =?iso-2022-jp?B?ako1TVdBVS9ZR3RROHpEbXV1eEFESGZLZHJaeEZ5TEtIRzVjYnBJZ1Uz?=
 =?iso-2022-jp?B?c2pmK2UwTURkZ05YTmJiK21TbndSaWxNVFBXd3pSbzMvWndSczMzNDNs?=
 =?iso-2022-jp?B?TDVuWjJBeWlqdWJxclJNVXllbk11T200Q21WdVBpdXUyV2xPNERPcWQ5?=
 =?iso-2022-jp?B?bG91eUhBSG9nNUhHTElrNW1DaFhWTEdQWEUxcXFGSkV1bEowYWR4WXB3?=
 =?iso-2022-jp?B?WkxNR1FDQ1U5c0Vxamk4Zmp4MmpEakphY2c4SXFjUUNvUWVSOUxreUtv?=
 =?iso-2022-jp?B?Q2p0cUdhY0xoWS9FZTE2M0U4TExQalplamx0OVF0ZlgyQkV0czJYZ2Va?=
 =?iso-2022-jp?B?ZkxZbjVmQldSTXRnZTZCSXhNUzE3czVQdmVTVVhnMXpVcVBMekRHeVI2?=
 =?iso-2022-jp?B?bnkwZGRWTUxIbHlNai9vQUkvZ2ZpZ3Z3aDVLT1RVdmxVUnd5VlgxQUts?=
 =?iso-2022-jp?B?NkhML1dXaU85TlJzRFF3aEdsQ21XYi8zYXphMVh2R1NqYzRIeGJxRVRT?=
 =?iso-2022-jp?B?NVJudlRkOExEYlgveTlZbE9vamEzczd1eTFOL21RR2FmNUpubVRlUk5h?=
 =?iso-2022-jp?B?c3hrQVFDM1lPdUlGUVFMQTRrSlZzbUNmRklML3YzNzhIUDZROFpkUkZG?=
 =?iso-2022-jp?B?elVzdTBEYkt2S1hlblNoRHJ6WGtYQWw2c0pnamdydnNkVmpqa09NbG9B?=
 =?iso-2022-jp?B?THllZWNldzAyZENxdjdkWno3WmdEWGJ1QWwxeURQVGVoWGhEanhpUXBW?=
 =?iso-2022-jp?B?SDBqMlNDNGxxZ3JsOTdGMXhkaCt1cFE0VTFxcDJXN2xZb3F5eGk2bUNX?=
 =?iso-2022-jp?B?cHEydE1heU5tMTRCNzMwWjhaZkhuTlYyLzIzTHh1bUIwUjZVYnlkWGw4?=
 =?iso-2022-jp?B?bTY4YjVTSzhlaDdwN1E2cG4wUVUvM2NKU2ZYSXVSWHVWcDBLdmhLOUNF?=
 =?iso-2022-jp?B?QW5WWmx5NkJuM0p2MTNnZXNxck8xc2FMb1lEd2RmeEIvemZveFpXdFFx?=
 =?iso-2022-jp?B?M1ptRjRwQm53d2wxUVljQ2l2ZVBIWkFxVnh6UEcrRFhXQjFBeVNmbk9a?=
 =?iso-2022-jp?B?S1FYSW50OGhxU0U4M054RGE5eGx1RktXdVVJZzNZSVhLaWRmdndUMUpY?=
 =?iso-2022-jp?B?eGI1VzUrZ2k2bDBucnVPVXBqU213NENtM0pZMk9CbVBpZDlJUjZaMlNo?=
 =?iso-2022-jp?B?ZlVDZHloVlNySGszOWNzUTdKQm5mRWFpNXhhUlFTQVcwMmw2OHFZVTI0?=
 =?iso-2022-jp?B?WnczdW5PYU5PVUVXYXhIZFllRm1JbjRoSWpidEtsU2VDYzZYTVBrSnlH?=
 =?iso-2022-jp?B?ODJuRHFaUzViYzdvQ09HVDhuTVVDT1BWUVlxeHRTc3NyVWRIckY0OGJR?=
 =?iso-2022-jp?B?Nm52eGRVM3ZWQnRtWkt5c0Q5ZWYwYzJoVitjVS91OUFpVzdCaUF1TkVB?=
 =?iso-2022-jp?B?cDdqYzljSXB2U2hMa25OaWlCZ2pyYVpJSWEza1czeGx1RTNNMC9nQmFS?=
 =?iso-2022-jp?B?Zz0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <3682C2C42F820844A0F696292795709D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6cf97-9610-4721-da3c-08d971cde221
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 07:05:32.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRsEHfTgKnQaVqeSuzjPzdRmKCFFf7nsLfbjjA21an1jW9FSh7GLyvDfp5Z52NYbT/yzq2gA8250iLoOipYOag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0014
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> CODE=1B$B!'=1B(B
>      221 _create_nvmet_ns() {
>      222         local nvmet_subsystem=3D"$1"
>      223         local nsid=3D"$2"
>      224         local blkdev=3D"$3"
>      225         local uuid=3D"00000000-0000-0000-0000-000000000000"
>      226         local subsys_path=3D"${NVMET_CFS}/subsystems/${nvmet_sub=
system}"
>      227         local ns_path=3D"${subsys_path}/namespaces/${nsid}"
>      228
>      229         if [[ $# -eq 4 ]]; then
>      230                 uuid=3D"$4"
>      231         fi
>      232
>      233         mkdir "${ns_path}"
>      234         printf "%s" "${blkdev}" > "${ns_path}/device_path"
>      235         printf "%s" "${uuid}" > "${ns_path}/device_uuid"
>      236         printf 1 > "${ns_path}/enable"
>      237 }
>=20

You should be able to get the error in the dmsg, please share that output..
