Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55E15278E;
	Wed, 25 Jun 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878084; cv=fail; b=ZgN4Xshrdz24Iuk2qoLcTjEfgZ4TOkcBSpNW2JoIvYQldkDcpSopURBP+yZIHW2XWdYloz6gLiiUioEGdwGhP3zhwbmFfF/WVH61QylfsxOarMb+9GBETzC6kBg2UsBak7wtBaEdnEKA52jtuKkapzUAg7CghT8TSrOwCtDjb2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878084; c=relaxed/simple;
	bh=EyPa06xdQCbTyiLkIAiM5tu6xtc4uXW0ESAix8SpdIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbgQqxQglSROFej7OVBwC6wS910fcsXfOinZ6KCRC5VzYeae7pF9TawcxQNqR7vzrEUXzn1TAw7IMJtUF06GeFnWn2ZVRcQgM1XISOw9z4lq6ElROs1i4Hiuvc4nXleProdLJt9Z38sPSSfo4AJ+REhsyciNJ19SyK+6oJP62Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCTRy6qg; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCTRy6qg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQBvL0VCznhYDyl2f4Lk0PtZ3+1u2F4cX2MQzmEwmP3WCzcKbLV7Nar6k1j6NpkkawY32t4FBBgg2yRerA+vGvxrVIC+XH2aY/71FMd2hD6OQ3s0WmXxSedjKNW0UikSrSPH3kxO94I/O/2Qm49Qu7q0obipeU5zAS72j6ByVuRJvkDj7baoNLAHJU/oMOrlbGCqvFLojW75SeYtLOaoFhgJhZpkb5LuztEU0N+5fGutwECRRbEiIyJ8CV1MWrAKAuc/0na0dtY8fwxpmebltCr62F/CxXCJRdVcOdX8rVGNoklfc+yb4GGs5onTPcF1I4VQlPehmD26QJbwd6kRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbKabcEhlFFk+Y5cJMKi2FNr1a2f+QuDbMpE3PyjEDI=;
 b=ZMmjzWmlYkFK1tU0wq8CcZCqXmwFL67FCPcQsyWyEJvHM6P9QITpmVcdtBE3/izl+ETCzrTy2I2C51QqbkjhZuuBYOn1zUWOQLf5KVz/Bqq9y0tjQjqYvyMlpE79mDolStQBfZIWVGvIu3IHDcXDp7AFx3lE3YRPb5rj09qAaSTMVrjhXYmOocvdDOlD75uLBkJ3jBOkkeN6WPqN5buvHjQudkl049ZBKs8Agwi44E6E9Oyv6ilxNHl7puAlFPbj0UW+JPQmfBb9Xy/sQGHfa9zQnNNMjK52iU/SSHX4hwn/XQeqEaA/Z61AkziYHNbbGWl5ZctyRs2e+0wsUWwqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbKabcEhlFFk+Y5cJMKi2FNr1a2f+QuDbMpE3PyjEDI=;
 b=XCTRy6qgN35nCvuMnh/G+hlNvG9EJXp+nXxYN2uPEKa/ubZROeMZKSUvo37LZtUDsNjscZhkdKUkj/3YJE82NS83XIaKT7L8PRaOPUmmpgM3ixyHYz1W7RiZCoL7V7wAlkDjmsRqwNE02EVJ9ZtbgRdCLy8Lc8Pc6aRCKll3bgPaPdRQIgyYbuA5Il6D+wWIYVZvB2yKreoJ7MPEqk2jgd7sGzXK/cOyVjvP77JHx5Wq3wT8iWmuRdb5pQO7WIiOrsLkGuRLq+DtVRh+/c+eQbQWdjDlb73icFXPP7bI8qjoE4+jevSQprTZ2Cv/e4lBS4WPIig2COdkZXoyu0fMiA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 25 Jun
 2025 19:01:18 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Wed, 25 Jun 2025
 19:01:16 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: RE: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAEo7oCAAGotUA==
Date: Wed, 25 Jun 2025 19:01:16 +0000
Message-ID:
 <CY8PR12MB7195BA7954EE2002CF552A45DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
 <20250625083746-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250625083746-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH1PPF93AB4E694:EE_
x-ms-office365-filtering-correlation-id: 6c148bad-22ee-47a6-fddf-08ddb41aa9aa
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6xZwqgO2BqrujrY7NJjQojhbk3IZirv7IBkR4arwuwg15zVEnJwAA8zFRXvW?=
 =?us-ascii?Q?ao2CdOyoltVeIZ9poINxleWXb2wTgiOE0vD/G/hs+1vSbibASwxYkcKJMTaH?=
 =?us-ascii?Q?zGdjMM6bVtv5tctbQ2ZnjlNYRCGR9XQaEVCxsTgSDYc2vkVsjxA4a5Scf6Qw?=
 =?us-ascii?Q?ZJEw/ZI9q+ZWWfCExOU4hWOfVKmNsWKX2ah1rcgiaD5DkbEKIG7gTdAQRXCM?=
 =?us-ascii?Q?FmKOUxARX5eXHjtklx4EjoDRhbhE5Jx0uHm54zrRDIWp/mOHtcIg9stEYZwo?=
 =?us-ascii?Q?+7QOV6iLMNc5vhkwsbe1keEj59iBMwzv0TZSPSknBFypeZWzNFTPzpGbe6L5?=
 =?us-ascii?Q?nlsplZto9kpWN17w5NSiImPdizaUMrD0Q5TltVuAGg/SGayCEwWj51J4c74w?=
 =?us-ascii?Q?G+Y2E2fOl9h60Fpp76y+pjex0y0TRga82XP9V7WdieVwSUQYSlVPy0ecSldu?=
 =?us-ascii?Q?IrSTA8zzJSg7w//vk3DxMeGXvs5jJ8lwITp1Tg6+n5ZZb4V3IRNqoDJgk/sO?=
 =?us-ascii?Q?acA1HVEWwU3UP5K6aJtcnGUfhgr3oNK5VggN01fDhUwnc7AIWCDgCbm17nkr?=
 =?us-ascii?Q?cZZbOYoKHfPu7Mx/1RabXuj/kz2bV4L1v5s1oSKVq8zNJTAnzxi8WeozBo/L?=
 =?us-ascii?Q?jV2vkDO3S3FKPs4uDztiL0JY1skYzMC593lUmM7MZVUi3Azgpg2YmS4yfEyl?=
 =?us-ascii?Q?P12niIM25JJ9wGRxnkhqQjk0lWCcvqHCJGuOir53X29B51MVntC/5xSIeeeE?=
 =?us-ascii?Q?fSLq/E+OR4ijvYMaBSQzUWu1eP3eW4abJdh1Yb/gv2ihgPcNDX1o5ChTmEaK?=
 =?us-ascii?Q?wXUYwwIVT0gEGPn5x3H/JjKQ7cspxEPwNyT28qDUkAgyGsnICCABRt01pNc3?=
 =?us-ascii?Q?1vo7IumQN1ST9Lz+yca2QBeZTZ5+cCG/bncUpJCcufijUf65Wh0zacep7Kj5?=
 =?us-ascii?Q?McwuvCGo6AQRS8t3+kShd5CNXwk4nzIWPQ5pMVi2hrrc1Gcr5OP1b6aLCZXE?=
 =?us-ascii?Q?+tagnFBSZtKbJuKkri7tDjfUz/LiV+HEWTqvgzLPJeBpnFFtgdD7IjgXy5v0?=
 =?us-ascii?Q?fbE/2UgMHrtAU0lIEZWhG/ZLCEC7QITeX6cQUlmk3G6EaOPYtnxw0QUVQd0e?=
 =?us-ascii?Q?cpbm4sEF1M4gOJzOgErlY7xA4YN41o0fbLoMKESzKuML6A3c6HRwlWSvk5xB?=
 =?us-ascii?Q?oN5k210q45M3z9N+wUkpm03H5KdupD1hTkp6uiaBxzpkVJbq7xYmauloldET?=
 =?us-ascii?Q?crw6iZHADzgYi0JldiZkneZxFfb05jXjRyDdnvmR72+Trzb0idWNSczk3d8r?=
 =?us-ascii?Q?p06l+kpNIEcDpvkEIivftM3aBnZNFCidY7Ra4TOhbyGt1pAzqolDYk4K95jw?=
 =?us-ascii?Q?aGBT9xmUPhl7DN//OX25PU2QnD83Y6BP95AntTQ+KcbbXpwOD9BY53lBj0bx?=
 =?us-ascii?Q?ALNqBLpKGydfTwo4C9YUVZcqMyLkJ32Jx11jPpBrQuI2mA5Zygnf6Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Glp56QAG1MIR1sG78M+rGtvGw2CAbqeR8V5WxIWeWkfs8rtsbULDW/5e5eFK?=
 =?us-ascii?Q?hXxvXo9cg9xxk+YEE1zABqCTskLmoCjh9TPBh3Ed/OgsboLNKKhbJbeZKW+w?=
 =?us-ascii?Q?ZrvE7bkTLWSR0idQyMAj7yBYSKxImMgkTOs1zALIHX0eqACIw8b8TKtU/I0r?=
 =?us-ascii?Q?yX0Vwbk9zSFYKckQbYKMPellfIYDInJ+5ToQ0etiRT3+HgrSPV+VNsbPznfp?=
 =?us-ascii?Q?dAEGDz5cRhBEATjmTHQxBjnqxOJtceaylp6lgq0s8+C1YVpniCOC+q3X0fty?=
 =?us-ascii?Q?USXr9wlZk57S1NqcuoVaI3Y+iQpTUacEyV0cObBejp8Fv5mXnYjVjvdgK4s4?=
 =?us-ascii?Q?/pz0orJWcUARUqRDBs5aM80aArCIIr3wHomISV7PoKmsA0if/r762i1R0mEL?=
 =?us-ascii?Q?UJTP6aP9/Tnp2qGexIDhrRxKQcwBmix8KldQ5+A9ee4pOFDvd4ignNlGLjhL?=
 =?us-ascii?Q?MD/n7Fea1LnefyAbwB2qH4ZEZBKhP5cI65bGacl0xsLIoSSXXpA+I+k2TSJI?=
 =?us-ascii?Q?hv5cklxR3l4eFN2RpFM7ZFdsoq8t486Lmz5pwYzWciYo4yR2nS5EGslT4Gtk?=
 =?us-ascii?Q?Nt+0BIpqsmHkNdkxqHPa+Gbv3Yjm0bz+uKemHVE2UdpjjooywkyoCiQas8og?=
 =?us-ascii?Q?6vTmuaNsn17/8nzlk2A6JQecAQtaxWLClEtHAYvw3xb2uMzbYa/IMdNPnN1r?=
 =?us-ascii?Q?U5PN1Yj/rwMuRiJuZJx3kkkDU58OiJDyZvZmBKGxfoD1wwRcZVnfGrFKUBOP?=
 =?us-ascii?Q?wL5t30MhKyxdfpBw49/BIm4G3rgcUiboSc+S9DI8ZeS0tbAeG2Gp+O6qbVvD?=
 =?us-ascii?Q?LxOUZP4pDQp4WmOt1UfuibrPDN4BxXUzp3P3zHzOenkVDvhetOcD0z/fV97v?=
 =?us-ascii?Q?aYvhym62dTSm1hxQdYyIfjAe3S4F7LnY4oktwFKhiYgv6miICx4/MMfiRfzd?=
 =?us-ascii?Q?5OchwSip4Q4dGKCoSq6Xl1HedaUE/cRmkWMPMzie8hloHaztjA1s1kTqzEdv?=
 =?us-ascii?Q?xNWDxAs7FqzTTyXNzGUEsPcjMeO47+pDu8kiy7YtftJngnvRm45gHkMrABTL?=
 =?us-ascii?Q?m0eDN/fE6Y8JMZgNc+8ch9wMn4W8N+2y+ZUzDfyd/0tQ4jIdhNeQh99qYhuV?=
 =?us-ascii?Q?s9g69KRPKvV7V11dZTjpcQTxHBjehIrz4Uz5q+49Pgza8KU8VwxWm/Cv37zM?=
 =?us-ascii?Q?xnNRKCG6k6LTrccuHGJ0ZEHochwjvVjNpKNefcTasIF1sA2uNK7PSedyiW+T?=
 =?us-ascii?Q?1mFPz0uRLaT10HDdfWtJRhUsS7TH8Gas9xugOIjpjICAUOWYj+7mBiTbZ3Qh?=
 =?us-ascii?Q?co8Idyq9xuhxtozd+L+HYEBWRb3lyh/CxAxU+Rd4GmXC4X3BQoko0oNPYfF8?=
 =?us-ascii?Q?SX7nIgDlMHXGnZ62kR3Vnw0ZZET1FepdAk2yvKm3ysZaUwO946REjSaRUx+f?=
 =?us-ascii?Q?nOsnAltKbpw8MqE0G7Fp2FL2R3vcU91sH1D7XhgcFrHDRlW33/GW3KCDk5QZ?=
 =?us-ascii?Q?Lmsf8ClMIiIV7cQRSs+hL+stJbNkM8yjVZvdYQUllPu7FdSdVQt01LiBMtpR?=
 =?us-ascii?Q?kzOMwBErrGQaGT4AiDk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c148bad-22ee-47a6-fddf-08ddb41aa9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 19:01:16.3805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKaUPkQQfe6nj1U+rToMmqBwLTfn60i5FDoyp8tDd36K4xYsPKCfimlQMQPoJWsWdwmCNu+59tNEUpuyb0BgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 25 June 2025 06:09 PM
>=20
> On Tue, Jun 24, 2025 at 02:56:22PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > > When the PCI device is surprise removed, requests may not complete
> > > the device as the VQ is marked as broken. Due to this, the disk
> > > deletion hangs.
> >
> > There are loops in the core virtio driver code that expect device
> > register reads to eventually return 0:
> > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> >
> > Is there a hang if these loops are hit when a device has been surprise
> > removed? I'm trying to understand whether surprise removal is fully
> > supported or whether this patch is one step in that direction.
> >
> > Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Is this as simple as this?
>=20
Didn't audit the code where else the changes needed.
I had similar change a while ago, but I also recall hitting an assert in th=
e pci layer somewhere during the vp_reset() flow.

Do not have lab access today. Will check back tomorrow and update.

> -->
>=20
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ---
>=20
> diff --git a/drivers/virtio/virtio_pci_modern.c
> b/drivers/virtio/virtio_pci_modern.c
> index 7182f43ed055..df983fa9046a 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -555,8 +555,12 @@ static void vp_reset(struct virtio_device *vdev)
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_modern_get_status(mdev))
> +	while (vp_modern_get_status(mdev)) {
> +		/* If device is removed meanwhile, it will never respond. */
> +		if (!pci_device_is_present(vp_dev->pci_dev))
> +			break;
>  		msleep(1);
> +	}
>=20
>  	vp_modern_avq_cleanup(vdev);
>=20
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c
> b/drivers/virtio/virtio_pci_modern_dev.c
> index 0d3dbfaf4b23..7177ce0d63be 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -523,11 +523,19 @@ void vp_modern_set_queue_reset(struct
> virtio_pci_modern_device *mdev, u16 index)
>  	vp_iowrite16(index, &cfg->cfg.queue_select);
>  	vp_iowrite16(1, &cfg->queue_reset);
>=20
> -	while (vp_ioread16(&cfg->queue_reset))
> +	while (vp_ioread16(&cfg->queue_reset)) {
> +		/* If device is removed meanwhile, it will never respond. */
> +		if (!pci_device_is_present(vp_dev->pci_dev))
> +			break;
>  		msleep(1);
> +	}
>=20
> -	while (vp_ioread16(&cfg->cfg.queue_enable))
> +	while (vp_ioread16(&cfg->cfg.queue_enable)) {
> +		/* If device is removed meanwhile, it will never respond. */
> +		if (!pci_device_is_present(vp_dev->pci_dev))
> +			break;
>  		msleep(1);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
>=20

