Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BE197536
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682918; cv=fail; b=LOCPLaXZYmzt4HYONxeaOAk1ZwcBMqQakHXKwI68YK/TgAaYB8di0lTXoAmNSaXKOxxeM39vuaBoYIO5bDXfSlKjkku3p1nWIYCVjK69GhIJOE4o6RSh0JtsekKXzgHphdhXCmRrM37uuvVeD2BLj46S9CU9KYriRb5HoL/Sqzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682918; c=relaxed/simple;
	bh=mxtBI5NHoKGXMiP0o8RUFT7zFaGyt7BJOI6Gb84T39U=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=E1UWac5IXOZ+gwbPsAbG/NpLgixEu4BCv8gc/ZKnc7ZZh0Uvf9nkqqsES2iN2H9IXlEofaUwVzgU3q5HKlf0PDp09a+nlhdkFgcl27ws88OiixOwAUToigRylvZ8YAA8WTzlrhNo+BKCIr5gYn740lfofWf+Op8Ax2ZygiZx5ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jluXArFC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y+KLxMR+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jluXArFC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y+KLxMR+"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iMjq016280;
	Thu, 6 Jun 2024 14:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=8KLZo4lw4vcf7j5pHla4SMR7VtvHn8QjacaND51k76s=;
 b=jluXArFC7HQ6+3WtONB8TmFA3qS2f/FZNuRImmo56vi4IVmpsAcRZAWPsOrSJuGwPXWj
 6qA024AdpU8TCrK5AFtp/ZJcd5vnxovAteUkqZhq2Ky+rbhjREOtD3mKejFZhw8AMFu6
 /6pYRmDPUnAUtHu2Q9gUL9iG325FotYmP+v8VRewMEn5i1INlodNDSR9R3HavEIfwnHk
 ZrJI1tJta2Psb9UXTIp7UEAiVypQarcYYXcBZCx+d8bEgm6vWAYaPfQutO5dbV6cWoIA
 KNl89TwJTZSYY9/GX/QGqImGAIsfFGNyQ532ynlc0Vo8cOfGPYph4e29i6mpuqypXp2G og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhbm42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 14:08:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456E2N8C023968;
	Thu, 6 Jun 2024 14:08:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr0vhe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 14:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXCyJW9FNLwfPLk1E/hUmKKNWbppET4cbZAp6V+GLcPSMY7/s+3vZX9e81+uFKY6W1Vdkko8ZTRte/2kWTvTjeXIwb6e/8J95yT1QN8EFygZPHum2oRzqkNHHP7nsLbLOftwrkRPRd4ymOJ+RUE3VLIWl1f5tMcoCja2LpjAG1azTQDZOhQ8pHzRDUpyPRLmP6qxlBfrgLl3c0c5CaKE7DXJFe90BmkWcmEQJikABx0TU1xQh3ymT8IobX/niIWgMmpNvmBF16Un1oYCDTg5KKrNbGo32y1PwHecHcvyJUgpE7a+ACjviOpP05mfvLFDG8kIEMmOseUBXPxFt9xpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KLZo4lw4vcf7j5pHla4SMR7VtvHn8QjacaND51k76s=;
 b=GTQsduLDD6QQQLL8nIphaxeV7hiNAsrOhvrNsU3wPuRjWh6yeV+e8IhsOsgsxx7YWumtRNbvUhZtmwc3f6HK7jqUWK6PqDtFN5lSdc3spfUAoEiuP6ENHQgcwx7HreKYtmkICfA/Mcp9n/oSvEANpizxg0/2MnxthG2LF3iFr/U9RxPtayFYfRW73ceOBGGb4czf271Oh+SSzsNCHailu8cwhZkN35v4LkO747uLou+2c/a/lrSrzQOQvo39elMPVYsRFYvR6nXRYbZP/0CXzkg4xCka0SCCEhsQu7ta5J8Lw5kIpO7s8fHi5D6IaBuXhh6bM1PkzbAQcVa7m5VE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KLZo4lw4vcf7j5pHla4SMR7VtvHn8QjacaND51k76s=;
 b=Y+KLxMR+24lO4e8KGCfIc4ROMIgCd416FDKWTb+V2SVRNr+tsT4h+g/7qT17jzIDOD44UOxWN7WnGDJ/w6JS3mHfUvEvXQq/LSIz+Mg8rqSi5fEHKIoVoWfQtVvTEwJM9h8gw3m+k5WZfOZ93UyEQMwr/hiAVc6H+H0UooNcBr8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Thu, 6 Jun
 2024 14:08:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:08:22 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: initialize integrity buffer to zero before
 writing it to media
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240606052754.3462514-1-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 6 Jun 2024 07:27:45 +0200")
Organization: Oracle
Message-ID: <yq1msny6ucc.fsf@ca-mkp.ca.oracle.com>
References: <20240606052754.3462514-1-hch@lst.de>
Date: Thu, 06 Jun 2024 10:08:20 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a41b228-3562-4ba5-a4e2-08dc86321fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ap8TFlrBL2CXRjPkSB+VKgdN/y3yJnlQk+Co4nI8mYkHtO4nWPbYhGwI0htg?=
 =?us-ascii?Q?4gnqV/vhOOE807S+RWDGzXFZwPz2Y1RakKVeBuxVJdNyVJ9zBZCoORF5GQQ+?=
 =?us-ascii?Q?LDaXcjKyg4pMnrFa7oalVGd6O6FcOOyHPky1HVYbuVHiUm9JS/ORR7Nu/v8Z?=
 =?us-ascii?Q?Kq540FMhUTclXzzZNthnAAKL2ciuKkihB1o+OUwhFv0aJCIh+J5xOrDo7XL9?=
 =?us-ascii?Q?F2nnmrBO6cjP5vzGW1H9TnJitLiSuy790nisKck2C3dsKnP+8sa0z+99vtW6?=
 =?us-ascii?Q?Em8buOOQGDspOW0AuNOTBkAo78KYbcUBmdKsmy+k6LyRPahfH7mH68d4jLY9?=
 =?us-ascii?Q?Jqd5tXE+w6dl2IIMATnaAG7LrwU12hs5jCWs89RUH9MjKpEAmG+2hCzND7DF?=
 =?us-ascii?Q?aVk7Okw0BEYjtN7HZmakyZfUKVbdzn7pA75FHqNFSLN0YB+DKHgEsAeFOaGh?=
 =?us-ascii?Q?qUzJ5jv2M1Cn9Aa4qjWiIiQcnlTqmN1gl+PtnHUu4GvM+u7UtxxS6jeVBXli?=
 =?us-ascii?Q?YR0bflAEA6y50Ms1RkpSvkzWUHszbnbDmzLnUgN8PaHPF9wqHW/lxtFleDpH?=
 =?us-ascii?Q?n3CFoesRQRyD+Yj/kWzR6qVrpl4Nx0ESngXaghJ/KCSEkdLwS4y2NoE6D8nL?=
 =?us-ascii?Q?U/oArNqd0wKPohxhvLJGFsecq1cBiOES8mZenZKYb9/MgrGa2H2h/de4+bXA?=
 =?us-ascii?Q?gG/omCOR4f1kYWrA0Iwx0ST3jiPiAaSa4OGoQMWuRoe0oMDNxKjhgz6pfPI4?=
 =?us-ascii?Q?6a20qVZ8M1gGzuZ0YVZg1uoWIqp+mCXWoEPT4p4jYmt9OZq346dRPd35HLU3?=
 =?us-ascii?Q?z7uPMECzwGD3LA2+6pDgzAd3sqE39er2bb/zp2lZWaZn274lYlijYbYniySv?=
 =?us-ascii?Q?AHgUGeYdv/zlB2nLi+jSS5QEBToX2I0oqDhhGG4k8KLhsSnYeZ/p1mUnpjjD?=
 =?us-ascii?Q?PPIVKCxiqVDAAAqM2n3neUac+b5m3Wulom20SZ8Jtid5S2gC0KVTANdn21hk?=
 =?us-ascii?Q?yWwKUtS5V17djoVk5h84fd2ykGgR/Gup6MAWg6lXoJW+RaGfecAJVDf+CLm2?=
 =?us-ascii?Q?ORro8+VXl86gGxTAwuagaJFzSfGnlLk88q+a0FlcW4ffBRZkoadFsoaRzw6T?=
 =?us-ascii?Q?h0x2w2540MCuwhuF+4IEMs+HGIjQh7Ad7UeXZOc7vxhpRjMWFGOZimUOG6Kh?=
 =?us-ascii?Q?A8g2wKZrf8QA6g5lqiI5AtHsptcNWvmEQV8iZJw2E7XAI3kL4GGWDdNa8jAK?=
 =?us-ascii?Q?WZLWCz18lPcHlZfCtvtt0xQ9x5P+xcJA1rgeQ12TiAqVodasPQZ303QdV/W8?=
 =?us-ascii?Q?HWrd2tjmA83RikckG/c3j5UF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TxXQ7VglcEEC3bDQgWiPX4tTyPj1szJF3QGRliNPtGGvSQxTSQlLuAj+FNFq?=
 =?us-ascii?Q?Nbm6rULKT211SSQOwr5fZryAaNfuIeoGbNMlfUlzbjy+MLSK0Evan72/0v3T?=
 =?us-ascii?Q?sMKZHuoIob+Uu5HWRDNgZjYCNS64NtdSSb3NEdJenGOHbACgkl3zvzE+A0RG?=
 =?us-ascii?Q?1oNAEU524oUJn5wB2fci9qLJKKdjBCLtQyA5vpZkjoZx1y5ONcsUchJ+A6Q7?=
 =?us-ascii?Q?6tbZJ4VQrshzKaXlRRKYhXXU45aUrxe+7Xv0epZpC3DTwvH/zX48Em6pFy9G?=
 =?us-ascii?Q?QzGB0w48Epa6fTgHt0F+0iDXL/yQ/DkM6l2I4kLusTG3h45h3vvTxUmNOuyU?=
 =?us-ascii?Q?Hag54LpW8ZMc6rS8CwPTZ10LSfYPoa7Y+wEaQdJE7ahHZ/cfxOFAhv9Mg9cy?=
 =?us-ascii?Q?Epz5OwgTP+qhqHeZ7/05zuGUx+YSL5Kytxrkk+K9dTnW688ynerFPBGpHSXH?=
 =?us-ascii?Q?/xP1ARFgK6WBX1VSNEVHoSD/IO6W6uNEPJCVaokZKR4VNM3QzsaqvQASqjBo?=
 =?us-ascii?Q?drq2ZmRVPl4Owq5vJ1YK+ZjSI2HyPNxXeVbcSci7n0K7joJAqicFA2oLF3JN?=
 =?us-ascii?Q?RHadwYj5d089FFLTsCI8RFA1zY8WXepIFrWKOq8smNcju1L2Fp6NtrjyKPWz?=
 =?us-ascii?Q?E9vmljyY4HXTSlso6vwTxzeBImh1qpJ7xtTUPBhRKJ36sr47Hw7pb88vXBme?=
 =?us-ascii?Q?EspXgFCimMKNdW2k4Od6fbZ3rzn+/W1YCwekRUzPUN9+dndVhySNwH1VGMTw?=
 =?us-ascii?Q?1uhUhoFiGloWwRBO92CgHXShCInAtslcthl0tRNgdk00CdR1mwQOBONy/4TR?=
 =?us-ascii?Q?2N42TGRn+vvsem4dXF+hPYvghbP45DuYgY5stxvqhtkwSkzKaApqlfCchV3H?=
 =?us-ascii?Q?tEevyKXZWVY7HJtRXXlazna0PNnXSdOZeUF50efg86MHNXr6Fs211Eb5QTV3?=
 =?us-ascii?Q?r/9dEYxbzKQbP+EaOY9+wHVqfR+ybVdhr2VJRNZxZhGs54bjukFcWun0qmU/?=
 =?us-ascii?Q?pEJvG6Y60klvB+b0+AL+Ys2LCvDWpifqKy5G9PkSlLc15NFxmy0n0Y+pIc8c?=
 =?us-ascii?Q?VgfJ1n/RmdJ3Zi8Z+6KE8ggMQb6tl34Njz2OjAEv69wLJbydrrhMNfox33ox?=
 =?us-ascii?Q?EkJqnvwxoviICWniH+rgl1hQVWPl2KI00YizE05xn39/A3G8eN2Tnt0m5f6+?=
 =?us-ascii?Q?CqUqO+443JwhPdrIGX1S5SmdbPSFnMOKOAsy53Ipeq3GUBh8HiMzZvVRQDtb?=
 =?us-ascii?Q?o8ZUq0ku3hArU/lYUir+aKNWPRjrzuIXkIr/maYfSXqLWLAD+NFmkVTAyzTz?=
 =?us-ascii?Q?uz6Asu5Yu4kXQUqXh4pckpsmr92EQvmRWxkVGcr2FQhEWLJmR2nOyxI6Y/Cq?=
 =?us-ascii?Q?hzSlu2kWceTkHt1VSRhkSXp6scD+3pF5+qJI4RN4YFSv3cGjeZjobdCDU7n0?=
 =?us-ascii?Q?k1FUCoWtciyc1F0zjlUzEw+dlDxz12+hlECZzq8rLF/6p6qjTuJU9X9hWIEN?=
 =?us-ascii?Q?16DlAmNR/S0Gdm009KOqXJcOSfdZVG7SYqfWhwTdXFW9ws34cwLrHTqU0VF0?=
 =?us-ascii?Q?ew07VEnfhokfL+qvd0oBTt3M24q/U+bkExz85sWJ7PtNKiuU1zyAhqx0P3B0?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JCgggam1taMRzXfPMaQCTw0j2Pt037bwTn0WHEtBmq9cF1VI1w73auxMIP3W2n9jDAS/I8hDLTi1UorDhNjq80Fte4xIj0ICnJj+D7gfTpNHa4KUsK16s7dRc/KjXsr/ueQ4N0U1n31A2/MIZnGZX92CBkFHrXUEjxO5XeZNkhonr0PzGDYxlTFufctwty5YWXPbg0Ja6LFaoUGtiqwUbtUid5HpbNKiHUnN7L82m15CGSDeWfQSh795rcGjAuXU03j/JaBCgxkK0fbFfB1LE9WV7W0ma6ODBUWoNmo9zTmXv1L3COFr9LcORMlFGUa1V85Nru6O7lVGxbQwfoyN1laxLHeOqgu8JiAhYjo5GUfyPk59JQYOKVtaNPCtnMXJBYtRtajRByLWnCrL8YrpyNp/6XeK4qC/7XoR0cZW1uwzMi0PcgzKAE8oEhiTBKU7C6jp3phoSnpnAdodkKpJMSVh4ez3tg7Q16bV4RQ2Y3CLTX+jAuN7CG4UdiuG7cMXM81Y+yvLwRllfdCB4JlT+eJHn8qlZ8QNwMdxkUDRuBZAKKilcd/z1t+31txkdl8nAtx/xwQd8tN+mVDLNAv44gRTU2YfHRRiTWU3QvB6q/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a41b228-3562-4ba5-a4e2-08dc86321fe0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:08:22.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRHYPnKQXkjK2ilv65bg7AoM8CBZLxDZsArWq/qucoal0xEP8hu+S1SSTgmMo8+Xb6EJ9sAExrgEl6MmL9BmTUJk71i/QlR1Ac/Cn1YMaRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=899
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060102
X-Proofpoint-GUID: msWDWiPgQit2v9_rDeX6t024PSl2clX0
X-Proofpoint-ORIG-GUID: msWDWiPgQit2v9_rDeX6t024PSl2clX0


Christoph,

> Metadata added by bio_integrity_prep is using plain kmalloc, which
> leads to random kernel memory being written media. For PI metadata
> this is limited to the app tag that isn't used by kernel generated
> metadata, but for non-PI metadata the entire buffer leaks kernel
> memory.

We do explicitly set the app_tag to 0 for PI so it's only non-PI
metadata that's affected.

> Fix this by adding the __GFP_ZERO flag to allocations for writes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
