Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CC33D8
	for <linux-block@vger.kernel.org>; Sun, 31 Aug 2025 00:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600567; cv=fail; b=m7BKBcoUryG6VgoRTybEZ+bJCGQ8iF1MRzcmgVDqhwVgjbdg+ZzEJA58gZ9l4FPxDOVRxd7ckEQki1eWYaIXKfxAsEfq+bWWBtESM1VoGT/qQHpT+scgbF0omcaOP4cVilSUZIZI3Ym9a2ESraufbDS6Oqx2+pgaEDhp8hOg1+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600567; c=relaxed/simple;
	bh=2daU1KqCU+KcuoCLYlT3D+si+1WKTAOW5fGGVthppIQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ug3BliwAOOz44gZxMrKcmBprc8nkL1RDw6KG2w/+/frTfac90N/H1MrxfxjWnbDgU3U1+JLixo2FYuheZ1cquB3NK2WWTT0MwKTlokDTc7zY6tNBSTPqQikZ0dNCM1zke4s9xXXvGpViDwUTV5tAfYZGw9n6WEuVI3InJG3WSPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lzhlDDvo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NmROKZY1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lzhlDDvo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NmROKZY1"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57V0Zp2b016810;
	Sun, 31 Aug 2025 00:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JNty/mK/mby3B0pNYS
	rmdBdu1IAcCU8iw1t0yjmQI9M=; b=lzhlDDvohWO/nuqfo4qlNRgPSJem5bawTp
	gYIEfxa6fhJWodGV1ZGpQGgRwvdv4+pMgY+Maf5ahcZJPJ2R0mda6HevgSxo6w4i
	hQiVGONeMpbb/3Q0Nq9fb7ECGnw4jamtIpjvnyBSe22E012qNCBIrG0PcLXeXO1A
	qtYLFIA/zTeHnjS8032mXt3D6rII5Vb9ORahMSF/R91fgFuDoZJc5o29wEm2wYED
	hrrGnrdaUbwhwT0CCf849TE/+nkFu5AwjrronPzpA4zZdZpPjcC1jYEV1jEIS/c4
	QaM/hHsJFU2uojSy6nO6og1PsyrAzLxXif3Owt0Ctci0JWUzxriA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmb8jvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:35:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57UMf0ua027175;
	Sun, 31 Aug 2025 00:35:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01k981d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 00:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxaheCmLm9Cls2plAj9CUsCY20DaRdglDJXpdiGtEIK2RS8gR/pm51DZcKDM+hg7BnfRSpGhe9fRYxkLLa1Llw7fpRoGefbo8T+ynM5st2H35tMSOmcpZTMORyA32I6Q6Sb48l+ivDb1m0Ai4HMjA/Kq36pqSkwBAZjkExxHmXbC/1Bu/tr16NgyaXitygCoXXl+OBbmSGGbFertfzItp1wKlcMyOzalt+uf+rA4dOBR5WJwIfY8mJtxf+7NBPCMfLcwFZqlZGD5VclTmFmENqFSamTiicoVEv5wtgPiDfiAh2kM+O4Bd58s0PpFDyVUK2i+Q3/SAL1JlLQJsz05Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNty/mK/mby3B0pNYSrmdBdu1IAcCU8iw1t0yjmQI9M=;
 b=saLFX9SExzqgzVDL0iBbnonGgUPaQWBKl+qx65s0DkjRbgsqx7VKQN5xfBdzZobYbE+l8xmBbcubxcsP5rXyqr8Hc0d3CqzhdawyNze8xF6AO/5/dqyL1ClSYBMC4PQDsn+G2HQjr7XTunFarFV5s0y4S5aCchheUoEaqecbUP0+hP/HbqacY8BAPTY7JAiN/AxyqT1Q3Zbv9mk0bW0E3r4p3HwoZIIW8abW9jOO42tKsflJ+0OvNKuf0tT2qT0M1CLGoZPTKQHbq0jMDDP0QpB3cFe9R3sk1NCM4sKVFtGUqU5HpplN/CBcMGDMX7Exa2wDNI2QqsBzpFW/X27KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNty/mK/mby3B0pNYSrmdBdu1IAcCU8iw1t0yjmQI9M=;
 b=NmROKZY1gmEOGzufDA81PsAYTINEPkfrZdQQF0XFndu6xGRJE0LN9lTlYtvTsRCAgfqFPPq/KOT25tHOxzNReQ+15imQeBjBfjzZ46cPzwwi5+IwQ3u19ltzwfOg3Bsgi5sSRapeYS0iMaOujxKocXQwqCv7LhpBIdTv9d5OC4M=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 00:35:47 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 00:35:47 +0000
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes
 Reinecke <hare@suse.de>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 0/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com> (Ming Lei's
	message of "Sat, 30 Aug 2025 10:18:18 +0800")
Organization: Oracle Corporation
Message-ID: <yq1v7m4gwfi.fsf@ca-mkp.ca.oracle.com>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Date: Sat, 30 Aug 2025 20:35:44 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::26)
 To CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b559056-bd93-4602-c53d-08dde82653a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09sSuggdUultbLXlg24UzwFadui5B8Mm5mMUqNKxm3OvTEeDI/MnCPTlY/4q?=
 =?us-ascii?Q?yRqGdtTi5Fn2H0LRRsUUjIXqbyyyTVKWEBw8qnAnedbwjMUEsYxSjqijQVNq?=
 =?us-ascii?Q?mr7h5QG28SqXbhntNUv4ZIkToHXwWUc6JWvsqBggz8848Iab2xy25buflHsn?=
 =?us-ascii?Q?I+tGa8bkeWcvVQtCkqgTvYSWhnOikvqAm+tNwpvDQgJlx3pSlGAo9yOjFVTc?=
 =?us-ascii?Q?Kt24u362BG8jcKJ01Kuw1EA6V4IT925svb6NTjV7GciNuBHQYSLDIoCti+Uk?=
 =?us-ascii?Q?22OZVFvqhrxat2Qbc87mdgFyXe5V+1WpfCZcX+szrh+MLaHitEBd5MsXSUn2?=
 =?us-ascii?Q?qaX6scQgjJtTNWDUMZkV6z+3W9GPJM2KKDlFJa/UFUMU5XaEA1KwsecA6q9O?=
 =?us-ascii?Q?ayVT7T4BHPJqwEr1S+f4woAlDycS5PNLd+Gwij+YXOYJuowW33ZCWgBuyUFE?=
 =?us-ascii?Q?LHDvgSKEDK5+2HhlB8c7xrMjJdCjiAVXIzKL2xaezdB8pN8kSXKkHkMKUfXN?=
 =?us-ascii?Q?75ape5ABm0rElwkgldEk+8MI2wsCDY1u1HrphRVn8q4G+ZW1T/0faesvPyYl?=
 =?us-ascii?Q?B39/Ya1NEIPuqaMGGounU/SDFKFk0Wnbq0snP2n0YLu+CXBZc2KRX6EUSLr7?=
 =?us-ascii?Q?qCOutzaOQXomEJZxbQJC8qDQxZSe+FEPcv8EOvqB3GmSvAS+RwxXm0AWPym7?=
 =?us-ascii?Q?6vNbqoJz0mIC8N0YIJgFE3d7eeeCwzEX+8bOignvFsqHo8LjczDmAPcQuD43?=
 =?us-ascii?Q?kkkSqvZV+a6/5MOuWgPxSYDlZaQv7rm9gvjQLcY/MNqd13XitnjRY+pmegfs?=
 =?us-ascii?Q?JEW4ewgrxDROOdWv+pbzvzOLgAKycvBA522aOvlREneW+3KKPrYF9roMHO0m?=
 =?us-ascii?Q?9e8aVtJJn4H3uvSQObnFkPWzaso0tbDOfBQS8kFGnLJVkI927VoZZVYURYio?=
 =?us-ascii?Q?m23+/QPY61o3opHS7QregHBBaVqzhJwHF5b70yDswxDPRvx7QYdgwjbft9aP?=
 =?us-ascii?Q?aFUdoIbCfXGbxmeIR5sfW0kUrRc66+BYHiMfTwUqHNq6zNvQ6r2DxanZci2n?=
 =?us-ascii?Q?PKs6Rywz+fj8BUcqEh1Qnbma3S1erRxt2V45IuG4Cuaiz0FnoKQKTFjrQXOv?=
 =?us-ascii?Q?NkLWBt3KsJKlS8SflBR6Otbg1yF30s3s71zbY0ZUq6Sce6XwPRXTfWGerJIX?=
 =?us-ascii?Q?sS2MMpOM8rcZM9BOD3vCwk4dnaSkn+UFcakiKu0j8/bAs1rZLfSznFtNfgBH?=
 =?us-ascii?Q?KaWDbwCkmMaX8JA+dsALcuaxtQag0y4PKESdkrFZkOd9V08ez/NSgprNtO22?=
 =?us-ascii?Q?g5vt+6SvSTxWkZNVZxmOCRxeqxhdtfuqhEJ3+DLJJp8Fdra9t053N2hjJy8Z?=
 =?us-ascii?Q?WbWq4iHnZRsy+xld4ae2HUl1fQq2ZUZOrbHAljoG8DhHtlHm9SgnYZaf1KRR?=
 =?us-ascii?Q?3W3OqAuSVl4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdopLe6FP/vM0x61g9dtQeHEjUfo1wvt4fRMzi5oYZatYSeqr6mkc+9vtAJS?=
 =?us-ascii?Q?1LkhjeMx2/QGgdVa/YvqsalMCOAJfTT6xj2M6n9YRIUucV+tqCn9x48c26FQ?=
 =?us-ascii?Q?aKqbkZora9zqXrzcVg6U5UNgbClV+p6L6Ngq6ycQ/Prgkf3XOrl4+Cp5JwdW?=
 =?us-ascii?Q?RFqAjlLMHrcLfPlxY6xrd5Exxzu7ZOgQzdqawFaoCjIwyxMEEsYOEwPepQGJ?=
 =?us-ascii?Q?PAPYwERk8y+hlQ3+vwJ/YSiD3P3NybNT2eNm6Duoa/pKQL7EXHHuALqusOST?=
 =?us-ascii?Q?ldMnQV7UTA6M5ezZMgU9xGxV8E0hI2hFT7Og6d9EaJpHMNFrKv6L6G0FrLZA?=
 =?us-ascii?Q?kzggOe8L+GQ7vHPSrEBqrmuSHTBfnYqfxxmlrkpmDfzaWL2b09x4e+Q1qdYl?=
 =?us-ascii?Q?MZSLfFVzka3WGhd3Gk78tfqfSV8XWSHpmTtMvp8mx+YRoaVDzkV1Mgt4pWB9?=
 =?us-ascii?Q?2zXZBCnUXpnnAYPLX14fkk5otGS2PwEk9s34zFZYPu1og4wvWYn9K2pTW0gb?=
 =?us-ascii?Q?eIJ1DZxWNcdLPleGBnQIz3I1ZFCsKl4iOXJhF3CzH1bwMtx40p//vFoKGzvq?=
 =?us-ascii?Q?TF6zjprlKYUG08fat55CnYub29+fPSJs45AJjvezGcaPoiN7rsxig9GnIpWr?=
 =?us-ascii?Q?xfBQS2snZCOVBVHyYCs6IfC0Di0qxJW+Wxy+qndgYGyV9YeGkhATHKn4Zw6T?=
 =?us-ascii?Q?LB5tQRTBK7ti9HlfDj9ZxE/tsKJMAJtqtznYXkn49ikeE04+H5VP8VQhh8If?=
 =?us-ascii?Q?i+wX2WyQ77nNG7L5bzwJQKncANL6LCfHuA0frJFQ7xAX9TVDt69nnfptJ9uS?=
 =?us-ascii?Q?nhm9i/S20uASzGuava5AQKUERqcHPaAm+O3nraTTXrufX/uVgqjzYAL90hrt?=
 =?us-ascii?Q?FWdeYNcsK0Aew1Bygil//BBT9x3Fa0VYdASL8oS2rZNEJBld3muinRH282iu?=
 =?us-ascii?Q?uCJGUTkAgC6RpVRghoE2NpqsDE755JrgxUxwMbCT9asTqAiqLiLw7U9yA0ow?=
 =?us-ascii?Q?JqtZom0YtD0vf2Hfck3RZ04yZF+FSKjVZLssiYeYJD9Pz7SCcz9D42MEkDHT?=
 =?us-ascii?Q?oN/r+ph99EfS/NkvzMolkBiDOmQOW+7XiaBCeLNXxd1jGhRN48Ib2Ej+s9u+?=
 =?us-ascii?Q?rkwfQwNAFNo+vHMzJf+P9JivX2RSz9cFsOgGhbnJjypFe9R7w70QfJq+mKLv?=
 =?us-ascii?Q?NHcfpsnQtXMYVi9sUPdxukpUbUi6EgZjTz5JpGhGfRiPr2iiAmCotWOkTbnO?=
 =?us-ascii?Q?wtnBT/uePKhceff8vv5V1XpUpXaxj3ULym0iGT8w50zJzyS19qA0dgM++iBb?=
 =?us-ascii?Q?LHX3209pYDg4UGYOfNfwCKf4GWLBooWLd4vEbrJHQ2aFz9fvQCYOwTrVuAH+?=
 =?us-ascii?Q?Nl6rcccyOF9R1U+0ByK8XabRTnPx9PR+TFxa5kUwpIxMzJ6QBuFHi6XfmLEh?=
 =?us-ascii?Q?0P4YMsChXiBkMJI4ifDSX/LAfDodRFeGVVu2F5xb0YNKqNKrQjWTX65hA4Og?=
 =?us-ascii?Q?7FZVjEvquZ/V4VWUVLnmdpTFk7zRIyW1p/c8EW2FUCiUuZ7YojKic5KQBQ8q?=
 =?us-ascii?Q?TqskcwB0nFJ10WHbOtcHjyKIEUewSEvHfYDYdth2Xvc6J2Gyr5THcrmD3dvt?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSS7qHnGkBZ5H3Ns0q27le7mqxNgMsuLvY03fd/+UdCdB7l58Y5ND8LKg9vEPlVCedYzxPAxZHcC0zkD/ZQaajZYp/Nh2pza2xepshRLxF1gjAceLw+3ZPsYgBCvNW2hxQnOsFdi23zmnk3+gknbrlxxqNEPkNG231oiilHCaYb8O+ED0uzXZa2be2Xtt6Gr40UAvEKfb2BSRaUPvtU6jdzWAdZf9paBd38bcqvjZvGGOLAAfb43M1/PW1J669u4CnAbpC+31NrJWJOz0ote9HH3/mbuU9UrcsgEQIMVTAJ07kyBcZ6KC0AGuKWPUHlAPIVlh/3FRISl6kSmtUuZPQOLS6mmaFls9SEu3COBybmH3yD0/sumgLPlKTmG2x0+FcKeKCLze5c8tfN/Mpad/tq7raAhs0cWNOBAdCiDPR/ysx7TlOeCA3d64DG2/DM2arMAhQ29OEDybmshpmcOqPDm3ERnfFqTpSyLC7maJIA0UKOwvlTdmvqcsYq6yEfgCmJBOb0hX6MOz14NxeUI7WGnZ8y3TfbGkfAfSWO/wTliUb33gjhDBUaekxnDaY+RWIC3voXoLTwpjITf6KaqwF8Lsmne16UMdltciYQSQ20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b559056-bd93-4602-c53d-08dde82653a4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 00:35:46.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMVqP/iVgKyE+Ndd3NaX1aDrYe9uhltjxflTy2t5rYFqQX03dGo32Q92PBUpHsVrDyMvKwrg9u/jBFWb21xaCTXLAvlrzaFJ7h2cYb4JjTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_10,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508310004
X-Proofpoint-ORIG-GUID: iKNgg7RO6ufexJkrXkc0qiupm0Q9CRW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXw2j9A3C/dEFL
 MGny3DEFtRNnvjl2fq+MtrgqamcuAFd8ntZGTlMDsO2WIfxQKIp61kcvOGi/uM1dPm3Y3soAN2K
 LUIVexbrRgoUgeNgYcUb2ZPncWlBLvEY/o9Mc93R0877yy5Qq47RJgIc2z6Du69TEHsiy/VY4e2
 6FdKwzfdTXPJl0VYgyQPWhn3xt5suiMgljYH2Io3qkRwmk+C0rXvj3wRfZmfJED5s6SKRdkFWbT
 8ZHhosElZ7EUPFWQBx7RFLCj2pWLNlKQrIP29vHpK4CSA0lTZqbACdROvF16zVIW2N+fNPhog0s
 qOqenpXZMt6u9LFXEl86EzOfUdFju67Oqi0y12IleaZnKdAK39BRDFbMrUYLLIDnHDiiZNLM88u
 ISAkk/Du
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b398e7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gPufkJ73PEoHY00fvJQA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: iKNgg7RO6ufexJkrXkc0qiupm0Q9CRW4


Ming,

> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read
> lock around the tag iterators.
>
> Avoids scsi_host_busy() lockup during scsi host blocked in case of big
> cpu cores & deep queue depth.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
