Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 12:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiEKMKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiEKMKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 08:10:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE9A66CB
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 05:10:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BC257M003186;
        Wed, 11 May 2022 12:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LqAkSLp1Rmu3BNCIuh05NVg1VyiHobi3pOFx1wUbhik=;
 b=xo/SSSspfBMEJ6cdjOe1nPv709+6FpLj5tfnFMBxkd0SvmCdK3M53eARMV+Sm6IFAn+P
 54zxmyjZqgLYlWdP6Ni+kbm/Y+iK15PZZNSSbgqMPwyfCJS9b4B7SQ9TSOEwmUiDMSVP
 5eUqAI4i9eaV9obsY5n8hHrV6byea5LWlloPpsihZYhaMXUFwepPSTZ+t1foeOUGsmqk
 GMWFn1o8TQ1E4zg1hlGFyS8Tcv9ZcTB3PPzbYAlKjjOV0LPFt5/Oz8l8QQoGl51GUOmy
 GQw/lHW6DO2uT5lSDWLmuzYpcDcmcoHdqsIId47CoZvzib4rY1m07jd7NMC2jcp2pDEn 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04gf2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:10:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BC1RL5007718;
        Wed, 11 May 2022 12:10:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73hp19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 12:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqtEKHTB6eebBju4iMaO2iSUis0+XrU906l+DgoInVxFnhAV0297y3R1doqIECJ0pnnK8F8rHdD6mMx12pL46s2jyS1J5liJ/+bXpzUqqcan9DhraU1cqswBobsbr5XK5UZskivyBC8/CNgY3UEaRiqHp8INfiP0cPJ0BTg8cYxOwkhlxdfAaRhfGUsFfTS5He7uxftBeGEkFV8Qn/Qa+k3Mbk4KoDYnmyrNLsby0hxV70/PP3GqMn8g+7d3VTgWcfEd7QE1P/mHtetkd3eyVNffrmuVj/IXKKJkHdhQA4WOhElPQQPB+tOUOfrHZA7STA3LN/sAIfSUEUAMt6nKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqAkSLp1Rmu3BNCIuh05NVg1VyiHobi3pOFx1wUbhik=;
 b=CVzkuDMpTs75SQwtZ+0EdWqZjExZg9pIUUvmGNfMW4rWkQ5n0ny78D8y2JSeRu2mcUcrR7B4Vwzqp1xgpGuTM3TSdvwUMrGQ/r5aVG20lygVVZZS193Zb17z+6rs91j56G/unhSglJLCo6VrW2PiQ7tOc9GpqiORwX22e7rM6HHmVs0M+KkQ1jrO0JU+gUV5dPQbQcHTYkMLpXKlz9CXXKZv3LAq7189x7eTi5TOgXsFrozKpj655LgM2nYFOeLHN1dOqiBCL/HNblXhSAWnwM1EpmtV/jKmPehiHcMH8SGu1sUqO2QoEgCU2ynA9WA5IdYNjCLmL3kOn5d4tTpLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqAkSLp1Rmu3BNCIuh05NVg1VyiHobi3pOFx1wUbhik=;
 b=RnLfsyMmGecXTx1H/eQDyaxr/Tf4AMkcFousTLD5+aIKYFSxyjoIYBJjbQ8AKomq0A0zRevmY7eff5pQ0tgwLMTi6MSxjmNBAvZpPtcml0yafPp8FspA1IRrdCT/OMa3TdV/+rdxveJKFDCrM13B3jCWRcfoqHPiUZr7oHS9bHQ=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY4PR10MB1912.namprd10.prod.outlook.com (2603:10b6:903:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:09:59 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::a0ce:9eae:f6ea:493f%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:09:59 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v2 blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYZI0OewODhGjHlUewQQ2As0BxIK0YUO8AgABftYCAABHNAIAABVqAgAAMyoCAAMJhAA==
Date:   Wed, 11 May 2022 12:09:59 +0000
Message-ID: <CC4F2864-9F0C-46DA-985B-72E8640F05E0@oracle.com>
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
x-ms-office365-filtering-correlation-id: 79ad1ece-230f-4440-fb14-08da33472bdb
x-ms-traffictypediagnostic: CY4PR10MB1912:EE_
x-microsoft-antispam-prvs: <CY4PR10MB19124CB11B8EDFB67EC178A6F4C89@CY4PR10MB1912.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBLND3LslBmwACFDa3/5zi5Bl3Tmed3Y1Tvj+GfUrv6i4J48hcwZVuLSuBAhTGqocP2yJHOlLwHB+QyJUhPsjB42zC/WBxgx91uZN4+NstVIjxbYRRyPDvuERB/IqmNnMe7AR891Cokehj4csCWGcuou9tnd+elMVuvdDEMHu5SdPHhAQf1367Zj+6BdOrKf1v/m+NjiayWE3hySD0r33gVQE+6WKfXMNtyplkX9BghgQcbtoOP11ge72gx8UGfNsBVZF9pNpSI7Azd/AesRkZ1L/yE+VHoMRimLawcZGqxNQHYx9ScpNldTfJ6A0ZA05FRePutORNH77Ct4g5stsOUQFK2C++pgQ6UZVPREv/MHHX/YbM9TV//ZOka/VpzF8XNgkFuBWd7VKJM3R2aC/HzEuFZfjzcbe1DSo1TYN6iTGDJqu0jitwJQ6jH9OF0Y6u80q94HYoJ8le2k2l0s3LGecOXBs7PCvnmybGpKEbsz85mtaF9BMTDY1oMl9wa84s3ZAbAVimSO8+MlQCz4F7xbD3k2Zh/Pwwm3+Dcy68obZgvFTM9u42mCZuwdib1oVlbmsCbNNj9LGlRaDhhnoXfzZ71x0B8i4ga0p017a54arGG7SsVQjGuGoHqVxXx+irpse1Qy+lqDVKuR+YTWc3XDSFlL2JGkU9Vkbo6f+lS+p/aDhShIaIo8WUJgPfmB3VUtr/jE8yzwLe7rfyUL76wnCYxYKP6NWLCmLNHxWdHUypqSIxplswpo1RdiS4FX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(83380400001)(33656002)(2906002)(8936002)(44832011)(54906003)(71200400001)(6506007)(6916009)(53546011)(8676002)(76116006)(66946007)(66556008)(2616005)(64756008)(66446008)(66476007)(6512007)(316002)(38100700002)(38070700005)(86362001)(508600001)(186003)(36756003)(4326008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?blFc3evdR+gNEdB8YmW/Tx9E30gtvbMPDNx+TucaJbIqQhO1SY2N6RpMnheq?=
 =?us-ascii?Q?3Z8pa1LRTJqTry8WgNYknRQwNFBuXNowTTwAz2F9YvCFXfbKbRQXtp7T9w0s?=
 =?us-ascii?Q?N/tjXf9rrkay4JFPga+4gRtKPu+TdGtavNkAxdxGxcxUqwOrpR3iLSIaGqj9?=
 =?us-ascii?Q?zRSUeJSqWoye7F8inTVatodZ3a5oZoR+zTk519CvC4RINOpTr3n/e3F1zfUZ?=
 =?us-ascii?Q?TMbWSZm3tEd7fPZaU434LrPnxdoRK4MKg/yRFZg5iHZpqoUOTO4ZI7IpQGqb?=
 =?us-ascii?Q?ndQlOiZWxJ9og5P5iO4niIEnC1/CwomNhvb58RTZEkuXFxhn9i79m2e6UVnJ?=
 =?us-ascii?Q?M1j6VJHMlXUAhCKjZIGIhLHOtv2Uvgk4a0gJvujOwBiToVkY9F4hIaZh5foG?=
 =?us-ascii?Q?YxYVuwwugAezKiEn7pTh1nG+ErshveWrj1rk4aOxilX3rFS9sBY8KFrWAI7k?=
 =?us-ascii?Q?uTadfmPYD0Wc24oKCEopFhzjS7DLTHMQ6aDfLecYN2GpDoPhRacUiGoK5h3K?=
 =?us-ascii?Q?Iscw1fXXH/r0fPdsS/Fx1I69vwrG4rt9U3UFSSIuEwAikOyJ3W1E9Is2VVqj?=
 =?us-ascii?Q?lYVySr157Z8kefWNoz9npckdbhJfE8wcxxN3Rqeyqu0m/5I2dgaNCuexif+V?=
 =?us-ascii?Q?AeLPo4VZeCmGbz2MlmqzcpSVjT+LzIB+bDCGpsCSHVNoJ5fxKoxCuZH9l99L?=
 =?us-ascii?Q?YW7bNOlC6Caks2GbA3MqnS+mXLCR0BtPldUqyDiV0G63ZEVRv+VZSVRnCf2q?=
 =?us-ascii?Q?KCBuLAQO50tVMp4cffQMVQgguqoBo6rA3TwpaHh21k6/6Xa/LM7U1Trsf70C?=
 =?us-ascii?Q?h5l6/Qm9AEE2wI//H8JfOrL6z20JBxq6ZFxazXhBmEf/8Yio4Lu5xJDYGTWy?=
 =?us-ascii?Q?ZX6oN9Bp6/8571AFYYi4YJbG4jV5nq62+k9htb9rsYnfpnHpiCN85w4I0wuT?=
 =?us-ascii?Q?q50H7MTShqLERRQr4o2noQ2E9yNCYkbWI3hpeLDw2I/WaX/90I5cVirm4hTn?=
 =?us-ascii?Q?K8OW/uGJ5gL0JPoDPdgZz3tcYo9+Oz1LTpprHOxBF34x1gfgDfr/UOvQC+B8?=
 =?us-ascii?Q?IPPPNbc4Ip5CE+RIVHprysykUxOqoJtFm6GQNSVWIfwkGiHIElhHdFUD9D8h?=
 =?us-ascii?Q?xLdbE1/6/mZQx9x5PamXNYaor8Tp62TNlmE+3IWeCfnvi3zsaqT/cD81lRMF?=
 =?us-ascii?Q?XmPyoIATvvvPofvPAmY8qiyV9uDkX7ca217f7E6Mi2MkYY7Tvf0mZKO5eC7S?=
 =?us-ascii?Q?GwyDL1i8tYkJinWSMODAHDvqwEAzt0mNHpkN7jBfRbUy//tY1N3PK+FGCVI0?=
 =?us-ascii?Q?vDD/YCGPG67dEfvpdjeNFHZ+w7Mq3zQ6JE5KR6E5OcBr9/De7ZMwYTGCarCk?=
 =?us-ascii?Q?EdQ/I6c/qo1Fcnfd2lvZHLP0jDJQdKVkFxJMpFm8v1TTYatNSvt++TOdbSj2?=
 =?us-ascii?Q?ypwzcGt1i0mgF56lKZ1H239TCvPMV+YQtBYps8wrfnoje7ugGqrXn7D1p3UG?=
 =?us-ascii?Q?kS/b/MonGm1RdS5BI+vgemPgS1QrH5Y3YTCeRLGlcvCUMHLRB4St7Ge2LXM5?=
 =?us-ascii?Q?xwB6aHOnV/Ze0YLprdmMErM8wHj1//VhGK5iOUseH0Aw2DrwyA8tzcC+SwIg?=
 =?us-ascii?Q?DhHDUNRIOkA7vR5EuQys9kMLepMXkMAWOOFGK2pzYrZ7wDC2il7uxcT7wqZ4?=
 =?us-ascii?Q?TJi9uQ5MJtuLuqYXuGp6N/V2WNTsYV2j4ZMmviWkYp9+oYarYJNEqf6402Mi?=
 =?us-ascii?Q?WQ20y5xkfmdl5qupv9JfVLw27sqtGvuyTb11fCknlZQSvAqy28NBsfv0Id9q?=
x-ms-exchange-antispam-messagedata-1: X73i6TBggm9/MQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7A49631EFB1BB488E99EEDF2DCDDC0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ad1ece-230f-4440-fb14-08da33472bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 12:09:59.7253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myMX9rtCjejZzlsvQ2aUFM8XVSO5HQ1mmKpfFb6ZNEE2wkLuL7DaFMa16UDJ5dEy+lIJ5ogA0S2EVkkqEbbDhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1912
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110056
X-Proofpoint-GUID: 7quHl9hcYznImH75v5N29eYfEMw-PsFl
X-Proofpoint-ORIG-GUID: 7quHl9hcYznImH75v5N29eYfEMw-PsFl
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
>=20
> Thanks for clarification. So we expect two patches: one to add the helper
> functions to nvme/rc, and the other to add this test case.
>=20
> The inject_*() functions refer nvme_verbose_errors for dmesg filter, whic=
h is
> defined in test_device(). That part needs a bit of rework to move to nvme=
/rc.

Yes, I can do that.

Alan

>=20
> --=20
> Best Regards,
> Shin'ichiro Kawasaki

