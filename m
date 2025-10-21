Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66013A8F7
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010357; cv=fail; b=TnM3hoH0kxW5SCS4Llo13ZpXTpP6blIVkTCMHZR2PMjw0YZMLtI9mzIR9fbxbGJRoZKLDi1k26PNvXc8mYP4tY3ZBBKShmMsURRlr1VhiEVKP0ASLIUmyRikkcxZGzkY5vL1Q8q3UBL7ponfCN3v/hOFwxd2W3FwUY3/jeOP5cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010357; c=relaxed/simple;
	bh=nkHNz0oIA1bYIUeDNlWzicpzIHPxVgqK4l9MOUcP3bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oceXX7eYKmcNYxDFkNnI88GZt94YRnYL3Mihs3MCIeAUpoBUW4zJKPXVwJ/ViMxslBmUiufRfS25BBd/1k/0FYnWRDuojo5Jy2agVuwhprDmvcsITtx3dbJMv6C6J7JTwDxke2oMT2iIcKAiI0lkXP+uw7UqZRi/NDkfXCYKFfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GbwhE9Sh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JpC0kiUg; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GbwhE9Sh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JpC0kiUg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761010355; x=1792546355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nkHNz0oIA1bYIUeDNlWzicpzIHPxVgqK4l9MOUcP3bQ=;
  b=GbwhE9ShAd85LbvvrFvRGDttekhn+ZkHg1/lOBXoyfbkAw4cP6hfr9Mh
   CKexEGCtfj1vAG1EQA6kawB/CwvGjPygK6znYqsW+3F8bbZiyxIIb4V5n
   4ekfDDYNchgzhpktcnOK5hNTTEiZ5iR+lFaSLrGEX3pW4N9tVmco103Bg
   Mds08Mofu8Cn0sRAcpgIYjnn6v3XRoaZEUp7ljZtU8l7auy8HUvwMmmOO
   8HeOIa5E1j3FNhEttvSvSqD6guldrLV5OBNobpxhqUe/hNM7tbpOm872S
   1v1cqmLq6oRd8d2Vbs22j5Tlunuc6FpvYDKCMnZXIgjYQRg1cAaBWx77E
   g==;
X-CSE-ConnectionGUID: vM60lGQvRf+Q1NleuVHCEQ==
X-CSE-MsgGUID: e4IxEfc6RmSJ5eUlXM7zDA==
X-IronPort-AV: E=Sophos;i="6.19,243,1754928000"; 
   d="scan'208";a="133270945"
Received: from mail-westus2azon11012035.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.35])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2025 09:32:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yonXQd2urVbNBsZr88ELSykfEiqgHJftn0TzaAbijYJt4ihEz15xHJ4NpbcDp+8tPwz5AEV6m0ae67lx/q/3qz6Vk70OQG1lm1IvE8GhWzZNdP/w7dylPYEH91gBW3ePvVk/9oMzG3X7tos3xuVAIlKLIrhQVKa+Uu/ZzWQ/Vcq/obIdPTB9humf47W4ZXsmsE6ha6Jkfhj5DgMNwVGxIFpuEleIj79HVuHgMENV3uYYl2hkUAQbETx6kxXTx0eqgKyzYfucdQ1LeG7MDH/hRE4Ktd2kuGwfE1534w4aBPpAuuvV1Ps+knsJKyzDEIK75sYfSyhAHQXubYeId2V/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykPePVB/nwRAmn3auIWhd0FgOxunrR+nuPwYgx6S6B0=;
 b=DmGtgDzWoZj4XBYf7e5WkkGVfWeL1EvuFbCrk+Mc46oVvhj+5FVBJnuCirLDixcfboZLkq46kJpMzINpbdWo7L/pHPrV+z6kbbiWq62WWUSg2KqXdEs+UGrdHUMeW2fMXTruVcvby9AAKa8P9kXxC0zVtLsSX1dtUMYYMVWUdfdVZ/r1vXudrtvuyGqwaZdEkgpV8WQpYs1gGyHonSCnzbji/RnBABXAZGX4BbTkt2bRl0ug+M0AqCYTviSbAvi4RHdPuFSAwySRjTHfFzeu3akNnIrDdLMJuIiAvEXPksIXxasQBFA/BGheey+04brjkeRUeQXiHFOONATgDhkSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykPePVB/nwRAmn3auIWhd0FgOxunrR+nuPwYgx6S6B0=;
 b=JpC0kiUg39VdX1EeWXeJcJEzoQn4dzSSSYST3kTmhOb1IKqaYJ7XiomllMXr9fz01XiAmDnxYkDKkK43M65mxr8cAXkNbFPWxOBBrK9kL7pSLFTwWdXNdrxocGQmYVpTtROYkyQzqrJOJedFscjSUycY9bXYGjRYVS4OyfA+PSw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS0PR04MB8722.namprd04.prod.outlook.com (2603:10b6:8:12b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:32:31 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Tue, 21 Oct 2025
 01:32:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] create a test for direct io offsets
Thread-Topic: [PATCH blktests] create a test for direct io offsets
Thread-Index: AQHcPUy+TG4J0xI2UEy14ngxq4EfE7TLAriAgACMvQCAAEsTAA==
Date: Tue, 21 Oct 2025 01:32:31 +0000
Message-ID: <mihxyxpcz2q4dpyylghkevtllfsnxqtfwan73zfvddqfbyvuou@fyemett2klrw>
References: <20251014205420.941424-1-kbusch@meta.com>
 <bihyeax4gcwr3ayy64bkdaccnjuyv6gp5fz6wxgnmwuhjy6be5@rxakhphw5445>
 <aPajtDhrfncyZHPq@kbusch-mbp>
In-Reply-To: <aPajtDhrfncyZHPq@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS0PR04MB8722:EE_
x-ms-office365-filtering-correlation-id: f24f5013-d3cf-41c1-c924-08de1041b45d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WTvK4XWRmAdhCJwUyrYLVdabbc1xmKNl5R19kuO2ceyKUXMv6OfnIQbpexF3?=
 =?us-ascii?Q?00cWhTIq3xKtzTJrnAF15ADr0iM23Rotl22mNTmvkXlykpmOfrnzjIvXT9TQ?=
 =?us-ascii?Q?PpoVMHd5s325ywBJ2+9IKDxNLJr75shL3uw4SbsxvWID5HWHfoc3WJcBSkSm?=
 =?us-ascii?Q?mbHk5yQsk2YoA8bIMcDiQJ1vSZAJXG9NzKgYVUOwzk3pHhAWpdMKyws8sQhV?=
 =?us-ascii?Q?ksht2KL6pWtkhOviI4VCymMFBoNly4cSlfLYWmUY8r2qMAYClTdAYwKTfmM5?=
 =?us-ascii?Q?8gSikzW701s315s2G9Aur56z3hEYAD5Jd7O37iaFkAkQbJ30Jz6S2sNTiRkH?=
 =?us-ascii?Q?qe0dYx1kG+F6pRJQypQGpgRQM/HoAZWZYap9LkR9ZHHAcHJPcfEFBBZGdtKH?=
 =?us-ascii?Q?roayEsBjAqmonTu3Y69wwfOT8VWl8WvNPRdXDcmeWfR7jjHN1TC/BQz/YjHx?=
 =?us-ascii?Q?FfvINlnrmoo7uM/c6+YyzeOLTWZn9gQkdxc+qdKAT/S1sj6OLxMD8cqpqFAK?=
 =?us-ascii?Q?BncyrnW8UiV82d7+sLNdHSOd+AesfVaADgN8RASXfn6SaBvPgASwkm7c/+GP?=
 =?us-ascii?Q?LQkyRmz8Pd+OOkz4FVL7qziHVTWvNkhrroB3JU2kAK/zJTn6gWZxR1bWhezu?=
 =?us-ascii?Q?kZbqXzMnQSIhBwIL9jiTf46zO4EI2HOm95xT8QAK1EgUGyyad0jhOobay7ot?=
 =?us-ascii?Q?SO+dO7kRFyVD7CISoJBJGMlLkkiJwnTtjWV402inX1Omm5NUeW+cSsUMSKKe?=
 =?us-ascii?Q?GhnJ2ffJUuvLQXYC28H+cM4aowkrPlLOq0+/neaQhCePDVndIb2bwRk+1PiY?=
 =?us-ascii?Q?qF+zLWSiSRkMDbEGRnF1ZWrOg+lLnE23fzodFEI72F2S0mACeuKZ1wLXkGWe?=
 =?us-ascii?Q?6HmB5dRIwemmK8Qm/LxdfGkAFGc83M0BVoKXmmes1pMlSbg8eDwMGvMpRqI0?=
 =?us-ascii?Q?hreG/62TQDHjXqHItw3FGngcFFYvqQVEwwH8nqOVEQXymt3x6VI8BHNwmpyq?=
 =?us-ascii?Q?k0ilQIs+tal8FWQy2TabJumJQKfZteiLHv2Bmkh4oy/3yMC8Jdz1hhEgU1OD?=
 =?us-ascii?Q?ZzaFbwaICDXn+JJE3hnz8McNkksVKENlQBYJ4frHhQSEV558xUA94jpZ7SlT?=
 =?us-ascii?Q?uncscqRZNfXvFl73Hbwy4HUxRViFUFwP/e2DwljTvmFaVlr5u+EYS5IbBpZR?=
 =?us-ascii?Q?KtqAJTmkLRWN7DX6942eaU2Fp3U1zJC+n67Ac6DrMqxv7ug6MjjJrf1DwhG3?=
 =?us-ascii?Q?PpnzUx2FcBcTEcOzVgpG2LvsWhEwUJkzv70p+vfY37FXcuOz/YzxegBW4lI5?=
 =?us-ascii?Q?wkA28u+Al9GkxY0Z7fJ8UGSCZme+X8YrOSoMjISQpioJejELt2/NlGlw3N3c?=
 =?us-ascii?Q?Nxg27d/4siRVAwAOkd0kCdN3GSa4Bi7XB7gT3SLLGEKxJMYA62kuH+0aYInb?=
 =?us-ascii?Q?GIz1ITY3fAMMXVhdbImb32MapjLpwEVBZfWOrJkIjrpdgK/4qirIUtH9Rmkz?=
 =?us-ascii?Q?uM7SoJ2BfARPL7n9tvgqMstuA6/1LX3NbUEa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+nwjUswFBrl2vXnt+trpNgIE2Tk6b1/kKwAvKgMuYoRo1cVOc6u30v3EDDG3?=
 =?us-ascii?Q?RLJ0gmGvCRRLXvgE1N67m8oTv3n44ftgKyk7LDHNfydtSqDmh5kpPgyz/TBr?=
 =?us-ascii?Q?ZxqV25jp9/ek4kEChQO7/i0QtknGqkC1gN6C34mvgTSRx2rocROMfxfTkfDh?=
 =?us-ascii?Q?NpM1BG0etGF9WJcVM9NW1FX5qv419NR02JRyb8Sb2ZBgPZTJarI0oVotjwGT?=
 =?us-ascii?Q?dcxjD9ZbU6trThqogVsG81FIwvlGVoJJ5EpwhX2IEVs6G6msUjGA/dGE+jr0?=
 =?us-ascii?Q?dHEAUt7nD6CXS2bPBWz3NN2SAwoDlZlDLqYqh5XhokCski9Iwqe4JgMMauuZ?=
 =?us-ascii?Q?x/GQUv9hplbWqyiHJ2AYrrmNhBLNFKR+grNzojmjdeypbVvFZLzPQVnqzO1C?=
 =?us-ascii?Q?BYnohdw0Csod4OZKEd65+gPoV5RjNEuGOzXkBnQ+YSZro8rjGV6GsjcPfGsz?=
 =?us-ascii?Q?d9x8apRIQzxzfQeTqHukZS47sjXYGx4TvUZxffGLzbxEY6chE6sh5kEltIS9?=
 =?us-ascii?Q?P/aECGsH5ktrcZ6+Dpa0BewzMf8/91aKF4zDlKuvD6QKXpafhSnV/ozo8OMs?=
 =?us-ascii?Q?a/cV8dtK3odiPunm5EAk2Hb233o/xLfBKItw5M7KJ7Bg2FuGBqCg1S8VqQKS?=
 =?us-ascii?Q?0EDF7WLpdm3aEBmIYBXhqkVYrhST0nuGKNDJRnUwI8v24vqn7Uj00rfHOj53?=
 =?us-ascii?Q?rDS5E+YikGCjSzn3rhYkvDz/cRXt/5A0XZpzUujQl7BCYVBjZZi7dsDUvrk3?=
 =?us-ascii?Q?M/dj5Ca8XhP+rThFs9ynXbIAvUexF5/NZD17vygZlHf4XN3EOwVWNjUU/XV4?=
 =?us-ascii?Q?1R2PrREuJw0jb9AjmY9vUjkG4nj20RgY9vv1Fft6qrvctI8PR+PG5bNLdJ6t?=
 =?us-ascii?Q?oiyPvZ8O5Am7mbqZNvMgG7PxXDHRRI6QUNYguIKKPN/C927GZv/NFqjvhWIL?=
 =?us-ascii?Q?aoryztGJi4dGN2DIPNe/BaRtORXQFFi55uVohDZemuXWVVfWiSEvF04UoKI3?=
 =?us-ascii?Q?Sl0pslE8Wr932ROJ87xM+NH9SXWdnaEDH3MQZPW4yjqSCh+QZKu/vp2TV9ia?=
 =?us-ascii?Q?WfZwgxelSV81wgPdKAElAqpzKQLDVgpoi7r5uZyW689uD+fopyEqhCe4XMOs?=
 =?us-ascii?Q?MjR8OL3ZfX/yX10yLCD5TE9P5/byzvpcow6THRKIEL09FdfbXge68cNxI+3h?=
 =?us-ascii?Q?rJa71DU8wQFPKrKTAAkp7phLK2fpoLGPwYR2My/uiCBt/Yqtjs1Dj8CXkyvj?=
 =?us-ascii?Q?0c2fxm9fdcp6OekaRqh/a3+u5iukJNnjhbt0Z9d08wfD5eke3TqDDe9DNmdm?=
 =?us-ascii?Q?iXd76RQ7HqzE9z7kkvbdL2YSwFYH1R9ZuptY8ZuzyC/DCFnOzdGibw3Gw7S8?=
 =?us-ascii?Q?7c7yL1mGY2D3nObOEIbAs9GAx6JACtHsTLrx38Kw7jP6NlOPOvHe5X2Rh1Ul?=
 =?us-ascii?Q?TVqfK91iNE23sDNxo+JlCODV1B2k8Q+WXmFh4zFE4LWHHqRfbUnsjVTxbTX6?=
 =?us-ascii?Q?jD1oYQeAq6kvnY2nMbOaGC5ejVDOCxLtz3r9vE9WHKBBqomMrH2OQwUt1q1A?=
 =?us-ascii?Q?mjf7LDpYHaRMh46ziqP4GIk53oV1fPbV4NHb7qNgJh3lNGTMwPPEBWDvSgGV?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E9E35BF67AABB42999621B439E3A521@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	14Qo1sX1AuWNlSPnO79bJnRPrS86/Fzq22Xur+peMythfCg0ZfQpuQwxlbtmhjYfR2Rhe6E4noz6j/drGTFLEndEQDrq0HYFM+uTOZScVQRECF5kc/1Sor61Wni4Jh15YYE3iRsOUnu5xP5xClP22PqDaYn18ujtJ/64OSuquCY5Glx/A3CG0CZZKzQebRkaCm+m1+THEJM9GofUu500NIi6v06XAb0tgTxkzy3AnUelI+N06t9CPeOFC9ZODgog7F+qyka/EKbtg/dMl5nwle5o2NiBnLVld5oJwPWGt1RiQR+5cgBUuJK5I4aazqWVQnxPauWFdDjxHVPtNf6Ckwm7u2IgC9OraZqzn7baWHbWoNInno7JNE30d3AXjj9NPX7uF//VDo1a9k46rpBrUUf8w3nNhLRICfARMJ2iUXvBwlKFwTFPV5T1IG8cIyXL8Qtcu6S9AzGpRJ/vDhUNTRN4TM2YcGNqoV1o3+cUxmSl+MQOuWz9fmztDzKlpKBhOLpLA/ZrEfM5TkOBhBeLNuTX8J5NAT0ZC98YffNBxOfu5hD9078sv8hPBOvTuHjujKBGSWe3WvL5M3eeC1cAzoU1xFk2HgSwmt80VRDuMRqE2jcO1lLpf0O44be5s0/a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f5013-d3cf-41c1-c924-08de1041b45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 01:32:31.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZGFn+HMLiFV5weUKLFjd3jplWWt27Nwh4rqoCtvvmkO8O2tC5R+VNmp2ahAy6bhFGIc/HLJo4gMD3Q5o66v70iiYcnFR4rSw5snWIOQGLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8722

On Oct 20, 2025 / 15:03, Keith Busch wrote:
> On Mon, Oct 20, 2025 at 12:40:07PM +0000, Shinichiro Kawasaki wrote:
[...]
> > > +        if (ret < 0) {
> > > +		if (should_fail)
> > > +			return;
> > > +		err(errno, "%s: failed to write buf", __func__);
> >=20
> > When I ran the test with QEMU SATA drive, it failed here. The drive
> > had virt_boundary=3D1. I'm not sure if it means test side bug or kernel=
 side bug.
>=20
> Hm, I tested QEMU's AHCI and that seems okay. Is that what you're using
> to attach the "SATA" drive? I'd like to recreate this and figure out
> what's going on here.

I used the option below to prepare the QEMU SATA emulation drive:

  -drive id=3Dsata_disk,file=3D/home/shin/Blktests/imgs/sata_testnode2.img,=
if=3Dnone -device ahci,id=3Dahci -device ide-hd,drive=3Dsata_disk,bus=3Dahc=
i.0

I also tried the simpler option below and it also triggered the failure:

  -drive file=3D/home/shin/Blktests/imgs/hdd_testnode1_2.img,index=3D1

I also ran the test case with a baremetal machine and a real SATA HDD,
then I observed the failure. FYI, the blktests output looks like this:

block/042 =3D> sda (Test unusual direct-io offsets)            [failed]
    runtime  7.281s  ...  7.484s
    --- tests/block/042.out     2025-10-20 19:57:01.314867376 +0900
    +++ /home/shin/kts/kernel-test-suite/src/blktests/results/sda/block/042=
.out.bad     2025-10-21 10:22:22.226811120 +0900
    @@ -1,2 +1,4 @@
     Running block/042
    +dio-offsets: test_unaligned_vectors: failed to write buf: Invalid argu=
ment
    +src/dio-offsets failed
     Test complete

I enabled the commented out debug print in dio-offsets.c, and it added the
output below:

    +logical_block_size:512 dma_alignment:512 virt_boundary:1 max_segments:=
168 max_bytes:4194304

>=20
> If this test says virt_boundary is 1 for your device, that should mean
> there is no virtual bounday to consider; this test should succeed with
> those reported queue limits.

I see, then there should be some other cause...=
