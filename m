Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133A3D3B3
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557239; cv=fail; b=bfIwlFIwRULCNDsfkChReoieT3s279eNIgNg7u6/xJc17Y/5rWtpvVyF8gTVPuK9/6fasQiu1f8VSkyYSOC5FhAkuCMj/IVi9iIMvsilAJ8qDIg4uitHyLpapzeQPUogev9oFB5GW8oe2HIPg9C0ugJ6hqtmLX40q4xR5rSBbdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557239; c=relaxed/simple;
	bh=AvKa2O52R6HYUkiUbkiFcUFMLmrbfV6s5Wt8jEHzr4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYE7786wXbvxpLJPIqWLh3+FTpHfMiACFD52xh9Hmngvqf0EDHdpN8iz0osYvMA6zWvVk2STTQijXX5V1cgA6h8YDWmkvD5kEfcT+6TgzEdNerD+mXhTYY4iMRhahL6Tnyxga92YNYoRjpUOEqOlIGeaGWFA4q/6MVhBW0AKpsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TZfA6Lgl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lcXffEds; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TZfA6Lgl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lcXffEds"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709557236; x=1741093236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AvKa2O52R6HYUkiUbkiFcUFMLmrbfV6s5Wt8jEHzr4A=;
  b=TZfA6Lgl4mWLnvlXbcSbZYfVTJOWfwRIP4kqXoRU6/bgXZYO5ijGt6BM
   0pS0MAX06NSJ3YBHx5RYtJwpkrx3MC/rN88znG+D36uCXC9btimBpTXXk
   UW1GxKoos9gU/t8RnslQPJzwatP3OjDfUPfFO8OAYjCY05bds17nFL5Fn
   KzA4xHVLvV7c6qC8JnYcYHvrZSJ/MNSLlNMyJ6ZgLF4zp7HwhU3bmXoZs
   Zd0oU7y0y61o1lc+ykQ9B975KUyzFwhQAVIkBFsPpn3HmfH4wJFpoUGAM
   IY2VE1jJtXce0kjSBp+5gj0WhcJEBsYGP1ojhpD1AextoblKdED68UAMF
   w==;
X-CSE-ConnectionGUID: Cl3RUgNoSWyFe5q3nW65YA==
X-CSE-MsgGUID: mvQKLVd6S5KxqsaW0AIJew==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="11338616"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 21:00:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYVIgsqNuhX3LMZ3d2/ifIVfR4MJUUTmRFRdKQD6Q7D8qwvcEQMvmZeZpQNq0xGb4LkyqMRxI71ZN5aMZnWUBCokaBv8WLPNsTM4rlI2CA0RsZqfdqKuF/vFIW5VONhMrdfM8ChmNLZq3bnOX8PHHA0JNHuZKGRiLvHs83KtNL+cOILpoRBlbmIC79rsDLIsRF57rOKdw2uKvQBkLp3v3eNniuBtNPDflfwtBLOkJz6001xqeznyPSZqMvuvTn2u8Cy60b3Qc6Ijteh8oPLmSxkKdwDOtZp66iX61QYV48xKMbuQ2JTChmSC6inWm9eSBI0pyVQUn89qI8Vc9SNUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2MvNsdcT2JHsDhmQxIt2/XXLplAaGDqp1IxuxYvFDg=;
 b=WqsdtL42oFBGCaUKaOV2zSvb9T2soiQJxVxEs0N0Hm3R+nYI1ejh+sFzkN+q6wu7vsb1LTkPbIEwaUsUdxf+t4eWZnXrIQEcPJiKnDv9umo6ilynIihIjz5J1INvOXnIJX7ixJQ/DWdW/qXF407DCQ2RCEP82qsedeYk9r32Or/HtN7N8jXC8M8MEKJiIwOTvNxtZuiOsGAvcEA+NkXcwJfpWPtCszCuBwWuGewIWvOFLKLqSAPDs+JculhlfXYsTMEY1qksP66AVER1rHG6TaOU1jlV/LglkQ0RweJLKPtcn6Kgnt9mT/Qr2w8v53syUWNamgwFc22viCkiIx+4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2MvNsdcT2JHsDhmQxIt2/XXLplAaGDqp1IxuxYvFDg=;
 b=lcXffEdsd0ShmJ6p5jZM2ANpUbYlEh4G++CCYqzzsxv/CarH9eKxDax+pUxKUXZSwnwjcQPg0lnWRq0mWEbPIkJbVUps2R7818WX1X7uDlQ9td8gKiRUxHmunlzIDuclMNDmcGYlPqLynIr0NWXsUZ7hFr/TF1vbgU/cf8NwZKY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7171.namprd04.prod.outlook.com (2603:10b6:303:64::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Mon, 4 Mar 2024 13:00:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:00:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Thread-Topic: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Thread-Index: AQHaa72fIpu5hQooBEylaH/67MXItrEnkGUA
Date: Mon, 4 Mar 2024 13:00:33 +0000
Message-ID: <3a3st4dkvw6ejizsfhomxyodssb6eyrbauzsv37a3anwrcwafo@v7ras73nknoa>
References: <20240301094817.29491-1-dwagner@suse.de>
 <20240301094817.29491-3-dwagner@suse.de>
In-Reply-To: <20240301094817.29491-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7171:EE_
x-ms-office365-filtering-correlation-id: 86fa8b3b-9fe0-4382-ec2f-08dc3c4b1404
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 teNLq58LlEuncpzBtILfvrtLo4yu8cXN4yXHbmaBwOrzSC4A6QqEvdkJA1RQtUqvQYDiM1ktoodj+10OiPREdRWRUDzWsgTT99LS7bsejtZ6Dat3t4s32yEoIpIZhRWNpXSjXMTsV1ZL2xxMRrbHyFp+DlO2MbaA7fIp6wFXStRlnh6aGY/C/Kdco/Q7be8li831Rvlhxd/43DgHJIFdZxPyNmISNA9bUkJvjap02DjIu+wIlSk/w8XLkbC9JKLyUqtqoeuSsmAKXHGSRpkajiaTfcUkGHn00fxPv1fKnLvS0AjckoreT0Jgc9/9mrkwD/kKaMZwMBYQUP1T/G5Dk14NwfdgCcA6/Z/hLoRG2RdZftw2WIuAdIE7ra+AOWN0UYeT1OJVuD50N2sZdwiaRUlPrG0FXpr25dbCauGUQTXSv24yenCqkeVQMVDhyzQNMAflucfZnaMzvCbDF+H/FHsbVDPNEwTXb/daJID/fNMIvvaApT2MKMPCX3Wy2FBO1ovYg6SoREA16Zm+uzqtSsSf6WRdT1UzjddyQ7UPYuF/cBdtjpByv6vLXf2bP2NP7o4Lsd1pekZ0e2byfCueJS89Lf3GFyrI12Rm7bT4x/yI2sy+eqXxdbrDO49gAEowu6iPAS/Cie8s7fd3nxwj4nZLc7+bcTiCA5GCsO6LIT+feBk4L4wZHdOKWq7bG5cD1MDNQ2M1YnR6NwPuxw3QlA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ezz9ZdLrDdsOEcmWfxzWpAHDTaOBhVj9NAihb/+JWSGA9hjUsXyoY1gghiuR?=
 =?us-ascii?Q?BIh9hLyUtBRSkySRasfQEM1HUkMF4Hi6hGhsJqQxbCW9efyL3CA+IX1ZKt79?=
 =?us-ascii?Q?MV3hxPDYn/a81EHLxNOoTMYd9G76xU7R3EhpX6Hkb2o790oJMrZwFbdvMil0?=
 =?us-ascii?Q?sEg9hgyYWKwMkq0o3VtRbFkHquVVSxjgmGffu+I0ghIn/XSp7O8fHUaOW0ed?=
 =?us-ascii?Q?Tvqm9appNeEzQi1RieQHvNz30PTTpGXIci4GZQl9IQDDZIi418kCppvpessO?=
 =?us-ascii?Q?kWWGC3pwqY17z6qVpdGyGBvyHVcEvzm7Ra/m08Do3mAa/D8R5BtEzFbsaKo3?=
 =?us-ascii?Q?tZja40ke5TeURG744jPvdA/e+rTUMC3LH91JyVclkKn58A7q/mC9FC0tLIYV?=
 =?us-ascii?Q?dSF7Zx/QK7l73kKgc+vbLtmghgBaxnvcQfkcjYEZPq9/e/p6L2xMsVM+7mip?=
 =?us-ascii?Q?cqrB4+x+uEHD1BVXZtwdiBwYTLbjG6zD4/RjtdKVFOem/cAdXBwyZGl6EZeD?=
 =?us-ascii?Q?dUpeC1oN7BAEA7Vn8jmelzND/O6NeUcHE1EFmyIQCzG8pn/fjHSIVDOIOXV7?=
 =?us-ascii?Q?AFQMUsrv9mg8u/OXBUzvLGlGzrtXxyzo2T5AMqNvKcgdWd6lYCMHphr+uenW?=
 =?us-ascii?Q?BQp6CIYLCGigkSvsZlT4uUw4SXNbyVnMl8XpXnv/Wt3lyDHoSydg9QzTS8c4?=
 =?us-ascii?Q?L5Fe3thfjtUJcH9iSfh7d/J0J3JocJWGd887BIHVsuPxPEd7r3RTWXVd837C?=
 =?us-ascii?Q?Xx88KHKOmEZdWv3gEP1bBiXjguEKOkRnEX27od87t9HwGckMJEHGd8Nc94VO?=
 =?us-ascii?Q?axAwfdNowvcYCf7U4Z47tK9wsaJjPwWpsJ9svlVa5L1AXbUQrhNhWm+JgJ4O?=
 =?us-ascii?Q?FDtCGDyN0DscV8JRp1DwTHX3tNspt6pQkafxYx/5R8RCsT1IEW3Y2HJ2jyqz?=
 =?us-ascii?Q?hxLBus9pbzh2ixQU61is6resj7/zrSQTTUdEq6gqop6GXkA4pebWH1LFGrXs?=
 =?us-ascii?Q?V+eRK47y/xuN6XDMS6gkTQDw4Qqpg6ui/uG4RfkGLc9Um/oxcfe6C9uvbYGJ?=
 =?us-ascii?Q?3W6xx646FDVnmbPCgTFOyHHLL5HjaacJVJ54FdYwhP7hLggHml+CzepaMbD8?=
 =?us-ascii?Q?szQjYo8Wba1FbEaRP0G+d8uUkn6LHsVIGcST3CD3dnIZzKHBilDBDEifFAZV?=
 =?us-ascii?Q?dicLklRY5Z5+xuE+oKe+mKsmuKHwwe3r7FRf/QGmyDhPMsorP51NgzNH9h+K?=
 =?us-ascii?Q?Tosz0oHWD99Ljp8HqDbZ+eY6k9i+NwPJud25mXOFn3QMGgqdOvluGH51769J?=
 =?us-ascii?Q?kRh827jLIoMLmqP31h3bDHmbQsTdOwB7S8biDtuOnf/M6By1UMv/9HV9zlVN?=
 =?us-ascii?Q?f3gTgazTPBrzKrdtEO68zQN0sxXN30tYHQ9SsX/mjLabh6WsVVpf4VNgQvAf?=
 =?us-ascii?Q?mmyd09FAB7uZqF+1kDcTZuodY9Dr4v3zNqF0w5cZWiGteYoKkIm7NhvfZu8S?=
 =?us-ascii?Q?YubDvaY2M/IIw93YAL34thZEbbHnZjOVAZ9JV+nt7kNT1JFbN1jloUWSs1uH?=
 =?us-ascii?Q?gpZRrJ9F5L2/am2SZFcmYCuFJh6FJcD6n1LpIOLRbUTWH/SBwJ1SHUKj6Z0K?=
 =?us-ascii?Q?lV7Bo7qcnXGJSQ6lyXnul4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9FEC614884BC7418803A1E94A4FF766@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AXs5YUVOhNhvF2Cy2ivHtUtS8eO8yMRLt22Xq5iEjxUgfQngXnVhV0Cu4LvkL9wPyOOA/+j/5GIMEcWlzSNBv9lYEcWwIrzvwcuccjwEsU356nimbZI78vc1pLkgPYyB+/anJVVuX0CZ4oCVk3fp8EeV5iHG9Vtsih2V/yZu17Z3bRMOUhpActPOH+1teSEK0b4Oy6VlRGCII6xBjkk1X2stNYlcA8hFsKwT8ueOKpIBzuCtYveG/dldBf46BPf7EqleAuS0TkztKj0OyR7nxdZpkt+L2oQ6j8kE1DtqQjmS174zkomn6wwn5RZaoZgAgVr5vhxZzKUPnA3raZyjkvtvAMOtJcXgiQNJWxPEAEgs2e6mGfsXUECBtB41SVKeS6/TdXZ4lcA8f+oN862KwjEo7KCy8MQn5iGf36v8LUl3zK8dxbivv7E/ThrjZSgHoA8kU7rWhlzDkr0hHQ2LPGMeFItFo7QwQI3EYKT+Wx3F3KkNZVzAZKGY70mTV+s6tTFjJgBidDOIS2W5DBUZAXVFF5y+BICIC+m9U1T7wwjzuEwKcZCbSFhISDezQa5go2mehU+Z2rhDkf/z4J4OfMrUWH8rPj72U7EKmd5ISGkZrL9WhIpIJWFEAJyv3hid
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa8b3b-9fe0-4382-ec2f-08dc3c4b1404
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 13:00:33.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /deFYZCHRLPlFvyKUwS/Sc+6jaRM8xB7FGFpXJObfuMl+6Q9hDIabXS+IcR2Q6o+o3Cml0O6CzFrwIkOJ/FzHvBxZiDrvCNFvJ1Xrn9kMBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7171

On Mar 01, 2024 / 10:48, Daniel Wagner wrote:
> We are racing with the reset path of the controller. That means, when we
> set a new queue count, we might not observe the resetting state in time.
> Thus, first check if we see the correct queue count and then the
> controller state.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Hi Daniel, thanks for the patches. I did a trial run with fc transport and
confirmed that this patch avoids the nvme/048 failure. Good.

Please find nit comments below.

> ---
>  tests/nvme/048 | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index 8c314fae9620..3b9a30bcca89 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -47,11 +47,23 @@ nvmf_check_queue_count() {
>  	local queue_count=3D"$2"
>  	local nvmedev
>  	local queue_count_file
> +	local retries
> =20
>  	nvmedev=3D$(_find_nvme_dev "${subsys_name}")
> +	queue_count=3D$((queue_count + 1))
> +	retries=3D5
> +
>  	queue_count_file=3D$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue=
_count)
> +	while [[ "${queue_count}" -ne "${queue_count_file}" ]]; do
> +		if [[ "${retries}" =3D=3D 0 ]]; then
> +			    break;

The line above has extra spaces.

And I think the break above can be replaced with the echo and the return in=
 the
if block after the while loop as follows. It will make the code a bit simpl=
er.

diff --git a/tests/nvme/048 b/tests/nvme/048
index 3b9a30b..d6f3e75 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -56,7 +56,8 @@ nvmf_check_queue_count() {
 	queue_count_file=3D$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_c=
ount)
 	while [[ "${queue_count}" -ne "${queue_count_file}" ]]; do
 		if [[ "${retries}" =3D=3D 0 ]]; then
-			    break;
+			echo "expected queue count ${queue_count} not set"
+			return 1
 		fi
 		retries=3D$((retries - 1))
 		sleep 1
@@ -64,11 +65,6 @@ nvmf_check_queue_count() {
 		queue_count_file=3D$(cat /sys/class/nvme-fabrics/ctl/"${nvmedev}"/queue_=
count)
 	done
=20
-	if [[ "${queue_count}" -ne "${queue_count_file}" ]]; then
-		echo "expected queue count ${queue_count} not set"
-		return 1
-	fi
-
 	return 0
 }
=20
