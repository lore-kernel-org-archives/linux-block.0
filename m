Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021102.outbound.protection.outlook.com [52.101.100.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4E3A873E;
	Thu, 25 Jun 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398457; cv=fail; b=KRmNUtcxDQ/jlYg1tdCcx+YTNKHq1md23CYLeIAX1nAI97BtPlCf8bSsUtDXQwh3QBd6d72JtWzDAbaq6p3WdXqf5FcztSLmUNPh4sQkUosh3OsYNwcgOyViqXX7Cjzo/2RwP6VpL/HBmoWZnkHBoi7xMEDduM9mzxrILv38Uxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398457; c=relaxed/simple;
	bh=+BsjThrQICLy2NWQ2ttMCtAvuZY0arifGF8WnrnrNTY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ml1ui/C/Tw+lO7ny2/lYO0UbL/GVnqzjSexdDjqILbk5ZJgwBU5/1wV+GiVxGOsAANy4OWpSoahM9NxbqxGtYFatbU2m6KSZF38q44PNvMr/rRIpuImgiU4Z5YEQuWy5J5jdn2PaPlQVOenDuk+emg2zG++3a5G/73oulOxOaKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aWsjUeyC; arc=fail smtp.client-ip=52.101.100.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aWsjUeyC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT9ZeEyKrjkEjogGZd3cdcQYrPC8Oxzn+tDzZNcJK27Kv7k0BamO2JXHuT7CotUbG0kE5ELysbk4W3J0+zC3SeEBFSR6hFSAYPDvpz1xadHfVWmztihkwGUO1e964XPKrxHDil2vsgi06Abpv7WmjHm0YdEMspRGfBnYvv4X4pIGVXTgvYLfIa5XRkA+EXl3Z3twzVqBVud62TozOGnK+snJTDY0Tf9t9o4ZIqMF4WHpMHUr/pQ7CcElClHfihOE8832xxPvCwEx2k86IRHijsP3KCwrH7iAClSi02UtXT13tR84rqBPkQvXymAIB0JaUrrSQCi4b/Qr6JLw4zsplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kt0DzrjNbvbJQX/SbFh+XgTNXijTkiR+yj+ca1591A=;
 b=v3ibr11oGXnZlkK2StG4z5LcrFuB7qJJtzeeeEHLB8C+wYM2rnsXUeJZntEoIiVDxHJrqyOnMufMc/a7harydh/loVTgs/IKA7XU5cbanOczHStODPbCE/Ri6ViZIqCO5IY8OkSHNbhA4ZPao1MDwQDl9pBulbN61Voi5hBA8+BZ2Ws3qkQ/hllk7SeCaRavrqgDJjGw9+dxfD6UggTZMKnxkB9YkBmwJshpqwF6maBFHGGW2qTnOp5Ep2BKX0qtpWAhWXBgsqJa3s6BQCA+OjYDde1y8u7whX7Q5Z3Ax6kU6zqgMafA05v33lYN8s9xWhO7bk0wWarExRXrsdyV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kt0DzrjNbvbJQX/SbFh+XgTNXijTkiR+yj+ca1591A=;
 b=aWsjUeyC84zBxa7Q6a+waIunB8LHvJO3fBIMTew4a0DjvLn7jXF5h9gVyJRKJ1I3IBTy7Lqt3WceEr9CCL4cQEuM2paQyfbrj6iksfC0FYmWrGGTgq+h5m2rq2KNqTfqPEj4Cx1LA0GV0atzsh9gqF5qgCt4x3eO4YJkLkw+M2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOCP265MB8626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 14:40:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:40:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:40:52 +0100
Message-Id: <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
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
X-Mailer: aerc 0.21.0
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
X-ClientProxiedBy: LO4P123CA0540.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOCP265MB8626:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0c4531-ad9c-43f8-413d-08ded2c7c1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|18002099003|22082099003|4143699003|921020|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YGkM6QCEldsuZ4+fvAVLwjbHP35fRN3JOxp1LqnlnJYXn8nEgSWvhpvzv7mePAG/Lf8RA9lsLeyF4vkBzqoNL8fbG9TIZhujaGvjTLgmEvvVx0iAo3cOUXoZoW2sjQjgQgketZOn0jA7zMLsFEcZY4drEhhobqbK4EsKfev08ZdmY5o81y0B2JZzMGh0bbjw4Q7sNocGKvgO7m5OMkG80J6D5uxsmQGlUy1ZPy9lZH5dluZqvhnihQBSewUQUF421iHbS8RANBugyB2RudfNg4I9TqWVFgS8lThs51ai4ZSE9RHLWQR1I+t3Gg7S/jzQh02S0OB11LNWwVmOhQN+LMe6bkaWEi4diQWeEDoroXPFWuHhln6doVOysHlXGBooIuvOLwfYNEjykuwVZSqQ93N5a2yqmVJQOjsl9Ro9Sio8C/kAj5lyQHCKGL+w10RN4gk7yJaIIIuP7vmqOx2tj7DLxiQRpiWfbkzz7AY1wh8MXgdt9IKy+/AZ4bcS1fh98GGJFs2clAkYM9/VpPpXDTnVVUgoqaoyzRegA0tEejf0WR1gEVAUh5/b2GmpyC7kOojH/F/lHfpHk5cBvnk8aM627q8ukKM39pUXGpGSuSG21PgTRgEv0hHdEXqYDmca6jYhxKwSEZXuIgJvrisigR9LsLy9ZAjniKr2mtL1S8kz75q5l1qMwVgEFjs11KvKkKOe4pisntvMIXR7SDk7AQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(921020)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3JiQnJOY0JwQkJ6cGRmbEZieGpVL1RvZk1ITTlUSXhYSk8ydGRTTVB4VGxB?=
 =?utf-8?B?V1B5YldLM2gyNHpUdlJYT1VMdW1tRVZucnliTHpMU0hrcjNyMEx5OENGZW1t?=
 =?utf-8?B?M1NOb0EzSDRreVF4Mll1bDBJaURiTVgxWXNlOU5idCtjTmw1WExUdmpjeDNi?=
 =?utf-8?B?c1MzMXdsZEttcGdWOWtHZE1iSEJQWGRsV25rUWFRTHlnQWRLMFVKM2JGSnZw?=
 =?utf-8?B?QXVJZWVhZ1ZkaTVvRmRlYmZuK0ptMi85dXV3OEFkTDR2YWtaRXEyL3dUYTly?=
 =?utf-8?B?eTY5YlhwazlLSEZpUFpJTDYxdE11ek9kbTV5ZUNnWWl1bS9mK3FvUHN0ZXBF?=
 =?utf-8?B?eU9uQzg1RVB5RTJ2OEhERjVvek0zeXl5NkpvZHJKNjR5Vy9lb2d6dU9Rdy9D?=
 =?utf-8?B?REN2aXdQblRCTG9xMkhLSVFodzNQcysxcDVOKzdjZFZZcStEcUxDMmpzNnA1?=
 =?utf-8?B?ZUpKQlY3MGhEWEJhRjFHUy9OK1Z4TTVwNVhSZDh4cU1yclFUU2JZSjFLOWYy?=
 =?utf-8?B?dGNzNkU4MXlvRm5VRWFLb29LaWRqOHl5OG90Y2xjNlRyUTlZcElWdXR3Yk9H?=
 =?utf-8?B?b0RIZlZUT2p4VzdvTms4Z3FpeEJOL2RYM2NRckdRRDgwM3lDdDNkZE45T3Zh?=
 =?utf-8?B?RFVsUzFpRGNuMGJQdUxaMm9EUjRrQTNvZmlvdExadUdqTkEwWk5UdElxVXJj?=
 =?utf-8?B?d1FXZmc0eE9LQXJUQzNiL1ZBZDRSMDBMK01rL1o3UjJIb2pYRUQ2YlpzdFBo?=
 =?utf-8?B?QzZVSzhYRVNDRE1NN3p3YThIWXhuWXB5eHE2ci9Pd1NuV0wzRHZad0hnTWlQ?=
 =?utf-8?B?K1NxQVlKaGxLOFd6bDNWendtckZicmpkeDBZd3pCNmxUTG9KUVF2bHdWZ1FI?=
 =?utf-8?B?Mkh5c0M4S2lzVlRxWnQ0bUhxQTV4YTM2eEwwR1RMaDQxeFJYRzhFUUFOL2hF?=
 =?utf-8?B?dkZMQVBwbFBMcWlhWGE3VFFIYng1d0JjQXJQSi9QemVHNG8vVWc2dnNDQ2w1?=
 =?utf-8?B?MHVGZGNaRVpjT2lxdGVyRXFWa1c3TGJzSnZJd3ZFZllHMGhSQmI3MFhWVjR4?=
 =?utf-8?B?czFYT0JNSGhwdkxhWGl1d2ZXcExjT1k0ZzI1ZkVLdUhQcGh6ejJGZ0RidHNz?=
 =?utf-8?B?S2FHUUxRbERla1NDVDExQS9jSFM5Rm8yYmJWSFVocnFhVXFyc1l4U1JxUDli?=
 =?utf-8?B?ZUR1Q0M0MHJvTFdYOU9Bb1NIcHNFUHhjTVlUOThqNVJyU3MrMHFTUGtiQVJs?=
 =?utf-8?B?Zlk4SVQzSVBjLytxK2pCck9Gbi96MVFwNHdEbW9sb3J2dVJyRFZJNWNtcXVa?=
 =?utf-8?B?OUt3OWRzU0M3VTlDY0FZaUorNlFCdGIrbEVXa2hUS1NIYmZJWWJNVWpWeHRj?=
 =?utf-8?B?aDF1dnlWWjRZSm5VMDU1cUpnNjQwcVRBSnFub3BCZGt6MlBIMHpHUGw3NS9T?=
 =?utf-8?B?SHo3Ymx3MUl0YkxqRHpPbWtMTktuNU1ZWXE0ZE5NenBnZjRjL3VrY1AyNUNm?=
 =?utf-8?B?WEdIbk5EcTRDVVRYL0Q0SGhpUGl1VkpMWncvdWRUSHZtNU5mSHVHdVZ4WGwz?=
 =?utf-8?B?dkpJK1BjQXIvaTByK0RvR0s3bk1WTzlEU055Y21hM0laa1hNNkNIZTRiYndi?=
 =?utf-8?B?cUk2aTQrRVpKQS9LMkJjZzZZVSszYkJZRGdHTnJtZTZncXJnU2JhRlh3d0dP?=
 =?utf-8?B?M09xelFZNmhWeEhOR2xDV3h6YlRGUU91dGVuc0JtaVRqTDF3TkdmblgzWE9I?=
 =?utf-8?B?cThyWmhaTHZyK2dPdXZHM21XeXBhNmZSN0c2QWFpeCtQclY5eHJJRHVrQk1i?=
 =?utf-8?B?QVdoRjFTSmpuM0pyK1QrQ2ZqckpobGhDYXJkd2gwblF4NnBxOU9sQW05MVd1?=
 =?utf-8?B?OFlnUXpLcVFVajNHT2xKdGx1aFdydEx1dnRqSTdTQklDSDZudEZPVUozNE9R?=
 =?utf-8?B?VTEwZnpSY29JQ1YzWmVObjE0NmhQRE1TZExiK3ZNbk5nN1pUTWVlMnNUODVm?=
 =?utf-8?B?Z2h4bTVSUG9pK3Jrak1Pai96R1Y5MHovMFRzRnVGejduclhWMFExdENodHRq?=
 =?utf-8?B?ZzJFOHQ4N3VDVDBzTWovaEJLUHZMM1VPNDZ1TmlMUGlaaGh3V1Nhazd5OXNQ?=
 =?utf-8?B?L0dHYjU2c3AxVGtwMUo4bU14N1Bic0FBbUNabFU1eUNFcWpDaXBMNW11b0lw?=
 =?utf-8?B?ZS9tQkl1KzhSU2N3bjA5R3k1WTgrTytYWnpNU2ZPZkw2ZGpWaDdsVVRzK0RI?=
 =?utf-8?B?WGxkOXpoeG9JU3Z2elhrVzJRYWhpM3l1OVhlSDhxbUpBV1UxaGRVMm1SZ3dq?=
 =?utf-8?B?Lzl4Qm1UdTV4aDI4NSsrbjZnV1ptb2xySWJ4cS8xVWtYczdtNzdpQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0c4531-ad9c-43f8-413d-08ded2c7c1fa
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:40:52.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTJymqezFnK6BcfUNr0JLSDHnBmQ4BLU89ZeN+sCPY5ukWANdR51vYP5IShSchgFSXiVhfukkPY/xJaxUjM96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOCP265MB8626

On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
> macro with `this_module::<LocalModule>()`, and update
> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  drivers/block/rnull/configfs.rs | 6 ++----
>  rust/kernel/configfs.rs         | 8 +++++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/config=
fs.rs
> index c10a55fc58948..b2547ad1e5ddd 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -1,9 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> -use super::{
> -    NullBlkDevice,
> -    THIS_MODULE, //
> -};
> +use super::NullBlkDevice;
> +use crate::LocalModule;
>  use kernel::{
>      block::mq::gen_disk::{
>          GenDisk,
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
> index 2339c6467325d..c31d7882e216d 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type=
 {
>  ///                 configfs::Subsystem<Configuration>,
>  ///                 Configuration
>  ///                 >::new_with_child_ctor::<N,Child>(
> -///             &THIS_MODULE,
> +///             ::kernel::module::this_module::<crate::LocalModule>(),
>  ///             &CONFIGURATION_ATTRS
>  ///         );
>  ///
> @@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
> =20
>                      static [< $data:upper _TPE >] : $crate::configfs::It=
emType<$container, $data>  =3D
>                          $crate::configfs::ItemType::<$container, $data>:=
:new::<N>(
> -                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
> +                            $crate::module::this_module::<LocalModule>()=
,

^ You only changed one single place. This is still plain `LocalModule`.

Best,
Gary

> +                            &[<$ data:upper _ATTRS >]
>                          );
>                  )?
> =20
> @@ -1030,7 +1031,8 @@ macro_rules! configfs_attrs {
>                          $crate::configfs::ItemType<$container, $data>  =
=3D
>                              $crate::configfs::ItemType::<$container, $da=
ta>::
>                              new_with_child_ctor::<N, $child>(
> -                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
> +                                $crate::module::this_module::<LocalModul=
e>(),
> +                                &[<$ data:upper _ATTRS >]
>                              );
>                  )?
> =20


