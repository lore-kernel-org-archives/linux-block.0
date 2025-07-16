Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00052D63E0
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666577; cv=fail; b=nHq+XgYRcEHLagQdq3kqyCp9r2KQfakGN621tHLXxFW8H+G3IsVqiy8WPOfrerRx5bBA0gOBWxzJe9l4lQvaTstDdWIqjYuEVrJyYdagLIEGvOr2l702yWBK5R3zX2TaMfwIRwfy1HVnURqVzZE/cVceTh4VLpTdpA4ZJMUXrN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666577; c=relaxed/simple;
	bh=gjarCtWafhK4MAe5gmH8TUI3eMZ9DvjQCIKfb6Idun0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TN2acN1ZoKt5MjeJqVgmKBtvoluVfjv4axvIgCGcCK73YjkFg5MZysuHvZ2hbtlKd6xrgvlVOK5ltGuqOGzPKu+RXo7OA2JQvSE1Jjs25vXBs/1R5WGSQzPP++jyMYIYgAzGv42Fj5jjnZLCqcO/om3+SEX9Zsn3+4b//0iYWFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b6s9vswp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Je5YJCDP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6s9vswp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Je5YJCDP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7fpkl004640;
	Wed, 16 Jul 2025 11:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qE1ZFl2ukBz0Cx+AqtB14A2QdmoWPrw25ZEudJuRmf8=; b=
	b6s9vswpqCT69E2stCVG4l1n/NIhECMhe7zA4JKF3bnu1nau5GOeDJzwiMy0Qgey
	1zB5AQy8TBVp/LjTD2Iz7lJZKzYoOBbk86PjNI6gBaswRjEsEOHjP/q1gsim5G79
	Vv8Dh689AFhq/6WngwAc9lIJsEX7cOaVEoL+dJpTPdUIbOZzljjs80cKiYuQcNXf
	1CKxULPZUgSPjVHr570CY0+HhgNNFnEU5S8GMzBQl6tegV3QLfKgfKMF18bRatY8
	etWp7H2WV6AD/M0if65l8XVIp9+o0Lta8rwrewZB4MZ87mEL9JtUXuvZX5UySYCf
	71lbI0CyOE3SmQPG3FpIsA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx80xt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 11:49:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GAQrWT011562;
	Wed, 16 Jul 2025 11:49:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b8ne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 11:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ghf7XuW75lJBmMwv3aQP0PoxiwW2ZlNds2eM7ojsn0zZkyE7Zb7pqkiMwFCvn4oqU/eHRk6xCfoQqwS+CvnsSczTlYFL4jR+vsp7ytembk/PQ9PS/TzUN5m1AJl5uwwCIcIdK2D9kA9lo1Vdq/olZIjpX/AVtxb0DEGTYJARDvTvDpmwe4x2qJj2lbCXmJztjtXvxKcaAlCXBA4/GZclBDbbZa2mKQYUPhU4/v0wBSUjTICToSWlLIM10/SczBNHpYYP3BGf5umW8onRCXbHFXs+M1/9jQY2lF40FwcPW8B9Bt6nFHkV2mnAASLuuctYTZSMAAv8zKITWqTQJZ9iBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE1ZFl2ukBz0Cx+AqtB14A2QdmoWPrw25ZEudJuRmf8=;
 b=S+rbf+gGJtyDXzqmk0gjxUEydcRs+knW5V6u9f2bIaAf7QV4p28apwtBIsdn/SX3daYjIkpPUugjQZR2baNWdZZeCxHLvPV0HM1T/bRzHB+WG5HF8Rf2OOZBlfLEXZDfD9ERbt8RrzBxra+oV7H3VUJcFPG14RIh5AKnKHimqYQ4mMrEWAAQbtPSqkWAMM2OQLBezBJC9dzeXpmin6MzHEenHFHZjrD1y+V+x24Bmabd12U/kJfm1EBgSyteN+dWy0KtKLSPcGsGY8zM34dMcWXL1uivPvpMPaRv7j1NikZUlArMVIV2QmsLgZP6nNmSoyBgeThMuj8HJnPv8dSs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE1ZFl2ukBz0Cx+AqtB14A2QdmoWPrw25ZEudJuRmf8=;
 b=Je5YJCDPbJyC+RYX6qRLMrtI539FMRV5wl7LYTJJR7KzD5nQN8OwTaye+cRYM2dpKgmpNBqdtO6M2TzjTKvUc1XDPczyOo/xdK9TXvYhx8e7g5PpgwT8jNttDV1dXO6MODab23mD3hz+Sex9ntqwPsR8mHkI9MSsSBRx7fYoLV0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 11:49:19 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 11:49:19 +0000
Message-ID: <f8bb19ca-5e16-491f-9542-51fb44adde69@oracle.com>
Date: Wed, 16 Jul 2025 12:49:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] block: Improve
 blk_crypto_fallback_split_bio_if_needed()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>, Eric Biggers <ebiggers@google.com>
References: <20250715201057.1176740-1-bvanassche@acm.org>
 <20250715201057.1176740-2-bvanassche@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250715201057.1176740-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c446332-cf8e-43cc-7e62-08ddc45ecc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkFJcVZVNVZ1b2pTdTZpR0p2MXJoVW9qY0k0c0NmYUlCekxVYU5DNTl5eGZU?=
 =?utf-8?B?THMwY3gwSzlWVTZQMWp4UDIrU3hCWGxpVjRpTmRSUnFsNStsZlB0V1J2cDF4?=
 =?utf-8?B?eXV2TElzeElYS1ZmOTR0ZE41TjRsT0w0dFpoclZLcVFiRnV5N3hMVjNQZHR1?=
 =?utf-8?B?T1pkTllUa0V2dDNqS2R1Ukp5WEd6QVc4UDhMN2tEaUphZlkzRjBHa2hLV2Y2?=
 =?utf-8?B?U1JaL2hoWWtxR3hrbWpWR1dsQjYwN1NmMkQwajUyaEZLVTdGREJreVZBREFq?=
 =?utf-8?B?RWI1MTRNd0RucDdDTDZVUDhHVXp4dkVsZDdsZHdEUGExcnNQbmN1L3lUOFMw?=
 =?utf-8?B?RkpZbXlDc1JaSGdaTnh2R1VYMWxMdVFUTHFGZUt3ZTE4cStYdlBZRDJ3UzAy?=
 =?utf-8?B?cGpMOHZNeFk5ZTI0Mlc5MlBLOHZjQjFKbTYwUHROSS9MRTF2TTR6QXVyQXZ6?=
 =?utf-8?B?KzQvcFBvNmJOOGsvRDg5YW1EOUJLdUdmVW9TalpHQ3NkR0tYZGIweExOUk53?=
 =?utf-8?B?OWRJMHpaZ2xDdng4NzdINGFUdVFjUDhqTjNQcVJrUi94bVZkRVQ3UFJaTVJy?=
 =?utf-8?B?Z3N5MG5xUFliTDl6K055S2VrSDdjWk5WNE1kRWQvendTVlZRTkJBanVIaEpi?=
 =?utf-8?B?am5rTEczVTlBaWxlWlNTRkpnanlpV1NDekN5VkQ2YUljZTMrOU9idFpRRGoz?=
 =?utf-8?B?YUh5TGtmTXdMR0tHZXZ4ZEI0U0VGbi9ZeHBzNGF0amx6NDFEdjhWWTVQQzlR?=
 =?utf-8?B?MmJTL2FOZVVXajhNZ3VrOXNibWpkbXhJR0dhcjRyMGIwT2MxSHhoYXJRZTFZ?=
 =?utf-8?B?dnNVUGlaY0dRREovSXFTYU0yMUJNUVhmNnNrd2JrbVMxVXFXeFZyM0dzbjls?=
 =?utf-8?B?cFZmekxxcW5RcTl4UGM3RVNxcTUrQUdSOGxZTjVTeUFlVHUxeVJhckR1ODY4?=
 =?utf-8?B?aXl4dnpSV29odURodlo3STdyNXhNUmdLUDlVMmVnakZTckVpRVQ3WXIvNjZM?=
 =?utf-8?B?ekpvMW53RDJNeVdmZ01zamJWaG1HNDRibHU4eEg1aUMrV2wwaE0yd01HTm5X?=
 =?utf-8?B?RkdQSldEQkN6WDVxVmFsbS9mVzh5UWxNS3BzbVE0MXZ1SjB3YWRTRk9mTU15?=
 =?utf-8?B?TnEvRzZuMWpCNXlYUmduYTVlbmY5OWJacDBIRDMxVy9nTnJWUFlNUXQ4WWp4?=
 =?utf-8?B?VkRpVmRTQW1xTldFMmhLb25jbVkvK1ZxRHludGtObWxDbE1oU3JUT3paa1Nk?=
 =?utf-8?B?b1Q4UGtMbXJZQkxZdlQralp5TllsWWtOUTNTSXdQODlBS2w1eGdTVGpMVXlU?=
 =?utf-8?B?RGFRWGJQRDdwcWJGNFBGZDh0K0lDaE5jUFZpQlFnRXNyMnRFalFXcHBMKzNY?=
 =?utf-8?B?aUVxYThWdG9reWRkSnJRNWxtUUJ5bDN2VE5USzRNR2tCbXVqM0dNVzBZS05N?=
 =?utf-8?B?MGNmckRvL0cyRmxiTEJKd0VFdkhocVpxekhralkrOE0wVm13TEFzRG16ckhO?=
 =?utf-8?B?dDd5TWNIcURGbFppTDV2b2FwbHJtRHdOdEF2WFUxVlRmSXU4Y2d0YzVLcnlN?=
 =?utf-8?B?QXU5VFVvSVgxWFprRWtQcHZqNEQzbFFpbCtzcjY3WHRtTTVBUWxDamFibkhW?=
 =?utf-8?B?eE9xcWhFdGpFMWxFTVgydEE1MElaQTF5eDVQbStqcExjRzlnTWZyMDRScmZP?=
 =?utf-8?B?czQ1TGJwUVJYZVlKZldzekJaOGVlNjFNMUN6cHBOZHIxQlFoUkRrblpSbUp2?=
 =?utf-8?B?YUpzbEsvY1JSWDNQdGY0M3MyNjYvUzZOa01ZQXFiNzMwNG1MaWhuQnQ1SFYw?=
 =?utf-8?B?bThCb1VTNkZWaUt3dUhhQ2d5TmpMTUlOSElOY0VVVHdBNVNrQWNzeXJERHkz?=
 =?utf-8?B?ZXdsUU51TCsrdE9QR2crRU9iMVNjMWZDVHgzQmJpRXZVV1RvWkU0eHNhaTho?=
 =?utf-8?Q?c4x78PwDznw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS9UeUlwWTAxMUd3NVVIdU1Od1ZUQklEMUJXaWlhS3JUQmgrQzRIT1p6bW9U?=
 =?utf-8?B?bUJyaVZOSkVkSEo5Wk9tbWU1aUE0QW80WTQ1MFVmMTZpZWhVMW5RUnFnNjBX?=
 =?utf-8?B?QzNvSld1dFp2UlFraTZtYlBOL3lZMEQvSnA4YThaV1FVcjdla0JVdDRTQXJv?=
 =?utf-8?B?MDk3aGppZ2FQQkloNkpubkxYdjBQZklIOFlzcHNpV3UvN2JOVFpveFhUQ2RB?=
 =?utf-8?B?bkZWUVBRYVhldHo2b3JrUmZsT2k0MVZ0MVJkT3RZdkxDUmNML0tOY3VXajhF?=
 =?utf-8?B?TFdIY1E2VlpLczIrNUUzRW9XTnFuQmp3Mk4zT3RlWnlsb01wWmZTcHJibDcw?=
 =?utf-8?B?VmY5ZTFzUmJiV29oNW0wMjZIdmhwcGxIQWJLU1NjNW1LRWp2QnpBOFNpTVo0?=
 =?utf-8?B?NVN5T3Q4WGRTWXBVMVZjSzcvMUhmNkZoVnFzSWF1VmZvVzU2ZEtWbVBUd0pR?=
 =?utf-8?B?Q0VwZk5UYzQraFdJV3ptRDFWWWlpd2tURkxQdjZmNngwODBEdkFnSHhHRlo0?=
 =?utf-8?B?MGpHdmdybGRyS3d4TEZhekFpZW5MeTFscjB1L2piN0l4d0U0dDRTekVBTU1B?=
 =?utf-8?B?blB1b3Y2Mm5lKy8rR2ZCVEo3ZyszbTFHNkMvRURQd1hIZ1d2allpSEc5MEpL?=
 =?utf-8?B?UHptbnM3eVg0SVFEOTdvSURPZEdMR0lnN3JZc1pLbjJVU2k1am90RzJ3YmZi?=
 =?utf-8?B?TU85Y1k3S2Nud09qVjNCNUE4MisxaVlFMzA2eDRnT0k3dXloUVpsWnpOTXla?=
 =?utf-8?B?QnRRd05wRWhDbE5WelZOOERRV01yR0tKWXZKcU54cVNSMEp3K3dDQm93RFVH?=
 =?utf-8?B?RHFKelZ3OVNGWVpEV0oxR01qVEwvT0U5RTl5a0h1bC9rK3hLdk5QL2wyaGV0?=
 =?utf-8?B?S1lVQU12UThvb3dDblUvVFRBeW0vN3psQ211L2tvdEdncDV0UjhZR05JL2FI?=
 =?utf-8?B?ZCtwdVUrcWU5aStJTkpldHpqRGZnUzl1dis5SEMyRTJjKzIxRCttb01tSWRE?=
 =?utf-8?B?d1prSTFZa2dvTEdlZmdvd0UyQ3lvc2syK3B3SjhHYWRqaVp1cFNXMTRiSWU4?=
 =?utf-8?B?aW53dUw5c3pwb3J4eVZ2N0tPK2FOR1ltQ3JiWllHOTFzU0N0U2hlQjNTUHU0?=
 =?utf-8?B?aVhIVjdDckhDNW1VUEMvd1B1aElCaGxRUzdmUVh6TGlmWXUrYkdLRDR2dWlI?=
 =?utf-8?B?N2ZXU0p2clUzLzJEN0FpcmZBN21lS1hnUGM2d3RhSjA2SFFDMEJjQUdBSk5O?=
 =?utf-8?B?YVg4UXUyeTdEN0dveHJqaEE2RzRHL2JLVGp6a3RDRGRwaXdId0dUeGZPRGxL?=
 =?utf-8?B?NnR0czNBNHZTQVJZT0hPSXpTTWp1bXYvdU84dDh5dWhIZGljem9adGJDcUNT?=
 =?utf-8?B?cGhZVDhadXQ4U0RWcDgxUmlRTFZOZXBFb3plWXRkSTdna01USG9rQVVmSXFY?=
 =?utf-8?B?QndQYkdlbjhyY2pjR3MwTXZOWEVnZGFCYlZrQmtuQVZLVE9ZSGRYbTdHandT?=
 =?utf-8?B?Tm82cVdHV0FieU9OODQ4YldZWkVMUk14WFMzaFR3bzNRek5uZjdGVmdoUzJi?=
 =?utf-8?B?VTJqTFJMeHJRUjBqcHRCcFJlbk5JZTR1Lzd1RU9pS3U0QWNsOHBVeTlyaU5S?=
 =?utf-8?B?NFVoNFdkQVQzN2FSSUFXOWQyNVE4RSs0SkpvNEF1VnZqUmVyM0x6VitkbkY1?=
 =?utf-8?B?LzlWb3ZvS3NsSlc5TXJzRzRIODcxbXJuKzFnQkNwVU9Dd3VwVHVnQ2FldkZM?=
 =?utf-8?B?cjdOUEZFbTRIWVNwRzlPR2ZoK0Z2UDhjeWZPdEw4WnljTkJRTm1pQW9pUTNy?=
 =?utf-8?B?cWpUTDdrQStJbmQyTVFvdXJxNHZ4U2lJOGgybWlISzNmRk8vT2xjdm5KcnR2?=
 =?utf-8?B?OGwrZWM1c1BEejJ3YmZGa3dnbGVrSCtKYlFvcEo0Rm9jWkl0NEUvY0QvUWdL?=
 =?utf-8?B?Zzl1ZU1nMGJRVXZIQm9hTmZoMEY1ZmNnOEE1V0VQMFZxV0ptZTdQMG1ES2J1?=
 =?utf-8?B?UmVIcWcvZ0YyOVMzOHpWVnl6cWRML3V0N3FGeGR3Nm1ESGRmQzB3c25UbXpa?=
 =?utf-8?B?TEEyc2p0eDdySEtMZWFDTGZqWEhtVXFSVzRHb0UvWHY1cGJiUytaSThBUE00?=
 =?utf-8?Q?PYg0IJWEmV5rpW22L3BBS9gDI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4lZzcMCB/tUHiduoLBZpwK0v7kQFnBMlSuYE2SRr3blaFBj1YzMQpfPv2Gg1hEV0qEE1yKDzVS4BwSFotoKP2t8VoBcxgZSdUwr5xe3VN0UOi1mzJp0woNEPi1zxzaFqMsfjtmxo6dGNyRozHDrtFQT2B9Zl/s7XUFMS7SmDXGWHvUgdjBYdwOiuCDXObZFBBX/jQ4NvwQJ3WSncDQ/D9Y1ScrlAkLYu6GNcpx77bUy6wwK95BbwU0ig2O/QQQypiQS4GKVTtesMoOckLszAydQsozmDgxQpByfKnfBgGNkALuRVoS60hC/3o4LjIrPj7YeZ24outO1w+AEQOwaMXGl1IQBBRvWOjBRi3PnIoDuJBqWaWnwQuuHCExmfAwj4uUmuAXJSgqNBKJ/nerEE3QYF/Wh+vPMrN6ECvEYHfmAzatArmTYbd5Qs5cy2aoEazYGmVx8r+nxEZdkzqOUrEHZrHrM8FDsaW4bOGoPnGjXZtvV3IkxySOj8yYS6/QDgxlL12U6QFJuKZDkOqhIkRc1yJ7hVbS+SkVKrwyQUNau4J6LPTFBHtTS5vUZQqaRfOWdtrYb/I/MPbfNLjgd+YAXRLa5o+ULEkhgwnjrMs+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c446332-cf8e-43cc-7e62-08ddc45ecc75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:49:19.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rWF755NYyJnF1aMjNMOApLN6IlZojyEfc9nRUqoa7OxSsiIW+IM3Ov0kNZ57fh0pno8+/M1+aapPdPiMMwDxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160106
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687791c2 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=N54-gffFAAAA:8 a=T_4a9H50V7IktCrcgYgA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: wOv6C6LscVExqlUL1zEVK20e9QIHvg2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEwNiBTYWx0ZWRfX7hP0pstYAVQP yBLWpo2iUPflIx9mXzNa6Eh0/OYGbcP1pMbBzNsV2k0VKoennqTvPXKRRlykcEnmks1g/WlVDCY KCf1RRUqxWkvZklfBl3E+sB8iBSjSgQTJNjtEMNwDJZUKAlpE3671wgFq7MitJwi/2uePG61M0g
 +t+F7ieahd07Un44f+tH4Kd6CA4WkHfjeXMM8834utdXrHYAL92wuFvG6ZqAoi4kkGIgHpcjjJu 9pwBkY+X80qSmm+Tjd72SEg/AO0vwXb0LL8adYZDO//F5q8gV0jlGCcghFdPjHULRnPJ5KD2xWg SryAEf22Bpn8Yjvvsnr+paCbzBnxStLfnExUQYiAWfWB28UHCblSSJlqvbHQ8r3hKPRzPA/cgwb
 Sbrt4zHE4NwaOGz1IGnAYm8/J1bl95JwJ5DI3MmlxWYUpvKUBW9QLa+cOO1gJ3HIe5fNqxah
X-Proofpoint-GUID: wOv6C6LscVExqlUL1zEVK20e9QIHvg2_

On 15/07/2025 21:10, Bart Van Assche wrote:
> Remove the assumption that bv_len is a multiple of 512 bytes since this is
> not guaranteed by the block layer. This assumption may cause this function
> to return a smaller value than it should. This is harmless from a
> correctness point of view but may result in suboptimal performance.
> 
> Note: unsigned int is sufficient for num_bytes since bio_for_each_segment()
> yields at most one page per iteration and since PAGE_SIZE * BIO_MAX_VECS
> fits in an unsigned int.
> 
> Suggested-by: John Garry <john.g.garry@oracle.com>
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")

is this really a fix?

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

