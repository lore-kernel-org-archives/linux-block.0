Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F519047F;
	Thu, 26 Jun 2025 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908380; cv=fail; b=k6bIC9wKIufCmlNtOok6L/Jj4YAwbsFpnFKe70yVneZnr2joXZR5Qfpq+USGmRITc/+3ZKg6cMDRfY5WAID0cqAM4S5kSo8AzuX3lI6qYwE2C8VgfYHH6Lo1bV9OJl0eXkUJlwnC/q6ScJ5Unvqc28NTwu4LjZX2T260H78oGBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908380; c=relaxed/simple;
	bh=kmgeTJHlwabUZmCwRvuQULYi9Coektn4a9WwTEzbeLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0gIfmGL8UrEpKs9+Z7TyBgyKG4Te8hD6o3+IAreoiibyOlUIEJAwSZV+UeQUY5IfsMsOkTrS85uqk9atozaV19SNEY5LuSrA/M+Brh9O0JzB/86I0Mch+gY2esiVAKYGYPO9tPZybXY3mdrNHdY/jv7XyowHRqkPhf2DsPBY0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Un97zclr; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Un97zclr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL0718KSyPoZM5RdMw6qDMcTPPVADt/S+vQeu3uWlDSEPAwbBbotkmXWJ8UpwfamJoK154yu2AFblQ1KR34l2iQKF35UaRKpSwOokVbU4cT4Mf4aZ3xQNBPcA65ak7uikC2HrknR2O6wKtdxlx7eNFM3Q9I8LTkOq8DYTpbGcaFRpzZ8JIJfc0x0IzpCDyT1XhsyMi1gdtifMZZfvjuw9W7CtD/hwDNKUsBJHWWH1JlJyn9KOk7VPUjfMDJl8nzbwbVt2TNMKRQp0fvr2B6P4Sfe1XZ7K2DMX/JYvlj0/w5KXjw0Tm9qsOWyINCKBg7K2/uYGSL7OL8/adQVWxO3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZpXeUSfb5hdEr25vG1WAdCwBW8Hj12sU43N0rKHtDc=;
 b=FafmOmzASlAkt+6ZtiMYZy0XnWfYQhqL2uSJQ6jLZzatg0NzhujTgHPJEpNvnW59cGO58G2pQ0DG/hrt95pWgIMee7OUc4+pvj/KyXWNxGxll1KCDmeUbKXYFZt8lnAdZEEquPTc/GPwqRwyyorX3xLK7R7WKrQ6UQvLlBjp83ooN/CCq2uCMMPbHNT+KJgNdtOxV/zrJMNjL6PR1IoXFK+olc+7GdZvE2EQYSh++pw5QyIpBQVjdTncF9VeucPbrPtD+JYW5azAALC6dhyajFnv5MFQ8q7Xj6A8qjNFNS/8FlkfeiExGIQ5oAxpwe7Gd6Grsl4fLK09n7v0Wb6u8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZpXeUSfb5hdEr25vG1WAdCwBW8Hj12sU43N0rKHtDc=;
 b=Un97zclrEEa77w4crBD7OhetoScrTxw/TVUxTWR/xaNQLcn+7+FPOXRWS/L93AoE3PaDm522rNeZH8YhlnkWBS9RYSEBA2m2KlIdTV1ipiRaaoW8pxI8ZiyorMZsDeSMgTZ3gks+Htj/zI/5O1QHPi1Kd2v7RcMpeJQemALrdVtA8waRTZC/HIG5ezw8OBqtg7btuWMM1K8kGJcWgcUWk6JKPVQxTKc7QJpgqYIb4fQUQ7m2bds6iiesEEV3vwsuu+3gfsgTEOytpGD/oVbvMadFIgGmPbsG16FxGfwC6lyGdOrnVJqyE1FV1tehkBFQNn5N+L2k8hhthmo2ANzsKg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 26 Jun
 2025 03:26:12 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 03:26:12 +0000
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
 AQHb02hI8rTGAA49eUeotBFzOHU9FbQSzIkAgAAAcqCAAAJ6gIAAARbQgAAMIgCAAHNgsIAAitiAgAAAT1CAAAsNAIAAeh/AgAAFwYCAAIZBkA==
Date: Thu, 26 Jun 2025 03:26:12 +0000
Message-ID:
 <CY8PR12MB7195D92360146FFE1A59941CDC7AA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250624185622.GB5519@fedora>
 <CY8PR12MB719579F7DAD8B0C0A98CBC7FDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624150635-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953552AE196A592A1892DDDC78A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250624155157-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71953EFA4BD60651BFD66BD7DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625070228-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195AF9E34DF2A4821F590A8DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625074112-mutt-send-email-mst@kernel.org>
 <CY8PR12MB719531F26136254CC4764CD4DC7BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250625151732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250625151732-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH3PR12MB8726:EE_
x-ms-office365-filtering-correlation-id: bb75099a-69c7-4fa7-97fd-08ddb461339c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ed5deVvvlDKlQSkZQHdbciyjuVxvJEgbDF4XW+wIPiny8Hz6ouq7Cg3dss2K?=
 =?us-ascii?Q?JyRBG8ICBY1ELeBsVSDl1aKukaCDekmx5t+XDLpV9s+z9XKQlnaDJdJcJrrK?=
 =?us-ascii?Q?lnyvuP45W5VhNAWSGJ7OdNl0E+ZV6y5+KcQNq+qb06BmQ+s04SiRF4NqC+Pg?=
 =?us-ascii?Q?p9D/DaSjHHnC/8MmynTmupY3P9yOQYZA9BmVA2bES8fSXQf0B3gyoTKCuX81?=
 =?us-ascii?Q?cijhECotosa5e7MKsP2Vgz61vkdW7xxjnozG4PHlBr1YUZPnSsxs/F0+jdtm?=
 =?us-ascii?Q?htKJQNO9buqKX1jlC6c+dL2U/+S8HZpVpDZEFERQyNBigbAZcggs35C5iAtF?=
 =?us-ascii?Q?2j81npcGpHrS4rZZFl/q6PG3qlcBdIuw/gMf5E+nEzvgL1fPQ9rUIBIUD43l?=
 =?us-ascii?Q?F0cOMDMGswVlMsAcn4NAxc+pwO2xSgu5MJ9DYNEue8oFOWjZK2eFbLEhPloN?=
 =?us-ascii?Q?kkuvpLkOYJhdmgd33XL8Wa8L99cQyeCN6G8LfzNF9nCF1OOn1xKp/du/KETy?=
 =?us-ascii?Q?cjAjxYeM7zlm99i0IoTQuxPutl7YbK1uEnQxrI/N+BkhmRVA/l1boFRZmNJn?=
 =?us-ascii?Q?nn7uvojyg4oPycTJ1JPiGgdO58OOkUJFCXsoSEptBtHmeqAU05uiiFTHos/H?=
 =?us-ascii?Q?fsOVUKgVYuXjgu44HclhX0bCWvuPuHSZrCrqd/SBScqIiZiFy/MR7p9QovQV?=
 =?us-ascii?Q?O0BDEi/sYk+aaxrd+OB1XWM8tdMzQ4bbcEItmnROzS7THbQLqGShmPnkAKyM?=
 =?us-ascii?Q?e73baO7/O1GznUMrr6FjzcGa6DligS7vBUbe6sfBUrstiEHIUlpKRkMOQxfF?=
 =?us-ascii?Q?u/IBw1wg0o08RTCWSs0vj2TVwHrJpNFQm3aV4ML/Ec7dIRp99zLGi33/z+jD?=
 =?us-ascii?Q?lXEFZt9sPltwWsEjbqPLVCRPcc2S4qJrnUN55GdILavwwYqtwBVLqCRJ63wP?=
 =?us-ascii?Q?Pp1fqNoMxtMlAVL2koDPyuo6yJismfUPoIC4gEauduOR63lwIMmdTGm8Hmkp?=
 =?us-ascii?Q?uZHCPh/Cad7R5vDBvO37JjzCEYJj9lS/E0fTALxILaYbfdMF3TlMAMC3cqE/?=
 =?us-ascii?Q?bER5MU6YpVvKY09IWgLwc8VI8pA+8VGU8x6R9n9ksaUR5vI/k8tdV0itkBpt?=
 =?us-ascii?Q?DVK2+gPPDgCXZ/zxPwcl+IWDxKjiRJ7k8x1+A/G8w2CWWh+7FJs1M1dFBY5G?=
 =?us-ascii?Q?OrXTgfZnrM9b6aYqodmmNz6+nTAUgABL34kbha2JV8YAH+C5uvTuf3rlTnlr?=
 =?us-ascii?Q?NW/+Vdxdd7ScPwKHiWqamVUDnl8EDyJGAK+b6zQQNDmnoUAM8XaKSEI2du6p?=
 =?us-ascii?Q?sKibOFlv+ETszI4yTY9YEOFrCYNZy4pO1bg27SLd5/bR/TUapvWCdvUN+mef?=
 =?us-ascii?Q?L8sjEMEobRZY15CyulzUwLXLpx4ANRqhnr8rAh+N01R4ZWQrtV465JUxuqa2?=
 =?us-ascii?Q?VtZ6eHqoQkyXV8dBlluepYVraU510Yg6QtkhfSFl97Uu+//nubIPJMpVoJNT?=
 =?us-ascii?Q?zWS6iuGW9JPa4UQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xxg1yHAW3iIeQ9qYsu3pkXX3XAVRJIb48oc57Ux4JaRFDvBaKUVj1iNJFh0U?=
 =?us-ascii?Q?ZVbq3bf/iDzGM+QzugqVSvR1uRs5UjRaiLN604ZBOzJFeFQI+ocW71Zv5wbR?=
 =?us-ascii?Q?HCfA2yQpIraN1WRktITBPtQls9x+NvKUzHeJkHib4izxWBXWfVXxDc+gW98m?=
 =?us-ascii?Q?+x+cb73zizo0cNOf2YF5duQe/17RMGF32Fomh0WTWNAUljPofnnOcKfx4slB?=
 =?us-ascii?Q?JKnzzUlYbbre49Tc9/tGvnA+ZK/aLOpE1ElrondZi+bFwxgaGD06PDIovx1v?=
 =?us-ascii?Q?QAAhj/xOF7vbBTcZMmClY7layKnaCS32cFxcsASQNTUDYX4Cp8h1jg/3m8DC?=
 =?us-ascii?Q?gR0Tw5GYJRvgAlv0O1AuMUzJpYYXvo7/ddZYA8HVV4119B6chjLw3imV9QDW?=
 =?us-ascii?Q?ksJHz82KG9MJopfyZxQvJro9koEHWR5WiQSm86rJBZ2EJ7ZIbwAO6DaYDC08?=
 =?us-ascii?Q?53aaiQwjsuadHMjhHXN5kcTfE57LoStQhWyBux8UKz4TLF/LiLLl+5/72JsY?=
 =?us-ascii?Q?Hc77cva0vAHncj+i+9E0PCoJVByAIjx4/9w3SbWwZl5OYRZEjZv7ECvkDVOU?=
 =?us-ascii?Q?BA91rW9d7A8DageaB6tLX1S+XQiHCh4ecCoBPVlkApLDziF5Dg32M2r6uubZ?=
 =?us-ascii?Q?ynQ5BPw9UPaPGyb5nhv6upseRyNdjYdtRmL8Q+PoFBN//ASsb+NcZvJeFaTh?=
 =?us-ascii?Q?k/20b1khm4k9JwpGwj9xxuqBmPpNze5XPQ/4blzxo4Nkis09DDvYY6b/yq6L?=
 =?us-ascii?Q?w5BWHAMkO4auCLxgbd6Maq2w2kTw+/pOdvyF7hBXMXodhK+zFvraffeVEkhq?=
 =?us-ascii?Q?Vbv6AXTm+Imt8vDPoeg1ztGIyjDLUfLCzzzPWGJTL9jey4LMxdjj+Hse1YOM?=
 =?us-ascii?Q?02IE8RvZvPbY5PmhJjaRSjJJAibNm9FLll79zGN5ER65ClLxEqklfAz6lHD3?=
 =?us-ascii?Q?iCcTkjzLNkMW3oowP/ZIKFh8ElmHkYQhx4g9UlXX8QfmmFXu33ejsnt4Qx0v?=
 =?us-ascii?Q?X9jrcrYe6tGiRcIDqNgxeugGXq867k/ysQR9VD7ybCxTMQOFbQHw6VZO8Y8w?=
 =?us-ascii?Q?sM4/9q9PZTVm6V6zBvAnShP1Cd2UP37ikXd7jBAKj1XDExSbHjyqSNIndJ18?=
 =?us-ascii?Q?+hN7jKLuzPRAIqflniim/Vugq+KKK0wh0ksUf4WXTfx+IQBPGiBZi50hEvWD?=
 =?us-ascii?Q?Qt3Se9QLfmyYV/kRnqfSafTpRqARofF24upgwxH9/7JswXsHWoi/Q71pNNwo?=
 =?us-ascii?Q?JNRv8LtWQYsN3nKufP2LA2IuYgoKOMPjXuTWMQ1nYxoizkptkYNxB9qw/GTo?=
 =?us-ascii?Q?7uw5WEdOKO5aXkxbzJrffnmrvnylKohdSMXnsFYeVdmG2Zc3vzs+orCBXWri?=
 =?us-ascii?Q?hpOLhN1/qE9/Hbt1XQUsgVHZi22nSnZF5/crZI0ocZD5F62ghXSfRbRIuicB?=
 =?us-ascii?Q?BcpvtxOF/kmBH3ub8wFN49XWstCxSLYsShUPUIZB4O0H4Yu0QLnmX26FE6Wp?=
 =?us-ascii?Q?ThJcI9pvIWZc0GdQSl5emLOcFpNOxT0TBEZFpVnNVs/k5Rk4IoCfBMXbWfN5?=
 =?us-ascii?Q?qsVLpNGUXG88EVUEMxM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb75099a-69c7-4fa7-97fd-08ddb461339c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 03:26:12.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ISTcSAFJQWY3+7nOl6k+5r1UhTUVJcp7i0i7hiobJkkgCepuCkM8zyWBT4iSG0TUM01RM4k6m4YB3Lc7ZObRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 26 June 2025 12:52 AM
>=20
> On Wed, Jun 25, 2025 at 07:08:54PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 25 June 2025 05:15 PM
> > >
> > > On Wed, Jun 25, 2025 at 11:08:42AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 25 June 2025 04:34 PM
> > > > >
> > > > > On Wed, Jun 25, 2025 at 02:55:27AM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: 25 June 2025 01:24 AM
> > > > > > >
> > > > > > > On Tue, Jun 24, 2025 at 07:11:29PM +0000, Parav Pandit wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > > Sent: 25 June 2025 12:37 AM
> > > > > > > > >
> > > > > > > > > On Tue, Jun 24, 2025 at 07:01:44PM +0000, Parav Pandit wr=
ote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > > > Sent: 25 June 2025 12:26 AM
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav
> > > > > > > > > > > Pandit
> > > wrote:
> > > > > > > > > > > > When the PCI device is surprise removed, requests
> > > > > > > > > > > > may not complete the device as the VQ is marked as
> broken.
> > > > > > > > > > > > Due to this, the disk deletion hangs.
> > > > > > > > > > >
> > > > > > > > > > > There are loops in the core virtio driver code that
> > > > > > > > > > > expect device register reads to eventually return 0:
> > > > > > > > > > > drivers/virtio/virtio_pci_modern.c:vp_reset()
> > > > > > > > > > > drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set
> > > > > > > > > > > _que
> > > > > > > > > > > ue_r
> > > > > > > > > > > eset
> > > > > > > > > > > ()
> > > > > > > > > > >
> > > > > > > > > > > Is there a hang if these loops are hit when a device
> > > > > > > > > > > has been surprise removed? I'm trying to understand
> > > > > > > > > > > whether surprise removal is fully supported or
> > > > > > > > > > > whether this patch is one step in that
> > > > > > > direction.
> > > > > > > > > > >
> > > > > > > > > > In one of the previous replies I answered to Michael,
> > > > > > > > > > but don't have the link
> > > > > > > > > handy.
> > > > > > > > > > It is not fully supported by this patch. It will hang.
> > > > > > > > > >
> > > > > > > > > > This patch restores driver back to the same state what
> > > > > > > > > > it was before the fixes
> > > > > > > > > tag patch.
> > > > > > > > > > The virtio stack level work is needed to support
> > > > > > > > > > surprise removal, including
> > > > > > > > > the reset flow you rightly pointed.
> > > > > > > > >
> > > > > > > > > Have plans to do that?
> > > > > > > > >
> > > > > > > > Didn't give enough thoughts on it yet.
> > > > > > >
> > > > > > > This one is kind of pointless then? It just fixes the
> > > > > > > specific race window that your test harness happens to hit?
> > > > > > >
> > > > > > It was reported by Li from Baidu, whose tests failed.
> > > > > > I missed to tag "reported-by" in v5. I had it until v4. :(
> > > > > >
> > > > > > > Maybe it's better to wait until someone does a comprehensive =
fix..
> > > > > > >
> > > > > > >
> > > > > > Oh, I was under impression is that you wanted to step forward
> > > > > > in discussion
> > > > > of v4.
> > > > > > If you prefer a comprehensive support across layers of virtio,
> > > > > > I suggest you
> > > > > should revert the cited patch in fixes tag.
> > > > > >
> > > > > > Otherwise, it is in degraded state as virtio never supported
> > > > > > surprise
> > > removal.
> > > > > > By reverting the cited patch (or with this fix), the requests
> > > > > > and disk deletion
> > > > > will not hang.
> > > > >
> > > > > But they will hung in virtio core on reset, will they not? The
> > > > > tests just do not happen to trigger this?
> > > > >
> > > > It will hang if it a true surprise removal which no device did so
> > > > far because it
> > > never worked.
> > > > (or did, but always hung that no one reported yet)
> > > >
> > > > I am familiar with 2 or more PCI devices who reports surprise
> > > > removal,
> > > which do not complete the requests but yet allows device reset flow.
> > > > This is because device is still there on the PCI bus. Only via
> > > > side band signals
> > > device removal was reported.
> > >
> > > So why do we care about it so much? I think it's great this patch
> > > exists, for example it makes it easier to test surprise removal and
> > > find more bugs. But is it better to just have it hang
> > > unconditionally? Are we now making a commitment that it's working -
> one we don't seem to intend to implement?
> > >
> > The patch improves the situation from its current state.
> > But as you posted, more changes in pci layer are needed.
> > I didn't audit where else it may be needed.
> >
> > vp_reset() may need to return the status back of successful/failure res=
et.
> > Otherwise during probe(), vp_reset() aborts the reset and attempts to l=
oad
> the driver for removed device.
>=20
> yes however this is not at all different that hotunplug right after reset=
.
>
For hotunplug after reset, we likely need a timeout handler.
Because block driver running inside the remove() callback waiting for the I=
O, may not get notified from driver core to synchronize ongoing remove().

=20
> > I guess suspend() callback also infinitely waits during freezing the qu=
eue
> also needs adaptation.
>=20
> Which callback is that I don't understand.
virtblk_freeze() at [1].

[1] https://elixir.bootlin.com/linux/v6.15.3/source/drivers/block/virtio_bl=
k.c#L1622

>=20
>=20
> > > > But I agree that for full support, virtio all layer changes would
> > > > be needed as
> > > new functionality (without fixes tag  :) ).
> > >
> > >
> > > Or with a fixes tag - lots of people just use it as a signal to mean
> > > "where can this be reasonably backported to".
> > >
> > Yes, I think the fix for the older kernels is needed, hence I cced stab=
le too.
> >
> > >
> > > > > > Please let me know if I should re-send to revert the patch
> > > > > > listed in fixes
> > > tag.
> > > > > >
> > > > > > > > > > > Apart from that, I'm happy with the virtio_blk.c
> > > > > > > > > > > aspects of the
> > > > > patch:
> > > > > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Fix it by aborting the requests when the VQ is brok=
en.
> > > > > > > > > > > >
> > > > > > > > > > > > With this fix now fio completes swiftly.
> > > > > > > > > > > > An alternative of IO timeout has been considered,
> > > > > > > > > > > > however when the driver knows about unresponsive
> > > > > > > > > > > > block device, swiftly clearing them enables users
> > > > > > > > > > > > and upper layers to react
> > > > > quickly.
> > > > > > > > > > > >
> > > > > > > > > > > > Verified with multiple device unplug iterations
> > > > > > > > > > > > with pending requests in virtio used ring and some
> > > > > > > > > > > > pending with the
> > > > > device.
> > > > > > > > > > > >
> > > > > > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise
> > > > > > > > > > > > removal of virtio pci device")
> > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > Reported-by: Li RongQing <lirongqing@baidu.com>
> > > > > > > > > > > > Closes:
> > > > > > > > > > > > https://lore.kernel.org/virtualization/c45dd68698c
> > > > > > > > > > > > d472
> > > > > > > > > > > > 38c5
> > > > > > > > > > > > 5fb7
> > > > > > > > > > > > 3ca9
> > > > > > > > > > > > b474
> > > > > > > > > > > > 1@baidu.com/
> > > > > > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > > > > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > > v4->v5:
> > > > > > > > > > > > - fixed comment style where comment to start with
> > > > > > > > > > > > one empty line at start
> > > > > > > > > > > > - Addressed comments from Alok
> > > > > > > > > > > > - fixed typo in broken vq check
> > > > > > > > > > > > v3->v4:
> > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > - renamed virtblk_request_cancel() to
> > > > > > > > > > > >   virtblk_complete_request_with_ioerr()
> > > > > > > > > > > > - Added comments for
> > > > > > > > > > > > virtblk_complete_request_with_ioerr()
> > > > > > > > > > > > - Renamed virtblk_broken_device_cleanup() to
> > > > > > > > > > > >   virtblk_cleanup_broken_device()
> > > > > > > > > > > > - Added comments for
> > > > > > > > > > > > virtblk_cleanup_broken_device()
> > > > > > > > > > > > - Moved the broken vq check in virtblk_remove()
> > > > > > > > > > > > - Fixed comment style to have first empty line
> > > > > > > > > > > > - replaced freezed to frozen
> > > > > > > > > > > > - Fixed comments rephrased
> > > > > > > > > > > >
> > > > > > > > > > > > v2->v3:
> > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > - updated comment for synchronizing with callbacks
> > > > > > > > > > > >
> > > > > > > > > > > > v1->v2:
> > > > > > > > > > > > - Addressed comments from Stephan
> > > > > > > > > > > > - fixed spelling to 'waiting'
> > > > > > > > > > > > - Addressed comments from Michael
> > > > > > > > > > > > - Dropped checking broken vq from queue_rq() and
> > > queue_rqs()
> > > > > > > > > > > >   because it is checked in lower layer routines in
> > > > > > > > > > > > virtio core
> > > > > > > > > > > >
> > > > > > > > > > > > v0->v1:
> > > > > > > > > > > > - Fixed comments from Stefan to rename a cleanup
> > > > > > > > > > > > function
> > > > > > > > > > > > - Improved logic for handling any outstanding reque=
sts
> > > > > > > > > > > >   in bio layer
> > > > > > > > > > > > - improved cancel callback to sync with ongoing
> > > > > > > > > > > > done()
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/block/virtio_blk.c | 95
> > > > > > > > > > > > ++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > > >  1 file changed, 95 insertions(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/block/virtio_blk.c
> > > > > > > > > > > > b/drivers/block/virtio_blk.c index
> > > > > > > > > > > > 7cffea01d868..c5e383c0ac48
> > > > > > > > > > > > 100644
> > > > > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > > > > @@ -1554,6 +1554,98 @@ static int
> > > > > > > > > > > > virtblk_probe(struct virtio_device
> > > > > > > > > > > *vdev)
> > > > > > > > > > > >  	return err;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * If the vq is broken, device will not complete r=
equests.
> > > > > > > > > > > > + * So we do it for the device.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +static bool
> > > > > > > > > > > > +virtblk_complete_request_with_ioerr(struct
> > > > > > > > > > > > +request *rq, void *data) {
> > > > > > > > > > > > +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> > > > > > > > > > > > +	struct virtio_blk *vblk =3D data;
> > > > > > > > > > > > +	struct virtio_blk_vq *vq;
> > > > > > > > > > > > +	unsigned long flags;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> > > > > > > > > > > > +
> > > > > > > > > > > > +	spin_lock_irqsave(&vq->lock, flags);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> > > > > > > > > > > > +	if (blk_mq_request_started(rq) &&
> > > > > > > !blk_mq_request_completed(rq))
> > > > > > > > > > > > +		blk_mq_complete_request(rq);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	spin_unlock_irqrestore(&vq->lock, flags);
> > > > > > > > > > > > +	return true;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +/*
> > > > > > > > > > > > + * If the device is broken, it will not use any
> > > > > > > > > > > > +buffers and waiting
> > > > > > > > > > > > + * for that to happen is pointless. We'll do the
> > > > > > > > > > > > +cleanup in the driver,
> > > > > > > > > > > > + * completing all requests for the device.
> > > > > > > > > > > > + */
> > > > > > > > > > > > +static void virtblk_cleanup_broken_device(struct
> > > > > > > > > > > > +virtio_blk *vblk)
> > > > > {
> > > > > > > > > > > > +	struct request_queue *q =3D vblk->disk->queue;
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * Start freezing the queue, so that new
> > > > > > > > > > > > +requests keeps
> > > > > > > waiting at the
> > > > > > > > > > > > +	 * door of bio_queue_enter(). We cannot fully
> > > > > > > > > > > > +freeze the queue
> > > > > > > > > > > because
> > > > > > > > > > > > +	 * frozen queue is an empty queue and there are
> > > > > > > > > > > > +pending
> > > > > > > requests, so
> > > > > > > > > > > > +	 * only start freezing it.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_freeze_queue_start(q);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * When quiescing completes, all ongoing
> > > > > > > > > > > > +dispatches have
> > > > > > > completed
> > > > > > > > > > > > +	 * and no new dispatch will happen towards the
> > > driver.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mq_quiesce_queue(q);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * Synchronize with any ongoing VQ callbacks
> > > > > > > > > > > > +that may have
> > > > > > > started
> > > > > > > > > > > > +	 * before the VQs were marked as broken. Any
> > > > > > > > > > > > +outstanding
> > > > > > > requests
> > > > > > > > > > > > +	 * will be completed by
> > > > > > > virtblk_complete_request_with_ioerr().
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	virtio_synchronize_cbs(vblk->vdev);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * At this point, no new requests can enter the
> > > > > > > > > > > > +queue_rq()
> > > > > > > and
> > > > > > > > > > > > +	 * completion routine will not complete any new
> > > > > > > > > > > > +requests either for
> > > > > > > > > > > the
> > > > > > > > > > > > +	 * broken vq. Hence, it is safe to cancel all
> > > > > > > > > > > > +requests
> > > which are
> > > > > > > > > > > > +	 * started.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mq_tagset_busy_iter(&vblk->tag_set,
> > > > > > > > > > > > +
> > > 	virtblk_complete_request_with_ioerr,
> > > > > > > vblk);
> > > > > > > > > > > > +
> > > > > > > > > > > > +blk_mq_tagset_wait_completed_request(&vblk->tag_s
> > > > > > > > > > > > +et);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * All pending requests are cleaned up. Time to
> > > > > > > > > > > > +resume so
> > > > > > > that disk
> > > > > > > > > > > > +	 * deletion can be smooth. Start the HW queues
> > > > > > > > > > > > +so that when queue
> > > > > > > > > > > is
> > > > > > > > > > > > +	 * unquiesced requests can again enter the driver=
.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mq_start_stopped_hw_queues(q, true);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * Unquiescing will trigger dispatching any
> > > > > > > > > > > > +pending requests
> > > > > > > to the
> > > > > > > > > > > > +	 * driver which has crossed bio_queue_enter() to
> > > > > > > > > > > > +the
> > > driver.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mq_unquiesce_queue(q);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * Wait for all pending dispatches to terminate
> > > > > > > > > > > > +which may
> > > > > > > have been
> > > > > > > > > > > > +	 * initiated after unquiescing.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mq_freeze_queue_wait(q);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/*
> > > > > > > > > > > > +	 * Mark the disk dead so that once we unfreeze
> > > > > > > > > > > > +the queue,
> > > > > > > requests
> > > > > > > > > > > > +	 * waiting at the door of bio_queue_enter() can
> > > > > > > > > > > > +be aborted right
> > > > > > > > > > > away.
> > > > > > > > > > > > +	 */
> > > > > > > > > > > > +	blk_mark_disk_dead(vblk->disk);
> > > > > > > > > > > > +
> > > > > > > > > > > > +	/* Unfreeze the queue so that any waiting
> > > > > > > > > > > > +requests will be
> > > > > > > aborted. */
> > > > > > > > > > > > +	blk_mq_unfreeze_queue_nomemrestore(q);
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static void virtblk_remove(struct virtio_device *v=
dev)  {
> > > > > > > > > > > >  	struct virtio_blk *vblk =3D vdev->priv; @@ -1561,=
6
> > > > > > > > > > > > +1653,9 @@ static void virtblk_remove(struct
> > > > > > > > > > > > +virtio_device
> > > *vdev)
> > > > > > > > > > > >  	/* Make sure no work handler is accessing the dev=
ice.
> > > */
> > > > > > > > > > > >  	flush_work(&vblk->config_work);
> > > > > > > > > > > >
> > > > > > > > > > > > +	if (virtqueue_is_broken(vblk->vqs[0].vq))
> > > > > > > > > > > > +		virtblk_cleanup_broken_device(vblk);
> > > > > > > > > > > > +
> > > > > > > > > > > >  	del_gendisk(vblk->disk);
> > > > > > > > > > > >  	blk_mq_free_tag_set(&vblk->tag_set);
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.34.1
> > > > > > > > > > > >

