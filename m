Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B018E1F
	for <linux-block@vger.kernel.org>; Wed,  4 Jun 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035837; cv=fail; b=QoixPX3bGz83C7SFGl9cubMVYuapU2uFIMxvZkWZC51RuMaroH7BP3rNEpXcs75gdudhESXQZjjJxemHMbgwNgs2/L7hN1U2ddEwCoID+tVasYQ8bUALF7yaVNVHzG/ie+ne+kx85hkgWffun2nwxHOhxzZS7hCbKMY4/I0wnp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035837; c=relaxed/simple;
	bh=2Hlp2mAxFtfZzrzW+KfFlgRUyri7CHDE6cnXT+4UOkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mP+47UzZ1uAgPLYnSdOaDMEVC30rSD5KEK3zVOcqtXLxX6Y8lKXLEf6Fa8aGKGACXIi/e6Xde0l4Bo1DSUc+4mc3mBm67mIb4ntryZ3f5U7VxhNYLPQJTQKdc3GHKJtJSAomt2jZkO8VZ2KwHNTsyLmes0Jf/yX3V5H5d45LXnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kLuR5erJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DJyuvvkB; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kLuR5erJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DJyuvvkB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749035836; x=1780571836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2Hlp2mAxFtfZzrzW+KfFlgRUyri7CHDE6cnXT+4UOkg=;
  b=kLuR5erJ02zf3Wao8/+yE/FF7hEUzet1zrUGb93vbvlA6BbOS4rXtxjT
   uOrCeOzmrhvvwUhamSb4H6XnWo5Up2n6F8LSaIb/g/CqvrmrizMSVisjg
   SQH48/G2Z8kRacxo6hkc6BjLtTlMY4tNJCJ6j5781b0lwo7EYfjWspyJr
   AToG6vNqa0ZErM5ky6L1APxKZSVik/8TX1UuYlgStlv83jZYS529Req7u
   0IuBmUcios2gayixMb4U0BKGvMc2cXFNBr4MpBw+ZlbD4kIZhth5aB3Qg
   opwtk4nKjisfM+cXz+5jBWCGduDvpB6sBDmuQM5NFCd3/NzVN0xCjrRaB
   g==;
X-CSE-ConnectionGUID: 2bF9Pm0CSOGDgA1M++Jf1g==
X-CSE-MsgGUID: l3PDhhlCSqKgxq/6Hm3SmA==
X-IronPort-AV: E=Sophos;i="6.16,209,1744041600"; 
   d="scan'208";a="83969594"
Received: from mail-co1nam11on2085.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.85])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2025 19:17:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5KNJlXLQwxUZq19O+mH/0gosYubggFcUK37HhJi8De7eXU0ijhJwfVZU+YWDM8VVPcVBJxF0hnObfZryQhvyCCoCBBjFUdyc5fAcFkhEmSr1+mQbZarO+ItDOYKIYwugKLPUXmG89ereiol4rOZD2udzupWU8kJEsFJRnIkx9BT5uLvTrMLSfnZOYWw7nhPwPEwBHbxhMmpxfQxru9HElwSf+BQmLuCP86dJZjD5EjceATEKfmJ76eFvjg5zrWM3rWL79MVfQ3gPzuS2PxrzMhUpOkEsX7mumvAdGe/c/R+PdwTFdjseRsymrlQyettctMic64A4uw/FZiKBCdI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSFV0YoQTtC2xHDPwhfVxaDvj8hN3pAG62+DCtjZ/aU=;
 b=RqhYwgegWzqJGZ7dU8QN/R7uxvL2+KPviDoNZqJfjRprWQK6oI7ULcx0JbUV/lBu1dYpN1N3BpYJHLZnA9OzQn44paCpjl56Xa2Ue6Fvu+rooJ4k8A2ix8k/nutaofjS70hJHujG5Zi7IRwtNrPmghBPakeVgIq2sX/IJfK+cuILPvE9MOOVKvk6OlrTTMa2L1AvXH0QQjVrHeESaEyarqUeMWkGcdqB14h498AE7uhYdRZP1u6B/2YKCYqUbNQ1oAkkjiySXthnjA6sCeO9chypLb9BCXRTbHxMaTokQbY0rO7tXQJiVkdqT92XhK5SOe3VJRz0U86JoyvXIN053Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSFV0YoQTtC2xHDPwhfVxaDvj8hN3pAG62+DCtjZ/aU=;
 b=DJyuvvkB+MhmTKjLnkklBhY6hmBcKo5F2EAIAYqOloVUTeQkfJalEUDvBVEot88IphMMhVHxfHjDEz4qBagD+ZyLJijyQtPP3EwaJYw3yLfYDKxXMSPfm8AWvidRXB3E66jR7CU3FBFkC0n+5gRbIcYOqfSCIc/UibRnG7folOg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN6PR04MB9682.namprd04.prod.outlook.com (2603:10b6:208:4ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 4 Jun
 2025 11:17:05 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 11:17:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Topic: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Thread-Index: AQHb03fJCWxsffIFEkOwzl+UxhDZyrPxRfWAgAFSe4CAAEUDgA==
Date: Wed, 4 Jun 2025 11:17:05 +0000
Message-ID: <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
In-Reply-To: <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN6PR04MB9682:EE_
x-ms-office365-filtering-correlation-id: 1e08238b-9ade-448b-7b19-08dda359567d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WLPUXGeyfsNs5duJxnlPousR3zHFLhZSPNeTwVrD1nlcFxGE9ej8Hnexoc?=
 =?iso-8859-1?Q?HV/1J46W3UEv46ip69HBUWBIaBO0Db6kKtpltsJNJ1vxPYEbdg3xZRSzHj?=
 =?iso-8859-1?Q?G1Uckxk/Bf5r8C4w8dp9ZNyl4Ly64lCZ01ieD2swvJxTL+7MTz4i13/HQ8?=
 =?iso-8859-1?Q?PwLq01uzzCoEoQV1zL0IcxUAPO7WSsHLARrCgJGbNUl/TlnjkHfK4du1FF?=
 =?iso-8859-1?Q?5Lpt9sn9ka642vYz7XZVOGsmcVdumtVu8LH35YX9QVtai/Ql5KwVKpic7L?=
 =?iso-8859-1?Q?9peIORW82Z5/H/9sLbuFISkMAtbOBK8zsmbSXv+eJ2FX3nH5AY6bZ2Kgdv?=
 =?iso-8859-1?Q?bfhIj0VTOQCXRMgL2OK9fWKVmxHxjAX4hnekLxIbOZFMCEpI/KSfh/dlaL?=
 =?iso-8859-1?Q?nbpV+LBmJIMWjg2rs41t/zJ0u2wn6bvNCiBlojHrA1Fol3ZnEWJEbu3H6K?=
 =?iso-8859-1?Q?RzHQW8ggtc+vdblBqs2GZcFRfA47E7ufc/ILuga1SrpvMQ66XgwlXbbUb0?=
 =?iso-8859-1?Q?1/vcifH77I8zpgJDQ8vLhxfCwsWjDL76QGWz4wkPfvebKtsfAO3mCGoy9u?=
 =?iso-8859-1?Q?pf2eVQJbRQ2FoLgKpajR7t492jo2QzPOpEnOM/TfEfEm2ZeQ5KGQCMlJIf?=
 =?iso-8859-1?Q?qfcK3wjG8qkoyX30noiUODEzg8xKfA93kdw6o++DrADXKV7LS9VOeQqkX9?=
 =?iso-8859-1?Q?l1GaqrvloLnoP6fXZxQYer3eHojTrMrZ86qjDsEgoJcw1D+TTWmG3nZDrk?=
 =?iso-8859-1?Q?kfYRWvaOoOl6JRO5eypfwIl86DKNs5EMfIxqoZmIq3jFpNgZg8QbwFUaL0?=
 =?iso-8859-1?Q?ZywAmT6py+WC20h2v8OZX4xJfMXeWq0Cv4RnslagxhP8HQKPft2DINFXsS?=
 =?iso-8859-1?Q?+wH+UpVGj3/OcS2/4rvGfY+9EQsopg2kyZDFz+6u6u+UsB13i8cl/4g7Oo?=
 =?iso-8859-1?Q?6nlXVy0xM6WLlx6zHq3I+962LZvVWYtG9L2SK/H3LWD9+WwRPySZEG691f?=
 =?iso-8859-1?Q?HSOo2l+uqktdKS2UyLiV8DaIR396VRzqmxOgZIQaXZ2Yf00YsrlQiUCMb1?=
 =?iso-8859-1?Q?0srRqhPbM5lRvpdoNvMMmReqWkH3PhAd7KFJ1mzTzVLv/46a+j3aGE9FFS?=
 =?iso-8859-1?Q?wC9Q+6n1NWqWq5c8J/EEraXpmdCmXTOAYVbz0LTm0JbNhDsdHgXYkya+vB?=
 =?iso-8859-1?Q?mVd7AO2iKqwrUNJvWEh1SI0C7S+Y2a1tueIR+jj0gYBPxc/ovRzOyVEsVp?=
 =?iso-8859-1?Q?VPBGE8ZSZy0X8fwiCVgcTiL1Ygqm6MXCWaSfIIRdNaDUssfAhUVVRHa65J?=
 =?iso-8859-1?Q?9cjfaXAfyHKoUqaKTDIANqXD6/tT9R5QjTdm+80B9xs66NMzZL8Mb+MbKC?=
 =?iso-8859-1?Q?a4+LE1yCHMzkVgN8Pg8+I6P4aAXkMnD1odEqDuA5HDlNdhvO17akViTMd7?=
 =?iso-8859-1?Q?fmWDjrdC5f22bXV9JtE4aGPCXi6o5Y0/xrJ4Vt3LSuxvfKXMznIu6OR1vT?=
 =?iso-8859-1?Q?q+kGMfTDchYxyBMl+3Vn3G2bnrmA0Yh3IBN4WA7MA+uwex/9xiHE6oWXVd?=
 =?iso-8859-1?Q?PJ+tAQI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rraNs0rcGGyHRaVIlHNfGbiT6ghSNOco1TyFtTS6qlogSsZX+kblOywY64?=
 =?iso-8859-1?Q?WHc6KudbI4xiV8+TKPTFy/wj3qFgHxhMZtUYqj2tIpo0526HSCm/bmTc/P?=
 =?iso-8859-1?Q?iStmeLtFB+h7O7cLmbSM99T6Rqpi8ZrGqlBsgFSSSbhODu6E1IRmQug3lJ?=
 =?iso-8859-1?Q?u8QA+wDZvp85e6E1QnHakcqhV9/Kb6KJYF69FWIpToG0SKIFxmpXmEGU6v?=
 =?iso-8859-1?Q?cu3z1ecsY1FPuK2AOJs//UhKBiqPaXLDhNNShuRVC23dxZ/VUwvxRmjuPL?=
 =?iso-8859-1?Q?qV2pXi1UuXgwAPxtvrtmKQmocBKNegIXtUGXdAW/+mlqnMltO9GX8RZEOW?=
 =?iso-8859-1?Q?DY6S6/CKQ1BS46sCdvD4ATtgBcjVurOu50LHfVcb8Dupg1f3XN5x3DLBSn?=
 =?iso-8859-1?Q?ooIIyYqsrBkJhd7pMWNZ55ld6J0rIar7u6+gg2Xg/Bg8jgu3RdSnM1WGYz?=
 =?iso-8859-1?Q?CG9gIqmZHkbJJa338Z3fV1rUB5CCKFYJztIlsvYafGlaM6WuxDl9qIHg4Y?=
 =?iso-8859-1?Q?xeMIFN8nZbSIK52XiUWzWf8Xm2HOp/N7D7+zTuN53kJQcGcYCfFrrJ0wFC?=
 =?iso-8859-1?Q?gbv05IYO9Sv2jYshBBjYTkjZyxs3pd58Xvzv1uhVLzCE6B9vBaKfkaGo4o?=
 =?iso-8859-1?Q?th6tURQDtIUDigYRCrbi+xSSOv/nW9BX/EUYAjDY6BMxBTDGQOTb7/mn39?=
 =?iso-8859-1?Q?3q7SBWJ45a1AFnS35eeC9AUqv9uc21NxAlWbx3nOh77EU2H5X1O8lMXl9c?=
 =?iso-8859-1?Q?udNp9nTGyEGgAlVOHCh01bTgThovM2RKE+40/gEbSePcj0rMAVovOgOS+t?=
 =?iso-8859-1?Q?M+0V6iJCYWA7twEAgacDys7XVv76vkuD2aSNgqA/zOJOsGt5ZAuKZQthqb?=
 =?iso-8859-1?Q?HtCD0VF7itjlxbhKZifGGzzXQI+Zk5obnxrEkXGLFfOMUZVoyn7nH6b89w?=
 =?iso-8859-1?Q?YVvf9ox1upIjbuukWxwlmhDKfIM1itax07qVAdl8rS9Y5BoC2a4ep+J2Nf?=
 =?iso-8859-1?Q?UThNJghL9svoo8imEI9r4orAFHXZdB0st5VshuHzxvodM7TafqvufBdenG?=
 =?iso-8859-1?Q?kmTb03XnX//403PH+BkzOQdUSGSj3lNbhXfXZ7Cn46JWwUgeLAkE/SOBhC?=
 =?iso-8859-1?Q?D21L/dN+vshIRw/0jePaXjxaoSWKSVlJrwfBcBv0K+vd/172arGrAJVYwD?=
 =?iso-8859-1?Q?62/TxOtsmeFQftKzbXrrU6sQ/yQEeu51GLTHI9HdFP2aTa4tCqc5GmZeQd?=
 =?iso-8859-1?Q?0gwd03ZAToVUsWw0u1EQ5LnnqfAkWMOIEsO0sBjbJhj8yZdBKZSHhAXM7L?=
 =?iso-8859-1?Q?J9Z9Uf6NkJS9fG4Q5VoRG31uWR9cVTPYw20Z6/Vg/jv8g+TYIVNySzNBVA?=
 =?iso-8859-1?Q?UinpqyEvNPB62bZ3ToNCU5aHAveRSFeAT8cylTvN0tnS4rXpjP7N+CaghY?=
 =?iso-8859-1?Q?fyOjnFGBqiIHB6WJot2/PmMy/UfD9ZYK7N93VMsjZwtI5QG1hGUR8aZKkT?=
 =?iso-8859-1?Q?OxHrwQOCZQ94Qrr8uSn28iZWAYPULMu47fVVhf/jvlJTeFulyB1JkghzCO?=
 =?iso-8859-1?Q?BeKpuBwp0eOtgt0WugItadraT/CvoLPDfXEQL6MCIx8qdcVZ6AhaXXZYn1?=
 =?iso-8859-1?Q?/CAudN5f4iQEWPV9ErB7MDjNhCvsPrVQ04ZV17w/5vCCsyG/Dt1/lHPA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2727B97B8460B54E85D7BC5C3BB193F6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KRzrEcZi1dASpuraZXLUnqGAOjKIyINYLmL0MtwLgd37UQJzZyAxOeaa6FQgLHxKe/Rdlf56XNgrxTxyg/yousLbPHjqrZSQp8BK0NMUztRJJM9I0KrAfDa2pDWN2dg5mqBJ8aM1hkzY1CswjHrFyKfkIRM5GIbni8A8V1oYJGnZ6iE+Uc/SUneosmhov9paHaPI7g2H74acO5SaRb11T5lm66LyhTzHPsYmY7/jn259k+hoGQtaxpxR+lgkZCAlk0rLqhv2s4lGiCP+MTC+VoUB5v5lpm4hyZP2Ur5spAncgKrFnfuiOYyKNvCnQIFgZL1Acie8H9O9eQ6a3+j8hpMH6CeizuKSIoMekB8ifZG/Ddbu1xvN4mNR9nt1xpo4hBGkMDPOG7hQ5pfIEBkBFnsH1yN8N0Uhkui08NJwiz2SSTPe4TrHTr59omROV0SH7iwOOmTxyZKxw4UuAeGk8lIVsV8DkHOuCN2T4djKIJtRrLhI/cX3WERA4eJLbyY28VX4pmgOWi684esV4rpd/6yDjjF/M65EyW7UrQ3pLVSnNgTCnyrd950FdV+VvFzlSOTbQlZWwwRY/71a5u7XBYVvP/3o/p4mWA0PsPJ/jfR+Q/vb1Dxh5iKzmoZOh0eB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08238b-9ade-448b-7b19-08dda359567d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 11:17:05.4720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwVj0AxpDOU5XBWFdhBfEZ0Y0Tg4uUYOID0yfNjybuzp4Ur7f9NB2Jo5mpApCFpQ+Fl5za8C1bRQjAz4gbRjdiPYCMtpQpbFxz8fjAoZXWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9682

Cc+: Ming,

Hi Sagi, thanks for the background explanation and the suggestion.

On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
...
> > This is a problem. We are flushing a work that is IO bound, which can
> > take a long time to complete.
> > Up until now, we have deliberately avoided introducing dependency
> > between reset forward progress
> > and scan work IO to completely finish.
> >=20
> > I would like to keep it this way.
> >=20
> > BTW, this is not TCP specific.

I see. The blktests test case nvme/063 is dedicated to tcp transport, so th=
at's
why it was reported for the TCP transport.

>=20
> blk_mq_unquiesce_queue is still very much safe to call as many times as w=
e
> want.
> The only thing that comes in the way is this pesky WARN. How about we mak=
e
> it go away and have
> a debug print instead?
>=20
> My preference would be to allow nvme to unquiesce queues that were not
> previously quiesced (just
> like it historically was) instead of having to block a controller reset
> until the scan_work is completed (which
> is admin I/O dependent, and may get stuck until admin timeout, which can =
be
> changed by the user for 60
> minutes or something arbitrarily long btw).
>=20
> How about something like this patch instead:
> --
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c2697db59109..74f3ad16e812 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> =A0=A0=A0=A0=A0=A0=A0 bool run_queue =3D false;
>=20
> =A0=A0=A0=A0=A0=A0=A0 spin_lock_irqsave(&q->queue_lock, flags);
> -=A0=A0=A0=A0=A0=A0 if (WARN_ON_ONCE(q->quiesce_depth <=3D 0)) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ;
> +=A0=A0=A0=A0=A0=A0 if (q->quiesce_depth <=3D 0) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_DEBUG
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dev =
%s: unquiescing a non-quiesced queue,
> expected?\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 q->di=
sk ? q->disk->disk_name : "?", );
> =A0=A0=A0=A0=A0=A0=A0 } else if (!--q->quiesce_depth) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_queue_flag_clear(QUEUE_=
FLAG_QUIESCED, q);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 run_queue =3D true;
> --

The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
ask your comment on the suggestion by Sagi?

In case the WARN will be left as it is, blktests can ignore it by adding th=
e
line below to the test case:

  DMESG_FILTER=3D"grep --invert-match blk_mq_unquiesce_queue"

Said that, I think Sagi's solution will be cleaner.=
