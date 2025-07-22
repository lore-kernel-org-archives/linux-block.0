Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D023D28C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180005; cv=fail; b=VVnwXhtXoz3Nv9TPmrj9ui/JGE2yoObhLhc3/OQ9EbwhD1uQMcKyaArGxNBKoc+L4hx88MRkoJNLnSoPdAhuQxaEScyg6LhMJ78vTFY2Mg3HofWelGZkdCabT15hRa1Qt9iiHXRlFYNBB6v5SDYPsu1Tk+r0HIuask7Q8CpmLbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180005; c=relaxed/simple;
	bh=NCxAE18Th7ygoiZkz5PprnCgerLOaSlVX2wIlj05+4g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lxWGfatyD3yT3bRo3OmPkV4EKLbWzuS0auGKdravdkRd8QmSa1+WGx5TykmNFcQQL/mOoifPrpveSegoT5UEU6kG6O2x3dMI7k4aji8olyRPT9sf2XpXErtBUiw7IsOctniiKnxxFlQH8jfslBg7glRGkDvWjwIUi4+XucxKyNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XNiLlEy1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/vfYXx2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNiLlEy1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/vfYXx2"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TAi6024411;
	Tue, 22 Jul 2025 10:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Xb5bKJQMQzpxYCwW
	sIipc5hsZzy2wNGPndtMA7TTOmU=; b=XNiLlEy1fro1H/+MvUkoeqIaAeq7fpc+
	K18q2AVK3ld2jG0VprzPufrtz7OiFbtKMmaWS3U8RHbl2mCU5OoPUQxPl2zzVKca
	oFGvHLLloCzh4+1PjpoLopwweVZciUqtmjjy0DX1EiXiReU22WrwijIjlw9fqAvO
	8CrIEY7yMOkuk++HtsE+WUCzZjyvVAjguQQdKwHX0TFqsdgzL2wvI49Yvof4Hj4s
	lV11yIZFxT0mC8BI1bwbX3fT9N2qDxV9Yastqrf+7AqoMDqnXTR2TcQ2SONjf7Wf
	Q3HkeXMni77bxaBzLRFXZr3r01oq8ArF1InnsmqV/pvkGcGqEOgRzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qvyxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56M8YisA014405;
	Tue, 22 Jul 2025 10:26:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfembn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 10:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrixv/wstygfCTpfrjN+Q1x6sdcHhm+oab8BOgUBOLR+2ne0XxODWpgQdlxxrySjenvM7e2Mo7EUI+9KkYNf0XDBifCOdzbdmI8ZyQBQjQtZbKfrR+hm0ws1xDT9syDqjpzfLWT7qbvrtp9q1Nert6UCSN8XjYRv9SzhEK7VR72jZaDsP62Z5yKAHAru8auhZ96ZQYwgn3WY/BFYirEE2vcJ6NXMn129tn/65VHp7IrZaVIXy/l66qpmdYOovtHDssr6EWL/oQnVpQMzjxq7MB8sV64gx7b9DRpQT1MGS8jzI8Nhuyhq+/DK3rwpkQp2iyqS79H9l8w41NNuzZ71CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb5bKJQMQzpxYCwWsIipc5hsZzy2wNGPndtMA7TTOmU=;
 b=mbCuIAA2wDmGFL0II70JJ2cOsBDfwEDpqTP8l2pRSjM762GB6viMNBDewiU3KnQ1cAVv3lFUCcWd6VY/GVBL8qH31KqhRFiQsiR4oMXIjim58sH2RcR7a/zw1cfI09p7fZFS5uRNAhyqw/dVCu00GEg5TOnH13Pe44NALvfMRQu8ccgM6tQMWOT9ot0IWDI+zPc4M4k9Cq7gQG53z8nTTYyYQjzQEbfk6tM/LmrM0Lz9SktUBNgQMq6DCMy644NvuE82NmrGt/Dr3k9E21WMl+YIKK5z9xIQA0QvkZUm4X6fUzNhIZgF7r8ijppkcPtmHcgKaWlXgXqetVllRoaEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb5bKJQMQzpxYCwWsIipc5hsZzy2wNGPndtMA7TTOmU=;
 b=V/vfYXx2GmhJLBbFFL29Im4NBvFth0kQbY3kC1pqX21n8Z/MMyBrsQPSQ0flKb1ExLT2j4T7Tea6hlNmNZ9VWZLykoeYmnz3B2eOoX68ITecw+OlK2hw2XZNd8L4x+bh+lHHsDTdKjbhXYNqoApTzIINrZRVi/mBCWTe+gvh4jI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 10:26:36 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:26:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] block: make some queue limits checks more robust
Date: Tue, 22 Jul 2025 10:26:18 +0000
Message-ID: <20250722102620.3208878-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: f44da0be-c644-4a7d-bd45-08ddc90a3cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfDfVTL6qLOZdo8RTRCEXyjsJWGYYb8j8/qcHzoQEHRf5yn+AbUBr5C6Yx3J?=
 =?us-ascii?Q?pGKn4yyG/dxj1KXzZwGN6UJR0Etj6av15daxSqOuwD41ezEmqs2m8vRbrGA1?=
 =?us-ascii?Q?GI2edGl2A6fWqE5QjLnSVuPjjIu4U7Ggje6lrsayShwV5CffMQFXEFkTySRG?=
 =?us-ascii?Q?qyDaaT2j8G91kMb8r8Sw8pwDzd04vSnnnkGluNXqjxbRxr3kTSnQuj2IJjjV?=
 =?us-ascii?Q?aXhbOdQGRwGPCvRh/SOJJwYlMzpXXxULHD8vum2rznhzaywCXLjL7TLGeyKe?=
 =?us-ascii?Q?9lBYrO/SYNiJWWcixGcZ5HIiPjOzFWj9Hdx7k2LQ71tPQ3InQxvSp/hWZDZq?=
 =?us-ascii?Q?xm0pTOyhyRuVA8VfkXWmeDE07MQ3VdGhkJqpu85lXATCLbfQs5kPQjgWIk39?=
 =?us-ascii?Q?Vy6U1/ax9cRa8ZWOgDsw1xhwrkYHr48AwnRPGqSKCw2r1Qj6KIDsT4co5e80?=
 =?us-ascii?Q?zTLF/aD97K/vks9pscgd7ldihmGmMOp9G31fZ9Pf5dlkVGIuH5ytjfi3CXJ2?=
 =?us-ascii?Q?2colRpJxvdZ4Vacq7Y4FYKau480A29Hi16hLIKhTuibJFaGHxI1n0TaSfhuG?=
 =?us-ascii?Q?8m3ZOtDSBRDBsuw/SQ2gHBOq0NBRI5kl61WctuxoflMK5KjiV7hpVbrUzx/y?=
 =?us-ascii?Q?azinxEloTh0n63uKlXASC/BP1yO08LV+Fbbp7pi6WFhKrM/cm2ZR7t0IA3Wd?=
 =?us-ascii?Q?CeGr9R337W0fy6wRTMSoENLS34CJZIEg2moy80tu+wZbsV96pMD80ETf9Hha?=
 =?us-ascii?Q?itsvg7dVIaOvcyJ9EET8aANdwn1ScPFEvKagLmuz46nBNkRLt8wfGMQI6Uju?=
 =?us-ascii?Q?FdFl65Bj6votyRjqbR2ulDzmD0MLK1mgiS9pfuzhv45+ij3r3oS8S2yWHfBH?=
 =?us-ascii?Q?UY8gExFOIsJsrqTvdvgOr7CURt6Y0eMbjc1lIwtrzBd6hkEnSU8PdU9W4t7f?=
 =?us-ascii?Q?7bWWL9iJjEiEt4bEGGRZdsnujcA1+z52qtQ/7oXEl0CeLT/+MWk4owTWsZkO?=
 =?us-ascii?Q?d03+WwCbsjny+jCZw/q+oF0qSS5IeswQ3xyFlHvVaKl7u9nVPgKMCgdJ5Be8?=
 =?us-ascii?Q?hAvnc9Pa8qsrvLEw6jwq3M3BktQVoVYCXAMC43nX3eS58Ek/UYrcf3Qa882x?=
 =?us-ascii?Q?faez0eoBZMVmXs2tTq6G1rQnnU+CIyx5kgEnQ64Z14I7p1lQ4BiO+2DkN3Lk?=
 =?us-ascii?Q?6ZIqFo4R2vLDkobA+XOJNBke/85yxvBeaLtb8wTaU115uzsBFpFEoZ8Z+wZu?=
 =?us-ascii?Q?nJH5GtDTt+4SMVOOr55CtVuziLfxhVvfu8p2mBr8+Uz9vXdBk3OtV1skx28u?=
 =?us-ascii?Q?vT9cAIA5SndCRw/IVLsdgp9R5KNZKGI9ZHRQ4+zEA4YPqxdcoHLokfBxcBnJ?=
 =?us-ascii?Q?dHR3QyZPp7L6X482IRjaUG+FQpBPcn1QqeBwKYo/nFi2vC95EZcSWS/oDE4O?=
 =?us-ascii?Q?b9lmLs2PJA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dr2OZuOHhc9XrKCTiElGaFYgsrNJT8zQomOFVD0fyw2+cFm5XrlbeA4kCNs1?=
 =?us-ascii?Q?VxywfREYLmXJZWdBEaX+8zij0+xs1gw+sYtdXl1OEa9rWHQLBw146Dqpt9EU?=
 =?us-ascii?Q?AS18iHi36jB/Emng3ZzgWwMcdRPasOdObED116qd2LasnmPK+LXqMR19HmN5?=
 =?us-ascii?Q?qyyvxFRtyWk6gUkptUwlr9xzYEm8nrtIsge6Crgn28HH80RalLM6KhFgz/Em?=
 =?us-ascii?Q?9f2TXSPFrVdkywz5/TQjsprNdbvDllyL69o6LwHgCgbCol1HPYsnUNc9zFuB?=
 =?us-ascii?Q?j8GWaDY7Luo+pbM2EhsBdh4IXCac/7jxfjyJOPVv1zzHXqWOI7X2vA12jkaN?=
 =?us-ascii?Q?Z+G9bWe7Z2d2lkfhuRbcFHyTHod6hSyCWydNdE8djhNhac24vyIzgAhfRWVo?=
 =?us-ascii?Q?edhLz9ymLYyDe2BZPqvIS3cRT+ksubraIXu+1DtABHE0O9uRQsdcoe3e7fkL?=
 =?us-ascii?Q?w+95djbafAWIuJH+E0LBaym/6FSNBjfFlerJ/wBh+1QqYKjdSt0Kc9z7E8Wo?=
 =?us-ascii?Q?MNaJXgLfP9Esmc9nXptHONEoplqFfvM8KwPj+yGP7CbGE3Pq9Y/7NvkAlKgI?=
 =?us-ascii?Q?cMXC4qgNNNwyjb/+gxatApcOxnUZP5aVDYSbFnArP3ZQ2VaeI6sNl6OwncOY?=
 =?us-ascii?Q?YpUFTcOgWuWIzrKrdC3LU8gnt9sEne24K6U38437W4vm4mnLxKn9+GZ51fke?=
 =?us-ascii?Q?DMidiH0eCgYD1EFrjT5/d1Vs1bIN7S/wn/qg1quCnlGOYTr1gUnpzSKwLCyM?=
 =?us-ascii?Q?KaUz4zIqqFPYALHMR2d66WR6E4LzIvt1xUwWgttD2YGV5X/xxblQ+MF0WaER?=
 =?us-ascii?Q?nByXwkdnFAc4R3SjgKZFO1NYWfvjdhM6xHUZkMek44oBzBaWBu6lLQZS0vfJ?=
 =?us-ascii?Q?wE/q0U2IuZETAbXdQayra/O3arDtuGHv1k6affgzpJeFRmiCZSjzQPejgRYg?=
 =?us-ascii?Q?SRRZwmMrp5Kxu5n2797Lvl4BmsqqyF9aL+xnQ8tPFpohEUTY0nAoANk62X21?=
 =?us-ascii?Q?KJbcYuZ+WX+rIVFSbBbtd4zW6jWDkAx4FXtrLqXUWuyoIy6tKsluGeQ5tYm0?=
 =?us-ascii?Q?R2SYtODVLPglDXvZXDU7j+npBsCLJuGTKuXNQUUBYIKr3tTyVpQgUlDnqQtb?=
 =?us-ascii?Q?zKBE0uKjFyXYoDFtcGYXyDwS6iSKrUvykEAk4mb7j4Upai55TMYcyHK7Bn9b?=
 =?us-ascii?Q?0A7o4IOjmFHUPFJAyu7G6ImQNjiDmTPEy03v0SOyJ0X5eXebgBTQEQVWbLzW?=
 =?us-ascii?Q?tTRYVe16JD7xa0qCVP3P1GqyBXZyPQdZiak4QqVPoS88LEDIuMGlS0tXyFXG?=
 =?us-ascii?Q?rPyAJQr2GOs5mcMBXVqV0RxwtznETuWDjEQQ8pQceXDMMmXdGGrsUoD89W/A?=
 =?us-ascii?Q?HnelbMBOoqClq1x/27Rgk0+ipB3FSoL2JOfJT8gWJSwXBaitDFgJca1hEQ0b?=
 =?us-ascii?Q?EQFytRjA/QO9bjbrAnjHDvbs8H3xfvzAqoHrtbViXMjbEaaVuHPWa/Afm5+J?=
 =?us-ascii?Q?PpttLAtoqbeRfA2pmRi1qWyLQFTtQiL0V0bqx2c8XaPOCl78GsTekWAH3q4j?=
 =?us-ascii?Q?OvtVrgH4G+nGflUk5muZ/Q1Xudz7bU91IetPCbNY+KMH//vDJsOf6pMsFapj?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NoOvQaLZDvFrqIIOGVqQIPDpPnw6EGoISLVefR+m6RNrdsnAyGHQUOGP9RS2I2jozYCK+i2ZzzvmHWzGgV54iz40cNSUhEDB9RWPxvEljmOPxemvt8vwuEvScceBNWkwq8BMF02WE4grtGFt3kOKGJALh53aaNdhnHyfhtwwoNwy7bJI9e4mjX7bjf87qLYDBLife8Im9JcWdM6T2N2BjBtgYB9y7f+Xs+SZmkceYkbxw/JC+2TrDD2MG0kApu3873ZoAral1TIGCQva4iZDAOOPIG8J1aKhAwSZtaZymMK+fXBkbp3qD6CaYlXk407Xtk/mIAh1B3U0VxACEX8A5IyLvsSoO+Tpxqm/fBDW26mbBayuz1xbRoNeNcEBCQ5dEKqPOyG0wqkmt1w8UjbLGkvudF3GG4CUiGJ3aILK1h+u/7aVj4aR5jHB28n5rnou3wqAh43fRT88GsrYPjqZJQ7VUlTDIzVFhg/xY8G9on7NxPa1hBezbPJw1Lbx7CFmMyt1ReneRyqAV0L0IUqjHBbxXApC9UbX47O5artlUZyvzwyQdDknTh/L0v7VA/wdCxerT3cJ3B+emFP+2oAKAWm+zA0vKChj+lkTMIQHLEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44da0be-c644-4a7d-bd45-08ddc90a3cc3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 10:26:36.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y86H1HiAlm73xbAYYqNdywupIBvptAFnH6x2kytGj/rTeMR31q27eITK7KWNTXDkkM6azqTyR9Wmk07hmK1Few==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=847 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220086
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687f675f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=_-9namBDacnue4ljQ4YA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: Wg6bpu_68evqVfvmsPwDen_cGrUHGMoN
X-Proofpoint-GUID: Wg6bpu_68evqVfvmsPwDen_cGrUHGMoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4NyBTYWx0ZWRfXzjB7e3ERM1Xj
 D5YPdjA4rkpQyjcHkdZ6vg7saJt5v1SE/uZKLk2dAa3M/j6yCQOUq49mB/bUY1Hld7TuYMv+JQq
 hEM+vRWPUsoeXJ88nj5uh8M1XOX835ylDjD/Ee3pvNtDgbMzwHZD87rAqUtZpZgZGKKeR02nZaB
 OL8jPGjtgERtCd72Q4q1IpC5fvobiPCrbMtnUNngyJNxSIfVS/8n5LLnW2GpyBB6V7cZuNzFuQP
 GKuOgviOgFREgfBArHh++8ZONb3f65jRy7qaDiDdo+G3/UYd6ve0h0yKGOEpYm9NS9wBqjglSBV
 FKy4zpI7Euq2nJgYw1A7GpnoPHfyioAbdRAQ7gD0ywrID6rFbrpjUr9dPIU7LroDtdgAEw+XCVr
 upUm2I1vUPNjooTozo34poe6r47g/BVWsgRH10M0CSaM1/V0rqwGCWba19ZcUEO8m1xdjKWF

This series contains a couple of changes to make request queue limits
checks more robust.

I made the change to enforce a power-of-2 pbs as RFC as I am not sure
what setups this can break.

John Garry (2):
  block: avoid possible overflow for chunk_sectors check in
    blk_stack_limits()
  block: Enforce power-of-2 physical block size

 block/blk-settings.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.5

