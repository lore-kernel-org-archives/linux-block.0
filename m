Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021113.outbound.protection.outlook.com [52.101.100.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BE1E531;
	Wed,  3 Jun 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497177; cv=fail; b=Ivw4+Fg1VWo0QoAIOCwitxHv4W6ZuEgukEjAKPGBWhOaU4dmHQPqTS4i5AMgmXJwzvIf3fzzkkusVTLnLpBdNvErYOdr3EEWOc85+Xk26oeDEep83S6yvgW2lgnirZh6uvsVLepX5QSOf8UP0idy4uvOiEyR4SbwDEV4DzUGdqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497177; c=relaxed/simple;
	bh=ryeG837aRW63rl6edtzAniffeNkW5WStpi3Lvck9JOg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cBOCV0FEFiQKhzpFNRJV6BzplreQpPsluW2Fz2hBhd/XqxB/kQ39i80nIRUY6lQVhSsOKhHPZ+UG/5bUecJ6HBdclXLwCfsQEFe10Pj1YyEtODCRK7Rjo+RC0VZ7+NTLPaB4J5SWXzwdYx8liwkh8NEJ6LMau2idVVY/lvZdFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fCx/kipH; arc=fail smtp.client-ip=52.101.100.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fCx/kipH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5nYwenroB6tKZp0b905dxMqid59XsU2gOE6li7PsocMCvHJNkmW/3vJSf7HL5BeY2cFmQhdiPsKTpLfSgOCmqt7Q6VS0M4ZYXIOSWDjaANKeP5UPHTgMPO4obn2i3c8dbQGj7hsHqBXvQHMAXsjhnGKni+jSmX1hKfiq+4LGLpD16bWY+Vm7nBR9St1bKrWxtCbUMVr8WA5G7+dHagIK+lsWv9m5JiFjUpWKlcBFMuGLIdIHTW1lUhXyfbeRCtSlOwtVGaUD+xayR/8FCPaptbPN0QjA1BnBwbDCb0NPJ8u+4ols25hh/Qca1VjxA9XBovGTDIaOQR+rzSqMAvASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+QWiy4Woy9MIfhr4Cb1bYq0TI52SjrbDOGZFSFW3rQ=;
 b=V5R7bVkgHYZnY+C3d/OGlG/fvc2SyYFf7kHShJJN2OUZ9xLZNdMZjRMDVjEF9hcKfJ3LfxFi7+ORk+shBEuIq2iAGr0nj9kwE9AK5fWdI5yc+RILftaPYWo8+dguNySjdWl/pJ58DeeIdcUcJnIT9duSXz5Zp5qQLLT55SWS0uzUEX1GdyI72YeeaQEqCJdGsulHP3UKbFOEyYT2swS/PgSsH/ETn7v4+m4E/7K3ripjHZHJVbBmrY6kgRr2QgwAzl2GVIQvX75PUNQx/LtuThNCZrUvgZEYlZ4iF6EB59uTdDaNgECrssYR106qKBYHU9pLi+ltShkgbqJjXeZs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+QWiy4Woy9MIfhr4Cb1bYq0TI52SjrbDOGZFSFW3rQ=;
 b=fCx/kipHj3zFyhtRXj1oqcrTOUoKRrE/VLGu18HMsNAgnROfRVCfWWXZgc+kR3NfqcHwWpTSalRtlTIy4bu8t4nINcWmB1qqilUd//xMarenGJmMqIjrMjYECL8qSgBNDznIbgtfQExWnVcbEsA8/G1lLM9S8oRbPpkCy+am/6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB5846.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:32:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:32:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 15:32:49 +0100
Message-Id: <DIZHKJSZXQ4Z.6SPXJVGDV9ZW@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] rust: add procedural macro for declaring configfs
 attributes
From: "Gary Guo" <gary@garyguo.net>
To: "Malte Wechter" <maltewechter@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Breno Leitao" <leitao@debian.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Jens Axboe" <axboe@kernel.dk>
X-Mailer: aerc 0.21.0
References: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
In-Reply-To: <20260603-configfs-syn-v2-1-cb58489c2647@gmail.com>
X-ClientProxiedBy: LO4P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5894d2c5-1e7d-4974-9295-08dec17cfdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|56012099006|6133799003|5023799004|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q3GsSxu9/g+F1TJoDNkU5fn0cMeKZdJNigZiYhUiGhx3mlD5hCpFVHjsuT/xyiWp7hLP+6KQosREyrTRWB+KQlushgMTdluUhhVXoZnlnDZfnqdHs8sOhwgixUKM5QLKGGZDQ/fBG9faD1dloI1hXH4VFHV/NoGZONxDD/35Q9Obct0YdprhzWFxibgCr1bMEyeJecUKoq4h45T2OJO5OugsezZ4WCLth92HFXZj/bXkD2WH+LG/zb0eLH/fXdg3xX7dRJtIqg78yOXk77fBQ08O28KdzjGLFPikrIMA0EnsJQIMI7dlUIw3zTr7AT1wsS0fvO6V5rFyNuIQAuJa+eZSZPKUdlGaRoN8qeIVufaapmEHsNFqdhJ2WrXfH0cysQxafQrTORtCsrFWlOrTpUjPrw6vtLPLRxYn0HXhN5iPvOitVav/9VdLIwAkufALjcs7c31W3JGZ/FPqdn95zrQxAQAEoidsrZHYEqHyHTz8w4GG9KfNaSFdLMeByXsw1J5ZPz86Xob+YP0TIdXqC//u+ci2Mj7TDjZKe68sFO/6qVWeFtm8lWaKtqyC6xabu2ooBpD0A0U+TjR7aMvaSKP7fSjttf2zbDMaRcoqrT7vHwYw8Sv0A0sEJW8rdMfaGVW8FHJUBH0EV9/6PDxPmdEXp+d9zXIYYFZ5oMlEYtrokx1QQrkdDUSR/JRQxMVlMi+yeOS6MQ8nN53o8Xfaza4N8kunyuOHd2WfiCIebUTH/ayx0AMUU0/d9K6HdPuT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(56012099006)(6133799003)(5023799004)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnZtQ0xZUEg1VnJlTjhZNmZaVEc1Nk1Bb09Fa2x1aDY1QTlTV0NMcWN2Uk91?=
 =?utf-8?B?a2UrQkxwL01SdE13UWliM09PdExUTHF6Z3JJV24wcnRwSFQrMkNjUmQrNXVt?=
 =?utf-8?B?VXZQQmFpaUJoSmhCSXJ2ellTY1lpRUtjQ2U2eFE5eUhqMUk2b1E5My9qakxp?=
 =?utf-8?B?TCt5T0lJOCtCRmMwYkJEWHRsS05YMHZIcmFyaWxCU1FScFVwU1BFZ2ZvREN6?=
 =?utf-8?B?MTZGVlJUcEl4OVh2bm5GQWJ3T3BFRDhzdHVQdm1GL1RBL2V2RHQrR1k0V3ZC?=
 =?utf-8?B?Y2RZWXJrNzc5VTNXL1RPemZTMnhOa0hhcjMycTAvaG13Rk9Uby9HcW9ZZHZC?=
 =?utf-8?B?YWEvemszT3E2NmNsMGdtSXNYY1dsU3E3ZS9IWGNkMWlWbWQxODJ1MEY3Tmg3?=
 =?utf-8?B?WUF2N2FraGwxbldZL2xpK2lUOHdwVFR6eThMSFMySndTdk1ZMmgvQ2hBbk5l?=
 =?utf-8?B?cm0yWFc5bVpBSXgwSVZCQ1VsdkM5d2k4RmE4ZVdPK24yYTliNnNQd3pDbURG?=
 =?utf-8?B?THhyWnVZTzJncW83aDdRT0crWmtFU2c2WHBUV0FZQjhpUkRzS0U4SEZ2aTd5?=
 =?utf-8?B?L3Y4TkdZb29ZejJoN3p0QlQ4NmJmMEJXVEhjTkYvV2RjWXdDeUdJOFFVdHVM?=
 =?utf-8?B?N2pjZ3RNb09oZ3VvRW9SK1h3MU5NTEh0SEM2Q0MxNnEvRU5uVGp6R2ZkWTc5?=
 =?utf-8?B?TkZkZ3VpbkpmZVArU285WGRGUFR1NTQ2UHJ3ZEpjVm1FQVcvWGRSemc1YnY3?=
 =?utf-8?B?VmZkR2VvZUcySUFXaVVINy9NU0FXMVVTUU1zZTAybS9iYmVCckx2VTMvTUF5?=
 =?utf-8?B?WHczQ0l0UXdHZFpJVkFWVE41enpDcFlVQ21aTW1jQ3lmY21UMGcvWGtEVGtZ?=
 =?utf-8?B?Qm1aa0UyTjdrWmcyVGhnSlJsOUFEcUcxMUEvdkVFSWNUTklydzhXUERFdElk?=
 =?utf-8?B?dHZQN1ptSHJPU3M2QVY1cCs0c2dYRDlJV3loangvNzZTcGJCNFNiWUJQQk9t?=
 =?utf-8?B?aVNOSnVFdEQ3NmM4cHhnMVg4OHhvK2d1TWpmQzRRNkNIc0RhWElGT3JXc0c3?=
 =?utf-8?B?ZVNqLzFQN1BpQnNxZWdkYzR2S3h2bzBHSTN1STJjRU9vWTNGUm5yRWtVNlJC?=
 =?utf-8?B?QTZ2bFYxQ0l0NWlDWXVRbGsxN2tFUGo5eFo2MHlGZkxDVCtBS1k0Y0NZc2w3?=
 =?utf-8?B?YjZPVzk4QWFpeTNPbUQvRTlESUNDRFlQNFBvU0hGZWVoaEZFZUd4NkNTcGlC?=
 =?utf-8?B?azhiL3RpWHdiTGNaekxWTGlqOW00aTV2MC9uYnFxMkVvSFhkMjVSZlJKQnp4?=
 =?utf-8?B?Zkp4SEljbVA4SnlzUTVvZWVjOVk3NTlZalVORnNFWUJoQ213bXpEVWsveExa?=
 =?utf-8?B?anord1g2b1BYOXV5blhLYkt6R3RSZ0czMG9iK1BvYUhuaEtPOHJRaWp0MUlh?=
 =?utf-8?B?WlQ2NStUY053WWNOeC92bEI3ZitPSjRsb1lJQk9uZE9vcnVjS0oxL294Und6?=
 =?utf-8?B?WWZ6UUxFZ0FPQzFRZXhaTDhPWEh1dWhwTUZOcnh1UTYxNDZmLzlkajlDZ0Vy?=
 =?utf-8?B?RU1JUWkyTzJWME5hcld5YTBpRVI2MVFtRlB3cm8xSStBdUxrRU45SnFsN2Ir?=
 =?utf-8?B?bHJ0TmZ3R3RUV2IrTG5hYkQ2OW9GY3RydWRPWHFtU2cxZFozdStKaXliR1F2?=
 =?utf-8?B?cDZpNDhXQjBjQ1dzNUpGNExRQjk5MEtWU3VtQWF0Z0FmYjB1bUNMbXRPWm53?=
 =?utf-8?B?Uml0bjJlOGhXdkVFWDZheEdpaWo4ZlQzNkZiYXR2VnN5QWZubkJZNVYvNll0?=
 =?utf-8?B?NzVNa0o1ZjNNOEk2dHJNZ1AvbmtPckJQTGVHaHJNdmU0eWNMTE1WSUQyMnlU?=
 =?utf-8?B?aERjeUpidWVIdmhpOWJsc2FUMUwyZWZSWmMxbzB4TUg4NVltVldBRjIvTDVo?=
 =?utf-8?B?dkU4TktzbEZBd3p5U1Bqd05wR2J2anNtbFVoSGNrWGpkRzZzWm9jSWZ0Zklv?=
 =?utf-8?B?bXpwY1FjOFp5L0o3U3o2SXlKSi9rVisvRGhWbzlsaENwTHB5K2pxdzMrUU14?=
 =?utf-8?B?dzRSWjRnWmxjRUs0WUduejVFeU5XSlZlUnB2TTVJR3FHN0lvc3dZWmYxNUVl?=
 =?utf-8?B?cUhGVUV3d0xPS1NkSnNsRU5ZeE1MMXpYbVFoZVRIQmJqRHFjTnpZSHBzNndR?=
 =?utf-8?B?Smt0YlA5cC9OV3ZOOGZHN3lPaVFkbUJzcFhMSVlEeHMrVGppREpmcVV0aTVW?=
 =?utf-8?B?K1RSZlpuQjNrRWxtKzhFaStPazhZRGRwNVgwNG5qSHROVm96ZWpkcnlEdXcv?=
 =?utf-8?Q?y49vE/Z06QnLEWjTkA?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5894d2c5-1e7d-4974-9295-08dec17cfdac
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:32:51.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npP6hnW6Ju2KEwjaCp43S4EXBt8zKhQ0LY/TETc7AolnIY7IrtmX0PSHF4UHsK3Yux7bz652QNc2xnEhhnk07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5846

On Wed Jun 3, 2026 at 3:08 PM BST, Malte Wechter wrote:
> Implement `configfs_attrs!` as a procedural macro using `syn`, this
> improves readability and maintainability. Remove the old macro and
> replace all uses with the new macro. Add the new macro implementation
> file to MAINTAINERS.
>
> Signed-off-by: Malte Wechter <maltewechter@gmail.com>
> ---
> Changes in v2:
> - Add a try_parse helper function to macros/helpers.rs
> - Fix bug where 'child' configuration gets dropped if trailing comma is m=
issing (sashiko)
> - Link to v1: https://lore.kernel.org/r/20260520-configfs-syn-v1-1-6c5b80=
a9cef2@gmail.com
> ---
>  MAINTAINERS                     |   1 +
>  drivers/block/rnull/configfs.rs |   2 +-
>  rust/kernel/configfs.rs         | 251 ----------------------------------=
------
>  rust/macros/configfs_attrs.rs   | 182 +++++++++++++++++++++++++++++
>  rust/macros/helpers.rs          |  15 +++
>  rust/macros/lib.rs              |  85 ++++++++++++++
>  samples/rust/rust_configfs.rs   |   2 +-
>  7 files changed, 285 insertions(+), 253 deletions(-)
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
>      new_mutex,
>      page::PAGE_SIZE,
>      prelude::*,
> diff --git a/rust/macros/configfs_attrs.rs b/rust/macros/configfs_attrs.r=
s
> new file mode 100644
> index 0000000000000..a7fc75cdebcc0
> --- /dev/null
> +++ b/rust/macros/configfs_attrs.rs
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use quote::{
> +    quote, //
> +    ToTokens,
> +};
> +
> +use proc_macro2::{
> +    Span, //
> +};
> +
> +use syn::{
> +    bracketed,
> +    parse::{
> +        Parse,
> +        ParseStream, //
> +    },
> +    punctuated::Punctuated,
> +    spanned::Spanned,
> +    Ident,
> +    LitInt,
> +    Token,
> +    Type, //
> +};
> +
> +use crate::helpers::try_parse;
> +
> +pub(crate) struct ConfigfsAttrs {
> +    container: Type,
> +    data: Type,
> +    child: Option<Type>,
> +    attributes: Vec<(Ident, LitInt)>,
> +}
> +
> +fn parse_attribute_field(stream: ParseStream<'_>) -> syn::Result<(Ident,=
 LitInt)> {
> +    let id =3D stream.parse::<syn::Ident>()?;
> +    let _colon =3D stream.parse::<Token![:]>()?;
> +    let v =3D stream.parse::<LitInt>()?;
> +    Ok((id, v))
> +}
> +
> +fn parse_named_field(stream: ParseStream<'_>, name: &str) -> syn::Result=
<Type> {
> +    let name_id =3D stream.parse::<Ident>()?;
> +    if name_id !=3D name {
> +        return Err(parse_field_error(name_id.span(), &name_id, name));
> +    }
> +    let _colon =3D stream.parse::<Token![:]>()?;
> +    let v =3D stream.parse::<Type>()?;
> +    stream.parse::<Token![,]>()?;
> +    Ok(v)
> +}
> +
> +fn parse_attributes(stream: ParseStream<'_>) -> syn::Result<Vec<(Ident, =
LitInt)>> {
> +    let attribute_id =3D stream.parse::<Ident>()?;
> +    if attribute_id !=3D "attributes" {
> +        return Err(syn::Error::new(
> +            attribute_id.span(),
> +            format!(
> +                "unexpected identifier: {}, expected: 'attributes'",
> +                attribute_id
> +            ),
> +        ));
> +    }
> +    stream.parse::<Token![:]>()?;
> +    let attr_stream;
> +    let _bracket =3D bracketed!(attr_stream in stream);
> +    let attributes =3D Punctuated::<(Ident, LitInt), Token![,]>::parse_t=
erminated_with(
> +        &attr_stream,
> +        parse_attribute_field,
> +    )?;
> +    let attributes =3D attributes.into_iter().collect::<Vec<_>>();
> +
> +    stream.parse::<Option<Token![,]>>()?;
> +    Ok(attributes)
> +}
> +
> +fn parse_field_error(span: Span, name: &Ident, expected_name: &str) -> s=
yn::Error {
> +    syn::Error::new(
> +        span,
> +        format!("Unexpected field name, got: {name} expected: {expected_=
name}"),
> +    )
> +}
> +
> +impl Parse for ConfigfsAttrs {
> +    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
> +        let container =3D try_parse(input, |s| parse_named_field(s, "con=
tainer"))?;
> +        let data =3D try_parse(input, |s| parse_named_field(s, "data"))?=
;
> +        let child =3D try_parse(input, |s| parse_named_field(s, "child")=
).ok();
> +        let attributes =3D parse_attributes(input)?;

I have a `parse_ordered_fields!()` macro in module.rs, please extract it to
helpers and use it instead of implementing the parsing in an ad-hoc manner.

> +
> +        Ok(ConfigfsAttrs {
> +            container,
> +            data,
> +            child,
> +            attributes,
> +        })
> +    }
> +}
> +
> +fn make_static_ident<T: ToTokens>(ty: &T, suffix: &str) -> syn::Ident {
> +    let raw_id =3D quote! { #ty }.to_string();
> +
> +    // Sanitizing syn::Type::Path, this is safe since it is
> +    // only used as the identifier.
> +    let normalized =3D raw_id
> +        .split("::")
> +        .map(|s| String::from(s.trim()))
> +        .reduce(|a, b| format!("{a}_{b}"))
> +        .expect("Cannot be empty")
> +        .to_uppercase()
> +        .replace(|c: char| !c.is_alphanumeric(), "_");
> +
> +    Ident::new(&format!("{}_{}", normalized, suffix), ty.span())
> +}
> +
> +pub(crate) fn configfs_attrs(cfs_attrs: ConfigfsAttrs) -> proc_macro2::T=
okenStream {
> +    let (container_ty, data_ty) =3D (&cfs_attrs.container, &cfs_attrs.da=
ta);
> +
> +    let data_tp_ident =3D make_static_ident(data_ty, "TPE");
> +    let data_attr_ident =3D make_static_ident(data_ty, "ATTR_LIST");

Instead of creating identifers like this, just scope them properly so that
a fixed identifier is used without colliding.

> +
> +    let n =3D cfs_attrs.attributes.len() + 1;
> +
> +    let attr_list =3D quote! {
> +        static #data_attr_ident: kernel::configfs::AttributeList<#n, #da=
ta_ty> =3D
> +            // SAFETY: We are expanding `configfs_attrs`.
> +            unsafe { kernel::configfs::AttributeList::new() };
> +    };
> +
> +    let mut attrs =3D Vec::new();
> +    for (attr_idx, (name, id)) in cfs_attrs.attributes.iter().enumerate(=
) {
> +        let name_with_attr =3D make_static_ident(name, "ATTR");
> +
> +        let id: u64 =3D match id.base10_parse::<u64>() {
> +            Ok(v) =3D> v,
> +            Err(_) =3D> {
> +                return syn::Error::new(id.span(), "Could not parse attri=
bute ID as a u64")
> +                    .to_compile_error();
> +            }
> +        };

Why parsing? The ID looks like it's just substituted as is.

Best,
Gary

> +
> +        attrs.push(quote! {
> +        static #name_with_attr: kernel::configfs::Attribute<#id, #data_t=
y, #data_ty> =3D
> +            // SAFETY: We are expanding `configfs_attrs`.
> +            unsafe {
> +              kernel::configfs::Attribute::new(kernel::c_str!(::core::st=
ringify!(#name)))
> +            };
> +
> +          // SAFETY: By design of this macro, the name of the variable w=
e
> +          // invoke the `add` method on below, is not visible outside of
> +          // the macro expansion. The macro does not operate concurrentl=
y
> +          // on this variable, and thus we have exclusive access to the
> +          // variable.
> +          unsafe { #data_attr_ident.add::<#attr_idx, #id, _>(&#name_with=
_attr) }
> +        });
> +    }
> +
> +    let has_child_code =3D if let Some(child) =3D cfs_attrs.child {
> +        quote! { new_with_child_ctor::<#n, #child>}
> +    } else {
> +        quote! { new::<#n> }
> +    };
> +
> +    let data_type =3D quote! {
> +        {
> +            static #data_tp_ident:
> +            kernel::configfs::ItemType<#container_ty, #data_ty> =3D
> +                kernel::configfs::ItemType::<#container_ty, #data_ty>::#=
has_child_code(
> +                    &THIS_MODULE, &#data_attr_ident
> +                );
> +            &#data_tp_ident
> +        }
> +    };
> +
> +    quote! {
> +        {
> +            #attr_list
> +            #(#attrs)*
> +            #data_type
> +        }
> +    }
> +}
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index d18fbf4daa0a5..fdab8804e1ba9 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -4,6 +4,7 @@
>  use quote::ToTokens;
>  use syn::{
>      parse::{
> +        discouraged::Speculative,
>          Parse,
>          ParseStream, //
>      },
> @@ -54,6 +55,20 @@ pub(crate) fn file() -> String {
>      }
>  }
> =20
> +pub(crate) fn try_parse<T>(
> +    input: ParseStream<'_>,
> +    parser: impl FnOnce(ParseStream<'_>) -> Result<T>,
> +) -> Result<T> {
> +    let fork =3D input.fork();
> +    match parser(&fork) {
> +        Ok(value) =3D> {
> +            input.advance_to(&fork);
> +            Ok(value)
> +        }
> +        Err(e) =3D> Err(e),
> +    }
> +}
> +
>  /// Obtain all `#[cfg]` attributes.
>  pub(crate) fn gather_cfg_attrs(attr: &[Attribute]) -> impl Iterator<Item=
 =3D &Attribute> + '_ {
>      attr.iter().filter(|a| a.path().is_ident("cfg"))
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 2cfd59e0f9e7c..745ba83c828b9 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -15,6 +15,8 @@
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
> =20
>  mod concat_idents;
> +#[cfg(CONFIG_CONFIGFS_FS)]
> +mod configfs_attrs;
>  mod export;
>  mod fmt;
>  mod helpers;
> @@ -489,3 +491,86 @@ pub fn kunit_tests(attr: TokenStream, input: TokenSt=
ream) -> TokenStream {
>          .unwrap_or_else(|e| e.into_compile_error())
>          .into()
>  }
> +
> +/// Define a list of configfs attributes statically.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// let item_type =3D configfs_attrs! {
> +///     container: configfs::Subsystem<Configuration>,
> +///     data: Configuration,
> +///     child: Child,
> +///     attributes: [
> +///         message: 0,
> +///         bar: 1,
> +///     ],
> +/// };
> +///```
> +///
> +/// Expands the following output:
> +///    let item_type =3D {
> +///         static CONFIGURATION_ATTR_LIST: kernel::configfs::AttributeL=
ist<
> +///             3usize,
> +///             Configuration,
> +///         > =3D unsafe { kernel::configfs::AttributeList::new() };
> +///         static MESSAGE_ATTR: kernel::configfs::Attribute<
> +///             0u64,
> +///             Configuration,
> +///             Configuration,
> +///         > =3D unsafe {
> +///             kernel::configfs::Attribute::new({
> +///                 const S: &str =3D "message\u{0}";
> +///                 const C: &kernel::str::CStr =3D match kernel::str::C=
Str::from_bytes_with_nul(
> +///                     S.as_bytes(),
> +///                 ) {
> +///                     Ok(v) =3D> v,
> +///                     Err(_) =3D> {
> +///                         ::core::panicking::panic_fmt(
> +///                             format_args!("string contains interior N=
UL"),
> +///                         );
> +///                     }
> +///                 };
> +///                 C
> +///             })
> +///         };
> +///         unsafe { CONFIGURATION_ATTR_LIST.add::<0usize, 0u64, _>(&MES=
SAGE_ATTR) }
> +///         static BAR_ATTR: kernel::configfs::Attribute<
> +///             1u64,
> +///             Configuration,
> +///             Configuration,
> +///         > =3D unsafe {
> +///             kernel::configfs::Attribute::new({
> +///                 const S: &str =3D "bar\u{0}";
> +///                 const C: &kernel::str::CStr =3D match kernel::str::C=
Str::from_bytes_with_nul(
> +///                     S.as_bytes(),
> +///                 ) {
> +///                     Ok(v) =3D> v,
> +///                     Err(_) =3D> {
> +///                         ::core::panicking::panic_fmt(
> +///                             format_args!("string contains interior N=
UL"),
> +///                         );
> +///                     }
> +///                 };
> +///                 C
> +///             })
> +///         };
> +///         unsafe { CONFIGURATION_ATTR_LIST.add::<1usize, 1u64, _>(&BAR=
_ATTR) }
> +///         {
> +///             static CONFIGURATION_TPE: kernel::configfs::ItemType<
> +///                 Subsystem<Configuration>,
> +///                 Configuration,
> +///             > =3D kernel::configfs::ItemType::<
> +///                 Subsystem<Configuration>,
> +///                 Configuration,
> +///             >::new_with_child_ctor::<3usize, Child>(&THIS_MODULE, &C=
ONFIGURATION_ATTR_LIST);
> +///             &CONFIGURATION_TPE
> +///         }
> +///     };
> +///
> +#[cfg(CONFIG_CONFIGFS_FS)]
> +#[proc_macro]
> +pub fn configfs_attrs(input: TokenStream) -> TokenStream {
> +    configfs_attrs::configfs_attrs(parse_macro_input!(input as configfs_=
attrs::ConfigfsAttrs))
> +        .into()
> +}
> diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.r=
s
> index a1bd9db6010da..876462f7789d1 100644
> --- a/samples/rust/rust_configfs.rs
> +++ b/samples/rust/rust_configfs.rs
> @@ -4,7 +4,7 @@
> =20
>  use kernel::alloc::flags;
>  use kernel::configfs;
> -use kernel::configfs::configfs_attrs;
> +use kernel::macros::configfs_attrs;
>  use kernel::new_mutex;
>  use kernel::page::PAGE_SIZE;
>  use kernel::prelude::*;
>
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260417-configfs-syn-191e07130027
>
> Best regards,


