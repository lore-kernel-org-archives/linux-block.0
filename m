Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020073.outbound.protection.outlook.com [52.101.195.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE32765DF;
	Fri, 17 Apr 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449756; cv=fail; b=ZzoHyAg/2XKf8kRPWdKUp/OqU961SNGh2BQvK7JTF11CQKXBTk6qz7fk1PkZUL33n5NEDGhCam09Ytky50A1oSoGi3NwqItM6Yvuhf0ly5MoS3Wu0BDEmE+GPvtYvSwQmyJaEflKuaXkiAAS6dbCg6rpbvPGNUjCEzypDrPCbYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449756; c=relaxed/simple;
	bh=ZPtn1Of+yMMxgt4T0aKlusBTW7nDsQqr7+bGlaJRd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FHCn0OJGxbZJV0VI3JUuTUkEvjZI52nuFHIPPgFzc+S3ee87GM1L7xQXUzn0KCHKc2hQ9nqxLgjto+hUvBjCeXxL5kIFvIbn6DeuD8r6c3B+RW7CCsbx08UZs7SThxRgOh0KkEl+w8fDvUcv5BFCS43levA5YryV1bhif8X5BZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXDt/vWgfkNmv2UY5BvY46RePEiavdiH/haU3gWgNSYqO9FhQW4fklgl14RPkWx8Q3yA0ahtxq48mOvipA8gWutyDewEBRVbnyDkhxAXPNk+shfqkI8pehrhkfPwyzB961Dtuh18qL2Whay9hOzASRGmLPCPnFJ2uP55GreufyyaVXsLP273NoHTVcITfKHfqs/L97fiv61OOVeBmhxwpzRV3rKmoxev6/zYnue+ijbmQzTlclL3ogQ5MFOMURLVo83W4fKJaUN5RwtFG4BNf6zZ2hcOfTv25q2yz28epUTdt7MLapirH91g1gNwzeMbaoLH7d8OPzaAR7E7vc0a6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGRCaMYFX/7K3NJlgLSPITaa55m0WfSzyKFEZFb2BqI=;
 b=P2y2p8LcdVukY7Mok/C8Epom7/3IMX6mWmSh6MuuzImvV1hj+eQH6h55r5VsdZpqeSmRFaQTTRpIACfXfit7YrMmMk0LVqHej9CJfgLVglau1TYA8p2EnQB6ktkzNmmOhbchIDOV1E1YtWhKKe3AcbZ/TcESxREx+al7dQuhLntF0WdFs9aiLS3Yt/9hdZtvWDOyhrmGqxFVU7PfW0qGezBgpGhx9F2ClJDpbL95tQCwrm20UgQY/AfvSlyBv929ru4elHr7jSbeYjEhcZmRK8OU0147oMF85nxT/t8OfEag78ufRMBRMasFxDDapOuPfM1rQcfD0PEtRJ6iTV3vlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:490::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 18:15:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9769.046; Fri, 17 Apr 2026
 18:15:50 +0000
Date: Fri, 17 Apr 2026 14:15:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, 
	sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] blk-mq: introduce tag starvation observability
Message-ID: <rgun4ex3t35ii346akdlvupfj23dq3dlanhnju3ynyp63xtwj2@7zg2hxaojqff>
References: <20260319221956.332770-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aaats64tqr2s4bnz"
Content-Disposition: inline
In-Reply-To: <20260319221956.332770-1-atomlin@atomlin.com>
X-ClientProxiedBy: BLAPR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:208:32d::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: ac20d600-b405-4ffd-bf6f-08de9cad5b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	z5+Ms45Ijekz+ijlIFRLGeXudRXvpheBI4d/J/vVxMfQo19K995GzrAfjmDrIbyUtosNalT05H++e68gqBpctzbgT/yMmvrJ3LS7Sl0+9fZyNi61Vi9Rg2cGpkfUk7gH6d7THr3jPZnDPEq5XYh82Uv27slKg8m9GcqRj1IrN52SsdXdc4IDXEyFc0TjU1//hh36ztK0x4jSbaxJNfaWwyU5+9i34cJJXGJ/bqrYN67jUhSr2m3TtJdhtIA7qVJ18druT6MlWxpT64yrBQGNC2YWbJD00qtRXArI8OMYl7usgjbbs3vNJ471fVTnDP3h3iVxzunBvQfqWTsBJkHFtd/aXhPCe3zMV7yKFKDLn2O1AAtDoywTS6GPMP6IlumvRk5GZpQ+Zqp3q/vZj0t4SfSlmFPTOFNCtYOumyBjAzT4hwfG2k7fexwurr3KLlZZ1OQigftXnUFMAReUi/lIfIlsqX9dUwNg/q6Y1E/T6tkIWsN6dmnEU4zAT69KKG/dZY2s1pllFT985Yh+zaSsh5GcvgL3zO3Wad9uAI2j/Cj06TFBH2Ji5UQjzQfP2wYtnNZhbQNA4tzTg2HkVXfQHtperlQ67AQjm/ihY3tQAgbh9MNbyHt1a0nFutun8n+b2TlfvtPtGh7LVa+xzcLLtHpMurfpmn70wESFRVAjcyyDoo6G1+XzN+SPEGOHHNZej1Jv6+FPIVsHEZIUpdGcTaiSjmaVozMvAvXrBfCXN6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1dDWGVLbzRnRlVGNmZzOFY5TEFkRXc5T04vRFdVME5VS0k5SndnbDhLT0NR?=
 =?utf-8?B?bnQ0QzhXRUZXRGw1UnM5WmluN0VWYkdvWkUyQ3VESk5UNzM4cE1na1E4b0tj?=
 =?utf-8?B?MXV1eUZLQ0JmMUNQQlBsRENkTnRZeXJqUG5md2JsWDQ1QmVYcmZZQ3l2amFY?=
 =?utf-8?B?amY2a21xSmRybFB5L0VWL29WMTNZWWZzVE02QzF5YjM0YllmQkJRYmRGRGYx?=
 =?utf-8?B?NU9lVlZMN3NZMDhMOTNSVUd4R0Q5R1hyblNSOGdwbDNWalB3dE9RZjUvSUdY?=
 =?utf-8?B?REZBamNZMjNvMjhBUS9DR1NOU0hUc09FemQ2WHMrN2JYaVhncmFjbTVLWDFN?=
 =?utf-8?B?TXN1enoyMks1My9MSTg0L3FGWHNjMXJ6K0VyNmJXdysxVEhwbjFUNml2MUgr?=
 =?utf-8?B?cXFuS0JWcEE0NjN3TFgzR3dIWnRzRzRlRU5tOUtnRGNNbTh3a0pQeTV1N2tJ?=
 =?utf-8?B?MTN2M3djYWtZek94dWs3bzQ1V1pmOEl5TW1wemZwU3E0aGMzT21UdHFQYSt1?=
 =?utf-8?B?QmtHcHhUYWNBblN5bVRLOHE1MmRZTmU5eDd3Sm9mNSt1MHBIdWJtcy8ySEtn?=
 =?utf-8?B?TGhiNmpQa1N6aDdvSDN5NjFmSHY0SkpFT042ejdnald6UzdvcktWZWFsNFBZ?=
 =?utf-8?B?eXVTeDRHek9tY1IzeG04eFdhZXpKaUxCRHpGTnpkbmpMSXpJRzNNMHJGaXdC?=
 =?utf-8?B?a2VWL3kwcVZXRk9GWEZ4M1g1eUNyMGpsMy80VDBIZUlkcHZYeDM4V3QyTzBP?=
 =?utf-8?B?UVJVRXVsaFZNcS9HY3dVdjMrZmhRVnJWQ1J3c2ZRbHUvMmFEWC9vY0lwR3BO?=
 =?utf-8?B?MldjN25OdmlqNitpWmp1aTA3WWtqbS9BTUIrN1RBRDZlNytnYzJOVFFMdFdt?=
 =?utf-8?B?dWVnZEozelU4bzRXU1Y2bmhTMmVsYWMyeHN6dHNQMFEwOXBrOHRIc1dBczZK?=
 =?utf-8?B?bGZwekpSb3VLS2xaMllTY3pZTXNHZ09JUmNSc0ZpOEY1SURkSTFvd2NQUkt3?=
 =?utf-8?B?clBtSWx0UGlWaUFrcWVJc1BQeFRGenhtTWxTTVc5RHQxMFN3YjNCN1BUSlcw?=
 =?utf-8?B?MTVrL0M0MVRCUHhkeFJCcXgxU2xoYk9jSlROcHRaS1pERzJvRlRKQjg4SFp0?=
 =?utf-8?B?bTVxa1pmSElDbmNYam5Wczc1c3hjcE4vVHYzNi9aMER2eHdob051L2NCUWkz?=
 =?utf-8?B?VEhMY1pJR1dUUjNIb3FCdmp0anQ5T1gvdldudGRpaFRFa0Y3eWh1d1hOaWJ6?=
 =?utf-8?B?bUhaa0ZicHBFUklQMUpBK0R1NU9aeWhiZzdwMmVLZ3RvLzdWY2hrYXp5VlM5?=
 =?utf-8?B?QUNkUDdYMjE0Y1lTdFdhVTlpZ2VCVFI5R2NRR2h1SmlYZkE5eXgrdWZqbzAy?=
 =?utf-8?B?M3lNUXFlR1JLNnJJVGlEaGZSMHVPSVFGMEluRjEwempCeXdFaE1CemNrSUZr?=
 =?utf-8?B?YVZuL0V3KzJaMVNEVG01Z2Z0UGc4ajRtL0Yrd0FDODR3K1RMZWZmQmh6UGRL?=
 =?utf-8?B?eit3S21VZkg3S3JXb0UxS0xnaFF3T29aSURTQWhOZUxIRFcvRGZpSDBMNUZG?=
 =?utf-8?B?WnZEMGp0TUNoVExTRXpIREZleEMvVTJvdDdUVS9ocDFCSUE1V0YxcmpKbUQ0?=
 =?utf-8?B?RXA2RmFNZElxNEd3WFlnL2xvcUN0ZXBLaytFSWJzczNTQ0k1dmZuS3g2WUE4?=
 =?utf-8?B?RmprOUlHeDFRYzE1ZmZidWZVYnNUcFM4Zk9zeTQrSHIzZ1c2OUg5Y3BUN0Jz?=
 =?utf-8?B?TkRvWVBjRTlmak96ZXlMeTJHZUxiU0xNbjZ5L1FIUkhRLzkrOGlLQ1kxMmlw?=
 =?utf-8?B?WEV3M2kva3YxbU0zTUVKenIzVlNIOW9lMWVSSGU0S2JSdWU5RmJGOXlVdlRv?=
 =?utf-8?B?WFlZSzNWbFh4U1RVT0F0SWdtWEpoeFluTlFYVGJVZU9VSnlwMUdVNHZ2Q2FC?=
 =?utf-8?B?Z2hpT3VEN2c1U3d5RWtGQWoxMVpFQWpaaERwLzE2RUkxOS96ZVJUUjRKK21t?=
 =?utf-8?B?akI0bGZKajkwd3I5OTUzUlpwdk9DaC91ZWxwVzZyNUxkekZqUEFOS3V4K29K?=
 =?utf-8?B?bFRiSVhzcGVtQ2dtUG8rczVEUmlWOHZYN2VWZE91djcrZXZtVzl3a3dSTEtH?=
 =?utf-8?B?UkRHRmV3enVQa1NLQzNXZE8zNS9Ja01HbEN4eE5UYkplQW5TR2lEN1dCMmJS?=
 =?utf-8?B?U1JtM0kyZjJiRGRKMlVnRTd0dW0wNjNXdzZDWlpxb0xwZG8zamhobFVHSWd1?=
 =?utf-8?B?TXZHc2NKL2dWaUhmbFFpdnkvZWhYejR4S0FGRlBFMzZTUW81WmpIaW4zVWtL?=
 =?utf-8?B?MUdlWXNYL0tpby9PME9iTzltM0lCd3RiSmV5S0VtMjkzdGlYMksrUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac20d600-b405-4ffd-bf6f-08de9cad5b13
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 18:15:50.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzgXKNLJCgafYA4Pmsg+M9MD2SRoNJdorlhwTPzl5kucu7qdsQg4MqLGPI4UoFRgyR/6k4RsiNuhykES1mb5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8521

--aaats64tqr2s4bnz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] blk-mq: introduce tag starvation observability
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 06:19:54PM -0400, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising RAI=
D=20
> controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe laten=
cy
> spikes can occur when fast devices are starved of available tags.
> Currently, diagnosing this specific queue contention requires deploying
> dynamic kprobes or inferring sleep states, which lacks a simple,
> out-of-the-box diagnostic path.
>=20
> This short series introduces dedicated, low-overhead observability for ta=
g=20
> exhaustion events in the block layer:
>=20
>   - Patch 1 introduces the "block_rq_tag_wait" tracepoint in the tag
>     allocation slow-path to capture precise, event-based starvation.
>=20
>   - Patch 2 complements this by exposing "wait_on_hw_tag" and=20
>     "wait_on_sched_tag" atomic counters via debugfs for quick,=20
>     point-in-time cumulative polling.
>=20
> Together, these provide storage engineers with zero-configuration=20
> mechanisms to definitively identify shared-tag bottlenecks.

Hi Jens, Steve, Masami,

Just a friendly ping on this patch.=20

Please let me know if there is any feedback, or if you need me to make any
adjustments.


Kind regards,
--=20
Aaron Tomlin

--aaats64tqr2s4bnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmnieNIACgkQ4t6WWBnM
d9Y6ig/8DU3QfsTlMCl+pQzb3kHt5rk6YnXFURKooZpeGhirhH9ALkmrKLYIIRSS
jCABZpIGFnDiI7QIo0x1dOnLWmQYLeHZRBTYV7DSQNjHQnX1Kj3h7/69W3U++q+W
dfWADjgiitFCiHrX5o0uXX8IJyF+Rp/r3qB+j98If7T4sdlv4RLtRdDXiYuIX7z2
BPOW1ffgmZnXqMrWOy0JfPPBEP5QebxjMj8i21GW0d8oq0Xd+lc2ENNlsXKwcvmS
+GFy7sUwUGhze1KQnht3Pjq0GqjwcyL818NmiXnXvKnXIcxdogt5D5v23upoFmHz
3Fu5on15ZF9HlWE6yk0LMz0J6UYhWm7oowEEsee19PsuCfKO00+d34r/xj4gAMBN
/sbUCih4apXtLv5qOweefEpgsRiy9bE2jOx3Km7DtMx9SSKqEMcDEYUopCT5vr74
BlaoSbPkqIBC1GJPtON4gOKPcgbSyBYfdwQnK6F8W6sBrTYai+YELOqUC5UCtXl4
Rq93XmXJ2NKJB2l3SHumFwfXpT1STh03wW3BQfEKE6DjO0XLvXhLSdlTBPQ0xB+c
Keqd3Lb/EvoMhuQn3iDSPN2PX0+2qckFHrqALMB5r7ZZ7nHali5hepeZRJ/Rh8nv
SKnbgOVeFf6beNCzPo4lRvCWI4oQ9BI1EUBnCSpSMP07uXpP6i0=
=s6kv
-----END PGP SIGNATURE-----

--aaats64tqr2s4bnz--
