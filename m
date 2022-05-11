Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF93EC433FE
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 13:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiEKN2N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbiEKN1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 09:27:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DD6457AD
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 06:27:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBwxZ8032663;
        Wed, 11 May 2022 13:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6oOJWswMP6twDl8oFU0YJ1wDnKMSuK++jiCTIbI+CkY=;
 b=rbs6p9Qci1J/0Rr+sG2ci4qcGXHdFCkG8moXa/BkKZQonTmHkCIAbTNgC/SxCThPCedS
 ouxKi6RwZO/s/3hoxjNnB7Mb/nnb5ZPjKeiwEz1e+aSL4Jno1eV3et4U6gSfK0c1IFiE
 9a4f7ipxTTu12QsUsV/ioCM7CVq9ddtVmsA4w6ls5mBD6DWMr78133AAEmwShFALjAvs
 idff+1rlFY/ViMtnQiRg6ZZlVTFEUBcgSNq035x+IzER0QRMAdfm2LXlQ5MJUCXRXmie
 JCsYdzt3GZGLjyJ/gDXO9ySqGOgWlGS10Brf0WZ+QP1feaZ8sfUI4nSqH4sCSOdTqdKf dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhathrvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:26:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BDQjfL022066;
        Wed, 11 May 2022 13:26:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7akpvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 13:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+k6zcZGUJC0vHx2qk28NIu9PARDllzks4zZbMvwoV43SkBOoslBH6SYPk6Ocy0XC7/pyeZRmneSnDpN5wCZNkp+jrHFq6PNjwbUBrjyUFxEmbv8ay5c5CL9SNTg9dlsGUgcmLT+xLKzm8uJzHsK9lD/XeG6j2MbxuV7JduuTb3sZ235SHcygSnYjKyw/Qj840+rD+OXzsF+QU+Nvf2ulG5Qvwn+9QHGoYKZlu4vUVvJP+8DRqDXDAQt+Jz1deRpHeW3+xtJNQZuhTKIBvGllvFJFANG0iQFfnTqSoBncE1lDgEMKnFzaTY5f6bV3dl7vI/oBNAmTWi5xIcd/01Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oOJWswMP6twDl8oFU0YJ1wDnKMSuK++jiCTIbI+CkY=;
 b=YgwvGKhB8/3lVI2vixx5iz0t19e2dIGQqaFT9ypQarRE2DeWJOvSFG/YQ0bSOifySDU/XQ4/hIwOGsCaZYUpMVX+r+EmebizCyrl6KvdAaLFcP2bxoTnV2hbKJIxwOPmb4rPDJER8CvJRPUkUGY1Lb2IstspPuH7aN9mHGGvpOvhp09mWjj0JGu02srs3KvX16Kr+qORVzt/cCgWkINzFZoaYuUQOGqQRV2tRDrM+2YUJAinFRynwHZGJp0Xfxg97kmxI6T5xRwebiLZfZ4GBpaAcmeymWi+uDHBm6RALQgW1lsobediWCSd1JpoOclK+kmFC7JU7MMkJL1MHQxbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oOJWswMP6twDl8oFU0YJ1wDnKMSuK++jiCTIbI+CkY=;
 b=pXnBjmCI3GxgsM35PfUsAFGK2EGqUX/nG94rxssvZq1C7/asdF5sYN9VrsNoFrINUnb57oqCnwXIUYehuf7W+0jwm6B/ZFgi4sWsupl6FeQWb+jItoQoRxCOE8JCBlnJNANou6In2RNj1Q4IIhiH/UVK317AzsPNcTY9QMr+7qk=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH0PR10MB5289.namprd10.prod.outlook.com (2603:10b6:610:d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 13:25:38 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 13:25:38 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYZI0OewODhGjHlUewQQ2As0BxIK0YUO8AgABftYCAABHNAIAABVqAgAAMyoCAANeEgA==
Date:   Wed, 11 May 2022 13:25:38 +0000
Message-ID: <8831D794-47EF-4094-9D81-B87A14EFBBA1@oracle.com>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
 <20220510164304.86178-2-alan.adamson@oracle.com>
 <da090342-f3c5-b3fa-d062-553a4f8a522c@grimberg.me>
 <20220510232919.xoxet3k7cxboixmt@shindev>
 <6eab7100-168f-e371-dbc4-a8946925099f@grimberg.me>
 <20220511003415.d5s5jjpw47kejcb2@shindev>
In-Reply-To: <20220511003415.d5s5jjpw47kejcb2@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fba9dba-ad89-45a3-4ae4-08da3351bd01
x-ms-traffictypediagnostic: CH0PR10MB5289:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5289CB58ACFBBE60363C59E5F4C89@CH0PR10MB5289.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59hs/3d/Si2NfIH+zfuEDptGhOXUGnD97/zJ5VWUN1YCz+PobUQ17zX14kkz7dN1KK0kC582XRVoFlP03jGS84nXBO+cYIOwFizhnEyTLhkpgo54nwf1SpuR4QRPZEiUR6uU3qBGlh79yZbnmO3dvih9zVr3ITn9mg5fG4m82Rv2Rzz0UZ5XMVvVmHKaOCrYuCpvERbfL6ihAG4Aqr3SixTPO4/SReGiBrV3SOxRSFuy9m027vPfko61ypN3/8RnbYSkJInfXJDeBYonzSMGEf4W6hOFDUKvqvlPodxrufNfo0k7du1radfcE++D34pD9/7akuKYb6aMk5HXGpxvQ8hma+jvWLavI4hOwjtSGkW8MC4sFcwC56Q+fmwChvGDI8s1Wkii27x1oVrc3jYBwianY+EHf/wZqmWivlTuGZq9VvY84zCP1QBAdi9NlM44A1UUxzTyY6OfGa4Q/V40sZTjais+Kgk3G55J55RnnEpTmFOXDf8wSGOg4XeKt8qt+56Y061A4MfDR1JxLnkWYg9j9+nPSAMWAENNPyWW4SU42aABCDYsysBgmv7wBVx/vPeEoyY4zq7n7THI/jwipxpDqwQSFf2KecwiBhWQ0lJWPL6GE+yBVtz97y2Ftq1Oq89eEEFQtk+Nc/NE9YHGqk0AVKtKf1W9BilcP94I3Wo4kkmbkqGx4tE+hhO0OMUwRlNDwHU2+WUfDlPm2P3enFqG2QBZ77VYULqWwh56Oezvpk3RUjiPc9ZFCDJRVJI8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6512007)(122000001)(76116006)(66946007)(54906003)(4326008)(66446008)(2906002)(38100700002)(66476007)(64756008)(8676002)(66556008)(186003)(6916009)(36756003)(316002)(91956017)(6506007)(44832011)(53546011)(6486002)(86362001)(71200400001)(83380400001)(38070700005)(33656002)(508600001)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cNEUh1nDGEgLMzzIVOsoNzLPFQT6GIAOAW7RIEDfUtpmKJz2Wy5ZsFOwf+ce?=
 =?us-ascii?Q?gwZFEjrMOUFCN6HtSWUBTMySY5XxdMrjQBPaNkXyn1T3HbYQeECQ/BGCLRu/?=
 =?us-ascii?Q?pkR17+1OFtplSnvedWD/w/YtVKt3ZvqV2SY7OSvg7lfTXe8RqCGlkhgJoMXE?=
 =?us-ascii?Q?/bFIutUoxqKDYdmjlFGYrvv9vFLzdkLffkkJTF4VECCf4Ee5UCM2lmlJt10y?=
 =?us-ascii?Q?sorJnD9oFoUq9R/nYXpBsBWH7WoqslTQdD6pQVhTRjHpuK/VW0o6/LIWXOGl?=
 =?us-ascii?Q?AQk2p1hLL8qsuQz2IL25MtPTXoyuVdjE8P3pHXvUE6uoImanMBvSdMIbkUkV?=
 =?us-ascii?Q?WXJH9v1mMBsJARHld4Pc+EuWKG6cAEcY6LgmQ3gxUyR/0+7ipzuk7bszIdCm?=
 =?us-ascii?Q?Wydq5iuVwO+aaLQF2A4LnMzZ2xHnbzGiwnxQ0MHIusTXEgZ8VRi8C1Kotwwn?=
 =?us-ascii?Q?lLRg5o6X6WtK+ZFLLo5M8ANB83vP3KuehremtRh22HEd2hc9Z1lTY3WGFP+c?=
 =?us-ascii?Q?mK8m0zyjXz8B0RJOHLRQWdJ7EPcJSDHStO9BDCx1tuVfQqOL90tDC/aaLCQZ?=
 =?us-ascii?Q?JrHWMyhWuQqAShdiMuNba7C4FCNkqsNjnrOdxPADUHSgm8gNVRXqWeJ0LPHq?=
 =?us-ascii?Q?bHbcJfV89/zYn7wdWd/dZELjSaqrmgmToyqDH49LMN7BGG505h+dU9SKxumi?=
 =?us-ascii?Q?buEFh7Urx8OMMybiJmo0z7GN5QgN/GcNb7yeK+A1YzO3V6G2WBvYPMJcWjbk?=
 =?us-ascii?Q?zct3VHGnszaavfm+xV8egCNbnPzTXsAccBxTPFlw5aMp3unPNDH4GxytdsZ1?=
 =?us-ascii?Q?D2Fa2iZUv6XDTcns0Oeo5dC9V/4xFa8OvuG7kkpUsc3e5MfEqAH6OzoP02+T?=
 =?us-ascii?Q?QG0y5Einb9AMDzJO/F8O7QtgcsyVKVCb0+ORXsSB1sMlm6M85HyI67qrugZm?=
 =?us-ascii?Q?MErBLx+iegu7L96ju9waTl2L/KUaOT0+rIi9Ff/6DYyRXA1rw9jkwdCfMJQX?=
 =?us-ascii?Q?PB2N6UeG7aBG+dg5Y2tNXd3XFWaPjEiE2ps20eG36qIZwAj9lBkg8Lwgiss6?=
 =?us-ascii?Q?wkoZRRMJDgTOmf6VoCIiA6nweOrYMM/K74Yf2Kus/dgOH1Ivh8bZadiPHDO4?=
 =?us-ascii?Q?pxIlSIsmM8w+DVShCj5RMasPN+IApithk1byJeloDboOJBzMd7LyV2Dqp85D?=
 =?us-ascii?Q?NNTSU2xA7EYhD0NWpXyruEM2OTLi753G8B7hf86VApowpOeR6o+QTfYrqiHs?=
 =?us-ascii?Q?Fd6XbjCwnjpvXbLWN35NazrSSqOQUtdPZET5uK1d7dAaWHcv5yx4KFzzV2R7?=
 =?us-ascii?Q?pzyW18sPfREEvUpSGQVux3LAK/sw3D2IgAwwxvdj/1lQeqIWFQz/fTYSAIS8?=
 =?us-ascii?Q?wzzlobiGtfxep7wLAae5Ai76/DF+nKMAPk5yy0DBohWw28UMfKQ4NE08PGzg?=
 =?us-ascii?Q?x2j/ez1qmRpI8VGTaLUoV1iNqU9EVyjeZg88jXRqdOKGwM1pxTEChFIXq/EV?=
 =?us-ascii?Q?WhOWc9RkSVzvvBoQ0VNtyb7+lw87TpDIoq1zcB1yGau+z9lNgU+/ka2HM6dL?=
 =?us-ascii?Q?3wWXr59b8twbu10hkUlJXUCEjdeDAmADof5JUsaPGc1PRcD6tTtRgbjqLu4Q?=
 =?us-ascii?Q?yoTWUx3Qn3kM9Oa8yJiPdz2TAbpkdr0PvSHs7n5FDzD0eez0hUrOgJCrxsiI?=
 =?us-ascii?Q?Epw9+YetihonmGaB3I6QMGXT7751HMnX3ugUt1y+xBi0YmNvwa7xwUyQUvy+?=
 =?us-ascii?Q?CZOOqQ3NT5pi03EtCINeNmbPxZz/+3MbxrQQkDT9v8Mgn123pFGWg6TPbPF+?=
x-ms-exchange-antispam-messagedata-1: hJcdUQIBtkPiZA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18BB97D881820F4EAF4EEFF2573D78CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fba9dba-ad89-45a3-4ae4-08da3351bd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 13:25:38.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ru2FevsXs7UH+5WuzZ5C01Pl+qPzBPDbkPFgR0+Xf/xAyWVSrnJ+9ZT0Fsrk3dWyV4rg2w3xSM9fRkPow7oZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5289
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_05:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110063
X-Proofpoint-GUID: 1xzViA7Ifk4uiMO-4VH5aoCyEXxvJ8u2
X-Proofpoint-ORIG-GUID: 1xzViA7Ifk4uiMO-4VH5aoCyEXxvJ8u2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On May 10, 2022, at 8:34 PM, Shinichiro Kawasaki <shinichiro.kawasaki@wdc=
.com> wrote:
>=20
> On May 10, 2022 / 16:48, Sagi Grimberg wrote:
>>=20
>>>> On 5/10/22 19:43, Alan Adamson wrote:
>>>>> Test nvme error logging by injecting errors. Kernel must have FAULT_I=
NJECTION
>>>>> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests =
can be
>>>>> run with or without NVME_VERBOSE_ERRORS configured.
>>>>>=20
>>>>> These test verify the functionality delivered by the follow:
>>>>> 	commit bd83fe6f2cd2 ("nvme: add verbose error logging")
>>>>>=20
>>>>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>>>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>> ---
>>>>>   tests/nvme/039     | 185 ++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>>   tests/nvme/039.out |   7 ++
>>>>>   2 files changed, 192 insertions(+)
>>>>>   create mode 100755 tests/nvme/039
>>>>>   create mode 100644 tests/nvme/039.out
>>>>>=20
>>>>> diff --git a/tests/nvme/039 b/tests/nvme/039
>>>>> new file mode 100755
>>>>> index 000000000000..e6d45a6e3fe5
>>>>> --- /dev/null
>>>>> +++ b/tests/nvme/039
>>>>> @@ -0,0 +1,185 @@
>>>>> +#!/bin/bash
>>>>> +# SPDX-License-Identifier: GPL-3.0+
>>>>> +# Copyright (C) 2022 Oracle and/or its affiliates
>>>>> +#
>>>>> +# Test nvme error logging by injecting errors. Kernel must have FAUL=
T_INJECTION
>>>>> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tes=
ts can be
>>>>> +# run with or without NVME_VERBOSE_ERRORS configured.
>>>>> +#
>>>>> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
>>>>> +
>>>>> +. tests/nvme/rc
>>>>> +DESCRIPTION=3D"test error logging"
>>>>> +QUICK=3D1
>>>>> +
>>>>> +requires() {
>>>>> +	_nvme_requires
>>>>> +	_have_kernel_option FAULT_INJECTION && \
>>>>> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
>>>>> +}
>>>>> +
>>>>> +declare -A NS_DEV_FAULT_INJECT_SAVE
>>>>> +declare -A CTRL_DEV_FAULT_INJECT_SAVE
>>>>> +
>>>>> +save_err_inject_attr()
>>>>> +{
>>>>> +	local a
>>>>> +
>>>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>>>> +		NS_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
>>>>> +	done
>>>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>>>> +		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=3D$(<"${a}")
>>>>> +	done
>>>>> +}
>>>>> +
>>>>> +restore_err_inject_attr()
>>>>> +{
>>>>> +	local a
>>>>> +
>>>>> +	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
>>>>> +		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>>>> +	done
>>>>> +	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
>>>>> +		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
>>>>> +	done
>>>>> +}
>>>>> +
>>>>> +set_verbose_prob_retry()
>>>>> +{
>>>>> +	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
>>>>> +	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
>>>>> +	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
>>>>> +}
>>>>> +
>>>>> +set_status_time()
>>>>> +{
>>>>> +	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
>>>>> +	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
>>>>> +}
>>>>> +
>>>>> +inject_unrec_read_err()
>>>>> +{
>>>>> +	# Inject a 'Unrecovered Read Error' error on a READ
>>>>> +	set_status_time 0x281 1 "$1"
>>>>> +
>>>>> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect =
\
>>>>> +	    2> /dev/null 1>&2
>>>>> +
>>>>> +	if ${nvme_verbose_errors}; then
>>>>> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	else
>>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>>>> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	fi
>>>>> +}
>>>>> +
>>>>> +inject_invalid_read_err()
>>>>> +{
>>>>> +	# Inject a valid invalid error status (0x375) on a READ
>>>>> +	set_status_time 0x375 1 "$1"
>>>>> +
>>>>> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect =
\
>>>>> +	    2> /dev/null 1>&2
>>>>> +
>>>>> +	if ${nvme_verbose_errors}; then
>>>>> +		dmesg -t | tail -2 | grep "Unknown (" | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	else
>>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
>>>>> +		    sed 's/I\/O Error/Unknown/g' | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	fi
>>>>> +}
>>>>> +
>>>>> +inject_write_fault()
>>>>> +{
>>>>> +	# Inject a 'Write Fault' error on a WRITE
>>>>> +	set_status_time 0x280 1 "$1"
>>>>> +
>>>>> +	dd if=3D/dev/zero of=3D/dev/"$1" bs=3D512 count=3D1 oflag=3Ddirect =
\
>>>>> +	    2> /dev/null 1>&2
>>>>> +
>>>>> +	if ${nvme_verbose_errors}; then
>>>>> +		dmesg -t | tail -2 | grep "Write Fault (" | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	else
>>>>> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
>>>>> +		    sed 's/I\/O Error/Write Fault/g' | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	fi
>>>>> +}
>>>>> +
>>>>> +inject_id_admin()
>>>>> +{
>>>>> +	# Inject a valid (Identify) Admin command
>>>>> +	set_status_time 0x286 1000 "$1"
>>>>> +
>>>>> +	nvme admin-passthru /dev/"$1" --opcode=3D0x06 --data-len=3D4096 \
>>>>> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
>>>>> +
>>>>> +	if ${nvme_verbose_errors}; then
>>>>> +		dmesg -t | tail -1 | grep "Access Denied (" | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	else
>>>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>>>> +		    sed 's/Admin Cmd/Identify/g' | \
>>>>> +		    sed 's/I\/O Error/Access Denied/g' | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	fi
>>>>> +}
>>>>> +
>>>>> +inject_invalid_cmd()
>>>>> +{
>>>>> +	# Inject an invalid command (0x96)
>>>>> +	set_status_time 0x1 1 "$1"
>>>>> +
>>>>> +	nvme admin-passthru /dev/"$1" --opcode=3D0x96 --data-len=3D4096 \
>>>>> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
>>>>> +	if ${nvme_verbose_errors}; then
>>>>> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	else
>>>>> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
>>>>> +		    sed 's/Admin Cmd/Unknown/g' | \
>>>>> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
>>>>> +		    sed 's/nvme.*://g'
>>>>> +	fi
>>>>> +}
>>>>> +
>>>>=20
>>>> All of the above seems like they belong in common code...
>>>=20
>>> So far, this nvme/039 is the only one user of the helper functions abov=
e. Do you
>>> foresee that future new test cases in nvmeof-mp or srp group will use t=
hem?
>>>=20
>>=20
>> I can absolutely see other tests inject errors. I meant that this code
>> should live in nvme/rc

Should the helpers inject errors itself (_nvme_inject_write_fault), or just=
 provide the functions to setup the
error injector (_nvme_set_inject) and let the test specify the error status=
 and do the IO that causes the injected
error?

Alan


>=20
> Thanks for clarification. So we expect two patches: one to add the helper
> functions to nvme/rc, and the other to add this test case.
>=20
> The inject_*() functions refer nvme_verbose_errors for dmesg filter, whic=
h is
> defined in test_device(). That part needs a bit of rework to move to nvme=
/rc.
>=20
> --=20
> Best Regards,
> Shin'ichiro Kawasaki

