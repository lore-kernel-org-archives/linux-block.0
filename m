Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA312405E3
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746417; cv=fail; b=d2sx6mIursPfPj9egae5xfKvjKFVQU88SE+JXL8U25wrBqTP8RtfZ0ov7waME0RSHLeIvHh2/7q7/ti6EmWP/XmqCGQB2TqoZkAN1KzNh19SQVB9VteaMTrpCbLr9LHKm0MX6SXkusxUrTNhPmo/m1Tgbd1MyNv2gQp1LuSqo5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746417; c=relaxed/simple;
	bh=+EKU6EC3VkmOMMg404z5tVYivf+h4J1dlnprRRtV+pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p6YyI5sLjPSqW+F/JzopZpPOK+LTote+NpfNiP4tM+oJO11qOdd2t0Pgv8eOepOwMDTEN0JB7Gam9ereM34ieff0xylZmG/CVQ/xZ8TR5I1LB2cxa+5vofG6jT+Srgvu+2Sf1Aj3w8UowqN2f8jOGGhdUlAMJnkNMhANhu5vi0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlCWljJJ; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlCWljJJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXzML1EK2c1XFaLqKIyoVeiL/C8376OPSiItWzEnuB1xqRmdsHEM0U69RVASK9mf6ID9TZq4yKKBxX5DhO01Jv7v9MswopZPfkfl5W5F2hzqxdxIFgXh8plCSLwnOB2r621JHICSO3NxpztyeSJbosBp8EKVRs6bcHUr9+owCeWMQ5/X1NWy0zmRO2tBvVoEMYz1kkcDRKxIegAfBgR5QcUAlF1MN12LVrRrm0rxHkyex7uClBcfZ9tkS+b79NbiKLFVbiNrONCPaZ1m2LEegmrLp0JOq4KkXt0pimPAdJaGWEkYvF8IEMKh5z6TXpAn9iXjhUH1vubOP2ROvPiK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EKU6EC3VkmOMMg404z5tVYivf+h4J1dlnprRRtV+pU=;
 b=vNxs26jbfZ3dD3A5TRdLl/VNgDGqjUob2VrGyTWtQ/IZHR5K8Up3xE/hb3G4J2/Iv05pWNTjAncDJ30B3CrjTNKrp/6BhKjFZViP7ezrCNRGGXLaN19Cz+JMCJc0NgOOXKuwKRmvbGWrAxpbnZP/nGLHv8t9H6ukNB18/M638B71SeW1FaCiYOBUEd6UghM1nz+6Yb6OlUN572fJCNIWXZJ78N1xoh1jayC6rLqkZ8ieQ6VphrWNexjS1ezFrTtgeVJ+Ub9GZRbJy9e8R5BFsKR6qTp7LCosdPve9XAoOTEFpQrosEzn5RiYQwTGk3K7pA0mLjF4WJ06QM9wfBjmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EKU6EC3VkmOMMg404z5tVYivf+h4J1dlnprRRtV+pU=;
 b=rlCWljJJ169xcUGdmbpLkYNiPtHXAFbofuOzbyeXPisnAdigVU8cU/fjkRYwEOp8xtStWL4VgklyozzWCwsTpJYiKdZoUJQoo3wy4TZ8oTnuXyhSlyl3uofJf5QvFO+1yb/NqmrHGRUeG/IhuiLU4hwVW6X97ivfKdNtBejMVZ9B3zFsi2SZ9BQBi9o3i/nQinbykBAXrivqdiEXJA0S1S4lKrDQEcLSmLXrq1Ki4FbfwTdKpAm/jpz/Q3DsRlJFMKlfifS2aF1EDNaNaVWMo+pVfH1qBKGvS70PzC4e1VUmFjTBFR7fBCKkJRRh+OowbqQ6e6qY1BMG2rjBk0CI9Q==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 19:46:51 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 19:46:51 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Thread-Topic: ublk: Graceful Upgrade of ublk server application
Thread-Index: AQHbrd5cAekQDakHykq2J5wD805DDLOkkQSAgACQ35s=
Date: Tue, 15 Apr 2025 19:46:51 +0000
Message-ID:
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
References:
 <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
In-Reply-To: <Z_49m8awtNFsY8pl@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|SA3PR12MB7880:EE_
x-ms-office365-filtering-correlation-id: cb750b00-2557-4d40-f695-08dd7c564496
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FJECL3xgtqOzWGjB/MXNAemkixmV3NwJOmW227kS2ab107WmQTsza7kpRHk0?=
 =?us-ascii?Q?Y1V42OOn/6aV2bTKdc+225J9uPdUsUfrlzFQRj5Nnvlgw+5+/UysfBIYNz4i?=
 =?us-ascii?Q?Iq6oDVIYQebCZm7rKlCJXqUk7oE9WqFsifcedxZ70Ex97nBXUxvgb9XXhHut?=
 =?us-ascii?Q?CpSy6M9xw26z/Voz6SSQEL5M+QEVGZq4Y+eCuItYSAFLQkvZe9Op31FF9Sd1?=
 =?us-ascii?Q?WRWKv76uyBVcI7/yLZJpefXHtWj4JdqTSAFxdPy0BHV1T2s0SjdXeVF0tB9K?=
 =?us-ascii?Q?7EEf8R6j00fAUexrhKCUtsJN8Rem9oMGg8RdXDVtsb6AdFXzHsF5koOHtV86?=
 =?us-ascii?Q?vghRnVxxLA2TCX01SN6GiqL+a+p8qef0TgyuKgMCGQUgwXnhhfapUPURv5+0?=
 =?us-ascii?Q?KAtT8lb8NGG8DoL01mk94We06TyBJq2cD9vxSmNSyUURK500sPucUS0ub2Qc?=
 =?us-ascii?Q?SfXTTpKU/28wKMCEvHCY0kWHwxzh4WFmcbO/XxIQ9ZMOItlkNL9oCF9laOYu?=
 =?us-ascii?Q?369QsAb19F/FPiMsKTjLmIu4QKIgsPXomfGTn+gTkFjGebFEM3MRAq9BozTS?=
 =?us-ascii?Q?qfFarpXeMCnGCR0jqZy6pm3uxUMA+cuOyqJ/rxRns4eQ+y+7P7tt5KZvikNu?=
 =?us-ascii?Q?sj2kfK2gHX9FR7v3W26NN6tb1HipEKv8c+feH1Qh/EGFC0xOWZQDeCbRH+Gv?=
 =?us-ascii?Q?UnRS3p0/7duulVhxh9FO9r3JomvGabWnI0YITHKy2kKIqdJLr+P2Zg5vRrsQ?=
 =?us-ascii?Q?lAeKFUpRM7wmReiVmEYRgJkpBn3l2HZ6CXM2yOUCNNsxLOCwu8e7QsCjudgN?=
 =?us-ascii?Q?H1aBoi/zATyx/3cRHrshXfz3HBa1oNdlqjjr0Cn4HVc7TgWZvjf77Pe3YNjZ?=
 =?us-ascii?Q?/c7oI++R/mkRMSUDPx+d5N3+uwZv0H41A00MWccqwKhn9HtePoZBhVRfBan/?=
 =?us-ascii?Q?R30eeAstrFC0unYyIu9OF2BzYFKh0Gv/fCcgeUSdmLHEsfFYVERzV58qP8VT?=
 =?us-ascii?Q?c6nn9z5p8xgWmBd0WO5KzmDxbH3xVgPpSqXXaRkJGJiPkzitCgg8Vsw7jND1?=
 =?us-ascii?Q?mS993PySfkx6MwcxlRsnFLR0TqBP0iycHhZbyllN/ABxeLzPj9AqY4Oz4Q+Y?=
 =?us-ascii?Q?2cIpvW0mIcAP0M7Q8GaAZ67CoP5J9fvnSrDk5WSJnts6iklFbuyrhwNazO3+?=
 =?us-ascii?Q?mtRT+azWOmpeqogYA/q4h8r5zxYbsoK3937B+tBRo/Eq9UxCm1F9jyFGoUTE?=
 =?us-ascii?Q?nNtfbGaQtRbgYkpuBD+mJkPtEYjRV0DloeiMVJkqtVJSoWGGiBVBaa1J89Js?=
 =?us-ascii?Q?UXTD7Rg5Du2+RfTIROz3lFpVLu3QqvBeOmu9GFvVWYqjTfQ4PcT9AWiNUul9?=
 =?us-ascii?Q?PgDzrZOavaE8q4zGvDPmBP0z1qLTzip+tKvVPBUixtc7el1W+bmTqsmvQw7i?=
 =?us-ascii?Q?87f0PTgoeWBA0lRiVPDrTPK1SuOD8HuYFz7jPPJRsIXulZC5cY4tbw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TWB7sgd2KbjIgEgoZkRCfGspENAlsuZ48Bk1ElG8DSHVH43J1oDnorhYzboY?=
 =?us-ascii?Q?CG7Eh7jMU8HGbuFeAKsOHMIAUWKPdySjVz9FaAD8E6apGUBjHUiO6N9cB7DB?=
 =?us-ascii?Q?sEM9q8XoKuV7jvPJXkDy/L4ws/Or7QsSdteqFMryA65IR2UX1Pg5M86spKBJ?=
 =?us-ascii?Q?lT9bOYyLroKIGk1mrOOrC+mDO1LS45KvjwKE6mKY37+XeYNQo5VIG8b6hYMU?=
 =?us-ascii?Q?CD3eS96L4k96dRSJc8qC7Vd+ZFe8MN04YLipJw1JplVJ2bSJTi9yiRHQIVhu?=
 =?us-ascii?Q?pTOkC/I5OIW3rpfBrClI/LOa8Z0LGe1nuBu3G7TAdg0SN1Go4XJZtRcl3To6?=
 =?us-ascii?Q?NA3Nt+rGu8VeKzVpFwzrRiad//tXHCItwwpvbC+NwkurHFXFXfi6ISZrWyWC?=
 =?us-ascii?Q?Ke3+1iT7gcYlQGhFo404dcQIrqExM+Tx8uDYz6eQqg6KDTf4kyoxoWMeP7V6?=
 =?us-ascii?Q?jVuTuUs/jmZwVtUXCjB6pz9D1pnUYLE7S+vvuSHCBmZXJo+nJ68fHQc4vcuk?=
 =?us-ascii?Q?CR+FSXSuMJVmjFXpGynYbQu5tTxHEuULgTktt4S8U/7CsoDwARRz7S2/mDps?=
 =?us-ascii?Q?mdxGXVIc7m5B4URs2Tb8YYQ4OedY+PbQS7xP59cC0Y5/tDes5ysFWk4Vdi39?=
 =?us-ascii?Q?+vfcvrGEnBF0z9zxPebxz4hyICrU7vNNYa9GhkD/x3RB5rh1JI2eVEyPOU1x?=
 =?us-ascii?Q?49x48mmEJP8AhYM8HGYQuaYdY8AK+wb7qKORMU/2KuNJBghuR1w8hsC6Vrwb?=
 =?us-ascii?Q?g0ycbpylveqBNIEDE9dN54G90DZzbaRRBpLxnn1f7Jc/KVW5PAjmdwFnz9cX?=
 =?us-ascii?Q?uVRqRvJrjNI/bN3IIOsMY3IXNyJCN4SxFtd3DJZyvMV6KU7gwT3SmGK4/4P9?=
 =?us-ascii?Q?Dn+fNMqacTEY54WrRILQ/VWHCvhcrUOZOFdGz2dzvgdBlsuchtZzdnv2IZjV?=
 =?us-ascii?Q?fOCUoUUHT7VImm0bXz90/YLL/jhiA5nWIRUQIwn2XhwpLg2OIvuujRDbM391?=
 =?us-ascii?Q?h0Mf/Jj1WBW3LGDysTcLD1alceRle+9t5rxqvYcuiWu+10hmOEjAVk3VbwBV?=
 =?us-ascii?Q?vyVOnnlWryWWRnHYx+6GDSGkzYwxkFumeHnPJDfUCTaIa3qCLYquuhgOZkDl?=
 =?us-ascii?Q?NtigsRi3fLWkMH5WCuUFzkQCRN3DR1giTbfwMjMSQctnH5hSEkG43eKFf6MU?=
 =?us-ascii?Q?nvO155TU5jFJN+jyP+DSSGDLwCsuQyu0uG01EDpRoyFdFuk9TT2gUFWclZjA?=
 =?us-ascii?Q?cYDJwSBc29PBx6JHbjhOV/aeEN7QsiRtp6L2vouK+ihBziQxwdIUk/u8G+LP?=
 =?us-ascii?Q?s7gX74RMeHFqvHpDXpYy/VPGdWAMpU42lR56hyYPY6o0WmRmRtyk067/Fpz5?=
 =?us-ascii?Q?ODTu7eaMo4RxbfP+k0V+eAzAVWz1LI/m64eDFkAkL6VTqH7y+mi7J2ZnYXVA?=
 =?us-ascii?Q?8mpuCWlYIld4PzvnD+j8obcDWBX0D6oxFivDuoxdiKn1dcmog2OnSmmQrHkj?=
 =?us-ascii?Q?7AJ6droEMEhUlSaVqTJTmoL7+vS3If8oGf0f0NTSADdK7FhHLFw+yJExbxO8?=
 =?us-ascii?Q?E5kDTSkJbfLRKvgs458=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb750b00-2557-4d40-f695-08dd7c564496
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 19:46:51.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKvZzA6/0w0mKOsnK5YssSx3dmzvIGi00KBtlxLyL/QcMBsD3A9uKh9rFWMQAwRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

Hi Ming,

Thank you for the fast reply.
To be clear, I don't want calling DELETE_DEV or STOP_DEV as I want the kern=
el bdev will be stay while upgrading the ublk server application.
It would be nice to have a nice way to have something like FREEZE_DEV that =
we may use which will also make all the cmds back with ABORT result but bot=
h block and char device will be stay until a new userspace application will=
 reconnect.

Thank you

________________________________________
From: Ming Lei <ming.lei@redhat.com>
Sent: Tuesday, April 15, 2025 2:06 PM
To: Yoav Cohen
Cc: linux-block@vger.kernel.org; axboe@kernel.dk
Subject: Re: ublk: Graceful Upgrade of ublk server application

External email: Use caution opening links or attachments


On Tue, Apr 15, 2025 at 08:15:08AM +0000, Yoav Cohen wrote:
> I am seeking advice on whether it is possible to upgrade the ublksrv vers=
ion without terminating the daemon abruptly. Specifically, I would like the=
 daemon to exit gracefully, ensuring all necessary cleanups are performed.
> In my current implementation, I attempted to cancel all ublk uring SQEs (=
specifically the COMMIT_AND_FETCH_REQ/FETCH_REQ operations) using the follo=
wing approach:
> io_uring_prep_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);io_uring_p=
rep_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);

That shouldn't work because COMMIT_AND_FETCH_REQ/FETCH_REQ has been
issued to ublk driver already.

> However, this method does not seem to be effective. In my scenario, I hav=
e a single io_uring instance that serves multiple devices and other produce=
rs, so simply stopping the polling of CQEs is not a viable solution due to =
potential race conditions.
> Could you please provide any suggestions or guidance on how to achieve a =
graceful upgrade of the ublksrv version without causing disruptions?
>

You can delete all ublk devices handled by this single io_ring instance
first by sending UBLK_CMD_DEL_DEV, then exit ublk server loop if there
isn't any pending uring_cmd & target IO. And the ublk server need to stop
to issue COMMIT_AND_FETCH_REQ after getting uring_cmd with UBLK_IO_RES_ABOR=
T.

I guess you want to send the control command in single pthread too?

If yes, it still can work with coroutine or modern language's .async/await.

This feature is actually in my todo list for libublk-rs, just not started
because of not seeing real requirement.


Thanks,
Ming

