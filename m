Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94130E85D
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517111; cv=fail; b=JsgcrFWlr46xf+PfYB2VE9ppC9FJRCVZ98SJQ4BMCMlRlZvMg9efCjpc72MzyA/xQpLXJFt1KsDnPWJAHQ3D5yRdU3mczaSHqcY0L23LlgYM6awsiiMOZ39FOm/xcvcGEpCVrEhvCKQCHPENK6pk9Zs03CCuFOTOoWInlBLvWeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517111; c=relaxed/simple;
	bh=5m3Mmcea4UXvethBjo5FXjokUoY9v7bn5Vn9uIRFNDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JmaLk0RddCgARsOLjvHYX8OlvQRKd1aLNB+S1z7sn5JDaJ9y2GzT4k6x/3fSr6CqjmeWbR3GSQsr01HutqUckjE1Qbi6rCJ9QzcXyPqDPElXGL+QlVXQWVJItihKeauFj7Xcisf5SkqUvsWyXZuovtmrZXLq491rvv7E3ily/G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=gQfKMpjo; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gQfKMpjo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPzk75yxz9QYtguJpa8Nf/8cGnLPaHNXS2DCAlopQKeXzOjt8W2WgXoLZLTrUo+28bxylF7psPCtpOuLENFCPBbtulXWKan7j2fE7B11RaN/VlO4Ek/Ppqlq7fDu83hViHQbIdP2+7t7SA6275ZBFhiKZDYgVPFfG11kwHsJLNg0gkqh4sjvb8RJ2kJnpKPy8bgEJVBS+pTHkbsrRZoGXXGwnNb7Mxog1fxUFP51U4U8KwZ1Ewh3XqP9Hb5UTyp95ns3Ue4N/bgIQe6Kq87NTin4z/Ilmma4Js4bNf892Y2NlZXoj3J7ZpsT8nNZ+LDLdUZPjUYAvRde3vg5Yl1uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDJX4A7RO1TsM91htWEc7yAdpCtNWD/NBRrjFvhcMWk=;
 b=L6kgwMqnun6RDbgIZZUE0WhoXkmMqldywJ0r19OWMNbj991D0aD+ENFLg8RQ3F+m4vHkeJdcYJoDH9mEHZ8XpY20rXfa3JpgMRTYsNUZCF1PB1N8vozZkrJGRRjm+DjGg8HvkWv7OSNs/NlxuzHMYJYH1AtvG1WFvXXYGg1SBsJcaALNk3281FuCLvcqWYKshrV5XsHRgpdYrIEve1dfd8auF6g25X42D9WEn3tON6XSRPo8NSaRftXtm9OUTKpqhj7bc0TrvkWGFYCFkjsXjo0c1QrrJt2vZgv/BqQv5/l4jesHfxggtvRClVevVCyZdHR0a4iQesVNuzT+egxAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDJX4A7RO1TsM91htWEc7yAdpCtNWD/NBRrjFvhcMWk=;
 b=gQfKMpjoeZ/W80Y3QHADAeGYr1HXnY583TyxqCXaFZvpGO7i0/uCsZg3yEj35RwMxyPW4jItu1yRg+PVya2FNLvUgwv4a2jq1GF1MXNviwIblEzUmetefXaoctTJ9Jg98vdI9zdGNy89HnVhjN2NmLD60S+CKSp/UppMXGqatUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH7PR03MB7860.namprd03.prod.outlook.com (2603:10b6:610:24e::14)
 by BLAPR03MB5617.namprd03.prod.outlook.com (2603:10b6:208:292::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 09:25:06 +0000
Received: from CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343]) by CH7PR03MB7860.namprd03.prod.outlook.com
 ([fe80::f5ba:35df:1c9f:b343%4]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 09:25:06 +0000
Date: Thu, 26 Mar 2026 10:25:02 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 23/26] xen-blkback: Enable lock context analysis
Message-ID: <acT7bt8jn0XzIL2p@Mac.lan>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-24-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325214518.2854494-24-bvanassche@acm.org>
X-ClientProxiedBy: MR1P264CA0031.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::18) To CH7PR03MB7860.namprd03.prod.outlook.com
 (2603:10b6:610:24e::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PR03MB7860:EE_|BLAPR03MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8023ae-9b63-4924-9923-08de8b199168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	XJLfofhPM902PCl54e5mbvXXeBLutIlFMEDRuLesXGzd064XD8fh+1mBQjoJRM0wtmwBwc1Py2KBU0cUBxEIIWLmMdLn6rqzHCT05IloH8xrcfaTAoXvS989iTgN2TlXy+8tf9beA/fZD15Gsaib3pNKJyKiMYf3EcP/mMz9Zk4aHUaslZxvCxsBXt0Wupb0d/d0sCpXzIqxPybohScTA+6Zvqs4BfYkvu84XfWqhm7Uywwn/QLa7xlabcddDGbhOI0U1Q1ECtec+HYPpML79qwox3H4nh0LFTi+bhFN22ZMX5bUbm6cOMjsVPDHWuOkK24AWHwdzT6F18azSRgsghhnJEHnAQI48etFuKRuXceT7m7AvvYcqdeGGBeu/PJqgP2VHYzOB1DY/6yB8lpjzQHcSNmbKb7YcH8E/Ta6hIxnki8sjMaM60TwKGEJEVcmnAOWx2asAZMPASjr6KDToKy8I3SBYe0XwCP7+XmgcxzIsunSJtpX4j6FZqgqpRvPiuvPuWq8/FAKJa1xD6fINF+Kt3iDoWehUjMjFW0TjJmavG/gkpHhiQkogzOv+WtBdqFIHS+RG9OW4b+PDPgSPoRPJX8I1HcEWcZwldD+byQ8luISsl3/ee7A4g0rKlS+Yfuf9xLP3goCYy+YiVI6Tt5WnIFN/QFDphxFfzMNUjIfrd0Sa066c4pH8ANJQ/YUaxzqspSH8CioVeECyNrQxpws3GGh6Kvx+baNVA4TIfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH7PR03MB7860.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNkQmpobENEdEoxMysvMHNJalprU0lEUElUWWh4bDJick50RmhCN0ZidE4x?=
 =?utf-8?B?SllhY1d4QkhHS3ozb1k5QTBPdFhnSUJESVFKSWpIaFE3M0Y0bXQxd0NKWnRy?=
 =?utf-8?B?c2NsazdlZlhDdjk1SUR4RTFZdThTS0JHaXpaSG1XK04rVnYvSDFOa3NRdElw?=
 =?utf-8?B?SjllNmRkUXlyaWUzMXpXZC9RZVpTQWhuV2pLcEpuQjQrUytrUkhhT1QvUlYz?=
 =?utf-8?B?QUtYR3k3dk9FdU1GMXVXWi9kR2tjS0NqUEZ6ZExENldMeEtVRy9EbndyczJ4?=
 =?utf-8?B?Yms0QnVlcEM3aWpFZWN2enlxVmN1czhnWXF4eGJhZnlxNnlnNHhuUEtFWGd5?=
 =?utf-8?B?SzZwTGhrRXUyVlpJTVQzU05aOUo2ZWR0M25SMG5kTjc5SDNJUjg5eSs4UEN4?=
 =?utf-8?B?QTRyRHVqaVFSbWcyT1NlQU5mWTJoZ2t5bWcvaGJoY3VlNXQ1M3ZZUTNLUU93?=
 =?utf-8?B?Qld0TXgwMVhCNlBlYzRUZDRnMllUYXpNVUxxNW80WkhRbWtMMHd5WmVwSk1L?=
 =?utf-8?B?bk1kVE5waC9MUVBybTczSmJjaldBZUQ0QzZ2WWVNeHZNQjA4RHhIbXJRK3h6?=
 =?utf-8?B?RGh5bjRGa3UvK2l0MFhIUGpIUTRFTUlhT3RMbFQ4Ui8xN2tvMXEwd2lST0hw?=
 =?utf-8?B?TEFDTE5zTWVwWm5XYjNKdVNnblJmRlFKSUlXbHBUSWhvY1ZWRTJZSmNTWkU2?=
 =?utf-8?B?UE1XNmVyVkZma0RneHJiQ2czVXhwdDVPaUJsWUVuQ3NZclBKNUwyTlJwaGph?=
 =?utf-8?B?c0tUeDIvakZtOXdjMitDK085TnpkYlVHQ3VhR3o5VEErTitnTHBMdWRNMnk3?=
 =?utf-8?B?RFY4YXpsay9PY0FPNTBkRlRxSWVxTjVwVW5Oc2Y5MmtWNzlyT0RibWlUOExS?=
 =?utf-8?B?cTl0YUxEdkM0S0RDcnB2a2JNa0FvclhQeU9FRmcwUnpUNER4WG1qQzNRbFNE?=
 =?utf-8?B?M0VPV1ZVcDhJUjR0R1NUclVIdTQvOGtCc04rWUh6Qkx1dHBveU5tLzZrTU4v?=
 =?utf-8?B?eHFJK1ErbkR0YXhHanZ4NTF2MUdENHYxcnFBdFpPam9Pa3dubEt1YjY3dXEz?=
 =?utf-8?B?QXhLM2hFODhKaEt3aEhNSkFwZ0h4bEFnbnI4eS94cjFRbGF4b3VMam9RU1FD?=
 =?utf-8?B?QWJJZ295V2d6MUpsa0h1NENnVVJnRlF1dENrV1Y1c0h2OHNCdGt4U0RXcTBO?=
 =?utf-8?B?bzlRZ1JrUjBDUmdxRnpzKzQ2dE9SMVJYQzlvQlVsc0JJd2V5TjVRS1I3dlho?=
 =?utf-8?B?TVBLZVYyMDkyUzVzZU54ZUxWbUN5NzkyZnhBUzNSQzE0cnVPZEtEVEl4TDVw?=
 =?utf-8?B?U0xjREhXUTgzbTBTelBpWmJNSjZROWFHeDdzQTFhMUNHM29WaWRJMGkrbXY4?=
 =?utf-8?B?aFJUSU1VeUZrZTIvT2RrVHRrQXA5ampsNEVmd1BXVEVPUmx3V0JSdllNNXFt?=
 =?utf-8?B?NE1JNkhheDBHYVp0bzl6ZFFLTFBmWit0Y1hEaWV3WStVRHRTZ1hXQ0hWTHJi?=
 =?utf-8?B?S2hROEl1NmtaYWF6ZWlWb1BuLzIxTDQvcklwTTVIbXBZVHR2OTRTWTBKZ0wv?=
 =?utf-8?B?NGtEeWtWeWZwSExsYkNVK1pKRy9zTWNDUjd6RXpXRWRvYUQ5blBxSTVuVndo?=
 =?utf-8?B?aHdQZWQweHFtUm1NSmJ2VDl0cndiRDhRbVM0YXRKVDRDWjNJSmNIVTZaNEdz?=
 =?utf-8?B?N3JVMGI3OWl1ZW5USlBmUkV0UTV5YlBZMFFhbXBaL1VzSkhza1hibGk3RWFi?=
 =?utf-8?B?SXNTV045amd5bElOMEVxWFgycTc0Z0NZUFR5bThGUitzYmNSZXRNM2Z0UGVz?=
 =?utf-8?B?cHZlVERBMU1td0pLU0p0VHp3bmszZjZTSUYrT01UQmQwUk1GaEtzRGNiQ3Z1?=
 =?utf-8?B?SUE1RDJyVkJmNkgvQWcrTmtCT3ZXOHIyNkpYdk93QzdiNmdQOCtUWTU1YTJp?=
 =?utf-8?B?NnArVHN6K3cyTWFoV3lFaElZeHU5MUxxMkJaUzg3a0tPRDExTUNPTVRSVGZo?=
 =?utf-8?B?ZXFna1VpRHdLWFp4bEJ0L2ErOVFMblRnRTBmNXJmRGRsVkcxQjM2TjVieVk3?=
 =?utf-8?B?T2tpejFLOHJMcnM4MUlFZkVXTkIwUnAvWTVyWVY3UVdpSEt0QVhRNkZhdE5X?=
 =?utf-8?B?dEFVWEZUcnFKeDJBNmRna2M5M1JmTU5JODhNYTRPeEMxaG13YU9NdUs1UkM2?=
 =?utf-8?B?d0dielFRZ25MdXZ2ZWpuNFlEMmpydHRITC9QQzdPN1NBY25WL3hYbXE5QmU0?=
 =?utf-8?B?dW5NYzdRY1dMaklObXVaaWtDczNRMm5acnJ5S3NETEVkYVhaQTZUajl4Ykor?=
 =?utf-8?B?MUM5WWx2elJoQzN4TDdWVlNmRHkwWEhlbDB5V0w3OFdOQzhadys5dz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8023ae-9b63-4924-9923-08de8b199168
X-MS-Exchange-CrossTenant-AuthSource: CH7PR03MB7860.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:25:06.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KO1itkX7vfrjO5qhm9sBKojZVQV4Iz1OqEoSQL7gzDqC2hpuexA/Xl7Y1sFwAiAZjEj8mnwW36Je+ibNKy4KLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5617

On Wed, Mar 25, 2026 at 02:45:04PM -0700, Bart Van Assche wrote:
> Let Clang verify lock and unlock calls. Enable lock context analysis in the
> Makefile.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks, Roger.
