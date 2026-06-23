Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020093.outbound.protection.outlook.com [52.101.195.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285237DE9D;
	Tue, 23 Jun 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222793; cv=fail; b=cXI9amz+YghluRtfziiMJYKMktz4NZRBMYhovnFcZon5dpdaruJYfvRIuxeaTLTSXnIeAyHLA1TmAAAw4WBXBnMbHwyBNSiv9MRRaWTA9T04Li5UOEnBCUZedfYt3VWZKcgSKJ5JMvJ9e2ELBp0BxHK11B9+A/LXrlbjU5QxseM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222793; c=relaxed/simple;
	bh=ifouXrtcQSwRRkW+v6eaSpau+zVw+26wOzIWNNNqTiM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=u7LnyMkR5CJdGSwwCWJR/dTtB2DEgKlJY3krWJy8STRQr3pYXsFrNbQrgyE7rlF2b/XFFIjHzxWj1NCmcezlYZtqxwsPtbeLGkKiW7sk52AYks0NPr5VgOBnec8oTQVfCIrAx5rfj0Frv96Kr2gc+qHMbh4/K72zNOOzjWGg+8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SBznQRsz; arc=fail smtp.client-ip=52.101.195.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SBznQRsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXjMcrQf+5jPSdXJlFd6p0TuEcRwgoMHZGYV9hnC4o2JXfod+672uhUq04toqy/NGAeJq6pCGPjvur9XxqWbhb25UnOkttuT3qCLAa6539LT6quJpLQXF4mt1r+qrq6cnDf87wBTbSrNG/UjlHZUaV1tUDE05QIdYvZZBXWeOSUiPlO7sZ2XiR0O+/i64uWDH8hhHjNZn2QTKkD7jfdIGY9H60631PErH45MlnoUWyvD+1uXWTFsi+AWTaxgbr6btOltq98HcExUxCrHHRvHlSYKixlqZwNN5hAWyK9uojPYt9BRcsmNZEV3BViqu3BXFh52nA421hizXiitJllz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qXEkNzwatS6h9KxR4kxYVsCiLdw6WrOTofmLgcL1kE=;
 b=sZMEAF2nR22xILE4mlkdGiHK22NXJ9Q26BqLOyZM6Rm0umtUirlQMF0kBbl074p7winCcrU5oJuVNf98/OBbW83gyydlq3bgJfWWAMvixZc36NEO7AStfroCCEC5Nnf/iPtCX+iWXFK1mR+npjKuWNc75pk2cMKnucX/FipCrOwkH67BGK8ypVAG8wiuPXMkEPkLRUL3UNp+H5jTto+nEsgTmWBrzF+u8nSv/c++S9VB6edIBg38j84qJKuvil4e+pcngtq57lIg/yGQtfqYtSDWIQ8dcHkVO3oxt2OMhdcTsBs6Ernm7Ng9fNVc/LujZxdIgvfrRv5mgcrGnzIEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qXEkNzwatS6h9KxR4kxYVsCiLdw6WrOTofmLgcL1kE=;
 b=SBznQRsz9SY7FU7Le7LZD8xDlvDQTxNNpUYvauR5qkHO4MBilJWRBb0wqm/l9Ed/NblLWLp2/Yq6nZDJArdNc3fA/gNxtfheF98D9fXE6ZC8Jg4OJZa/WCEi14+j/9BPGvG62qkJWW0SqOuueTHxiNVve06W0qynIC1YY6gOp9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB5847.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:53:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:53:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:53:07 +0100
Message-Id: <DJGH91QS6MA2.2RQ1CQPRMBF1Z@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 7/9] rust: configfs: use `LocalModule` for
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
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-7-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-7-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 95650359-89fc-41a4-c64b-08ded12ec1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|4143699003|56012099006|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r4bSLqBbahaCLhrcmDJRw36geA6b7mKa/GyQNNC2gDQBv8Ny30mHArIncAnYVJdHntYPEwyuYKmnDb+zp9h5RMW2pGU0XnCcSPr8Dncd+gaLbdv74UTBAHIDUC6IJ8oyjrSDnNFUbKA5AE3sI+0Zs4Liv4E1Ai5J5fDS7KE0hTr0GW20CBedYktIluYsDp+/x/w9Zz9jVXQnLdhArxYJO/eJAEl84OxkcyPFrdkzjvAqrDBkyLUyl6qjeq6ycmyaZQPAyXFBubr7dUUv033UKRzi84kvhzhvQKNxBeYdN+sH1qccPCuAjkmF82WifSNVLaiVvjNXD6FVbCSlYMZntUFos7KbcJAHq6hLkhU6OtPksK24n4qHEJwrxxa9wwwVt+An+P+gs/1RzptuQlNspahjZSlMjXxtmSs6LZepsIHTdqf1cBtgPIeN8f3DX/gGQ1WqWV5DUTi4vaEedYxWUuQ7nVUAOG9imA9DyRyvTu18KcMsNU4z/jB3E7TTzRdDz6Ter4y1JpblU57npygmUbDxYIkRBihHmQDYKSzOdwqg1eB+UCJdUWr6WPj376o1wp4MbYBC6KNEsEO+Cfj4vDC2g1iG8wFAVNxNLRRsY9+AKBhQQysvJkfh0/4tia08gMh55fKba7o+gfCihWp4jY7EDXrJGVzVTZ5scVdG7Gc8Gy0CPsuyq8pGDtFkdryBciYo3XVytFGGDo4Jh3LlDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(4143699003)(56012099006)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnM0S0pSa3FpVWFBZHFQQU5WMHRiWVUzT1pqRXJ0ZklMUFhTWjEzcEgwRVA3?=
 =?utf-8?B?NUFUTmttY01vWmdndGphR0ZVZ01PVTQ4a1NaVzBtMmpmM29xSENSbFc4LzRw?=
 =?utf-8?B?WUVPcTVDMGVFbnNGNE1CVGFCZHNpeTk4VzZwOURjWHJBZkJ0amZueWxSNGdC?=
 =?utf-8?B?VFpXRXBPbktPUTZDYkVITTYxSlcvN2FseXhoSnkwTStaaVhZcUt1a1JmT0hP?=
 =?utf-8?B?R0tpcTRsckp4M0JGb0hZZ0p5eU1WSDBXTnBZMW5jN09wQUJWaS9PZG52YnBE?=
 =?utf-8?B?NXkrNE9GUEVsQm1namQyK2pWQmgxT3kxODFQVzl1UWxhK1ZoTlQxS1dvMy95?=
 =?utf-8?B?d21HRG12ZytqeSt4SGZjZ3NLZm5iSVMxUWF5d202ODRwQkJCNGJmVGJhVG92?=
 =?utf-8?B?SmZLYlFDNHNlNE80L0hjOURCTkRlYzQ4N1FHZUIvTDlONVVIQXZBS3l5Unli?=
 =?utf-8?B?SU9Ldy9WVkZXb05xeGJFbEc3L2ptWlRQL3MzcS8yZTRUSklTS3I3OStJUTk4?=
 =?utf-8?B?UDdsOUpoSVY1cEpxRUpGQ2FKYXpZOFNHQThERkE4ckRXQzVFMnh3U0NhL1B1?=
 =?utf-8?B?YW1VTExHZDY0YXh6cTFzdkxhTEh2TjJyL0h5RjF1dmJsZEpPbkE2eGlNYW9S?=
 =?utf-8?B?MTdKN3FqSVo1Nkk0blJJb0kwR1ZxSkJHYitZSE5GSEphZ2F0MDZabFNVYkZG?=
 =?utf-8?B?czJzUnB0UXR6bTlrWjl0RFdqckZvTWdaMmlQbHUwZXFtWXNxUnlaUjhDeWFj?=
 =?utf-8?B?cHhrR2s2QjdwcDFVWGhUci81OUdMSTZqY2JaTGsrbmNDS0lWbjI1RUVEOFRL?=
 =?utf-8?B?Yi9ZcmZydWE0MVRzV003dUZXanUybTVJSGVTd0QyRzFCajZVd0xxditlZWNF?=
 =?utf-8?B?cFVnWGRHbU8wNnY4alVBNk5kOC9VMy94aFlJMXhBTVlGa2xPb1psZFdQZXd2?=
 =?utf-8?B?bEd6dU5XUGZoZ2p3WEZyd3YwTmlscURhbUtobU9GL2dlcGhacXdTcExKQUFL?=
 =?utf-8?B?NzEzS2d3ZlJVWkV2YnBSOXRQbENtMXdIbFFhWXpzZmtKbGpORFFzdEYrRUM1?=
 =?utf-8?B?U0ZvNEFoY1JJUlFLd1R6ODlxclFOTERBamM5TFNMVkN4ZHFpNVFrQ2t2cHQv?=
 =?utf-8?B?TkVPem45ak5Eb2dsUDBaN3loMmtUbnpJU05xc0VUeUd6SHl3YVhicEY1WE1a?=
 =?utf-8?B?TmR6bG9ZOFlQY0tUcGpVMEdNUFRvN3dIbko5L291M3R4K0cwU2RrQ2JyMTdE?=
 =?utf-8?B?ZmVCTkc2YWt3Um5nV2FEUDJBSHJzanpXemdOY1R2RFVCSG5qRERQeUlKSW9K?=
 =?utf-8?B?RnRscWJYWWthbWM2T01jTy9jNUYwVEFydWx4UGVFUnRwNGJSWWRxbnhqWVdr?=
 =?utf-8?B?d3hLMXpoSjJZRHAycmd1TDkvVHpKeDVpaE9NZ3dzSWM4ZnFDU3V1a3NJOUJT?=
 =?utf-8?B?QjFzMC81SEExbUhKOXQ1Y21rV24vb1N5bDVIem93cHpzR0dwMUF6QTVMNHZW?=
 =?utf-8?B?amJpMEdFM0dvSWd4RXlVa25pNmtBZmJzcVh3aytvcWVVWU9zeUdGZ29xWDAv?=
 =?utf-8?B?MjFPVXNGeWdKZzFqbDF3S2lodjl1SU5FUjVVc3ZWcUs0VC82RGdBZHcvYnQv?=
 =?utf-8?B?Yk53TlRHTVoxWExCby8vTTBleXpSdG40OG80SjZDV3RGb0oyQWJRcWVJKy9m?=
 =?utf-8?B?bFEvR1pFZXVJalhhVHBKOVpVbElrS0FuN2MycjZMNFgvQVZlbkphZEYyRXhT?=
 =?utf-8?B?KzFRaDB1R2ZxYUJ4SjRCakhWYWptTFAzMitJL0JYTzArb2U3LzZNcnEzRzgv?=
 =?utf-8?B?aXZSNmZuVnl1TE5JUGtlWUxIZ0xrRWd1eFdXYUxXdDRYeXlIQ3NoUkljbDM4?=
 =?utf-8?B?ekpoR1JyVHBNSGNtSFNsYUg1UGk0VVFiaW5GNVcyb0wwZjdEOEhWTkp3TW5V?=
 =?utf-8?B?bG1zcWFyVlVkMWFPUTlpcGpBVVhYbmdWVnpoWkFqd3NFelNVcUdEdy9pUHZp?=
 =?utf-8?B?UDFaYTlXM21Sdm0vOCtrRjZTcEJEYmRLekNFd0NtNkQ0WUtzQTNtRlBET2ds?=
 =?utf-8?B?MkcyTWl6UXE3TjkzVUI3UFhEMTk0UjRVY3RRRXlpU0FsS0hxQVpFZFRoODFN?=
 =?utf-8?B?VTVSRkt0emxsQys4RXpLK0RtWU5FUk90ZGR1aHA3UG5VVTZKRlJYbGEyQWd6?=
 =?utf-8?B?aGFSWk9vVnRsVVI5VEt2M0l5MS83K29RUGZ6THo4UllxQzJkK3pUUHFXQzVi?=
 =?utf-8?B?WksyRDFPS3FrY3k1enZQN2tCZ2Q3bTRZdUk4YzBnQVdFL25OYVdoS1hJaXN2?=
 =?utf-8?B?YXNzWUl4RHFJN1JJV0tWWWs2ckZCWmpWeGF4YWpXZGpCUHdPeVY4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 95650359-89fc-41a4-c64b-08ded12ec1be
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:53:08.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb2qHLwc9c+Cu3YxxEi4F61sw8pIwpX1TswL6dT+UDgwGHiNm+6hj0Lx0EZOS7+tSYJ4NQqFWfxpWIj6R0H+GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5847

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
> macro with `this_module::<LocalModule>()`, and update
> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
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
> index 2339c6467325d..b542422115461 100644
> --- a/rust/kernel/configfs.rs
> +++ b/rust/kernel/configfs.rs
> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type=
 {
>  ///                 configfs::Subsystem<Configuration>,
>  ///                 Configuration
>  ///                 >::new_with_child_ctor::<N,Child>(
> -///             &THIS_MODULE,
> +///             ::kernel::module::this_module::<LocalModule>(),

This should be `crate::LocalModule`.

Best,
Gary

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


