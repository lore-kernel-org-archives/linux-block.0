Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353479FD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099159; cv=fail; b=OSWiL2FOO+p9xml3DAXX/Vef9i6dcftMiMFoTIT+LtBUIk9IQtxHEc+JIQawWQHdEMQuGgiWUPMLbVFnaAqxwQU9k/0A8z7asSJEOTvIHODCgDoRm1IMDON4qnbUjcmkkHCb6IDeZbIijvbRjt6PC9TYUz6u+uJ2QEQp4r70cvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099159; c=relaxed/simple;
	bh=dBPyxTVUyDLYa/b8pSAwEj2R8ZAsZZbepw4UrwriKBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhVR1fdgINe6ne346cXKpwQJh1626IiVd8M76qY1ML4yF1hhLWS/zExLDvfXnauqBzmOYwXIgZbxhAtr+3KBsYCKD+2sZ+MLiygkBMI4RI4Y4y7Rtn8Zlrzd/2FWZGcPgBTiFPQKFBTaSHqh5YPd5s7Rgh2bDO/+XlZmuL7QRSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ep4atJbd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TmplQOaj; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ep4atJbd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TmplQOaj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711099158; x=1742635158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dBPyxTVUyDLYa/b8pSAwEj2R8ZAsZZbepw4UrwriKBk=;
  b=ep4atJbdc3WWvtyMNJh1ucgEPxwaFSVXQfN9wGrh1qvaaCP4VWFUO1QI
   JNKEmC6JEDYIzQ8OkwjVj9gzhocCq5uFii/zXDYBbWeJft1SFGTasLWUi
   tVvpQmcg5yaIdbf0F0iindTdubq/672ChnxdfP9hjDNLThq93YGQUn6z5
   W/lsgwWwJJgv3tOcE//paXEVm16MiXwS/Yx/6SxK39FovTC7uro8wYTu5
   J61ajEU1p7cclmgUFinop+APx+djF4W76XRy9GAc17Y8LC1T9U3E3v4Fr
   GJowKzifGrP1yfWQHRT2DATs1/bmgVX6/Z4HATCmViaxULrv3jZge93qD
   w==;
X-CSE-ConnectionGUID: tiUl7LFPQe6nZyUsdGp3zQ==
X-CSE-MsgGUID: eIM0jnwtRk635X0QfchSsA==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12061641"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tll+oxMoFO+Amk2TdKBrcKUlhGAI7qlI8EzZrcKb60oLog4I1Kd8fZ+PKYW+7WCGeJgYkHrkpupV9OIdH7YTnsBouw7GN2lycueL7Y2tlvHsw8EO5LApIKBPdiz2ZW4QBZF/629+UwpJX5tFRTok5wmn52GX2Iq97G3XBUsOV4qnjgZlswS4DflCQLt0GcyoKPnVB+TQUAtjFXCk7XyoSdW7J6FUn2ENM1s4cVmEeGoiLr04J+TmoAEVd19fD6/dcK64IBEoRAt1Cdkt6CbWr5oxxn2r3+kx3Qi+rADoks3xLM3aNBw+Fy8EVRxUvicqpuKWCjcsJyWu/ZfzDiyCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iziojUoxXY+OV9FEgNi9zRzdgyq1qlxnYAWxDP9kLig=;
 b=DJhIuODdyAG0wWe+R1KgJpl+fuV4SFSuOxK4K0jJazN/GH4ywVmXhpnllrXPLCUfaxdgSsHTTXD4NofoBACVuUi6daQsm7Qp7kP6UXgcgnTdi/1NBNhEwToscorPuZisyic+CmMzIV/LTYo0087GHev4APxICJdzihI+GLP4ZaUODN44xYv45xjtrOIWJgayzbmRXpN3SMub30QqF7fcRt5wD7bB9g13SFV392pZ9ixZ3vjDGP/sx5zshCHSUA1oyl1dQ/bXO1K1CUQw0Xd81r7FSlo2ZbO90LIPfdRO4xroPjFZPLmGYpMl7RmTjJkg7VBh1kBdUyVkyOxLPYQgXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iziojUoxXY+OV9FEgNi9zRzdgyq1qlxnYAWxDP9kLig=;
 b=TmplQOajcIef/YIlW385P6YYyI2BzDwlWo9hoVVSWtJMTrgCLS4W3GCZJZ+RFUrBHOk8Se7Pm++7qkgIW+O1FYV/HZsLErcGicxkYODf2Ie1+NKUJ+1VJCFaw5O9zI1zKtWx+2Ue90tb6vd0IljsZ/H1NqMQ7uinmllX/utV0Sk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 09:19:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:19:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 11/18] nvme/rc: remove correct port from
 target
Thread-Topic: [PATCH blktests v1 11/18] nvme/rc: remove correct port from
 target
Thread-Index: AQHae3TR4pkThNdNhEGBASg5f1ZDarFDfQ0A
Date: Fri, 22 Mar 2024 09:19:05 +0000
Message-ID: <zxctkf3h336lb2hnms64vfpilvwdnetolwxljjqndzzvmq2qjz@xflo5ceiejza>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-12-dwagner@suse.de>
In-Reply-To: <20240321094727.6503-12-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7827:EE_
x-ms-office365-filtering-correlation-id: ab4cb92b-dfb1-4231-1cd5-08dc4a511f26
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ElHnzCDNQ/dywzpQrr450pCRkFOf19bvcK7G1TK3V94gXToE6Db0J58a9nNTa2QUIFbND6qlTHZmLSjALxcP+f4aGPXlFRvs72iEaiFrMtCLoeRypJc9yKgGArkm5j6o+iRBAgJ2E0nYKk5F24lR179ERMwwMPdd8KMD3O/FWRJNEu0sX0TUv/00z941HwmtWodn8Wopcs55PM4DEFV1MDajtKdUpNlhEE7wZocwHHNTZdRI+C0j4Z8VjH9uMFHAbDI2yeWhUV93jhBdp0SUmoZQmBuqzDwfzFTr2O89ED/CTKxSXUjduV1Qv1xnKgyN3MtZD8VyVjHPVgm57yXnOUYHYqGlNX+D4BRkHvILza0yD9QDZNL3MxPoglxeci4Axi2lMr2jynCBmusaaj6QMiu7dffiN7eAcI/jhOC+RAsCSrVHp8G7kT+FPpfUIHUfP1qR+TpQ8SHYNrdVlXtsmsMux7ng1PX3aEFj57YTlvY9i8aeguR8WEssEVXuXtF+9hw70QOitm/PdX0v8y/cXkaLhmk2/WHWUGrCorxLoDjpeDvqQBsw7zZUtUTQ/kEXiwS6riJ4YZwLGRmYrf3VTqF1O+KwMxwydO8nuplNBPwGkJM3PJTQiMFL2BtsVC+4676ouNazS8lo2UsIT4CL7OMCX1yfYpz2DuiIreRCAvZQfG6cCb2Kp7LpKb+/QfMd9Ky2CFJ83lz6tDWbQuy7Be3bO+g77lzhTb6WREFpLbw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xmEQ9YAU5EcgwZMRlppCh6oL96haB2DtDVK41Qae6hbaTHp6zvlkUJlLcAbN?=
 =?us-ascii?Q?WSk5Ya8O6CiVXTgp9DRLfzbVwksw6FG0tprYWZKamehn0VgeQBnr3RtuOfcl?=
 =?us-ascii?Q?JIQgVlD4sQQqZOgotZ/C31ippgP4kyD4PTIne0TsspIf23uUJvc7aEF91tSh?=
 =?us-ascii?Q?pQOBr3ji3vxWcO4mfqrQO9gVnPRirF+ZVhOfFGuM536YEcDdo1EkvbuoL/bk?=
 =?us-ascii?Q?BTg4J9FMN7igT1SH47pLDH54VODMjHSXID2uRCvvrLeLzQV25/xRTSUSsJ69?=
 =?us-ascii?Q?JoWItSeefK+GP+tbtWXPEkKJSYYWpbu2YKIEWTSVA/7AkCCsNgzUtkQj/LlP?=
 =?us-ascii?Q?1WiisOUz3Fz31BICQ7W8V7a7uutkzHl8URycNsBCEGtOOVX7ueCyUaXJLfi2?=
 =?us-ascii?Q?AzccokjAo3AguN16p79doN2iwW9rBSJi4IDotcl1VpOlF1tK7eY+i+JbbxZC?=
 =?us-ascii?Q?w0dpp937aT00C8p7gzY7dM8dL3UqfGR0uRp+tYWgspJNzEltexojX/+c92OV?=
 =?us-ascii?Q?QqnVX3FvV8o0g36XWet0SbIt+rlg9bpQgEmwO/TxQLg4CvyuFlAJnjZIbjmq?=
 =?us-ascii?Q?xAsZilGeIJrwJWeAWomVJuYMogSg64gbp59AnZ+ltK9RaAuUNGJ54rMUWEiS?=
 =?us-ascii?Q?OExMoX2BXjv7zq4ZMunJO3E+0pb1vM7XTjlQ1zoErIFD4UROKOM8Yhk97qYd?=
 =?us-ascii?Q?bvzFYSIvkqRIClw4ovyjOtHJAAKLRkIGgE8L3NJ2QXb+fS0PSgg/ztCC4DXA?=
 =?us-ascii?Q?CYAC9JZLgr1YnRkPNJjUA/FjGrKqI3iC9uiyoETEfm6/sYfXvQokBqyAf31F?=
 =?us-ascii?Q?owytOomFEEnR0X59LJE9t1UmPShdq7wYXLjNsyMlNmJsQnKlRXXcYoBH1xoM?=
 =?us-ascii?Q?D9503V2KPucrUKKJ9KDVhQvyFqi8nU/8j3b55HehAD17xv0kfRAu6XZyghtm?=
 =?us-ascii?Q?CjSd5FwhKqCyqzt3pdx6EqsmB1+PB5+b0XNlMs+EfO7tNB92Y/hzGoFPEOCC?=
 =?us-ascii?Q?q5naW2FkNr2xIWuHR5lFz7gHikYJbsVdqLaCR0vwS8G5XxSAexS+GmKWW7cw?=
 =?us-ascii?Q?/DUkDTQriLG+2gXeSuCDgohsjoV9uixWMu3+sul9UqpP+4NG4rL2SJnaMOFt?=
 =?us-ascii?Q?yMcgmQvTbHSFqA/v+P6oB0z3AQ5V0vwGXoysh0TJpbcWo97NroxmQ4yMwtUi?=
 =?us-ascii?Q?m+1rngy6eayPFzKHWqBK8+Wh8B2DfogL9KSTLzM/Mfi1WIQ5R7kWsxX5Qyg8?=
 =?us-ascii?Q?z5Sl29tSGmuu49+ZFtXlGYi/nI6MCUq0g6tUxSlhVzovYVrT//qHOz1jOM9m?=
 =?us-ascii?Q?t49gWddrlo1Gd3VcdOktR8UFsDmjkoisdUoiHH2TmhHJgrHgznIZk8qH6ake?=
 =?us-ascii?Q?suf3k0fcAOGCJI0DqxuwIoXnf8CvobeT/GpM6gGm+7P2k1F4Q5LPgEHV21Ko?=
 =?us-ascii?Q?TZhsfjjtftUMUAFByvOeXsstZCz7R7RYYM51HATzjGlARjKGlFEdMFeGVCXY?=
 =?us-ascii?Q?CJDNXdywdqpK4XZ7VMWNuCuQ/OASfwGK9N9E9UBX7DAy1KtEBlEIt66RrnIA?=
 =?us-ascii?Q?KvtZshlY7OFMc2PzdS09GyakB3KUhwHSF1zKaPOkChYUU2Yzj7jeNDBaT7DI?=
 =?us-ascii?Q?k6YIpZA6OmrQGlwVTNZEmn4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB3C8CB89034ED4E94C71CDB578C12BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0h/KI27OIdS9kNeHGplMU7M1/viq/rPnKNYa8hEt0HQ3o2oUr+3ad2cmQX4EcvNQlKs/LtQ8EwXs07r5xEDcAcli3kmCqdpuOWuBjQWCGy0+z5wtkQTpmFxBstmHTUNhE1ACNxbn7dcgwJnOH1vyvHi2lUC/O2SEl8cggIvufTN6Tg5DXsFsNSUvJhixQL8A9XBYuSFh67K4RofIyv6WKYFqNS4eAQY8LcwxW05Nm7ljB3zlpeLUinPI+ojFuIl9x7j4sScE9ZT1kv7zWeEjghVAWsQSsbl7nzZT7cq8X5e4kk8s48bQwcPmmigeN6ZdcCwaFf3DkI9r6xzwmZqh4j7vfRhgNxWjp1p5YKs0WEQWBjffsl4Re3uEM2X8lInUlOc3bfAkxy0wLF8coLRxfO3fmv7chlpeWVyZZkMl6IOFq/GQbbffZW2RVVazMcL6xUEPR1PcPWh3tg2aX7BucLae5sSCelkaY86F5iyPevi8oW9YyAFrcD1/Io2YyGPVxskHq4NG8GW+q6Bx8NVCZkNvib28tFfurg+D2LYJvpvdVB+i0opcj0gNyzq3u1Y0R1T5Mw2+wSCfFDEvHAi08qIYn0QIkiUcv58khsTVOcNovgu2ZiBY1bEwCgY/XN7c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4cb92b-dfb1-4231-1cd5-08dc4a511f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:19:05.4652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nerG6JVG+t3tKOTxjWLsBQlWHpkNFWiQlfDA0Zh5PNATb5//aAaCoWAHSdYvuXdGc5SpS5qE7iJCBNpFP9N6k2IGWcw6+ZeM8rTWacji5dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827

On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> Remove the port from the subsystem the test wants to remove.
>=20
> Fixes: a12281b8320f ("nvme: introduce nvmet_target_{setup/cleanup} common=
 code")

I'm not sure if this Fixes tag is correct. IIUC, the change in this patch i=
s a
missed hank in the 9th patch.

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ba83f32febb8..d74a5418557d 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -869,7 +869,7 @@ _nvmet_target_cleanup() {
>  		esac
>  	done
> =20
> -	_get_nvmet_ports "${def_subsysnqn}" ports
> +	_get_nvmet_ports "${subsysnqn}" ports
> =20
>  	for port in "${ports[@]}"; do
>  		_remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
> --=20
> 2.44.0
> =
