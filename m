Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A03594E;
	Thu, 26 Jun 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929595; cv=fail; b=XoPCREp48TVLNnztfRvuJNgpmDErkgRSxE8JF39GTUIZZMzIVqghTxEBzR02RsBYsjO/FQxWyRFCM9PkQVOfa3w5hncQojomlWZymZdVxRdsUt1npquX/iEtWndxu5BuZ4bQmLbL9TMD+ADPIvJbuyp8ZDdC+XS4VKESop2Q2nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929595; c=relaxed/simple;
	bh=7QKDFwLW+NEAx/OBH6vcD7ly/1fYmDJYRIKXnT8SSgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jMY2Wk5a28i+oc5gPFzftTf9Lh1Dqu8CtDuwb7mTQOo5oVtlQt1upIGRbZRncAFrAsgFsRV/6FcQ5VC347A/2dgwuF0EWbJXDqJmR5/XTRBeuv3zne3vBF1Xop3m7qZ2qMDaOU8KVuiIzI5nlFmrB9R+ZEDqiJprNAC23fTLvYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCrbZ9s7; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCrbZ9s7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5+1yMLhCxR3UiO/J6HPAAsI9jGS5bscpMrXJa8QWfBC+v9v5wK2BTDPCFqmZVoZXbB+/PiO8opKaqbaxT3WTGalVUVeVrRez4ZLTGgXZSwqnwYKswHPZGx0h8oEJ2ro6w6eCUa5qkmg63+X/HEIFoGxqrFMbhweTChGXpPlqwGcDkZAPs7pUOoU0pXFmUxccpusxYbMB9+LaqNC11VGvddAilNXYSQvCgq0HEDooEW9GhP+3FJ575gb1ehA9QI9NxtAvtjp14EUvnyhN2qn4oc3MmGhQjEbZXN1Oh2AZYxnVYJFKbXRP4yr8OQ9C8KYSktO8L89eaD5Iikl6140Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QKDFwLW+NEAx/OBH6vcD7ly/1fYmDJYRIKXnT8SSgA=;
 b=UnxIjRHu76KJ85/esi5N5yD4OPxFtOV51q6dRXxAMd34EMIAnmVkAcI1UV8UCwB5HYz5oEkZZDhVberEgzpkCw+n1AYRja/gKqYodMB1w5/4gWhGbgB4puziAUsFSK7AeFV86Ar34+mRVNPT6Cfvj208gp32aaC9VCpcHltlh14OI5Ov3NZdV/rceq4eYCoySRWGImQ4g0ave6jieGApQzW25St6kcymH1WMDPgnFlKZlreJnQCgDGaFzjVOS/Wa268FevCs1s7VzAF+BZieT/U5Dlpbu512X+/8ovk/7P9jzu/ygoOM7VZjmc/UukgMCP3sGnDYiFQ6aYnQ0w6kXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QKDFwLW+NEAx/OBH6vcD7ly/1fYmDJYRIKXnT8SSgA=;
 b=XCrbZ9s7q9FxWpgACXAv+ZSMrdrrqxZDTJKb3YGuk7qwy/uJs7PjLnGtf3X6BTgrZ/8kazPLb3LRJpx+6esnUNDDuWXNb+4mKBQteeNvNGc7+LjrER9dCw+PXskErVFZCTgDZlCARnsf8ysYdNndOLKuiaxqRYLzCARtCLRe8UHjnZ8RfZBOC/GjOStnRIBnLOKFs9ICYpzctTbx2mvd6i2Qs3k3Z/fjdi7eC76q00fFIsF+qY9pLEEcq3/uqwpkpxj+1jyGX6FI5LfjUURFjLdX13hNOr0Jbn9Ics02uwnL8oKelN0jkm1LrzNEo1KD6NsHw04YUXZ34624SrLKtQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 09:19:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 09:19:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
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
Thread-Index:
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsIAAitiAgAAAT1CAAAsNAIAAeh/AgAAFwYCAAIZBkIAALRYAgAAGIWCAAAIjgIAAAHrw
Date: Thu, 26 Jun 2025 09:19:49 +0000
Message-ID:
 <CY8PR12MB71958505493CE570B5C519A0DC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626020230-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195435970A9B3F64E45825ADC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250626023324-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250626023324-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH2PR12MB4261:EE_
x-ms-office365-filtering-correlation-id: 55982f96-2f95-46cf-d096-08ddb4929a1f
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5qXmkbuXuTatG8ayf9643bdw7pEW0pKnHo5Pgbe+dqszayeF9TuUKuJp1vut?=
 =?us-ascii?Q?ay68rgzV2ZYZJb3IY7dL26BSxc8lRKbLn+BN+OaVXRPcye4XG2GSeJvIZznL?=
 =?us-ascii?Q?cQLjl4QWHXX07eJBi115CS4fBx54fz9sz1etZW+yJRlT+7/I81/vwaS5kRqE?=
 =?us-ascii?Q?QUtKhAnySjMaAOBolLL4W5gVRywrr5gcwN/yQzg2BxEgPf30mCyPCDw3xwrq?=
 =?us-ascii?Q?tO14RbQBXrhgVEI324ArIimP6oz1gVr3D+ZYKPDm3dDsr2p0iFMSdPzmWDC1?=
 =?us-ascii?Q?KTw1QzM0BiCSlxEuRkk5faKZEnrZrbej6HvJdy0z3tbxOWpH9I4tf11RUymz?=
 =?us-ascii?Q?6Kb9q3811rEwaExq7NKrJmv9h6QLP6Tlv++fHut+1EebcexnX9d8YGP/LbFW?=
 =?us-ascii?Q?RxAvA0p6oRt2jRcv6pPkdlu3tu/be/2UFjSnkA5YWoEO/umQDszTxwdnbBfw?=
 =?us-ascii?Q?8vUvnJrSC7D5E8MlI9flQokQWO7Z1geiaDlcrC1h0K4H/mZ9TOmCow5Fzuet?=
 =?us-ascii?Q?U+mRv2DDyjsjQZemPnGkZGgsngy1OCgg8MIIHATgW9uRrhZLEjIHRoooNzf4?=
 =?us-ascii?Q?x2MHeP8pLmPDusmIpzrzmQD4gYAAQ9+CZkyJDCkTCR9wopgN3+HMFqC5f/Q5?=
 =?us-ascii?Q?9Q5zGKN1y4V9VoqDsOBD1oP4bUKYashaYEtWVjdlikRJy6IjHVkHAU9DjzwT?=
 =?us-ascii?Q?qfQ4GgKcZ875KA0dLcAEDrih63fxAslQVBsP1sn8p4AakbCE8kMaRV7fxfB6?=
 =?us-ascii?Q?BXLQqWcs923Df6PV5JCg35gSmG8HdpGyEMDUNtLMCC+oKObta3yo7Zc1A9no?=
 =?us-ascii?Q?jp73NSFWFHR010Ucdc8WOTQ4xuI/3xTbrbDArG09C7z1rYjtZ8ucF5WT9li9?=
 =?us-ascii?Q?zHzSZv6AVvhyCsesGCmCQ83CL57OeV35gmCVixIWgMM1t1FOYXm61DgKT1bJ?=
 =?us-ascii?Q?o2GB4MHqRlYT6e6VX/tCob6HbGn71+TN1S/P+l6Cgt9BCmBfHdQUWyKRJjEC?=
 =?us-ascii?Q?iNLrVvHNCyMuKz+hJq99NhxasFJWh2O5Fc2/KuuZgnXVOzAQzgizJ4EaXu7h?=
 =?us-ascii?Q?uH3Fr9wOAMHHwsnRXv6xZne4rCSQ77pe2vUm9tcHq1wGAMLddxFLUlxcfVX0?=
 =?us-ascii?Q?A0839C/iUmixG34Cki1YGCSNkTUN7HCefBkw+T991mN2yV1tfpNO77IsMYAQ?=
 =?us-ascii?Q?d9ppE8r1bVKHeMIYXDykrr43VigSbI/px2uJaVq2jj1YVPm+8tfkOJMlL8pG?=
 =?us-ascii?Q?s7lA3rRDpi9jA7d65z4swSSOE+vXpxbcxaXrPsiZuNBJVAOcY+UCKoFRr/Uv?=
 =?us-ascii?Q?BYUo7OLzIObJ0lXs6gEvSkgqwZoHQr4r4BUBnAmURya/+LrdmMidVm6o2W0o?=
 =?us-ascii?Q?5fW3JCOskmdn7aUVAx0sgdPMA63pg1Xd+EL7NY7V9U1lg5OvHUjhKxWBJmKx?=
 =?us-ascii?Q?9bxPye7Ur88RVQTxLAVPkrxYWYdh+Xz75x+mw7NlUlunQkCEOayFQfz/BlGm?=
 =?us-ascii?Q?RFcFL9sFMZtfM6A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Doc9DIO01guO8HgYvMS+AmCHSQ/1cRi1CkrUA1vtf7iBZIDh5jpsE2GABkfr?=
 =?us-ascii?Q?H4AedJlerIZN+bJbgMab7Orx1baA18fpOtsMOb59nWAtjiIoGam9gkJVoA6B?=
 =?us-ascii?Q?56cQIGLuw1fcWoz45OtPbGL61Gjncgq3RYeqKKK07kuKD81MYHwt0i/eTdvB?=
 =?us-ascii?Q?G4hWkhFUN+p/avzDcnGESiPbmilXNCRPAwdqyiS/WL7qTuFLFR8G6XdsUn5A?=
 =?us-ascii?Q?nQpoUBs6/M4/jzSfCVMJmR0IrAeGiWn5nlhHaoLA61O9743PaR8ez1VnqiaR?=
 =?us-ascii?Q?caOIvUpqsRo6Wwr8PD3xwnsVWDtcaE9rxxdqh5crCyhqEscwHU3QQSN9c1hM?=
 =?us-ascii?Q?xRwxqjvU+fk3uosEh68y2XkubgWCav0W9d0ouLFEF6E7WvU33eYPxbnd+DLb?=
 =?us-ascii?Q?3dY/zmfR4EPe6kE4E+O/OC33IUaZBgQirGge8MqPvM92g/KodCS6WH00IK97?=
 =?us-ascii?Q?tvpUImsF31DLTykWYEM5EQ1kSADJYvOT3yoDrUjoa0sv00Q7QBQTVLylHuEp?=
 =?us-ascii?Q?K5WoRSe6VvayMZJLTvMV/djCIJJ8J0xF9pOuvWwiAJSQDhEp/NV0W5ZA39cS?=
 =?us-ascii?Q?YEmY5/cEFyQt709PoYwOTtjqbJPmlxeBIBs86SoU+4YKd5j6Sgzrd3s4Oonf?=
 =?us-ascii?Q?yLnBE1FbAm/+VBujWXX97vmZDaqogrywHE8h//XHnCbDjJyLJgxVCIIpSVNt?=
 =?us-ascii?Q?VFFizQ/MJaPEAGjbRnzAOg8ybIQCxTvgrv+PzeKewUHZMSjxsvaEpznAVbJr?=
 =?us-ascii?Q?WWjIkZrL7iV3C0TpG929qJZYFCsFjSFvGvJjUPuERApkXyjhndbht5l0F3qG?=
 =?us-ascii?Q?OK8gcDpaoRWodvS/ggLqa4MhivH8Qq2Qa/yCj+nbvNPDRWjupXbhHVg/0fXk?=
 =?us-ascii?Q?jeXMafcwVietZGVT9kBm5MlEpng/7yDN6ZdTFMcEb3vQ8VcUff1L6bJ3Fz4n?=
 =?us-ascii?Q?MINIiSoHmor3RnkU4wBSaaikIwGO7pxCHNQMc+sC637aw9LM/5LixAf1CJGe?=
 =?us-ascii?Q?mT0y5HrAkTFQbS68/wYNrz/2MxH+Dv2J8h4xBi0/M6ClqwbdommM4ni/9S3Z?=
 =?us-ascii?Q?uSqakG85saUu2eV/Up3jBZXGcpM+gJfRpNLBnTj0khc4dz7JyjOc6RxWW32m?=
 =?us-ascii?Q?EPPyPOg/+gqDaMWBX2tQtXK0AGMFJ1o7Uh2NIvbUOds5vMGTazuBIrDgL5nL?=
 =?us-ascii?Q?Fuemj25yn3krjd7b264b72Ww81TEuBAWphutC0MOw8moPtAtNooPnMeV77og?=
 =?us-ascii?Q?wEXXkohfaiuHKfiB5nW+lT45xcBPu+tIJdjussnu5Eu2q3FLyZRy48w3yKWt?=
 =?us-ascii?Q?gwigdL21ZPz70iqhcaArIncguHdnYEi87rHKv7xhSmp+0W3YqHotHFZq52ff?=
 =?us-ascii?Q?wuP0ZRVALAeUWlz0AduND+6N6cchBZ+jklIkLvm6ZPLH2BVk+o+48ntLctyl?=
 =?us-ascii?Q?cA9xdqSZVNq5uoaPpMB5Ood0kG8sw3MsCcfe3F02eXtOSoWRY+vMK9d+cmhn?=
 =?us-ascii?Q?u60EPBSyigiXywE3DLQ53EpYmncVM0yYFQ6IcNs3aJ+tXKKIAdyxYTVlr3bX?=
 =?us-ascii?Q?2gGXZoGy3TO9SBRlk9I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55982f96-2f95-46cf-d096-08ddb4929a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:19:49.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7Phmgv0uRS2GbMaOraRez4ELdG8jhytHtoTyIDnj5OPx2JMtq/lOFt7IAZcOUUH18//HXeN2rQTOcQPOlQing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 26 June 2025 12:04 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>; axboe@kernel.dk;
> virtualization@lists.linux.dev; linux-block@vger.kernel.org;
> stable@vger.kernel.org; NBU-Contact-Li Rongqing (EXTERNAL)
> <lirongqing@baidu.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> xuanzhuo@linux.alibaba.com; pbonzini@redhat.com;
> jasowang@redhat.com; alok.a.tiwari@oracle.com; Max Gurtovoy
> <mgurtovoy@nvidia.com>; Israel Rukshin <israelr@nvidia.com>
> Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surp=
rise
> removal
>=20
> On Thu, Jun 26, 2025 at 06:29:09AM +0000, Parav Pandit wrote:
> > > > > yes however this is not at all different that hotunplug right aft=
er reset.
> > > > >
> > > > For hotunplug after reset, we likely need a timeout handler.
> > > > Because block driver running inside the remove() callback waiting
> > > > for the IO,
> > > may not get notified from driver core to synchronize ongoing remove()=
.
> > >
> > >
> > > Notified of what?
> > Notification that surprise-removal occurred.
> >
> > > So is the scenario that graceful remove starts, and meanwhile a
> > > surprise removal happens?
> > >
> > Right.
>=20
>=20
> where is it stuck then? can you explain?

I am not sure I understood the question.

Let me try:
Following scenario will hang even with the current fix:

Say,=20
1. the graceful removal is ongoing in the remove() callback, where disk del=
etion del_gendisk() is ongoing, which waits for the requests to complete,

2. Now few requests are yet to complete, and surprise removal started.

At this point, virtio block driver will not get notified by the driver core=
 layer, because it is likely serializing remove() happening by user/driver =
unload and PCI hotplug driver-initiated device removal.
So vblk driver doesn't know that device is removed, block layer is waiting =
for requests completions to arrive which it never gets.
So del_gendisk() gets stuck.

This needs some kind of timeout handling to improve the situation to make r=
emoval more robust.

Did I answer or I didn't understand the question?
