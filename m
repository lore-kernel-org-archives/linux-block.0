Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFE770E4
	for <linux-block@vger.kernel.org>; Thu, 18 Jul 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345678; cv=fail; b=CWlnTS+k3CF/aSRojj7LbuLeSIRINpbNjOvKVnBAlnQOAxIjqA4dNFho00aPTJlroPM7e/j+UHI8JQvujGpVAr2tqBjyTatR/SWd1akCOcm1gJKVtW8IE2qwHpcMFBlwIx5a996zQCeJhvIMDgwCr7QYRi/vg/Ppvb7ay3opXAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345678; c=relaxed/simple;
	bh=WUegy2DuFFImbOu+/PSM9O54m5ByOiHvudVuaXnVDRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WEz3CNV683SL0pmnIwqAgbFlfxRzzQZMe4aCVfTeSvhN6bj9Qs46yDC7aE7Vu0JgoeQ8AAU8rZxARz5MhGtJgHEuYfa0W4JPowjicbikp3ThlhEi9Fl6SThqnSPvw/ls9PDoGG7SgPD8oeX/uZzstZJWPhSi8qcAoXXJvdT7CZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NAt+9VYc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FQZFZ9TM; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NAt+9VYc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FQZFZ9TM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721345676; x=1752881676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WUegy2DuFFImbOu+/PSM9O54m5ByOiHvudVuaXnVDRE=;
  b=NAt+9VYcw3kf4pW+xOT4EXTOrKXoJHKpw5JNjgNF+ykFBMSNcMrhDwc4
   Ta1r9QQSrNx7wLKqmiMoHuEAsJyPPtYvCIBuKEcuFkVOOQqHJlX5FIdiL
   CetAnHEGiCmKFB2o1LoH0boWW4UdjQS0AwJ6zUmOiSNe6qTcQC5v1uakq
   yV7U7grwsoU7bPd0cW8URPDHzTXEE3jjY7MDkcH0FSBdGnPewqGVZERxh
   1DaHLRlpX1mcFCy80wENO0WFVF29hjZHS1lPOdiUUO3K2wSG3+axxDj4Z
   ECcQThrUau9ZWqQRRKLdW71IcZm0pmvzedon97nvVSFT+BhjMUwaZCYuF
   w==;
X-CSE-ConnectionGUID: MHUFMuJTQKOCh4GJW7bvCg==
X-CSE-MsgGUID: 98PDLt7lS/ydlFPJ4cUdAA==
X-IronPort-AV: E=Sophos;i="6.09,219,1716220800"; 
   d="scan'208";a="22815373"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2024 07:34:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQN8TPFzifa5a7etb54Db2Darzjjqsw2WIXobKDXd0NDzOBstIuq5uI9jycGGzeI2mNbivC1n9f3y2exQqeaPbVSJDQ70DomguzwtSZnHOKdGft51PegDn+fRY/JDw5DlYD1IRaIqALcL3PcNJMsI+x10lPv38Va2G71LoI6tFvdDfJGykUWQ8W4+0LvgFXx9yZg4//ahtcV833VbNQRBjlMBLma/oLiHfRU+Vzuglki/MeFjaW5NbP9jfs/GKuX1FX7DaHt1Av1GAdU0plRExFsB+EMZnaiSnRCny+Uqmfyu9g5HO7yjjVqaPEpLSf+1NO/VPufsoabDnLny5JXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUegy2DuFFImbOu+/PSM9O54m5ByOiHvudVuaXnVDRE=;
 b=LSOIPfxxVyoQiv+92nGCV0mYkaX6bP5HNJAd8mlVuDtZmGgeSgvgcLEEZKNeX4ZdBUyBD8oaRgAy1TXOmnHZGMzIFpM/lyetp3e4JAe9j2YKvIqXwpb/b1GLFvANNNaAbB8StXhN9fUdjKimMo8LAgOyQn43LvBZG9F7FEL9gTmS0nZnoAe9WuKP4UvMZ3UcS9vGwbJSl/QMTyDnAzuldcc9Clr/5Bp4ORKX773o98XeAWiZxuov2e/a8HHVN80ceTeGF7g9aFoGvhTQz85/UbiabIGsj2uV7Irfj69grAkgeBFYs0c+sip3XdEsv7eFxIdFEhfKxZrzFSJtYZwvmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUegy2DuFFImbOu+/PSM9O54m5ByOiHvudVuaXnVDRE=;
 b=FQZFZ9TMNJfQaWF7QsKiZj+xaAXxBF6Hi6gmwPP/SmyEdFIPVbN+z8bsiv0jW1pkD+eb5El/qjUSfpegXCCbQK8Z/woiKfbgsMGfqZTTvAo+9L7V3yRoyl789F0F3hioIsBTlF8FrEKnxJ45mtyRt3ngNkrtN7NcXMyPNNlvphY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6381.namprd04.prod.outlook.com (2603:10b6:208:1a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 18 Jul
 2024 23:34:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 23:34:27 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Topic: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
Thread-Index: AQHa13ZloNQFnpI10ESZaT4cm2k5SrH6iqcAgAGe6gCAAEXCgIAABlkAgACxdAA=
Date: Thu, 18 Jul 2024 23:34:27 +0000
Message-ID: <flo6lwe6ad33fziqxd5xvklobqskzflqjdav7cp2h2v2echrpz@hvztbcuqzguc>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
 <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
 <f6255383-88df-4aff-97fb-2504108e300a@volumez.com>
 <kumwslbrccrhttvbjqyfznbcem7k5rryasppabgkzx6iw72uyj@rv4uu2o2jtkt>
 <90d5665a-bfb4-43c1-bcd0-5a1189816b37@volumez.com>
In-Reply-To: <90d5665a-bfb4-43c1-bcd0-5a1189816b37@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6381:EE_
x-ms-office365-filtering-correlation-id: 88b284b0-6761-42fa-3698-08dca7822a21
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rdStktBlJc8EVIpkFgmrrqY+iW3tkPX2G+YVDLgjhsM8hpEpwTAa9i3FVrNJ?=
 =?us-ascii?Q?Im3bGiovfSObWvbP0cx31jaZUkymUcpwPHyWlu2XHIZUEUlYBV7sHI18/7sg?=
 =?us-ascii?Q?qyrTM/Az7k+pmNIo+VjPUspC7aK0ra3iRtHdbNGHDC4n2QYacpUXYeqEzjNH?=
 =?us-ascii?Q?Ycq2MuJWQGdt8T/VeiR51nqhaxydPO3KLZxtiDY4j6DTAXKdZbjtIPwUilft?=
 =?us-ascii?Q?EjYKYEZr/3ZfS+ykKv+ACVvTo1ecNtXMZeZhuuKPBdtVduIHc/IfNSNjLQkF?=
 =?us-ascii?Q?FOWGnrXLx5rKdIrA3DKag2VqXXYt2U3zmSRKbAH0Z69T2QYXUelwn9E1zk8i?=
 =?us-ascii?Q?IODgaVDBTdZzgZ4qBAalmFXFP1mK9wdn9GIdfDvJ3s/tc5n/Dq3rXbV6oUIO?=
 =?us-ascii?Q?alh/VOLl9IcdeRHSJI56GJQ3TQJ3+l/RZBLUeR1Mm9mm0Cqi/ETEWmAHBhR/?=
 =?us-ascii?Q?fjmrZ94pojWOlHG6M55F06JwLqdCnbBBiAUSxlI22T/9qayGUHtowAhtol2s?=
 =?us-ascii?Q?FuWH3TUBNtCsVp4AflM3CVOy1mwHQl6UDpze8sqhATuVvYRLOg9QxeDz5FYN?=
 =?us-ascii?Q?yR+iLjTNM+ugbsb+fq1TRKNGNQchUZK8ZMD9n8LmV8sd9r71BxWY+OVy++dQ?=
 =?us-ascii?Q?EV3Gw4bt4Ufye3KUoNGWevomjJzGCPsCatNHf8A0CNRdCELBzehY0K4WTREf?=
 =?us-ascii?Q?SZEilukF4H9U7cwB3BKtYsAT47gbSpiXT1rnU396LOtEolXHydwKC3OT7vb0?=
 =?us-ascii?Q?/jex57+xj+pw6cls0hfeZ8VXOWK2MSHixSHscNThlYQ8j/WSxiCSG0pldrR7?=
 =?us-ascii?Q?SoCG3XZyhQu+DQdd89ZOlQic85ehorBaqyTfgx9sXzgIIXxP9FJQwpzW5Qqb?=
 =?us-ascii?Q?gzXYuNg2cRPCaq8QqRkkH4/fhROm8l43UHl9zstbrT6xZlPyM3mwDyvVbwJt?=
 =?us-ascii?Q?y06o3/a3qxwpm7+N4CYxrihmLYBLswSKb0voiyvLa56xzJG/lQ0hFcGSwTvA?=
 =?us-ascii?Q?xLiurRz/dtr85QlucLGGJOfIrZNvdJZ9YEcafwCl1A5NDgNTCdBYKL1v+/CL?=
 =?us-ascii?Q?CkJJLLCb5YD4C1FX4YFwAw8SR4i5jUirbad89GyoBWCLiwKVJiQRnNkCUmKP?=
 =?us-ascii?Q?c1HOTeE+r8e6oWgCBlXa5t4iXz46Dw7tXkCPTL6bJKXceGP7ee9oXda6WYBS?=
 =?us-ascii?Q?I+O0nRfZ0tu7SB753n+XE35TsHEuJCH62n7H0qjE1VlBM4Z3e5aKnJuI0VTy?=
 =?us-ascii?Q?zZe78buVuvzqFbW9I2F6300RIuYxkXbgOUKydmvjUFtZ58hpf3Hn6T8E2BHE?=
 =?us-ascii?Q?r0b/uNuYqmEIN9knWCIT3WHy6b5A8Ocrh3bYL25Kw9v5EEl9+gvDjnnmULeM?=
 =?us-ascii?Q?ZtCc7SQw9GBrEULzG84myAjrpoImvTgS+JwHL2Sd9w7i2pIYFtfp7WlaUm5h?=
 =?us-ascii?Q?GllPCF4ALew=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X8ZZGJfvjbUvvEo7WUjbg6EDVSIC43GCB5dKCDDPr+SkWHbncPN2AkbIgs0y?=
 =?us-ascii?Q?XlQRWR/9nEMEN38K9oZ/GnLWbgiS/6DW52eRvzq1CdhJKp9TRVbPRnaefM8e?=
 =?us-ascii?Q?MbfNxfvQWak4ZFK/sJHp2Yna9gVXeeHVJmMTsmvpEM8x3X8waEU1X8Kr7n+i?=
 =?us-ascii?Q?6y9AtBBbRpJGz/9w+JlYVs0R1vqW97erRaCus/X9oU8gaQwZnMDQCpRC0WMt?=
 =?us-ascii?Q?aLM9TwbWJK9GDDGi/sHg8yLYKCmw6Tvi4JPfm7t0CEYHiEDry3o2/aSaCY2M?=
 =?us-ascii?Q?YDJotwVNJtpWy/Ya5ZSYnvtaREJV4HwBEnuAWzyZypsB1VjWgJoyrxjSuAfA?=
 =?us-ascii?Q?GzJetZP+8lsxh6tPic2N2wUFom51AIvFnZapYFxJHR8HP+5MjNO8hn3GgPeQ?=
 =?us-ascii?Q?hUpryZGdxcoaU+jiQ7A8wJy1ERe+Ikz0rHGLzkidcPiuhP2ESICATkczb7ce?=
 =?us-ascii?Q?WXUtQA8+f5tk4IKkB1LjiS4Z09cGuTdQsCYLeY8T9fN3KLUggkABYk2h4xqu?=
 =?us-ascii?Q?qvgdAfDnX6iOEjuqhmkvIJFgL2uqj0FMLahIMz6TPnHrviYaZB+s3eVhQDw2?=
 =?us-ascii?Q?NxJKNWVmlRh5Z+pBxmlzPNVbCO2SsJAFy53CWw/AMVg4wZReVyPf/C74IAOt?=
 =?us-ascii?Q?1ulEduB3nJozfFGGDxnLLF7tRJMOs7NA3iT6RqY53sTGQ1WV/BPbCv5NIn5e?=
 =?us-ascii?Q?Tbb43kZDoLCHdVY87cNW+ldWoX4g6LhUwnb9ng1A3xgoligrI+HBef23PC+6?=
 =?us-ascii?Q?DvXFaQsLsCW3F968nm2r1aFqrhfSCsoBKCzOlJ+tBHuPiJcyvqDGB8Muud0K?=
 =?us-ascii?Q?tQWWRFtHwsAFFgFFFXCvnnV1c5C3cxFvn3Q1gUoME/MNKu7av4IZa840x4EG?=
 =?us-ascii?Q?5GrE2DVWxXO1Q3XLciEehGsQD5AhsJQtvwIcvveF6iOIfwKMDZAa3u6JO9+8?=
 =?us-ascii?Q?dAHVSFTZjPrec8E7IQUXDbQ/eyYMtbDsykn3zHSq6cO5lCYPFV0+0KU4RHH2?=
 =?us-ascii?Q?As7P0RPADX3DjaullDYDd52WH+6oc5zoVC//LafE0XthLt4QtqKS+XxXccn4?=
 =?us-ascii?Q?Krw+2kpayK2SssE6wgwbGax+qFnSJVRmnyNSBFjQAvod7tBpIAO7lBl2MfXM?=
 =?us-ascii?Q?q7V9p1eVm4J+OB935ZGeS6z9sGVNL0tZTOiYgb3q07QF7YYwZj7MlN9Dex0L?=
 =?us-ascii?Q?EZ2ViqXK/4vnHoW/nqh8YNY4IDFq1kivLTQdCfyPWSe0tEPp9+jYXnYYnQ4A?=
 =?us-ascii?Q?kWaj22ho+ZycAyL/cz+ur984i8p20Rs84dRtGxsaXV9OU8sKADk2SvlSB4PI?=
 =?us-ascii?Q?wirKflxQB/4SuH7s9zBbIZJ+sfKCM3oE85X7ftPm6MJ49k19iJkfXMZip11U?=
 =?us-ascii?Q?QExcNU3ijykFkD+iJILu6T7qY24ogayeoHy3SSRIFYm6WzO+c3Iej+UM1gfb?=
 =?us-ascii?Q?S8PFVtXUmOIFpXzsDJbE7fLnkgUGRsU4h4t2/7E1dBWG0jHnZTkQznrPjsXU?=
 =?us-ascii?Q?vYeExN0NLByuhtCFcKzNlsiueUTmHAKhE0PmUyIkv3YFoJ+w8osaFuf+RCMl?=
 =?us-ascii?Q?sJ/EqIwWh66jyymYIescyygWJ8f4zbtgAWdn68zypGhX554OFqPHzIU8K9OY?=
 =?us-ascii?Q?sxVyd8AM5gjWtctgj2kpmvY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5C87C4AF398D84FA48AEB860C3D2E6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zotUQg4ESYuxJ0sL5ZS4F4Nc+v4FX86Njq/rWBmS99kFh1wtTOqBqPI7nNIq1Hxsx4IHKzynePo1VYgYnJZLi7pYkGVIg38hiu6GMiWkiF7l1EVDvz7zRCH4w6OnyjYFDx9pQ7Ea3N17TLkE35+LDt/dMHumbF7s8c9UYxZSDWrKMwWO1HkpaDGiLOjgbnt64bZA/Cdk/tUfbqfwXIz3rREByZ1Qtyyd2M6UcOUf41LakojXVwAW/6JdYoTKigY9ZPs0yL+alCHW7wfyXwBEkglCUDf4IFjD08YU0cgD9nnfyrUEyxGE5gn0NqlXGSv8yVh+a6j0elLgZZMtezAa7k1lqjEQOZ/ps46ZGr6wdhWfljGhmQQR3LgE0V6o8e8bsCfAlfQA85xK2q94Pvmc6F19I3MbRzdHVO/9CYLKT16yBgiAZBgQIqnHtUjGd+H2bqtYO20zQ1ZmlQ6saEwLo+xgDF5MzgMhxqtC+ACWiT6Yfkrn5Q/JA35UCyWEjIDkZqyLIWj9aOHaFTbbflNzzKZF6Ag7mXbDmsntE7WSj5jCGIbjkP/0bVakDiyXPKiH+6RkPiqnucf1qGDz3JfyCGZvOy8U6Aqm9jeccibScXv4cNJ/zUe8nt30wk3ysmKe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b284b0-6761-42fa-3698-08dca7822a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 23:34:27.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV98xCfvpqU1orgkc3uUF1JHsV9uLENsmjJpNpUn4APwnCiMot9OvMyYGcQd1h5FBpX7koit/IT1+y5n7IHQlKU5IcutW7PcyAvPeAuFXSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6381

On Jul 18, 2024 / 15:59, Ofir Gal wrote:
>=20
> On 7/18/24 15:36, Shinichiro Kawasaki wrote:
> >
[...]
> > If you are okay just to drop the 2nd patch part in the comment, I can d=
o that
> > edit when I apply this blktests patch. Or if you want to improve the co=
mment
> > by yourself, please repost the series. Please let me know your preferen=
ce.
> You can drop the 2nd part, Thanks!

All right, will do that. Before I apply this series, I'll wait for several =
days
just in case some one makes more review comments or provide reviewed-by tag=
s.=
