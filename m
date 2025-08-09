Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5C1F8747;
	Sat,  9 Aug 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754727719; cv=fail; b=AKNMQdUMQhcXRA/1ELKqjYstw4qR5TcFv092v7HPJMSvevltpRmqQU4zcjzXwdYiq++wg/cmPAXiY6bb2sCV9dhZSnLKJN6C3xw1JdUnnqfuRIRgH/rlAoYBkmllZpBRY+fMcUYg0i0yb/F5uI1z1+2Aj5lyhByodrWI3ZKbY34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754727719; c=relaxed/simple;
	bh=VY3yooPhUIM7nGgYMnFvfKWaUvcQLKqP+5h0j+YKvko=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Jn4FZvOw8nWvRPHoPNCSmGoPNuhUDUB+W40zr5AP2p2KN3FmRucOeHOcpadmvYuWUtPlyHw+8PLf7wWn3VwriiPzkN/134JOMeIXddv+9HMYPdih+G8yYO30J+u26OjyL8KlDs6ot48uJzhSJYIQY11/F8CkKqfuCuIVD5IMemg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwaQaQ3d; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwaQaQ3d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNzqBxksdTqno6gdqy/tiLwt7BbBosIxI/NvXWEVYs30uD99ZnLollsLEbJBASTE7uwE+QZo7tPtdsUoSFoR2dMJzsKhRXmRgcMM2hpKAt3wbQtWys8UQUVk3HOV8fb2/rUHTv9SN0C5XBcnimRqOxlvd7+ZS9knczjqNrAk5FYc3xFuVdvNVeTRtxrbxXjqXsXFrLEWMYVOyYsnbQHwb1uwSHOR2SeJg5BGwn3KlHnh/KJlySx6RQzjMxH/8vJLC8p8lI1qZgOn9tAkNsXXla6SF8fXbUtXK3itQxmfKGovbYEDs2LeKW6RSangTgeyxd0emcgdrlThwQufOTXVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixIWluUuxNZt8DE635iJy5N0AmzdBDbmFGqEpKnBrWw=;
 b=iP1jetr/9zO8IFOCLM0jBtCO+Z0PgzAjUAHk/8pIeHclptNBz3CGGcr5UD7XShFF8H+puIxLoWU7pvE6UssXOqnNEdWgHPPktuuat47RF9T1MtHnhF1+yptNtSKAIpsytAoLCBgjINFNKsOqRiMtHFAKSjef6dfWQMeLMHszIZDPJD5fVzG7d/omIhrIp6dvAFaFOGPHwhe0O7yMbK4nQORpR5LwBGo9rbmcVaewUrVWOx9ciYg8NnOwVWsn2nLRbViswlMzN8bOE41qQPv6ldt+QyZfYITlA4oDVAZjpP+9XK7gGT/n0r8ZwguZmEkRS3w4w19icm1fwojmtwWTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixIWluUuxNZt8DE635iJy5N0AmzdBDbmFGqEpKnBrWw=;
 b=AwaQaQ3d5/rD/YwRmWEgMqZzTw/kBQnNXzWtaaPQOzrOCbyoXIr4NZK/XixQ9BFFkmNRnduGMbGQbGjYoPrKXQBN7x6tf9rbZhHTv0F/OW7lQZkizjsiI6/87CB3EkBCwV2FcaO+ZunftbFWwTh2baNpkBIXxbfdWQD+N4y5fVzPYB1w6fzrfOR2wVCPxcWuQyGiU1lAezl7Y0j4EsEE6xa8LTCAJmMXBlR7xp3GIbF1oXchrsfHpQnArafKqjo7pT9RkJoyjaykI8jQLDnx6feh86dOHNSnyIhhxbfLeCYLDrWI8Tsxk4VxkASn2Myw5r3UrUOaeIjDxSlO1pbL0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Sat, 9 Aug
 2025 08:21:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9009.013; Sat, 9 Aug 2025
 08:21:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Aug 2025 17:21:49 +0900
Message-Id: <DBXR255ZMW6F.2AF1IOPN7IPI7@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, "David Gow" <davidgow@google.com>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] rust: block: convert `block::mq` to use
 `Refcount`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Tamir Duberstein"
 <tamird@gmail.com>, "Francesco Zardi" <frazar00@gmail.com>, "Antonio
 Hickey" <contact@antoniohickey.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-5-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-5-gary@kernel.org>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: ad542807-123e-4608-9b2e-08ddd71dcc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVc0UHJJMnpvY0EvOU5RWXNMbWVDMWZ0MXFuUlUweWorZVZqTU9tUEI3enJ0?=
 =?utf-8?B?OFhDR2xDK3RmTW1NalQvTmVIYzZ0Y08rZ2dHWVlxeHVWTmN0TGNWN3czQ1Fo?=
 =?utf-8?B?ZXFmL08xcG9HWE9wN0MwSFJ1TnRocmNkZk1xRnl0ODk5TWlQWFhRL0JoQ2hv?=
 =?utf-8?B?L0VkT0dib0R3eU4rRTFBZDZhTTJkbWRHZk9oK0poL3ZkNVRyRjJHZFVqelFM?=
 =?utf-8?B?N3VsWDBhUmJ0b3lmRkJKcGhwekdBVDE3bHkrOGdlMEt3eUgwSUR6WXYyNnZa?=
 =?utf-8?B?UUR0QllIR1JCV3pPdC9BSWtCN0NGaXVUWWJUU0g4TzNtNjJpdi9JS0s5R1Uv?=
 =?utf-8?B?dGVRYjFTck5lVXlmWjVoRFJZQnFmZ1ovcEg4N2FTbkwxWURLZDFNSTFhSm5I?=
 =?utf-8?B?NWFTNHRvZkFvWUt1cWdheFhvSlM4SmsxRzFWd2QyTi94RkhGcllwZ0ZId2I3?=
 =?utf-8?B?czBLY1RSSzZjWHlPZDNhdHBXWHk5aVB6cFdsbzJJeGFZTkYvUGVUY25ib1lj?=
 =?utf-8?B?RDd6cjE2M0xYNUFwbzFFS3dSWUxsYjRDTGZoeUx4SFNndFlnZnBTMmtqa2VS?=
 =?utf-8?B?VWpjMjVLOTJzRlJWZi9HSkFKTkZLVWNOSThqZmZraUR2ZVVjWWgzWlhRdUo5?=
 =?utf-8?B?OE1YR280ckZmeGphUmZmcHZQVWVGT29yTEJDUjh0UDlXVTRZVkRVd1JRMTlz?=
 =?utf-8?B?UTkzRGxYZFdESHlHc3kvRmRyeW1Ub3hOSHZjaFI2c0RCZU5rK0MzVlRtRzUr?=
 =?utf-8?B?am90MTJHSXhxZjJwQkpmeUNaSk1SYlNtWk82cTRIaDZqVHI0VE40a01Hb3BS?=
 =?utf-8?B?akQ1MFBOQklyaDBkV0x4bytDN1piNHlPMHlCa2pFVDlOaDdMR3JOR3Z3Ulkw?=
 =?utf-8?B?WGQzTUNZbXdxRE16UVU4QWhGYm9IZE16MnRtYTFQR3dKNFhBcGcwMVoxS2hj?=
 =?utf-8?B?TkVsM2hqaDdpRDV2dmZPeWR5ay84b1o0bUNzdzBhdGRsbEc3UTZ6SFlkNDZC?=
 =?utf-8?B?NHhGeDV5aCs5YTJOSXlLRnl2NjdWWnBRdEZjSzQ2aGVSSlR0aG9aU2pzV3pm?=
 =?utf-8?B?VVBWYS91dWxISWlNSXZhejV5YjdsSVRMUjJrbWswSmFDTURmT2wxOWZRaGVs?=
 =?utf-8?B?SGlueElUNnNaaUwvRVVoWEE5NUh5ZGp5R09GZmxBckdlVDJMclU3K2RUK2NB?=
 =?utf-8?B?cFNWWkVveW5JVGM5OUhVN1R3MWo3LzhZWHlmMnlVT3c0R1BIUlJ4d0kySC9O?=
 =?utf-8?B?YWJVd1BRMWs3N2swVHhXUzNjd2xiSVZQMmllYzFFdXg3UVJ1eWpFcmdvN0Vw?=
 =?utf-8?B?dzRrZWZyS1d3eEtJdDJzMzd5Y1lwOEllb2d2UWI0YnJrM0FQdUJ0Zkg0TE5n?=
 =?utf-8?B?SXVvVXYycm1QeWhBU2dSUFJucnZvTFJJaENTaEtnWnROVUFyMjdZVThwQndZ?=
 =?utf-8?B?M09OamVhbVgvVFJkbDIxK0d5QjNIZHRvaVY5ZW5pV0piZE9zYVZxVU9NdkJu?=
 =?utf-8?B?TDhqdm9IR05DK1R4OTVFQXh3OFpGcDlwMDlpNXp3cEIxT0MzTFM2YnNtckZn?=
 =?utf-8?B?Q3V2RjhtVUl1bkt2OEFMSzJ4WW9ZZndpa1FmWDhKOHdrU3ZaZmFnY1k5OXNY?=
 =?utf-8?B?SE9FbHlOWDNjUnBPRUNDOUhmMEVDd3pKU1VUMUlMU1c5aC9Tdy85N1R5TkF5?=
 =?utf-8?B?NkI5NHI0SkxXL2JUOEhqUlFIQzlqQktFRXlvSHA0a0gxRnd0aWxkcFFSZjNp?=
 =?utf-8?B?Qm5McXNXT0daNUhzd2RVaVRRYlI1cXI0c3EwQXpKZmwvN2pjVnNBMk5FUVlY?=
 =?utf-8?B?YlNMaC8rUjQ2eGhidmx2K3FseGNtSFVQSDUzeHVVM0tvL3VSYm1HWTRveno5?=
 =?utf-8?B?RFJvQ1R5L1ZtdzlnYS9WT0JqRGZHRVF2cjVKcWtCOUJ1VTdJVHRPQzY3Rjkw?=
 =?utf-8?B?VU9BMlA5azJHVnhrcjJoZk9YSHBseTU5K3gyYTZReVNLdTBES09uYWJIUSsw?=
 =?utf-8?B?VzV3cXEzTFV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzczVG9WTC9yUGZ3M0RuVWdzTUpKVER0MS9xVUhDNGhOMFB3b1MybjNVWVpw?=
 =?utf-8?B?NVRGTlN5Tis2WU1hcFErUndyTnRSODZzZGY2YloxZkJvRUtIYVhRRHpuT3hP?=
 =?utf-8?B?NUxoU3VyTWV4M3gvS0RHMHFaME5XM3c1UEdWc1d2WFVSWWMweEhabGdPSi8w?=
 =?utf-8?B?OVY2cWhkb2NDcC81cTd5L0VNWUplV1NTaUFvSXRQa0hJYmEwZVNEU1VwUWJj?=
 =?utf-8?B?ZjJyYUF3N3U1QzYvQjhGVXFjMEd3UzQvVGFqamVuOVhjN3dNOUdCdGZTWTRH?=
 =?utf-8?B?Wmp2WnRkcGNtNW1nelN4eDU5VW0ydEhub3M1RVJEbmhPdlFLdHdMMS9xVnlp?=
 =?utf-8?B?NTFGQno3aDdMRlhPYWVSRi9XYzhUK3g5WFZYTHQ0aUo4ZWlWUnFoVEpkeWJ4?=
 =?utf-8?B?b3QvZDZqMndXcHVqY1dqTittL1Y1bkhHbFNZME9kUzM2VkpoWDZGMS9VdThH?=
 =?utf-8?B?dXdrVFc3Skx2bDhyWHBISDczUkMvK1RPUHJ2dlk0L2J2N3VocXZYSU8wVUFB?=
 =?utf-8?B?NUEvWUJrZlltQVcxUnJDZlhUSlN3aWN1V0NGdXFoMnRKYWJzdU1hS1V6V045?=
 =?utf-8?B?MFZ5Z3RPeFpCOEtRMmhubmJrUWdrNUxrNHM0SGIvREtKajlLVHRESjRJWTFk?=
 =?utf-8?B?UEJGSVpMem1XbkJEQmdoMCszLzc5NUt2QmJyWmVEZVl4emF2elRpLzdWaWo0?=
 =?utf-8?B?VGhqNlpZb1VrUGJBUXdzNXF2a0R5dXczSjR6ekhHTEVtSjgxS05hWlJXSWxU?=
 =?utf-8?B?YUV5K3dvdkhUSVpBNUMvWVRWNFlLYWw3N2lDaVMvbjUvZi93d0NmK0pybUhT?=
 =?utf-8?B?ZkZydjVXTTV2aXR4RmZBSGVXb1J4bmdadVZnNEF0ZXk3R2dBenVEVFVBRzd2?=
 =?utf-8?B?N0lZRWN5c0RXZXRsZVo0bEZWQWFPYkt1czRCbXArZkh0RW9DZ0c0NnpwMlIr?=
 =?utf-8?B?ckdNNE9vN1JxRXB5R05Xbkc2MytON1pTMXVZM08vRkc4UDZXdWFDa0lZdndE?=
 =?utf-8?B?UENDUDkvYUNxQTQ1K1FyS1hKanVNbGFLK1phYWFET2ZEK1d4dFM2MG5zaFMy?=
 =?utf-8?B?REhVZnNZK1c3c0V6RVRPOS8wcHljVkJNZmtTR2pXTGNpSzBPR0RSWnpmQ214?=
 =?utf-8?B?R1hNVGZpczI5ZXNSa1BKckkzVHVYWWhEd3FMOFBqT1pvN0RvelFWamxGVG93?=
 =?utf-8?B?VUZnVXVBRTQ1ZFFGdS9QeS9oWFNxSzg1TTFzR1hEejJJeUFuRi9PTWRYTDBr?=
 =?utf-8?B?Rm9LWG5iVndUOHlWQ3U4T2MvZlppOVZIczFReHF5NTc1VGE4b3l2VjNHT3Yw?=
 =?utf-8?B?K3NGMEhuNGt2QlNXcGhrd2VkSG5CS1RUTTZCTllzc2w4WDFqWnJqMW9ha0NX?=
 =?utf-8?B?UTdON0k5U0prWmN5bFA1N2c5MnNySDZPbG1UR1NYb1hkNnlra2xXUDM3N2tM?=
 =?utf-8?B?dmV1NW5ibGgwTHhoWjhVaGhjN29weXdENmZ2ZCs0RFZadlRrbzRLazl0cHdo?=
 =?utf-8?B?dGVHamVaaXhxT1VKK2V5VnBDeFI3U05zSkM4Rlk1a0tyZmxjcDFiSjZoRjha?=
 =?utf-8?B?bzlxSUw3RWNDSEtWYURuR2ljOWpoQjF6T2IwV3Y5bkpOdE41dkRDM3FUZXRp?=
 =?utf-8?B?U3ZkNVBoVkhsR3g0TURPU0JLRHVvS2ZRVktBc0duY1k1MWNicWhXdzU2KzFS?=
 =?utf-8?B?dytyRXY4blNXeC9uU0UvK0ZicU5GT3FxT1lTWGFyVWRsWkZCZGptZ0tBUzJX?=
 =?utf-8?B?bHJ3Wm5WNzRvMzI2Ky9oZUNJRDl3OGhUNkVpSjgwd3YzMEJJOHpvR1Y2c1A5?=
 =?utf-8?B?M3RHSkI5N0ZhejR5NW8zYTNMaUhyYlVac21WZXhMOFRDenJyeHVzK0xmSVRJ?=
 =?utf-8?B?ZVU0U3M1ZzBRUUFMZGx3TEV1bXNlMkpNRDJEV0EwNEJFdWpDdmtXWlRHajF3?=
 =?utf-8?B?SlBwZUdPbWpmMlhFcW02T2xwY2tBZUVUL1RmWmE3NjlzREw2VUpleXBJT1M2?=
 =?utf-8?B?MDBiN0VtUzV1YjVwZGd1eHNqMGYyWVdHTGw2NjA5Vm9pRnVKcy85R0RzcWpJ?=
 =?utf-8?B?ZXEzL2JJR2pFVFhTVTRaNW01TUV0SmJGMHRnZTlWcVpWUGd2K1VibGNqM3RG?=
 =?utf-8?B?ek5QcS9HNFVNbVFvZS9xYisxeXRtSjJMMDFEaTE4WlFzTWl4cHZDdFVaM1pK?=
 =?utf-8?Q?SOUPLCeuWY8boVpdvvxj74Y4Sxn4X3O4sJ4FOHFGW6lI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad542807-123e-4608-9b2e-08ddd71dcc3b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 08:21:54.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvSpPEMhdlqwhdKMHlrAYk/NMG7dAFLx3gzJtLuEtGDlgDgsg5Q3tzpdbsyjb59Jra9cvfIquaFUPzWO7KWplw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175

On Thu Jul 24, 2025 at 8:32 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently there's a custom reference counting in `block::mq`, which uses
> `AtomicU64` Rust atomics, and this type doesn't exist on some 32-bit
> architectures. We cannot just change it to use 32-bit atomics, because
> doing so will make it vulnerable to refcount overflow. So switch it to
> use the kernel refcount `kernel::sync::Refcount` instead.
>
> There is an operation needed by `block::mq`, atomically decreasing
> refcount from 2 to 0, which is not available through refcount.h, so
> I exposed `Refcount::as_atomic` which allows accessing the refcount
> directly.
>
> Tested-by: David Gow <davidgow@google.com>
> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/block/mq/operations.rs |  7 ++--
>  rust/kernel/block/mq/request.rs    | 63 ++++++++----------------------
>  rust/kernel/sync/refcount.rs       | 14 +++++++
>  3 files changed, 34 insertions(+), 50 deletions(-)
>
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/op=
erations.rs
> index c2b98f507bcbd..c0f95a9419c4e 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -10,9 +10,10 @@
>      block::mq::Request,
>      error::{from_result, Result},
>      prelude::*,
> +    sync::Refcount,
>      types::ARef,
>  };
> -use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::O=
rdering};
> +use core::marker::PhantomData;
> =20
>  /// Implement this trait to interface blk-mq as block devices.
>  ///
> @@ -78,7 +79,7 @@ impl<T: Operations> OperationsVTable<T> {
>          let request =3D unsafe { &*(*bd).rq.cast::<Request<T>>() };
> =20
>          // One refcount for the ARef, one for being in flight
> -        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
> +        request.wrapper_ref().refcount().set(2);
> =20
>          // SAFETY:
>          //  - We own a refcount that we took above. We pass that to `ARe=
f`.
> @@ -187,7 +188,7 @@ impl<T: Operations> OperationsVTable<T> {
> =20
>              // SAFETY: The refcount field is allocated but not initializ=
ed, so
>              // it is valid for writes.
> -            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).writ=
e(AtomicU64::new(0)) };
> +            unsafe { RequestDataWrapper::refcount_ptr(pdu.as_ptr()).writ=
e(Refcount::new(0)) };

Ah, so that's why `0` is allowed as a valid value for `Refcount::new`.
Seeing the use that is made of atomics here, I wonder if `Refcount` is a
good choice, or if we could adapt the code to use them as expected. I am
not familiar enough with this part of the code to give informed advice
unfortunately.

But at the very least, I think the constructor should not be made unsafe
due to account for one particular user. How about doing a
`Refcount::new(1)` immediately followed by a `set(0)` so other users are
not tricked into creating an invalid Refcount?

