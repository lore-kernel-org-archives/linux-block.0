Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DF01DF980
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165340; cv=fail; b=g9mzs4CA/xEmO+TWL+anf/jxS3fmaoNRwSdwBt7EQzfd8BEBMBBYlNm2WmymnVQepINT761pyS/XZwyil/Hz03UrTjWIZKVK8qOgH1tKqYBpFLTMQZSDPn0Zct3WCLAVla8ZegWpdQzRoQO8W2heqSC0WQ01bLEF2maML734l7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165340; c=relaxed/simple;
	bh=5mpUHm6cQl46Okn0qiubCxD8ecQdo4j5PmVOhiML4XI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ma9oB1RzMES6UfC3WdByuRQ25ORDTcuKiQsLOxqfBFQsRWOdk0vFd0JRmucSzgHJ25pYJyXOu8OqsjtEG1YiMcuXWn1SUv2FbideA93xuMM9WZxvD1vxaBwN5Z6PQp84jLWVYYexEpU9g9RU3wNlYyLEIsokfgSAdtCcgdL0ldc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NuWzKu6Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k1j9qE1c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NuWzKu6Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k1j9qE1c"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFMtOP027806;
	Wed, 29 Jan 2025 15:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fSoZCWdteXFCf88XeO
	5t/YwgjgITNprmcbbyqpVW5aY=; b=NuWzKu6YBi/iiYUp+gBv9+16ulh0vU8W+6
	LaRrZybCHfEw61QBRAbBmyvq31b8qVuc1pkRoLc+xJ+cpXGudk419vO5nFOPmfSe
	LT3lUvUfTLdhWQoauKg5nX1VCTFdRId/GCq44FSygMeAhIfr6d4s5KIS31IMJdeV
	nFhO5fAzRgrll5+v+Jv6ykb1vYxcvi4lYF4AOM+aRe4yK7M9tV+3coQRFoUR/Hwm
	YG1yjYra717SXBAOwjBkn/sil73xdzYtCSR0sZTlXgNGdZAzhiAX91husG26KIkq
	KUYf78EgYxsfKGD+7NuCVtqjYsFYfYW65sAUUafb7FsJl6BzEfRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fpfe04uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:42:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFH5iC035827;
	Wed, 29 Jan 2025 15:42:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdfwyqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3V6ok6AnEEwVkBRFbKnyp6EAJMPHdNXZDmFunY3PHjg7fAOXULnQSjm5y5iC0ApVHhYZQUYUgoP6gBSpn1mWsa/EcnyNzcmAdPpdp8b9IjQHGwhDB2KTzAqPGebyxRlSQp6XU45qNlKt7ousKLkOnSqWljjXv5w2IJWiMETv5/3YRVO+bQk5uzbA9oKRi4p/hnSvB9Uit0iD4g0ta51udpiTDkDBDfLpwjduGizYkTjoPDSTYj80ZVpX12nzZU8hujh9Z2mNOssiOeIo7AxpevUBKK7Z2Q5EAa2Chkpj8UO/90wlf+04GTn1nVwF4qjOdz3Pd1sl6bq0NGo3u4EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSoZCWdteXFCf88XeO5t/YwgjgITNprmcbbyqpVW5aY=;
 b=zIGnbKXrsdtgQysJi+symrq55WEXTBQTMxqmWfoRF8PqdGFZdmV9xjdrzrcexJwqoa5OcQjAJDo7R9aWqVR/zfUQZGz4sH0o+v0+Pv+aDxD44WsrQAFn2/DieyTGyK0b7oDdhCMu8y+UwGM7NAavbgJ6vSnLowb3o0jrXpkzi2kuOnh+fxEh2JmZT7YkrCnKUNHCL/VIyMN035dCMQNIhVCN3Tg2x6S17C2wsdwdZJETtqPcNWr7PJCFP3rCaWoufMxVGQ07ID48/da1f3QuGuEDvHB5CLv71JoWzHVuhyG1IZ+Lp+nzC9suZZ4gYSTOGkKEuh9Q/db4oboziFeT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSoZCWdteXFCf88XeO5t/YwgjgITNprmcbbyqpVW5aY=;
 b=k1j9qE1ciGF3N6Tol7FfSe6/jQI26d0DJCNau/bI90KNAQt7g2qRvgBVEDF7wVCcP1YzTgBHfNb7R6JgAqyecohutJjohRJAjTaq10ZzLpRBLnejqFs8H0k9ywli1PUHuyboN8r6ROqxJyRxUqone3bjwTX/nB8pb7uo3tmvZUM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 15:42:06 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 15:42:06 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, Keith Busch
 <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: in-kernel verification of user PI?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250129152612.GA5356@lst.de> (Christoph Hellwig's message of
	"Wed, 29 Jan 2025 16:26:12 +0100")
Organization: Oracle Corporation
Message-ID: <yq1tt9hr62s.fsf@ca-mkp.ca.oracle.com>
References: <20250129124648.GA24891@lst.de>
	<yq15xlxsqkg.fsf@ca-mkp.ca.oracle.com> <20250129152612.GA5356@lst.de>
Date: Wed, 29 Jan 2025 10:42:04 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:408:f7::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 894e1b21-d6d2-4241-c02a-08dd407b7bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SezhHpEo/ji2Z583QKHK30QrDqT9wa/eKk+uA+yEd9agqwAK4H5MtXzCJjQa?=
 =?us-ascii?Q?d5CWL8i25ZZF/cDl3jPWD/sRh6YfMAJZzRdx7ITc39JIViIdqKR5Mjfz1shY?=
 =?us-ascii?Q?jLemjJ9JgucHVZBu+tlyHqLkqyCkC9LbRn1lJs+m/TnR81ew5UYhODwRme0u?=
 =?us-ascii?Q?2imu8Qiz+qGOD9CSKLZUfNjxCI2pMWi/uhn2HkFgC1sJN5wGVGn7CU7NGp+S?=
 =?us-ascii?Q?9UT7TX3ufXsUXKdqrN3Ze/M63qSt5TWPRnfLWT64DSOEYnhZhe97pGr98ddl?=
 =?us-ascii?Q?x52IpIZp4yz9y7wTvax93T+7b2b7d1N8uycqq8NpRGqI3n+RevoP+0JleCJ+?=
 =?us-ascii?Q?2/tqNH7Ts4Os8rCGusMRaCoilkZDmtXkZO/ezPnIXx6SdPMZg7Vx1IQQZ/98?=
 =?us-ascii?Q?kY/DoZ6JlgWblTBQWJiHo3hnwTDLoIIgOotxdAsfyCHdQ6m4UdDD5mfSnk3O?=
 =?us-ascii?Q?EXtdvYqTK/J03fclHNVwBucixOR7mZ5ct/3WwgnW+1ia0uKXXpM1YJn2Bm6w?=
 =?us-ascii?Q?ciDPfaKzlAPcZfBnkY+umWYpLWOXDPnaqCNXwlngExRwgAtBQH0I5dnw/tqq?=
 =?us-ascii?Q?SDvkNVgGMKJfeP+al9WfP6LO+la8x73wfr1UnGKydtMEGezJ9UHagP265frk?=
 =?us-ascii?Q?19YHtjo8byzFzbgCwEnkqy+F2kSP8wYIQzJEjdlGzmTWNPstuBADRQrSzSh2?=
 =?us-ascii?Q?OK5P1eSXl3IwgaOgoDOX9o+jeTQluvTGgCXhQ+453i6D7geBJszj0Nj6uxSq?=
 =?us-ascii?Q?baXi3vyBugMXcQ1ek3z8FCe8PG5YHX4v+gWX0RCiLQk4XxuiDN1ODYH634iJ?=
 =?us-ascii?Q?yP0tt9ifBLi8fD0n0GdNOM1dcgSI9T1AvBjNNH9t8D9F2j40u12JyJYqqY6E?=
 =?us-ascii?Q?IJVy82PIXJQcp3Ze4AwE6GVM1GaMGmrb5rjZfw077ponsqvyZqc4G//KGDyT?=
 =?us-ascii?Q?nYr0ud03OmWFyIEQs1WnU+SRWtWz5Udq8UXFP9nLMTPQMKWWh63Br2DGyJG0?=
 =?us-ascii?Q?1KnEVBQgnp1qf0tAKnbJpZOiCwSZDL/DxibjKBFWpYvBkZaxWlS+P2IZzt6r?=
 =?us-ascii?Q?ins035DQLm65SOlsZWihqdMdcWIQE96rwF9ldbWXsRvCJK0YPbbhP4UC/wqc?=
 =?us-ascii?Q?0/5p8FKpA+p0YSWF/ygvQkQi7W6TkjJNcC4/yoQjkpMsXfZLEzX3OY/hREmY?=
 =?us-ascii?Q?X3pfchbv7cjGDJ+w0x9riWo7kvGPpVdBXLXqgOavD6L0UUWN81PwMwWRPugp?=
 =?us-ascii?Q?IDRg4SpxEDIGO1NVendD5U26h5T189jtpfF2wkf0ebvaw+BoDeCQ/dbWpsV9?=
 =?us-ascii?Q?j4CgaKMoQvSjCnQ9ngnHTxlrG50k+N/kxOxh+jZCehTNCOg4qJpsallpLIGL?=
 =?us-ascii?Q?PRtzjNT7H2GgNgBp5jQq70PP1yD9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjR/uwQ1woLkJsJtA6NKtv48fU0X2432vPI6eSUt5bY2ANUctd/unUUCJUlj?=
 =?us-ascii?Q?18aTmcsUGpglOAo6gsxnX0I0qaiG6oOpGFXlmmUeNSujYT2oC/BlremWtnUu?=
 =?us-ascii?Q?PKcykCGBp2qgBVyrqVXjfVlaz+cRPUWYbjmyg1zle8JE09Uobsk9mE/k+uu3?=
 =?us-ascii?Q?ydWMiLa/258sR/2KV0bTrFUQpyKg+0ehYPEvWi+A7kKGnT45lFZw7WJZ4ec2?=
 =?us-ascii?Q?/tdYfck5ds/3JldPQop+PiwFkASXl86d7pSVSUMBXMJWGlS5FUycl2rzor7/?=
 =?us-ascii?Q?Q+n/Ln4RqcS2uAukS7Aa4u48oqBvjmNHGR4KO1SpQLA30s/BOL0wp++Uwl2H?=
 =?us-ascii?Q?YoDlkYlWTcGNWSrAij2ZGJqJA5hu4JRWrmpJAmuoEfl+Fw6dzPiFzLJg8m36?=
 =?us-ascii?Q?XM8Fut7CqNyfyWbsxLmynqeaf2y7Fx4PBcUumcR4rDR0VdBUVPYRh/773zRf?=
 =?us-ascii?Q?bjyzcO7JJcKPdfzvjA8bphDWLO6s+s96qonPuyBCX00sitNYM/7kWfWWFEzj?=
 =?us-ascii?Q?/Tb6n+8jHukuJq7y9KGy6qWpHzQq0jvraxIJYM6UKWDmYr6g4ymq4XkchK0J?=
 =?us-ascii?Q?j/LG3tjECTCDOCuEBPHl7rHHP4glkLpnzXj+QG8hp3xHq2CpbV1jF+8SZhPY?=
 =?us-ascii?Q?CuT3RzS4cRPiW5pi8zjkhCFtp9vn5qcsVLUTiMylElFzKqPzWbY7aNWuFUIL?=
 =?us-ascii?Q?BgNJFYDVLQ1SzNgPiSVHuyLc3STn8fxrn3imQpNy4T3xhRKqAqkxDGvO+uUe?=
 =?us-ascii?Q?oJ7FSPIjfBfmYQChmEnzKDfnhqOL9ssxWMcE2KhCBmR7t9s3R+J3VqmMQwqn?=
 =?us-ascii?Q?Dqai7fVAmyR5jGOKto6lG6fSsZ1dA47zGxgqXKq7aYqLszMPROCRJ9oxmZXK?=
 =?us-ascii?Q?JdOWyFX2QLpNNr0WJBuP3bhWKQ4FXAkHzIfQQ8ZXTp9V7bOLg4tkKGHc+4NV?=
 =?us-ascii?Q?soW3MtEnOT6kvMekDu229nsU4gnHJHwk9TBUqtCFDW9kFAvceDRQPCKIOM5e?=
 =?us-ascii?Q?wHhA4Y8RZWmfyiqIbFC1cm8pM8T724bdk5Nkz7MEEvwbwcbya9XHR1jO/LKQ?=
 =?us-ascii?Q?OEZP2H7B/Hb/U4oRpol198KVPMYBuznBqsh3Wu3GSctAzyfT0U197+4fwDu6?=
 =?us-ascii?Q?qxKPPuC3/2TiGpxTzCR0gJP+VJfzO6gjwU3qI/EZESMQ0LDFAmeEMcWoFP+x?=
 =?us-ascii?Q?zNmXUqJwzG4X2LulmghFraPVdtLuX+3ZDZ9Dt+ZraTKvY5iuENGLuAq2Q5yt?=
 =?us-ascii?Q?2glBzHjws2/qB++cq2XYnHrx945rr+VKdgT4w+04RZ8lOVd/vg+/kDJlkmFl?=
 =?us-ascii?Q?0LaUnwIDMsAU2joOi65ZYMUB0rK7JUXhN4LMQwfJRYiI+onPFuPXxmxJTwVE?=
 =?us-ascii?Q?heauE7fejwDZFWld1pVMYeZkONsEIYEdrr+bPDSH3e1uY3y68buwI/qt0mL5?=
 =?us-ascii?Q?omtuSMSzBvU29oJksvZIivkXNAPWuKzTcCqR1uN6yl8T4V6wFuNFBPOH8nAN?=
 =?us-ascii?Q?Xjj4T8hwP/y9+a2xppo7rNeLMpsONRv0wy8uOD8kD9AHtSbw3QqdfASrwnhI?=
 =?us-ascii?Q?krdq13YQz15fClSjB+ePc+mnLv5rIagh4eb1IGngCgNU1ZCAbw0rCX+KssKP?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IoY/F8QvA8csswGkloxQlZqtsfFAq7mb8CKWrDfsr/pkQSZYD2KZIiOy4Fu7QnOLntZ5yUT24juq/F1vSx1D+zI+YYinckebl+bxXf5qKqlt+NpZp1TeSbCw2j6HHvzqi17OAWWhpI4MD+xLuFu1m3f+BPwN+JJIKLomuc/sQMDuwVR2Vq4dd79flxf6UAPw99NOHTWZ4tJgfOXJWT/dcF+Ln4JSAJ/fNnaBKSO0GjLrPg1ARj3qeLLAb+PA+kCcqRUfmAsMPlR6q9AavIvlp7PAOPn1tArY/5NF2fgPlUpx+f0W9RZIrpHsFrCBrWMBWChw+wMJj0QUuC0lO6Pn+te2hoFE1yJwCamApK7BafXvRt70p91Bi7XSxvdZD4WgM+cb+s9uNX0T66EGDKV1hhQeC9k9m0hS/7a4E9Uw6cG91uJv5PHGO4jtNjvrYsg4pTJ5yBCn9cQslr4rYiZYHZJHVeIXZT2oBTMunwZTvHvblLptMVvp6kjzJb0kcVy/mssNSJrA+B37szDsxWCdNUpeqnLMEVufnxA5ysVjx1CsBYQNNILexuFieHiJBOQKt36apOZHLOX7xeTQJ0TeGlLelStFfwCoZv01ZQ8oeiw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894e1b21-d6d2-4241-c02a-08dd407b7bcb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:42:05.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhuuUMsdk64q1l2rJ7zlRzo1X/SgnCYwA9RClXi7H/NozhhpnQyFEi6XFeYmNvQPr7M21lKnpbgFNne+p1ZC4sIcql4ywSfUV9PGcCjFHq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290126
X-Proofpoint-GUID: 9-c2HISGNiOj_aKVa4_C8-VfzwDDn7rj
X-Proofpoint-ORIG-GUID: 9-c2HISGNiOj_aKVa4_C8-VfzwDDn7rj


Christoph,

> As in supplying an offset for the ref tag somewhere in the HBA specific
> per-command payload?  That's not implemented in Linux as far as I can
> tell, or did I miss something?

It fell by the wayside for various reasons. I would love to revive it,
all it did was skip the remapping step if a flag was set in the profile.

-- 
Martin K. Petersen	Oracle Linux Engineering
