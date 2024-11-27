Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97A1442E8
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699432; cv=fail; b=jpA6F8zftAaugqoUKre/+9k9HxLGOnauET9UCbQ174jKIW7nlhLs5XQ7A4euEz0gtMwu/YaoIyr7lG9D3oIl5G3JQwTLa2V3GSDd44J8mupu5p/MYDk0vbnKvzBxNYRkyiC2nFzVaaLN3Jbw3UtixjIZSwcL6D/3EIMQYDlBbeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699432; c=relaxed/simple;
	bh=fv1QPkJ5o55cuU0a2hsozRB0IAY1/mg6n9M6Z9axMQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y6a2iL/6ZSmclTWMl8h7yqlGCdv4deLRJu2txfGyeMdUulGldOG67Dmah7apj7IDGzwRxps7dEDodQ+goBZsSQ0R2EVWH5iAsG1xWt4ib3bhoNde+Ba9EKGxleJ0z/RtoXxxd5XcREeX7bprytbUN0O7AfX2ArfPlfoBwlduw2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=inYPPvAK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Adm/D42X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="inYPPvAK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Adm/D42X"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR7MlfV015454;
	Wed, 27 Nov 2024 09:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=njTW2fIB6wKiI5X6
	pu3j/2/sInv4WoO2sCLu+G3Hz3k=; b=inYPPvAKlqBp8pJTldL/wFDrCCfeLU46
	uwXNhBna/285ayqLbzg1XKErycqmbleM6nEgKA55vCFD1sEuTqd4zjdnMvIf3tsX
	16Nce3hOx2caA+0Kn9WWsfNEKE1o1Zr79pQDEzod28I3MjpT/CndGCNmEw8stJef
	GeZYuppPoDwhbBAJtFXkaLHHHqnnIHH+BLZQhMRECcDwMGTcGXpD0H+FE34CZRP3
	7kaSAFTKv2RbEThxVOm3+ODuPqBa80uaq3ZRUbAcW09XitjSnMB+eyxvL5JLcJIZ
	WIl++0iOEtDTGMnhpQQAhHN3FRQVrP8VoISI1fOX7BnllzjUVKGoWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433869yhue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 09:23:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8BFUK003101;
	Wed, 27 Nov 2024 09:23:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335gag6pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 09:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYZBoA8EurAnPwxv+2QEBUSVwwVmri/BTduEAfvngU8uxExC5CiegGMzrn99y4ln099qQKGJWMhDehtqkJoztakBPnzKhuEir2d2xT/+bkZ9zxlcFFjojd4o1B2LAKAKHmjJuLb7Voz1v0amBwX4nVy2250t1SiTLyBnrlRhs7ecCrwhrqESNghs8RBL4iHZmQqoXTNtAYt7bIIoB2BMxog8pQKk/9hPfdMnhVCK3drRB1gbgT0yX3U88VeD+VW6votJm5YsrN6KJt2tSFIbWj/cEQEt7eBcU4B6a8nx0LAHF6VRFE8d+OybvJ+/fZtIn14dvSnJDLufekH9nc8czA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njTW2fIB6wKiI5X6pu3j/2/sInv4WoO2sCLu+G3Hz3k=;
 b=H+1AAARXLfLDAw+4EaE7gTYAiU0vix9XtoNZ7PMBOAScLNacKjdhePTFSdQtdIKi9lG7JIhMOZKkrEPeDTcw8ZosuSMj0dD/pBd2DQjK4+p6wdXpSD0EZuys4RbG/O8ajxuVdQEeBo7rp3f2QldlT7I49m5zCz72ZJYn/b9A+jRtOStC/cD+ZgUTAWwY4QTaz39zePaRv/PevEFuDDpG3VvC2h4J2jcye2Ic2O+1j4hpea+T67Gaaoh3GrRVZi0vGwep82lvEN7ZFTrMnvht+S3y3tq6cjJln0DiW2G7bMCdUWpwr8JzyYKIRairQxFVs8L+oJGz2m0jr911br1Uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njTW2fIB6wKiI5X6pu3j/2/sInv4WoO2sCLu+G3Hz3k=;
 b=Adm/D42X3ytu6KdjHIdUKTUgjxujfP1CsIGFW2T/HwQ4LHzsm4V5Yw+FQiX2O9PiO8qG4MMKMN8mUHh5A3nz7DkmCHex9iUVoheSNQafiz1gTCcP8h5ApCsERcGU0hpw/2Hsl/9lOO/UW7kAjpyEPB5am41rzatGB/9KC4E6vaY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA1PR10MB6194.namprd10.prod.outlook.com (2603:10b6:208:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 09:23:25 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 09:23:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hare@suse.de, hch@lst.de,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Don't allow an atomic write be truncated in blkdev_write_iter()
Date: Wed, 27 Nov 2024 09:23:18 +0000
Message-Id: <20241127092318.632790-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA1PR10MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 52786634-9030-486b-595e-08dd0ec5252d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fbTdaR+zyulAmj+jp9TiSbnxpP9+1/J2QtaPkpBUZp47b5H0gMJ71jEHL4Y?=
 =?us-ascii?Q?uF3HFbirZK+bB1eJjlrGWvCPIU00zYqTvj5Z9t7YhrNgYygUBSbpzku4/NN/?=
 =?us-ascii?Q?gNkH0YWgSXOsqWlrqGYjYPoj5uRgRXmPbVu0hfWiP4wFYxYfepEzDbnJqtKA?=
 =?us-ascii?Q?g+0hamSXcQxTNm0fh9sW2/9JhtjXIr6iNkIorOh+DGdyGdyVLVcKpA3Qgfw1?=
 =?us-ascii?Q?IuK92QLcRJv57K/yRerjIfmXfnskipoHb4s2zQXNBQeVKcx5QG4gc6uooq5F?=
 =?us-ascii?Q?5ZjHnGrM37rbqbirtcmBNkKdE56gdXR4h1SbpiwviQqxEbaoGzpXT7uoVaeX?=
 =?us-ascii?Q?15MtDOyn5Y3y4xzKzRYCGrQp9LQ/54QQOhzMYBNTutfs1gq3DA9DaXT/kFG6?=
 =?us-ascii?Q?r8e3WZPgNrWkkzkaox6Tz5UzDWFmN3+wndM/V6VqAiL85gZIcb6L7RX7dCms?=
 =?us-ascii?Q?cM25jvdqpifXz5zP8DRo8iLRIb2nFT/Mr6RWFY40HLRTTfBrIydTKf9MQUwE?=
 =?us-ascii?Q?bChJpDWYuWl/iJ6962l++UKd60SRLgHycg1tVLk4OIboPVq78xsVVHwAoxil?=
 =?us-ascii?Q?QIxVsh1wCG59x3Qs7WZi29PG2HtLUm/TY08UYDpG6csgEA5gsfoCDrZgfVsj?=
 =?us-ascii?Q?pz6ny0kjo1eOuzEGHReifSWzzewVg00xA9tkIY/Fd7ZyTXcUj/kGYYsWTj3v?=
 =?us-ascii?Q?Ik39Bav5Bh39eHscwd5PwY+gjkKb7lVI2zrlQpUHvopPujv/ReQazpiLVoR+?=
 =?us-ascii?Q?uTXM25ckPWzypuTwzWeCYK+VscKyprUTW987OCIq6ODIln+dE7NYmVeZqOfJ?=
 =?us-ascii?Q?ZIboi6BJ3xurL7IJcrK0lCXHBrgOCrIwfNMGteouyzY9qGk2hz1VCICIZskF?=
 =?us-ascii?Q?2nfkf6/Q2OSCD/s6p1uHcOxIizs6XTjs7c83n6rlvxVfp/vT1LY31HkQIgQX?=
 =?us-ascii?Q?W7iW++chKf2uS5hgh+GYe4iInfvQoL6M/O5B2BFYQjgPHqv8jwG8bXE0TioE?=
 =?us-ascii?Q?EmAAdDOJo7cFGm5YCu1uQVFI6m1NYJ8wWBegN0t4HEHa5yMaK4TbmnJyqy/A?=
 =?us-ascii?Q?Ey4lbr+Uzt3Gv8ysJWEFvsTv8ErB+nHFsS3Eyu4yLMCEa+A4jAafRuH799Tk?=
 =?us-ascii?Q?pMNgkJh+KGf6kbqR/ZZCt7epSlLeql9j8+jAGJKA0c1V1n0+YQthXgXUumfA?=
 =?us-ascii?Q?PitU3kH7K/GP8+67nOeBQLcXQHa2+rkgMb1ZigFfQiKz4lhFGPN7MhPtPUKb?=
 =?us-ascii?Q?M4NalK858k1hlmspUfSVrKH/IQr+dDi5+5n8IoKjiiqLB4qOeAYRUoI5wQag?=
 =?us-ascii?Q?jk3dmHYUKbnv1DUybk8wJWtNe5J+tptD/knhuhlW35WBfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ey3RdNY/zF/C4o2mJ1G2R1JIn8KySrRKDL2YZcWh06jJVRFz3aL1ttub2dxm?=
 =?us-ascii?Q?6umNDjNZKExloMx0A86xIPfKz4pp4iH3I55k4SSocFFkKsoxyUiqSqg9MD8l?=
 =?us-ascii?Q?AQC2dSochxgMFxgoJ4Cc27bZDB4OQfxVMWtjgy/m/Dc+/vY7nSH4cJs2dz74?=
 =?us-ascii?Q?aR+NYHAArDo60raP3HukTlcVW1g8S03QkDv9QBmuxULdCOk6Dp+UXMuNE9lg?=
 =?us-ascii?Q?CQqJA6i6IS3kAWz2GvD8RVU/LtjmzJM/vVf2amO3mx8Ch18z9ZRU8i0Yv9rw?=
 =?us-ascii?Q?Episx8EoUgIZPlxp4krKNZs4urV6FCtRDFD+FIYWXgAVP6U49RTC6ShvIcLq?=
 =?us-ascii?Q?JW6CXbWY48+4GjUGCEdiMYdT7GTuGRpFgF3D9OUHz4ZyaCMo05CbdiguemrS?=
 =?us-ascii?Q?adYs0Jd3zlq6cgcYaLQpoGK3foGa8KvtsijWsQh0EU9ceiTN2u8wQQglnpz8?=
 =?us-ascii?Q?uO2HrsvQ/vAyoIal4DW+jEctIz2KYZ1LQTzYhANI5xjM7SBhTOp9eq1dLO+H?=
 =?us-ascii?Q?XWzVIUKyhSIGQeLqGwChWIXxW8K6IN+yZQViA0KBqYddZqGirz/ezldVuvEI?=
 =?us-ascii?Q?mo/mbqL+AxobzO2sDGeJQynDvBRJvffmdHkGXjxHuG70c2amks3ci+yiQC/M?=
 =?us-ascii?Q?au9nI5ZGy/xuqlVU1S7BinxxGhfEiZROZ4tIhJsw6INaYb97mbJhww7et/nw?=
 =?us-ascii?Q?u6nNqg3mOLQRZWuoW1L9jpeSNiIFHJB82JlqFhFou7JBLBIBclL94TLot99f?=
 =?us-ascii?Q?oihiw1/KF1UT57GhVtgLcq3WiJY56Mp9JDjUhRxtMsXGblLhxZ90HTLwYNlG?=
 =?us-ascii?Q?/obMN3uJ90w/cHXoHvKIM9L332PCL+af/aneLKc35pnB9WEoUKXWOXgQEwOt?=
 =?us-ascii?Q?PqNxrS7ULr0r4YoEpOVEnhQHjcRNazJLFViQLPRKCJbdPVwR2m2n5x9JxoXg?=
 =?us-ascii?Q?rqWk23EEQhMGlHYh3yebnNIKZn//uDHw6/b9t7zNGvpSpERrtNu0xXP3h2rt?=
 =?us-ascii?Q?j/Ma+PTzeZkD6x7Zez7FMKFeE6CKuiQiBp1wmUnaxQd91mJ+a/pyeFEpqeZ8?=
 =?us-ascii?Q?42ZedCfCJgSf370i497QuBoz3N7DF1Kx+aMtL2Q6gO1llv4jwpvFDfEvd/GB?=
 =?us-ascii?Q?ki8xtVC2rJliRXaO1b+VXd3Q8HuXIkHrfw4euHFf1S6WKJP7dX+I5ox1sVjU?=
 =?us-ascii?Q?4nBy1Yp7DMzPKd5ZVFv41gupHJF3C4x+ZafuH6BkUaY5UeMXImPA6TmmqLhe?=
 =?us-ascii?Q?PIVNA48QrS92bcPt9iU7uAyIUVP47aF9B3KRWdaTLl26hhprg2u65zVngwF1?=
 =?us-ascii?Q?nMbJoysqVSJU8H7ByWx8yjHTEOGoHHHEsD+jyke+biIvdDWgk5MxWCxGp9K2?=
 =?us-ascii?Q?OF1H5aPSDvG6+GtUrvcFZ+w2VtyMZFrrcUGzaPPJDC34zQi4/ZI6obAuQsT/?=
 =?us-ascii?Q?uYxc2fihHNAZWKPg8FTmoZ6ahopfYAt+6ebzakaYBsDnvwPlm5GEVAq5VDfI?=
 =?us-ascii?Q?lZfvEZzwFJNhcJCBa5t3XTAkXgWyOEUinuJpLtrEP80o/32lXcbWSnXR3FNr?=
 =?us-ascii?Q?njg9wi0AYyg8fVcX/MYsQY7+gne6haVTKrY7fLgyfNw+f1M2NHCS3U07/rss?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tzf7bm4HzxN8lKjHGD/mOJbVnfIJUdkUoBrvK6oPuhy3ecqLyoar0QX+4OddkEisI2ZKmFg+wBjvh8MlmH2oQ7n7P7JAbJc2gsNUjtpgN1ti/+sl7YN5q7iFYw61J+6n37a21kpm+3QY3fXHIEeoxqB5V4fdGs3uN3NdIrLIJWcQ7fnqxAK0E+o/RYaeXyL+apfCrZukxI8tfHjTR43PXHkOixDqWQ4BQ25SCWtSZ3Jac66FQhpFSJwk1XruKnPyaTCBd6itvHoplFzgbiFAVs/ijYZJjPGOEI/C7dRjGH1EopovxDOG2/YDVGc5JV3eSmWrYH0ss3l5i+zpStolSd4ctSfmzciX6DmNaMK8F9FCi7KQd53Jx9XfYHwlN9HiHgRI2MPa/1Z7+wWnjCtZkz2bs0nFoYQWi1VhclBU2eJIge0yt+aA+N61uXeHRCCkr9W9UGcdiMewI9LELi/ZIcTyN0MN0634ZFeGk6k8qdFCyw1+pXOhUoOzfTtOAOQcT30LHTRmHVPmv45A+MNDvgHbjoDi3IjZP6nUwDRwgydjYcvXNbz0BkMocUWI8tzyD+Btw8LEPW0kfUUd2tHYH2cr6zTO378U+iF0vw0lr84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52786634-9030-486b-595e-08dd0ec5252d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:23:25.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsM/GF6vM1LeNzJNnSJl2e4M5+d/ZIebuhYSla/xKkhPsY5XkChn7yF9chyerD34Jb4zCMSpWCpI3oy09A131Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411270077
X-Proofpoint-ORIG-GUID: SB2DpGNV4xt44dP-hb-lMMUWPgNWkGwN
X-Proofpoint-GUID: SB2DpGNV4xt44dP-hb-lMMUWPgNWkGwN

A write which goes past the end of the bdev in blkdev_write_iter() will
be truncated. Truncating cannot tolerated for an atomic write, so error
that condition.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/fops.c b/block/fops.c
index 2d01c9007681..13a67940d040 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -677,6 +677,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *bd_inode = bdev_file_inode(file);
 	struct block_device *bdev = I_BDEV(bd_inode);
+	bool atomic = iocb->ki_flags & IOCB_ATOMIC;
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
@@ -696,7 +697,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_ATOMIC) {
+	if (atomic) {
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
@@ -704,6 +705,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	size -= iocb->ki_pos;
 	if (iov_iter_count(from) > size) {
+		if (atomic)
+			return -EINVAL;
 		shorted = iov_iter_count(from) - size;
 		iov_iter_truncate(from, size);
 	}
-- 
2.31.1

