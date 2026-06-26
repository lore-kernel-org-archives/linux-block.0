Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94893BBFC7;
	Fri, 26 Jun 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484884; cv=fail; b=Ch+NCcINv1EmA6oHX/UBV83NjVERBRnCPqJDPsQRd/cs42YVwmKRSDCJ8fdxoZu27K3QaK95vR8Zrt4C14RFyOCP+LY6NTpMShVd5FiRMgLW6FQUS01XKPMPJ1DHlYTEyyFsI7XxDoPaMZ/+KqFiHw0ptC+SGcLVSARF1ryNXVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484884; c=relaxed/simple;
	bh=Hn1KkwaX7D2t3ZoH013fLXukWte8TXPd4fMqlVbRSnY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=b+GEzVH6kuKfFIMUOWNRpS9WYiKrCkD4bCYRz2srKqYFxxt1LWwRtEwikUCFztBNPGZJzMxOBU4Ce1ksdEPn4EIMayUsbFyKG2DfxOTBAvclDi+8eTWGd+XXXXBp4+/O9YWKYxwYGeXiQ8EDvp7DOwlbiNmWI6QecLYV4XSvgqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XpudTMrM; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XpudTMrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKzrQrVSxrh+X2tb0dsTt7xWHROmWC4P0trnbWQP0CLzlPDA0YtLZMm30s5fBBrpgXUzH5VZcHGS5Zpwglp15lQ94i1KU1JggDxfjbR9vsh0v8Kl5ttGzO7gIYmo9vXWhoNlf8Fp/fee9gj9vnB6p8WrOkuRDb69GeFbfc7x1XXX447D4o8WSzA7tg/YzBXYyk3YRBKjgTaXiQqzmNaihFleiBAfQnf/WrjC4WQsAUpqxMID6fPARQ05O/hTZ9GZzAn0qe/AOfSHdwesOuxP/3U3lDbgRnrjCoow3qhra64fNPY2FuMuKv+IumfiCxCK4uYxIzQSIz9Vp9ukZ5IJ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/In0jbnny/jXUU6cRuOSSncCBRe+lWCbcL4moOM3qQ=;
 b=W00OkI4+GqKvIcEeTLoES6o9OIg5vtaTHBAnxp3TFFGHXr55XsD49wAXhelXu2X9XR8DxrfnEwXS+8G5/wucEmS3FEcyPoqHz51mgk9P6i9a1pzG3JH367ApRi/82C1SwhOyAO34X20Gee1tJwz/ZjSbC4OLezz3C+WreDhiunQsN3rWSFiwGgg4Qb6ckW8xN1ID2SfTwFvDYgb8w+oPhRh2aJdbessE23lrD5XkMTd1qtswmvwiWLIWQQQadbXWWvAFJzhqIJNnvz7uD9hiFlBAWX4lxna3qWxNayhvvZ0P5ptzg1uKFt7RygWEgiT/Ahg2s1qRb30ZQYAhzGsd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/In0jbnny/jXUU6cRuOSSncCBRe+lWCbcL4moOM3qQ=;
 b=XpudTMrMDLcjFW4p2OGQfPN2zrPX4yBwAqhWtu7FujgCLaGCJqiFjuaO618KHopIS0R3mnhO63dMbhiwLSWXCEUCFfWunqixpBamweITySXbdkR6zEjUKWtP4+0Ql461Eo+MlOzm6Mqq/WjRiUCIM8kh3hmX1xarhxgKXBD9/S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2181.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 14:41:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:41:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 15:41:16 +0100
Message-Id: <DJJ25JJ3TDO9.1UFOP60U0IPX5@garyguo.net>
Subject: Re: [PATCH v6 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
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
X-Mailer: aerc 0.21.0
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-7-5295e333cb3e@linux.dev>
 <DJI7IOXAD84M.2F6VSBY64BO62@garyguo.net>
 <34a009d9-a1f3-4347-9e92-866ec05ddb60@linux.dev>
In-Reply-To: <34a009d9-a1f3-4347-9e92-866ec05ddb60@linux.dev>
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2181:EE_
X-MS-Office365-Filtering-Correlation-Id: be4d2d70-3212-4e42-1472-08ded390fab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|10070799003|366016|18002099003|22082099003|921020|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	n1/Litt233JeXjMcKfMVO5Ik0DQYng3aPcXxHykxEQ6XPCTXmbwhTOvfQgARoGyZzL2nCGXiEPwRHGD70UbPJHCdR82GV9COBvC6lZ7Aoc0EsRKi1sehaV0Lz376SB6UmjESIyxwJ6OgeuEARQ7BNaUU5uVnVoFdZIZTVWI7Aq981GAK7PJ/SNM7CnDdlzDBns++Rb1ZAeBZQlaVbcY4RBVs3DvHBfpWA4icz7JRG5fepPYNHE6Uxtks3zYncKOhrr4UWBrG9dq5tBMdth/vLz0GGU5ls+dHu3vsxj06pynlin25OWzSfP3W+CCrPfuI51hV1OWm59RzH2HvLl4qqVkD6nFCIL3ra4bzJpALakJv5RmKHqT4ID4hfmN1WTe2DTrsIzLpfNXWgmrHf8E9CuCpJtXm1rfD6tDSxf90C9s+Be7x0WF+lO4jxaqyZlFAn3F9rF5EojBsvWcdRAYRjp9PfWp+C6m6eTvb6ZrgxRJa3gy2MnsN0sEQD6NrQu4f5LOZdYzehE89ayUJi4Ll7zWFGUGgfrmzVwaqPvJJwWYjrLB8CAow5qriwIVzS7ONbtv3cn/a2LJsZzTX3tTy7Qn8nGwPcuTWYKk64n+xPbmgYyA0KUD3qfqKIrKsblpBdV52Yrifo211ZSjr2OOfffG+ACsHvCiU0oCP31FAKsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(921020)(4143699003)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFiUzdOOFNnemJEbjA0WjBIRDNiN2FHQlV5MVVmWFNBeDRBdk42RW9pVVhs?=
 =?utf-8?B?RWNiTE1vTnJvWERIQk5uV0taSlBLaFcySzBaSkR4cVJqcDRYbmVqd2l0b0FH?=
 =?utf-8?B?MHlOb3NBOC9PVXU5c0Z0YThpVXE0TklHRUt2RTlacEJEVUp4Y212b3BWL2ww?=
 =?utf-8?B?M0Z3aVo1Nm5hZ1RBZ2tvVlBwRlhNQXE5eHYwcHNxelhSNUEvbEx6Z3lndHVo?=
 =?utf-8?B?dGtGb0pJT0ZYZnhOS0JyRGVRNCtTL3orYUQyVzNROFU5Q3BoL2ZSYUgzTlBq?=
 =?utf-8?B?ZGFYTHVNcUR5SzRXVnAzUi83eGhqdGlqUDNqYy8weS9Yb2RvMklpTlFIeTRP?=
 =?utf-8?B?QWJwT1pSUFNZTFhEcUdJUjAvRGMrRnVCVWx1SmpKY2RvdHlBRGhPRlB6RGtu?=
 =?utf-8?B?RkpxejFTaDEyblg2eFp5L3dSVjVuTzk4YStydWNtTmxzejFhM2xPOEM2Nzd5?=
 =?utf-8?B?UmZZRXhZMGRBaDBrdTBCZ3JMc01OdkJ5YjhrU0Y1RCttZlQrL2FrNWRpUUE4?=
 =?utf-8?B?ZjBrd0tQYWZyYmdBM2JDTGtUTW0rMm81WHlUb2ErdWN1Z2YwUzJvYTVzUHBt?=
 =?utf-8?B?ZGdHN3dYN1BHQnhFS2tQaDZIZ2c2Z1MzMmpHWHExR2d3U3ovcVE4WjhTc2FE?=
 =?utf-8?B?TlRDQjI3SmcvdHpQejd4ZEpmVjBEQmpYeHFHdFJESFJ0OVcvQnpJcWEzR1JP?=
 =?utf-8?B?bmc5SmRmU2RsMzhjcjhvOEg2ejMrVXVhNkdtMWNSTDRtUXl5S2VTZEl3VHds?=
 =?utf-8?B?VnR1eVVWTDFlZmIrQmFBb2NZcmdrc1Z5YWZVODRpRnZCd3F6d09SdFBCcFMy?=
 =?utf-8?B?OEhXWHlDcVpNSENvVFFSTjgwZTA0Ty9DNy9yS1dmdGZpcVNzckRIcE0vWUhj?=
 =?utf-8?B?c0Y1alJscGRhVmNTS2w0YlM4ZE1FVktCZ1lwUTdsRTNEb3VyeCsrZG9FYnMr?=
 =?utf-8?B?VGF0bXRwbDAySGFBSVVLaFlnUFU2UFd3aGxHeVRYVFBURDMxUTM5R3BTTjRH?=
 =?utf-8?B?UTRzV1Q2c3UvcFBSTWtYdGZxNHRLWjdDeTJjZVhpcFE4dmFLWnRuWTJGNUxF?=
 =?utf-8?B?SmFyditMbjliNDNINjVhWWR3RmpzcHB3SVRnOU9yY0VsUnFkOEVRMmJSVEla?=
 =?utf-8?B?S25nOEZyd2FLZ1V2c1l2OGpPZUdacjJXdktCT1Fwb2trdzZ3TnFnZVkvMWp2?=
 =?utf-8?B?WUY1S0FyQ0hWanE4amtpWGZkM083V0VUTlFoRFFaZlpxMGpiL0wwSUlUeFVH?=
 =?utf-8?B?QVlyMFVveXRQZ2NhZFhmNkEyL04yYUUwUk9aK2hzNFhJQzdWQXI3ZTdVVkQr?=
 =?utf-8?B?UlRTaFdkemdCcU9qaHhWREJiR2JaU01Na0prMWxhR24xM0VxcjJkcHBvRWhD?=
 =?utf-8?B?aEdpRElBK3VBcXNmcFhUTWFGaUxmYUVNZzU1eXFSbnZPWjNDUWlnNEdmNit6?=
 =?utf-8?B?enoyUXJpZ2wrVm00QW9wVzcxTkhBTkZYcGFxclgxTGFQL2V1eGYrNng3NEYx?=
 =?utf-8?B?NXpMS2JxSFdTRVQxeUEzUVFMakdwWE1nUVdnaGdiTjJQVnpCd2lxOHlqQXVZ?=
 =?utf-8?B?WmZiZjVlc04xNjZCZXdQa2R6SExvZmFrdUliWXJlZC85VDRocjBqUWYzMHF4?=
 =?utf-8?B?OUFkSCtObWpXOFppVldQTSt1eFptNmhLUXZadko5UkN3d1V5UnpQTG01aDk3?=
 =?utf-8?B?MFc5WnhOVW9YK3BpMXhUeFJZZVpMbm1iSTJuVDNkSGkzY3ZpWk5qZURlc1Yr?=
 =?utf-8?B?aCtSWUhyN0VsOXZlOHlGdWpxdnpSMGlONE1TYXI5U2d6eHMvYlZkQVF2WEY1?=
 =?utf-8?B?eTRUbGF6R2FNR2FvNUM2bjhkVkdxZEkrTVc3QkZ2aityeWlwcWM2QkRqSmQ1?=
 =?utf-8?B?elA2YVIvVWc0eFk3dlZTR1RRMm5FaWVBOFV2bDl6V3JOUkVFeENudDBtMnR4?=
 =?utf-8?B?ZDFHNlBndHVSTkhlbngyaVFhYk50QW5wTXdqemIwL3JKd1Z1ZkVobXJubHZD?=
 =?utf-8?B?M2xpNUNFRGVIcXFuRklzVnh5aWhUcEt1b3Rpc3kxYjlITVBDV2EvMUMrWGsw?=
 =?utf-8?B?c1NpVURRdWxTMEM0Y05odXJyWWM0ZUpaQ3J6VU1lOVhlQ1MxYlhjc1gwbmZE?=
 =?utf-8?B?MWFkNzJIV2JmU3pVcUptTnRjTWZYN2k2eXVuTnhkUlVud3hXNWtZQ080Rzht?=
 =?utf-8?B?SU5xZUxmOWR1V1hGaGF4SzhWM1hNMWZxYy9JYmVjbUMveHZaNXpidEFQdFFV?=
 =?utf-8?B?VWtIbExDZndVdDlRTUh5S0I5WXVaSkJ3UWkrTWhvN0FVSzdxU1puU0paT25N?=
 =?utf-8?B?WHFvOHFySllKSERuK3d3dzdUVjdMK3B0QWZvWkdwYkFoOE1vRnNEdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d2d70-3212-4e42-1472-08ded390fab5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:41:16.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uExMzTkpxOygcNcgL/5vaLRujOt3acoS2ACqEgdMmDJX4xISRFoNpZVOhuIPZsjUjCb3UdK1bhKVXx15yqAwdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2181

On Fri Jun 26, 2026 at 3:35 AM BST, Alvin Sun wrote:
>
> On 6/25/26 22:40, Gary Guo wrote:
>> On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
>>> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
>>> macro with `this_module::<LocalModule>()`, and update
>>> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
>>> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>>>
>>> Assisted-by: opencode:glm-5.2
>>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Acked-by: Danilo Krummrich <dakr@kernel.org>
>>> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
>>> ---
>>>   drivers/block/rnull/configfs.rs | 6 ++----
>>>   rust/kernel/configfs.rs         | 8 +++++---
>>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/conf=
igfs.rs
>>> index c10a55fc58948..b2547ad1e5ddd 100644
>>> --- a/drivers/block/rnull/configfs.rs
>>> +++ b/drivers/block/rnull/configfs.rs
>>> @@ -1,9 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0
>>>  =20
>>> -use super::{
>>> -    NullBlkDevice,
>>> -    THIS_MODULE, //
>>> -};
>>> +use super::NullBlkDevice;
>>> +use crate::LocalModule;
>>>   use kernel::{
>>>       block::mq::gen_disk::{
>>>           GenDisk,
>>> diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
>>> index 2339c6467325d..c31d7882e216d 100644
>>> --- a/rust/kernel/configfs.rs
>>> +++ b/rust/kernel/configfs.rs
>>> @@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_ty=
pe {
>>>   ///                 configfs::Subsystem<Configuration>,
>>>   ///                 Configuration
>>>   ///                 >::new_with_child_ctor::<N,Child>(
>>> -///             &THIS_MODULE,
>>> +///             ::kernel::module::this_module::<crate::LocalModule>(),
>>>   ///             &CONFIGURATION_ATTRS
>>>   ///         );
>>>   ///
>>> @@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
>>>  =20
>>>                       static [< $data:upper _TPE >] : $crate::configfs:=
:ItemType<$container, $data>  =3D
>>>                           $crate::configfs::ItemType::<$container, $dat=
a>::new::<N>(
>>> -                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
>>> +                            $crate::module::this_module::<LocalModule>=
(),
>> ^ You only changed one single place. This is still plain `LocalModule`.
>
> Initially I wrote it as `crate::LocalModule`, but clippy warned about it.=
 So
> instead of putting the crate path in the macro body, I added `use
> crate::LocalModule` in the calling file.
>
> ```
> warning: `crate` references the macro call's crate
>  =C2=A0 =C2=A0 --> rust/kernel/configfs.rs:1024:59
>  =C2=A0 =C2=A0 =C2=A0|
> 1024 | ... =C2=A0$crate::module::this_module::<crate::LocalModule>(),
>  =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^ hel=
p:=20
> to reference the macro definition's crate, use: `$crate`
>  =C2=A0 =C2=A0 =C2=A0|
>  =C2=A0 =C2=A0 =C2=A0=3D help: for further information visit=20
> https://rust-lang.github.io/rust-clippy/rust-1.94.0/index.html#crate_in_m=
acro_def
>  =C2=A0 =C2=A0 =C2=A0=3D note: `-W clippy::crate-in-macro-def` implied by=
 `-W clippy::all`
>  =C2=A0 =C2=A0 =C2=A0=3D help: to override `-W clippy::all` add=20
> `#[allow(clippy::crate_in_macro_def)]`
>
> warning: 1 warning emitted
> ```

Clippy has a point about `crate::` being usually wrong in macros, but it is=
 what
we actually want here, so obviously you should allow the warning.

It is the exact same case in `vtable` macro, just that Clippy is unable to =
check
proc macros!

Best,
Gary

>
> Alternatively, `#[allow(clippy::crate_in_macro_def)]` could be added on=20
> the macro
> definition. Would you suggest that approach?
