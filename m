Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678D2C326D;
	Mon, 22 Jun 2026 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125287; cv=fail; b=NQQml3Hp0PJ8hGJgwrJj5a6yQGai4LQaiqJg3UWLZEpi1ddfNE5FDUNeVTx1EOdmADx9sch7Ewc4SP4E0voiawniiymwfcu914LoU/NOlMn7yYm20gLFhgLrqNiSgPff86uzvv4mkcdjmKqWgKCzZD162UELnb4odG/ZHnWT8zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125287; c=relaxed/simple;
	bh=zTL2xa72KnAqESc/1nJiFJw/S8h6/zg1kSc9OrNiy08=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=JEkEJ0ZTcUJJyyUeQNoaxa+QcsxosRA7gXlSMQH9XXO95w3THSBvths+ieZ6oMqjs4TeseerffW7KrQkujTY49ERbH80zA4dvyM++hxRdJF8vAsUT7HnwDvCAL6P1MYSlaZA7hlbrKN+sRIcpKg7pLu5KNkGjPeQpMD9ErQOnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ytfriWXX; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ytfriWXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLjYwEfgVQW/zcUEpJgwuSgTypfS/h5VxAdgTsmZf70DEX21kFIROq/L3AEO1VzWhAy4scvE0qBHALYiD0YbAr8Z52vsHSi6IteG+r7rVKXCzMnX2iLdE0BO4jJ5vjZirdQeYIljizT4o4kA/6lXnDzW3DAcvJ3eh8iNKLEPa3jMoQ8/voh58KNy3YOqht7UeAvzAcn4NDDVR5VF+1iudrTSMGNdGh4020dkX/NFrj1CAWu0da2Rp0J1Jrnq6UFZv4x41vyUVNZP9VMsfePzbPqk17vKCN/ghJWlGpEMaWhMQP8/9+7FvwNJdgg6jWxXk/4wcFvoGizqv5MCS0bVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/PgOASC1tk+iV56jRNtAlvraXEi9Tg5B5Tx29lNr2k=;
 b=qEe4uoHAx/FSWZsgQnn9evU+gvEZnT6G//k2IZyfZYjzQZdBptK76KEsuY6Exzbw7TPNHbUJ5dhDZ70ZCcXl4C9lKv0Ljk/6r8oSUh1wiiYRr2gX2JhN6731EW8bcCivVJxVY9Rd6M3ts76dGw8+LAl8q7f+zDJTYcp++Rw9XYf18/8HzPU/UcC151a4140xso4EMmpHDYU7iYc7Uiqp/s4EXtfD8JBc06mt6en1X2g6pnGNIGNY3lvw/FBL5vbjdbvpysDbm5YOxxu9jajXD8dwzVuqzYbCOD8H5jr8aRzxDwG0mjHAExhkrTG0FztH3cm/PG7AIhh/aiGT6tfOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/PgOASC1tk+iV56jRNtAlvraXEi9Tg5B5Tx29lNr2k=;
 b=ytfriWXXttmvHZBkavvTuYycvu8tt937jEft9jqY/lu/0ER9toKAAijgQYJ5cnyOkQXsGgPxHxVG+PXbMyuxPmpN0D1Apx2Y9Z87l/qpstq1szE2+pOt5oy5c9fyb3KbGgRPQoHjxroEQF0t95tD8JpdtBAQ74j0aIjMGb7lCrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1963.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 10:48:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:48:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 11:48:01 +0100
Message-Id: <DJFIOS86RTEE.1N2P2EGHBFXJK@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] rust: drm: set fops.owner from driver module
 pointer
X-Mailer: aerc 0.21.0
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-4-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-4-49d45cb37032@linux.dev>
X-ClientProxiedBy: LO6P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1963:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2ab882-97e5-43a5-f5af-08ded04bbbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|18002099003|22082099003|921020|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AFIdiegEM45MlygFBJi4Asczk3pyOWLbrLIszAujhn8zODGqxZBAubjECOtSJhlT7Wni8nkyMV67GMlQ9u48uDc1Eqp2mZV9l5wer2NmC/ATHRDXXFpLsHJraNzi5ug6yu3vv3MS8Vld0pJiOwK8MFr2TjqlKD20Wqxa8qZ5M3MluTMdixjiyvoWDE7qWFAVQAD+FNrqtlqY4dzjxojOWHLE8il453P0hHQACnhklloH+0St/GIX/Vhup82ASZgC2pD1u2Lm0up7S9t2l0187M3lAm5UqafHA1y1Kx8WvwkMAmSYvFI61cX+FIbcOWVzy/vMKsvBzbF2hPU91GjoUgHAldttzl8qrhy7C29QrTXnxbuVhULarUR/kCLOFar9adXpNkZl6x1FL1Qs8Yad5QqzuPfm2rEzwkpgxKrisfrsyNZm7tT+p1RlEHlHvLeCYE+ekOQDHJITdCFhgr+p6ANq77sgFuvizaBfJcETitWSTHIUU5/WmkmYLHyLWYNDRhh9XlpwpQDLujGGgvTHK4cpIlaCBcbwLZK73NxvoX4IxMZo7/iGO27Zbv0v5xuvMvM1bNXdcguMocjL2oAsucoiOHmJIpEfZKjAyyhJ0PMQuxShIytt4PqFc1LmrhIQHwXSl2GPGBqddDTOGpflIMOnQ1eXeuMtr+ymQCk0MaiPwulCiCWKcjucEZ9j2CaUQMxey1ytwhAoL5o/hENweA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(18002099003)(22082099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG4xc2JjS21rSnlrZmc2NitPVGJOS09DbDY1VXNvM0NOMHI3NVA3SktOQU0w?=
 =?utf-8?B?WEV2bVBpbWt2UTkrU1NhYW01SG9BWWNXSVBNZHpzZiswUFVYcURLUWNRd0di?=
 =?utf-8?B?aUljWTY0em5BcXdHeC9sb3puenozMEVLOFBYVnduWm80eGpQeGdxL1JtblFQ?=
 =?utf-8?B?eDFTL29VRnI5V0RaZ0lMR2FxbFU5RlJIRmhRNnVkNFhyWFpScEo4NUpUT1BJ?=
 =?utf-8?B?d3pwVDBubnJUazJ4RzJzRDNtZVJFZjM1MU5aTmtSNTkrK2MyTWIwU0dYcUc2?=
 =?utf-8?B?VmI3aEswY0E0VC9mVW1aU3VjWGlLUHJKZXNiNzdqZDYranlUUHlvSDdoSHBB?=
 =?utf-8?B?MkRnMU1qdGpJbzBuc2dkU09xbTI3ZnNSMUp6anlqdVBUU29XQzlINWJqV09m?=
 =?utf-8?B?MUp3ZEtFdlUvL1FacHNsUGdVVDA2WDFtZUJUWEY4K3hzSHdzMm8xRXc4MXh6?=
 =?utf-8?B?NnhMZCtDRVlFVHpPbUh5eXdrVllEL21yWXlOOEUrT2xXOStjNjAveFJpTTg3?=
 =?utf-8?B?VXY4aVFKNGZpd2trVTBiVWZjbUxSQW1vYUc4WnhVcGVsK2VzN1dSS0ZWbksw?=
 =?utf-8?B?eXh5ZlVHcVo3S3lRTVBJUkVQMUswdEU2OGhmTWZhNXJueXNUa3ZGbGRSa09E?=
 =?utf-8?B?cnhVd1RrK2pOclNOQ0l3bytMQTc3S3ppSTZoYUNrbFNzc2tkcEVMNmdYdXNv?=
 =?utf-8?B?eW1TRG5uMStUMjJJdXBOdjVRRXZmQjNuU05icmpLZ1NvR0ZsVXVDakxsM0Z0?=
 =?utf-8?B?d2RoRS9lWTMwckNibUs3YU41eGZkOXRuQjFTdlRxVkFpa2dpenJkUkIxS1Fq?=
 =?utf-8?B?L0ZqOStodGJMS2E5c1B3NUpudWRhN2VPYzdsTUQzVm5YSmVpcWRraWlhNmdM?=
 =?utf-8?B?RmpMVisxTXVRMERnbUszRUJhK05uK2poa0pyZThxYzlaWGpWeXU4NnZtSDZn?=
 =?utf-8?B?enNMd1hYQlFrTWxDV090SjRVRkFabFhTQzRRMUROMjNDWng3Q1lXV1VkcVYx?=
 =?utf-8?B?OUY2bVZtT0pvK29hVE9Uc2VBRVI3cmJ0VS9CWWttNjNsWnNKQTU3ZEtSbThw?=
 =?utf-8?B?c1FxaVpTNUY0R1VhTUpPMzNBUDBEazA4UFdmWEIrTU5lM1cxWmhNb0tHTjBj?=
 =?utf-8?B?V2JraWZnQkV0MTN5OTY0U29oakxwZnZJZzlRNmtoNEswWE1VV2JtUzZmbnNi?=
 =?utf-8?B?czBVQnhqR2o3WGJrUExFajdFaHZjanRLQXg5d2hyVXI1TGZ5a3JtU241MUdD?=
 =?utf-8?B?Tm9oWmJIZURWd003c0YxcjBheXhtcnBBdU5xQlBhTzlQMExuUWhlcUZFWmo3?=
 =?utf-8?B?QUVGYnZSSmtVUmNXTFVtckk4UERZMUI4SFRnVG1kaS9sdWhVOGhLaHlyOGRB?=
 =?utf-8?B?MVpVNnJJV2g0MGlKN1YrclBFOWpITHN2TEEzV0F3UW1tSDMzNEJSQ2ZYRnlX?=
 =?utf-8?B?SEhWNHhyY1RxVXpVcEFxMjZwOEpXeDU0SjB6ajRNNHN1MlkxUzFnODc0RG9U?=
 =?utf-8?B?NWo3REVqM2phazhabGFqeGZoL1ZNWURERzJsMjRwbjBqVjFaQURTVE16ZnFE?=
 =?utf-8?B?RHUrYWFnQndjeldUbUQ4cTVZL0lWY1Rvdms4aDZFTkllWkhqQnVBUG1qMlZr?=
 =?utf-8?B?ck9jaElEYnhKWGNocnF5dmhPZ2dBTUZuMEs1N1FvdlJJQThYazN4TFVDWFhh?=
 =?utf-8?B?VkpDb2RjTXVZR001TjY0MHVHdGJMTHBzYk1MN2RtSzJhcXUyME0vRStJakQ3?=
 =?utf-8?B?ZWg5Rm5hV2hwS1NISXd6amYxNm5tN2l0eFduYU1JeEJNSlNHQVlEaUNBNHpO?=
 =?utf-8?B?c3dtSlpRaG1vYytVUFRhdDJEWkwvTmUrQTMxMTJxcG1ON3Q1Y2xaOWNRUGpX?=
 =?utf-8?B?b01hYlAxU2pPUWdhd1RmazFKaE1RQUxwa2JlQUtSb0c4Y2ZvQkx6alVtVzFy?=
 =?utf-8?B?a0lWRFQ3QXRjODVuZXRxdjUvejNOZU5rMno5L1NPajh3Vkx4V1d2K09NZDRF?=
 =?utf-8?B?SitVK1VCeExPQjZXK2VGeGVTaERZb1g0NHp1VTNnd3FBTVpqdlFjbHduOHJP?=
 =?utf-8?B?VG9EV2JyZ3ZzVituRVQ0a2lRTTZuYldIeU1iT3FVZWdWZnJWeitmYTRLaUZa?=
 =?utf-8?B?Q3R3cnFzTTFvcEtrNWR6N0pqWDRSSzJUOS9WRXQwU0tUUmh1VTg4TGU2WGFU?=
 =?utf-8?B?OS9rdXRXODZ2djVzNTgzTWlJbnBMa1ZRcW5sdUw2Y1A5ejhud09NRjFmeDJK?=
 =?utf-8?B?YmNROEVQT0JYOFY2OEE5ZzByQ09MNUNmS3g3cTdGVnVlMVNGdVdya2JUeFVR?=
 =?utf-8?B?U3FzdzFCWndVSkNZbURPQVRZdktrVWdmR0pISEgyYmhmSEx0aTFjdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2ab882-97e5-43a5-f5af-08ded04bbbbc
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:48:02.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ouu4UmaWGgdCGzvwpwDdB2JNG7Z7oorvqdmRUS/g+Sb2xV3A4HFTQFvAIsguEFHG4AxBEoWwnGPPaLoOZfbGfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1963

On Mon Jun 22, 2026 at 3:44 AM BST, Alvin Sun wrote:
> Change `create_fops()` to accept an owner module pointer instead of
> hardcoding `null_mut()`, ensuring the kernel correctly tracks the
> module owning the DRM device's file operations.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

How is the patch logistics going to be handled? This series probably should=
 be
routed via the rust tree? Perhaps as fixes?

Best,
Gary

> ---
>  rust/kernel/drm/device.rs  | 3 ++-
>  rust/kernel/drm/gem/mod.rs | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

