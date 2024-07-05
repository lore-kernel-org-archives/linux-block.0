Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB42B9A4;
	Fri,  5 Jul 2024 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720152238; cv=fail; b=p2WUSHvtsl9OHrSMtgnbrHmm/kjClzz4U8zT7cDFFwS8A/9wwLfgLybJyhAt2L10wFz8A4seeovtl96JWj1Z+qQ6wMBLMk4Id/EJzFarmHUfy4whcq7u+HjN6TkEI5nbiJIbFsZvWS/0E84qcVAaheNrlBM9ajOS4qlRpBMpLNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720152238; c=relaxed/simple;
	bh=rTxibPGCMRoPsW1E+LEhbBUiExVxQh3a4LjDZT1kd7U=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=IzuD8IbJ7xSuMKMt2+V3CcInEUHoROzTadi2wQyR+b7DmuMhp1lZYHOSCRbR1OGI33qRNl4QsBxtMgKKH7/A5UfC3BrAa6Gfy0qebw9MlTqNN7PyX+P5ARmb9/3SsnnyHT2JuLRjFkmYJ3iuLPoaHMmT9hAunzyIFmN6W8nUOYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gmD+FX88; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ds8D+/uk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmD+FX88";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ds8D+/uk"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464MVQwW016564;
	Fri, 5 Jul 2024 04:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=5W7xBzcm5Tj2f8
	KPpKFbDp0J+9ILTpvTgQ20ZUUDAjo=; b=gmD+FX88lAsltb+CFz/IYELhEmpYK5
	56GAarGnMFyjZpRaKg8JLQizGPxs/bITVuDSlSSAnBr5d1wnvlIccjyy2hVWm57y
	A5cVGqq7SMi5JVmYdBqHBrggl8DkTQCx7pcsVpzE9u8G6GGUcXZWZJO9cyzPmCJv
	PVm7ofYnB/e622vjCif3ozmhUATzClnGYmecZHsrClakNqJVhkpHHZBhh0ssXu6M
	wckB8JH6nZYyaU0tJMJ0b0p7jt2O41QYBePQaTjM562srrdWcDMyPL63uMvGOpWU
	AdARQXdcVWIf8VGpIq07NJE+AlXrS8NrD48MeXn/BquQ1MiZXnn7PD6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402923328m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 04:03:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4651I0er010960;
	Fri, 5 Jul 2024 04:03:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qaya36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 04:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2JT29Z3E6EdpJsvBpfjA/O6GlFSKTdWd0l04l70q1Xa/+y73lWkG6h/n0ay5DYRmQHkyYqGkxdeff2oR3D1WE5bXzPWX2GJQIgZOAm/mUObkpM+OvM67nRM4ps6z2Ii+d2KPOy964ylamvhpcrmxTGlHGjvtVdlesouIDfi3DD3gohpHtv+ovAYB7tEIJTczDHIaDsS4GLJFLMcjcgx8vjT5Vz+6RriLz7djSaqxEsTj1/n007BDS3LT4sXr1xK6NuISyqIV8zgN68yqUHZsQXyaw521mWqKCFqHE8v9B4wk5FSa23LY38CQ0tmGyC+I+h+rhTNObFP40/INPUYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W7xBzcm5Tj2f8KPpKFbDp0J+9ILTpvTgQ20ZUUDAjo=;
 b=L6tdaIegLZ+jzQ21oO/E4yoIBF7hdSwwhPWxCOeFrT0yKKP1LgfcI/bEhGHa39Z9OUvOT1idfF3mwdl6LUDvRTDiQAUV3gtZGuLBaACeQSW3yvcS3tKSbcmLgC+IBo8HPypIsCnLlJqO3GzQ9ic6TLmujLMe4Ni46d+OVTkEiG4+2zOQjp8wE8RFR7mZXScJo1XdxlShFQennxCLxDPsfFxSCf1Mbicq6O5QXXLsxAE0Oiu88L1Y/MxH0kFvV4WHHLSWvXdF8S+KND7R0XdQVBmF24bnTae1+JB+X70OaoGzZ/kwwMMn01CZUVkDzSZ9Qo9x0Y6GE/LSwIu+8vV2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W7xBzcm5Tj2f8KPpKFbDp0J+9ILTpvTgQ20ZUUDAjo=;
 b=ds8D+/uk3hqOWowJABkfVm1vpEcmZ0HNfxgQOmrUr9/H6jjT/oZVe62pxBYZDja5KkRW4e5b1RQn7ivDwS4iYj0AyaDwnbuAlXsPaQ1SgE5v6EH/2aLCvQtSgZ2ORD/4qhMsKtr4jBAOTgNNwZyGlczugBj5t++lKJSFbtpqVUU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 04:03:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 04:03:44 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Conrad
 Meyer <conradmeyer@meta.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: make secure erase and write zeroes ioctls interruptible as well
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240701165219.1571322-1-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 1 Jul 2024 18:51:10 +0200")
Organization: Oracle Corporation
Message-ID: <yq1msmw8ozc.fsf@ca-mkp.ca.oracle.com>
References: <20240701165219.1571322-1-hch@lst.de>
Date: Fri, 05 Jul 2024 00:03:41 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 801ea3c3-7043-4ac6-5dc8-08dc9ca776bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TEDf2/h1BafpPlqeD0jMMn6Y9OdMY5LZRUaGXh9E/tnnZsA9gIKSG76coBGu?=
 =?us-ascii?Q?UWq79y0Dv5Cu81QCVGJDWS4fjkS4dkFoyrwjikPjqoVpngidcQVioJXVWi/V?=
 =?us-ascii?Q?uvvL4depgk8sXo4FIlAD6mA4VUiQliLlvV51GPvhuZnoauo8ejn3g6L+VcFK?=
 =?us-ascii?Q?0Ze19rbDEGBeutmT9P2qK9jJBdIupquCaeKBN7fApYZhdmjraCb6EKWjyxU2?=
 =?us-ascii?Q?eulIIC4fxckM532x2wB9tgJ0p8EWq/oGqiGVEXdjSwH+dwzAinnA+dtkpgKQ?=
 =?us-ascii?Q?cp+ve2VDqxRJ4D3QeLJZpu/1lU2ja3LaDWR+2KYdzxWhi5Ff0/bSZBa3k7lj?=
 =?us-ascii?Q?xW6Je5BCoUXwT5chilTaqCDaHa3hDW3G9Dl7ARDDIzUP4JZNjnM65b0TDoon?=
 =?us-ascii?Q?siOFp/GmhbTa/TwA3gNfFimuSlGle/7jiPOQnZ7TuwNLC77fGaeWNuob9pVq?=
 =?us-ascii?Q?Oq7LvgNBKsIORZ0a+tSQ/GdlLGhovs/kwb3+AIm3cFEqPB3a+OLndqRx4c6g?=
 =?us-ascii?Q?MmDvPTc0qVKwdVpH/1oO3ziuI/ll4w83ChIzcA0EFHlK0F9OJR+fsoj/I8qN?=
 =?us-ascii?Q?fSnYTbF4igrEfUCqM5Nja2h1mguxDED3SoQt06A13JmX8nah4oiYtDbNwubc?=
 =?us-ascii?Q?KRaxnT3TcaHW8RdnswB7HgEq5v1nFi16soHnqyf0hxrUGLwOs3KaMfbaK8bm?=
 =?us-ascii?Q?i9WpNhGUkW40Vgd3uQ8pxF8JsLiuR95vC4z6G3Oj3vYysTmQU7qKn24tV29o?=
 =?us-ascii?Q?Dkn4DI+hX09P21DhwG179tzwOyl1HW/VO7kodLIywxxqh9FZi9uWdRrFrQ0w?=
 =?us-ascii?Q?COgORGTtWl0KJIg+Z+Jp6KD4AC/bMVkFXUs3TWZDWyQt9D8yVlf6egOYImhJ?=
 =?us-ascii?Q?Rdf614uzdHXt7jdCDJsH2O6Lv3e9bWYRyEhfGHRo1imdQmfnhMvLVW/78qRD?=
 =?us-ascii?Q?2uHTPIRs1kncGvp373lIgJMxZIUJSCFFTQGf0pvFItxUe4+RVrX0zkdjVaJg?=
 =?us-ascii?Q?4OOX9nWzGZ00BH65hb80lum3pVK5rUuCA5gyGpKgoO3N11cgWnvgLROJpa16?=
 =?us-ascii?Q?vEqa9myejrzcm8jAOXp7VwpKgTMYxJeM5wnk0GP7GdCS4wh2AJqDISqNELb2?=
 =?us-ascii?Q?gkNYDi1kv/82Bz5oa/OM5QD/OTOkCuijsG6koMSJkAueVBe3XXwtWUmssmXO?=
 =?us-ascii?Q?1GeKaknF2WnTKNKCiOlUej5diPnCbNlUgQz9EhTr8Hk5a+crSVcvJcM0n8eo?=
 =?us-ascii?Q?xoy0ODkcmt91QB+onHxC/k3gZMIrQUmWbkvT6oA3rZ4F2aj4SMr8W+TRZzVn?=
 =?us-ascii?Q?EUPi9nzweTvn5f/5M6qq4orm2n9w7wPK6Tq3+rXfhjKbeQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iLuRcWOKv9tnmF+7NG/02954LTXw+b88J4bZhx0fIgv+Evd7jfkdGyiAISyQ?=
 =?us-ascii?Q?8pEcVBd6vroa6YwIKh/L2IVZex10eh13ahhd/2HhQPBTZ0ULl+szvebVZbLV?=
 =?us-ascii?Q?dtpAFSmsaFZBDdhB+HVR2RXGYF4GNo1Fn4CkmbXaXcEUSjnHEsoc+uMw0cqw?=
 =?us-ascii?Q?fgvBZgJbaPHVQUrKM/yeKgE/7kE9E1e87mt70xaYy8ZFsqjHbbpKZ7SvW8U+?=
 =?us-ascii?Q?63UIyNJRrQgMN8627eVceDMF8oiE5dWGsmUZRGP1P2R3Pbb7hM+R/FFrP4oe?=
 =?us-ascii?Q?kl33VU5QqAVEPUfFMVj5uZAeij1yRGrx/gy5cpk/rRnChSzmPP40aWrkisCR?=
 =?us-ascii?Q?Mya8HILJFX1TfoPj4xHoeuLRocPnEWvtBa28CvSrTr3DT2EqN9WgSj3/yrqy?=
 =?us-ascii?Q?lpmwSYsL6Bs/Z2K9JK7/kTFs+svFgRDbw8uQ5CC1i5d1/JyobDoCOnXkRp2P?=
 =?us-ascii?Q?HkB2+J47MRI76OJ54hp2fWmcr/HF02yFnGLBbaDKQHMLlRtYJ9PJirmK4oB7?=
 =?us-ascii?Q?yoyOLQL4AzExOir5tSikX4r4JK8B2xbd+hAuWdZPaCC0n+Tqy0ulFQTqIX74?=
 =?us-ascii?Q?1/FN7YaC1c8cmCw5Gm3PsWC1xuiVpwygKJUS9PqJuvAH5RIj+XMk1+sWShGf?=
 =?us-ascii?Q?lqG6TIwZHYLYRIqdwPG8sX2pPzTJxGqgptDrGk9QneNZ0U8zrmmIPCXckAjJ?=
 =?us-ascii?Q?zCgGDwBhu6X0Wnqcw2cRWf33o2zt1W5fye4djxnUqAuQIzxLQQJeL5atVuMB?=
 =?us-ascii?Q?I/Bf+5corGyUtEetCD0Kpj7d7/UJsg6I6SbWBIC2AmhO8azmOTsuxEn5VIeJ?=
 =?us-ascii?Q?Km/QAJtX2IggQkFwmiSpcanj1qefSBhPI067rYQFd8OEea7mQCoZQNT1HDWv?=
 =?us-ascii?Q?AHijUBzBMb5YNjhqyywcq6Bn0U4TpMT2a0jmjkKYqEdozcNKL+tm0PNjx5ER?=
 =?us-ascii?Q?8YOuElc8B1CqIhDxqGsINSvJK5n2j5ADaJIKwUAmmFUQtaU/cC/77hMS/Ygj?=
 =?us-ascii?Q?HYRgUmcSKIZdaa6NSnSpKznVPgJMcRq+yrfbJavbdy+GxszPAaO6axVcvGw3?=
 =?us-ascii?Q?L0uKuyDwwKvo1SzsJ7li+4TZGye3t2SS0sNaszIHfexZlfeWBQSjyZJBmWRo?=
 =?us-ascii?Q?YK+2rcLqyfEUh5abLNLjm+iTI6v5/MAJPrhaT6u8cG+3iLLL3nsxodSuqD7F?=
 =?us-ascii?Q?6RlzPUMbhu87qubkVx0qUp2DvHP0RTblLu1aeK1A4yOMP2eREywTOmqP7ASa?=
 =?us-ascii?Q?Sg/mnnumJAT0R75+HT+LXuuGcBC4+jI/NTFo0OEIumSQIsRMOZrQjxNLFDMt?=
 =?us-ascii?Q?mphWg65JBLW2sm26srR2PvZpo0kRzBJsPdXiKY1QF3Xpsgkfi9O29apAlFBZ?=
 =?us-ascii?Q?Qk6QhsmGRTbrOKfMDeO6EQ6nkL/ocy+qqdp/64SYVjyytvGU3iQN6Vg098oo?=
 =?us-ascii?Q?prPXp+yW/13WEAHekqNEWmBTSBDbaBN9kBYawglFWkhACqp6xvHdVClgJgJR?=
 =?us-ascii?Q?ac6shWFaKyDP2yctgaAJT0bU3dejBA3o1qxuIPkkLX7BA+IgslX1DnFHT8ry?=
 =?us-ascii?Q?PlvWiVlkxdk+GN6Z1MG2/TO9s7PuPiu1bzEyBL0Of0srNtCYaykGomtMIHHp?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WjohNyjZm11TfT0Uldi5mVactJre/Rt9yv5GAev0MuBHCyVPovL0IHrzHr9GRIii8oCASeEHIBnut477s2Jm4rALQv2lxrVLvmukn078wdKqrwJdAXoa+b9N5xljUFVlbZVqh8CMR6w8kwF45J1TBDchOPvgC/kfnFoaTAVFrfBOBXmPX+j8/xZy6dodIHKKzI1X3lnrizXRHsC4vMG+IZWgdnGeRIVKE7avBBUZJnyUjIrJgwjp3aMfNMMofKlEcYRphLQ6bFVcpKXgLrhdv6T6tB9OOwjwOfuPMNrVK4qAIQoGvyV7lXxz2EJLs4/6pkNvQW0achgMth2QlI5gvVuJNKIcOeMgNL7ZLdkpOzufzmbwO81DD92eyeZw9YcnEvkQ65eLBYv3TRxrxMLwODUKOmWhGqG+HLOv++bRXtwUhg1uW9ZtN2FcpjEb5uPQidrQDiQj5uD4/XqVR/YdV+M6i1GI8J60YZahU7MDgCaATdHsGbQ1lL+xx7+bBTTNLG5CM/q4A1OMHUhO8HNwxoJbv0pz5ZtG+vnzlIIbqMWGt3tusptuG/8PuF6ZhQ1WNyu0/tFjpbN1iA7wXzvfHOgkk2HJ2ggUKRldy3mFpQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801ea3c3-7043-4ac6-5dc8-08dc9ca776bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 04:03:44.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89kkHMOHDqQ0rpOn0uo0AwPOifjneHUTGVSsicNgnzEwwYuhyBEv9X+PjBi4LqHNavrJEijM/1T8sp4OZEn7A/n3mGWNX9eAqi/0ls8DqbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_21,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=595 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050028
X-Proofpoint-GUID: 9P89-Epdi9lrsjgYXtXGuKytK8SzXt7W
X-Proofpoint-ORIG-GUID: 9P89-Epdi9lrsjgYXtXGuKytK8SzXt7W


Christoph,

> Following discard in the last merge window, this series also makes
> secure erase and discard interruptible by fatal signals.
>
> The secure erase side is a straight port of the discard support.
> Unfortunately I don't have a way to test it, so I'm adding the eMMC
> maintainer as that is where the support originated so maybe they can
> give it a spin? (just do a blkdiscard -f -s /dev/<dev> and then
> Ctrl+C)
>
> The write zeroes support is a bit different as it is more complex due
> to the fallback code and there already is a helper taking flags that
> we piggy back on. This side has been extensively tested.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
