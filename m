Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0302E175F
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886136; cv=fail; b=G67ax9gqX2pZARYykj/DYBTvzi1QBZnpAno9OxhHNMJOpJg0wVwQKRlY4D6ryUCRrOelj+HUQ7UkvUAscE5tNoRJnj49BJt2PASbBx8/V7I4K3B/jinBIsXPmAPQrrA29iJ13WmiADHaJTVrCkVR6BD1dS+qf09chDHoe6TJMfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886136; c=relaxed/simple;
	bh=EMm9NFYHE90JCdjvPgkkgsfveukCfgadKEye7srurVw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=l1S2FfjqbT9j926ZDsH8x68YqW+f+aDKursrcHQYGYYS0pvvwPXHUlJcxZiv6yKxIPaVmuBIxnVoSlJGQQ/N/j9cA/qQ9rL2MeitQMfnIK+ZrIgpI3fCa9WK4kE6fd0jGEFENkmHWAMAHAmOskXsjszzohMUDvk2IdSo5rRSEHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xn9naMXm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lb/FZoux; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xn9naMXm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lb/FZoux"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5837g38p016170;
	Wed, 3 Sep 2025 07:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=r2XrzWZKHkh5ZXwL1e
	vYbsGEWw7QD8+37G1RI9x0c1s=; b=Xn9naMXm2BmCEik5uB9exkDMWDYNVbk/WR
	TS5l3P61PZYXN78y2MsSLt8Sd9wnWy3BHDw+9EkE3IeePrIyZ07xO2zTkxtyx2E7
	dPY9ve07WcnDCy6K1DO8fKkp33Ng7zW5PrtpGNMVPnYbZP9hMdWM5Wp79Mg2ulVA
	1jKQkERXF4CEOdRSdO0fDvhAlLmzIKVs/E1c3v4DDBFRM5q5Y4QKwLQaz3oR2k5m
	T9TRbyCbgsLVwPgOl2pJJ6D8e1mvyIIfP0vj1H+V2nZFO4Jn8YsHj+RrDhx74enS
	1nTHNvmTGmQ9EQDAdRgGwDMAusTI9yn43c1oVKpkIi2avsByds4Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmndqet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 07:55:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5837cfkG040724;
	Wed, 3 Sep 2025 07:55:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9t1qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 07:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjDaSt5q6dy/zxHy1r14O6QjOQwPmrHLAGI7HYKL82wRVQBjmFRSLTJd3JfY/dSAxKxEmTlb5ZgpvREve/oErdDjSf9pjVRVQPbXYR1yR8X+ZEm/eo7JxueViRFNgT4FaDUFyYJirNROyigyoSSZo97gT0fDQQbruh+6poRvUMD60cNpoZkYfEXdn36PbNqdJ7M+IthNigXrUN0BTulsea6fMOHKdARYvl7Irr9nvoNIMhoqxMBxIXtJVeAXN8bQb8WYmR6I9pQ9m7NQtd4o0yQsccyi5dbEEdRgfsrlMQvM/OAA5DK3E877pWYnkuAq6DulwwqRJ0s+mcrbNV/Dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2XrzWZKHkh5ZXwL1evYbsGEWw7QD8+37G1RI9x0c1s=;
 b=rq5wfkMdfKfMbPn+whznd05XxQL6ij0cFbLb6MzjVuiqtZNMdns4ZCvb8FR/jnLUnzdQMZsDFTctmMNQVHuPNvs0fRIcwYG6AtS+BRDs00yLwygK4u7VWYlSOB9UATpc3QqXTOU2rQqCOdxbLxyLP5g4vU15AtRubmHMz8Rw2ojTHDdUADS+KAECqQi7BcwzfgMty7S8UzaIkqTQ9Q4H9brjk7h5HQeU/zE420yl3eMFpcPhcRWChEpQLebIfHReNhryli44hVXYmMJRe7qn4iTEDQQt6omC5sUouw04XVIeTHncew5oolDW7G6quNdQSqTCqNQfvPl5t+UxSJAqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2XrzWZKHkh5ZXwL1evYbsGEWw7QD8+37G1RI9x0c1s=;
 b=Lb/FZouxgLqgYnSMfjD/rCCjUlR3el9+j8NC6urU9qY8B77WacBX8HmM9MtTEYLvIuHN+pJ/IT6HwZwQc0Yl5q3QWlkCX+R8WYxJyrEBS/J/tVJIV9gd3E51pEihKqnmljsWMkq9ZaZhwnYVLXdzEWBTXtgfatnuUm5lzk4a77o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:55:08 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 07:55:08 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/2] blk-mq-dma: p2p cleanups and integrity fixup
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250902200121.3665600-1-kbusch@meta.com> (Keith Busch's message
	of "Tue, 2 Sep 2025 13:01:19 -0700")
Organization: Oracle Corporation
Message-ID: <yq1y0qw9diz.fsf@ca-mkp.ca.oracle.com>
References: <20250902200121.3665600-1-kbusch@meta.com>
Date: Wed, 03 Sep 2025 03:55:06 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: afd5fa82-80ac-4f67-db0f-08ddeabf335f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zHyzZVaIyRjgVZz8VmQqm9f+umzhZXSDUQCWSBC6o+Sdp7eFaTFSw2Zr4FE?=
 =?us-ascii?Q?pQPh+uvabmFhPcv6TBECmukktNLmyF+3gVSTbAa26PZbrCaS3Cdp7BEPBnJ7?=
 =?us-ascii?Q?9fV8GZTnzsTCoOR6wLY3Ko6JlNSAF9rLofuz1HOefL2eFJzk3gWV4JB2TqgN?=
 =?us-ascii?Q?rT7QbbTIjfq9Ez/FXFJ/qolGKOiaZsCFE3pLvRmnPCjbHrgL9/ho0d4OxpMD?=
 =?us-ascii?Q?k55nErk8ycrIAwfXoizX7MOycc5954e+CXQqUCR/D1+mPwKkbt+rzFw5ZIHe?=
 =?us-ascii?Q?QdEqitAd2nkIjNveRmHMmX7qCqk5d6etzqVin+xyRJBTAKLWV8JI2cXVIL2y?=
 =?us-ascii?Q?u3X79gXvzP2oOQxpUesQMSpGFxk7qCQ7bYG2x4vpp1v2cLY2Pbh9m0Dhq+ii?=
 =?us-ascii?Q?MAhvMl+hKqSk9oom39whP/Jw4WpteqvTTPni88OqTam48C6O6cSQY3SCXeey?=
 =?us-ascii?Q?2zRgrXSv/iV6H2bif4zmE9Ep2PVmq7NSca39IcZ4bDL/4urx6nz/hJVw3Lv4?=
 =?us-ascii?Q?zwVUvSCEF4Dc7OCBQso4hl/z4Ap+oVhKJp7Z0OUhHXRSfEJbi1L+xYqv+hdc?=
 =?us-ascii?Q?RvJiNDbOakKcac+E6e2Q18SaiJIyPTEhJNyyB5zqZG1R4TrPQDjB8wMWB75+?=
 =?us-ascii?Q?wmc5M4QC/ZvuMgdkNjZ/Q08uLVxcblwssdzzRbBipk6cG2GzmyVXatw6LPSt?=
 =?us-ascii?Q?6010zyGVrRTspvU2opkgTBJWEECAo/gsPsM6mn+uKJtonCmc8o0yLGKtm6li?=
 =?us-ascii?Q?FKjUJ8Sdwxsf2AOZHk0vujgkUfBC0WoO5iWmrn1Bdi5Wl0zLUVetGAD6rsQg?=
 =?us-ascii?Q?q+bPsPdjjeHJdyk3P4iHMt9Gbwd43vHU7xlaQ1e5rXWcm+o6nhL25UKUWGZf?=
 =?us-ascii?Q?kw4Qa2sugh02umpvkDbyETQha40C+kqZB7GtrMtNBC74IivFJ/ccdaQTrhn+?=
 =?us-ascii?Q?nruybYh5TlEJv1vkviZ4333YI7N4+RmGluafzGo8kSkT52YcsVunhgf0hldF?=
 =?us-ascii?Q?wx2sJfZbScF4rn7kxZXiz1hIewSscBb5JNj+QToZo3tJsnquxV81cvDSoOf0?=
 =?us-ascii?Q?5gTQLeqh7tLawJVHRrv1W9fpaCvPtxjafZRtruySTqXJDnOFxq64TJqlB9LQ?=
 =?us-ascii?Q?nuNQ5WMkGt5KFINnNpVpkMbzOyBiCMrZGz8RkFOgzWT97au32Thf6SIidbPu?=
 =?us-ascii?Q?Dh+YX8mTF042KV0OUiTVeb9QOKGuHV8GvtgA9LCtxYooDASjslU2J8l6Kf5x?=
 =?us-ascii?Q?pNw/EOXFfDBfzZDoJ2cJ3TuacytieC85nP+TvBr193Aws44s3CLrQTA68YX8?=
 =?us-ascii?Q?FKnxT/uVJWalN263ZJVUPATFmQXBWkuZV53Yz0jrH7NlJZ4B4l+DDAvn8VtR?=
 =?us-ascii?Q?E6LZPqhcXn4ax5uMlmFO5h0bRAbEEjwCJVcrQtMrO2p/GrPmjzafDG//QVX2?=
 =?us-ascii?Q?OSq/X+ywr+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAq+MC5C5QdBUJ0wJh1bhlPKVtzUqdTZSbZ5nj2SbmpnMH7Pe4uZmeyG8iIz?=
 =?us-ascii?Q?336Yy++iu87cGIrHQ+heXIWSaM33u3na1iZAosRz2TDurpX71x2AMii4PYz/?=
 =?us-ascii?Q?rJJ5NeHCvTDmGuecW60P6aceIgzAn09qhI75na45cblGp2ofNK5K+7+ngAdy?=
 =?us-ascii?Q?n9Lux6v46XMKpeCBz4A5L97R8+Kw/Kg5VrdQWFGAuZPILMzz1/cOK0UPMdrs?=
 =?us-ascii?Q?L9mCHaAYaDM5dmJsYM1kehweLt3LvDxWR5AihEhKAUd1vH2y0ApzKEg2fRJN?=
 =?us-ascii?Q?ynng5H1HFLQRlrpt74Nd8S344bGJRfpxa50MNSIwJ17EEDyg0loGXMtzC7+J?=
 =?us-ascii?Q?fLsvkOhsU4LOOJd8qCV+XyhTaWivaOq5WYp8fsXi/dLtmc5ERg05iT/Z9MPD?=
 =?us-ascii?Q?STe8EAVLgKcBzm01n9r2VgYWI9HQExAq3nxwO5B9PC20qE3ecU/IDBp5Pl9J?=
 =?us-ascii?Q?FlRzFnI8bduSGTMYKFeN+6K8o5BARVVGrVZM4eI79nvbDMglZ2reoJalsde0?=
 =?us-ascii?Q?6Rg+hDO6WPlztCh3pIQHZPuuH64j4jOAjkSIMx+6C0fSzyzVVWYfvrxI8frv?=
 =?us-ascii?Q?4I0UqUgxlkxGr0hSdx0aTA/z/qSADfmbODw+OEyGJno4TJF21N9oItPjVI6x?=
 =?us-ascii?Q?kO+IDlp9aNJQ2G0QuGU9QXi6U7cugHwg8xtQx7TFYK56f7iWxZPtgbToYYZG?=
 =?us-ascii?Q?RYpHRcvs6c99BYsHY0pQ9KhG1w/+eXS+9WAnTBRIEDPr1kzrOzKef9LA9lop?=
 =?us-ascii?Q?m06IPl5DFaVg7ucH4A03rnzURuGeNAP2Gv0wTdjqG6aR/00LioOD47f5TVZX?=
 =?us-ascii?Q?70s0/aFTQh4YoHjSd5KJ8l4ZgqV404iJidW7ysN02Ky2eaAb7XFVEc+8tqwy?=
 =?us-ascii?Q?Je/m7gTTz2PXDz3uw1X/B08UoUMK8w7x70yGXTZTVE6Mg4Nm6AI85TudJmkQ?=
 =?us-ascii?Q?q124jpJi89QbhvyafPxsBwi8Rvl3sYKIW0T1+s5XeDFlkwOxfRBatyo6bxLG?=
 =?us-ascii?Q?AgNCxGJEfaqvYpOfxyoX0au2CHmA4WxYDmjyMhh+OWz/A+JdY1l8o9RKcQLZ?=
 =?us-ascii?Q?pbBX2Qd5RGEn1nOJsI+f4b30ogWkLfq7vgFIBXYPVfMYmrAZOepZH4zgmBDa?=
 =?us-ascii?Q?SIfe+w9qp4iftbCMrWUwyOqnTcwOnVTpIi4Xp68UJ6cRjSGIuYxsv5qhFpIP?=
 =?us-ascii?Q?gqxudMdK1fR6p3eJzIBh65Hlv2Ej8Njt6MQqaQNnR59kdiYbStDyfA5IZ6GV?=
 =?us-ascii?Q?Mp1Bei69914ohjDMlfeqCgYZwh93GlfcNY1WRPtAtlrZ1elM4p78qEpukmDV?=
 =?us-ascii?Q?oJisiZ+nRvgSPFT3mqWt2BOLVSr1OenbcizoLAdLAdWHjx6g6wuw6chvne0G?=
 =?us-ascii?Q?+1JferFvwXuQUZRtfd02z37U89gwq516hp473Sstj6KZLDXdRO8kk5JJNOHA?=
 =?us-ascii?Q?H1QodGoSV1Om5V154IXJJzKqcY8vz35lpOH3KDeY3MyoKZ70ZASHykxVG6to?=
 =?us-ascii?Q?C2Td1OF5s+oyDUDrqwEG/WNfpP2bARusNWTRSz7Tf2x69QEd0/eHoumRvRU6?=
 =?us-ascii?Q?eUl225hjy8bwxYS/sIHM5TqBmVKwj46sf6OnLy6/elMACXLFxXHu6cUeqnnp?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Pvrb/z+t92vjGOXnBhGzcUT/DLaxfrzZl7BcT3x2kBCyMGYtea0+ciGn/+Jvu39U0sr01fL7IQ88Rv/btiqWg0YpvjnZmprUu6xmRDT3Cjx9zWLq6Hip0SOH+NpNV6+CQmv8ULuLYmziJu9zcoRMkGBMGlDRVJiKpQMX4r/6zgSmgn5IxqQH2dTftF+NWQvTtEs3Taoqt8b61Rfh/2z+pTqwjzQT5ZccvbkR2/PjOTI1FMpzFSC5bw1UABfYqhmDxmfcI0IcSqnBF94m9mw+2YNSZZvbacaKhMQDCSH2SFKkzVb/GAZn6li/kLGwEjXMEC6LietB349XVJ7cX/TV0PeKMx7mGvIuK1rUEDkrng5RD4aVTbUKwxs6s6d+Px7k249nfYh0nRyEpIIs2ThVzzEd/BwnX79aNZlDG6HaU28CLYoRpOwAFU2ZJnPkgJGTaBNcCqLsPvfaTiJhcAKVZWq0taX//0Z5CoTNYynfKW1pc7QSYt5W17sf/ObYGxf26jDZGd7DThDLySQMWdaIhbP/1OyfPvQ2td4CbmkRi5nq0/BXp3n1FaTSP0MCwI+1lJVYB5jnabaOgbhj8sQR3yxTEPYZ/WKtHEyaRf1uCg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd5fa82-80ac-4f67-db0f-08ddeabf335f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:55:07.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiP6uj0ktW2Z8BRxIrW47RjFZf0X7fZp7K81igIHPbj0vJWjfq8+sGVEKPPj0y1qtypt6s/ZVveQ8xVp85NILrtSGbJse4DAIrR52kTOSro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030078
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b7f45f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MldQ-SPdW9_udX8bFasA:9 a=MTAcVbZMd_8A:10
X-Proofpoint-GUID: BTGz6lUrUCUdsnxKp2hMnLcF33clU3Qe
X-Proofpoint-ORIG-GUID: BTGz6lUrUCUdsnxKp2hMnLcF33clU3Qe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX2MLN+9AQavwK
 2F723mRcmZ6POwleACepAe9J/V5zJpGsD1DW1/WKEYSPkes7VgNphV27oE3cQIQRWi97Z7apCJ2
 MWvkQly/mXBGQZUbuXXC0jWSos2T0c6JMq6c74xKZvvlBV7qHq8fgOUyozFwcuEYS2IaWteq3pZ
 by+PbS97nsMlY1/zUsWtJuc4nIOlDRjxT2Ye+qkGbv25Tpb4XBf4kvJnOU/FcxsALd/67DcnL42
 Zc3xaDztG31FSmXgEvKvOkRkW8gUoH4wWcAGiEeKiacNCLiFhxZPnRAcVeZOJa08iqthBcoD7q0
 oCGUFCuLzkebsunhzxVsedwe64XMAeCjL5FMlHFVIbbICNe2yU4nwisaYLhWA4bNp49r4H3MwHR
 9LWH1xhZ


Keith,

> This series moves the p2p dma tracking from the caller to the block
> layer, and makes it possible to actually use p2p for metadata
> payloads.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
