Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C93F411E;
	Wed, 13 May 2026 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715052; cv=fail; b=VY5ybi8wYNVmG5dFgYUqvxUUFS6OIMfQXvFmGLFDoBznI57UV0la8Exi2q42B+VolZG0HMwOMKJtZ3eid+eCINm8C40yRHNqVm0XdloqDu4x+LnvuTNIn+WG+xoR7dfTLnt4RsO6Uw9lK7ufoi9M5fxi6gu3CfHbf4SMR/su0eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715052; c=relaxed/simple;
	bh=OPf6J/ObJ43hyBR4aXcY5B0YUT8VR1iCkzcaDmUJyQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lD4tqr/8ZBP4U10+ZUmeFqvB57XFGZPkl3jom3iEdCyU5b9gU9N+sYzDKb1rSNfUFyWvu1Bs0tBogVIu/LVQ76GPgRcrIhG687apqSzFejGdt3ISymy6hdciJ4Tkqc9WHPMpyIaSVpp68r8S4DRegUn77xP4m0BX2h/xkPgvqz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONmY9c77QE+ltzdCLLrKXxf62IqnGEn+gAgrgk3lNNC3DzW2kZqI2wUxM2eFIyEmxjwC6YIs477JzGbOPQ6jTsjBJB2poOz+uenKAj7f+q6AMawfxSmugU25lvCd/dD6bWdDvjOtCxcw0R6fN4eb1Idp8hpiEbks9KWM66HVHW+ACZ3WPbb1dPuq8j8/lnMoQzr48sXDK9KbmJ3h84kI9KnjZottC6Wn7dUKaQYs+4zB4mZo9Dx6aH55EGglPjMgMUY+o1GB7J4LqIoLi8mpWQainhVkrvMh+cr2R8W9OcV1dubtnsy5MFwDDJkh/s3iyrKO5nuK9HOm+oRFFbjhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/pmWRCG1FWH8zy9PCFx3+eNt+m0avgxxxAdwmJKFeo=;
 b=Qkq1PsRSJl27fvi3Wt0PJ5fh8NafCL2ISnluTyxvBdJzyHFF4wQFMFr2hJ4kvV33U3D4eOY53bmrEPxL0ARr8JtzKqCLLU+xQPwJKSVA+0VUmJxlofrEYH3op93UjB5g18rGJ45tw6g7bLOcx0Zbny7PZKUrkkxo7e93S3AD3Wsh9FPAKyBzhd4+F1U1kayQxuWjnWDfFZAbMJXIuHSW8TVZfKZ1Vxgfx7sPdqABNzjbPgpSFJe+K5GaNaE/08j2tnvVCpo6Mk/ErE+WlgzDbyoUW3UDoJn9OVGIh506fTEzGP1oVgfdUQpVAyvv9wLE2oJEL4HEjTn10RdbEzbnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3084.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 13 May
 2026 23:30:48 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 23:30:48 +0000
Date: Wed, 13 May 2026 19:30:44 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Daniel Wagner <wagi@monom.org>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com, aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, kashyap.desai@broadcom.com, 
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com, 
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com, 
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, sean@ashe.io, 
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, nick.lange@gmail.com, 
	marco.crivellari@suse.com, rishil1999@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <bovevvg2n77nzdrvjkayca2piibjl4noykv24wthex7em4u5lo@beqyhu2xertk>
References: <20260513005509.135966-1-atomlin@atomlin.com>
 <20260513005509.135966-6-atomlin@atomlin.com>
 <3af2cd18-1221-4ff6-aa7f-6dab74460eab@nitrogen.local>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgv6p63zicy57ug3"
Content-Disposition: inline
In-Reply-To: <3af2cd18-1221-4ff6-aa7f-6dab74460eab@nitrogen.local>
X-ClientProxiedBy: BN9PR03CA0566.namprd03.prod.outlook.com
 (2603:10b6:408:138::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3084:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b46a7d-20d3-480b-e094-08deb147a985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	m+65tibfMAp1PsFwwatW/lWHi9YaNbW3fRoKAJ2e8iSjQWSs0kSvIzlEElEP4LnmuSERRFM5tZva41uuVtGtrKnHOu/0NGsc3RFZC7geAy1rfA9de/ETjWe8pccOOc/HjrEoAZRwM//3LUbxa1nbVXsCrPqEzRBs9Re2zmctk9TIfwoyb4Z7aKY+7k6jEK/59curpKcy2OQEP/AsfrzkN076FgQgQ0B8nRWJnO9QCA63SsjVPVVeb/bxAKBR9e6QfN2s1nDUh2b5kftYddAM8guVqKKjIQSYBWsqZewKMlff9FbG7UvkkO4ZvvyvA0tmPrUVflxwFEB1P+9uNIbHa8b6Il6qMshsc42ts0a9uSvCYEsG66tJiNeV/KsQfz6JrGO689rKChtep889+WKlGVQoJIseKFzKtsAfGKqjqNmBDxyBoexh9UBScRl8N+ZI+oAf3fOjKKK9+USUZna5uhc293e13DT0jcr7BNY9WPkhgu3zi64xboDagO+QPYMxhbmGY61xZeA0owgbSFFveDrM60Bo0nxCijF97loqS/4yd4Ue+ZohynGTiuTV03QLS2OczYxTGLJVENlZGfxfSKzawWXRrmFH094BTxT6vrdTOYH0PKUHiEuyBKE7xEjEqOYnLdMhf7/hTGAKIw0qTT2e3qQMZitl/5HL0d0Yityc/4FQUEQVh2v8xUohhT6e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE9PdGczNWN4RmF1Z2t5Rzk0STNiQ25jMFlITGgvdnpCckVEeFNueHh6NUJz?=
 =?utf-8?B?QzE3a285OTh6UFNiU0NhWUZONVpqTmFnb0RtMWtSRWg4V2N3dGdTWFBtKzlr?=
 =?utf-8?B?U2doV3IxQXdwSHVVQ0kyVDU5VjRVNGo4bGI5bXRDZ2VYS1YyU1hZVDZydVhm?=
 =?utf-8?B?YzZaVTN5SE1kVEJTUGR1eHRPU0lJRGlRTEE3NmhJLzdUbnJTNy9EeDVrN0g4?=
 =?utf-8?B?cmNMZVJjTEppdUVYSUFrSWdXS2lia3R1cFdDSVF5eEF1RUt2RkVOVlBaR0ZF?=
 =?utf-8?B?a1RvVHQ0SkdxUVR5U01zUFVWSHoweE93QlBiNWtrSW51TG9pTjd1aWpDRTJr?=
 =?utf-8?B?V2prNE1LNHY3c2REZXBrZyttOHhTcm44Yk4wR1ZYM3l5VEVnR1FRVnZhM1I2?=
 =?utf-8?B?S2ZHVUVQdUlMZjdBMlMyTktaN1RLWXhPNnF3cEd3ZEF2QUFBa2lrWG4yWWhE?=
 =?utf-8?B?Ujd2SU13elVkdVdoRE9kQWRqV0U5d09lYTBSeGo3RGxyVGFUWHk4Z3ltTE5a?=
 =?utf-8?B?U1JDeXlWQWJyWHcreS9TcHNXNUdDbXRpbGl5bnVuZ3Z4alFlU0cwbHR4NDhK?=
 =?utf-8?B?bXhtdHZTcWRBcmprMzlabXB2WkF1RFFINlJKK1ZldlFaWVdRY2pWQ0svSXJm?=
 =?utf-8?B?SXRyTGppOVFubVlKd3VMQ1V1YjJyUm1qcHQxRXZBcjh2VFlIYlQ1cEJkTjU5?=
 =?utf-8?B?ZXN6Qk5PcW1BMEpxWENXb3RQcW03ek1IWjEwSnQrNHZ6dWxGZFpNZTBTWGJE?=
 =?utf-8?B?cFA2ZlprOXlLNXRpU29ZQTVOYlhUZEdZMVk4R0cxRWY5bzF6OEh1QlZlUzh2?=
 =?utf-8?B?S3duVC9mNkFzalBvcGJSeTNCTVMxWExPbnRGbUkwSnBTU3BpejBweUlnci9k?=
 =?utf-8?B?L3JoU3dPU2VweWVEczgwQmZhRG9aU0FINFF0NGxjQlBCVlBOUDFtaTkzNWkv?=
 =?utf-8?B?cDFOdDIyYkwrN1ZHTmhZcE9GMzlodjBudUpsVml0RTRkWm5nUFd6aThGa0J3?=
 =?utf-8?B?TUVOcFFPeUFYdWJ0Ty9OSjRZU2hoNXE2QkJyOE0xSWRjazROUUZheC9vMHlG?=
 =?utf-8?B?WDdab242NUhQb2x1MGd3RTdUbmpUcDVjcjJ0T2lFUnBzVzlweTYrVGY5bUVI?=
 =?utf-8?B?b0FlZHNnL0pNblFrS2FvRW5oRVc0UVZEUGJnZ0xkUnpmOFM0ZndIclExMEFS?=
 =?utf-8?B?QUVoYWlPd1h5akdFOEtqZ3Vtd1BVVFVDSlZQZmpBOFFBM3UwdWpZcTdRWW1y?=
 =?utf-8?B?aFEvcDkvRHhPZlRVYTkzN3FNZXBDYkQvUHdQSXpTcmtQOHFSdXBpS1g2Y0gy?=
 =?utf-8?B?MFd3S2w2Z0ZLYVgrRno5ZlRhcnFZOFpPU0ZMTGV0RVMrdlJyUHVsODRMdEFj?=
 =?utf-8?B?dlhQWnIzQUtXbmUreUhvTVc0VlJJcU5HcGJXbHRwSktJR2xhMHExcEV2ZzNV?=
 =?utf-8?B?MUVOTzh2SWRhNkVxdTAxc1g1eVZmQnVJNmQyZXNIRUxKcEVGcVJUVnNHQ3lY?=
 =?utf-8?B?Q2F1My9MbjdSRzdkWVh0NXB6dk5WekZzb3BTU09tVG0vMnJIenBOeU1LclRS?=
 =?utf-8?B?cll1RmtlNzNad3RwNFEzc1JTTVdkV2NtTWpva09aaVNINjJtWVlwQUVaNmxM?=
 =?utf-8?B?RE9qRm13alVmNVV2aldqN2EveFhaZDJQYnF5Vzh1cmlwN0oraU14YXBsSkE1?=
 =?utf-8?B?QW9pcjFQWm0yMEtpc05OOXRFMDFBK1BRSHZrU1ErZHE4MGVyUStWSzc5YUJO?=
 =?utf-8?B?MEVTNk1Ob1VzRkxsZ2xXbCt2TUdHUWZiR2JKQmJ6WHBENW5jRkZSQXU5MStH?=
 =?utf-8?B?aVZvak5palM1NElhV3ozVTExTTFKMWM3OFN1dlBnMVA1c3JIaERreVJnVUMr?=
 =?utf-8?B?azBiLzRFY1dGV01xSjI3OGJ5LzNka0FMc3ErWEE0aEhTM3VhUkRpU1doVDgr?=
 =?utf-8?B?Wi9aQ3NSSndvbTZjL05YTHh6aWNzaHZ3aHhFRE1hWnJJTnZ0L2RlRlI5SEJJ?=
 =?utf-8?B?c3NzRzJiYUU5NnNzV3d2cFRQaWorYVh5Z3RtTU0xSUpnakY5RVRpN1N4TmQr?=
 =?utf-8?B?Z3dSUUZsTnVKU1hQZ3BMQjdrRDJjT08wUmhBUDBHMkFtZUE2YmpmWm00WHA3?=
 =?utf-8?B?dXFmWk5YMkJ3WU0zeGpkc21MVDlqdjhBWWJvRHhCa0pzRFBqMjRoNXkvcEtE?=
 =?utf-8?B?YkRwRXJaTk1MazRWUU1sc2lCTFpkZDNxL3pSUHQzZjUxZW1vSFNPZ0x5NkNn?=
 =?utf-8?B?bHhKNDhPYU5zeWhKUmFKTUpNTFRVWnljVjlPKzh5NXg1RENtNS9VSVlXeW55?=
 =?utf-8?B?TEppUnRSYi9TNzc3NkVZUTZ2elRRN2NyejQ5YVRtcVNmdnBvT0VLUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b46a7d-20d3-480b-e094-08deb147a985
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:30:47.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQAZgYPSQ7IGnNN6xBCO+dd5NKFWoIsMYJD0HVvBP/fc8d+/d99SyTpt9U6z0fgg+OK0d6XxHtsdbZjSLIwuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3084

--cgv6p63zicy57ug3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
MIME-Version: 1.0

On Wed, May 13, 2026 at 11:42:46AM +0200, Daniel Wagner wrote:
> On Tue, May 12, 2026 at 08:55:06PM -0400, Aaron Tomlin wrote:
> > +static void blk_mq_map_fallback(struct blk_mq_queue_map *qmap)
> > +{
> > +	unsigned int cpu;
> > +
> > +	/*
> > +	 * Map all CPUs to the first hctx of this specific map to ensure
> > +	 * at least one online CPU is serving it, respecting the map's
> > +	 * boundaries so secondary maps do not route into the default map.
> > +	 */
> > +	for_each_possible_cpu(cpu)
> > +		qmap->mq_map[cpu] =3D qmap->queue_offset;
> > +}
>=20
> I think this should also check if the CPU is online. The fallback should
> ensure the system will boot.

Thanks for the review Daniel.

While I completely agree with the goal of ensuring a safe boot, I suspect
that we actually must iterate over for_each_possible_cpu(cpu) here to
prevent map boundary violations during CPU hotplug events.

If we restrict this loop to for_each_online_cpu(), any currently offline
CPU would be left with a default array value of 0 in qmap->mq_map[cpu].

For secondary queue maps (e.g., read or poll queues where
qmap->queue_offset > 0), leaving an offline CPU mapped to 0 is highly
dangerous. If that CPU comes online, it could silently route its I/O into
the primary/default hardware queue map before the hotplug state machine has
a chance to recalculate the mappings, no?

By mapping all possible CPUs to qmap->queue_offset, we guarantee that
unassigned or temporarily offline CPUs remain safely fenced within the
correct map boundaries, which I believe perfectly mirrors the safety
guarantee of the original fallback logic.


Kind regards,
--=20
Aaron Tomlin

--cgv6p63zicy57ug3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoFCZsACgkQ4t6WWBnM
d9bQ/g/+KbWMe4Lnd2xhHyvhAa/9PxLDL4+GwJTqxEzPfSLQFLAlc9ntYM7wnsJw
3d8EWEUmQwwn1+jbVZzLjGzVcZVydYG19SouHOP2Kww7j7oXvvgu9zlD19rKCGNg
Dih4izXlQQ8p3bucpzB+DwEmTv2yq6qJ+TDCR1dfZkfEsCWFbNhFEaRREWmlvUOx
FZ8HorWHx1bgQ3oa09AcpL1fbCvUOUv4tav16glV7xpeOyrR7sIxyLuMz0F+OB1E
r3rwas5ilcU0hqCLG1byxufTcROF09GxBVT95ZGl5drc32nGGNvSs2Uu7s5ArEdQ
HOci456lnwOuhKu73qFOwjRaIkKpUoKtcEUcVkN6RoQm7K7uf/VhkaBDPm4kvLK7
kEWXVcriuJPrTS5E3ddZxm3NT/5dfMv30gdmcprvW910Q/UBpJgexncpPxbyWDpm
lawhKcooQ6yTSxoFcIrhcmNLS20ij/D9+9844i7qOFmVoKy15Bw67wdGbtYwFX1m
6lScz10b8VjNp3k+hcLz8ZPfmTiGSEFzlPqub3/SU+77FHphHU2zIJyhqV40Dh7W
DH1wR/S4HMczdtIoDfP5E5KXzmTK+swD4Oa+e6q9992lLRMsZoWuUnqvyoF2JQ8n
JaqVcEjM2D1vPado5DZrBnXlL5MclmL4olQzNw7mlfCwqcm3674=
=cTzz
-----END PGP SIGNATURE-----

--cgv6p63zicy57ug3--
