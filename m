Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021125.outbound.protection.outlook.com [52.101.95.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CFB3911AB;
	Mon, 22 Jun 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125073; cv=fail; b=uhupQDvYvpP7MdEl2UJl/vnTrsbrSb/zjK0SNpNosZ4hJcn1AAtJRiPf+0XzZLMW37/e9SFDm9/mR0eVlGKYPDv3Y4hVpUv4LXB8w7PkPjgHG8dukr/h02Ecx+VaZv+NQgUEavfy8k/wHpOiV5eF+BALYJNyFl9+hR1Si6bud7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125073; c=relaxed/simple;
	bh=9POZ+TtBbcP69+l+MLajZVIgbpZ3JpWh3SfTIFwq1yQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JTT4PIV+ENzWGtjkXlme7iPaBBUOzVbGqGPN4weTrB9NklMKgQO4KCb+36Fh2jA+S1KYh5Ua7ZUdFI/obIToqVgetZD1ADoAOBmaEr5nrAyU1Kut7Zh8khe+eBZr4Cuq8QfSiGPxkh5fuQnIZJZm6CYkazCtFiS+V0yCywEYcB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zL25Ouaj; arc=fail smtp.client-ip=52.101.95.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zL25Ouaj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSXRQW+9Jt17m0iSRXlEtiWIcTECvLB03b7a5/amVuWzV/yZut1K+/lH5b9D1N+NgPzGUIVLYVmWc9PVSqVylx1ONuqydouv5VrGhe//9cZHBxumr71hH4Xr3VCEBFxQVhFsf+nNZjJX6kbLoQ6F2hd3DWVT15pBhEZq61HvBqNzyBr7+dusKv1zF1qVrgPQWLqJheKKiJ4dPDXmsnaC84KJfIUkgJpm7ub9nZ448p4XeKg+s58i8e+RBuAwvzXGptqUSJ/S0SmDWWmdwXGi98gzf0qNo/ERLQ0MlE7FcH5PnX9P5VoyN72TBgKQfYyoyRI2DtYaphXPO1IwQGUPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXoSAt8t/tE2fQcm/MQbkYBGG3PL/mgikcsFM2sRJfM=;
 b=sz4IbuSRoZ9xn+U2sB1zMHGimV9HvPQjbX7ie7HUMooREh0GlNgLpNXp8+chj1SY6k201YAz0dFo5YlNFDYnpifH25aSJ1Bnw+HxO7wa7YCNAwURA6S58CQFBuhR6+gCkrQc0PLJ9ZP9ld421EzthHzffaoVdXcTzXKPU6hZnbAOP26LXmqSq8EHsFF7qxUY4B9a2XgWJAtpOhmKyJMkvvT88Quzx9RQkt/Z0coOFHBxI/UaqxV9U4+/cg9HxibSx+u+NjLHz70mylHw/TeW8svVQpKENJsJZFMcMNpqRPxnq3LsmH+qHdfG89xc9zN+CP7FWt83Hev2hOvKMHwlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXoSAt8t/tE2fQcm/MQbkYBGG3PL/mgikcsFM2sRJfM=;
 b=zL25OuajIAqr8X1tujM46KjTUUupOtr5OjiOE/yTKODFwPLcp8AGBucZSJOHgYFzkQezWow0DUNLhgDj22wp7gpzWcAVX/IIAhqpRYWhVVIeclFoFLrKM0adoqZExGsNZoCl9wc06r9Lk3lKvvHAFoFBTaOwFcyg3v8W7tQd0yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5775.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:44:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:44:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 11:44:21 +0100
Message-Id: <DJFILZ5U8XAG.3INUOAHPM98XN@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] rust: macros: auto-insert OwnerModule in
 #[vtable]
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
X-Mailer: aerc 0.21.0
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-3-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-3-49d45cb37032@linux.dev>
X-ClientProxiedBy: LO4P265CA0292.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2831ee-23d3-482a-4de6-08ded04b389b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|921020|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r+zjAMc5jiGrbPAkedfbCVPsedZZCRmP3OXzJeMA2q5S0OqqCb1pp3UkloHcbW/CGg+Ws/szbXpOU9kTuVgNcHWfdwffesp6dwH9N7Gas/3RrUoA9i2Q3lOomAgNSVAJMy5muyOESUfZEZ8ia7hjKa0SSKH7oWrXcU8AqpChOO7gFpAPbdwgj3KAKFWLPgOJc2xzl6izXnDDUVfLCpZwgKRW1oZR63UNooGXjgDdJR7RhI1BpanxBjDquzcdiejNVu4CfFrQhSBIb4ANpBx6WBuiclInw6l0iO0m21qr8Cu/5SyFeF9CEG3scQkrtrt8LBJPFiuRu8y+SqgwdBVfBceCEaWmuX4KD7x83OyLZWhXOZL++jdCylkHfLYup32+fdRE/UlJp2m7h7Sb0DvI28qjPo7+G1hiU+mV5v8lB3WVO7+Tc5VOnsjZPf4VPwljDTlFiLcWw2ZcbowIyMzMRE2BqnF5uPy/AX9EJIzzhxO8g4MtVfL5BLyfueXSz33+gSb3yxDnOaRZV5tQWbiN2Vz9vpbcFm3Zvbwaiuno1aEY8FTr8RCTXWWgx+1h3O0A8/Oa6UWOAveyiUr9YT2o3p/90ZCtYHXAHaEcT/Iy7v4E47D/wDJP00143TZM/W1/P+Wyq+i2EVyOjXY3zW/R2hMTh9zFUoY8gvCJxenUaTKoo9SvO07rk5otqOln1maZyoNTHuFzRAm8qqWAjGPC3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzhxOER4MUtDZGN0TFNBRVQ0NFZwd0lIMllobnhVSkJSL1M3ZUhGN3F1c1l1?=
 =?utf-8?B?MHFCNzBsOFRmRXl6QWhCN3c3cXRYQmNqaVk1OW96bUNERDVZd2JqcmRQZHJH?=
 =?utf-8?B?RlhQU2lheThuRVcyQW1JNXdJaVNnTUhaVUV3bno5ay9iVVo4Y3pnNTdHMEh3?=
 =?utf-8?B?WHFoN3haRDhXZkdvcjhsbVZrWVJvMk5TWUFsL2NObjcxOStmVXI2b1draTFl?=
 =?utf-8?B?dnRFTUp6L0VEdzhPQTNnai9VQ2RDZnNrYkxGNldSOXQ2K01FbTQrdlY2RURL?=
 =?utf-8?B?QW1wRm0yTXBmRDcxemdLZmF5Qm9RSHJyTWVsVzdNWkVqUTdYTkNmMGNnazFS?=
 =?utf-8?B?OWFERVJ4ODRwYWlacGZrVVZPcUhYZ0hjSTNHeC9tYVhwaDQwUHJld3kybml2?=
 =?utf-8?B?Nm9pTmxkaXJhbnNSb1B4S0pocjZWbXptbDgrbFJXRGxYczZiVzdzTHMyWVM4?=
 =?utf-8?B?YmJ1V0UwOE81NmtHbGNBSVVoWjBmMld6VStsNTdoSTV6LzF0Z3lodHZPUlRS?=
 =?utf-8?B?ZnBVbFBVTTVFUVBXLzZ5N0Jycmt3TWMzQTZpaVlWa3BMMUVyRHVoUHlMQ0tQ?=
 =?utf-8?B?cHRBbi9LSEVlT3M5QklKYnVJOWYrbmJHb1E0RTZVdzM1aWFmSW5yNG9LYXRy?=
 =?utf-8?B?RE1tQmttaTY2WkJpN2hneFlGcGxFQm5pUkIyMCt3N1c4Wm56dGtQcEVlNjBT?=
 =?utf-8?B?dTBmSmExUXNIMnE2TkVaLzVoeUd2N2VCSnJsWXUrWE5mNnUvbnBKY2RTSjly?=
 =?utf-8?B?QXZ5TVdSUmw0Q01ENVk4QlZHNkZ6SlcvdldpSHV1NTZGajJPR01TeE01MUxv?=
 =?utf-8?B?TTNWVXdYbncwd0lwVEpnd1M3TW1OcUJBRFhvQS9uUllwNzJzZ3FqWkQwQlh2?=
 =?utf-8?B?eUsvV0JKUWZMUkJHQWREa1pyYTlBU3l1YVdmd0tlWW5wTmttYlg5U3UvdVVT?=
 =?utf-8?B?a3h2UjJGL3FkeEwzb3hiQm9peTlTMy9HTWNXUGE1dldmOGVYS1RIeHhtNjh5?=
 =?utf-8?B?RncvWkZYWEs1QThOS0ZoTHI0ejdETGViYmlHdUh2QWhrc0w1QnpsSWUzc1RB?=
 =?utf-8?B?K1F6RWJ3VW1EVUhRaXYwK0ZBaEt2SktxbWVjR3ZrV2N3ZjdyVERxNm5nOG1a?=
 =?utf-8?B?bFdobGRVSm0zRnJBaUVJYml1clI5ZUcyUzl6VnNyMzkvU1p1UU1LTkpwL1ow?=
 =?utf-8?B?VTRQeWJ5VDNLb2FEUi96ZzZXQnh0SmtJbHY3N29EMElBVTZlKzFacmdSeDZ6?=
 =?utf-8?B?Y1RzcVNlVWtHWnBFNHYvd251WExtbGRMODV3d25BTEs1VUJ1RmoxNVhSdWhP?=
 =?utf-8?B?dXJYMlErdHdub2ZzSFhPRHluY1c5Qng2SW9reThxdlBLQlh1bXZqSDZnbTlB?=
 =?utf-8?B?ZngxbC9JWDU0SmFJNUhYbUZjZjZ5MS9SdGVFMGlMdzFiSUFzVWQxUG5ISFhk?=
 =?utf-8?B?K0s1djRUcDZqdkV6MVMzYlZWOTMzbWFjTDVSMTFwL1Z3cHdTWW9WRkxYRWtK?=
 =?utf-8?B?dndxN1gwWWhySllzWmMvUHVVenNpb1dtWE8zajlUVlNTUnMvUlNZNVZ6cUpN?=
 =?utf-8?B?TzQvMnlvenBQMW5kYXRYL3BtdTd3Z1FSR1ZmcTNpU0RPRzFDWUR5NTVXRHBV?=
 =?utf-8?B?MTlacVZtV0lsQ3pVc1JtbitZbCt1S1FmQUUvNDJZNzZwVFc2K3FiSjQwY0Fq?=
 =?utf-8?B?MnYvWU41aVVoUTVGYk1EMlZTZ2l0RUo0cVpUR3hOejVIQTRCQ2VWRXFLYkNo?=
 =?utf-8?B?QVRLbi9DVWFDdEQ0Z0NSSUFTN1VnZkI5d1Y5dXhEVndlamdvSXNyOFYvd2cz?=
 =?utf-8?B?V2x5dGE5WWlkbDV1N1lRazFaSjBMTUNqMFpPVHNZNXNsWThlZnBPY24rYjNj?=
 =?utf-8?B?SjRPUFk5dTRMR0QvdXZKSkg3SFk0MDV4WUl3NVF4R3NBNVhVVG1nQml1Njhi?=
 =?utf-8?B?TmdJK1Q3bHdGRktwZ2p3Ukd1bFFsdHJVOTVsUThBRFV5N1UxbzNHRkZ2MW5z?=
 =?utf-8?B?M2dSQ0ZTR1FnNGZIcnlYYXY5cXR2KzhyZ0ZQcU5ISEExOEZiOG1IWU5HTUVK?=
 =?utf-8?B?d2RhREhhMTc3M3lCbHI3dkErTDB3YXAvN2psOVdiSlc2S2MvbFZEOXNZSXZE?=
 =?utf-8?B?cUd1ZXZkenZ1UFArckI0U0llR3IvQ2g4S0lrNmJsLzdHS1o5ZDBQUlJ1RnFH?=
 =?utf-8?B?bXRKREwwWW1Pd2RScWtWMHc5UXRLYXRxd2tIY1dKRk9RWGJZSG82UnNkTDlL?=
 =?utf-8?B?YllYd3l0Z3cyWFFXY0hobHZ1RnVpNXNnUFo5eExUWDFjZngrMy9iRXRSYkFx?=
 =?utf-8?B?LytWYjRYcEx3ZWhmRlFFcjdxN3ZMTStjektCem9WOUZwUWF0TG1Rdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2831ee-23d3-482a-4de6-08ded04b389b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:44:22.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4hyZktyqiELBd1VJo5Hdb4f1ARlu7FSDLM1EXS542O/snjBsd/gMzfbtvGLq3ZOTHWHBQq+9RVd2GAz8o8H3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5775

On Mon Jun 22, 2026 at 3:44 AM BST, Alvin Sun wrote:
> Auto-add `type OwnerModule: ::kernel::ModuleMetadata;` as a required
> associated type on the trait side if not already defined, and
> auto-insert `type OwnerModule =3D crate::LocalModule;` on the impl side
> if not explicitly provided, eliminating the need to manually declare
> and implement `OwnerModule` in every vtable trait and impl.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/all/DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/lib.rs    |  6 ++++++
>  rust/macros/vtable.rs | 41 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 42 insertions(+), 5 deletions(-)

