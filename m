Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C0212574
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063769; cv=fail; b=Ql7Gl0dAM5cGchwMaglnpJl9o1/wgf1XIXVP94vmeqJ83FnlNVoHsJ5u0oCsGbRCJFAzuK4scVmnXpvVsjbwr1Er8A5gFOGjY2ArDzrFjUF+AWX+IxX5Fk6/etYrxWbC39PBrC4cHZWWZo9PVOeGtynRGUPZCKYvEeT8W+cMEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063769; c=relaxed/simple;
	bh=wnvUmhWBLCh3nWKlW8Yy3ItwazcY+DlrMSBSjFRSHiI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=kIdCSSlboAZuJHMUvVczlnNObBJP/C57zS1oOiDXo6+zpY0dnxe0lV5fsc2crXKgul620MNsRS1EG41scEAeAeX8IHnQ5QKX2+4imUCm0bc780nx2ucjzl2IUfP3Cs8ncaunDCldpquqJhJJCsqZwG680hckBD2VphULNYzk6t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxckmLMv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zQqD7FxU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxckmLMv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zQqD7FxU"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADE9uuq027981;
	Thu, 13 Nov 2025 19:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wekv/38FdwHEq6OybR
	EFxVaesu5EmHaoL+CVVZcb5L0=; b=SxckmLMvJx0qesdjq873kWCTMyTyDHiKnG
	ZUcZ2Pr+Nn5Vw5wXT1m7WPn0O/ihOxSLKfYAsU8i7m6KDv0iqgBtaxTekNwEhg7t
	1tSc51JwDr1j3W5ImcTSZaCyqaICOvxytWrXuws/ecBnB/xP/wOIo/QGQwt5YEZn
	GmGXfc3l7+El7aZpbtSH+Z65jhjnw37+xJkMDP4KwmphqYF6y0QSSkfFqAQWRrT6
	wCzPcm3/9qCLWBBT04zqsYbBHDMvufun1fQNA31FIoUmqlPABTnsuiOd16bpywVZ
	xzoH0vqp3iZM636YlJ0uta6r2ntZPjx6nw9RcvccPNUAzHstBrCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsamd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 19:56:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADJGcAO010833;
	Thu, 13 Nov 2025 19:55:59 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vapck9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 19:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXSQ0eixT4RQzdM0+Ran11afTh9fLstdK7RSCZMjjf+Ktik02e+lprnC8tZsil7LQDK2zQK58eli6ElqfqeQlJp2vlmNauabWrFKy+hDRTrFrus7PchsB++bnuEA1btr7vidFt+aN/ABw/q3AHhe+245lAksYbJceoLtPhoYGrSKx7YbWbxH77idSdw3IkRCTWSDto0oYQDO5ufeS8f1LiGbKzvmKlSgX4B8Oqq6fgIXpk70/A/r7xmV6pQRUTRmC2NARVxwUSGRiDHwhOCVFGF8kPG8Ec85OIZ3pQ+ORKfvzKp7pStSR7idcLnfh2kqiR8+yZCemmoiXUDU5YVSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wekv/38FdwHEq6OybREFxVaesu5EmHaoL+CVVZcb5L0=;
 b=p18PpWterqitW4LiyWVAZaTT6Zgmmku28m6ivFKpo0VFyRG66Ke6QOZRl7JKsnfvEBrjTt8piO3wLDczthB3QhF68VUlOEPS4EhuNzK4ORgHLVVb3QeCzbC9L7jyApaM55JdgT1Bk2OFak9+IlmiPUSohxeMsdMeC200YGOUVoVYNxqnIEu4gCoLq47QmDTejzIa8t8jY0Gb5ABlsMRDsnCJTfSSiZJX7sGTNLSJWC60umz+BE05wBAzbDPaUHtLcaIR9JwqGB0bqnGggQZkFLbche7D/qjKtBCauKu/bsKX4Px4fPYwYxH7edEuofLHE4CqlPXHxDpp4/FjsaGDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wekv/38FdwHEq6OybREFxVaesu5EmHaoL+CVVZcb5L0=;
 b=zQqD7FxU8EdSIRboxQk2pk35IfKIH+nbW6AJ/BOimHbuUjrlFCBb6bb0xwEw5sr5HnRa+XV9SZGzlTP+slh3+pwJxB70SrJ0EqhFZzTshKVgGk/ajk9+CfTN06TzpVmgdNFrj99ILV4QsIUoVmVvL2p5gniXoBNL91O8aH2+NcU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 13 Nov
 2025 19:55:57 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 19:55:57 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aRY2G6xEgEVqLBgb@kbusch-mbp> (Keith Busch's message of "Thu, 13
	Nov 2025 14:48:43 -0500")
Organization: Oracle Corporation
Message-ID: <yq1pl9ld7y1.fsf@ca-mkp.ca.oracle.com>
References: <20251113152621.2183637-1-kbusch@meta.com>
	<20251113173135.GD1792@sol> <aRYf9S-UuJqa37fi@kbusch-mbp>
	<20251113192022.GA3971299@google.com> <aRY2G6xEgEVqLBgb@kbusch-mbp>
Date: Thu, 13 Nov 2025 14:55:55 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: fda437ec-5d2c-481b-a019-08de22eea95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSM0vu+5apQIz5ymNZT1NjcEZJrfU0Fp6KVKgWEu1Q0Hra0GUFztmQZJlg3h?=
 =?us-ascii?Q?3iyqnTA21MgRuRkb7sPruBlcPHXbmqH58hIcT37k/W6vasedp18BYvymoGSs?=
 =?us-ascii?Q?ZHeUYLaHaWhHQySiy+1I8JRAbLV6kwzHVzzEsFBEnZ5WU/UaO+9CPRMmcVQC?=
 =?us-ascii?Q?td39FBnJnULAYaFe7gYe8u6iqTZ1g5A/Ax1q4X9h4Q8FGf39QE2qKquiJXHm?=
 =?us-ascii?Q?rOQuy9kew7821hMaovZkCDI0Ro1BRBOo2GBQVJJfYwyWobOehv+LVJ/hjcWk?=
 =?us-ascii?Q?1HiISO6A6aSc/U+6FV85vcgCZdqkK+LZ1G0fg5/eOs2yDmpu0eDo0tRkPYCM?=
 =?us-ascii?Q?Y01Mq566Xo0SIomvHxhY0/BkjemRM6zcXjLAgQ/sw3WLSxSdHi49qWFKEXXF?=
 =?us-ascii?Q?wxRsAQFpBi4GBuaJSvoBLaG0Rk0BB+CRrNXUcx9NsbbMb6Og8w3RW7IMnTbt?=
 =?us-ascii?Q?b8o2I5ecWN3qm9z0iR7H0iJY/vQYEUhB5e87aAzQBfIxVq/+bSDsRFTxlISv?=
 =?us-ascii?Q?Pq+m7h8IymVOJIn00dudlxIoJCO8pZhOiq1H9PZ29OdCwBeZUJ7UueXQLIAV?=
 =?us-ascii?Q?EixLR/pzHL9fRjUAb9F3I+U2hmACcAY7lTQKI0OnbDj7OomG58jPINO23+sZ?=
 =?us-ascii?Q?KY4fTzZ74gOBjbRe7ynTUI3M7SUP5lbKMoeTstyDXmfq/TdM6u4nV5JOCuuZ?=
 =?us-ascii?Q?+0L3Wfr/MOhAY7W2HK2JzO/QoSb3dSz6m6pF2EqSuQMlqAFFgrRxhBoiUOJg?=
 =?us-ascii?Q?F1h57DBY8K8EEeqUxi9OP/mX/w0BnBFqs4oblc+th8jvYdPShhqxupfbrkf6?=
 =?us-ascii?Q?hzw3KYdc6FFDCkyoPmsHT2ka7oRU28rYxjz4tPLPyUVG+3pb5+5AQ8lHYKQM?=
 =?us-ascii?Q?m2Vw8eWUq5QL4zbYLwWELUGzuDu3XOuGgpS1BQjkckObcNV1UsMQV1ypnjb/?=
 =?us-ascii?Q?gtoMbW9yh6i5dAXXuGJHFSK66lbvrZoGR/xowQCFTPqnerdtlnR/DrZ0Bqs9?=
 =?us-ascii?Q?tQw6O1AvOVHkKzkWe9TrZdN7YjyHhysNibwkSOEKAwnvlhcasTq+zNFWS6Og?=
 =?us-ascii?Q?Ze7kD13bT4VV59Xe13E8HrBG8m5gbbdktXwgF+JAYudDJ+6rQiBKgTvTyi4u?=
 =?us-ascii?Q?5W6fTHJYKLT3FSgOyggKmAIE27LIEn1nMXNkVyL+I7aOXjf1vngbwUeXMrA5?=
 =?us-ascii?Q?jUP+fL5uLxB/cMcbqm1+4GakuwUJao8CeMZ6Uk0ciJAXCHURFcf62vJ9upHS?=
 =?us-ascii?Q?iCdddeZToro05Gc4TITpsvuuQLZ7h65+YD0wg4XO6LCzI6nDC1eREdOmrMxM?=
 =?us-ascii?Q?xlPXgRii7n4WLHUYLmrBgBHDejroxEipmo5AaWo2JGJxPWliZjw3JnpUFQ9p?=
 =?us-ascii?Q?kkQGv16Tsw8rNkivcnNSDZmLqM6VKgUYphyEEQ3SyjKco6svMxzMp1QU4BIF?=
 =?us-ascii?Q?/L/T2n+Bj22pVrsE8qpHveMqZDqkSgem?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GryqPTEDQrH51fotbqGapR4NapDnvJ8/e0LRcXOlG4EVKOOqhvwSC03S9oxt?=
 =?us-ascii?Q?3GutTYIAR6Zw2AIFKptKIwH2iWNKVeny6rf0UheI51S8ENB58VItP2BvD9Xt?=
 =?us-ascii?Q?hZ+frLVN80bb+32TxvJL04JfMkavojlP6qHTwKYYrrQWGFI8kEcHTyhNLUFx?=
 =?us-ascii?Q?EjakqoUlcZNuWLTsbo2DjAobdGBBcndg0NYLdL9rUIeGxbPRPmAcQmNC5Z/F?=
 =?us-ascii?Q?kQCSNLf2MHk4vOYyESC7ZZkTuobQ13A1i/vldXafbZ58WlZXHxXacu1GRLNf?=
 =?us-ascii?Q?BrFepplsTttxk2cZdna5OWeIu7nwyhpvn9H+ARLVVwbWrfTxemzgTYEBj1Cb?=
 =?us-ascii?Q?JQKOLCsz9DoIqO1jZqQdUWeOlPbRiNtmA9MS9c7DOmYlB4TipsNzYSSHRdEr?=
 =?us-ascii?Q?xuijrATLQOMC8su+tQ0Je542qxZ49RpkNPJs/RWq04kcRVjjF8X8azAYAxes?=
 =?us-ascii?Q?WdeZmuF705ei0mNYgOSAdRtR4lWy5mAf4DT6q5YCyPcgkioUgzAkl4+NtVCx?=
 =?us-ascii?Q?kHO3OpZebLUA8qqIUZMrWxpUjcSopbW/FFPchW4PGNtYzSlihc/XQQFTzwv+?=
 =?us-ascii?Q?dH8KM6P7y6kyoC8WlEc078RqeSsNSReoifliE/bZr8gsc1zzfAxtpgMB84ef?=
 =?us-ascii?Q?ouwyrR1f8T+TN7eGVui1Laqwe/A8weRr2cNDcujkDVmZDzmx3qYFJcYMscXp?=
 =?us-ascii?Q?tYIguFUNioyOVxkXmrnqPn4M1PiCy2/ygPmlg/yt7ulPIStX84bGlXI6kpRO?=
 =?us-ascii?Q?PMnIEBVwEWh7kbSA9/MY1eymi58TbG1QR48AjHpzgPCUXW6Bsv5qQPi3Ub5c?=
 =?us-ascii?Q?9WH71kj/FbidUL3mCARUpFvkRbySL1tgSoG7ZVJVGgWESSfYQup3xt1UFCOw?=
 =?us-ascii?Q?PXXr5uniSF8jLHdcDdlioX5r9pWU6FJ3gtFrJYTa20+gpRegHZiGXRhIoGEa?=
 =?us-ascii?Q?I5x0AJs8kaeoAOh30Dqm2EeiCdr6mXMCkkQZbLXOqIGxElJJjSsrNsep4DBP?=
 =?us-ascii?Q?Y2EAwNGdYUmKYazAIknxqOlRxcEnONeHYAPsjeVan9S6d3PMJ64jnmHtcm6w?=
 =?us-ascii?Q?B9yUco/RUDsETYpL+kQYQULl81RPvIzOVW+Faxfx+9/LKSXZmWOTP3kV+ER/?=
 =?us-ascii?Q?TfEidbyjUb86VgvAiiJOkp4TIvXYRkFPecqOEiN+CGs+vI0MFAQQVCtICBxL?=
 =?us-ascii?Q?flTg7qNjctIhm3oN5iyjOBPehHqEcLUPTU6wKx/IbFQDg5Om+eZq1hNhr3p5?=
 =?us-ascii?Q?93CuWD+OImxhkWXrYk5X8gPXoBkZfnSONjXSrfgemRwO0loQcTYPOTI0MHFN?=
 =?us-ascii?Q?BO8N4T6M93R6OLSbnqw7AZoSoOphXXEt2fxJiuTtyx9E2zUjSLVr+FKg6j2A?=
 =?us-ascii?Q?zddlAPdjb+l/KtbpBdwR9DKmrMOvgkEnJrE4DxhsUg1NyM4MQr7rfA05B598?=
 =?us-ascii?Q?LcRMtHRFBLIPx9lJhMJ5TyK9Jjbg2tZiysXV+cmFUgX/BmeijzuxQhuyHF3e?=
 =?us-ascii?Q?6evZIJzM48dpcwJjlfHIsxaq88IiYXsgxIZ2/r4IlKI9ZsNsTc2OndVbmvl7?=
 =?us-ascii?Q?KiigeFTjSShk36iK1ieoA+HYrY5ZD9RzFMthunEy8dQj6GlAXLvODjY37PXt?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xjYuhVZHvbQyH4Gl3pmMd6ohoifvbW0hJcXIjdcAXckmXwuJ3lfRKXAXggmGqfv+MwhgmJyYDEGqkqRGNnQneVr4x+V9cl/ZJpGVuEQxwvbdoQt5lzA2fLzDyVRu0e2UT2d3Sa9qjiP1w8ocpdNv17Srv1y28BcXhaoSlbaJa5SB0aeBwhboZ8J8GIHJoQ4xxITogOM/9ISMJaNg5oIEm3GPgAxlrJ1/++f2myln4cW7xJM70YoqnhMHbmSN5hpm3CMtzRMDvHkkTOZt7JOYw7r8ZeGztpm/zV0+FVjXOtrlVaQcTG2tOKrEFzDuqnD5tXtfcxz4DjCkl/JixG9fLAiwQYBDz3KkJEZ/yLRpu9xBXqjBPGOoJIzfRdm3xNJ/+9ZFh+LuoA/ietAM11kn2ypa3MCW/BnGMKbwNf9N/+tQ3AIx27oVvNhH6d/f4lVLVB2I7BTwdpVt7DL4007WelbNiloTuud8bHMGKyUW0dtrFoTAmD1HCaQ/VOx4jQJGTN96GSJQVAVWm/pvmUdiMn0nqGcwXJGJOCWvwHtp7TVG7/Aq++C5w6jj60c1w0sMczIwdu3940UL4TXvq9d5zm7O2ioFzy8+fMA4Lxq27R8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda437ec-5d2c-481b-a019-08de22eea95f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:55:57.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pt6Wfiy3Zww07s/fY3GXi+nsBvDtX9AUIeQMERajXFcpbdn8B5meSxPo0IN7U3ksQbofvawxb+vr+LFuHWIkXlH3UR802ChaQMvSh1iMDZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=675 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130155
X-Proofpoint-GUID: kkTCX1A_6QaObgP7nMrn9oQILzQqDpGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfX0JWZTcVYkQSD
 UyNINmAoTndmshkdAob4Ng0btssoU7CqsPsiX264RCOdFIPRPwCpGaerY1Nm96JXcbph4clqAoQ
 1rKNGGhBt1kMiGxkJfI25Q2ywkfX/DqN7dp/SOLupK/hqsf+o96kZEOTinoYAAeBxSGeJTTbRgB
 yrMms8j/6HcW18lV4k/TB1t8BLiEoUMXBumIe1hBEGGO6tJy6KFgpQI+/GBtPhqtXiGT047a8qf
 2YRErS7XKWvsDO+12TaM8SnyyFY8rXegQ8fdcdBRcUUhuz9po/3k5O/aCpDo6sQGI/igPmT4Bff
 DNwL+LwFXx1aFQbzHQarD+dLpWvRsfiZvOToowUGJg8ODp769eLFBHmPmXQspggazVY64wWO8G5
 NUQEeNa9LB1BmhUjEUVX3JE5QPSCmImGQvb1FvE7awRyovl2sJA=
X-Proofpoint-ORIG-GUID: kkTCX1A_6QaObgP7nMrn9oQILzQqDpGy
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=691637d0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=nbY8NXNN8SLUVCoibqwA:9 cc=ntf
 awl=host:12099


Keith,

> Like on real hardware? I'm a bit at a loss as to how, I've never seen
> anything subscribe to this format, not even in emulation.

# modinfo scsi_debug | grep guard
parm:           guard:protection checksum: 0=crc, 1=ip (def=0) (uint)

-- 
Martin K. Petersen
