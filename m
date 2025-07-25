Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F11F9E8
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403123; cv=fail; b=lSnuHKPAdDK4Nopwc3haYa7gvwBkUQFVTw1LVjEETSIwNXJQ6HSdh7zfIzmsi3zxHkZf6u4Hx6yIAUhH6+t093T5WhKh7BwCHjnb32+vqUqgZlk3T4/s8FnIHQeaBqV528gAI0YLYUjOE9Dnvpczvlb73d04XNNz97wzwqtI0AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403123; c=relaxed/simple;
	bh=VfFQ8Zocmq2EVQNwEpfo4jPAapRz3c+dGPqX71B2U8U=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=n3IcAmAiR/3AUTpygnYqWJLTbRwpcG5EdPkT6LT6V2tN+pDG/EqePKgvitFnvUZBQ0nOhy6a8i8e2Y3fPnSsKMBOkZE3P2qDZyBdvuStPTPHmPQOjTvlpho0a4nDAYG/R19PtWTukAjdj+KlvTDH68tlWBFyIBPAjjQaFklhODY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lqc9MxQb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ywDEaJMT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lqc9MxQb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ywDEaJMT"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLoruN008506;
	Fri, 25 Jul 2025 00:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Z/52e5vWh60pQV9l/E
	SNwe6sauH6pPeuh8QerejlRpA=; b=Lqc9MxQbw0EhpiZYF/fCRcm7FArAFQWnZw
	yUbA0B4K01OeyM0n/4GjF5KC9KlCp68w7WjWAg6NE3eeW278AD3qQOIAdMKmMAdc
	reoOfu4L0zd6+dXF6fm/Cdsy1Z9vwEuUmIvUaTidBUFrDTmzgACAU4O8YJxV1Qi2
	+f/xIeEih9ny0DxQdsfJeOvNFTsdhiRgq0BrUhPVH4GpqT2vtS/xst87Oo/1T5VX
	FHBgUv+4eKlcqLd9MTZ91yfi863vr399e3dycJSnqGuRcWUnxpJ09LEmRc94Zy84
	gnC0lT5F1PjDUYdSpuiEO2tK9+TN5Wf96jG3Wcm4+SKKGchZPLVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg49e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 00:25:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ONjOeQ038305;
	Fri, 25 Jul 2025 00:25:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tch6ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 00:25:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE+jeojcgqwjjd5vXIixXgO9gvjXe9Ae6LHgjlBxOV4lph+5f5+RIiyqfJGrImSXsbUvK3tiqUqhLd42LHlELL3xcJl5dPpP6FvORA4C1Ewsd+iRiPMiroTHuZzqIdmFGZKbPdHFVM1Nlzjbqw1U5JT50MNm73Tu/v4B1SpzMXOtRirrxJ5/uooyioVfhcvx3zI5sCAAO4uX10R8I2vHbC88NpTWzOfaLZ8UYkwD+0BKHcKks5QY6ssxmgoalQkSXoSTBTyO9DPuLPzod0UZJV7zxTHls52EQ+t84L9Xy4Nspd9xKJUxzfuMmRzZ/l5ecOpccZicacEnTAce8enQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/52e5vWh60pQV9l/ESNwe6sauH6pPeuh8QerejlRpA=;
 b=uNwed0Bs9fgOcC+wGBa15MTvEvt7OG0rP/PXUYoj8RD/0C5G7/3VOjVE0I4Vftt3OPq1EqHAc+7jGwCJZfJBfI8rZlYe+TUVTv/FxsVRjff/DIfCmcGCW64VAFujvf3SHd+vl7M35TO6h8A7g5JjR/WJnxa5Ik/sqR7BBE4Uny+t2VNk83XPgLbl00rJmMXaUYKc3hoGvjYc1RNh0j0LhcUcIzprBS4A+TclHpUzguP6WE/Qmzk5Z9/TatQRXW8L0/7xAC6+6eR2LLWGetXEAiqz6/6IhZwhmcwSPfdvpWOHwPvecoU8w4ea/DNx/Ysa0h4BqDE9iZnlhxJPCPINQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/52e5vWh60pQV9l/ESNwe6sauH6pPeuh8QerejlRpA=;
 b=ywDEaJMTCsBDzR2OIQMj55oU7cSNMD4fOwZm77wNt0HW9+2yYUk2BfNiSyW7TlvEhLrM9irR6pLKeMUD06GGaK8m3Ru+DAD6cqK4Cr2DBozGX3vV7LAVZCQWM2lB9mQj9i6EGjEbz4Uj3VrDgne2yeiT5rKFLy0h8Lxwg6HjvGc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA1PR10MB7635.namprd10.prod.outlook.com (2603:10b6:806:379::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 00:25:12 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 00:25:11 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, martin.petersen@oracle.com,
        hch@lst.de
Subject: Re: [PATCH 0/2] block: make some queue limits checks more robust
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250722102620.3208878-1-john.g.garry@oracle.com> (John Garry's
	message of "Tue, 22 Jul 2025 10:26:18 +0000")
Organization: Oracle Corporation
Message-ID: <yq1ldodt8vp.fsf@ca-mkp.ca.oracle.com>
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
Date: Thu, 24 Jul 2025 20:25:09 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:510:323::27) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: d01a4f66-4f58-44d2-8652-08ddcb11b7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGuqrK3hS3qoJt/QPMpolzJTbW2p2FWqO+QnrcVw56qG7jruiryJZg0jnA3k?=
 =?us-ascii?Q?4ny0vDIw5Np/YGaG+CsUJHWLmUA3zp/zM0AcxncNlqRKhIYJbXcjy8du6jA9?=
 =?us-ascii?Q?pxzM6XUY3f/T8ZfnaLj+KjmfSAzSuLxYjhhj28BLU7MFjtf03N0rrwV5WV0p?=
 =?us-ascii?Q?qJEnAM7eFSraF1KQqnXlEVSKku7zRR5/6Kg2LTlYxEZKTZY5uzFftDhgqE7n?=
 =?us-ascii?Q?aOTshStgxAcuOiQeidT1ocNwB/kg9OAZfVtBsCSFo/K0R7H1KPcThmfVgInB?=
 =?us-ascii?Q?PY2tLzHKw3MogbUiN/OqdGSsFIOIfH0qoygru7ILSIvG4pIRuNqRY5eMwV40?=
 =?us-ascii?Q?xCqN1m5w3oE9XvPfEAF/gA62xLLlMtuVFx2NeimDQNj4XNQi3LQP/Kyay6Ir?=
 =?us-ascii?Q?4tsFQy2QX3two4CbyGdRuRZ2M93FeiGyVBYBATvNXIynw2mIHaxV6Pb40vfn?=
 =?us-ascii?Q?2sdXmbRpMfgwX5hhr8PxAUIkT3gdhy28ijRln+GwrLfsAFXlmxgmhgbcRIAt?=
 =?us-ascii?Q?gu4xdS60P+Br0ArWH81XMGCwXBUurfZnN/Zo26Vcx5vJ5K16ijbXqoACthz1?=
 =?us-ascii?Q?yjKPMMMDPApQoKiaBAxkGLohUpmC/GBiYedBRenqGTn7xQu1EfKoRkMIJciF?=
 =?us-ascii?Q?IvJu6jKpV9eZjileV9ZlHCszxmPmzpzSxL1TbQGPDuyziT+PADiHW3UcoPoG?=
 =?us-ascii?Q?ZRVZZoogEJl5lkOC161o4ng8MzURnGZ7fRtZJbq8IK2/qJrcgL/SsCjMsqqM?=
 =?us-ascii?Q?4wJPq9E9OKvP/PQWaBoUdkqevh1oYRVO9wQO/N/MEederpYplcb3ftBYAWA0?=
 =?us-ascii?Q?yiJ+5/3F37dJ0LA7Mnko/2N1CoXL96t1F3WdLvUXQyM3xSiy+O/10e/4CkcQ?=
 =?us-ascii?Q?h2MZU0faVuK6kBCbhLYA0yRoK9UbVpG9NCs+qr4EAxa4ocnAYevCWQLzD3RB?=
 =?us-ascii?Q?ZQIORJ8bSHGzhJJh0dHtBziM9dqICmLtJqrzdcPgGFnAobWnVXxFkTSFTBrT?=
 =?us-ascii?Q?9apQNVsi+5tWq0COSWco+skdTHDnXKzabC0K9MhYp2fe9uuNzjD4qMh4DRQX?=
 =?us-ascii?Q?u9+UPJiStqnuN6zFUIO5w9AD1zRHqKApseE7XBp55cKX4apI+0TGbla7zRhc?=
 =?us-ascii?Q?WFucROLlSzs3ds635upVQ0kX+SvUq8LKtPDPRsrAk4CX8fLauW17OAsy6K8b?=
 =?us-ascii?Q?vrPwqJWBWj0He3WW5B+XcLIBdMxAbIU+iGbL9SoXVZcX3NRUQsbyiootaA4N?=
 =?us-ascii?Q?iA0RH/tr0V7tRbSA17WF+dcE3j/zikE/Elg2smLRDJ6SzJlj4dtBtHZ0Yomv?=
 =?us-ascii?Q?XEQYUp7fHSwxr/c6Vlzz6ZTtdgvagmR6lmE+r77cDlJgK5O67GwxjtgEEXyc?=
 =?us-ascii?Q?MIUGWyr6+E/7Vxkdiy4Ss2RCzCec+6uH81BadS8tdrIRfjQOmORmy9uXhfxv?=
 =?us-ascii?Q?B/PeoEQ9wEE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oG7oMxdKQ2sEZb55TSDAJAVy28XAvNyb0K/f0bDVPA00mbZXgtIS1RUWmHNP?=
 =?us-ascii?Q?mlTyXjNVyNrIoTFJha2jEzHmrvOTMrC3b1/Bv9QLHS3DvU4g4Jx3l68Xz+3T?=
 =?us-ascii?Q?7eofkMs6H2hxEaGlHpppGIYHQ53WBisyOVbppLCzxTd5rXrqIrHwLvrkSR3x?=
 =?us-ascii?Q?fVooQJIHWgZ0LTPa+pYEeLL/pEdQ1TZvvvdWfc5PTmHj7RmgD5nleh51dDfn?=
 =?us-ascii?Q?O0pCT2yGaKUrv8cBLFOx/CmMicqBQlBhSKQhguHPSlIJ0bR9Y2bgd/l/ieK5?=
 =?us-ascii?Q?pO1b9xQP/Ad/A7xOSVJl8h2AjILK4JzF6jy+8TWEoX5kxOLYrv3ocNUkUfRn?=
 =?us-ascii?Q?wU1oEzqHMm6Znt19r0egn7j04B20+FBYpXlK9n01+1fnqIZoIofFEvWseVsF?=
 =?us-ascii?Q?lQxj+DtWjhvM8jS90qIF37P0yjQb/AKzpXwcigt1L3asGC3ydwSevTFWcVLK?=
 =?us-ascii?Q?Gsv+m36UoqSo5STa17ieNtvEp9OwIPXwQfvXvdlpxugryi7bUo0uuSOycmes?=
 =?us-ascii?Q?Qk7X8TOCQOXAp4B/QJpmp8C40RuT1xQVXduOYCPw8TdkFTOVdcPUMX4AzFVe?=
 =?us-ascii?Q?AymVHbJlHBLg1G1dyi1ze77ENIG8nvEpP8nwab3ZMpgrUyXkv85e4mxsLvGu?=
 =?us-ascii?Q?NN5puxMd6UPDpxrNsP3pYIv4Z4Njo3t38WA53rTwFAYzd8AhXW8LBC5lz4B2?=
 =?us-ascii?Q?P5Lc8+9nBbfiYMNXF5+u41UbzIAmbn4Oon2mJBD/BQ15rSWWI8FyxtGPh3T8?=
 =?us-ascii?Q?nNGZbpGqGpBkqcrrvrYGBQvZX4+pqWUboMZFvL3jMhsV/1VqMuoonzTkhZvR?=
 =?us-ascii?Q?Xb1sIq67ZLKdMAu2trslUPsFb+MzLXEuY8JqlMqy++EewT7EHU7MUOGZIZJl?=
 =?us-ascii?Q?RhSrW0rGAHRpKdmIZe5O3LHl91miG93liSwNOSaAbPVkF38yvq0gEzpTUVB5?=
 =?us-ascii?Q?GfbHKeoxseqrt1AGQwXwPTD4YD6xJ9uBixw7+FY7TtK7/6TZ4TYFRyXm9RO2?=
 =?us-ascii?Q?kiyn3m3kcSDmGN32otAJITofCjkAwPlXYirL2o1vMJBm5NtHRABvFd0kYEXt?=
 =?us-ascii?Q?P6eE8JdmZkdwNhc5Q0vXJGZ4cVbWKWi+MlJKRnG0/yywi5mqa4uwzqLQvquQ?=
 =?us-ascii?Q?qLesdFciPzAWzpOGt/sq/LyUmGL6iu+8tZjKj0VLBvY9LQHON4tDDCbbvM4/?=
 =?us-ascii?Q?DiXNzez4maAEwJTKcl/gjP6PFBBmVupriBIE5sH7L2L21NhAM2FX6kTEFL1P?=
 =?us-ascii?Q?uFZRPqvi/BERvybkFtgPL0K/VqYjJB42PGHOFk0VlZ7f9W5T81w58Gbrqydd?=
 =?us-ascii?Q?B76lob2AKMfG6hnMQdILNlfy1q5jXI1mR+tb9hB2RBQMFzmTYzm+iafj+WLe?=
 =?us-ascii?Q?KrIJ516CDkh9xt4WiaBQI4R06jEj06HXJdaA1SluIGdBdCBNbxNLFJTJ+QVH?=
 =?us-ascii?Q?ZHi7qI0PyE0s87BhrcHhrvFy/ejjyILYLPRqCQyXIG0S20a0f/p9la3TJKIv?=
 =?us-ascii?Q?PZcVaEGIL6sggqL+vOrrzyU4lMhKz71coaV+wLwRo8T8F82yZikagXxxSPA3?=
 =?us-ascii?Q?ANgfAJKQ81s5AB19Bp+FolE8NnPbiEzUKKlRtBKxgFSyn4o/M0Lk2tpsI7KX?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xXLn/RXMuBPtB6gBxy6uMGJ94vz/OAEfkYJeFgXm5aY93NdpNWB2ZG/rqtPoXlDaW1GblwiZ4fFQrrphzpKOwqYt1jkxHsec63w0MiUCZjVYGle2C+talip9/fwpvWcLNIcgL2bIXY5AUsxNavSpkcewTuvkaiUaw5N8xkVuayp6JMz+9QGM+JBZjd4TfQ4lvjrEpeJOWsaUQBg4fNPaquTlEGEi0uGlGwJ1dqXlPY2/h9wM9MEHrZ42We4owzIkq39fmgvP25vluSxApY9PBxyVEZAyBZob9zyfwVXJ7gLDOmAhzC3TX09gvWnKErUSMrUQ9rwC2CB3pt2JZp+4r3q8zf+Op9NN9Ag20Xrkg0E6+PuQKhLkEuPFia405Q5elewEEvMMukoP352+m5aU6QdKIBaIyzzbOFR6PAkxu6gMDHHdwPo7H2UKHTNnD5F7rIxQlVd0q5Z4FhorQ4h+L3lJIObyQv0cg42CwcAGsJ3JV4b/NamvcLri5E/uO46ikcfbwIn7Hk31Ql/bvi0Ia1hj4dl9K69MqyIIXp4x6WHYZEr3JPlcGMucvprx6xHi9hUIM/Q/wnLhK1vGqOTxNcS06iVByKfIKjfB28qFoA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01a4f66-4f58-44d2-8652-08ddcb11b7bc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 00:25:11.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxITb024TyvA2mk7N/uBjRLY6UCaGzmVcNCWjGMis0FujNTapWA1ou+caakqGW8Zvk8hVYeQPMtkgl5zmYFdwTJ4CnKxo/nhcH7ZEWoMdSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=897
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250001
X-Proofpoint-ORIG-GUID: HXOaTlE2e_uGwVUV7b3u5Rr9CuFa4b36
X-Proofpoint-GUID: HXOaTlE2e_uGwVUV7b3u5Rr9CuFa4b36
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwMiBTYWx0ZWRfX3013pIn3g/rx
 FXUtYRVQtd8JpdjtXXL0AoV8XV+yjNPibrh8lhUHKP/XOnpEC7UU1NB3KkZex4y51nZeJsazyMX
 +QE9NkeDHk3yiZM4inm6pS78ZXmjn6J1dxKIw4yU7pDNidURuW+GvJ+PEHZW5/3R0Wymiof/FK6
 wsLEMXKZ+MQsENs5r0d9hciM8LgkIJuY5Bjp6pRyJCIcTqFb1BvPZuME5ePQ99gkH0jBqqsDvzP
 tw/jXhFuxBpSqptRVM0H9JriI9Xc9zY94H1JKkCUAXBSLXH7kx06ozvOAR5bDxO7KWICK5MQR8Z
 +zDxHnf03w2ypiaXPDZTQtXzB1cRtcL4sY5q1S59C5Na0khIdBQQUROuUhk8uVFdI4O4HHr7KCc
 pDlIj8+ah0hRfi+CYvkLa8xIq9AqMDCFTVJoZwKVl/3/86Mxd3+aNL5Do4O9kWkcKUo037SM
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882ceec b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=jsXdlD4hHDSZ-kOWPDYA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12062


John,

> This series contains a couple of changes to make request queue limits
> checks more robust.

This is OK with me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
