Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95809481C4
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372988; cv=fail; b=to5PCNdlR8a1v8RDgteqSg6HsFvhWJWkcyOCMSpf7UvNFavCMjLH03YKdGQD7iR9SFSHfNT2tqGe+6+5q7s6b9Rz8ofcZuo7wZBSn8m2ciSWjGlRkVKkAHn8VEpQt50kBqyTlhV1Kc65V6eCTHi5F2QNu8C2crd/kSIP6reTz/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372988; c=relaxed/simple;
	bh=rZW3OWcDhSSDclUvVIH70dZrO4n6EydPMo7lbgzN7GE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSZxIPfjq2BKZf4uYR//hmq5U1+ZFctElXEc7D0gSpUqTAYKDPYs4/l16DykbIS37MvurAdAsLlJWv55TrjZRDqNrTRJrodEyuEGAGzIbbHd4gnLl46IkQMESGr+LIxtVaZjWx2Xt8C4BOf9n1amYAeak2CrDHrcaAkNzvulVdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ks0EBuP8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IEakIsEH; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ks0EBuP8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IEakIsEH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747372986; x=1778908986;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rZW3OWcDhSSDclUvVIH70dZrO4n6EydPMo7lbgzN7GE=;
  b=Ks0EBuP8ufU8mYZE+YJjMkCVHP+GFaGlZlRwZfoaMii54wFg0oxMDMPL
   Pz6m0rIyyRDkYoWsSoSyCUTF3Z5NTpMTGj8fshQerZm+sOODn902vICSG
   HBhJY51bwOZbIW8+1H5DC39C2QmZaTKnmcH3TU7LBXAuGAZ75A+56DDIj
   KJYzpSRcx71qqxFTKMXWMRf4tLY96wwurt29IMQZg37WRl3YEnBh4mtY0
   jL2LpDEEpme3Xn2koaPLv39BIYQaIRLbSMBdMqggtzr0xy/HiIJM/392K
   arTOdAojIC1qI16+wzIImYOHDniFZ2mMfcLuZB1vCkksE0L6RuxFJSwc8
   w==;
X-CSE-ConnectionGUID: NOElORZEQradOdHgPoYfhg==
X-CSE-MsgGUID: qhqgEhZpSF6BDgJY3nHWSA==
X-IronPort-AV: E=Sophos;i="6.15,293,1739808000"; 
   d="scan'208";a="83659931"
Received: from mail-sn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2025 13:22:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpkMH4JUavbe4L8U/+Ugtfy2XN0f6Zdl1crk1eEOnwRR28YVa4Vry8h1Zm845lOFGMWq9qHp5Fz4QPQrnbZy/9HCB7V+jaSfBO2/C+q9OJGqdMsRqoZlb6Jr9pcsuqGC4MwDR7Obrf3k1Qx+/NWtDKsITi29IEHf/QG81r+kOPHbWKYDJQNKZAKSpiZrpEbTqHfBddS+prPD9hlWviLNhrG9eX2y0y5+cjZKipHhaPHrYor53JOpYgc6fnW/ItnJ2Ndw4XAE/jdQHWqUmso0Iojyg2rwupkh4BerherCc0thB/tkm0UvNgheRVPQ9fXmV3JzxQuhZxPRFltghdO25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZW3OWcDhSSDclUvVIH70dZrO4n6EydPMo7lbgzN7GE=;
 b=P/bSJf/rgz0BhbvvfgfnaplSd8odV4sqNKmxFNXpa29DjaQlyraioZ87Z2M5PwJrUgt3hHWenBJpmhW1F7dRM6g5yz3YCsW0/uHL4Gio5kbDmodQGe57lE0hyN/Gw6zX4ZISoyZLtuPeV3ARI75nOW1jWUqno6NfAeaMfAuSFaAuVSoeinPOLhQbJhNAlL6uYgjlnKt9JVt2GsIjppQA8h344eiLKs698cT6oQpB5o2UGN01CN9OT6FpUEtcvN9CMlm+kGCyhvgFmk88+cARLr67i94hQzqkDz8s6f4TBCb+RWJSxDs0SaK7AGx+roBCe49NejPkM7InZKWTulzfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZW3OWcDhSSDclUvVIH70dZrO4n6EydPMo7lbgzN7GE=;
 b=IEakIsEHbUdiXiD2YrJHCkrleHZYt+JIV1w7CBFvkUh5qhWjJWkDJX9WlTVndjnxuT89X4hB8fhj5oIFohcwIRxIHPuCojat+lalH2mhVFHWtxzwLIoJRc4WLaMtpshhjN/AxDqRCPv8k0dNcqc3URg/FnhyB1ZxvU+wZsvY8cw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB8957.namprd04.prod.outlook.com (2603:10b6:408:188::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 05:22:57 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 05:22:56 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Uday Shankar <ushankar@purestorage.com>, Caleb
 Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] ublk: fix dead loop when canceling io command
Thread-Topic: [PATCH] ublk: fix dead loop when canceling io command
Thread-Index: AQHbxbYXJsvfAxzAXEiLoacttxrpYbPUubuA
Date: Fri, 16 May 2025 05:22:56 +0000
Message-ID: <gczs4vaafy2tt5mr5c4mq6jvlb24ez4t4sclvbuk2wi5ty4k4k@aaexomlhtcz4>
References: <20250515162601.77346-1-ming.lei@redhat.com>
In-Reply-To: <20250515162601.77346-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB8957:EE_
x-ms-office365-filtering-correlation-id: b97e302e-c318-42c8-6cb3-08dd9439b75f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p9p52pC1qQ2v/OCmTNe4C8woheQhnFpZDwaLZkWLUVoqMVDent85rvMggLZt?=
 =?us-ascii?Q?kudlzRl6FRDVuSRlzd6551IhbNNsClfjxgWNlgPpRvuJFHOqNOJpWi9VwbJ3?=
 =?us-ascii?Q?MWMaiiK8D33R94AISG9vDgnOVcTkfNBEuG4iNTdBY0oDEI/KUbUrpdDlSJxO?=
 =?us-ascii?Q?sdtq0dr6V6LhIlJTKC00wHwFyBAwn96rbfY+lYahFFBwSqXCgn03QqL8vBcv?=
 =?us-ascii?Q?Rxcr1g4LnvrH4pPRXnvxiVJRSCw1BO40y+EjHHs3F/LUen+dmLcNzR1nd5kB?=
 =?us-ascii?Q?5U4FvuuK68u650LvQVDAbT/qxIw2bCax54bHueGp+xixfyMDkNG1GFQnpuQ9?=
 =?us-ascii?Q?k4+JC5O24B+lpU/IVRezCAm/S0jXCZ90bFbp+H1lf9RL3fpP2irYGJaw0zFN?=
 =?us-ascii?Q?z5AwjazYpJCF6WuNEHfxdIv1Rf9Ly7iFJYWuQJr69FT0xeMVmRwB3klNcHVM?=
 =?us-ascii?Q?AMWQlbvpVZarMZbQwUHo8yolAP0v7NC+aaXU8y5Fow7oujFzW3njibUODDEt?=
 =?us-ascii?Q?ZNXKh5I3N21TB13zSTnKRF5nTtynnb9YbTQpK0TTwC+KJIxrCPmFZ7BuHFQw?=
 =?us-ascii?Q?hm+hT1AZj+qwdlgUGTsefMePZCrsLnm1dkKmY9JC6U6XOhqADKjyhs9cDwlu?=
 =?us-ascii?Q?AQBfbnDrCKGUCy/dnmAMoF4VdkkuUkEJKYb1I9xMy76y5nc74lLtZc7kigUa?=
 =?us-ascii?Q?IUil1CThjwFL5lyNHR9FwTo7RDVwS8TNx+F1pPoJrPm3ch9PqlpK9KywxstG?=
 =?us-ascii?Q?euNPRS5ulP8GNctA1iZS05Yl3PLi2xkp0r9P5Q/sZkOFzLqorIHzzOeP94ia?=
 =?us-ascii?Q?tzCDyxXQDL1NjyKD5XhJdCkICctMpBs29KUwkLt3OgBCPgZ3nFsYRuaOR7b9?=
 =?us-ascii?Q?+axLlb+ljdtpiUJWcxLVwuJiEMfPIKftljTJ7TjH9iSgdJqBNOLnsV+ny+/z?=
 =?us-ascii?Q?+rNQXwLbwgClTzYYDBV6Nk+pehoInvtRfRt6afzr0jespuaaZTUA/AHanxLR?=
 =?us-ascii?Q?kbf3TUaWnpeiiJfBDUPksAkUBk6xz8QJ5gDGmMS0oLbLHrnDmwYYLv+kTCOI?=
 =?us-ascii?Q?qR3jvvaJElidwI1znQACMpSt/7BJHuO/ZvNMmJOgjJd9Y9SF6D2ZloX5NOBn?=
 =?us-ascii?Q?0ao4VH1sUvr5PcARlB2DwLs0KMdDm08liO7eRzKS1XMhs6nNdtfohzQn0kav?=
 =?us-ascii?Q?75RVxZiLjA++vdS4na7fyo2wr0iaNWHnFXi0LP5DQqe34oSNxyITV9Un+NLL?=
 =?us-ascii?Q?U/lPYgpXjyAFIXrcrKSSEa+T3UZWVj/U3fNGm699wy8Z/rd3FkoWd/kbrQeN?=
 =?us-ascii?Q?/3T4khSB+ybzOrxq4FHSuLWDx2Sz59fTLY2C1l/ugEV8UOy4WFwewe9O1EeR?=
 =?us-ascii?Q?miUMTgHvMYEj2nONCK2SolQVnvy1k2+RauhSnB5zIAu/7ES6R/V2crWZQGDe?=
 =?us-ascii?Q?jUxy31dLO05umxupUpVuNA4F8Dz0Jwxg0kNIzezkL79RqSpmsI/pxJWTZMPL?=
 =?us-ascii?Q?9dM17VSD6vQYn9o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PKul5XaFlicEBPYsqkgbuk0zK4wbZDGynUv8vTIctFViordK6jYYBS3d1aTR?=
 =?us-ascii?Q?W8XOfvTZ50ViWKkLi1OTrDXUIUjsHTC1++UD0x6sBsukDCu9EHyfSRzo8mO+?=
 =?us-ascii?Q?5XMW46rDugkpD5Z2C2y15jfW+2mKY2904ZetcOyMeEQE+MxIk8aYxOEXEN7e?=
 =?us-ascii?Q?PLVuCMWzv/qXpybH4ANCNchYpTDe2Sw8Wf4mECfNB3rrIYQggvFIsmUxUfoB?=
 =?us-ascii?Q?LNWp8qUmCmVLRSaftcSgxgc5K5Hwjrxp+bwFFQoNuI9lqSTMIO4fJLqLdLLh?=
 =?us-ascii?Q?0OOhyPAGzASzaQw6FCBqA0CPefzTqFL8+kWw+3REi8wn8xc+q1vJYJuGYcbF?=
 =?us-ascii?Q?UtAtJd9xoxTVXrlnzSnLRP5nbtDGmI53Iqqtcyt/zQTMO+K8amdb4gEpWEaX?=
 =?us-ascii?Q?I7ZoUR3btEXjL/9gcCqkqcCQzlMnsRIA9kcxKEpTeCJ4gCdrkQkMu1ZJ55fF?=
 =?us-ascii?Q?2JrN1IE7T8JcD/fg7CMsEnlQ08UPsZ3R0k2eekDUlzxybBAw6OfQPqTNwajA?=
 =?us-ascii?Q?ieUPTlU7mxXv8YUotMfYM6GH3/22bk8Pq1PY1erFvFS5LCeiBTS9KV59D8bN?=
 =?us-ascii?Q?n52FD0Ftc65Q6qJHu1no3LRez58keTsOfkOym1aF29gOzH35lTxNDR6nexTM?=
 =?us-ascii?Q?m12zmSTJeBPE7hbPtLzZASrP3WnMV9DgWmoS12QeNICSMZmOPECoGHT0GwTn?=
 =?us-ascii?Q?iHTmifVPJlntqCajCtdlz35gUjiVOiVXVP54C24PCMZv6gdikkE8N+yLFJVv?=
 =?us-ascii?Q?AyOiF1FDML/0t/F1qMZlZFP5SfoiXBV/QuCRXGfSa47uN5+Mqnl1800uXMY9?=
 =?us-ascii?Q?ZyDuw7oCzrSDVyayr6EuLpZbr6zUiDmnZhk2QZSbWDWAO5lZUSfpVvZ0a7u6?=
 =?us-ascii?Q?dn7kBJfSnZcpdIWajpTpGqfWpF4x58ehiTLhAzvhmktA7Q6JM1uFpgohhmYD?=
 =?us-ascii?Q?w0DoSZW7x0OfeRsytEM8AANRxcMZyABBfPbhErEeybak9KhkR1soOS3i9H0u?=
 =?us-ascii?Q?f0tNTtfpldQF5t+owSSl8CmBBRrh61HKWqd7HQUYjwqV87RGQ9ItVgBP079n?=
 =?us-ascii?Q?Yy2Xg+oIqN7OXIf3c3xFyQebhlwVPbAltQSNTHfbow4lYefc2F+ERzRa0j70?=
 =?us-ascii?Q?8+d7PBEmjPwo8g76c6ypvDEhJ7m9n9vO1V6b8G7ffe/NmfEZI+pHgFrdCXzQ?=
 =?us-ascii?Q?dKscvbWR7zxFUOFMMUO1y69uU3YZBGoTMvPVcfPZHqbmEscTAtryTIAeLh1j?=
 =?us-ascii?Q?JdYfSvhWqeog+AZ2VaipLMIoYxhcPvs1pgWjRKBL/N89rYx3zdlXBGT0aMsA?=
 =?us-ascii?Q?A+M46WmM8Ek/p8FCTjtqb83fOwtgIrMFFhVuM/O5njNXMJESME58IJI/z3VT?=
 =?us-ascii?Q?X9rsRft/Kkdsfx9ma4ci00SXfXMXT54b1UwEfB54aY7MfnJBb5qMy76Eyva/?=
 =?us-ascii?Q?gTo5s4Dwd0v8yEQq9S9p7TvTX/jCdsCEceCbke5b+0UnPCodTavXMRe73GWr?=
 =?us-ascii?Q?RCkCUkuzbdPGH89IsrJRmGDJ70539YVYQLlt05m6JAdIZthmwPtRj98XOIcl?=
 =?us-ascii?Q?Mp/Rh4w5k28ubkr/HoodjqNsv53u9dVLwdTaR4mpQc1P1bSOeoEvnDbQmnzP?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3393EF76F0097F4F9E85C106E1B77230@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jaqh4+0W4LElM6JdqkpkmFSSifoj4qupSEsZgXR1AAvQnesboAQ1jMNbTscesCjZeNtIB1wvTwmEhkVGYJ3FcgTAzbcefEbCLeDA6nc64sWEXCLBgbkndOl2rLQIwFwZcnOHrPeI6rQgXMgyv4kT+zw0pwkMuExvu1xHoJI35VtY14Ip/BiZRq/9rJbqWcEDLwcSdOghn2PvL5ibuzIAMCxf+HD2YFuPYCsI8JkqWf364g9q+/vCaukXG5o9dKa2ktpTqku7v/roM5P9WEf0WWVcMhsGU+YmLLcp5JjA8LhzH87u1HbOzcpf/zxLtt52AHOT5H1zJT6z+aPvafdffTiI4S3DqSvhoG4JZy0zk6Yh1x3YArEyb41saHH4IenFjwdARiEvkRclQMpG5NL/vPHrYNdvTjKgutUUDQ2PIpm0GJ/XBEGfDuO6vYUWnfjARh7U/+XhgzvX3ZHUFnGliKS+BD3w0IjEBgXwxTuHPbUmUEZ99jigeD6SHMEG9qmz1FPJBdvHtMoxCsOzrfjzcwUzRSAwKpqf5WB6L0VXnkbeFRBV+YunIkpjgYnVhC4rUA003x06oiXGiPceM9z5ogI3ZkJS+Zv95mY4mx3YVqIJg4s5MUd7sAMfQ+Yx5a5p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e302e-c318-42c8-6cb3-08dd9439b75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 05:22:56.6784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0930HGmqE2o6aiXwSGiTN50sk4S3lRNFNc3laLC2HlkQaTkR0StJmTQKo2QXtqmErB0n453W6dbHSWJq3IDW0nmegl9RO+L+YYSXK4FMti0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8957

On May 16, 2025 / 00:26, Ming Lei wrote:
> Commit f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_tas=
k and ublk_cancel_cmd")
> adds request state check in ublk_cancel_cmd(), and if the request is
> started, skip canceling this uring_cmd.
>=20
> However, the current uring_cmd may be in ACTIVE state, without block
> request coming to the uring command. Meantime, the cached request in
> tag_set.tags[tag] is recycled and has been delivered to ublk server,
> then this uring_cmd can't be canceled.
>=20
> ublk requests are aborted in ublk char device release handler, which
> depends on canceling all ACTIVE uring_cmd. So cause dead loop.
>=20
> Fix this issue by not taking stale request into account when canceling
> uring_cmd in ublk_cancel_cmd().
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mruqwpf4tqenkbtgezv5oxwq7ngyq=
24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn/
> Fixes: f40139fde527 ("ublk: fix race between io_uring_cmd_complete_in_tas=
k and ublk_cancel_cmd")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

FYI, I confirmed that this patch avoids the hang that I reported in the lin=
k
of the Closed tag. Thanks!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
