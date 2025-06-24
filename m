Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E21246BD5;
	Tue, 24 Jun 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791711; cv=fail; b=fEg6pIQ3OHPdaoxqbMrylMIdNM89DNf6YhhWr70wiFhUvuqG8HDt+RcnOpeMnlq87tRHpdNf38h9yMLHRno+BeRhcsV6pzYpKnuMxo0onsC/Fy/xhqo/p8O3kZLINgFsO/MK89dUZft8QfeNkxz2I+MRJr0Albu40PXLeXJtRog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791711; c=relaxed/simple;
	bh=xAUAAT/DZdHcPU/YIGA7z5s9vnssucl6YTWI38UUrIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRlzlHcjIgfHuZeAxXlSE9zb8K61N+cgO8WzAZKM+XHPUd7kOViR0QvB90EVJh79UFVRGVis2tW890+PbYVWgy4Uhz/mEj+vUC7tPQyRMHSUKMH4kBP8a5PoV8gyF67S4B5QSAbKfrQYlEGam9DsTTuh2HypC8xi/OOQJTxsX9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UV5hvqIU; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UV5hvqIU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ9JL/Ab3cqiC8rbPXMHWP8OCk6cYTeSd5XjkHnb5GmigTK73nqr9nWytpgxuDQQrPKzojfVBI4bt5VlZHr+EUIBceK1JXkMfdScyDI1wluvaCZ0kpXs1d+pmFlrQscc8es7XNePzZz4Wqzo8rHGjB0w1joOHad8o84ovg5EZlKD4xhFQ9ky9myfPKnkN8P8IZfuPwhmNzMbLT0rwH7yKfYEYbNKTmHOdCF80KyHHXQxJ2VnxjBPensXFfOmmqjFdaHw0Yvobqj0naomc7IQqv4SBXfTNFKa3IMwK76nInKEFiXnb2VM38/wjKaKf/Rt2+x1pknM/CkyJpVk07gI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu8SZU960FziggDV3gxdW/mc52o6O/p2cg0DMdAUsWE=;
 b=Pemv6y1rXWgonHMuZKN3QxP3+/s7koIECBn6xN/nuNocXoxaAWw1ZhEEUbb9mrZxMs7ioNJigDC7j0Q1Vvzp61GfLIWbM11CI8QbK62b6ik6/9iP1k/tyRkuodehMcberqIIZ7Lv/VqyEGda8/80K1t9hv/loDFPfuncRLzUM/jJzNXlzWW7eQx/eZCfeysRvXkA2qra3RhuuXXU1XMH+s9dDkiewJU/pRob/5ryjZA9qAoyJhniVxIZD3VE2z2LO6uRlCfBpQOR4Jgrt0r3j9MX0S3qRSUn4p2krYDl4uaqGFLBgdlOlaf4i9Fj1sXtwvPdLKvqi50sqlOro7auqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu8SZU960FziggDV3gxdW/mc52o6O/p2cg0DMdAUsWE=;
 b=UV5hvqIUxmrpAHAzrZMwT3HJ6JWAlG0U6qyOJIhEJw4lW4of817matuOSSHxKFzLr4uzQy57kaOb25RDggLKMekN1aFF00pBipOVnRTDUQcneMZxevQBoPfX8nrOWuakuD7bAsdWCfti+IGOFHko3wW79KOlwHkT299JpK4QeHOXpBP9rmTMy0o+BDxU6IOkCfg0Fo8QwuVxP7WXoy6f9sCW7byEaG2H3Hw8j1NStIAnw8hhu80QBTkHwENjghyt7NerkajE4o1jtiOFdqSOLbtRVdzU7TQYNi/Zjwu2FuO29FLStIJG/pdsrabdsFDMQbmv2/qfCyLTi1zZnHCotw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 24 Jun
 2025 19:01:44 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 19:01:44 +0000
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li Rongqing
 (EXTERNAL)" <lirongqing@baidu.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel
 Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqA=
Date: Tue, 24 Jun 2025 19:01:44 +0000
Message-ID:
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
In-Reply-To: <20250624185622.GB5519@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB8201:EE_
x-ms-office365-filtering-correlation-id: eb95ea20-c982-4113-02a5-08ddb3518fdf
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?habpxwZ+bwcF1g7rquQIdqORp5KeI6bKXzWilK+fUbiLVAlj+SWPHxLmeati?=
 =?us-ascii?Q?dvKCJdhqiJ+Ikbc9u7F1NHVg9sk/rxXDJunm73ou++kq4DLz0tTPvTsdTsu5?=
 =?us-ascii?Q?0YWRS1GvIhd9I8QabnUsNT7fR7BRwI4T+GlOD8EotjZNp46+2xNizTE8KPSz?=
 =?us-ascii?Q?BYG5Yq39SghgalNhiHAMGqHfPyHacl3BzRJqL9g0TS1djb0hPAetCDcbHMaV?=
 =?us-ascii?Q?TouKmDhsI22HOOgI78aZXr1jSx7WC9Hmw1TiKUHMXNSQTD6F+AbImUGasdCT?=
 =?us-ascii?Q?6YYztLUj0OwP7PK9k+tujwTv0tJxc9OLwnl4z1N246t3wXSGzVgNhSIwFk+m?=
 =?us-ascii?Q?1h+Sy6PbXQMBfF48xhsl1JZIxVJqefmZE6Xk4AGlkaja3f+KcTtBTVlKgBI9?=
 =?us-ascii?Q?bG7ZXj6eC4vk7YzTcnxCjq1qETMbfwBnbceMtVDozAMHuFUma67rsJautHVK?=
 =?us-ascii?Q?nmLb4Pu8R4Yhnbh44RFo+pOTjNIA7rdqBr8Cwh0VxU8kqVlIIyDoxJbc3BA9?=
 =?us-ascii?Q?hnhh8G1GR5/75w3vlUgFbwnTBgzss7Ik0mo9Sb0x7SEQIO6bG+5hAzi2J+ao?=
 =?us-ascii?Q?Ib0nrvaR94154XRTk2rzItc9pEuREPjI0e9pcPo3Dr3ruirgDcXApy9J1trE?=
 =?us-ascii?Q?+jKLvWD5sTy47e84bKM4YN2F8T8AG0d73G0VTVXxBiDP9vfR5WlV1nz46bBY?=
 =?us-ascii?Q?rqxkKigYkkNAGUM8AP8qVTVjOtTrJug70S2T1u+uml6wiVr+YA/1xpDm5zeD?=
 =?us-ascii?Q?RmVwoPgpbC9Plxl0ZV2I1ofL8lb23btJojwqadmE4qTale1+KpvLGDkVNX7+?=
 =?us-ascii?Q?OSqshfFeJ58ZQic6H1z0RgsEbEwYYSDEDvqSC7YNNfCHgRLT9U0hpUWKWWhQ?=
 =?us-ascii?Q?gVDozEDZRTAggAC7fwKyRrWsg+QEfQzo4djkVFEDaWAR+H6uHXNuXUODkUS3?=
 =?us-ascii?Q?0Jb1r3SJ2rVuTepAbpkMA34yS54WClBLNU/WwPhzg6cmNpxe10TCkxE8i9Ju?=
 =?us-ascii?Q?25cbdA6KM667Flsu5MKfos86DHiwECPGLZPVxWp+nBnvSrfwFEd+GtGbm8m2?=
 =?us-ascii?Q?gauaucRpqakbXCogMsZIcqvUsaxMd5KHL7M1G5KKQw6C4UsF1/aBzaki0Z5a?=
 =?us-ascii?Q?hjwF2whJL9+g2KKlIbjEQjDHO0nKHUXuLWCpUv9mqzhkOTaN7id56xiHMJqX?=
 =?us-ascii?Q?VZu/sPIUX6ipmy9SbDVcZwBj7vUZmwfa5bXB0XXFXtb4FLYAVf/5O7pxX+Wz?=
 =?us-ascii?Q?Dbvn08a1qUbGmLp9vAvYshqlUKrBWNnOHzdo0jS11tsVyrc4OMU3XIb4AYYL?=
 =?us-ascii?Q?WAaUkISabHSiy/nUz0oL4TW61+NmyJHj+XTVFwEj4nh50E3FBdID1th5YTzb?=
 =?us-ascii?Q?KM/pt+WgIdUwRV6yNefBAPfD2tLUwA2+7HNW/5EJzuOrpMOCd+RQG2onY7qD?=
 =?us-ascii?Q?bF3au3PocPvFjnEtl+8F016/aB8//BPiQ5ZxUIXFGWQspvONjqO++mD2Vk7X?=
 =?us-ascii?Q?0He+zNHbetz3zVg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jNDIGsjurevMePNYE0yz5hYAvLU1SXc8cS+JzEhWA3py513C8PGlhdsAlQEI?=
 =?us-ascii?Q?zYnE2d8OfQyWD8WalVUEmHLPyjPquwMPpBebVDSThvrCgV1L1TxitjGWgViI?=
 =?us-ascii?Q?RVIhLKK6kpEHbJHGKG9vEB9jYVw080HrpPZy59brEoQysuy3YpHOpxVK4Vgz?=
 =?us-ascii?Q?BQdGXvkMokLhsJwgKa80HCtNTadI5/fMJNLKjzMiIegFaCyLqS74b+eJT+W/?=
 =?us-ascii?Q?mkdKycS3qp+QGyUyK/QuCPBmuZzIuzR4DOmePVPF4Vha+P7Xtll79VDBnyMu?=
 =?us-ascii?Q?H9tlf6tV67/Jbu2y8hEl6gC3BbVC2AuVeUlLkFNzPLFSDB4KoPkQI89Aetye?=
 =?us-ascii?Q?lbK8xtJT71Hs1u119MpvzMmMzdreVb6ByWzwnAptbEn340rsROkbVnPad0aV?=
 =?us-ascii?Q?YgXXqdImXzyNhcb+Fd4Ndm3d/YX6Gkq5PCi5xru9xB7BnIi+DTmObsFlqw/6?=
 =?us-ascii?Q?FP7uYHPXW6vRCORA97w0DFLvnvowYejvb/ZOOPXpMMDS/KEJyNyXtjK4/a5C?=
 =?us-ascii?Q?eT+rwflP0wGWvQbjaGqO2Rpq7gtLZU3Nh48pmzdfbG0/YpHTVXhJYaQUPnk+?=
 =?us-ascii?Q?GGmismYQAekHfZBQQBzSDlZQpXt60F9oG2N3sf0nfddsopCvu7WkuL88DAC2?=
 =?us-ascii?Q?tdvnGNvCCkZQvPXckYwSO/UDxvY+Qj0cCUroXJ8dJrTpfe5asWdnSCT+7j2q?=
 =?us-ascii?Q?lgEK/GfaGqXtAW7rR1pvH10uNpDPBdxCvGRuRs6GRUZMqRzL4rsxQbvH/AWd?=
 =?us-ascii?Q?HP8AERMUvDRLpVsTr+bwQ0GCZj9aaHM8biAz0rg41bForwk2IpRqUgbozjfO?=
 =?us-ascii?Q?kLpLuw0JjK1agK0tvAYWKbfy6Ci+gKexoGhKBff3Nm/zLVfh8T5UefWjJzK/?=
 =?us-ascii?Q?kjWPuJdyLzZwsAAEz6DueqMbQaBNxuRp8TNS/T6I+BQuORnVRyWQR5V2+iA3?=
 =?us-ascii?Q?QH4XvemiTfHIk6/mz1hLKpOvdWfd39jkRRAHpWwv0ehO04hrm3jb/BMp6i/T?=
 =?us-ascii?Q?JInndnWLzkCAIIwUqTMnNy3yzmAUhqco9ZoovzWrls0ldjbelqb0ALceaC5T?=
 =?us-ascii?Q?SrrCG4KACGj9cYEuQ4J0Snah7OuIOKgOZcC5Q6+ZPAItwgtSkUC4416OXB97?=
 =?us-ascii?Q?Gucf9SvKxuzpiI0oXWfKeBQ5GzSOPGwW9PPRQ20PYUq3tsn8rzndDWmD+bPs?=
 =?us-ascii?Q?V4B4927E0DgLnyZpAmbbA4gyjTmBeUKTDVDSdb7kEXjUDf6p8ADKoo3BSXnF?=
 =?us-ascii?Q?/Ko238shJyDd1W90+pXLrUVVfRsmyjl2ADaIMJiBHrnBt5806dHUfUIJFhJw?=
 =?us-ascii?Q?dsINrdWfs/WDzlLbW8FHUlSrs47nimVbrgYQx6lfhmaobpr9TX0eJclR7c4f?=
 =?us-ascii?Q?GpJWKpTtMV5sQ/7+sWW7A3W2QyHWsvSG1LVyRMwSLhNmgO9eZhjoVAbfQAzm?=
 =?us-ascii?Q?kwL521hz3B8ND/G8+rIwVmYEV7oC9KMOSgDTENR1QxDHZw4UvF9xx6k4bKzD?=
 =?us-ascii?Q?l3bklibToCjKM3nr2o1lBXLw29aQzf/s0EWt0URlxHHB3UQNi6eO5Lu1WcZq?=
 =?us-ascii?Q?2e6QBuYsh0RBrhtrhY8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb95ea20-c982-4113-02a5-08ddb3518fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 19:01:44.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7stP8JydhODC7q3JxekdL9Cg+7+D9F9I0EnkC40ZQpOUtUh/r6oxuCdDAbSXjQ9f4uawMm1PyjqlKWodFwkQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201



> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 25 June 2025 12:26 AM
>=20
> On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete the
> > device as the VQ is marked as broken. Due to this, the disk deletion
> > hangs.
>=20
> There are loops in the core virtio driver code that expect device registe=
r reads
> to eventually return 0:
> drivers/virtio/virtio_pci_modern.c:vp_reset()
> drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
>=20
> Is there a hang if these loops are hit when a device has been surprise
> removed? I'm trying to understand whether surprise removal is fully
> supported or whether this patch is one step in that direction.
>
In one of the previous replies I answered to Michael, but don't have the li=
nk handy.
It is not fully supported by this patch. It will hang.

This patch restores driver back to the same state what it was before the fi=
xes tag patch.
The virtio stack level work is needed to support surprise removal, includin=
g the reset flow you rightly pointed.
=20
> Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
Thanks.

> >
> > Fix it by aborting the requests when the VQ is broken.
> >
> > With this fix now fio completes swiftly.
> > An alternative of IO timeout has been considered, however when the
> > driver knows about unresponsive block device, swiftly clearing them
> > enables users and upper layers to react quickly.
> >
> > Verified with multiple device unplug iterations with pending requests
> > in virtio used ring and some pending with the device.
> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: Li RongQing <lirongqing@baidu.com>
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > ---
> > v4->v5:
> > - fixed comment style where comment to start with one empty line at
> > start
> > - Addressed comments from Alok
> > - fixed typo in broken vq check
> > v3->v4:
> > - Addressed comments from Michael
> > - renamed virtblk_request_cancel() to
> >   virtblk_complete_request_with_ioerr()
> > - Added comments for virtblk_complete_request_with_ioerr()
> > - Renamed virtblk_broken_device_cleanup() to
> >   virtblk_cleanup_broken_device()
> > - Added comments for virtblk_cleanup_broken_device()
> > - Moved the broken vq check in virtblk_remove()
> > - Fixed comment style to have first empty line
> > - replaced freezed to frozen
> > - Fixed comments rephrased
> >
> > v2->v3:
> > - Addressed comments from Michael
> > - updated comment for synchronizing with callbacks
> >
> > v1->v2:
> > - Addressed comments from Stephan
> > - fixed spelling to 'waiting'
> > - Addressed comments from Michael
> > - Dropped checking broken vq from queue_rq() and queue_rqs()
> >   because it is checked in lower layer routines in virtio core
> >
> > v0->v1:
> > - Fixed comments from Stefan to rename a cleanup function
> > - Improved logic for handling any outstanding requests
> >   in bio layer
> > - improved cancel callback to sync with ongoing done()
> > ---
> >  drivers/block/virtio_blk.c | 95
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..c5e383c0ac48 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1554,6 +1554,98 @@ static int virtblk_probe(struct virtio_device
> *vdev)
> >  	return err;
> >  }
> >
> > +/*
> > + * If the vq is broken, device will not complete requests.
> > + * So we do it for the device.
> > + */
> > +static bool virtblk_complete_request_with_ioerr(struct request *rq,
> > +void *data) {
> > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > +	struct virtio_blk *vblk =3D data;
> > +	struct virtio_blk_vq *vq;
> > +	unsigned long flags;
> > +
> > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +
> > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> > +	return true;
> > +}
> > +
> > +/*
> > + * If the device is broken, it will not use any buffers and waiting
> > + * for that to happen is pointless. We'll do the cleanup in the
> > +driver,
> > + * completing all requests for the device.
> > + */
> > +static void virtblk_cleanup_broken_device(struct virtio_blk *vblk) {
> > +	struct request_queue *q =3D vblk->disk->queue;
> > +
> > +	/*
> > +	 * Start freezing the queue, so that new requests keeps waiting at th=
e
> > +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> because
> > +	 * frozen queue is an empty queue and there are pending requests, so
> > +	 * only start freezing it.
> > +	 */
> > +	blk_freeze_queue_start(q);
> > +
> > +	/*
> > +	 * When quiescing completes, all ongoing dispatches have completed
> > +	 * and no new dispatch will happen towards the driver.
> > +	 */
> > +	blk_mq_quiesce_queue(q);
> > +
> > +	/*
> > +	 * Synchronize with any ongoing VQ callbacks that may have started
> > +	 * before the VQs were marked as broken. Any outstanding requests
> > +	 * will be completed by virtblk_complete_request_with_ioerr().
> > +	 */
> > +	virtio_synchronize_cbs(vblk->vdev);
> > +
> > +	/*
> > +	 * At this point, no new requests can enter the queue_rq() and
> > +	 * completion routine will not complete any new requests either for
> the
> > +	 * broken vq. Hence, it is safe to cancel all requests which are
> > +	 * started.
> > +	 */
> > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > +				virtblk_complete_request_with_ioerr, vblk);
> > +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> > +
> > +	/*
> > +	 * All pending requests are cleaned up. Time to resume so that disk
> > +	 * deletion can be smooth. Start the HW queues so that when queue
> is
> > +	 * unquiesced requests can again enter the driver.
> > +	 */
> > +	blk_mq_start_stopped_hw_queues(q, true);
> > +
> > +	/*
> > +	 * Unquiescing will trigger dispatching any pending requests to the
> > +	 * driver which has crossed bio_queue_enter() to the driver.
> > +	 */
> > +	blk_mq_unquiesce_queue(q);
> > +
> > +	/*
> > +	 * Wait for all pending dispatches to terminate which may have been
> > +	 * initiated after unquiescing.
> > +	 */
> > +	blk_mq_freeze_queue_wait(q);
> > +
> > +	/*
> > +	 * Mark the disk dead so that once we unfreeze the queue, requests
> > +	 * waiting at the door of bio_queue_enter() can be aborted right
> away.
> > +	 */
> > +	blk_mark_disk_dead(vblk->disk);
> > +
> > +	/* Unfreeze the queue so that any waiting requests will be aborted. *=
/
> > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > +}
> > +
> >  static void virtblk_remove(struct virtio_device *vdev)  {
> >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,6 +1653,9 @@ static
> > void virtblk_remove(struct virtio_device *vdev)
> >  	/* Make sure no work handler is accessing the device. */
> >  	flush_work(&vblk->config_work);
> >
> > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > +		virtblk_cleanup_broken_device(vblk);
> > +
> >  	del_gendisk(vblk->disk);
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >
> > --
> > 2.34.1
> >
