Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0F241E4
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299883; cv=fail; b=qkR/oiu9LY0wR2poFldWbdfudv2Ik8dbW5hqm7N166vLT0Y7fhff1EoWum4yNet3i43Ybq0i4ZPzadWAV7QQwN6UF6ytkwH0jj9h8w130VQUMZIdhDTwqJnS71K3UtnVyOWGR28cug63dD3r77RkuIj6Chk0bEt7ROq4qnrEqQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299883; c=relaxed/simple;
	bh=J9D3XKV+gUMXQPe9PxzLqNwuoWZ3KBYN+Z5gyimhPQ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p8L+tZWrlZUS1B8wkJEb0Qns3FVs6OrNKx1bkjPg5T+Rgte0Me0Vbv4YT3pkcZd+iKss3OOGrN2KeOLMxftigcImIAzxrXzD6auiyeerNsGf5hGoJHm0/85xS9hXy8ZulvXarXiU6ps2TWy77yjE0K62O/v2DwIb//RvgK2iGgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QWuET2g7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZJzztQgz; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QWuET2g7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZJzztQgz"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707299880; x=1738835880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J9D3XKV+gUMXQPe9PxzLqNwuoWZ3KBYN+Z5gyimhPQ0=;
  b=QWuET2g78Grk8JMUBI2dz4CyRfk2maE83/mXtGtgHPbAK5KrVVer4nZv
   3D4czaxGF7DD0maqed2RjyblR0vQww6NpcCZQ3YrcQMWuz7MCVawRD2L0
   7/E+Q9zdLjRXj8exBkL1ATK9YZT7d25NjpVN3nVQtJn8LCMhmJ4Z+kIwn
   /Vek9iEBEqCR9hGoPQuBc021i6L4Mx5UPyNeHn6fhoBQCCWApFXiubsh9
   nywW0SJRlBwxJko6RtGVhdEBjwN9xR6OOvh/b5srQlWtJ4nKe5PkXhSKQ
   fxGQvErVuSaoMmNt7nJbidj+UKBR8kUvAWtVSPbuK4kGqlwPl8vSKua3S
   A==;
X-CSE-ConnectionGUID: ZEuMDAmDRwSL2KU0/EFEhw==
X-CSE-MsgGUID: ft0zkHBiQIOXmkwydInIrg==
X-IronPort-AV: E=Sophos;i="6.05,250,1701100800"; 
   d="scan'208";a="8698874"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2024 17:57:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBx07Q8+G8NDWq9LYck2vfLqjI9IWDIJb/2RQL14AenPu1zItWlDpQJ2TxwVsR4KG/QIZIe0qsJcB5TOoCC/ETTz+bY85FdyvH3fDEf95dbuAYuuK9aMEly+B1Hm9xwOrvoWeKN0oL5YB0zXLmajSISzfOfFO4HvEgQP+Z/DcuyuYGWpioi79hlBs8l01DzzfmX8+1w3l9e1BV8HuM8FVThFFHEJGfsydgMXDrS6i8B03LfY5qAMX7+1I32vfLh6BFtjDo8fhRA+UxAe6t5UvpKtVbpVcdSusamb3hbLai1tmxu+ejOahBlxH11bW5k50QNZKVo9fmbdPI+TAN7/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tkD/inzXB2ZgbKqIoG3Lpl/e1i17HHgwH+v85dhtTA=;
 b=HmLBhZ6uwKh8V7l1z2KQv3TPO2M6bFoH84TTX7XxyExBxz9tVoxJcOF0fMFbXIrCiF2WPeLv50kGFLsHPzcbja+USWhD4p9YGNA/uvPq+8g56QJQcLjCDx9C4ml909uHcifnaZXPqoXYYtgzrog1zf0orZpqkW7mPzVhcyfyIl3wUGIXOF6kPOdGktx6kb1T8Zo9MZEdnGqL1vnuNH0DO9TpvdCjsgC7mm0p+ZLSbA1ICnom6diMnLzLdePE0P7+Bk6Jnw5EGOeNdOlYLcehLQJDazhp5j7xeXMrAlbZwOkAiuBHhe1iGcENJDZeAsnkgcNqCUXub+20GvOeEIVDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tkD/inzXB2ZgbKqIoG3Lpl/e1i17HHgwH+v85dhtTA=;
 b=ZJzztQgzaGWVK1EXwGtd0pAySUxZf67I4xwGUkCEDFCyzK4yxJtcrYbRaBO1dgV+F/5ZQwsxx4OCnUzaNtGJlXBlO9TrOJp+aPqynVMOwtfSh+laNEI19pf2FAjyJM1oZvtqgxJe+7yEqzJQvyNQ++1ATG++YXdLdwJ977jLNvM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8468.namprd04.prod.outlook.com (2603:10b6:806:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Wed, 7 Feb
 2024 09:57:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 09:57:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 2/5] nvme/rc: filter out errors from cat when
 reading files
Thread-Topic: [PATCH blktests v1 2/5] nvme/rc: filter out errors from cat when
 reading files
Thread-Index: AQHaWP7Nvt0mK58cNkeBf9wvmC5tgbD+pjuA
Date: Wed, 7 Feb 2024 09:57:52 +0000
Message-ID: <xrfrlceflyrsyxbifn2y7kgi535md5t4bamgx7n43c3ngkigsf@uzzoyyf374j7>
References: <20240206131655.32050-1-dwagner@suse.de>
 <20240206131655.32050-3-dwagner@suse.de>
In-Reply-To: <20240206131655.32050-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8468:EE_
x-ms-office365-filtering-correlation-id: adbae11e-95da-48ed-57dc-08dc27c33fe9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nG67g9gvEHiw+GqSt/LYPy8qRXLAvcJC15b7P5QjAXJKgPe/Tcf6v/Uf8J8DiPy34d4SKMSo5+KgTcPdO9WcMsooxdBgi29XTwRZj1Qv/2e2zjp8RQDT2eg/IFSnisIsLVOe8A95OlkxGl5xNVeGC2IRlLmdL7IGVDKsAsPks8CSXNiHI4ocVfOHSCY6U1KrzZ2mhsPSIo72WfFCt4QXyWzdTLshVdIbDffXqbGk3BoErQs15BFsX/EYp0kvO7g+I9dzciMRIr7JH7pJ936h25v8B6uvPV/dF+f2e9pWyOziwYGew9MrTEf1lBX/1XRV6wIrq7vI0LF25GXM4II5mzN4/LOazOkYef0XjGpokh789xGuhZPvaVKp1RtLTBuU6EWZS3o97lgRx9oLsdtBoRc6pIWvIAkKOuZmAgSUB8kCo8T2EzMzBq8Xu90aPvfCJzq/JFB2RUw+Z4v6+lEnwSM4v9FnYJY28ONcJTHr4q9xgn6Wx6xndNtu2lg2ADvxbOI0H51TBWUxOb0LKhdNTqg8G3UVRZhuewfHsmSyzfO28Z/JPzGpPO5BE8TxsPgPF7hFskGk+oXK6Agwcr8GfyQ4sGSAex0ynyH3iWX/aMslhtuek4NKDSeUjjnzElg4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(86362001)(33716001)(41300700001)(54906003)(66946007)(64756008)(8936002)(66476007)(4326008)(6916009)(66556008)(66446008)(6506007)(76116006)(6512007)(71200400001)(6486002)(478600001)(38070700009)(122000001)(8676002)(316002)(82960400001)(38100700002)(9686003)(26005)(83380400001)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Q/Da1Qi5RpXb7oYeO6Cj0n5dp414eaHhBryQXt9FZdqqZJ+aJemhqe6hFFK?=
 =?us-ascii?Q?VAbQWkKOR4gbo0wWNo/5Gx3l9Zwgc4lPjbpOP3TGEi9dyT+HL4wCeXWMEcE9?=
 =?us-ascii?Q?GOXp9xQfv0MFbzJbucEVlUz5QefJ6H2vRfoAdyf91OgYR+5a5Tc653G+lj9Q?=
 =?us-ascii?Q?gSSstNc7ZzYuOP5x4CnQCq80aCynhOY7tAw0MpMT86vRce/9UjWCA7TJsc6X?=
 =?us-ascii?Q?xZyMKqKHANi5E1mUT4DeEUZIbMcdN5fQYLYT0/wdZnGQ01hDLABQu5vpF0Zx?=
 =?us-ascii?Q?7b0VL9DUL9qRF/O2GdPbm33zR8Q4b2GRsyssybCOhhSyjrI5Igjx99K1CWwF?=
 =?us-ascii?Q?/TP9hpSzXs0FpNpY07yp+gDeh/MvKhQzOtGatAIyNba9sv0iGouECgta7P+e?=
 =?us-ascii?Q?VqxZx1/pAILbhPAbY92Tc/yc/AwVyieqxNo77bZbHqGCRVlBtP+rcvD2bAZF?=
 =?us-ascii?Q?rJR8z+zC8aTUn3sacS3NEdFNf6I5h2gDEvMRydmi3Jvana/76IFWK6mug1ia?=
 =?us-ascii?Q?y6JTPzwOGB6EhBxoATLSp0GWWoEwgbdk8DK3zPTlPGuPJLPAZFSp69x5fmti?=
 =?us-ascii?Q?d2BIG2VrG5e6ITV5swN1XdH+1hZ90EP9KdSamNfOO9Bctzr4U1cF5qv905Mg?=
 =?us-ascii?Q?GKXF9NAY3/PhstqN0x8BJ3Oez1vHV6/5dfUn/JmpW7iy3bTxyEL/HN+agEJI?=
 =?us-ascii?Q?Rj35XkP1iIHg7O362ONA9dJgBLo5e+wzYuNqKYAFB0aEXoJSgR6CG1iSPP6S?=
 =?us-ascii?Q?q1UuZJqb5wxiwl3fVVB1rm/GdGzlA0nSllL8UhrLRSO2dmDFyvJqQVbsJUiA?=
 =?us-ascii?Q?NmHmbogIl2KcWTiq7jv7iEuHnAO8z2Kjqolh0RiFVPxRhj6EdftCwtzoFihv?=
 =?us-ascii?Q?ltBeZb3HMAWn/jbjrHqs0LuRTqVXaMaDH0JRnK4PcixJ3NsZf3FwqQlomGry?=
 =?us-ascii?Q?W1lSoltxT7RPTgf48ptOUsXu3UgFx/bQGWFEGgUruTX4FrbOeNvt2ikZbJuJ?=
 =?us-ascii?Q?fJ8owCXY7c72UCnsJIwAxJCxKvnGzzgKIDDUf/W2+GCEvlSPhnyviVkTYcy4?=
 =?us-ascii?Q?+ht+CkjlRdbnESzMPnXUSKlVbRe98grwHPTq0IpQ7iIpwe3OEbQfHGtq/gUH?=
 =?us-ascii?Q?7ZgTxx9wmTnT632RUc9SyiWXxs4xWiaf4AeMOM2u7AKGW1S9ZRRC7qDBWC7k?=
 =?us-ascii?Q?rZ5eWUdqduYzy+qSE2yg0k5+pN5CaJk07OTV2TdYFbGlif9Q/5nA95mO+J0B?=
 =?us-ascii?Q?mIvFGgh1tzGnj0w+TEe6dOvfOoJUchxOtydEZWiUatUrYXL3LgxMPkVdb3vM?=
 =?us-ascii?Q?Qt2OrsSOUoIY4l1tu7CjC/E4w/S9rpT1N5NHNgM1Dlx++pgY6yQjyn6uzLmt?=
 =?us-ascii?Q?VxpbrM3nMHEIyL27nI/PyEAJsid4hyzy4F4XsMB2ZiLkwrON45cz1P6OtM+i?=
 =?us-ascii?Q?lMq3rbODluGC5K2SyLmxvD4OPLR11GiUHio0+CF48msWWXGXVo3kd8F6GDgI?=
 =?us-ascii?Q?74hHNJ5S1dUOm2uMdTrK4SGzAmzlrF9LcqDgJPIeGlxFLOd7woXgcwKP/Hoc?=
 =?us-ascii?Q?PWbJ8/yckfPcEzKi6/AZyXpg4rNtwf2QCoUWxK+5hWWmU1DlaHezNDQCeUpD?=
 =?us-ascii?Q?DYByiksRO2yPpB3U25wAETM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B2E34DE5D61C540AD9751B656D0079D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N/Uq8qA6SY3+4bQfYaqVLz3GYop9k1t/XzJr35qsB3hP9t/Srxxk80AqBPmCemfGGJKaKUVC0Sqjpk+ipS8NdyoQnzN9harCw7Zn2vfTstIIo7824CX2KOj/GL5V55B7NYep3n+vVPFPVsAGSzFuGRY1zWDeGkERRf0gCrFYMdHtxfF9wz9kATG7BsJSTEv8fcp8U7erpCJviz86gTzAO9uEUY/Xlzx4nR7wrccOruWoc3YTcf268dqQA5JYRYUNf2lxgFsNSTVqOIIHXminE+0tC34C691EhN9xCjRSAkLsp1WGFLj4zWBLDfqmt+bflAvk/1M1z8b+FcihAAbnI71WSEAdPsXkDs39fta3CgxbZUmO2WkXgtaUKFzeKjQc5vQVEmdxZyeoKUCkv+IPFyRjyEwN+MeEeR5+Youq2mr2wFhYsof7zMq7GQ0vatAe0gwQru+ZscimJNSB7sdSlA/Sra5Uk3LSC36ABhypi4aEiny2ORLuO+CIKGZwiiqEAFc6vEZ1/vnS+zB3K+HwBFMHrcoHtG2bBCaDBgDmZ/cgiTjjV55TpYt9bL8JuHOBetmWV7Yn8jpDu67u69inEnWi/PpBnWb1v5CiuZ1k6vNfexJHzAQ7clB/Ch1rOZOa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbae11e-95da-48ed-57dc-08dc27c33fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 09:57:52.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWAhiqJX1JmdeVsULIa34V8LKmHzmM6idagoGjWXAHlPXgXo1gLasa3mniJRY07gAeBqVUAwumFpNTiqHRyVLuA9wfqqCimDfkD2nIUvgw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8468

On Feb 06, 2024 / 14:16, Daniel Wagner wrote:
> When running the tests with FC as transport and the udev auto connect
> enabled, discovery controllers are created and destroys while the tests

Nit: maybe you meant "destroyed" or "destroy" instead of "destroys".

> are running. This races with the cleanup code and also the
> _find_nvme_dev() which iterates over all device entries and tries to
> read the connect of transport and subsysnqn sysfs attributes. Since
> these steps are not locked in anyway, the resources can go away in
> between.
>=20
> Thus filter out 'cat' reporting non existing subsysnqn or transport
> attributes. The tests will still fail if they can't fine the device etc.

Nit: s/fine/find/

> But without filtering these errors out the tests fail randomly.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index e0461f1cd53a..9cc83afe0668 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -350,7 +350,7 @@ _cleanup_nvmet() {
> =20
>  	for dev in /sys/class/nvme/nvme*; do
>  		dev=3D"$(basename "$dev")"
> -		transport=3D"$(cat "/sys/class/nvme/${dev}/transport")"
> +		transport=3D"$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
>  		if [[ "$transport" =3D=3D "${nvme_trtype}" ]]; then
>  			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>  			_nvme_disconnect_ctrl "${dev}"
> @@ -840,7 +840,7 @@ _find_nvme_dev() {
>  	for dev in /sys/class/nvme/nvme*; do
>  		[ -e "$dev" ] || continue
>  		dev=3D"$(basename "$dev")"
> -		subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn")"
> +		subsysnqn=3D"$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
>  		if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
>  			echo "$dev"
>  		fi
> --=20
> 2.43.0
> =
