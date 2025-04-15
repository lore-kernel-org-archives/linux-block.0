Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F634C96
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704914; cv=fail; b=KMAseOqfQzUMgafbeWYW+TzzxiHdfrsCFJuavyz97oHUoDwkYOgDq9PyXvK5gWMIeuJE3uLzxHWvWGU1sRj9pWrsMkXlW/uBXXgKZjZtVM9aDCfzIavhoWNAAj84uGwm7fqL4b6jMULQH1pex1JUFa/GRrN0ySYxr2qlC+pfNIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704914; c=relaxed/simple;
	bh=PKzfHALAHhlRKNjm3/iLBAb9ElWg3nlw4yV1pAWEmww=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XEPMrAnfzppSYwMRVMtsyxkdQdtFTT9mPhK6qywR/Ky4DlT0P7Uso1ficQZ0uBvBOgOaowIBhe30b85tMHOVicJF4HHbbqfuRoKpFtk56KaRY8j1MBlCVg6G27Rjo+2FGXB2KLYlc7oCLr9c/iOxIkLT+/yFEA7Fo/9gl07UW7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BPIR2UXS; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BPIR2UXS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0YkNS8g1fjlOTRJrzjSz7fQE59Xl22rBLAhL/xq5CwE07sN84pTaQs3pAjUCjyQwEP5iCq6nmSjH0ewDVRgd5IX05STIt5QxqbKFFo7855uLvYg/v9cMF6UvEzT7NfWmkSJr7jSQY1sifcYiQS7EzraSosQc/AZSaFI6etMM0Fn56jLqoliM3a5nyRqV7u8nkDV6tf0FY1KBCBq1IUPdCbw/fsdcjWjQ434g9rhYceryt809pe3trbkQUQhmameXohZbmlyKQud80Vh76/iqzR8aZnJPs94NGVIarByysp3dCECBcaPCPuGeBhxJr698Eixg0okgVjTzqaNInsRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKzfHALAHhlRKNjm3/iLBAb9ElWg3nlw4yV1pAWEmww=;
 b=ls6Fw9gL/g8YIOGxdQibCGfQiPVncZdzme7vuuWQElixE2YB+WiXtidjG7RmIYJj+gRsxulKNTUWGwisWxasJ5rcvhSi9ybXwYolWQAVvd/J65Ttoh+IF5v89+B6mZax2pgUSmtl8BJRlTgi4FtCML7dr4j999FlK9bN4xepriAqDiU2zvX/VQtumQeIYAYHtfflF8GLbHZ0iP5Zj/+XzVO2HwKrOXszykzoLMBnNJVwjf7CnX8tQHNh1IRHvRh0/vcJZkOVCLvQDyER0rbhB2So74T6t5KysKDX9MzwFRDEUe2YavoGfQZLoFWZWQnnjMTtnrdo6dNsms7j0uxVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKzfHALAHhlRKNjm3/iLBAb9ElWg3nlw4yV1pAWEmww=;
 b=BPIR2UXS7Vp5GtX1M5yYwDD5jRLjuhSYH7YLQCHCFfmTQd9jU+E8q6HcWZoWJwZlkqO+iqWqb8GXjcdpgAqL8GiQ/Rldb5Oi3x0EIdnQf9vKZJzCl7l6Dfu1ujoPjClB1+XvIpEnd8UZYjtAoxf4SAjOT+XqZlD1V8xR6Mlg/5RCdvsxV1ehnJ4WTXEA1zzRE0u07V+Ck62hImc1r/SvkhboyZ43A8ooNnoazhNp2VIogtFUi+KPtVJg3q61yRhf97R32b6I8meGu/nso1IxNHsL+Pit3S80vBoBpkp9OtFC2DOg+Wq6ZGNbEBqw4e4ekW0QkUnSxUZIQqjPlW9ruw==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Tue, 15 Apr 2025 08:15:08 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:15:08 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: ublk: Graceful Upgrade of ublk server application
Thread-Topic: ublk: Graceful Upgrade of ublk server application
Thread-Index: AQHbrd5cAekQDakHykq2J5wD805DDA==
Date: Tue, 15 Apr 2025 08:15:08 +0000
Message-ID:
 <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|DS7PR12MB6288:EE_
x-ms-office365-filtering-correlation-id: ba2c6eae-0236-49df-46c9-08dd7bf5a2cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?V6APTxlUckM7el1Vj54rsakH5O7XT+Nr7crJxbdhrnoodRN/k8xPPB7i3k?=
 =?iso-8859-1?Q?AIfjnamD4Hdtc+ICGnwcnXsEvJfIgjbUT6eJdBuJoGYmdHeaH+cmL+usrD?=
 =?iso-8859-1?Q?SKO36TB07eqFl7itCT8nPfEx/USfr4PKZxBKOOXstGICdPJlV85WW2/plM?=
 =?iso-8859-1?Q?OypD8jsFB/6rlh3pNA5kKLOYm/U6uqUBh7HAKcHweis+fa8B/FPN5XqIGX?=
 =?iso-8859-1?Q?Zixi7KBZAWpapi6mt+XcHafCR2gQteV3lTtegNLTE1VkFjCZlaymfpaU+v?=
 =?iso-8859-1?Q?oiaiMzXZubYv/mrIssVve8icHTSyPOzDorEoIEfdqX3LgCmAM5uTLl4yNU?=
 =?iso-8859-1?Q?r3SwEldmwC0NHj556cMNMfgarGNpRTeHabqCuSRBGaLmNznit6ZX8AdhlB?=
 =?iso-8859-1?Q?LoFqR9gld4o0ArQvkkfWU9sctjfLmy3gxzC314BrFJ/pewVzIPSWMQsvPy?=
 =?iso-8859-1?Q?c5E4T802JSxCqBioMfYIlRg6Er9E+2AblXXcuXm+upIy6+EA19dpa2ugvI?=
 =?iso-8859-1?Q?PNsP4pIsF+rwkMuQEFG3iF75jL9mWvmA9ltunlx44m1VYoHyjxbKtbsFLa?=
 =?iso-8859-1?Q?3jvesylJMyJBozOQCrKVM+RnLH84WQmPNGMZUbJdDBKaRiscLslLpyj1UG?=
 =?iso-8859-1?Q?b4fHaf2hxC6XbEif5fJhwj46xMnSppYwaDhYHXcryUQ95g/oqu+mVTGLo9?=
 =?iso-8859-1?Q?9Kw5t2Gv/QsZPrAzobRa07Tnc6mV36JKTzB39aRA3Gj8MwRzqtzATPski2?=
 =?iso-8859-1?Q?rQkQt2tJo/olFet4IXmaD/aEgKA4876MLDJlnKRg+TWSP02XLzVDEKqWPe?=
 =?iso-8859-1?Q?jFx5grg9thNhbO5jLZDOPO0LKEa6JiYEmQ+eZ6uOg3T8Q0/WsQ6Jma/Wko?=
 =?iso-8859-1?Q?DnMOGwwAVWsPwp2oQiyNNcgXaxxSqD1T1KjPfZb2vCzfetLx+UJU7n2FDX?=
 =?iso-8859-1?Q?leog6QGP5+KIHVprWiq/vDmFF2bcmy744hOC7P24aCrr8VWgrlf738LJZH?=
 =?iso-8859-1?Q?m+9h0nJRFDTmb31/4RlSqDbvbKCFQcB4Sn1MjPY2+EDGETTSmh39JeLU1N?=
 =?iso-8859-1?Q?meWc92Gwxs5xcz2K5PAFJkoPtBXSzDcluBiOesG7aSXeuDU/rqRojRJ9eO?=
 =?iso-8859-1?Q?x95q5MvbZZy3NA9b0tKLd4teEuzafn6fiXxUOSnay6//gwIYflxApbk/Gv?=
 =?iso-8859-1?Q?Uo3t/sQk8rr6JpOOWz6lTc5G7eP4tzEMDRp9RwpHfuSrnK+sh7k1n+cL/w?=
 =?iso-8859-1?Q?fK7V7wPi75j36q4hmbHi9OkELMrrZ3ZaNA67PacwI6GMImWKhKHJhvfTCD?=
 =?iso-8859-1?Q?40Eicxkfj11emxddDfoTjWWThANeuZPsaEyie9avCb8CgFrcuLTZbcPMUC?=
 =?iso-8859-1?Q?kaRCoD9LiY6iyoqR7fPHpdEta1+LAL1OQJemjxhbF1WzbW/Ez+CG6UWhU9?=
 =?iso-8859-1?Q?HFWXK+i8vz3Yx8HKovcjYXyTE+nY3x2O9r+4ErK/claOyNMxtjMvBTHFZZ?=
 =?iso-8859-1?Q?c3nCYTqCw6CgpBmZck7beRLhBEkknpQJWwBCQwRLmuxQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?V5PjO5YLlNXJ0yoKNjnBc+2jWpfwnSfF0r2AjDxZ62v5vxBD9zCNjpLiHi?=
 =?iso-8859-1?Q?ffaUZIN8fclg9I+ZBl5MJGHNnMSzqRcD/tzIBaN8eieq/nnz1tnnXdU+MV?=
 =?iso-8859-1?Q?YNmN/SQDtaGtOYjT2JrnC2r6q5MF1kz1kaNMnowsdLGxW3SrVszps+thcL?=
 =?iso-8859-1?Q?KuRUz7iM2BS6xAhGGghDPeZAGtWlHTDJy6fshGwvmD6XnyhLV2ppW5ZkCp?=
 =?iso-8859-1?Q?9q5ucKNvRMbUCiDANmyTP/er2+TA65KTM+TJQu9uiqo2KI3uwrDZK/fEI2?=
 =?iso-8859-1?Q?Yx/zB+FJAAOwwbkVbpOmpd+6Sx0a8mZ6qVuUyTPNf35lcGeDbPnRWFlFxG?=
 =?iso-8859-1?Q?hnxwpbtdaXP4QsQQW4NLYJPAl4/GbNnspc98O9SArfRZGAlVMYnSd3pxVN?=
 =?iso-8859-1?Q?DtbDwwJ+vPCz63Za8fYcOaCN8nYkwEnnA5hik8JrQV9vwwm9Lx6dLBQQAL?=
 =?iso-8859-1?Q?CkxWrQog/bz1bhriLEZSuaQ7SBhBoTmilSWmXg/6BebTNEW/lCypxugsor?=
 =?iso-8859-1?Q?nownBvu+BXAU/keFl/c3/nSF3BE9M6wCdm1Ybqss2DMT5qOwjqToyA4eFB?=
 =?iso-8859-1?Q?l/+WWclq6SOdNDkMTfWAFQjkoVmRA2r0lODVuc/+3pfMQV/deZefFjOLri?=
 =?iso-8859-1?Q?KPEfIQSzWoAB7swS/Rw2GWMonarD5MT+oEEngxNrjdCfQvjF6H/odtyAxe?=
 =?iso-8859-1?Q?qy9D3FnFwchWdijVBqR4YpFgwOn8Ks7rNQU2kDqHw5L0JROJ0i/1ou7VqC?=
 =?iso-8859-1?Q?dG+uRjpo1/MYDXZmXknrLU03s2JS8a4EMdhm9TJvpUIYbB7rBh8cfUeuyu?=
 =?iso-8859-1?Q?GnWH77a4ADABbe8/oXIFKUsEB4T18DGlXwmiAXYLWQpoo9Y7OR2S5VfkBB?=
 =?iso-8859-1?Q?dZNJGUQGXcHuKaV/oo+ujf6M10IUFyGfqv1HoPGrY3mF5tOoORbIr6VEUL?=
 =?iso-8859-1?Q?dLFfJuhbF9PM+GcybbpwlepOPD/yl5mjtQHC7KusVgGauUtil8cqV9S1Kc?=
 =?iso-8859-1?Q?tvsU7Ix4kUH2cXW8Agxgu6Z2rpdNTx63YWoCfBR7KZCbZlU6iz8ggR+tLV?=
 =?iso-8859-1?Q?R8VgthDtYa4vhnAUqLAXuhVaTnEGPfIHjM7S6J1Ok3in3Xsyt/OgnNzAmM?=
 =?iso-8859-1?Q?ifv5VtJ6zwrilTaD6vlClFiTkXLoas723bRxcKpD700BbPJoGSXmsjNdWJ?=
 =?iso-8859-1?Q?Eang4/6wiSbrRHAuCBoIapidMuUG3FfsYN6zm0QjVkEpyQQgS9ssqF0sE8?=
 =?iso-8859-1?Q?WrFjaZy/pAHXB7MFh95AprLkq6WjnrpqH/QCFH9BdCMWIMTaPVcfeBB1E6?=
 =?iso-8859-1?Q?p5GAIIemvMolKIJK51m4WCj7sAyseYR0rWJEF9ZRcexR4+uIRRmRqe4t3T?=
 =?iso-8859-1?Q?pl6jfxE1gLEMHdUsk9rN3ZY5oYRdwDDeXbiVoI4ZVmes+T9oKI57IW+BsW?=
 =?iso-8859-1?Q?wB7LOD4+BKjY4rj4k3FHVYzLnOP+gY0qQs6UKz0/NjsuGKPCIIdDa7nAZp?=
 =?iso-8859-1?Q?tRgItgTLmHek9/W4SOmhlEQnQ1bDU+0MsnNT/Q5mwUUYxBVxECJOBTVJ/c?=
 =?iso-8859-1?Q?NztaPb5Oq6QnnvgCQLYPANbAD9OaEjwyR648DarSsb8BXf0YVJru2umvyq?=
 =?iso-8859-1?Q?N7f1DZyJnaJ9g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2c6eae-0236-49df-46c9-08dd7bf5a2cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 08:15:08.4785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyXCUiPmW4Dg3/xyCB8FW6bvQQK4282nFWC0BsdolA0FF9Z23QKIoS1OCgyhUlE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

I am seeking advice on whether it is possible to upgrade the ublksrv versio=
n without terminating the daemon abruptly. Specifically, I would like the d=
aemon to exit gracefully, ensuring all necessary cleanups are performed.=0A=
In my current implementation, I attempted to cancel all ublk uring SQEs (sp=
ecifically the COMMIT_AND_FETCH_REQ/FETCH_REQ operations) using the followi=
ng approach:=0A=
io_uring_prep_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);io_uring_pre=
p_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);=0A=
However, this method does not seem to be effective. In my scenario, I have =
a single io_uring instance that serves multiple devices and other producers=
, so simply stopping the polling of CQEs is not a viable solution due to po=
tential race conditions.=0A=
Could you please provide any suggestions or guidance on how to achieve a gr=
aceful upgrade of the ublksrv version without causing disruptions?=0A=
 =0A=
Thank you=
