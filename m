Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88CD27D
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MTbCv7Kl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s09hm1ly"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704958476; x=1736494476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qv1WgY29622Unq18ZN3MydcYRcMR92Ea/vAFt1yCuA8=;
  b=MTbCv7Kls0+WHLo79v5gGarBYJPzBzxjuGMY+FfO8x+2s8vV78/TkdRG
   S9ijj+GVId12xCphpSFTcfh+t7JqkQyfz15u1TX1NIdyJrSiKF8zlgjxH
   NiK3ZE9l2T+WP3ieeYKd/Dmk+Hn18RLkvxNh44jsnfI2lBeFUJNUFNu4x
   1c/ws9yG8qAcW41nMoLZ33r/ZJt2sFhIpzVDDdEjnOyqxU0BmKYwbE3zd
   Qe8tNIwVNMB4yK442v09lfpYVit8mBDVVxfzs1XpKqxyLwzfkrwm84kPp
   lzWIz4Zn5urFkJgyPDQB9d7G2HhsGzy1Q8cUsIs16fPmkoLSNYYOMa8YM
   w==;
X-CSE-ConnectionGUID: dQVRTzLBS06GT+ILPAmmYg==
X-CSE-MsgGUID: mZrydFDMT06314PrXbZQ+w==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="6648544"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 15:34:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0pvYWQZiMlcL2SBST+UzlkncNQQzLqnnaTfx5RGVvJKxNM0z7STbaGsX7wHzq5MHk0myJxY5iyPjvCOipXpSN4msorHCCwahX6INLajEaUovSYPSMl+knFE3NJ2bu/A9f/B4XavrWA/oMrNL1r2CIR5X/cRXrxMdCE/sLHg2+QSqfPLNNUEAygYiGua5i/i7EjROW5a0IHZC9ACO8Q4A5OuCGOcEGl/WCmuZVrciWXdk1/KTQ3C7U+s1x2o0A9zxS+5Ryi0stHcparRrwz+LPG+zWa0cwJ8/F+ToGufGDJ9IIYJuxwNmqgggnefqugRIvGdKJT+aH5EXf6aeztf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJRx6cES9PDpQynlgqTSiWg0B6lm34LL328f2c2wKP8=;
 b=m+AYkncYnffL8C95MPPir1AU/O3KnC7a02AP8Cbr7Ml4ItKwUAhYrL3Ea/uj6qsOIKe2ns529v4XIU7lmbXONhX3IzyRzREP4mbZPi7n/qzvLlU/2ewla3kstazDITUSibs2SIYnl4fEaKlYiZVa6QS+GoMDwAnWzvxoVlgjRlijNHUcqjp36z2IJW7NTnhHakWhl4VGYrO1b7DRinug4RijJl9nLnAIA31xp126qE9wDWCbx83CqYPcGqlmYWb6BkoOXMTCMYbu3oxedudD6UIlwB9d2+a8FEpPmNr25IIfpf9z5feV7BiHinjLTZw/B2W4T0AWml33IrlqP2Tttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJRx6cES9PDpQynlgqTSiWg0B6lm34LL328f2c2wKP8=;
 b=s09hm1lyc0CgMMIdl31e4MYdk8neF3WsxJyDD+GLhZBwUioliE/V1Wai32o1gfXhZl+eaEhhdU1spYjiCcCUu+az1RsqCKcqeZEh7ytzTyV/40svl2EPBarTxo52ZU9CBkFHM3YP3aLiCO7UNddUImBBPGSpZ9R4ewX1JBcCRKc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7497.namprd04.prod.outlook.com (2603:10b6:806:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 07:34:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 07:34:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Topic: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Index: AQHaQujnpRNH2s3KN0GoD/i6keHycLDR7HKAgABkg4CAAQQlgIAA5k+A
Date: Thu, 11 Jan 2024 07:34:32 +0000
Message-ID: <4um4kbbq6nt3xrustk7z3n66g72aqhox36hooosaatn6lq3xdf@enmy3rriqrkl>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
 <4a6b2848-7792-4e11-9fc5-482b8e4e020b@acm.org>
 <7auicy62muu22xsd3adbvrljq3guvbdzgkbafxva5du45jli3n@wo4f7f6ut5eb>
 <f64d4219-5265-4cbf-b955-f72106f9e760@acm.org>
In-Reply-To: <f64d4219-5265-4cbf-b955-f72106f9e760@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7497:EE_
x-ms-office365-filtering-correlation-id: af3ca8da-65aa-4092-7d34-08dc1277c100
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1H+Zf4wdIieOpe4V1sk3fNQ+TdFci3G+/hBhAYyQJc60eyu4ceMlcXtJrQE11tnYyDk5k+PAu1L2uPZZKJNz+4NO+mo+Y0FvOQY0ziO3SlK1CjSHvxIigJWMwIWp8tvWsztgw7O23Eh44oAQSoaGqCdMs/b6dnkerz9yqmIMkQYjjxXzJOWFl+6nqQXrJjJdb9z4mnfgyow2cehE5l4EIrkjrdfB+6UhiSgEjl01XEtGkVgh9wCXGcZLHmbIkKSrk5n4S9e/1RgTFVS0XKspHx1oXMH7mF43zxLXhjizrLc0XPRqkIm5VpyXpbz1lP+m8gga8YMek7XHVXM/pLHSQJcnAz37C/6QstCYKaEwBHySCZpJ8Ebq18zZK+U/DNBMamY8Lcc3NqbjBG43bmuTCPVhTCEmydwydq/vyltG1gpLwVWVgQGjhbke2Xj5XQ724K0F5WAL+VN7a9ofM9qNvetkJlxEhpFvOIoSfG7nd/Ky7Idz2P9MMcefOC+4r/jQ4TNfbR1v3fiHNqVywxUJS5h5cJ4AWQh23WDgkTaV6x2LXLnJSRyvUV/12rwZVBmbGilJ/PI/9L5skCZzkSGVFWFRZUPXPsbALAJuCAO//rM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(6506007)(478600001)(6512007)(53546011)(9686003)(26005)(38070700009)(122000001)(38100700002)(82960400001)(86362001)(41300700001)(33716001)(44832011)(76116006)(91956017)(83380400001)(5660300002)(2906002)(4326008)(8936002)(66946007)(6486002)(66556008)(66446008)(8676002)(64756008)(6916009)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nhCWIYjFbWqvfqDgm1uK7h1iuUyuT/azx22CWqDx+zprZXk3BNgGrfyFHari?=
 =?us-ascii?Q?JRez1+S0TUR0xV8+PS1cKxfBZ7vTMsl0o/F2YDltRLujJeiGBHzAEwk3lsk2?=
 =?us-ascii?Q?lelUwQSQTDmnKx29A/c7ocJ6OSXrY16VXOkG1URyY60h1f5bput89CqV5sMk?=
 =?us-ascii?Q?LGP4fK47eSa3FLzJbo1EbGOh2UDOJ4O2FNbiCHSUlEb3xrOxwKpscypU7qiO?=
 =?us-ascii?Q?19HnqMzsW9f7hi9FGqr6wyYRZvlGQH3UJOV511Teiq7P9RLhvyvO/QcFZ3BH?=
 =?us-ascii?Q?CTzHUMp+8ua0XnSI/QpoQS8Nq4agmqj6TTgKpCKTqt4XK2+Kx7XCzMAKFdPY?=
 =?us-ascii?Q?A9yoU6nD0fKf20Zs3CfAy5E+PKbrtgdG+jNk2KM7VJWdOHYtjBdfWhpiIFtB?=
 =?us-ascii?Q?txcenGwtj8pVqVZ62awwsZaShWTVjQscyO/DX4WiD+OP47+hQS3KloYYDHVm?=
 =?us-ascii?Q?EoDlM5PjzFZwK8O4izBFd97v5Scva/pE0CHKfWpQGCsuXbchGcGv6oC/qLdz?=
 =?us-ascii?Q?19Pu7fPnTvlpMBXBqqXLrcldVS85mOdL6UphIc84JnItZ7bQw+JDIJDhodso?=
 =?us-ascii?Q?a2twEcmfFFUU/kntKrbAFzIt091FKo/Nc/UY9RhesrdThGr6dYUTpw4dafac?=
 =?us-ascii?Q?zfBO0Su6ebLlL1jUqCpaOaS953ZrQuNSKtcklzR78CeaSRfTHebd2z3aDr1g?=
 =?us-ascii?Q?gbkjA6MBmYrzztdv1ahmvHVB7lfx/Nj0Id94mrz9oFDtE6SAbxvpXzGiLwpC?=
 =?us-ascii?Q?ErYP1xNWaU/izWmYpYpI8PHkXo29dl5tAMq61MoHBUcvo2E01ffKX4kiqiYj?=
 =?us-ascii?Q?l6sKQ9D71tv9o0TorOBwSq1fnCJsWvIqkNgOaskD+tI0zvdA14uVUS33RqZK?=
 =?us-ascii?Q?L7SIEX9H+TgP21nyMf6oR8dWZOwPJcGYmrLTSVx+SiXws+Xsk8xeMkTtj7XH?=
 =?us-ascii?Q?+2w6XeZ9CXPc1EMpJ915fBRh+ec1iOy+rjTgjk7h0THNWDsDodMNDbWzJZ4f?=
 =?us-ascii?Q?YjVB8fc0ORHq8VeO32YnU7SYoo1cTbxmfRO1ZMAmPDU9Lc7+WiSNUIVoflAS?=
 =?us-ascii?Q?dzEcW7jHqc6BgRN1s2iW5NlGEws24faiII9cARC7EG+ue9EamGGvvjFa/vUJ?=
 =?us-ascii?Q?KKtgIoM7fZWdDJgdr8/PKrr9Vyq6PpEuNdrNpHuSEGxBHTLomZh2sbXrBqQi?=
 =?us-ascii?Q?9YQbg3L2gdsaWloXfZQSD/PY6kjGWZxQBhP+JgRXkCd8Ix+K7W0hJt+BvWKb?=
 =?us-ascii?Q?h6pyVn3MqHL5Qhd/YhIe5mkdNryID6Os8aewIzeHwlFga+Zaj76dtg4L9EpI?=
 =?us-ascii?Q?GbdpRFP1zEnOVzSg3UMmHBM97jefQ+tOMCdM9aMlVbUcyuKU+iYu8mHySTu1?=
 =?us-ascii?Q?rWHHJiodde7MkoapIIkOFBupjfUJSfuwkyp+ZBYhYrDMrgz2C2qVtUeJg3Mv?=
 =?us-ascii?Q?jYLJxsLD4I9/E3TRBZVf51U1k+sTkEDLoz2fS/nf1J4CmKHw9mGm5rYXzGbn?=
 =?us-ascii?Q?lyzInULw6SKoBuK2D4/gxvFkG1Op9pznsoR6XKOmU8s2GLI+bqnBuWfLYogC?=
 =?us-ascii?Q?9KeBl04TQiBMIoqZoyc91PKJc1o6/NmLgm9hRUjIevoOOTRsdz9rqI8Sg0Uv?=
 =?us-ascii?Q?SBV7wqBEs3U5RYwtXo3BJ8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <480E8BD8922F114D92DD7117CC9CC400@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	04qIcvM+PJhYtM0UYc6icjQsOyAm3906JFmfqVfcxLvvE9FIkSQMz8eBfOJJS8yNkOoHKlXBHZVGPLJ9PJOcF7pi3b99/crRnCD0XbPp2UglhQ2c4wDMKRFXwXOMkYA7kRUF4BLBXeSmd5xdhq2BZcy3dHEvwyY2tk671IgBlSOau/dNE/Na+MAhv1XWdcML0imMnM7fGzqGMDd0WIVsGs2djsNp12B4l/GevWiUiHQEB9hLoIXoE/JqqioJ1ATN8ZGpM7VlG5XJvQ+U2jDhsqFN7KxvJXLJIVv1v5SV/oLTiHwJDF9BjKZdR0xffd0tvrDXM6tbMssajvSiXjHhbIW0wkGJRKaMmFblhjAdki3KMqYZ3KpRm0fKIhI1WJSh76+lUx1rIdwySJT+Eb4Exrr8j0qJZrGac82Aw7OvOnr8er1erR2y30N7gt+ZxrxHlrV1x35nFmb8p3LdbrPa7GwdkUENuUrduYTNB8YXQa9jFfYkBixFDL8bm+bcpzfrqnFhg6eV66vYfD1+jpgoKtk7k760+Sq0zS/7iPQ1P+AmX/Hhhy5rZPLganRWTmMoFDNs8UH7EI3GuGal40Yl5CSXreMsdygtwDcNALNwLwoDyyv+EOHzf4sZolHYK0/O
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3ca8da-65aa-4092-7d34-08dc1277c100
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 07:34:32.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEBvyi2/BvR3Ffb30kE8ubDLQ5WFPDIAdecbQ7GUnrNPc2GpI0FNe7KJM1BgVfJA+ExBSJw6D3M5kqF6FkwT8E26R0giqNAC1kce3FUE/lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7497

On Jan 10, 2024 / 09:50, Bart Van Assche wrote:
> On 1/9/24 18:19, Shinichiro Kawasaki wrote:
> > On Jan 09, 2024 / 12:19, Bart Van Assche wrote:
> > > On 1/9/24 02:44, Shin'ichiro Kawasaki wrote:
> > > > The parameter has been set as a module parameter then null_blk
> > > > driver must be loadable.
> > >=20
> > > It seems like the word "If" is missing from the start of the above se=
ntence?
> >=20
> > With this sentence, I wanted to describe current implmenetation fact. B=
efore
> > applying this patch, shared_tag_bitmap=3D1 was set as a module paramete=
r, not
> > through a configfs file. So I don't think "If" is missing.
>=20
> If I upload the sentence that I quoted to a free online grammar checker
> (https://quillbot.com/grammar-check) then it tells me that there is a
> grammatical issue with that sentence. That's why I asked whether a word i=
s
> perhaps missing. I'm not trying to be pedantic - I raised my question bec=
ause
> the above sentence is incomprehensible to me.

Thanks for pointing out the incomprehensible sentence. The grammar checker =
looks
useful for improving my writing. I will use it to revise the commit message=
 as
well as the code block comments.

>=20
> > I think the inline comment above was not clear enough and caused the co=
nfusion.
> > How about to improve the comment as follows? I hope it explains why
> > _init_null_blk is called in the if-statement.
> >=20
> >          # _configure_null_blk() sets null_blk parameters via configfs,=
 while
> > 	# _init_null_blk() sets null_blk parameters as module parameters.
> >          # Old kernel requires shared_tag_bitmap as a module parameter.=
 In that
> > 	# case, call _init_null_blk() for shared_tag_bitmap.
>=20
> That sounds better to me.
>=20
> Thanks,
>=20
> Bart.
>=20
> =
