Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021137.outbound.protection.outlook.com [52.101.100.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC128000F;
	Sat, 18 Apr 2026 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776479392; cv=fail; b=DM4duWXm+xhDcy47he9GnIfw3jY35tz2PTQkyxWY8vbM211a+JBi34SjUuehwRK8NgMm1lghXE8/2DdyTdxRYVRlgiTcqAKQDEX6fZUv1c0AUJ30KrwRCxxvyUtZER/k6sCngfAG/YmCPGjqDWwV5wuSKfmiMMYwDbT0YiCwaeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776479392; c=relaxed/simple;
	bh=Mpd7/s6okq0zJ4P7GXKXmgzPJ0SSusGoFMwPl0n2Nzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCQFkTZxAf47ILSSitpOIwzOhObJJJRzhQ+IS7b10IY7/kGHOkqfcJJI6afbDlXUDeAXKRhqkpcDYohupcUACpEtzpii4RA7wcK5CZYZss6SUIKpKaM58m65XFe27bgRKtFXZBDC3yksZRMTwDj1K3ml8QMG7LFtauQMbe6gQII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwzvtRV8+pHROhCaPeseIVPeJZ7pvHWIH7Qa7rZJ45YRy3FfD8W1PHZMzbPln+vwwafXwomSh74lOyu0o0sRtM0ptBd5UDmRDrtd0smAdRfX4pHno0KuxTNKeRucwL+LiPawe0wcRQpivTlf4ZHo/JN0FaZ3QR73mz6Sv/xssQ9GM4VAet+81qOLqflG+vCC69KLqF3iiRGPQxK+VXYGwTYiM/wzhx7Cb/ojcuLjC6y9DM0Yj4QrxVVmYRV2P/vDEiLNOGJRe+lBPUoNSPcSDvuGxTI6IYyMdaS6D2JwNFdcw1hNOp597ABJ9qxtdDiwp2CKQq2+UZuol1K5HZIJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpd7/s6okq0zJ4P7GXKXmgzPJ0SSusGoFMwPl0n2Nzo=;
 b=d30PY5J/s7IY3cNYSGjoejS/H1p8oyk0Brpz41Qc1q0xow43EQcriCld7RrnuJPueciUxtbjei6rwqT6K+CIeKTTfOQbGOW6R8Q70LhZJlANqR0nM6j+I1ZJqp754uAA2o92swvijcip9NLMuBjijwIRlzk7uuGGJHoe9+pDNlDodCxh/pHYBAf2L4IUIy0B5Xo66ydk25TuF7H/Gc200uAu7Uf7kDXAJvISmrhAr1aL1U7LjlMgt2+wd3/OLY7BETadRnFzXXc05+RrFdZj3DJZGFsUQ/gstZLtXfGMZHsgB7vQmbALSOSr5AjphNoDiuQs9b/oqQjRNB2YjA9/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8291.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:434::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.29; Sat, 18 Apr
 2026 02:29:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Sat, 18 Apr 2026
 02:29:47 +0000
Date: Fri, 17 Apr 2026 22:29:42 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jens Axboe <axboe@kernel.dk>, bvanassche@acm.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org, 
	ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, sean@ashe.io, 
	mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
Message-ID: <fvhu4zwarm4zgj2feyo5j43iu4gftgn3cga653wh5zjkufvkgk@5za45vjksyzk>
References: <20260319221956.332770-1-atomlin@atomlin.com>
 <20260319221956.332770-3-atomlin@atomlin.com>
 <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
 <424110a4-4e14-4e40-af0d-59ca7a30d904@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ev2pxwrbatgndwv"
Content-Disposition: inline
In-Reply-To: <424110a4-4e14-4e40-af0d-59ca7a30d904@kernel.dk>
X-ClientProxiedBy: BN9PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:408:f8::20) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e84fe0-0b1a-4686-c1ef-08de9cf25be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0BvxsEB7HFe8ug4xSiM4qPbtN8fNISKiO1LKGs1hpUCIXag29KkFhRfnWEKCn3yeCMITE/J/Al1KWQCvpZW359mFPsUO1WOSjU8mHj7tTgaPJPA/GRP25rAyfEIP1HBaY2L+q5j/F2TscOOwMPtjDC1R/XwDWQPGCVDyoTAX20kR/0lm4xABWo7tTRtrhao4RHDjsW9x/hD3PGfBJLhZ5S4LoOgmLh3qhdGlHBYjjvfzpo93q8SKCZDYUrMN0ZckulxGPrenVdyWy+fW5om7fzfcg/KKKB52dCjj06bwqDa/vUCboGOd+kw4THWA3bwP5O869ecf++78QQU+p/4/tj32fRsiAaVxrnGM9Th9Iracx7VSOBYbEkMnTAzC36KKoQ1e3EvFnh1bCf2J7L2RXKi6zsH257VyWIdsiglwv93+UqUYylKd0qnLbCOJsvDRQY2i0iDb7Yu4c0XvOwARXMOc/L7+hT+TtVC2TYmOchBdcRO1WtqvxaZzXXQqjubR2vMSzDRpBPXvuY/S038DcnGSs95j2uuKtYFIIexPsUStBJjB0cLUoAknobHHbC2WvNUcZqVXM/tQHI83pJFPGAq/FreMXzNxAwEjVonQImlQWvwLBg8vxmynQV1NUBpz2H5QNleDW0syjNqHKWsvX79R9OCZgFLgpWFF/MUOIwnbIo7TgVvS9GmB7EWIMU2A2MEmylCofXzRpyHln+Wx4Jx9mfnHwNGucVTVveQwsVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FvZGRZQVBHV3VodEYzQ0tFdTNlZzAxTGs2ejErcUtQbHlTYjdQNm1IYmZh?=
 =?utf-8?B?UVZ3RHdpQlRFd01Gc3JuZnZ0b0lMMThWOWF3SnYwZ2Zqa2tYbTFJOHBVQ1NX?=
 =?utf-8?B?UzIwKytUVm5jS2pLOEx3cDlSYWMyRE9IUndaMHAyaWswSXJBa2NwZ0hvY0Ft?=
 =?utf-8?B?L0NOR3YvZXhHQkpSclF5N0hKR2NpNXBIdlAreExOdkREcTkweTZ4V0Y2a3FT?=
 =?utf-8?B?MWVVVS9rTUUzdXBEZWxwY0xEYzZJR0dDTXVndHVaMlYxazlRdWlad1NNMGZY?=
 =?utf-8?B?R3REcnpSb0EvR20xMTBZczRoNmVZbE1qNHoreXlndjMwODkraWJnNlBOUDBp?=
 =?utf-8?B?bHBMeTBwdEZmK0JqU0J4UHpxYUtxMEtraUE0VTVJaWY3N25VNlRYNDJ1eDNP?=
 =?utf-8?B?OEtVVTIrNUZZMWRNdWp6dThnaVB3R0RSZGFrRVhmNVN5d0tMckVDS1g5OExE?=
 =?utf-8?B?TFJoMzRvNzYzYllBR3lZYzB6TUdHd3VpcjlEZUI5cFl1NEpkUll6OEFsVjBO?=
 =?utf-8?B?M05vL0hPek5Wd2xvSDViRjJncU1sNWY5T0U5dG5KNlQvazhzUFV1SzgreXJX?=
 =?utf-8?B?M3NXQnA4TWllb1FycDlJbURVMjFoSHExa0ZMYkdCN0JoMXBEOEFJS2gxck5R?=
 =?utf-8?B?U2xRMXVtUGpXUFVTdmtXTHVhN0FzY2RQQ2FLcUFtV3oxRGNHaGROWGhEUWtG?=
 =?utf-8?B?R2N4VkFqWXJHejdFQisxZXNpRUlCOXpYd25oQkdMeUYvZEg2b3p1UTJ5d1l6?=
 =?utf-8?B?RTR4ZUZNc0cwcCtZdUthZlVvZlpWVWIrdElZYTdqSGp2UlprZUZTdlJEYnA5?=
 =?utf-8?B?RzFBa210S3FkWEVjSzJaUUFkV3A4S3BOME5YTHJuM2Y1bUxYc2hDTjAvakd4?=
 =?utf-8?B?OTBMOFcyaFltaDNHYWNzbkV6YXpZOUw5ZWoxYjNxUGRRbFg5LzRkMnhFK1Z6?=
 =?utf-8?B?TDE5WTNaeXB3SGNBOXI1ZVVQbUEyOEVnRjNTMDJPN0xRbjhTYWxManRiTkdD?=
 =?utf-8?B?R3IvNS9ySjZJbTNTSXlrR1g3U090WDhxaVhaMVhNa1Q5U25VemZkOU9DYkVx?=
 =?utf-8?B?TEZnRkl6SUxmTWR6dzR1STlIam5LL1J5TjVwc1NVSDNNRkprM2JNMVdobzdG?=
 =?utf-8?B?ZzdINGU4Z0d6L0FHWFpXSCtaRlFrSS9JbjlqemVNV29pWnpoS1RHbU0wOHV5?=
 =?utf-8?B?SXdKN2tBUXhBVjM0ejI5bjNkNnhNbzBlMEF3dTIrZFhMdk1JL2hRSWovWFV1?=
 =?utf-8?B?SGk0WkRZMlpxRXpUZTQyS0xWN2huUG5DSVRDUStUS1JVU3J0L1UxRzRKS2t3?=
 =?utf-8?B?L082MkN1Y3BpY25VeFhWekhaYllMT3ZRb25qcHlHVmdGd2I4MXpmb29nay9i?=
 =?utf-8?B?bWVzVXRpdC9uWXN5UTd1N09kMXJyZFRtd3BFbmt4bnQ5YWM4aEtGbUI4cDZG?=
 =?utf-8?B?WWdVaWpVMGJaMkkrL0NuRXJ4bjY4ZmVvL1lrN2hpMld3ZmJZenFHK3ZzbVda?=
 =?utf-8?B?bllVdHFiWk81QlJXUlhzay81bEllL1FRYkNWcGdRUk00TENuYnljREk1bndJ?=
 =?utf-8?B?a2ZkekFhZ01Cc281WW9nU1hJb3p5djNOTUVMR1NBQ0xPR1pNRzgxSDdjVW5y?=
 =?utf-8?B?Q1RhbGNZbmV5RmgvZnhDaElLTERESmVKd01NMWV5SVl6NjdzWGJEaENHUnNm?=
 =?utf-8?B?dmlKMmh6TG4xK0IwSXJpNU9vbG1kayt0UFM0VVFyeEJWdGxMbkhuVVJOWmR3?=
 =?utf-8?B?Sm9xemVDcFE2YkVOb1JRalFneWgza2M4ZkdPcVJtN0dDRnV1YUtQdVZvbTIv?=
 =?utf-8?B?bkVyQm5YWU9Ud09rNmMxSjFYZUltSFU2aWxVRGgwTjlxb3gxd1dYK3NnOEgy?=
 =?utf-8?B?V1lIeWZhR3cyUmdKRld5aEZ5elJKZEhEMkNRUEI2WDM0UWllYS9QZEhCN2xu?=
 =?utf-8?B?VnhlMzBuRUtLNzI5czllVXpQeGRwZjFTM1FqNXJNcksvWGs2b1c2UDluZjRB?=
 =?utf-8?B?V21OR2lFd3JuM3I5L28zdWI1bHdFcUZNVzFxVmsxQWdiMmQwckhCRGNUWW95?=
 =?utf-8?B?c1BVUnJKRTZ4dzh4cDRVM1VSWFNmdmFPbnVINHNLWmhVY2lCZEpHM1grM254?=
 =?utf-8?B?MTdhbTFxQUhzMjVMYmVFU1FkQ0hRUXdVWHJaZWx6VStKUWYrOFFFSlVpWDVW?=
 =?utf-8?B?My93MGpXV3F3Z3dmVXliV0JvTVRzaFJuNzdicmwxYWtHZVZ1TTlyUjBWR3d2?=
 =?utf-8?B?WTRMWmsrNnVFQjJnaCtuK3dlWDV5ejBJaVMzT1ZqR1ZSSnRQWFl2T2l1YmxI?=
 =?utf-8?B?MVUwM2xGb0gwY3NNZnB2SzdzYXRxV2hQek14cWdROVEvTUNlTEo1UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e84fe0-0b1a-4686-c1ef-08de9cf25be5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 02:29:47.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EF9a4FsLxsZGcTjOGLCjQXE6e30eawPpFfZzRTTRsqHahYSoGQ77ixoS04jEqj46E3nB4i7oXZDww8D2BsRUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8291

--7ev2pxwrbatgndwv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
MIME-Version: 1.0

On Fri, Apr 17, 2026 at 02:16:07PM -0600, Jens Axboe wrote:
> On 4/17/26 12:28 PM, Bart Van Assche wrote:
> > On 3/19/26 3:19 PM, Aaron Tomlin wrote:
> >> To guarantee zero performance overhead for production kernels compiled
> >> without debugfs, the underlying atomic_t variables and their associated
> >> increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
> >> When this configuration is disabled, the tracking logic compiles down
> >> to a safe no-op.
> >=20
> > I don't think that's sufficient. Please use per-cpu counters to
> > minimize the overhead for kernels in which debugfs is enabled.
>=20
> Agree, this is the usual nonsense of thinking you can hide any overhead
> behind a config option, when in practice production kernels very much DO
> have CONFIG_DEBUGFS enabled.

Hi Bart, Jens,

Thank you both for the candid feedback.

I concede that relying on CONFIG_BLK_DEBUG_FS to mitigate the performance
impact was a short-sighted approach, as you are absolutely right that
debugfs is routinely enabled in modern production environments. The use of
an atomic_t variable in this case would indeed introduce unacceptable cache
line contention under heavy workloads.

I shall address this in the next iteration by transitioning the tracking
logic entirely to per-CPU counters. This will ensure the overhead is
strictly minimised, irrespective of the build configuration.

Thank you again for your time and guidance on this matter.


Kind regards,
--=20
Aaron Tomlin

--7ev2pxwrbatgndwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmni7JEACgkQ4t6WWBnM
d9am3A/1Fq7Efkk1sNFChlAyJZl3N+Q++eruOEzp9gEgL2GSyfw/+2x2EXMr2m75
57pLHRh+G/1YonLoJEr1jn0A4DyRsQxqrErtpWdiA79oBFP27o5YjIlz3AG4xB1n
VhIHvYhQR+dIRnpf48ZQhxGR1pvGlTh28lcRkz3zzH4Co3724BLIO36CVRAhWpYU
7Jsk79XU7m9WV9/wC7xqIRlYmDHwJsJx2T/4KdJ1cesRiEbqvDhPp1XZM1UEvaQR
t7jZ6kBIc44YWs3MDYQ3oWXWu4zhXtpAne4P1UmtTi2R9V//1iS490SMnJFMoZJv
S5i2QuXocVwmWoAnPMlmCZce0ADciQBxemfy4P4jVHX7LiIjekDwjGUeHU7eRV7e
hh4DYlS3q3NxhHcvbpiK4GArzrULc/5YMvOQuv6PDPl7tRol2MOS2shiO5FB0r/0
kKGX6tdrKaUQs6Kqd3GyB8q/3l1p4OSuY6M8Ur5xMBPNOO2iDJBfZs6Q6UMb54/p
0xLYLeYZArDgapo1iooz2GD8pNyCKNoW9yHG91JO+NPc0coZ0EQI63lD9R4zEm0Y
v6oWoW5EnwsEO2wh+nUCGTxc7Vdc2Mh36zvp5LUjI9lqTWXiml99UO7mEV4pqUyJ
/3dRbU43/Scgya0yZN7zs1lC0bR93z1u47eYgK7dGO1o0tNWEQ==
=YLko
-----END PGP SIGNATURE-----

--7ev2pxwrbatgndwv--
