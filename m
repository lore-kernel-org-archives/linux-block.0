Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795597638;
	b=nN/9bBKIf159sCjC3TK4v/dFng0YdaTAIh40W3d2pJfIuQ/lGEpH0AlHIsfR1fC4rB/v
	 T6VRlaZKQA7WWoSU1ShoraTxnYpvixSK8cE4+3qj1d6FQ0Q2NlanFsmQLJr5atdlxwtsJ
	 8vu+Dgrxd/ES5q1R1nn2sik1tsJlLcrcdxPQRCNenrxmqqczeD0U52Sl2Q8FBJf99IKUR
	 aJ5bKjVWleXsrPWZxvecY1CIVtiu2rUh1DLUD/3skg/xqjjwHWlU88hAUaCaUR8dAchbs
	 +Bm3nL16ZHfGpARzC4WudyNOnOhOiapwTBiDSfk7TFBE0RXt76GbxRhL5cG8b31CT9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597638;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zgPyBci2zmS3b1P5LmgY/wiYhA2DBq7+lHWBK665QRA=;
	b=4QaSUMaqXEPIXyNpq/Lt60RBfuXjVH6Dcr/ykV1q4GxEm4gGGDG5hPb+XWQ83ZwhN+Fi
	 8enWj9Rc1KxB1xBM5228guycw8QXH0g0ir5wXXH5D39Jv7XQnYxtihZtq2NXsvjD4koif
	 CdwZhFhPDhJRwcGmxTb8QhgLrMnbYRI839y5R632s1l8Ir7IKolPG0EXl+mRuDItghY0g
	 Cm48LB1ru8tNGWMTT7nQbSAd1Elfjvx6W8aMp2uPv8pBRqhhhajrTQGpldQ65QAPoTejI
	 VfwW9VUIu9ByfmsRfmcbhMtRz0oHAS02xOz3yZJdRqcuPCzFcmwSENbOoO23ZE4otoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Fbnx8Snl;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RFH+vipD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7C606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 09:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C7C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Fbnx8Snl;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=RFH+vipD
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795597645; x=1827133645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5CYdgkV1reAWLOATXdI+xbQjLZszqKIIkYxS/aFYAKA=;
  b=Fbnx8SnlfV0uHOuutxVffyjpHfbDHYjsjIkh+6coFTot4yFZi5jN2M9E
   x0shLrxsvW9AtoIZotC8RTwv2aIx2t4w1rh/obhNnFjbnw0LXP3EDGccB
   DI8SEsRBO3jJviWHrvPdkt/lFdKdBnFvpNO3DrUPaPtsND2devEvoh6Iy
   9EeXP5+GKcBEqdGOyeF0/muf92eFc5MPbClFwrT4jQRwmHDqBcCRmJpYR
   FM6rdnMD/n/hCcYFv1uTjnMNNqyiTMQNmHs9qr5c5azhLt4/h+Y4ucZN8
   vuJzZCw7ZaQcyBKRgkiQBvXVVjenIRBcluWR0EujTTsHqw014eTqHMcih
   w==;
X-CSE-ConnectionGUID: 4LX5KdiJRBG7SL5yCW75wA==
X-CSE-MsgGUID: jgkyb+o5RE+RlDlcsELXtg==
X-IronPort-AV: E=Sophos;i="6.27,232,1786982400"; 
   d="scan'208";a="160756748"
Received: from mail-centralusazon11010012.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.12])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2026 17:07:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL+SDns0bYU0SlWGpauTwws6Lq61xWbnL6Caus+1y2GXsOhl7u0xPeSyRI82ACgLDpZ4tcvPanVd+xLgxvVBn59tpOBr2oFw5w8x8hUQASoDOoVyZvLwdQZBk2tGnOq7H+TI2SL43ntGWVkE4PxKYSjvNZip3/V24zRVD9I3094WFBqNa8G3fQWZ+HjWW8GQx2T/gCp4LNRgcd+4o7skU6Dvn13ibqlw6cHcl75rlorVRc3+0dTnXg24oGplK/rzsZjRI/lMypcDmqf2YRbitua6DsUKVa6KuU7uyBsA94bPgWUH6GR0HPxrYa/NaTpzoHzxMFY3bb5FMti8lTvavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgPyBci2zmS3b1P5LmgY/wiYhA2DBq7+lHWBK665QRA=;
 b=njE9uScr3HuhXyWnEEI1u6BHQShQ/Sp0nVbGDssi1nU3nBEBY9tLy/skqVNkSVQ7kwt2n6vv4MYDO4MC4gccDEz7Z8DUdaN5oFVq5TThMTpgv9FbZmkolMxC2YeZOJXt3sBcwZRRoVNEa/jmlYQ2aB1SEo4g+q/X2kKJ5pnyqdS6KIETe0jkixGpWkXNdrGsBalPtIBxvec+z7topYE64IZ2n0FZPQOr4wumfxSHN2nxcBsrkJ+j1pVNUFLF8KSQBdrYINrXKMheFjtmh9HVE3qSCLXjb66wAqYCcAgmswHnCAnCAbaK46K83Gt/YqgG9vL8O7IGh5z9TJp27h6mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgPyBci2zmS3b1P5LmgY/wiYhA2DBq7+lHWBK665QRA=;
 b=RFH+vipDdZndaFkfvS0YijkA82qb4Rt0ppU83t2eHWIaQgNRRruo/mAIPSlRtkCoZzoH5dvlmj/VSJ5N0rkFXdz6xwrAR6AHowMRqzvUYGe+/k7WMW2dPl9cPnVfX3qJ+zXzY1r4V0A9TkhuUlQ9i9xCwNnalDvWrsGvRS4vCaE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by IA3PR04MB9475.namprd04.prod.outlook.com (2603:10b6:208:50a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 09:07:15 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 09:07:15 +0000
Message-ID: <ad36d8e4-27af-4c6a-b3af-984118434797@wdc.com>
Date: Wed, 25 Nov 2026 10:07:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
To: Alberto Faria <afaria@redhat.com>, linux-block@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowangio@gmail.com>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-2-afaria@redhat.com>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20261125083947.263216-2-afaria@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::16) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|IA3PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9012343a-45eb-4d71-5d30-08df4ad37fa4
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|10070799003|23010399003|366016|261009223027099003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	jIgId8jDh7e4M9LHAZd19rdawl8WmLGl9an7pdcqmdZx28dZwTkSKu6oV4Qe3RqCtGIIDgzW+IUBZPJgsDyJyxwoMl7eR3+lNQuedDx7B8AWH+kGstQk3VZgQ+b1sDFWxHQ0NnmOOOa/rIdgYy902w79GSDIVzXL+wHU9LI+h7RKX0yhE65i+PuDkzoK+6aGQk1LZWmFZdJTMQiziSx/OiFH4vm9PVdlayENrvaB2nyjXcTom709260SmlnAiYJPLhMcXimJ/+uDDtDAgFa/IucMWF2yZtKrVd4tAGh6i7k2KZASPDUzRz7onftOU8uLPgh0tvFcjqwx0XYEt1Neo8pLrBxkQt3zK4v5T5BQ5p08FoZce/rEtWSY8IpgVcMcMFcP8YUUyfXd8bZPPPkiet3nhatOkrw7mYRpdfxFO6fo3WougDOp1Ki6uz0vLZm/S1Ugyf83+9I5wNIZFxRoQ2LTLcCZhy3qBOcVirROrjJplaFXx75vuoRTTRKqOfuFJFEfgsSOicbCCNtx5Hyut7poByC3Osf/S1Xk4UTyje+wBM0nh/hMHapP2PPdiGHQOaq04ASCZgBJu5TF88PWpMeISIPJT//U7KqCo9qOThWD1I5dT/Soy9MDp+Ww9xfyON/KiMygGvfGN8vB8+AdHUT/TM/3fYMDrurzP4zfTfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(261009223027099003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjAyUXFOdStXdUdORVRXcVR0VzBOTXVrYU1aWlhQbUY1aHhrTW9CNHVQVUc3?=
 =?utf-8?B?bU9wTVQ5U0pBUk5aMjQwVDFJNVdVOEVINzZDV3k5NWY2a3BsOVNyK0d5cThw?=
 =?utf-8?B?Rnc3OXN4RUozQlVNUXJ2OWxyeW1Ibkk1WjliTEpMY3J3OGEralhhaGgwb2Vr?=
 =?utf-8?B?QWpGNVVEdEpQUXhaamNxV0cwY3I0Z3g2RjRsT0o5WkNRcTdaTDc1TkNsUHhC?=
 =?utf-8?B?dUdKK2NQM0Y1WHN3bXpZMi9xczVOWXRiM2tzd0Z4Yit6L0tlKy9Ebld3M092?=
 =?utf-8?B?QlRpWURmVDBaejRNSFlKYnBTTFRyM3NiWEd5dGE2TUhxbk9XbjBMYmYxdmcr?=
 =?utf-8?B?aE51RXNoMTdrZkxzR2ZLUjBDeXZXdG8rU1czaUtzZldhQ3NybFllRm1uWDd0?=
 =?utf-8?B?YXl5NkFJaVBmclo1alZib2RVdGpEMnZ0R3ovRGJocUwvSlhNV3NscHphTjY0?=
 =?utf-8?B?RnpMUWZmZ2hPSkQ3LytPZjdJY0VNRUtOMXJTcXdLMWUzdWtsQWpTL3p6N2ZB?=
 =?utf-8?B?aWJNQUphNVE1TzVrd1h6R3dRVld1bDdjSDVISVI0VUdzTmlVdDVUZjNMQkd6?=
 =?utf-8?B?cjRwbk8wNmRhWk9Gc0Y0R3hCR0hobWR1STdUdzhMMTJzbVBWWERZSDNXQ0w0?=
 =?utf-8?B?SWhJVjZFQVRnU0hNeUZXeWFSRjhQRUtMbXorY3B6WkVVckVWRUMzNFk3YjZQ?=
 =?utf-8?B?d2RCZjZOdWl4RGxBbzhWUS93OXpzS2lpVGdwOStrMnlsVE1qaFNUU01EV2dJ?=
 =?utf-8?B?akNzdlJhNVN5U1ZpaU05VnQvT1VZM1VzRDhWdUowc0JMZk5WUllQM2p6TDFu?=
 =?utf-8?B?STdZRkVjckg3bG9XQUZLQWdXNVg3ME5Sc2w2V3pnRnVaMnBMRlplajNaQXBE?=
 =?utf-8?B?c3FESm51SGI5ZVFFakxSenhDb2pOMEVmaGRKZEtFNGZCUFZiUVZWWGpmQ2k0?=
 =?utf-8?B?alJ0QnAxR0VSaEpLTlZSUkExTFgrbUwydEtKNVFISDBJSTBodDJPY3Q5OS9w?=
 =?utf-8?B?cmtmcVp3dGxqcFBEalBic2pOM2JBcTF1UzQ4Mk5XUGZ5eHd6SkR1NUtHQlVp?=
 =?utf-8?B?bitKaENqRU9wSXk3L1N4UW1vbUtkN29JVjFCT1pIZnlNbVVqWTdlaW1tVzF3?=
 =?utf-8?B?dUVmM1p2K3k5dUxlbWE1QmRTQlFLZFRoVUxsVmhjSGRJQmZ2bE8vSWVzcUxj?=
 =?utf-8?B?dUs3aFBXWldMTkRZUk9RZWhUZFBUdUZCcndWQW5LYjYrQ1hHSjN6S1NqbXg3?=
 =?utf-8?B?ZDZqcDJuZDdvYnA0Y2xLcmtBdjAzclMwUHFycUhEUkUvVFpYKzAxNHpCU0hK?=
 =?utf-8?B?dnMxRVBuTlU5aDZqQWJ5Qmx0cmZCdXJGd2Y1anNOMUZiR0k1M1BFMlc1ejZs?=
 =?utf-8?B?eVlBSXZXSkdOQllNZFgyVW01UVVDY1B0dHEwK1F0Y1JIRFFJMlhzKzhUTEpm?=
 =?utf-8?B?dFRUS3JLY05wMGFGamZ5RnFUUnh3V1dSZ3Z6Rnh0eGhrMzRGUm1BbjJmdWM4?=
 =?utf-8?B?Rm15UjFCejRWU3luSE9hNDJaUmJRUnI2UjFQV3pTZHJxYlpMM2Y0MkN3b2t5?=
 =?utf-8?B?RXV4VmxDR3loaitIWGRidUJBcGRldi9mTFdDaytiTTVXQ3pzK2Q1YmNEdmJU?=
 =?utf-8?B?a1NlL0hEL3VkNUw1S2JwWkN6YnJjNjUwVGNGTmh6cG1FNnF5MWdQWU5IUHJz?=
 =?utf-8?B?dE1PZ0lOTWZRRFpReXdxb3dOUGxxekdsbENHZXlFbDBqTVV0WkpoVzd5VVAv?=
 =?utf-8?B?a3lwVmpDOGZrZVVYSlJFcXpGWlNqaWRrVjNNVVRCM28yQ2FkMzFQM2IzNWJE?=
 =?utf-8?B?L21pOGhpckxPSVZabXg1OEpzNHNnbEk2Tlc0UTZ0VGNVbzVDbkEwakluYXpL?=
 =?utf-8?B?M2tkb3hsbFJ3VGJoUEt1dkdxemNvTE8xbmJQNzhIckNtSDIrUlFybkFIUklE?=
 =?utf-8?B?Y0VoVTREd3RXMWw4MGRYRlV2c29MUy90TlJMZkZaZzI4TStNNnFieUFQQXdD?=
 =?utf-8?B?WFRhT0lwQmJhK0thMmc0NWRjbXlIWGpRbWJpR2UrZEcranY0dktNeDJ6Mkp5?=
 =?utf-8?B?aHBENE5xemREK0w1S0hlazI0ZmdtRHFDSmd2V2p0Zm1vMjN1SkZqaWMxK0FD?=
 =?utf-8?B?a0tRUDY0TytnNU03UmErWk93Z1FuSGY3OTUwY1F3YjFrSEFRZ3JxaUVPaHZI?=
 =?utf-8?B?Ynlkb3dxTEwyS1ZZZElINm95OG5mR1c2VnplOFd6amJvc1l6aXN6MTc5TThM?=
 =?utf-8?B?YXVuQnNES3BjSThRdzlmaWJwZk44MkNuSFRsZElyUkVxQnBkb1RVWUlISWFO?=
 =?utf-8?B?amZER1UzN0d0bHYrZSs4WHY1MXlKbXZma3BadzhuTEhwTkVoODU2dEEzZWFS?=
 =?utf-8?Q?Uhv0k5p1NBjkVjV3Fk9fUs3HEwM++bmb86+CUxG3pt4PE?=
X-MS-Exchange-AntiSpam-MessageData-1: 0wIjzngHph5Ix+kzAhzRpIj0k+B9NNLtXhI=
X-Exchange-RoutingPolicyChecked:
	jrx8XMZG3Tqq1BpGSaWISj3TeNrd21+cQV6u+o251XUe6eNB/142rS2xSR63eu2+K6KaQrztvVWDE7I+xx9pKTLi4tKhtGmkun+YE89y+k9EWkMy/hsELW4IY7ctn2Xds6m41Ui95vw+oEKkpVAOx3WZOoivwETa3twLO+Qr6rBRI5+yppzr2vZp1Qus74gZXwMXWlHPKHkt1+v0zgOK2uGMFostK3V3VW2T+Ves1wOCS14usCMnr3PMvPU2/CbbjgCXjCVpKNEZWpiPu0pzCL7xXrHpY01v5vMfZXTB4Q3Pe3D/AZeYZS2EeGnMhhjmmVMSjbbh7haJs7fSmkJy/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oe+YK/XxD5vL9JVgaVC/BS6ElVIUbOn9aiz3qIrnZt6eTpeyu69aYVVM2B5Mxo/rm2zJhQPSM4BH+NdjqMd+pLlwQxEum/7Gq/jQodOQ1ZgbtILmGLXvZke7PbyF4wwiaTvU1EpQ+kEaxvQoI04Ez4i0O4DU4Rw48ly3zPNg6ulReDeS7+pyboSQM77TA8jjGBMhSVdYuKhFyLDLCf0m6SfUiBl/BJpaTQ+mjdQd3wRog9MZeZDTy6IfJWfgaKlcoKXE9iIf7WMK7NJbyKzwsV1t4QnTjEH0PKRUJ1q27s7fA0GA86QWlo0obD+u1Qn2pzgj3YvcsI6YquNarJqlKdTNxa+qE3e7MPMu2ip+y6O6QN/dYDaNKiuxTsXdMRQjSBrRT9RBtghhO7GVj1b0oAlGXvobPk3Xj1Vsa6KCMfCLeK4JWO/6bwn4hbSB4Ne/sePA3i/bydBmw8qtHCHsVqJU0c2HLMkBT2sEZtVFOsiKL455k4ZepEWb/rSMbqZRZnB7XsfR7bX8/cnqoz2aCluKnNKbkF0xVDTeOWGms5wXhPrmiWTf2VnYG71jMKeFNfFBT96FPb+A6nKrvVLngO07oSwZXMjWis8rbyuOb1e/TEbuexr5GBG54n0jauDs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9012343a-45eb-4d71-5d30-08df4ad37fa4
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:07:15.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHWGmtzLpAUUc1Wnl4g5c6igz+syk9/BM3IriXzPk2j5EwhgH4IGn9e1e1IsOF5tlzMQLdi74sM+95dsoTP9RICe4YUokzRuaH35QWTHGQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9475

On 11/25/26 9:39 AM, Alberto Faria wrote:
> +	/*
> +	 * Do not advertise FUA when the device is zoned, since we
> +	 * would not be able to handle it on REQ_OP_ZONE_APPEND.
> +	 */
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
> +	    !(lim.features & BLK_FEAT_ZONED))
> +		lim.features |= BLK_FEAT_FUA;
> +

Can you elaborate why?

