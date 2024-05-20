Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78B14292;
	Mon, 20 May 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205644; cv=fail; b=fygRmi8VhWF16awlmFFTsChEu4BAPUsyVXdbKLG2cxdtX6F3p9vtom/OtciKy5H/sbyWe20anA1ivF0HQhPJm94fia5z9QSirJb+BzQhwsO4ZMjvwDeJkFdulpQrA0k3fYxNLf35yLp8t5Am4o1403+XByJYWtQP9zOmmUSy47k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205644; c=relaxed/simple;
	bh=xtRYkv2tIVIE+sHMJLvtV5RHpXjhI2SGXnHC6aC1Eqs=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=VstXIynAVetZZ8zKCfBcTxQWvqdZwk5j3RKMjN9oxMc7ATq6tGDELHSLC7DJaZswLvv3ZO13iSGgmhbZYITEHo6id950FLTwO1WD/qB74BxUHscAFGIKl6Ko51BULHzavpkStTTekGsgplyq2aHCbinJnaCWvFgLfq60oPAazYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GnKHJezR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EFKZ3AP5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GnKHJezR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EFKZ3AP5"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K9XR2x026214;
	Mon, 20 May 2024 11:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Br/yZou1U620v4xByFhSpASm32T6djqYM5TLzdIkEnk=;
 b=GnKHJezRCrxhdJdr/3zBlaGimeCVdfmaagBySWyHKAi223p4KQF1zHNP9DHu4v6whAb8
 wdIOvRELRCGLPpaOa7XiF8Pm1KLPHgysuJssBACVMX4+DQCe+z9oDDy6EgfFDb4vezbw
 fUpS0sJSOjp+U/6sJ1qoV7vUezeorDav+kshQ2upOPutto3gW/IevqXofR3FCtkq2jxY
 kLO10wKG9uhObXpzc1pZYoS6aPgBCrPfW7XsI8a6xCKqyU8X8/iYSdAcy8kY2oayCnun
 hDgodWSZFYF9/Ve8NttPRjWTePoZO+ByYtmIlVuvbCL0+kzyciPMmb3Ef6Qh1lvC0mLO Nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv2dtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 11:47:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KBBaSo038446;
	Mon, 20 May 2024 11:47:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsc5k80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 11:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsVexlLQJohNuRyPdl1bBQLND7AO2IQs/4opiI0wxx74vo5pqP2i9YArvSvcXxvJwqKlAQxrtuTjkE3J7+lY56FXYiweDF4w0Wx8RSVItRM+++yBvTS2rLjZS2HaPg6czQCjjbW0J9jw4pMhpJw5D6MlQ1hI/V0/HTiA993Y81IrMQ5kbBXsoSl1i+SdlAfs7M7415Q1hNV1i97CLllXvQCu9M8/hlOg6UnTCanEsdp+FvtoaVe41oBJJ+VbkT08uTC8AsyeLBOH/nz8NIZwzreMQrB9+yOgJPZ9O8phw55cZuA59ctE8/0sGuDoPt8usu75FRX78BRU25/fi564vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br/yZou1U620v4xByFhSpASm32T6djqYM5TLzdIkEnk=;
 b=f3dw4iQVSUurtQXb6XwbVOHtmoDA0etV25le5ZcGcY5CM/eG9AFGYx+MBFPyMeHHBylBqgatP2rflo9mLYWQ+MCEsD2VH0+Rh0E6HimvS4lWJe1EIpbgF+wd/YtJzAJfgfEhITEFN2ia+ARUEmWzY5fseUv+DQ78ceUohddGQRtziVG7mdJLodtTZRkIyxTlfLENU3tqqJpW179LHq7JFv8CEN9XvG8ohmwUPcXBbWRie48UY6IAQWtzqRiobrnIfweGIz0pFNGbpURjxJtST5KBiMLpfS1uDm6KO5yAhfDgmDhy9nntmARIrosddrUaEjyo55MpSBmdPJnr3jV9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br/yZou1U620v4xByFhSpASm32T6djqYM5TLzdIkEnk=;
 b=EFKZ3AP5pQ7Sf87GdCRNPR6hkwJ6O/WiySEzpgvN1FlTrsmvX2TzF6wj7iUNC3IlqXg7QsorXyKcJ/k1w111Fggs7DmV0PDN6U3rnpdkQZszX0z/go2hcccc85Xt3aEaDZrWp2MOkLnmYasvN23C2EDd3FJtTsar4VxoU4oHe2k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB4958.namprd10.prod.outlook.com (2603:10b6:5:3a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 11:47:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 11:47:13 +0000
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: t10-pi: add MODULE_DESCRIPTION()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com> (Jeff
	Johnson's message of "Thu, 16 May 2024 17:15:06 -0700")
Organization: Oracle Corporation
Message-ID: <yq1o790pv20.fsf@ca-mkp.ca.oracle.com>
References: <20240516-md-t10-pi-v1-1-44a3469374aa@quicinc.com>
Date: Mon, 20 May 2024 07:47:09 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0624.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e97a4d1-e00f-4f1a-9ba1-08dc78c2973a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6owSKVY2i2sqM6o37e2RfPxi02uq2AiFfHW1TEyquTayYN+tE16N7qYejCru?=
 =?us-ascii?Q?EwJGSk/VdUdbcF9Q29AI1ayAvb2IpQR7Jsi1jEvHqbgEIuwBIJVF8boVz66o?=
 =?us-ascii?Q?DwBppRjZJO5tbX/nKPI11Q/o3dfnPot5nqJilqxGAFHRbtsQm5VB0u4hHbrc?=
 =?us-ascii?Q?+FmmGGl1UNSsKe6Y0fxiL38TwL3JmeQf6j/xbff+Dy6zotepHiRLJNmLZYI6?=
 =?us-ascii?Q?VIH5uB56ZWGEXQWvk0vlNoh/hIusRnsOSypnUNYp13/HRKC3fC6JSpoLj4ZA?=
 =?us-ascii?Q?2OZCo0TkB4zR4FBqLep+i6Z9InmiQYYYGs2QvVztzLCw+tk3noaocT3Ku+GA?=
 =?us-ascii?Q?L88TU/bgkzqslEAnMgsbcnUYhsp0Uh7vHiZBabgL/NtM6TjiNfJGaGTyd0QL?=
 =?us-ascii?Q?GMYlWmXXgdYuqPADGCH9pSgjzMg3jcGC73IycOReIvoucmFf+qYRU5Fe3abn?=
 =?us-ascii?Q?uz7oQEhyS5AEtNajhXXmBzPLD4HIdnAkemSTOcgfRNVOtGjE9zlx5qdoGKRQ?=
 =?us-ascii?Q?aK4z1ZxLG/i9kpsrlUl04fE5ifwMyEaL+QRRlYFCTFw6i7t50w64eYPBzLVr?=
 =?us-ascii?Q?AmOejOzkNbezbRL2sRfC6OA/6camfTHkKnOx0YrM0BDlYgA8C39VGHsiDeW9?=
 =?us-ascii?Q?TQvbSSgRLExA6EkFaj2MaPc4RUwNIvO3V+5TFVKunaOejwQLlgcb3l8AkhKB?=
 =?us-ascii?Q?Win3nDcTsHtf0n8uZaYq8Xf/Q+I+e3fz4i9rOkXuKG1qQPBaW8uXzyJZNPKH?=
 =?us-ascii?Q?Spq9Qlrui9g2OZuVbA8Nza3PSv/NXo40PbsohH3XhVaQmlzPIsPHMBisILp8?=
 =?us-ascii?Q?1+04Wo/3tjew3qD1mFLnt8j7EXRsraad6xi+PFsJRsE6G73xXOcsI8FBFaRn?=
 =?us-ascii?Q?p7S8Al9bIUIJhYVVDu+2slc11RgP/6ZYgCBL8TQvb94+wVgJd+Q9DwF77lt6?=
 =?us-ascii?Q?bPRlKIO3Rea6gF+aqG/Yzh7KKAaquuQNv+GBQM3hyS7N5cMNTjoqB3N1IWGH?=
 =?us-ascii?Q?3/kuZBR022Ugpj44WS19CX6GqrsUqiS5eSsCyi8mW9OEPk84/iJB/jaJRRII?=
 =?us-ascii?Q?vmRUYxkXILkll7oTtijpyey5IcTPysFAuegkk+s5SV83tvR9c8lk7CbPZFNa?=
 =?us-ascii?Q?uDTazA4PFt0iAgp0pc83tFpDssHo8Zp7LhGIItjikgBXECOOJvv2n3egzxWK?=
 =?us-ascii?Q?x5rUV80zmgC8ujBZ4/qrfnz+Ng7KEN5sjnv+IGdGb+O3L6J8n1lPGQ6lJN8o?=
 =?us-ascii?Q?w+Fk0jLanwqytGXJ4pZphQvsfZjfzqV212j314rBNw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zqhLfFSgg8oV88apUx1lIxlEufzZu4FVzsJs2hLBMtZCmp9LoIzV/k5PgLXh?=
 =?us-ascii?Q?yqqoy+8zNsrHBqVfRaWVNVXOn0uFmtiz02M/jwbWfI4GL9hC2172uj8OK2DO?=
 =?us-ascii?Q?eqJuNYkKOx9Y7sAfuljojbjffAB72ZEUbIJLwO9hbil0e0rLISepmyp/D3M7?=
 =?us-ascii?Q?QFyEs4ObbDHXUuzxcvJ/0oET3guQCUcRecEks41HLcrczQ3M0BH8wiz2bPZA?=
 =?us-ascii?Q?EYgW+gCbAaXzntFcHM2fVA10YdnqsvLwCbY0C1eoG9j3McSZy3GrcOGr1pKJ?=
 =?us-ascii?Q?khgdaI6ca6axeG4aJaHGSP3UGwRObELzJRlNsPHyMjqcR3iw21z1XWiRUm7D?=
 =?us-ascii?Q?BRI23Dmi8rBybCQ4r/k8+xSBpxE+6tn5sv5NRfcHGdpoR1eqNud9pEl8uNuI?=
 =?us-ascii?Q?YPzkr5mPKlXK4wT4INa/GxghMVjF4LIFSDMxI9opZsZlQe+/CTo3Aiz9Olj1?=
 =?us-ascii?Q?WNx1IXGs4d8RjJpGLcRTJFpH72aaCSjTTHkioISMYVrxRsA4hP30Nkngtttl?=
 =?us-ascii?Q?p12FLOyTQ050V0QELNMMq8GpBtP1nrv2rsrMig9m1RbSgvsxsUzJ1immxAqq?=
 =?us-ascii?Q?xFYn7P0w5hCTFC8YoJdv+HHdd9KUO+ePF/oLr9bmj9QlxLEbmbBVMuptTtL2?=
 =?us-ascii?Q?phca+4p0KuXrOWf4c4+Gdza4APatIT0rnSy1GUoAeSw36NjYgpZXEBRmyfW/?=
 =?us-ascii?Q?NwIY125QPkP9pxIarIp8rg+Q5RA6LErYthoWueMJPh4R/Djr3r21xMAFHrjM?=
 =?us-ascii?Q?M7VGJcBBalRAaxU4Ldqsf1CI9lCFYgYiMbPs75WQIy4o/Lseu3pjTo0vB/Xj?=
 =?us-ascii?Q?0oJwcGlM6SsOHGw4C5uKiJr6CcyT1hQ2QyBjhmuQK3pLfwvRqRThygjrHb/L?=
 =?us-ascii?Q?nak701HpYp+TJHeHNZKkas5FTXbthtabXqz3JtJmAv7WWUtS4u1Rsvv11kuN?=
 =?us-ascii?Q?GivzT0/aAqO7POmXwNpMxqyb/oRXGSPuHMA5a+4clDuAIp/mSWPLAPOE8mcV?=
 =?us-ascii?Q?5BAvu2MawAzEFIssrJzXRmN9nvXb66Y6pMIKNWtx8Ya3AXUb53Dc2O39Dvhf?=
 =?us-ascii?Q?LKjdM+pWR/CcnVcvxrFtgx+Kv7hClSW53vPhQrJLlJX2iXjdpXvnqgBj4isF?=
 =?us-ascii?Q?T1Ruki/t8GnEkIEZGBwa6o3/O1Hr02zBmo3LtZeQ617ondpwa0g/SHLvPZGh?=
 =?us-ascii?Q?PCxAin7pP5V62MHU8WSAshtQGazMSksZQo6TFtb4KtXWNCpvH0A7676tYMiC?=
 =?us-ascii?Q?pnWnXJlbOQnAd2nbTMeNBOKqcldoZlE9Stb4Q7+Ntzfa3guwT2JlQKjrQKgx?=
 =?us-ascii?Q?A+rwdXoydBDym8vvIPQ0UR+Ni+leTgt8Syv59hUEKUmmVp/1BR4lN4FMCiMa?=
 =?us-ascii?Q?2xyKrF2uuAsjrHtQFfvJW8L/lktGmNjW7wDut4+xgirvu8UY2LRsKL4GPUuW?=
 =?us-ascii?Q?XEhytw2jv163hd6klvT0Dijp+derRtiXWbq87VNOc/412Tvu8awh8nRt+9HQ?=
 =?us-ascii?Q?z91Elk4Yo8gYRgKqqcSfYgqtvSoBPJbCXFdMro3cOdHnuOTdt0Ip7DnoMy9C?=
 =?us-ascii?Q?0zZLDdUToPSwqqoEvp2g+reEP0uBmt3GjyQ75Cv5aLflxjbTiEk8sCD/qA64?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1yw1pY72OOfWQ44AVjXoZ3Kfyv6j+AUQDbdBY5WKLdmyu+RMJLTfaByYvWMvjnn0o4Vvk35GayDkxT9+B0Uv1cUDYZ/42G8gIKuBwjGitCJeYFZ4g+h13r+KG0+rEQLrr+HMR1lzTb8BKeOpzSueRKOjKuzICVOkJxJXGPS4WsHUwj5c7QHK/69xS4xDbhwINaN5/9Y8t4xTPy0GtlyKvDAGTFShoeQsiYSe0NIYoLsndoeSctF7J7EQicdMkvRg9bo8OSemyt8RXg1Yaglqo6vlUHEILn7D8YuGjcy4SLEtZrBvXLegAyJbDMBgF6tjxmtxIJvVQmsqorOV5u49OG5j+CO49coO7neXWoeAJ9dSbl/Zq1WQKM1nlT2/85EFmsjDzQ64692RZSprfRvEWTgKaJs9Y91qH9YA1cVNh8dA4qLqYAu/XlEF/WQRFrE57zBjouoqk+bkbsPQ0FVP6Niot4oeNLitH+Jys4WE7jXH30cIJ+zQrWDMNX13G5nOwJGe7Fd6+WnwfvNhqf/3md4y0Or1zFzPAcOL3pgrKOteZgyZ8LapFZ5WVoFd7Uql5PQWj5piT5U1ujdP5PYmQxc7CCumYrweXqmmueaHYG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97a4d1-e00f-4f1a-9ba1-08dc78c2973a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:47:13.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS4bX9IzavfrrNC3iRp5G6G++x8KvLJWeouS/YOvAPRtmYdBVN9bp+vG5bHHmAO0PtER16E3YP1xNkZ3zqSAj0OVemCImT+/GcyhvZ68mGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_05,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200098
X-Proofpoint-ORIG-GUID: 0Sb5rwKONbBAoHSqvv7yIiegs1_3hhCF
X-Proofpoint-GUID: 0Sb5rwKONbBAoHSqvv7yIiegs1_3hhCF


Jeff,

> @@ -495,5 +495,5 @@ const struct blk_integrity_profile ext_pi_type3_crc64 = {
>  };
>  EXPORT_SYMBOL_GPL(ext_pi_type3_crc64);
>  
> -MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("T10 Protection Information module");
>  MODULE_LICENSE("GPL");

That's fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
