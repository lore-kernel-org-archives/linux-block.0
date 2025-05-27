Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1D248F69;
	Tue, 27 May 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339609; cv=fail; b=BumS7iq1NgK042BILkOrK7Ou965FEP63VMrd9/TOvoP5Z+kJvyyMlFNZ3WVKBwyXzic8po6Io+7sfUdPe0FIqj4UvdCcft8x77UASSP/VnB42j6BMijHzr5h2Bjljx65pV0D0C3YvJ1EwbXRxHAW3hgCMRir5jW924wp17T4vN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339609; c=relaxed/simple;
	bh=9CkVYgTpqPLvv6Hr99uuZZRBHOVqR9Gca1SAgHn6LUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6QPheTV2t0rrLYAIaHm5lPJjlsgBH05S8PdmaJYY3VpLJwqXtQZpWEEa6P1PrTUF/CTqSc53CdcYw5oQVp2yjDTxsG4kOFR7WAgjpJSMuDbgI0xHmtBoSqhA4AK9ta/Qn9t4ru5KiuMeA3/eWJgw6ky8ZGDY4qMErMG7EUOwm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UNAPR/iy; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UNAPR/iy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ0mjiAXFmhnWtAKuo2/3EDLzLzDfkB+bNj+XwG/PCzPxVp3+QIQrvgJiFbugNPbryFSiMFm574or7r5A0bSfHJjy5zQKS9QY589weiA///vLiAPb9vWQvl2a1C5p2fyU5zIWZ2J5T41SH2RLVrKBGDoFktfL12OcN+F/srr8Xnwg+HXbskgeKJ2l1Jt3PgTWobGDGRM8RcI6Sj5nxoFVUisryd5/TI9PHkppBstT3WtMKS/ugFOmf8DkEH994me7bPgtAqJOnIm7qEL5AhqQocTucU5F8AtFSraYCj9aKesMYCt7jyH17nvA7v+M9IUcIHfsbWdqgJ5IiUDDRVdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+P8lpo6TBwKIktp19GsIFYNH/5Iy9/nPyDOYPUbK0E=;
 b=HyvUFdIZDWjanKCbWPXufn4qaniRpUx7oN3PNf6Ln6LEWJN8jxdZbK3ZrvCUw+olgwMMq3uOkH3lm1D8JAQHMfKudEVxUZMHYUOBt3t2n7KAHhhlrFILIK8VCKxF3n9o7wk/x1EpBn7l4sShmKeo/Xaw9meOsxI4uuFu7Zrcoe2nvNE9qGeBS7rVyMPTiLvAuttHESapl7mJ7m8eLiC5KE2hlNmH1Y+GCz6TyjW4pDNo3GwEvYZYRvq/+zWrsOy9Uqxs/Z3y0XE85Yyxc8/ck4muAvASIurwA42Zlvg2UHt8ZOIFLSYe0MY5VbsFXAXsiDBf+fb4/m8uvWdFAzx9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+P8lpo6TBwKIktp19GsIFYNH/5Iy9/nPyDOYPUbK0E=;
 b=UNAPR/iyz9FnTc8KDP1czb4t8vEmz6dr0A7aRqjFvxcQlTlfoExp+7QHOU3087QNVcJxBvKa8V8Cm3E+GA2iL8gIgLHuOFM5Soep4hBszK7f4WevdpiIOv1ZdSj7o+fT0mpdndYJgs/5Whts1cOrdIfW4MI1mHpGRPb5TwWOJC3lPcA+zkYhBOkXRq84x5ITlqCOLg1aszR2ALdYoqATK4hjZL5NI9nElGTj7IRaElJeWPKmEk4ioc7jO5vCsWVeObRZONyTM19JXR4+9iViOos7vbTDJwnhLkrpYUbi93vIgZ8FFSrvSLtOD6/iuK/mmwH9VbDOx2cFdm+gpYrJVw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 27 May
 2025 09:53:23 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 09:53:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbzkwlOUEmL26euUGJDrp2Zb0iwrPlWS6AgADgxZA=
Date: Tue, 27 May 2025 09:53:23 +0000
Message-ID:
 <CY8PR12MB7195F57BD94262177597DA22DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250526144007.124570-1-parav@nvidia.com>
 <20250526155340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250526155340-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ5PPF28EF61683:EE_
x-ms-office365-filtering-correlation-id: c651e0be-0f9e-4b5e-08d7-08dd9d0451c9
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nHkKBD67ss768QjiXNhNCFGlfGded79wnFbMdRz2H3cVYpsR3r7sKXxMIo9z?=
 =?us-ascii?Q?qcJVqOAi9bVRuvMHWPJBnNIROhwXjtqmq+NopVm3CvB2brpn50+MJfFtSSVL?=
 =?us-ascii?Q?DKXCkNghATZYzuSvfJ9gWvyl/M7El7wMQBsgAn0MVnaK+7XCCGA9LwK9IrZK?=
 =?us-ascii?Q?0/JN0XX7x7yc8h5HLNyTMwFFYVPL6MmFQOFhK5spWk8LQYB8dTwEmRIujSt5?=
 =?us-ascii?Q?tPpdvsiG/HK/XCDtpfmODhYX74zrzsIAzrYt3iFV+J78BYIdu/ixS2EqBKCH?=
 =?us-ascii?Q?U0FCHUpSCw/8psyeuj799dbvTDRYcVDjN9TdSdAQuzXwN9e7D2vH3ljKel4E?=
 =?us-ascii?Q?HIr1fEeGL0tSmykM20iauSrsZq71u05J/BaRamjZNnAl5oocJjfVwg0Suklx?=
 =?us-ascii?Q?Eb8KK8SwLoXcdYBoQzKV3Csi/Xzr1sCXOjZ/CDgmr6cNxZdni0J1W2cUT4SI?=
 =?us-ascii?Q?2frnlLkBM8qAoQ0BmIcfXR0EphMEAsXDBbtm++aF7OReOtDZjtZaAzog8Vgp?=
 =?us-ascii?Q?am5tb3VCf+ArgqiUkNrp5WRWgZTEZw/XgaPxkN4OvR0iJRczwsJvSnVOGcxL?=
 =?us-ascii?Q?ZtLacnsZoi4kDgoCiSUv0ddyN87k7+oCde3x+AmCE3cWRI7hoUia7uh1Stlv?=
 =?us-ascii?Q?+aAjqqBkFZvMSGTkk6Sk1PzlVjsM1V/6688XK5cgEkznz/a/+Fda10ewljyt?=
 =?us-ascii?Q?mVwFDrbmWmUh3E+9EaeQZ3YpW1S7iXnVql2KoPalUb+wOi632cEle/mZSFW7?=
 =?us-ascii?Q?ws0NkZbIAMxq8J9ONz6yuG00lCvFU/qWp1yYhHIXsf3Pa8E2EtSjiT/OIcZV?=
 =?us-ascii?Q?0IWQImhQCWjVsBPuf1bPDZFpO6qwhhRqKgK+HaqiVE/uKkJZaukmZa9zGXtk?=
 =?us-ascii?Q?8iaolVcTFkvFfhpjovBp5A9sE69MmX630rlOg6J6VErk7m5dg6yibqtF/khB?=
 =?us-ascii?Q?mCONazRMLN5HTovCYi9XyEvkS3Oxng5Mv71h3ZddZ7HG0OgBMTySW/LTQWNw?=
 =?us-ascii?Q?VIoiTAqQPJgpVd6E2a/KrUURVFUYROIabMk/nPXU1HTIj13huCQyDxaOmzfD?=
 =?us-ascii?Q?RWcPZ9K5oCCtxAxZ35EIFi1byilM2RgJ0e3luClqfp7af3Xh2g+zoLnxAnk5?=
 =?us-ascii?Q?ckve+Lr7Iir0Zp7xtgzbvQRx7vfaNSGzJSemP50FqhcL3+uKqqgmmGvdYFtI?=
 =?us-ascii?Q?NO82X7Em6jWRqW+uauVptb1YEFXbthMmgo16tn/l8fFJObKS9na0HZvBMd1L?=
 =?us-ascii?Q?aufEAtG15f1Y3QvY3hm0zOo416a9bQINrUJv4msTAAcC+MLiVETk15fUH4fR?=
 =?us-ascii?Q?mzIBDe6BBd/WilldbP0YxhDpQ/AMR6YsRMOmy6uFXIZ6L7CEil6QTZwO1G1J?=
 =?us-ascii?Q?Spu6MukL5/9pjfESC4H/hg8OhBIUUx4a2Xq1qKlemyDvEdgFDXdZxM7yJPI1?=
 =?us-ascii?Q?B2637DqzZFumw/ty8UJREV6ivHhU5870JIdhlsd9jCp1YV3x67d6Jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8/htoeUtgV+o83l7L8oS9EVS4vrCoxGhFKk5o9djHZmBXMOiuCqxysvEm4GH?=
 =?us-ascii?Q?61Mq6sIbMUUpBX7Xg0+zeCykbh/9A1sqkXlU1oxE2OoHgmeOwZpL/Iclwv+x?=
 =?us-ascii?Q?uY3bFNq+dsLaRyJhFUsVqMvOlufYDKlDEW4qc3fpfsMjROCgmhZZj6rIkgq+?=
 =?us-ascii?Q?8OAGeGFAu5u0gWrlTf1RJzS70CE4FiXa8pqPlTcETWFgpXB0IOcX5SK84NpD?=
 =?us-ascii?Q?xyn+l6z02JN4GAtj6U/7Az4WQFhLCNndSSCwv9ppQGe0tgjhBmsD8+hhR1+m?=
 =?us-ascii?Q?eAuiejIA+gzEdU7m59RxPFawqng62MOYboISRqYYMLg+/3653KxKIbvKzKQY?=
 =?us-ascii?Q?UvFKMZYZTV3dQRf0PZpEhBdAhJMpXAhtl3VgM0/ZTUfhy2pML5F6r9Ut67p8?=
 =?us-ascii?Q?4S7czrWsYZP4tR395u0HAQOUx5Cppxxit1TgcH4cLQXybDNo/FMi++BJIjlO?=
 =?us-ascii?Q?WmJHHgFChFMlyDXH8KNVdjdc+iHWzEhJWL2mOrkZeMA8Ek8JISRcOlql8wRb?=
 =?us-ascii?Q?RQFZv04LF5DSgspl5TAP9hqq/LFBZzuX6H5lircqxX7g+NbgY/hWDaEvHJWf?=
 =?us-ascii?Q?o9deiwDuTCgaCZXVZMAWryYWwjXmkOfZ2rv9Q/QXSJVngyypluCrlNaikV3o?=
 =?us-ascii?Q?JXrUt1jhnH403PG/SMIecLHfc7AdxXVHQgmARwcxUYYUYJHHk6J2dsY1puUK?=
 =?us-ascii?Q?9CYRUK8PDzYMDZplYONwHmex6iMMoOrUuOz0bVT2qEMm9mNJTqUYr9ULXQaI?=
 =?us-ascii?Q?rqKH3KPwMgwHpdd+ZYkHdf5znoU9gZSXQBpIzf89WpOeRk6LLjzdXipLndS0?=
 =?us-ascii?Q?Oy7Lr51JniEHv9CnVIsHio3mkdLbKkmi7nibJ2VL4SAAjZOG6TwShAdeERBU?=
 =?us-ascii?Q?it+CWRb41eU3l0Yqg3L4aMvRvVrsFQut13PZOiox5xuelyCMe3qgtCoT3aGK?=
 =?us-ascii?Q?jb5sphp59p6nVz6u+wlnK1DVVCwk9WthBeNWF2AAiA0SIi8dhKs3I/qMbQms?=
 =?us-ascii?Q?qOQgOg7AEW+FAIp554qu4ChD8EMmXvsEQc/nMUl0H3NYEzSZBHMGRdveORE7?=
 =?us-ascii?Q?wrbUV7Sn9AvgZIgEbZ2zqui3qBopt/P8d3OF1hgZsBCQrcCmFiQicM1UZWg/?=
 =?us-ascii?Q?J9g4DfPjEUzX0u06j/KOEieDsFYiq967P0qLT2Wja2z0IcHnn2W4CLTr7KB/?=
 =?us-ascii?Q?D4jpA+OYiA90TNyJ7hzX7vQo/LQO+Od5tdzartRDmzBmY7WLTgnOhvmq7YnK?=
 =?us-ascii?Q?+HiHRJRUaPJmLETM/pBIg45YEijoJnVUgA/8DQMV5fa+jyO6X0orQfWXyxix?=
 =?us-ascii?Q?CAG+SPg3p8uVVJDeQGN0DIEDESd5ciLj4QDTDfkpm33pcJ+V1LXu+NrUdBoE?=
 =?us-ascii?Q?7myTTR5+VDvGG0EPCA/bUWj+uFSwOZR5fD4bCc2T9XGzc680C+uX/3Fpeiq9?=
 =?us-ascii?Q?u2fVQFZ2jtdF1tcL+AnB0nQ+H5VklSORXDe0sFONq+mfRzU3PZbvqbYomcHu?=
 =?us-ascii?Q?H6ggiTB/Ngx9AW93YkXPWKe+DrFNqDjdEv12AQbM5IaOUpR0rLWb6IykspKi?=
 =?us-ascii?Q?sLdNK11akmx3bSIJpU+X9voX/sZpAtltVfVuUW23?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c651e0be-0f9e-4b5e-08d7-08dd9d0451c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 09:53:23.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sa1Pn2Jmd8tQK6vdKfPgLOHdjPHAIadxJTIw6uKAjIJ3OtlQCpl7T+wgvjkW11rcNy9C962e2POkhJrIshCXwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 27, 2025 1:45 AM
>=20
> On Mon, May 26, 2025 at 02:40:33PM +0000, Parav Pandit wrote:

[..]
> > +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> > +		blk_mq_complete_request(rq);
> > +
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> > +	return true;
> > +}
> > +
> > +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk) {
> > +	struct request_queue *q =3D vblk->disk->queue;
> > +
> > +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> > +		return;
>=20
> can marking vqs broken be in progress such that 0 is already broken but
> another one is not, yet?
> if not pls add a comment explainging why.
>=20
I missed to answer this previous email.

It should not happen during surprise removal case, because surprise removal=
 and remove() is serialized operation listed below,

virtio_pci_remove()
    virtio_break_device()
        mark N Vqs as broken..
   unregister_virtio_device()
        virtioblk_remove()

If one attempts to unbind the pci device and once the remove() crosses the =
broken check, and after that if the pci device is removed
(before existing virtblk_remove finishes, then yes, same hang can occur.
Such thing requires an additional time out handling, which should be handle=
d separate patch as new functionality.
Since timeout handling would be additional, it won't replace the existing k=
nown surprise removal case anyway.
I anticipate that it will likely reuse pieces from the proposed cleanup() f=
unction.
