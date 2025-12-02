Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB30E831
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670959; cv=fail; b=aCQKpcuZsflsGWXB5Q5CuPgF+xiqwkBLrhKBhj7/t+rsQHUcefGbRS8lrDmpzl8MEDAZQ2J4aYrUkCKJA+Pc2HcJggAOKzwuIvUk6wMiOjUcx7uxmwaBEm8Y1pgKb/2ZHWQYjJDtbLxFCUHbKUnh/mL5iMbT4zxbaJCph3m/ZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670959; c=relaxed/simple;
	bh=aDnj/dr5INNND9Mqr6Nwgx5/NpxjRRRBdV3pxI5m7cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CUnbYuolIJ8BLjpttTKzjk3AnSw4wsYF3R7y95RRgrwy3ERRo6xpCxhyhqik3wUIB8dIw5ucLFwvqp1TJXQkaMEfa9pCzOu0SoF0MrcpdySEL2jM8gVx338BhpIgt/TvAjWI3clvdS530PypCn7XpaO43JFvpR/R43WVM9nC1p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lZELUZFU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P55TeNUe; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lZELUZFU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P55TeNUe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764670957; x=1796206957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aDnj/dr5INNND9Mqr6Nwgx5/NpxjRRRBdV3pxI5m7cY=;
  b=lZELUZFUPJLlhTWcZeFNNNaOYSVL12q33PeSf5aUcElEJ3pAn3tNWmRV
   lQ/ETLAFcbEtTEVKGGOw/0x3uVCrKt4Z/V/CLhy8j1+WBK/T4CxXAsWfF
   tMt7W9aVbUqaPfW4M7Cyv+7BNbR99J6vDanZviI0kXLRU6vR0F4sYGkcV
   /uEbkudHJuidAGE6Vg50kzCnBFibHUuAVryIfWjohaSANbDcYeJm/iyVs
   BDYhnmmWsW8DI2Eb5NUnulPBZkUzYOzf2U8EHXuSXFCJGx5UFVKCC8xuy
   8Mt/BzeCR42xD36PU4bxZ94v7bPsAdYGm/wav1DGpFWNprnIVS3q443Nf
   A==;
X-CSE-ConnectionGUID: kx5Gb6BIQr+eFVeGLP6NDw==
X-CSE-MsgGUID: VKMlPkYXT5yFsTEgh5gUmg==
X-IronPort-AV: E=Sophos;i="6.20,242,1758556800"; 
   d="scan'208";a="137502996"
Received: from mail-westus2azon11012064.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2025 18:22:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVXHJXpe0MW4hJ3WNQndrWvBikcpVgjh+CZVrLFe8h7MopTkn7qrSAMlmhuW6/YbqlNAv0ZD6LKuBHARf5DcxRVi10ACWFmXkJ8Xbv/vs4NHjmw4VWAGVQ85io0lv0G+AFGyeUuEnyVawtv04vH77AZTJzMaplGQNTQbxumuBL6b9meYZjhgqoTOv+67TZQlEU+9V2vpywH+lhn+HdL9F+bFSc+W5whor4JSuIVcfTl8jJw4jGk7ZmlfygddT1CC2NqXClU1Q+tXhJoGZIBMVMQvx3Zb1QEDrTUWlzwI1Z4kYQZ21Zv0iab9yVLMV8RRtw2YR9tbkga+zeHFOig3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hw5kk3GFJA6iXmzJ//6OYG12I4oQ0zdp92tfhAbj5I=;
 b=BOswEyJ51/GoBVeP248Cc/NfBLTmZqd0pL+VCNXC2jkq/sijHTCwIKmgLqqJqnLZs9EhzGUHhZt+Bd5J+dQJT6veR3jORL5x8kyfmtVJYqHuReGZ14shMjvuAJNuxUA42gm1/KnphnYIRmJhKJKulINlVqA49SapQCUTe1x3kati4Td3TFN//JgdBYG2bpc96N7iQ46T2m+huBMj8oz4zQaWz20uJYrdt6WNCRt89R1TktCcapDk9Zg6v8xK+8mB05xSchcL5H+PGDsy8XNxjm/WimtpPBXMeEZ2adcUPhxHZO3xLXm7903jNPQ/RQT57uSHLXRPrU0+rez2DX9wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Hw5kk3GFJA6iXmzJ//6OYG12I4oQ0zdp92tfhAbj5I=;
 b=P55TeNUeq7OYuDlhIYsIVxTW7SXNczt9mr7t5z9+wN3wt5mLEzg399pcE/HD+1yLnQo0NvzxWH9EbKx2SKe+OOEZbpaBOi4BFU2BkBdXh5qRaB9mfgvPtQk4mPKCP2QjkEkZuWc1gyPMxguhHoorq8bF/rVteif4AEhm0lCD0hc=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7351.namprd04.prod.outlook.com (2603:10b6:510:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:22:33 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:22:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Topic: [PATCHv2 1/2] blktests: test direct io offsets
Thread-Index: AQHcWY5oK4YlIertQUeyjLZiqQGMbLUDSZMAgABYZICACpYPAA==
Date: Tue, 2 Dec 2025 10:22:33 +0000
Message-ID: <5wzzqmgu5mnq7ijpozsrhnn6g6hepmchvxz2wxm23obc36l7za@rjoew5uzuipj>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
 <y744um3exsnhtf5u4iabfipzwkexcz5t3xqe4vvspa7z7hfuws@y5mbl2oszpuy>
 <aSXci0u7c9Ppnjbd@kbusch-mbp>
In-Reply-To: <aSXci0u7c9Ppnjbd@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7351:EE_
x-ms-office365-filtering-correlation-id: 5981cce1-53c1-4f95-9c60-08de318cb4e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xgN856i/4XlK5wEqfhjCvas0NtvsHfuEU8NqqM4RYXBZDmTvngBgxTmQ+OSq?=
 =?us-ascii?Q?Hs1zwsXg75zxo9q9YtDYUgkIObZtJZFPNq21bWkrNx+Hnwg7s3lieFNl52rW?=
 =?us-ascii?Q?I8fs2NPzO0h7iUh7R1qKzBYc2BPTtzCwOBs5787GBSem4B+ll4Go9iy+Pl1O?=
 =?us-ascii?Q?K2bOl1zslkIH0zhKt9mC3rGm55bE8piLqflf9wR/izoQlCIxWH8iMCjGCMne?=
 =?us-ascii?Q?pblyR8Z3j4/W2MmI6qgsUQm/UsCcJbdHlJCa7gvn60JHvqL/cDqIZAN230si?=
 =?us-ascii?Q?rkywS47LL2UFbH1eH5zGpmXTvFv5sjuCumqIaxi121hKLneMvNFX6DzsHARa?=
 =?us-ascii?Q?M5sQoPfKX6OV8WrAgicKZEr96dBi62BW2ytf6HH6Bdd1KnYJrsjT8cpXkiV3?=
 =?us-ascii?Q?Y0PfumLta0AErmkDbDnMr8n3lUwcMx0BtlDgvsTEDsgoyVTFXCjolnGNNdv2?=
 =?us-ascii?Q?+/usPazJ2fpeTIdnCAjfyP2Gc8Jzm+svN0SnYB70x62xKOuwzrV7Df/JI1Ql?=
 =?us-ascii?Q?80F+zybwS8CvTvIX4CNfkbPJtvfbUfNKqHgS3f1fakUvxevgMepVV2u6x2lq?=
 =?us-ascii?Q?oQmph1qNpwOIuo5I+9SgmgtBtYpO6Qx+ynhodjFrQwpjaaz18giV18xkN0ty?=
 =?us-ascii?Q?WNuaSpiJCrKZtC9AU77WSiXXBVXeeYhQLDK37x4AaZSFUy81eP2NEizwU/hl?=
 =?us-ascii?Q?QzLjEwU7xvbxuOwX/uiUTFpLgtva/QVX7CEAU/N7LE9r0V932Ojbez40J0TB?=
 =?us-ascii?Q?4W1QSP+F5zraPLnKSIUuOfEaWL1o+XOIP9QK7AcAOudhw3g6nq1FThvguNNc?=
 =?us-ascii?Q?z5Zzs1vyP9DZYLUtS9HTmfyFd0mnG93bm4by4qMvSxJo25v4v37wiwJGaQdu?=
 =?us-ascii?Q?qKrzHe35HJYv4S23BLmwgph1hqoQe6MphVr/ec+Z8ps9FaePQrBUFORAJLQd?=
 =?us-ascii?Q?0FImtXexranqPmFXJkQ0Xk+u4E0Ak9c3cppU7sVjQio9kt1K7oYlXVMLAcwI?=
 =?us-ascii?Q?4aFXz/jv0+UsZTx56ARKLTGvcTRXaL/fGN12S7dnhnebeUbgBYAypUgarNen?=
 =?us-ascii?Q?f1QAVLW3oSO++90PkSZmFwvNaUUpThq4V5fAZwbESmblcOgb4fhgndaKzn7N?=
 =?us-ascii?Q?tcv8XmWVh8dcB7mLzzC7/RG3icshqxgcMJTWLF1hhkBE+ivRbVNdMkwZEibt?=
 =?us-ascii?Q?4NkV04CPWloO6in7nQJNIWBsX3OmlzeZlfAM59oD55aHLQXh55esEhLCbP+J?=
 =?us-ascii?Q?pHEpSDMbEJrhbDmZExTzpwSl+Er7zmk9BNdatsxy0Hc8mIsiQ/N4qUczg536?=
 =?us-ascii?Q?lrvMS0VztuRQBMQ5lfc4/RJnPF4cixQVVgDXQUCGId9YgbgS7yzVClpzND9a?=
 =?us-ascii?Q?HXcUc+BVenREnlM0FEy4eysh6mbipYON3TqEHywMPakRjIPcC1nQCXGAPjLy?=
 =?us-ascii?Q?hP/0DOecckXlnPJYnbsWp/nesA3tKzvNOOTX+Cxu6nzBvGkTlFjt/6LIpzQ+?=
 =?us-ascii?Q?Bn6R4bx/k2M1VtyrsIAhBdoT7guX5jl6FzO5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l8yJ83rB8RFkZQ1DcN+xSLrQ07/rOIpUGnG7G+EO242bu64bNNcBTfUSeWHE?=
 =?us-ascii?Q?8MKqPKNyj0Dae0hv1bHz8pD5EFbojtipVp0YLiKKqxp7bIIRG9s18/k/CmWz?=
 =?us-ascii?Q?nECOijGm4LgoLcPR1hpttTmygGBof4QyNUE762SbMpIbj/Yr1bqUKCV6ajhQ?=
 =?us-ascii?Q?pJHdL6z97Gq2nL9Gwf/zi3XsDMHidBMD7kTUFZB/mueXHI10aehsuzBFRNDX?=
 =?us-ascii?Q?HJouot3iwKL8m6o5FHe25gHHQlyJHDknmzWjrYGEHRCZKq5yT8qP1HvcMomf?=
 =?us-ascii?Q?Njt5j03yj1eGTWPl2VvVHkLoicY5rmINQ+dRuKRKCh74sr3UaUTMx54KX+u9?=
 =?us-ascii?Q?P2i81gx9BGCo0ycaTQ50sE1eo5EA2e4jPXZiEQw4cYP5kAWasQAfhO0DZQ8k?=
 =?us-ascii?Q?ncls6NwUlGRWtGXghFOxpy2ZaDHZxUaHDsMYO0IMC3Kl4EQAF43ZtStxEJDn?=
 =?us-ascii?Q?rxPCtF1nmomrqE8hg3pye+d0Hu2Q4PSPs/ARB+nl7YXWD9X+Ly2c0iMkBlXx?=
 =?us-ascii?Q?4VGwFyxN342106PSeh6j2UeYvNBSR+IBXRkPzYAxm25yIhTuaB4y5pwBnNpY?=
 =?us-ascii?Q?K5K4QjBTEgSQY3USkTQJ/eIUthzg/pnQXMwZHNoy4WbrgsCTIY0XoMobW0ME?=
 =?us-ascii?Q?nAlsdpuqIsCQ8SCtKpflaXGZDH9j9x811jYf9Z+pvUT/IXMFCzK14wU82Uzi?=
 =?us-ascii?Q?OnPOmlsvAe01gsjl556+dtUdRsE7/LFb2hnSh+3kmp4ajfvOD1/58UICX3Ik?=
 =?us-ascii?Q?74F/qBkUR22P0VYX6BLAcSkrVABAeO+1FqglwS5updJlHBjBcGcE/5dj2fvQ?=
 =?us-ascii?Q?EqEPgfYcu7gOd6m4AF1NI+6qhYk9GNi+HUbFhWTnHcHj+FuOqv1ZCD/flhRH?=
 =?us-ascii?Q?M80LfxWqZYH6atJEMMfB3i9DSPIEut8UqjnGfMnf0UVjlJsDkfhki2u+er7M?=
 =?us-ascii?Q?D3lNExDnFw6TEZ42gxqS+i3eryFyb/5rOCECdUwmLOs11XAQzyUrGBPNy1Kv?=
 =?us-ascii?Q?Jj5hiLSQhATfiH868Mi5X5OhGx89l3YWlj5QZwtoRMxQ4IrJTcZkpCxGsv76?=
 =?us-ascii?Q?IdmfUYUCHTDzLKW3yqYaoHriI4Y3yB/XWdUFcDKzanv6Cxr0Tg07Kaq3G+u2?=
 =?us-ascii?Q?saAirVGb2f3y8Ttp3uM8EKYf0HFaEm4BKAC2vn6+R19QeCL+bWHQQSjdTp/F?=
 =?us-ascii?Q?yvoVfVCPONethNqrDpz8eE75/l3tw25ThgpmW3TPON2FXMkcGRvNbtj0lfRu?=
 =?us-ascii?Q?Mm+22zsn8rMeKaGwUb8r5DLg8km3dGhiPhjvTnfgVX0RlyIxsAg0gqW7GN17?=
 =?us-ascii?Q?/nuftg2GpcT4VgssddIVfPgsH26r75QQi52YZ3YmPFqcefWxgdF+Ei2I1qHE?=
 =?us-ascii?Q?JId5eMfWn2CD0vMsBr78CW5FJp8gW84Ys20XXAG4N2xRkoBiZ4eeSEm0vD9r?=
 =?us-ascii?Q?0Uud9jaPbCreUb/f1OopRPsiXeDAPepD0cKnts+NdQPIqlKzrDggFUYy9q6E?=
 =?us-ascii?Q?T/U4s/3DwFkAcqOUDuGyF2xIQ7pyHUtXd1QWBMTy6d61onJGGeuZHChstq++?=
 =?us-ascii?Q?AeWDbstjyJaOmVh3W7jzLokSsCXEVigp2vFHIfoDMxxa/cFm7xcg6GIQYCEN?=
 =?us-ascii?Q?h27ROl5k2fCdg16ae/6S1VM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7660DC4B577524997000B7C0B0503EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e6V2+2Oa+juvBCa8Qo7753lPQ4pbIJVSkaJO8XvAEYiYOXaO/rTEx1E5uafOmCOxPHVNDe13rlM+cKztnmlec0ijG3lRAbgyrxMDGfRJiwcfSmnmO11//JUOveZ5MvtyveVYv8xQ/vJApXzSpYdOHhYKG8BQE+jJSciVA3udVikjcEFddS4M0bc+6W6yh8ikbVnIhdFJ3uy48yqJ+jsK0Qfih/ATOjr9USuCxwjjfzHR42vnqW/NihervQ0/rz2vtfEbQnHgvbf9nZbHikYqmCDZzIAaSVU0qKwYy9j9kOL2xCXQBK8zSBcx7MVECjyoCF4+OmTPqjlvcOlWUr0PcXLiu6eh9KYkl8trwrbIN4v2eccVm+ZjwkkQDriZy/1kgeWTtEPg+Yq3u+svGaTvqVfg40SiR/gbpwvhLfC0a4QJLni4GQ2yfaesHlfkQPp7BfEEdKw0YHHZot5xVp3nJyf6fx9hkph/G0JkICR6yrvLs7ECPTy3Gpt/quiIqOQCnNkJlX5k7Z4Dzq1KL5yTUNM/Ro+ia7/ndvpSBZcshGo5sB8uak56nWplz4DnDPHexfHPh6TW0y4CxEvqcXJJvy+GWnQTupeToR0flzsL8n6tyewpPauWDttyFRuPhdjg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5981cce1-53c1-4f95-9c60-08de318cb4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 10:22:33.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CthUMfSbiFrWBj4ypnYJxqDulKnlQP9hHjhQ9VGHnz5vWhvqOTzYdAQHawdcCebIamDo1f/1xXgO2LbZ849Vn8Lbee7yagPfUV5VuNqewE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7351

On Nov 25, 2025 / 09:42, Keith Busch wrote:
> On Tue, Nov 25, 2025 at 11:26:31AM +0000, Shinichiro Kawasaki wrote:
> > On Nov 19, 2025 / 11:54, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > >=20
> > > Tests various direct IO memory and length alignments against the
> > > device's queue limits reported from sysfs.
> > >=20
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > [...]
> > > diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> > > new file mode 100644
> > > index 0000000..8e46091
> > > --- /dev/null
> > > +++ b/src/dio-offsets.c
> > [...]
> > > +static void init_buffers()
> > > +{
> > > +	unsigned long lb_mask =3D logical_block_size - 1;
> > > +	int fd, ret;
> > > +
> > > +	buf_size =3D max_bytes * max_segments / 2;
> > > +	if (buf_size < logical_block_size * max_segments)
> > > +		err(EINVAL, "%s: logical block size is too big", __func__);
> > > +
> > > +	if (buf_size < logical_block_size * 1024 * 4)
> > > +		buf_size =3D logical_block_size * 1024 * 4;
> > > +
> > > +	if (buf_size & lb_mask)
> > > +		buf_size =3D (buf_size + lb_mask) & ~(lb_mask);
> >=20
> > I investigated why this new test case fails with my QEMU SATA device an=
d noticed
> > that the device has 128MiB size. The calculation above sets buf_size =
=3D 192MiB.
> > Then pwrite() in test_full_size_aligned() is called with 192MiB size an=
d it was
> > truncated to 128MiB. Then the following compare() check failed.
> >=20
> > Is it okay to cap the buf_size with the device size? If so, I suggest t=
he change
> > below. With this change, the test case passes with the device. If you a=
re okay
> > with the change, I can fold it in when I apply the patch.
>=20
> Yeah, totally fine. Much of the sizes were just made up as I went along,
> but it should probably be programatically calculated based on the device
> under test.
>=20
> > > +#!/bin/bash
> >=20
> > Is it okay to add any GPL SPDX license and your copyright here? It is n=
ot ideal
> > that I add your copyright and license, but if you specify them in this =
thread, I
> > will add the Link to this thread in the commit message and fold-in the =
specifed
> > SPDX license and your copyright.
>=20
> Yes, sorry, it should have been there. I added those to some files, but
> missed this one.

Thanks for the confirmations. I have applied the patches. I took the libert=
y to
make follow-up commits for minor clean-ups, hoping they are fine for you.=
