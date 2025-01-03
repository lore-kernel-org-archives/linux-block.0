Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39711B2186
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892598; cv=fail; b=k7quve4+qP3xGtXQ0rKliIDlYiau2IpD7tWNJWoyMgyXxUn6cZ0XDvB5i1bWBgw4dwSvT7P+NpMOruk5MuLtJxrcHXdu8D/984nUTCjXj+S3tlU8wcI5YGXinYouqgh++QvIR/7IaD7JzwDCLWVcWJxTFD6KVidzkONkFHolH7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892598; c=relaxed/simple;
	bh=gAFR6HXfODiWHeOw4skxYcZLZdLJm6wM6O9Ks5L4FqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FrI6wqWTdCJbYyIldTDLFwl0V5nx7O9UhUGS27w1+FctEUbD0r/LrWPss3hA2cQb/sljXXot3KSeOe0yoe35PamRHtSQGvDT/6SxFaBlLh/MeEyuGd5QMuXwMZ2cjUpRVulAvdk3Kl7KL1arFBnyTnRyYPo2tlJUIenj9dDr95w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kU6TFMZN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pv1NIBTN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kU6TFMZN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pv1NIBTN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50333Obq023918;
	Fri, 3 Jan 2025 08:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+vEm5MPcVOy+0HxLA7E57zGjCgsndZkOAUJlDrpjr4I=; b=
	kU6TFMZNUkmlu7hc2j+zMOhbgzyKiYlAuCn5e8j27SRnPFDWc1mt82HBt3kmXUr3
	BQq9MVMGfYtttG4evljyR/7SElDmA/Ll7cVGMra+Tdy3qu5dR8b4G1JLuqQfIras
	zHOtSUKCfNtBElpL4G9UORdnamOlbdAXOUoFHSAYXdm1sn8ttmf+0cyPRW+flwRM
	c2TSvpXGOyu4/d5hDj5jfVgxKk6HnZrNz73Xx0ySBY32gUW3gF1KPmcptwnVVIPY
	nPJKDe8eB3+2rItKFdACE9rJykibH8cysYPUC853AEOJ1Nequ8pyi7gSfPjJCw02
	2vfPUXp5vMgZRVMcDJ1MbA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs7qfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 08:23:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5036m7br009245;
	Fri, 3 Jan 2025 08:23:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9qe01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 08:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPAnQuee6RdzqVSq/BebBXgY2O/vvYFupYP2mBlIjffzHw8OC5Kk7X4kaL3YaY2Y2LeD3Yk+iH5LprwKSKqIkoVpfg5Umy0N5RdLJRkTcPI6j/LveFYS6m8McBL1n7zXUT8OBm/w4hdKXJzLf8HsgdQ/KzWdcFLdIhQLcUY/EC9NXOztfj0dbqCFP0E8jCt9Nzx3RDUfvdOloU8NBOujpgG4LNxwx3zOs5YgIbHKTqdR5sXR6o23PTxk4ejMy/L3YecTd22qPJyijkKIvgJdbZK1SZpVCVlg1ShPvuzKATGRhSFsdp/Bhb7uOjL8qRtG+bsgPG3HbfWTdpbOurT3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vEm5MPcVOy+0HxLA7E57zGjCgsndZkOAUJlDrpjr4I=;
 b=OC/txqK9S0XS5xlPCjVDI+aKYL90V4yDHkFXIXhAeZnQ8O0RO/wd2CI62nx7N30lSzvd2aj2XGNO6WPFxTZmog6d++4znpx/efaL+wzSt4gXihvXdmeJ9PbMgLWCZE2Y8P67D+kVRA41JyayjJIDV/cIYcfc9kAD5uY982kefsCeJ7JSbKMK30jKqNnBolevHYWw48hNOKvwLry97a3FfwLgo33B8oYGACPEb4cfJ356k5tA8fmHjaOBCCdgKGebzOrOnSufJmWzHPu6jX4S9aMZxYM64ogKJoXbzeyxvPn1tml1qAh8DW54hqNPCO9PkoYMZB98sUmOGQXglj/Fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vEm5MPcVOy+0HxLA7E57zGjCgsndZkOAUJlDrpjr4I=;
 b=Pv1NIBTNBwmYrp4ygTCJz3ZyMA0ujo6MLFvIj94OgitLNPy9+w6PvkYEJrnwTiSTucDLb0dixJmmpx4+nSlDzEn/kOcvoTbJP0gRqF22dCTe7/kIKWSncwryz5J3ZoAwNC2e2N4YrAvV3V6WJj5uylyWeNhRy9ot8Xsn2nIGrKk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Fri, 3 Jan
 2025 08:23:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 08:23:05 +0000
Message-ID: <f3852e75-dff7-4cc9-b64c-01ebf1020808@oracle.com>
Date: Fri, 3 Jan 2025 08:23:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Use enum for blk-mq tagset flags
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20250102144426.24241-1-john.g.garry@oracle.com>
 <20250103064427.GA27984@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250103064427.GA27984@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 707ccfbe-763b-44b5-e558-08dd2bcfd8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0N2VkFIakdkUkdCT1ZGT2FLNlE0eERrQk52K09ZRkFRWVdOeTJqdENrOXVS?=
 =?utf-8?B?bGtTT0s0R3BiblU5dTV2SVh2MFc2bmtzS3ZMNGdrYWJ4Mm5EeFdRQll2eW5o?=
 =?utf-8?B?bnZja0RrRTJGcnFPVzdiM0Rqc0txLzEvci90S1l4QUZwOGJwOForRkV3ZnRT?=
 =?utf-8?B?cVhtSlB1WitIMmF3SlFSaS9XWUsvWFZ2WFlkVVVwWStCaWV4ZkFHYVpvZFI0?=
 =?utf-8?B?Vmg1WlpubXFXZWRTZTN4L1o0RDM4Qm1UMXd3bGNzRGVydTlnNUVlcy8wWVBs?=
 =?utf-8?B?VUo1ck5oMlAvano1ajdXOXhObEorMlJ6VzlDODl1K1kwZGkxYVlvMTlmYnRK?=
 =?utf-8?B?UkNJaDIvNWh5cFZNTHphRUhhMWxaVHlPTGRlR3B4YllpRWw2YjZjRG1Td003?=
 =?utf-8?B?V013R3lKbGVoVklkVXFSc1orY3ZLdkRUMFFJUm9zb2dDdEhRQTZld0xmR3E5?=
 =?utf-8?B?THZCNTVtK250eFN2eWVmcWJSdVoxODRDMXd2MnZwWEZSQjNCN25jdXVaTElR?=
 =?utf-8?B?c0FZMFpGazhzWnp2aEwrTFo4bHF2Z3l2bGlPRzNVeXhZTGNzRjAzd0hCWk91?=
 =?utf-8?B?djN5amRaRjZ0aDV0TklWZm5HTjk4QnIzd0QxcHhWY0I2aFZpanNoQmZqTlFV?=
 =?utf-8?B?VDVSU0NueERsRE1iRC9WQVNYcm9TcHM5aHArNnljTVBhUjZTVWxxSHNpMWEw?=
 =?utf-8?B?N0lEVG9hOE1MbEkvcDhrV3FSa284b0pLSk1zdFlQWUZ0UGd3b3I0VExDTXhX?=
 =?utf-8?B?ZlFUdjBSdWFJa0Y0LzB1S0g2RENnZTFvOWpvaG5kK3VubmNnamNreUV4dUcx?=
 =?utf-8?B?RllNNlVnZmNhazhPb0l6eXM0QjBqY01lRzVBMjBndm9sQXlvMEVuQ3RySGJW?=
 =?utf-8?B?RUo4ZHk1WUFmV1FZYi9JeEVPc2cwUzF6UG5BMnViT2l4YU9LV2o4SDI0Wk9B?=
 =?utf-8?B?ejkybWlMQUU1REp5QjkxVnlCcmxqZ2pFMW1oM2EyMDNoRHRZWW8rUERZcGpI?=
 =?utf-8?B?M0hwMDVRMmlPSDlMVFFxN0dBUTZUYWNoaGM3M1dMZ1prclJobkYrSTdpRXRp?=
 =?utf-8?B?SURWU0hBZWZWQWx3cTZYM3BLYnFLSFhhem9Gd2k2TFk0cmx0ZkdnbXBHWG91?=
 =?utf-8?B?RG1tNzVOTkNvSmkvdnJVQWw0YUlPalhTT29HUWl5TExoN25rbnljeVVWUC9r?=
 =?utf-8?B?M1NDb1o1UWI5Z0lHZnhlejBWcEVBbFY1Zy94cTdNSnJPaHNTUkZQVUxiZ29V?=
 =?utf-8?B?VlJ4cmRhY1RJNitEL2R6RktzN3dIcEJCcGdhWW9teXlwYWFQb0UwNlRTWVFL?=
 =?utf-8?B?Ym43NmlGdm1XL3hTT3FmM29JbDM1M1J2SmxOemk5dXNieGVJQkZ0NzZqKzVO?=
 =?utf-8?B?ZTFZZHVXckNvN0llYjVBV1hUdGpQcldPdWczVUhMR3YxbUs1SUo3WHlWUmw0?=
 =?utf-8?B?aXd2UlN2WkcwdUsyU2Q5QVpndVJTV2tSZ3k0YU1ha25QN3FnNy9Qbm12NlRX?=
 =?utf-8?B?eVJ0MFptdDVlUmpGSUlxSnkwdGh2TTdHWEYvMGMzaXIrSGdaSldOOVMvaEIw?=
 =?utf-8?B?REwvb0JrV01FYy9tWDdXVW1PUFRvbWhSUUljSiswSCtQM29KY3hFSUZWSUFt?=
 =?utf-8?B?WW13d1Z2b0VxYnM3WWRCS0FyRnFZclpjd2RPWXVTTmo0YjBOMHNqM0xnVldE?=
 =?utf-8?B?QlROTlAzZWsyb1ZKSHVjUW9aV3MyNHBCeFJqUml0ZUUxNy9YNm1hZURGdGt2?=
 =?utf-8?B?Q0crQ1NQYUsveWk2ME9JU2RFeG5UT0JqeGZXanZzamFvakQyZm0vdXFFNnNs?=
 =?utf-8?B?S2czbWRSMFVscEtUU1kyeHRSQldxWlhtTWVNTzVlbktIQzBpM05UZmJoNVNE?=
 =?utf-8?Q?CARvlqWlPM6Od?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0d3anZKamZPZENHSkJORFdGdlJ3d3NuWk04UExZdWVEYTJCR2J1em1HOVlu?=
 =?utf-8?B?bk1uSDJ2anZmc0dwbEt1endjYXo4ZFd4c2VVNlVodUUrSndUcnVuRUJucWVs?=
 =?utf-8?B?OFptSjFKRGt1MzRwcSs1K0RHei9KblpOZDFTb1dNMUlKN0NINjBEclgzOGF6?=
 =?utf-8?B?b3JQTmVxb0hseVRGNzh2NTY5WEpPUENXSnRpOEtyb0R1YW96c2Y1UG9UNzU0?=
 =?utf-8?B?T3hBUjFLcVJtdWZzTG53cUpzdExWR24wQ0Y2K25uNDBpb2RzWjNrOExLOFpF?=
 =?utf-8?B?NVhZUVczMllwQm1NZUxJUmlUWExScVNLeXA2MFVPaXpsSDRJVUxsMS9Nd21I?=
 =?utf-8?B?VC9ORFIyTUZ4NUovczJsM29aNDBOb2E3UFhmMzFlYUNEMW81M0RaSHp2M1NI?=
 =?utf-8?B?QWFZd3daSjZrb0ROeERRUlJTMm1KVUViRDRycGh2d3ZPMTh4OThjaWdyRGJz?=
 =?utf-8?B?VjJndUFmak1jLzlVM0swWkdUY2JLNmlNT3FNWlZhNWZSL0t2TlNmVVQ3VExq?=
 =?utf-8?B?V0ZRd3hEcStLSzUyQXBwcklQWExDUzh5SWZkNlNSRm1NVEVNSlhva0QrMlV4?=
 =?utf-8?B?OTMyNXh4aktWQXpjM1BMT1Izekw3bU9EdUp1UVczeGVLT0ZpeW0yV0hJd3Qy?=
 =?utf-8?B?cTZNU2Y4QzhDZzl6L0N6SG1sbnEzWWNCcVI0NW9sdGRJZGE4S21QWTBJT0Rt?=
 =?utf-8?B?NVdJbnhkN3I0UEY2M2luWFgxR0xVMUw4YnR6UFZLTUtPWDR5Vk5EUlNFYTh1?=
 =?utf-8?B?Tm1RT0s4Y203ZHdMVWhsQ2t0ZDdJU1gwU293U0M4TmxnSm5pR2JVWmFxWStX?=
 =?utf-8?B?UVRQTmFyZmFmd3UvZGNnRFFuSW45VUJTeUN0dU91ZFVlZmpjKytsSVpVTVhp?=
 =?utf-8?B?RDlJbHpvMkRwdW9FNkpMa24rWDJNNnVWRmM4em5QLzJoQXZTWUV4Q3BJdW5q?=
 =?utf-8?B?enBocFFMZGVWTVFFOXZSOGFDbFdBTFhkVUxrbXJ0T3M4Z3FFTnpCeEhrb3lw?=
 =?utf-8?B?amJJWUlBc2R5cEpJQk54akZOYnNoazRrR0dtWWlTbEZOek9WanFsQmFyempZ?=
 =?utf-8?B?emc3NDA2QkQvMzZUQUZOWlkrMWtEOEhtRE5aZEdrT0FhYVhaNEpIWitrenls?=
 =?utf-8?B?M3l6YTJvcFZWSEZiQUdzenNIQ0phVlBVVEFyZ2lZcFM3K1BlOUdVbk1lOVZI?=
 =?utf-8?B?YVowbkQ5MzIrNU5oNGczVDVNNnJPMjJQOHVoL045dFUwRlppZzlOcEZMdE5X?=
 =?utf-8?B?WXhoVlRTdWZxbVdBMEpJd0lzT1dmVUEzdGJUaERLc0FmQ3ZaZkF2L205Vndn?=
 =?utf-8?B?U2N4N090eFNDM3A0dUhBNHA5NGwydUxBUC81dEEzelBMM0x6V3cxczZMdTY4?=
 =?utf-8?B?aXZha0RRYTlSS1N4eUZ0V1BrUWw3Q3k5THBKVWxjQXhrYWhzckZ1cWYxZXZ1?=
 =?utf-8?B?cXpPTGR5MnF4OERIQkZTNUUwek83ZXVwQWlXRkN0OElGTDhpTzFnUnVIczJX?=
 =?utf-8?B?Uk1tR3dRdGFiM0RvSW5takZMNnc5OFp5OXVuV0FOb29mVWdqcHQ3Slo2UUdO?=
 =?utf-8?B?dEZycDc4eEwvUCtPcW9QOG5GOHRPMVRKNktmMFFKSk4wb1Y4OWFacm02bHoy?=
 =?utf-8?B?ZXpwWkw3S252SWd3MEp3cmxKOVRya2VmUk5rRWtEMGZxNm9XMW1kN2hZNDRC?=
 =?utf-8?B?SmZtYUNQZ3ZpTHVJNXBQb09pczh1NlVGNmk3V0FGWVhLL3ZHejFXR0pldk9L?=
 =?utf-8?B?VXZhZ2RBZnBFd0R1RkN1RE8wOVIyYXk2eXp0dWNYeXpTcVdUVGplamlWQ2JF?=
 =?utf-8?B?L01oOXl4MURtVFRBdHRLbnE0RWl0eVJYT1RSVVlQR3RCY2gzV1RVRHV4NnpD?=
 =?utf-8?B?UGcwNzFNb2JvbGx6SUZaU01ZL1paNE45bEdwZmpkTGYveGNXUTA1M2Jpd2ty?=
 =?utf-8?B?M0I1THgrVlpTVWpmL0tOczNkMVpkbmkwQVNUSTBrdVFhY29lVXpvNTRjRUpR?=
 =?utf-8?B?ZHBZWGJkcmJYVTNvanBpQkxoNWRtdVNOK2lEUkRLTHUzUFdvV1RyNlUzc243?=
 =?utf-8?B?NjFDMWpQK200dmtNd1RZNHc2Z2Uvc1ZCSFM2cVRNWkwrV1l4RHM2WTNwN3I5?=
 =?utf-8?B?MHdXM1N6TCtUdjBqeER6MmM0QkFlRzNsYlJwRGhpamJKQ2htUjYvZ010ZjhR?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PgXDc0/ef7uJQXa3ZlG3FJmvqNXj4UQ2FrEs1M3BHrp/c9Mo6XQ4KAFQjyxCmGp1Ul6tA8VEju6+5PPG9blngUd2GLXyraqB+0AG4rGbZZtmLFlNOzTnkg307OV5XobrAv3oPZEb7CeF5Kbm59yKgWBcniYkGPZNy+AuYSsBzTJdBmcE0FEiIZ9abkX/68CXyRc4WLnrQ+DAIH+4l92H8HmRy2xxjLhgNxd5nADWP8NRSE/wc/pugl0G1ZAAk96JXAQwanJ/23hW4csoM8ulvsNPBdxML6MaJk/VVZVpqsdUNWnXPC4dE8F/hsAwa4mIEHKDMzVEhYRylinXKAgbVJQUaQgSTFfrdd4iS0ZpiUpMwFddVeu5ng9VrzDTXnHBSPYDuK0YuiSYsva9SIE1Yd4Bjn/WGFicmetVn2ERTz/Og4oTNkExS+EUClbCJs5nRFqA+SDhby2ImvjlvzFzA+4FiOO9bhb11lVKj3cPikPhIb2pe5Pa/Whi9QAIFa82Ym1S1gonOJoNVUFV670ZnGG5yDea6bKa9JYWWQa7pxgsir8Sc/7coGduTUeZjyFfW3WuFqI85zQhXSnetM3nRbudcboVhZkPQKsmvFYmrvU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707ccfbe-763b-44b5-e558-08dd2bcfd8a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:23:05.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa8rh4xfCbPHMlDX7bQ3n/ewH7G3lZSWR8i1HCGNn+U75S0lLl4HPvaFKLSmm9LTxEuxhLqyt+HgG8IKAn05qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=763 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030072
X-Proofpoint-GUID: OAVITo57--q6V2v7Qo8NcswyNHI29EMy
X-Proofpoint-ORIG-GUID: OAVITo57--q6V2v7Qo8NcswyNHI29EMy

On 03/01/2025 06:44, Christoph Hellwig wrote:
> On Thu, Jan 02, 2025 at 02:44:26PM +0000, John Garry wrote:
>> Use an enum for tagset flags, so that they are automatically
>> renumbered when modified and we don't potentially leave
>> unused gaps. Some may find this neater.
> 
> Just as last time around I think this is a bad idea that just creates
> more boilerplate. 

Pros:
- better to not have unused gaps
- catch missing blk-mq debugfs array names
	- this has been a problem in the past

Cons:
- boilerplate

A compromise could be to use some macro to evaluate the flags, like:
#define BLK_MQ_F(flag) (1 << BLK_MQ_B_##flag)

And have, for example:

.flags = BLK_MQ_F(STACKING) | BLK_MQ_F(BLOCKING);

But that will lead to churn in swapping the flag throughout the code and 
maybe also obfuscate, so I highly doubt whether it is even better.

Anyway, I've made my pitch.

> I actually wrote a series before my vacation to
> drop another unused flag, remove the weirdo policy indiretion and
> add better max flag checking while removing code.  Let me rebase
> that, finish writing commit log and send it out.
> 

