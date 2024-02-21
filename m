Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4413A8D8
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496561; cv=fail; b=HOkdhzHXkW0DDBiakoXjzVFVF0O8I+VH3+zQOTdLnC7RJMAU0DXy0Nv4Jt1j+bUafJf0C873+Me6tr9L6Edyx3cgR85Rx0iGadTA7wEt5qw7UoO6l/9avEE3cSolPZTbHvqZnzx+UrB1iPMMwYYVb+pMxgYxyVm7opUpsyLymCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496561; c=relaxed/simple;
	bh=waOxTjGjhkbRstVaHby/2XP7+edhTNEV1oiQNeDsNhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dRhLdQpKH++cW68pojz1G9QW7EZxmgycItP0FpiRNXYqXbmlEp3Xq29w3WuAee8gaYskn22Le/YRSpvdPATg0oSc/BpTq7R17UVM4cAEPzkbhqu2Ib4ZKqV3HX7nOYpkZA28FQApM9o7EPzPs04ZD1nWfvgpKdQePrFjvbqdGmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jfiWsoMK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qugjaa8A; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jfiWsoMK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qugjaa8A"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708496559; x=1740032559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=waOxTjGjhkbRstVaHby/2XP7+edhTNEV1oiQNeDsNhI=;
  b=jfiWsoMKE8ruFkZSNXYbhcHFFCM5ZXNNqhavAGYUJNV7Uzb4GqQYUfhf
   wZ5hfBxqQkqumwHHztpXiAWZgEFdvaVsBmcTdaD13dz87dAUWU/rC0g7i
   LMISL+QS0b7wN2Ugq4GiD+iRV07szg/kh75osgNu8jpRb9gWV5o7BVXwT
   tpe7jbwBBtSMcYwpKdMdpwiBZdhc9CmgSNfzGqCYuSVtBIz3NhIM2p7jL
   /WsbfDcNsjw50gdzJRiq+09FM1NXC2x4GOaLXb0QuOPLJgPKaU/dK2Ou+
   utXmiibXgahYRh3STYW99afK/0cf/l72WCLTZgiZaXL5XOyy+3ImadqJL
   A==;
X-CSE-ConnectionGUID: wreMWQgqRrCwu7uMh21ffg==
X-CSE-MsgGUID: S/GJEPBTQY+9+CJbZiNg/Q==
X-IronPort-AV: E=Sophos;i="6.06,174,1705334400"; 
   d="scan'208";a="9407270"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2024 14:22:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmtrabi70Sj3oIxTkf/08U2/WnuY5DFrhbimlKgRpINEQtJBiQ+XacTNXrmfBGlhqvo3F/vqRcUT9G3O7yjVauYvitWhysf5gDEfRuygkg0PoviZkiFJR7v+a+/IfcbrbAtDuxsp5CujcP99cKR1mlD/YchkOsL5aWL4h9buvfXDIAijx8h+c5OHENGsL5g6sT11svCSuWRRHb3fjeGPg3FF0wBkhsIVMh41Bsx2G7LncQbVP2mM9zxo9Qk/ug4k3zsCBRugF5/N63zfNHTOBDuoWyILV0NnVSYjr8W854td3scgTXF301eufIbs8MP9M5HXzy3+NPbMFWD6meOLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk7HKuaMYrJmm/FgycgD9cJQ6ZFvarC9bgE2aK4q6+I=;
 b=iTvaRnNKc422IX6Rg+UDENdbiumKMwxZiXn1WT3wOkjBfRgSaO4MGc5nfqSHFwfyrHWJULObnsVIbqowoAoiIDgPoI4PXP/AjDftgdmr77DpMeYNlnoy7oQDXaU0y5loGyd5EQiLyRiaqk6U201j9GtUT/GqD1S/fi8R32lqwEMuzWUEI4mAKvm72jxIlT6L9J5keO73Yp5OESplcmRlRhf2qcYakhBEN+vLL5xfpN64Qgpc5qTFAoH5zU6DvsnGMoX7EqiObf/q4J/UWzKYQZA4Ha2cQk7rTQz3r5qWrPB7ehzNC+VzL4SQjOrolGgvSifQIqPxiBmVLqfJX32RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk7HKuaMYrJmm/FgycgD9cJQ6ZFvarC9bgE2aK4q6+I=;
 b=qugjaa8AGGln7HsJpzFjIOHuurVk7Ta3obpd4mjNuiPEOq3vx8jTx2T+WzNpSlSdH3pOG9wtXO0D4Zi1v42SwGk9TuRXPAJVXppGIY31YS3xUOTJXdtaxZCfIySlSVaWpUbv2Nhew3nbxN8QSBrj+VvUdEZV88gQH3nSqnagKJw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7208.namprd04.prod.outlook.com (2603:10b6:510:b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.34; Wed, 21 Feb 2024 06:22:30 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 06:22:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Thread-Topic: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Thread-Index: AQHaY9S2AHNMpoi2xkO7zJ/1Iaqj87EUVQeA
Date: Wed, 21 Feb 2024 06:22:29 +0000
Message-ID: <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
References: <20240220081327.2678-1-dwagner@suse.de>
In-Reply-To: <20240220081327.2678-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7208:EE_
x-ms-office365-filtering-correlation-id: 722d8164-8cbf-465d-2183-08dc32a57b42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7g5sXCnQBLtBW7LHAXwyn74OBJuex9KfTypIR+xDd6GwJr6CvwQgemyboQckF2p9dhQiD0W6j10XaTpon7LwmE1QwPjdUHrlhh2/7pXgP4aVfeF2nnh/8kwpKLc0FuK0H1y8mxUXkL/k2/v+P64T1huUPYqPHH3aiXIQ1R46WEvs+sWYr56mT5sBZOrF1jGnDUmqo0UZqeCNv3kuiS1RgxZ5ZOwpq7x4y+636mX3xTFw5tt0ZXMC5mEkw2XlvghDpU8qQDJLALmdtWJHT2cwJ5RMrhSdy+R5UZ0tJqUyoTInzNF48ofEqd+pXDRhJBG4wIjO8FJ4zYillkx2llS+34jYa0Kh0fMIuWFXnJPcMNlbsIRujncPngyRpbtcfG4LHxinPCHdJPW7frxgtHpAa4FkUsatoMqlLXgLbZpQexl03D0c4bQIkJnM7E7C1H/Rx+d+vXEvxX6IiFaXd99MRKLTyWmIHj/JqjjShYhIX+QwJcxWMaqbsrKAXJ2md8JIqov3aZM6CAtuj/O1UebVjLxS5BEXjGS+JdvSg7ckiMgveebt9hrGq6RSrTkQBaMSyEobcsv7qPOVUAO6xM3xeBh9k0cusy7CGCc9XWb9UMU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mLq7Uyc0OXc2IFsrNzhYoB6Kv2LBMlWnpDGcMaFMN08CuS0qTozyYwUoEtCi?=
 =?us-ascii?Q?sj3wozkZR7GgbottsBhfbRh/C0SKS0t9Gy2XQOPVzBK+ntETmRg59q+IByb5?=
 =?us-ascii?Q?77jI32TyqacmLemhGNVxki3c6s3mhzvYlQfHRsgvSMX4XIUkw577UeNyy0EQ?=
 =?us-ascii?Q?JZeVCx5TvcchFaCgKpOmra1A/pvmoF/Ygl/vsz/xzP4kfPeSlD/6P6vEVxde?=
 =?us-ascii?Q?FZX/GgDbFDXWoYX+iP55p+DRTXmPDBAVr99/KDMFFjOm2dKmb76b1d+Zvda7?=
 =?us-ascii?Q?nrauPk1zF0QW1RwlAQw6hrc8iYhUH+Bsc97TZ4wddP5Gl28iTDHTFmj+H/3J?=
 =?us-ascii?Q?fdh4mgmywoztOt+tVpF7VupcruPRrGpH0AbREggYjkDbn3wbXbCfgABU8wiQ?=
 =?us-ascii?Q?chFGnGwOKhk/sjeieRWnuRWyuYWF8V4IM6PTIaeKg3iJWTLrg9zJF4H7qyTY?=
 =?us-ascii?Q?OPoSEnt8SNFIbyZj7x8/WESj7DVuUx5YvvDTIj50C08QxxlQ+58x8Qm4h1jA?=
 =?us-ascii?Q?isvs5lRIZfkGfuuvzhGCz+wkQLnBK3+hat2msSaYG6i4p9Qes28Yls3prjFy?=
 =?us-ascii?Q?rIqI6w4Mqv+VbQXfahD3jkAyiJ2y2ElBJutY73fnLtAtyUxWjyQY3nhshIXW?=
 =?us-ascii?Q?R7HQ655ZeTIGqx30GJziV1q/rQbOrK0XwSQH/1Q8I4pL1nu03VmuloppdJw3?=
 =?us-ascii?Q?0vV6m4JKpeZ7E2/CuoMMsfbzji3AelxoWcCksH8bxaaNDVIKlYYNfGc5naZ3?=
 =?us-ascii?Q?fl8rgs8fRetChVprTKOGRBnxuf8cCVZZYPuGTR8dQdDjQEWrAvh0az61uqHv?=
 =?us-ascii?Q?wFo8si+uYj2PWQ7asv/8JtP+seifhyQUwz1zvc8MM1hjA/G4YVuK458Bjg3y?=
 =?us-ascii?Q?wQ3NWbhuohgWll9V1ubKDLEEfdoJLITwLLwCqF65tPKv5yb5448wNKu46tfE?=
 =?us-ascii?Q?KySzomm2ZS2RwQHJBtUZMrD8vruOuCQfCJDhacfb7YEMx69uvFyxsTHB/xxg?=
 =?us-ascii?Q?SuEFK4Hhtf4le4zwu11PXhG51yFvPGfJDJAF7RhZljqa3qKmFrivzrNLprzJ?=
 =?us-ascii?Q?jiPNY00mz7qQxAEAjum6Aevb1/LhoFm/s4KkywhdIu+8N1XM7+jbcTPyqGhB?=
 =?us-ascii?Q?pgPCH7AtdBa3AtptMIInbTqVQWNBcDOHKL8zkONQvyOboAZqe4ZkuicAVMAU?=
 =?us-ascii?Q?aGoUNkKicYcqjEGiBIqH/V0ui8FF9IJ79iFp9phOtzCMqdVXkIQ9j/GRBJNL?=
 =?us-ascii?Q?9Jh7jVml61CKCrRFkQCoaOVKaD+k3PQ5KoBLDcAm57312/A2wKQRbJVFgJYP?=
 =?us-ascii?Q?u2g3wcyAgOFxJn0kpiHkdPkOAG6fTWshddW8ipHrW7MK7YQSNyIfHRWIG3c3?=
 =?us-ascii?Q?+/uN7mtyxQ4Bwh1gCGnO0QZPvTSMHa5hiGsq/DFaebOpuxJwytSCe4BEbgmB?=
 =?us-ascii?Q?1nJ3hTJq2HATt+mra4tbc3CFp3AhyTqe/y7jOxLc5RY5LhK+fGaYLPiNiKnM?=
 =?us-ascii?Q?FLW99f2FNaeAWZpb/Qhl2AeKDG9wNelw+NrFrTeBEizzJIxjOcYK1HpStHB8?=
 =?us-ascii?Q?GfWFwIAgzi1YwcADwztgAH0D+jsgN1vTXPcJ50YOnG+vwobBELnP9lVZ66b5?=
 =?us-ascii?Q?ImrXLQFR1ayUe1sPmSLi0pQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB1528B2B1DBC644B1472EAC1604FB14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/GnRHczfrLNCIifwnlLTwIzWx0by7ZKmykBOfJaxWNHXlR8DPznhv+/XtzbAC9EoOrbT2hIc/1tih6mMqoF8ZKaBnontd1EjHiEA8H+7qXJw6pL7KDZanp1RiVPmhf+SD7p4OiWGugt7jSz5Z8uTEHEFxNBy0zm+wpHa/xCnf2LeNn2eU/96SC6HBPh4K26H1IE/LzBchHBQfkMXGAWYO/qcf0I/5R9E0YYkMdTZf5UtGcamssL4/2QXVhojZyhZxz1Rzlscde0nFizZkqkdYIkEYYsmP47oE5ld6ZkBHBSg2WAQcx80m/QDumM8z8Xy7mI1duxkOgaXzxweU1Eo1CNxX9LPKXLumn/2oerK23CWOpv9ti1EXxDZRTwxn3DTekSzlJE7/brlY0w0dpFo3IFtCgFY5+CbpFy4loTkrj5SP9OVAMq0FCLrgX4bypnWdUUjG678X6Cdm6/R4vANyzOSEuCFrmvIJiRO+pNo1Lo3h6syQ3KSNr8ekjhY2AyRdUo+HH9WPyN4EWYjNYBGJRgJdtBvmoxCTrQZKGI3+S1oFtPLWKFSb65MIcemldkY6a/cw6Mflet5hA2G7p+xVF/dq09x0Hl1QSy9swW8O6uzg1MwHEkXcc1hYPpplkvj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d8164-8cbf-465d-2183-08dc32a57b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 06:22:29.8344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/Y3xwe6tvd/sTm/qEn/djOhEK6hUXiHDw+t3GkwmQCu/uUJXu+BWoEI+ME7owNcmyo7LrF/pwdS1zFYjOz/9yIdqOGPK/oCBTP6O7uE0i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7208

Thanks for the fix.

On Feb 20, 2024 / 09:13, Daniel Wagner wrote:
> The test is issuing larger IO workload. This depends on being able to
> allocate larger chucks of linear memory. nvme-cli used to use libhugetbl

I guess,

s/chuck/chunk/
s/libhugetbl/libhugetlb/

> to automatically allocate the HugeTBL pool. Though nvme-cli dropped the

s/HugeTBL/HugeTLB/

> dependency on the library, thus the test needs to provision the system
> accordingly.
>=20
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

I found the problem was reported and discussed in a GitHub issue [1]. How a=
bout
to add a "Link:" tag for reference?

[1] https://github.com/linux-nvme/nvme-cli/issues/2218

> ---
>  tests/nvme/029 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index db6e8b91f707..7833fd29e235 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -54,6 +54,7 @@ test() {
>  	_setup_nvmet
> =20
>  	local nvmedev
> +	local reset_nr_hugepages=3Dfalse
> =20
>  	_nvmet_target_setup
> =20
> @@ -62,6 +63,11 @@ test() {
>  	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
>  	_check_uuid "${nvmedev}"
> =20
> +	if [[ "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then
> +		echo 20 > /proc/sys/vm/nr_hugepages
> +		reset_nr_hugepages=3Dtrue
> +	fi

I found this changes makes the test case fail when the kernel does not have
CONFIG_HUGETLBFS. Without the config, /proc/sys/vm/nr_hugepages does not
exist.

When CONFIG_HUGETLBFS is not defined, should we skip this test case? If thi=
s is
the case, we can add "_have_kernel_option HUGETLBFS" in requires(). If not,=
 we
should check existence of /proc/sys/vm/nr_hugepages before touching it, lik=
e:

       if [[ -r /proc/sys/vm/nr_hugepages &&
                     "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then

Also I suggest to add in-line comment to help understanding why nr_hugepage=
s
sysfs needs change. Something like,

# nvme-cli may fail to allocate linear memory for rather large IO buffers.
# Increase nr_hugepages to allow nvme-cli to try the linear memory allocati=
on
# from HugeTLB pool.

> +
>  	local dev=3D"/dev/${nvmedev}n1"
>  	test_user_io "$dev" 1 512 > "$FULL" 2>&1 || echo FAIL
>  	test_user_io "$dev" 1 511 > "$FULL" 2>&1 || echo FAIL
> @@ -70,6 +76,10 @@ test() {
>  	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
>  	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
> =20
> +	if [[ ${reset_nr_hugepages} =3D true ]]; then
> +		echo 0 > /proc/sys/vm/nr_hugepages
> +	fi
> +
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
>  	_nvmet_target_cleanup
> --=20
> 2.43.1
> =
