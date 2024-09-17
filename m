Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAD1E4A6
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572902; cv=fail; b=VeV5oABsefHbkRuHF4nuEQt5iz+K8pQB99rL2KweT36E1pKFTXswcYDGjxtcbGPETnmIeUp/jmuNpNyovbMHWHrAvgjaBCD9ka78yTr0GjtWWIIJVjsWrIRuVD7rUTy4Jph2ocC5tDFRJcIgo3X3qZ0898+p6m7j8WdftTznGzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572902; c=relaxed/simple;
	bh=/Y1vC9tq0/1RJbtXTpH3fgcqWz54yRxNyoSbsj0jVIU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=B5GtagyIugf9cALgsSDSWKJNchgPzlbH2Wzh6HjIambfKmTYj7zYt6N0fZQjS4BvStK8SnmTQvhbaPdkoB3ISXQb1kcwj2PPMHy9AJ9KVtkagzoQ3+GWgPjTgQiCyQn/LgyPsFoQA00HMdHJrEN00/eSRtVRkMcddL7p4i1jTng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F4ZF6yHS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UkfvKOn3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4ZF6yHS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UkfvKOn3"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HBMXMQ014254;
	Tue, 17 Sep 2024 11:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=m6WX7OHSwPVhLk
	GLspr30kf1Umi6rsZjggWUxgJHEuU=; b=F4ZF6yHS37RblEYNXb+SSb6obmIaRN
	f6ydyFQXElWXJUKW51+2DU7X7bpRQcMad0kj3Obs6acScFqU6utqugQE5wNqUMWc
	vWUO3B7HU7Gh1SJA4I/DRBTcga7EdSNprNy86iLTB1hfAyu3F37VV2OGigeldvO+
	bT4dGAGu5age0Y5/s8hlIMzduTyMBo5qgUtMHZWWE8lzPNRK3dDeaAHVRQ3WwJ8q
	HVmIm9r7WihtXc2L8xPw1drGR8RAvTBJ64J6Ek43Iv6A7EQFQ/b1EojF1IDdtkst
	ygbNqHuJip3DdtbHMdn/3IfbpY3mddtAddqpwjxlSyR5Ea84LAb2iTCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfnv9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 11:34:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48H9Zlq6008314;
	Tue, 17 Sep 2024 11:34:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyfbt3xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 11:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rd89hjMyeNJ9/6VPV/eTylJVQB2l7Om7llLBPTv6kYF3C+DzvltsMv4KmQVz3ZzfH7eVTQmvSuIvuBjz5Z4bso3pbWppxj6MD+QvwCz+6hBVVFtBhtxQsm4KAcqrtgovO1H5RSI+1TrYX39MW+ghvV0QDzpbVFGhOQVEZPiMbph8b6q1EKCO2wJ2Fc2idnxs0c2ZS5gds01oXfkadQUQApcGkrT520mUnW3KGNBSD4S/5BHJ8BfWTM5139ZqeXTrfC1snqL8xtiobKqKDvyf+6Kqikmju38haJXvG8zZ8wmSplW6/dXGdxSH/Z2PO/OKmtX/l+3sO0wKvd1AqgKyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6WX7OHSwPVhLkGLspr30kf1Umi6rsZjggWUxgJHEuU=;
 b=mqbqqglTXoAr/6SuuOibi0sBQZDYp4zGhI44yUxDjf689Is+EKuSQROGhWrZsSEFMiB56CYMEKVJzrLEZ89ZxvnyBT2wX3kArH12Kea60ZWsh/aOdzjXQjDpCVpE3ECn2qkdFnPEYn1z61J/2zJWPpFHJYmrJ+5k6yaHVH4bLJ9641TIgIR0d3BFBqxqlDe8L1Z6q1IT0Jn1EpO6fE4VJX7Rn2U7xRWQ2CykIRa0zSVuYKo+if99ZaKyGZItGmhQVPQrvIKfIGXNkDthajT5dyIpRfoKc7tMDVnnz74wkPuk8q9YCWTvCEBvy/J/mNBW+9M8JWRFDkDsIFHg/a00tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6WX7OHSwPVhLkGLspr30kf1Umi6rsZjggWUxgJHEuU=;
 b=UkfvKOn3dyPwIBRfPBes9tLtdBBjYdKTZ0T2b5cB21G3ejaVnXQYodG+iAxNDYPHJpxUBBOs20MNjRIRCenFR0IbEvvDt+D2XnUaGhjzgiIah3hPvdmOvs9Bh/0w75t5rDEs0ZyHhCX761k+C3t2YZ6kxCDuD4BdoepTwt6dssY=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS7PR10MB5199.namprd10.prod.outlook.com (2603:10b6:5:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Tue, 17 Sep
 2024 11:34:35 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a%5]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 11:34:35 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH] block: remove bogus union
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240917045457.429698-1-joshi.k@samsung.com> (Kanchan Joshi's
	message of "Tue, 17 Sep 2024 10:24:57 +0530")
Organization: Oracle Corporation
Message-ID: <yq1cyl2qzvz.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838@epcas5p3.samsung.com>
	<20240917045457.429698-1-joshi.k@samsung.com>
Date: Tue, 17 Sep 2024 07:34:33 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS7PR10MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c400d2a-ed67-4e60-a4c5-08dcd70cb50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/GLTmpjLMaUua2QxqGeksKkGeEcGqD0ugV5IMhdQOCVKBAMYizF89f+Umq5?=
 =?us-ascii?Q?VcLnZSdx0d3IjSfZwQexgQjC3VNhbBxxxptTi/meim1ITy0kw7gBlJ+TPS3B?=
 =?us-ascii?Q?wEmGl9LZFyLIhOnMXvVSr/zk3RWBLVHlds3VXWZkuEpdUTApT99BL9QjDknw?=
 =?us-ascii?Q?qXDVD32W76S9e1KyN6F+J4Y7C2VYgJ0SJS+fDU0td5NUu0WBsFyI4/6R1dKZ?=
 =?us-ascii?Q?pAgkvD+F8Appm50Lu8TkxjBF1p5sZepARMEFtveaym3zYpNL3xLnTbhVFmCo?=
 =?us-ascii?Q?E8lRmNIC98CFVQ8xEAxpyjQqWuoV4P0roxCe9U/Q3aGVgyrTJB2rpXKNBXJd?=
 =?us-ascii?Q?g1bnc+dENUtraxKdCvAyl6qFtXEtugWNV7E12Vk/w+orhDI1et8hKknPwhrC?=
 =?us-ascii?Q?Yi6rI744b3qUS/Ie/StYIhFKvzrsch5Cw61CNRIU58VC6TyHv+4DA34u5EwO?=
 =?us-ascii?Q?SQQlxRliDu6d2/9EL+Wi5t/ClRxv8WFGEZCP5bSgOB+HB3Ywwwhr/Kkbm/N5?=
 =?us-ascii?Q?MHE5FHs5PPuNHxE8zhaDFnUPwSeYtvxpI4Fxwc/KUCP7e64liA7bj3UcJzgK?=
 =?us-ascii?Q?r6qc1YGAwEauSuj//CQZT5X07/7TLqscw4jXz3RftnK42cWfHGWfIoyKYNiu?=
 =?us-ascii?Q?9CdCGpkXxbYqOTPUQ4mfwi7aATZjvZ9Hcs7lJKqtnKbZ6ji+CIRDwZDt2nxr?=
 =?us-ascii?Q?9jrY+EX60h4QEtu26S8NSt1ZqhV8DIg//DyYYWo1bEY2bMBa1i1JNhQ6Um8g?=
 =?us-ascii?Q?USMkv+HoYndVMkOtem0eDRBKpBdcuMqz1pa4oNwurqEz9cngIS5MLD7UcPm+?=
 =?us-ascii?Q?5FGZaIMY1W2AesvButd9zz+fzWxJxrs6Rciq3+05JD6okNrABOzsAxINfvFM?=
 =?us-ascii?Q?MgG4UOM9jvAwfVZwEPyGvw3rabx/mh+Nr9mwdeJxIeSdIzWdt6hZR4MgWDjW?=
 =?us-ascii?Q?72iGy99BefLitHHc3/mpaomt6P0MyjKylK1gJHDVOGflq8MZjBIwrsnjsY+B?=
 =?us-ascii?Q?YnsZoTZ1M2m7vTftp/anldNc9Lt2IFdnQuD+UQqPaJZr/bcnjJDeon9Qud2a?=
 =?us-ascii?Q?X9gjpkugNBemZ/sm2WGurCB3WRrau+MkGtRt5HTAS3lkceb11FjzbYNOiocl?=
 =?us-ascii?Q?bVrjBGwmsIivpKhasJzjWaeE/bEeA6YXlPn7QVCJ2Fjmmx3ddAZO/5uoAeE0?=
 =?us-ascii?Q?uA0oyizrFoDyQDF40RcwOAN1ptV2BB7ltWwrZ1acdNdm7VzBG2T4FgrYgInK?=
 =?us-ascii?Q?HaOEQaR4R7fc3bFfuW9DOg3KbUwej48I3WK6Sv5WKjjZbl2diVgsf1uCVQmH?=
 =?us-ascii?Q?2dgxUeRdLI3d4i7xpCA9DwkqR38bb1qFB4NwDmHu+UJHzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38c0EMef9xrlRNhWTGST3LZ3Rgp9nW/c78cDSz9epNb2cm5XgFC2gx3eDiqJ?=
 =?us-ascii?Q?8HZiUch8GUkIgmhDrkIBxcCNdzozWp6xt+8ASLp0zNnrDux64j379i1gk10H?=
 =?us-ascii?Q?pq3pjMgR4bBS7KcoUrH71ZTn2L0P6Pmy06/AcfVPhQO16HmoxEOHgjBO4MKE?=
 =?us-ascii?Q?sqte6I4hzbtyRbVOfXCvRvdgROfm9yWIEKBOk+Ef4TeHbvROujCfgjwkGW38?=
 =?us-ascii?Q?nQEdWQD2u8DdbGJwHWBlo7XbYNgt9CcrH7mbLUtzBPRkxeefzBnHBJ9L9UMx?=
 =?us-ascii?Q?gQr/Rj4LYgc+djze/SEGtjxwKEUuMsEg8bDaarZgsa6qE4IMLzQ/XGrkn7nt?=
 =?us-ascii?Q?Da5MdGWT5SYLYWLazmZC4y88UbOV+nevsWJPAn47TE4fybxYiFnpWiwuDrZk?=
 =?us-ascii?Q?Yp8JzvZxfk0qoHpIY03kqoIvCyzgmyJHFmcOAnfTJvsTsqpgwpBUGRLFmUif?=
 =?us-ascii?Q?fn05OHNQUCk7Q5Ttr3C8K1Y3plF3ZmLDlmgo+SFD9/R4kPfFCaEWuhKMfHBd?=
 =?us-ascii?Q?xwF5x7azscodeh4Mfxg1gf7DmlNRTb7go3nf1dBu33VExhCD0irGqx5gwq1W?=
 =?us-ascii?Q?IQPpS2bGOG/ARFqDdL1edvJxooSnUqVHO11pDmP3dCYLdCYmOyEbuU4HpLyk?=
 =?us-ascii?Q?LgXo11qFJAbtB++2YvtRrrKmPVCeFcOJrxgJLSCRa/pkxJhrSc2fApsSethq?=
 =?us-ascii?Q?ef/hppwCQFtcWFE5A/EBYqC1Ta1Y3XeicftyWDeKMRmbf4YEHLccr7r2WHsn?=
 =?us-ascii?Q?QjTouFaxtLQhpU76sooMYVWZ77FPFZ8fg/sqOaSi0nzMbw6CI/ITvkHsSDWi?=
 =?us-ascii?Q?UMLukpAeZH3cAgGUKNsFrHCgYvX2L3Pd4OrVeQ85kO4vDl0obgMxAk8elDwz?=
 =?us-ascii?Q?S38tPjIjjfVIORmav96tMR0LEVnoi4UK1X7WdrrLbkSGd4477lXLb4CRamSr?=
 =?us-ascii?Q?QarFktdyJr/CxHCjGRjPTR+cmNPk0kfcMBShRfPWQTw2bvjyLlSlwWurU6VS?=
 =?us-ascii?Q?GiT+LmEBkGDHsuguu23wJQe3/MfQzTvSfNAlDvripTk45nC1XHjtskZtsPnt?=
 =?us-ascii?Q?GktJYndSgUvtlb2Zc9Xo6/ztW6qfKSiHPt4oy8D7uG4pnEEa3ONw+KINbFac?=
 =?us-ascii?Q?vyJyT/dnlLfv3dt7PUkJftl4RNBhXD3cjy19ljFOR/YwcyNGQ0lceMm2kCNO?=
 =?us-ascii?Q?C0d1rhShuaqTdaj0p8EutF0HnO7BLRNmrdfH13HGN2yl3UzbxK6emRO0FVm6?=
 =?us-ascii?Q?Ig2Rf72ot3uj0dPdr5NxUXbp6cwrPoT9l0S75HyHFCIqwkk1FGAhq7FDrlik?=
 =?us-ascii?Q?Gs14x22Byl+PfwZ2iH9FmOdzP5LyorgtedQtD7lzAaLuhhAjnZ2M/uPEVvSS?=
 =?us-ascii?Q?D7jVRp/4/m7F2W0uk63jzed79Qr7xhA0VTPuy4ifa3uT3EI5e1+1zUHByLbC?=
 =?us-ascii?Q?IVoD3IwzPlFb89D7g6NDvDFJl7CV4JxqTs0bGPz75KgrXwnewPQJYFnSITJE?=
 =?us-ascii?Q?LhXdQiuf0peKyjBxcGXsKCCeNt1uUolFH5yb+cHE4iik6CJ9a0Z4vl68IKZR?=
 =?us-ascii?Q?6y8qHbTvHzZcM2oHBpOXT64o0HFy7mFuZer35UM9HCxrXlcX5m7LFGZmGhNN?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WVDA7YIgiF+OqjrMopzXN8rDGvEwBqTAu6cSsyvTqiWpXh43eDy5hyWUKSYe6bitkDiA7bBZ1HPRZU2yyMalWf9FgMHY6ikZn6gxl1nC9ZONdUY+D07/ujW1xZeTW8IZRAY6S9qfn5CqVLhtMlwB7N7QK9x74MeZBsST3/QMODjcN8WIEdl3KANLxZhncotmRYvwEPisLVMyhNlUOLmZsicsDgidTdgUutbVIXjBf69w2kZ6vM/7W8yA7I4n3y12ASQKaltwElm3dCWFODsbxT51jQ+dZcwzybDJjdF9jbK3zss0yynUIlWi7F09Po0TexS6SGb9rU0lE7M+Kg+eBUBGUPiupgZDWjvkm63K5HaW3a4nuEzQhOl8LpB0p7fbJ6t2GiUjnCydm5qoDGHgAuuEyTwRPpavBSFshv3aG23HuFsGjBgLpTWD/40cT39lJcSOIR7VJc7mj55JobOn25xbSjbCbyQ/gUxDr9H8SklD5V+T2dDuqBisOlO65De0srDag9xK9xqSg14th+E6sJ3RKAva7UP1dQOGApziUeIUXxbMGad4JVX0rjUQeX9AFJZWURByqTt/z1UoY10EJU1AZWLQ2tARJjSKHb4+uRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c400d2a-ed67-4e60-a4c5-08dcd70cb50a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 11:34:35.8445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgSeRYILvWjTJuVsAfHzhhhboKFskox7R6cO9TplK1x1r87USeFh1Q7Lzud+gJD7M0njbdxXGVfixb8PZzlAWj52A9907QFUQIaD5g3mkys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=811
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409170082
X-Proofpoint-GUID: 9W-QRMVXaaxy39_2O6ap1YOXLAnXY-vV
X-Proofpoint-ORIG-GUID: 9W-QRMVXaaxy39_2O6ap1YOXLAnXY-vV


Kanchan,

> The union around bi_integrity field is pointless. Remove it.

That's fine. It was a union to facilitate sharing the space in the
struct with the original copy offload patch series.

-- 
Martin K. Petersen	Oracle Linux Engineering
