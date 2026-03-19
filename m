Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020120.outbound.protection.outlook.com [52.101.195.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D640DFBD;
	Thu, 19 Mar 2026 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773879743; cv=fail; b=VyTOBR1PGxsLl1mUgal0EjLLTzOw4Ch4D8a8pRaaN0JJzPL5wVzy5drO5k8SCnsgHM/I2MDZQT+j4InrYlXSOBl6KZFIFptj1FLZCgQxIDAd20CaVSS9P6lCrZi4SX/udBdh5KLy07vNi3pJSjsRbWAJd4N+FmEYKlaSK/oa/II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773879743; c=relaxed/simple;
	bh=TPOL4rvRCM9BTOsBUyGbTowVypO/QNq0XgPb390QZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gt4COgp4QIdh/VHstbgSFDbxEdQaFTFlKu5HO/13U5abqtipfACQqaqxRlH7fAcAkCHa02MX1cuZQZxC4n9b7IwjGuMVK12XzVepWiaDoGOIctZKajw/m1R0tgMnyZYIHNpzzr6IlbEDW/oL+/x9J7xrQ+SEMhKhDdQmLUTQSkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQuqxroBoiZiC6NjUb/iLPCdy6IKbGJ8jE+D/cSWdSMtgV8E+cbCdgIZiAaNlZqtTfmtF3KYu8HkLYAbnwtJYR5yNmv9oikMY25Z+KQiGL6WHYAVKlE5nUPwK9SaUeAuUJFbuw/KLGEQbbb41UANw9oL1HGI0uiapq07jaF8zQ5F0eUyvaVH7PlE3nx+vMVDoqwXy5xByGTB+Xk71aT0R5TELut5RlKn6Uzlp8rk1NJDwatxOSWf3ndt8mwAkRqBVeJh4mOxkIupI7W0ReZW79ovEQcPYiRu72fIanVDHDx8oFDnCCM282T+oXUu65xHlSv3LG3TlfNvVkA9+FFStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skUSwdgOeznYcgo7Gbj1NxSj7qygmJ1xS37Ghk3vLEg=;
 b=iAo+tlT9nXsctpc/kK/bkVnp5k7YlDyz4TOSrb8vsutAQy8in3RjkzAMPsTYJgQu0vYZTLH/9UHbgjXTctnMfNZqf4U+M0kycmV/mXDzWw2mtH/zjcs7V3HYJ20eSijeQ43QkL2/PGi/vtspV6mzRxJ0LwI5o17HkGeUcK2y4N0YQQWE01kS9pd+586cGQ6TpgrvGsXwE2IA0Qv6nsahP8fb2UfJz/Au+Z4889nB6qXrFEdA7TR2FI+0cDo4R5lt2xGPekTh339hneTi1aBRQFh/OUCcZ/o+5GuIGbcNF401tJBx1XGyU6A6Ye5+p2m8fasPshLBH3ULOK6OAJWfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6455.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 00:22:17 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 00:22:19 +0000
Date: Wed, 18 Mar 2026 20:22:15 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Damien Le Moal <dlemoal@kernel.org>, loberman@redhat.com
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <dymecshyxu2edlc33cqzyfkrsp5jbo4okrnn4a4bpwqbzdr4aq@rb3m74ckta3u>
References: <20260317182835.258183-1-atomlin@atomlin.com>
 <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
 <lrnjp7wcrrfita36onlxqihep44sgr4il57ccy4irf2mortdqi@46w7sl52whmr>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zpzfsogidy44d4pf"
Content-Disposition: inline
In-Reply-To: <lrnjp7wcrrfita36onlxqihep44sgr4il57ccy4irf2mortdqi@46w7sl52whmr>
X-ClientProxiedBy: BN9PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:408:112::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed31fcf-5a26-4ee0-e397-08de854d94c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RQIPyKdjaBhlm7MYQMLOfoNcHQ5jWR6ah0qkfcrVBLmm3iIyNbxevkqFLUG/A3DsDHO2Kc2nvtETGnlckNumz6uzPumEexMlU1WqkqxNEHUpTB6xI8FYK+JVY9tqBs5x9S0ThkVQThzyd/2RraqUqELvu0ChJJhiIJi+f96/iw3wF98eOxqE8DvAG80KjLiSQH/m0e5HKRQXkm2XT8GJHLPF0uO4tb0SpOlA6RyAb9V+oWZxJAthR4qS40vekciEUBU426n/EuM8AHHK2Ja6I2ET3ODisrTSrXMGn8kctH91iwcDBAPK9zwQFmuMnH1ex6SkJK0QxT2S+yxoLWNsSNOe9nd2jvBWRmLR8R52XTQPrXXr4zex3BOpDjcR0F6SEfj3tKHXP3BIBelkXSUty3cth5+b/zqOKMRmvPfVcfWltpp6ivYoNo7nwDCSpJgbOt0iLj1exsYu95hRf/lkwmrQ52UTZYzaWK57MgnvTa4jG4ifzm6vDn/wAlRpbtP+KEc030sf8/33GyyiygQM4ty9ZT1K6b35KvM2+D6B3loapOJz+Q+i3uwgZGg+2hlqZA41j4mGVtKCsJDv5M6lyy8JHc1Bbx7PGm66mzeVzdFq1vsnMJvoXTmynwBOzBHHdvuuh0CWi6dxN77Ugc4UZosBIqXoIzBXgH+zcjlo8p4Y56hg3UoYED24UPx69BpZCrfH9sx1q9yZ/P0LVhQMwGTAhKE5aqh0IMi03uGU9yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3o4aWVlSHA3eUI2NXg4KzJsQU9uaW1Lcng0c1hkN0E2SnEvNk1XRlFMTVBI?=
 =?utf-8?B?NWRVMnZPaXhqMlF5TUVJZjlzdUthOUNibTdzc2srVHVidFAyYis2ek9RbllB?=
 =?utf-8?B?VWZPVzNLc0VBUW5OMitsNGN6TGorZHRxZmdtSTQ1QUxDbEdsRTJQa3llbHdV?=
 =?utf-8?B?dFY2T1hHL3hwcysyTGsrbkI2SksxTklNVTZRVDBnK1NEVURWWkZuMnBuM0w1?=
 =?utf-8?B?NWlYWGM1ak9DNkc3b29JMnFvU20zWGl0Z3Fielh3SHFLMVJ0V3hBYWV1aW1m?=
 =?utf-8?B?VTVhOXNXZUZpbWNYZ084NkhyTzFWYnNLYkw5WVlObW1vWDZvMjRRRkpmNDY0?=
 =?utf-8?B?NnJTS21HWXc2Q0dvZnBSdUY4eWRobjYyQWRYQmxtaUU3SUVsL3FpRVd2K2Jr?=
 =?utf-8?B?NU05TGtsb0d0aEJkQkhrTEFDVGpPRldHVkFobzdGTFV5ZzhkRmZXQmlMZEU5?=
 =?utf-8?B?WTQrWloyaytKcFkxaWw2eEdWeFlzTkk3ZTNZWGRjcVhtb3Q1T0FnRlo0WGlC?=
 =?utf-8?B?SFpNcEVkMG94UjlpbCtjaEQxWE4raDNIOUxyMGZmRkdwVFJQcVJtYk5QbjdV?=
 =?utf-8?B?TGZhQmwzcmRUOFVDNEFKTHZUOXVGR1psRUpZT3NZZUlGMVVFbkRrcEthc0xX?=
 =?utf-8?B?VVIzVHNnMzlwSHI5Z2c0NVF5Qy9nOGk0OW56NndVSTdXWStkcFhYZTFsTjlN?=
 =?utf-8?B?VjhocDFBOG5ocHlaVVJpUVNHUlprTGdTa2dVRlhlZEx6dGRiT0RQYldUK1FS?=
 =?utf-8?B?RXJsaThjWUxYQk9zbDJWc2JmRDMzajRmY3RyQk1CRDR1d3dBTkJqbHVQUzl5?=
 =?utf-8?B?dk1IU1p6bWpHRkpVYTN6TFZ1Q0ZOTTFYM2ZjYWc0amwzSzFNakEwSHJlb1l5?=
 =?utf-8?B?b2RwSmNCeWVjSERKeDhSNWJSSVAzNk94TnFFS2l3azA5RUtBbUxCRjUxTSs3?=
 =?utf-8?B?ZG5wTjVKbVRQMHVwQWlxUUlGbHFCZE9JOGU5c0xXendLOFhIRk5WU3pTbXBp?=
 =?utf-8?B?TDM4STJVckRXaFNRZXRlYnV6K1F0ekNSaEU5MnBkSmlaVExqU2tyQ0VIV3pX?=
 =?utf-8?B?S2t6SDNhSTlqSkNqd1pwbURkSml3MFJEM2NvVHNxbmY2eWdpNlRrS2w2SzND?=
 =?utf-8?B?WTVZZ3EzMzdtdmt3SWRDNDNuenZPK0ZnSDAyVTlPOFZOTFVBVGpGZE5NZ1or?=
 =?utf-8?B?U082WEhHQmlIeE9vS3MrOG16THM4LzVDcmxWREpZWW5rSG9JQTdheEl0TXph?=
 =?utf-8?B?SDc5SUNsQjdXMUJMSy9YaFhZNVdhbmxaUjdJemdrRHRmU3Qzc1A0NVNLUHRV?=
 =?utf-8?B?S0JHbUd0MWpSNW1EdEtnUHB0L0Zhazg1b2hMVW1NbjhtSkxZeU1jTkVxZGky?=
 =?utf-8?B?NzhYM01oYlM1NTN3RURMZm1VRkxrMHkvVGRPM2Zld1FxUjVlZkE2cHpCM2xF?=
 =?utf-8?B?bmdVWWZIVHJYcHJkcHNHRFMySHlmRU1ncU5CK0ZaVU5KKzgrK01oUjVuVDMz?=
 =?utf-8?B?ZUpWZlp0a2lGQ1NqblRMb3BIZHB3NWNHb1BITWxXdHhyc3NsNE9FNW5BSDhX?=
 =?utf-8?B?Wm5rV1FMWGdJQTRWa0hVTzc5MC9nQmorc2R0RklZVVllczFiL2VMenZLZU16?=
 =?utf-8?B?aDkzdVZZVDVYV2NKa0h0dUZncXJFNFNGOXNPcWgyU0Y1UEFPSGdsVGVSenNK?=
 =?utf-8?B?RmdRSTNYRDJ5RjN1Sy9mdnErQUdyYU51UlZUejlDOWZ3dTFPbEk1SUxveG0v?=
 =?utf-8?B?c3NxNlRMbi9GSThPc3JKb2Exd0VlWU4rUnhPTFRhM1JUakNBTnJXc2FoT04r?=
 =?utf-8?B?Ukc5VVJycG9ENVRNbU9JdE1Ub2p5OExhcEQ4dUpXdGRwYm1lR1Zhb056dkk4?=
 =?utf-8?B?TDI1VkhsMTJaY1IrYkg5L1AyUjM1ZDVlS00vWHFJUDh2Nkd1OEMrMXJybzBX?=
 =?utf-8?B?YnMvOU5PeVZuTmJ4Z01QSE5vY3J5VUxJNFliaHkzTVUzeGxaaFQ1aWdTVEk0?=
 =?utf-8?B?NjZ3cUgyMFl5NXVoandvY0xpQWYzVkhXWGZxdTBtZUJZVmFpbGlsRStPOGZF?=
 =?utf-8?B?U0dzK2lEWlhQZDZWY1JRUVZNQ0tnWHd4OStFTS9nYTFxWmlJcCt0TUNjMkhm?=
 =?utf-8?B?K1VPRmxqRnF3M1JJVTlsM2tHbDYwLy9CZ3NWWHc5NkpHeEVldDErQytxMlRM?=
 =?utf-8?B?SzFyb1BzSWJlOHJTWDVQOStqdGV2Mmd0RXo4T3F3S0tDcnpSeTF3RmtiTVNq?=
 =?utf-8?B?SVE1cUJ3bFFLTWVJQWJrWEN0Q2pPZFRZUDJMeDJwYTFERDZhWXNqSXJZWm5C?=
 =?utf-8?B?RE0zeGY0dEhlY0s1OTFPQi9YdVVmUldLNm9TRWRLT2k3Q2NwQ2NZdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed31fcf-5a26-4ee0-e397-08de854d94c9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 00:22:19.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+ZWdiBOypBe6VEwal4x7Xth7ZXbKw+fdD/yRucC/mAxxZzRDuRCTEraCseKa+Me1stTsGApfl5BMmq6CypWLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6455

--zpzfsogidy44d4pf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
MIME-Version: 1.0

On Wed, Mar 18, 2026 at 09:21:23AM -0400, Aaron Tomlin wrote:
> On Wed, Mar 18, 2026 at 08:38:20AM +0900, Damien Le Moal wrote:
> > Looks OK to me, but I have some suggestions below.

Hi Damien, Laurence,

Upon reviewing the source code once more, it becomes apparent that tracking
"active requests" within this specific trace point is essentially redundant.
If a thread is compelled to invoke io_schedule(), it is mathematically
certain that the number of active requests perfectly equals the total
number of tags.

Now, it would almost always print active=3D0 in the following scenarios:

    1.  "mq-deadline" Scheduler Starvation: The thread sleeps waiting for a
        scheduler tag. Because the request has not been dispatched to
        hardware yet, blk_mq_inc_active_requests() was never called.
        hctx->nr_active is 0.

    2.  NVMe Hardware Starvation, "none" scheduler: The thread sleeps
        waiting for a hardware tag. Because NVMe drives do not share tags,
        blk_mq_inc_active_requests() instantly aborts to save CPU-cycles.
        hctx->nr_active remains 0.

    3.  RAID Hardware Starvation, "none" scheduler: The thread sleeps
        waiting for a shared hardware tag. Because it is HCTX_SHARED, the
        kernel tracks the active requests in
        hctx->queue->nr_active_requests_shared_tags. The local
        hctx->nr_active counter is completely bypassed and remains 0.

Rather than attempting to print the active count, the trace point should be
modified to indicate exactly which pool experienced starvation: the
hardware pool or the software scheduler pool.

I will submit a follow-up patch.


Kind regards,
--=20
Aaron Tomlin

--zpzfsogidy44d4pf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmm7QbcACgkQ4t6WWBnM
d9ZVMQ//cDBFtlJvLcTnQx9tnmMUIHr5eIR6qQCNfEKxFYy1FJMMFZo1gwq+y+Re
PstSH2f7fRRBFQqTXnI+LChelpOOf7b052H8NeeKMXmqEWFddOmhsn3vkUBoV68X
ls3cuj+Xu9UnYDSlVOUdei3aReEYzZ69ZTsLBNXt+xuw0gBXW12ny2TJsnnIsd9S
dOLs1DDMn2kvMkVPbjwfFXRq/rK+j1okjVoy/E4qVinzOZQYA7nGB2NIuRLeH6vi
MUg15Tyn7zwC8wDYUFq9b89n/8F3yo1+mbQAEkrpTHDnBvf1ZKLRLg6CQqpHQZ1L
6E3oihTMondkEnOsdj/eoO+531H/fhRgO0oQuBDZyQkS0BuGoqQ9MagtDfarnD/D
52iLfZRHVHYMdpXDOt90JgOUDDcrfrEuFj4eTrG4KU7lSDh8lse/qZE/gNT0rEn6
Luxk3Z52vCfMq/fMG1Nksjset8A2aNQrz3zutvFqfu4I5I1WfX8AuClUdFo/b2s7
j1Sl9A9v638AgCizf9G+lY673fX3pSlhrqAGcNNV3ZBUWguGAKIw8qJxMR4H+rH1
lrjS0A0k8FcF9MoKRdturYAPtVc+A2ACjNNGwpauiMNHN8C6/SwoJM/Lu3Pg0/PG
0IIZRkEGiY6ovA8FQKDe+MU5kT1NEOZz0q5iyQB54prgHnIRfoY=
=REyE
-----END PGP SIGNATURE-----

--zpzfsogidy44d4pf--
