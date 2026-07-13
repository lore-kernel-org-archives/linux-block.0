Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021086.outbound.protection.outlook.com [52.101.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF154028F9;
	Mon, 13 Jul 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944450; cv=fail; b=iV9YnLP9vlTr8nkvM3YpSvniZfz1U6uphBnb6+byjkiC4ohhzFUdZ8ZUw/cfJ1yCDQF4oLOpWho3Ci6HBV5nlW25eoTjcOBC9GZHxdbmZ2Sh5h+MZ1yKwmWLvBz48FHJqa48ioGT6n7qghfOHtYNN0jjIkOnT+pyKpLb1FtlRFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944450; c=relaxed/simple;
	bh=EeyTyLNifURwcN/tRH3j/7EDGOnFDum9wss0Y68BVFg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=G6bEoTRa5MgO5Jarqyakf2+b6sdheKOXp6qkGq4WXWRrrXJMJPD1oCjbtS9pDnjJErLQJWQFyXrlv5pMQid0PEb7niiOV5Rn+CQQeslSzW/jiZCsxdqgPGExnigp34sPby0p20KhpLheb/Q7AydHYY+WLl98/P3PMwHW8sWbkv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EvkqveAU; arc=fail smtp.client-ip=52.101.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EvkqveAU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxx3vf3iWRGRxk273JbXcDK4MB9JgIWtA8yElwQ545z82OG+WtzC1z5YgbFKJ2iynlA3ix0HXf6uNM9GXgYCE2plnBcAkzKAKQTkV3mwRUMhAs/qdW/Ag6yqRh0418jyt7NvUtvahOT6IGBNoNoPAL7xInlWdav8zTcwSw0oIJyOa6o5M0jUtUpNSVTzy7DBxK2rkwEgCZx9r/oAb3U7RZDFQH3mbs9D397I+SqdOuOntFIGZGM8H7T7tD2JKPRdoj+uMKk9WgvlLGFkdiE3CLL98fEtYtFAaiQBW+cVH3yyUkQopS04yi+2Ts1w0VmKTC2aM+4cwbQqwJGzfYvQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qirLLX/ZhQD3j7TnLcMoexVuF2EazNr5u8vL+5VLNE=;
 b=iZUX5ORQFjYztha8b/vMcd1W68I68u092vtDiIIisfeGhcZr7ETFkNo51apA+KyNr4H66ftCXdpGu2NZSPRVyvn/Lg6hzy7laL3IMgrogBxo+O33tnjQiP5BVgd3czJMtB4TNqDG12DwnProeOJkV/qh2lboBOJ+6R/O91Zhda6GrFcAXYjRgFFkHyI5m+1NEdpL+bM+Lu3LYbJ+nAUWsTPiQcqe1U17+4fMAn//+0zrm5lJK76U7SdzB4/wwemSEHkvmulPv3HuzjONSTX9BpcFvE6czMpQRx05jCneFNbyJyz7Qm+Hi44yAm6y+JAzB3y6WKPYFwkjCG6KV9VQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qirLLX/ZhQD3j7TnLcMoexVuF2EazNr5u8vL+5VLNE=;
 b=EvkqveAU2zWjkyYiaLcVSzSg2gtdPgO9VZrfOR2jHOLDXfMR0pjoum+Ywea1sCJx1qAULBfC6LbHOJmXAnhLCSVzZiZjnYl7k4keD2EK+jJo7q/zAAAnakxPUhdAQlU8g2V8qGvsj/aEKA/+lYYTx30qTk/ehNTgdNTosTwX4dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB6995.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:07:25 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 12:07:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 13:07:24 +0100
Message-Id: <DJXFJ00EOKDK.CNXCIN7TMZU3@garyguo.net>
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
 Leitao" <leitao@debian.org>, "Jens Axboe" <axboe@kernel.dk>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Leon Romanovsky" <leon@kernel.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
X-Mailer: aerc 0.21.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-7-2495cfa82d47@linux.dev>
In-Reply-To: <20260713-fix-fops-owner-v8-7-2495cfa82d47@linux.dev>
X-ClientProxiedBy: LO3P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::21) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 962ce0e8-cd1a-400e-47af-08dee0d74d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|23010399003|921020|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	PwJe6ZszOhIvyq8wDahoMSzBsEiSw7nZB8jX8hPmfFA05i8jCrVlhnUJ0sLp2Di1Z7Jtx0qBwQVcf/M43ObaXllEv4VrqbWGLVj72cuTg9qxPgPq/9q73A8cc8f69Cqg3/JR5TM0XBICNxU9s5m4kpwHBHws4U61VneB2UB19zVv+BqMTWwCN1/aGppLY5z6NCPAhfN6ZHhAsNmfVyeyW8vHEUXUlVSze3oBAwhO6qZ0oLsFrAQ2N8rz1/bH6xN8Il+z82DrX4ttcWjJv2j94xP7LBbVI2L5qNUReoRbK4HHC0NGzH7IyqhaHLsUmEwntw2tfb3FQJDijJR94ej+sLqqKLsI+EmCLK6VL3mSaIdB1mMmE+naRoI89xa386OQj354IRYs2W70fOw6BWolY0Des599JUuGbUzHN/7zRIj+X+6bQ2/RTiGpzxwewjGqQDHMn4wyk0rSiVEVqmyI9a0C6nSDYkf1ThiW3KASpK5kA25Dbv7wL2X1CN77sQqT4JVoNsaWp55V5IUCrFV5Rj+hD3SafaonNvTFU5x36U9ptHmm7NqkYHfOrxZwFJTKYSBUcedi9qRX3BywTCLZpdIUwxuk1xuSWu+O+s2d36LIKW77UHGqH92QTUy1kF+FSNahCsFRI7WxGbhlygHtZ1Qs+WyHuuCs/TdxmpuEg4bcmQI0rCYel4zKHZquZd3m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRSTWJYWlRmbk05WUlUOCtDemFJbC9lWkZEakxQc0ZWUlRqeUc5aWpKWUxQ?=
 =?utf-8?B?dFlad3JaVEkrWDU2VnE1Q1UvaXI4bm8vNGdtZDZuUzdDNEo0WXYvVFh3Nno0?=
 =?utf-8?B?MUUwNlhUQmU1UEN6QjVXbUR0NW5hNm15LzNxTmdVK25RNVBacTZQcFdUdHlu?=
 =?utf-8?B?bno0YjNoaEUzVURSSWJoNkdGcXJ3UmNLZEwySkdqaFQxUExnR0RibkJuQXYr?=
 =?utf-8?B?dWN6bU9FUFN5dXpvTnZkUWRZZTIvVkFkTkRWN0RldzNocUdhc012YkdsTU9h?=
 =?utf-8?B?Q2JvREZmd3VIYnlJQzlGN3BySXpnczVLNTNCZXNRc0p0cllvT2Y1NlgvamhR?=
 =?utf-8?B?UDlleGxranNnWEdKSEZLbWdMQzFMTSs2UEpLRWh1S3IySkNNb3Byb1RkaU84?=
 =?utf-8?B?dXlXcHp0UzZlbVlIL2E1MlYzUUJYUWZtWGVYb1BETjJoWW4zaEhEdWZCZVBF?=
 =?utf-8?B?bGE0NzhOd1VnQWtUcTFVeWdSeEpiOUZWNXNmZ1dTNWx1Rit1a2E0dlcwajh0?=
 =?utf-8?B?SjB2dytrM0xKN1cwMTJIUEM5WkZmU1BMYndDbmpLb3dIcEludHZoMkQrNGZv?=
 =?utf-8?B?dXJqNUJtQXhzbHNPaE9QTDUxWXU0VlR4UVpuSlBabEMyeTBWK2M1UlZmSlVF?=
 =?utf-8?B?eGZiRkNxOGV5aTRkZU9BK0JTYnU1M1VYWVQ5K0F5MEh5Y2NGbzd0TUR4L2h4?=
 =?utf-8?B?Uk5YWno3TE1yV2JHYlRuZldqbHFtVGdlRmF2dW9wSnNVaVY3ZzJMVW51UWZJ?=
 =?utf-8?B?VTFFTGNsdkxWYTJaMm5VbjNQc3l3RnBZcXRjbjhVTm53SXNQQXhpeWhjM0s3?=
 =?utf-8?B?UXpsemZqSmdROGJzR2E0TTV6MmZNL1FXVDlQNmErYUpUR0JwR29ndGxRTjBh?=
 =?utf-8?B?bGxBaCtWOUVRc0lianc1K2lBeUp0L2tFUWl4WExXSUdBaFVvRnhDTis1dXNy?=
 =?utf-8?B?SnRnbzRVb1l5Yjd1SUh5dXpDU3crUVYxenUyckhRYjZOODl6K3NjQ2c1Vlk4?=
 =?utf-8?B?VVhZQzY0aG9ZditzdWFWMXFNZXJCNVJNMTVhM3R6WmpEYU84ZVpZODFuNVdE?=
 =?utf-8?B?N0s0NXh0aWYvWFkydXA2WjdXdU12dHYvbFEzSE1hRDRjbUhSTW44TjErQ2l1?=
 =?utf-8?B?Z0R0aVhQaEdnK0lVQ0R5VFFETSthY1VQTFpOODN4V3A4bFRoZzkxcll0TUZN?=
 =?utf-8?B?MXpZZ3F1ZzAxWittWGZXeTNnaEIxRTk0VS9iZGNqaTVETUVPY3YzWW15dmtP?=
 =?utf-8?B?d3ZXVXdPdm9BOUFDL3pWU244dWpuQXNpY2thRVMydTNRMjh4R2hIY0hvS2FB?=
 =?utf-8?B?Z2YxOG1Nb0J4U0ZyTVJPQkRxVjhxY21zTVgvSzZVRHE0bHgyYm43dFh2ZExG?=
 =?utf-8?B?Qlo3bUkwYmlqbEJicGtUelBUMTFOUjBWOFlFUElueVJYWTJybWFqQWRtK2pH?=
 =?utf-8?B?em1hZEZDSFZuT2VZU0lRdkluOW5BVEEzQlNMT3BkYk1rZGlpT3JnUWcxS21H?=
 =?utf-8?B?VEx4cElUZjE2d3hNUXNkYmRCNUhwK2dJNnNwbWkxT29DNlZyV1NRdE4vcGgw?=
 =?utf-8?B?NXpSOWNoQTJGMjRpRS9yN1lMdHF5UjNQbDhZVzV3SzBXVTlJRmNNVGxZbE5K?=
 =?utf-8?B?cEM4WGZXZGY3U0FOMHhOOXdKRHliS1IyTWJaYTdZd1N2TWNmMkZ6blBPcytu?=
 =?utf-8?B?azl5WlZBb2Z6eG9icmFqUlUybzBZbE5WQ0V4NXdlUkExaTU2NXRFOGFFMVlv?=
 =?utf-8?B?MXEwL1dEcUI3cEwzTmw4QlZWeFE5eE1QTGNpSW9TVlJzSWs2OWNySFY1MnpU?=
 =?utf-8?B?NXhzTWtGSm1WTnpDSWkvM0VXY3hqN1RPaWpQdWQ1OXNHUnExbjFnNGxRaktN?=
 =?utf-8?B?SGpHQkdZY25DR0lKR3U5QVF0RGJ2WXhsVmtyOWYydlBaVExLR2FWVkNYUmNH?=
 =?utf-8?B?VDM1NnRZR2dFVEhzZUtJRjZONk96Q1lZM3hxUk5Ba0FTYkFVOW96emxIV1E2?=
 =?utf-8?B?a0tpdDdBMldrY1pHK3dYdTdpaHhnYmVmQ00ybjhPVXMwWDhGSTRKdkY2R2k1?=
 =?utf-8?B?R3FsemJOVzIzTU12QzQyOVp0RWk3WSs0Q2JWU3lnZVZsQk12eTZoUTBybUpo?=
 =?utf-8?B?ZG95VlBFS1Bna2pSVE9IS2l3T1YzVlJZWW0rTWJiR1BENHV2UXB1L2h0QmVn?=
 =?utf-8?B?cnpyOUNZVnUvSXdvZkxpWldYVGlvUVM1Tnk5cWhsaWxGR3FXRk91NVN4QjFB?=
 =?utf-8?B?MTd5eXcxWkdDRVhRMHVFeG1SY3k4T1d4N2lnTnFiUnBYQmx4a1F6MEZjZDd6?=
 =?utf-8?B?bXR6RERUVUhIYkc1K1pnOVZaRTlqcXA0c3k3TklnVzczMndvVEg4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 962ce0e8-cd1a-400e-47af-08dee0d74d81
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:07:25.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9vU4FMqa6vZWMbev4hqWyBPSLty0QuHXD/Lc1QATdjQDB2VLyVSZMxxoLXCyPy1JR8bTfRv3mapYfUwTDPPbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6995

On Mon Jul 13, 2026 at 7:45 AM BST, Alvin Sun wrote:
> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
> macro with `this_module::<LocalModule>()`, and update
> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>=20
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/block/rnull/configfs.rs | 5 +----
>  rust/kernel/configfs.rs         | 9 ++++++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

