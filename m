Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="irJctheM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GtVGTOef"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC041B4
	for <linux-block@vger.kernel.org>; Mon, 27 Nov 2023 21:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701148199; x=1732684199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BevODAili5CnckiArqupoJYs7JVWpfkDPhZSaCpZc9c=;
  b=irJctheM5DxUt23Hyfy1nf9arKQTx2sKXBr5HhmasdFTD+WIf9uiX9lZ
   1ALMuCXOBQMRtucOF7b9Ki8G7Lq35vrLr63cEP+xPakJA6ukJ6l+tZTDO
   Z5UzIFBaIk0SXnKbhSazHPCuFFsu0o4AOhUS2VAeZiXudctGCqs7/D9yw
   4Tqwn7O8JJQNE4mPgqljnVgEcvAv6HcqWvzaT1likCwjqNShXi19GUhfG
   oOErcGVF+JyskrsasSZq7LGIw30owgUx9cXBrY/GdmkNZkLzc6wDcTi7H
   12zfyiUsrxLxBuuKpPMl5DUS0UEobVJNPT3F/tLYoVcFZrEzSFu2JwNCO
   w==;
X-CSE-ConnectionGUID: cD747eQ1Syuaz2DBTqNzlw==
X-CSE-MsgGUID: wd4gKmwLTcyHmhFNQ3RQPw==
X-IronPort-AV: E=Sophos;i="6.04,233,1695657600"; 
   d="scan'208";a="3583182"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2023 13:09:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB3XqDW9Pz8LxYMcBJno1SXF+2MBSQz0l0I/jOaWTKTQPxWVy89MzAVHHpugI3FZd5ttwpfx4j0kxAn09dxY8Jc3mroeisKm+1OZQVcjMiAe17Ki3H/IWq3L5pA6l3qQGnuItob7+0FtsswLFV/HyXGMRpTNZ4eogYcb5ub+B1KulW7zKi7jYH0LxfKAlrxHQS5axvAZEc3GsWDnfUlqVeV/xBQC8tvxO5hu1CXujsqSagTSYtqDALYbgvDrwbaDmhsAgNoRBxJ9oSq/CK9Xtjz24oYIwvvz1mUbRjFwWc5IjowPn5B554/SYA+BWPpY9pXGKap/mOD1xpo2tp6eUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB8H0dhLbT4dL61fE1yjhFrASf/L+eVNYyTMp/AVxQE=;
 b=iCOOcB03OijYgUrOxFWvbcxEbU7LDl/SNioKJrxm/3HLge6QerxzlweQc6Nn4AIMVTLOj+OtWrupNVN7upt3IffWfu4kH9LrJPRyOrKFCHE6/i/coI9bcSTTTz2JAs2cFcUnWe9xX0GFTuYLMap4uQHvACMNob5mCy+gBgowt1EeFcYu8u3FpdZDDcWMDGHHoHckxptLuXgho1i+1Eq/on1fGZfe+DUGm7A0h3p/KfAzUAd1m+EtkHsWHy5LQCM18GDptK0wncyuNB95PJfDJ3PU0Yzp7SLQ97U5nSnU05FxMVQ3tkN7iPj7+QaA+P+23Hl8P2tzISfxiqUrOox8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB8H0dhLbT4dL61fE1yjhFrASf/L+eVNYyTMp/AVxQE=;
 b=GtVGTOefxsRn6xhRCr40nbYoBH7xsuRs+rK2W9ebX2RIiQryNykuFn3ZK0n8EZ3Urb5mxEmYaKmWSjuEvKJrKHzAwJSrtQpqHeA1mdZNm0v6mD+Akew+8Kx907Mo0pI+tUVzIzSWpNo+qJIb7ueFqEqpIT4RJAWzjMt+gfB5fJM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8116.namprd04.prod.outlook.com (2603:10b6:610:f0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Tue, 28 Nov 2023 05:09:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:09:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Hannes Reinecke <hare@suse.de>, Daniel
 Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests v2 0/1] nvme: require kernel config
 NVME_HOST_AUTH
Thread-Topic: [PATCH blktests v2 0/1] nvme: require kernel config
 NVME_HOST_AUTH
Thread-Index: AQHaG1w0EfeI8I0LTk6pGdjcPeSrqLCPO4eA
Date: Tue, 28 Nov 2023 05:09:56 +0000
Message-ID: <hwuaw5rieyhtxv7wwdfhqs6k2jl7c2p3s7vqkofdbvk4pzrn6o@kb5hf54qxwvi>
References: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231120024931.3076984-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8116:EE_
x-ms-office365-filtering-correlation-id: 6960ebb3-58bb-49b5-515b-08dbefd04336
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Idy9NAa1IhAjsrJKoz3zhBqGiReO4uWlfgeKcyi/ZcdkDS09kFs81cO5BEoxe19gj2u3XMurSacFKpxB5mnZcLmfh/7M9hcQF0zb08Nyb6KWp+rX2ZLAWs/n1uYs8mwFa4vB2Z4SHMwe268lMMGTwSf4Qkm1iHIf7K1BUq0bxlPP4AaV4pFAeuBOxv7H0OsDpgBxtcw79SMZ9XJ/KKTpvPgBBRlpitXIt9YzWkBb808tYnLAPW9J3/yYKBGSZiMfvV34BOrfVsri/skH+TLLlXbs90Kwe6HRyMTWht3dvvp8PtjWUfGo3x7RUu5af0sdewtVqlV04DXRgKj25UWoeizjnDznjS+bCnmM9MgC7AHBO6wG6Oy3z5+5q5NHlWtpuAmWKRZAiTa1hwIcxtzv0jxFfXoxB0pdEJK6fO8pdUZa15Vj9diUNdxcjbg8Lt5iah8Cw3IyBowHIf+SCycArYnY37qDeFRw81muhqcrzcU0ww8aETUt1RFTHNxzCGIYUpkjng6VwRhpkKfrhL4han2iY9uvTA8oSEkIyoaodY6gUBtwc63rfWPC904loTc437IUTEfp6ubIfD35ZT82PgdmHL/oQK2wbSYZpjHgof7l/3FGk5pCJIH+YxSuq64Pr5sM8Nh8u/3G8Hk3KBYqWw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(33716001)(71200400001)(4744005)(86362001)(5660300002)(2906002)(83380400001)(38070700009)(44832011)(76116006)(8676002)(66476007)(66556008)(8936002)(66446008)(66946007)(54906003)(64756008)(4326008)(966005)(110136005)(91956017)(6486002)(316002)(122000001)(26005)(6512007)(9686003)(38100700002)(82960400001)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f0EiBqSe2HfRT++SGy8VOqZk4ufWEhnVHmdb5BGX7/VAH85Bm8jn9RuhKwWQ?=
 =?us-ascii?Q?LNSg+j21SmrGLX4B8+JpNowBj2cJ1um4y6IdBG+reYR34qHiZyJUP9luLidi?=
 =?us-ascii?Q?g3s08fDcYdAPRfPSJ4mIvQsYlfDcgNPwofswwnlm6s0ABsLpsWjcHw2zZHNC?=
 =?us-ascii?Q?y/gT3kZlhX4XmlhvUpchTpMHlIEsSSQcBmpdNvwzuxJHn69OzxaEXnMeCU4Y?=
 =?us-ascii?Q?5uVQ9SHFBqu4+1bkawsBGQbE3WkwGddnN/5Y5cdosm60JRFk6sUsZzqzaZQl?=
 =?us-ascii?Q?KMwVqPq134ZmMFlpj52bX9ckVzgHSzLhX5TivJkMPEIms+YwiEKvkPxyGfVR?=
 =?us-ascii?Q?d0Y4C46IsvKArb2HUMdY6OyT5FHnpCuO7JDHc3bAkf1aWKglt1loopeL2pDI?=
 =?us-ascii?Q?Er+qXFFVrCcHdTPr5JSerzsBLgGMLOHVTenTjY8qYVELFZkwRdRgsiBJ1Akk?=
 =?us-ascii?Q?iYkvlyg4bt1Gf7TIxzobvm9hzPdbPadjf+mgTjq71yZ0H1g+/akLZfvdf6vx?=
 =?us-ascii?Q?uM1eSF77lsBjAAKJHmYS08dt8PRH+UTngm8bwJP/Zf9ZKVBErqddlqu9I7Pe?=
 =?us-ascii?Q?Xph9MyE7rwyGP/T6l3gWDmBPnGrzKZv6e7Ybh+qvvO1QmobdLO536/S56Hmb?=
 =?us-ascii?Q?Lz9xs28yUshX86of7N4W4iELi9kRwgRxbyqQ1JZLgW5TWb4NpYYSoW6G4QBA?=
 =?us-ascii?Q?RsJZWRdoOMzlTTWNLMcvUmY3ImERJx0pbXxpfpGoR4+EbGpv1ACOKTycMTDX?=
 =?us-ascii?Q?QmM03vYNPLdbg8PPg7DvtdaCtOKNot/ZBOSxeyAOyRIF5t/nEkM4MH3deOCu?=
 =?us-ascii?Q?yws0VnkHEnH+beZ7snbDzEUV9HyLZm6ow59aJU+Tu5c6FhbtwGmCiXIqgWWS?=
 =?us-ascii?Q?B+VfUg7IVF9ETSP9dYj0D+bRyeypmiSwDZuo2u6rWurHZ0zWXMPouU5HuVy8?=
 =?us-ascii?Q?44oCZu3BVhscL001FxPxzpA/E20FpzgI0CSeWH3C6RidLXh8qb1bAiNYMNC4?=
 =?us-ascii?Q?9xrJPkfKdC+m27YF01dU/Fc4L6Q3uRf0obqNX89nJIcpJLcxhFpFH5xwLSHO?=
 =?us-ascii?Q?xoMdZ94Ecev7qPp1lC1OtyPKIC5ZT2r5qkPB9eN/ju0YD/5uSVpu1MWkkzeK?=
 =?us-ascii?Q?gUN9rqkvS86QbgBegDOMXwWfUuYna5+K6v+HBzIPnYCtY/i8fZyrOI385L7b?=
 =?us-ascii?Q?3JC3yBOkDBBNxnBNenXMTTeQ63qwNrhmH86PK2K+tIB8HDO7pMXSMEA8iGfz?=
 =?us-ascii?Q?3UsPmUgHBfZdAy7UtL7wu9tEStOjhG6PFYwSM2Ek2w6o/QXduDN2HIVN3Vs6?=
 =?us-ascii?Q?tqH6gLRLlTULi3VDqWCUH4vLMBk88OV3Lws9mgqpD3dGnA+zmrH/dmMIL8fk?=
 =?us-ascii?Q?WClULCpToeSnwov8aBNDP6LFaIdp8MdU+7TmLrahRHDaXIGbr6kTVBbUHTpN?=
 =?us-ascii?Q?t9r5QDpI3EEH2KXKrd9mhA0qvW31ScgV1Uue1E2mkcfcTr30ZNiUbZsHhvhf?=
 =?us-ascii?Q?cMJ8hfkElejqFG2wzid0vG3Uy/ZSMNs0aO1lreUl88WV9/kIFfkpeLZwdS9h?=
 =?us-ascii?Q?R1gFVKxIXKrROyfccITClTX5OYcjWy15cVrAD0umky73RGGGw6/vfHjWyBCN?=
 =?us-ascii?Q?I9ru4a3lXCfJ8KRyR0wQcZ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <601F8BA0DD0403459D3F7E659BF34DCB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3RWEAxsijdVBy/ZkBWQdwo2X/+EFZEEjH7ULCO2o6d4xbfXxbJeTsfuuZextdYu7uhJeJjaCn8DHt1haDBwtWXUHU8tBucNfPGUIvgn4aWhh2AmUPGdA7W0mZS/E5sxaNwdm5HFbp6bNNMlkPbFKciRaZSoLkmVvuGtycRM01IR91g3N1xx3Hs0SwdysToiJttrOcx6B8FeQNdhtjjwVnG/YLPI59SgMAQO536EqNeJ8SVL6Es3iRTcd8RlzO53Y0F+BEbzaAFiv1T9RnxGBMrBBdioubcvxm6kgS/afQF99FKvGTTWL523QvCkXTsw0FmITpj8RVhjxhR2ef0GoRFtR6JSabH0EbdipH6yfSm9J1KZw+IPsh/Wp7XOEwHSXHDkrIvlgTDAUvTsaQBwqSKqbleVMXlP3ayXWKtGwCCKTaKJHllmQBCpfA4TlESyzo/jLNALk3yAKb1iUvvwAD2fjFiK/bQDmIoyPc7POWetcirb7zX8j3R+d1utkdfy9cEdBBYOoVo6Mo/jfKOVI+WfvFlkUodihLE6j+aNfbDvHyf2MzWdI9cfaLCOC8AdLvzV2Sl7WGdWadAaauL7m2FKtAlwqZdtNya4RykOr3ry8IDPdNOsCoHU9ivD/FOlQ9knfTUJZEIg23iZ6p2gJuTFxU0MGiTK4cOdW8rSS7baAdqM8Pasvlhd7z9m+jU1UjpNt++qQZSADbgR0Rry+Ane9tu1q/dx5leaInBsXKS7eMDZ37fSlszrWZValUOAkdJ7n2riVHFplz+/ktAwyEGptvPWhaDw6SMwZpY63ALTNC4zcn1h1O/hagEch2GgRBjsB0c9tvUiO0xWmCiKOttMF0mgR9aHM9x82xiwXPK5mznpJP3hr1IFNq2pntG5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6960ebb3-58bb-49b5-515b-08dbefd04336
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 05:09:56.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2rVtXwo1M657vZjtMuF4PUGYfNvlIUJWPBaeEEN3AuzRANhky2T33GUDvGi9iEXZTprHmpyCFRE1TiUtswRy3j+6PPIT+vlrM/0hGOFHcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8116

On Nov 20, 2023 / 11:49, Shin'ichiro Kawasaki wrote:
> Yi Zhang reported test cases for nvme authentication feature fail with
> linux-block/for-next kernel [1]. I observed the failures with kernel v6.7=
-rc1.
> Chris Leech pointed out that the test cases require kernel config option
> NVME_HOST_AUTH. This fix patch modifies the test cases to ensure the
> requirement. I added a Reviewed-by tag by Daneil per record on GitHub [2]=
.
>=20
> [1] https://lore.kernel.org/linux-block/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=
=3D_mYiwuAuvcmgS3+KJ8g@mail.gmail.com/
> [2] https://github.com/kawasaki/blktests/commit/81110ce8056f16716d09774e6=
f237ea0393579e1
>=20
> Changes from v1:
> * Refer nvme-fabrics sysfs attribute to not rely on kernel version
>=20
> Shin'ichiro Kawasaki (1):
>   nvme/{041,042,043,044,045}: check dhchap_ctrl_secret support by
>     nvme-fabrics

FYI, the patch has been applied.=
