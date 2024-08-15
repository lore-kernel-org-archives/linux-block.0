Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D96BFC7
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743839; cv=fail; b=TQXOMuXaUrQnXWlGm48GUnGszoCUGmj1Kcdlj5KBrKO02TxgP+MG6/3u0fbQD6VEFTGh7xTEKaQ+s7E3LGgGh7kF6WlztPxwKXQSZmv9dSgvkRFM9fQZxuSl++bnWwmFLmp9uTITd5VjraLHHI1cqJ+QydKGivcE3X9OvXRwAls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743839; c=relaxed/simple;
	bh=54Ht10+EP8ski8BTB6hO6c5X2+933cRZ4GqjgAzK90g=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=mfIR3Y/S0wSMzZ8wJZfSP3WtTUVvKs9Rx79HPXuyo9jtyqwCKzxtBioi+BROH5n93w1zcCm8rIliRn/HnnzsfC55wsn3iw2pluPanWLW4CaL6BjnRHanZ67WMzHtfxuxyQHzOrgfc5Cs1FbEUbg7me8CzaiN47nB+iqUraL0kSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HS07mz3L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yb+AcX8L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HS07mz3L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yb+AcX8L"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtTeW014140;
	Thu, 15 Aug 2024 17:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=sUbQcogOAbjs4a
	2oiEslwPko9DYTuXSKiV+BlAQLHY0=; b=HS07mz3LRf9t/F3eJaYqW6RPK3doGO
	xGCFZHdDFXiKhyeYeHe7sZ69ZSNeReB7+sb9Daev/rBeplXaG+fcfy2FtsPEwNaA
	k153ho+bsdGMnAYR2pcKXeJBxYvDdMWYAcvxEjYH6qNJNwN9Z2ilOFDIAdQWtCFD
	YpNJK+eRt3YSDkaPwGUCiaSaWdgSmoFvwFxH/TPsgpU6q7K3mv+Gg8+4pxPlqDnZ
	v5Pcc+OgZPsbWJWhkeT0nrvCqVu0Dq0tbSdcnCvW10XrzA4nwFyiVSXNtlIeyGAI
	wbCmvGbxlsI0eZeSESGNkBOIinWFUqNqSr9vfOtASlbPQRGkdXtw1rVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104ganqdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 17:43:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FHQHb8010901;
	Thu, 15 Aug 2024 17:43:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnbdy93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 17:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqlSUzNc8dhhd2Herl5+L5xsa0xDFmeXRnLHVOQZMcQ8vFqw0cOMMOg5+WH3wbGSEd+dHlCrL32kRsbVJ0gCcJd5gwmcYEQln8JbdOdtUc3k60nSC6/b7NIKL5ZsLexQ5oSwXQ8SG2qImXngdMhVTebikpPFfrOsFTMaZPCALnEj5jXa4p/dVRBN4gMIB1s9437afs/50c1e1Qej69T/N+ycjEfIRZLZhlHJzGFaO+w3zU15omp0fzY1gq1Oyn+6yoa8E/i8phzvR3KujnbtPjmzFSGqMBwHAeiuScsFMfVNdiM87TV27YlEYqc5J1KXajIwgbyHoHDNyo4rDyc0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUbQcogOAbjs4a2oiEslwPko9DYTuXSKiV+BlAQLHY0=;
 b=pH7fm5joG2It6YjL6cbNHKvQ5BMgawZlWmTzaNDAQcp+R27VUJt4LJRpKFe24Id/ugsw+uskoDgbXoTuUZxLncdOFZQuXR9ri/DEMOEbQypd9/yciMryCsy/QQkyYcs8FrrYX2YC8mYykSmSCGbT6no3QqBERNr5ZYr5QUG5WB7J5qTIWCPxaeI2lmPc6kU08fRlUsWWTZOw4zMMWRThOc6Sj2KM97TEkj1Me+7nxJYRnCQHos1ocDyZln9MShp1afH5rpaWY7ODFUQYLtuz0+hzFzoc80fCLUZhYfXdaszSvrMp8aIHuif1p0s9r54Kt6ZSxaIQ6WLLqrdN4Bjg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUbQcogOAbjs4a2oiEslwPko9DYTuXSKiV+BlAQLHY0=;
 b=Yb+AcX8LXTLOscuIxnaWGe5oXZY9dDWcDVKCpy61Kazh2vcrm4KpvwFRNNwpHxwccTOGLV3Oqfxz2L7naJ0Sw5Ara3NhuqaA+UWdB304xBKgD+Ui6kxKDJXMS/vBs0tY4cXlRoHSAK+yXxAFVdIbicBLlIWkCMM23ORm24S8Yp8=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by DS0PR10MB7430.namprd10.prod.outlook.com (2603:10b6:8:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 17:43:47 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 17:43:47 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240815163228.216051-2-john.g.garry@oracle.com> (John Garry's
	message of "Thu, 15 Aug 2024 16:32:27 +0000")
Organization: Oracle Corporation
Message-ID: <yq1a5hdsmva.fsf@ca-mkp.ca.oracle.com>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
	<20240815163228.216051-2-john.g.garry@oracle.com>
Date: Thu, 15 Aug 2024 13:43:44 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0685.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::8) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|DS0PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 237de871-d582-4a1d-abd5-08dcbd51d0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rSnzkGFWSfHeW1NaPg1TcgNqghDRr8NBk0goorwKrxIJLkc6l4kRJ4TSMFlr?=
 =?us-ascii?Q?qVqICrHVMFezpY2SXOnEcNkgPY7phtKcdBgFdPG0mu/v0IWbR02HS6ILZ/dy?=
 =?us-ascii?Q?2TnhAI6dzgK78uM1j+oKCp4aXNm5x2+hKgyOIoOwJF0UV2lAaI7+9SjsBQ9/?=
 =?us-ascii?Q?oipjHLlaNOQZApG+QRwk6Yux/scxUikbZzI3eC9yFwPxqa4U7svZy+3v8Q2p?=
 =?us-ascii?Q?++ToAYG7A75io1/gLSVbdTbWNA4c8VZM/W2XHhDUP5PnR7zTy5HTTovXPBlc?=
 =?us-ascii?Q?d9s6+0UBuyY6Yz5G1G142mKy9V4qJwDbSH8QfziIuxb3rzGSMkbCrab03pDM?=
 =?us-ascii?Q?efMAQ9X4waAxJNfOFV8nt74BGJlzBoAprO4RSRHkuH28IsbD4wQdUn1et9M5?=
 =?us-ascii?Q?+8F+f5grwSncWa1f8f95US9up1sYAW0NFap4GFWEJamqom6jYP6nu+03CvvU?=
 =?us-ascii?Q?fQYuNC7sUiG9kloYuIAgCFJVlYnk6cXpdD4l70aqn7+c7Ep/CnTAuJiHEi5c?=
 =?us-ascii?Q?gk8LSKx3dVieDGOmi/9s90zPJBE6neefeELGRQRA1SXNclIav7e8XiDFjTu7?=
 =?us-ascii?Q?SCGwkpkY2ANiZ8sOcfJ2gtvR8eejfd/kO5T2GdFsqQgbw6i6H/DzQ8gZ0aEc?=
 =?us-ascii?Q?dEQrYEq6dCyyyYhx4DOHiB4YCSBhcTaePC50PmIl1GoYKoCBeHOePc+jZY3T?=
 =?us-ascii?Q?nE2c6zy9gXDq7h+STFjlCBd8+JIVFczJ+HQD/xzMmEFGmgeNFoD68bFhkp3U?=
 =?us-ascii?Q?F1ae/ALLN1OKWHOhVRSsJliDK7ziy/brQCi2NkI2zhsqZeOE71qvflD9YEqN?=
 =?us-ascii?Q?TqENyF0VOBTj0Ny6hneGBudxMWA6IGgZwMWuwH4azvLBf4SFK1tho9lIRDWm?=
 =?us-ascii?Q?hwiN5YLA5Zivu5KgjjV2mEwVhGYKVhpPEJiWBT60DYeFjhcqdwOz+BmubtmR?=
 =?us-ascii?Q?IZeoy8KZj/KJhYbMRca8o8hOAXy7a0lXGcqBQ+nLh6hZxwQuw5b3bOsYvn7F?=
 =?us-ascii?Q?yRwk1cTAfy9UlojvnhmwNh4aXh/3KyJL4xNQVjuh4aDNf2Be5zFE1z/Gs0dI?=
 =?us-ascii?Q?dJ+wWJdeCMMyHCZZL8SLWnrf04zwOvCisyfKEsx7E1ZBy4m4YTEEJer373iy?=
 =?us-ascii?Q?/ZGSNz5OyY+vi+ieTiFvKfFXp5T4ZW4I2IIA5G88nWu64u3emy6h+6o2XLjb?=
 =?us-ascii?Q?6Gmb2RKsTBEOzfPQm6k8ez1tU+kM+YbtbwzsHDTf8zqlWi9eYJQd1VxyZlnt?=
 =?us-ascii?Q?cCbR97IiAs0F/4eCVv4KJ1DNrQXjOfH7PNfoU986fruDgBcxfiqJ2yZrGuki?=
 =?us-ascii?Q?6vgPkzkMVRICkfc8OdXBMy9Z5zV3BhTmuNPOkvz+nFJdXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Glctz63+6dKWutwNe5AXN2yMlroqC/l4V4dmSGF4T9JLWthxpQoBXyzMcQHd?=
 =?us-ascii?Q?zEiMRvdTG2A/lPu4yOsVrBkWhrVsbzsRMqYHnKsnqUerujmp+7z6WT0HmBYu?=
 =?us-ascii?Q?dyh9TBy7TJx1hva5mEoKBoIBi49CogfrSI3tPMqmP93Q8dAhswZya3djBc+U?=
 =?us-ascii?Q?MSQlWriRRwSS078ua+4h7GryIPHepYlXd8CvHvg0a0PNDZQ+TIPxKzBgjDFJ?=
 =?us-ascii?Q?6Veyi9wQVmibJwhPlPxhJCX/mzhOcSWDsGA0xG4HbZwTSUFSq7oxwdrMhxDb?=
 =?us-ascii?Q?z9yyyVxI8sdVTVpYrnS2yCsblw4opfl2ZQIcmwpgZbdL+oCEbii8yEEyvCF8?=
 =?us-ascii?Q?4zvcLKUyO7vy2W+y+LAMH019mYk0lJcFTePbI68HoSE/HNMv2Lhm165GkbRh?=
 =?us-ascii?Q?G4Lavec54+OSBCBXRM6XSga6IoHJkV2PiOp6G3Vwf9YULUxYbIHNx2LjrlT+?=
 =?us-ascii?Q?8Wg1aYC4Krw6qTMAYdt9/i76XB9Hce8ttZgYdva5W/m4k5Ja/xS8TiU1hmHz?=
 =?us-ascii?Q?mEhM65mC8/mROyi2+aE7H9bCiM2nK6+WW880EqymZBqnc+1sBo73+R4Ivbmp?=
 =?us-ascii?Q?kxO8KKXdMs0KnqQnMy+AklXE7tLCtniaomHLTpv0ciSkSUStJeWkGMfi5W56?=
 =?us-ascii?Q?R4NxGOaCCID7iC2vV7Zh2ETufqVWoR33e89nj4tX/hZNGnhiOy3y5RcbiX3O?=
 =?us-ascii?Q?FfIZZhIa2h/tfbP68Ks66iNO/cuRDT+BDvDBmztwRBE7vem1Nu+PyYwTIzrG?=
 =?us-ascii?Q?KgYcM3p1ZDO0Gy5+Hno7imxJWY+/Q5Lia5xwCGnLlWa//+ohb8b+s1ylHJhb?=
 =?us-ascii?Q?TnoqEc7QEpZdJHDT5LZaSvQgc6U7yCZuTjiSNoP1SX6y71BBdY4+0/4C1x1R?=
 =?us-ascii?Q?ZU7AZwKFh7g/YQalZpq2bZR4Y2mLM8QOxrvxsy3I7OxSep368CL3Lef92QM5?=
 =?us-ascii?Q?SVZDOQNlgmtfsMOJSwGE38P1CKCUwwkcLYPUXqfiXJ+vBXt+jhiZzDecmsQY?=
 =?us-ascii?Q?CSb5px0Oi8XNL4EMhcYVwNz8XcyRGPNa/xUgB7IEtdXD+7xIH2BnGtwrSNeI?=
 =?us-ascii?Q?B2yF+v1mxtZdVXh2XLakaat0M2jqEVsnnEQGNUw5Q3Cuj8BUFSZtjh3FGXBd?=
 =?us-ascii?Q?wMFyDKqHWx2XRAaalOCcoWQHGt8UDSh3AMq6E2AxeLRlHhXGEtQaF8t/3lCS?=
 =?us-ascii?Q?PtcbUnJ3UWyNmFsfkfHlMC7A5GaVqm392GLyApKXSsQLMcmpl77jaVSyNoaY?=
 =?us-ascii?Q?gckeZ+Fys4nugQ2+F8C4rTI6GRxzJLMmerPANxfm8Q1ytgAcVAtGZt95I8QT?=
 =?us-ascii?Q?aTYB7k0AZGgjW5OCUJtJ1EO+5v0M2AzLt3pTdLmEqIM6y+D+6fzf/OzDDRgv?=
 =?us-ascii?Q?JpzwGPKkSzW8YAz3HqiODUngIGcsDYkPMhB2AWKswiadrfoFQU4zdPUSVjXR?=
 =?us-ascii?Q?y5pqfqB0yHX1w7G88bFvWs94J9CYoSNFhvhCfvqtM5G7cRQu0em4koap7W0H?=
 =?us-ascii?Q?+a24ZdbzNqWzZkjNuc7BRM4aammolY/fqClvK4oxVt36KrweIX6iymYKwmK5?=
 =?us-ascii?Q?KVa0I+fBEH6I92SSgNcTpTZbB9L6Qs0sXng9GSBSU2SVsEJAM+lCsabK3mrN?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EjlD1HDgwA/Mqyzmjs0yAZtQh2F/DfOEEaLxf89RQXg7KzVfUCeSEma68+oSA4ykSjmCnakosn+d/bxC6T5wJwBj+P0atrZ5YwWLfaIhe8cF0KCso/BiDKYhS06IG7JsQIGD5Y1THd78ZO6oYzLBWfBj4oJJ08zvtMg2QdmB3QzEwdGbAxHDiJDIxgTahM9ZqiBpKQd1HSGu/9nO+bBKPajfENqTacVWJgiD7XE4qfAZkD7syKBa33xNXmApYH9wHYk502a34pLLAhbnICWCcsn/Nb6MY8ZBZImNC2cFdCMR82GciIW5MbXDSg9G/E2S0QRtboM1at2RM90T3PASdHXyDt9C3ifD0RZ7z4H9isx6ZVmapllU6xvQ0kNKc7qhYehLZ8Rq9Z1ITOPZHK5O6tsijNhGtah1CbgoepQA8571dH/+xnlC9N59E/KwvANBjj7KxUrYJ6kRFln4bAHNKC4SUy0Tvb7ulr+j96Zknlw6mE5Qz1LcbJ1Y7nJsLtnm7AZDOBwVAjL1m5nJe484v+uVE8gfIH3Vr57J4KrOaP24r274/Tz4TN/YfRQYuH/zjfDuVan1JEJs1jXyiFYBoQcPKjq8ZaWoF1HclmGfCrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237de871-d582-4a1d-abd5-08dcbd51d0d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 17:43:47.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIT4lAMF02uoC4LP11Lz3ms2d9ALqGy7ipbyREeg3sPLPkaUMw/AjwfgcOZFQDTdZLpJlRaJAO5KKU8IKiEOqeNBQzxCFNZ8+k3CUvc3mjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_10,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150129
X-Proofpoint-GUID: K7AFdPA8Lx2CRysCO28EW8VrzOwX-8rg
X-Proofpoint-ORIG-GUID: K7AFdPA8Lx2CRysCO28EW8VrzOwX-8rg


John,

> As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
> drive.
>
> Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
> changed __blkdev_issue_write_zeroes() to read the max write zeroes
> value in the loop. This is not safe as max write zeroes may change in
> value. Specifically for the case of [0], the value goes to 0, and we get
> an infinite loop.
>
> Lift the limit reading out of the loop.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
