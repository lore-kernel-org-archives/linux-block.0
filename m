Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA4430B95
	for <linux-block@vger.kernel.org>; Mon,  2 Mar 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772411447; cv=fail; b=KKD3HUBCfXjBw2bzSaqZSb4iIijfTi5QjxPThljyoDjLxGSmEpB00CevijAuJeP2Wg6QQRKyOSsmAeCKLhg8/xhxHoD5EJRKXyk3mJj3+XLJ16dZzCwrZR2V8xFhPEUrUTaAFSvzaAyggT0HVRrgU1qGWoN2RrU4/TxOZmbj7WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772411447; c=relaxed/simple;
	bh=nYzsACfaFP+dDgPrEdLe2hnPM510krV95u/3xDofwwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohYdciwlortyUyUsK9xM6ntBKVVBljsMJOZVih1JdOdTj0ycHeLy9hgBU4SwRFPKcQbpELxtYOdiLAC2EFeDQcgXgsvMx9LOWafopMZeNEYfbO0kKxwJptxh2iPbhAXmRBY/y08ZlEdL87Wlpp4UQRNoNnFnUrJaDT26mjoZ/j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RhPTcMr3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iCaSLeEL; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RhPTcMr3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iCaSLeEL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772411446; x=1803947446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nYzsACfaFP+dDgPrEdLe2hnPM510krV95u/3xDofwwU=;
  b=RhPTcMr3sPNXIucxG/31ef4HX7ANnzn9FcdIRHATmMhJOL2ZQrv92WlV
   efUrnqfRyYnv270TZu8BdW3meCPvgzjdrKxDpE3OJOA+ODkd4Cgi+WBy4
   6A6UJosouWsvgHcnl9GpUeQkJj+BW0FgLXbAxVjlkNWgciBNrETY0xR0e
   0/Ay8k/WHUee5ECRsRiAQaphgdaBWowT9Sp0+MhMiGBI9ZErNw22y5LOj
   5E6wyOr6JaNE/EhaT7pI2hXLEgc+9DawNGDrO8o6VO1E2caSm0BMow8u6
   EQA9zTWiJnhjx0Ox/mV/kxBDwwtWmeXe/32QAC1LWTHxbBrp327LUdpYX
   Q==;
X-CSE-ConnectionGUID: 0BlMiHTjR1eI/Ot3R7DJ4Q==
X-CSE-MsgGUID: K8PEqD6sQsC52TeJJT4ASw==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="141301308"
Received: from mail-westus2azon11012036.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.36])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 08:30:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZUkBu8HEMzdl9pBS5XynKItQg3tPGbvzYQ447ssH5T2U2y50kqAdx3IBts+9pHQZ+9cef+txGv3bDFW3quAXWnr7aknnw2vdyAoZgqbosSpbCXroVtmsh5pFVwbzWT7qTvFJ7GmgBDMhJk99oqHEesOj8sWp8yd9l+JzHzh/CUg0mXbe0+i4c5SkprFDQFwYXJQUzjPrEwod+8L4op1DE+CC+0bmnSS3ItBnqbfsty8FJnoGcKnKaKRgSqodAt0IEwtukkKFc4vSZJuiybg5t5wXjKPPYyVuAHQ9N/HjBleG5Qf5j1PQvsNnqCGzpxhKGYq0ih6SyfbtIDOYdWHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s89S79eEcfnsNviT8aqDNBCjsSxWjJ6YGo2cEkZDIo4=;
 b=Qc71G2f6wauJolawPenHuZoR4vH4KAypsZrpKXfNP94H61s7HHG02zTOX7xo0Dr+59oKiRhITg1hKKIMPyG7nnEbAuJHPHBRb93i4ybRjbyGDyq7smwbHlLfuiy6Y19PX9oYvTRqk+NqSOTAMn0eE+t/NZIqAT5HjMdgnj+4S6n8TDIpsLgbMGnv0s2KpBM6DbmXBH+8ZJ8Zc2CNHAcJNa5c79Nbjn0qoX9aYcKjCAhCAxrHDPlHEtdmQu+wTBkcxjz75h+R/iGQnIEX2Pk6poZ7VihMS5IHmkXQC4fXwW9vAgfQyBHNfyzpvsW6s7i+jv0rXdCPE4ljYZYfE1ztTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s89S79eEcfnsNviT8aqDNBCjsSxWjJ6YGo2cEkZDIo4=;
 b=iCaSLeELhIW9SIdCceuHctSyO3bRJPMud3pTRF8BJpb++iIE+zGTlV/l/BoTnrBJnzIZKRM8qkCy+1Vqa2Ut6RNRxZB2IG3GgNVStHZDD0CLDT6P9nlmXtLAd6awyoqLBe5ID9m5YSymqHqsrqOUT2/Ayl4UAy1/ijoXcLdmQdM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by IA3PR04MB9377.namprd04.prod.outlook.com (2603:10b6:208:514::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 00:30:42 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9678.011; Mon, 2 Mar 2026
 00:30:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 0/3] fix module unload failures
Thread-Topic: [PATCH blktests 0/3] fix module unload failures
Thread-Index: AQHcpHeO/lFtfD4lp0ao0goKJwhOvrWSD6eAgAhfAQA=
Date: Mon, 2 Mar 2026 00:30:41 +0000
Message-ID: <aaTaDa3m7dAIE2ix@shinmob>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
 <ad4c1108-8604-4a09-b3fb-e8f77a4abbcf@flourine.local>
In-Reply-To: <ad4c1108-8604-4a09-b3fb-e8f77a4abbcf@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|IA3PR04MB9377:EE_
x-ms-office365-filtering-correlation-id: ecad5c93-7c81-443f-2e9d-08de77f2effc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 Lu119fZFlhw1SV7DZzNBWpNASQc1/cMOAO86BUZcPANIQxeeXnE5snznC3iSXKwSoYDxtmfigbgjy2YU/WRElW0Lpf0sxZMxDzKJMRQoVniomqOmUa3UBWrAnPFtx3IjlIXevE6oWZ00aFFIM7zD72dAXueVHKkSgC2Dgzg1+EXNWpWm3BGMC2MjDoiAfCXSfhHYbBbuKX00/aqtikhvODD0ouDCjplrX21RD0gtP+yEJWFrPYha3/BfyWu6z7BB5teCrM/VWZAPlRHq5BuqZS0i0/VdNEXyeL7GuKO0ER1W77CJwwMe8MbBMoXHjYdn/mhLe7R8Bloztjm07Lka8aCXdzCCY9AmYn+UND2cQ0is6SuV5AXjPRQt7SFzU/X5ikLDWRN9Lj9py8H1fCL/rmsntGY/huCJE8+jwH21a55v5yNjsxpF0YQA70461DoetI3dDpG8doePTX8jsDiBTvLggY+apl+KSGzaMl04fRRofHLzyI4moiigoAmWmB2kW1Eh/q3maicUVtwCNQew3VgiMuwWcL+EUwFRLi8LmH5Gec/lE+Z1cFDRlNBLkgdKIdbgWheX+slNDqPu7uzdgM9exBn/kougkhjhCHX8Hltb7MDapIh/JS+pasxSW8STkevtgRn8EfvPrLJ5YfAEzKbaG5U8BiBNjyAD5JD96TwUSiVY/SWBe0DBkNmsfLhVsE53gPBTZ3WXvjii5FRvc2EVQ+1mTYe4QKgTHTSbJqyC09/ORwogDrCFSpeR6UAzk7OydqTOr742qbxxSRSS0LWpCEiDHMxRqxYc0zMLz+E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XSDohnmKfhhIiUq2GMPLAq9ScIG3TTTGKLj+L4N7vYFWwIE8bJc52/7+jZK8?=
 =?us-ascii?Q?ezPeD2iGj6JgcoCWobBhGH4cxBkumMM4YqgNCOuSwV2H1JgA+K7eEy/2duF0?=
 =?us-ascii?Q?L3tbt89bpEKs3iuZy4LFAs7eUeZnERCkPHl6tYYmM6uK88TJwhikBPeqp5Ym?=
 =?us-ascii?Q?zNXiruKCHsl5nKsvJJC6NaJAtERDF2tMT3KUmFNhau1SnQxFg0xULBvaamEu?=
 =?us-ascii?Q?aG0ya6S6Eb3EDwaGxCr+laucUWsfp91ND0iZG5qDma+sU5psqaWKNoZJ/WpB?=
 =?us-ascii?Q?F/u8ss34b+Do/jqaIBRJevCx8qg/W81Avo4miMTfRk4gxrf/kiHD3UPX/RDZ?=
 =?us-ascii?Q?1zumIQ3ro1zWRGQoE7KxWhKDtKEm7ZHeu5dyYBX57odUHKensuksPH6Ooa3l?=
 =?us-ascii?Q?KNQMtuSBIfQK41Ko6m1lUc2Q438yy+DbAF66NBkIfs9bkLCnFYqRlzmoe/qF?=
 =?us-ascii?Q?A/GOe84HMIukfqCMGVRr86mjOa8a0srEwpon1SU4Xd6X2K/Kihwi5ptotQ6M?=
 =?us-ascii?Q?BT5C8LKOnvInB2M2PaKG6us1+gc35I8Bt0sUUw1pMZ9GSbinGfhlbAoG0T7v?=
 =?us-ascii?Q?czBJAQ0quUUUNT7NwL3MuNU/9tgy+76f7T0PH3YQZcJKiu4JioHzBRy2izPm?=
 =?us-ascii?Q?OI6/1dlYUYm1YGcHeQGdElsuxzg0qMPIPE/MXZwwlV4mwgxvIapNia4MMWnu?=
 =?us-ascii?Q?H03NFV2jBXE3NilPWhJexdduKqGIY9dRBec7akElMORhx5vGgxNgh1K0TJcZ?=
 =?us-ascii?Q?4v6n7Ye7F2pVtepMl5rApPLHzjVZ+n44CPrf/g2DFo6rneTSyUw27q01GmDH?=
 =?us-ascii?Q?dK1BazpnBBD4ZA/UUwjR5E2CsLmHUt/k2eb2o3xzwjTgJmoZiABvASn1BFiK?=
 =?us-ascii?Q?C2AXi8om/+Hm+bUNaQmVzw0oCZnmNIjsj1dNy1JH6bBFrEzVfXSeiafxX4fs?=
 =?us-ascii?Q?2+bce1zx2J40sh/FpySlu2ggPrTf1Tcswobp4fETSyMfMJjBe2YgAPcQQUPb?=
 =?us-ascii?Q?Z1pVsMcMKWjZps5yl4FNydhSN5f15/IOLRz3rX8G+2HF/B1Gj5xnawNNggZM?=
 =?us-ascii?Q?kLlLpldAzu8HuGEczovxQX4do2wUj98wYKpMfYJErRvUE5KO91XGqWxn9u2q?=
 =?us-ascii?Q?mBc0N4a7d+aCV7E9B1FUUjWGECWftJ793oTozjH3Wa/CShqfDexCcngAlfJR?=
 =?us-ascii?Q?9s/qBTKvfhmBgQ1Ysneva+SejuELqYIQrwyI/TiDR77vZq2ZCAPXCTUrli94?=
 =?us-ascii?Q?BQGtM5nBI74ruWxC0GTyIPT9ie9bFyU/7I+qQ0aHwT/xUsh54dJ6RAHPLOO1?=
 =?us-ascii?Q?zSQ46uo8Q576HRQTugyKEKOjUHX4cIEQvy6+vyGhmhK+J9Zcxv4QaFCuTbLc?=
 =?us-ascii?Q?+WIjN4heN+URZ7ig+yUOOzDF/PaUbMIOVtHhEq43DwVRUF7GUZKWdoZ9rsMr?=
 =?us-ascii?Q?MiGldFXbEajSwnuRVSv6KT3hLzw8XgYKOYE8tBvz8Kaq5TuyblOZJE1oH5y7?=
 =?us-ascii?Q?84s8MgEKDPIkTnYsLe8plVIl0Ha5yXo+AspbvcecCcKWwGIVUBShHrrF6QKg?=
 =?us-ascii?Q?NwRIx66sgjd4vPz0a/7FpwlrfCjFeHk6lcNkGf/0fmxRPYjc2K6f/vBTDKa5?=
 =?us-ascii?Q?lABIP3g5zLXvxZyMwk6lH9poKBov1nr1T3/DrCVEZDt4R6eBmgdtTSguiWHx?=
 =?us-ascii?Q?kdIQzAYm4Ad3IzuteB3EzNMuA9aBNGbD34P1syPSTrcsue/GQlRmFXKGDuYJ?=
 =?us-ascii?Q?8YiaRQPG7UQEWdK7qgfH4P8ht974X4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45A748115CA69645BF5CC9C25AE6FFA9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nyXswJ+VA2YpfA3f+5XM/3xbclUXKKMRyZoiZbbwTQgmeWWUTG34P83b7CLRzXQ9dqpMuMZn8FxOsfvO4bgITIra+eNq/7wXRmKTxob6hIkrwp4NI8so8ZkZkgY/n6FYYqLulp8uV1VxjYLv2j2dBDghKmcpPiB93Li6ulJILxOovJp8C74Y4rQe0zcDG1SLIl8SOHoJlRlnKl2YzGh8cg4V9eWRPrjyWjASgzVs39Gs/Cn2MiMja48KRTeHK/WgM9Mx2ByWjXcPbnqvq9DNiTuXwtaobDg02mtJIzs7fjixDkChqErEr3GncPjtxeyeTEKU+rBfB7fAsddSrnHGU2x0XfxltQ1cFPW17R/KPyBuI603kUNk2FGhi7fdHNs689YagCenu1D0bZI9Ik9iC0QXobQoQ9ElAVaMoIzCwnQ7roEC6QYIod749SURcLVE+KkI8eiOL363o7Ee8QM60FCZDtFZ4kxntjcHtJf+FGCpLUWcvIiV53K9P3qNVOkfb38IwVikKaEGl/a6G3D63zr5UelZ35WJeINTiKKL57AUqcyvphlbB8JM+87XPj65py75I1mPJcFjy17mVzDw2UYiNqD3A0hdpUVKCkw78pTk1dlCFxhpOUeetKFCyf+g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad5c93-7c81-443f-2e9d-08de77f2effc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 00:30:42.5110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpOJuDGs5R1dVTM7Azil6fOYzP3BmLCRWzlW4svPOL3dK5JSKBcuO3OY2oHWh7mfo5iUESaDmvkICLIICldxW0RjF/p4LisRCDRiGJtD/Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9377

On Feb 24, 2026 / 17:40, Daniel Wagner wrote:
> On Mon, Feb 23, 2026 at 12:50:20PM +0900, Shin'ichiro Kawasaki wrote:
[...]
> > From these observations, I identified two problems below.
> >=20
> > 1) The requirement check for the loop transport left the nvmet and nvme=
-
> >    loop modules loaded and it affected the following test. In the
> >    current implementation, the helper function _unload_modules() is
> >    called once, only after nvme/060 has been executed for all specified
> >    transport types. Instead, _unload_modules() should be called after
> >    each run of test test case for every transport. This ensures that th=
e
> >    modules loaded for the requirement check are unloaded.
> >=20
> > 2) When _setup_nvmet() does not load the nvmet module, there is no need
> >    for _cleanup_nvmet() to attempts to unload it. _cleanup_nvmet()
> >    should unload a module only if it was loaded by _setup_nvmet().
> >=20
> > This series addresses these two problems. The first patch fixes the
> > first problem. The other two patches fix the second problem.
>=20
> Looks good to me.
>=20
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks for the review. FYI, I applied the patches.=
