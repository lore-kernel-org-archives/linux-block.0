Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020092.outbound.protection.outlook.com [52.101.196.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF52836E;
	Sat, 23 May 2026 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779580527; cv=fail; b=EyY55LALCAYli0WQH1gI/31qT79nke6ePuXyIHbaQg1cl5H4GTwiylVOJTnPSCNrBAhWYZStB2eg0r3Ne3H934cA/fiz7KBezEVyenXrHsL6R41vrg8Ga1elfvsAdDZKipBY8+07RRmmwrvm7jIy2yYTpRyzlKwr+IFK4T5WxBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779580527; c=relaxed/simple;
	bh=gq9+BBrxUpEDnT47aOgr1KpeDRxsNdgY+0xsy9vgeok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sAQMlcCfJBaAJqbc25/AYv7DpYHWpYJFK3jZibhnGGfKne+y5Xf0aNznS6beItvPYI31QBR+7pktSRYMZ8T8+GWkn2ILaIZesxvs7Gbsn6qL8Cr6KP734XjdqPTl1gatwwio21OjYaE5BZxWQlGC55Tg8X1tVRG4m1VC5X0/DQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiW3lGoyq88UAoEkEbYKkPMkJoY5mmmwB60d46KfrQ+x7o+P3Fk8SqF3eebC2t8tbaEcnkygqktMLF1j0CJZCy76rsz+7v8jx9c6ksTTld/PTgBotsOAkPyWnhN17TMOTp1O44d9+D9mWAJJZsN07l8UOgdqXGs0cPuew3A8GWo+65E+dey0/n80em/x8NVj3+jon5W0hXw+VbRRCBHINEjr5J7k9hhNB78QD9yGclh1P23/d/wW6Rb+VuDmq6oioERVEalAuv9naj33Ap8Z9Q89nB6+h7lndcKGSpRXSho6dLQwo/lZPc19UXZn0kopyUKBEPldg2G2SiIfgISb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcHNj8zR5SU5P3kEEbrpJ8FDy7FQoKz6Vj1/ZsKBqwo=;
 b=D6mexuOGdEohQLNASpUjbFCv6i3Je6S4U0MkYHlFpnQYk/Oyf4tDPscNz91KepYMZToh/sYrDe/gCo+7YH6DuIpDY0IZ7jpuOXokBjySTjuqdievj1c1ESNmSvhj4fYnhGpQwjr3pEq4ATXa6ySohEendJWbqxwYXpcgfFD25ARw6ZGtMRE0tdCMqDJAHhG2REU4pph9WQtq4SawpXASF0Pdm1sOsoHQuSGHPFAfrDO/HjwQkJA7ZfBW/ksGOSPkGDJ4bWRuLHv7zT96qy6M465WXUEG9FAow2BwTskU1pbH3bHPavr9JHFlzPTEts08XvkQQRtS/a+9leIIGEGy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8210.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:434::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 23:55:22 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 23:55:21 +0000
Date: Sat, 23 May 2026 19:55:17 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
	dlemoal@kernel.org, ritesh.list@gmail.com, john.g.garry@oracle.com, 
	loberman@redhat.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7] blk-mq: add tracepoint block_rq_tag_wait
Message-ID: <q7exvbi7zaxcqo7wxaniriifibt3zgzvij77iffgx3tyyn7vnb@gksmtwk5ziuo>
References: <20260523200942.587199-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwe4jmhkcjqtvyzn"
Content-Disposition: inline
In-Reply-To: <20260523200942.587199-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0453.namprd03.prod.outlook.com
 (2603:10b6:408:139::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 129da628-a9b3-4156-94da-08deb926bfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kgyVYi0tmJtghipREoqsm/bmpCL5yjQpLfHEk9zESK1eZJZO6P+dyffdpo2DMxhgWVH1zuy33zYvGBuXzI90SHTaJJmc/oYMgafzdB6vagVNIw8QycFbJecf8gEu4YxT5skJkLWRP1df9Gg2WaPpFstYyxu94gi/gaYZabPJmvdU/gis0ffHmVCpFfKEblBticPv4bOTXYzefMkZ8wE8lExenq0Yxo7OgTf/TJc9y9EmC9J0+GzYSgXNAm9qTKztD7iXCkrWIbsNKRZ9tQUcAMqCTgEUE7jjpnfwngtXWNj/gMyGl+ulfeWK9FhP8EN5TonGJapkNUrTrfaBNHcf4KvsgLNUIUAr4seLFboTt8nODw6JMpYfP5cXKsmknWSUzoJW0P7A08DVlHdgs11PwNOIrpL8vcH+JP/fwjifDd1sSw3MNkrfkELl1xHLCkjhdkEjsbHruzBXHqrw9srvrjdQEnSYY+KkA22/FSLtXmw3AUrp/TU5zNhEQqIwZnDqAnjKfW8pGTv5+k+NfG3XzM0Spkt6VNC0AUiRh+cUpoLrIP/SyuipiccDBsbItZprLJTIVAyppZk4tkNIr/K6Y3YCSLoFVJeaZIcD+2k1GLGiSn8KATwytNQeUrHR5Z9l7dnLf4Z4pkXjmXh+lSJmn5j9K22S+KNQtb1l0CXzm9bDeE1HreuZBjlRwQrt3PGR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFRJZEdEUjlVZ0pidUgzS3J2NFNmVnJGbGlUdXZ2RVlqajFpMEs2M1E4cWZW?=
 =?utf-8?B?S0pyY1g0SVZuYVlXeVdwWHZVOFl3eCt2cnRTc0lLWE1KMHlmeW5tREZNSFpx?=
 =?utf-8?B?WXJCMzRUSGV6SmFLVzNhTnJkODNsRzdvU3FVU210UjBDVEN1aVFENyt1aEtC?=
 =?utf-8?B?ODlGK2VvOEhKbFBwOGtIRVJBK3FMM01ESGRmTUxvSFRuTXN3ekMxUmRuV3FP?=
 =?utf-8?B?ZDRCbjRERU1xeW5LeTRvZ0FZSk80WGw0aUl0Q3ZzUzRza2ptNURMSjczajBk?=
 =?utf-8?B?RFBTM1FQQUJJeTdwak5kektEalZrclNtc0dpYUJKTHFFTEVZQjNPS3B5MjNq?=
 =?utf-8?B?RG5EWHVQYVVwOWNuTEU4TzhEUlU4NDhEcWNUNkFJK2p2RnFoTjhmRldrTUdC?=
 =?utf-8?B?Y2YvMXBKN3hoL0NQT3lkK09Ia0Npb3dDcFlhWDIwa29BY3pxNVpQUjNkcGVZ?=
 =?utf-8?B?T0FheXhYS2N0TGliU1FrQ3lJSzNjdE9rNUhmK01nbnFNMGhjbkk3c3pVYUZM?=
 =?utf-8?B?c2tmb3pRem84clZDZFZNNDlodTJjTERKc1d4SzVpNGppbm50a0tTazdva1Jw?=
 =?utf-8?B?RmVFTVJIeHp5NFQwdkNNYVd5R2RILzFjMnpUTEJyVDc5ZmN4RFc3L3VmRUxL?=
 =?utf-8?B?L0Y1blVOcFBwM0E4YTVJU2Y4eHQ4dGQ3RXNHQ0l2RmVZREJhK1FxUEx5c0dm?=
 =?utf-8?B?b2VNVHZTY1EzODRaM1k0RDdLUW1PVUpMcm42YVdOb08wVm5JM0lyM004UCtZ?=
 =?utf-8?B?OXFkMGlQZ2tSYVQ2QVNhcmcraTVzVldYWFV6eFZ1TjRvbDNkRm5OVzhhUUNZ?=
 =?utf-8?B?RzN0NnZObU5LbmdIYzVZUzlXbGdHTGtRTUNzTSt3UlBYZ2k3NTVscS9JQWVl?=
 =?utf-8?B?V2ZWODNDUUlTU1BheE8xOGVOMVlHd1FaSGFoaHZaQjRQTlQ2aUpNVE01a3Vt?=
 =?utf-8?B?YksrVVJYM0N4MnFiMEwwU1lxblljdnNJQW9SZWNKN2lCMWJZL3djRUN0N3Az?=
 =?utf-8?B?TVNHWXBQOVpEVnd6dDNDNUd3VkZBcGVnNi9tcXVuM2hvbWU3VlJtcUN5dVJo?=
 =?utf-8?B?b1ZsaGtIOUl6SFZpQ2FoWW1YWlR3UFBacy9wc0g0bSswRWRRdUZ1cFN1a3RJ?=
 =?utf-8?B?SDM5QUJPdE1kcnNmdk1VekduS1VDcDlHYU9lY0lsYWNDajJ2N21kTzZRb2FH?=
 =?utf-8?B?ekVIK1hzS0N1amVOcWFHLzlQMHhBdEg2NW0zNkMyYm1IT3YwK1BDNTQ1TnBY?=
 =?utf-8?B?aERJbktDbk01NXN2dzRteHl5SnhYNTBQWHoyNmhUemNPb1ZDK2RHZDk2dUNC?=
 =?utf-8?B?VEd4dy90WGtOZ210RG5ZV1RURnAxYWRqM25ZWENPV2xxYjRGQ0s3N2NBd0hW?=
 =?utf-8?B?dFlFL2FmK05PMGgrTkMrRHp4TWJWekVLd3g4R3ZycVc0SCsvdTVxdmtvYTVY?=
 =?utf-8?B?UEJsaDlOZ0EwZGxYOUxIRW5wcG5EQWh2MzRIRDBYa2x3cXVQUWRrWFk1dHdD?=
 =?utf-8?B?UkFrR3RKNXFxeWNUNi9TWkFsTE1zNTF2OTdEbjFGVlk1NzVubGFJQTJXV0Fu?=
 =?utf-8?B?VWxRSWpBd3YwM2g0eEFGQXBjL3djS1QwMVk0UWxjaWNNUFRwZlhOVkVtVU9m?=
 =?utf-8?B?V0dHaXd2Q0NsN1RidFZSVnpJeGhoVTJ4L1ppaGd0QTA3UFJ1dVpaSi9vampu?=
 =?utf-8?B?UnFwaEE4OWM4SGgwbWZtZjVyMEUyR2JXN3U2Uk1mM0pvS2dvMXlaV3VVTDlh?=
 =?utf-8?B?UzJaTEsrYzUybnoreGdpYWVHbEo3UGNPTHNxb05nVXUyUmFRYVdvRDJzUWZD?=
 =?utf-8?B?VDVSY290SmdNa3pSWkZIYVZHUm1TTC9mUzJ2T3J3b0VGdlVDNGFLQ2VMRThQ?=
 =?utf-8?B?K281bVlzN3FiSTVuYkhvUjJlQVB3ZitidzlhMGNYbVJ1a1RENzZscUZiOTRt?=
 =?utf-8?B?R3FlTHZ5bXVHTFh3YjZibGFBTjhnL2VzU3B4YytJempXdm81ZlVjUWFHS0lL?=
 =?utf-8?B?UmlvWkdLU0hXS1o1UWI2eEF6M0oyaUFDUm5pb2lKa2o1cGlWWWpuSHN6YURl?=
 =?utf-8?B?dlU0RHBZVXpPTExtdkhlRGpqL3hEOWw5b2NNcUNIOWx1SUF6S3BpdmwwY21u?=
 =?utf-8?B?TkE4SjFPVTJjQUdFbjZlT3lHYVVsNTJTS1VDbU13RTlQdGRmZnAvZGk1Qlpk?=
 =?utf-8?B?RzZoTzBvU3lzQmZNbHZWSFZMdXRzL3dIbkR3akIxMDk2YXJ5dURZcG1TZ3hy?=
 =?utf-8?B?RVVqajZTWkExc012OWcyaHE1OUcwOFdpU1orcjg3Um5nMERZVG5lR2VtTUk0?=
 =?utf-8?B?OUIrUlZhY3d2SWpEWSt5SExYd25rUHc5WVJiWHJZV1ZIUVhyRE9CZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129da628-a9b3-4156-94da-08deb926bfd5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 23:55:21.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3Lha6UXtK5YQ1E2HqdmGyYrYsdUBhbenv6rGgeVLsk31EUKy+HSdgV4quB2MRcvqpnj42NCJznE0EKA+mRZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8210

--uwe4jmhkcjqtvyzn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7] blk-mq: add tracepoint block_rq_tag_wait
MIME-Version: 1.0

On Sat, May 23, 2026 at 04:09:42PM -0400, Aaron Tomlin wrote:
> +/**
> + * block_rq_tag_wait - triggered when a request is starved of a tag
> + * @q: request queue of the target device
> + * @hctx: hardware context of the request experiencing starvation
> + * @is_sched_tag: indicates whether the starved pool is the software sch=
eduler
> + * @alloc_flags: allocation flags dictating the specific tag pool
> + *
> + * Called immediately before the submitting context is forced to block d=
ue
> + * to the exhaustion of available tags (i.e., physical hardware driver
> + * tags, software scheduler tags, or reserved tags). This trace point
> + * indicates that the context will be placed into an uninterruptible sta=
te
> + * via io_schedule() until an active request completes and relinquishes =
its
> + * assigned tag.
> + */
> +TRACE_EVENT(block_rq_tag_wait,
> +
> +	TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
> +		 bool is_sched_tag, unsigned int alloc_flags),
> +
> +	TP_ARGS(q, hctx, is_sched_tag, alloc_flags),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev			)
> +		__field( u32,		hctx_id			)
> +		__field( u32,		nr_tags			)
> +		__field( bool,		is_sched_tag		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		=3D q->disk ? disk_devt(q->disk) : 0;
> +		__entry->hctx_id	=3D hctx->queue_num;
> +		__entry->is_sched_tag	=3D is_sched_tag;
> +
> +		if (is_sched_tag) {
> +			__entry->nr_tags =3D hctx->sched_tags->nr_tags;
> +		} else if (alloc_flags & BLK_MQ_REQ_RESERVED) {
> +			__entry->nr_tags =3D hctx->tags->nr_reserved_tags;
> +		} else {
> +			__entry->nr_tags =3D hctx->tags->nr_tags;
> +		}
> +
> +	),
> +
> +	TP_printk("%d,%d hctx=3D%u starved on %s tags (depth=3D%u)",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->hctx_id,
> +		  __entry->is_sched_tag ? "scheduler" : "hardware",
> +		  __entry->nr_tags)
> +);
> +
>  /**
>   * block_rq_insert - insert block operation request into queue
>   * @rq: block IO operation request

I completely overlooked that a request could legitimately have both
RQF_SCHED_TAGS and BLK_MQ_REQ_RESERVED set simultaneously.

--=20
Aaron Tomlin

--uwe4jmhkcjqtvyzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoSPmAACgkQ4t6WWBnM
d9Zeow/+PrDylSKn1gFUEV6wEznGOw7QXt+D5PnNvbdBaqtOeh3RsarNuj1TwDRW
EVqY5V8NEFj/IPvuNyrY+cvaM2mE6+vFOdMlCWskhfhDEGsDl6FB+09csuhJ9Zyb
8A9GdLW7fRSkSOkNUXfL6b7rfzJkyGK1GZuK60Fz2iNxBsv5RC+M4ImzsyRVP1ld
x0dO1Zk+eAyrJSF4ppcCbg2APPgGqZ9syJNvqLPy2LfjzWqpTF3m9sFO7ieoIDcx
pHwIMFDC0a6fR/fpp2PWip7BJJVcbYdLukshgW/Ywo3XVaVjz/5pnUgtuVbAC70L
qN9bwIhNOruCRanpqlz9mUFwryg99twGG2VdQFCuMxCJP0pD2HnTo/b1+U/80X1M
JjV2WJFvBvIfRg0LMlz+YHEznNuiHM8ge/Ko5PoYYptPQLtnSdhmj2fOeXBLygZ8
IbNUZfJht+ETyqVu7pI45MCpJz083uEW50QOvEfTfaujDBjugQQxXIMiCKHkRjNR
TXVQZTWlxUzcpGBMl5UteFwclxJZ/AdvgVMOOpHoYAWAvA5YLgElwb1KKDzs0n0/
zbWKaVrJfgbAvrDs4L3UAEbUIx1K/06InyCZD+Bd38htC/Fvmp+lEdDq1MUODdKl
qRpVBxk8w7nuTFyLj1+JYyKfjWg0tY/mo0OhEClVKjcGvgFb3UE=
=rc1L
-----END PGP SIGNATURE-----

--uwe4jmhkcjqtvyzn--
