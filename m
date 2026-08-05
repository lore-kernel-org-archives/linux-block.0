Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022094.outbound.protection.outlook.com [52.101.96.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7F3A0E99;
	Wed,  5 Aug 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956488; cv=fail; b=eNFS0Y0ER2SoORbnSdAYAEClJ7LP+77fai414EQLb8GCIzXkQkc5cpCCRRqHxxZTPboaLZRIe82gQNkfZZwAsc2RSZi7NQ0Ge9VDFkLbHwi48XVG8m1vIbb0ZV3AGsxnvE1UtdQS1H8xsl7BlBZeFcBRzdz7ENt/5DuiS/RBKOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956488; c=relaxed/simple;
	bh=NX7jW27mswIonBH2rfCc39A4cvp8xpy33E+gYW8XXkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sFoTtwdSv4hN1DXHYxovgz5KE6PzcDhtL2cCZlIzgShlB6wCWH3dn6nLTUGMAavwuEo3lpdt4D9X8s7zcHZHsPeKMPrUZhfOWkxBMHKZ9HxUGJbJquOIgNvsqUSP4R9RR4zvzoF87zj5vUCkWQu0mgUfqesI6eaJldA9IiC2hRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8ZTPu2aPXah6Lar8Vq0xTbX8pPqd/CeDN+pGyZYQmQTZQD7DIQMsf0D4VMStYGcKpr91qDYMY+9VM8aBjnclC2J70d0dtlNzt9SrgoEPqaFbrnXBd4Bm52xCf0Zq/OqCb+kfCIeOQbQ5M3HZRaruIkFmnBl++DqbaRVImVdWm5Lbw0mg/SmP3l6VMg9sIKDZXlTEHG45ogUQtsja7al6A3OEzNStFZ7SXPdmodf2Lah6ma7urKZ5rtxz2jxJtptoQTXpYg0+EKYPWSmKI5YGHgnU35TA967l2YJUom9CFoagzdVePH2P7FvlciCStuOSQBgYFdWpj3pc3SY9vnSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=OsB9P98gAX5or0Ry0xgVyMfIjWJY59MTxxOgmxmX80M=;
 b=xCCVCUxxKrx9IYiv81Ps55gPGtwXAzXxvjaOQNDcpKze2BUAAtQjZFh4ZlcjXlz8GftnI+bgzUPBqoAR6x7IxXe2PQ3BL1VlluBHADLFGtfoHOFCaKEfZB7UUKdEDypVReBiOISR7sTn8QKDYxhws6+zBHgOIgjey0MLIhtceKhsxMjTEkfS8oZla5QRajuuKeNlidfwXFTTnwpneLJtdLoafixZQdNn+Shy95w88cIiYy2ZtU0k1FMkVSxSywKTXvCKo1fSbtloN2+57tFLmess4/RlOuT/vcEXp0v+oBnVItQgNZ6dp0opT6iC7pssrenKHs6z65Up2clX23uDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO7P123MB8529.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:01:23 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:01:23 +0000
Date: Wed, 5 Aug 2026 15:01:19 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Marco Crivellari <marco.crivellari@suse.com>
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
	rishil1999@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <j4vezfte2lairuxebayen2meqyqbwl33vv353gsgh4bfr42w7j@szhqn4zqxpnx>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <20260521232956.553287-6-atomlin@atomlin.com>
 <CAAofZF6xLwOdGj1mPA7ayhnAfSFBhBv7kYOfgbyDY0dQVMz65g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xy7g6nepqqsjswe"
Content-Disposition: inline
In-Reply-To: <CAAofZF6xLwOdGj1mPA7ayhnAfSFBhBv7kYOfgbyDY0dQVMz65g@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:408:f7::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO7P123MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: e0598fab-2bc4-4439-c464-08def323f173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+XNuxDBTlo3dtaaHeRqMwMdNVMVNOCSPkIpM74sDW+aF9VnIw2uyc2Px2x6LW7cMEhndAe6palE85MDhEYONtCEr2izO8saMX35cGmSGs/8GvZMhi+Mg5mGO+q5R3Hvha2hZtdGtZxSblN9mkuXMw5gMir1Ge1Uec6/Yar4I4BwkaHGyTtgv73nOriEAT/rRzO8rITgAJTDBb0zIpCWR4TBsMP5eDJYn24XiMtidladUZFannp4MNGXqtP8D/KDeu21UDOCgFMW1NoFBXcr3sH3wuhaVN0SWMt85ejId8Txl3clCUMiW8/PEEZT6WZuqSWfSJECaFyHWabVMyPbCQZsIePSuS1vRt1/p/e+dlxkSzrUWHEMXfDGiSb8JBPOufMVUGmSHpZGHyAYUI13tAXvpgZyCpwPwqO1+aMkwZWyIM7lT33Ks4DKYK9aEDIPCS6nOUOLgvufIN+3UAhSZ/Pb/DaQQvV6YCiP4Qbu5MFFlhXdJZ07W1juuOwK8xFbS/7Kfa+HeLt7ST6IGLW1uqg+X7zx4lqKV1YFouaPU2QZWzlAu49ofM4K0ZYFlTSYffQTrY5nrWDuzJzn94EX4h5HHTOGODrChrQ1YJMtDUxlVsu9vUH9BLGnhW0s9Br/1GEmlzG4fWp9qgdZjXuGUkX2Uj6p9R0dhauemfKoPhqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2hkUkN5NTJUZjNydERXZmpyUXlCTytUUlpCV2R5eGRubkYxQnJMQW1NN2dJ?=
 =?utf-8?B?ak0xWWZTcVZXVkZpNnJPdVVMSVA1US9pRjFHYjZjODJLcEVXbWNoSXFnckJS?=
 =?utf-8?B?d1M1ZG1KMmxxWGNrYThRWGJ5dE8weXRaeld2Vkw3S1R4Zit3ekdWNUVURjV3?=
 =?utf-8?B?MzMzYkl3cXEvQXZGU2Z0NE5GMitjd2hXellteUkxR21HZWZyNWs0YlI1ZjBY?=
 =?utf-8?B?elBiWjRDNFc2OVMxN24ya2V4K3V5MXhFWGV3U1FiWjM1bmFON0t2YmEzZWNL?=
 =?utf-8?B?UHpJekplZVRhQU16UnY3TDBPeEVGVUQ0bGprYlkvc3hBMVdFU3VNZ0FsbTE1?=
 =?utf-8?B?SzdxeVprc0dxZVM5SllTK2tQVzVIWU54eFRtL3RhdHZEY3JqRmllaDByYzdv?=
 =?utf-8?B?Z1prT1kxSlZlNFpOSDJ2U3VvNi91bXJabjFZdElVV1ZiLzI3T2RCckhjQ25x?=
 =?utf-8?B?T2I1dVE5K2wxa2syQVBHZWZWakF2b2ZIcFBIUjZQYkR4eGcrS2U5OU16WGdW?=
 =?utf-8?B?eVJiVWUxenh0dk8yT05xem1PR1lFQm44UktVaFBMY2VWL3FnQ0RRNDVYNHB5?=
 =?utf-8?B?YlZQL0hRL3hSVG9IbmdLSEZNZDFUbENwUWdsNGxqYzlCVGp2QzlsYmhuR25n?=
 =?utf-8?B?OVU0eTlTWXVzcG5XSjh3Q3RicTlmc1BzVmJSdmVVa1J5cnQxSUdIR2U4Wk9u?=
 =?utf-8?B?N1ptUHl3a3VPVERQdGR0UFBOVEh4amJQRmZIYUhCaFIwYWtVbEtCa2NIaE13?=
 =?utf-8?B?U3I2Mk5ZUExKc3NCZXlraXlEay9JYWV2c0pJcUhDcm9Fc2RHaWVTYWZ1VS9y?=
 =?utf-8?B?Z1VINkJucGRVQmlTOWVDRmhaMTJmbmE0UVhJUjcxUVhRaW9vZUtSTWZuVWdK?=
 =?utf-8?B?M3o3azJwYnBxN3p2Y0EvTUFha05WZVFrWjdqeXdkNzIrY2F6RSttV1RpeTNv?=
 =?utf-8?B?UUF5aUV2UmhRRkpDOVZuOVNQNFFvejhoYWx1ZWhyR3paTVZpZ3VvSnA2N01M?=
 =?utf-8?B?MmswSFBlYzBObHg3bXhsenV3MGRrSnNuWUlFTHdVaFAyeklXak9KR1QrMndk?=
 =?utf-8?B?aXFMR2lBUTJwOFpRdGxldFdRRGpMU01vMGdXQk9lVXlQSC9EMlJOek1Nb2w0?=
 =?utf-8?B?c1U1RWZZSms0WWFDaW1zaUNHMHVrNVQzajJ6a2FXa3FwalRQbmlVSGNvQ2Nr?=
 =?utf-8?B?elVzUDRYMmNOcDFMMUNVYXVaVGpYL1RzQS95Q1lsb285S0JybWRiTEZjWVpE?=
 =?utf-8?B?Ui9PYTFhZWN1TjVSZzd4emNwdFVDcDV5MlJPSFlINXh0Y1hoVWE5QnhSLzAx?=
 =?utf-8?B?Z2lzOUVDR3U1Rk5yUnJmYklOOW0zMDhEZ2hZNzBoQXAxQllxVHRwSE1PeXl2?=
 =?utf-8?B?ajlZS3dIaUduMmFtV3RVSEhINlJ3Z0RHK1ZhWXUxVjBtcnVCMVVTL2ZCZ2lY?=
 =?utf-8?B?Q1ZvR3Q4MEd0Qk9IdmNkS0Evek5yODhDc2xYb2dHRWNTRGhiUTVSS1AvR0VC?=
 =?utf-8?B?NzJXVy85d25VaFp0WEFKZWlnd0I4TmR0bFpoRDRhUk1MamIwYkdON2czMk1R?=
 =?utf-8?B?UHRXQ1JyZSt0RE9yWjVJbHlIU2pWN24vanFGOGNUdnpxU1pyVzlPSStTL1ND?=
 =?utf-8?B?YWxieDdlTkVZN0preldORW13Tk5vbXlaU1g3RVdLVjFjdnd5UTZ0ekY4OTR4?=
 =?utf-8?B?QVMvVlIvVzdPbWc5Z0VzY0x0dUVPQzJoanVwUDQ5dnVBV3V1bjFKVDlTYUNl?=
 =?utf-8?B?VHhzMkoxWDZ0WUdLUWpabTFmM21zZFdOV240N2YrU1k4dExkVmFTUEtUWFlm?=
 =?utf-8?B?Q2hhTS8zeFM4V253RjlJQTZvRzdiL1EvekRvcVVCOFhPRXNRbms4VDFubTJN?=
 =?utf-8?B?ckVUbm1uV1FRcnpsY3JkKzZsTnVkODBpK3RHTDJvaDI0OHNIczBkQVBMRFRZ?=
 =?utf-8?B?aXVwUGgrUG04Y3RhVGZNVzQzajRoSmttdjRuS0NkY01rQkJxRjB4RDAwRlhC?=
 =?utf-8?B?K2l1QVhwMEphRW5qNEtWWE5MSk1mTzBJRU9oYUZPMlVEUkR4ajVKZTdmMmZU?=
 =?utf-8?B?UWdnYlNFSU1DS0NlK3VzalY4d3ZKaDhETDNhYnJCamluL3RmTGJUWHNFQk5P?=
 =?utf-8?B?L1Rkc1NmUXQzbSs1azVtOW9IRHlvR1hFNm1zcHVra2tJbWR0RUlSdEhOMjZP?=
 =?utf-8?B?b0srNTIrQnN3SEI1bk0xRTJsZGJkcUhoZ0lLcnMwQ3phSmdOamdXWG9Hak9v?=
 =?utf-8?B?cGhNVE9TRktXT2wzanZwRGg3dkc0R2tOZ3Z3ZkRoc3Yrdm9JODRJUGdCdjV5?=
 =?utf-8?B?SS84UFVZSWozSUl6czNzOC92QlBhUnpIZUtxU2sxcE15cktGRTF0Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0598fab-2bc4-4439-c464-08def323f173
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:01:23.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTtodgy/ioR7kUdpImVnjHZx/J4ZOadakNAlLeSEV3nSNfemncBRAdYtp8vAiud5D8SCg7xtecvJAjGTqwYZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB8529

--3xy7g6nepqqsjswe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 5/8] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
MIME-Version: 1.0

On Tue, Jul 21, 2026 at 12:28:04PM +0200, Marco Crivellari wrote:
> Hi,
>=20
> On Fri, May 22, 2026 at 1:30=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com=
> wrote:
> > + void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
> > [..]
> > +       /*
> > +        * Snapshot online CPUs to prevent TOCTOU races between the
> > +        * mapping phase and the validation phase.
> > +        */
> > +       cpumask_copy(online_mask, cpu_online_mask);
>=20
> I'm wondering: should this code be protected somehow, maybe directly
> by the caller (eg w/ cpus_read_lock()) to avoid a CPU going offline eg
> after the copy?
> This invalidates the copy because a CPU set there might have gone
> offline, and the blk code would then still use that CPU.
>=20
> Does that make sense or it is not the case?
>=20
> Thanks!

Hi Marco,

Thank you for reviewing the patch and raising this point!

Yes, taking a lockless snapshot via cpumask_copy(online_mask,
cpu_online_mask) introduces a TOCTOU race, as a CPU could go offline
immediately after the copy, leaving online_mask stale during validation.

Rather than introducing cpus_read_lock() into block/ to protect a dynamic
cpu_online_mask sample, a cleaner solution is to align blk_mq_map_queues()
with existing blk-mq architectural patterns.

    1.  Refactor blk_mq_map_queues() to build mappings using the static
        housekeeping mask intersected with cpu_present_mask (or
        cpu_possible_mask), removing the dynamic cpu_online_mask snapshot
        and blk_mq_validate() check altogether

    2.  Rely on blk_mq_hctx_notify_offline()=E2=80=94introduced in patch 4/=
8 of
        this series=E2=80=94to enforce runtime hotplug safety. The function
        blk_mq_hctx_notify_offline() already runs under cpus_write_lock()
        during CPU hotplug and explicitly prevents offlining the final
        housekeeping CPU serving an active isolated CPU


Kind regards,
--
Aaron Tomlin

--3xy7g6nepqqsjswe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmpziHoACgkQ4t6WWBnM
d9YSrxAAtLsWXYYMYYOQMRFOJKQ9y0ktzKASBIIIUbZ1wDxwJdzK3vg6HXYxHbRn
TR8++VuJulqfQZ9xu0ecvUIUhSzPzAB+Y636H/w9VjREtU4cHm7TzUsAWoCUtv7S
/T3GbTAjT+tXBrVweT4BNMej08O6N0BMDbIxRwRTBMsg+0UVrQSR9Xuk99z/usyU
i4ZAAnkbGVxuOu2bc3O6bwui9DP+fg3FL4TqCcNKHq57UFvnNy52YfGgvLaD5zuI
CGQuVQrZzkOKlaBD9DkrAp8+59eNzoFHaAu6TBBqk1nujnwWuNW8cxAdRDOMWZcw
UjIPpQF8BAkqG+z3bVA+rX57Q/qkCN/S3xNE9k6LeXW0BZpin3SEDiCWC9fT2tVb
kE9XnmXuAatYMrd2W9Ou6b1NeZjnGHw5jS2yi9/b3TjBknrko7njXmAIBe3drF5V
YwIgymbEveh4aBRGoBmfDpLej6cDbuiZSKb1wCH+Y7gTHo7Z8uaiSKjGi2AMau7O
jw9epoFrjsjHbetbwtc8r3jIkh9LmxxHmus8u9qaZS4ONkwGYwAFHy5qci8pN1ci
LtSds+QIJOOPT/JVzw8qFisKiLxaiEgPdg8QYagHxEk48xLv5VFm3dqF4wSXP4hi
LXM3r3E+Rp+AY0aY5KUDLgatOmDwcemQSOGpjSDAmjyPyl944Fs=
=AUdu
-----END PGP SIGNATURE-----

--3xy7g6nepqqsjswe--
