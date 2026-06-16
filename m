Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6B41C314;
	Tue, 16 Jun 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610958; cv=fail; b=fsfJ2t23vFTu5fjSGaooCt+IAc+KXWxj88Nx4fNjnO3Xj1RIkReLQtslZqSTJIaVf9iMGsqfJclbF4Wm2XKPNNq1yGqJ6EdWmfG3+uVvENd2ruUjcWRfEXIGLMJjcW4RgU/aNYroLX4So3eFANBbPb38VtWEIzK55f3oWC/z51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610958; c=relaxed/simple;
	bh=06NSxnf2apm0DCYwv+NGXGOAfRlkSkTIOCpcFekAYJ4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Da2ftCYPRUsBU156ti6vR467z2gwgu5KkRDept92Rp+F8uBK55LXas6A1ClxiA82mJcBlfBbC4QfXywZBGxe96U+kK6JSsDu/fv0qR3uipYpOI1y9e8edMxtCT3ggkyZki/92tQbQEd8Ju9BjUBlJsP26v+vOIMP3SKFmYMD1Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ECJlL/ND; arc=fail smtp.client-ip=52.101.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ECJlL/ND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiASH47eSi/aIxZ7qR/KQo/j78oNqPwWUUfa1OWBAy4I65vzUKK+rXQGomUKPPnRlknliWlhqwf6ndb3xKf/MiDTFuZ7bf9KI4rGZV37DRm0nHatN6iRTZGIXGPuIWNgyLy40MYe91YdvuLG/y/NrWskkql6cYumfL7DmKSlvh436g7oCYXDcuvrOgvDUUD5BhqtYbsW9USXn7PCDK/B7J5nka48N2Og4GVEcYX+XwkNiLbjA7Co8XSCRs3S0JrwyiKJ9SfADV7jQy3FSTY5nHVc+yjJgRcm5h0FDnlkl8l6VyKiaZNtfjbyCZhNNbenwgXv9vKwB5ovmRLjvt+FqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+PHvsyef5ecY47vB1MQKewJdzm0KSVB9RdjG34EUhw=;
 b=v8oeLeEEWnMMRG1RysmB9qqnLG59J5CT3R331a4ByCmsyMskOEi2qG2n5O9TQcixOLxBC6iLdThL4pOxrdAV+YvRtiNNaLev44oIHoJ080DFdYuftmq3bEEmVX26RTis9VsSZzI+jCkoAujtrcTCagFzOKG8zP9vRGqxju/KQ0YuRzIe2oaWXn8qedA66DT4HCNSaFQvdyZZZPfH0Cv1pxslu33+dsxEvZqkS5w0eEjtLsAj50Y6p/Iiltxyu0Qe/uL0S7Lbz5DZZlRzuxZGOte988BgJACwLKmDRzpWYKhvjDi9onEVq27PcFOY3Armq+xRI+IVgb/qe6X+1OTh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+PHvsyef5ecY47vB1MQKewJdzm0KSVB9RdjG34EUhw=;
 b=ECJlL/NDD4OasxBhriowz1k81X6PPnpzyxwT1mGNiNMMeQjn6Q0GXqMvRY8cSK7MHzuYzLiGoKcc0ln9gWfvhVqsFpdMH2wXRqQ8vfUnKeaoZMSWSXt9iWBwSJWlgFF5tA0QTBIJbKx4ysrHn5b5JDSDXhn/tg2GzvudxNbAUZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB7593.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:55:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:55:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 12:55:52 +0100
Message-Id: <DJAGDGPKZ4HX.M47NMAU53PCJ@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Viresh Kumar" <vireshk@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Igor
 Korotin" <igor.korotin@linux.dev>, "Pavel Tikhomirov"
 <ptikhomirov@virtuozzo.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <driver-core@lists.linux.dev>
Subject: Re: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 3457848e-0f2b-4fc3-dc24-08decb9e37d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ywg0hO6cdJbxJ+MWCMNAwvM/9Xym9x6OdouXwN/k9VaG9CjN/S009Cplhxv66RTwE9RbwRvC4AKhEUgZJAKnXiEmujN2CnUgqdtzy1Ty380td+JjmmYyOfmxakaA5+XcpDMbqBjT3R7eE+mHVaQQt4SRrb9pa9Zh9nNc3h+mgF2ppUqmKysSiYHDIECf9ySfVOxnkU+qhQtd9xUPe5UtZJIHRktRlXMYL0lcy+SSiLyd/NBosNi9LRJrxvVzQmJ8WL9LoC5PnycgnucQrbDLUs5cgNSzRbHBv5dD75X7PfEYjK84jsK6bPGb5BJR5gzput6yYIRh4UyASzp2m/9Rcy2zzTMNGd3nJGJJkwPxhqLJSnMm+sPxs7LDyI5RxmiSmrsCz98Kb4EMO5aoXCxSPDTGqsl60NUpcWqx/wXE5At0khdYvbnPGdSWDqE634bYYFJUuL8A1OdaBYUzo9bySUkpdotKWxRn0jlRpgiJvN4Ed8UZ8Sk5KH316lsOtdTBXy0qXQG2/XoC1xKfYfdwEdt3Ys2s9Gg6NxEcg7tzKl4eJv4W97GhSZU6s8dp4wEc/A7w3bdXqR6zk7xi6AEAbsM4KlHRnK8MsXnh16uEZEqjihXpM5WB++uKlkkM/E90tnm2HlS9p94Pzy+7LQHosxmzN5MRLTihO1W/M0LgK5Yvpb6DwiUUtbBLJE2pAQ0+vS7lKmUXqN0ddK0gSnVni++wYzsyuFfGqnUu4PPIhvc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTh6d0VaQUs1cG1VQno4OEpNMUZSYlg0cjZUa0dNQ2ZZYnpzOTlKUzNRMlFJ?=
 =?utf-8?B?OURYN0U3S1o5blRSeFZnV2tGWXR0TTNGT25GRWNrS0ZBS01BRzRkcnI0Q2JH?=
 =?utf-8?B?cVpwMm1KdDZOdDgzcDB5b2QxeksrSnNVZFBiL21mUlBwcE8zTmtCSG5hcXFD?=
 =?utf-8?B?elY1bTU3ai9WdXNlb2dXNmlyR0hJY1phSWpUOGZ5c0JoMHQ2NUlaa3ZFR292?=
 =?utf-8?B?T2JvdGxnVkV6dEgzY1o5WExhL0wvdmNCK2ZmM3E5VGYxY1c3ZzIwT3RWVnRZ?=
 =?utf-8?B?eUZFcmZXcjAwa2g5NUlib3dUM1NjTlNZK01sT1JTbktYMTh5bnBFd1pVamxQ?=
 =?utf-8?B?cFhHRU9yWEphL09DM01uQ3hyMldmYmdDa3Fzd2JrajZwK3k1emhLWkpNUzRR?=
 =?utf-8?B?cXorR2pVQW9qeVpTa2VVUWQyMEx0Mm9kN2l6bTc3bng0WWF6TFNWNEM3RWZI?=
 =?utf-8?B?OHIxbitybVRucXl1aE9xMDkxaVhSeWJnOW5lV01pWFQwUEhWUHVwOGdLSEwz?=
 =?utf-8?B?N0dmUnR5Sk1mWTZrdElrVElGRTFMMG1INGxxenRsa2lIektMTkI4Z09VVjNq?=
 =?utf-8?B?bzA4ZjZ6NnpiSnY2UFVqb1dGMExlcmY2QlNmM1Z5TmdpaTNacXNrbXlmd0VW?=
 =?utf-8?B?WnVrYUdjMit4UHlZYitROGkrRENFVHhwTndtc05EVW9aME95U01IalYraXVN?=
 =?utf-8?B?RUV4S2IxdW5xc056NkxhdGZwajU4Q3NOQjZTMmRQNTFRenozTDVXTThkL1Rk?=
 =?utf-8?B?ZERoalRqb0NVSnRRUG9tbXhnaDB2VGtzcG5EUHFTMmFaMGJmRHA3YkZuNFFt?=
 =?utf-8?B?Z0QrQTh6aXUyT3hGNFAvdjh2Qy9wTldXNHQvOG5ISzZMamFnZ2IyZWJvaHVD?=
 =?utf-8?B?MGprM1JPNENyd0dLbnNoNVgrYXBmeUZYVjBDbkl3UmMzNWhIbGFuMlZGR2FE?=
 =?utf-8?B?bDR3ODd2dU9PcXA5TmJ6Sk84L1BOVUhWY3RSSGVhNkJ2clpEZmo2YVhHbEE0?=
 =?utf-8?B?VWVMSmZ5eS9qNUVIc2JMT1lmOVI2Rlh5dkFhbWFXeHYvQXlJOXVkQkxsTWk0?=
 =?utf-8?B?WXBzWE5Hd2FRUTR0MzNxczVhUkhGVTFoV2NsQlZtS0VZek9aZTBUYkpkbnZa?=
 =?utf-8?B?YTFEaDhPU3FpZ25mbWFQN3JYa2pyYjk5NjFqMTZSOXB6N0JCQWQ3c0pKTFNI?=
 =?utf-8?B?MDJNbGFBaVpJUG8yT0hBUVFqWm1waW9ka00vQTIvZU9wTkNsRjFLOHVqd2Q3?=
 =?utf-8?B?cSt4TGNJMmM1YytKbThqTmFqOU1leFlIT3VKTXdDSXNSZGZnNy9ncmVnVzJL?=
 =?utf-8?B?bXhXeUV0b2Fzb0JpZUFhSXhLUXNBdkRxcUtLQW05QlVYdGtvRXlUcXJ3V2xC?=
 =?utf-8?B?clhlVUpsbjM5dFFKdC96MDVMaFpDWjJQYkhHNmlibWs4anRwVXJCdWl4cVdN?=
 =?utf-8?B?V1dLbEt5QWh3czdNNmRCNW5aUjI3aElrL2h5WG1ubnp5Y09aRUNpaUNOZSs1?=
 =?utf-8?B?V1p4UURyaEk1TzFGaHgvak81a2x3L3g3Y2xreVVjdjQvcmtPMlFEMVhUcitu?=
 =?utf-8?B?WUtsQ0lHRWYzWGJxdzkvMFE4WSs1THo0NGdKbzR2WmZ5WXNld0w3VHVsbktO?=
 =?utf-8?B?eCsyK1dKSGVjWjZmeGVHVG5kNEx1Q0Y2R0U3bEZHT3RJMWNCMTNuU1hDM0Fn?=
 =?utf-8?B?elE4ZkpiS3ZXSi9iTEg4eXd6Z21mLzhhUlZvMWpQNWdjZG1ZQ0lCRjRVSXBu?=
 =?utf-8?B?cTRBNW13Skk1YTYyT2tSNjM5a1dCUEJHZ21zZU9NdjlVWTlZTXUybXYvWGMr?=
 =?utf-8?B?V3dXenlFbTZwTndGYnRSZXNDd3MwenpNSEdWbW1QMlBEb0F6akVmQjdGZHgy?=
 =?utf-8?B?OFZkRVdVcnlwTU53VG1icDJqVnZYVnZRdlpkZElaQ1dlWXE0YmJEZ2pPUDJS?=
 =?utf-8?B?OHR2V1NWRlNxVVNsL1htc0kwNlNnbEhpZDNDdzNkRGN2QWk1enB6SjlPZXlq?=
 =?utf-8?B?ZlovdGVyMG8yVnNFcnQ3bVlEYy9iMTgwbndQbHl0ckNrVXVsZUEzdWFFRGps?=
 =?utf-8?B?L21EZkdZS1RWZkxEQ2lpekxqOEVJR1hQTk8xMlhKcWdFWlpoZzR2aVFFWVpv?=
 =?utf-8?B?YWozeDZYWTZGSTZDNUc1dithdGZKY0Z3cUx4Mm5tK2VVYXRYV2plWXRvN1hv?=
 =?utf-8?B?d0M2VENLV2JaWkJjUTUvaldWYk45OGdqbTFEZHFOaWpLWmFTSWV3L3RvclRj?=
 =?utf-8?B?YzN6WHhtUFg3ZDVicmVReTBUSzF2SzY4dExkZU9PU3M0RVhzR0xHSWdhcExs?=
 =?utf-8?B?ODh3SUJ5WlZMejhDSm9KZmI0Q0lPcjBCNHZmcFhmY2dTN0FtekZwdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3457848e-0f2b-4fc3-dc24-08decb9e37d1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:55:53.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0WU7QSlklUpsYgZNN5x1HSn09hUhovE0hWzquC6ZxGfRYbQrB0U6jtqdMUt4eR0YlAZ7mdKVX7LvR6d11Q0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7593

On Thu Jun 4, 2026 at 9:11 PM BST, Andreas Hindborg wrote:
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/owned.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 456e239e906e..5eacdf327d12 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -15,6 +15,8 @@
>      ptr::NonNull, //
>  };
> =20
> +use kernel::types::ForeignOwnable;
> +
>  /// Types that specify their own way of performing allocation and destru=
ction. Typically, this trait
>  /// is implemented on types from the C side.
>  ///
> @@ -108,6 +110,7 @@ pub trait Ownable {
>  ///
>  /// - Until `T::release` is called, this `Owned<T>` exclusively owns the=
 underlying `T`.
>  /// - The `T` value is pinned.
> +#[repr(transparent)]

AFAIT this `#[repr(transparent)]` isn't actually needed.

>  pub struct Owned<T: Ownable> {
>      ptr: NonNull<T>,
>  }
> @@ -185,3 +188,46 @@ fn drop(&mut self) {
>          unsafe { T::release(self.ptr.as_mut()) };
>      }
>  }
> +
> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returne=
d
> +// pointer satisfy alignment requirements of `T`.
> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {

You should drop the `'static` bound and put where bound on the GAT below
instead. See how `Box` is doing it.

Best,
Gary

> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();
> +
> +    type Borrowed<'a> =3D &'a T;
> +    type BorrowedMut<'a> =3D Pin<&'a mut T>;
> +
> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
> +        let ptr =3D self.ptr.as_ptr().cast();
> +        core::mem::forget(self);
> +        ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        Self {
> +            // SAFETY: By function safety contract, `ptr` came from
> +            // `into_foreign` and cannot be null.
> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
> +        }
> +    }
> +
> +    #[inline]
> +    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowe=
d<'a> {
> +        // SAFETY: By function safety requirements, `ptr` is valid for u=
se as a
> +        // reference for `'a`.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    #[inline]
> +    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Bor=
rowedMut<'a> {
> +        // SAFETY: By function safety requirements, `ptr` is valid for u=
se as a
> +        // unique reference for `'a`.
> +        let inner =3D unsafe { &mut *ptr.cast() };
> +
> +        // SAFETY: We never move out of inner, and we do not hand out mu=
table
> +        // references when `T: !Unpin`.
> +        unsafe { Pin::new_unchecked(inner) }
> +    }
> +}


