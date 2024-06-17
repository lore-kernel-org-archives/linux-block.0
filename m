Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BF194A5A
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623963; cv=fail; b=tU60c8G5IXtyi1TSrrjJ8h0B2IXek12nrxfqNNLJEETx6CTlz4kJJR2kd5kNiUihNPZEtAwu4G6vwXP0AP0v8K8l2hsz9D7fIXSCKcnCBYEdeCGrIKbIdDKo048z15qj8r22fzXBzcoPy03mE4Ay578hvf3cWWcclbt/Jz+M+5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623963; c=relaxed/simple;
	bh=27PFV4GrBjlaJPep+VLV2Sr24nfFTQbZu5530Mi0Qkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u1v3iMlkAUpIPxVB/akTIPldxEjyOMbyumeN7iMvqmbwsS4xqZbkSW9KJBUNsSKp3lvr66vZFvNqDOp7qCICE/QSbPFytHMp3VJPJhqVwbGC7jOWcmmcRvcQQZHywB5L+VYr2FdXO5gGe0lzzANwahpaZiupqEekIs4HZG7+vjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pS+WGC3f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hccmUb/8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pS+WGC3f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hccmUb/8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718623961; x=1750159961;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=27PFV4GrBjlaJPep+VLV2Sr24nfFTQbZu5530Mi0Qkg=;
  b=pS+WGC3fsjl1Rcc223jChK66RU1S9eXMv6xid29VVm1ABQ76/bKxk4SC
   SwwZjAlSIfAu4/EE6GMfoyfKS98WJBzk73dyyD+3UeRCxn2wCh4caFH/N
   kWVQ1EKpKt8kHYVZ5jmu3WREdMhhqjA54GRxfYCmtiPjaSfY2/8DymNoM
   XebyTaJm4WdjUQ+e/O32Tf+38Wdsp28oziCEGIoZYoMRH7pGEXgt/89mO
   mZcOZGRdnydr3m+bRmcQL/IhIpPq0YWFsfcYZhnHFjkKLY2iB5IGWgTbT
   uGKa6hHX3WutUzYQ67tvMgDfQ3TEmP07yp6KsJ9oTsnk7D5K+LBuMZdcj
   w==;
X-CSE-ConnectionGUID: VjNxKmWPTQWgEVk4zojKCQ==
X-CSE-MsgGUID: BH3FGkMiR8GMQ1K79UHvmA==
X-IronPort-AV: E=Sophos;i="6.08,244,1712592000"; 
   d="scan'208";a="18543625"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2024 19:32:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuaH5IfFcWbNH0N01zcF3V8aqDqj1XntcpEjeRvQYCrFdlYmrdFhRxK/Ho0ssvscjIhMY8nqmpdUmlsAg6zZExg3Au3MRDgs5yl9jFCFwUthesxn2BritlmPfMaUbe+B4FAxMD2UeJahE3GHb0r/2O7u+u6Xbq7I8RzxJg2DsXyvl1E7HvK7ww5aGX/tgE5zYobqGGwUvN7gEZpvnQt2dIXFxxtDmUpzdvYIvgNZuVgzHVLnlT3276dV8/1y2EaiSy+yvuKZaHTmSVMnMTgjHsl29RGSnr4vO9izn9ueFYKZCkZticJI8Xyw4vQzYzunS2hRIvOMdPKyKedx6CV7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0r9hA0u+8uS8J7YDJcrTP3JI/jVoUq/80ICi5HTF9w=;
 b=BHOJih03MBMqo1Mj6JYLuQc5e0tPvtUfD7HMXEz/grH4embLnYe65kLHiPgNta8vKr+5nlRTnMAE2j1NMujoAjwsGAXHj56D/pAqtPhS09G4MtSUFbxDVLwcv9fKp5gUx4udzxMP2DYxAo2eEw7rYkRd2MU+vTd77kluEjFN9UTyhUDkIeBv6PH67nz3TwD85AXnf9HZutwxnwVuPoElh4b8q32qsOliI8h+SHHzVIIe7XRsEDvNBs763yNgOam5Ihi8tFF5REO7AhVuHC0jm2h4mUX6W7xz95X3HYBpBoDfs1HAlCkCmPpwNdLz0AOnWcE05xbU6+twbU6IWlQeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0r9hA0u+8uS8J7YDJcrTP3JI/jVoUq/80ICi5HTF9w=;
 b=hccmUb/8oD488aE2hpVdABdh3HmCsbaBoby7U1nwujxDXauFI+NLQ60p3pIFXWejjzJ7ktNIF6NDVfDzAiNnAS2CNBVVU9txIz8WzMnpvtI6uoG6L/TxpMu1IB/E6ddeFqdiy5gIUgRZ3u8BV+cGykxKIheXK1AudHd2bmwzQg8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6865.namprd04.prod.outlook.com (2603:10b6:a03:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 11:32:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 11:32:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Topic: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Index: AQHavY1+2yGNDI7RnEqMuaOkwQh00rHL2PmA
Date: Mon, 17 Jun 2024 11:32:31 +0000
Message-ID: <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
In-Reply-To: <20240613123019.3983399-1-ofir.gal@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6865:EE_
x-ms-office365-filtering-correlation-id: 80aedd04-ee0b-45da-29e0-08dc8ec12d34
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gsyMs4BiiQVxfwAmG0VUg0oYSHlg+GtTE8ynkwHjHor+U8lR2Y8DT80otMS5?=
 =?us-ascii?Q?R09ZUGjLjsp9Qbb+hpxC1nUsBPF9Q/msse+Uj2iggj+tHgxDq+RpmqdBP7a1?=
 =?us-ascii?Q?TnYVoKWHDySoG7lCv7eAr7CR4FNvrT7dUZTUwr7wNJtaXpiF4igkAnhgHOXf?=
 =?us-ascii?Q?GeriME5I3TzE5uJIX+gE3BX5trI/h7eTEtwB1EFrqj67Wjm87e40GYJ980Xx?=
 =?us-ascii?Q?pN22D2iXryr1tNUGH5Xl4RhDsIL40lE+1a4PQQmmH0kBLqGLxjicxQW55PQO?=
 =?us-ascii?Q?X11oE5Npd07N6Oe/37eQPxCFB5PBJs2E0ghA/6UbO+/8rovIdnDpy2YOvP4O?=
 =?us-ascii?Q?Hz/0W5/TeDgna3F9VDit3CuLU3AIXZ+/6Ug578Zhf2Tgb+DC+GxrMpbS5gdI?=
 =?us-ascii?Q?9cyewKqNR/EAPNT4BqsNh/e3cjX1shE5rBV5FagtX71AdE24oOJxyFU2Gg/d?=
 =?us-ascii?Q?GmJVLFJOh+GDF1SclM/+7SMECWpZ8/l7MWO0m8QttDwcXrA3kzsDoCsyd1bo?=
 =?us-ascii?Q?dNgqfEH1OSQTB/iKUU313LO+aKuuCWKmEUrQTOILxK70QLHPFwKghkpeY/WQ?=
 =?us-ascii?Q?99oGyOytAj2GLbEhMo7zHhSMa1OqlGXzQQx3Jpf7AkThPZ0ndW4t88QVJ4c+?=
 =?us-ascii?Q?Vzs22nBlzOkv6+BAoxxTSsY27V6Wz7ByzGG3tpQBUf9xbSqUWdW71kgLLJl4?=
 =?us-ascii?Q?wyVeq7qsXISO37/OOkgmGKADmuI/le6VG5q3Myr4zLD04210nBExGphOt9Ge?=
 =?us-ascii?Q?czCZiEzVuhFror8aXUVilsb01oTFEr0Gj41majsfj/uJp+tPhPRnmlC23SIB?=
 =?us-ascii?Q?bPb1vG/28mCdWSQ24695EPyDQtFf8nbwoa+5E6Ep+bHWGRdPgnP96jm2v9eV?=
 =?us-ascii?Q?2YzlFOz4ZzDdso5HPXrjOU6+TzzlN49ro4sc1SA2qq2WiAk6uMhsTT5BSIlI?=
 =?us-ascii?Q?/0NL8p6pc2h3VcwcfneZPGCD40Il4JiKBczwDh5Rtw/idDjeVm05Bn2PhDqq?=
 =?us-ascii?Q?NBgOo6IhVGI96urboEusJgbLdRs6bPvbHdonuiSI4/fh8isdybJMpDGPiyKS?=
 =?us-ascii?Q?6IK7wkafe06CyivV9ksToWXbyuTvdPBjoyYwPij0X4hNHLeEt+sp2kG402F4?=
 =?us-ascii?Q?QxWGq+0QgcvRfHJvZRvZxTHAGHodSkNHrBSPC/6MhmjOn/d7mu9m8PCrcR1U?=
 =?us-ascii?Q?P5RSS0o6DamctY3O/gOXP9cI6hsa2QZ0GwbeTdTNvW0dIO4hVBpJSwJRerE7?=
 =?us-ascii?Q?6CtOO8HKqg2kK6pZvtyapd9pFXTeuyn0K/So4pdZ7ndJxqh6kReGvxLlV0cY?=
 =?us-ascii?Q?+uBx1eROO3V/W/C9Au8BkUd5Y8IRkHlx+rjiitxbSTGWmQBqqBYbTJh/KyYs?=
 =?us-ascii?Q?Ao+ZF9s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bA0p/lnI/ockzHtvoAtNu1718uuVNCdBNR11TWZScUTZ1Ant0J/MC1wyhb8d?=
 =?us-ascii?Q?5ZzXuhpn+RCOouaIk5DMuyvhF59Ggd9Q5wF/tsh3YwfPqzwYQgZ+QPCgwhUc?=
 =?us-ascii?Q?5DfU4bhk/8U1aFnUzzKuMtkMAx2rqfMm/i1MkgMhuCnAib29EEhO5xA3HI3d?=
 =?us-ascii?Q?HgsZTCOlGWVBb8nWEz9AXle3aPTn1/9NBdxFN0yKUtEnGZk5HCMFb2BDCBdL?=
 =?us-ascii?Q?L+uiDzv4sjWOwwFcVeoAfPglAuoGTgdkhM1DSm/bkyPt50La0iLu0JPEk3R+?=
 =?us-ascii?Q?GqFpbha7mIcy596d5MnYCvQsbRD/+u6UZrvWmaHcOU42VkpF8uMe5HF8sEbA?=
 =?us-ascii?Q?JLX64WPAVdGP5HnPJUoORO+zHJwZslrN9bBWqIQk2LOBSPqEjDt37EbvKES3?=
 =?us-ascii?Q?99tSrU2aylFXUXyYXhaGXzEL5snzYxRj/JFgR4NPgTSbxHspfQIKp1fEa/4Q?=
 =?us-ascii?Q?V8RXuQuW+BIH3m0XRV6OHfDiOzBtflL67TavyP44Jm3iO7Xy9dTpk2/XhJGE?=
 =?us-ascii?Q?jQceH5Ql6ymXEZWr/QrYBSgg+h2i453pCZBMY7L5cVRn0UUR7vdsQG0sHw9F?=
 =?us-ascii?Q?/PD+uBX98UCmbcPhfXXFMMNci7DXQz6I85g8Ma0eK92rGmVUxcxd52YfDxNZ?=
 =?us-ascii?Q?vJjF5IZ+y0ux7yt+X2vg1CX9XhVzOeQgVeSwnMiz8iNb4YM/DRvIFbnEUrWy?=
 =?us-ascii?Q?Jv9PsxVMZvHWU3dJesBSA6w3ZKoz44hm2V/WG64Qfdd8rSie73gi0Kok0uvc?=
 =?us-ascii?Q?GQsWywyy1i53cu3ON8futjCDBVZvBEEGCWoRVYzAVXTrnl9xyEgxm+mRNlTY?=
 =?us-ascii?Q?lEjklvIFKpq1v4pPl64J2J2D8xGiWUuMxTe5MZ6Lso8nI+8VHQxfmqNB/qRu?=
 =?us-ascii?Q?gD+fT0MwCQ6+dJSj6QXc2rZ18ndDnjPrzSrwaEieBOUPxFKzr3UL4Wpfyvel?=
 =?us-ascii?Q?84A35wEqoDYMFpBy1pLSdTx5fm8rDKkxEJeEr2oZe6/rTOYDGsMr9/sIJTkZ?=
 =?us-ascii?Q?Se0zNq3/bM3Ba4OEkh3CUNNeM9GMFcQ4zaQxIk/zBFRRK89PUBXr24lCC/Y4?=
 =?us-ascii?Q?jPzbuArr1kwaLkMGlyZkly/ZodWmYJe3JgFpihozy6qrAvYD//dQfpiQ67Iy?=
 =?us-ascii?Q?vwblhx3hQ2rzNZTZ844gMsP36xC/dqeLT6t9nhJreORFZ4oiT8dBGt9Dv9U8?=
 =?us-ascii?Q?gA8/sxlKfXLebpND7KWaLNwTeM5ywmJDg+U+7VDd9WAqO81FcLHSY/hIV6po?=
 =?us-ascii?Q?Ovj83ZClBK8goQq7FUgH76FvpyWzosAjVX812EFRiKLE69vG+cxxJ+Z1Ze5x?=
 =?us-ascii?Q?iTlCF4ffSkdAcx0tHtwGAKBoe2EHABFIia9QzBr58CGs6mrSpI//jWWAGROt?=
 =?us-ascii?Q?xRUDUWPZgpEYyY8JLjZz4EI9vBidf+cSA9/unyoLO5r4/bPRH/RpcUtHryhU?=
 =?us-ascii?Q?yuGJu4hbWTQacHjaq4OUVRG1XGZ9D30Z+qSpYF7c/+Outpz68eKkFbxgN0fO?=
 =?us-ascii?Q?HfF7QosHIeY6UH6l1H2E87P1O8D1lnopSpbyJvZWKilvGF+ZEcAFNmzkT4Tq?=
 =?us-ascii?Q?43QB8isrQT/ectk7KrRzJ9gKO8nfNodlx8J5rBWm9cLGe9lsBkuqSQiOotEp?=
 =?us-ascii?Q?PXVXE7ylgmY+Rz0cH3dJMWs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <464EC349ACB89E47896003FA1144BBB8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GUSlcrumNPY1Bd/9J5w869w1Xu336QPxOWnHhMDyBDRyOSdM5r4gV4rP27gcgnKF2SxEq4nHqB9PMqVIacmVLbnFJpANG5lIS/ZBODsnht22lwRhGTQHLoR59D+q+H7YX3i19iA4iHqbv0hSHZaMjVneq46r2gvElFE5oT2mlGm0HfacgFT+8tNjsczWl9Ve/UfRs7eLxgsshNlIwJV3sE6Q8Ij2TdFzilHtu35zfoEDRBauUUOc2etM+BXqMhWZAIL/SZs6QksYLcymb7higZDVoernNKpfukuD5CRWl8+fje9nIiKjuXJN1GfQ3zv85IgaqvYDxbNdbAkmKcCUtB1lZSLkK2gew+yixQQe+iTlsWjTee/BIdwZu5wVusOTWN3anED4723UJjLKgXIVGSv70dyowXGTt7aZA0HBaxxJ0C/pOis+KqEc+TXw9qLTYMe4nJrwu58zSVzHD/Zrz98SmAwFXjYPkeuNGiFJQ4EaOd5XSpyz+DhBTUAUTmoUGum0U1Oi+v34R91J9UG7Tkqq4DEgcHY5tUUy83LjWncFvo5teBGmExDXwlySy+vMgaEKs+SFf7dN4zvCksjHg1UAKAfZ2iFB6T3UEZK/Elfm80v9crs9b5t2z0k+K5gI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aedd04-ee0b-45da-29e0-08dc8ec12d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 11:32:31.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99wguFoWPam4iqy2YJsx2+Z4nNwmGnXMSLFhtWumOYJH/noUC4h14O+wkbwxxO/0SLTClmqWjQmlOLJ1a5/iHQ61AwoStkXslACLFcab2qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6865

On Jun 13, 2024 / 15:30, Ofir Gal wrote:
> A bug in md-bitmap has been discovered by setting up a md raid on top of
> nvme-tcp devices that has optimal io size larger than the allocated
> bitmap.
>=20
> The following test reproduce the bug by setting up a md-raid on top of
> nvme-tcp device over ram device that sets the optimal io size by using
> dm-stripe.
>=20
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
> This is my first contribution to blktests. The tests hangs when being
> ran on a kernel without the bugfix. Should we wait for the bugfix to be
> merged to upstream before merging the test?

Thank you for the contribution :) If the bug does not cause any hang or fai=
lure
of other following test case runs, I think it's ok to add this test case to=
 the
blktests before the fix gets merged to the upstream.

Please find my in-line comments below. Later on, I will do trial runs.

>=20
>  common/brd       | 28 +++++++++++++++++
>  tests/md/001     | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/md/001.out |  2 ++
>  tests/md/rc      | 12 ++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 common/brd
>  create mode 100755 tests/md/001
>  create mode 100644 tests/md/001.out
>  create mode 100644 tests/md/rc
>=20
> diff --git a/common/brd b/common/brd
> new file mode 100644
> index 0000000..b8cd4e3
> --- /dev/null
> +++ b/common/brd
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# brd helper functions
> +
> +. common/shellcheck
> +
> +_have_brd() {
> +	_have_driver brd

This _have_driver() call checks brd driver is available, but it does not ch=
eck
brd driver is loadable. I think _init_brd() and _cleanup_brd() assume that =
brd
driver is loadable. For that check, please do "_have_module brd" instead.

One left work is to improve this case work with built-in brd driver, becaus=
e
some blktests users prefer running tests with built-in drivers. At this poi=
nt, I
think it's okay to go with loadable brd driver.

> +}
> +
> +_init_brd() {
> +	# _have_brd loads brd, we need to wait a bit for brd to be not in use i=
n
> +	# order to reload it
> +	sleep 0.2
> +
> +	if ! modprobe -r brd || ! modprobe brd "$@" ; then
> +		echo "failed to reload brd with args: $*"
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +_cleanup_brd() {
> +	modprobe -r brd
> +}
> diff --git a/tests/md/001 b/tests/md/001
> new file mode 100755
> index 0000000..d5fb755
> --- /dev/null
> +++ b/tests/md/001
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages"=
 and
> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
> +
> +. tests/md/rc
> +. tests/nvme/rc

I want to avoid cross references acoss test groups. So far, all test groups=
 do
not have any cross reference to keep them independent. How about to add thi=
s
test case to the nvme test group?

> +. common/brd
> +
> +DESCRIPTION=3D"Create a raid with bitmap on top of nvme device with
> +optimal-io-size over bitmap size"

This descrption is printed as blktests runs. All other blktests have single=
 line
description then the two lines description looks strange. Can we make it sh=
orter
to fit in one line?

> +QUICK=3D1
> +
> +#restrict test to nvme-tcp only
> +nvme_trtype=3Dtcp
> +nvmet_blkdev_type=3D"device"
> +
> +requires() {
> +	# Require dm-stripe
> +	_have_program dmsetup
> +	_have_driver dm-mod
> +
> +	_require_nvme_trtype tcp
> +	_have_brd
> +}
> +
> +# Sets up a brd device of 1G with optimal-io-size of 256K
> +setup_underlying_device() {
> +	if ! _init_brd rd_size=3D1048576 rd_nr=3D1; then
> +		return 1
> +	fi
> +
> +	dmsetup create ram0_big_optio --table \
> +		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
> +}
> +
> +cleanup_underlying_device() {
> +	dmsetup remove ram0_big_optio
> +	_cleanup_brd
> +}
> +
> +# Sets up a local host nvme over tcp
> +setup_nvme_over_tcp() {
> +	_setup_nvmet
> +
> +	local port
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_op=
tio"
> +	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"
> +
> +	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
> +
> +	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
> +	nvmedev=3D$(_find_nvme_dev "blktests-subsystem-0")
> +}
> +
> +cleanup_nvme_over_tcp() {
> +	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	setup_underlying_device
> +	setup_nvme_over_tcp
> +
> +	# Hangs here without the fix
> +	mdadm -q --create /dev/md/blktests_md --level=3D1 --bitmap=3Dinternal \

In the past, short options caused some trouble. I suggest to use the long o=
ption
"--quiet" in place of the short option "-q".

> +		--bitmap-chunk=3D1024K --assume-clean --run --raid-devices=3D2 \
> +		/dev/"${nvmedev}"n1 missing
> +
> +	mdadm -q --stop /dev/md/blktests_md

Ditto.

> +	cleanup_nvme_over_tcp
> +	cleanup_underlying_device
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/md/001.out b/tests/md/001.out
> new file mode 100644
> index 0000000..edd2ced
> --- /dev/null
> +++ b/tests/md/001.out
> @@ -0,0 +1,2 @@
> +Running md/001
> +Test complete
> diff --git a/tests/md/rc b/tests/md/rc
> new file mode 100644
> index 0000000..d492579
> --- /dev/null
> +++ b/tests/md/rc
> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# Tests for md raid
> +
> +. common/rc
> +
> +group_requires() {
> +	_have_root
> +	_have_program mdadm
> +}
> --=20
> 2.45.1
> =
