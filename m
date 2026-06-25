Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021093.outbound.protection.outlook.com [52.101.100.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A781F03DE;
	Thu, 25 Jun 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398277; cv=fail; b=HEbGDHhXxAATVwUrcfdpaLLq7DR/ALWMWjs2xBUfsQErnuqz7wU6MGh2xTkDoZLTG1Ytg0ZOaoAsLRSwBqknXKFQxxXVqsxk8pQO6Y9fYL/GH9yRoyoWIGBbcf/0EHVTzgkTbjBuwwqcL44A6rG8VCJP9QGADRRP+oq+jmo+nDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398277; c=relaxed/simple;
	bh=PiPyOVIug+sEhJq3B14v4cwsuNtZX6IUM+98dR49lVs=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=j74wPZsPNlMwoUqYM2dcixnhZQGG+pTroxNs6aRgqXmrt9U5BTjyZEc/GNo12afR6C+4Ey5cLt4ZJuXvgf1SvUimioJoKM9k5q3VUfnPzcbovCyKdYo+RgLv/CNqOYR2F7YRmgdTxpLmVp/Vv9AFHicx4M4VCjbdBKJIhxfTsx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cyP/bcjf; arc=fail smtp.client-ip=52.101.100.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cyP/bcjf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I90heEliB6oC5xwTh08QJEQg7pXIWfu+c9Y6oJM1Ou/88EtN0jTrxlXax9HiIHMXZKFHhiaVJE14MixiBSDcm71AXe3x58TQ9QAMlckbEnmH59IoDnokHeB8wrKYkqOmEcbE9nti+pTAXu5uaCSIcoxmqVN3R/pGmbmbQlEyKvKYcivTvAiZvGU3O5poJDGSRHyP++OXAk23E2zAHFG8AS7oD0eqysCAizcpixauzRtCAb16lPuUxz1Qs6qR7uypf47E2zkMqHZaLCcnl4nt4tOhMeJpJxNfBg1HJJXE8GctfoUSbnHhPKR0GHNRHK1GsWQiaB0iMEoHdZ1Zt43yww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeZ46F5NU2IQYCQYOMIdAtXEWTjT1aICWq5YUy5nZFk=;
 b=gJ99x058vgcf4gFNhzd7YCECpbs6XH/OJ5kZjm03rvWLfqDwKfWofDAL8kXVasTVkM4nGv0s9y7UmSYpKUlqaLGszAA8WN9+hhIkbEXbxM8XGVxNUmerBPtP6pZMJN7zwupAP+uJrKBljPBpkRsVcv+rARUm14VYdpiHNE6MZngI+jYo6b2UngaRvWv9u7MAllRHwzCE4eqig0rt/ycNVnkhu6tO5gasyr+zCpqOd3PF4GM+YIuESVN/FUlYAjtC4HpxTOWNw3mFsZBZkZzJ22lukiwR4Z3sF1Z8jFuw41gUo/7u84QT+pm6fxTxjKQ8J5fokCiRbvb8u3nA4F+MxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeZ46F5NU2IQYCQYOMIdAtXEWTjT1aICWq5YUy5nZFk=;
 b=cyP/bcjfFQ2gRpzXfFbY7PY1+1/u26XjvYIc8if0vo+IPajGhpB8nYP6aUU+xFOjJRzuPGta7Xyw0Sj3xxXnmINnetUYB8uF8afVwDLuZpJVcXy7xI8KuhLN4xtUp65lAKKN3iopOC3xfedc4vXw/oJIbA+vYKNW/e5Wr4MApps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5852.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:37:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:37:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:37:50 +0100
Message-Id: <DJI7GDLWO14I.2Z3XN62XCNVP9@garyguo.net>
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
Cc: <rust-for-linux@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <nova-gpu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] rust: module: move module types into
 `module.rs`
X-Mailer: aerc 0.21.0
References: <20260624-fix-fops-owner-v6-0-5295e333cb3e@linux.dev>
 <20260624-fix-fops-owner-v6-1-5295e333cb3e@linux.dev>
In-Reply-To: <20260624-fix-fops-owner-v6-1-5295e333cb3e@linux.dev>
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7424d797-c0af-49d4-e23c-08ded2c755e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|56012099006|921020|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HdKWcFtQMcLKOrjpP//YXO/DGO5/s94FhF/KS+sW+C6cO62qB9RaiKLnAKV97wV3vf+cXI5FlLxNHW+dsgvZcov1uqJYqZXC71Zpg3cu4rqRSCx3K8dxNLT3jEdK4byFvbhkaqLWF+9Q5mW7tNW+JM+2xsGGLKiRvm/nGnZK+SYpcKOJYr62m7QwgVcLHUZm9bJ4mX0UPFj6RZM8CCKGjL5MNr1V+/X9uo+QekEYbiCyved41mxkcfkk2wZXeTSU1vHG76QYUM6CTnOLDNbEse1L2VUwCuWnyROIAVEtv+vgJopaYidkgX7bApjJ0oyWW9okySNMqeIblhd1tGu1FDU62DErbzYwKTxN8IMQ6QKAp/Zq+mA4VhzTyTflU158XxTCAhnxpgKfI02cUqFSo1lobKk0PRXI8W1xiLGb0/xWf7qAjCObsWw4eUrOayuFJAusQz29zF8t5xEL4X6luvMT6yv7z8uY/wzxMWqUk8iTDgucjGMreZUD0dTkcrYp59ZRKCdQ8bqwlecjqLFgH94OFjtElL0SeUFq3Bx4Hz39129opwLBGygsDb9ntGJkO76MG3/DLtqPvLOYHkKwGVY+FVAhGKOvwrsWBmV5FvN1ht15RkiRwwahpuS75k+nmwIvLHxhMjDCzNEtg2x1py4m/2Jp4SHcl6cIHyPJ1Wurf/61lkw4wFuVRkqaA2Vrv203jqDJAhK5PynjCP7NKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(56012099006)(921020)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRHVFRNSXlvMXhIcVBYQXJMTU81QngyM0l2SUd5bVFsQjlvWERYT3c5YlpB?=
 =?utf-8?B?NlBuTWpkS0tCOTVQRUovRTE3QXJBVnNXMmhmckFKcjN2NGszamZjMG5HbUp2?=
 =?utf-8?B?YWtjQXFhOExaemZvQWd5aktqU0ZNcEdUTW5XL3FWcGM4Z1NlZXJLSmY2bnB5?=
 =?utf-8?B?ZzdqS2Y0MkZtRERvNlQrVG16NUk5dktIb3lBY0c1cVR4V1BiTkpxTHhoL21h?=
 =?utf-8?B?TWVOTzdpWG1rSWhyZHR6bTdhMy9yWUxqZkVjL2k2RUtRdmF3aEhrZW8xdVZn?=
 =?utf-8?B?dFY0OWc1K3YvOFBMa1QxdURKVjQ2T09ybWxBMTk0eHZYR2dpclRtdDZuZmF1?=
 =?utf-8?B?VHVVRWZuNzhTWDFZSzNBMTcxMFY5VDk1M3lyTktRN3VIbVBGblZJT3lZOUdW?=
 =?utf-8?B?eG9BcUJjWGcwc0hZZEVsUjNwVFpZMzV1Lzc3dVJVcjIvbnc3ZVU2VXB1L3oz?=
 =?utf-8?B?TnZIMC9Ma2JjRno0aUVOR1RXYUtUWldlcFZhT0p4M2ROcGlla0dnQUcwb21F?=
 =?utf-8?B?Rk95d2N2dk9Yb2RYZlpYYVFlNHZ4TVM3ZUNBSENVTEVxbFNkdERmSFJEVnFL?=
 =?utf-8?B?Mko2ckZ2bFBUQ0E4dG5PbUpEUk1yTVJsR2JRZE45M0c4RGpIRUlua0dyOUJS?=
 =?utf-8?B?MDYwMDI2eVZRUHNGa3FXRTVqNlFXTWRJYXdNYWhHOXUzL1U4cmFWUEN5Q0Rx?=
 =?utf-8?B?bjA1aUs0Yktsb3NqWHVQWjNOUnVod0JRVWNpTEZRNUpVNUprR2V5ZEVibGJo?=
 =?utf-8?B?MGZETU12RkJmb0RFZGlWdXczQU9Ea2hHeTZrUGg5OFFMc3FhUHNmR3lFUlFt?=
 =?utf-8?B?a1J1V2FGSHBKV0daaTZpeGplUTQ5QTV1WHlIVExSVGVmdXJLRDRMM0JuNUQ0?=
 =?utf-8?B?ak9ZNExEV3E1SWJHcG1JcHJ2NzVNS0J5UUFhY1BKZmxJZFYxaWJaVVhPVmVj?=
 =?utf-8?B?K3I4aTk0K2NNQUNhdWFYem9JMHZlOUkraTUzdS9UdDloMitoMUEya2NoS1Jq?=
 =?utf-8?B?dXNqNVplcmVsdG44M2U3TmZ3dEVzRlQrdmk0NDJISWdEZjBEYjNZdFRERTky?=
 =?utf-8?B?UHpCUGVXYit1cHdRbDR0WXNjMjVQMVk0OEZ0bVM2ejFOZlVFek93VzYxMGcw?=
 =?utf-8?B?eU1kaUo5SzVLNG9uRis4dnVab1p1bEdvSUhwK1R3WExUOS9KTmthVzBUQk9Z?=
 =?utf-8?B?YUdkSVBXZzMvd3B4Yy9ndlVUWGlKR01tLy84NGZLbUY1eFVrcmdBTFlzZ0M0?=
 =?utf-8?B?YkdSeW51Z2kwNHRUSFdScVBSa3I2eS80aVJQTHBoTFUrYTNBN3NuU2psU0lY?=
 =?utf-8?B?S1FVMHZua0JiMGtaUUQvYkFFaVdyZUxvNHRXalk5N1NLcHVaanoyRi9tR2ZW?=
 =?utf-8?B?ZWE5ajJQbkRMSmhWTDdJUXE5MlBvZUJBdzdYTVlHSjFmeWRLdGpLeDFsM3pH?=
 =?utf-8?B?Q0ZtSzJ6YkpBdmdKQ3dpR0V2RnU5a0Q5RHlWS21YMDZROWk1anYzdytCWThU?=
 =?utf-8?B?T3Fldno0V3FEWUhwN1dReCtRK1kreHI3dm5JcUNkVDAweGo0S2VWYU53V0ow?=
 =?utf-8?B?VGJwT3FGTEN4RGo0V3UwQmJuNHc4ODBwZngyUHF1OFRzdURaajZudTdaRkdz?=
 =?utf-8?B?TDlxa01rQXJ4OEhpZHFoQmcxaWRzYlZ2SUR6NnRDSll0ckJZSkhxSjdVVVhU?=
 =?utf-8?B?VVh4RGRzMk5xRHJWRGY2RnlyWmxjU1VweFB2S2o1Z2JnMWtpWmRCOFVMeExQ?=
 =?utf-8?B?SlN5SlBaZjQ2dnRnM2ZVd3EreVJDNUZBUlpiclpjQTFjTksramxIUnpubGJL?=
 =?utf-8?B?UTFUMVEyaGVTaUVrNDhjVVdtYWFBcjc2cDB4YUc2bHFxQmxQOVpEWHFSNGZM?=
 =?utf-8?B?UmxiM2RWWC83bnR3UTFDNmQ1UVQ4N293elhrTTFNelJlbU5ZeW5vUjQyWEds?=
 =?utf-8?B?K01qWG1LYWcvUCtJQXlZWmxsY01rUGhiNUhtVHlQakN5d3lCcXNPeWxINEEz?=
 =?utf-8?B?QkEzWjdTS3Fha1dDeS9rdWduOG9hUUFSRWRZZyttazFqRjFubzBObnFRVVdQ?=
 =?utf-8?B?MnNCMlpWSkVDWk5DQnB2SzV5a09hQThyWmZRcHFDQlMzL2k5YTdMcXJWVzB3?=
 =?utf-8?B?ajhHdk9XaFgxV1l4aTI1ME9SODk0QnV6cWpDSCt6UUtIdllrWUNiZXBjaFJ2?=
 =?utf-8?B?ell1bWcxcWVCNllrNi80ZTdIcGNja21hcTc0YVVGaExFYkZpckRpbEtvd3lY?=
 =?utf-8?B?SmlnSitNb0kwaUUyeVJZVTJNemJpLzVPRHd2b0lTYUozRkE3ZENSNGZnZW1L?=
 =?utf-8?B?WXp3Ung0R29FZ0pWVlRXOGRRRjJHTG4yVW9aVmRFcHVKS2R5VWpXUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7424d797-c0af-49d4-e23c-08ded2c755e7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:37:51.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa0M+OlPuxB8Wu4J5DLAlGDE1IyUEMdusI34WQJXWuTDAcF8svRY0T26eu6fLvW3/adm5od112sQHZdUGeACVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5852

On Wed Jun 24, 2026 at 4:00 PM BST, Alvin Sun wrote:
> Move `Module`, `InPlaceModule`, `ModuleMetadata` and `ThisModule` from
> `lib.rs` into a new `rust/kernel/module.rs`. Re-export them from `lib.rs`
> to avoid tree-wide changes.
>=20
> Switch six bus driver registrations from `module.0` to the public
> `ThisModule::as_ptr()` accessor, since the field is no longer visible
> outside the new `module` submodule.
>=20
> No functional change.
>=20
> Assisted-by: opencode:glm-5.2
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/all/DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net/
Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/auxiliary.rs |  2 +-
>  rust/kernel/i2c.rs       |  2 +-
>  rust/kernel/lib.rs       | 75 +++++-------------------------------------=
------
>  rust/kernel/module.rs    | 71 ++++++++++++++++++++++++++++++++++++++++++=
+++
>  rust/kernel/net/phy.rs   |  6 +++-
>  rust/kernel/pci.rs       |  2 +-
>  rust/kernel/platform.rs  |  2 +-
>  rust/kernel/usb.rs       |  2 +-
>  8 files changed, 88 insertions(+), 74 deletions(-)

