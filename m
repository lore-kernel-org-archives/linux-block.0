Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022076.outbound.protection.outlook.com [52.101.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BC31AF3B;
	Wed, 17 Jun 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694093; cv=fail; b=Hd1crwMsUy/YozJpeahKbKXNTGpYa2gZGW0thAYib10YdNlMpFcEIzt1iuFsO9wsfSgIyO0ds6SIjJeGBrPLwDGQeRv1mFf0rawsmWSCVtfSUAHr4SwtyzuoIJCaaASA+9LkfUQ07OfQ0KFsP3kMH2w14tAs2HBrSJGNm1omXSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694093; c=relaxed/simple;
	bh=phWASaQ+uhIcm2KeMebGql+6P+stuB0ZV5R7CDPsQlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7J/Ina000SSxXdGfLUiliKahqDHuBTmcpQfP18fLx5Jv5QzIn/Z7q8NAW6/HDtm5blewV7/NXChP6yaKr6GS0/qhC63yKwY/7sBCPg1vM5H2rC0GH8drJe07WR5Km52uAFRWoM3i2OYhk8UK7UfOaP4Yy0vKyBzmKVmayZWtY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5wDXJrvB+WnChTVSzsu9pEzuMHWJjR7eolp9Mf8n4rZFN3n8PHi8d2tliEKQVjKjhG+Y9uT1mTSOeYqjqnxqzMlhu180VfBk9GDWa47Dr7UOASBwo20k4YDNELaIVHeB5ZEbXHXgwHZY6iNMcVHIz4X2GHoYmpy8Jmhci2YqwZb81cShATYAYlB/o559dmvu4yXHBJRX/dDgpfO7R+dvDOLeFUBHZAaahgghPko1UdmBxdaf7smX3KwihxW7uafB0+/etW/ktlXMICpiSCvj+IL/dBVEdfOEAGWlsfLJVvjgNJsI3rexslzAYQu9jyXF8b3VO1lwhgJry9alLCM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=zKfdpHEWvCPcpqentoGKuq4uQAVIu4I0jiszBhoNc6M=;
 b=qccQZl/IfHtB4OISyLSy+YjOU2vWpXDT6DVxGLhOZgp79U9+AmfgBV3gh1tmefz04OYgHMvxXNkjUhH3QIPJES17uKUwzOJMu++ipmJ3u35+eVIRc766A13CvjLJtr22BT2hXpsxYLUQqiw5FgcKpYE5/v/NGY1ebOe6po5DOr1ab/t/EMnCMigxhd4faO9wnP+gReu0Rz+a0iS6/hEeIWWRS+Bi5ef00igWlKSmExgfslt5O/E0OtqonWvef5JvzG7Ipy695T96mM9bigLfWNOvLR/ERXEb19UfQTlj4rVnVOUyZjRm1NDpOQNo7BY0Ex3hX8qJWDpCsGHhU3SA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3210.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 11:01:26 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:01:26 +0000
Date: Wed, 17 Jun 2026 07:01:24 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	mst@redhat.com
Cc: hare@suse.de, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, bigeasy@linutronix.de, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, longman@redhat.com, 
	chenridong@huawei.com, kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com, 
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, nick.lange@gmail.com, marco.crivellari@suse.com, 
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <olynqvtm7faqrw3qc2cwvup6vj3rqrr7acbagrgxn5yly7vlpz@yszlwd7afjak>
References: <20260521232956.553287-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5zdbnjgyfotz75ur"
Content-Disposition: inline
In-Reply-To: <20260521232956.553287-1-atomlin@atomlin.com>
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3210:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f25f53f-75dc-4917-cab7-08decc5fc69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|23010399003|376014|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	SdYqRvkr0WDbBkhlHVNF9s3L0zs/rBlU/x3TND+MyyZHxD7ZiV5MS94dqqYyKr5cZOAGRqdS1sg/uMbwADsTKuNGpJxMnCE3cdo+HOS6H9Tz8ILU6wE4nc5cLTCVdJesUbpM6dseDWJh0i6odhIOqHib1IwZmRYnFbgT5VL/tFim+TjjihJVX1f7RlsmFH+uH57QXosELkn2/KCqDm/A7Xqrn1ZJwjLItE8xXyfP7a9n+Wi3LFRUmxXzXkyrjJoh4bkxOO7rLbNrHj9OVL4SkP2U+9MsQJ1Ryy2rNCnpHdkWBriaEgURl0Y4kCLxfkRTg5a2CgyEhrqEkEwmzrqOLyVpoFQwwYzGUWFX+nD6zdpkWU6UT5yupp2wHo9oOUCx9uq3ZgPZsCIm02lcFG6WHmGZKAyf3qRS4vWhiK4Cy2PTr5XQspHuIcDaH4IiAdRBE56SsPHe6FYfdPDPNXEkkFiF7+ZADv8zqJx6fC9DAc/8HSiA0/fJUnJPaWTbYWyUux/2UtCmSKEOZHjaHWIvAOqx/IL3ze3gtA6mh62WLTDYc/4MgqW4Ji02OLETj2+JcHUwj03v5gVHt0rItuErZzhhkvcnovGAvBebkwumTZppFM5GKPOvYaCwjYX+rKImyzn4rCJhpxYTGF06dqL5wmQqaaZRe5K5162P4sBoL09+su80vWLEXaqizo8pyR6o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFQ2eDc3bGUyai9rRVozYTM5aEhWQUNlSnA0cks1Skw5U1NPeEJmbmRXbkV3?=
 =?utf-8?B?T25IZkNadHo3MmtVVndaeWFNRmoyelZ4YXFtd25YVm0zNUJMUFJZUXRNOVFJ?=
 =?utf-8?B?TUVzU1FxLzFyZ3Z5cElzc2dFTFhyb1JTemNKRHJmVEl3eHRWSjdVZTlUUjBU?=
 =?utf-8?B?WXhRbjZ6L2RrbmhvandFQnBVL3dSQVUvd2czOEkvVHlQNjVJVm9MSWtQRHdo?=
 =?utf-8?B?d0VNQjhQYTg3S0k1ZDRSTXJNUTRVVkdOWDQwOVpIU0tkdGVvVGU3WStQczUx?=
 =?utf-8?B?eUo4VFFiS2QwVzUxTi8wdjBRUmtQMWk2Q2V2c1pQdGFJc1JMV0Y3ZzJ4ckJw?=
 =?utf-8?B?Q1RpN3I5NStUV1RHNnZxaHNsTXpGMWV4UW05VDR6NVhwcW85MElYQ0JCQVFI?=
 =?utf-8?B?TFZTcTZkeFJkOWVsSnhEWFNvdVYxZlhoVUlJVEJaaDFIdkFrV3ZmcGxmQSty?=
 =?utf-8?B?UzdVL0tpajZHZWNzcEZ0RjNTdW84T0lzOGJjZFNRdkV6cVU0b0x6ZUhGRDds?=
 =?utf-8?B?YUc5ZFcvUnZTUmZNSzg1bVFLZ3EwVkxLRTJqQzFDSHIwWGhrU2J0d3hGWDFL?=
 =?utf-8?B?ZXJ3dk95TzBFWFRDYjhWR1V6WFhHTHZobk5ZS2lxcHJ3aXI0YS9XSUR6OVhX?=
 =?utf-8?B?KzFsRXlUYUVNREdWTlpvQnF1WEtRMGFvZldkWHNjZjN3cjZ1cDFnbzRIVG1B?=
 =?utf-8?B?Y1k3U3VxRkEyY0RlTDZGQTdMN2k3cXVsazEzcWREMEhaT3ZDUDNzSzdKSjI3?=
 =?utf-8?B?eUZpNEtZWTlMcWdRSnBsSlZ3TGZxYTl0RE1UL2x4UjBQSEJGcnFXa1M0WTB2?=
 =?utf-8?B?UmkrM2ErckZueWtwd3hyeXNQRHRqZVh3MklhWkJobkJGRjhJYzFCS09ETk9B?=
 =?utf-8?B?d0hGWmovNjM5SllaQ2cxQ2pOdS9GUDhEYVBGRktYRHhqZkw3NENmdmRzdCtU?=
 =?utf-8?B?OHhRaDNCUjY2VUdMbVlCOWNCUGtXRjVLNjZ3S2Ztbm5Ia1JzcjF1YjdxRHFW?=
 =?utf-8?B?SXg1R1VrTXFGa2dMQ1dVSHNVa1JqNit1VFdGbWxPdVBodXJ2OFVObk1FUWFW?=
 =?utf-8?B?Y1RnMmVOalAwa1ZMTnlBWFpDa042bnU4UzEycjczNjlWSkNHVXhGU1VWYjRW?=
 =?utf-8?B?R3RweFFQWi95UHhRbWdYSXF6WHo5OHZ6Rnd4UG9CTnFHV3RRdkRPKzYwV0x5?=
 =?utf-8?B?bUlUaWNhTS9mT04rQVRwYU9BR084ZE5ROWpwZDQ0UEVQcStob3pUdHZTenpU?=
 =?utf-8?B?RTEvdDFiZzRkMzhTYzJmRDFlTjM4RmtXa1UwZEYrWFNzL21lejlkM0Z3MFFq?=
 =?utf-8?B?bHZmL1pQYWI0OEl2dS83VmUyMmVBN01YSG1YaHFwTHFZeXNVRlRLUmpuWFNQ?=
 =?utf-8?B?eUliUXZLRk8xZG5IcEdrM29PRkxOTmlmbFdVSXBhNEhvaWlCeGtic2RZVXkw?=
 =?utf-8?B?K0IxaG91aC82bXR6b0NoN0hhaGtldUt1OWwzN3Q2QkdnZitzb2pXV3ozSUdn?=
 =?utf-8?B?dm5SbDBwVVRhVm8zelRIQ3dWdE81SElOMCs4RHZKNkh5VkE4K0NjclEzeDBF?=
 =?utf-8?B?SnlobXNlSlVvNzFGS3hzS0F5VlBucXR1L2ZHeFNFWlpaaHk0aEZnMG5scUR6?=
 =?utf-8?B?ZkdXN0c4YmdxdmpmcytLdlh4dHBQMHl3NDlmaE9QSXMxWFQ2WnFZYWxlUnEv?=
 =?utf-8?B?dzRSd2RaTVRWbGJqTkZXS2hJYm9WTktVU3VBRTU3cEpMdWxveE5XbXVYb2pD?=
 =?utf-8?B?ZVZGT2pNOUJrN052cjV5ZUovSlBldVJxU0MwQy9oZE9uVkpVQnFUREtBV3VV?=
 =?utf-8?B?S1BCZEZXUCsyUXBiMnQ5a1B4b3Zya2wrc2JLVkJ2WFF4TGdmWnRNS1R1djgv?=
 =?utf-8?B?S3h6ODI5ekJwVVA4TXJRaUtWU1R5RWdCRytlQWJYQlNkdUJPU2xINVROZ1VE?=
 =?utf-8?B?Zk5Odm1ZdDZtajZwanhlM1FOTXg4UzJPb1RBU0xrY0lub2hsQjRpSUxXaG5t?=
 =?utf-8?B?MXYxeGwxWEdkUEhpcHVraDJNZXZaZnNEdTVLZWx4Yzdwbm03ZzFWYlBiUERp?=
 =?utf-8?B?SlhUQVd3RklUK1pYbXpsK3p5eDRTL3RlV2ZUWVFZcjlHQzdlMmF3M2VraENv?=
 =?utf-8?B?Zzd6R0JiSm5RUUE5bUFCN2o1ZFprcmx2Z0pyUjdMN2VVREJtcVNYUzFnR1ZS?=
 =?utf-8?B?aEcyRk9OaCtGVGxSTDQ1Vm1tVEVDMEp0WnA4Ni80dTc2N1NhcjdSQXAyVlpJ?=
 =?utf-8?B?a01FRUk5Tm5xNVZCaDdBWCtrQk96R0IrZUhzY24xSVo4aXRGTGRscE1hVll0?=
 =?utf-8?B?OUo2OEpZVExxSGIyOHZGempPTDNtUEJpd0cxQXN0T09UVkpXQUNiQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f25f53f-75dc-4917-cab7-08decc5fc69f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:01:26.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQLDevKOHuv0Qicqw/bMA5w9HtDg6awMNDPsKCPewnlHOxvLgOmQSCgV9WyCIrGN3BFRv35HDKCInogubXKCgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3210

--5zdbnjgyfotz75ur
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
MIME-Version: 1.0

On Thu, May 21, 2026 at 07:29:48PM -0400, Aaron Tomlin wrote:
> Hi,
>=20
> I have decided to drive this series forward on behalf of Daniel Wagner, t=
he
> original author. The series has been rebased on v7.1-rc4-100-g8bc67e4db64=
a.
>=20
> This series introduces a new CPU isolation feature, "isolcpus=3Dio_queue",
> designed to protect isolated cores from the disruptive hardware interrupts
> generated by high-performance multi-queue devices.
>=20
> When enabled, it fundamentally alters how the generic IRQ subsystem and t=
he
> block layer (blk-mq) map hardware queues:
>=20
>     1.  Restricted IRQ Affinity: Managed hardware interrupts are strictly
>         confined to online housekeeping CPUs.
>=20
>     2.  Transparent I/O Submission: Applications running on isolated CPUs
>         can still seamlessly submit I/O requests; however, the resulting
>         hardware completion interrupts are safely routed to a designated
>         housekeeping CPU.
>=20
>     3.  Topology-Aware Queue Allocation: The generic CPU-to-hardware-queue
>         mapping logic is extended to distribute hardware contexts evenly
>         among the available housekeeping CPUs, preventing MSI-X vector
>         exhaustion while maintaining optimal cache locality where possibl=
e.
>=20
> To prevent I/O stalls, the block layer is additionally hardened to reject
> hot-plug requests that attempt to offline a housekeeping CPU if it is the
> last remaining CPU actively serving an online isolated core.

Hi everyone,

I am writing to politely follow up and request feedback on the v15
iteration of the 'isolcpus=3Dio_queue' patch series.

As noted in the cover letter, this version introduces a major architectural
simplification compared to the older v12 design. Specifically, the complex
"top-down" mask plumbing and struct irq_affinity modifications have been
completely abandoned.

Instead, this iteration relies on a much cleaner, centralized approach
using direct isolation querying via housekeeping_cpumask(HK_TYPE_IO_QUEUE)
within the genirq/affinity subsystem. This pivot successfully decouples the
core infrastructure changes from driver-specific implementations, which
should significantly reduce the maintenance burden.

I would greatly appreciate it if anyone has the bandwidth to review this
new approach. Please let me know your thoughts or if there are any further
refinements needed.

Thank you for your time and guidance.

Kind regards,
--=20
Aaron Tomlin

--5zdbnjgyfotz75ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoyfoQACgkQ4t6WWBnM
d9b4oBAAgArDIWRKDuUB0SMyJQ/HVGNWyTEqyt79A2XAAN87SIhZLiH7LCFTihKy
DoTuwSzMwftzNj6Ao+bMsj5BxAZg1SChzu/hVs4Yr/IAPiq76ifUIHnN9rmRcsAd
iYRyZZ/mnp64upI3BWfef8bx4otwg+2YsHrXhmHwS30otAVwgPrsC8NTXNybrziz
gd2s29nYJzOTg4pWFYEJrR8HRzeSAc5KF0BapiSrVdPSmpqwvW3R8ZsZuD9CwNE4
fwW1P9Ix30slEprYB4T1d/tbvwUEALqxqbm5MANfj9IRJEdZ+4ndDjNeEt6pzZaN
iPxlTRMDAnxQeu62Bj/us5Jf8fdul2oobMx7i/00LjPGWVslHp6xudpW0XvTh55w
XnxiAawxrnPjd09VRVylT2lR6TTAwlnpqGUUOWnoRZC97hcSK7ExG10VqJjVLbOW
vDnDdSDxdJX5T+JHwvaKSn2M1gKnIpKIeQOvVq1O6Lqy2oAOQ+tQf5WmuRZpiV79
DvFgVCzhujMTAyITUUG0YLv2ZlrYPYMuM+O8HwzXxppOfWBAXz7/vxOuHPDMQVRI
8fzaigHRZurxpZgHPQNa7GGbkheKjwBO37ubA471OmILfAYI3t2xa1DeJdZzKafT
GehOV6E9xdgqhwdN5gVwOj0TsefGaLwfy6qmdwjXh3mj20EDeB8=
=QtSv
-----END PGP SIGNATURE-----

--5zdbnjgyfotz75ur--
