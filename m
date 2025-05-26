Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F116D9BF
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247936; cv=fail; b=TeGG/1HtSG2FvRirU4mAqr9JLf/Us0mA/lu37Mrlli1NcFcjwtv2CcT52tyz9bU1orO8tp3m/vchPQDRwwgZFhZwz0o0PLOqoOD9Es/VLz7G1Hvt5wflgYlC3CJD27ddLsYyN/Q/SP6+/stNAJKyzgMA37kppjbxUZa+1CY1mxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247936; c=relaxed/simple;
	bh=+/Jf//KxcZucRvD32nime8a8Qu9weQ2A1dba6zG1meg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/MkscgMiVI9nov8Biw0IzxdIuWq5yl2t73m5/PGFe28OEZf5+++WP2vHMsLjHiCF8QausA657l5oNHu5chvXpgwltoqMAROI/jACkasjzZdwLX0XxXDWuxMKmSaseolYZsIuaESOBij2GQzrkJTwxvIVt5KhgbIrMLfMKq8Dr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NwTb6ejw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DqSg13Hi; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NwTb6ejw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DqSg13Hi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748247934; x=1779783934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+/Jf//KxcZucRvD32nime8a8Qu9weQ2A1dba6zG1meg=;
  b=NwTb6ejwvvSy/TPiTZ9wx5hTTSW7meoSUEddnwbvAdJuZHyjCX62a+Ue
   gIsH7pGsmxbcvmTCnS5h/3I5qcGmXpxmA3pfxnAWB3vfaBPsNFDn1/p/o
   Bv1aoXVTrF3R9MKiH044XsH3YC0Vc9RDnu3H8WRWOP4sGYFEeSI0m0cM6
   C049Zl27xwi6QoKXZ8KjimK/aJJFZkIs1d+m91Ov8pas0ngPm9zHb3HPJ
   ow0dNdmrhO94lynYujvaiutyQPIZuTuHKvoO7Q5U562yKV9F6r+U1yR+S
   pTCG16e1xroaWF0VFLZL96XlgcOyObzcWr9eiaLKSqj/gT6ws5005YE5g
   A==;
X-CSE-ConnectionGUID: Xhx/jYEcRzCYELM9+DuxFg==
X-CSE-MsgGUID: dZwVIDb2RV+t2hnA4dFs7Q==
X-IronPort-AV: E=Sophos;i="6.15,315,1739808000"; 
   d="scan'208";a="88003829"
Received: from mail-southcentralusazon11011052.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.194.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2025 16:25:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV6N9Y+uGSvI1oVjW2lnf60AZA+UMJflv3PX3ZTH4J7qzE5KHKg/6192FwEQiaCxEuV80I2mTG55T4s63aNLGCZV5/t0d1CAWhxvWfPLNj8uQ9n3fcMDpRnP0On2v6iSQBu/TSstvOa9vRI1grBSH8hm1XsDymCM0litAISYav1t2xq8XzqRXzJVTn68h3aUBu72VLHf6rl0VhvcErTNayy1l20Pnr/K7EKcqYRg0/tmbaK7Q6qH8KjqbZ+ZHPDrpcAiDns2cv3/tTVjzXJ+KxHgNB88Gl955RAK31A59SdccaLzrjCMVOYqNCWU+/OlOTN/QdkpYC28H50pI3pm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpcRN7XmVIOo11YGU/SOVochIsu9+TOjzTjMAmeuX3Q=;
 b=yp5yUls2fBX1ulBeC+ZrLXZJUKnNcdrwZgq+wsNJqCpTTuL6eq49kD/xoh3xYz7HnL5rRKeJRl5MpaSyYocDOpVAqTvEXDYhaB4GTzu/VS2TrGrM3TWG4MmhgXjylud0uZxUGh4R/bdDWgtLoTcCsy/hWl9BzYlrCN+LFtUeG720mhsFixMaI//MfO3VoeEUAook0s2iTapR/DwY36lOWuTLmU1FXBfuGxsJJwT3N+PFcaXQx+T+6bE09JPw4nZsLt5bYI3BDEUjVpKiP7YF1FxLDfo1FYAbgOi5nXXxCfuLCpXUkMWOhNtwY04IxbeifyPjrOY/twcJ8BLUe+I4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpcRN7XmVIOo11YGU/SOVochIsu9+TOjzTjMAmeuX3Q=;
 b=DqSg13HiOLJJ+5XYpzqRgzJ2L9gV0i7I0LvxUloVpyp3j2zpZgXuNYel9xlXtOY0bkzmi4VLxtqwCPeGib0KZVKE05Pf3qjSB9JALkEQZ6+dKYXfq5P50g1dGeXBHivtbJvYikcUq0a5GfNCQTdtavg5c1ojsm1tM329+t17Whg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS0PR04MB8617.namprd04.prod.outlook.com (2603:10b6:8:125::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 26 May
 2025 08:25:31 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 08:25:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Thread-Topic: [PATCH blktests] zbd/013: Test stacked drivers and queue
 freezing
Thread-Index: AQHbzALLtqOQN1PdUE6hMcTwgzbaO7Pkl3UA
Date: Mon, 26 May 2025 08:25:30 +0000
Message-ID: <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
References: <20250523164956.883024-1-bvanassche@acm.org>
In-Reply-To: <20250523164956.883024-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS0PR04MB8617:EE_
x-ms-office365-filtering-correlation-id: 6360b782-428f-4371-1bc9-08dd9c2ee0cc
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ds5O6X56dVgMXLpyGE82OhptI3wl5sAfjpQFa8AmjcN5t8RBZrhpqk1Bf00q?=
 =?us-ascii?Q?fGyBJm9C+LEF3XP5Kh4K568AkAVH2Eg5BevSbLwcr+VQ5oMWRmIUPFsgJiFr?=
 =?us-ascii?Q?gpLu88DEyMaZI1O1fa+dEQewtMD9Y5nSYp6VyoA/l7SKHS6Ar37ir7vIQ4/s?=
 =?us-ascii?Q?vQ3jz8aZLDTqUUa2YxToOqv40BDkLBf6/jB4g60YLETd91yYrRbC6rgE11Rv?=
 =?us-ascii?Q?LejzNTCVBZ+qtsb3P3KOaoumWVjXfezwwjTTbsmqDl/a1Bia1XxmN86Ei2jv?=
 =?us-ascii?Q?cWcTcyfpFmaTOc1TfdhH10jjuFDMP1R0NPJtYumzVRGkRxQtv+Q45MFRhJ9t?=
 =?us-ascii?Q?EX/Bgt2M/gDAJ4JXA276qcqLsCBaHK9aN4fx+f8oOVuI81sgg/ogtBxhsE2C?=
 =?us-ascii?Q?/Guo6/P+U7lF9Osv9rCXPyntCoqUCOab4YsnVNEc0G1Z2VJ4q3g7YqdjgK4Y?=
 =?us-ascii?Q?lAETI/pvjolWtw9PPcozk4fjIwpRcEwPYHegPKAZKPoK7U6zlWaKjulvAj3D?=
 =?us-ascii?Q?vSquSE5OIg8LobD2wWZBkHBOm2xqKo98NrAs+TgV0GGMpqE14/I16aSxhU49?=
 =?us-ascii?Q?jhndEm41VANDUivM6QbPT/TZHjeARGvaSWjDpgbo+6nSwEtd6/7OI4ibzIkQ?=
 =?us-ascii?Q?PkG5qtUIv0nXAesaWuPZoEmTYf0tzpe+wkyKn3ZEoygbF+LeM30+pficG4wC?=
 =?us-ascii?Q?aOdcdmNW9iX5pGhdzxlny13b6DIL/gUPjCgYQZCPxeh9NfachA43CUFV5nib?=
 =?us-ascii?Q?GQXpuuz64a4WigKm5cp1ciNBKxrrBHChXjujsh0xEoo/cUKCsv7XP+WzZqFB?=
 =?us-ascii?Q?VzoqvsX/trKo93ktrHVhcg1OPrpTb0vsxIzgUeg7bE2rJx/z+2tVWWjUOjte?=
 =?us-ascii?Q?4qzzlWt4dmZCqov/d552OTOmeIHCQIiReQQU5X//MCc8dcPEzhoSY1mZG2Q3?=
 =?us-ascii?Q?w+5A9Dy37A6yYt1M3deOHWyLGarjrf+skK2YLvWoFWv8BVtB285KJESqG6lH?=
 =?us-ascii?Q?PbJEJXt5e/lOKr18zyXfvxCIMR9ZZWsegnyXbmR9Uf0ie0pc3BYNpM3R8S7/?=
 =?us-ascii?Q?g9NJkTjkgpYDemfOhtaFeS8V3XfMrDSmHKKY9b2zRJCMoIfmSFjXJGZ+lUC3?=
 =?us-ascii?Q?TRn84rMCMM3/o41nlEumbdydG9nwcXdfqQgeD7O14sAeb9SQ88e5SySipHI3?=
 =?us-ascii?Q?g285BDq+H8wcjTa5Rbt2zMVw8Mjyx1ohW2HNWbDtvcJNm0vYVimsaCm9NNkm?=
 =?us-ascii?Q?AK3CCPpCUsKLgBDT2j9qCuCA/ZbxEDOfAk1ZEUVDbWh4zfeNsvcnQf70SJbh?=
 =?us-ascii?Q?ImM1W9nSmr01zKO/n4JzaOs81Ylfsd9TRsyRPAp8qRDrUBAKfDYMwCZkqlBB?=
 =?us-ascii?Q?Xer1ow6jiClh4I9930rsoQvS0UbddXM5nCtuPxskINYLevBJ7/bmghB1HU2B?=
 =?us-ascii?Q?HHA/yHRG9kxjkb3/ZIhj7wFVb7MyXA8r6udDXgj6tKaq9S83KiAd5kgNYW83?=
 =?us-ascii?Q?ry/R046u/DO2o+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N1++N1g1lyvBfdQLt2mdd8vQ1RMZQd1vC0T1+8I5RNHsdGhSVhpQ26Nv3Qog?=
 =?us-ascii?Q?hexkC7yHiWMpqkgU6jGGmj5mIpYVJoeW8uRJZRWu2k3JgoV80V8P9rlAp280?=
 =?us-ascii?Q?I58UB+UvsPraaNDqzTyoMyk3lHBTZ4ObAL/wLaa7I9Ip8EcvSOx6Yv0clgDE?=
 =?us-ascii?Q?SJvddRi/2z+rIK5ano3XW3GePF4GksQSe6gvMr4vh+wC3TRDvq1tR0MQFgXA?=
 =?us-ascii?Q?vwLBHfxMJSz14mLrRxuPY6ueuNd7FwX7qJ0MbtIdlUF9AKjVHiPXiJ/CuJHb?=
 =?us-ascii?Q?kQTsJdo4vupFFKjyaC33QiIFY5Iw+0yvdFKOmg6JM0qA+2XQYfkQRpQ+d0L7?=
 =?us-ascii?Q?pGcBlJGs4s2z4kb15RXEMgULPqPxXwAmdMbppShNjSdR9UDQzgu5fsNJXiQs?=
 =?us-ascii?Q?WKMg4hKKi5LdUw0GkAxT4hhnQD3ZctvX/pmO6CTiBp1jKNJFXFE9joSpXSNm?=
 =?us-ascii?Q?OWK/yYGq2rIor33dR0NWj6iyUXn487hSjfHaVCYENadZp9r0+XaPsFQBJv+e?=
 =?us-ascii?Q?kRRiK2nCJvvuhKiQx4yDRqJZN2gT4PneqCxRDdCkD951+9A3DET16jdDFcbS?=
 =?us-ascii?Q?4xVVtOHC7XWRnM0aw25q/zpscZsMAGQLyNCbJl9oMyWNJ5BaIwduvZJitGPa?=
 =?us-ascii?Q?IAS/MlwdyIZSzMBdGLNvBuDUhDCoMSGzfh0JPfNnrb1U3F3+GvM6x3jMOjhU?=
 =?us-ascii?Q?RQctF1/rVBBihdCli52omUla0gbo3jKFfWCF5VkId9mKDK+bcvjJcBpnkDyH?=
 =?us-ascii?Q?Bru2F1EuEaUF5KZY6BMi9D4IjVlxm/paKxCxgFIxckPoqx5TBPpotdCCr4YB?=
 =?us-ascii?Q?joN+4t4zfSNkZYsDzYcC/MjkSkOgzrAiV5nUvyYAnEqQNTeBuursnYYxVdqu?=
 =?us-ascii?Q?ebRR/pYCw1V+7+oROeN69EuEqXN583nXgmEHix+GXO+SxCZfft5P9ZUNoUGt?=
 =?us-ascii?Q?EFPBr8LVXywaw5naMu7z6H8O9R77JtbIdpda1ZPs6IWu9swqWT2T1EIX+Hte?=
 =?us-ascii?Q?Jh3prNp2qpNuj2hH1oojtq06QiCQfL+FAvvytd3IJ9ZZCRK/GnfaZ9P9ANBn?=
 =?us-ascii?Q?NI9Dq/kaExk91aBJonUVjYahRL843X4wmi3DTL4X8SuebqbojAZYFcVIXqPz?=
 =?us-ascii?Q?IOBYR8HU0uLfYSGGBOBDkhTZHFsHU4e/n4a43VUhw4UccbM+ABCyuyJsILUU?=
 =?us-ascii?Q?Ea/jJOhOHyx30ok0fC6Ppo8UHDDsEWFgAejAg5s2to6PqKz6sWAmYGcb0njz?=
 =?us-ascii?Q?YfB7NhMhOKa2fURJKuNyCmvvaekUHTOgYooM24qCxRcnoVRpkam5xWrxSJXv?=
 =?us-ascii?Q?+8FT9X5OyqCVRuZsxrh1t7wlw1E/0W91KBf1LZ9tr/gfatjj3Yvh9t7nzuE0?=
 =?us-ascii?Q?BzskWOvPDkmR7prQi6Gpc4ahPzM/8WpJbIHx4vspNSgK76pk7tXaoN9bExo/?=
 =?us-ascii?Q?H2TzpV7txcavB6T9qqAJrd8DN8qkKVu23IXmlgsYnHQC8rMiT8gxIAuTHJkP?=
 =?us-ascii?Q?SoExs1x38p9JldgE50RBGk+8z8ssdYV3WiGA9flWr1At2jrMAhF/8sov5MZm?=
 =?us-ascii?Q?Kcbu0gDlAX2zYgd7SuYRgt2LrvFhibDB9JGmNMENTeT+6evwURozDLm8fM6f?=
 =?us-ascii?Q?kCQAciPBhapWhAhZrYWh90s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E90475891746A4BB70ECB26D29C36C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x9SOgqszw8Tj1/9VEYNKLOnLlMoktaWkN0lZJW3hEwx8YSQ+X0L4+zqf4Yh/IgNIAkMZCf6ToMPaOZRBxLMPZRHtLia3e8RjAwiC1jmC7Sk7O+rvB7xcXev+qzEhvQdnApRdHXmNTlsY37pisyHmGwujmol0zyqMhAWrdZo236440kxDSKK7938b9bhEQS7PFsUhD6ticrTm95yJqfZIzhzThQMKj4JJ+zJuNGYBsn/AOIlESjTLX07dg8qhVJapxtGhnk+YCLXleuNnJXdpw6wuRAXlT0HOS6iF1PKHm5F04QOvUIX1ft6N1bVYZVmf5Cv610UldK+PqFaz2AQpZwV+1utp62khnUk+sCG9JZeNzHO3N/F9bkuvx5o5rmqsNx/zZag8H8ytyyucRf8paSCgi1kH/5FW5WnZFTlQpRpci27KBhbMMl1ci9s+LOusrQr2P3GlIg7iksACm0Wfzh9ASc+zNr+YNbl+ns0tUsW5FSeeKdP2Pr1UauX4mGquFi8r7svJ+n5bcbjEmMinMRxuD+zVPoMirItzfQuyW8gBL8fKBqM95UZNQtJ5+gAhsBiIwqk1uYL0ioBv0sVoiZWbo1dXy5eu1PBo5STOBH/eep5uRBp4+1jbo1QEl2Ks
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6360b782-428f-4371-1bc9-08dd9c2ee0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 08:25:31.0322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLJ4wxPILRQlJ01s8MIf1F0FUfqEdoopb+Z/cKVBZrOokC327YWiN5gAOtHxcPbFPUWROWhNcxfzsiAM0tm9NumemL69WzaswbZ0FUc7f6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8617

On May 23, 2025 / 09:49, Bart Van Assche wrote:
> Since there is no test yet in the blktests repository for a device mapper
> driver stacked on top of a zoned block device, add such a test. This test
> triggers the following deadlock in kernel versions 6.10..6.14:
>=20
> Call Trace:
>  <TASK>
>  __schedule+0x43f/0x12f0
>  schedule+0x27/0xf0
>  __bio_queue_enter+0x10e/0x230
>  __submit_bio+0xf0/0x280
>  submit_bio_noacct_nocheck+0x185/0x3d0
>  blk_zone_wplug_bio_work+0x1ad/0x1f0
>  process_one_work+0x17b/0x330
>  worker_thread+0x2ce/0x3f0
>  kthread+0xec/0x220
>  ret_from_fork+0x31/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Call Trace:
>  <TASK>
>  __schedule+0x43f/0x12f0
>  schedule+0x27/0xf0
>  blk_mq_freeze_queue_wait+0x6f/0xa0
>  queue_attr_store+0x14f/0x1b0
>  kernfs_fop_write_iter+0x13b/0x1f0
>  vfs_write+0x253/0x420
>  ksys_write+0x64/0xe0
>  do_syscall_64+0x82/0x160
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  </TASK>

Thanks for the patch. I ran this test case and observed the deadlock
with the kernel v6.15-rc7 and linux-block/for-next tip (git hash
efe615cd8823). I hope the kernel side fix gets available before applying
this patch to the blktests master branch, because this new test case
makes the blktests runs hang.

Please find my comments below.

>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/zbd/013     | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/zbd/013.out |   2 +
>  2 files changed, 112 insertions(+)
>  create mode 100755 tests/zbd/013
>  create mode 100644 tests/zbd/013.out
>=20
> diff --git a/tests/zbd/013 b/tests/zbd/013
> new file mode 100755
> index 000000000000..88aea23ee68a
> --- /dev/null
> +++ b/tests/zbd/013
> @@ -0,0 +1,110 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Google LLC
> +

Let's have some more description about the test here. How about the text
like this?

# Test the race between writes on zoned dm-crypt device and queue freeze vi=
a the
# sysfs attribute "queue/read_ahead_kb", using zoned null_blk.

> +. tests/zbd/rc
> +. common/null_blk

Nit: this line can be removed since tests/zbd/rc sources common/null_blk.

> +
> +DESCRIPTION=3D"test stacked drivers and queue freezing"
> +QUICK=3D1

TIMED=3D1 should be here instead of QUICK=3D1 since this test case refers t=
o
$TIMEOUT.

> +
> +requires() {
> +	_have_driver dm-crypt
> +	_have_fio
> +	_have_module null_blk

Nit: the line above can be removed since group_requires() zbd/rc checks it.

> +	_have_program cryptsetup
> +}
> +
> +# Trigger blk_mq_freeze_queue() repeatedly because there is a bug in the
> +# Linux kernel 6.10..6.14 zoned block device code that triggers a deadlo=
ck
> +# between zoned writes and queue freezing.
> +queue_freeze_loop() {
> +	while true; do
> +		echo 4 >"$1"
> +		sleep .1
> +		echo 8 >"$1"
> +		sleep .1
> +	done
> +}
> +
> +test() {
> +	set -e

Is this required? When I comment out this line and the "set +e" below,
still I was able to recreate the deadlock.

> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_init_null_blk nr_devices=3D0 queue_mode=3D2

This line can be removed by renameing the null_blk devices as follows:

  nullb0 -> nullb1
  nullb1 -> nullb2

nullb0 is not recommended since it can not be reconfigured when the
null_blk driver is built-in.

> +
> +	# A small conventional block device for the LUKS header.
> +	local null_blk_params=3D(
> +		blocksize=3D4096
> +		completion_nsec=3D0
> +		memory_backed=3D1
> +		size=3D4            # MiB
> +		submit_queues=3D1
> +		power=3D1
> +	)
> +	_configure_null_blk nullb0 "${null_blk_params[@]}"
> +	local hdev=3D/dev/nullb0

As noted above, I suggest to rename from nullb0 to nullb1.

> +
> +	# A larger zoned block device for the data.
> +	local null_blk_params=3D(
> +		blocksize=3D4096
> +		completion_nsec=3D0
> +		memory_backed=3D1
> +		size=3D1024         # MiB
> +		submit_queues=3D1
> +		zoned=3D1
> +		power=3D1
> +	)
> +	_configure_null_blk nullb1 "${null_blk_params[@]}"
> +	local zdev=3D/dev/nullb1

As noted above, I suggest to rename from nullb1 to nullb2.

> +
> +	local luks_passphrase=3Dthis-passphrase-is-not-secret
> +	{ echo "${luks_passphrase}" |
> +		  cryptsetup luksFormat --batch-mode ${zdev} \
> +			     --header ${hdev}; }
> +	local luks_vol_name=3Dzbd-013
> +	{ echo "${luks_passphrase}" |
> +		  cryptsetup luksOpen \
> +			     --batch-mode "${zdev}" "${luks_vol_name}" \
> +			     --header ${hdev}; }
> +	local luksdev=3D"/dev/mapper/${luks_vol_name}"
> +	local dmdev
> +	dmdev=3D"$(basename "$(readlink "${luksdev}")")"
> +	ls -ld "${hdev}" "${zdev}" "${luksdev}" "/dev/${dmdev}" >>"${FULL}"
> +	local zdev_basename
> +	zdev_basename=3D$(basename "$zdev")
> +	local max_sectors_zdev
> +	max_sectors_zdev=3D/sys/block/"${zdev_basename}"/queue/max_sectors_kb
> +	echo 4 > "${max_sectors_zdev}"

Is this max_sectors_kb change a key condition to recreate the deadlock? I t=
ried
some runs with this change, and still able to recreate the hang on my test =
node.

> +	echo "${zdev_basename}: max_sectors_kb=3D$(<"${max_sectors_zdev}")" >>"=
${FULL}"
> +	local max_sectors_dm
> +	max_sectors_dm=3D/sys/block/"${dmdev}"/queue/max_sectors_kb
> +	echo "${dmdev}: max_sectors_kb=3D$(<"${max_sectors_dm}")" >>"${FULL}"
> +	queue_freeze_loop /sys/block/"$dmdev"/queue/read_ahead_kb &
> +	local loop_pid=3D$!
> +	local fio_args=3D(
> +		--bs=3D64M
> +		--direct=3D1
> +		--filename=3D"${luksdev}"
> +		--runtime=3D"$TIMEOUT"
> +		--time_based
> +		--zonemode=3Dzbd
> +	)
> +	if ! _run_fio_verify_io "${fio_args[@]}" >>"${FULL}" 2>&1; then
> +		fail=3Dtrue
> +	fi
> +
> +	set +e

As I noted above, I wonder if this line is required.

Thanks!=
