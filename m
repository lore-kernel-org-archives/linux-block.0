Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020074.outbound.protection.outlook.com [52.101.196.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559242C0296;
	Fri, 23 Jan 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188954; cv=fail; b=b24f7zqeZsGBE/H83G4GI1HSA5gOWnsptB85hYoqgWB3m1ZR3hI4Fabs1B36KgtH2G7ele+Ydo9Pvb5H4Y+dXdyC03YUrZcJkLFr56NqfZf9Mxr9jTcKVxp+P8nyGX+l9ScL8jVx2z0hzZp+6hkpazsvQRmVloC6zWLQHfpeL+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188954; c=relaxed/simple;
	bh=RiR+dtcySHSs5BTx9JOWwt3CfWc0eKulM/83HGJgd2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNgoYRseD0OaC/EPs/EWNvz7WaGsZb21Ehjc0Ac62uAopHLpvUwkVqrA+GI9NLj/zP19GWs2IgQSGJwiCbuQ9GJpVBTZcjy0+aqrjDeaHXhKPlxtAL5FACwiQ7KAXlWaHPf3YzIzGst0bZ9RhPXrKhQ2QxbrJg+c34YKSXaOC38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=X2t1EkVp; arc=fail smtp.client-ip=52.101.196.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="X2t1EkVp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPX+5OtGbdi+eb0pmTFQw2E8D2xAhb+aOSlvtldnijiW7GO0yyTgiTTXqARUqgUiZ0bjKjxOQkA7jNz+dLoQvXj4Epk+K0gOUyaaoTUnEsk1//d5F22a+LUza/BjEdGjfxCXlktJbhlzXncHVe3yDoEO2nP9vxQrrd/yc1Z/pACEHkGS8z53InFeQzTV4nYGF5UeBbnGFN4kQtUQ3xdRRIbtY0DuRhLZrgTtnRUDZKRK5I/C/4MLsG4rw7r4sL9tGSYcGJIU8PcxzVymJjSevY13i4FpjboEVQwNug4kDpo2yokBcNk5/2txaxG2hyLIU0/QY23YORiVsqZ9d8XkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuXBvg0fEn+8/RIag1lZLw2U6tvVBwr8jf6pU9Jghuc=;
 b=b0PZ5vas0eYkrS3SmHpi3v0U4n4FUoSutlKxkFEHiZtwCiQ9xoj/Y2UJ+Ji7m28xAkUhlc5+hiWJitG8wYCMvXxS8vHcUonDI+eqaVjAINwY/rXNVNgZWxQk0KgPTMaDYtk7Y39O6iobgVWcgEPPkgKPYcj1D0bhK2Vd2vbZb5UZF/vBkj3JdDDGS4KXFQj6Ti4UAW6gX0Ab3HU9XtnV4v0r1atgoo5NjoyltiZZO9yfo40tVWQQGWrWX6F792zPvspBp67eZrDVXGepI7SmkzozNxNm5TYzL3Kx89jQ8eOuQ4TDfD7G0LpEi9VuNpxLfxkif95LKNK1qovsVsWZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuXBvg0fEn+8/RIag1lZLw2U6tvVBwr8jf6pU9Jghuc=;
 b=X2t1EkVpEmO0tImxLOnKfCFE1LanBM7ujxlLszB/uCK6rynx7CWYAvRityRAXCiibdC4W/pEvMdaAs2GPD5hVtiZnUXJJPDo46XXmPfNfdF4irBwj01tnxUjzuosTTyfoeAF+PLirp0KCBm6XGDFimVecsJIDz4mSzdOaU4VbTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7833.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:39f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:22:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 17:22:29 +0000
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] block: rnull: remove imports available via prelude
Date: Fri, 23 Jan 2026 17:19:41 +0000
Message-ID: <20260123172007.136873-3-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260123172007.136873-1-gary@garyguo.net>
References: <20260123172007.136873-1-gary@garyguo.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e867eb-ed28-4765-bf90-08de5aa3fbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMpT9gWHHc5FXjTAjHR+dnoSnuOuuvj9OiDlnEgedt0nuBQ8/sr36LAvFy6Z?=
 =?us-ascii?Q?fuOGsdsHrpp+9WY7LYSrBy8hgxiJQiHNUtEkc7x6mtQpZrEHB1ra8QA7cv4H?=
 =?us-ascii?Q?5Rdu/XlzHnmLAP9K1N0beZTpsiwq5lC0s07RzEkZATOoVT986GWN2ErKJfGk?=
 =?us-ascii?Q?6c5M+GWBr3Al1fqPVAvixJzK7lWzVgSJZk3LGZlXtlfPiMNJ8dpnwSzd0sue?=
 =?us-ascii?Q?55rGPEl8AScVifdcrMNkjB9t/lVlXPIrrnOME8onh6HfQrg9QrzQ5KBPXDBH?=
 =?us-ascii?Q?ZNYgTfmsPweBLoqJoGVLSoa+8aw/qwSmniWVIm580XwFVl93DWuEJ27w/tVo?=
 =?us-ascii?Q?dLZpAbaKDxyzDPIYGaaXl39YRGrAsk1YHEpTA+mIYQRXk1V6FRwoSdFalC8H?=
 =?us-ascii?Q?pAwVq57w9dYhTOb6LLfXrFIlplJNc35WmLc2MGvNK1MgYkkQxTEV3uC/W8Y6?=
 =?us-ascii?Q?i0SBg3ydsCAB4cRCkP8fwbmpxygOTaYL6zNj+vW55un19rqU2PoErYmllDZn?=
 =?us-ascii?Q?JPPmRj6ySoS6HB15KWjsip9LqN4oCGOCAKIu37lqxBQOiqm0pLaNPoAjzKBb?=
 =?us-ascii?Q?IZGOwFsBxn70R/eahh3uvQl/bOFT2YcE/MpaJTsJ47U1tFsWgZqHcvaQdcrB?=
 =?us-ascii?Q?3ZuLcuNhqE+RDS3WIieRGqUEKnuA0685nW2QRUiwz3TKr81dj+awYwnXDUTy?=
 =?us-ascii?Q?gr7ncpdTvseHEy0gAHPSIdhxgg2xmC77dWiQ/qb4t00ITMXX9GQrob7ZYsRv?=
 =?us-ascii?Q?EC/mX6hMs5/NczB0nr2c3+wHI2OP8FRgKD2uUtly3vixQWoYVLN4U0wtUWYq?=
 =?us-ascii?Q?7JlMUdJkTbbcTKX6qSWmA61T7X3suSS4zjjUg3ib2VaaeDsl6/etaSagBzKm?=
 =?us-ascii?Q?uuihVnw/dT1TlG1sqaml+ZnxadV9mAu+FSve4j3m3uXht0uUANsaQ8yElVkb?=
 =?us-ascii?Q?0zaBEau4z4TwGsZ/mcUFhJETfXp7sTubQ3FyxVhbq8lTCSqC6wPq0W72Eg8b?=
 =?us-ascii?Q?T1qgUBx5s3cBiNByygMbNweaRa58p2DQJVUT4Jub5z5gYeqCyL6YLWJkaAd3?=
 =?us-ascii?Q?UH0q5poGUalptABv9A1hxaxOle5s3Hig+0srzyZgYNZXrt8VoO2fYW4Cz5Pp?=
 =?us-ascii?Q?Rut4s5DtmZ11/x24VrBPwDwDhDFLFHTMA8wD9TiKhKF2VxHhYF2ziOBB3p8R?=
 =?us-ascii?Q?IJgA+1OtHYEChe1ZwXQJx3c06Spo3bqcrYLwW9zKzZP8DFPZxBcYJpg+QZ3l?=
 =?us-ascii?Q?TGuwIFOxkHIvTEeooxsNO92HcQgtt7+KIdXJP8RQzO/YtQ+RCOFkUq7W0W0L?=
 =?us-ascii?Q?xuuk8KRrfQYOnzXveUry5bt4mPR/qikMe/Zd1XavIA6BBQrPxpvOZGRY/YmH?=
 =?us-ascii?Q?2mKl12Mh4K5fd5LZ18Fcgvm3Buq7jAV0nVHFc9eD/C9JC5HcTyWkP2AYWHib?=
 =?us-ascii?Q?FWZk2VYwh4RUcp17GGVNutWFWV7mUzKiXHglzFTpeelj1P5QnwM93Cb38hxR?=
 =?us-ascii?Q?fr+SvrnQANzmNxmdSAyxuEus0dSmhYrdzAmOPXOScKrvMWfmn7fKIczmN6VD?=
 =?us-ascii?Q?L7s3iUDshh4Gnx4PNQW7n/cDIxDlTLcU6SRu+g8GKgKRBb0BMFaZ8V2j8ef9?=
 =?us-ascii?Q?jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?56z7VduYmf6EXZZ/KGN1hk9zU3PF+Zp7+n8fB4ofvAIU7ycuKhv5X0E9l5d+?=
 =?us-ascii?Q?W4coXFSUYJ+oplguR3UV0ox7l61qlPvAsCPVEicAhcAJnQUmVmzM2ChALO/0?=
 =?us-ascii?Q?Rt4Mw3EYKKfPQYcnqXlLKBe63sJZBAZx+CsXcGbk92p7NyzaN0XeKXDFMmpq?=
 =?us-ascii?Q?CaDlaivcqAViUNo2e7fUoVd923ng0/kSUboaErSQiEnNRj3IhkFdst/mBqbZ?=
 =?us-ascii?Q?7sjAvdHvZMOJTSyyS4UdhsmuSbG7vGXSpH2Djv9SYViYgBBmB9OB1MQ5v9vt?=
 =?us-ascii?Q?yh0OnR1kB5IDUFSIKXEs64biEBw4wG7KGRxBqd6VM+fRe6j6m/mDmLge648b?=
 =?us-ascii?Q?ZEx38laeAEgaJ8VFGHEWxnKssgw50FBqy0TqyVVqFmlmwsCX2hb1JQ74cCaC?=
 =?us-ascii?Q?6saEK9OfsplKVKIjkjBSG77LhE32GoAT0iAPlonb7fYw9Z/HkU+wG9vYEuFs?=
 =?us-ascii?Q?ZJUbbSVqSKUyFhqJCKj/6bnJpBUIBP5pcbE4aHm1JaOMIvBKShT2YP6cbZa8?=
 =?us-ascii?Q?7ra9IM4Moz+jo3eSVZvMbNvdUjRmAyvYV7xXPQP3M2PYsRWi6ibu+WLdN9QW?=
 =?us-ascii?Q?mIOUCJ+7eGrWzEk6nZY4zOfHUcC0C37mQ13CWOpLSu8RyQj3FXkexiysVZcM?=
 =?us-ascii?Q?aqnTvtNWbcB4ynflnzfPtUWBeq2ucf6EnTQM7p06S+ZqvYV08HbdMEtMci6p?=
 =?us-ascii?Q?kSGmpV8+hqfXPUjyjXzLt1TLvr1lpiJFNX2PA/HqKqPE2W3Qx85TW4W6EuaI?=
 =?us-ascii?Q?1XNfZyYWIKxA/aCVFWksA2GVkCPlWNOfONpPFR7FUwQLECm1tzQ1re6bLkjh?=
 =?us-ascii?Q?9NnjARVXpUcyIEzjnSJxKCgQA3nOG7zi6/oNqZ6QGvTiRFJxWM63Jbtgjkyd?=
 =?us-ascii?Q?tkLMaQAstEh3/NiBmTSzxqXserF3jcBJcph0oRUaUNYTROshaGyBJk1qSxAs?=
 =?us-ascii?Q?S7A6/uknNO9TpK4y3fHSdK6mPlKJaaDUAZ+r5NyDCinyPTyWdg8HWw6cLKI6?=
 =?us-ascii?Q?497JpZN9wazhRKZdjPuPI9UVsBW9L6pSAY33i4KeWLFOSciVpWftd6ZqyacL?=
 =?us-ascii?Q?VL5j49+ldE8kseFXQSApiKXpIOUWQ6fxOp/0Vtv2fSrcpwqOjp3VYfaE0FXG?=
 =?us-ascii?Q?DPE5x/C1gggrtr9mP19Xm/u+pcdY/41BWxsJUrCLAoko9Gw4gNAHktX63M7n?=
 =?us-ascii?Q?TqPTxTVHHr5nvX0G0ZFNbav+Y6QpskonvKwjpJUX3rrsC7lz+grDIP1EtXKT?=
 =?us-ascii?Q?JPMqQVwkXdF2f+0E/fB+hidwL8B5/9xYMk8oee+0KGsSoZghr3UB7ASZm1uD?=
 =?us-ascii?Q?djtvabMtg+unJLEl2gM5EtMcKXYpcI9TYXUKpuB8zlv3Fy4dDPRcnpwjsu4q?=
 =?us-ascii?Q?4aFcTHTu1B2y+99gw2QiOdl3pcmT0D4JLi538usCBIeEFOXqvFEJje+Xb5nW?=
 =?us-ascii?Q?yHgmJIiUNo7c+g3PewjkgOq72WAvZkltXRjkYb6RhCjJviSVkA6RWFaeZrMD?=
 =?us-ascii?Q?2tYwpl3Ma5vdX6JKZAPrB0oFep2aATq2qXWNdrTqcznAbtauQ/DJGc8i6a5t?=
 =?us-ascii?Q?avq1jXJLOMs5IHLvo1VS8jrxslGEUAUuiV7b+nqPUqf16AYRLgh6lCTGWNX2?=
 =?us-ascii?Q?OAoLwz4XfKRjvGiWHZz8tvwoq+0rh+CQGiwpQSsSrPuEcAhPCwjV72tV6LD/?=
 =?us-ascii?Q?Wbhun4t6zkDQN1a+RjgNuLt4hgrk/oehDFv+6y+St4/5hX3tZJ8M8hwurwMn?=
 =?us-ascii?Q?Y+IdiHA6jFW+1JxtTv2xjhhN+Bb3Yk0=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e867eb-ed28-4765-bf90-08de5aa3fbc7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:22:28.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYrHGwu72Xx6XjISZvDj3g+cUEQLqs9GKyqQYHC4AY/9Nw7+a0qNEByP/Wt4tNxb4EOoXYLWwfb2GChqYoTeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7833

These imports are already in scope by importing `kernel::prelude::*` and
does not need to be imported separately.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/block/rnull/configfs.rs | 1 -
 drivers/block/rnull/rnull.rs    | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index bfe998d31eb9..7c2eb5c0b722 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -12,7 +12,6 @@
     str::{kstrtobool_bytes, CString},
     sync::Mutex,
 };
-use pin_init::PinInit;
 
 pub(crate) fn subsystem() -> impl PinInit<kernel::configfs::Subsystem<Config>, Error> {
     let item_type = configfs_attrs! {
diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index a9d5e575a2c4..0ca8715febe8 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -14,12 +14,9 @@
             Operations, TagSet,
         },
     },
-    error::Result,
-    pr_info,
     prelude::*,
     sync::{aref::ARef, Arc},
 };
-use pin_init::PinInit;
 
 module! {
     type: NullBlkModule,
-- 
2.51.2

