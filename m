Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021111.outbound.protection.outlook.com [52.101.95.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FE3955CF;
	Tue, 26 May 2026 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832968; cv=fail; b=txi+/XCd3sLH3afHi7ZWO78kvoj2Cbsu8D5aNCpTzMtPssyLPmq/EES7ikla6vtfneNx5CbO5ZpapoI4ZAInx60jGAaXIHd9rKrfM1IRKMo6efrQf12BtSxCdJYWFGIK6+29rmfxbZqraOXwnjDNArAppXY1erRfkhHNgJlWUHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832968; c=relaxed/simple;
	bh=HxoGKoMn9LqBmkE9LapPqhnz4mtARFjRNh2Un67xLYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dCc8JLTl8PnrAMDzKlBMJUQoBAMlC+tM/i/SeY+oD4/qHj6LMYBpQAEaLgtjCqJ1ecfb5CREjM8eUqqcGpbeVN4Jadr7K7kyTVqxZrtJsU6BaggVrGA9iAR2QpP84Ur7mXlqKOLFAup8ZIvfhK9kp9OevP48tJOLnGP60DFRrH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0JJd01ZNORf2Cr2e8LbHamw4Nl2vG3vgi8aEGCB8XfzU9TkryNRdlgQALw6Qv0FimF5IzSmZO/ZcbUk5bQIwsCSEIR/NyfGfODBluyfSbS+eK6R5NdEy0pO5NPJ9Hynq1APvC1NUYboJpG//w+irkJRaxoIR9COe9I6ZCsT7c4LHL4xaZsVBCFRVOD1dMz4XXrVfdYaAqDPM6HUIAmsIIFKRgoWy0wf8+N8LMf7PTplT4KCkXSxMrOw5iQQ8cH29y61A35lrCvVniAQRKuX5xDZO81d5cf4UGCZCMsDpmNM0n4WBWhH+JT5lgehc9Ybyqnkbf6XpUONQipAv0GjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=HxoGKoMn9LqBmkE9LapPqhnz4mtARFjRNh2Un67xLYs=;
 b=k/O9Xwu48ApvnYnWVXI4Vr6qiWPW4pWfSTxmsBdZlVEn60PXE+vOqsWsEl4nxd/Co6YrkvKwC7DtZV5x0D/CspyzYAzzTtFnqWeos4FCy5BCSPEmdHnKTFAXxlil1y54aQDVrBa0L8pDxjyfM8Z7pOUOjv2zY4XBlznSFoyM3LZdcZxK6QwXzAoyKD3vdUXBpKBpoFJIAi+tRpCoNR7cmYKRrurwox+C7eM4a88seX2LhAR3GC7o+fCKIizqJGxggw0hpDJlgV+wdJ3gzpTCkgI5pWD89n3HVWZwX1YG0MPyNsIU0JLXxS0n3h/d8JZPBWpIzIyvxSi1m7UIaCsN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6112.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:284::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 22:02:43 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 22:02:42 +0000
Date: Tue, 26 May 2026 18:02:38 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Daniel Wagner <dwagner@suse.de>
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
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
Message-ID: <vtaj2dlvazlytflxilq44pwqvnyc3w3rcwpd7sri67kthrv2ie@ozh4corapeiw>
References: <20260521232956.553287-1-atomlin@atomlin.com>
 <a276d7fa-8ab1-4cc2-a095-e7e4c060a4ad@flourine.local>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uw5xtma3w6at262c"
Content-Disposition: inline
In-Reply-To: <a276d7fa-8ab1-4cc2-a095-e7e4c060a4ad@flourine.local>
X-ClientProxiedBy: BN9PR03CA0934.namprd03.prod.outlook.com
 (2603:10b6:408:108::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 7922ea79-4b82-43ee-9d52-08debb728290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099006|18002099003|22082099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Lv7OkTAzCLNCQeJPL5W2ymrUbRD78QjIY4wj69HIz/NOlHnFs8kB6N7XfoCEwnAYg0s3FQ1hw6+hYv1elKoTbGTFEgglnGBzSo8JzSWslTYqn5Eh8nqLu9qWGFjOUfM3VCWUKrzk+neMOQ9jifWf8j7btMYtVRXxk+QljwpKQrYG8FZROK0iqdlYrAVLnno6oVu5ClFWXvQMkr2dO1oP2067Gk2pOpVsYEc9mmFbMeYswkoBygt2ust1yp5Vh+loKwDb9X3xy1YqJl+0cCRZNMwAvs1rS1yzbQ3Av1htrAz4W4N9N+CKeLfgTxi5ZNVqxHvW2ydaLCGSTK6DEqUX8bxVD48FIfFqP18IMsz1Ze5jq+2WAPITgSC9b4VnDOV4hWikn5uA92UdOLb2C7R3n7gQoZmbNbk+Q7fcag1/loM6c7+H9YJBhjtwDLc5irjfxWXq5wGdB0sVk/flG5OMsVFDPcEUqt4GmLxrCB2cvcI1aekqOlVWgKvpBpVRnX5SAYqwj4qmGuo1M/XM3x29NJbOPXnghXbH0Qlsx2a6q57NRD6D/5XlhZfTuTV6I6ZMV1zKrvxDEVpqJHvMBpl1tEMdceUGX1A8CVCKsatz/U9n10xQLuMb3BqyMIav03y42ie6nV/J+nNVEIH2444ErfHdisTZfHSWTIzxQ+AyoeagsTDng5c+TciqxETlf+iw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099006)(18002099003)(22082099003)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmZzeE45Yjc3ZE5Uc3RlaDRyL01pai9PR1AxclYwY1ovaDNNWlR5TXJWNllY?=
 =?utf-8?B?QzljOUFnNXZ4OCtZb0pmellQZ2k3Q0owZ0FpdUZCQlUzK2R6TGNwY3p4TnVR?=
 =?utf-8?B?RGRpMzQxOWJEYlNaby9QbFVCbWwwNEpaMDYxZU9Vd3h0UjJFNCthclVXRU1l?=
 =?utf-8?B?UU1Ydlo3TnVGTC9MdURIMlVQeTVvZVdQT0RRU1d0NFY2VlpGekQ0YWlpd3pk?=
 =?utf-8?B?RHJxalF5SFU0MnFCWExJeE5OOG5NMDcrL2FXTGJ4cCtoNlpUZXBFZFFpYXhI?=
 =?utf-8?B?Q3BVeWpydmw5MmRDTC9BbFhXWjBTZ0FYOVBvRnErUUI1dnUzanc2Mnl5VUpB?=
 =?utf-8?B?c3J4KzRjMnhYYSt2OUh2MUc0c1FxWVd6Uis0K3BVbjIrbkxsMmc1MXMwZUpl?=
 =?utf-8?B?ekhsZ2ViOUd5RUJCdnBnL2pxL0swTXJQK3U1cnNqQkNSOWVPYnA5MEx2eTdl?=
 =?utf-8?B?U3IzZHBwUW5aWU51bEgvMWMxbldFZ25Bb3FUWmFLNW0zWU1BYUE2R3ZxZzcr?=
 =?utf-8?B?d0MwS2RjYUNFVE9ZeGdHcVhYYmZraXk2T3ZheTlTQnZuRVl2OTR3OWl6c0JR?=
 =?utf-8?B?RCtqK2hEb0UzOUFpRTZoQU5yalI3Y09UT083WnBGSFAxVkxCM3pWd1RwUmN1?=
 =?utf-8?B?aGdVcytoQjBSZnptVFhyU3NNcGdsT3hDSTc3MnpiZU52RHY0dnllMW4yUFpa?=
 =?utf-8?B?L2VYN1V1M0VOK3BHNWcxTDNMNEI4bWpINVZWZW9ya1Z1SUlvNnVpTGNxN3F5?=
 =?utf-8?B?ZjF1c2h1cTYwTmNVdG1DYzh5Y0NMZWxkK08xeTQ2NHZHQ3EwVjVNVHJncmla?=
 =?utf-8?B?c1NIRGRKOUVDcDFCQWRtZU9lVVAvWXhQUXNLRlhsbzd3cmg0RVM4c2FpTVhG?=
 =?utf-8?B?dlZQV0ttbEpaaEZxU3dtL1ByaVcyZURmbzZ6WFd1SUlKU0NleTNIeHplcnli?=
 =?utf-8?B?eFpURGZreEZjZ2pic3ZGRGhYUENxWHM4UWtFbzYwU1lZemVsdjdjNW1rODlV?=
 =?utf-8?B?YWZNUENTcEsyR3VzaWttWTRYSVZrL1crNVRYOGh3N3habGYrYjhEU0x6dTFt?=
 =?utf-8?B?a2NjVVpiUXBZYkt4c1luOHZJemZoOU1CdUNOUXpuN0J3NFMvU1dTRTBQa3lI?=
 =?utf-8?B?U2UxdW1NcWp3MTlUWjJOR0JjM1pBdGlDa2tVSHNwQitGUVBqV0tWQXhXTExX?=
 =?utf-8?B?dnVOMGNCYTVwZnRTR1BEVzFwbDZVaWcwZ21PaEt6NWNFQko5dEdnUCtWUEVY?=
 =?utf-8?B?N0RaZkVwZVN1cDRueE54TjIwTFZhZUxwY1NQaDFEdVNvZEk4QTV2SndEMXpl?=
 =?utf-8?B?elFLRUtwYlRPYzNkWVlyMG85cXBBbk4vWWRkTlltVFRBTTB5bUNqMlRBam8x?=
 =?utf-8?B?SjZrcm5EWFdSdk1PZGExZm9CaXV4N2hzcTlmeUhUdHJTNGpTRCtjUmJQZ3RN?=
 =?utf-8?B?VGNuSm1Db1EzUVJuSEFoUHRoNGI1MklTT2lYdC8vWWxLSXBNdmcrdWJ5eU5I?=
 =?utf-8?B?WHV6anhYeWhrTDVFbzRxT0dHL3RkY0dsQjNmSnlkOTlkeGVLbHFqS0JHWU50?=
 =?utf-8?B?Ym9hZnJhTlFJWDI3UkNCcTZYYVpvMW9lUzc3L0FLa0FxYkk2VVhpVmhxRFlR?=
 =?utf-8?B?SWJOTklVdlJ6UmhXSHNDWjR3ZGZGUk1qWFVaQ0xhemNNQUZrTUxHNHcwdHpq?=
 =?utf-8?B?V25Xdjl4NWhNODI0UFpZUFB0dk4vQUpTY05NZDcwK3l6VDRKaEJZeW9iVG01?=
 =?utf-8?B?ZW85U1VMa1dnQm5xZk1kRmNURlJsSXJGR2M2WlozSThmbXNLQ0pocm1KaDBT?=
 =?utf-8?B?clNBbDVleVVEUmdJWUUvbnN6OWJuZEc3L0h6dGVSTDcrZllBQXpGZHo0OEpk?=
 =?utf-8?B?V0NPdllkak5LNTNCZ3p4N0krQmt2UjF3SU5TY251cVN4RUg5ai9veXNzcm9E?=
 =?utf-8?B?bGdGOFNtUHRjVVk3YjRQdzcyUlhRODljdWxoMkVlTW1ISGpDYVZmeFNPZFlW?=
 =?utf-8?B?cjVKcUhDTHhKa0dmcWNvcGN1UDVxTlNUcTAxa3ZZUXM4OUhiRmhTMThkdEZr?=
 =?utf-8?B?MENJUC9ROHdhTDR4Q1JBMTQ0TXNZa01SZHdtdXI1RHhUNlN4Z3E3TzBnUGpN?=
 =?utf-8?B?SmxwVGJvT240VkF1emRPd1RuWlFvSndIclZRdDd3MzJObWpteE12bFNhaHJu?=
 =?utf-8?B?M1d1eEtuZ1RMRFJnQWVRRGtwdkZic3lIbldMM2ExTStyeUIrZFlWVlFBS0sy?=
 =?utf-8?B?ZVVzNEpWdkpwMEVwNWxCWUpRazVtMlhLUlA5eDVaN0xwMGtCTldUbFBOZFV6?=
 =?utf-8?B?ZDV0WkRHYzQ5LzVNYXVYUEFCcU1aT3h1SER0RGNTdUpXbTR5S1A2QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7922ea79-4b82-43ee-9d52-08debb728290
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 22:02:42.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3m7woPszkXSQNQG945GOiyN3uTTsWTnP6Ow8Pke0AsfwB3AbInV1VbJHiP/b1h6bCwBFX+J8nFVfAlCbph1sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6112

--uw5xtma3w6at262c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 0/8] blk: honor isolcpus configuration
MIME-Version: 1.0

On Tue, May 26, 2026 at 06:05:54PM +0200, Daniel Wagner wrote:
> > Please let me know your thoughts.
> >=20
> >=20
> > Changes since v14:
>=20
> You=E2=80=99re moving fast with these updates! It=E2=80=99s great energy,=
 but it=E2=80=99s
> actually moving a bit faster than the review process can keep up with.
> I=E2=80=99ve heard from some folks in the CC that they waiting for a 'fin=
al'
> version.
>=20
> Is this latest version ready for a full, deep-dive review, or are there
> still a few 'knacks' you=E2=80=99re looking to iron out first?

Hi Daniel,

Thank you for making me aware of this. I entirely understand=E2=80=94I cert=
ainly
wish to avoid causing review fatigue or unnecessary churn for those copied
on this thread.

To address your query: there remain a few minor concerns. However,
considering the rather rapid pace of recent updates, I am more than happy
to pause the process.

Let us allow the current iteration to settle. I shall hold off on
submitting the next version to ensure everyone has ample time to run their
tests, conduct a thorough review, and offer further feedback on the present
state of the patches.


Kind regards,
--=20
Aaron Tomlin

--uw5xtma3w6at262c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoWGHgACgkQ4t6WWBnM
d9buIQ/+P1Dq8u/WmUmiPjsPgmHP53byGvu5utACS1oAtV6tYAgZNEFu6zGDL6Wb
edS1yRcG+uVf3YKbAVK2r8BJYJh4xP7RnfFnYQmhbr3Dtu2JuDEitI6zdSKxb88L
Uja004WeRgk1k3Z1O8geFOASY6pn3FlIj6QY8+pFSpzu0M5+zoD7ln7DxjNjuNxB
A+spzN4smOqY+IjbW/P4P95FzLSyjaY4PQEv2kX5O9pGRBD87p1bmLN7KoL+JTLh
F9ahDIkMl623B3qJEzn3cPP4WQ4xq7PrRUwjH0CN2oYBKXpSB1KTYn849SCUmZ0c
SMcCpOC+P4/tvvY7n66CQtRGcaCrRkqTE6khMJ9/5vy2iWlkND5kkd7NVgBS0XwE
eLbS0DgBglks72khDBsHmHOR8fJ8/MASXNu4N3wR72SmqnGle3J1gyoIPIhGqAqe
21SzUhGuvBmeZiAaRO+qqypa1djZzwhd1ML2ycnOeq8783Y4CF7LVzf06PfYvVPN
Esllw6Ckmt3PaCAd6rdnERjHCsvOpQFctCMUAzHIEs5Mdmtc1GxmHBEYLtOyZeGq
N72BY0+DGhOspnur11hbasGvrVx3zTVfp5LcdIlQuL/pFH6EwbEYrWwjFVPVO1EA
VxcTep8d51e3PIUmQx+7ShbWNuv24rhafM9D+pvgaHp4X13r4N0=
=ymqi
-----END PGP SIGNATURE-----

--uw5xtma3w6at262c--
