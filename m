Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C323F374
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689761; cv=fail; b=QeCsvyeQChEnZuZrgKcOb0fhUCUDYtP4oEPrEgz078LKAPyncscGDnOJeBynSSSMNx0OHeTGxTFkfhPsBMfPuyfmu48Qb5ZQOK6BbhS1qBLicX+XmmKkJCocRhoDPU0xFckjDJnq2CLTkn1nXwSTo0jsf+lXgDJkhUGA/T7EMUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689761; c=relaxed/simple;
	bh=mN9Q2Rmp8Agt8jOiRVj1hnAEoW0nqa9Pq/ruYV005hI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6HLQqH9H2QApxkfnq8liuyvdrzXi5dfUF9I1gDTOSVpggd21Fuq1za1BpKBZ0UGLrjbuoIsrs4tjnqyu2CVq1z6uO+uuJKFXOE8Qhjq/7l+fvL5Tojwv53ENlBL3gvwQFU9ZYZdlOPaWSFMzra/qNz0+os45P0SkFRK9alkIiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cSVr022e; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fjsCgK8/; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cSVr022e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fjsCgK8/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741689760; x=1773225760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mN9Q2Rmp8Agt8jOiRVj1hnAEoW0nqa9Pq/ruYV005hI=;
  b=cSVr022e1xjCXrHurIMCZyR1iAM5+qcUcGOyljI7TSTkIk1HFqZJOiIl
   udM+f9PChCKfAX4onW/XKDrlKf776WTemg5nxIZLfbHxGb2e4Y3p3Gsw0
   NjPSheBmQMvSQofTuzKK7NfQ1FH8iZ+6GhvmkmX1V+IziaSwZBq+CdhXz
   WrfHbd+5IW4zZQrkyFq4EXjCrHGWC5Wsnq9ryfQVC1tPYaf8yaTuP41oU
   SaasCcUMdMNHnN70sIppWZLUvSU6hGjxY7EBt+eg6ERlRr/Maqr/MXIfl
   WMlyLMVki38I1m+W1zOEFjRaVefkWaeo1sPcxdJiiMFxrXADWKP9ws+4Z
   Q==;
X-CSE-ConnectionGUID: hqGnOfviRayt0RNcU6EZHA==
X-CSE-MsgGUID: 8120jqkWRN6fMGYArMd+dw==
X-IronPort-AV: E=Sophos;i="6.14,238,1736784000"; 
   d="scan'208";a="45394286"
Received: from mail-westcentralusazlp17011031.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.31])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 18:42:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOyC92KRMpLA8axKBCOIFXMrwwY17K1VauD6t4dFY1+RcftYOcT+OA+R0Lgx2egbGqfbe9pPOc5iYyA0nl9f5pDgkU7dfG/NRlOrdN/9/a7FtmVhJ501dIeYIhKHi1Q7LDxTkgbJEpi4tYrrFUXVb8DqF93TAAW+6kzeIOUozmd91cohrAG84zlqPmTT17j6Yw1tW3OBaUNE6GHFLT6o91i3SSEQxiNZYdibFTvFgonT6+BDpopzAQYQ2hG9TcVg/tnyq4gMCS4PXwktuEBTtvzlJ9zoL66RM/wyCrOj6ZLYjlrtoiYMKtDvVmymdtHFkI7mQWbgf3TADCQd9bcuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN9Q2Rmp8Agt8jOiRVj1hnAEoW0nqa9Pq/ruYV005hI=;
 b=Z57SWTXVUa1saDclfmWfhM59fOLasMnBLGeDt8NoztOALXnjFD3jG4sshUeoFmik3khRBwN7kIj6Dhscxl5j+HsDyMmPoIDqBLc8/T67kdQgu4Lyr3GOsl+d7/7WAJ+fFe7sNJZ4+tk/YZdpwGQjtRgPC9wfZnKzW4C1/2fGCJF4GEWmBTa86M+OXPhYXyfmBHf/YeHiKnE/0McAJjlqIFzyYpKJaL1Z/i9dHYwoo4VfR9yVaeRVfqXHA4Aczjuk6IzIxYw1qYqNwXHRiyBYLW1+zSzSyTQyHUHjF/TwdnIOISTXbrl7/hGRGK4Gml8vDBEogxn/ZH/8KOVGPCz1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN9Q2Rmp8Agt8jOiRVj1hnAEoW0nqa9Pq/ruYV005hI=;
 b=fjsCgK8/zjWUlsRdFkkzTcn3GV+I1cbqd5TKnrWlku1WET9/+3TJrH5Y0mSTlCK+Lacgcs2eKB1O3WnsTFyA3Vsy4hI1qQGc/GsqbPNAtcg5mV0wKvtDZLBHorGMdPBqiQgeKOH6BTMPrcCZgvKwuFXtkFVn50fyyJChmHODTSk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6674.namprd04.prod.outlook.com (2603:10b6:a03:223::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:42:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 10:42:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
Thread-Topic: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
Thread-Index: AQHbki8tFpPA8PVXJE+J41voKxqzp7NtlnGAgAApxYA=
Date: Tue, 11 Mar 2025 10:42:32 +0000
Message-ID: <azwm5cno6croi4l3pbp73z53wa77i4gleetrvn5jjf7khi2e2t@ru4yijtbgluz>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
 <Z8_wjZUNvM7JAWAQ@infradead.org>
In-Reply-To: <Z8_wjZUNvM7JAWAQ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6674:EE_
x-ms-office365-filtering-correlation-id: dae46e68-720a-4c30-beb6-08dd60896e0c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RrZ1xj5f4sO6so/IdYkaKKEtndh8FA8GA8Y8wQILMM/+bRqKjv5VpZZZuE?=
 =?iso-8859-1?Q?4qMGTeHt88Z+Wre4d+fSuQIk45ffJuc8mejV99ttCIzu3wgLBg4gV0fKN6?=
 =?iso-8859-1?Q?rRbxEEUhHherL1qH6IKofN32UOwg7dpZ1ifmNV0gdxfXmymbmGru+C6LFK?=
 =?iso-8859-1?Q?xxslhryWU3cYOEM8IhhwOKVJi3qskxMcYcC1WgMrUE4bLY7fqVyj8olSTq?=
 =?iso-8859-1?Q?+9frlJfqd9WkbWI+hBW7EQnuERLhlkM5TdfbuouSOUMOaTQD/pOMLHkwPr?=
 =?iso-8859-1?Q?OglaqxgdwBLkj1fQio/HtECWwXhDNIPJ3n3VnvIlE8n143KynRJS4JLk0W?=
 =?iso-8859-1?Q?3Ri62Rljb7jQJA4PSej8NG4oulDXPpNeHuV54qlprOFsJFnqJAeoOvCKsG?=
 =?iso-8859-1?Q?3u559vbtXxIrvCEOcS/0h6YJGZVe5xDlYvYLVhwXTLsOYSfgaF3R3r50oy?=
 =?iso-8859-1?Q?Nb4x28pDcwAKQpIK698ruQLc49gVxfsyNlLMxT3nzNHhssyAYWIQ7HKX3p?=
 =?iso-8859-1?Q?RXO20GQL+2Ru/XvaksEpjAt8Zg2IsvELqCevqIw0+UHkRX6dLnF2GquYLg?=
 =?iso-8859-1?Q?WB/MpoLNRRi54vpuA51nskIUVzokucNP+HSf/E4beBKpLDy0G/KSBf+xGm?=
 =?iso-8859-1?Q?ReV9s3d+1K0UpPG/aP/fRAxVHQsBhEKrDII0DOdRhe1ygLlyruGKMlrMQM?=
 =?iso-8859-1?Q?i0/0MxGHAzBfQHnz71uo964LN6KC+fNgurxaFAF9aRTAYwnDoBxJ1gfShS?=
 =?iso-8859-1?Q?GKBsDCiRou4emBAbA34HeW6dzSCt/DBaq4BpjjZTezHzjQatx7Gme0T75g?=
 =?iso-8859-1?Q?kuxhCuPo4IVZpTql4qPIIx4uuVu8aqAhL99V4IFCPElGWg97YBu39UQNvw?=
 =?iso-8859-1?Q?7Ynn30fmsJQ9jaH0cu+QqMhbMcjbq3KPtg6uO9lqLLI8ACx/n9wk2xF++E?=
 =?iso-8859-1?Q?U/XYk/5L8x3B5tjvhQsYneJJZ6hlWhoZdbKO/aOirqzefFIN1B8TEBRBUT?=
 =?iso-8859-1?Q?5u4VkuEsvftOv04dTPgc+MFiIwbpvQ98hRnOSFk5A2BOP1hYtHeh2T/R6b?=
 =?iso-8859-1?Q?VTjRKiE1W3inJ/IIaAid4BUz8j1RdXZjMz82VwvsGZh03dpcN12rrLW2/x?=
 =?iso-8859-1?Q?DStNlkRt18be/cTEp2Jn7hIRfm1/BkByBnAcHlSSWpMYik7cuRpWoeDbvl?=
 =?iso-8859-1?Q?LlUleWIuvGsdl5ojkHnTVyGYbgpD5pSTZ05xg93QkuxglJNTBxeMjsrcrE?=
 =?iso-8859-1?Q?vniSYoIc9bojbVn/B3BGauW+cOMixkcPT9LTdd2We9ZjRcymj8i+hGdAAg?=
 =?iso-8859-1?Q?6ljnW7C7t3RRKYHaC/SIaG3DOrflikEHJ7doVyfXD5Iy/HYcDZ8bmNDjIi?=
 =?iso-8859-1?Q?5fy8grWZujiVAE4SFQlG0slrr5BxH69EsocPHtSfyLypyRJ4vqmLMF6/bI?=
 =?iso-8859-1?Q?rOiyVvDa3yTYxBlJ+1Hq9FJRZ1WbGxZ9enQg2iXeMcmElA2mZ6xg1fDN06?=
 =?iso-8859-1?Q?Ry7/4LdB91+BIShup44QUu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?u9rL2Oh1f/8dwvFexYfOIcxvqbWg+8YgHA29KyPitI7hXyuKTbZSzmKLp6?=
 =?iso-8859-1?Q?kVNhzV/U1jPLYfYrej9T0MovO3x7dZ4hOT/4LYNipxbmScfs5FmbA+vHY9?=
 =?iso-8859-1?Q?x9Wut2EPcwY08aEFu2VUugOBZvuHfvpN1FaT/4hhqxJb9maXNG62fSCQ5H?=
 =?iso-8859-1?Q?3Gz81YqCclr03yYtu4p8XImrjWNyWbzawDxUPZAajm55uKChVFIP1nX8cC?=
 =?iso-8859-1?Q?ci0Lqz4E04LzVEuPKVnLx/S/Y0gDUqGGRBCjXwSJYR+qOACzyLaYbfx69L?=
 =?iso-8859-1?Q?vCtMAEUQaEtSkE1v3CUFemJN//dTAufS2/FPMbtFkSYKVLT+OTFO93YEz1?=
 =?iso-8859-1?Q?HXzikFmTPqAVhmMpYFaXsTDeADrwKadhFdiF2oxsCE/6eb4HwrOCJ86p1r?=
 =?iso-8859-1?Q?YPyz1vrS3QCE5y6C5uc1xHhHGlh+NqwlG3eIOJg1PQWA5KL+DsMjK+VXXT?=
 =?iso-8859-1?Q?PpO03kUHrhdGWc7namybk8RGlls1achmxOMGnq/GLgxoBTu2coM3lCvgUT?=
 =?iso-8859-1?Q?Np+Ww1/iVR1cCk/PHgu8xMNMjj/2GCpWSfp10AYtGxmsO0enMkPc7/Sw5z?=
 =?iso-8859-1?Q?GrRcfUFIGKhPywAjPL3wUdtYvWmat3Ep4eqsQbck8oTtfyvzgZHLN0iFR6?=
 =?iso-8859-1?Q?/p8u6/bBZJFDjfsMymzJHGUTKR4tgE3gQH7XRAgCoZYJzHMAU6II3R615h?=
 =?iso-8859-1?Q?Vsr/WI8tiDFK3aKFkK5KXenArQhc8KNbjnwTMl24YR5d6b0SZqaypXA3X7?=
 =?iso-8859-1?Q?cT9GWakSSXLOaEkI+Te/AIKlH4WjmML6fF99HZ5HMFzELrGyvwEKP9Iyst?=
 =?iso-8859-1?Q?ZYSMxOzVHOs6Rin6K856EnNj6NLmmCqdHdEvxtZdeFKhAmY3iqjtIt7VX4?=
 =?iso-8859-1?Q?x4jsmHUACz3a0WvaisUVLOzyuZrg0dKcoo4xn/zxPPLliZoix0egdrpdki?=
 =?iso-8859-1?Q?pYyqItC8jfihRM67AV/6chAIrdN+f/KJUDCZ+t+dJsb2OCaKBxp1cWVBP8?=
 =?iso-8859-1?Q?kavzk5kk8pnMSalsfat2RaCu17eOpVjwKmvQ+aepBIHwPBT0dPzI/4AQ2w?=
 =?iso-8859-1?Q?p3EQhzRgHiOVehtIonmOSJ+zBlHTxNkYibvsq7RMGQZTbxc78CZCbt69dH?=
 =?iso-8859-1?Q?9ErLbqvokSzlQaS/+02Dz6OVv3AE7hbQJQvaKKCCnhRptGLI957dBon+2O?=
 =?iso-8859-1?Q?7VViFT7Ap5CsQN8P8ngUqYgrNl/ojkJgimlk2X4zWQyd3lmzxh+6EFTJ+s?=
 =?iso-8859-1?Q?L1attQMcfmGsIa1+RZdRABnWrjlAmh+STywrrcR3pyNUa7F4H2B3SikMXm?=
 =?iso-8859-1?Q?FjPtkvlbJuXKczDjEFmBP4o2fo+Sy33aUA1FPrK/v0IP3MerBH4WIJ2zdO?=
 =?iso-8859-1?Q?INmxXEU37jqy/Vgx+9okPTGPooiO6XDcWVKh8mx1f5L5ahIYNE5Qe4bUgW?=
 =?iso-8859-1?Q?RmL07nxLrIDRbpw5BkfDcCSojav2QtRiyAXlW4XWLg0pMTKFnFTu7jyvVn?=
 =?iso-8859-1?Q?VN9BqzM1oqLnPm1s3tb+Cai9nA4q/hBULmsesfS6yjEmyssqqih18KTVEi?=
 =?iso-8859-1?Q?uHnms1/9CuPx7P8FIv2WR0aoqNOCl2c9zEkTZHu+gFUEws0JiXU5gtEBfG?=
 =?iso-8859-1?Q?PWCJklyfPWfWRVlOIPqT4Rdn8p1oH2NS6SD1Q9wnBSFEOGJgdIlrt+3zOh?=
 =?iso-8859-1?Q?2sGgb58GIiY1N6LNdoc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F6F867C5B4748242AB178B06DC340FEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w6FePRJiTDMXKScJM179qDT6h6O44lfbIrdq4pWmzwBa5375GUe++v3SEeldWz/IBHSmtXlDzBeUWlvpUGRgcyPFTXmucmDQjG1HyPhXdfUCApr5c7Ugjy12nF1Dd4853PEGDklqkQBNLuG2KzhfIx2sn/Uo3SQPNZfbvFkIeKjRQ00O8awnkSxOSy5moqZJUSaO+BP2BBKFxY841j0LL7j8BbWmOrhuibQxoIlbRsW2IAdkDS1YaCr2XthJw1VUyj6Tv/XOwFHpy6TPDfPO2bAjb/6vWloeh27fxSmW1e0f+wxYti0IFnwmNG8Xxn4+2kxLXpT0KH84WT2R5d2ZV5rMp7y1cqp+XEDvVJYIkl3nRlBzOLfLAgbpXYz1Mu4IAKKUZIkuZGwjGBQKigAiyzOJliz0JEg4hT5Xu0J7aGek5xS6atzICG8qfLxFTGOgln+LP09GjHIEMdWIw/Ppo7O7UwJYBq551x5zHlgC3xhJWg03Z92t5WSY1NLojY8w2QqRBFATjPjx/tlUL66SGoFiHf7jom5vvp0uNIGSYsIoQluuc/QLBM2H16L6cunMxIbdtnsbfI1r7MGR2uWLI7nM1cAkyT0/whACNjBqtbrAvbvKD/dyVTd0VSBkGRM+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae46e68-720a-4c30-beb6-08dd60896e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 10:42:32.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsgTE7d7wWAqBTQjEuV6062/Y678dxLPYF5mkJ8ut1TtFu4YtKCPIZpT20qLHaoevk7QQjVz4ah+yNAxDebwMYUd/sH0a6fHKzp7I/yFO6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6674

On Mar 11, 2025 / 01:13, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 11:41:44AM +0900, Shin'ichiro Kawasaki wrote:
> > However, blk_mq_add_to_batch() callers do not pass negative error
> > values. Instead, they pass status codes defined in various ways:
> >=20
> > - NVMe PCI and Apple drivers pass NVMe status code
> > - virtio_blk driver passes the virtblk request header status byte
> > - null_blk driver passes blk_status_t
>=20
> The __force cast in null_blk should have been a big fat warning..
>=20
> > To correct the ioerror check within blk_mq_add_to_batch(), make all
> > callers to uniformly pass the argument as blk_status_t. Modify the
> > callers to translate their specific status codes into blk_status_t. For
> > this translation, export the helper function nvme_error_status(). Adjus=
t
> > blk_mq_add_to_batch() to translate blk_status_t back into the error
> > number for the appropriate check.
>=20
> This still looks a bit ugly because of all the conversions to a
> blk_status_t just to convert it back to a errno just to check for
> a non-zero value (blk_status_to_errno can't return a positive value).
>=20
> I suspect simply passing a "bool is_error" might actually be cleaner
> than that,

Thanks. Hannes made same comment. Wiil do so in v2.

> combined with a proper kerneldoc comment for
> blk_mq_add_to_batch explaining how to set it?

Will add it in v2.

I Will send out v2 soon for furhter review.=
