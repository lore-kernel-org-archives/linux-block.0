Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86663101C2
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615244; cv=fail; b=i5R2BgJWLCmPezxYA6jiNBx6wVIN/EQM8c57gO+q20V6vID6dhecCml5929QjKmG0ztPoegYBgsMFbu7fIKcSuSi/o0SRJjcUATZPKFjNFSAy4NPtIat+gMueSg2QNJzzN/ZpHXh/ohqt5uekTYNeUmnkmUaGf0ayqTRnSUuZOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615244; c=relaxed/simple;
	bh=sY9YXiDtJlnyZDLx1VVrGBrzEwKS4pI9xPLRbe8FXGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1vKkNO0h6WbeI2c7PTeaBruH7BmIz1tzLjpZnjsp5NDj0zH1Gj0lgAw/ADzH4Ymj90I0E5lMzcHz+XsSp7UEI3K0Gk8BEI7KEO7fxFshNIf/lSAikYz0XA3oXhNjgNWUeGXLiN1b/3l0m8hkzx0d9bOObWHt849JuosdTMnhMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AMcwVdVi; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H+l3OBCS; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AMcwVdVi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H+l3OBCS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758615242; x=1790151242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=sY9YXiDtJlnyZDLx1VVrGBrzEwKS4pI9xPLRbe8FXGQ=;
  b=AMcwVdVi6rKFO5S8Lptc+io4/FT2CviH7V+wHg5eUMDQV/q0J0S51xYe
   CvEOKZ1fv4jsL30j893fm5r9B2/LtESsom/WETl5xGnGeci4BhNH/G7VD
   YN3pXj3o0Me0ikfOVvEAgOZdq0uaXd5uBCAlW9U+nINgvvMbXa/kvDnPT
   0qimdudSCxg/rCeTGQLJ/s+qa2r5hZ+WRmu48KT/QtlPWZkzk7V7v2pOr
   cb8XO9gG6vjm9ZKQCI5bv7A5d9/j7CGalaWIuEaqW/nQeE1v7sox30Zye
   HUJfISjkUcWDLFi/O3WB4Gzh3l+emi/Tx4g61Wc2DhSjCIKyteTeqsfS9
   A==;
X-CSE-ConnectionGUID: G5FtTd/CTbGVSZi2ukqf+g==
X-CSE-MsgGUID: 3ORr56IEQEKD8MuavkFnEA==
X-IronPort-AV: E=Sophos;i="6.18,287,1751212800"; 
   d="scan'208,223";a="128296966"
Received: from mail-centralusazon11010013.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.13])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2025 16:12:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkOK/0mC6F9G6/DGvnhGw6meWoO/7j+NKlbIsOGIdLqHWnuh5XfOfDxsS+fymw8FRlkjo0bggF8EGJ7uBAl4fzUKs56999a2PpTmDt4THdy+eK314bIJ6m7tbFCgQNgZ1tNtqQKhVkT9fGlLnmXuAVPzo11xfTeEE1LreB74FpRKGmfYQVrzw80ehZlxAFbIhz2pBeK765AMmHqhFXpPv7EU2MbdsfzdEBLK9dlBVTK0Bc8EpZMV93horFH+hMqTjDN+Ac0CSA9WIrzeuFurX5CHHOJmWkbJIseSw3Tqe3HoTqNaBmSapgjpUa40X8ve2Iat0+KCL4cGfPGyVOmHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knuBrqOg4vLX0RnjPiPzb+9Vabn2Bjimj+3Kt03doD0=;
 b=ZLvBTGEvvyPTCnx3j6XF0SRYOmOCAWdzb2HHCqya0/haHAGQxUM5Ekre3eDa7DKAoEGu55VyoytdW0ehRmAaa67b2gpARUcm+q3ujIAAm5eRcopuqrxWtPtDhZG35MWqq50KXb1FcJkUrnGfZxBTjjitM+62Uz9ZOpYO1FSRHXrxcjKyif3fRr6NqzRNFnRESdXMnMGkTfosJXVzAraCkBbJfvo6ozUy6dd31b+yfcswlvg3MFRGdy/n/R38yvdVTru9X8dzvDFncrDzXmLchW4MSNddN1nAX1iMzXFlpeI79zJe5S5PQ84fLZYPiINkxM7YFp+G9R7JlsF7Jzqwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knuBrqOg4vLX0RnjPiPzb+9Vabn2Bjimj+3Kt03doD0=;
 b=H+l3OBCSoywvpq8oeZgn9r46Xrm4nfOfFk0PznvmTGDWDVFmwSxACoj8ra++A14nc20C7JB3opbubYiuhqmMaQOgErenzE+XzWNLxBCHY38S/2jCwpum27DhAtUfPcoQbMTX6vspk0F1lxk0UCn1oUUb1RrRxmqmBphENbZKDl4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ2PR04MB8557.namprd04.prod.outlook.com (2603:10b6:a03:4f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Tue, 23 Sep
 2025 08:12:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 08:12:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>, "johnny.chenyi@huawei.com" <johnny.chenyi@huawei.com>
Subject: Re: [PATCH 0/1] tests/throtl: add a deadlock regression test
Thread-Topic: [PATCH 0/1] tests/throtl: add a deadlock regression test
Thread-Index: AQHcKHsjkOCvLWjNmkaQXXpa0j9M/7Sgcr2A
Date: Tue, 23 Sep 2025 08:12:50 +0000
Message-ID: <d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzh@coj4djvqosml>
References: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250918085341.3686939-1-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ2PR04MB8557:EE_
x-ms-office365-filtering-correlation-id: 66ff1c7d-d487-4537-7753-08ddfa78fd9b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S/Yxr3deR0hjMuAqXkvHbxCo18cqF89l6k7emaOAwZnldm1izew1DoVsZYU6?=
 =?us-ascii?Q?htsQGUpmLKAemnZfRNGn5wN1rAUNvgtdaSVqAFLZStngHfSKryImUuNuf0Ar?=
 =?us-ascii?Q?Ep52Enm4DSXwV/gcBFCBC/plcFGCUPsJq3oWJwd8KeJcZqyWm/CswD+lSoLz?=
 =?us-ascii?Q?EtvBMf/Pynk8qBmi3JIFjHVKTDPZ5eu/Fh3TNGQu5APCy3QEBQaaUV7feZuj?=
 =?us-ascii?Q?aQzqWR/6L/ZVCA16xcmnIto0tL/TGFCsZCv09MTI7nULn6cfyzw1fVbYdo0o?=
 =?us-ascii?Q?WIyNIT1/i2yD62JVhP8kds9OLj1JHEQ6UqM5wTnm7LoK0NimMG0Cxvwi2wgT?=
 =?us-ascii?Q?kxVCraynaUVJ0V/PVOcyshwBk/vZmGEF6X7ljaSYN2tEhlTSKl/3BWkAXfOk?=
 =?us-ascii?Q?pugfy5j0RedwbGarbYRolX34WcRBV0gy5pU8KAwH5LVph3Al58kyIll73JQF?=
 =?us-ascii?Q?afM5Ysh1byZd7eIraJV3Ba9/CiDmBKvUFaYdV2p8h8z6gadFG1i3xREnZLMC?=
 =?us-ascii?Q?SsTa0d3Uso9C/h1ec5nbcUw4mf/k8H7INaSYwZh+jrGxCijy3pep+umZ90I3?=
 =?us-ascii?Q?zn2K9lypjkXTPVyUyGG+/AxEFkgcg5pADWcXp5dBQkWsx6rgc6g0OIapuEv4?=
 =?us-ascii?Q?fbpXp1a1sPFqJMXzdRGGl/5eGQTkDCvbi1czUkpo8KlwO0yQl/KUFl6UvOr0?=
 =?us-ascii?Q?7NzMh+maicQyIKiJjI+fKUyi1UYi6/P8q5b53lFXJc+gTcgmcpbdrJeWwjJv?=
 =?us-ascii?Q?talkX4QDXeHrBDNtt2dDwkWH4kWDgDv4hWxtylHI7Ox//M/cYzjKEpXu3np6?=
 =?us-ascii?Q?p/WFnGYCRTOIafu7JyitCMUAfHJ4DPn43/ZP1HIZl/escPZ02FQX6gNSsdt8?=
 =?us-ascii?Q?dvyUGSrI81a2dr67sW8LgKMhXB+LLV80fIgzbbpvOWOzJ27OsbTNSnB99xKo?=
 =?us-ascii?Q?vP00n1C+CHLnxFl9fsTgqvwJyq1oZATGOhLN7/YYMDs7MHsBk9HK1/Fdfc7g?=
 =?us-ascii?Q?6amXwvw+NexmRVWDIjPnIBydUCUu9GcMAN0wFdzQnhvZHDzSfSxo0D51vuP1?=
 =?us-ascii?Q?ZYPGOl9jVhWhPR6sl+MyzY6vIAhysga1elTUP+ouwSnHR9DjPeFqIiDvJvdU?=
 =?us-ascii?Q?uxsrXhltlDUtu7I75Ttu767ovpigOyxRgbTzt9Zt2P3mRp4AvXeCxivNdX8J?=
 =?us-ascii?Q?6CZav0yoNa0aCST28YOt4x1qN2P/SBw4NFh7LfTwEw4f6RYADGfnhYr9Y2Ci?=
 =?us-ascii?Q?xxW/8ISV+Ojpz/Yev/AkoJzdMcJaeMkH4L0Xxqbmw/R+H4ZCpyscAufVwEHO?=
 =?us-ascii?Q?094HFbkXDnPR/mU0G5+l97m14ISqVGXG0LPiL1UbarGhxJtoBr3FWG/6O88Y?=
 =?us-ascii?Q?A+dic29/NwIv+t2Sn+Gt+4Ih5DVPztQyxF6FJUKueD5+xGKTIbITYPqCBMcN?=
 =?us-ascii?Q?EfktfllUprWPx7IaJSH5nGboQs4vC8dx2gwN3pbW1bxUmIHa2ID2SElNWFzY?=
 =?us-ascii?Q?2jxazngHIlnbtpA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XusaVkhEopPMEK5F2B96SfxhcZK5X0XAOP3PrlhGttMFqAB0MZblITakQ1ar?=
 =?us-ascii?Q?/7Pf1+0MWrMvnYnNOd/VtgQKlbYd+1jsPva5YO9EKOPlTIcno1soIGx0IRtT?=
 =?us-ascii?Q?xi9l+6J3s4w3ReKQFBc2pmSuVEJv66EpL+NlZlIj6bkVls6y9ZFM90sUbFJ/?=
 =?us-ascii?Q?yhpkKhzp9mzgzphptRbr9vJEKH0CaiocElnPn9dIyYeiZwxiXmEcjpixCnxh?=
 =?us-ascii?Q?3LrTesYZ3ZXC71Ip7hwEFqUlwKKKUGWO1k1imN3WDFnoxjNlWk6ShNPnxna6?=
 =?us-ascii?Q?AALaRmRT6QH7ps4rcevr5x/vvljSlYMvi7cVzp9QAjozUtfIvlSKbZNQjQfy?=
 =?us-ascii?Q?6LhAoNolPD1QD59k0bCqglaUhxnztbp0Zou5MJ+WvfZ/uyPu/uWH6e83oO+T?=
 =?us-ascii?Q?8odGRLyEWKNXusIciKBUMXAeII2efBsbY+q9LFszyXWqE5R1vU0Fni/3X5XV?=
 =?us-ascii?Q?sMTNUJoR7OSZD5PAx+oru7YlnHisG6XsUh6N/YDzEDPUDME9LFU4FwrxJ61x?=
 =?us-ascii?Q?r84dtHlIFrCzTyu8zhHNRhvr+YsL5LvM/H2Hc3n1v6B9jlT+vLPFnjm/GIOA?=
 =?us-ascii?Q?EhzdpumetIjCCSTCDFjYR2wC45R2o3TUJSNfV5w9XJbjIa7BeBGh5klh5TWo?=
 =?us-ascii?Q?ildMkNdHgo4OJ4OUoh1M/K/VjDYHnmxAoC1MRx/rVmBhPtWgQbM9A6JVLQMG?=
 =?us-ascii?Q?16C4y0MnOH63hPuVZ5mMFS0fh61j1EcWfhqY83Yurl+DZIczo0OJVfDY70qA?=
 =?us-ascii?Q?UX21y4g39znvmxavG1AmQ+QqZ/7aN9daum99rN3Z3YBFTl+ElrMHWgjvhckW?=
 =?us-ascii?Q?bHzRAER0JJrgqKOgfo9EUDG/9pVhjBjOyDfsG/ocYAeNuec46uraFkSB+Jgb?=
 =?us-ascii?Q?SHoM+NkKxuO9pd5sE7s/XEHwR+QhO0+P1Ali1ODvIVlkb09O/2lUlPcsVq6T?=
 =?us-ascii?Q?G2tzd7qdeHL4JeexUMB2kLqmPYzVSmmBx/l5dZ5v6LwiSGVQx0qeRhEiEBWU?=
 =?us-ascii?Q?8CUPhDBqaq6Xx/XpaJSZNc+uD+GSYLqJI/q0YXD5tUhVtu0w+MRmJXvOk3Cf?=
 =?us-ascii?Q?U3dStrI0oYZcEaImxOKj/I/aIuiv36bMxVhZyxTqWoI0G6hW/G0TVK1WQzi6?=
 =?us-ascii?Q?SsCG8UQGsUNCAEpalpOdm01GHmBEzmWAbA6YtHbaTGuWBRbbDtb26a3Mp4Rj?=
 =?us-ascii?Q?H3PO/PqeWrXOnZ4DJOyoJxG1wtI7exCyvR5MbJuohzpHyGa63UJCz4hJbH06?=
 =?us-ascii?Q?0Ju8GRwBufsT35zAcuYZrFtS3L4JRMTN8kR/oEzkH2KWNcZK1qLnzCPy5KnS?=
 =?us-ascii?Q?MFN92MjXr8JNNrwmtUyOtsCn2WprbdczVABnKzEALEa+E6qcK1sxscP4bgy6?=
 =?us-ascii?Q?6+PxXwGEYnmpgYQqeb88BrL9pS+9TOpAdpNUC4NjxCYs1sX8v57aKfoh+qrm?=
 =?us-ascii?Q?Fh2eg3qqTRcXnP9WAmM2U89S3RUXPT3XIX36tTNGipbX95NByjKv3zpO+Jvy?=
 =?us-ascii?Q?M5wIkkdDmkfjLnYjB3jTtkmNjhLT33dw+iYRkqlae8WTiiCQa4+BE0ibj9zE?=
 =?us-ascii?Q?/zuEHADM5Xnw7KE5tT6+krwqM5l4oKUHXHaXuHENOizS7+fogVF977PNY0lH?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzhcoj4d_"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Maiz+ZCYMEDJma+apJKX+HBTPBULSbT533ozWQP9Ea7ECqfWt5CToFsUJYH1+zan7vYp89o4ESfj4RT4mOeFgZBkym36am9NZ64dRoEiv4wnKw1cEeK0IiHygBWwPsDNEvEMwUSm+zE124lYO3ZeSah97ByBdPU0tg/EVc8V20Tj8HhmYq1MiM5bAemUnyxqiIMPwClcRxb3PS8og8VdFgXnB++/iohhjskfEswKbIhpnOloXHaZAdQtiwTR2Sbnxc1gIWDwFhwT9m0hcUIUz8BSn1TkBq3NtuK/bfyOcFORNS1E/+U7YBQum9RoMR7uPNsKtgMbwdwAtqSpDkVj/PRvrtTO7p3EgNOCdVZtquYp0Roo/4rHZvVR94zO2bWMHRmxknjfGee33c0RwK/QXDMBPAQoDv2Hu13NSPT1h5YUKoc2c2r8gtERJ8VPz+JAlm19i8FP1zUQmmBzP482ANtY0qm8r2OKKku6jTLbSKuIz8JwwPyVOm3M9RY9lU5dRa4Z8dKXPTjMkR94VYrBchXGp2ronde0pjN8ZktzCEJWnRDEeF1bhyBI/7ka3BiMmD20VJrS36T3VW/wI9wocqm+Eh3bfnms8E6o8JE8RRKO7cCPoazEOJ2712zSdmyV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff1c7d-d487-4537-7753-08ddfa78fd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 08:12:51.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stDPjt1IhOHHTFz+o6TC+cctd6MR2EYtyqiruMr1SXfHXTzvxAAs2fGbaGDMyYUk+Vy0pSiYuXe4jeGZ2PBRCt0c3hRjnYTw82VAxRRG5IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8557

--_002_d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzhcoj4d_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <765FCFE2A6592249AD272E1919094549@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

On Sep 18, 2025 / 16:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> While I'm looking at another deadlock issue for blk-throtl, it's found
> during test that lockdep is reporting another issue quite eazy, I'm
> adding regerssion test for now, if anyone is interested. Otherwise, I'll
> go back for this after I finish the problem at hand later.
>=20
> BTW, maybe we can support to test for scsi_debug instead of null_blk for
> all the throtl tests.

This is a good chance to use blktests' feature to repeat test cases by diff=
erent
conditions [1]. Test cases can implement set_conditions() hooks for that
purpose.

[1] https://github.com/linux-blktests/blktests/blob/a997ab0ca9b77ddf31b8c63=
2bfe57f7bd75e305e/new#L183

Yu, FYI, I quickly implemented the set_conditions() hooks for the throtl gr=
oup,
and attach it as a patch. When you have time, please try it out. Each test =
case
runs twice for null_blk and scsi_debug [2].

- With this patch, the lockdep splat is recreated at throtl/004. It is
  observed at throtl/001 also as show in [2].
- throtl/002 fails for scsi_debug. I guess performance difference between
  null_blk and scsi_debug is the cause, but not so sure.
- Results are placed in results/nodev_nullb and results/nodev_sdebug.

If you think this approach is good, I will prepare a formal patch series.


[2]

# ./check throtl
throtl/001 (nullb) (basic functionality)                     [passed]
    runtime  4.546s  ...  4.753s
throtl/001 (sdebug) (basic functionality)                    [failed]
    runtime  5.386s  ...  5.842s
    something found in dmesg:
    [   79.444897] [   T1156] run blktests throtl/001 at 2025-09-23 17:05:2=
2
    [   79.684859] [   T1260] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
    [   80.002576] [   T1262] scsi_debug:sdebug_driver_probe: scsi_debug: t=
rim poll_queues to 0. poll_q/nr_hw =3D (0/1)
    [   80.003950] [   T1262] scsi host9: scsi_debug: version 0191 [2021052=
0]
                                dev_size_mb=3D1024, opts=3D0x0, submit_queu=
es=3D1, statistics=3D0
    [   80.009307] [   T1262] scsi 9:0:0:0: Direct-Access     Linux    scsi=
_debug       0191 PQ: 0 ANSI: 7
    [   80.011952] [      C2] scsi 9:0:0:0: Power-on or device reset occurr=
ed
    [   80.018583] [   T1262] sd 9:0:0:0: Attached scsi generic sg3 type 0
    [   80.020594] [    T103] sd 9:0:0:0: [sdd] 2097152 512-byte logical bl=
ocks: (1.07 GB/1.00 GiB)
    [   80.022826] [    T103] sd 9:0:0:0: [sdd] Write Protect is off
    ...
    (See '/home/shin/Blktests/blktests/results/nodev_sdebug/throtl/001.dmes=
g' for the entire message)
throtl/002 (nullb) (iops limit over IO split)                [passed]
    runtime  2.586s  ...  2.486s
throtl/002 (sdebug) (iops limit over IO split)               [failed]
    runtime  6.137s  ...  6.467s
    --- tests/throtl/002.out    2025-09-23 14:05:35.011885439 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/002.out.ba=
d    2025-09-23 17:05:37.209794003 +0900
    @@ -1,4 +1,4 @@
     Running throtl/002
    -1
    -1
    +3
    +3
     Test complete
throtl/003 (nullb) (bps limit over IO split)                 [passed]
    runtime  2.554s  ...  2.424s
throtl/003 (sdebug) (bps limit over IO split)                [passed]
    runtime  3.075s  ...  2.924s
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.269s  ...  1.071s
throtl/004 (sdebug) (delete disk while IO is throttled)      [passed]
    runtime  2.142s  ...  1.471s
throtl/005 (nullb) (change config with throttled IO)         [passed]
    runtime  3.345s  ...  3.420s
throtl/005 (sdebug) (change config with throttled IO)        [passed]
    runtime  3.905s  ...  3.984s
throtl/006 (nullb) (test if meta IO has higher priority than data IO) [pass=
ed]
    runtime  13.014s  ...  13.086s
throtl/006 (sdebug) (test if meta IO has higher priority than data IO) [pas=
sed]
    runtime  5.715s  ...  5.631s
throtl/007 (nullb) (bps limit with iops limit over io split) [passed]
    runtime  4.527s  ...  4.476s
throtl/007 (sdebug) (bps limit with iops limit over io split) [passed]
    runtime  5.065s  ...  5.043s


--_002_d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzhcoj4d_
Content-Type: text/plain;
	name="0001-throtl-introduce-THROTL_BLKDEV_TYPES.patch"
Content-Description: 0001-throtl-introduce-THROTL_BLKDEV_TYPES.patch
Content-Disposition: attachment;
	filename="0001-throtl-introduce-THROTL_BLKDEV_TYPES.patch"; size=10102;
	creation-date="Tue, 23 Sep 2025 08:12:49 GMT";
	modification-date="Tue, 23 Sep 2025 08:12:49 GMT"
Content-ID: <29B5F7B3DB70834CB9E7D114ADA1AD29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSAyNDBhNTRlYTQ3OWMxNTZhNWZlZDBmODMxZmEwODRiMTM4MTU5ZTdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3
YXNha2lAd2RjLmNvbT4NCkRhdGU6IFR1ZSwgMjMgU2VwIDIwMjUgMTU6NTg6NDQgKzA5MDANClN1
YmplY3Q6IFtQQVRDSF0gdGhyb3RsOiBpbnRyb2R1Y2UgVEhST1RMX0JMS0RFVl9UWVBFUw0KDQpD
dXJyZW50bHksIHRoZSB0ZXN0IGNhc2VzIG9mIHRocm90bCBncm91cCBydW4gdGVzdHMgZm9yIG51
bGxfYmxrLg0KSG93ZXZlciwgaXQgd2FzIGZvdW5kIHRoYXQgc29tZSBidWdzIGFyZSBub3QgcmV2
ZWFsZWQgd2l0aCBudWxsX2Jsay4gSXQNCmlzIHJlcXVpcmVkIHRvIHJ1biB0aGUgdGVzdCBjYXNl
cyB3aXRoIHNjc2lfZGVidWcgdG8gcmVjcmVhdGUgc3VjaCBidWdzLg0KDQpUbyBydW4gdGhlIGV4
aXN0aW5nIHRlc3QgY2FzZXMgZm9yIGJvdGggbnVsbF9ibGsgYW5kIHNjc2lfZGVidWcsDQppbnRy
b2R1Y2UgdGhlIGVudmlyb25tZW50YWwgdmFyaWFibGUgVEhST1RMX0JMS0RFVl9UWVBFUy4gSXRz
IGRlZmF1bHQNCnZhbHVlIGlzICJudWxsYiBzZGVidWciLCB3aGljaCBpbmRpY2F0ZXMgdG8gcnVu
IHRoZSB0ZXN0IGNhc2VzIGZvciBib3RoDQpudWxsX2JsayBhbmQgc2NzaV9kZWJ1Zy4gV2hlbiB0
aGUgdmFyaWFibGUgaGFzIG9ubHkgIm51bGxiIiBvciAic2RlYnVnIiwNCnRoZSB0ZXN0IGNhc2Vz
IGFyZSBydW4gb25seSBmb3IgbnVsbF9ibGsgb3Igc2NzaV9kZWJ1ZyByZXNwZWN0aXZlbHkuDQoN
ClNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtp
QHdkYy5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL3J1bm5pbmctdGVzdHMubWQgfCAgMTcgKysr
KysrDQogdGVzdHMvdGhyb3RsLzAwMSAgICAgICAgICAgICAgIHwgICA0ICsrDQogdGVzdHMvdGhy
b3RsLzAwMiAgICAgICAgICAgICAgIHwgICA5ICsrLQ0KIHRlc3RzL3Rocm90bC8wMDMgICAgICAg
ICAgICAgICB8ICAgOSArKy0NCiB0ZXN0cy90aHJvdGwvMDA0ICAgICAgICAgICAgICAgfCAgMTAg
KysrLQ0KIHRlc3RzL3Rocm90bC8wMDQub3V0ICAgICAgICAgICB8ICAgMyArLQ0KIHRlc3RzL3Ro
cm90bC8wMDUgICAgICAgICAgICAgICB8ICAgNCArKw0KIHRlc3RzL3Rocm90bC8wMDYgICAgICAg
ICAgICAgICB8ICAgNiArLQ0KIHRlc3RzL3Rocm90bC8wMDcgICAgICAgICAgICAgICB8ICAgOSAr
Ky0NCiB0ZXN0cy90aHJvdGwvcmMgICAgICAgICAgICAgICAgfCAxMDYgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tDQogMTAgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKyks
IDIxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9ydW5uaW5nLXRl
c3RzLm1kIGIvRG9jdW1lbnRhdGlvbi9ydW5uaW5nLXRlc3RzLm1kDQppbmRleCBhNDJmYzkxLi4w
ZGM5ODUzIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9ydW5uaW5nLXRlc3RzLm1kDQorKysg
Yi9Eb2N1bWVudGF0aW9uL3J1bm5pbmctdGVzdHMubWQNCkBAIC0xNTAsNiArMTUwLDIzIEBAIFVT
RV9SWEU9MSAuL2NoZWNrIHNycC8NCiAnVVNFX1JYRScgaGFkIHRoZSBvbGQgbmFtZSAndXNlX3J4
ZScuIFRoZSBvbGQgbmFtZSBpcyBzdGlsbCB1c2FibGUgYnV0IG5vdA0KIHJlY29tbWVuZGVkLg0K
IA0KKyMjIyBCbGstdGhyb3R0bGUgdGVzdHMNCisNCitUaGUgYmxrLXRocm90dGxlIHRlc3RzIGhh
cyBvbmUgZW52aXJvbm1lbnQgdmFyaWFibGUgYmVsb3c6DQorDQorLSBUSFJPVExfQkxLREVWX1RZ
UEVTOiAnbnVsbGInICdzZGVidWcnDQorICBTZXQgdXAgdGVzdCB0YXJnZXQgYmxvY2sgZGV2aWNl
IGJhc2VkIG9uIHRoaXMgZW52aXJvbm1lbnQgdmFyaWFibGUgdmFsdWUuIFRvDQorICB0ZXN0IHdp
dGggbnVsbF9ibGssIHNldCAnbnVsbGInLiBUbyB0ZXN0IHdpdGggc2NzaV9kZWJ1Zywgc2V0ICdz
ZGVidWcnLg0KKyAgRGVmYXVsdCB2YWx1ZSBpcyAnbnVsbGIgc2RlYnVnJyB3aGljaCBzcGVjaWZp
ZXMgYm90aC4NCisNCitgYGBzaA0KK1RvIHJ1biB3aXRoIG51bGxfYmxrOg0KK1RIUk9UTF9CTEtE
RVZfVFlQRVM9Im51bGxiIiAuL2NoZWNrIHRocm90bC8NCisNCitUbyBydW4gd2l0aCBzY3NpX2Rl
YnVnOg0KK1RIUk9UTF9CTEtERVZfVFlQRVM9InNkZWJ1ZyIgLi9jaGVjayB0aHJvdGwvDQorYGBg
DQorDQogIyMjIE5vcm1hbCB1c2VyDQogDQogVG8gcnVuIHRlc3QgY2FzZXMgd2hpY2ggcmVxdWly
ZSBub3JtYWwgdXNlciBwcml2aWxlZ2UsIHByZXBhcmUgYSB1c2VyIGFuZA0KZGlmZiAtLWdpdCBh
L3Rlc3RzL3Rocm90bC8wMDEgYi90ZXN0cy90aHJvdGwvMDAxDQppbmRleCA4MzVjYWMyLi44OWE1
ODkyIDEwMDc1NQ0KLS0tIGEvdGVzdHMvdGhyb3RsLzAwMQ0KKysrIGIvdGVzdHMvdGhyb3RsLzAw
MQ0KQEAgLTksNiArOSwxMCBAQA0KIERFU0NSSVBUSU9OPSJiYXNpYyBmdW5jdGlvbmFsaXR5Ig0K
IFFVSUNLPTENCiANCitzZXRfY29uZGl0aW9ucygpIHsNCisJX3NldF90aHJvdGxfYmxrZGV2X3R5
cGUgIiRAIg0KK30NCisNCiB0ZXN0KCkgew0KIAllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSIN
CiANCmRpZmYgLS1naXQgYS90ZXN0cy90aHJvdGwvMDAyIGIvdGVzdHMvdGhyb3RsLzAwMg0KaW5k
ZXggMDJiMDk2OS4uYjA4MmI5OSAxMDA3NTUNCi0tLSBhL3Rlc3RzL3Rocm90bC8wMDINCisrKyBi
L3Rlc3RzL3Rocm90bC8wMDINCkBAIC0xMCwxNyArMTAsMjAgQEANCiBERVNDUklQVElPTj0iaW9w
cyBsaW1pdCBvdmVyIElPIHNwbGl0Ig0KIFFVSUNLPTENCiANCitzZXRfY29uZGl0aW9ucygpIHsN
CisJX3NldF90aHJvdGxfYmxrZGV2X3R5cGUgIiRAIg0KK30NCisNCiB0ZXN0KCkgew0KIAllY2hv
ICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCiANCi0JbG9jYWwgcGFnZV9zaXplIG1heF9zZWNzDQor
CWxvY2FsIHBhZ2Vfc2l6ZQ0KIAlsb2NhbCBpb19zaXplX2tiIGJsb2NrX3NpemUNCiAJbG9jYWwg
aW9wcz0yNTYNCiANCiAJcGFnZV9zaXplPSQoZ2V0Y29uZiBQQUdFX1NJWkUpDQotCW1heF9zZWNz
PSQoKHBhZ2Vfc2l6ZSAvIDUxMikpDQogDQotCWlmICEgX3NldF91cF90aHJvdGwgbWF4X3NlY3Rv
cnM9IiR7bWF4X3NlY3N9IjsgdGhlbg0KKwlpZiAhIF9zZXRfdXBfdGhyb3RsIC0tc2VjdG9yX3Np
emUgIiR7cGFnZV9zaXplfSI7IHRoZW4NCiAJCXJldHVybiAxOw0KIAlmaQ0KIA0KZGlmZiAtLWdp
dCBhL3Rlc3RzL3Rocm90bC8wMDMgYi90ZXN0cy90aHJvdGwvMDAzDQppbmRleCA4Mjc2ZDg3Li43
MDBlOWU2IDEwMDc1NQ0KLS0tIGEvdGVzdHMvdGhyb3RsLzAwMw0KKysrIGIvdGVzdHMvdGhyb3Rs
LzAwMw0KQEAgLTEwLDE0ICsxMCwxNyBAQA0KIERFU0NSSVBUSU9OPSJicHMgbGltaXQgb3ZlciBJ
TyBzcGxpdCINCiBRVUlDSz0xDQogDQorc2V0X2NvbmRpdGlvbnMoKSB7DQorCV9zZXRfdGhyb3Rs
X2Jsa2Rldl90eXBlICIkQCINCit9DQorDQogdGVzdCgpIHsNCiAJZWNobyAiUnVubmluZyAke1RF
U1RfTkFNRX0iDQogDQotCWxvY2FsIHBhZ2Vfc2l6ZSBtYXhfc2Vjcw0KKwlsb2NhbCBwYWdlX3Np
emUNCiAJcGFnZV9zaXplPSQoZ2V0Y29uZiBQQUdFX1NJWkUpDQotCW1heF9zZWNzPSQoKHBhZ2Vf
c2l6ZSAvIDUxMikpDQogDQotCWlmICEgX3NldF91cF90aHJvdGwgbWF4X3NlY3RvcnM9IiR7bWF4
X3NlY3N9IjsgdGhlbg0KKwlpZiAhIF9zZXRfdXBfdGhyb3RsIC0tc2VjdG9yX3NpemUgIiR7cGFn
ZV9zaXplfSI7IHRoZW4NCiAJCXJldHVybiAxOw0KIAlmaQ0KIA0KZGlmZiAtLWdpdCBhL3Rlc3Rz
L3Rocm90bC8wMDQgYi90ZXN0cy90aHJvdGwvMDA0DQppbmRleCBkMTQ2MWI5Li5iMWY2MTEwIDEw
MDc1NQ0KLS0tIGEvdGVzdHMvdGhyb3RsLzAwNA0KKysrIGIvdGVzdHMvdGhyb3RsLzAwNA0KQEAg
LTExLDYgKzExLDEwIEBADQogREVTQ1JJUFRJT049ImRlbGV0ZSBkaXNrIHdoaWxlIElPIGlzIHRo
cm90dGxlZCINCiBRVUlDSz0xDQogDQorc2V0X2NvbmRpdGlvbnMoKSB7DQorCV9zZXRfdGhyb3Rs
X2Jsa2Rldl90eXBlICIkQCINCit9DQorDQogdGVzdCgpIHsNCiAJZWNobyAiUnVubmluZyAke1RF
U1RfTkFNRX0iDQogDQpAQCAtMjIsMTMgKzI2LDE1IEBAIHRlc3QoKSB7DQogDQogCXsNCiAJCWVj
aG8gIiRCQVNIUElEIiA+ICIkQ0dST1VQMl9ESVIvJFRIUk9UTF9ESVIvY2dyb3VwLnByb2NzIg0K
LQkJX3Rocm90bF9pc3N1ZV9pbyB3cml0ZSAxME0gMQ0KKwkJX3Rocm90bF9pc3N1ZV9pbyB3cml0
ZSAxME0gMSAmPj4gIiRGVUxMIg0KIAl9ICYNCiANCiAJc2xlZXAgMC42DQotCWVjaG8gMCA+ICIv
c3lzL2tlcm5lbC9jb25maWcvbnVsbGIvJFRIUk9UTF9ERVYvcG93ZXIiDQorCV9kZWxldGVfdGhy
b3RsX2Jsa2Rldg0KIAl3YWl0ICQhDQogDQogCV9jbGVhbl91cF90aHJvdGwNCisNCisJZ3JlcCAt
LW9ubHktbWF0Y2hpbmcgIklucHV0L291dHB1dCBlcnJvciIgIiRGVUxMIg0KIAllY2hvICJUZXN0
IGNvbXBsZXRlIg0KIH0NCmRpZmYgLS1naXQgYS90ZXN0cy90aHJvdGwvMDA0Lm91dCBiL3Rlc3Rz
L3Rocm90bC8wMDQub3V0DQppbmRleCBlNzZlYzNhLi4zOTk3NTMxIDEwMDY0NA0KLS0tIGEvdGVz
dHMvdGhyb3RsLzAwNC5vdXQNCisrKyBiL3Rlc3RzL3Rocm90bC8wMDQub3V0DQpAQCAtMSw0ICsx
LDMgQEANCiBSdW5uaW5nIHRocm90bC8wMDQNCi1kZDogZXJyb3Igd3JpdGluZyAnL2Rldi9kZXZf
bnVsbGInOiBJbnB1dC9vdXRwdXQgZXJyb3INCi0xDQorSW5wdXQvb3V0cHV0IGVycm9yDQogVGVz
dCBjb21wbGV0ZQ0KZGlmZiAtLWdpdCBhL3Rlc3RzL3Rocm90bC8wMDUgYi90ZXN0cy90aHJvdGwv
MDA1DQppbmRleCA4NmU1MmIzLi43NjkxYWQxIDEwMDc1NQ0KLS0tIGEvdGVzdHMvdGhyb3RsLzAw
NQ0KKysrIGIvdGVzdHMvdGhyb3RsLzAwNQ0KQEAgLTEwLDYgKzEwLDEwIEBADQogREVTQ1JJUFRJ
T049ImNoYW5nZSBjb25maWcgd2l0aCB0aHJvdHRsZWQgSU8iDQogUVVJQ0s9MQ0KIA0KK3NldF9j
b25kaXRpb25zKCkgew0KKwlfc2V0X3Rocm90bF9ibGtkZXZfdHlwZSAiJEAiDQorfQ0KKw0KIHRl
c3QoKSB7DQogCWVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KIA0KZGlmZiAtLWdpdCBhL3Rl
c3RzL3Rocm90bC8wMDYgYi90ZXN0cy90aHJvdGwvMDA2DQppbmRleCBiNmY0N2QxLi5hMTMwOTJl
IDEwMDc1NQ0KLS0tIGEvdGVzdHMvdGhyb3RsLzAwNg0KKysrIGIvdGVzdHMvdGhyb3RsLzAwNg0K
QEAgLTEwLDYgKzEwLDEwIEBADQogREVTQ1JJUFRJT049InRlc3QgaWYgbWV0YSBJTyBoYXMgaGln
aGVyIHByaW9yaXR5IHRoYW4gZGF0YSBJTyINCiBRVUlDSz0xDQogDQorc2V0X2NvbmRpdGlvbnMo
KSB7DQorCV9zZXRfdGhyb3RsX2Jsa2Rldl90eXBlICIkQCINCit9DQorDQogcmVxdWlyZXMoKSB7
DQogCV9oYXZlX3Byb2dyYW0gbWtmcy5leHQ0DQogCV9oYXZlX2RyaXZlciBleHQ0DQpAQCAtMzQs
NyArMzgsNyBAQCB0ZXN0X21ldGFfaW8oKSB7DQogdGVzdCgpIHsNCiAJZWNobyAiUnVubmluZyAk
e1RFU1RfTkFNRX0iDQogDQotCWlmICEgX3NldF91cF90aHJvdGwgbWVtb3J5X2JhY2tlZD0xOyB0
aGVuDQorCWlmICEgX3NldF91cF90aHJvdGwgLS1tZW1vcnlfYmFja2VkOyB0aGVuDQogCQlyZXR1
cm4gMTsNCiAJZmkNCiANCmRpZmYgLS1naXQgYS90ZXN0cy90aHJvdGwvMDA3IGIvdGVzdHMvdGhy
b3RsLzAwNw0KaW5kZXggYWU1OWM2Zi4uOTdkZWNlNiAxMDA3NTUNCi0tLSBhL3Rlc3RzL3Rocm90
bC8wMDcNCisrKyBiL3Rlc3RzL3Rocm90bC8wMDcNCkBAIC0xMSwxNCArMTEsMTcgQEANCiBERVND
UklQVElPTj0iYnBzIGxpbWl0IHdpdGggaW9wcyBsaW1pdCBvdmVyIGlvIHNwbGl0Ig0KIFFVSUNL
PTENCiANCitzZXRfY29uZGl0aW9ucygpIHsNCisJX3NldF90aHJvdGxfYmxrZGV2X3R5cGUgIiRA
Ig0KK30NCisNCiB0ZXN0KCkgew0KIAllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCiANCi0J
bG9jYWwgcGFnZV9zaXplIG1heF9zZWNzDQorCWxvY2FsIHBhZ2Vfc2l6ZQ0KIAlwYWdlX3NpemU9
JChnZXRjb25mIFBBR0VfU0laRSkNCi0JbWF4X3NlY3M9JCgocGFnZV9zaXplIC8gNTEyKSkNCiAN
Ci0JaWYgISBfc2V0X3VwX3Rocm90bCBtYXhfc2VjdG9ycz0iJHttYXhfc2Vjc30iOyB0aGVuDQor
CWlmICEgX3NldF91cF90aHJvdGwgLS1zZWN0b3Jfc2l6ZSAiJHtwYWdlX3NpemV9IjsgdGhlbg0K
IAkJcmV0dXJuIDE7DQogCWZpDQogDQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGhyb3RsL3JjIGIvdGVz
dHMvdGhyb3RsL3JjDQppbmRleCAzMjcwODRiLi4xYjY0NTNjIDEwMDY0NA0KLS0tIGEvdGVzdHMv
dGhyb3RsL3JjDQorKysgYi90ZXN0cy90aHJvdGwvcmMNCkBAIC02LDI1ICs2LDExNyBAQA0KIA0K
IC4gY29tbW9uL3JjDQogLiBjb21tb24vbnVsbF9ibGsNCisuIGNvbW1vbi9zY3NpX2RlYnVnDQog
LiBjb21tb24vY2dyb3VwDQogDQogVEhST1RMX0RJUj0kKGVjaG8gIiRURVNUX05BTUUiIHwgdHIg
Jy8nICdfJykNCi1USFJPVExfREVWPWRldl9udWxsYg0KK1RIUk9UTF9CTEtERVZfVFlQRVM9JHtU
SFJPVExfQkxLREVWX1RZUEVTOi0ibnVsbGIgc2RlYnVnIn0NCit0aHJvdGxfYmxrZGV2X3R5cGU9
JHt0aHJvdGxfYmxrZGV2X3R5cGU6LSJudWxsYiJ9DQorVEhST1RMX05VTExfREVWPWRldl9udWxs
Yg0KK2RlY2xhcmUgVEhST1RMX0RFVg0KIGRlY2xhcmUgVEhST1RMX0NMRUFSX0JBU0VfU1VCVFJF
RV9DT05UUk9MX0lPDQogZGVjbGFyZSBUSFJPVExfQ0xFQVJfQ0dST1VQMl9ESVJfQ09OVFJPTF9J
Tw0KIA0KIGdyb3VwX3JlcXVpcmVzKCkgew0KIAlfaGF2ZV9yb290DQogCV9oYXZlX251bGxfYmxr
DQorCV9oYXZlX3Njc2lfZGVidWcNCiAJX2hhdmVfa2VybmVsX29wdGlvbiBCTEtfREVWX1RIUk9U
VExJTkcNCiAJX2hhdmVfY2dyb3VwMl9jb250cm9sbGVyIGlvDQogCV9oYXZlX3Byb2dyYW0gYmMN
CiB9DQogDQorX3NldF90aHJvdGxfYmxrZGV2X3R5cGUoKSB7DQorCWxvY2FsIGluZGV4PSQxDQor
CWxvY2FsIC1hIHR5cGVzDQorDQorCXJlYWQgLXIgLWEgdHlwZXMgPDw8ICIke1RIUk9UTF9CTEtE
RVZfVFlQRVNbQF19Ig0KKw0KKwlpZiBbWyAteiAkaW5kZXggXV07IHRoZW4NCisJCWVjaG8gJHsj
dHlwZXNbQF19DQorCQlyZXR1cm4NCisJZmkNCisNCisJdGhyb3RsX2Jsa2Rldl90eXBlPSR7dHlw
ZXNbaW5kZXhdfQ0KKwlDT05EX0RFU0M9IiR7dGhyb3RsX2Jsa2Rldl90eXBlfSINCit9DQorDQor
IyBQcmVwYXJlIG51bGxfYmxrIG9yIHNjc2lfZGVidWcgZGV2aWNlIHRvIHRlc3QsIGJhc2VkIG9u
IHRocm90bF9ibGtkZXZfdHlwZS4NCitfY29uZmlndXJlX3Rocm90bF9ibGtkZXYoKSB7DQorCWxv
Y2FsIHNlY3Rvcl9zaXplPTAgbWVtb3J5X2JhY2tlZD0wDQorCWxvY2FsIC1hIGFyZ3MNCisNCisJ
d2hpbGUgW1sgJCMgLWd0IDAgXV07IGRvDQorCQljYXNlICQxIGluDQorCQkJLS1zZWN0b3Jfc2l6
ZSkNCisJCQkJc2VjdG9yX3NpemU9IiQyIg0KKwkJCQlzaGlmdCAyDQorCQkJCTs7DQorCQkJLS1t
ZW1vcnlfYmFja2VkKQ0KKwkJCQltZW1vcnlfYmFja2VkPTENCisJCQkJc2hpZnQNCisJCQkJOzsN
CisJCQkqKQ0KKwkJCQllY2hvICJXQVJOSU5HOiB1bmtub3duIGFyZ3VtZW50OiAkMSINCisJCQkJ
c2hpZnQNCisJCQkJOzsNCisJCWVzYWMNCisJZG9uZQ0KKw0KKwlUSFJPVExfREVWPQ0KKwljYXNl
ICIkdGhyb3RsX2Jsa2Rldl90eXBlIiBpbg0KKwludWxsYikNCisJCWFyZ3M9KCIkVEhST1RMX05V
TExfREVWIikNCisJCSgoc2VjdG9yX3NpemUpKSAmJiBhcmdzKz0obWF4X3NlY3RvcnM9IiQoKHNl
Y3Rvcl9zaXplIC8gNTEyKSkiKQ0KKwkJKChtZW1vcnlfYmFja2VkKSkgJiYgYXJncys9KG1lbW9y
eV9iYWNrZWQ9MSkNCisJCWlmIF9jb25maWd1cmVfbnVsbF9ibGsgIiR7YXJnc1tAXX0iIHBvd2Vy
PTE7IHRoZW4NCisJCQlUSFJPVExfREVWPSRUSFJPVExfTlVMTF9ERVYNCisJCQlyZXR1cm4NCisJ
CWZpDQorCQk7Ow0KKwlzZGVidWcpDQorCQlhcmdzPShkZXZfc2l6ZV9tYj0xMDI0KQ0KKwkJKChz
ZWN0b3Jfc2l6ZSkpICYmIGFyZ3MrPShzZWN0b3Jfc2l6ZT0iJHtzZWN0b3Jfc2l6ZX0iKQ0KKwkJ
aWYgX2NvbmZpZ3VyZV9zY3NpX2RlYnVnICIke2FyZ3NbQF19IjsgdGhlbg0KKwkJCVRIUk9UTF9E
RVY9JHtTQ1NJX0RFQlVHX0RFVklDRVNbMF19DQorCQkJcmV0dXJuDQorCQlmaQ0KKwkJOzsNCisJ
KikNCisJCWVjaG8gIkludmFsaWQgYmxvY2sgZGV2aWNlIHR5cGU6ICR7dGhyb3RsX2Jsa2Rldl90
eXBlfSINCisJZXNhYw0KKwlyZXR1cm4gMQ0KK30NCisNCitfZGVsZXRlX3Rocm90bF9ibGtkZXYo
KSB7DQorCWNhc2UgIiR0aHJvdGxfYmxrZGV2X3R5cGUiIGluDQorCW51bGxiKQ0KKwkJZWNobyAw
ID4gIi9zeXMva2VybmVsL2NvbmZpZy9udWxsYi8kVEhST1RMX0RFVi9wb3dlciINCisJCTs7DQor
CXNkZWJ1ZykNCisJCWVjaG8gMSA+ICIvc3lzL2Jsb2NrLyRUSFJPVExfREVWL2RldmljZS9kZWxl
dGUiDQorCQk7Ow0KKwkqKQ0KKwkJZWNobyAiSW52YWxpZCBibG9jayBkZXZpY2UgdHlwZTogJHt0
aHJvdGxfYmxrZGV2X3R5cGV9Ig0KKwllc2FjDQorfQ0KKw0KK19leGl0X3Rocm90bF9ibGtkZXYo
KSB7DQorCWNhc2UgIiR0aHJvdGxfYmxrZGV2X3R5cGUiIGluDQorCW51bGxiKQ0KKwkJX2V4aXRf
bnVsbF9ibGsgOzsNCisJc2RlYnVnKQ0KKwkJX2V4aXRfc2NzaV9kZWJ1ZyA7Ow0KKwkqKQ0KKwkJ
ZWNobyAiSW52YWxpZCBibG9jayBkZXZpY2UgdHlwZTogJHt0aHJvdGxfYmxrZGV2X3R5cGV9Ig0K
Kwllc2FjDQorCXVuc2V0IFRIUk9UTF9ERVYNCit9DQorDQogIyBDcmVhdGUgYSBuZXcgbnVsbF9i
bGsgZGV2aWNlLCBhbmQgY3JlYXRlIGEgbmV3IGJsay1jZ3JvdXAgZm9yIHRlc3QuDQogX3NldF91
cF90aHJvdGwoKSB7DQogDQotCWlmICEgX2NvbmZpZ3VyZV9udWxsX2JsayAkVEhST1RMX0RFViAi
JEAiIHBvd2VyPTE7IHRoZW4NCisJaWYgISBfY29uZmlndXJlX3Rocm90bF9ibGtkZXYgIiRAIjsg
dGhlbg0KIAkJcmV0dXJuIDENCiAJZmkNCiANCkBAIC01OCwxNiArMTUwLDE2IEBAIF9jbGVhbl91
cF90aHJvdGwoKSB7DQogCWZpDQogDQogCV9leGl0X2Nncm91cDINCi0JX2V4aXRfbnVsbF9ibGsN
CisJX2V4aXRfdGhyb3RsX2Jsa2Rldg0KIH0NCiANCiBfdGhyb3RsX3NldF9saW1pdHMoKSB7DQot
CWVjaG8gIiQoY2F0IC9zeXMvYmxvY2svJFRIUk9UTF9ERVYvZGV2KSAkKiIgPiBcDQorCWVjaG8g
IiQoY2F0IC9zeXMvYmxvY2svIiRUSFJPVExfREVWIi9kZXYpICQqIiA+IFwNCiAJCSIkQ0dST1VQ
Ml9ESVIvJFRIUk9UTF9ESVIvaW8ubWF4Ig0KIH0NCiANCiBfdGhyb3RsX3JlbW92ZV9saW1pdHMo
KSB7DQotCWVjaG8gIiQoY2F0IC9zeXMvYmxvY2svJFRIUk9UTF9ERVYvZGV2KSByYnBzPW1heCB3
YnBzPW1heCByaW9wcz1tYXggd2lvcHM9bWF4IiA+IFwNCisJZWNobyAiJChjYXQgL3N5cy9ibG9j
ay8iJFRIUk9UTF9ERVYiL2RldikgcmJwcz1tYXggd2Jwcz1tYXggcmlvcHM9bWF4IHdpb3BzPW1h
eCIgPiBcDQogCQkiJENHUk9VUDJfRElSLyRUSFJPVExfRElSL2lvLm1heCINCiB9DQogDQpAQCAt
MTAyLDkgKzE5NCw5IEBAIF90aHJvdGxfaXNzdWVfaW8oKSB7DQogCXN0YXJ0X3RpbWU9JChkYXRl
ICslcy4lTikNCiANCiAJaWYgWyAiJDEiID09ICJyZWFkIiBdOyB0aGVuDQotCQlkZCBpZj0vZGV2
LyRUSFJPVExfREVWIG9mPS9kZXYvbnVsbCBicz0iJDIiIGNvdW50PSIkMyIgaWZsYWc9ZGlyZWN0
IHN0YXR1cz1ub25lDQorCQlkZCBpZj0vZGV2LyIkVEhST1RMX0RFViIgb2Y9L2Rldi9udWxsIGJz
PSIkMiIgY291bnQ9IiQzIiBpZmxhZz1kaXJlY3Qgc3RhdHVzPW5vbmUNCiAJZWxpZiBbICIkMSIg
PT0gIndyaXRlIiBdOyB0aGVuDQotCQlkZCBvZj0vZGV2LyRUSFJPVExfREVWIGlmPS9kZXYvemVy
byBicz0iJDIiIGNvdW50PSIkMyIgb2ZsYWc9ZGlyZWN0IHN0YXR1cz1ub25lDQorCQlkZCBvZj0v
ZGV2LyIkVEhST1RMX0RFViIgaWY9L2Rldi96ZXJvIGJzPSIkMiIgY291bnQ9IiQzIiBvZmxhZz1k
aXJlY3Qgc3RhdHVzPW5vbmUNCiAJZmkNCiANCiAJZW5kX3RpbWU9JChkYXRlICslcy4lTikNCi0t
IA0KMi41MS4wDQoNCg==

--_002_d2qk4s5jbdd2fiqnjvg43ik3e5qplwffmnjjgy2ewrhqs3quzhcoj4d_--
