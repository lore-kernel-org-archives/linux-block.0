Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022090.outbound.protection.outlook.com [52.101.101.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2603101B4;
	Thu, 19 Mar 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958234; cv=fail; b=nh0ubW+RVOhac3cWcsTjmiGigzPija2AxErGwVpkg+AV8DBw3uuD/MXLqSwtAoqQ9eusYu/Al2IjQmEA8gUDXGtSNMyjXhms1ZLbjDJ0anMmVFaSYrT43O5iE4YL34lkHLNKEir1veiMXqcYgLJ4+FLGGbsVOgakmDIVpb9JFi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958234; c=relaxed/simple;
	bh=WdmO55vx0LSlMKzPO1qBIp066Q2w4VyGdKb0UsmMLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hahthoa0HsCRNnGheSJKI87QMVt1HKiSPtR2+h5LzVZb3KQqHJ9yRbYv6kMIro6SzD6+ZbE6fc0QBkkEXBV4+9wOuiuWGhf87Dx/q0nzZRBhSTYxJGm7gSdyjgxRUbx3pAp4ASzdzdmI6BhW/3DQUYiepxG3N9PPGqXJa34Zja8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUFv0c22+5MHuQ10pZOlLIraeOaTGrTsYq9M3IydhKA7AXZA3mNM5p5Hahw18jEGHniQs4ZcZlTw56gVGRIeXvckjWBflNzvnv6eZd7NXehN53cGJzQf9oQBboHgZ5iJ7Ny7S8wBvd/CoFgKUUAQKH6geJIM4brSZ041teS7JgDh+5XXSpsCff+aLJHekxkAqhfJg1LyV1x0JVgjy+/oo61mltcUO5bqn0aGX0cNuljGy1kPxTxbXMX3omaaJVv50ObQtECRflYWf4jvQpU2ztS4MqGB9egeRCdiglAZa7B18cPckzyuwD/P9CeNCU5IqfgjMIrCs8CzSuKijaBT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlMa0t2Ffbz4f3YEgmzxNHEzLkk0MzbGocUdCqwCxG8=;
 b=WAbvh9EAEoCuCIxDxUV3F7TcQwDZC19lAeegxM/9cJFjn4AqTp9QgVEAIbLtyznzHAsJpo1gOD6WdolQhQyr+/9R6laHOpSZQKbjAZTKnkQQGAP7ymjcJUK3ieIBjR+gFzOA2BjGVp8AsKMpGnZ0JRdmNdVyP5vvgtvb84sTcPWuPbJfnmL+DHLLFE9553TQby86zOMbf21+htnLYoQyT2QD+3Ba8GNniu2h85qriQkEI+6UapaAmt0tTZAk8ixTkL2nvOQCZ8n4bMrqV5h7xI/63/x5kVkMzlESY71IP63tt5nRWN6r/srD7zPD1dtbBndcXQelnUf6ootM8USLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB3023.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Mar
 2026 22:10:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 22:10:29 +0000
Date: Thu, 19 Mar 2026 18:10:26 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, dlemoal@kernel.org, 
	ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <vuielga23rvaf7wxrz5vo5mzs7ac3hkinncdooc4riadgqg7fp@zbnreowm64bn>
References: <20260319015300.287653-1-atomlin@atomlin.com>
 <20260319175249.560f27a7@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xorxjscjiu7tajid"
Content-Disposition: inline
In-Reply-To: <20260319175249.560f27a7@gandalf.local.home>
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB3023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2189f09c-e0eb-4a9e-a100-08de860454f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/n8YgbgeeEqvZkbSUz2nabtcpC5lmwCCmyoaHs3to7VAtDfGYUODIXFOZDIOoNc8DJYYzJYZC2bCWRDjWjvAYxSK82ml9zlP9BBI9wTDyDl6IhFUlJA4XxoDfFH7IndFXKk9SQ9DdpwG3bGKT6rvfwkMklCa6+PHTlwDeEj54XYRi7XJfgu3BBc/G+WUVKhBGhYzhFqutPTReN24pf8VBFgNo/uo0lETsx1dn5q8WRK/EVWFN1g7Pkx1aSUf8UJp69x/EV+WHvwCTbYoMfMMVR7ibXG8Vj3j4L1xlgugtAlDzJcu1zPIK0e6oH+XobHIg5IILNC3qyULYhzoTrh49yRUpZTrQfRD/x2CZXqIPW0w8gCzkSYTzr7dkFQOURiR6+AgAnFon8D3Iyr0+IJqu+RY2lUFHSEW3uwhtnPlx2NGndvC+UX9dFCsa+rFUaIOmYXVQwNhqSTAU48Y5PsDbrgQTzNHImprnsJFGUd79VtIPI7Vr4o6OhEoqb7DKHRRuV+z4ZiVlgTxKe4QOQzQfNW4wy7upmI2I8NHdiN4A1qawqutekVqJRPz0McCNgnRe1TM1yXoG469tHMuaqduDsSegM/lSuHkViNyF1PP9agfcTZCsc1mrTpq7l9dBpHgCUiuePCzX2lYZhG4j9bLyMb+1r9eJsIWU4/sZSmLgqk3gyOzLkoH8ZA46Mhhpd89b9VcCT8+bBlq2FpOcAhpw6D4I3trIarHfbQ2CJlvC1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkQ0VStRNXRpdVFUOGExQ1Jtbjd1cCt2aldaMXZDM0lieittYy9JSWY5aUhP?=
 =?utf-8?B?RTZ6bU9iYlovRWJpZmt2dk5HVHRKdGpHVzBNWTdMY1NJT2JzK3hYcVkweTRE?=
 =?utf-8?B?emtIdUFLMDZJbmVwRlJjbC9oRlZ4YTNaVXpWWncrck1GUVgzTzJVeVlnMnRH?=
 =?utf-8?B?Y1FRNERkWERTVnJxaTI5by9LK09Ocjh4a3d6V09yTVFZVk16eDRacUpjOTk5?=
 =?utf-8?B?czdXcUVnSFdFZkxScjVtNm5Iblh5NmpaenVNSEVZNW1iTVhFUDFNR2tSNnpz?=
 =?utf-8?B?UUZ6bFdMZ3lEZ1UzdjNkU2gzOFQ3dEFGUkd3d0JpRjRMazJVdnQ3WXc4NzVR?=
 =?utf-8?B?S3NWMExKbVNHSE9JWEt5cVlSMjA0emFlUjVxZzh0RnRxSVVlYzF2LzdjVDM3?=
 =?utf-8?B?UFpoV3FUakJ0NytYd1pPNHU1QlVCa3lFMS9SSEp5VkhpYUp0TjFlcG5iR2Ey?=
 =?utf-8?B?MTBRYTRrRFd2bXVJSEM1VHpTSUZwTWRiWGNLcFhoWHNVTXJuRm5DbUw4MzVo?=
 =?utf-8?B?aExpSHdZV2RtMmtWekp0cEZXR1ZLakdUZ2N2WmFldFBNK3VjQ0pYN0swV1dD?=
 =?utf-8?B?bWNTeTNuYTk0UFN3cjBDK0hvVHJPek1KQVcrTkxKeW1vaHZQVlpUKzZ3NENv?=
 =?utf-8?B?SjY3WFVwcm1YSHJrS3JvUU8xMGNlWkdiTHI1cEdrUUhVRWVYa1Z5aEdIYTlO?=
 =?utf-8?B?NklvZHFDNWhWcHg1NnZDSGF2SGE1UG9aVU1DKzQrTXdtdm1GWktKS1RmdnJX?=
 =?utf-8?B?dHA1RzkvSkFKNVpUeUZoMkVlS1RnSzlWSHhtZEg3TVkxSUtYcVdrdCtMeHU4?=
 =?utf-8?B?bVN2WFoyL2llU0xSRDhmQmJYMWhVMStSeXRTdlpDUjRUT0hoZFRCNUJXdk51?=
 =?utf-8?B?Y2xCS2YycGx0cWpaRzlOaDRsTFBJU2NsQVRzY1pZZDgyL0lPZmtINFVCZFdO?=
 =?utf-8?B?K3o2WjhxdUpnUk1GS3lzaXp4bzN0N2ZMWVIwZ2YrQ0RVMU5tZS9SMVhwa3RL?=
 =?utf-8?B?R0lyVUhPV0hMSVZabE1LNW4wVzlPRDRMc1hqTjBtWWtuRVg3OEs5dWcwbTZt?=
 =?utf-8?B?QVRxZVNBajFwWXluYUxqeXMxWW1EK1hmRGpIdlFFcDB1c0VaSUp1T04rS3U3?=
 =?utf-8?B?bTZINTlVaktHTDZHU1FkazZYYU5XUTZTNCtvVGdsWCt4L3B0eS9xU3U2b1VX?=
 =?utf-8?B?VXBPWm1hOEovQjZQUDBLNnFFUEwxOUNacDkycFlvelA2Uk14Qkd1Zzg0UGNm?=
 =?utf-8?B?amJlVm93dU1YUTZTWEJScUR2VUxMZmVjWWxxUkNNc0RISERBV1ZDTTQ1U0dJ?=
 =?utf-8?B?ejJHRW9EcDNYMnhsd3V4dDllRUNibGxPTkdzaGFBdFY0NWZJWTB3ak11VzRp?=
 =?utf-8?B?Ukkza3o4ZWZnSlU2NEMvT1VVWnRMajRIR1Z0MzlMV1ZZdlRlVUVjS2RDdlJo?=
 =?utf-8?B?RTdnSE5PSEVLSnowZ1FLZ2VXYmtuS1dCMFdWRUlTZ1dDOWFrUmdwTUFLYXJ0?=
 =?utf-8?B?UGhYclJCRlpsZlhiUDRDeXpmdEpTR0h1NHllSzFURFF6blJOR2dwS3dKOGVw?=
 =?utf-8?B?ejFtcU1lajVWYStvSUpDeEJXZlM0ZEx3QkZTOUNxalZ6ZEJaVVh4Q2RuNzVq?=
 =?utf-8?B?d2F3cmhYZmlZNjcvcEtjWjVzZVh2dVlSdEwwM0xKdy9OMTYrY3Y5d1R4ckhS?=
 =?utf-8?B?ajVYOVNlMWVINTVJeSsrVUllaStLblVkZWttMGZ4elhvVnE0NVVOejl6MFd3?=
 =?utf-8?B?bUxvVEZFMmY1SDBLQWMxRk43c3ZHTlh3ZXBsdlZKbUxXS3g0MmxHN3d2NVVL?=
 =?utf-8?B?UFJQREpkNitvUGhzMHZWL2t2Y2JtTXJyY2dITS82Qk53eTBvUEEzNFhrVDda?=
 =?utf-8?B?VGFZZnBNOFB3eURGaWhpSU9FOUNRMXE0M1I0RkFpb3p4V2xuRGFZQmpzWWtN?=
 =?utf-8?B?dEVIZERXRWl4elhyeVBlZU9pK2t6SkhGb21zT2xEZ3RkenRaSFNsRTRUbTRw?=
 =?utf-8?B?UndvTVBUTmdPdWZYS0ovMHdqcEVzM1o0Vy9objF4bkwycklQdlRUd21zU0Fl?=
 =?utf-8?B?THFhWXJCOW1HZXZsR3JEOFNUYVhiblhuc1plRGQxODEwRFV3cmJTQUh4SFYw?=
 =?utf-8?B?dW1scExzdXBJWnkxNExTdko4VGxYSVgxT3lYQUNadjZDVWZpeVN2blJ6SWFx?=
 =?utf-8?B?Q3dVMnF3cDdzVW5FWkUzSWY4NG4xcU5VandiMnVDc3BIK1B5N1ZobUZ2YTh0?=
 =?utf-8?B?VFlBcFFNY25HT25vVk5ZTUg5aEFKNTZZdVFIMERGYkt4emdhSnBoRDM1MTgw?=
 =?utf-8?B?aFMyN3YwM0I3RDdOQ05OZ256c1FkSk9CbXNKbGpQMGM0NFJENzVzQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2189f09c-e0eb-4a9e-a100-08de860454f1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 22:10:29.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7TBQfIngCIVctGJUm1RkvK2zwVBc4fHGidHz68oE7eyVexh2bZRolnCHL5VLASzo6PwbaipHM1nWBL7TY5UCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3023

--xorxjscjiu7tajid
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 05:52:49PM -0400, Steven Rostedt wrote:
> On Wed, 18 Mar 2026 21:53:00 -0400
> Aaron Tomlin <atomlin@atomlin.com> wrote:
>=20
> > +	TP_fast_assign(
> > +		__entry->dev		=3D disk_devt(q->disk);
> > +		__entry->hctx_id	=3D hctx->queue_num;
> > +		__entry->is_sched_tag	=3D is_sched_tag;
> > +
> > +		if (__entry->is_sched_tag)
>=20
> Nit, but why use __entry->is_sched_tag instead of is_sched_tag.
>=20
> Not sure if the compiler will optimize it (likely it will), but it seems
> cleaner to use the variable directly and not the one assigned.
>=20
> Perhaps the compiler is smart enough to use one register for both updates.
>=20
Hi Steve,

Thank you for your feedback.

That was an oversight - I'll correct it now.


Kind regards,
--=20
Aaron Tomlin

--xorxjscjiu7tajid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmm8dFIACgkQ4t6WWBnM
d9YubRAAiP8ODSilcRn5cIH+UIxA+AJgzbe+xew0CReUFQKZv4J9wwJdpF08xRo0
H4W0qPvjH4uVc8vc2sYkAhErhcW+/DWAI0+dDY1oq+X/FKHy3gpEJqhXI8L9AtHF
5gxyxoq6IT30y0XyveiarKBkA5vwzVIZMxM1Jh/UanEXtsfjvmXXQaztP4Nc0PiC
NGCssqBe3XdRHOhXwxhU4hlffhQyoOGIuN37+4i/zFtANnSnS/yGg6rt83jE/9cX
P1oxOQKAjCKWwf6DRfjY57sNv3G0h/yElz5/9UYp0Sm5ps+810CwMa9+Xu3z4Pr6
4SdWiU4Huva2ZHW9cvsStxOZMwwd6xtAgOR19Na5ufvqimsSG1wxzLxcF24lg+nR
XEbRigqVb5p/XAbyjjEC5kayQ5HDPsNA5ywI51AwpW4EhCEvB/SQGvzINI1wDrGb
OeP1AKEwKwZf2sDbJLPulffAUXRmjCFvRZl6TRSpwyTWSzPi6nO0COGWsWXhxogL
TbOS3j9u5hrC+CwgJks6No2KU08BojEBbt8/v8euyTjDl3WqAEaleAY6cfdMSErY
aslUA5npgQWgc1uscj0VBBjCfgpzdJlx1bA6YByzo9R3WcIxNC49YpqDveUzd4F3
Z5Jgb1ka+35a4582+bMj6PFcE1cZ/34Q8EpjlMZ6Wmztsn8fHos=
=z8kI
-----END PGP SIGNATURE-----

--xorxjscjiu7tajid--
