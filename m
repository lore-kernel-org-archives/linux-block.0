Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6462D6E68;
	Thu,  8 Jan 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908246; cv=fail; b=r7k6IEUoY1By0M6ct27YAfmvz6H8xi9Hq3JKqF4pixLA9LYLBBOGj7JrHgp4gghNezw40IhfR3iQ8cfZqlRClfHAIbCm95A8x/LzygiTMzX2pPDx/b+2lacZTkdAcNjvoscAJSsCa17t0J2y2a/lrzApfMwtgZIU+zAXZkPhNcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908246; c=relaxed/simple;
	bh=781qOR8B03Z3CRStKkdzmuGZDjN6UbjzpUeicBynUqA=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EBJ4R7PmY0rsZG2Rah88ZV1da1jD5vd8Zf/CySfSvEKU+FlHDBae3E6pgeH9aicEAxQhoqc5yweBNW3XcgKZ/Kou6ckxW/CDiwkQYngU3AC8GHmlJdbRVimaOLLysc2piyn99dM9eCxO51oAvAT5JpSvo5enN83hCYxEiFCsk+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzqoojZ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qu2sQRux; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzqoojZ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qu2sQRux"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608LDQXu1451048;
	Thu, 8 Jan 2026 21:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zMtATtiqrO1PSj0hiN
	r+VHsWalAR06q6v5ZnGk+hvRs=; b=HzqoojZ1vbJrjWjiiX8OOpXR60ysLCt1D/
	1xiVFl54GcnHHVuJR1Vxl1nKDNvHUR3G+uwEl8mZ3URG3G4fVxpygBDJyx+pHa3K
	/sQXQsV5Afn2p8DhbCXBPJOc9rgs3TcytW2BrMlBKJdhTI4qd8GRq3k+eOjYixq1
	XyPoGbOoFaWwGWZj3m0tb3hSzmhF4pcGxblYGS30cTVJqdmiex/991+c3DnoLPJ7
	Z8nLmAwlXuZrYs3B8iLJVJBZZJOxMLCHeorrsLCIaa7QeehC5ixLn6laHVLCfeBx
	X+UBlBZPF9Kxp/AuZstaaWWvymgYKrdqvX1dpbjMV0EZiTbaWcoA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjmad01kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 21:37:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608La80V020359;
	Thu, 8 Jan 2026 21:37:16 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjnmb3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 21:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM1EbbiYWBYVb7LdI2WpB40cSj4sEVGd3NvkVwbPGwIx4XzcPufrB/U3tpiF0ZWQE5h8w1b7i3LDX0+QadkK0c3HuTSvbWPpCcuJLdZgi15tJoeggZdBB7e+iAxeBrXl4VCt8lqKPowwPnTT+Qwb3F05OgA074rT+qxfk0OiXcNg5eBRIG6Er3DccHcBG0uN9RTxrxDQukXQr7gMvonpfX/sNlWCTewc0xWCibQOrnC1ng7xuuRzquIYJJ3lr6+j5fLCqR9JlEdc+V+NW6IJs9LS9e6cvcTesy/8kkQfmhKOtfDMpUKftfdvH74PtYkR0elOn+8YEmljaZ2sceGN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMtATtiqrO1PSj0hiNr+VHsWalAR06q6v5ZnGk+hvRs=;
 b=D132j+gFavmtHHvX9F8jHFaxOh9Vku4YCW1cuDW/esEIypnn3tdD2EilHcK/lKmXitmJKJqZK9Fl17Yz3KxqjJ/D6omVjk1IpwVNj9dFSl274e8pk0EQmC2LEEZsnqwPSXPhZbzMbYCI7C90CF5ZO3wSeJukHosibTboNKQmNxknXyjTGyZeE27cBPAX+SX6yoB2H3ctIY1sZSJ8xJeyxClSlhGO8CxS5kcSUiXVkBHBu+/EddKcpY9/+WO6YO3QuE0Ef6B4HzuoIMNGvD7u8XSBKO6zXCYezhG2wjYLnYCLN8Q/U5Q+hWH+WnT2ttP3xJ0LT5JSqoW8gpq+MYu+/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMtATtiqrO1PSj0hiNr+VHsWalAR06q6v5ZnGk+hvRs=;
 b=Qu2sQRuxkN9DlWzKhZ5j7Xig9n9fm2ha6LslkFo2R4ewEUeO/QjVQs3L9CtXF4fHEwvwLCITfOY8X132mTSDl7hZNHz5Pgi1A28nvqA6CWsW0bjTxFenpTXlSy8Tzwu99nnCVG37NIYAm64wjBLfp3ngbGHf122HQyhzjBFke/E=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA3PR10MB8188.namprd10.prod.outlook.com (2603:10b6:208:502::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 21:37:13 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 21:37:13 +0000
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity buffer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260108172212.1402119-1-csander@purestorage.com> (Caleb Sander
	Mateos's message of "Thu, 8 Jan 2026 10:22:09 -0700")
Organization: Oracle Corporation
Message-ID: <yq11pjzrdlg.fsf@ca-mkp.ca.oracle.com>
References: <20260108172212.1402119-1-csander@purestorage.com>
Date: Thu, 08 Jan 2026 16:37:11 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA3PR10MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fd75d5-6096-4315-1a0b-08de4efe160d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tsmb3jEIpGV8xf7Yq8GNot65Tl3QNrqKmW8FaRDgHemSlKM4BPKvo74yEoae?=
 =?us-ascii?Q?nON7eD/6wRQiax5+6a2+uepfiOjXpo9WezHF7cIyoPoz6l3e36J4r6jAoS5h?=
 =?us-ascii?Q?MUMuBfiavPeolBjXPMjY7ST0wooTmpQMrFrkYQUEu4Scp3Rovff6LHei1Mfh?=
 =?us-ascii?Q?NMOS33HJMqyR5k8GQPVDgcLhTn3SjSuOP8pxiKQ9sPIoHAAwWAhN3k9QfdFp?=
 =?us-ascii?Q?ZaB44W8XohiXVPZJGptpBzNAqBOM4t12PYZzfTuHCu+gsVFsT7WA82Im2tX6?=
 =?us-ascii?Q?kVx/FaXHIeWiXo9fvW7dIVplpuFKfbNxvjoLKfzjiYO+OrLIJTdz/FzNjxOO?=
 =?us-ascii?Q?MKQmSqTjIfI/he+Ep5RIWKBdOhdJjG5A8ufQ/bLj3Yrj/I88X0cp/KBLt5Rv?=
 =?us-ascii?Q?+9B7Wa34UvaK/MCT55x9lMfowlefXxIKEzRZNbcYALGla1VTWMIwGsgo1Ou0?=
 =?us-ascii?Q?E8AXXZlzRhdbO6ZgU+WwHDxLklqHDmBisBcQr7oBQT8s2b/juYU0sJoEFFou?=
 =?us-ascii?Q?SewZg0FSCBjPxfN1wfE11dSchkN0zwx4MtStKoven68oLUtDosq7LW4bodW0?=
 =?us-ascii?Q?ZWr44BhE/5Mo+4dY26tx7K5qbAgnZrfXb8qb0eMjMEzC/rx9jCrSPq3bVODl?=
 =?us-ascii?Q?ALb1mUeZrpTDG+kKntLQQX7cRPGh8S0cuK5VQOH044k6ngt4x5T0r5aD5Eyw?=
 =?us-ascii?Q?pbecAgSaFZGVbu9bl9fhFVN9o67GPssa8f7s1PDdkHEVi67bu2G70n9agh4q?=
 =?us-ascii?Q?ypdMaZ7Et6alRyiyQTJWbuG1teiGSAxU3G//xknVn5Ow4+Sv1gKdadlt6ElD?=
 =?us-ascii?Q?BMYEs65Zs5QVhFnWahOQM/Vc2Z8JKJRm7omdSyp3GegiRO7u0wX8euqKI9I4?=
 =?us-ascii?Q?KFK5p8n7/wCnGXX7YbrVAkHOJUpSYamr8vwxTmy2fSMcOVekcgofVcuTi7vM?=
 =?us-ascii?Q?nqbgBMRsEszMz1Xuv9h27gQ41S1Q0TbTaHmTPHVuc74rQefea5i9sXSUftH1?=
 =?us-ascii?Q?Hb+i8GywJOeHbm19I2Ei+1f56pNSPJe5oPkTGwq6P4aJUZriEEg1aZKAm37i?=
 =?us-ascii?Q?9xwJffKOFWxB5+Vj60PoXpCOzdUsbAXd5GXBintiFhTfxZN6hc16uVep0rm2?=
 =?us-ascii?Q?jRDUDRPpEMJXPylnHtwpL7acxDSY4WS/CfZggWDiNYC74H7gBTo8Q56YXRAA?=
 =?us-ascii?Q?TzEbTkcOQXwQNQXO1Hq3A+i4r/7o4aPZvFGIyfNNn9GQCVQMRGJiuev30gku?=
 =?us-ascii?Q?WU9WkFLm8KtAxWnMTgxm9SXqfQiLUD+krDh6KSnLjArlovuNoAdncsoewGf2?=
 =?us-ascii?Q?JYgoT6jyO4Lfxf4XOvtx3LTYmJAJc6DQvgCpAr4JWMthY01PJEbqHX53CG3J?=
 =?us-ascii?Q?ha7n1XK8vJpJBHrNOyr4Z/Fr2Mv7tpsH6XB8Ep+uLIqqdwWSfzXNIYy0uHDR?=
 =?us-ascii?Q?vLNEkElTPvc+9Syw50dBUtzb9WREhThB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToUaXJNdGnL1SbPBpbIj7bWv5NszD24fxFIz09xRXoLliHzrRliPed4EKLLk?=
 =?us-ascii?Q?CBT/qUn3SsQX0KR1mYXk0bA9YH7JgYJYd93pUpTe/vlz1KfPju5BrPGcL/7m?=
 =?us-ascii?Q?TJFGLOyMqMCTzLrMQ6g9HmsTgGmKXzP/AaunGJ7h5zv3exzvDd0UH9fBA0jL?=
 =?us-ascii?Q?v4Z5+NiuzsivxfnVhvGgjFprAqYOPhhaWdPHRC5l8GUUhjsaqu3C6Bttp9gX?=
 =?us-ascii?Q?V/eADNKaA40BaO2Uxdg9GrNJXma+9G5ZlccWvYD6ViXLAMXj/nhm0fIfUA4S?=
 =?us-ascii?Q?axYCZNt+ulH6bpHdCOk1waEttp2lT4+7JmRV98UmGSk7WI1EhBWLE94sFKBz?=
 =?us-ascii?Q?fgvChAH+LyFssqBlbSGIYBWIx0tCJSzMyzBh0BZuYMnKcvS202o2jUwJqEJ9?=
 =?us-ascii?Q?3hNVRC0oQl8rNCxd//P/crq1uY5e0L/SvilvpNiILB1jsrJdJS2NACR5NM4l?=
 =?us-ascii?Q?GTVAtmnMtNAEi+qS0XgyqrEZBXkXPQ85ombCXoljJ3DiC+KLumV82zNYR4jK?=
 =?us-ascii?Q?nkBxEc1ec9hcru/VDEsUmW2vwW6yWAEC0t3CsGu5nesD06mDhGspPUXRUJQI?=
 =?us-ascii?Q?CEqIaQA5B/X5qmDcela1AR1r1Vul8idswofkd+HpVyOZ0B9eMcPrHBeOt80B?=
 =?us-ascii?Q?JydR4BLEukum/23iMTB4vMu+c4R26tlba6vsjCVIQW8xMyHBU4kobLX4rx0t?=
 =?us-ascii?Q?jWEAvFaFgHKdTtHLbN0I5UQwHmvYph5oopB7IC4mlhf+o56DOQct/1/6x5jp?=
 =?us-ascii?Q?e9GNwFTFms7jkOCcLqUmZD10dt4BV1LyPrJOoWY+XNRe4DsqqkY38SVeksKZ?=
 =?us-ascii?Q?PwECzAN9Qdj5Q/UxdyvTvSG6yljdGUtUubxTbG3ewb4V2a4jsQPe/UjC0kKT?=
 =?us-ascii?Q?B7vrHIUg+fhEl2+JjfWvqgIJjTF12AC7CgTJhXQ3I15Nx6AzRv3ejRAxt/Iu?=
 =?us-ascii?Q?oZC+omOkeVAKrK82FcQ9TY8PMhggCVccvQuI3seMzMSNJ0CgUS0ulfCY4NSh?=
 =?us-ascii?Q?MrsPAPczpXrc8nmqIKSXrjo4Bbc7zW+XE4OIc2ydUgbzzmtf1QzmRwCcijY/?=
 =?us-ascii?Q?QrRjJNvA2vVWDM58eURIXbXBKu2i+KR6/6RlYW5nQ3JDf6R5mvev3d9bL+hR?=
 =?us-ascii?Q?HntaEmf3hAGtapV7+u7QL3ApohTZYFdxyAq9rVumXbPlinNmlOiG+zsz/veG?=
 =?us-ascii?Q?WEv5y593R5GDZNHsiklkFx87QP/l/YUcFlFIndJjmf0oiqQD/W7i1GYqMCDV?=
 =?us-ascii?Q?jBBORWgLMGVwvvGdFM01oJXBERdL7+U6kkJqfwfMnniqNk7/hU6RS86nl7oj?=
 =?us-ascii?Q?KK8NfnmlN4Xewsz9+kM+msurhRyVoy3f2GdRPUmHGbfDk8emmvwi0MwEY8b/?=
 =?us-ascii?Q?eGaEbAe3Zyt7IoGkFxaOv78dJzynhxnVTGhvOmEwvP0izVnqCMpAXx+GB53k?=
 =?us-ascii?Q?iUHwjDTEe66vAps+0+Bah9hJWItD/d3rf8UGxwUuO5h3BMGyGgQ3G2O4xT6n?=
 =?us-ascii?Q?XqBCYc7kYFhhynfc6znZwNgI56Y8gZmB9ERNu3Q7A+ZtZ+V0SJlUXxOib0wg?=
 =?us-ascii?Q?aZuoxldJLGblMmYEmERx0D/4XYwc0qHknb90La3wqWvUDvTKHrca9gbSlbFP?=
 =?us-ascii?Q?nLmn+4NwIy07RVq0b0H5qFZGKwxPVAudAv5rL+ApykmydFYPQfJ5U9SwU+Kj?=
 =?us-ascii?Q?CwkSVtZdbe3kxeRpuLbh3qYR0vUoxD/dKA4MvojcxOMVQNbLOEwxEieFVczo?=
 =?us-ascii?Q?jP9nuis7w1lGMCoctzwdcHDCbzYM7go=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Oa4pbCStvr+/hwrbmVRj8Ev33csvph467CiBR+XOrxcHoZP1BPWCLc+MJ8NxD7Nl8hnG7sBR4AtC0x2LVa7o34p3BlRWn6hbkhNGpCEoTfd1o4XPLMF06d6FuxKiDmLytxFE49Hz1x77r24G3rsYxKE/mrHzfOAD6PKMERJEgmt24zzNAVJCgor6BMV5pQMQwdGUSRNtnOmfgykY9xo/YTc7zoPC7fXvVqGYVnVuik0EeSYluBYSSYtNYoTe5hUDz+dp4YZEa6n2QE/FcivxEU0jUbFm4ivkQAAa/5v1xABz+oyfM6B/2n4UKKSTE26wvoTbjHrne6hyKNkBxSxyxn96kH9c0gsZq85gGrgvklFX3Duj0VBW4wHkiYKeZZzbcYuUsyKRS6T60hBKPyVdd4zs/dEhjKtnbTb03BgtEUPeNMecpjWM3//rxqmeKL9WFg+IfN9N1r89Tc+qO417Sx9Yw5+bWqp5NWxdAshQBraza88J+YrSVWhRhQhNEjtdVeykdwPMF5ZKuDdLKwg++vCvWIvafsZsnutYCsdDqCVf6ii1biPGmOI2OZmf4j4+QzXTGJ21M6UtJg3TuZrGLWsY8Qt2nvZUXNKdq8iNRoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fd75d5-6096-4315-1a0b-08de4efe160d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 21:37:13.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pzxqy11nT9ZCRIH3rOUpkXhuRQEqCq2E7we86sWySl99MV0dIzZ7vZKQF3XBglbo4zf4wQ0Md2wuvHllNOOBYE8AUmUNkK4smKYoR4niSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=954 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080162
X-Authority-Analysis: v=2.4 cv=Cpeys34D c=1 sm=1 tr=0 ts=6960238c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=sY3kdg5T8PVerZSGG2cA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: IWLkNOb_1mIlwX0ooJ8Hn6HAVDRessc2
X-Proofpoint-GUID: IWLkNOb_1mIlwX0ooJ8Hn6HAVDRessc2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE2MyBTYWx0ZWRfX7JovJ/wuYo5k
 Usu8wrTJHbQiNIerl/yiQ2DQaMqw2pV5b4cddA4Qj4EXGZsZOwBy0d28QWjVX+i74lgMhKF4hvy
 O3R87fWsZtx0Qemg8pfKBSRWclP9nWECKjEo+MODCaW+BJS5wTbJZ1wOh1dwobS/7WjbDMAqDjc
 ZfTsl2Ce2G+Efbt5CkFF7o/qWuldDFR+bYj26OtgtWKjbwj0B9IjwWfbaHAJ+JD7g7cLmCd/XB3
 A6W9fFrNaKfhUsXnw3+5jlwgoKJzMsWja/kKA33RS22cKS8O7R/VWlIDYlJCCmgtBUS3hq4C1W1
 EM+Nt7/e5wnIRDzgLb7OGuswO/wznRtjZ3ylqf0dhmo/bPtrm99t8ullXpi4Qdgf7StAI000yTT
 Zoheoru8t2or7LVBCmV1RJ2LyrWT47tPglI25fIQ2KN8dZrPdmP5B7X3XI6RVCaH4E8JXUC1ZZm
 ESmEvl0Wz69ksJz3fDlHup3LX43DBcsQ1psRliOo=


Caleb,

> For block devices capable of storing "opaque" metadata in addition to
> protection information, ensure the opaque bytes are initialized by the
> block layer's auto integrity generation. Otherwise, the contents of
> kernel memory can be leaked via the storage device. Two follow-on
> patches simplify the bio_integrity_prep() code a bit.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
