Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD991145A19;
	Thu, 23 May 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462906; cv=fail; b=m3DiNtYgqDVnxFsmDq52j8FJFfyqtMaOGtTUe0nugvBYhHWTUmOtNhIlsvCZh19aG7SSL5OvR6Gh+UtnrpXkyDmB20k4t9XydMWoSp8RAizLfK2J0eqn1Kv/2KHLGE7WsOVN6hD5XVNf4kYl/+IheWBLf/FgeYtm2LdP/t5MP6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462906; c=relaxed/simple;
	bh=hh+kkDECH7j5on6AP2bjUZM9XusigbBEqxdy8WUdC2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ls59S67EOEk6xQZKSf7hTemfFtZJN/ctEIewEN6MWjVuwLrvP4i4nKMLUwv3muP2GYQ37NQ8FxNSl9ko4R0W53420Lr/b7mcq0pdScyLtF8nfiTWMfH9dB3QPzQJBwxYDeYAJNuhXwSReuRGz0x7TVToA8fTNmpKeh/XqF6FN4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BxnQ6cgx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=l/Dxpphw; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BxnQ6cgx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l/Dxpphw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716462904; x=1747998904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hh+kkDECH7j5on6AP2bjUZM9XusigbBEqxdy8WUdC2w=;
  b=BxnQ6cgxbwq5C6gKqdxu5e4IDTwZI5Ze4FFFSpcTzgloICrL4c1lLATh
   Wh5nqRTeXgn4PsfCM2tr341MTfz0p1ccNVN0oAVBrOHaZYoKc82KcEVF3
   0eX/eVaGg8iK1br61i7ojkhLoNQ6iX1lE51qhswRPJ3ryaafOmtozlQoz
   9FihBVQ8xrAXDR/2sHexn6+3Q8Z0m6GzCH7Ue23Irx6OwtXmBr7mn/cpC
   ahAYoMTjrzWAeUM94itln18TuPr2RuO2F+bNQ1RNPc5U9HA7cOdHFeicV
   VokQ9DV3YZ3a7oO7wCOmzh7l5EbhllIucq8yaFWP4p5mEAunMRz298LuQ
   g==;
X-CSE-ConnectionGUID: 7z46an6cSh+WP+IiEbIBnQ==
X-CSE-MsgGUID: gyAT7zf/TNCsvLL8ffFxig==
X-IronPort-AV: E=Sophos;i="6.08,182,1712592000"; 
   d="scan'208";a="17896423"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2024 19:15:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqqpjXMxXKdtFbTbXUOE66OLE1LxhRBq09ZD1A8fXL0EAwAmOxXCSwVgUbRfV++L+t5xTOhFNMSzRkP66BsiqD6Obt2+nyv0hsmeJrCbD6UBquEmkLrNNJWydWfe/mX0mZS5gLLyykJ8ou12HfcrCEP2RKXWFm2RlJjzCdzJGLFRpUUNc2nw87AG8V4oH4BaBq/M+NTnWVvgFpfja9iemfNt4bvpWSBTB3npnCCd0482fzIr60MxlDBDSN0+5nZb3YvaZwU/orfD9ptbFfs2vmWPuZBTqZd439UW8NFt4G7g4pmYi9LnK7f8HIA8/UVnp9FlxT5OF1qP0ssty0SJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is+jDyQ4Vul6+VTB3FxOheiq96UEjfu5jOBXAf8SftI=;
 b=KKIAbhj29N0+ch+BnwZT6XYrizqvWwvtFz9nosb9/pptJ1K2PdM2FlzOT6f1zSUi7YpgORk1rf0cW/Hcra7w6sFnO6Xcxfe8o5N8V+19p2dsdon8RFCAwg2xBtjxsdKjfpla95gQk0wVQClbRLMfOZ7+lNMywxeJq2OArnRL7C0Y+Uh5w6ZckssyoFQgExJg7Vr9mkc1c1s9ZEN2CRflBPsd8xYYFdqQC9N2gktGM0D2/cEpLGzbNCWS0cWD4tIYBUvP/ouNOc3b9NoKzZ3EYFUR6CwqnCetGOmEflPHYbw87iSvaExKozqatTu9hdWPb8vdYiUUGauy5jcsl5kCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is+jDyQ4Vul6+VTB3FxOheiq96UEjfu5jOBXAf8SftI=;
 b=l/DxpphwRnEmT8Vsb+uYatIXRwY3LgRw4LJK8GvJgIutqFqk8WUNpRy4eGr7tTqdBDRsXbdI9+l9RVakKuPx9qwCSf/QFkbynImqgDFPnB1YbimtIw2vBds3ZsmNZYTBNbrMbckFUqUNLltiWTSOhgvTOlrEVkhA5OykwH2F5Qo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 11:15:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 11:14:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/2] loop: Test to detect a race condition between loop
 detach and open
Thread-Topic: [PATCH 2/2] loop: Test to detect a race condition between loop
 detach and open
Thread-Index: AQHaq9A9Bm0odGFJG0ekI6huQi5dBrGkrT6A
Date: Thu, 23 May 2024 11:14:54 +0000
Message-ID: <g7c53po5btgdyxr56c2vxmyv3fdkcrq7qwcbeowjd5bulgqlvc@d3viig3wwgo2>
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
 <20240521224249.7389-2-gulam.mohamed@oracle.com>
In-Reply-To: <20240521224249.7389-2-gulam.mohamed@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 134b8602-2453-4364-a792-08dc7b1992ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jBFQ3cq2yk80B8lObATT2NHFjMCWLdqFeCrP0uwyq+uTsiyl2syn20bwPoVw?=
 =?us-ascii?Q?Et5C34gAl3hiSPuAHlBVPKPgyHbVuJpEUQOiKiNPuB6YkbF4+UO3RaU1NCF/?=
 =?us-ascii?Q?ybKHD1iIdghyNe3oC0bIqOzYkRWhKV7pbiBt3f5fH47/AcEha3wOM12MtNsH?=
 =?us-ascii?Q?hXuJztsOUlrgkaAOmTMtM1yAHDA8Z86pFHGULav8ML/kX2dS4ZxHjFBZANpA?=
 =?us-ascii?Q?9ioIjxajhgdrBIJEvw6NcllbCgKNZ/AOm9dNGH0AwDnT6LSKQ0TMjmP2uN49?=
 =?us-ascii?Q?TEGx87HGRGBPW8xCXVDF4cAVokZBJ33+mb0aST90CD00N6zRMWxZuDvfHR2l?=
 =?us-ascii?Q?1wIeQhXKM+GK1YllzYDnys3cDmEn6LzATE2wxALYafYZty6OHWxX9NeM/C7m?=
 =?us-ascii?Q?9/+4S2jya8mC0RkAZDrpx21ANlYg59Ij3o1Yg0F50V/ixiXc5bEJremHPElT?=
 =?us-ascii?Q?nRskCAI7JpWNjf5g+w/y7hL3aCdWLxHQKkCpFHZsj4VJyWozCnLWTk5qo1II?=
 =?us-ascii?Q?fDey4g0lNs9CRtCGvN/VilS9gDonYMZo3ayTTbRIBbiHJ5gkp5pvV1U0J28d?=
 =?us-ascii?Q?4tRaGfq5BIPutbSLnQMgCdnQBCtINzIONskyxTs/lQtUYPbRjoXYfPpSUVWV?=
 =?us-ascii?Q?f+xl8h0gCiPL3FDrrggYg4Cp8phr+eLM7rpxihHpQqjB47QJzcVSorPEXOAV?=
 =?us-ascii?Q?noqAOs5M4xJ7iwVTM5qDqwnv4PIso7dtm5WZsWCQiVUNbw/IU5Ufcew6cr7x?=
 =?us-ascii?Q?ATwIg+dn7d+tNRMYgIaAhKvuLquB2VYA4kPy3JuxD7EMHrNUIvfzPaSlhEcy?=
 =?us-ascii?Q?aY8vRJLnOkdnFAQQra0Mvx2j2+0hCBobpcreoapUhREAIhJrEKhgDEcNtIkT?=
 =?us-ascii?Q?yyKBim8XuoEINBrYcWD2NbxEFmZXOlKgFMtTEzVHMZZ0o45cGoX5cwU6rbRA?=
 =?us-ascii?Q?JBXkvTjBZylYCCgKT1NYXXgEN3GhPkiHeDs5keRQLcNIgh271j3wakbyIQAa?=
 =?us-ascii?Q?WtwsPrrpH0EtZ8cYTmQFOFhGvhc4LfJ0eatYRh+CC89jCo2X6uUD3CI/YUHK?=
 =?us-ascii?Q?PZ+X8NH1XPSn6P1B0iZdVOmT55G1a0mbs5O+r0bYCBgkIEE/66HFyOAmvQtf?=
 =?us-ascii?Q?OSc710ZodXJSelmcP1R61xFSDImK1quqtOYdPvouCNb4N0T2pOsPBtJWbxSF?=
 =?us-ascii?Q?jwTmguytzxNA/xK9HdXBG/a8BjV3YBJfAytMiT/BwrkCElGNdhNsP/E7Twt1?=
 =?us-ascii?Q?hrqXii79xOkUnvZEKxOJQI1QbzFgh5FtUVPHQuxk/L0MnlJjXWlIqXH6fRB8?=
 =?us-ascii?Q?mdaG48PSZ0nISh9Me7CrFazEHwr3/g+8DmgGGpDSdhV71w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ha+PzD9jv72ea+1qnZeue653h3+HvK4VZdDvD8wpGwV9P/yDv4PJwzzhPNey?=
 =?us-ascii?Q?ixk7/D1VZwHB/fODVGoFc/PZbZtEoIn/uqYgpoETvZv+ZVdjIZBq6hLyqOaA?=
 =?us-ascii?Q?tUri4yqXLpYzVEN7SyjJo6MPfnNQiN7hjKJnaHsrcNPn1sCOOA5WJLSc3CqF?=
 =?us-ascii?Q?HqXYIIXePMzkHD6nzzdwJN5LN/mXg3Kdr3PzJUDjI6/YS0F/bluaMhLSx9Pv?=
 =?us-ascii?Q?8qst9jtbGaoVDoGTPgGxRKpqEYqlTS8PAyUchP47Pd8lrU99vcBUessGB/5w?=
 =?us-ascii?Q?6fSLSyEiaC0D5xpSqmDyzUUoc0jY/3G24h1AmJbLxodwEG2wvYWrl7YKXCNi?=
 =?us-ascii?Q?ukvNcCOC5dEE7Qz6Y3bLOfmN+vBGQ3S25tWTUozPg4UfEJkzt8BaYn/a60CZ?=
 =?us-ascii?Q?Vx7wYwrfd8lLGyo+zcFCZHFTHqVIVbwkyrJpHnuq+Ez3w0BJzHSmHlMCGYJQ?=
 =?us-ascii?Q?ZaKIYujEkoQVno/gajgf1dW57cD0bd/VA2TufPJGikCTrkvImMlKf/7UDHDB?=
 =?us-ascii?Q?07dDMVcpg2xvbXEKaT8y0+TKH0+99BfBqGTH1nEBSc1jmKCtS+kD9w4xNbSF?=
 =?us-ascii?Q?z+MPvKLl92Fqfq+5lVE3Y3ebxMyODU78L2hcV9ch04sa918KwgLkz35vga3m?=
 =?us-ascii?Q?pyrcfiYkGSuDcE05SHOVXDR5M3kpntyyus21KlGNEbZ37rHi08Svii2S7lza?=
 =?us-ascii?Q?MDZuKDHKIikRxuwPveMn3c+zUBQJKX7plyukOSLVTR1E7mEgwCb5X7b2z6Xr?=
 =?us-ascii?Q?rwqs19bTd3swLzGVJgRdMxfjltbznGVtqXMDFU3vEl4ATjX0uHiAfJ2XV1Ng?=
 =?us-ascii?Q?3OM5C/yTDa2/BHEFxMbt71ZTVXGGy2yzNUkBN2/8E+1KSsJeiPGTRW8VUycW?=
 =?us-ascii?Q?LUZ8e/tZKFPIcgonXw9duMvA3fspgqUATih1JlCJPE1As392HoBsEgEHUQ5O?=
 =?us-ascii?Q?M+9nBSDWDvBCRKVh7dNr+nHEW08QZza7JSQWAEqJHHlt0D1o8OKd8ieH/bSg?=
 =?us-ascii?Q?3+vv4S6ZlWqyBrbus52MB4PY/l5k70+zZcFVeWvV8rSHcSk9mR9MVYnFIbr+?=
 =?us-ascii?Q?o8nfo7qXAz3mvcmaZaYFSeYSs5N7qfQztI0kntCK3yP8Nt9F7fWxFSomJbv6?=
 =?us-ascii?Q?kspetqNQX8ojRxMQYrXpzQs83IaWiSeGnseORc9V4KtvrMq+Ut5gYHuDVnSH?=
 =?us-ascii?Q?FWmc4z/FGAeSMGvusDuF08/335st1bK49sTVfT2DddXn5QKb13jWxQm9L0tX?=
 =?us-ascii?Q?iew/TjVjmE56G3GcQJHMfcX7CCAdAXgJAkKt30DbAdyImyL5IR4uWn1l4n4y?=
 =?us-ascii?Q?RmcADomjgfMToo78ga5XyPEwNKEs5wcPyOd3O/ddzA6fxvVaXB2xE8quYaOv?=
 =?us-ascii?Q?8MAzNe5FXf2ta4RnKXTLDoiktiD42AmpxqygwXRcfMGdXHCTFmLLXeQYuDi/?=
 =?us-ascii?Q?ByFBlaxXy0qCd02UEPnZQ6YbzwXwz3WK9QKUFqk5Vi+e9fQzPNR+nosFKIVT?=
 =?us-ascii?Q?0AZhenPKaTVIpwh0xv712Suz/Yv63WnHBm0+EPjKwdnL6H6X0gcS1dh2CJFQ?=
 =?us-ascii?Q?rDoXisFV5TM9yT9/KbbNHR2uaURAz9O3xtPVnL8cuTAsT7ZjGumL0vn6jkSb?=
 =?us-ascii?Q?/QjCJetFxIitXXBtP1EBgF0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C742D93BA305A64FB9EFA0BED71AB44A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ECCyOezOqH6FuUZw7z8b36+XDdFld5WdgcDKTrM4RQ02wwow85D1tu+ovomtEHKeN7IKrbGA2beoJTK6U8I8soaRG2cSKMFXZun9cIYd5dekQ5hZ8e8uDHrOVKtxl9zXgmMpdhWn8cRxu4ey38z02kcfr0cpGjol0uRRWTGyvi1EDViTN9PpR+r7KTlX5mezbCI6c5Z86yq9iE3V9q/9nUxzMnRFPDjSxFbfTBy0Vbz569Djqr87jeaiD+boEoMREpWXFnGcgS4wmsCsa1MRTGLebbTzt0nXvBh55LFL7Yl2D4gYGMMwMRSgigMR/paHHQ1GwEJHfCx27R8SmHFqu+aPuockv/7zGG9E37ukbXb8YgKdf9GXv2vVN7d4HkASTQBhOxC2UGpBhsr8jCUyCInvbAP1CtBja6xYqzTPJpl6M1MzhaOIgabkbYmU64AVduSo2QxFxrg0wIXEUUmiFWl9XAFfigh5XJUkQxQ1hDzBTSB1UQihu8OOhki+8VLJyuj9P8OJ1DOeAsZPcol92YR0xQIAX26xAfC7JGxJ5tLsbXwELXTjCya9ezswjDhhEb4vMtMI6DgLIsPn3DLU3ekZm/35fITRzAxnPACRfQneOx5+UcHCm1cheCqz+pZ4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134b8602-2453-4364-a792-08dc7b1992ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 11:14:54.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cY1d4bHjjiogGBhktECbqxMvY4pBIoHnxtg+TkMPPkRHWvak399Zk/qyWhw+Lwo3QwcP4nxhK5hbn+6ajtsY1SiKiklNhULrucLOxDyJIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886

On May 21, 2024 / 22:42, Gulam Mohamed wrote:
> When one process opens a loop device partition and another process detach=
es
> it, there will be a race condition due to which stale loop partitions are
> created causing IO errors. This test will detect the race

Hello Gulam, thanks for the patch. I ran the new test case on my system and
observed it failed. It looks working as expected.

This is the patch not for Linux kernel but for blktests, then it's the bett=
er to
separate it out. I suggest to add the subject title prefix "[PATCH blktests=
]"
to this patch so that reviewers can tell the target repository easily.

I suggest to take a look in the "new" script. It has some guides for blktes=
ts,
such as "Indent with tabs" or the global variable "TMPDIR". Also, please ru=
n
"make check" which runs shellcheck.

  $ make check
  shellcheck -x -e SC2119 -f gcc check common/* \
          tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
  tests/loop/010:23:17: note: Instead of '[ 1 ]', use 'true'. [SC2161]
  tests/loop/010:32:17: note: Instead of '[ 1 ]', use 'true'. [SC2161]
  tests/loop/010:84:7: note: Double quote to prevent globbing and word spli=
tting. [SC2086]
  make: *** [Makefile:21: check] Error 1

Please address the shellcheck warnings above. It will help us to keep scrip=
t
quality at some level.

>=20
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
>  tests/loop/010     | 90 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/loop/010.out |  2 ++
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/loop/010
>  create mode 100644 tests/loop/010.out
>=20
> diff --git a/tests/loop/010 b/tests/loop/010
> new file mode 100755
> index 000000000000..ea93a120d51a
> --- /dev/null
> +++ b/tests/loop/010
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024, Oracle and/or its affiliates.
> +#
> +# Test to detect a race between loop detach and loop open which creates
> +# stale loop partitions when one process opens the loop partition and
> +# another process detaches the loop device
> +#
> +. tests/loop/rc
> +DESCRIPTION=3D"check stale loop partition"
> +TIMED=3D1
> +
> +requires() {
> +        _have_program parted
> +        _have_program mkfs.xfs
> +}
> +
> +image_file=3D"/tmp/loopImg"

$TMPDIR is recommended instead of /tmp. $TMPDIR is cleaned up after test ru=
n.

> +line1=3D"partition scan of loop0 failed (rc=3D-16)"
> +
> +function create_loop()

Nit: the "function" keyword is not used in blktests (there is one exception
though).

> +{
> +        while [ 1 ]
> +        do
> +                loop_device=3D"$(losetup -P -f --show "${image_file}")"
> +                blkid /dev/loop0p1 >> /dev/null 2>&1
> +        done
> +}
> +
> +function detach_loop()
> +{
> +        while [ 1 ]
> +        do
> +                if [ -e /dev/loop0 ]; then
> +                        losetup -d /dev/loop0 > /dev/null 2>&1
> +                fi
> +        done
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +	local failure=3D"/tmp/failure"

Nit: some local variables are declared with "local" keyword, and some other=
 are
not.

> +	touch $failure
> +	echo 0 > $failure

Why the file is required to keep the fail/pass status? Just a bash variable
looks enough.

> +	dmesg -c > /dev/null 2>&1

This kernel ring buffer clear will likely affect test harnesses which run
blktests. To check the kernel message generated during each test case run,
please use _dmesg_since_test_start(): ref nbd/004, nvme/003.

> +
> +	truncate -s 2G "${image_file}"

Other test cases in loop group have 1G file size. Is 2G required for this t=
est?
If not, 1G size would be the better to reduce disk shortage risk.

> +	parted -a none -s "${image_file}" mklabel gpt
> +	loop_device=3D"$(losetup -P -f --show "${image_file}")"
> +	parted -a none -s "${loop_device}" mkpart primary 64s 109051s
> +=09
> +	udevadm settle
> +        if [ ! -e "${loop_device}" ]; then
> +		return 1
> +        fi
> +
> +        mkfs.xfs -f "${loop_device}p1" > /dev/null 2>&1
> +
> +        losetup -d "${loop_device}" >  /dev/null 2>&1
> +
> +        create_loop &
> +	create_pid=3D$!
> +        detach_loop &
> +	detach_pid=3D$!
> +
> +	sleep "${TIMEOUT:-180}"

The default 180 seconds sounds a bit long. How about 30 seconds?

> +        {
> +                kill -9 $create_pid
> +		kill -9 $detach_pid
> +                wait
> +                sleep 1
> +        } 2>/dev/null
> +
> +        losetup -D > /dev/null 2>&1
> +        dmesg  | while IFS=3D read -r line2
> +	do
> +        	match=3D$(echo "$line2" | grep -o "$line1")
> +                if [ "$line1" =3D=3D "$match" ]; then
> +			echo 1 > "/tmp/failure"
> +			break
> +                fi
> +        done
> +	failed=3D$(cat $failure)
> +	if [ $failed -eq 0 ]; then
> +		echo "Test complete"
> +	else
> +		echo "Test failed"
> +	fi
> +	rm -f $failure
> +}
> diff --git a/tests/loop/010.out b/tests/loop/010.out
> new file mode 100644
> index 000000000000..64a6aee00b8a
> --- /dev/null
> +++ b/tests/loop/010.out
> @@ -0,0 +1,2 @@
> +Running loop/010
> +Test complete
> --=20
> 2.39.3
> =
