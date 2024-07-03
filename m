Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D7C8C0
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973113; cv=fail; b=GFo8bpRk5fqglMHqZQWrn38uVQXVMN0G7b1oNi2lGEC7eE9m4V0S6ZR+ZRVsspLt0Hq8wx5BuY9XDak2WRY8bvyWYFJr1n1t0PwUmsQThyW1HtMNrA7L5sb/X8rTif2ycb6gWvQ7FqqAZRfopNAnduIqWh0oqpyDiyYYc7RNvVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973113; c=relaxed/simple;
	bh=lZMi07CTZ/92csh/d7oZ3oXBN4WW9rGLRsIUKctbHCc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=UWJr53QG0tjvtApnK+ypHoAKt2Lr0MzhR9McWYWRek+8Z5Kt7F057VCd8dkkyNhmeT0nlycvq8PBLR6fjlwVCEyEUVoO5Rm+u7ZlEkPZ9VWqvJKQ62zZFBq0CwB0ZamUVG5iJBP0oI8wZRCKlCHUDieOKthhL3PJjuYyZT2Q6Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebyCT1xC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rfPzCV77; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebyCT1xC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rfPzCV77"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4631MtRr013255;
	Wed, 3 Jul 2024 02:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=E+KKf7Fj6InAs0
	umnWyOGJRotDdp+Cz1wStU409R8mk=; b=ebyCT1xCmGfaWKPUpmGBcijD8EHYXf
	RFVi45wrjblWHI57tgwhmbUw+LfWCRgDWX5S6JOje9ATFDsTcMoQjSwtyxVOa+8K
	aE45CYusweB3CxptSoscwp2LDesnPb/qsdag+KBnCA3o0FJaWM3/EsQj4zZ6J0jf
	xLD/IxHRcBXmMyFUbUpCj0Oeoxjud02Js9U9D5le7z3Ou9A6mbhXihaQm0XLqPXT
	onP8ZXaqUHzGmJzjn6Kc/7qW/cLjZ5GW/fYy6X83SokGX0EDE9ROIVyYjzN6kxWP
	kFLIj+5xKLELbcASTl+TKbmBElueaHUqcjFF2kJ4cvduAQWyFtZhtiXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296ay723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 02:18:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4630PbXq024632;
	Wed, 3 Jul 2024 02:18:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q8ve77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 02:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI6b8hZMvHPM9g+KrXR3I5UCuGK+XKVU7WuXpSwAv5VVu9wbH6mo5fcN/hvGKUV+6keysvncfhFcB7tDJvqwCppjKXnbLUYCc+u6U1tMLCzHaQqgzlomohxvrxPlGuZ44fHYr0jaq7XUIyFMg0UwjcEnDw33QXh74qYIyZhqMyVL4o12MYc99V87yvb3AlZDwqB6zUaxrutMXUZbO0AzzgiXSB249PPuCv0iVNLgEAVa6m8d+rLWvF/Dm+rEKu7RWuwQuhIGwIV1w3BapY0ECBiltQ5SYpAA8TDhiy2HiWVTxX7Wl+tIQZo1zulC+aefEfB9skljRcXcHlkjp03weQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+KKf7Fj6InAs0umnWyOGJRotDdp+Cz1wStU409R8mk=;
 b=f/SElR7CzZtu6u8tD6D77kyGvtGm8gIAlhM1TpaNMMtLFUJIuUzUZLyQcMoaXD/dLdu6kmPL7okmid3QU2acT9r2f8cGyqjPhOdnwIJ1cL6despXuAd0eYnKxE5dX+0FxLeS1TuQePZXtKYK2EPCrkLnEc6yvLM1TVkIK1TjYrs+A0iBVCZLs8VkvD+QTVDQ7oT5tnkPZzkJwQBvXSqmCvcDsYeQXmZB78gUDnQxAUbr5BL/EF8pW73WXfdyH3H4wYZEh1l+AC+3SjTxXkufIpxGGBrvC+jBvu/WNbVy0MIwUys4Y7TWyXEU5XGb9V0PWhWvcJx2sdBM/zY/pUUu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+KKf7Fj6InAs0umnWyOGJRotDdp+Cz1wStU409R8mk=;
 b=rfPzCV77/LsZE5rwlHwj/OHd6qRkI9n4ZClAaCikTFrkTHbaAYC4yhB+8j1nHhhmjuFXNEqiqoAc8VooBK0ouAj+rMH0pg9n5qU77oZ+IcljY6xLn4vQFkn1meBrqQLY7BZUeWrhBNgR1ERaAp/XZbL3EkQTmm4k+Bt92gQkWhA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7302.namprd10.prod.outlook.com (2603:10b6:208:407::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 02:18:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 02:18:09 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Kanchan
 Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
Subject: Re: more integrity cleanups v3
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240702151047.1746127-1-hch@lst.de> (Christoph Hellwig's
	message of "Tue, 2 Jul 2024 17:10:18 +0200")
Organization: Oracle Corporation
Message-ID: <yq1ed8bcj81.fsf@ca-mkp.ca.oracle.com>
References: <20240702151047.1746127-1-hch@lst.de>
Date: Tue, 02 Jul 2024 22:18:05 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: cc209384-c8e5-4b53-55cc-08dc9b0661a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7vj5N0FJfZPMYFvUwQSPolUPrdq+e+yTufu5adAPbWCEwXh8UKvAJHboKAG2?=
 =?us-ascii?Q?px31CI16q8s825Ptaa32mynOwJF8nw/xglG4xGfWcuZTrxVo4rmOAVKRJmut?=
 =?us-ascii?Q?xqLIGEHNyQs4+IWlf0NOUCm+vF9njDP5vDx2CfyD41NfThlbxeu38IcdD1Bd?=
 =?us-ascii?Q?RZi2tH2ULjqa5Fg2gQgl7sg3GrnRM+S7E20Zx9tM6Fm+G0JjSJXN/xF+vlV2?=
 =?us-ascii?Q?AT9FcI8h3Fj5FFCKHk7OwqqvpT7JVQOiT3cfeInARCGlphxGyoPVkfEV47RJ?=
 =?us-ascii?Q?A58nlmoSkYl2ugwMK0y0KswM2R7kHtd8calaJwRAnOfBlS86ba4+d9N5A3Hn?=
 =?us-ascii?Q?EVCcEc5ugvE1Vun1GiVLBNf4qo1wen0Z/OPcw3F2qm7uYmtFHXE1m0+gWM0X?=
 =?us-ascii?Q?xB5I5bcbQgTmrwFH8y8bfaSwf0dgOfp79xMpnKWiVFEHRfhqV6aHb/6ss8VT?=
 =?us-ascii?Q?sRozZw87VtuVwdOnOjEfExC/tyoeu0QHW2Ao5oBCzcJaB9d20JVFaeqNxZYw?=
 =?us-ascii?Q?54xj3PP0ku1b3z28RfufmjKIwi/t8SArNNJ4e+5jDGAJTzR1YFB3us+x94QX?=
 =?us-ascii?Q?x8EzwcwfmuIGaFNd3SPkM5effS/KuZOmIIyogueN/0hwZDZhFNbECjrBRtij?=
 =?us-ascii?Q?g0L/Jp4Ar1ulHsMU/D+NvjilvNCi3MrIixuXw0zFr8L+p2RFEHiKURXt613C?=
 =?us-ascii?Q?Wqyut0V5HGK9v/TRajhC4BcPXnDvkfBJ5YIviaowWa6oMXGpx7Y0ZPChSyfA?=
 =?us-ascii?Q?F1OQQXtKF/abrgFO5jV/E5uvmnm06+6phSlCjPsJVlkTWO5BToEzj4AXuJAX?=
 =?us-ascii?Q?xHdQwU7wECymN5iss3I4+MKVKfj2VsEU0odP4dyw4wVImaLyML9DsLdESq/h?=
 =?us-ascii?Q?P5lvABlE9ZKkhGfbmXZzY5zMs6sa7HbzwSehzHr/x6veqv077m2JDn2l+B3Q?=
 =?us-ascii?Q?+Seemxk8EjphHNQnImD5CiyY0+9P/HMwhBznBtNia9JtOOY5Pis+FY3ZrvdC?=
 =?us-ascii?Q?8DI5/0zYEuqbs1kJJr/64Vnb/6DBPDdrlxr1Lmz0+C6ylSve0/xGH5+93m9B?=
 =?us-ascii?Q?RUwyQ5C+3D7kd1PZc52inqv/tlpGJ52Wsifh7ydJwUKgEHGQV91m3kp1700Q?=
 =?us-ascii?Q?t4fxXA7EJv1U5mdkcTb4yrbdeWBo6oFkuDq5uUQaFucQxa1Mzllgjt/gMd7v?=
 =?us-ascii?Q?ViAOAUpIPTbEpy1vGfmuVtSWoopDm/iYOTvej50qQ2HOdU84YZE+8mouxoYm?=
 =?us-ascii?Q?Ej3EkDdQ02tqcre3TImuDqpykjwMsah5gx9X4Xtg16G1KchXNJyKdBxJGO0p?=
 =?us-ascii?Q?S2VPJGTLXU5i5vRZUL+yhuAlCNRHvbK6Vby9Qv6i4xykTQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uS0SjhcBxz8YJvbr/00sUT6aPb0OgSBdxfcYKDkqQWK/lDaFAJLJU7+hvtLV?=
 =?us-ascii?Q?tc7USAYlU+d9YZl6c8v0sksLOn0FcGUaTMPTsNoDsq63Vyue+G6r15RW6pGJ?=
 =?us-ascii?Q?nu5u6dYUv81YeMHUuzZfeNBWSyvm+mjzooCyiNTMPM+zbKYliswtQu/PoWCM?=
 =?us-ascii?Q?Q+qFzOZjlks1KbdFG4+a/sZep1IMw4xLtuTAqRy6Gb4W8Y0fC+OhQr3inntf?=
 =?us-ascii?Q?iaRjZXC0/Au0nI1/KJai35856OW3jzV3dJxyQWPlcosq+eIs4GA21y5hQN8o?=
 =?us-ascii?Q?ONkVdF98ZVO7qOKY7r2/Snd7WjOsC9zMPzCY1ZeLxCpVfQiQNjKnNBwzAFAf?=
 =?us-ascii?Q?iC2ZgmGLvJQNJyo0Iejpd1sOh3olk++drf4M9j+E9vR6QMHyFfcgRKuu3bXb?=
 =?us-ascii?Q?ch561q3DklI3YuKkAQYN3ncdoobqWSkmCzc17SYXDjlZwmPrvrnDJZVB3vMs?=
 =?us-ascii?Q?+8JirNYjrHcHPU1F+0BfzIlwnvSSR/PxFHU0UIkg0L8JAcFRyxwePLqCeWDP?=
 =?us-ascii?Q?XqHaKtVEQ55za8P+XU4pT8BRLO2rPD3PYjb5PSEt9Npd440zZQI81Yq07M71?=
 =?us-ascii?Q?IIY7gKkfNdaBuFIhy3V0N9wHIoofPRbuuE2QThGYBYqRY724+MsyZjTzYbuG?=
 =?us-ascii?Q?eyLjYrCHVJRZ6QyLCrM7t3Jh1kLhEuyF/t65yMjaomG2rLgBQPDNMEkGmveg?=
 =?us-ascii?Q?k76NH6mN32wycDNBit0ifh2vdnysDfhIC0O/yEuvwIy3FP16uYSlVBfEbx0I?=
 =?us-ascii?Q?8lLGkgbZWdcx/i1EQ50yjIN49fBXACHQilp9RRYrPHYCeTISOCMFNj7aUUim?=
 =?us-ascii?Q?XZi4wOwfE2SrH12xbTBliBvYwXOOAoausLNQaZELyzCkPlw+2Zqz5iuxJbtp?=
 =?us-ascii?Q?nuTMoe0FOBbiJG1vPC7vtGACS3GJ2NYVNNk58yfHAM9CPzii50X3XJfv1W7S?=
 =?us-ascii?Q?zRH6xZoeLbK8prYHcXcgof0GwNtdU+2LUH9HcPBq6Jn/uirxu6udWUANxOOO?=
 =?us-ascii?Q?BmwXxcTsyqOxC1PQY30rbBTFNRbG2hGpW/wg6TuoK05UlAc6jmsQUB9aiQEb?=
 =?us-ascii?Q?sngItijEsQK6rmjHjz2tWJ5Dj3BO02ArNmWE9l2adnNTiwD1tobppWWuL2l8?=
 =?us-ascii?Q?A9VKersQWvcfMQs3BmMauzRTZksifacS4ZQvskQXLIrsgcqr1b2TZG3GivKO?=
 =?us-ascii?Q?g40zLFRYM0GpGVlpuoOxTq011uGhBtxb9gKrVxfLqf+MyNHZz7294zAMwMK9?=
 =?us-ascii?Q?NeXrSVwCuHWnkHqN+zvVkrNt9YpaQofP5XYciz70fGvkyMPPEEkTdrgieSSE?=
 =?us-ascii?Q?ZKo2XVQ8lX/IOcjhoWgBrd9aLSJOFwIrkN5NFeGvFblTecJo33g5cIAa+XA2?=
 =?us-ascii?Q?zP1MLIDGe5JVePGQUrw+po51TyLA/Vacv4OhCMgayxnaKHVJyhx22sP/OXF6?=
 =?us-ascii?Q?BxMiB5io3mV0QcuHM+HkvqPuk5CCNoC/QoXKpcqdYWV4CIWfmwZn8JBUVo7T?=
 =?us-ascii?Q?qpLq7F+lRTPsMQF076kwMziHSN2K2qh1dY6HSNSw2ROUbnIQPzAs58hQHuFH?=
 =?us-ascii?Q?nw824vjXOMwe2ZQPScQsLHU3s2NTmBEhtqGSQ9e/DOFDlOjvkIkRPf7U2O9v?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3O50CTAdENknbZyEtH3Isyw7mwa1subF8DksGUufoIgMmSqCX3H7TyKDYvbDWXO3K+ayutOrQhvfK3rxNK3/m8N7+wGWhNtmXa7QUhVPgGLU8F0DDt5D5S7s0yWWGvWFGVMW7PoHR+YOPPrgrxknfDFmYscxQw6sPtVKkdco4aZTiwxKwSN+4praSt3LN8HZ2iM+xakfxo2m8305PWqBhk1j9RTOUCfhgB7liUtLGTmy4yztX4raAFw1Xj6/0eGX61wwnawVDkHEpTazxqpdx6Gi3e6S9hCLkBJ7UZ7xGo53hauZCLMnznoDha0UbjkCyx0sJEcMb/tnE+dNgtegacbFJCAUip/N/BQc70zVkLECk5v9N2idZ0wzBHW8Wr8ZNFnD2TjAHu6O30OacfmQdHR0o05IILkAI1b4ERJ0zBb5JHa4ecMg/gCO0+ShmfMyMtoEOgiDLTh7gYogHVBQvc2vGbYUKqxkqeX/o8eFrfBp2VeeDl20W3pisPz1Nr/l9P1qTVJp3r2PglCcJ+ppjjFFoY3nDMIyWgk5U4rkKx1AUpG3ABnwDJ3f5X9F+iiS6p24eAhmAQW24z5IdccWu61CGP7cTpoCtW4IadxciUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc209384-c8e5-4b53-55cc-08dc9b0661a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:18:09.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/DbASdH8ER4Xdp1hyq8g975DPnqSu3FuMUPcG+pwYpem7oCAAjmNa/fd6NpBrbaMAGv8EEkOZDBrpE1wqWHWcsoWfHAf81TpREMyWEKCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_18,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=830
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030016
X-Proofpoint-GUID: de7jk_7Gf0swEsCMR7iStcPgqZar6ko5
X-Proofpoint-ORIG-GUID: de7jk_7Gf0swEsCMR7iStcPgqZar6ko5


Christoph,

> this series has more cleanups to the block layer integrity code. It
> splits the bio integrity APIs into their own header as they are only
> used by very few source files, cleans up their stubs a little bit, and
> then in the last patch change when the bio_integrity_payload is freed
> when it is not owned by the block layer. This avoids having to know
> the submitter in the core code and will simplify adding other consuer
> of the API like file systems or the io_uring non-passthrough PI
> support.

Looks good to me and is more in line with how this originally worked.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
