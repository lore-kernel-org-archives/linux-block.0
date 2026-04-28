Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022095.outbound.protection.outlook.com [52.101.101.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E240472623;
	Tue, 28 Apr 2026 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336183; cv=fail; b=EqMoN0wy6gw2AwUkBjWYTbUoEdjjdb0msjEs6G9V62zbqyhEKinXkPnIYC0bw1NHnA0V0GrlFqqwQh29vKXaKbM1NC+E/JvW8WmZjQ6awEsaG+UAi0jtO7abuobdsy+aMnSJuWw0sVsMxRUB7XTbZTW85b1HjxTj4M9gLijiXmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336183; c=relaxed/simple;
	bh=rAQnoCGTMwdrvmgfAXOcO6W1oZZks4D12i2qt48YLj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K1BGFeLJh5e7BjKI2InNLSXyW4tsShzhX3rw2DEwmNLkheDyd0rh/nV0g4Ym3/1z7QKRUtYaAXgr9qNNQv7eqjHIvkMwokdyQ64c9yjxtyh4VMAR1OTdWPWLSrdCRUfOPqxLhiNQEY5oyGpgq1p+vfMwAfFQCC5OieWGkY2C74c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijqCV8wYi3jBZFgG4ougRPD2YYkEYqqil5tE5I8p4fBmcuLLZgztmCXBWzwa6krqr7JcVw6JFQAYpSF8Mb+b8AE3MSkb4uXH4oDeheekDH44yb6QAz78oIROdxYCdiq5/QYnkZeOjCrIkevSMdXL4M4Inoi6Bma/Ab81XYPautgTiqnExJBYT8CkEcw28bAujdjnpSJnl903AcLFsg1trMqQdsyN9vaWdbOk+pJMPB8kHtWA1ZV3EkjIqW8d41oTl8Y/dKI2o1EvmfxBp5MyjKUbNRLgU7G9pR5Eit293s5rKqwCNpixFURK1ix1IscKdQ1Qsl0ldPnvHbrvRyCLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy3neNngb+HOcW2D+LmP7EFja7NLYEc6pJyuYmAYldg=;
 b=oP3nus6kKMvHlldkxyyU/WkYYbo/0q4V5yXlWUoAy+kEZqqVgVNfoVk1E46qa8So3DryIreCr9pzPGNTySg9KJY8cihOCUNmFBaORN9AvNKYXBZY1moH5eL26Jfrs5I1aIjlm7U8bIk97DCEnOaTL8kW22g+BzGRM1t/3wTF+QbOFUSFDhPOEZAbOusD94jQD0IIXjbH18YhvFqLF80Fx1M/HKXzt33GVwP3ZYWjtipSPTCJlR7oFjuI/kyoCivsJwFUvfE4CIMnG+bcUKG2OJK5cPxmzwp3V6AgLT+YLzxoQ7/qOnza57EBODq50agaZ5VEgq34hZUYTg1FE7PNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB7445.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 00:29:37 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 00:29:37 +0000
Date: Mon, 27 Apr 2026 20:29:33 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: axboe@kernel.dk, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org, 
	ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, sean@ashe.io, 
	mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <qoob2vskubani4n4kqtrxjelh5yuowj5i43654l5p2kcutmjhe@hn44mdbpruu5>
References: <20260427020142.358912-1-atomlin@atomlin.com>
 <20260427020142.358912-2-atomlin@atomlin.com>
 <20260427123848.1e6b63d2@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrpsvuh2xdtzfmok"
Content-Disposition: inline
In-Reply-To: <20260427123848.1e6b63d2@gandalf.local.home>
X-ClientProxiedBy: BN0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:408:e4::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 919fb58c-45d2-4e6e-c354-08dea4bd3a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9r1f1OM5Nu9Bs4iDy0WKMFVF6Bh5BX+jiLMZv72MnXEkZmAwXmExWI0z2Oc00g4sUxso+VwsmSvM30nUoVBNbmRzSY8KJSPX2WLrx9JqomxGcZV7yOAQiF5VYsmUyE/vIbAZgKOb9qBVAGAuKRRI3dtCOmSY/08a40A458Zu0OD51KyQ+BPgaF26mi9c9j4sZh+xEWWYxbummtDcofrt51T9aYGys4joAvqo0hKs+oftkomN+3SWndU7mH1HHRLPjssc/oUzt+1f2YEY/BiKSmqJbEjmiZde3hG9WBEwrHttlaYBcmDTBJ2KkUl3INHzvvnx2pAMs4HYtnelsKHdqhyYSLP/ALTH9nNeTalTDhLIiuHpFBQwwuVa3nS21hpt0CZDi50o0anMhuvkUYyvame3TwRF5B4tMRV0WSXU1jGC2n2rTD38S8Y+QlKa7cwxPoXj8WsMM2ABnDd+eSEpRE2ztoAt67nHPIwzxNPNKzQGBKJ4uWtVusFGTj32KYMALVqn5xQv1un2IzKtYYjJKU6EHlA93aTBgTxbYFKtfkcnKzG8mPYOMT5ZU2jIPRk9+SqIjeuRsWBTBRSMByulc6/eigSOGkWOEYg1nevP8HznlJgkTtQ3rWd+xVWwWOH8IUNDFQjKHGkZJqnlpqbPeaEgThEKDxb6k/VVPwTzxvHTyybTrxlieDNwygc82jHzaUHED1W7aIhNXlzSDGNesgMdjTJJqxAfRSXBvQw+zKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2t6TGl4UG54dWNrekQ1MEVkRnhYNXplaEFET2ZxME94KzZVNjhNNTRRbGNI?=
 =?utf-8?B?Qld4UCt4b0ZGSjgzQmJDWE5aK09UcERib1VBWWQ4a2IrQTE3NzdRbmRvcmpk?=
 =?utf-8?B?RFUzNVJtTm1WZHhkN1pqVThjSjkvTXlqM1QxaHdyQ0ZYSVpFNmE5VXVkNnVp?=
 =?utf-8?B?SjZrdHpLVGFwY0dIdnVldDQ5WUZSOTNoRnQwNC8xSlpkV0N6N3VuSFFhaVZp?=
 =?utf-8?B?dW4ySHFCcmVVK1dDZHZ4MWx1a3ZXYUVYT1dWUDB3NkJtQVE2RXUxZTFmazFT?=
 =?utf-8?B?S3gybFdlZUV6Y0x5WkQyZG5WQWZESXpmSE41T3pCYjQrYWhDcGpGRTdKWlZq?=
 =?utf-8?B?T2xaaHhDZ21SWm15MThHNTNSdXZEdzlBYlhxQi9XSFNpczFQdFJ2bzI1TGlv?=
 =?utf-8?B?LzdRL1dPNnFhUjBHa3QwUjFiU1ZWa0FvUGlSeFRhSXlMSjgvMG5iQ3poZkNK?=
 =?utf-8?B?dWRWRHFtTWgxUTltS0kyR3J1RndRSnpwSE1adTl5MWtZd0ZudTZNN2kyUFZ6?=
 =?utf-8?B?SFlaSTVDYWpTRGlPTFpiWjM5ZlpTcHY5Z1dxbjZUbXYvUmI1UEZDcTBwUGlO?=
 =?utf-8?B?OEFNNnMrdnkxblJBVVErcmNvcVJxeHZGWTExS3dQK2ZBbzJMQXQzTFMrWDdK?=
 =?utf-8?B?OEdLK3owV3daWjg1dEdwVDlvcUpqaytEMGhvOGRsL2JEdDZsS3JYUTVQcGc3?=
 =?utf-8?B?ejh6UWxWTlgzTUxLSk9EWUppRlBnUzZ1YytaNGYxSS8zT2tsMDA0Z0RsWDFD?=
 =?utf-8?B?QmNITFQ3OUNlc1ptNUpwd29BeTVWc2VxVGhPbXB1cFBCVk5YVXE1cTg5TGJ5?=
 =?utf-8?B?TkJmYzJRTTVVWjQ1TXlWelc1djNJell6cHArRW45QkFvdWdVVkhBYTJIREhK?=
 =?utf-8?B?dDRudEtmTWZNWUtyb2RYYXoxZXIwcXloYUl5cEc5VGpXR3RMMitVSTV4d1da?=
 =?utf-8?B?RnkrRTVnL2dKSSt6K3p5Q0ZXY2NYd2hqWUVnR0hSZHlSMWJ5cWhJZnA3RDI0?=
 =?utf-8?B?V3pPUnI3UUFBZ24zRnNyV2pMaWlIQzJQbXB3TktWRFd2NG1MM0NPS1A4R3dx?=
 =?utf-8?B?VmN2QW02NFkwVTdsQUNKMjhmTkRENzRjNWM0dUlKMmJSQ0NnYkJjcThwU3lu?=
 =?utf-8?B?YkZPSWtmUDZPZ3FkV0JDdW01ZXhzdllFL0FRVzNBam5vaDFOVVV2Ump3THJI?=
 =?utf-8?B?WWFBUUpvTjZTNDd4cDlCKy90ZnFMRzRuUEFkRURHbTBZNzFsYmVEU0E5TWo2?=
 =?utf-8?B?SUgzQjhTSng5aVQ3WE5ucVgrdGxEbU14MGdTS0tjYytXYUQ3Z1VxL295UWU4?=
 =?utf-8?B?c2Y4azBQU1dKVEo3UnJEZTdzS2ZrdDZtQ2lCMlJaQlprKzFnd1RKd0FVb1hY?=
 =?utf-8?B?QnlWd2UwUzlkenFrWXZUL0UzU3NlNXVDcm9Gcjk1cnFpNlpxYks3WG9HS1FE?=
 =?utf-8?B?b1dqQzdsZTAwWWttdDhmbWNlbWp0Sy95U3UxVGEzeFBWOVczTUFjcmNhb0hQ?=
 =?utf-8?B?VUNYT2JpdXVHWXMrK3pnVVlWVm9QM29tcWcrK3V6REtzYlV1b2N2aHVpUzl3?=
 =?utf-8?B?Zlp5MUphQTZKL3hqQ1IwNzF0Uno2cUNSY3NiTXhZci9UUlZOSW51Q201L3hF?=
 =?utf-8?B?UVVzazhOSTVyRUFuMmtUbzYvd29MYU5KZ0lGakE1dXBFbVY3dExINUU4WlN2?=
 =?utf-8?B?Q0RXR1BnMXF5dWVnNTNzVC81L0l0N2FqelZoUU1wSTMweTdWczdmb0FscFc4?=
 =?utf-8?B?Yy91M3pVNy9GYWtqdGZUc1hxaG9ZaHVaY2FXczJGRjZ1cStuL2NMaUtjcG1W?=
 =?utf-8?B?Z3VJNkt1Yk1MMnBLWjlrNWhrOXhLQUU5VGxqTG0xTWVPTjlwb01tVFFTVm1U?=
 =?utf-8?B?OEczWmZOUE9DekZ2NGIyMlhMZXZ4RExKNVRpWm1abjJqSUMyUVlNVGtBa0tN?=
 =?utf-8?B?dkI1MUFTdWtrTCt1Rk1KeGk3NEVuNkptUzFKMUVJK1pZcWlhRzdkQ2hiQlVY?=
 =?utf-8?B?a2Vya3lYeldOMWd3a2drZ2p2UmdjYnFyWHlzaVZXUFlrNjBwZWxrM3VnamRo?=
 =?utf-8?B?MW8veGZwL0ZBOFEyWkdDMElneWZzbzZSZC8weHdVWm9KMDdLbUUrYlhoRjRt?=
 =?utf-8?B?NUsxMEw0NGhRdEpveSt6S3lYc09sQUR4Y0FKV2NJRUVmcFJxWVNXbTZBbGlE?=
 =?utf-8?B?SmNqYW0xdDlKaWgvRXVuS2Y0Z2ZvZGVPUXhZekY2NWVGQUUrMzVzcDVOVmMr?=
 =?utf-8?B?cjJLakVqTmZVaTI1dmFxY0pFS2xTc2V4QkF3cDZkRjFoMFFXcG5WRzhjeENT?=
 =?utf-8?B?eHdVQm54ck1zSFY1Tk5nK0tJc0tWbkdJem1pSkd0QzdYQ3pRVDhSZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919fb58c-45d2-4e6e-c354-08dea4bd3a8c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 00:29:37.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pd+cYEcx4jXsUgloSqst8BiGogUM7QewboBtzjRS/0tacuEkhK9sqyuKotZDk+AaCZ2NNn+kCDOkzji+fAknw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7445

--vrpsvuh2xdtzfmok
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/2] blk-mq: add tracepoint block_rq_tag_wait
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 12:38:48PM -0400, Steven Rostedt wrote:
> On Sun, 26 Apr 2026 22:01:41 -0400
> Aaron Tomlin <atomlin@atomlin.com> wrote:
>=20
> > +TRACE_EVENT(block_rq_tag_wait,
> > +
> > +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx, bool is=
_sched_tag),
> > +
> > +	TP_ARGS(q, hctx, is_sched_tag),
> > +
> > +	TP_STRUCT__entry(
> > +		__field( dev_t,		dev			)
> > +		__field( u32,		hctx_id			)
> > +		__field( u32,		nr_tags			)
> > +		__field( bool,		is_sched_tag		)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		=3D q->disk ? disk_devt(q->disk);
>=20
> Hmm, does the above even compile?
>=20
Hi Steve,

	TP_fast_assign(
		__entry->dev		=3D q->disk ? disk_devt(q->disk) : 0;

I embarrassingly dropped ": 0" from the ternary operator while preparing
the v5 patch and failed to catch the syntax error before sending it out.

I will fix the syntax, verify the build and spin a v6.


Kind regards,
--=20
Aaron Tomlin

--vrpsvuh2xdtzfmok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmnv/2wACgkQ4t6WWBnM
d9Yjzg//fklZKGRKyICocLCO9C9vz7I8oqsLm6DFXAoMh+aemBnUCqaYC1tQR3ui
HomC549iJjV7zmaFF0kNOcGNitkpU+/69ATQw0oHIctL4Tn4sJxqmnKbkOPDaRs6
LibEkpaFhXB49Bo+0Y9Zp4UqeQW6i1VriyDrNg+K8r97wl6XHMESKn19fvjl4qWg
yh0fuAHSqcTj2ZFOzfmz0fJ6VzBnILzrLs03EQbvlX6n08cyZnwcDBh+LQDA1FpB
c8TPgVWq1Eq1Z6zTfhIvMeq/d4t+qr33n7IhnSdyHVUvZWy5aJQ6ir4QX86h+pXb
OvyTWN/AhTeASCPW1qgPhcF6XfgD4x0UBrKVtHLwCEdRjlW5RxagYLrJjGg3w20i
1kPCa+gKywRSM8MgHnhgzhETLzx+/NYRMvIIayHlfQYDFvvF2RcJqczDRDZp8sFI
v3Hm7LETtRviwj0E+xnKp601TfTexTBY5ljdQ0RWPs5bEI9EhHMAg56c7P3EpOKs
0ZsG1EunCiFvK0Wa/9DyvXnXLJje9mJSF1LPdEkpWCMpr56AjKC2QQiatymBoztI
cKiD9pqLVSQw8I2IqU6qq0ebvuzoXFknYmOpCsE155ZGoYNMSswEJKFQiWRjrG8n
BPB/lZPfmmQuhWo+zG0Ndz1N4f2mVPukFGfuLaMnT0hdB+rpBkE=
=iUMl
-----END PGP SIGNATURE-----

--vrpsvuh2xdtzfmok--
