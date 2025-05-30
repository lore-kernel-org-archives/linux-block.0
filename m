Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1F2144C9
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591589; cv=fail; b=ijXVa281pK4BqC54j4pcw/45T8Z/r+FVf48pONKj6tnWDAwR+yOq9e6V/K0a5D0cq5PBSOFxDlBxMkdgIFzcvVUrVRn02RtaVxYlnsp1T6/SODhoaRt3MDijGUAuDyGh5XKC8HbxGuCXAEvnYLyr6mWNQJrM2NkpZPz145k0e1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591589; c=relaxed/simple;
	bh=EheXQDigd37vvUl/s8t9iMZ0VZ3tWY3RLttQJogEw4c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHyRjrN+Uae4KDTYt+3dROSDzjUUGnhwNZ7L9MHLr/CAyIi4nCvZx9DYr2pm21yr2OlpF0T5++xHIZsFZn/2vP9DPAVSejsr+s3n26cIHHuSMeZmTTLKo7SjPPvxAokWqxe7Za6kqnHGzT5lDmMYZQbmpNWDwBVv3Vas+6jIkgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HO1KD9DW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tVclc7CQ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HO1KD9DW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tVclc7CQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748591587; x=1780127587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EheXQDigd37vvUl/s8t9iMZ0VZ3tWY3RLttQJogEw4c=;
  b=HO1KD9DWS8l4JWdTXn0tKrWhP2nCMy+OvRIpl4qGEC2nYhf74+4Ldcmp
   KwWOLkHgpsL9Ks3eL+YpWxWNa7oqY8NaH7CHdZZ0UXgY/56UB4ldlJ2wt
   FOIyaV/44bo/l/Hnc3OtqNTKx4rg9PJ7LUzVslKniH9sLE22K0Arl51DV
   0U35eejW1SOl+cXffeiOWxYOY+7h7Z12MdRG4J0iDkStmHn8r7LARL6Of
   81Trc6UnPI4XI0aUrrPyns5ymgKCb3+qG3DzxKEId6Saif76LLU3Vw2Q+
   uO5UXtmgrtvH4yl40Hqe9Jg5e50y6fN2G8KNtP0hHJuhqwr6xIO9q92E7
   w==;
X-CSE-ConnectionGUID: shKJuId2TaacL0GGV3VHKA==
X-CSE-MsgGUID: roPfqvwWSC61fAr0Y6dbHw==
X-IronPort-AV: E=Sophos;i="6.16,195,1744041600"; 
   d="scan'208";a="83115971"
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.40])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2025 15:52:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBHbbEj4DvlODd8NS+MffVrNndSd4FceuBBqYETPbi/iFRGLH+zd9SeDNs1UfTCK6UE9fpeaeD+TdxqkmnfsnO35icNALyZ+Z0ufPRwTjhdfcAerETXC1uCsrlmbU9LBPmSxKHKNe6M0Ecgfp1GiHdhBnQMyALDmwqXicWF9lf9DHFmleURohqIjTGunhpK4xS58r4HeqtD51jAJhDa9oXo+kA6sepZGZacvhnsVWs7q7MEkyKJDeF8tqZJ5yR8WAsRec38e6J/DWovtJLnNo6A2YFVLwSWgO9Fn04iBol5e+aulf8K4hkXhPFgIXDEhj81luQHapa2xPQHDsdcWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DaYDXKhv3z32piw6WzqVX/UTZEV9p52VLXCaidbKHU=;
 b=yOJ4A3jYECENUtXvSRdMTnhkRMeXzcC/v34fBIYq1BBaw9aZnBURYzsdl3ltYb13moO1qBjUmprQ8WRg22ifSbYECdF5/wpSQE0Crh7dFN6V0PCBnqhZtsWhSyMhR7Gl6oHHdNOmsZMefoPDimAb27cD6SE45WsZIB/ZmnI15g0xo0Y8RFf1J/Uk/q98shj5oH4lAuA7/WQXQKKGQfbjQw2/4v+6Es2B4GhZMvnYe/8ooiwQyzJqSkisoQEA6vyp53nXARE6PwInS3jVt2HoAtUjjlCzrPmoijU0zQxPKAcIP6Tu/seO0tSriGRzhjwj9V3XK2ChV9+ZkSzfyNFmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DaYDXKhv3z32piw6WzqVX/UTZEV9p52VLXCaidbKHU=;
 b=tVclc7CQUUIBnmB+sZ8IfNfcVXrpce/p7mtBVBd9eM8lsQxK1CJ5RSIcXTpBYVbgjpuDCFengTmHkk8hUWtewQ2bE5jcyhUwXQH3W1iNm5ECwzfecOBzA1vBHGhQiCibARCuKxYIKHli1HYFBy2mC3SWWnh8bW5Wex5XCq/K+tk=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY1PR04MB8704.namprd04.prod.outlook.com (2603:10b6:a03:528::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 07:52:56 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:52:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Thread-Topic: [PATCH blktests] zbd/013: Test stacked drivers and queue
 freezing
Thread-Index:
 AQHbzALLtqOQN1PdUE6hMcTwgzbaO7Pkl3UAgAIPjQCAAM8gAIAAx6gAgACWfgCAAPrAAIABCKUA
Date: Fri, 30 May 2025 07:52:56 +0000
Message-ID: <6767kap7ppdxwj6msorrb7uf2zpz43y2ym5t6jrfjo2vcea3dm@u3wyb5ixfnjf>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
 <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
 <fggaqqc5dxwbrvkps6d6yj34a6isbcsr7cxepg64bppinpk2w6@dkmleb5pncjt>
 <f8284cf0-0b05-413d-83e5-5cbd1c72ad35@acm.org>
 <ckctv7ioomqpxe2iwcg6eh6fvtzamoihnmwxvavd7lanr4y2y6@fbznem3nvw3w>
 <e2983028-08ae-4135-98d3-2223d0450d85@acm.org>
In-Reply-To: <e2983028-08ae-4135-98d3-2223d0450d85@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY1PR04MB8704:EE_
x-ms-office365-filtering-correlation-id: d201d5c1-eb9d-4104-a97f-08dd9f4efd76
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/uajcN9rVw0l5USVdNBnGIuP6ktjtYTxa9NwZ+TFWhKgkgOQooxKleMEZ8q8?=
 =?us-ascii?Q?lLxHzV8tWq3bOmV4Fg6mV9aMvZPWSNCOyCjdiurJLNvyVznxFMJf41KFoDyd?=
 =?us-ascii?Q?JO92iQlLz36UzsFIYYIfv86ftZzj/9QdedcFdZXXDjMrhEQcJRuNydrR3KEQ?=
 =?us-ascii?Q?8xl2aGzIMwOUU2m0EbvDGDvUOJ6GHFMnVIM0JCxGe6eDjT1XfRUC96KMXUBT?=
 =?us-ascii?Q?/0GtyShZmOeAfVlJ7fXK/Hqtso9X3ocaiA/yihKRZOctkWLXmVSOkW94HFzY?=
 =?us-ascii?Q?/pjubcMNHkx+zt/Xy9bJpR30rit6uTHwQJnhaJEBlEcaRHpk99/kl9rzSV46?=
 =?us-ascii?Q?2tpq4ahiArTNHtVHGc5qy7Rn4YuwR7FoagLYwEnQrlQ9Y2O1yFpLBDEaTbHv?=
 =?us-ascii?Q?D/s0S9NmykJGJ1RBQXSr1BMlknAW4sn9/FsLL8Rzmsyo6c6wsciTukS4dnBB?=
 =?us-ascii?Q?blJRy0lTHq1yEcdF/kqbGbv8ufi1vKznTOHsRTiraboqdGCW7+7o9wqnzF7D?=
 =?us-ascii?Q?hHexSJXTPfRPQW6zq4vP3EN5BnZIJ5w6RdEKpduK2YTylqCmktnrRcSvEKPv?=
 =?us-ascii?Q?DJkdxAe00DzVxG2KyRNR7WQvKC9nP+5/gNBE+El7LtX1QoxOdLAh/sCb2/A7?=
 =?us-ascii?Q?Ba+oInv/StS57nLrMp4WGX7nsd/wP35q8Ldjn5rCyZliVtR4EM8VBXzjuFc3?=
 =?us-ascii?Q?17Hk0rhI/5oEv4GXArWGEizohx+u9wBBFErw7g+SRoTYocYhWENDR0RsaQE6?=
 =?us-ascii?Q?gseGquZbnPU5SmDVfSj/m69JGGGuaqxPJmMwnB9kJLXOC7afjvalB9xS1jD2?=
 =?us-ascii?Q?zcWb+KoL67ravC4CoaOXEputltwoeo7vMvwVh9HiZJWY/vDyrN6kEfbsGk5E?=
 =?us-ascii?Q?giMZEdRKNeZ/oai0U6FkZEsy8wtgT+USAlZO08d1G9gTLKt38WCESiBvOx2c?=
 =?us-ascii?Q?XViWVQodi8n51Ac1jDKoEkbuFQwnSyp4X9A2xhzyZDzrpg5i0JVKfWivIlv0?=
 =?us-ascii?Q?Zh02qzL3e3hGCR5kkTQV1zKiTa+J5fDMOviXFq334JfSHisrOSe53C9Evs5P?=
 =?us-ascii?Q?YyExcLmSpOIUig8KPoimFjS6fngn5VucVo7oBK3IFjdiEvK5o8w87xrj6+Sa?=
 =?us-ascii?Q?hEUQDbu5iNHmW5AZACQbiPWdKMI4qMTCRFcXJjXTL0z6uxWRg+rdOp91/URu?=
 =?us-ascii?Q?vKgnWaiMAIl6y6VKWDCqQZYyyca4Xi8cLnCjnMnF16Pl3ngDnUTQx+j0PBb1?=
 =?us-ascii?Q?9mRxrAVOVehTmEsM31J/ObS2FB168gXVRs4kWfk7CBSWa/e6JS9IRKkm2iCR?=
 =?us-ascii?Q?9MEOy88b0+QhMBvqrcyX4Vot8Fq3+EAzMeTnkyx0iRbEhj1KXXabNBACN7BL?=
 =?us-ascii?Q?NE5Er1fF0oyhBFMfWTrzlSyrfMdWsTNgeDKVb8RFGNw3mHHFXpxfmG3jod2l?=
 =?us-ascii?Q?kNfjHWrO3NDMa3zl8icgd9IlEYXgoDprolHPHKnFmcKGN9XpZDKV9Bwry6bS?=
 =?us-ascii?Q?1cm6djdKB/MRHwM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZYdF4Z/3axT7sKhwBABNsfa6NDbuilyafG7hziLEqslk2coynVlNBC1kx4fA?=
 =?us-ascii?Q?oO7A2kTeaJ6REDwKBJBkJx7yPS3h8SIk8qErTwKpVd9GOESHaLGzv6/QApCG?=
 =?us-ascii?Q?iRGWcGNwlzsfAiKeyTBbd0LnWws0MUoiYailofLAOoqBX98iDeVEDlfSWcBb?=
 =?us-ascii?Q?IR3gPbpNWPKwvi796MhPeh/+gHI3WDGqFxFdyr7qHRv2eqBLJlUDGRvOQ0Ph?=
 =?us-ascii?Q?0FiQ/0A/Cx3TqxiMqrp0AdOL8Ns3QSoZgUAzBdj4kmN5j/UTYmlYIdTlpx4H?=
 =?us-ascii?Q?f7qPNkoyUODpF3dok6vQgUphdbCcPeecEyfWzDBSw4MREAFs0iZPfnXb1sF1?=
 =?us-ascii?Q?gLyNZnUdqMgKnHhOxKK27nqf3KTJ+vxz4hhSwDx1mtke0WTw/2duQBAhpq0D?=
 =?us-ascii?Q?NxsDRncg8oq4A1O6EvNUD4QS7C0bzKmC7cWCCG7WNEda7Aoib1SH4FWWdJrc?=
 =?us-ascii?Q?kdizv8VLABAhOOHZTP2wlpnfkkqvu0Xd5QDMqR9Wg03lkcLP2rbH8AwVLmSJ?=
 =?us-ascii?Q?2bJhW+5fN61GEFIGDzI44ZY2J+6ywosRumSuw4Tjq0jKqdFB78dy+23mFhYC?=
 =?us-ascii?Q?WapIIBzjSgeMWRQ5lEiIrJ5oezzeIuKVKmDVE19Sz7zt7L1Sw5G3ue9uAjyN?=
 =?us-ascii?Q?Fkw5Odr6Q3Rs1tXsvMRccVxDTkfi7JNbclSl/VzjoAcgTNeM50u8O73PO7zy?=
 =?us-ascii?Q?PSi6tgKjxXmSsLzKfwAtzGBAWZquG+JnpXaOXNTGSj3Y5aFVuNgFx/pi+xlN?=
 =?us-ascii?Q?jDg0LX7XewiMr1LtPe+gmYZ2n3ZIwgnwlJ3rmA9IUn6CF7DVY6KktLIo3IJx?=
 =?us-ascii?Q?HwUk7+EPPUQIQ5UI+Q8fYkpzloPsdCDLC8hE//jkS7fOAyh35WNIyhwGl0fU?=
 =?us-ascii?Q?a/AAPgrSKmy3GOw7Kxxj/VjltlzCr8ssYq5+1O99iKJDnCm26e4q+7f9fe0n?=
 =?us-ascii?Q?hnljYqjhdRpE/anIFkIagIGNGImsvG6hhM5bObxSpXoaaG9XL1yWNkUrFNnc?=
 =?us-ascii?Q?1aNCSkhy1Dd6tnRToLySssWlaQ5Xsx5OQfAf/4R66x0XaRJiuWcTD+iAzQp6?=
 =?us-ascii?Q?BTTqPtI7ZIHnMXXO06fniTB/jFyCoeoGTNS5h4gOkC51jwjGYOjuJ0YUoBLf?=
 =?us-ascii?Q?TRJT0+pjmsMofVanhWfCINkOhhNChMrN4jup6+3TgclsaEAcNdxdfhG4osXH?=
 =?us-ascii?Q?nfJDkZ/Kh3OAbRDAscD52aTBG0zgT4JXxrf2iyvjUIBBTPwDIJFCUMYjRjKc?=
 =?us-ascii?Q?YhKF2rS/kxPRBMv8Oez+H7CJwvEvJ6k90yrdkzRt4MW+MqfDVdwQ4Xyl4aBQ?=
 =?us-ascii?Q?DaUrt0jtnTV/DvbOA9/tKUcc/vOFWkx0R4HPcFArz7PYeNV0N7ZYLsMBWygq?=
 =?us-ascii?Q?D0x1kTx4P5jdjwcGQlddG3zZhKpJDnTwqFLAEYOee2V0L/eZtO/Q4mLj//Sg?=
 =?us-ascii?Q?3sjIatAv/8CSASyzOXMPeONhQs0iQysbquSUzWnuJIBOEWnS76iZLPSWA7OG?=
 =?us-ascii?Q?B7eEIx83CZBDYi//oeGLeHjm5cgyXf0wA2Qs5De+Kvruw1AGbzDr9YUdZ/jB?=
 =?us-ascii?Q?oF5zrz8vF+etev0+zZQuzmUIRopzbPF6LSuns4JfzaNleS4O/zPBhzbOevta?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1ACE755F22E3E84E94E76DD208C1CFCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rdYt61rgF4Rs5m+bTgrWhO8M/0QwDUeIUO9WL8KAytcyDJeq5CGrxpL+KVZFi5Gw9tExtC77QJArVFDQoaXa2/tSDeBaNSJdcCpQcIYaG4h/AA2sUzHmrJxn+Uu/qy/nDYkkhxt6KpyWKSL5rJ5OtJM6MPrXi8uCmaaYtry0C3PKz3tNsNiXhxoY9st2DlgWTgw5XP2JwfJRiONtE5bt0AhbKANEha/Ga8tVEBj/BXQd/pGYEBc9tDvx2zXXm1XozS8kPfwUmbQYMYdObCYffi2jtaIUJngUms2Ieace68nWb+HIEjIo6FYBQOr8z5M0a5FBKcM9CAGtaeGYCFeD2Iz8eDOiCHTZjIHkBEzOw3qkBwck9s4XphTw44Dq1N5HjsaJCISDagU6j5AoFcaWY/CbKhUJDS2nyBeeDxsUFrClqt17dPJQnwj4aPluSGHpKsO30fGBVseJy1jGzyPIhpOPlbD6oDndlEoLKRNV4xfBRH9FuuWs+W5CSiLpAn1tUclIlGEbG5Y/O0ZauzU55LNBlNlRMu/uZcOJW72NASSrZbLNqzfQEQsU5Vnb+ZHn32fUwTqATrfFd347iCzryHIK78ItJG2wraNeWa+6iv0ZE5dZXOLRSmXhtrmYunOd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d201d5c1-eb9d-4104-a97f-08dd9f4efd76
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 07:52:56.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBPu+p9pw6DxZ/kc22nNRQTcLDf59q80CppGp7ENdkuVlRR2c0ArHxSI6zKsXrktFrMYEkRorMFlLptDA8yAJQVS69TNfJp36yVnrFPHDZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8704

On May 29, 2025 / 09:05, Bart Van Assche wrote:
> On 5/28/25 6:08 PM, Shinichiro Kawasaki wrote:
> > On May 28, 2025 / 09:09, Bart Van Assche wrote:
> > > Does this mean no "set +e" statements anywhere and hence that stateme=
nts
> > > that may fail should be surrounded with something that makes bash ign=
ore
> > > their exit status, e.g. if ... then ... fi?
> >=20
> > What I'm thinking of is different. What's in my mind is below: (I have =
not yet
> > implemented, so I'm not yet sure if it is really feasible, though)
> >=20
> > - If a contributor thinks a new test case should be error free, declare=
 it
> >    by adding the "ERREXIT=3D1" flag at the beginning of the test case.
> > - When "check" script finds the "ERREXIT=3D1" flag in a test case, it d=
oes
> >    "set -e" before calling test() or test_device() for the test case. A=
fter
> >    the call, do "set +e".
> >=20
> > With this approach, the existing test cases are not affected. And we ca=
n do the
> > "set -e" error check in the selected new test cases.
> >=20
> > Will this approach fit your needs?
>=20
> Although I'm not enthusiast about the introduction of yet another global
> variable, this would fit my needs.

I see. I thought that the new global variable is required to detect the exi=
t due
to "set -e". But I came up with an idea to not use the new variable. By gre=
pping
"set -e" in the test case script, the "check" script can know if the error =
exit
may happen in the test case or not.

>=20
> Does this mean that it is hard to make set -e work in individual tests?
> _check() calls _run_group() in a subshell and _run_group() also calls
> _run_test() in a subshell so the exclamation mark in front of the
> subshell creation shouldn't cause set -e to be ignored, isn't it? The
> use of "time" in _call_test() doesn't affect set -e to be ignored either
> as far as I know.

No. As far as I try on my systems, the restriction by "the exclamation mark=
 in
front of the subshell creation" propagates to subshells. A short script bel=
ow
shows that the "set -e" in func1() is not working.

#!/bin/bash
func1() {
        set -e
        ls /foo
        echo this should not be printed
        set +e
}

if ! ( func1 ); then
        echo ""
fi


With this trial, I noticed another important restriction that bash man page
notes: "part of the test following the if or elif reserved words". This als=
o
applies to the blktests test case execution context.

Anyway, these restrictions can be avoided with some tweaks. I have created
trial implementation patches. Will send them out as RFC.=
