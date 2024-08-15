Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812021714C4;
	Thu, 15 Aug 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716195; cv=fail; b=AE8g5lekF5WycXcCuwPCYjzrRiunKd12dZCpm//z2E7onPdILZ/QqSH2G8MaQA1MplTC7ioX6bG6PwLFQDPI+NbHYDjEuJh7E7HD5yLvnEr9dlypA1EDyH2k6h9T1msSirXPZnMahTM3t6DWybuwR6stP2qPSougYfsyniZAsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716195; c=relaxed/simple;
	bh=BgvLH7SWBLp45Pln/I1rEFuNOdXZ34pgmyTaBdbDhKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pvQFj9nicdPo7YspMGGs6/Ou5GpfGqs4CtWu4us01ZwFMdRO0f3bMVoFFI65CugQKsVslQ5f8giSIp8FIYYWxzFGwU++I97fBm7FF0WKvuBb/LFXfbvj/oMvuvbqyLyT5jUY9FLuUrdRwZbNC3Loq25N+hKPB9gBTfbbeUoXTBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=nxgprBv0; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="nxgprBv0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkMowyz7gR7w0ZXmewgtUN9+v7Q1fWYJc+pum6wjP7ad/WLVXZAmQJOSoRMKm6YhMf+HUyFRY0YUIbJdIkQg78i3qcvgrqsES4cpRILprruBTCANfhbfanNcEgmP18DHgV3NVfd/nuSOUnQ65yNokYazIVe1g3aWpxhT7RpOCUkoj/FncVbPePNEuBSPl74H2mqJ28xbosQK0gq9BI+EHSQD0gR1bd/iyW8vme8R+T5XWL/J6jpj6QseRSJZQe0Qn0qg3naZoNluanLtCjQpMFuqtOdfLAPFceS5i7lcgdsp26OctGkZ0neJw0/7eKZf07djuQPPKW9dbjHyu0fyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leWb0AWnuAaBJsBCv0lRNv/l2xH+Ptq7bZifvsxLh44=;
 b=cBgSsH7pWZ4JTsLyy+xeGRiA+yqDLFxDsj4WhSmWz3rV9x9FmSp1Ju8WUzspT3HIWFF/t4yr2dWe+9X307vb5WfBunihqQO5Q0rS8KuEjccWcVE94eioY2qmf6+qpfwjTCXEb53nrWXSvWHqEVuQ37Bz18H3xuvWoiK7CYXYICgqxHRU6Q2DaHtQ78dDapBsNcv+rCjW9NdR3osLlTSTf/OU/7+XGiX4Kme3eQhstbPo4D+Mt0ALoUCx1m/RLj/+6Y7RhJobyW/qUIo1J7dPBBpPPmATlH2TYO9yLYOjOEI/Go5OCQgQb2DwpmUe3A4gC2Gu4Im44o1xhtRRQ2qmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=metaspace.dk smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leWb0AWnuAaBJsBCv0lRNv/l2xH+Ptq7bZifvsxLh44=;
 b=nxgprBv0u8U8e8TtSmbq7tEtpb18JuJhgAGIV4Ej6s/+uuyQ+nWBl6sgJ0IgsVY6PHoszLNnO5SzP//QdQ1TLAVk/fVjytVeri2n+FXpTHAzxI7Jth8PL3yyMbspRzQivI/f5kGS3+XUav6Jv24nr7I+6uU+hDKQz4wKP4ho5mArbOKlS6PPDKaRa1OSzZW2ST1gosr8W0fNtdLp1Hdn8nGG6EHY0dW1nJv6/j6vt8IzW/TuVxxyh6085rpxOddt0XX38MeVwCR3Mb3tP/DTcF108thE9EdbeIplAEE60eht1QYnU3bAozUIwBLacG4ZCzovkzYBdy9cH0Pgz6PAHA==
Received: from DUZPR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::12) by AS8PR10MB7548.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 10:03:04 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::40) by DUZPR01CA0010.outlook.office365.com
 (2603:10a6:10:3c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 10:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 10:03:03 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 12:03:00 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 12:03:00 +0200
Message-ID: <bffea54f-d8b1-4043-8f5a-81ecac16be2e@de.bosch.com>
Date: Thu, 15 Aug 2024 12:02:48 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, "Miguel
 Ojeda" <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, "Wedson
 Almeida Filho" <wedsonaf@gmail.com>
CC: Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
 <20240815074519.2684107-3-nmi@metaspace.dk>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240815074519.2684107-3-nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|AS8PR10MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 092af08e-5ae6-43f6-d749-08dcbd1173db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWE2blZEM1B1WUtLMEdDWWlMb0xrVUNocTEzRitObmY4TWsyc01XY1JYcEJw?=
 =?utf-8?B?Y1FoaHFMdDlmQ1lnTTVLNDR4NGJzMEtDUDZpOEVDcFl4K2VaZS9qSDRVVG1U?=
 =?utf-8?B?YzRoMmZvZzFRTy9wZ1Q0TGtTWVpwRHpyZHRHWHJSUDV5c3JQdGVhYjR0SXh3?=
 =?utf-8?B?cmZpWnVua3d3WVhzNHdoMy9IN0VxRVR3RWprUHNORXdlNkE1dUxIR2xCZy91?=
 =?utf-8?B?R1NnamNKWW9hclBNeVc3RVNGT2Z4V2dFZUFkQWlMQVBiTy9FSnhDRDNnbG1E?=
 =?utf-8?B?SEJ6RndwVWtPSGMrTVlaaWRPN2luOUZ4R3paNnRRUHRSUC82V1NKcnBBaC9Z?=
 =?utf-8?B?ZEppSGwxZjZzT0RCV3lNZlo5ZHhIZVJjN1laY2xsZ05idnhRemxvdlRJZXQw?=
 =?utf-8?B?ZDRtcnZTa2tuQWdWN1dpL0JOa0tDR1Zoa3AvOHVodllGbENBeCtCdXZGVnR0?=
 =?utf-8?B?RmpQRW9VU2svZVFRbGcvaXRaNVhYcW9aWWR2UjAzL1RDcHBOKzJFSGJwY0RW?=
 =?utf-8?B?dmpuQjBQNjdVTHRzV1NhTklxYUphODJBTk1ER0dxSFJQZnhxdmx3TU81ejM1?=
 =?utf-8?B?dk5xdjJ6UGJXZmd1YTcvYVFBaElpb3J2dDVXWUtXb2J1ZFVNc3V5bTc4c3F4?=
 =?utf-8?B?MkhNS2RscE1aczkweXpxK01VV0RtOGZRbU5RUGl2STIrbWkrRXhiL2pzWVBL?=
 =?utf-8?B?SGlsQmMrOHdHWVk1VldhQnloQkhKbC9FeVE2QmN6enFXdGx2ZWlXK0cxTW5I?=
 =?utf-8?B?NDdUVWVxQjU3VGQzRVVUcUROTGxLSHhBVlBXRlY3bHFyUkZQV2h3VDNuQWtM?=
 =?utf-8?B?azJFc1VYRmx2S2RwNXVpbi96TGhwNjdjYzNDUFM0TjcrazcwVHhQbmE0ZmZE?=
 =?utf-8?B?K3BhYTltNzNzdnU4TFZ3cFI3VTllZW51Y2oxdnp0V0RVbTJ3OStXWXVUQjVq?=
 =?utf-8?B?UXFGRVZGaXBsOWRuZzZPcGZwZS9JeG15aUtUYlRvZkl5RXdJVm0wUHkyTXU5?=
 =?utf-8?B?blpLd1haQTh1bXRIejdTZmNRakFQR29oMkRsYjk2WlFwMGFDQ2RvVWt1dVNS?=
 =?utf-8?B?eVlDSE03RmlXemtrYVphazhwOW41YVNvYlRJUFkyYzczcjFjcEVvSE40U3dS?=
 =?utf-8?B?dkQwbFlEei94RHZKR1ZBV1NpRDNOTkhHTkdsSDlhdkwzeDMxVkJPQkdUY1pT?=
 =?utf-8?B?QzFHbVJMeTE1QktpNjJjOEgyeWZRWnFnUlZOaEMxbi9VaWpDbk5jdko2OUdN?=
 =?utf-8?B?ZVppQTdsSkRESzFVdVJsQVBsTTJOQzlPZkNubG9QZEFpYnZ0ZS9FaDZERWcw?=
 =?utf-8?B?R2xwSE9mL2VkTFdkM1ZvQ2tsMUlXZEhJQ2daNlhQOWFOalRmWHVrRjgrbis4?=
 =?utf-8?B?K0N2NU9DLzExRG5zOGR3NHJ0S0RxUlJMeGVGOGIrRzMxYVNXK2lDTTRYaVMw?=
 =?utf-8?B?L3ZTNzVxeGNpZy9QR1BQVUUwYnZrTTFpM0hjbVJ1UzZrTDQ4ZENvSGltcUR5?=
 =?utf-8?B?b1RPS1N6ZTBZMDAxUnMvQW4ydTVFTkFKUFVBR1pSY20zMFVwL2RGSCtLRFlE?=
 =?utf-8?B?ZThoajQ2cERJbFlEM1NtM2xLVjI4QisvY0Z5V1BwcVBvb0lGVDFBQm5ybFlh?=
 =?utf-8?B?ejRlYWxlQk42SXRheUlmRUxiSjJLTXFoMDZnZTFxOVYvYzlVbXloWTZsc0FS?=
 =?utf-8?B?bTVPMGtHZTgvMVQ4WXhWMWVMMW5tUnhmbkxISTZxSzBTU3JtM2RSNFlrdmNn?=
 =?utf-8?B?NlRkTjgraXU2K1A1Y0RXNzF2cUJzQnNVREhWaldXTGdqd29Nc3dZQ2FNNHd4?=
 =?utf-8?B?VGRGckFZSHlTTE45S3hTV0J2eVp0VFIycmJBUmZsOXBrenZ4bnRHcWZMNERu?=
 =?utf-8?Q?K1z9u/osIGyZA?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 10:03:03.4555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092af08e-5ae6-43f6-d749-08dcbd1173db
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7548

On 15.08.2024 09:49, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic lock
> class key without registering the key. This is incorrect use of the API,
> which causes a `WARN` trace. This patch fixes the issue by using a static
> lock class key, which is more appropriate for the situation anyway.
> 
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
> Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20lock.20warning
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Many thanks! :)

Dirk

> ---
>   rust/kernel/block/mq/gen_disk.rs | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
> index f548a6199847..dbe560b09953 100644
> --- a/rust/kernel/block/mq/gen_disk.rs
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -6,7 +6,7 @@
>   //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>   
>   use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
> -use crate::error;
> +use crate::{error, static_lock_class};
>   use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
>   use core::fmt::{self, Write};
>   
> @@ -93,8 +93,6 @@ pub fn build<T: Operations>(
>           name: fmt::Arguments<'_>,
>           tagset: Arc<TagSet<T>>,
>       ) -> Result<GenDisk<T>> {
> -        let lock_class_key = crate::sync::LockClassKey::new();
> -
>           // SAFETY: `bindings::queue_limits` contain only fields that are valid when zeroed.
>           let mut lim: bindings::queue_limits = unsafe { core::mem::zeroed() };
>   
> @@ -110,7 +108,7 @@ pub fn build<T: Operations>(
>                   tagset.raw_tag_set(),
>                   &mut lim,
>                   core::ptr::null_mut(),
> -                lock_class_key.as_ptr(),
> +                static_lock_class!().as_ptr(),
>               )
>           })?;
>   

-- 
======================================================================
Dirk Behme                      Robert Bosch Car Multimedia GmbH
                                 CM/ESO2
Phone: +49 5121 49-3274         Dirk Behme
Fax:   +49 711 811 5053274      PO Box 77 77 77
mailto:dirk.behme@de.bosch.com  D-31132 Hildesheim - Germany

Bosch Group, Car Multimedia (CM)
              Engineering SW Operating Systems 2 (ESO2)

Robert Bosch Car Multimedia GmbH - Ein Unternehmen der Bosch Gruppe
Sitz: Hildesheim
Registergericht: Amtsgericht Hildesheim HRB 201334
Aufsichtsratsvorsitzender: Dr. Dirk Hoheisel
Geschäftsführung: Dr. Steffen Berns;
                   Dr. Sven Ost, Jörg Pollak, Dr. Walter Schirm
======================================================================

