Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xhh98TLt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P5YfpTqc"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE035187
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700100550; x=1731636550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=80Hm7+3zmjCGaaJhgXUTiAPxpZlenCMivynUFK1T4Uk=;
  b=Xhh98TLtNa67ApI5xuRETEvi1FA20XBtGyBThsgeFliBmPhv7VvpM9r1
   68CELn1tZ3EwNt2nE1bqDT6Aw0W/RVQxGjr5Q/jWz0qWaQ8VHzwdS5CdB
   y62YFEvI+8Pnz4xu5wrLIUgTTi/C9EGt9tdo9xj15o8y6lgCmnE1TEkNj
   su9gocAR7C5Hs9E42/o/fY++lmN4OGjTPwYJeDCkBCfRqE27QMnAana0i
   a8yNLyQcDAj7vfyS3FY32Yod1xKIcpVvGt9pAVx4O755y9auKUtlThO0/
   uawuHMGsIuZXIECVNFEl9YaHu6s0hyGqWXk2aWro7DMNq1gTITmS1Ty9g
   A==;
X-CSE-ConnectionGUID: kbDymTKWQqSb980J22LqIA==
X-CSE-MsgGUID: xk0UV9hESzO4Rw5LQC7mDQ==
X-IronPort-AV: E=Sophos;i="6.03,306,1694707200"; 
   d="scan'208";a="2404958"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 10:09:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS7PnWtG9OCr/NEJdA3huEmRMIJzCXXif6AuMuqSqAq3+eO4NZAvkDmRKTLtjj67Mx6avJn2LYQGF2eiGqJGAipfz3H/OdQxS6ADgAEvoo+ug0XyPh8Z2HAyVkb2GIF8bmBZhdU5GNxj9DZjdYwXU613jLDEpLnBx1uZOMk4z0NrtThOF7jTPBkySBIRNYepBZE8b5xVHUT8UfIW1lLP2mOY6ZaZgFMu/08mKpfYWLlJjIcsDs0rkAP45nUHzi+840Dp31tm35Tosxfj2T+ClyXbdvKdUZmeEqdnE21KX81v7QF3Lmc62rvYhWJTcvhOFTZFk4mYPnslV7PAwe7x9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEpRvGSrkfPZ5R2yuFOlj+kfE4YKp37eQrRltqRNR38=;
 b=k8n8lnxSY0ZIXjFl/6CCJP1kATIaI/XTEETKSiZG3dzOMcZ/SilgkAHsAVn8Jt3lK0qG84+QktF1ODV3w/5lzZRb0jBdf3FiL/xtkhXamHO7TkbMbWwXd1JtiL8ACObwgvJZJJJVsIWqk44PyK3wUpN7ihlN7jbB6BVtouReQKEkCuV3eD3hgbW2nLj7vEXtFLuYGCJ8PvhQljFykiPPN5WqNWo6o5EyDkSrM2Gk9wk3Ya8bicaBmQNcLwpSPq7FI6xKIo+F+5MaAP3/nOvPUVTD/tx30yy6iAvJhnq6HB9paDpBRYSHbfJiRSEM1n6Z/9+HrWzIc0qsEP8/ksTSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEpRvGSrkfPZ5R2yuFOlj+kfE4YKp37eQrRltqRNR38=;
 b=P5YfpTqc4XVtGj7gZI9bZ7BUuMQKW9th2NRuiNn3EmtXukDAANtLhH3sZL4xOu1gamEYfvn3OSphpkNTgKUuse4zi0WVLKSBtA3Qez6NMkuOJ2ZZ2Zt0Gfmz6KimPO2UIFqGkqoWqcGk3fEcpTVrSCC2Y6+MC2mpsbk8lbnXQvw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7943.namprd04.prod.outlook.com (2603:10b6:8:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.19; Thu, 16 Nov 2023 02:09:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 02:09:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Topic: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Index:
 AQHaF4fs31V751Pswky+3T/QxhjUILB64sUAgAAdzQCAAAmMAIAAZAsAgAAD/wCAAMKJAA==
Date: Thu, 16 Nov 2023 02:09:07 +0000
Message-ID: <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
 <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
 <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
In-Reply-To: <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7943:EE_
x-ms-office365-filtering-correlation-id: 10aeb096-a5f5-4a7a-e386-08dbe64903cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0VYyMkHk5c4m5jRGyreGa7kmtPHKPyJjY4E0TveLlwRWDWIJVSx5paJTsAhc+KLQyHLgh/rayRjmibr1X1TYsOo16krGFYZgiokWF5nr+sXvbO0Lhy0uyOvvrIE2cfV1jxCsYVjgScBStRD9aRUAwY5nABc2O1hMj8K0lftkfcPHDiD5Hb8qYsoNx5yO1gj4NuAZQSahRd7shQf3tCwaBnjKSceCyMRsYBXnYZQGEiBdNAeWWqo7qY/yRAc4hL6SPQXJ0Z2fXu1GAK31e4Z5U9tiib5S/dVP2QcJYpncC7XaEboGQS8A19TpsgXfQKWy6YoMMRFj++HN/e8btuxCxdy6aLdT/lVpPyrNSSBrBbgSE6wJgHTJS6AdjPdKSyyYY4zPC2f7wvfsCH8aPaap5qYGd7oFU3EGc8F59oNXncqF9ek3mE0oiVGkqG4f7kU6L0k+1UZF8xLU5h5F1RdNSABM2ASgsGlo3zk53NibLKt/mfwxM2mv7pFM9pPut/VMTcMbnqMZfL8R5+l/GImSttebN/WANUGEkqz1boeE4mT5JZKPJpVbF/h8QYRd2amrqKTRjxkUncTUayG+j18nfzCis0Fy5S4jEa7A5GCuZI/kc6SEwN/sE9xvnxtEZTiK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(478600001)(2906002)(6506007)(9686003)(53546011)(6512007)(91956017)(5660300002)(86362001)(71200400001)(44832011)(6916009)(316002)(64756008)(54906003)(66946007)(66476007)(66556008)(66446008)(76116006)(4326008)(8676002)(8936002)(33716001)(38100700002)(38070700009)(83380400001)(41300700001)(26005)(82960400001)(66574015)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3CeIUHwSEQKAiuomJNWKV50L2U/lMum5dR3mudJ7IF3Q4crJUzGK4pwXa/?=
 =?iso-8859-1?Q?3fyYORY9/T7IiEHD0jBAQ0Dr59UTsGTRuMl3GZJ2WB37l0ZJMI7fq83B4L?=
 =?iso-8859-1?Q?bSkmfGKoy+iFfY2Z1tF2srb+6mbYcW735NGiHkY+Jd9dQgpLmVDubUqxAH?=
 =?iso-8859-1?Q?1VYbDcIhMU2o8bQhqluiyvDzwhjZZxnNsvI7bcvDdLrQ692ag7oNuHv8MP?=
 =?iso-8859-1?Q?ftE2UCtvpFEa+tk9WOuLtHys/JyPb9K/WWyoLWjoRagZeh527McPE1WRF5?=
 =?iso-8859-1?Q?r+xUK/dS+fQYLM6uX6GDZuD7p4W6ATuKsVUULsoLOKJoSgA9x06NtiKdbq?=
 =?iso-8859-1?Q?fQHU17+CZS4UFed5+F61DiKfG2yv7TrPm7NETg+8hU9Qcy0tfFzZDc8eTI?=
 =?iso-8859-1?Q?yAjTsO5d2rS4UhRcGSxGrdQfEWUszCFmhtFDwqDSST1aBDNaP5C2Af0Qh+?=
 =?iso-8859-1?Q?2/IMZRbf8fKUpfonnlaiauIBLESPyZyeMech+h4q6O3cgOAq8guyUGURr/?=
 =?iso-8859-1?Q?ACdD6ABTUYrVWrIjV2fzLQwf2e+nFv++g1VaWuiP4c5YjnQDQGrXuNY42Y?=
 =?iso-8859-1?Q?3ymBFfasxyBLZOS8S9TI3k+npxl3Ukz7/7g2CmBrpfk2ZHCU1nlVK0NJuj?=
 =?iso-8859-1?Q?xPBT3k/9zRdtT+XgKKD0kc85Kwi3Hy3nI03Jv9gWSradTTTncAAHvX02MZ?=
 =?iso-8859-1?Q?B/N9Feepw3oCiv2/rydxmglb1FZ610Icx37GW0VkbQPGj59O/3zJnAMHwl?=
 =?iso-8859-1?Q?13huC/e5b9BqstZd8qFNMzCxJrUXbQ+Xc3xKB5BkaVnyZ5ES+j60cLoAkl?=
 =?iso-8859-1?Q?So86i6ViO1Njlf3wMegDMF94VsAcPc8j2OP3G3Qq6NIScZi5tIDJqohud0?=
 =?iso-8859-1?Q?qFL+es4lMEgIjers+Vpn6c4p5g/pOtTSSHk68VdgjifsADRQyXd9z6MF8Y?=
 =?iso-8859-1?Q?+UqB/76R5LxIZ47llWTwjFTh+Z1ybqqNKbldERZhQF8q6fvfLYAeewMbeC?=
 =?iso-8859-1?Q?Le/IfSJBi6gK769/cceuSTKki5ZAPQqQvtLidgngjpeNnP3mCnzqci036s?=
 =?iso-8859-1?Q?41D32zkkM+1DkNeUODE5lbSBg87oho/KdpjRDFQL1qHZ4AkCUHPOrJ+vVm?=
 =?iso-8859-1?Q?NDOQXtgGFvMZBl5A08Ypmn/GRB8YkiZP+De+uI2PfeUmwFml39YU+t5NJR?=
 =?iso-8859-1?Q?54GD/VBssTDkTw6rKukqk/h6Kgxf6vItVNwvbUXSnKc21EBjSz/SkbTX3q?=
 =?iso-8859-1?Q?0821TIsUj2xltKd5LdAgQQMDlGk0yI5xpFhapAaItXje0gWNeC5PJ56XZh?=
 =?iso-8859-1?Q?VuXBQ6Lk4DjZb6Pjx2Z55tO+DvFZDUma4nogdQZp9mgXnRq5mj9L4Iet0v?=
 =?iso-8859-1?Q?Fftq1LKPuuh2fLULeytZwlxLf8YopiIr5LLLOOLh6tcE1X0DCRk4d5C7hT?=
 =?iso-8859-1?Q?nzh+iNAOaZDNYOp/7c27ZhFi5UIxUAX3Gg35hKzzWpfFYYsR4IRq84qndR?=
 =?iso-8859-1?Q?B2XNbLf3axmQcX78DCoWGoKJeRfR/PG25vNrROrqOvcMA0/mkL0AytN0NH?=
 =?iso-8859-1?Q?mcWNVwdT+t1yKyAB0FR9F4PxVK5DoWJPkqvY1Bj7QkoVADxBlX0t8RuMoJ?=
 =?iso-8859-1?Q?3B6tfglHuH405Ez4/Opk60MF1bzJY9zkbPeAyBDJjvG54+QneqheFvthlU?=
 =?iso-8859-1?Q?4+3PXmXwnLJ50tSz5Ew=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BF3E20776BFCDD4D9FEBBF417CF0BA89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hVYZnC9ONnNPm5ojFG1ZckLpXKHQDqgj/sIO7PskTPVXjVNGnSsH3F9+YVTFociFmVTT3tKcqCuL2iPMJf1ALAVQyAbuzSOzfF165tZ4j+75FLurrlkLMHy0VVWl0QBXe1fNHtlVXKq3OC6C0uDidIPTQf8ChOQZdYfTkCWOhNHi58YrdAE3ZR1OmkYfg+sGdFRnxxv4N8XAVJFsauzXEYXfcZIwB+tr7FXlPUmS3AF+MDqHllPMvA1Hs7RAcAToTXHxOohiBMMD2TMvku+VwsJjC/DDYfX00qVckgKnfGiqwARXuIG8enk+/ZgnH903rW2Dj+nmLeP5B/SpeMYi7zU3OiNz5qdSs2mseRlSKK0H4owari/fZZ9550S0IpdcSaJrAqexR5AFmzuow1geMWD0s7GvL5O98+P/y9H4qDdLDFYf8UzR6P7j1xoKC9UzzWSMJSLSRKXHHeHMdqQ9CPa9+pMLOayz2xwuIUp4jmI64fcLfbvl6uKpA7LwVbeGT7Ku4ROL2ilWsKAyfJo3XKTzkf47jha0TD0oBjFGzeoT8pO83TlT5TWBJsteQbVTt36pxPKOfzdIRda2yZdRgHUd7upfGnv3gstv3+yL5EE8kdvIzVTyscUOXPxbOJYRTsIAHwRGGUbyt/bDvyMbbL6Eo33u6Ale1CDpFiyRRZBpoNLTIBuZEAfObYRXIAFd+Wd/KxgAphxnsr2QcusszL+J2Z0P6AsO5tNXX5/N2DczFYEW/6vZq55J/5yILprfZ0BtqEHcpsUUxdKEiDi12kPlEgvwAWwmk7pYEby1P1AwllAYs0f8kzOcgYbseOuDYwOrjinzftK5e6CInDVorw2UtQW1GqBKgSob8/gS0FJL1vnwgfxQObGvtDZ76Ran
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aeb096-a5f5-4a7a-e386-08dbe64903cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 02:09:07.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvfDoeOqIuWkYK7cFK8q2km5ipp3yghd+tbMoCwG14zjoL3UjUpmYP31ZVWEUC3p43mcurgwZzDNZBGg6YghrPiJXGVuxqo1OjiRUVn1fVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7943

On Nov 15, 2023 / 15:32, Hannes Reinecke wrote:
> On 11/15/23 15:18, Daniel Wagner wrote:
> > On Wed, Nov 15, 2023 at 09:20:28AM +0100, Hannes Reinecke wrote:
> > > > I agree that kernel version dependency is not the best. As another =
solution,
> > > > I considered introducing a helper function _kernel_option_exists() =
which
> > > > checks if one of strings "# CONFIG_NVME_HOST_AUTH is not set" or
> > > > "# CONFIG_NVME_HOST_AUTH=3D[ym]" exists in kernel config files. Wit=
h this, we
> > > > can do as follows:
> > > >=20
> > > >     _kernel_option_exists NVME_HOST_AUTH && _have_kernel_option NVM=
E_HOST_AUTH
> > > >=20
> > > > This assumes that one of the strings always exists in kernel config=
s. I was not
> > > > sure about the assumption, then chose the way to check kernel versi=
on. (Any
> > > > advice on this assumption will be appreciated...)
> > >=20
> > > None of this is really a good solution. Probably we should strive to =
make
> > > nvme-cli handling this situation correctly; after all, it would know =
if the
> > > fabrics option is supported or not.
> >=20
> > nvme-cli is detecting if a feature is present by reading
> > /dev/nvme-fabrics. I think we should do something similar in blktest
> > but not by calling nvme-cli in the _require() block. Though we don't
> > have to rely on nvme-cli. We can do something like this:
> >=20
> >=20
> > diff --git a/tests/nvme/045 b/tests/nvme/045
> > index 1eb1032a3b93..954f96bedd5a 100755
> > --- a/tests/nvme/045
> > +++ b/tests/nvme/045
> > @@ -17,6 +17,7 @@ requires() {
> >          _have_kernel_option NVME_TARGET_AUTH
> >          _require_nvme_trtype_is_fabrics
> >          _require_nvme_cli_auth
> > +       _require_kernel_nvme_feature dhchap_ctrl_secret

The idea looked good and I checked /dev/nvme-fabrics content on kernel v6.7=
-
rc1. But unfortunately, I found that /dev/nvme-fabrics content is same
regardless of the kernel config NVME_HOST_AUTH. I checked opt_tokens in
drivers/nvme/host/fabrics.c, and saw that "dhchap_ctrl_secret=3D%s" is not
surrounded with #ifdef CONFIG_NVME_HOST_AUTH. Should we add the #ifdef?

I tried to find out other differences that NVME_HOST_AUTH makes and visible
from userland. I found ctrl_dhchap_secret sysfs attribute of nvme devices i=
s
in #ifdef CONFIG_HOST_AUTH. But to find the attribute, it looks "nvme conne=
ct"
needs to happen before-hand. So the attribute does not look usable. Hmm.

> >          _have_driver dh_generic
> >   }
> >=20
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 1cff522d8543..67b812cf0c66 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -155,6 +155,17 @@ _require_nvme_cli_auth() {
> >          return 0
> >   }
> >=20
> > +_require_kernel_nvme_feature() {
> > +       local feature=3D"$1"
> > +
> > +       if ! [ -f /dev/nvme-fabrics ]; then
> > +               return 1;
> > +       fi
> > +
> > +       grep "${feature}" /dev/nvme-fabrics
> > +       return $?
> > +}
> > +
> >   _test_dev_nvme_ctrl() {
> >          echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
> >   }
> >=20
> Exactly.
> Far better :-)
>=20
> Cheers,
>=20
> Hannes
> --=20
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 N=FCrnberg
> Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
> (HRB 36809, AG N=FCrnberg)
> =
