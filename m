Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB32318C933;
	Tue, 19 May 2026 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151905; cv=fail; b=syNR+FM1owJdrEWAzA8jwUlKpu88opHEhuYKUciF1mitqGRFjG43OA9vkYeOKTtuDUFCRfVhpsFTKJgKsWwRjYoJR+7V9hNimmD3qWgSI2tQA5XosYcfHKZwYRNfiZ/iEjV+4Vikschkd2f0SvQOWCXQMqHnB7PR5tshqZVAA/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151905; c=relaxed/simple;
	bh=xHtn8N8YO6jlAKAbZrZgGudSy7qB2Tzut32UftzEmV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AYxqEPEIt3uVn4pr3TLuE3CA4zEIpIm4I16cac/Mu53J/eky/c0SXDTt54GobE30dt6PUcEqcm4sXq+3LRcZ6s28iNM8LWwuFzSUPxIHzTDauc+2l0PTbKde8u+ccfSALwfnRrYkcb4ZLvNpG1NvQnakwyAosM27114P2qsrDI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcRVNhhtogE7jNMke+e8A/Tuqay9miH95LC6EtD5Ylcw8RcEvqTfcimN4DAXM866Gsp0LrZWlACIOo/xg7mWJZxHwBgALP2bL+UwgCjAWgSQM1kCJ15vHH8EAXo327hnl0lDqdx3+ZkBqb5As5jEkL4IyjpvvhE6VLldF3ic+s7LZxov3nSBKTxHYW4cFoSFVITntK4BTAu1XOy5FyB5F+0iepg7G5W4wmvOLS9rD/ypTgpcw6NvIX4VKqHfIbUQ6k2/eCyctKuqVPgRfuo5rciDBPvJj5pIvjKNKU9KkXX0MoZk9mQtNcUm7b7Ou1Bu/GQCccYf273SGc5XIr/32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0E24Drv6R2aaLDkgUyd7QsCNKp+ZsAL0FsgduoirkM=;
 b=Ju3aoXkcTZP7QR0kHcOD63HI2t2Hykwm5vapaGeYe1Yh77SGM9Ds9q9+0Z83d8eQm/T2IpuFAWmYkZ091BQw2rE4C5ZFubx8OSkGjcXUh1VEeV3H8LnzP22yH6atL+C8n+9sIHU7Vv1LX5vJlvlxj2qd+TbOgBZP2qvuxBwMpqhGxYZzI7Y4NnMk7OsaLqcYflQJB7D6afW9OMFhIC5KOIhrxtTcKs8Jryb5/A0tG1tL3MmxPn8XmSaIQJIZPspHtNTB8XwHaufl25ynZI+yKCvPWDVz53GwTRrx8vh7E2pw+3RdMAym4sJ7YPSkod2M0YO3JmHz9tlYD6pAKzYAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB4220.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:159::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 00:51:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 19 May 2026
 00:51:39 +0000
Date: Mon, 18 May 2026 20:51:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com
Cc: aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
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
Subject: Re: [PATCH v13 6/8] blk-mq: prevent offlining hk CPUs with
 associated online isolated CPUs
Message-ID: <7p6dtovz64aevecmgzysvjvgwuaixg6t3i3r2ivfzlzw4n4ywv@z7ob7rswb34z>
References: <20260513005509.135966-1-atomlin@atomlin.com>
 <20260513005509.135966-7-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xk6zlcookcxdp4iu"
Content-Disposition: inline
In-Reply-To: <20260513005509.135966-7-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:408:f7::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2942cf-588e-486c-5a65-08deb540c90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9moAiop8M9PMurTs16uAafTcrH1dMAuZaK6LOOFCsCHT/ch6Z/Vokjo9+h7QnOxBIOHCVPn03n9eXMW5RC31GWEw1XV9cF0CY7LH7lw66/d9DurAvA5lioEd7geJHGXVBmlNI9CsT82mmcCCYyuNkttWAyq8vfN0kfKhjngvoPuLy27fQhuLlaAZDzoIghi28BdZu1B0Zo6zv7ZwgAD25ODfZqcsvpghg1X4nInEnIv0RAFgm8JFsPLeu7HHWrvVG1vVqEZhCfS7NzU7mFNW6A5iEKo7IgdDuNH57edhJkJet+iQDnmYEdNdF6GbffknMeT/QYmRhPtB8b5FvK4STHycMS1jEf2WzXLfad/aF8N3j14G5EWuM/oLUay9Kh3KYYDUeUPeIoSKaK+fQpIUE+4vcwQj6Yvuh4eBcBAV6VI109s0VDKJTrjnpRsaJgDkPu4jI6GQarWJ3BNNc/TrkQ2871Y2kM+HhnzVwsPVDXFRPtt3MFFDxcvR+GgVqvvmoCtYRxZcBxE9MCQM1vUrmkV9BywcC3s1XWtwC1N2AYVMr/RvhqDVgsXNKJ2ciIupxcTTbg4mVxKF33TIpFz85afXVoGQyCPfH0TkRnUYW4rtCO5cX8fZsBlO0Ej11wBZ6v8djT2w6VJnbMk+y8kB8E4Z3o31PxY+zjtEbfsjSKGX//cYPBwEls5oJB74QHuk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UStIL2lKNjdJSTl4ZE9YRDV3L0xJT2EyVHI2MmxuU0RJSzFQcE5Xd1pQTmRO?=
 =?utf-8?B?OUdiU3dpQ3JsQU5WaVJEQmlscWtRclZIeVRtL0RrMm43NGwzTkV2UUlvdFVq?=
 =?utf-8?B?Q0F4enJ2T2FPWVFtbnVoMURNcHhVOEVSaFpOV095ZXFIc0tPMmVnVG8rdXNC?=
 =?utf-8?B?bWt3TnBhTkd3dTlpZUMyd1ZxazROTW1qRE9jTmNFanZnUWNZQlE3aWtqWDlU?=
 =?utf-8?B?VCszMWE4bWR3bHVERzdVWjFEMjhpTndPS3F1akdXR2o0NE5KSnRlOThkR0hP?=
 =?utf-8?B?TG1GMFF4c2pOT1JoMGdLVmhQa3Y1clE4c1ViclpOdjAvQ25tYUppendXNUFH?=
 =?utf-8?B?aFcvU2RXWHA4R0U1dTV2a3hCTlJ0cWtMMkZwSlJZMnl2enI4SXcxUXp0bDVj?=
 =?utf-8?B?czY0VzVmbGdTRVB4bzhabkVmWEdKdDM2NmcvNktOYkJTUmtrK2t1UVJwOXgw?=
 =?utf-8?B?U1pBYUZsdkg3U240SXFTM3EzUUZxWFRVbFp6RnBCNS9lYVpGaUZPSEV4SGo2?=
 =?utf-8?B?N2FCNWZ2WlQ0bUhCSldNVWxTRjRTcVlMOGpIaDM1WGhtR1M1NWZHb1NRRHVV?=
 =?utf-8?B?YWYyVjg1NXhLakNKS3RhcFZoSWlHeUduVmVaOGFjRFhJNVJxdVNpd0lNaGdL?=
 =?utf-8?B?UisvUFc0aFZyejV6OEF5Z3pKc1IwZnpoOCs3b2pXNnE0UGdKVUJobWs3OHN2?=
 =?utf-8?B?Q21qRlZxektvR0FDY0d1NGx2bXM1bG5acnlUTWxLTnlaK0ZORUlyeTVCR1Nj?=
 =?utf-8?B?OVl6dUVtalBMWWhteGdtcFNhbG54ZDkyWjdBUjF3WHFCck1ZVXB4anRCVm5a?=
 =?utf-8?B?aHhBWmZIS2VydHRLaC9UejlTUG1xckxKVGJzVFlYYUZFQ0xwbWpYMkJHc21H?=
 =?utf-8?B?b2IrWlBheGt4OWFnYktIRGhFUVJTR0hSaG44cFQzUmlodWRFZENyYjZaaXlK?=
 =?utf-8?B?Z2lEK2tzbUlnMStob1QwWHJaVndicVhzM21EZkNJMTJjL25XelZjYllPK2Vx?=
 =?utf-8?B?aFJ4dDJyNSsyY2RLcTFKRmF1NVZHZjQvRlUrV0FabmNSMHdKWjBBQk4yOGxv?=
 =?utf-8?B?ckI3UG1NS3Q3Rk1JbmEzTm9XdTUrbWNBRyt4TGI0dVVvSDJ4UktVdG1KQ2tR?=
 =?utf-8?B?SVpMdjVEcU5rNGV0RkNPcjlMNXJ1TE9ZOTY3MFE5OGdVeklDTkk1UHNCSDZI?=
 =?utf-8?B?TlNWNHZwMVRNVzF5NVcxUHRKTGVSRUo4L2VOeVN4eWF0RjFNV0NTdkF0MFVE?=
 =?utf-8?B?azFTQ096eFhHSDFIWFVNMW5RVStwTzR6alNoTHhaaUszSXE5UjZkSlVqb3B2?=
 =?utf-8?B?YnVoQzNQRHpSSm5wVkxCTnZsaTRBZXIrYVdLYVBwVTZhSzdhcG9NMURvd1RW?=
 =?utf-8?B?TUJldm81WmdseW4vL2pNRzFEU3NyVjdLaVd3S3owaThBdUtWd1FQMDZuZGhN?=
 =?utf-8?B?OWlnV0FWelpWUHgzdzd2b2Vva3RUdUVjZDlZUm9oc0tVKzR6RklVZ3gzQmZ6?=
 =?utf-8?B?MitaZmV2UzFFTWU2RnUwOVBKeGJXT01mZ2c5SWFUWm5CKzZMQVpnTXo0MmV3?=
 =?utf-8?B?NzRCUzRnMGp3MHNmd0RCZHVmbjJSQmxsT203NXZEWXR5ck96VXlTZk0rQlRw?=
 =?utf-8?B?TjBxTDc3WTRhNkVOSk5sUnZIRUZLdnNOSDQ2aDhjWGtsNjllbHVVdXh3a1FF?=
 =?utf-8?B?QnRjYXNjT3RTR3crL1pORHdWRStnZzBKTVZuLzBEOWg3b2NCckNXdjlsU3Vk?=
 =?utf-8?B?QTBaek1pcng2cDFtRllhMm5lQUlyaG16MENxSkRDWE1ubHVQZ3M0bHo3ZVlh?=
 =?utf-8?B?akJ6ZkdXS1NnT3lSQnJRZVZRRW00Rk8xMTBVWmJVeHJKV3IyT1E4dkVWZVFu?=
 =?utf-8?B?UDZxREIrdVhRaCtrckNhaGdzMDVKd2ltUHl5TUZ3enRmS3hPSWhtRlNnL3Zt?=
 =?utf-8?B?QUxicng1ckR5b1ExZ2dzT0t1aW5ZOE1pZjdKR0NESmdhcWFUT3VhSHVIaGx1?=
 =?utf-8?B?VHlYSWM3alRYcEUyMnBoeWhHM3pkUmNUTlhvTTEyMElkTmxHbjBuU2dTR2Vq?=
 =?utf-8?B?U1RiSlltMTdSMmtMU3FYdy9kcE14Q05sekZTeTVLWEprVml5S29RMFpmR2NS?=
 =?utf-8?B?NDlpT3FXaEkrelZocHhYQWtNSlZKNm1taU0wckE4YTl3RzNLcDNJSmZHaXdz?=
 =?utf-8?B?emwyKzRnSW5uTmJLcVIzK0Y4K3FrdmsyTWs2WHhBYkJKb2RDS2JUWkZucVlX?=
 =?utf-8?B?RjBhUlhubDRacm9LREE0ZjZjWE55aDNHS0VXS3RNMkYxRFdwS3RZMGl3eG8z?=
 =?utf-8?B?VHE1VENoT0duUCtDWENGamd2dGlEMTE4Q3FvNFhUWE9PQmt2azNEUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2942cf-588e-486c-5a65-08deb540c90f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 00:51:39.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00CNQcj9Led4q7voWSgjrA2nGYp+8/lRO6lkJSxMx7WUsFH6/gViiY8oTbbgFgBjUFyFfJbF6UqAoviNSXMS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4220

--xk6zlcookcxdp4iu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 6/8] blk-mq: prevent offlining hk CPUs with
 associated online isolated CPUs
MIME-Version: 1.0

On Tue, May 12, 2026 at 08:55:07PM -0400, Aaron Tomlin wrote:
> +	if (fallback_isolated_cpu !=3D -1) {
> +		/*
> +		 * Use READ_ONCE() to prevent compiler double-fetch TOCTOU
> +		 * issues if the disk is removed concurrently.
> +		 */
> +		disk =3D READ_ONCE(hctx->queue->disk);
> +		pr_warn("%s: trying to offline hctx%d but online isolated CPU %d is st=
ill mapped to it\n",
> +			disk ? disk->disk_name : "?", hctx->queue_num,
> +			fallback_isolated_cpu);
> +		return false;
> +	}

This looks like a use-after-free BUG.

Consider the following scenario:

    1. The per-CPU hotplug thread reads the pointer, and is immediately
       preempted.

    2. A concurrent SCSI device teardown can invoke disk_release(), which
       frees the gendisk structure.

    3. When the hotplug thread resumes, it blindly dereferences
       disk->disk_name using a pointer to memory that no longer belongs to
       it.

I think we should modify the warning message and drop disk->disk_name.=20

--=20
Aaron Tomlin

--xk6zlcookcxdp4iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoLtBIACgkQ4t6WWBnM
d9Yuxg//YtawJER/3oXY74PdH43BD/XcjJM7XR5zkII3gIFjt90LjEtER5qDvDTZ
giP2cZB9v40eFYkXmX46/xoBqvHJ8VqKIPD51u5pPat1xG/jwr/qeDoBY4ZFjzM8
whuMJQsb9/l43wpjRVGB9z5DysLEx9AWXw0oeqYCnX6MgFptfOvnBgR6q4977U+M
xLBB4E2tRjUx6Fd5io6dRbdSJaZ6gc3yHbEtzJedxh7rAFrPt4FOpFCna9BcUQxO
SNSIGXZIKtd8hLQZd0VskBiV6Lt8WsQTkNDt62qvDHeTwnZEyG+4powde5L1/PEk
Rjl26kKDEH6Y/SYDwcRaXrkF5suzmbwIIVZbyN7l5PXNCcuufGfmugtrc8W7xBTw
I4UlMygFopoMVIaQbJPuIUs5RV2y2ImZmqnv7TTZOFAOd9A6NM/uqcwnQskyOoVk
4pAxcwl8cJDJWx1WGE6qRUMIUXN/0EI6bYievT8yHUx5gVg8hsquUjSYNGvyLgZv
gCBdnRWFy0AfV3nRDWR2b2zJZSQ8tEZ+kNVQ9lNiuLmYAAjuj79SHi3Z9N3VAE00
8+sFOeyB6lwdsn8SJiD427taSA28XNYuEznENCTRHIsgekTj3u1WMNRhwpKjwaSN
tKezTTgoKcve5QAr4RbFWVyrA+0AKFNpux96mATtyt9WCNQi6IU=
=absU
-----END PGP SIGNATURE-----

--xk6zlcookcxdp4iu--
