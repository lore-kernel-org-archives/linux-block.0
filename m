Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28E155C97;
	Tue, 27 Aug 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744539; cv=fail; b=es9o/QzvNXPljd+EvZ5YkCQv6DWxyaosUpXivE6PhEK9dmZV8sLpUVTaUtvByPMI3K7kfTLHZE5gdiGQrsw6Qfo0w/LWDh6DqDQpvuw/SFn7yrnfDHLbdK1/NoTkG9YUWqDWLlmKrQekZgZS0Y3tNhBCCEoXXMDNCUvVp3NRJNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744539; c=relaxed/simple;
	bh=cN2Sh8hhDVuBL0ERXZCYYQVL5UIOKpdSjgZRwkzU5XE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRea3cSBK/MOWWjCfNnqFeGHnIh38A5NfxxdDjz6981xHg2MwEMplCQ0Q2/B9H49rIB/o5jH2r1Raa5mWh6A+eek/voXMWlF2gb4Vug6M5VNbuTUh97Cy9VMKZJzmRRHTUfYLatyCg/4vBh0llps/H/s4qSoFFqVc0QWEq67Ja0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hlYmKQZh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XEZaKjbK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hlYmKQZh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XEZaKjbK"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R5tZST024205;
	Tue, 27 Aug 2024 07:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=cAONJqH3llo0BRUHLFvEeDlTx+tlVFnJN1mpKzs61AM=; b=
	hlYmKQZhVz3Y3T752C4WnuqivGbvtAsjVWeB+SO3mL+oTQ9+fmGKhG8KJjV4JEcK
	w6V4rMDC9rCYYspmC8e6AcbsJrNwyc4onzis0TyH40snTnxMu07+zzIjsJtdEtfq
	FFIiKEwNs/ZKpiS/zmZXnmlhUMsLp6Kn9/RM0McHLXPfmjH04HzBtwz9WPz9YHhk
	pLvIEv2cb/75RvDW5WrvLeApNBQZbV01OSx7oWi7w2Zi/Y+ijkQI/MiGqPLWiZXJ
	YKiweV3/dYynv5D2B0rjIK/3ZVir7n8KDaZRSmsPbwO0kfw/cNmk4KvU6Ltfg0q5
	zf4bMDUCZk5YutBMYA6Vbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nw4tyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 07:42:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6Uvt3009924;
	Tue, 27 Aug 2024 07:42:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894mky88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 07:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s97KyvyqSwZvj4rDUOemfStGTFQ2qO6VAqRkHdna1cnxycKTkku5sO0Puvfn5r+sVjCI0VH+e1SugIvq52JuDfpcAROBBzJ9YDWmJX01DVSJtgeQzegq7MXmhBr6YE1Ej+x7eWVUvRutMbTFNA8w9uzxN6gpuC1nixKl/Y20Gh5trvDv3aHhY311U8OSb9wYBKdzFVDHgQddGe41ihnQNsgD8EbflLY7J7vTEKkGkrEI73CVgCY9VqXLBslj8n+mvZLPTLqA9lM+xUrlxhPkd0KFlyYozc3wlkXgFJzkIc+vRJ6qriJn3SKs+XEWzDYOQmrRWzsn3ZficJ/26VFqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAONJqH3llo0BRUHLFvEeDlTx+tlVFnJN1mpKzs61AM=;
 b=vjREMS8aLGhgXo/A+m8IgY/+GU3ttZhEKP1D2isL3Fu29KS70O22xegBM8LmO+L7yJNF7GwxW4ILFJcT9RRtmIW/BBpEOy3vXMhYmKUXk5C9EyKKm19SxAC94KIeHYt3EjErIevHMEj6vbMvVuWgTyveYBsrW4RqvgOTbuTpo90C4vjAt/WDtZ5cQ9ul4h+JxCIunJj3t35eerHK6j5sVU5sUM0PfVJf0+YxpFrUFHq+gQGn9f6haBBlk5hlLMllRJDuQz7hRZsNA+g9d07EsvYEn0smoCFJIrTGM1J2ckEt1CAvvsbDyR//lilmYYtTkO3CEQNE6i2g9bGQGI07cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAONJqH3llo0BRUHLFvEeDlTx+tlVFnJN1mpKzs61AM=;
 b=XEZaKjbKRMdw9S/L6EvzKzSDw8I6YNaTXNe/tneuU2YuZXvNY7gabKhR7S0uaNdDi1gpcMdvgNpBwN6EFcInLw6l2wmcaFCZqNxZWb5OsPea/1mdKrOQ4zwCsbrqq9nfZ+wwa5Q0GQnCdBc5CO390V+4kQKv9jW5ST8cf48badQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5669.namprd10.prod.outlook.com (2603:10b6:a03:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Tue, 27 Aug
 2024 07:42:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Tue, 27 Aug 2024
 07:42:04 +0000
Message-ID: <d431a0a3-a12d-4da0-b8cb-dd349aee8d4d@oracle.com>
Date: Tue, 27 Aug 2024 08:42:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: Increase bsize variable from unsigned short to
 unsigned int
To: Li Wang <liwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Jan Stancek <jstancek@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20240827032218.34744-1-liwang@redhat.com>
 <8694fd51-67a2-45e2-bda4-f6816e1d612c@oracle.com>
 <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAEemH2djkWMtuTN2=Y5MXZVOACeCm32_Hh0zAJxH7X4Ss1MSuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c5f059-a45e-45eb-45d3-08dcc66bbe62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFl3MysxaXBTcFQwQUNjSXNWWEIwdWI3WTY3Z1BUNnhPRlhCalQ0V3gyWHVM?=
 =?utf-8?B?UDhtTmNlamFZbFpxUkRjQS9VTUpnN0djM0NOMmhGRks5QTdkdU5GMDFYQVRs?=
 =?utf-8?B?ZStZWVQ1aWJIbHV3MUdXaFZyVUZwcWkvWDg0RStHNlpqVzFQMkc3Yk9ESTdS?=
 =?utf-8?B?TmpGK2RGNlBEQXNuZFVSYUFwRGRxWlhsbmlLUW1FaVNaV1hOSDFOaGxhMzl4?=
 =?utf-8?B?ek1zMWxHZmZYcExQdUc3SU9YaW9XWlJRdHh4c0hySHZtSDRnZGQxc3VEZDFv?=
 =?utf-8?B?azhHanNnMEdJZU13bnFJMTZxaDRoK1dRL0xmRytZRXlOWVpQSjBwRmZCNnRR?=
 =?utf-8?B?U2hiTW9EbjQzWko1QVBVZCs4blFWajVzT2orOG1vQ1cvNnM3ZFd1cTdUbmlY?=
 =?utf-8?B?TTlRY3VWSnFYK1gxNGxTOURPTk9qWEZnbEo0ODVJSVEzcmQxOFIvdDMrRFhZ?=
 =?utf-8?B?V2RLMHZNR2FqVE53bnd6Y3lsQm1BUnI2Q1VzTFpSQmlWalBDaVAreFFGU2x4?=
 =?utf-8?B?QWg0Wkx1MStmMThKZ0hGbXFEU1RzaDNoUnF0emNXT2FrZGJ0TE42d2dLR1lO?=
 =?utf-8?B?QlNHR2FQM3VoaG1PTHNicFA4ZWZDK2dSY3VScjVOM1JScVZIaEVkd1p5TG5z?=
 =?utf-8?B?WmQ2eTIvQU0xV3lod3VhcGMrb0tmZVJYKzVrc0FZL2NZQUdiZVRqZTJKeVQx?=
 =?utf-8?B?ZGJnTGZ0enU0NGlGU1htQUtJRFl2TDYyTEtZdnB2RjJFR2tPZW1NOTByU0hS?=
 =?utf-8?B?NmFLVXBjK1RoTjlUTkVKVVJBcnNMdkt0Y0ZwTFZENFc0U1duU3hJRmFPaGx3?=
 =?utf-8?B?N2tUb1JJQlZUYWIyUG1tT0loVUQ3Z3dHLzArdUxzWCtQRS9CelpaRWwzaTF3?=
 =?utf-8?B?YkUxZm1XWnZKa0JXTThSMSswZmRBc3hZUU9BV1M1dzJ5WVkrSy9FVkY2c0Jm?=
 =?utf-8?B?d1FhbS9uQnlWcUtyK3dDZ3RjQytCVkQrUlVQUzJaS3lnakxpWXp2OHNlaFJh?=
 =?utf-8?B?MExYY2MwcGJEazlIYUtCdE5nN1BBaUdyaldRaXRibWxoRWRMV0hDSS9FMlBy?=
 =?utf-8?B?dll0M3kyVEtBQ3hMdnM5cGN2d28vOUtpeG1ha2g5bGtyMWpteUUwbjIzTlNP?=
 =?utf-8?B?M3FTZXJHR3FSRENQZ0dXaXpaVUtYaEZvTDcremZCak53VzlSeDhkTnlNUWE0?=
 =?utf-8?B?c3drK3VUS0M1U0ZsWC9VeS9FakREaGViWkNGeThHN3BDSzhtR3VIY3Z3MFMr?=
 =?utf-8?B?Z0d6Q05hWTl6bEU3M2Y3TWFHbFUzZmhMU2l5R1hjaHpnZ0JyNytWZDRKQm9U?=
 =?utf-8?B?b1pYbkg3V0tOZzN5dThROXBKWk43OWV4MHBza3JRYm1TSTdENGtuR25KalFk?=
 =?utf-8?B?SDJXRVBKeURCalpMdVJtdFJiK0hjamNVd3B0MmJHTHZ3YlZJVVhjUEhlQ0ds?=
 =?utf-8?B?SFIvd3dyOC9KWHJFSzhoS2lOMWwrNWFXL3Jqdko0TFVHeTZSS1kzK0RsbnhE?=
 =?utf-8?B?ZGtJOUVoNmlaUGRpTFdmM0Q3eVJBSWIxS0FoSnJSR3RDN0EyNE9OU3c4dnZ6?=
 =?utf-8?B?TmlMeTF2SlVsSWhDUTB4UzM5aCt6WG16WXpwVC9Wa3dEQ0RaVjNYblZxTGJW?=
 =?utf-8?B?L1VtTzFCQW90UWI4MCtXNVVhUHlVeEw3Y0RwcXdBZXBqR3JoZ2dtSDlXUWdR?=
 =?utf-8?B?SmlCY1BvQlMybWZyRnBCTG5kamt3Y2dyOVVsNnBTb3NEYTJ3bDMwTGRnZGto?=
 =?utf-8?B?YTVHTHREQTFHNmlYQ043eVFIMlhsS3UzZS8yM3c4NHptcTQ1ay80cnhIa3Az?=
 =?utf-8?B?ZlFmYi96N2RLUHdsQ09ldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGZ1WFpWZ3hOSG9IbWM2YUVybFBvbWFHbEhCWWhDSWcwb2UvcjFxNC9mZnJx?=
 =?utf-8?B?RHpGNzExWTNVV3RoeGVmL2VJSDMzMWluUWdJVmpYdThDTWJmUjNuN0RaKzlK?=
 =?utf-8?B?c1UxSFdiZnJaRVY5aE1UYXcvK09aSStDUG1yYzlrY1FNVHAzSHBGQ01tMG9j?=
 =?utf-8?B?NThJeTV1SldrTCs0bjJFU1daeUd5UW80RUtZeDZwTnhCMVJwd3hjT2t2RjF4?=
 =?utf-8?B?cjVtZ0U3anMyVnE5NjdRTkZiVXFpeTRpcnJvcjFNNEFWVjY0cWNEOExRdjdG?=
 =?utf-8?B?UUJZVEdVbTllZDJVOGpkalJPOTlHdmJOZG9FRTZTTVlXSGtPY2RJOXVyejEy?=
 =?utf-8?B?bmsyZTIwYSs1b2hsWDVaeVZoVGF3Z3lTM0x4MU43SVBTdm1GOUFOMWdEZk81?=
 =?utf-8?B?Z2Z6VGk5bHdpOWJJTEdHQjlDQytia24wcHhkNGZBZnFjNC81THlwcWxXM2Fu?=
 =?utf-8?B?blVhak1WSFZlTndyeGpuTG5VR2E4S3E5WXlDeFF1NkNYMERiOSt3eEx3eGEz?=
 =?utf-8?B?bE1xNjcvSitweWo1OFVzdWd0dytmNVJXVjdjbVV0R1NwUlgrajVkSkZMUkpw?=
 =?utf-8?B?S2FzQnZJUXMvODgyQjdTRTRqSldEOU9HNW4rR0tWTUdtYjMzbzRmRzViand0?=
 =?utf-8?B?ODE5T0dnMDV2NWZxblRpRjZ0ZDNROWxueFlSRXIzalhRS0JIejlLSmJzNkor?=
 =?utf-8?B?dk1BdjJyMkw4a2lRK3lZRGpRaXJ5RnNPQUhZRUtaOFFtUWZsNFdiRVd6VTdy?=
 =?utf-8?B?RS9zSWdsQ1pUbVllQ1k5Q2RsbzI1Sks4WHl6N0MwS0QxSUxONGM2WEhKTm5s?=
 =?utf-8?B?ampMTXJ5UGlmQnRtMDhLd2ZwRzZhQ0hPMGVyQzdnZDdUd1c3ZjdmWWRqZjFL?=
 =?utf-8?B?OE5FQlN5VU82eEVVTm50QjkzOTdqN1Z1TEpwWU5LcnorZXpkR2p5eUx0VVBs?=
 =?utf-8?B?cGVDemVtQXJuMzlqQklEQ01rTU9YY3BQNzVnVEZLSkVQMVpSYkFxOUphbVZx?=
 =?utf-8?B?SjJKQW9OZWlCNVFkZlF6NVp3VFp2YWIyVDlNVzhTd2F4WERTQ1Fqem01UFRV?=
 =?utf-8?B?VzFtUENkU3VOUmIrOU9xWlNlMXBROGM1ci81aHdOK3lUMmJFbUhUTThKbGRv?=
 =?utf-8?B?R1JCQXNWZzF1QXREVlJGRGYxOUlEMU4wMmREeXhjVzh0RkJ1OTYvekd2QWlM?=
 =?utf-8?B?WDFFSkUvcDgrMlkwSXptYXA5ZXh4YnlVQjFpREFwYlJFK05BRXNpOEIrY0RH?=
 =?utf-8?B?S3U2R1Rpc0pSVEE1bUlMMTkxREs2OEVtaTlOOHl0L0F3MXZEYTEvd0ppWUxa?=
 =?utf-8?B?YktkSHFsdjdtcm9BYkt2WXNPRTJGT01oVzZ4eUFiYzBvQWI1bnFRMGp5ZTFz?=
 =?utf-8?B?ZkVCUDNvQ0pnN1NDRjlEMFBlMFovYlhsNTFpSXZMSGdIUFd6MnNVRWVZemNp?=
 =?utf-8?B?b1lud0xQS0lVWjl4Z1RkeHQ4dmlleDVKT05WQ2c2UVU4UU1IaDkyZDlXdDBC?=
 =?utf-8?B?S2dLNmY4WCt1VmU5ZzBuSHpESEQ1ZkhYOUNTU01uVmJyOG5sOFR0RlNxbmp0?=
 =?utf-8?B?RE5kM2lDbXZpdUx1OUNqVUw0Qkh6anhSQXQ4aUVhd1BhN1E0M25FSHJRSG0x?=
 =?utf-8?B?YlhhQzNndy9PaGF1c3I3azU1NXB2bTZ5cDR1OHZvREhDa1U4aTR0RzBHdDRs?=
 =?utf-8?B?L1BLWjc1NzBRTkdBZUQ2cHg1RkhnVWFuMXJBeXNpUWNCallUMXU0RTJaOTdT?=
 =?utf-8?B?cktyMFdRaXlweWtGUzZwVXRYeXJXcTBGSDBxNXR4b2tZeWhXMEFmem9ZUmlW?=
 =?utf-8?B?R2o3RWtUSm0xYllrLytrSThMaFI5QklGSkxvcG5xdDhXZDgvWnNoeGtHZFNn?=
 =?utf-8?B?QXNaeVUzb1NlanZmdVQrM3hydFkrVWVEMUlkcHVnSVdlV01XeDkxbTc0dkFL?=
 =?utf-8?B?djd3OFNXWlNvbnB3VHdGYyswTjJzcmpTQWdsZDVoUFlqY3Q3RSt5ckZRc3RW?=
 =?utf-8?B?SC9QL1RnSW9EWkxJODJYVXpKaGpzUkVodkkzUnBwS1RSSnY1UHV4NC9vQTAx?=
 =?utf-8?B?eDJ6YU5iMHJ4T28xRVE2M2FGUzNvcEZXVFYydUtwdVhWMjdSWFZJVnVzZlRi?=
 =?utf-8?Q?89ho0mQSSCzbw8Ia7SD2g7BsZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XzsRUoV41vZGUrD6omOCpTOzUvu7Ue5lqoOjrVQhvfHy5vzlgIlw3IBi7RyOrrz39+Kqb8qsuVCwjOkbBsPvHi3QphRfLqt54BguZwBr0PqkXrV3VXehGAKtTsb4yxjVDZUZfJ4P7T67Zd+CXZvx0H2PZnemTHMoBe+8SUe24c1I2kctFgY645e9kCnqhJWC8Qh6pIeGH/W4X2hjmwNvthb9VpQ1Q/EFR5ncWgPBl+Ef4sHz8fCDcS0w7hT/wPKkRNRjTk3NFy8+J2VRdnxCqWCsHhZ4ALa7l+P2MB5yDvGQH2rBZfjC24C67a8Rjiu0qa7GWm5dk60cbjABXvLQmOtseNiefVLgELROSH+PiX9QNTMkssR+Kpg2ac9noBrTgVEHFumpc/WWqPS4jRau9l6GD+U3/L6iD7kWSnxtFdAB5yKm9x8YdjRFVFzCkEcfqvgk1GCAvQEFCJc4m8NMmg2MRddvkX5dK0kuOGAs1oRQHXnLHvbMp0sGckMTAbAe1MxPG17c1MGnrpZF31HJ0cVbNSx0KInVEdVl3mVgOnUrEnZ4vHEFIAdL8N8WgxunQwKAXoxCYipCzPS6bAo/pEEKiL92n6pz/DPCLYFMo2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c5f059-a45e-45eb-45d3-08dcc66bbe62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:42:03.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJUw/PHxs/2PqxIPXWOwlfgReKMdYxDffp+EFcvMMl+wD3TILRjA4Z9pInSTC1mzaWaVnXEAwZdetcuvY00X5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408270057
X-Proofpoint-GUID: gwCRI2FRYpodb545sb6NnifKCBGGtd3Q
X-Proofpoint-ORIG-GUID: gwCRI2FRYpodb545sb6NnifKCBGGtd3Q

On 27/08/2024 08:35, Li Wang wrote:
> On Tue, Aug 27, 2024 at 3:20 PM John Garry <john.g.garry@oracle.com> wrote:
>>
>> On 27/08/2024 04:22, Li Wang wrote:
>>
>> +linux-block, Jens
>>
>>> This change allows the loopback driver to handle larger block sizes
>>
>> larger than what? PAGE_SIZE?
> 
> Yes, 

Please then explicitly mention that

> system should return EINVAL when the tested bsize is larger than PAGE_SIZE.
> But due to the loop_reconfigure_limits() cast it to 'unsined short' that
 > never gets an expected error when testing invalid logical block size.>
> That's why LTP/ioctl_loop06 failed on a system with 64k (ppc64le) pagesize
> (since kernel-v6.11-rc1 with patches):
> 
>    9423c653fe6110 ("loop: Don't bother validating blocksize")
>    fe3d508ba95bc6 ("block: Validate logical block size in blk_validate_limits()")
> 
> 
> 

I feel that you should be adding a fixes tag, but it seems that those 
commits only expose the issue, and whatever introduced unsigned short 
usage was not right. Maybe you can just get this included for 6.11, 
where 9423c653fe6110 was introduced.

Thanks,
John
