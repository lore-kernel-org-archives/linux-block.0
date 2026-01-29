Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478123A984
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710805; cv=fail; b=WaukiEh5Jpc/JjKAQGeQd45FSmJoS//Igy8kPSeiWtxfycnWNR1X5qf9xocJDMsKyez2D8x1WC72Kq3nuwGiwIigxZeRCdpJP+/Jf5Wsy3SzLYqFo9Q/Te86r+UqPgU2zIy1tKfaXkg7k6Ozg67Sj/MoYBqycBVWfdoXFlYM8Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710805; c=relaxed/simple;
	bh=LqeZNmj6plCmUPPRE5clhoe+PKIKDOUOOHIDIaUDs4A=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=tJ+Vnq50GrpiQ2ZlSJDy4qIiXbDPqDMc6VHBOaCmt4Su8CvOSF+sqXq7XZ+Fuc8vrWMwViH4pr4JhnArWdxQxHtlBgh+gV/lEngb0Ix8nBt9R0YeQDLrI7pSbsehuk2JuPzgVKk2zkj7fDSWSlAITyhgRHtyEiPz9ZVyin8uEK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BehmPwkR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CjlmjAgv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BehmPwkR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CjlmjAgv"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgHvQ448901;
	Thu, 29 Jan 2026 18:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lYGryhArAJ7Kee2M02
	6JEWnVYgyUY7A8e1DL7povL28=; b=BehmPwkRY/ct+ZMcHsJyBRe+0c+0PSpTWw
	j0mij8SgPYO2YpE6fCFcY1A99oURcDSE6BwWskcR6myr5NPfM0UEbCiJoCgpG9BC
	dD86aBYPIgVHbhxkp36qmb4LLNJhsvShwGtSSKwskedtSoU7MQHmv3geCW5pzWvI
	5X1OmIIkSYkEhsya4/RDRD3Bn+wq/5Rc7iu9PLQXjl6nrqMXHeIt1ErA1jfiTilI
	pQNn122FQzqV3i1l6jcZV1HtXW/dc8Ez2sJB7n2AWNEoY9Ay+hwl4BDEZ2CUxWbw
	oIba/PQ9IbkCHngJ5ymJuJuSTN4R2Yum4jpqDVaVjjOmgTBC9dXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09mg4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 18:19:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60THuJ8N010437;
	Thu, 29 Jan 2026 18:19:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcq3cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 18:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D768P2jHM+q7wxRm+leCruX+FASptEI2FD3VgqIoZ+vhIFBl3EKkeeA1uTRchF8nfCGEvwLa/uEy9lPeHuI4eO/4ldP1sVfurOZ1FXkbUUZ3GgtWkve+1RbQHU+PRbMQtDp/AxxMpku4qmjSY/A+CGJrYdZ7yOErxxs33jKv1SbM5tOjqea3lNggDSyBGv3OXUr1sW92IzKgu07Jv8yiC0c/lupBplKV0ezEPC18G9wYNJXLn440e/QkCFKXnhgKGNUahcekd6FgTM7O5pq5SBL53cn1QJRu55fx+oWmNSz8rA47ycScgXsZmmfx7IO6NtCP2Pd8txggHnsor+cE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYGryhArAJ7Kee2M026JEWnVYgyUY7A8e1DL7povL28=;
 b=I4MDNZaS3LLmBqnLGYDDPbOtY5vbMF6CNwXRVTHQ/u+qR0FJz36ERjsmJltTKZ7eoBRw5BBubpHDJCknKlrxqfDIhMQxmAceT/FDtaJS5sI04xcBvyFcols3nDu5GayKGGiaYozuIZqnDXRvDdIeQmlKf40eTOae5YG+KCMjj6k0A1cil3u3PWNwq8ROwDBWTFQsS+5qQATy2c0jnuv8iwj4CHzo8f2Q0R21sd+anfnlmwQXm7gE7YogEggtMB7ZaB47RnPv3sO6JQJhYimnPxkfN46ztdfXzjnBUEK+h6mnAnu0zb+uUzWOzCkDGuwljIqKhYQdbsPCmlyqcpH/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYGryhArAJ7Kee2M026JEWnVYgyUY7A8e1DL7povL28=;
 b=CjlmjAgv8nmK45jbQrl5JOi9YAVMdsTYVcX+0j1cyEWqqbI31tG9PRayYMe2OaPcEuq470caEywy5ipJYg8bbAfD4dvinJ3BQ9SyVvbZUmLZMqyNegYnXYwJcK5n2jfpDhqys3PXcrG7QDuUJON14h4w56Ra65Z5b/nyY96+98s=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 18:19:53 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 18:19:53 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] Cleanup patches
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260129072715.1107336-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Thu, 29 Jan 2026 16:27:13 +0900")
Organization: Oracle Corporation
Message-ID: <yq1cy2sqo25.fsf@ca-mkp.ca.oracle.com>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
Date: Thu, 29 Jan 2026 13:19:51 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0235.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::19) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d34070b-5080-4633-86bb-08de5f62ff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JdTL8GRFX9RYQHxlY7Q0/AFxovoCHODBQU0p9t5CM+LZZXhgj9DEX6LKiIU?=
 =?us-ascii?Q?cKQwls2D/4lNTGhbGqvGXpehzKkQI/xVaStnDhwxa8Og9AjSiBiUjHXzEHVy?=
 =?us-ascii?Q?NWB6jVMgS01cjpgqTEia9VmV1XmuFT5H6S8xTYElEoOY70Djy3yZYInxtNFr?=
 =?us-ascii?Q?AsOAB+vRpMvxehw56fkV+5VSG/j3X6BrH9Wm9BmFAjf+Z34whLq7q4Q+kElT?=
 =?us-ascii?Q?ubC3r5TRjAiEt890GeR/4Qnc7atkRMt4m0V/T/BD3ST1hbQm6NOp2aPMEwcg?=
 =?us-ascii?Q?lo8FToge5PltcIp3FNXskXY6DuKiXVKBDA9UteCk92JjWi7Pawy6vwg60D4K?=
 =?us-ascii?Q?Ub14tw5wFksyJRuWTDtvf9INe9JhTM7WawMDxg4Q1rAvjcs9XyrvGeP/QntW?=
 =?us-ascii?Q?ReG0NjMGxA00goHGbJUM1ulunvb+CdwUWVLDcSAWDeXzbg5SDDKsnM9R3wFj?=
 =?us-ascii?Q?F59n5DfUc9FDiQjVT+r7G2qD7fHRQr5dC2d3TIAAvMQPHyNxj3ogoVo/ArW7?=
 =?us-ascii?Q?SSssqtmSMq5XT3gARThZnqC+CHE0r44FZjNKZvq+7q3u8evxUxgPTOndJBip?=
 =?us-ascii?Q?BjQTkTQanu1bFmSomVGj8075EC7IkPsaB3vxd4pJCtYya750H1YO7GW3mOWX?=
 =?us-ascii?Q?/NUdCAEmsKRYUEDQ1Sfk2IOBr4VdFXsvwYFZdio//Eyj6Z3RKz2oTLu7UjcQ?=
 =?us-ascii?Q?GaiYQfEsCyKRVQmEcSscSmBum+HxQG0zbayNZ5r6eROHPiE/Fs6h0EW3QeoY?=
 =?us-ascii?Q?gsn7cnXhY38VccJyQhmExnbHQBoO260uHhjVYCQw2VH2kaBSiOakc/4WDDp+?=
 =?us-ascii?Q?Y9TTmxSj6fPHD/E1zs1prY2xfSpuiKsiTM0G+9Xgi8wKaxRIyXhZ5NVQUktn?=
 =?us-ascii?Q?i8Ov32xGlQAtpv2S9HN5aZo1NIlOaxGyMfO9WLtSkkUyj7V8mdXGp/9Ntbbg?=
 =?us-ascii?Q?ZDQfWz4OcOWMIkFwIO1CzUeI7DCrHKSmw22/09vu5j7aCyqIfECXYE4B1K0D?=
 =?us-ascii?Q?WHl5vPfn5xSAn7mEOrPI5ADY2yQDzf8hWfhH+lKeLrMNdwk4bTwTNnGijpq2?=
 =?us-ascii?Q?haFuUvm+z02X3h9IN4+KFCWwPohNelYOaXgdoNXzSyYvGRu8Ak41b35trEEj?=
 =?us-ascii?Q?I8dJYOl9L5hNPZfjYAwPZmSXziBV7WVgIQozmztC3AZvMz6A1eTYIYHgZP2Z?=
 =?us-ascii?Q?EhBy84lMCdwPw+EqNFz+mClQq3zQVSewod7SJ6VUZf3m6xlFU4hr6K8QBBJn?=
 =?us-ascii?Q?1FkBBVuTSLck/RDP6IsceDbsjEht8OAo0Jtpai6S5IFb59ojG0WAp1N938iP?=
 =?us-ascii?Q?DBVhzywY/6ieU44Nvd+k7y8sKomj2FJgBXHEVVNfAvYC59Kuk+Iu1+Mj0COy?=
 =?us-ascii?Q?1Pog3/f0B5dESnz5wH0aY6aG5Ow+feai8fFUH9+rB5Sa21Th0IcyVMmOed4e?=
 =?us-ascii?Q?mdl5WkSykiKsw8IZTHv0X4XZ9ppMLpemtY8VunMgWiTwGBFRqdeGl/FvKGdu?=
 =?us-ascii?Q?z0+8lDZ0pePQfhQsJi+gjnuCrey6HfFAw2j37XQjFY/vk8nUfixZQCK7/hua?=
 =?us-ascii?Q?PQ7gIFW5M/78btZRdrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPK3hJ1FYrQMXUiIGuf7k74kinT3e2J1Gn3JcmMiR4r+FlGEOCUzjIOR1bkm?=
 =?us-ascii?Q?CHIAfaC+mwhYlJ23kXtXWAbXf0lltbdOL2r/jtRR+fTghvFO0Vmkz/eUFs2p?=
 =?us-ascii?Q?sIjm2xV6yQUyTsFhWgERFxNqAGSx1AtBGW9xjxXsbbqSSGcB9K/kidArZ15L?=
 =?us-ascii?Q?j8/7zY4Hl9eHXhjUtSt3OrmwWtfz+AU0yY4pJ6Pdp4agcaX4hIjQNXLAL3g7?=
 =?us-ascii?Q?++ACL6QNu5sU+fps9ewFAEC+LbMOj29O3589SDkG1XAQa3Gr4Fke/2rC1vWO?=
 =?us-ascii?Q?+XuL6gYI0MqlhvCOYE9hIumcN6fqUPoqF2YZXsszX/8y6hJ8+Pnu/vpsVxdl?=
 =?us-ascii?Q?C0ftqdEvzhk+JauYNvvYcrvRLZ4u6MKRyk3gpmBKBCc/Y/QPmJW3c8Y6oPRh?=
 =?us-ascii?Q?hNcYthJlWse4hzqL3UKngfh/KjBhiqGlvAJvXxpuB0X4tun640udMy9r/MNa?=
 =?us-ascii?Q?SblpmV1bpYFK91j8WXjfFTMHU8p6FFI+j3jqi//OGOVpq7/jfO2OKeMtlzrD?=
 =?us-ascii?Q?vJuBpqReynB60dNTCJHFuV0jxhjRzxpag9BVRWwyOIdF0FwUS+jmrCgZybqS?=
 =?us-ascii?Q?PZRZLCKkuWXz25BUGY5YAVn6j5Mekq7mHmJPiOYKXV0Ryfm8OOYwNUaBAxHU?=
 =?us-ascii?Q?Z9WHpzlYvBlsbHRsX4Iq09m+QB19IW5uAr4Hfc209Z4FCuQNGPNxQykSi6GX?=
 =?us-ascii?Q?YWVGRDpgoklwfN1ywF+1sus1dzj3uIkKD0sC7jTLHoAykPFfKZjNgsoZWeF3?=
 =?us-ascii?Q?ze/k9JsNw0l4Iq4qJS27+skltvfM0YfWyzo+2VgSLFAN2ST9OLDUmfKy0WAJ?=
 =?us-ascii?Q?YmY3roM1DLKgO7SoqVtGdryQAwvXWiM3JQzDFNDXnwWSlfk5any14k1EWuQc?=
 =?us-ascii?Q?WpIXhMwCRWadcMXAUGV4b0vxUtye5hS4JmtGycVxfaVdSZtCkGmIxOTXcBwa?=
 =?us-ascii?Q?xRbA2W/WOGzgjndYO5TwZx6r6Mtrv4JPcAK0nPdhE5NSkeWSKz9yF0doY33C?=
 =?us-ascii?Q?K52QhKReHy6dH/T8OveGR+9VfzoZcgSuxoGObq2gm4DNQ3n/t8+9othEKKuD?=
 =?us-ascii?Q?PVVZQ602BcLn4V4O91yRzEyegSKUd23xVG3kzVqhRtdi9+ezXcVFwKRTZGKi?=
 =?us-ascii?Q?z19C+hC4Ka0Q1k2CGfJE3CcOO8zma0+9MqQ21I2MMZ2GAl3oOtTFnh2sv7Y+?=
 =?us-ascii?Q?DzzoA+NbNCHxLWr8S97s2iLZwiM93lUOD+RXcykYN3atHinP5m5AhQfnpvYG?=
 =?us-ascii?Q?8XONou0/1vqjwjgNzLI035v3SpnKVeAScQCTEdbOedKKxiR8GB/Hmw1hsgm1?=
 =?us-ascii?Q?iSNvdL+90EXZ2WmbSwLFHRLPtNg0xFZFkTNFUREfKNEG8DbG1QsVZZr+TDcs?=
 =?us-ascii?Q?mdzcWexpJEpSSCcM0WnlDya8WGfE7/64X6UZsrMp64Gl15VTGelj1+PxhWoJ?=
 =?us-ascii?Q?9FzxWB5R2qYTQ+yUaPGG/itpGHobntjgDoGPDFSNVR3BjTT42Ub2u3pCxl47?=
 =?us-ascii?Q?2FkCRYEPetTyA0clCfft/jUayDqAsZSThhDuLxbrqDqOXyYj/yAwgpj2iG8k?=
 =?us-ascii?Q?0eaBcQl1p6JoZv5BBJLm2f+YuGzWcdGb2QXPXi40XMTo/aOG9pKY2GJOVIha?=
 =?us-ascii?Q?Q7XxaINhOoo6/+IElsbP5m1bn+tzPXctQrEO+IhqOAhXzzGbETHfc2V9l03q?=
 =?us-ascii?Q?y/f33eSEBemwOqs32kpEFlyCjCkLNiKxv3i8dseJ5vTJoUlRzEAgqCeQK/iw?=
 =?us-ascii?Q?VxpKh6Rbc8IN3L3RhkfMyEV5CC40NBY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0oVAAJhNi8pPhULgY1JhVE2O1nCRjgx4JYcNCoafMlXgzzoIBz1SLUB9qL4JzgOvqBDbXtv9Io9gSeg68gmcpARBeZ2l+GsCQBFnMvJDcjJeg7KircOOoT3PpIIDjhNSc7euDnYfsWZrKCTSrX5Dx1pqva1hcXZz7XadQqbSOqpua6ufEmkBXZvTky43eDTWXx0wDVJ+12071O7ptVLtsEFIQ/uHveLZHiv4ugoQuLPr9SGst2ipnpkAdg/9D628/CKeCnACgnman+Lm7Cc7n/5iYQfLntXke+6AofBzVYhVPwOkYd1MFjp8ltGXKQKQDFuduOenKh81w0pfZxmF+3AE8bjU0zteAdu/kOv8OUehRnSg8zyWdzaR2tdEbO8mOGnIkEjP+73OZ+tEBZYSJH+IfPiql3H2rS6Xlro3MtgV6kBIpMREn+f/BG2vEW0+OarVjYYTjGvkcn3Utgy8y0ubwCD+3r8ieBlhf99by560BKqsu7rJJNgiJOFADmpehQVffvRP3nm8jYX5Y4QNeI3UExNrHQ+ct+LnBCHRiy6iHPQrapsEIWJvPKzFWkFheervc4c9Fgc9yBYCTb7ybbxz4dX4PfsCdwWBBCP3zkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d34070b-5080-4633-86bb-08de5f62ff6d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 18:19:53.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elcfs8kiNFuzbJSCaTYtdoLEbtcspVqDQjsZctxgo/JdcVXMxGu7cNVC//Ff2zGDO2JB+gy7s7hEKoaxbfXlySRdY/9/WL5NOvHLcUdtKVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=998 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601290130
X-Proofpoint-ORIG-GUID: 5DEOmkOwAMFWRNI52y73IHV3Djq5L97r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzMCBTYWx0ZWRfX097mjyfW61za
 PNwhZH+6GyHSEYZXQ/+dOFx95ODUy40rtI6qxbwfmErCvT1ZTGHpCBtAn0m4qD7Ybs1OGk34y2e
 UtTTj/nCVpKHxfF8DaQI/tx1Sa5DAzU50QgGBWpWT315c0OZyySc+M8RcgE7gBHLWICQTPtu1e3
 OvFu+8Tx0Nt3jqPTXoRz7ZRcbLCd4wlQjN3Q8zqI63obMglcKk9HeM1FiBaCzCcL8uTY+1LEuCf
 tHzlCXVe37do+wFr+z+lx/96+HBYs5T5z/erlfi3aAJ2zl2L3HsjILm83mek5CQE94n12AwhVmC
 tyPrpuCiK5TWFnI4DoX/4Du6Gl+pba/xB1yzpDz9cce8flwC4nvfE5kKFnX9MB4ByhgSVHxvPxt
 7vkgOVXN0oygX1LI3QOL8zVIgDQuUWsYFJ147kJaNKCHyNY8xBf+bAK6JOXtbRrZrNS+usBBdVY
 77G1h34sO2dXrRsKE8Q==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=697ba4cf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zkuvz6wQTvy6oRhD74oA:9 a=MTAcVbZMd_8A:10
X-Proofpoint-GUID: 5DEOmkOwAMFWRNI52y73IHV3Djq5L97r


Damien,

> Here is a couple of cleanup patches for the block layer. No functional
> changes are introduced by these patches.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
