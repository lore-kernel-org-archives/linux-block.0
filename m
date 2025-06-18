Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A3A2DE1FC
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241986; cv=fail; b=u69EicdPPJ44ReI/VOj8KNFc1SUF/jd+wJlTFan3EKs4mv95efUG8BPbEfmXVIgCE9Q68ebke6eXGR5fxEbI3JmAM4dH3iIu8fZXTzDaKWOyKUTTASzgIiimO+UEGvpMuqFi4dSToedm2ZVPHSTrVH/Tgmv3dEqKxdAY+vpHKA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241986; c=relaxed/simple;
	bh=F+4ebT/ZTXXI6Dzawn5p2Sj1EBl34EsBXfoi2ctxXuI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EFWJ2O/wAV6s3l5f6w/OuiqDjg6QNo0b+/xG4qhJbFgmm2OPFlX7tMk6nSthzEcoozVlNP/NbnjvirtnrAdpjID+EmaeiImg2bC3YlSfSfACWEQpI6VSej/ecALOpJtqHrG8ioUjzdmmamRYEFznBh/whTBt6huVUDKZyoF6MEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UMGwqpHH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p1hGk7gX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMGwqpHH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p1hGk7gX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8fu4W024470;
	Wed, 18 Jun 2025 10:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8foJjbir9xo0s8pOTZ
	wu93cTMqYIAw2e1FAf5Z5pxsA=; b=UMGwqpHHI6xz5zA1Kj2hECpaCIcVenkyOS
	iZTLxfZqli9F2mObFmm5b2yQKqvEFlhBQyNWfRy4R8fFrwmGyB/wCcHvR1NnOYYf
	07TqeUSGzoA2v/KlxN3mMZXxz2mjEXXTSn5HzeG8PFJY8c+X07kqY4lyoXq+oeDj
	m8Os3+1EbcD7SCXVjKzFvBSfLgnhyrZWP1LEZKTCWdWFyUtm6T0+Mdms6kJSpbmt
	pR1cCjqqjBe672n+njYbmmwY+fKKZ/mV12OVRvEWY3rEwLk883yQnrEqaY7EqFLa
	nkl/zOud0knqc4GQlqEuBwYQB5pkW6Z6HRYYqHUF2WkP9CTXJzyA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r6gxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 10:19:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I9UOcs030953;
	Wed, 18 Jun 2025 10:19:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yha7euw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 10:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3vHN7xRGJiSq1vti3umzBM7iiiMbr3S8f9Xpd1MEdUfhpdL4yq6Cqums6HoSusnXrBxL5OkUuzLIrzzY0aPwAJxvNzgsLE+zPnPOS90Pc+GFXLiAhYmuzcvDnOiBL3QG+mN5hJOVWW2PornaVVeGh2Mri0aX8qJXSi80HsJemzcn/+2xFNfbWAHfVkok38lHfHjUQx3gS42jMrmF84viQK1xRQNcZQL8ddcZSkrwx3zf2MCD64OsziF78Ur6KcDY3+kruNF4pYiiLotyJV7MxM0t1HYjhBhvovUm6hrvS8pjRRsO8C1eh+1PJwt+poRGC/8vopqFHey33+87p3khA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8foJjbir9xo0s8pOTZwu93cTMqYIAw2e1FAf5Z5pxsA=;
 b=DSaWERCn1i8WQaWPWdtPzKnB88CXloi2LID+qnfwSOYWnmOEqwiHgBLKak721nrOK0J0tUbSUKfVOjEAJRy95pQ+hn55JSAlmMasEA17YCMTvMqHpx9vFXhp1qoZiLhB9ZGBndsIIZSeMZZjlVNohEqSHBTvzFPlLYWzxd+zxPkdbVt/dtX/Ngc8w9fJtE4ODNNftAAPPR1rIXivT8vzbX439QjgN+ABLfP1bY8RSeZPYSllcK7J5QRlfZuJN7pzt4tZFTyq2Zwx+QITnJ2Z23hWSQmdXH/DbdnM6PYHP4gXJ2AbplQteZAVBjSOoZPASr3WMmi90MaImO2TfGTpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8foJjbir9xo0s8pOTZwu93cTMqYIAw2e1FAf5Z5pxsA=;
 b=p1hGk7gXE9oGWDiezgzl39sV5mE90N622Pj7lc7nBmW8DK3aQACvtobMvnarARB7JqWJzkR8wNTh2QhSadFkOjf8o952YmcbPLMEmRC4ub+ziFuKYHVHLmoKLKwA7bzArFCezeBNXzNgdTRC1i5dqy3H8WhSO1ZB0zzYO+Jn8+k=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH2PR10MB4246.namprd10.prod.outlook.com (2603:10b6:610:a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 10:19:25 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 10:19:25 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Wed, 18 Jun 2025 15:00:45 +0900")
Organization: Oracle Corporation
Message-ID: <yq1a565wdwq.fsf@ca-mkp.ca.oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
Date: Wed, 18 Jun 2025 06:19:23 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0873.namprd03.prod.outlook.com
 (2603:10b6:408:13c::8) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH2PR10MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d589792-350e-46a2-bc73-08ddae5199c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQzENw2oY/Q+/bVBy3VMENIRqqRn+5XQSEOHri3XU+Oi6O4e4Yuif48yghvh?=
 =?us-ascii?Q?3x6YZCpAamQg4nvJbUciEvY1dxhQoDYbQVSQBGIhrSjTw4KVfyhbazkW5kcD?=
 =?us-ascii?Q?t3neOimXEV6Xie9mQD1q//NroBzs4hp54ni9VqMjLtNjvDm8dVA90h8gw3uJ?=
 =?us-ascii?Q?ufl3Y1wCbhkOPbpI+xp+AAlOl9urJVj8rvCT8yb5f9y3s4O1yq1thd2+Frdk?=
 =?us-ascii?Q?cjKaixCrGaqhM2svv0Ltjlslrj0xZgOMY8fnAJvzh9rhiEXgmisa4WJUM5JX?=
 =?us-ascii?Q?hUiooqV9NHUtFto7KbJ2QVGINR02HYQp1xPezDjS+yb/YT3Is3q/rhlowjIo?=
 =?us-ascii?Q?/IljXi5rop1DpQUJD8QUPXWRWmrHAZLeYgEjGIN+bjIQ3Y2Jg9NC0QfkZrwM?=
 =?us-ascii?Q?BQKFPWXgh4WGg9yLUsekblR5HvM1LocWVriTCB5MyO9QgrN/9YWeGeI51xml?=
 =?us-ascii?Q?9FL7/4GRadsPshWPpRSsNMLtml668eiZa1QEw2yXR+T2RtJm0Wu5Ltcb/+O1?=
 =?us-ascii?Q?616oIp2M+hVIPYcyMPn3M/ZjAYTsY9FgePn3yt7HJYKKXVUwhTqDEXTi128d?=
 =?us-ascii?Q?Z+tQ4PVOHvZ/Sufkc0/RjUQgZcbT3gwMXXdUOQ6CDzBzQWl/ghNAuswgxH6y?=
 =?us-ascii?Q?QUROIH6Xkc6cUj79Qw4TeUiahSqA3MRRXgW42Bnkt8KP8CuUGHg1FbL6lHYv?=
 =?us-ascii?Q?6hhc/wE85gVS2coGPvdRGv4Zxl5lLGc6sI2sfLyq8LbGWw+k4NAU+gwraNLq?=
 =?us-ascii?Q?P8gfPTgoWoQoDFaUK1XV3gMKIoPJhDIFC0GcFvRWBHo+R3W4BBLHopvxHvXw?=
 =?us-ascii?Q?zWtanDPXIYF54oWztDbP1v0vZBCZc24sQSXWQ76h9LpQoiKq4j7luDkDhNnN?=
 =?us-ascii?Q?HiqN6poPC0ildjwg7ltGEq/XaOk63zDlqGgeRghrKpUqxkKFqPl3oARAvmXY?=
 =?us-ascii?Q?pb4yyElXoy2IRS1NpJUiaKzONKrRDqaUSNtiregA902BsE3KeVeQbNHJvEtq?=
 =?us-ascii?Q?NVJ3bHcSqsMUKYmD5sLBAas32V+Nl+IctYLasmSXpnRnNGm1NtaE/zdVZv4D?=
 =?us-ascii?Q?lyz0KEL46o/AHv/LOOoUvdSihm7dD6RJO1Ctk919KpcU9yjppnBfSIBVuJwK?=
 =?us-ascii?Q?unIpgOSL//8dso+b6OLdmJ54JLD4zOaL/5yc4f6zs3scgkNI/v8w1+6BVCuv?=
 =?us-ascii?Q?0o5nlGuORQBl22pMrWlFvQQieyct+YAAyKVhH9Iu5j52iw1aJoCElLGrIP+I?=
 =?us-ascii?Q?xTFbyZ+nRDYVtsgIBWCgI47bUl6O3WmIoM2UEt6BVPqrTQxw8i+pT0WNJmwA?=
 =?us-ascii?Q?5BkPVBDILL84HzWyeSvrD+LILNSF7+CRvt+VNsJ640ukdopVs4hgUApfbjZ9?=
 =?us-ascii?Q?f2fj5NQAA5OEb6JfrCicWYapZlehwIFl4RDU0Ct2YI4l9FtFPUl1tgU5etof?=
 =?us-ascii?Q?gSs2ujyz8gc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1Vr5JX71GEuSwjDhxz54mKX2oG3rChkhxXJrkpYvLMj6qLR6bn0xYkuEjGo?=
 =?us-ascii?Q?o+fjuaoCTQpBnMMDK2iTTqGb21z89b7qpzB2gZlR4XyxjlLcMjSpJes34+KG?=
 =?us-ascii?Q?1vcMnR15IUITZXHU9j1wLh8KKyaFeg42Yntbi8FKte6cBKbS3ZyaWbmGJtxH?=
 =?us-ascii?Q?25LKmsgy0y/9Ab96NGau+TY8R4KTKVAwcQTvvINeUHkYgiNQd6c2QjESyPMd?=
 =?us-ascii?Q?kRka8uJDI92nhQ8DqUJ08qdmalTh50djhDNP8Lm9QL1IQYrpIVj7hi/dV6lV?=
 =?us-ascii?Q?NrBTLqlwX0EsdRRxYh7sqbO7cjaPV+/zkNb85gZaUqJ5Z9hMDwcH5Vmp6G9N?=
 =?us-ascii?Q?c9EW0QHc2iQC1bYmDyZ0S48jsUrrEw/NgriziJtNkrLJIsIWzZPk56exWrG2?=
 =?us-ascii?Q?7KSp6ApNzV+uB0bcKB0JuKuiM+QCCESCGw8UFTaHX3IGE9v+SMoYIwtKkxMT?=
 =?us-ascii?Q?MH+j0AO9mz4YJHOyaDOf0JO0ezeDQMit5+xTm9IaeUXmdQYJf1avudhu/Jpr?=
 =?us-ascii?Q?EQ94X9O+/QKmsRs8W6gh62YsJOmmQM5uRyK4UHV0oJb98uKDXGRtgllQ53vz?=
 =?us-ascii?Q?AhYRIn4LLakfahUqhMAHq/ppHMN35hypz8laVuQ9/AMZn2t7D/vUNC/W+y5q?=
 =?us-ascii?Q?eCfLRZU4BFJdP1+fimPNa+5XTdbmFS4rj3sMQ6gTZZ4oyS9LFyaHUeDqTKPk?=
 =?us-ascii?Q?jDDak4trjqNNtAee2bzwvjVnCzb91FutJtwrTzgNkel2UlBDVzcnZ48Vc9ij?=
 =?us-ascii?Q?46wtFTvN+pIQ/93iOkpZeYcq6uEFFuevkdgXm+qE9NlQ1tkpjNgG4kEarjYF?=
 =?us-ascii?Q?vEe38YuuUsIi+7IWphOtA3vFOnJmfhfxQThML1L1GuqB2PGP7MH3E4YzcN7g?=
 =?us-ascii?Q?nL5R58LJNhJWYTXuO5u64tH5nEneqtYtYMOrcjmKepQPbZJGVac5npdGeO1e?=
 =?us-ascii?Q?QiMR48JrH0bXwrT1f/i1VzTSnribFou5TJetFYpTewDPTtVAAeHxGp6Ml1PF?=
 =?us-ascii?Q?Q8YgF18SxzW71yYJyRBX1V0Z/HltICLmwm6jzjxIGn2IFoAg5TMq2LSaFKcW?=
 =?us-ascii?Q?J8zJg8agXw7vXQNTHr0GBx7G7KRus2fNBnNS0U20AwSGXNfBPiPlrwfkkZQY?=
 =?us-ascii?Q?Njv2xZZHnLGsdy7R3RnTQJM815Kh/dt539CsZBFvCZ5Ms0trdBBVPA0FpGrC?=
 =?us-ascii?Q?fY5sZCBq+t0zJ3SDh9bct/kC5Xsfg/BGQ41nnI9lNRIp82ilaWBZ/k8oRceJ?=
 =?us-ascii?Q?7vHhFLiEPWYwm7MnuD2gbHsnNld93Vjg1wn+ObmvXYqqrmEK7EtTFBMhWSlD?=
 =?us-ascii?Q?FQZIVFkK1/yBtIiDlxlGtUuaopo4EJ1gKODM/v+E1pSCOas3X0SiWgTZXXY8?=
 =?us-ascii?Q?DjrkP2WVXLPxk9vRBqlpcFbH57iP2aMI6N0bshgb25LvmCoOnraNZJUUVttN?=
 =?us-ascii?Q?fa4G9rSPXeK0VRQaDsHH13T6+ev800o/mxrZoPgt6Y9WdsYHEgbjBxAOiNZe?=
 =?us-ascii?Q?tyOiXld8M7juMdxK0ElXvYB8gXSwca9VsCxKD7Xlq7VaZAbGKOLNjLS4Q+Xf?=
 =?us-ascii?Q?a0gkTM1wMliKi9ac87I96sO6uTFihgt1iYv/PkWNIFOFbc7sdqBM6ylUxqHn?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iBDJ1DxumitXxNTKVKoE2hGZaTPBM1EvJ9Rp2PVNPvfSThtsnknIkB0xIhbk5kjNVxX9vSpPPlpAjnP1jYVikjHKLSBbFJqMr5OlnYT3v0rOZu0lOvaZXkW8GHzrKLs2QML/oppRR+v3Mn4ajcyyoTVla0Ept05YeHwjwcfoNTXvGANRa8e6Bgayb9BPJ2mS3tz4apMqM65VyRUycUSPvjOHTmWW4eFjqOAHB5aU7D2BY/7+4AhpzdqF1P/xPmDW9jk89j6AX+gf2Jle9bEAil+uNo2Qiid16lCKmM65amJa0bCbu8kwU5Q78ZDrBNBG/20M1w1piuXkqiA1sGT6AQNKDF0zkXct4NYD06zh4Ug3wQTGi4YQS8IxnslemSkFSwc7uDuT9KsYfSgb3M7g7/wKbOvh9zGOjRQDxHa8vKHrM/R5D1NDTCGfeIv+F7f6dhLyk5RBdYygD2UBtXakcjiGnuKxOmYZAZZcbS/JZQ2Nd7ghds0Crd8W8QWOdiYbmoh3zhFwy59tyFXdJb+oElQJPUEiRMo8dg7XpXZhVBLboDzMexHRVK+CiynWHj/g1sb+HoprIqzjL/taaXWprVoIKpKEU7qSxqGIuVNBIM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d589792-350e-46a2-bc73-08ddae5199c8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 10:19:25.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYBRlftmo/Us+vISoHDy+mPTWJlDzX5y54aAv28jSPxonROMYWeUXVCNfzqycWFnCZfbGRpLBVGhtB539wAZNjp9MGeSI1gLD3AMwr73J88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4OCBTYWx0ZWRfX058gwAgjSJYh 2Q+Rs9/T9NyQcc9pHiXqz1wwamiFYkw5V7Y3Y+jCa6zxX30P1RP5oqI0gPRjwO82oN0L4+ODZVC zjwnlG2T+z8j8to9IrTX0xaqQwPZZOZ4U51yuj/PyqGRvSooEveu71biZNrRsi2G3ws2CoTqsxt
 nnWKAYpYMdErDqftaN0UK+V5SoCpHL3sDAW+DVFCQHCCZxP8jalkwky0yFmwm2Ia/bs3rWshonY fPIZZuVmDNwKm50QuWGs88wQRSYIlKROfVBLIg0nf81cLKlJc58vayaCx7XaMWlRXm+kwSpiExU SQb0DVLTEsP6/RwvmB+Ey4Heqnc8HJ+s+wTMPxvaPeWObOGz3ypKITb+gYqlVFRqCxbHiz4EeBJ
 nLTny+b0FzqJZ+EsgvWxEN3MIBC/hFgDx45/rEgYm1ToU43q5S/5F1gvAdV15tZAXVLqxYg7
X-Proofpoint-GUID: giq0I0x3dufJercoG6COYA42ZdpiUE4f
X-Proofpoint-ORIG-GUID: giq0I0x3dufJercoG6COYA42ZdpiUE4f
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=685292b6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=RgUWrKFr3H6P38NroG0A:9 a=MTAcVbZMd_8A:10


Damien,

> And given that BLK_DEF_MAX_SECTORS_CAP is only used in the block layer
> and should not be used by drivers directly, move this macro definition
> to the block layer internal header file block/blk.h.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
