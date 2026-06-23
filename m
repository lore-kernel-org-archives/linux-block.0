Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020139.outbound.protection.outlook.com [52.101.196.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0C37DEB2;
	Tue, 23 Jun 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222837; cv=fail; b=tZLdyNxK3sx3mvqOn65ynW70LUT1W6V0lGpxxWAFUOARwbBwUBTIC1LrrohwJ6Mlq6m/pLp8jlBReHRxSSgDagRzjC/ehgUiEkeDzc6vDsHd5bIN96V4KmkZpIgjsnyt1Q+6Ee8WIPWcX47NO6yjf/x7XX27nu/RNdVLhTgj0uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222837; c=relaxed/simple;
	bh=nXBm6cQjZnNVAj0zPW+VjraD+FeenNV/XcxIBPbFkHw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Gga+K7yWmlMoFOgxE2uWkep6eLCsZfxr5caJ4FdFPVH5lRMbhkj4wZi7k+ygB83rHmIXPthsotLO9XISIz7BzvY87+DEYjGaQlAcarp+0uwVK8da31Z8JxcnhpUq7GWotLFobtZDrz/GU+L3I9D8t6DHja7a0p5n4hDMZB33TCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Qb3GuF8p; arc=fail smtp.client-ip=52.101.196.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Qb3GuF8p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naoRKJ0fCEYFdDlWRKYiqs4X29YFP2lt2YHAAT1Iupi7FIfx9eVTlcN37y3ZNczqBxcMUBMTbpV6mJ8JnxQdyJFOhw1WBqwvi9RZwEkrpxxjreoR5kQOi8D2MA1+46/PyP7onUUUqcxDVhbJ7/QABa9w/DWBIodHgwTfTIveuD1Tho1k3A1zKOZg1xJcCyughl8AhcKwNf6h7Ttj1SRmfXwQVTkhvzYNVSlRpKoUPohPLi5gWfBPvFynXTc568MzKdEnJM/4jq8tmLORO2HzichC6LZbo9Ddz54K2UONglUfFTtdaMkrCJGLhhwVXf+DaeM4Rw//NI5gOl76zv83Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntZ+H/jZbw6Qr7gjbdNaPlIGZcih3eFBassSF0OFppA=;
 b=Mh1sq7xZy2BGHhDlS/NNearErx7CbxP9uxFFQpVaBksUo63ziN4rYPE11kpZXe9aGbMEdK08GlFKBKoegzm8TxTLxD2wmgzavlR/uiCcApvtE+gOv/Fkj38c3PnFpqFrVEcRaVAHoT7SAcmq53jzwUR2bVUNYsbslN3r/F4d/aPF/OqKFv3R/qF8xqt7D5d3u66R6c4HgUA6vum3wv3vZS0bVYSh2d8trZ/hvjY0tZ2Wb8BP6+Ww+PFyosm+FSMLgP+fgWPFWX6y002et3RVPFNCOc6IM+eVH41P6EVvEW1yjnNWhOumr5oAMeCsE/VRhvg5llcqoDKLKS8OBqyN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntZ+H/jZbw6Qr7gjbdNaPlIGZcih3eFBassSF0OFppA=;
 b=Qb3GuF8pdzzKPb+EffVXBy/UGHTpj69hfN4gI4KubBV5Lqcf/KaUMeGH3dIYyVmiJdTk419zupf8hZpGteXyjwT/A+MFsRV0Knpi/XpauFKNqA+nK4dHD+bEjNYydPt002BaJeSHrOODv4yrWDzR7sMOjfgNhgWFtq5UG1gS1Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7950.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:53:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0139.020; Tue, 23 Jun 2026
 13:53:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 14:53:49 +0100
Message-Id: <DJGH9KZY0KTF.YC8IJ8SLC4YM@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 9/9] rust: macros: remove `THIS_MODULE` static from
 `module!`
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
 <20260623-fix-fops-owner-v4-9-0daf5f077d5c@linux.dev>
In-Reply-To: <20260623-fix-fops-owner-v4-9-0daf5f077d5c@linux.dev>
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 970ba5c3-7513-4dc6-fa7f-08ded12edac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|10070799003|1800799024|921020|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WtGUz4nXCe+cI4fITPELpdJOdOyTYdVAbSYKRUfo3m/V9oXq53/KEQgMRQnDafXIBUM1y7LJuZIIy783nnPD9G7KbnxiFvtdwGtobD4redLoB+EbYYArbTtN5nSd1n154OVwquexSfB5OQq0YKw6OOGJiF6vA5Lkz43LpheylO9QQG3t6lOgfHnXJTOSNgZnEZFmnxzOukvD0zC4oGyEOjYxxRpIue1XLHSMzKz/h59T00HwQgwLUAT/aLtGuUgFBS90VTSarYn65S8ghVbAFcqmPkKhlDfevJNepHNZDSTnYMOeXbI2eIqzWrjQ1UIMiIpkvlK/m7WHExqRiSiL/h4PueNg1QQQpZ60MYlzM+lOEzYPGtGtEz/fXsY84iU/7tDs/HSylNtsoiiLWm9XxY8Bpab6T+lBW/ApbKJcHHoTNRZgZkrC9znQICp/UBfKACp3YUHv36SaCFTaTKEJkaN/hutBVy0AFzTcPQJRrn9bq4eXSJy1kQhb0kGeYuBbSYiybIxn68w2MyHOmVqkAMhqS+0QwlnKAllYpfQm0ZcCA6nzqxaN3WjSbiFA+2d3v5xE/vZZD83ubWmm8z972p426x6DYjVg8T44/undw+aGYOiyLBdJyJEg4/Bb7bXxDtKjlorymNpZ3ulcBFddqyIM1+US+r7NhIO84byHZ3gcLKXLGdNZ/zChSeeM7tvNAODJantIIlteZCndKgH4pg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(10070799003)(1800799024)(921020)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtBMDZxWlRFeGJHVlYySmFIWUhzRzF6Y29YbjN0YkpXemNjWDNvYnVVZHVW?=
 =?utf-8?B?NFJFMWlWbWtnaXRZeTByM1JjZGkzbGt6VDJBSGdnc0JjaXBpblRqMEMrclUx?=
 =?utf-8?B?djFNMCswMUFpVjBSaFhqTkp5S3hCb1crcjBnT3JtcDBzUys1bWNZTkxnSzJM?=
 =?utf-8?B?c0NUY0hscFlDck5ZUW90azhOaHV1VEord3dJL21VSnRqckU5OVByM2paVUlx?=
 =?utf-8?B?OG1pU0c3TDJCZnE0RzFtMDNSR2RYT1J1eWNhTytWNGNQZ0JKclpVQytOb3l0?=
 =?utf-8?B?dExWWjk2RHIvTm96ZVcxTllsZmVuQjNWamxnaDNkalh0MkdiQWZyKy91M0lW?=
 =?utf-8?B?MTh1cStTNDdYQklZbnA4algwaC9JUkpVdzFTY04wKzZ2YkNKQ25xNWJIckUx?=
 =?utf-8?B?V210WUk2Z0UvMVJIR0RXanpHTmpDeDh5VFV0SnBvMUcrcFJ4eTVkU25yV1RI?=
 =?utf-8?B?RGlSdEVZNVJDQm1pMTI0UHVnTlhKT3VLQVRCbTFHWHVxRFUwM21DcDRYdlhm?=
 =?utf-8?B?RFU2c0Y0TDFvcVlETi9YYy9waGQ3S01QSm8yZGJNOXl6QlVaZy9jL0dLZWlQ?=
 =?utf-8?B?UWtsRjg4ZStrNHRlQy9ERGsrcFJhMUp5aUg4LzhDYmtPampFVERUL1hqMVJ5?=
 =?utf-8?B?aGNXMXU0dEZYY2V0Q0JTTmY3M1RzNFRuR3JxMUtabklCSDF3ZTBpM24wSjZu?=
 =?utf-8?B?Q1I1WVNZU0FqUGtrMlNWS1ByOWtzVXdTS214Z3M4eHpDd3RreWZpdGh3R2tZ?=
 =?utf-8?B?c1ZvaFJ6cUc3YVVPWVdqOElocTlDT1FQTEJ6OHdqQ29SOTVVK010QVA5VGx6?=
 =?utf-8?B?ZzRzK1cyMGMrRHBjVllldjF3THBTd1ZVNjRwTzJQdno0Y2lPcnRpTVRLRkxL?=
 =?utf-8?B?OHJFSzRBVFdWdlMzekxZMTloSVRROWY4WEpMcnpidExxeXh1eGZXRWtSdjB5?=
 =?utf-8?B?ZHF5Rzh3MVV4RlkxSkkzWFZRR25WU1NlTDViVFBZektTclZZM09wdnpSbVI3?=
 =?utf-8?B?TGVYc2I1RmJUWjd0Q3I3eG1pNGU0Sm9BYXVrVkI1V0d4VCsrY2hrSDlGSzR6?=
 =?utf-8?B?OHVRRFJrZzJuOTgxcjFwNzhUclhhbXJHdHUvNVZOUFNYc2lVN2tuUU1tMW5v?=
 =?utf-8?B?NG1ScjUySmJKMjJqd3lPa1ZNWG56SGVZN3NrRG5YOThXMVdFcGRJOXZrUXRr?=
 =?utf-8?B?WS9yZTk5VU1SaC9RbGRseng3ZWtzd2RqMi9tR1RXNUc2T045b1FBNGM3bTRV?=
 =?utf-8?B?bUZ0NDczeXZXZlNYV1RtTUxzWW13cjZWbE80T2g3SDU5aW9DVTl0VXc1SkRE?=
 =?utf-8?B?LzFyMEFYWDBHWjJTSVRZcStaUWdDaWZMRGgwUTJiTkdFRGRtRmcvaE9VNjVZ?=
 =?utf-8?B?YWdRMmlJRzU3NzRnQkxDVjhHbGVwdTBiWC9CU2Q1M2pVVjQ1UXpydno0cGtQ?=
 =?utf-8?B?eW9nclJ2Q3pwMnRuL2FhQy96Zy8wVXVpdEhWUzdCTTNlSHljVkRRbzF6Tzhw?=
 =?utf-8?B?akFNUWFodFNCZDlnZnNjM2dXMXc4N3crSy8rU1hTZU90STRwZFRDTUFONTF5?=
 =?utf-8?B?VGlHN2JNSkhldmVaZE9JODF2MTZRNjhLdXZjeTZoTm5TM04rVHFidVJqV1dw?=
 =?utf-8?B?K2duY05QeGNjcndZckpVb0xGRVg4YmxmNFdUWWFZcWgzM1hFWjEzeEh0dzdW?=
 =?utf-8?B?czlPN3NaRTBIM3dKSWNjeVRSbjhBaTg2UkxCb281NmliZE94ZjQ0dG05cDNL?=
 =?utf-8?B?MDlwR0FRV084STJxTlA4Q1lCQmJqVUIxWWhYa1cycW9aMU94ZUxOSEovdWRx?=
 =?utf-8?B?c3ROMHdnc3U3TzBSOHNVYzdiOFc2RjQ0SmY4S1p4ZHJGbmc5dlo4UDIzaUJJ?=
 =?utf-8?B?YlNWRm1FZ21VSDNKR1MrYVBsODlWVXM2aDR6SThVYTNaVGZBaUY0TWJFNmdm?=
 =?utf-8?B?aFh1MXRlL1dxNlg3WDFFd2lLOGt3dUxIcENtcGZLRDhKUWF1UXArVFFPbTEy?=
 =?utf-8?B?VGhtZERVVlZrOEJneWhNelJQaitXUHk1OHVKWUhMNU5rUGxCOWQrMUZ0TGdT?=
 =?utf-8?B?MHVwVHduMmpTZmxDeFh1blBYQkRqU1c1aDF5aU5BdmNSWHlYY3EvNmV3cFRL?=
 =?utf-8?B?Z3dHbkRSN3d6MjJJWEUwTDlFbUtWYUZUQWpaam5Ldy95NlRqUmhLYXdkelBN?=
 =?utf-8?B?UWZrM29TV1BYN0xmSFByVHU5L2wyM09vV0I4TVQwYUlNclpSM0s1d0crTk05?=
 =?utf-8?B?cksyVjZuK2pQVXBnQ2ZDYVhPN1pEN0JxYThHUWJ0S2ZmVVJzcGZqMnIrQ0Vx?=
 =?utf-8?B?MW1CVXJKUmZ1OHBFeFdkNGt1MzFXd2VhZEtydVV6WUg2Zit6bFVGQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 970ba5c3-7513-4dc6-fa7f-08ded12edac3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:53:50.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+aOxQ2/JEBMa0DPK2jyVDpvsA4qe1FtIAqjiyP0qOJB2lf0KqE1v+6labme7i+yFc0c9PK+yX1rL1XOqd/Jow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7950

On Tue Jun 23, 2026 at 7:29 AM BST, Alvin Sun wrote:
> All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
> `this_module::<LocalModule>()` helper. The `static THIS_MODULE`
> generated by the `module!` macro is no longer referenced anywhere,
> so remove it to avoid having two sources of the same `ThisModule`
> pointer.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/macros/module.rs | 16 ----------------
>  1 file changed, 16 deletions(-)

