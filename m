Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020136.outbound.protection.outlook.com [52.101.196.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9837DEAD;
	Tue, 23 Jun 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222653; cv=fail; b=V+Mf4sDs4oFaRmMgUzyygrKW2efSgD7vvkqcJrpZC5uGI+VYqr4p7XgwXiJWd7GftXkqIGuTQiIb9y3GYyqMRFdqL52TK33jY4ExaWttjcitDylgstwy7jQgFlo3vJLNx/NcEc70GHlehk10rJEttNhSEIWfK6jy7M4Ela489Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222653; c=relaxed/simple;
	bh=07sen1W/TlKLQny+KVHFraiYSA0Up3uX9s6hN7ucKng=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=l2t3JftA8Dk2E57b9pRpJFX2vQfPmQgPKrQq0s5N0/wHW2AwcPYhrzACIAvRZFLWF8HEjCpXVXeCeKIkbW4ufbtIj4kKik5NJNBJ2frcv/eM1jS4JVfsOXi+SOwROwe28tIsF0jcPg5u7q8l8InlpP//da8FSZpg/0NZko8vJ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=TxYWVlA6; arc=fail smtp.client-ip=52.101.196.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="TxYWVlA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h51aEdfqPabx5zV4OrHWnqUUntah6wm6/gfiIBpD2+QIkpyNabw8ujXixSFucV40xiDJwB0TOpna/BdZ8K/hh+LdccPaDTSkyc6ptQCTvzFj3zWyR7Dy7V1X7+KZBEYBN/FcxVaGW7eOL8rkP7ZVPEt6hN8y9kg3KFSS27W4P73QokaSvx4UfJRp4kJ8vRvalSeiDJa0lvarJvaQvivwn5wwIEQMI4/WZcIRIqU6ZN5VevoWz5HA0G0XZ+GyJ67dIMGBdyp79rtoo4Ird+BJ8qjBU7Sdj5omsVyfGqUy5At7BpZquOHuwF+7CZiOkTvBWtuvgvHzoWvWQSRGvLQ61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=897EG5z7QjY7m2VO4c8EcKsefsAlzKVNLjRwrcOl8W4=;
 b=ZuC2mCmhFHKCgoFep+fvYSLbrP3TfAI1XbDKgpSu+fFOge4B7o33GFX4gSwALb0uh/IpIb4TCbyAFShsxcCzNxYW6FPyRg1b0LQabMmMiWvxNnMLf/7HH4m+XSBfr8BNqhkYiTAi5flee9uGD8o9UZ0jHiy8gy9XYosmZPRgeac4oNz87XgqBDA6x1e/b14tdKJw96LQB3kD7H356Uw0bdDsw2vCOyoFdsUPyJkwLutt5GGuWD2DqPs/gGsb5PmGU57KOIkh5ucl9G5SNG4yLlTo2kGYiAtGdhTC9bbnXuiDu4UBgAmKMbVINZ4BBrpWZXnZBMviIcLfKAmXlXTRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=897EG5z7QjY7m2VO4c8EcKsefsAlzKVNLjRwrcOl8W4=;
 b=TxYWVlA6yhlzbFoArKixzY7kYPJprpqZEnlSy1ysbHt+4cOpujy6hPbG6Z+G652NlC+LCteuf4mNE0yY2+GTPTJp/OYcMqcJ+f5Sr2iyB3wiRaU6/uPGlLdpn4MlWPZn+Vl8HfG4EFxv4jn0bCGNUQ/IPMhY+w70wHRKWIRfQLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOCP265MB8595.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.21; Tue, 23 Jun
 2026 13:50:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:50:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:50:48 +0100
Message-Id: <DJGH79NKOPA0.1RT0GFME23V1C@garyguo.net>
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
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] rust: macros: auto-insert OwnerModule in
 #[vtable]
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260623-fix-fops-owner-v4-0-0daf5f077d5c@linux.dev>
 <20260623-fix-fops-owner-v4-4-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-4-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOCP265MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 170700e4-3dcf-42ee-98aa-08ded12e6e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|921020|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z79+XGRczmGC4A+OY2kyTEOwEoxjMKHrZejQZtWGSq1c7FKVey9oMNV+PiALgIcrRpSN44HmbNcISTiwQV1yxtLdMTv0od4hn9UAL/Gs2ZMMpYUZR37O0tfhrD/ku4nweqSDu+rmCbs7NtcDq1ZTQLLwxDyiTuQBRcjh8/99AOjaxC6GAOXIpqL7VdWmWYPoDBA63Kf/L79oI6Gv4NjnT+gGbL1NoPpy7zwiWcURj/GjkFBDR1RV0mguST+zK07kLy4idbiuIohhsOet1jhWvg6E5bq03BZ/oS2iofErRTK5XJFOySXhZ5H8wvPv322BWyVRV8aayQMGJPF86dqmtS5r6tYUYmlkLz57oopuOUFHUbantXAzeF3lWT+avknumr8qQUXfzftqz4QJwFUW7aHcrKYG/ym+wslHTBytR/ULFkUdU0boH6PjQE8JDJZJFpx+1GaKOS5Aj3U65U7jil1bX9m8n99YxyV6QiUKMa2QLi9iEcC5aErwOmOsBtnplv7v0LeNtVTRy8sbQx1sX0OZX8bKlBeI0b3hkSbKO+uH6sdXmK2opZlqS88pc96bPXS6p8ev3d0Xw2PwW3QbcGHu/rzzzYiuiQ8fN7jtLcuESZl01tNFg6OutgyZAI2bXKZnoT6F76bq7mMr546K5WD3MFgUk8tiKBWSYikbwoU/r1erARZSDYPPhvbEZ0sTg0GhEXvORpo7G0AWrqjv9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(921020)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUFtOHd6aURQbDkrbzZNWGtpV2tjK0FoOWQ0OEJqMDNtUTVqRzZ5U3ROZDYr?=
 =?utf-8?B?TDVnMzhEWEVnb0t2bUEvcFMwQlVGdUU5WW9JcDN1Yk4wcEV5eDdaZ054MW9k?=
 =?utf-8?B?Qkx4a3JtYzF3K3FLS0o4ZGtKUUFlYTZtOGJDcHlPYkYwT2V2MWVEZTVEcUZD?=
 =?utf-8?B?bHA1MFN1YWJWSjJ2dE9uRXl2UGQ0LzlxTSswM2lVc1B2L0VpZ2tsdmRvbTc5?=
 =?utf-8?B?bjdPbDE5aG0vaHVUSm4zTzNjVXMzdE04cVpJTzJrRmhrQng3V2VkZklmNkt0?=
 =?utf-8?B?Y1RqMkFVaWNPbE9QdXp2enVBWmdJcmthS0xHUEVIUmFyMnlhQnloWnEyMm1u?=
 =?utf-8?B?Qm12R3BYaUZPY2pXNkNQTGZTNXZuS1JoUisrcGlVa0FsdE81M3NuanFKRGpu?=
 =?utf-8?B?YStuK3dGdkV5RDd2d1l4eHhTWFY5cHl4eUNJMFg5MDBTSG9TVWlsNXJuK20x?=
 =?utf-8?B?c1JOUTRBMXNoNldkbjVLS1BqSjArMXVlZ2ZTek5BbXJiVHorU0x3SkpzNy9G?=
 =?utf-8?B?RHJjdFo5Q2lRNmlNb0lwanlTaWhrQlE4OHRNdkZiQ29ld092bVFaTC9jV2Z4?=
 =?utf-8?B?OTVmMmJGS0xnWjJGRGE2YjA5NWFsMVU4eCtEMncxTzJ5andNSmhXMnN6QWVJ?=
 =?utf-8?B?VmgrdjlXK0tiSXhYL3R5RUY4YS8yQTNQbjBtYkErYzNUOUVIWklzTElBMDJY?=
 =?utf-8?B?MHVSdUdkQTBtM0d2eEdqbi9mVk02Rlduc09VTzNWaHFpUEszTEliZUZkb1RU?=
 =?utf-8?B?eUtuNjJvSkRxNkJuZEJ3YmQxM004UkdkYmpIUng4cktUd0xUNmRyM3ZZTFlU?=
 =?utf-8?B?NFU3bVYvMEowK0tnYk9XUGsvaGdSd0hpeVk3SVdoc2I4SGNldC9IQ2RvNFBR?=
 =?utf-8?B?TGRXNURVZnkxa0tmNUNiYjVLTEFrTlhoYW4rRUJhV1lyTElpWmIxU09TNkZD?=
 =?utf-8?B?dVh0dXVxb0hrM0lTN2Z0L29FN0hXMmYzU00wMVlSTm02bXNjSlZHdjEvaHJK?=
 =?utf-8?B?b2ZmWTEzeEhTTVpIS3VKMjlWSEZVWFRoT0tNY0pVcEtwbDBmTEFnU2FXK09j?=
 =?utf-8?B?dk9SZVhxVzQ5NFFiZ2dVaXY2dzE2R0o2QWFpVzQyYzRqNlJHa3llMnJrcnBY?=
 =?utf-8?B?bVo4eE1YV0hqZldmOHVkQ25NcWI2WHQ1Z1ZxMCt1OVI1VmF0WHozUmVZTUFo?=
 =?utf-8?B?Si85NE5XRWcxcEsySVNzenZFRzJnNlF0MUI2T3dRS1JTSk5uZS80S3p3MHFQ?=
 =?utf-8?B?eWRLbXNsNnpGeERXckFOdGdRbEtpNXpIQ1M3KzlLVDBaT1ppdFdkQjZMcktN?=
 =?utf-8?B?aFZER2ZkVG5NbVVYK2p3eWtrL0xveVdwS2IwZ2wvUXhVUUF6ZDBwcmJvK2F4?=
 =?utf-8?B?bDg5RUU3Vm0yMFJPYUY2UGgvRkFkMkZhV2pxMVhuNm9jeld3NTVDeXBLRkFB?=
 =?utf-8?B?cWFadzFMc0FBOTVGb3djWkNhRVRxRUFDbmNxTVBLZjA2bllEcXRJbjAyREtN?=
 =?utf-8?B?MU9ndTZYTGozdGZaZVFTNEplSElzcFNXZERvY044RkpMZXdLdXU1T0FlN0xW?=
 =?utf-8?B?b1ZPQnlXTHk5Q09yYS9YWHhaMk95TTAxM2NRZGhiK1Q1MjBxOVFDUWVESHFT?=
 =?utf-8?B?UUIzdURaYjBqRzdPQ2p1MTdDcVk0cTJoQ1FDUm1TRWNMR3ZPVW5JbkxpOVBJ?=
 =?utf-8?B?Q25iT0dmbHVyYllVV1Vkdm9iQjlJbzNEWWZ3eDlmUjA4UjhUVXh5RU9WcVQv?=
 =?utf-8?B?TEN5Q2xwRjJhOHNZY3phUUNlZnFCempYUnpWY3ZhRCtvWHZNczU5TVZaZDhs?=
 =?utf-8?B?Sk1KaVRadlFuMEpTRTNyakZJMjJRN0ZkOFBVaXhucHlXNXE3ejBMMU5TZXdt?=
 =?utf-8?B?VFVxeTFlcDJRNkxnS0k4cGpTMXA3aXRuSUNEemhjRmxnalhVaE1zeTczcmox?=
 =?utf-8?B?OHJBaS8vSVpjTHJzbUdtTkN4b1JpTFNEaENKY1JSWHB3dUw3bUJGSmJmMi9X?=
 =?utf-8?B?VUgvaFJxUEpwTmZoTTcvanltZkNUUktvdHgvZUV4SWF1eUpROHZtNEFrV05k?=
 =?utf-8?B?RGIrQ1U5RDZZbXREYXRwU29lU3had0pqZnFvOWdJOTNycGE3a0Rpd1ZibDJO?=
 =?utf-8?B?cEhidVY3a01DY2ZrNitiVWxsUisxc2xKSm5ZWUVIK2ROakhqZ1E3dnhzRVR0?=
 =?utf-8?B?R2Q0dE80MTBESWMvQU56cGdteFdsWjF5eks4Smt2a09ISkI0b2QreHNOaFVz?=
 =?utf-8?B?Sy9RSmh0ZU9FZWxjdkJGSHNFWTdTN2I1M3ZuRFcybmFiWHN0Zm9XclZNRk9X?=
 =?utf-8?B?aXJkQkhWRkpoZWhBZ0JqbDFPTXNlMmJnejNvTm9EMER3VnlQOXhBQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 170700e4-3dcf-42ee-98aa-08ded12e6e98
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:50:48.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hAqg9d5ce/LxZxrLqDZYdOftzJu41m0rKyFrr8SxpkQB5d2GP2hsn71Ue0hZFojtVCr3+jlwl/fS+STMPj/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOCP265MB8595

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
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

