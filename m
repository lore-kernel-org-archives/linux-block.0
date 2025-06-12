Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D1242A82
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716276; cv=fail; b=PZgE9ujNJXZ32tJnPJFMoXNDG05PPPlvtj4/ZG0oIfzlZXPsXquf37Pol/HAQ8YX/8TIaLSvtJHszsgMFEijV1B/VQ7TutKM5CzMGXdh94D9yq6kOzYWCFY+X+jy/9xDgXsLK8D84zBmVQ8kpoS+/8PdM1a9RjtSpQcg3oam8ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716276; c=relaxed/simple;
	bh=fpiRFgzi9O1DYz+6jB9+hinELRBHmk/t+EhVMR1/1TA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GcuKh1A/Ut3wC5yCSJVmo04VHaB4zFc1Eb9gZc2fLsNgEnJdtDbsOKVpSW64twPAJ0/iZ6RAKf2gzs5qR9zCI7nc88Ooh+O7AQ4trx3VrshGA8LNM06PQ3a1ZjqbRglL2hBNgagOuGmkIsnFku7AL7V1RChzLYVlidmWQDBFL+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOj9Trtn; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOj9Trtn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h79o3ze4sBg25MIZCZLfvOjErpvU9IMVdNu1mHIXdca5QK5P8hEryLU22+A8t5WgpIYQfsUdK+THUGbElW4JIkbGuXh0elmNA6kflu/qv6DWswEZCiGEOy0vNdbG1RGmNW149WRsAyhuMp9VyG+zU8UwTeGH3yiRiZqHDj6RCHUbiO27wuaEpyYICascKmmFHGgwtWKWzkiPpcDOX9k4a7Ts/qDJM/0aIQuOfAPnB9lG3nZ0iOXz8hO+G6k9HjA39XER+Bvidyd6QF/GCDl8nJxuFFLaRXEw+gNJXgPBPLiaMkwP+aEOodlTujTOsh4OevkKG3HXigMapaY1nWePsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyzoXaSj8Wj46KENsTn2wV37jQAxVYmhsznJvsma3a0=;
 b=N38ka7OEC5kECrvW33kG5Vl0OJ+9LOdHzWGuyjKt0pv7djSr3vnMALeT5gRfZlSHVENwFw13J6gtffkbkOoShhbuAPsnZHCvO3QrvAYPFa/Tr9MXsZoRs3jS/bFe081cNPn6RqYWFFjk2WsJpp7UJiiJkudj+qEUFK3BvHiurkdN0ESLV1y37uhbdhT9Bu7K20WKI9nTjDptUe7PcgQyjuh4v+XjFZejhdqMg9gA7cqlgT03FCWlqFw+CDTaMbwVzgB93T0NvIPLyWwwtA/uc9xy+4sqqFZDXNmdjg8Ai6NqcOhs8e0e5CTG/fxr8JwuiSVRja4XTQ73Pd8XT8CsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyzoXaSj8Wj46KENsTn2wV37jQAxVYmhsznJvsma3a0=;
 b=VOj9TrtnbhxEEeIb81EOCb21fT1wt5odQ7+dQCUGOFkxg107aHCtueBhO6xOO0l0RrSmdC5Hg4Y3IC5eDJohmGQd2VIzNKxFj3TEqUvBoljOQl1EkfT3xVwha3UMeJ7rq+ZMRlfp1nVU8JX8uxlCE+rptCFVjANyiBL2QaJlAEf6AN5x8pvIVgUPodktUt0vLr2n6Lheia0jcABpaQXo2HJk8L7XCfiX10sJIQQ/TQVDI3MuQM8PRNxB2Hhp08PwnPKeo7kCjpegcXnp5n3mrw3d/zaiTN9YmHb5MjzHv4TTgom1tIQdDIT4AhoY8/xLDWzxBLH7LIbuOxgV8LcGLQ==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 08:17:49 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%7]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 08:17:49 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Uday Shankar <ushankar@purestorage.com>, Caleb
 Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Topic: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Thread-Index: AQHbyzeSSRaVFqTPg0GnAQDdJHQew7P0ldE6gAFlm4CAAxP3QYAAXvCAgAXfTWQ=
Date: Thu, 12 Jun 2025 08:17:49 +0000
Message-ID:
 <DM4PR12MB63280BC70C29A91E973E8080A974A@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEK6uZBU1qeJLmXe@fedora>
 <DM4PR12MB6328BB31153930B5D0F3A3C7A968A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEWfWynspv75UJlZ@fedora>
In-Reply-To: <aEWfWynspv75UJlZ@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|IA0PR12MB8376:EE_
x-ms-office365-filtering-correlation-id: 14914724-6011-466d-0d61-08dda9899e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NFa0ziU030tT9eudBA93GaYUtYGbHOmFE/3Z2d4pifnVBzJ20Lh3XYAeKZUA?=
 =?us-ascii?Q?txcPGSokNaaadMh9mj1tXUY0IB2h0C6c3+gZV66JQnjGp4C8R6Zk3GMCU1Yj?=
 =?us-ascii?Q?sJjTNNPoMUHT2rS0XURX+fyvBRyZzxeJG6yTK+MnFmLzNcKyU5UpA17qmWAT?=
 =?us-ascii?Q?8gMKRQqiUikgfIDcJDD57qTTb2BwZ1zZ7RG4SJBzoyyxKdPuguYLB5z+/RHy?=
 =?us-ascii?Q?codAxZ8SmxvSsGI/3iCsCwiDEDNzf1nO84RZtT3HuCKH3qfiK/CYoJq1Vxp4?=
 =?us-ascii?Q?csZYCy1OdwV+tKUvbTJ1Ixhb6zMPduBsJ/DLL5hG0SLYqyTZPL8aXelJKDx2?=
 =?us-ascii?Q?ApaJBVboH0cWvSWnra9OSMK9XK2iJPD9KaDzlBIr5vcjXnz4DcKIhPWWqWY4?=
 =?us-ascii?Q?rs0nnDSNgpRNUjhGCOUm+SBF/qPUG5z0RzHWN8EHy5dt+Nck0B+Wqz8CnKbH?=
 =?us-ascii?Q?OvE+h6rJJn18pO2rn2ymfcB7NX7uxzP87ue9DVZnZ/gKOXiNzCYuD4+e6qMz?=
 =?us-ascii?Q?gB58kr3YLJk9rwqCFQq4Gfj7iC+IbmBk0pS/l8no1u2D4U+gh5d+pvnBofOY?=
 =?us-ascii?Q?8KbpFQhI9LQJj1Hvf3sUDpZ+NLWE53SvHy7AIasNoVEApU/sFuMfNrFc+FgB?=
 =?us-ascii?Q?lcmPvpvaytLZffYguD7ympsvpIyfNc5EfiYqT0xFIfCVfZjefyqMFnRFYUEw?=
 =?us-ascii?Q?dckagf2e5pUSdF/yruxAVytPjr3ucvxBJepAcTC8NUgk7PMGcMg9hi2XJYXk?=
 =?us-ascii?Q?Bds6TaGkSu50VlZj8v+/fF6RvqtYwlMXUB7RG00s9APu4ggC5fRaVsOToUNC?=
 =?us-ascii?Q?lpJ0TrUqrygZ5DTq7uwKv+sFgbBijEtUR1D7yC3/9XbhPX/H4Hu0Z+gpT+Mr?=
 =?us-ascii?Q?9Nhip2/IbLIr8oqeq+BMile95ryskQz4irFbmof7jdTxhrkIs5H54racQzph?=
 =?us-ascii?Q?ddvnZBM91eQaWHHKfShq8qNjtGgIcYEvtPTpf8NjUqX7Uv1jxzREYb/c9r3i?=
 =?us-ascii?Q?PNNexjp6bAPL/sJVjS97UfqPeV54VaIl78EQmDE4OwaZIaLtIwHYqAQc16zT?=
 =?us-ascii?Q?ONLgCD+MQV+p1MuJlAVFsFraSD4fbYIa2w6b0uG0znG+t7LHV9/eRtioAa2O?=
 =?us-ascii?Q?HCk2ZGChTZFg+qZU5nA49c5jlCuLg+8IoxSwVKjiPPxM51C0iGvmrk7nDR2r?=
 =?us-ascii?Q?lvQaPJRIqBiUgpNrVpjybQ7/Q4etSbtjO7HgsiiwGf5xbNrAkT3tWNS65RIt?=
 =?us-ascii?Q?RQOqAvaenZXrTY+4ACyrMJ7K0a7nVoAW4JfeY2R+LP7IcADutg/zEoeMctXw?=
 =?us-ascii?Q?nRBMZobmJg/l+fYOnfGezgn7hndlFV/f5g6UCpENSa+pDkvRZpFBYLb3VYiW?=
 =?us-ascii?Q?BbYzBH7hlIBrqO0z//qwCLtLKy8l/kge5xEyYB8EXaPDXBQ5vfAj9DD5C85C?=
 =?us-ascii?Q?+Z7yQWQRSeD7ZFE8WrZfz1WbY4WDTLWOzBQIzZxCjREQloYUaQ/Wq7k+FvAq?=
 =?us-ascii?Q?hkAe2c8RWuDmM74=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?koUpOxS3T640HBMmJGCekIiWOw0qiXRFlNcKTRe1ce7BcEFnsmbebSadCcPK?=
 =?us-ascii?Q?nfCFId+vOJgj6fXByS0IGMvYPf2dHoG4ahbJG9SDFLW7hUlGdDQ6ezJIZzmO?=
 =?us-ascii?Q?lQ3oSV9MMKGysXAR9YZKWAQ/od3sNWaq0cd3wpW16GQjF4H1IM1111ROGnxL?=
 =?us-ascii?Q?DPtwz5amYrOiUmDyKlEimONBtf3PXshXvsrZoCrVG1Noglr9q8WvlQMTSC0E?=
 =?us-ascii?Q?KzFXh0QmTIsLD1oZ2UB7uH8hKp3LfE9RDLonYHI7FAKLGi5S5yX4sx0NZDtm?=
 =?us-ascii?Q?HoHg12ywgztDODmJVwGuWcqbG+simqhL+GaoCfwfMqR/Ccnr2QFJYGXm1zK1?=
 =?us-ascii?Q?3JuQhK1CKDiipc4e7Bfx/RVHSfOrnQ2NJ/4bxo3iU4Gy/QihHyPjuBePpfi6?=
 =?us-ascii?Q?28l8fb9xnJ/vG0m48jWPheJSACJUQ5jt52e7HG9Ymt0bz11TpW1F0wnJ4YJE?=
 =?us-ascii?Q?2E6z72yrie3AbA7fq3NaNfwxhl9/tJ5idO1ukwvol5eWULmQiBRLkbyHo0/e?=
 =?us-ascii?Q?yl+G5IOEnwiWfCjAI4rSlNl2eSmy9kaAM7l3j+FozZVSXQ9OoX8769VtiBrq?=
 =?us-ascii?Q?siDA/i+JGIhbkhQytWJV6q7CBpbZgqEjP0Oy0zsar1LaFV1FkrOSmm14xJyZ?=
 =?us-ascii?Q?G2IlZR0JHor+Vt53tqdwxAwwwMJszVHgX/d6Ij6qYL2SBx2a3TlxHKLYtK/A?=
 =?us-ascii?Q?iaIwQAMdJ6xhqinAGobUuSR16GwBv12fbCph4tW16cL6wGHYcZOfFqDemk3r?=
 =?us-ascii?Q?5rib7QGT4ShxCrqDr3GIMwiHtr75iUuXgV5w7L+e9uCfmunMHzCtq8t07VDe?=
 =?us-ascii?Q?zFUQRF6XTHx/H6t8Z7O+wp3WxTOT4sIJ49eGnSbrjAbFZbmR7gjCZi8CYpPf?=
 =?us-ascii?Q?GUNbwrl1SVueKyhXSO1c/sgdHv7srX1JpYerd2PesC0V0jvBir2IeFAi7aZg?=
 =?us-ascii?Q?NsmP0QLNHoNJzie6UVMJTSJLs43C2DCQdABR3X6JmfeNhDoJywB1wHvuUmyu?=
 =?us-ascii?Q?ffKYs3/k8rFKTi3chIXEHTX/8YRK7e1lmLM/bs4LlbQMxnvE/6Bt1KJjRpR7?=
 =?us-ascii?Q?FrErC0C0r/NSTInhuOyW1UCxfqRZhpO+SgijxbquxkPAs5Mn4kbeSGKopDaQ?=
 =?us-ascii?Q?8zVmxAA1ypyfBumlumTM1uIhCvHIQ5Q2puUeKOxiBk+VeSESGBfFkLCwFlzi?=
 =?us-ascii?Q?Keo4sZm7ScIQMwwnSrWkZP3qNtSIge8ZE3c6g6s60Glr57L58CIr6OBhffJ3?=
 =?us-ascii?Q?57Sgp5Ch6w+8h9ALuw2s3z//YoyT+u1eyuHjeYrTutXYJH+PvBLbqwsSKQGO?=
 =?us-ascii?Q?n9aUIvvfxMrN78rgxmYXa9Nl4jv9ZbG1DR46M3tfye/9BUsxdGDcjtxgypsI?=
 =?us-ascii?Q?12tZ0X5LMfRM3e9V+1j1nwmdX301Zqks6qDwUrLK/ODJgEbSbkLWeHwvQX49?=
 =?us-ascii?Q?wGAfXOx3XdKLWNoMai1M1WEr8sREcdP+b9tRvGJDWiwGbwysAWvztW6HWXbM?=
 =?us-ascii?Q?u64gZjumKpIcBAfyraxXZqCxGS9vAhKEZVTb4sF3gRlBSXuda15mtsBcPOW9?=
 =?us-ascii?Q?olIygE4S5YdvUgWOz9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14914724-6011-466d-0d61-08dda9899e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:17:49.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: op3Kk1S45GigfmoEbPovd6Xv6nXVkFc8tKc4B3+lq9IxFyof7P0cW4xuEuahe35B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

Hi Ming,

Thank you very much, I managed to integrate the feature to our application =
and it seems to work perfectly fine during our update tests.
Just a double check: when UBLK_F_USER_RECOVERY & UBLK_F_USER_RECOVERY_REISS=
UE
and QUIECE_DEV was called - does any IO that will be completed using COMMIT=
_AND_FETCH with a failure (i.e result=3D-EIO) will be retry after the recov=
ery stage?

Thank you again!

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Sunday, June 8, 2025 5:34 PM
To: Yoav Cohen
Cc: Jens Axboe; linux-block@vger.kernel.org; Uday Shankar; Caleb Sander Mat=
eos
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE

External email: Use caution opening links or attachments


On Sun, Jun 08, 2025 at 10:20:25AM +0000, Yoav Cohen wrote:
> Hi Ming,
>
> Thank you for the reply.
> I understand now the requirement for the idle IO but needs your advice.
> On our case the backing IOPS are going over the network, when switching t=
o upgrade mode we are shorting the timeout of each IO in order that the app=
lication will really finish as soon as possible.
> On this case (until now) we used to prevent COMMIT_AND_FETCH on the IOP/s=
 that are fail due to timeout to prevent the user for seeing the failed IOP=
/s only because we are on upgrade mode.
> Checking the code I don't see how we can do it now as there may be a situ=
ation where all IOP/s are failed due to it while calling QUIECE_DEV.

If the network IO takes too long, you may provide bigger timeout parameter
to QUIECE_DEV or even wait forever, and any one of inflight IO is supposed =
to
complete during limited time, then QUIECE_DEV can move on.

>
> I saw that ublk prevent zeroed read but allow zeroed write(__ublk_complet=
e_rq), is that just for supporting devices with backing file or a real requ=
irement for every ublk device?
> Any tips if there is other way to make the kernel retry this commands?
> Thank you.

Please set UBLK_F_USER_RECOVERY and UBLK_F_USER_RECOVERY_REISSUE which
won't fail IO during the period, and all should be requeued after device
is recovered to LIVE after your upgrade is done, and all won't be timed out
too.

Please check if the two above flags with QUIECE_DEV  work for your case.

Thanks,
Ming

>
> ________________________________________
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Friday, June 6, 2025 12:54 PM
> To: Yoav Cohen
> Cc: Jens Axboe; linux-block@vger.kernel.org; Uday Shankar; Caleb Sander M=
ateos
> Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
>
> External email: Use caution opening links or attachments
>
>
> Hi Yoav,
>
> On Thu, Jun 05, 2025 at 12:37:01PM +0000, Yoav Cohen wrote:
> > Hi Ming,
> >
> > Thank you for that.
> > Can you please clarify this
> > +/* Wait until each hw queue has at least one idle IO */
> > what do you exactly wait here? and why it is per io queue?
> > As I understand if the wait timedout the operation will be canceled.
>
> One idle IO means one active io_uring cmd, so we can use this command
> for notifying ublk server. Otherwise, ublk server may not get chance to
> know the quiesce action.
>
> Because each queue may have standalone task context.
>
> The condition should be satisfied easily in any implementation, but pleas=
e
> let me if it could be one issue in your ublk server implementation.
>
> Big reason is that ublk doesn't have one such admin command for
> housekeeping.
>
> Thanks,
> Ming
>
>
> >
> > Thank you
> >
> > ________________________________________
> > From: Ming Lei <ming.lei@redhat.com>
> > Sent: Thursday, May 22, 2025 7:35 PM
> > To: Jens Axboe; linux-block@vger.kernel.org
> > Cc: Uday Shankar; Caleb Sander Mateos; Yoav Cohen; Ming Lei
> > Subject: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
> >
> > External email: Use caution opening links or attachments
> >
> >
> > Add feature UBLK_F_QUIESCE, which adds control command `UBLK_U_CMD_QUIE=
SCE_DEV`
> > for quiescing device, then device state can become `UBLK_S_DEV_QUIESCED=
`
> > or `UBLK_S_DEV_FAIL_IO` finally from ublk_ch_release() with ublk server
> > cooperation.
> >
> > This feature can help to support to upgrade ublk server application by
> > shutting down ublk server gracefully, meantime keep ublk block device
> > persistent during the upgrading period.
> >
> > The feature is only available for UBLK_F_USER_RECOVERY.
> >
> > Suggested-by: Yoav Cohen <yoav@nvidia.com>
> > Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5A=
B7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 124 +++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/ublk_cmd.h |  19 ++++++
> >  2 files changed, 142 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index fbd075807525..6f51072776f1 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -51,6 +51,7 @@
> >  /* private ioctl command mirror */
> >  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> >  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> > +#define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> >
> >  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGIS=
TER_IO_BUF)
> >  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO=
_BUF)
> > @@ -67,7 +68,8 @@
> >                 | UBLK_F_ZONED \
> >                 | UBLK_F_USER_RECOVERY_FAIL_IO \
> >                 | UBLK_F_UPDATE_SIZE \
> > -               | UBLK_F_AUTO_BUF_REG)
> > +               | UBLK_F_AUTO_BUF_REG \
> > +               | UBLK_F_QUIESCE)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -2841,6 +2843,11 @@ static int ublk_ctrl_add_dev(const struct ublksr=
v_ctrl_cmd *header)
> >                 return -EINVAL;
> >         }
> >
> > +       if ((info.flags & UBLK_F_QUIESCE) && !(info.flags & UBLK_F_USER=
_RECOVERY)) {
> > +               pr_warn("UBLK_F_QUIESCE requires UBLK_F_USER_RECOVERY\n=
");
> > +               return -EINVAL;
> > +       }
> > +
> >         /*
> >          * unprivileged device can't be trusted, but RECOVERY and
> >          * RECOVERY_REISSUE still may hang error handling, so can't
> > @@ -3233,6 +3240,117 @@ static void ublk_ctrl_set_size(struct ublk_devi=
ce *ub, const struct ublksrv_ctrl
> >         set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> >         mutex_unlock(&ub->mutex);
> >  }
> > +
> > +struct count_busy {
> > +       const struct ublk_queue *ubq;
> > +       unsigned int nr_busy;
> > +};
> > +
> > +static bool ublk_count_busy_req(struct request *rq, void *data)
> > +{
> > +       struct count_busy *idle =3D data;
> > +
> > +       if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data =3D=
=3D idle->ubq)
> > +               idle->nr_busy +=3D 1;
> > +       return true;
> > +}
> > +
> > +/* uring_cmd is guaranteed to be active if the associated request is i=
dle */
> > +static bool ubq_has_idle_io(const struct ublk_queue *ubq)
> > +{
> > +       struct count_busy data =3D {
> > +               .ubq =3D ubq,
> > +       };
> > +
> > +       blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req=
, &data);
> > +       return data.nr_busy < ubq->q_depth;
> > +}
> > +
> > +/* Wait until each hw queue has at least one idle IO */
> > +static int ublk_wait_for_idle_io(struct ublk_device *ub,
> > +                                unsigned int timeout_ms)
> > +{
> > +       unsigned int elapsed =3D 0;
> > +       int ret;
> > +
> > +       while (elapsed < timeout_ms && !signal_pending(current)) {
> > +               unsigned int queues_cancelable =3D 0;
> > +               int i;
> > +
> > +               for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +                       struct ublk_queue *ubq =3D ublk_get_queue(ub, i=
);
> > +
> > +                       queues_cancelable +=3D !!ubq_has_idle_io(ubq);
> > +               }
> > +
> > +               /*
> > +                * Each queue needs at least one active command for
> > +                * notifying ublk server
> > +                */
> > +               if (queues_cancelable =3D=3D ub->dev_info.nr_hw_queues)
> > +                       break;
> > +
> > +               msleep(UBLK_REQUEUE_DELAY_MS);
> > +               elapsed +=3D UBLK_REQUEUE_DELAY_MS;
> > +       }
> > +
> > +       if (signal_pending(current))
> > +               ret =3D -EINTR;
> > +       else if (elapsed >=3D timeout_ms)
> > +               ret =3D -EBUSY;
> > +       else
> > +               ret =3D 0;
> > +
> > +       return ret;
> > +}
> > +
> > +static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
> > +                                const struct ublksrv_ctrl_cmd *header)
> > +{
> > +       /* zero means wait forever */
> > +       u64 timeout_ms =3D header->data[0];
> > +       struct gendisk *disk;
> > +       int i, ret =3D -ENODEV;
> > +
> > +       if (!(ub->dev_info.flags & UBLK_F_QUIESCE))
> > +               return -EOPNOTSUPP;
> > +
> > +       mutex_lock(&ub->mutex);
> > +       disk =3D ublk_get_disk(ub);
> > +       if (!disk)
> > +               goto unlock;
> > +       if (ub->dev_info.state =3D=3D UBLK_S_DEV_DEAD)
> > +               goto put_disk;
> > +
> > +       ret =3D 0;
> > +       /* already in expected state */
> > +       if (ub->dev_info.state !=3D UBLK_S_DEV_LIVE)
> > +               goto put_disk;
> > +
> > +       /* Mark all queues as canceling */
> > +       blk_mq_quiesce_queue(disk->queue);
> > +       for (i =3D 0; i < ub->dev_info.nr_hw_queues; i++) {
> > +               struct ublk_queue *ubq =3D ublk_get_queue(ub, i);
> > +
> > +               ubq->canceling =3D true;
> > +       }
> > +       blk_mq_unquiesce_queue(disk->queue);
> > +
> > +       if (!timeout_ms)
> > +               timeout_ms =3D UINT_MAX;
> > +       ret =3D ublk_wait_for_idle_io(ub, timeout_ms);
> > +
> > +put_disk:
> > +       ublk_put_disk(disk);
> > +unlock:
> > +       mutex_unlock(&ub->mutex);
> > +
> > +       /* Cancel pending uring_cmd */
> > +       if (!ret)
> > +               ublk_cancel_dev(ub);
> > +       return ret;
> > +}
> > +
> >  /*
> >   * All control commands are sent via /dev/ublk-control, so we have to =
check
> >   * the destination device's permission
> > @@ -3319,6 +3437,7 @@ static int ublk_ctrl_uring_cmd_permission(struct =
ublk_device *ub,
> >         case UBLK_CMD_START_USER_RECOVERY:
> >         case UBLK_CMD_END_USER_RECOVERY:
> >         case UBLK_CMD_UPDATE_SIZE:
> > +       case UBLK_CMD_QUIESCE_DEV:
> >                 mask =3D MAY_READ | MAY_WRITE;
> >                 break;
> >         default:
> > @@ -3414,6 +3533,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cm=
d *cmd,
> >                 ublk_ctrl_set_size(ub, header);
> >                 ret =3D 0;
> >                 break;
> > +       case UBLK_CMD_QUIESCE_DEV:
> > +               ret =3D ublk_ctrl_quiesce_dev(ub, header);
> > +               break;
> >         default:
> >                 ret =3D -EOPNOTSUPP;
> >                 break;
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cm=
d.h
> > index 1c40632cb164..56c7e3fc666f 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -53,6 +53,8 @@
> >         _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
> >  #define UBLK_U_CMD_UPDATE_SIZE         \
> >         _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> > +#define UBLK_U_CMD_QUIESCE_DEV         \
> > +       _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> >
> >  /*
> >   * 64bits are enough now, and it should be easy to extend in case of
> > @@ -253,6 +255,23 @@
> >   */
> >  #define UBLK_F_AUTO_BUF_REG    (1ULL << 11)
> >
> > +/*
> > + * Control command `UBLK_U_CMD_QUIESCE_DEV` is added for quiescing dev=
ice,
> > + * which state can be transitioned to `UBLK_S_DEV_QUIESCED` or
> > + * `UBLK_S_DEV_FAIL_IO` finally, and it needs ublk server cooperation =
for
> > + * handling `UBLK_IO_RES_ABORT` correctly.
> > + *
> > + * Typical use case is for supporting to upgrade ublk server applicati=
on,
> > + * meantime keep ublk block device persistent during the period.
> > + *
> > + * This feature is only available when UBLK_F_USER_RECOVERY is enabled=
.
> > + *
> > + * Note, this command returns -EBUSY in case that all IO commands are =
being
> > + * handled by ublk server and not completed in specified time period w=
hich
> > + * is passed from the control command parameter.
> > + */
> > +#define UBLK_F_QUIESCE         (1ULL << 12)
> > +
> >  /* device state */
> >  #define UBLK_S_DEV_DEAD        0
> >  #define UBLK_S_DEV_LIVE        1
> > --
> > 2.47.0
> >
>
> --
> Ming
>

--
Ming

