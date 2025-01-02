Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81843ABD
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735829083; cv=fail; b=GXTiop/PcspBmEEux3JfgNobGMCham0DbqEYKy3VXiwYowvYNPrf/Efk21IoPD7L3NPbsWs2a02ZM5iVAZw9nZ4jUx2ppSXNy09LA1+6H6KPzAm/vvoC3a4NXAtgXMYzOFGete/lbv7mTr43B73uCO2Zs0CfoMKs6/GivXkhf48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735829083; c=relaxed/simple;
	bh=mJMHkO77NcsctSDotsZL887SA9uSxpuJHT1y1zCXAMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KIG1T4FknQpvH3kxSnHV4ZnjR5/ZsBF8/NulEKWlrvce2XBKHOmvCK/sM4oghtZ32YYRbv3XhV1YWovV9pspPymy22F2TzAAdJQH9OWGTchEiuIgIhj56zRoI9lILLjt/YfUb4qIEje7KkMOYAxlFN6of2PV0uHF1nBCQWmxyI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEosnLHA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hmE7rUUy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEosnLHA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hmE7rUUy"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtwY9014852;
	Thu, 2 Jan 2025 14:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=FR3VoXlhT4GeNgYb
	Dg0V+10h9EEvPd31OHroK54xSZQ=; b=KEosnLHA4Yp2DP6e1qI0MBdCLvRA5V5R
	y+luKFdPtgoLY7xQV63DGoWvdn1nTF5KLCe9Xvz72l4CRuOCLvyyn5oev032jRRx
	CHv8qzNid/zi3yg9j8MsVCFLyNSIOe5Lm7enXR+uooWEJHs9Srh2pL/2t3n7INb/
	+KcxlplZgltjyFxPzXVwdt7GnyeS5iloIKAArcLUMjnPis6viyBKA3BbR4hY8rqV
	t9s3lzMGc2aRxjj7p6nbOhameW70Z0hDAORN9LC+/ClyvRTMdy9CpyuINNnzO099
	4NpNUSA961gl2MkGXNhXIwUgQ8GeAKPnjbL3S/ViI5rKPtC1m/nRsA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt5dxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:44:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502EBUVZ008766;
	Thu, 2 Jan 2025 14:44:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8kmxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah+L2nZBCCkwrA/K8WSEhMujKR3BfLzKY/8i9vyxbKfIZBasf44R+6QwMI2oLvmE9AqBauksFH3Z6I+7R/Feblb86UJKssHOs2Yvdv4tb8VBEUVsk8hOfE/D70KMioGxi38ARwwgX5UQSy4Qlp/pz/Ju32fUzSrzVTAMBNaTD7zRJu1tJ/lSgyQBVgVgO4UXfkFo+JjUwbRYsvGPllP8ad2490Fq0PXSeAs5y1pN1W+kcpmtG9B6H81IN/J5MivnXm7t5Y0xvz65FYVYsElvJRysAZK2sArG8H2hw5BeVFNTszqhhvtc+NhH633M57BceMxy1oDjE9iOffHU/nApOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FR3VoXlhT4GeNgYbDg0V+10h9EEvPd31OHroK54xSZQ=;
 b=I0Q0PFXrJT2/XLtvYJB89CTS6+73/E5MpfqiHjlJOJvZto3urwQign93JwXHk4XebgFVcFkoJvsroU262l38IvQaxJd/6RDmO8PNYfnTZOjGB7HSWdgoH4rre95R8E/kjRm56AHEF0u/uLPrs59BQLEhBb6YhYRv/y7VW3zyzy/3PSoSPjcAl2bXVG0VidHFzspCEnJfeD01janMdpgsavgN6lJ1qxlbQ3f9ellPEQJDE6lgwJMM4D7h6JBC9A9KzAxVFN2wKSg9NO/ZFGarkPWmKd3nVUKRx0LP6c3VouT0KjMzH5Mn2QL+sw/wCyrMVG+kWqG+1cZI9wADRxOuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR3VoXlhT4GeNgYbDg0V+10h9EEvPd31OHroK54xSZQ=;
 b=hmE7rUUyXQ/076XmmIKz5Z7wJrm0dB063P5eTOFrNugDp1qcSIulSRRl0aPKvyvneRmszWMKCTJCrwlpKZ6tMwIPFcQ4UeG5sZnuplTGLYZYGxLPmiQGG2BIILX3JrzQ2zg7Bg/M0+7tgtqRh1sXIcJv1kgEnLqda338EdtQxjc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4917.namprd10.prod.outlook.com (2603:10b6:408:116::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 14:44:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:44:29 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] block: Use enum for blk-mq tagset flags
Date: Thu,  2 Jan 2025 14:44:26 +0000
Message-Id: <20250102144426.24241-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:408:142::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: e504d2a7-0bfe-4cf8-f500-08dd2b3bf694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkQHKVYcPS3py0MzUI1GcNuV2nDpXEvGLVyJDznZLvCDn+xNbv+hOD8zSkX4?=
 =?us-ascii?Q?X9dpJ1TCA1F3PJ4bU37vqLlIvvSFzwMBWr0fldzdVO3nQTc/7pUNH2musIoi?=
 =?us-ascii?Q?9AVtGGClrGOfmoe+vbDwpVGj0Ok59X6lNRHuiGrcLwvtrNkn+cJO4zg3O9iy?=
 =?us-ascii?Q?moIz2eI/V28i1HGBLAvzwCuvVYzLKTbz3nkRCbEzR75Ie1tl84E2+Sxv7EuU?=
 =?us-ascii?Q?S9T5/Kexz+fCSYtbb+/BZzvVs5kax7pu4sR8LSBqphlj2XNU1O94bnU2PtLf?=
 =?us-ascii?Q?yQcb5dZ/HpOkp1jfcKAF4Y1U+hhMcA0CD0y1CTQZCdMo0LCa8lNeJsurri5k?=
 =?us-ascii?Q?f/VG5KUCTNm+Gsx14rrEhxehJ4OwhKmqVVsS4vBFceupB/C7v3O9wRGlhAiw?=
 =?us-ascii?Q?2fhAAmNNzDTohUk5S1iXfEE0nzL4xAR+vkOb2wvbKuyUTQoogTC/tbwYnNiH?=
 =?us-ascii?Q?PLDzEwjOWZrVp0XksznViE4J07uq+fzwmdaubrfSyy1Rc377t6F6hFv3Ikx4?=
 =?us-ascii?Q?ol/T9fkHtD6n4YmXBc7yIKAK8jbEY6uS0oj1sVxuYz8dyEaCM6ok9AUafdsh?=
 =?us-ascii?Q?+SpPDorcP1NtdXHaattMyOdNO9PgukQbFevrBkmrfWoBPLMVhHoUMeOjQY+B?=
 =?us-ascii?Q?S3y1pomDb4nKDq+XCA5cHdnAqToHInBPkdMNcGhYFp7u4AIcAcbrfeQ/40Ha?=
 =?us-ascii?Q?HfOIkml1GW4EbUm1rTNKxk/s8jw3kxxk29fIRzZ9P2GDQxg81/KObB56KYbd?=
 =?us-ascii?Q?mx5eqC8Cx42fDI/EL3MnwtJLu3D+LAqQdVwpqWLSDWh1mTyX9TzFGYzWQcAV?=
 =?us-ascii?Q?mBz/z5J11qtQDy1SR+VmvA/UvcfcA4+/rDe3hrjvbiWUkbeKpeBU4q0RAj/G?=
 =?us-ascii?Q?6MqKwZMsEOaz3vJc3RE86Ee34sibNVrjLAqZQYHR6c/xFHfvUt86laKPUQxp?=
 =?us-ascii?Q?Kbi2aoXs4L3sn+tNQTky0r0rieFQZmCzq0BCeNnuJVKkCGAjCv6DxECPTboG?=
 =?us-ascii?Q?ZTuqjxzOybpVuQhj9vVZC2fCP1wWwRF8/QOG1gCsOjldnYEZT7uHmPwlWqEY?=
 =?us-ascii?Q?O8QXgl+hh6rNMBA41C+NTJPSDbh7mqzAo5xxxZmBYXbVGvfLwhqEQHGsB7NK?=
 =?us-ascii?Q?V/f+khpqnHI3CjTiNY119+K887d8ggatspuoG3VThQ6xlozCtLbXWx+/TXze?=
 =?us-ascii?Q?kKuVAQ12gwF8fNjGyMg8o6Ull73LbQ5Jml8vKCEdJ9ox0YwwI/6C6cUbgbkt?=
 =?us-ascii?Q?Sc0Aw7BGDAuH+MITLrtSGTmQx1vwPBUlAYnGXvmeJCuIZoHW/O/R/xsndBtG?=
 =?us-ascii?Q?CGIf1eG0irP8fDOCpmMuL1lkWqoAmrStBKPBwo2wFg9bsxZg9n4hx+Vs+XDg?=
 =?us-ascii?Q?YrUrDoCOOvmA4B2lZl/Gb6lCNw0N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hp9usKgmSi+tC5PRkbrlwlU4ZEeIUpny4VOVyCDhbYxuu26glxpZ28FqiALK?=
 =?us-ascii?Q?PS6D5i1OjWPgjOGHJqeOQw8bbmIKqqvlb73FkWa2/moU4P9T6cp2sP5aiIJJ?=
 =?us-ascii?Q?4id4sgysgMsQ3Xx8tvEgImP4tl04isJDGLY9kn0RJC9ryPXC8GiJZ+5lwHTT?=
 =?us-ascii?Q?AIyx9NZrBnF3WfopiSqQz42Pwcy3uwHJeT+sSpF0gmhoveyvcnu+FOGRHUT6?=
 =?us-ascii?Q?Hva7c78hFne5PCix2BHvLLkNx2mv8uvzu49pRDxOMAQiBTpCt6asJTRSZqQ7?=
 =?us-ascii?Q?b31hZhOfI2KM7KHIHNZSaLg6DTkbHKT468Grpx/N7+75rVKFcyjcGkcQ5ZC7?=
 =?us-ascii?Q?5T+fDBf1n6Kax9sNlt01QlKY/R3ACmBQ+yCLizWDOqxWdWbFdxRiJgCFSimR?=
 =?us-ascii?Q?zyjiQNIgYSqx+WAxMAkkX/a1YF8BRMPGid/kCFjjKG6r641GnYRRJ2rSsS6D?=
 =?us-ascii?Q?JqfMzN9ogO+IVyjb5Iw6d3TPVyeCqqmFRZSQDJN0pCulKOGmPo0wXDBTO4xJ?=
 =?us-ascii?Q?YYtlcGlXfOBfdq+hRhUFMUFrIcSSqrUUYi9ZGzJRPMaPQjiWCJyk8DukD87T?=
 =?us-ascii?Q?9tabBOtHzZnvFKtmJpRuBnyumInWWem88irDzyUcxVch6xbhar2bfmlO7GiF?=
 =?us-ascii?Q?kn/honk4HhDmPOfwxN7ZrXjg7v8gTmhH3HxXoRhNpFBFyiGp/lAhY1SJgXT5?=
 =?us-ascii?Q?52elkCXQK0xzMkz2G6VGKd6KLVp0QQ2GjQ7e2dIfbQ8lQyKcBu9C9lrMymV+?=
 =?us-ascii?Q?pBovlNJy93AS7YRN2zo0BzKL7MwCAfFUP09LGAahTq0XotxpGpkGC6BfvzJg?=
 =?us-ascii?Q?eKh0y2HuRBbAYQDb/o0A4X/YJFICFnc3XBtgcZ8hL04ZD54oevbHa02Oz5Xz?=
 =?us-ascii?Q?2q4Def2nR/BQ2ObqbIaQwYzJZwZOsz6G4/bk43l8DLivbQ2TkH4zdQFrB/fT?=
 =?us-ascii?Q?E4aH6SEUopKjbTcChvvlaZ6QXuVG6o7xXT60tTG7Tf43dYDnc2W87juYmhFQ?=
 =?us-ascii?Q?lFAQnmiZnT36RJo8zdaRkTtJVp0KQ1RL4LUdpIjvwCerLXmJ84dP5WhDXesn?=
 =?us-ascii?Q?xn3C6vjnT5w9JAVyxAFZbdcjdEQrCdznnV3RHp7Cs0JfjqCSK2QvF0wPANCr?=
 =?us-ascii?Q?eSiuVTt7p8YGas5nSQVWq9jNEm5r5NIyt2gkRyga4BQKeaX3owTTsM2iRAPR?=
 =?us-ascii?Q?0p9IKp1IcjHIydoGwiu5d4PLjECVD14R5T3h/weoC9ZHZOm2leFOiP/M/S9p?=
 =?us-ascii?Q?ZnMP+pKzhH4aIhJ1RCoj7mmRofk9IliKBrPdTBDT0hN3s5Agu/3L2y84wd00?=
 =?us-ascii?Q?hxBmdBwrRJCfj8nLqjmLv91uHa2CmyLmQw8yzb5cgu//yS61OWPY9oyAL5C/?=
 =?us-ascii?Q?eFaJJkhq07p3queJeKyQ1KWkSqkJ6Ykbmq3Q7npxnJUEHkpHunzBkSk9UCJ6?=
 =?us-ascii?Q?YmTlCCuN9cKxZ/DptgQp9WD+IoMdqm74mRLRA8Mqdd6hDXAQ3/brVWasKAZN?=
 =?us-ascii?Q?muxJftPy3MlUhacMufQSF5ln5HweOHd4YYnt1k2wCiUQwDC4EgQp4cA/V7f3?=
 =?us-ascii?Q?mHDVIQ1CLMvLM3LjICqjc60kmHvWB/LEqrE1TnxozjlE3GSaF4shi6f44OiN?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RLyL3Ba1dXxl3cI9+k6p4uSECZaino0xpKPgpcpJtw7D2+JLuBzyjvVxNs45k9hmz20YA1iZ2lu7pv3+2I6mue/ukc7jnLFFBkEtJtkHRq9WBfnDlrhwmgQPlODEsouSpfMImC6JuXvI4dkUu8EgK6IBd6lvZ4RN+ThA+mF1k7mnjA7x25cYU9i4CT9OzPf+MYHsRucwiTFd4RPnyc+dsny9z2dPopYzPaXAKUWewl/+2gQXReUs2aHMmqvn8yHphU/idXhQ8YbirtMk+fKO0huF2VecinVKEE6vOzM+ebpQszKn3cYta+j2qeFAghAdHzyh41GrKH/eZOWZXCbta+366WMg+rsoVD+rI400cCIVcAXzia7O/gR0bcWiSniZoSPPCfcE/J18C933E5nji6VGCJfFxnuG6MRI7mvMFkv0hk9ZaaTHPS13nvTLGtYAIR5LtBTcKfa83CTAip7l1Z/g+jf8FRBZRaxUTGcU8AiUUOuduiSVbjIRbibu4Me2H9o1/9O67pu/caTCkDS/N9yWjiXbkXxXXyTRZVN3Fn4uQLEbAPChm+3191D1mP3NdQr/wttJEdrQqZ3gya9fR+7C1FQ5hEkEx4UURIkwUTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e504d2a7-0bfe-4cf8-f500-08dd2b3bf694
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:44:29.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfqy0htDylANc13wp1vmv2asycJJMW9DMTh4nW9NSlGtWIdejImoAYoZZmYrtO+HL/GVnn0JgJ2rL+B1ytad1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020130
X-Proofpoint-GUID: aCIjcOvKBsD1U3_1qi9j-LTO9GEZzFzf
X-Proofpoint-ORIG-GUID: aCIjcOvKBsD1U3_1qi9j-LTO9GEZzFzf

Use an enum for tagset flags, so that they are automatically
renumbered when modified and we don't potentially leave
unused gaps. Some may find this neater.

This also catches when a new flag is added but a corresponding debugfs
name array member is not added.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Differences to v1:
- Stop using ilog2 in HCTX_FLAG_NAME
- Reword commit message

Note this outstanding comment on v1:
https://lore.kernel.org/linux-block/20241223192727.GA21363@lst.de/

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b6b20ccdb53..dc976a42ecb2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -179,7 +179,7 @@ static const char *const alloc_policy_name[] = {
 };
 #undef BLK_TAG_ALLOC_NAME
 
-#define HCTX_FLAG_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
+#define HCTX_FLAG_NAME(name) [BLK_MQ_B_##name] = #name
 static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(TAG_QUEUE_SHARED),
 	HCTX_FLAG_NAME(STACKING),
@@ -196,7 +196,7 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
 	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) !=
-			BLK_MQ_F_ALLOC_POLICY_START_BIT);
+			BLK_MQ_B_ALLOC_POLICY_START_BIT);
 	BUILD_BUG_ON(ARRAY_SIZE(alloc_policy_name) != BLK_TAG_ALLOC_MAX);
 
 	seq_puts(m, "alloc_policy=");
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7f6c482ebf54..8ef1a2455490 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -666,33 +666,39 @@ struct blk_mq_ops {
 #endif
 };
 
-/* Keep hctx_flag_name[] in sync with the definitions below */
 enum {
-	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,
+	BLK_MQ_B_TAG_QUEUE_SHARED,
 	/*
 	 * Set when this device requires underlying blk-mq device for
 	 * completing IO:
 	 */
-	BLK_MQ_F_STACKING	= 1 << 2,
-	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
-	BLK_MQ_F_BLOCKING	= 1 << 4,
+	BLK_MQ_B_STACKING,
+	BLK_MQ_B_TAG_HCTX_SHARED,
+	BLK_MQ_B_BLOCKING,
 	/* Do not allow an I/O scheduler to be configured. */
-	BLK_MQ_F_NO_SCHED	= 1 << 5,
-
+	BLK_MQ_B_NO_SCHED,
 	/*
 	 * Select 'none' during queue registration in case of a single hwq
 	 * or shared hwqs instead of 'mq-deadline'.
 	 */
-	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
-	BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
-	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
+	BLK_MQ_B_NO_SCHED_BY_DEFAULT,
+	BLK_MQ_B_ALLOC_POLICY_START_BIT,
+	BLK_MQ_B_ALLOC_POLICY_BITS = 1,
 };
+/* Keep hctx_flag_name[] in sync with the definitions below */
+#define BLK_MQ_F_TAG_QUEUE_SHARED	(1 << BLK_MQ_B_TAG_QUEUE_SHARED)
+#define BLK_MQ_F_STACKING		(1 << BLK_MQ_B_STACKING)
+#define BLK_MQ_F_TAG_HCTX_SHARED	(1 << BLK_MQ_B_TAG_HCTX_SHARED)
+#define BLK_MQ_F_BLOCKING		(1 << BLK_MQ_B_BLOCKING)
+#define BLK_MQ_F_NO_SCHED		(1 << BLK_MQ_B_NO_SCHED)
+#define BLK_MQ_F_NO_SCHED_BY_DEFAULT	(1 << BLK_MQ_B_NO_SCHED_BY_DEFAULT)
+
 #define BLK_MQ_FLAG_TO_ALLOC_POLICY(flags) \
-	((flags >> BLK_MQ_F_ALLOC_POLICY_START_BIT) & \
-		((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1))
+	((flags >> BLK_MQ_B_ALLOC_POLICY_START_BIT) & \
+		((1 << BLK_MQ_B_ALLOC_POLICY_BITS) - 1))
 #define BLK_ALLOC_POLICY_TO_MQ_FLAG(policy) \
-	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
-		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
+	((policy & ((1 << BLK_MQ_B_ALLOC_POLICY_BITS) - 1)) \
+		<< BLK_MQ_B_ALLOC_POLICY_START_BIT)
 
 #define BLK_MQ_MAX_DEPTH	(10240)
 #define BLK_MQ_NO_HCTX_IDX	(-1U)
-- 
2.31.1

