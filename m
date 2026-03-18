Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB22135D7;
	Wed, 18 Mar 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840092; cv=fail; b=OVk4Di1HKubOBWLaY3CBLz0ZvR48ouKgZQx0Sv+wT0fhwfjYaXOvZXChvYtv/t8TSVHN6PLvSrP6u7IVuYIZR+CBn36jr9H9XCLDdSVZv2mKLuTlUn+YwR6PhPkqnFtzmkftufCyQZlX5n8sh1rpKW8cnu313HKTpyg8y5Jm2c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840092; c=relaxed/simple;
	bh=T19Rlsd2O9skxzGWw7PBl89EBw9M+TAhgYLC9zzDq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFg39Um8eX7nhtd3BOfXefXj62d8jbAGRON9dyttqm/g3i84Sh667l1DPRyQ4IWdyOeuluW832bHFKbgTOxsp/nkq4mupcSqDC1x8587TsoU/uSpDwWrvN5jzndaAuEtzLyNcJdr+nY/5WkLDjH3jetBlaa09ngxb2xUBG0fBdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+S6YWXMvugHfyb4iBReF3JybkgeqKzflHwReklbDlmzC35v49MbHhoJTpnObhsULwUXZOnhw4tOiqSFSpaObzZMqo4rz2akj0iy53qE9EP87MbxNcd/E6YywtdWN27eTAtngjnaGBiBSx5gJ/Ykt/I9aBLZjIlUu/ctQD1L/IM4ZYhYroEEkg7dcZ7DDKJoF8ZxMhc0pcDhmf6k8bA0z1ZvNXJrekbojQVUdB/jQNmKd6EoPM+i+VLeb4+wjCWaoEQ8LNuPdqdefH6VKtogFTMRjT+wjE2k9Ldo6nPZ2IJc1WhCFS0NqgcE/YnNrQ+ZRQSq6Vpm+l+F0MgN0TaS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQsEu3AlmpEFFtiANz1VNDj2oinYqqVRQ5R4YVQsG+0=;
 b=iWdpLMH+/uhs656ybkDGKASMqznXqu/9IyaD2ZxJOFMTen0LsEky9pDG9mobS2Oym/oxeTQY+582hpf4dygNjQy2MHgwN8yjNfsjUytjrZqcv6Ss2qLTGIAKaqiS7JATMWoVYnWkRYlyGqzKeMendD+FW/M3Mq4df/XHq/4w92tpU1UHDdndmHuzfnNBmJgBj3JIM5/0oZ4z5q8oI6jcAUT1SDqiEscROAxTUKOW5WQdNpYfHrAQyeCcb5y9pWZcjnnJ4ymxOn3vH88twTMbEhTqdT9YDm5SArYj0EmuiaqMt9NvvUZO9hLqpx+tRJKiOn+QobENnZSnH2SgZTaW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB4000.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:21:28 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 13:21:27 +0000
Date: Wed, 18 Mar 2026 09:21:23 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <lrnjp7wcrrfita36onlxqihep44sgr4il57ccy4irf2mortdqi@46w7sl52whmr>
References: <20260317182835.258183-1-atomlin@atomlin.com>
 <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrmavmidssja2xoe"
Content-Disposition: inline
In-Reply-To: <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB4000:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d83c6e-2086-42b9-6cbc-08de84f1428c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jY4yoQZJdJGedNpV4BE08M0v5Ya1gQKRZ5FzHFaALAijYrQX8+SAHWPGEZ/K1dQKdfaXGkkzqBAE3qH6eOJBPMQc4ElJr8gZbSHQD9JCFPPLkN88R4WAw7KQ25SZHsnU7f5J9DIGF/DWXOi9Y7ydrrhjtCQEP9cGXgv76im4gyL0XUq68S0mCohrgXxQ46rod13Q4R/t9DY7eMKiBoI41u0cfTnLHgIm/Qtr0drB7F/EcecK1z/Q9kierZpfvNiUvMLY8+19XmbePYZJYUuhtDacBOgnKfaM7ryL6xZeamCog52zdvH1Zp4uzk92D8P3cZo9kswW7ZZ5rF40XSwaZyirlttQnVU/msQbqs0TGCBrI6Z/Vh7Ur1bVh7Bhnga2tHEYpZ+5hQQSeCN28L53n+E1YnqQxIWNvGf6u2d3Qugt3NGpIGq/JQid6Q3V0rlvqHNGkjGuskLAO/bIpbozsApODBFwUy1eokVxhdIenfP3FKnAjYOwPJws+5QM7afb+k2vNuH3z5wrd8iK5ccZfJ13lWDbIJpRVz4EZUvL+iDRjQhHGa3Z4pc58iThnG4tAfB7YDj43gSQBqRsxcWdFuNftrB3ehlx2VSk+hsdatDe0F5WZuoWuwTUeEQ3G7k6PXYb0Pwylr50g8vYkDXAvG6+74OlPxhgw6GKVbFGNmEHRTK1wbGDoXzofDe1R+NBtwzKibi5k8g02Po+TYVvXIQVTRI6z6Hk5Aq+NAJSQHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0UxZHMvaVo3UHdEemp5OENvWXlMZkgwOGcvdkt0akRXTms3eXl4VThkMXph?=
 =?utf-8?B?dG9VMlRST1BjVkVZS3NZMXhBMVpsdkVZTFhHT056LzFQVFQyaGhyWFJ4YTFC?=
 =?utf-8?B?LzNWbElrNjZhQkNsZkhmZlpCdzI2ZDNwZERRcDdnY0dvUXVwSlFnWXhsMlpi?=
 =?utf-8?B?ek1pTnFZL2tpNjFpaUFZRnRTVjVTWjJvT3c4ZldpWmdEblNDbTJFbEQ3cHUx?=
 =?utf-8?B?aThYNUFUU1VDT2V2RTNsTW5HbFJhd2V4Y04rL0xOak4zSUMzWDNBZDRRQnNn?=
 =?utf-8?B?OXZOR3d6SWpQUm1GSmorNmg2akQ4SHAydDBudG1DVEtGWU91eEpnQ1JLVktm?=
 =?utf-8?B?RXorSk50SlBZcUlHK1JteUhSdkhNQTF1WVFQWExPeE1ORVdJbG9MVEJmVTky?=
 =?utf-8?B?a1VkcWRvc2xqRU5nd1hrY2R0d2F3enZRSW84Z2ZJbjhRYi82TFh5NCtDSUh4?=
 =?utf-8?B?UlFTeEowNnlUcktoTGgrcW5uQkpWL0Rqa2loOUFZQlFDcndsL2QwNy9pK3Iw?=
 =?utf-8?B?dmI1ZzJ4VjFjK2tTblJpbEgxSHFCM1R4ckl1S2NJL21TVjUrRjV6KzdlcHRR?=
 =?utf-8?B?WFp0dVhrRDFaWkEyNFd5UkNCR0ZKVVpqSkRROFd0M1JieXNhOVZsV2tpa3Ft?=
 =?utf-8?B?Y3RBbVkvNzhXU3JsK0w2MGpJSXdGSjUrb3ZFQ1lyNjBoTXptbm9mNFNjUmdG?=
 =?utf-8?B?czdzcTdSZnluRXFiWVc4NHEvRnhqUFVwZmJJL2pJVFdvUVd5aEhWY2FhQk1s?=
 =?utf-8?B?alhQanpUS3VRNklJbjgwY1NUUi9MTWZOVklRNG1BSmtMM1RCbzBrMkhPQkU3?=
 =?utf-8?B?ZEc2SHBMak56YjBHUTA3YkZaM2ZxMVZhb3YxOGRyN2tvMTRhdUFRQk5qWFpX?=
 =?utf-8?B?ZDZOYnpmZ0ltY1FGcWdIb1g4SmkyQjR1Y1YxL090aEU0TTFXVmVIT1QvTDN1?=
 =?utf-8?B?NjQvaDNGMnBTTWw5RWd2T2loTC9tcUtDSHhpZzh5Rkk1WDBaYWk5OXA3RlAz?=
 =?utf-8?B?dkk1eXdoc3NrYk5HZnhIMlRJWG9kUEZCWU8yVWxFZXdpOS85OTJuK2RJMFdz?=
 =?utf-8?B?cVVxZ0tZemptcXJYQTloUDVDbkxvTTk2NnlEZXVXbFpDZklRM0RZZ1FzUmNG?=
 =?utf-8?B?S25ZQ2xOOUJ6clJ3ZWF3ZXRzejZoa2paYWVqK2p3WHBsUzlHSGM2TWViSXhK?=
 =?utf-8?B?LzI5bUpSUXlBdnVkM3JhUStFTHVZY3RwSnlyMXYwd1REZU9sOXlCdnZZdnFH?=
 =?utf-8?B?dmV1a2F6VUw4SGo5M3hXSDBLY2kza29FcnhpbTdkQ2RNcEI3UTFTU055L2Jw?=
 =?utf-8?B?UGVmU2tTalRSeXFzY0UrU1ZWU0M2cnozL3hEUGdMdVo4TXdkWVlLK1E1WmZ5?=
 =?utf-8?B?ZTQ4N0R4L25zaGpmelphZnpIRGZ0NlNKcGF2RXl1T3FYNjN1K0lsNmxHQ0RU?=
 =?utf-8?B?eTlBVGc2elZJZWZGaUlEcHlyWGNUWXJwMko1TVFYZXdMeHdaWEduVnJKUkR3?=
 =?utf-8?B?VGZPL1dPaDVUbkpBWDBwNDNGSkNGYVRyMk9COGUzcWdHUUNiREpWV3F6Ym1B?=
 =?utf-8?B?Qy9zTUpEb2h3VXIxWFpUbjNORnAxcHRwTWI1bE9RME9hNmlDeWhmVkNUZDFE?=
 =?utf-8?B?SXhJL0ZKa09ZZk5NNk9MSVVpLzUrWEtFWmJsbS8vOUI3WS9zS0F6OUxuUmJ6?=
 =?utf-8?B?Uy94RXRadFRYMkRBRG9CekVUZXd4cGJ3aVNzYWhqWGJoWWtkMFFpdGhsR2sy?=
 =?utf-8?B?RnZMaEljekRObkcxeGFNR3Y2RDJIM0IwbElEMW1DbDlhOVdkaU5FWGh0QStq?=
 =?utf-8?B?S2V5WHF0TjdaMk5iTXNtRTlvWHZMQ2Mra0FLM29KL2NmOS9SKzBaOExuZ1Vk?=
 =?utf-8?B?UzN3RGZEN2svdXliR0FiTmJaa3dadXl6b245bjhBWjZkdW9aTmxvWFlrb2Jz?=
 =?utf-8?B?QVlLZUFpbXlxUThRWXI3L3hZVlJHWEs2eHFocDg3bjU0Rnp4YUQ3VHAyNUk2?=
 =?utf-8?B?UzV6SnIvQ2FjUkc5cHRMaG9maEpkT0NCNE4rNWFRRU42YU8wYVVKRWdBalRV?=
 =?utf-8?B?cVNqRS9sblNpT3ZsMUtERkE3QkRtMUFLN2ZMWXhVckZLWU1aRklIK2hTMXZo?=
 =?utf-8?B?WjluMXVCZ2Ztdkp3VEZwZ2VDOUwybXAyOXZjSlVzQ2Q5ZWY3RFpGSnFna2dY?=
 =?utf-8?B?OW1zeHVheEZjd09tR2V5MG5pKzU3aW9sSjZhSVhwZE9KL0c2Q2JoN0h1UStX?=
 =?utf-8?B?RUJTYWM0Y0M1ZFNnVFdVY1A2YmgyL1FUYk9sc3lpcjFkRHQvZEJON3Q4YXNH?=
 =?utf-8?B?b002elRkTWltRnBwMGlkV003WmFLZ2xzTlFka3g1VVhNc2xyUVpkZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d83c6e-2086-42b9-6cbc-08de84f1428c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:21:27.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6xKoyIMF0e/ZO/xgeYIjUNR0BAMkf9okQzegu8qRVMu4PPl69RS0B8Fpb+M84Fw7fRNYv+9cYz3riZo1Yph1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4000

--vrmavmidssja2xoe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
MIME-Version: 1.0

On Wed, Mar 18, 2026 at 08:38:20AM +0900, Damien Le Moal wrote:
> Looks OK to me, but I have some suggestions below.

Hi Damien,

Thank you for your feedback.

> > +/**
> > + * block_rq_tag_wait - triggered when an I/O request is starved of a
> > tag
>=20
> when an I/O request -> when a request

Acknowledged.

>=20
> > + * @q: queue containing the request
>=20
> request queue of the target device
>=20
> ("containing" is odd here)

Acknowledged.

> > + * @hctx: hardware context (queue) experiencing starvation
>=20
> hardware context of the request

Acknowledged.

> > + *
> > + * Called immediately before the submitting thread is forced to block =
due
>=20
> the submitting thread -> the submitting context

Acknowledged.

>=20
> > + * to the exhaustion of available hardware tags. This tracepoint indic=
ates
>=20
> s/tracepoint/trace point

Acknowledged.

>=20
> > + * that the thread will be placed into an uninterruptible state via
>=20
> s/thread/context

Acknowledged.

>=20
> > + * io_schedule() until an active block I/O operation completes and
> > + * relinquishes its assigned tag.
>=20
> until an active request completes
>=20

Acknowledged.

> > + */
> > +TRACE_EVENT(block_rq_tag_wait,
> > +
> > +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx),
> > +
> > +	TP_ARGS(q, hctx),
> > +
> > +	TP_STRUCT__entry(
> > +		__field( dev_t,		dev			)
> > +		__field( u32,		hctx_id			)
> > +		__field( u32,		nr_tags			)
> > +		__field( u32,		active_requests		)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->dev		  =3D q->disk ? disk_devt(q->disk) : 0;
>=20
> I do not think that q->disk can ever be NULL when there is a request being
> submitted.

Yes, I agree. In theory, a race with disk_release() cannot occur since the
gendisk reference counter would still be elevated here.

>=20
> > +		__entry->hctx_id	  =3D hctx ? hctx->queue_num : 0;
> > +		__entry->nr_tags	  =3D hctx && hctx->tags ? hctx->tags->nr_tags : 0;
> > +		__entry->active_requests  =3D hctx ? atomic_read(&hctx->nr_active) :=
 0;
> > +	),
> > +
> > +	TP_printk("%d,%d hctx=3D%u starved (active=3D%u/%u)",
> > +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		  __entry->hctx_id, __entry->active_requests, __entry->nr_tags)
> > +);
> > +
> >  /**
> >   * block_rq_insert - insert block operation request into queue
> >   * @rq: block IO operation request


Kind regards,
--=20
Aaron Tomlin

--vrmavmidssja2xoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmm6ps8ACgkQ4t6WWBnM
d9aIIA//RTZFSpxcQWuULmJoM8iLaDzXjO7z9xyVps95zH8tW+KNXCYlRikP/ty+
NXqOTAymvozzGIZRgosQzm3BCO3JZ391UhZK72SZe9Se+ukyLyymH6GPQ7mgaGyq
VKIY833T7Zvff7q5SyNQpIFnIGV1clywJLg9MHUuYhGI+wqdgQOLuKwgRABJiT1k
B9VKagbHug/xyoKKva5kVKu52hogCSAzTNmguwcrQCLF+iDaLpGTYiHLZ6w5xhv5
qnWBWDTZ72CxKsWsCF3pvN5IsQB+dTPY7yyfQxWuB2/Qq+FWWHU1emBClIDXwjA3
7goE43jpboJ2Ea2mpTvfd3bEJfGUh4YHfbtllgUCrFiFNf8UExp36PBG4WWt+K8d
qjDKnRrmkheUQwOfEjbRUbTer787QtEMDUayhTXAq9P69E5IejlauODwxkMKbRHY
l+/x2hHTAugo6efC0T7fTQ/fkqxiT6qGZRjr6WlOuZ35Lb+y5dnRpqKORohdng85
WCC78ND2cyFD912JkCqs79OQnHWPmHqV8PAgLoFptrvD0tOPjK/XD16E+Q5RjrHg
r9xLY1Tf9aRdZm3m2QwuMbglnGOOUYfElfKDTheCz6TFzqfwrUIRznmAyaA9o3ib
oKB2pKXeMlEBYFZ93cKUiPwul8cFAgHQoZ6Kw9DJ/ZVaDJUogrs=
=uCuk
-----END PGP SIGNATURE-----

--vrmavmidssja2xoe--
