Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8D18C28;
	Tue,  5 Mar 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604896; cv=fail; b=Wu6/pz2PZPfavdt10l/KWIuzjDv4vuq+twwYHRLLJjFYHxbojpDcKMestL/ehFKNNrz7rDVlZXRhPLDNExzG6CE4UrPUmZ1ceJIKS9LMycJndkgvHKXF5Z7AXt1vrOdOqGH0KdoPr1jgLRdDT+ro1LgjjuYtBK/yXJ9gOr0cSYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604896; c=relaxed/simple;
	bh=8zVcxpc4lj6FlDM3eYcMB8Ypm9Ie0NzSKwujtbNP8os=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0rHKCKLOwEDsiUep4tLQsmlvK1qsv04nbylq5isIkvAsq6TCh9U2APWEWrhKnnsmUtR6+n61994yoFBDL2A70/47ySosPKU2ADAUIqB04hPKLU6x1haEoOc84fhCgJwNcwBEWdmMar6IhpYCd4rphTVhNhbOHrGChrl8kAWWqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SPwlIZww; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vpd3zWY9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPwlIZww";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vpd3zWY9"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424IxfDg002258;
	Tue, 5 Mar 2024 02:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=VgcGe0I+lfb0M9OjfYgcbcsTooWwtpH6IzVi+HDZOrA=;
 b=SPwlIZwwSqwrBDMicitX1HKe9ILzvYl4ovIYMj5Y/ktspHjmzEyMq71FGnzq9CrrO23u
 FEJb0iroCaR+0xzXaWhveYul+ioZ6mOdMSZKTSoNthkq5R4CCmSuYni5Vgyq+m1Erogf
 +Rtb9rWOOWKPworOn+T92EKOFAgkCYZmzv1v9+naK33yg8j2F/pPeZnQpiuY2nryIT1I
 i3hfwY/1Jb4ZBTtGOY+WiAMO+zehZjepLWY7bHBRLNOMcAaCfOnexomewlOoraIE9ert
 s4cbWEGtNTr48NqjAPlLlW2xrQtb/mpplbOxZJomH7lXNq6dyeAdUMeq9Lp4lf+N12oo AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dd6p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 02:14:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4251ldJR016990;
	Tue, 5 Mar 2024 02:14:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj6s068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 02:14:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1OEn262NYAQKC8Domu77PqL6gW3NvcBKOkpN80kp/dCKbv61TaCPVVLrNrgYvyVUkUO6QHK1Nz457s3UHMwg8DyRTVgTT5WdhY/CtrC/4wTS5SPkw+SgPae1MkMmdeGiHbffkeTEcAEH2tUkl8qp8PEhSdfXVzxZbdM4d0zoqMjf/TzIIxt/g3AZgqk1dp2UvDCL2Czii1DK2p/RbthTdFD2/VYh/He5buWUcc4Y/mxc+I46Q29Fl3QhjOG3mMpqrygZ7VTGmyDJWUAp4bDtFUCKwoJg9bken1kfh/Z2rSdiHUa66eQQr3cfX7pKWjGpTncFhaPAn4a5G6/w4fwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgcGe0I+lfb0M9OjfYgcbcsTooWwtpH6IzVi+HDZOrA=;
 b=MoXOT8gI7V3gcrvIxTPmdCkxXIwhoMRAr/zGKWrkjlYNBI8NLUYJhKTYFaWPZwUggOuNj9Rv+3Ad4CuIyLB+bKbsBI5Wq8VGOU12FSxu8hStfFuAFGBkb5kFBUdUvvF/B2GFRSjOeDT/JazOy9ucWcVwMiXEyntGu9t+sCYXE8X+/STo0CroAJFjcReM40P7m7lDswxS+8maZ3sIZz9Wc7cEVpJ6pqRqMFcSrdA3W7SPRYydzEAbcOcD+A1np4kI6snJCzKwHRbiBMna+ilqnUYcasJQPXGZcBCj5K3fEmslCscjmewUNC8rRcxReNnXlvUps+9d03k6vB3YO4GKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgcGe0I+lfb0M9OjfYgcbcsTooWwtpH6IzVi+HDZOrA=;
 b=Vpd3zWY9eTXLNCpx6vmSSKFl7GjXulimioz4pVq0F9+uKrUxzfeEuhgAZcRxvqzBnuRXMz8wC/nnvUMJW3HlqmkBi5fsm+T5dKPNjQrk9OvC8TbUTym1TheclVRiDNM3EvLP+rJpDH/uuLGjE1vsMSjEkvgg/Y/EccQOop3d3LU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 02:14:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 02:14:27 +0000
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch
 <kbusch@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>, Jens Axboe
 <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-usb@vger.kernel.org, Harald Dunkel
 <harri@afaics.de>
Subject: Re: RIP on discard, JMicron USB adaptor
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jdlv3cv.fsf@ca-mkp.ca.oracle.com>
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
	<62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
	<Zd9Xbz3L6JEvBHHT@kbusch-mbp> <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
	<7a10ff3b-0c4c-4aa3-8218-02d5f27ab062@afaics.de>
	<029ff780-902e-42da-a5ed-6c306c6cb2e4@aixigo.com>
Date: Mon, 04 Mar 2024 21:14:24 -0500
In-Reply-To: <029ff780-902e-42da-a5ed-6c306c6cb2e4@aixigo.com> (Harald
	Dunkel's message of "Mon, 4 Mar 2024 08:46:56 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ff6b93-780e-436c-f55d-08dc3cb9fbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	71o8+8E5F7pJADULaHtlED3DxL2DxMHmxPfDObRWOLl42yWu5ANY9zgk+dTGfu5KOVZ5ljT24/kax6hTt9SH7US+CEVMshI5BsPDCAVd4iaYYzbduUNkGZgy5TUuHYfgrOOX0j1Jdn7f7FE7eWxcZHPpwrWYqigiafl1oh+GvYeuVfdgKH8CKHYGcMzRsKUL5JeP2zt/LFnYUwEJYGmzEn6fnea76lL/pz6khzYNjVcgHWBhOyybL9h5tULeQZam/wMkJ+H3cSEbrvpeBc5IPDEA3zfAiCvfcEtrteIlpJEqANHUa2aKoa/6uQ0UJdKKW61jv4BnVUZ1FtX66G5Dl2ChCTQBPciQvu1pol/5Onp55D11X+4BwIcHULZuRA/KC3IvnhjvLntdicIJLzLXsSA3uD8ptt2qazkGOAsUSKtdjnXnXOeIJIeG1nT3TTT2586ssjmh0I3OOrZLEV7LvYhx7i/hWvGjZKOYSV7061APOVNbTmQ4pt7yvtr1JFtq1qOaxL9STBj8uWRurc6zP2kZ5LdxqKnF7TTy/3zah/hWNHWGi8LsgnIzMs+EyGNYcKiWwFRp0JfVMuL51GmcZGbtKLU8+9vmv6kokviGz5donN/a9qVhr/AC+u8CXJN0Q7UhKqqVn0JPm0vJijxEO3soYaZWAlI5MW5xQPrjPAc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?55oybX24McRn6XmSLaFx2Yd7Kw53hRp2GB0uMl9Dy66BP/kFDtIuB8lA5ayJ?=
 =?us-ascii?Q?gjr6LLRY/ifzm/ACXKK1pFVxJayzQwlK9cP7VFQvgO1HZso0aZS5aCCdXbXj?=
 =?us-ascii?Q?uvdxCWaIutpJQMFcuMjS2/NIJZrnIk2wmDk8SkREwBGwpq8UQuCMl5NliwjM?=
 =?us-ascii?Q?kdNKCwHVOjePP3uE+WhKW6u424wkoDOb4IharoX95/W3m8pQMfpS9QFWXYC4?=
 =?us-ascii?Q?p8HmML4DsGbUKkIIl6OE2GlwqkY7evgyRlttN6etJU6yGYz6l68Y3kio0fkC?=
 =?us-ascii?Q?v5T2pNsilJTY/uAZCV5JTHo5jo1VtciVVlLZqWWccai/G2kE+Yo/io0kwoix?=
 =?us-ascii?Q?YOrJOjzClaarYYaPmMcrQfAzlL2itAUEXnsps8U43KUSM3/78M55rUKncvJZ?=
 =?us-ascii?Q?XT3a4dyj4y1uqbiOz4U1VsHK1ZeN5fX4/f9VwBkRriRE5b+0bg9HX6a2tL99?=
 =?us-ascii?Q?r7J1i8+Z6DvsYzNPgBx6FHUZbCu7JROU/OdNgAu3tLPODCBshGXfysMNRxmN?=
 =?us-ascii?Q?OOa5ORHAm8X1XATqMsoeXuykZzxNr/D7qhk8TZEj/BUWoxTKTbLrkmpPvwmZ?=
 =?us-ascii?Q?W42FoAop/c+agJtC7vQvXSHDvleo8fOV74/Lh9tyt5aa5jQcBFqj7z51/u3C?=
 =?us-ascii?Q?+30F5fN04libRwpZu/bTh/t5L45tXs89/nZ21E8C6EF3d/W2FTBXDdu7Olmf?=
 =?us-ascii?Q?Pf5RH/xdPdklbhq9rACvOrFfNNfpIZX52n1dAJseYb2c/N62ILL2UPUAlf+r?=
 =?us-ascii?Q?VEbQ20WmFlMKE1jjor9Q7A3k3+28PcrENPsgCYqA0loUQqBrIOW1We0rxMqw?=
 =?us-ascii?Q?pab90DvdDh2xn/nJiveoph0vDP+O9m3bD7DGREbcdzTPodzpbUXaYih8a22c?=
 =?us-ascii?Q?GUTkyVBMTfbjF7agAQoG8jOwQueyUcMeWVP3Iph6PnyDvH8EANxlZK8i8UMH?=
 =?us-ascii?Q?QnNj6eIu5VxWu1wLzVOgYdDWLBSCjUk1Ym38TJwN8b2jRQ94texZB8l+yl99?=
 =?us-ascii?Q?oAu2hGhChpFNv8ktu7YGuBxFTjFZuU15+LjmMqFnW348CpTlu8DzYwZOCZI3?=
 =?us-ascii?Q?e0K6zxozcB+qQvudliVqswcGz0KxHyoMvI7mxWAS8VR9Rbs5ENz2GsMPK/Hb?=
 =?us-ascii?Q?aumwS7xbCmUVRO5Bnm8XXbaJMybqXM5cY/LLRDpXCQub9e7lq2LW+4qJkOUP?=
 =?us-ascii?Q?CtO7sV/z9HIx65hxmg4jbkOHAYAZg88qnyquYis/Mz4E79nccwm4SbpcZMdX?=
 =?us-ascii?Q?HSuSwD6qoX9xhuV0Mm5auI68143uymAPjvBTDrJPe2fhs7IXDuOjcS1lO1DR?=
 =?us-ascii?Q?IkZ/qMqlK/4DQkqDCZ1StHArJq1jYOD28OfAe/NFU/4Y3i3PFLTWtKAcc6Xe?=
 =?us-ascii?Q?Kf08y/m79EvClmog9GoFfGZBg181igKvxyfP75nbrX4B8Y++y84uZEnoH7Wy?=
 =?us-ascii?Q?X2qkRE5y8d7LFF90kuBOI25nSPEHd5I9CWfRQRjjtMlLdR7vY41huMlgsiSp?=
 =?us-ascii?Q?nxsao2egXNIqr6lFTgHBqNu8cvECaa63//kg9PU7SCRAC5lJNspncR2w2mSM?=
 =?us-ascii?Q?1MVSNxWQXsm9Bi6fTcixI321aj9al/Ha3KQa6+EB3e0XuLRIi8wTHI23INVP?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ogDFeHH2Y8Y0IHiadLRYNdu5cxHJvk+W4nV+F6p/qMI07NRcR3pDXO/83eFsXxImt68S7nr/WI4Cdvso03CxPKnzonMg6LVgBd0rPSCJ7cVZSIN03TdSnIh+WqTDlg56IrZt70daeqZCJYsiSl98rgMfjG9Sqlz1pYrwgE2LBOaAuFq7nraTgAiMwDZCK/FnVw5cX5y2r4UKtIIFPJNjKCH7YSzbYV0cuJ5j8pHgVTuGGaWvVlu3CS8zp9ycA1rjLXCyVrrkITNKjcQlMjKIEoUmxjtKeuY/cYrQZAciu8kjOvsjQYJonYTmQmu/ZdhOc+qQmqBrmYv5siLd0oN2fbCyvpIRcrkwCpPxiko5pK055gUscNfcgg42iOhZ8FIQqfp6PP/HLVhxUzA4T24B/GZ/e4+IlGb9qsyhN2ct/40z16TlVsku6iH1szwnFqJGoSChwYlC4w3GYx8xgTd7eSrrHpjYXuys6HEdLQvg6SRYq8IHak1kne6f/dh3d42BR154es5yK78sZf+9KbzIeyx1wNgUnyct0w31oH8AnCUjqreDFdoJ8WzMKercnkqM+2GJt7lAeFh5JJzw1ouyNDNmf0ECgXae19LJqGV8sfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ff6b93-780e-436c-f55d-08dc3cb9fbb8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 02:14:27.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c4ylLAlf9/5hc9VSlgay+8VRaHgG3VHMXk0ZBZMLMB8zeogLfUuTJqalMuG2aDsqU8rJp4UrMkh+5g/bCKpJlCB9vIKdXrairDHaNAd8f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_20,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=828 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050015
X-Proofpoint-GUID: BNhEnmbaAQzZ_2ubW9AH0mz15THndzEs
X-Proofpoint-ORIG-GUID: BNhEnmbaAQzZ_2ubW9AH0mz15THndzEs


Harald,

> having some kind of feedback would be nice. Is this a known problem?
> User error?
>
> Of course I would be glad to help to track down this problem.

Well, the device reports that block provisioning is disabled (lbpme=0)
which explains why discard is not enabled by default.

Oddly enough your device does not report an UNMAP granularity. I'm
trying to figure out how your discard granularity ends up being 0 given
that your device reports a physical block size of 4096.

-- 
Martin K. Petersen	Oracle Linux Engineering
