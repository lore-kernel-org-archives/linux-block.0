Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020084.outbound.protection.outlook.com [52.101.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0633A9CF;
	Thu, 21 May 2026 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342597; cv=fail; b=uM3A5+252aBqgAa5n2JMweKG9BqITFslFCWrt/63ZWU47HIbOjuyFpz2BnbnOxElXgKUoJjdIEjZDxj2kEziPlvwv/ebxlgHc6KBB4E8HD9Nf6fqYgiCA+4ByNrNu1TxUBJ98NJo8XRVNV1cf5lgZX2dFTm3iBknvEjQZcPHskQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342597; c=relaxed/simple;
	bh=C8YM8QGPN4M0I/GvYTdritRneALYmxb3S4lfJlh7AMk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=vCwaoWUS6slxAdLzm70ocq5bTMF/AduTvbmnLUYi5fQ3LgB4gp3xN0479SLLNmb0EqQEfU9H3588ep8DEVEJANnb9NeVvMWbPgF7PVO1Pu1OwOkGwePUynqps3nqGOW7WpJCO9q5a2k89qca6Dqu1BcMiVXKd99Oo/qYZ0c7lGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=j2/pAg9U; arc=fail smtp.client-ip=52.101.196.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="j2/pAg9U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RadaUE1bHC3T1zxxF/xAYRnX3Z3rYZR+BumGCVp/5CrTmW3KlzgEPBYrKQWdWkj2aBsuEgzy+q9Pv5FgnVbhviGI2rZSWMJvBPus5UD4uwyFeW0itrPwMt1v49/1hGpylqcZAJLnusfCLtYAo+Fwvep7EDwogNoI8Ey3TcxSuDTAan/F6IQoG7EozRC2b+MnNt4PQk/cQU8Uss2sLEfVyil/55ifUGX2i2ske91QhbazHR4j8YOjxnb7MGrMzZBh7jQ56taMaeNyRY/TYsh2WNrSUbZvAPui2Y1iQgBWiyg2vz3FofrooHi8RXVbjFHKcFt0DnecH6OaFp/969W22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+UyYCtTEjlzL/vhIrs0TzdVP2Av/iaIgObmq7H5ohY=;
 b=WzvR3sPuNZtsnHqukN+3Uk8XxMiS2GZKV0r6r8Rppd5ithA4P+krGVswBgzHwEH5SxOcry26XwlC3V/uV3spmwSYS5YFtudsoPQsBq7ZmA/TRINyDyOIbJcfypUGWwUIXubgPh6VDVs98sP3brnLlvvn9GPAk+x85dFQYrsUM9uMcW8N/thDfQhgr6qZOHhSse3IyzhG1mawZ6rR2dSdj/7swF7/i+zB8R7fQb9j3rBERtZXWfRKsOU4bEIFTh/pUIlTHsEL0ZkXNuKTXDMls5Ydmf+XUnpRJA8mWifPHY13kCVhBpOrOEJ5Gwz1yBslAXygdtFT82VEx1vN650VEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+UyYCtTEjlzL/vhIrs0TzdVP2Av/iaIgObmq7H5ohY=;
 b=j2/pAg9UDcj03gVKcHXQ4Ctz0eEc7+X/SOw0Jith3jkRaKn0JidFWXBZzasyQ9Q9viRwIf/s2QyyBH81uO/t51ivlyhUINTZ5dLbJKqPCfdVd566Qfh4DszU+2MacXsx7i4XD3GV4L+T4674L5QPRm9cNx4JSSzzOMNZ8dgLY7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3272.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 05:49:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 05:49:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 07:49:51 +0200
Message-Id: <DIO4B1VH1JZT.27KYCZG39SKDX@garyguo.net>
To: "Malte Wechter" <maltewechter@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Breno Leitao" <leitao@debian.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH] rust: add procedural macro for declaring configfs
 attributes
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>
In-Reply-To: <20260520-configfs-syn-v1-1-6c5b80a9cef2@gmail.com>
X-ClientProxiedBy: AM8P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f75f9b4-f82e-446d-6235-08deb6fcc730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tK1CuzPyjF/ewIjXD6z5foZQy4sMqytxFcQz+3HuaMezKXo+5BrmXw6bdLAqgU/Ay583zeeYzimV2MrtTG5c2gkiCoZ/Ce5c5Nav/MP64M2C/Irp5KK+3r2V70kHB9vG+KFtKjybsqS6mz47xiwq9bHjaUNd/C/YIDHg5eQWl4n1dHGJAsjyOq2AoJrYAfcuWiuswiT1NZY2tUPiErZVj7zLdkw1dEvqnJtLL0kyU+CndpkzXJezRWoUQQDTq5jCaHMs5vB5cvVEhf5fbrVvWkjpViiCMOIRFgov7xPpVEE+HYAhXOWs/k6sEPpO8ht4z+tNnZztp18MBeb8VS0SD4T+01eYXFHiGbQL7wBg+4rM9t5pO/C+cPVvSo6y1l3q4vigVEgHB+YOldKUNl6bn6jTenXqJQR7Z3UXxDJUrXo+hbWVPieKJJna8Qi2Ld6kIadwoxU7ITxaVWMoUFG1KNaOk8z7+4Fvo/W82Cjz481bFPGSZf4JvWXFofXeLufxSK2jhVk1N7SjzO+PfwSreL49Yim2mohl/ds8fxD1ttuaEC+CLWEtmQPJ5hPX34NNhhAaiDewPvVJnXjygEf6BBDvfggQS9pdcrPB4mku5nYNLozYS+M+FEogHmu6TLdwAzJoJa36ZTkw2VNwGS9oW5GdA49DKMQH1om6K0k8qFd5f5U95h+RUKt8l+mbgoL2539xGn4ulTSTrF1XqJfcxq95UzVg4WmyoalueYcibYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0prS3FRTGdiQmlKQ3JhN0V4anVRRkFURm96V3RLOGkrVlppRy91MjJ3N2lZ?=
 =?utf-8?B?Z1RRV2t1NVZhdnFUbnhqdko2dFZ5TllXQnVtTzZsQlBzVXJNV2dOZG1MdFFm?=
 =?utf-8?B?dGl5WG5ZYjF5dHpFV2VEK0s2NkxHUExZTmk0bEkwRVdsenVrTlloWmdOZFRF?=
 =?utf-8?B?ck5oYzNFdVNYR1JjM1puQlZMREh3eVordEhwYmFTQnpnMFJvaVArWHFuUitK?=
 =?utf-8?B?V0Z4RWg2TkZKRERVMmZoVnU1UUNUTmszTzNtaXlESldNRDE0R0svRnF0NUw1?=
 =?utf-8?B?dHFQOEJZZndyallXcTdrUXVsb285SytKZGdqaHFVNGZTMEdvajlDZXNvY25B?=
 =?utf-8?B?VHMzeS9yTEJEemVQYjlVT3NNb0RQQ28vNDZxb2Uxd2QwSjNxRlkxMTEvaEhs?=
 =?utf-8?B?NEdUbExvWVVWTWUrcm9SY3B0T1Q0WUNoRTlGUUlxMnNoZ0ZyZmYyQW9lenRG?=
 =?utf-8?B?V1F3eVFkc3lwWE8wMEFCZkZ0YU5HTStzNEE2ZmZoa25UQmJKWGtnZENON0Nn?=
 =?utf-8?B?TTg0cXpjVDNiVU5Jek1pOStNS3VjZWk3UGd5d0IwMW1Wd29NSEs4YzkvdUV1?=
 =?utf-8?B?anNGUytrMWs1NjJhWU5qVnA4L3pTME5kOEdXVGdUZ3hhdkYyajhtTG10c3lk?=
 =?utf-8?B?RW1OVXYyVE5aYkhWMXAvNURPTnZmWkh3STNnQUd3YlV5Qk5hTTBTMHRZd0t4?=
 =?utf-8?B?N3hrZGF2ZWdzRzV3UFJQdzdXNnQwakFnOXVjVlh3VXI3Sm9hSUw3YkR6OFBk?=
 =?utf-8?B?dVhPZFlhQWUvYlFSQ2N1N3NVeEF0Mi9XKzhaU1pyaG5ZZTI4d3NranVxZ05C?=
 =?utf-8?B?WnQ0NzZDWXJEUzA2U2FPT0dRb2MrQklXNnhVQmJkbi8zREEzSjdWUFdTVnZj?=
 =?utf-8?B?b3BPMEpiOHp5M3pyUnR1WE9QZGhzSGd6dTNSWHhtaEV0Mjc5MjB5K0xzSWho?=
 =?utf-8?B?cmwwTktiQ1lYQzFjVFM4bE1jSE9uOUJCSEFYem5jWWZjaHFySk92ci9iZnVY?=
 =?utf-8?B?R29kYUM3eXdXc1FrMjgvZG5IYkUyTm1OS0k1bnpLNHlRNitYUE1XTitLdkpS?=
 =?utf-8?B?K2VOSEliQ1hUcEJnbzJxb0RqNFRERmxDam5jdC84eFJmeTVOM1poWjA1bnlO?=
 =?utf-8?B?Nk5jcFRpT1lnRW9DallKZURQeDZjVnVuMEhSMnhrbVRXclJBQTZZQXp4NFEz?=
 =?utf-8?B?dGNKSG9qeml0SHpZeUU5Nk5NYTdnb0lPV2hsWmZMbWZIRFhDajhERWJBZHNC?=
 =?utf-8?B?ZmJUQzBwSFNDZ3YyT1QyMDJjUFRvRk9CRm51OEhwcENKN2xVVXdwakR6RFJN?=
 =?utf-8?B?SGRERnpJWDBRanNmM1B5QUlMbHpBWHpiV0FlTzlVWTNvWGdibm83eFBOZ05O?=
 =?utf-8?B?QlNybUp2Q3BGWjZ5QlpWWUI1aTdJRlVVQUQyS0g2cFhUdGxYYlozMUx4cEYz?=
 =?utf-8?B?QVMzdmZ1WHZTNm8vTm5JRjNNNGRaV0JDTXozczgyOUFxdHFGcXZmNGtIbng0?=
 =?utf-8?B?Ui9Cc0wwRy9GeUY3eXJJaldvNzVPV051RGcwc0h3VlRyRkFxemNoQlRndDVk?=
 =?utf-8?B?VWV1NFYyWHFscVRUUVlkQ2g2NzhhMWJwNEdMZlhVTWl0cSsyV3k0NytxbUt4?=
 =?utf-8?B?MDBWTHlSZkJTNTVvSzhWaEhWYnFQQmJtOG9OOS9YRWVrUWFSQXVQOGdRRmo0?=
 =?utf-8?B?Tmg3aGs2elJlcjdNVDlJWEVRWkRVUlVxQzR3RithWnJPWjZncVlTQ29kdHZN?=
 =?utf-8?B?K3hvVnd6clJDQmhhQjIweFRHZEMyaG1TWmpUb0hCc1lNdDR5c0I2RUE2cXBs?=
 =?utf-8?B?bVlad25NM3dLSWVBbVdiRnFTeUk1SXA4SGxQRU0yOS90b2F0YVpJRVJ2S2FS?=
 =?utf-8?B?a1lkb2dXYTBtb1RCZ1BIQTk4Qjd5bm5OcDRCc1lkUGNFcFBlRnhVN2ZrYmZT?=
 =?utf-8?B?TktKNS8wQ29LVGxhZ0J3dUxOVlBjcnhkdHdPNFFETkkrMDNzYVFZRXI0b2ty?=
 =?utf-8?B?WkN6d241NlpGdHlkZEdKYWFDL0ZhcVdJTVJobVh1NDhxNTU3OXlGOXZaS0JM?=
 =?utf-8?B?YkFqUUhTMjJmd1pzN1lDYzhaRmNRc2JGYXRlMTk5bkFOZnNzNVBPSzd4emRh?=
 =?utf-8?B?bEg3akdJNFQ0K1JFQ09Hd21oRzlJMTZVRGVzU2QzL1E3V1ZUOUxxdTNWRXd3?=
 =?utf-8?B?MmMrLyswUW85NkNNZnN3ZE9pL05MRUtUdEVhSWJpWm1KQVlrTUdlWTR1ay9o?=
 =?utf-8?B?bjNnNlViekEyeGNaT3pKVE5NNzl5bEM4Y0lUcTdERCttOUhzdmRtaEVzNldV?=
 =?utf-8?Q?99tHWIjBo9HoJfS3IT?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f75f9b4-f82e-446d-6235-08deb6fcc730
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:49:52.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6zNdyi8I3oJ5GwZ9yAeoL87MJBSauopuiIZ/NEtV2tFKf6eGDmI3WlRtG9vjfv/0lFlAYEx7YGuM9n2TQ66/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3272

On Wed May 20, 2026 at 9:40 AM CEST, Malte Wechter wrote:
> Implement `configfs_attrs!` as a procedural macro using `syn`, this
> improves readability and maintainability. Remove the old macro and
> replace all uses with the new macro. Add the new macro implementation
> file to MAINTAINERS.

The current declarative macro implementation is quite readable and IMO more=
 so
than this syn rewrite.

Unless there's a compelling use case where it needs to be implememented usi=
ng
token munchers with declarative macro but can be easily parsed with proc ma=
cro,
I think it should just stay as decl macro.

>
> Signed-off-by: Malte Wechter <maltewechter@gmail.com>
> ---
>  MAINTAINERS                     |   1 +
>  drivers/block/rnull/configfs.rs |   2 +-
>  rust/kernel/configfs.rs         | 251 ----------------------------------=
------
>  rust/macros/configfs_attrs.rs   | 182 +++++++++++++++++++++++++++++
>  rust/macros/lib.rs              |  85 ++++++++++++++
>  samples/rust/rust_configfs.rs   |   2 +-
>  6 files changed, 270 insertions(+), 253 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd163..45f7a1ec93b45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6464,6 +6464,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/a.hindborg/linux.git config
>  F:	fs/configfs/
>  F:	include/linux/configfs.h
>  F:	rust/kernel/configfs.rs
> +F:	rust/macros/configfs_attrs.rs
>  F:	samples/configfs/
>  F:	samples/rust/rust_configfs.rs
> =20
> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/config=
fs.rs
> index 7c2eb5c0b7228..f28ec69d79846 100644
> --- a/drivers/block/rnull/configfs.rs
> +++ b/drivers/block/rnull/configfs.rs
> @@ -4,8 +4,8 @@
>  use kernel::{
>      block::mq::gen_disk::{GenDisk, GenDiskBuilder},
>      configfs::{self, AttributeOperations},
> -    configfs_attrs,
>      fmt::{self, Write as _},
> +    macros::configfs_attrs,

Except for very generics things like `paste` or `concat_idents`, other thin=
gs
should not live in kernel::macros (or from top-level) but be re-exported fr=
om
subsystems.

Best,
Gary

>      new_mutex,
>      page::PAGE_SIZE,
>      prelude::*,
> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
