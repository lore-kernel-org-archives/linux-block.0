Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70362AF12
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739576; cv=fail; b=A68A7AIwAUsQD+SmP8qHEQ1dpEeqgkoW4JvcR/h65uF+8CN/7TMmaL6Xx0X5oL2tB2TQeQoM8Tm1+d5B7Y/Vv6HDTlN280AWMBKcDHQWalD+yx1FsaAQKjVqNyG1Li5XDI0uUD8tm5FTtBG17RVvoC4fqDoP+t9boL4T/pq6ypY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739576; c=relaxed/simple;
	bh=AugA7uAjoRMQlBMldzLLeEFKr/+d2tQFDOShbW8b/2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lq8DLzyQ/UQrX1pIRaoHhRaSGJ3OrkKRMLzLOay7gveTxOZ41tW/PbkkN81Co0yvz93NVW3OvoHwrRnA9j80RI0L3mukcNJXiUluyh8p6PK7zRmRcN52Yqs+/VkjXkOFPM/FPDaxYQmpLavjyx3KYnnzgOaX1YMtIIgakjUxbu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HKDlhOHe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBOp5i0f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKDlhOHe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBOp5i0f"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtdjT017848;
	Thu, 15 Aug 2024 16:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=pe7jqCgiKkjExsO3sPMxYCr43xGKXeEqiysvkUIYe80=; b=
	HKDlhOHeLnYzdvD3NP0wbKnLnwnAZlNor1suDV5vFZn67yUyyZ7bsWiygtdbqaHI
	Fe2V0ZHDb6k+E/NtgF80UtxbuJfXEcHdl3uHewSMzMZ3GVJvpzxFhqiQxugludzp
	8oOjWWpmNjMY7g1SUOi90gpJGy4setdLYHh5c3Q2UIY2v4+t5X7syu2iyRDmhUK8
	lrNra+fQ7oMOIJ6Sl8Pv95/4ywVKgclfMdJiDlcFbYa8YEOsubRXIlktyWCrC1ct
	CwFDgTD+Q/pxUIXY4CZZ3fziJnHPVeu+G7zCxqX1UlmSJaFY0XmOvB20xkgsRANJ
	oQYCU1EAkpwKQYKMxBGZlQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttjx9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FGUCI1000747;
	Thu, 15 Aug 2024 16:32:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnb8m02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FckDvtqrho6iUXcEIA9aLQq2oDXVcjCILgFYSJJ9EoFLC96qiKZD7n1Ol/a4HGoHKKMiPg/2yEpPGxfgwsezxGYd08HNsxAUs98d5Qn42dk8OazqJFFfCh23deyMGHBi4xuAThjZHqXMPJUH6TyMlvi1V310NIaQsQ5MY0edGYsTBYT8y6mxWCITL94PA5s3nJDHB6ATkLXCGO8/Fp+s8dczJ/+59hd8ZFRfPVnVCLLgzqx0KQdlT54k2kmiPupbHlQE6QWK/PtqYnp2/5A6IlndrGveyEOuRBmy5NXljPdH6xJpny8uMMTu3P0CoXbYkV2MIhZUV8SLMvThPmWvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe7jqCgiKkjExsO3sPMxYCr43xGKXeEqiysvkUIYe80=;
 b=UtBAqE4lFCQV7xbS0Xl0NshLUYmhZsixQtgBkrDm9nozaR6DQyaNmPJuSDZaHJjiHuYQZQUWfNbL6SdgsZvhhVPWncz1XbE4y10Aw/c6MjyktbzH+S3cZtkUBffvu1UZ7diAQL15Z/ji07YaPEPWQa6ordHeU2SA9F4aUuH/T/3Imn1UJrWNKXYRqgoYDTJKG2oW5XmwgWVKLWq0PY0NNtsPPgnlbYDevk4yGLv2DIJQJ4nM2z7uY9zaUFflV4bplq/UAYXzRIeCWv/PxdSMCjsltpmN1vR210zafy5fVCStTdw6u0aa1FtXyDywxb7hfeNfe3AbeJGbobWKhQKjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe7jqCgiKkjExsO3sPMxYCr43xGKXeEqiysvkUIYe80=;
 b=vBOp5i0fKdbnW9YfUjgwIMUssFThKAPrhGDIVIz5FKn7RzRsU0gUZreivRb7Mbg+t4YCjfBf9oLWBQZPd6W2kPaD9+mHztuIg0FJwdzzzWNN81xw53m8D5jkHSu8trrBjBi0rmnMOjn/vOsU8Lll7wZ84OhYOdKC9ts7PZWkuvA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Thu, 15 Aug
 2024 16:32:44 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 16:32:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/2] block: Read max write zeroes once for __blkdev_issue_write_zeroes()
Date: Thu, 15 Aug 2024 16:32:27 +0000
Message-Id: <20240815163228.216051-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240815163228.216051-1-john.g.garry@oracle.com>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4ac4d9-15e5-477e-ab7c-08dcbd47e23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SeyUodG9wFM9AC+fTs2jLtNooScbFO6ZG4CXnqHPeK3kN2wIZH5LJgCIJzND?=
 =?us-ascii?Q?1uRk0n5KgQjw+lLzRpOzBEWHF5PbcOAfC1E976p0tKn3yi6XvIerZMfLWias?=
 =?us-ascii?Q?Ksyt0hyusw+N6Q+PRdYty5+xtG58iDHDud/gfK8UqzcB09GQZy2n+M717s43?=
 =?us-ascii?Q?AjjrxTh8MA5K5yv1RiKyz8O1YhSgAOqB/CXc+5jiojxhvSrgJBZj1z3SLPZp?=
 =?us-ascii?Q?yset5Epei1zbPcLC4MSZt5f6OyIfsYPj7z7fnrvZ4Q5DPhS0nfqEuc7TRbo4?=
 =?us-ascii?Q?9uBhEFB+TJexwykzoxU/Kkqou6bxnKlI4nJa6Wyc7iXkToWkesDIWkh/hntO?=
 =?us-ascii?Q?1OoTXGr7pUYlGA0Co5fHTPRNd6iouEiTXnnDJtPKX7b+FosEwK9dgdUllSPj?=
 =?us-ascii?Q?/zPvKVU2pRx6hmFPyGCjz229CWNQkK26Q3ZRyMaTRwot4T9JHnMPdSgmol4P?=
 =?us-ascii?Q?wnCODmNxq+3vetHUphfGBlaGERKmtL1u91M3po8uvguevd9qSKy51tDHqsTP?=
 =?us-ascii?Q?+EjGLv00xJqAjbzWt0ijEUs6HtUu7cEcK1sO9YMpHQvlQaBVPuQ1oVyQbWVf?=
 =?us-ascii?Q?mqAsXGJCD3hi5nUec4Qf0yJPsZf9lClz+xd7iSD+IGsB8ingKYonTn32GNzs?=
 =?us-ascii?Q?rXDSRRcqCqSkqe3fMDDxMA2xC9u7PrXnoJsEXfYTDjDHyaE2wV+rBcJWzOwK?=
 =?us-ascii?Q?U087mVVbMC5a4uWnuAmOpvECI+KXlFELCK7oQ51HksnVByA1m0cbrOWqTHIs?=
 =?us-ascii?Q?c934W9uPg8dZWnFElLqJ+3iIOCtDd5tUDWzbjfbm/lxYydWqmJiojou4lQWo?=
 =?us-ascii?Q?omMEHGlqA+kgAjUGGC0YtV3eWLKBQ0eDkh+pFX5A2zj0GMfcfOpd9twwfm9+?=
 =?us-ascii?Q?U5G34A2OZFPvc3SSoJMzb2VjevmuvjKLjcT9Fc+QIlZfMqRky+PI1eYjEyg+?=
 =?us-ascii?Q?ZT5bzAZ12TaQu9ydZ7AVpgYuHTzwHPBfMEPKq2KJIpjLYRxjZadn4G9gBwLz?=
 =?us-ascii?Q?J70oMK6btm2Dcf/Hw2EtoPHaWdbZtimPz0Wra7dKqipfRCkcdTfjG3pPiULo?=
 =?us-ascii?Q?QH8E9KeSrj8a6/nvqNnAizQo7X0U8kADV9/CvXQf6Nh2vukcbZTv2cvq92Tx?=
 =?us-ascii?Q?yn8tmA1vlSaYqfweueZAZUl6VbDmLPYpwzHIPdNXdf5vCMzAcm4kQ4FBLCBM?=
 =?us-ascii?Q?Kckgdp8RROJq3UwKR6ZhyNwDH5YUIRyPs+wPRJ6JWxj6B+eCl0Bd9KRhcSIw?=
 =?us-ascii?Q?8cdpcdgLoVqABTUGc1OLv7mbsir4CLOubMqrxAUImpx31d+O15W6dpz9VGKC?=
 =?us-ascii?Q?dIg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ekzfpnh7xdlDKMBSgbmunGGFiIByMaj9NhP3GUfnzmq5gC+SQyZ3ob3TnYUf?=
 =?us-ascii?Q?m1DTDu8Za5rtw3Hkxv1b9K4I8WiewJEzq8WXjdsWvzGiIjIExBWADLWZYRu9?=
 =?us-ascii?Q?4KerDmnaX1ga26tPaAsYQcoa0aL235JP08adq9axx2N3Cc9Ijt2F90bI+TBn?=
 =?us-ascii?Q?GOCn4+2RuXR3o5swrwKPZHkppp9tMd3vZmQMcT3HZXrXi7n6fEqrzDPHBG02?=
 =?us-ascii?Q?YDjsMvIXzZzx1e4q8ySmoy3n3iuggg63MVu7wZYFlvcedRLeLip/Mo+D71RY?=
 =?us-ascii?Q?FPj4gHtiyhiFMEakJW8d19I2jg9vVC94xHIe0OZWH4q37e2lL70eyZAniTk5?=
 =?us-ascii?Q?vuVDj2tiN796QqJSrUlf9KcrKIqiQeBxpaAUw1crgaPkZ5RDrbvfLkXTgLM5?=
 =?us-ascii?Q?x+Bk8pzB5IiWG3hqwuOW56xXpmMWS1JVlWzED51Q6hIGeoMuAaKoKPg5LRCl?=
 =?us-ascii?Q?KF6kD7DWHHw5z7+daC14d9nUm0CWUIMUxJnt7bv0pm1yZkaDdog1fEKqIICV?=
 =?us-ascii?Q?Rgs33OmiwoSyYiDq3ebx8QFGaSg6+SuCr70zSpcGgWL2vU6vf1Wwnyhl8G+I?=
 =?us-ascii?Q?pMQlkieRCSi8Mv7IvOQExyZl9belSt3Qg0CIKF+G7RYSmCVxtww4tUII7uk5?=
 =?us-ascii?Q?FrK6DKhBXYRg28eVIC1qSprMc1hxaS77L6s/0yGXiN5RaSVVk7k4eATgTpbx?=
 =?us-ascii?Q?ctFjGvWTLax5bYFQqdmvemK6WmovyApDR6EEftRC7O4azsmJRNLbL6r5xJCT?=
 =?us-ascii?Q?X5sYtSckstgSYmIQD+tSBz65n2xLSQOz95fWrh9mmn4EoYLdpICh+pzBhisz?=
 =?us-ascii?Q?k/zPrbmgdY345aD/m2RAHJHzVUZRzke8O5Wq7pCUNoUtMx8o18ShtSIpW/ge?=
 =?us-ascii?Q?Ue5K703Er6onT1+BG2mcbs8IHXZk+9E9cVDuBu88bFPOntG2bn3hy8d/GgZ+?=
 =?us-ascii?Q?B3LA2LRc1pTZxFMzd/Lbi7e5kBGDUacWnj++Y9XZPyaIXjySTXUxyv+BgH6G?=
 =?us-ascii?Q?N26C1VaA5Bd6hBKHUcCuGqIZWw35TG6NHURZZ5Mnpz200b9rQqJrRFG4SgB7?=
 =?us-ascii?Q?XkbkIBke0RTaIofMkHdfZfOY+nGjDxsXVdZW+hjZCS/ue+HZH1pJm5gGQQ13?=
 =?us-ascii?Q?lF4gk2L3xm09QfqYn+lV/yXab/G0OIsFDRpfDGS3SugSRsvlTmuCScqDlx7w?=
 =?us-ascii?Q?HX/dZeSCiCtABIyqaNOFZwLmbptY+rk+z0wE3dwNV7nTOePrAn7KZKwqW/sR?=
 =?us-ascii?Q?UfIY3cZZ/17pMDPiH9Dd8ZL1sPEdaqr+DnU0C1iFfVtNXGGGPPX1axRU6vP1?=
 =?us-ascii?Q?LT4bNq2SXZDEIQn3q43MLjRLRPBMvORBRdJcJAhG7IfpcqEApCSbWgJvPke3?=
 =?us-ascii?Q?oPxl8J4FpqJRhosrHJV9D7TYAtDMbUPZoxoMTSoaZvSAD2DUMMlhxFs3HPiu?=
 =?us-ascii?Q?WdFt0i3eYtGVSlNKUMmrIZhxgq0rorhNr6z16PP+G4F4RoO8kv7caCckXCmP?=
 =?us-ascii?Q?CANAKTDPS9PQa9mBdkvfP2gVV4Gw32vIZVwjjiOtNBNZu7s+2PWNL/tvNii9?=
 =?us-ascii?Q?2aUZ/YFGzf3wHXUniEp13CXNMZ9L6SWRzWLo07IY5nnbOROFdkKFneTI/Yx7?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zJyU7NpY6lzqPr75KVfmsZJ+3FV+G1kUFulX8aEhZULxn98k76L7z5pFsXWWsr32pAavmQgg4sVsNE56kHMtXUWOCN/4Z27+3Lh8S35qG2JL/cQFibAw9PvuRXlEdz6scVWNq0F3pm6l+n0djAzfzUO9dW5gzc2oQ4zfLUNpxpsEV25bpK/hTSzo2Mcy14t5/nZGf1MFm+OdytQRkEN5GP6oCqxeq9BY+JBBo0Y4PRhY4QeEpuw5CFt577LSKM93kldcs/qYW901cCN/DN8FRDJrWo3DTYsL05iwm4UXS7EzXRENOyGLmBGXS9gEyxBXQP40tVGj7przkUd+ooe5eOeT3Dd7q4xhaXF0USb+LAN7xdkd+ptF1D1o57SjaX4bbgE3e+TMScwgXXVmxeOpr3e9WLKKS+sqbyNTqKmy5YKUmNxga49cx12wfKh4rQuuvkdRr5O9p663K5m4tRhGoNtZrNQyXNmlXtXd85tKMSA1Dgmy/sxaCD2slQApNuRJnsUfZfKRQZlPR4Ne6U4yeylq30Zg9t1vdktX3+DaOOo8h1LZfwiHoc9YH8oZFGQSP83SaSV5OUXyoDJo7V8TOsAxbqyH2fbgMigOxYWiOHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4ac4d9-15e5-477e-ab7c-08dcbd47e23a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:32:42.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Yp3K0bd+jshXwPo06IWlyaMlLt482XfdPTLD/I5dLafgbEnTkNdO8Az5YNdhPb2XXvGry5SCN49/CVWPkYt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_09,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408150120
X-Proofpoint-ORIG-GUID: OHQZJYetD1Nz1NgSarKuHarzOX77Ml2M
X-Proofpoint-GUID: OHQZJYetD1Nz1NgSarKuHarzOX77Ml2M

As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
drive.

Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
changed __blkdev_issue_write_zeroes() to read the max write zeroes
value in the loop. This is not safe as max write zeroes may change in
value. Specifically for the case of [0], the value goes to 0, and we get
an infinite loop.

Lift the limit reading out of the loop.

[0] https://lore.kernel.org/linux-xfs/4d31268f-310b-4220-88a2-e191c3932a82@oracle.com/T/#t

Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-lib.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9f735efa6c94..83eb7761c2bf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -111,13 +111,20 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
 		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
 }
 
+/*
+ * There is no reliable way for the SCSI subsystem to determine whether a
+ * device supports a WRITE SAME operation without actually performing a write
+ * to media. As a result, write_zeroes is enabled by default and will be
+ * disabled if a zeroing operation subsequently fails. This means that this
+ * queue limit is likely to change at runtime.
+ */
 static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
-		struct bio **biop, unsigned flags)
+		struct bio **biop, unsigned flags, sector_t limit)
 {
+
 	while (nr_sects) {
-		unsigned int len = min_t(sector_t, nr_sects,
-				bio_write_zeroes_limit(bdev));
+		unsigned int len = min(nr_sects, limit);
 		struct bio *bio;
 
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
@@ -141,12 +148,14 @@ static void __blkdev_issue_write_zeroes(struct block_device *bdev,
 static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp, unsigned flags)
 {
+	sector_t limit = bio_write_zeroes_limit(bdev);
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 	int ret = 0;
 
 	blk_start_plug(&plug);
-	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio, flags);
+	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio,
+			flags, limit);
 	if (bio) {
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
 		    fatal_signal_pending(current)) {
@@ -165,7 +174,7 @@ static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t sector,
 	 * on an I/O error, in which case we'll turn any error into
 	 * "not supported" here.
 	 */
-	if (ret && !bdev_write_zeroes_sectors(bdev))
+	if (ret && !limit)
 		return -EOPNOTSUPP;
 	return ret;
 }
@@ -265,12 +274,14 @@ int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
 		unsigned flags)
 {
+	sector_t limit = bio_write_zeroes_limit(bdev);
+
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-	if (bdev_write_zeroes_sectors(bdev)) {
+	if (limit) {
 		__blkdev_issue_write_zeroes(bdev, sector, nr_sects,
-				gfp_mask, biop, flags);
+				gfp_mask, biop, flags, limit);
 	} else {
 		if (flags & BLKDEV_ZERO_NOFALLBACK)
 			return -EOPNOTSUPP;
-- 
2.31.1

