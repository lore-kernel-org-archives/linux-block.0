Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F23FF1
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452147; cv=fail; b=avMW3ShKeF2ZOH1JyopCiIcHnLoS45EdQOJ6RdxyrQKAwaaCvB8fw7+8R4DEgnFxwDg9N+QL7zzsANBhcMK9bXiP1fAGH70sqlNSVdAc3UDBdivkJxaeMWWfhY7Wq7RE5ApEBQRyyNxy+naG+531W2Dh1//URs5U1xHAv0xUlYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452147; c=relaxed/simple;
	bh=THTkikV3gAcYzJsb63O1Y4oLwvWuGU1Um1Lq8T6fzTg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QoTz/gdZ/qXPiZlklXhk3nXZTVttoMvZ63reEaWIhwwNB6ZUuI7j8pacxB9COflHiiQZGCkYOCS702Li14MEQy68p3xcg19QJzZAkMe3KvRe7Alz7Eri44Zfryn7KvXYUAHs50XPitaBie3A5iMMPSHE/8FHAWzLBJCmy9qnYQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ct0jTvjI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=faPbUhSb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ct0jTvjI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="faPbUhSb"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18fw2T009181;
	Fri, 1 Nov 2024 09:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HBHwoBOLQPbQpnl8KGJeJDHYHcHe0+JuSuSYwvUEiHc=; b=
	Ct0jTvjIwozQIReZ5HfYtOUNY48jm/Tm/2pOGYtPE3c347QyHa+OXk58ZU46V7pg
	NsAQ9q3OVJSCLdxkN0+yg8E+3b64Yvjm2SAzIY3q4UFCD4tywkjmlkFUX26BqGhR
	mZz1dmSMaNpuC1gugg8UOvH7CR/Pfe6MSkDTjTXXKTRdLOcTTg8jK34amhoxcpfQ
	jt3ImLxooOnX91jGKGoUdbYYOF1RYSo2D06SPiaqlWxJlc3FVtq1inBuGH7TH7lA
	gAzNj7EL8MVzPXZ9jcny+fxXyr4Gcuk2PaIu9jbcIl1Po+SmUqN38Qs50+MAuGIK
	fA3QCVoZx0R/jkngFWvXpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmm2ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 09:09:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18AE6u010296;
	Fri, 1 Nov 2024 09:08:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn91gebe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 09:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bogve6WRJ9J/yZhIAlBpMZE4UPDjPNZKa+gI+UhGy6nBbHZz701yIaL+krTwgMnRmbSFy84eZFchE/aFcbzAuSoVxsATN4yPs9TU0pFSccFZMmIYw9Q8rh0+0BaqbMMNlkBHKwy8uIXmQShAE9/yve4XLzD4xx5drmt+U19L0hdicXxZ4tNA22Un8AjsGzbiSycY4tuVb0a1Cu1tfnftphRP7hwl4HvUqsIVkuJargkejNYJuAWdDWYkcc+5Anj8R7j1O1MyOgYVMRwkx0vWdhEZ6WGwIK1LgLdceJRq2YVUkhs6q7bkXUrBk3/xohxZgL4lxDHvcZvhBwbyagLvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBHwoBOLQPbQpnl8KGJeJDHYHcHe0+JuSuSYwvUEiHc=;
 b=epokiIvTcDWX4Gqlo83Sje6dlaxUj/LIrTcQ2jAlD8CJsjIOMrEA9IwUv87ezsLEcbbzQOMQB3e6kklmgn2D41OljyVgWAZEaOWhgIHnxilRjUaUKQzfYjBxIpnnCRyBvbjdbD8oAFOZUxIKEfnKYStqF2COSFhoxOnu9h8isblBWIXvfgcfLbq2YKPWQAY/smhUNS4I27ydkZP6xXVeH6bgfmmKGiZnr4VeF2524EzNuWh8aiqC0Yy4GdsPQRVIhX0ijAGQ0NsevGd3PWrxdSC6ItfFrcbRCE2n8QecemwFWCmyBWKiOfalPQPlW5/Nj7i5xttQPMJoQC0BRIGGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBHwoBOLQPbQpnl8KGJeJDHYHcHe0+JuSuSYwvUEiHc=;
 b=faPbUhSbmcFVyUOhhr7RO6FI2gKJcQvJ08Jl6d2Hnn9wYbypzt9RbLG2BbZTrB6dnLoZjamRtDIbwLIu79iGNDVZC3pr15gZSCXgnuBchfgH44BGc+FpWToXv8w1tlL8pCA4JR4bDTKzSIpyRZbvPgkmA4VnpFHMSa6pVBRz4Bw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7209.namprd10.prod.outlook.com (2603:10b6:610:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31; Fri, 1 Nov
 2024 09:08:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 09:08:57 +0000
Message-ID: <629883c0-9269-4820-801c-a5ed6e4b2803@oracle.com>
Date: Fri, 1 Nov 2024 09:08:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Use bdev limit helpers for configuring discard
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20241030111900.3981223-1-john.g.garry@oracle.com>
 <20241030140601.GA29107@lst.de>
 <27a2e5e7-9dbc-4fa6-81c2-1a8df906187b@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <27a2e5e7-9dbc-4fa6-81c2-1a8df906187b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 269e8729-8dee-48f3-e296-08dcfa54d136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnVSdXB1RmhkWktFYSt6YXpCWHVab3FQdU9BTmZDakkrOU9DN2swREZvNTJx?=
 =?utf-8?B?MSs5eE1DRDJIb2R1VGVGMHY0OCtiUEVBTjYzajZmekx1enU3cGlPbEZxQ2pr?=
 =?utf-8?B?WCtVWmRkTXpUNDIwcjhDTVdzWUpBUVYwV2dNNFB4a3hFemtoZzU0THgrOEwx?=
 =?utf-8?B?K1oxSnpRTU1TekREdmt3MmFmRXY4Q24wTzVwMGtTZDZ2TkFPLytvV1ZZMXhp?=
 =?utf-8?B?ZjM3blJuMElNajdKMXRaSnVDWDBiRkxCSUJIUkJpNHVIVkc4ZWNDT0dvTit6?=
 =?utf-8?B?OFNPV1N6QUt3SkZORGc3Qyt0dzhzU1NDRlhZbEZCb2tLNVlreEJEd2ltVlZG?=
 =?utf-8?B?QjZ2N1lwMXVUVXB5RWFoc1NZWjRuYlBwWU54cmxQL3kvaUdxbjlUQUZHQUdI?=
 =?utf-8?B?UUFuSTBWMzVHUHg1SnZQWHJzbXJ4dkpxNDJmcklEQzk1RHN6YldTWWVxbWh1?=
 =?utf-8?B?ZTVNYnFycE81bGFJSElvYXkrOXp5MTJYQ2JZZ3RTQXdIN2dWb3JlaHNyTGJR?=
 =?utf-8?B?OVlPYTl5OGhxdS8rcmN3NDJwd2JDSktkY3NscWNLOWZzLzFTY1FhaDZpZ1Jq?=
 =?utf-8?B?VzJYWFpvYWN5dnkyajF5R0lXMW5xK2VTOVdpWmoyaDNlZUhJVll5aEpTZE5R?=
 =?utf-8?B?Rko1dTBlSTRTVW9QQ2V3Um1ObzlKU0VwazFJMkRnbGsvOWQ4Qkx0UENtWkNs?=
 =?utf-8?B?UWQ4UDYxWkpjQmRuWmhBbkQrZWFlTHl2Nmg0UFl5QndOdWZqOEZXQTIwemR3?=
 =?utf-8?B?TkliZ3FsaTNtYU0vMnJXTzNIMDJRWVNaYUlRTXRsMmYwSTJtZFk3TTFJckdQ?=
 =?utf-8?B?cnlRQllPZHBBM081UFZwbEE3c05qZC9ZT0dlaENIZ2dHQW1JMGVCQmliMnBw?=
 =?utf-8?B?akJQbC9mZ3ZZTHZmTTk2Ym1Ga2pXa0FHQ01QUmNVajNjUUxKc2F4aGt6VkZo?=
 =?utf-8?B?M20va0VFOUU2cTdrN3MrMmIxOTJER2lMVGlINmZ0TkdqbUREemJ6WTVQWXBD?=
 =?utf-8?B?R0NFQkgzL2w4Q1pZQ3A4MlZ0TjB6eGVXaEV0YTVOZzVjRFJrMFptVE9rOVZ1?=
 =?utf-8?B?ajYweWRjcFBtd2MvMGVhV3BsVllrM05JOWZmTUxUWHRTcytUd09xRTBvbndi?=
 =?utf-8?B?d0RkS1JXdEo3SUZqOWZ3QVZwZUZ2ODlrNUIrVCszYWFZd1RDZjhLdlJWbzc0?=
 =?utf-8?B?WHhFUWkxTy9tOXptdVkxMVc1Q2U1MmpiZGlRY0ZUN3EybTdYbmI5R213eHBH?=
 =?utf-8?B?dnVVRzczM3lzQngydzJzU3E1L2Exai9Zam91MHI4Q2g4cUkzWkgyNWcra3lI?=
 =?utf-8?B?OEMrbGdJaTRrUDE5SnpXT0lqNzZmQ1R0ckJkYWZOVmFMV2FpeTRvQlpCVm9x?=
 =?utf-8?B?WVB2cXNMT2VLdjJLenZUUDhGdHRQdlZHNkZaUTd5eFB3WThvRDE5WFc4d1Zs?=
 =?utf-8?B?NnFmWWhvbUJUNXpwdm5rWnFuZTkxQXZDWU9IbXhLUUljQlByc2xpUVZaNVFW?=
 =?utf-8?B?Vk5VVkRoSFJGM0Qxd1VyOWJQVTZxQVgwbVhESHROenpXaGRyZ3g4NXp6VkYx?=
 =?utf-8?B?NDlYeUprcXh5VzBBdHdIenoya0tYUnE4dXpKSUdsQkhQS2VhdDM1SHk2ZVFB?=
 =?utf-8?B?ejNRM3RpTHY4dTAyMWttL1BhU2t4R2NacGE4MXRZc01DbXJjRSt6ZGZCOW4v?=
 =?utf-8?B?aXlZKzNMQnRaMzV5WTJnUDl6RjNZREJQMjNFN2dBSEhnZERRYVROcmgxczVQ?=
 =?utf-8?Q?3f6lqbl7aUtanKacWyX9d+Lq5AKYomSlGQQOEVF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFzckJ0dGtVQ1Q4bnAyM2JORkk2eUlNNWg0MDloK2FTTU44MHNkVFA2Wmxi?=
 =?utf-8?B?NXFVeHJxMXBoRmlPcS9YRTM2OEVvbEhBejdHejUvRHR4cXdsUDQ4dXdRRmhs?=
 =?utf-8?B?cTNqU3Y0Tkw3eHhLemtIV0x0WUNHdVdscU05blVRbDNQVzZPRWVMcGhqRUY2?=
 =?utf-8?B?RDNjdnJJMGF3TkpPM2dTZkxkVWJaeWhCU3RYTkIwQzNFSGt4N1JCQWpnL3BL?=
 =?utf-8?B?NnlMQWd5ai8zUnZHci9xajhuYlFQYWJ0T3llWStRTkNrc042dnR2ZHpsY3Nx?=
 =?utf-8?B?V2xTYzd0UDRBb0dvdHp0RHZ3bVcyS3RveEt2WmhvcEl1K01RK0lrWm9MZmZF?=
 =?utf-8?B?MjNZZ3Q5VVJGRDJsZkdDaVdSQ051YVo5bmxwT0YraUNhUG92OWZDSWhTb21I?=
 =?utf-8?B?S21BVW1ZV3VIYVRCZExvTEJVeGxrWTdaeUtHYnhNK09wN3lzZ3NqQS9Cb1Ir?=
 =?utf-8?B?TGE4R2labk0rZ216MXAvM1lwMEMveFNrVjA5RldjZWswWittZEFiNWNwS1dZ?=
 =?utf-8?B?WVAvSDc3cW9tejNlc0lFRFlEcGtFUkptZ0c1M3JrbmFqaWVURHJlT2grTjhy?=
 =?utf-8?B?UnM5elB4NjhyMkpxa1JuOVBkUkpWNzVqZkt1NUs5MEdsdmlhcFB5YmNkVDA2?=
 =?utf-8?B?TkFVZlArVGdBcmlCalpmR0MwNUJNQytoUlFoU1RuOGtEa08xNGtUbFpZVXAx?=
 =?utf-8?B?cERkWWQ5VlRyK2dZRXY3S0NKanNTVzkxUDY3RDZVRmoyRzdMekxBOVpRVWtY?=
 =?utf-8?B?S2crZW91NEI2aWJIaVRmaXRJa3pxWldTWFllM296S3kxaGVHdm1kc1hvNGZz?=
 =?utf-8?B?bjdwcG5ua3RsT3h0aTlCQ2NXY1lXakhNN0EvQ2s5WmhrQnJ6ZXJabHNCRVYx?=
 =?utf-8?B?eUR1ejgwd0crQy9zV01wVnFDZVpNVmt3Z2l4OC9uaXFCdWo5c0VEditkTldB?=
 =?utf-8?B?WTd2alduNFEvaXo0M09ZZlQ4cWJqRFM5ZnpobkZqaFBheVNxOHJJYWp6SEw5?=
 =?utf-8?B?cVZkUDdtR01URENIVk41b1NiTHVZZUVVL0FjSWJZa1czWUdNVjBkd3FNTC9J?=
 =?utf-8?B?a3Vvb0VTWGZGdjAvb09TR1VrWUpJZzg1dDFTL3kvTTlXUDQ3Wmg0MHJZMWhi?=
 =?utf-8?B?SHRoaDAreFFQWjBDSUgrelFjSFJ1alpuTkZVR0ZtL3JTSDVrVnRzMXpWaFdw?=
 =?utf-8?B?eGpCWWhtNEg0VnFjNTRtWHJXN0JQUkNDakdoQVpJVVg2alZvQUE2U0tqWTJR?=
 =?utf-8?B?THpqWEhZTDIxMXJiVXNIdGRlVVc2Q1hUNkVhakJ0S2RFck1mY2NWc3p5aG9n?=
 =?utf-8?B?ckJGSCt6ZjVvS3RjODMrUGZPUGlSclBncmZyUko5SG9lK2xZTU1YeG5jWUl3?=
 =?utf-8?B?czhJQzdDVHdDMXpQbDdSeFBLaUhRTVJ1NzZJT2p4Uk5zSUdTWnhzbUlXZXhp?=
 =?utf-8?B?eUgrdE5uMWVjdTkwekV5akJXR1E2SnNnRE5XdjFEOUIzWUxuaWRkRHVCSGtM?=
 =?utf-8?B?dnZKcy9rUEV3S0h5ZjZST2FtdndQY3prOFRKZ05xTUVQNzcycC93b0dtUXh0?=
 =?utf-8?B?ZnFZRzBSazRPbFZLR21NUWwwUVdUQ1FpV1g4Mk96SFFSR1BBZzFyZkQyajlC?=
 =?utf-8?B?eVJvbTBOc0RkRkpJdDNGSW5NbXJpWWpCMkY0WkRnRWplcVEvNEFyZXlNYzRr?=
 =?utf-8?B?V2NNS01CRVFoUFRTS2hTQklTYmhJOU8xTFFjUWJQNmVodEFwNkFFYmRyOTV2?=
 =?utf-8?B?amZLbDgyekpoZkZSVnl5V3dvUGhDeXpKVTdQSGNlcjFRaldlTFVDblJPNGJi?=
 =?utf-8?B?eGh0c0xyMm16MGY2Y2svN2V4MVN2ZXJleVVuZWRmRmYxejVFUzA2TzN3YVhR?=
 =?utf-8?B?QjJtcFMrWWtqWWJCR0hUNnI2Nk8rNml5akdzRDByT0JlSHBTVERtQ1RsV1Bj?=
 =?utf-8?B?YUlKK3pYanBSY1BjMVZMR2RGZnJrQmhjQXhaVEtSakhzVEl5b3ZSVGRJNytt?=
 =?utf-8?B?R0NsZ0NsUkZKeFplYnVaSDhJSk0wSVBySXJyVFpUbVgwa29lWkRhcEF6b1du?=
 =?utf-8?B?U2pROW44bTk3OW1rWHQya3B6R2g0TkVqQlVCcTdsdEdqbTNTZ1hjVHNvU1li?=
 =?utf-8?Q?44uo+0QuyHCTAxV5uoYMYjKkb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IKMxIoIfAhIGbQ+omf4EKsZezB+loPyZPV+/HzQpbINKe3KtdgIMYO8lD9IDzuq2dPbcq+9gf56DR0twT6InTMLNaTgf0/KvNtJiFMjnn2CsgJva0hK4kRbAPjfGNb+CkBB/IxLrAtUieXPummfTE0ltw8jNUlymlbj8sJuOWQbRIvVj3bDvCP227e5SebuVtUqzcBzBhwku1THQbI9zRJwIQggcP3NwyG+YPDGquizLINguWiSl9lLLhiP3MyWyRL3vVquRbcQPDOhE+RJzu+fZgSKFWF62S/S6cUt5H/8XxGKEx356LZg4l/ufcYOkj7Y/9Ovf7sf9CojkwBz1sMdtQRO82EQ8+hfnI+RLQ0RjXPewLH2GgvNVDqPpw/AUmRZ7ze64JeM2+ujh8wJTUSbLiQFA4CJ9UpT53/MC8ndtIvbpo/fDkVz9xc5jTjRFZk387WEAgYkd0DNbT7F2JTPSQC+pcz6570pTSoO/aFlkz0cOVxXMopYvr0KdRGDWkgghTDP9eLWQQDTNEMif7UPfPJihqfsXprb1h+wYhov63vlTU/8Sh/yrD4ebajWzDIjt3wQQA42h+wdYP8aSPuSqBwBbZZ+1x4lq9f4Z5CI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269e8729-8dee-48f3-e296-08dcfa54d136
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:08:57.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSWTg3AC4YQn3lpinW1qu6MLl3Zoh32G/zuvF7HWSz3BARcBxrrmVNmnwEgltP5wm+gEj3ckt1gmMq+2JjeSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_04,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=978 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010064
X-Proofpoint-GUID: vjoeMoXK51VGUr2phbaRqYD0ky8Jjqxc
X-Proofpoint-ORIG-GUID: vjoeMoXK51VGUr2phbaRqYD0ky8Jjqxc

On 30/10/2024 14:13, John Garry wrote:
>> On Wed, Oct 30, 2024 at 11:19:00AM +0000, John Garry wrote:
>>> +        granularity = bdev_discard_granularity(bdev) ?:
>>> +            bdev_physical_block_size(bdev);
>> The discard granularity is always set to at least the physical block
>> size, so this can be simplified to:
>>
>>         granularity = bdev_discard_granularity(bdev);
> 
> ok, I see that set in blk_validate_limits()

BTW, can the check for granularity ever fail in 
queue_limit_discard_alignment()

static unsigned int queue_limit_discard_alignment(...)
{
	...

	granularity = lim->discard_granularity >> SECTOR_SHIFT;
	if (!granularity)
		return 0;

