Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43E209F50
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545891; cv=fail; b=jYJTl/HLrEpABTbZhZgae0FWdy3odjxP0V1nWy82K2dKfytQ4zl+d1QtMcGVrl6Ir8MlYZY5SVWIfNARoURoCMiRUWTANXKtW0+wnE0gjZEn/rwswsZpaBk75gsxbPmjDvTilfXLBY8MIRLWjZz2YZuuWCy2L3UyGLHrLaTdqD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545891; c=relaxed/simple;
	bh=nzWq0mVDgknLsql5nE+T4rpk2FQ1KogerdpXudiKTAw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=GtxW4CbhNAFt/+4qBUBTPpy0dMfCzhTybgrOEHi1y1ea6MJ5m/aZm+mSM8Uo2EyhvSC/jUx1J24kExXHW0yXB8TzByCLtPGfpejReNPL3LFmHXsKr9qz7ZzPkjauf6bCisDQHn5NzTBjr2ZN+FUdou8mi4QoAws9ks5Ny9E6Ygs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BWAutgaD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qF2WOD1W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWAutgaD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qF2WOD1W"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ALBncF030519;
	Fri, 10 Jan 2025 21:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Sz2nbdAXoTyamzHgKX
	R3qb0sDHMNtF49+gChD8oI/oY=; b=BWAutgaDluJrpUYMDqw9G1dLXLJ+70BHso
	ONVTy/FWMCAzmtn7mmwcf1fYiQRDhPU9ogeJtociiHXJVBrU3Ze0M7dN6eAljVM6
	B7IIpDVfdsd2mF28MAP07YuvXVPhdIajfElysJPH1LOloPQ6rF8DLeX71SAtN0fP
	7+FpvPgFKwRGpKFNtXQqRoSL5tAaSabHae5tVoQ6urfnNFkcsrlctNMTnLTGpg9l
	U6K9xLphBmyodz04+mUxVVR8e4Ofjy1c2Nthh9SYbzsYNz73lps1uruj8YX3C1N5
	9EXmgvJvvadlOrXhzhWZ2lWU5S3SELGjbqMXCLVfKQKU+H09x91Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4427jpkpmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 21:51:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AJUMg4020044;
	Fri, 10 Jan 2025 21:51:24 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuekb79t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 21:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdHlO4QERS0jZ5CpXukeLksjejiCNK12F6fL/UgfA3hrxAEmfgd0nRYbdAVNyKACT6aOIi7m5+WpHB6L6pg5IDfnnZuSmR74pZf7qQoNNRx+VxCvraz4FVZWMM74CpS6kkhuTQNSEF83Nksx92U2AIQtgUyM8TlnrOCJyLDNL7NPcWQg+Lp/GzhKmEwx0I5nxX/MrCsBeH6eEzy5FaPT6RYnnydgMhANa8ge1OfCiaDTM5ORtdQ+ZZfgbGQlNwFy5e8ePJCtgrJsXAardBHfUIZ5DzbN7DLY6+QyCLCmkZvMvH5VoK0gE1Tw6PA+EITMLH8ia2eULj0cPBpzbG/a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz2nbdAXoTyamzHgKXR3qb0sDHMNtF49+gChD8oI/oY=;
 b=pVyM1dgTFsENa8B8tK6vkzDcBzszJi/AUHwLRNfjWm++mvbsWHebRqhJm5/itxssBE+s4okS0da+X+96IMoMpAl4+2/epy7PG5pMl4CBLGvPyVVNTuE/gNHzMDOzQ0e9TY+wVm+giFRkqdIMy4p/PzO9JMv/ZR5XUexttQX6xS45Jaer6btQh8FgP4vvH4lYtIfwxgYBjpwaeScwI2PW2HZ8SQGtWZTxTtJmhSiVAdLVk35VYvipDDloo6GYnM0z2SAakFlgLjrz5mYTvKCRjOZF8G3Ud8kWhRU91/8DtlusbziX/3zAl1LkF1XIpNFJu4kvPevTHWA4n88RGVdcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz2nbdAXoTyamzHgKXR3qb0sDHMNtF49+gChD8oI/oY=;
 b=qF2WOD1WThwNTgZIGvNIaTJN94EJr5ddRZa8KCmIGO+IhXXeR0OvBHEthQwi50+bVVaVpKJlrHKQfobaQWALGKuO1IDMFJhLFs0qGBLrvEexW1fXNlVGLV2bZezjosLuu71ktmal0m6184jnUxrBwPCpIANEhi5Gqx6a/elztFI=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 21:51:22 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 21:51:22 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Subject: Re: [PATCH 0/2] block: Stacked device atomic writes fixes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250109114000.2299896-1-john.g.garry@oracle.com> (John Garry's
	message of "Thu, 9 Jan 2025 11:39:58 +0000")
Organization: Oracle Corporation
Message-ID: <yq1o70e5oe1.fsf@ca-mkp.ca.oracle.com>
References: <20250109114000.2299896-1-john.g.garry@oracle.com>
Date: Fri, 10 Jan 2025 16:51:19 -0500
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BY5PR10MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a3c0df-aadb-4493-fd57-08dd31c0ec12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O5cn4Oz/7mE33n+lqIoNHvnEOygJYiE/1W1CPOdNaxkWxzg4vzXuI0/SzAms?=
 =?us-ascii?Q?oKtk6Et59wVR2IyY1nIJdpCwgMnybAkFhs/+9cVaMeyx9E3HtGeVJIfA7/9Q?=
 =?us-ascii?Q?XfcdStTxm6F/KphkqQA+5RvAuW1MsU2VpLWnfr2hVUPHihaO3Dpy35PY/Mhy?=
 =?us-ascii?Q?wVxYEDWlSjhKrJu5nc+i7gmKv2CoV2oKBmjLAnMktMZT7B6ExiUm+qtIcPOJ?=
 =?us-ascii?Q?v+ll08hJpxLjvSG6rJpQyjfBoMEGpldx6XE7xNhD/rtlwZP2tUEpkUcX2vqo?=
 =?us-ascii?Q?a69KEwQSVNW2QNncaJlACXrTaQ82K4ZNvCIOZCyLKpNOwcGDF/9BQ02DaK0n?=
 =?us-ascii?Q?XUBRiY+jU2g5SjltgOnd+/XOYVBwZkVjfPj9dtJKYTjT6UiCwh+VMllVk9Ai?=
 =?us-ascii?Q?097TFj12SxGUBME8LF2FmQ0zzwdyeAZM/KkVSFw/k37OWkMHgVQC5q8Ig1sN?=
 =?us-ascii?Q?Oepgljr8aQEi370UNbWfHFCR934rg32qPyifFGR6tCq9HkBdqvlPlMb7+vzH?=
 =?us-ascii?Q?GDZOb4VDG9HDI8FCFparfc+xVOu2j0VbrGWIeJWlrLjTmRr1HFe2UY0qFeAs?=
 =?us-ascii?Q?PwglKZJqZMtwJnJuXqcg0FyyN+gkhLAk3jr5yV4ZChc1ugABIyhYLSNOAhxG?=
 =?us-ascii?Q?ily7EKYMBZbuyFkHZU6RVL+unO8pdZPdYAB8cou01ND1r4Wmy9BAiUZBz+s+?=
 =?us-ascii?Q?Ifje1HqIqU1IUm8SDfnyxkaiEp3sRM5M3lh8qkUxDVdXQfFeKw8ypJLqeBY+?=
 =?us-ascii?Q?7mLfe1xzcFKv95ThWmAVrP0Tm6jPr9uC4S741qXohH8YREnR8EiJhvv/I1cS?=
 =?us-ascii?Q?NRq2gclqtK3MFThq8wMXeWsWgybBA8LbgXO9ayth7JVYMb3d3ORT8otKDW+x?=
 =?us-ascii?Q?PjvnJr7v0108kZTQBe1yXx3HWRLhxGMVKi2D/wfEv1XKyLbIZfUFfOXUk7tf?=
 =?us-ascii?Q?E1uie/7tsSzWaBiQarIITUlFIPVNkvLmZDs0BSLAmhPWGsBgiZuAwxk91voM?=
 =?us-ascii?Q?pIsFi+PC4yANRLxzJOflc3YrPoDlfGo9okjaEaOuFawXQgO9IlUofU5I1xbB?=
 =?us-ascii?Q?YGXzSJnegPK4vLH5jlNhzChpWHnNgLDSRhuckb7h5oxnO9h1lUry/Z/fnzzc?=
 =?us-ascii?Q?FO2T5olPAK6Yx/bztRxL2HZCm/wbEUaofBSktXrcBV0+BEcEwuh+wQkX/dTI?=
 =?us-ascii?Q?J+XjP0vyE67O6RltMBmH4JkYnXAU7MVNcIDWmgatEAC+nTMDOZhba2KJov/g?=
 =?us-ascii?Q?9XROXu6N5XpNPc2z4MovBaOd61OCm7tq84qeLg0M5GZV/LAfKtWTbk3Nip+7?=
 =?us-ascii?Q?7jQ9FYPtRWr4b4dyNxP/3rvTuTNvH2ljrf9xieH/29fiW0VQpvxpRr26u8ao?=
 =?us-ascii?Q?AsNML4saYJusRDs90NVgw+Ab0IE8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTWNPHRBWWR0OB+tZQEw8kElyUT+x2OwAJzOBlq6LgpCHQce5EJ+Pgs3wJpy?=
 =?us-ascii?Q?h61UCpgmJKkZaVt7mYg0eP/e3Ka/TiwH7NSNqwNWNN6xNWl57oYyzltHAMFh?=
 =?us-ascii?Q?pzS4fBIuRNBJbcZkyTBozLPedbQX+4Axvabg2c3iO6YOEq0hkiG70pbdcRJq?=
 =?us-ascii?Q?8fNU6WCnY2PMcxVm1N0crt0YTqEwYU4wXkKsv1DL0IACMSbT1VjDXWLqBKwU?=
 =?us-ascii?Q?4L81gGJ8q+bG4BBtFoI6+Cm3SBvB7dF6ibFxD0qlOkjydqAP0q+65bto7yxR?=
 =?us-ascii?Q?UY6eTc/6AFQIPGnmG6jDtDf//6oPbglA6Pa6n4tCfLcBKh3BtDrMOh3d4TxP?=
 =?us-ascii?Q?hltmzbhsQ3PlsuEM88SihzIuWScbcUG+nxmurEY0+wB45o/kPgJCYgAMLQe7?=
 =?us-ascii?Q?lzpTTQpQTWXFDyKFU7Z3aAAum/6dlqtrEly9R348AC6zxSX27PAPAZiGkOKt?=
 =?us-ascii?Q?IZV753ArrM3Q6HOLU5F11DHdtyFHjzM5eQnbf4axamSE1SZ4jEIa47DscvdR?=
 =?us-ascii?Q?+MQJbgu1rlnXD7sBW+EnL0bM/pVoKRFiTFOXVIv/j6wvjIo9eCdEtB2s7Q0q?=
 =?us-ascii?Q?PH+vQeV49XItF7znXYYUO6Wu2Za+MzHLfU/gi3ja+A1jwGmAse/y2eHft7p3?=
 =?us-ascii?Q?1SGkjluX/kikDmzg2zntfdEcBSH9thb8SwPYvTOMfXnEv6Q9sxdD3UDSMiIh?=
 =?us-ascii?Q?0N0Q12NW7o5b+jj5mum0HQ2ahrLPIvER2spFWQ7PhEZRimD6B2mSJX0/o6u+?=
 =?us-ascii?Q?NSY7gCoPhC1riH3w/AaZJfrdSYm92YT8PDgi2q2ejBxqlqb3NBWyp4adgDFY?=
 =?us-ascii?Q?8sHoQSdx6xm3bDut0PHEcaACUYhHMufJ2kgQTC16ne3q4PgEvmIrBiETbgak?=
 =?us-ascii?Q?fH2MwDSpBMMbzReJtIw2atJxNkOKKLDOPsRWeSdrwPxw9wAVYkJ3WL+U2Qkc?=
 =?us-ascii?Q?wV2yLlPFcXnZL48pghSkUdIE9z+UmlyfB86kIh0wnckbY7JYJti7ZhHy2fWN?=
 =?us-ascii?Q?zaJvpj4WPrK09y1zcWyCgFRpS60HdtJV7GLqNC8hLrBigUblMA4Ls4bwojMm?=
 =?us-ascii?Q?gtBvvXrApoS0a9RM7tQq2Wcq0wVJP3zrgn7bbhkXWcwd0gIMCdL2huGFv9Vy?=
 =?us-ascii?Q?TsrSRoV86u526ljwOFU/uxbM3CXYUkPkuXkFL17IuDbYq/sWDRCstRTlZO1x?=
 =?us-ascii?Q?0pBjHWfSfjqQb6M2QgHwrOD1lucozK2KinTJNovqQEq1LaPmA/6AcYyJD+PO?=
 =?us-ascii?Q?vWOHxWZ8kKeTznX3KNs61tah216Hz1U5bicoYQq66rXIyq93tbAN7lN+NSsR?=
 =?us-ascii?Q?FemYTAFI6ty8OwQYhvQdR4bsX+GyMiNZOBTm/6LZCWYj82ERKNU739oxHkEp?=
 =?us-ascii?Q?MbdGt0Tvj9P7e0I+UpnWGnJ0ruaqYO2KtLyF5kas00dTwtEwu83HyO/w2gQi?=
 =?us-ascii?Q?wjUoj8g9NHQqnOPkcGqJdt6jaZ4fYdoSYnnMqCddM8bxwQnyNZ8oteUvmDqL?=
 =?us-ascii?Q?KckoG8YRADAGb9m4z2M0uNC5bchAIqJxRwM5bM70SvX4cu9pHAPl54sRGOhc?=
 =?us-ascii?Q?3AIE4DCBwFmPetMdEU0vVqYdtW7V9ZX1iq2TSPBegSGiVteZC4TYeFuiGONG?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NwZjaLrkW+Bloj2D49CBWHViFQLtAVO1VrUjTjIIufq2k/xCijrU2Ijhh5VXt/7Btt5WQSlaYJu5MA/UjWVV6OWqt+8yJqZ8/XpntU/+75ppReVZ9J2/5nxkaUJurEO/XMbT8tLxHGDwcEGryiEj2mkzq4H+o/h2McjNinOcqt+AWRhdSJ51XhY5KvBJ+lL74RLFvCDW6XFIkAKgDTdMpD9sqjIO2BkUdlUNqrIJIIZqLyOul84iiubvwfe+VLagV1cCAZgckI2DopqjYF6zde1F3UbWg3FWFk4aLvSElZ1VJD9i8O/t4VHgkp2fnsg3C4QkIraPLKw89gjpjotDnzLHpM40nvdACIbZPFCdrUwIfS5bQi2O7FlDlYKDlOktKXvwL0wZa04pkxWqgSJZk+fwzsJriG67KKm2oLpUENb9Jmo0ar9EPE4EE4FvdfVJHzstnbcEntgIFMJn27EpS+pj+OR9J5VOB2pxP1MrwGLQqh0p37qpki47eQKi2/n+pKE7LhxEHvBV+UW3cEwlNQMKsD8HzThN+WvQm9SiKykD1oY0nf2/BxG9iBOzVvUxyo50SRutMAbeNrLLXGuPD/bh5l5Jmx+chKiVsH+6R5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a3c0df-aadb-4493-fd57-08dd31c0ec12
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:51:22.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW77mR8kaftxZUEG6mzWbUMRg/+vq6adNACFRVFWEw4VHx7XmgpduN8EOK2hNLugHArnHk0031OD7rQvOjHO9DdX7NWVb88fpnUAknKk2+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=987 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100168
X-Proofpoint-ORIG-GUID: T3Lpk3sf0NuG1VPeyRvJawY5wfDPAVf1
X-Proofpoint-GUID: T3Lpk3sf0NuG1VPeyRvJawY5wfDPAVf1


John,

> This series is spun off the dm atomic writes series at [0], as the
> first patch fixes behaviour for md raid atomic write support also.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
