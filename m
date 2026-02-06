Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78B30B51A
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362753; cv=fail; b=dwufAgnpAaAVcBjhyEGQ9vqkO4gUat/9FTKpH5kYRaoJAcyPdEnany6KHGLOr23Qxd5D6b4/4qeGedZAoKyXSmlD5h1OhzRBu0sDCWqO3Pi92V7dZEZG68HHmJxzqM0f1BFA+CoA0xDS4v0NS7uFm7T9ySPqH0Tbq72x/Q00U3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362753; c=relaxed/simple;
	bh=9IYRNSVtoc4/p/36A8h9BnTbpfHit770qmd3kFPFvK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGNUPyD8v17QOsSyJ74/ItEIr1I6IHo9hN+QkOP0lRmNbLQ4FClftLslyFBfbIeJA7Z0VVm5GcORo+fvI1F/UquxRMlSmpDkpPFVvXvSoj/0icAZnUaJKxbjMLuH9DPgA8eLSspqtVHtHkWQ1s8JT4ImhcV2VYNm6XI3RRzAQwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pEfr9YZs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kvawyhrX; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pEfr9YZs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kvawyhrX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770362753; x=1801898753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9IYRNSVtoc4/p/36A8h9BnTbpfHit770qmd3kFPFvK4=;
  b=pEfr9YZsjhiZ3eoMUzjeUijsIZ85F5D8sL4B14UENHtx+DDCEL56PjvN
   wV6FIK/XKiu5Nyepk0hNMms0sPVxPeIfp8TLSwx6sHpt4VjJWh7DUwJJ4
   drTOmy2Ra/ErtKYQHU45l12278XAcEF4X0IxaUXGZ1Q1CnHKIKqXZO4ue
   jB6nEO1ZoE5ZNqJJsQkFQN9afYUunBm66EXyKSZYCrOOyOzYdsXrliC1x
   oOpH7sHE6Sz9SNMrt7cOoObZpGtH8oKCu1xpBBrlQ06EWO/fgQVkHN489
   NIXK+KmHALujJuUOanRf0rDdwb0KxgMX1YYJOp5dVCmY0bnLsNVHifeQ3
   A==;
X-CSE-ConnectionGUID: n8udxloIQeSSVpTBg2rC2Q==
X-CSE-MsgGUID: Jr73SmIlRqyJfZ81/qSP6A==
X-IronPort-AV: E=Sophos;i="6.21,276,1763395200"; 
   d="scan'208";a="140847406"
Received: from mail-westcentralusazon11013025.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2026 15:25:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgVW9iC5iMCwtnoux0HRHXOE/k/9dnh3Nsq7RaBJt6N7wOvTSWeb/zg4Vy5zErTtAC1O8AatT3ScoRcttqDrXlMh18WPQ2gYUwEG+OVMiU/K9M0MNai21RoSZXdlKazmkcCdTdk6guZb7gCw+gGm1zkSHigj9m/LKjJCQs6yqht2e0QEBYBWhbgSuP7Owq/XXOrMvqMDD2IrdbE2gWfWRv3ElmmVsEz4RLCXzgMwktbXq+YB+0Bf67Mpk5aND/GJnnWwd4JC/V5V7hIMibp7vuxHimiUcMRkz6yNmJErRHg4NxF4o2ig/qYyx/TKfeFyI5QRBZ1X7Dd1hGReev8yBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHwfAt2doi2qZu7xCe42HV6OSVloVtTo4kpw6xsFNZI=;
 b=wzdVuSCvWTQUz5awhZL+oc9J9ujXrERu51TBMeVHfWpWrtApBD4v9106HUNfHZPVhURcI8PGJNNvlIrG3HglLZKb/lKRousXTv68h18PtP8KvugESFeVRmka4pdszenpoYfQbNqJXUNpgE5esYNZDEEnd84nfWXdbv4bhrNjnZ+hCPl+z8ASm1VqNC8X+WpVUYgbukC6ilOP2VGup6yyRT+QGvUp41lPeujxw5F7AX6R9c7dQzmHFo2TutqE/OXQNpSZfv8kcvhUupxUft/Rw9vJKq3rPlH0P1UNF0JCQ+8XuigXryo9IJOIFDPlLNgMrDcTxM08HgyuD+BUIVn7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHwfAt2doi2qZu7xCe42HV6OSVloVtTo4kpw6xsFNZI=;
 b=kvawyhrX3R2UuXBHqSlFdxZd9OGdWVOVWCJiL4C7zdJoP/S3FF+yzQp/VzokPP+oGkJykUJmjgVRP/tHeUN30sh+80saJCNKOUZoRooiUL6tkIvFYdnkHXPzdMNU2HaE1Q8Wyu8qDlKWSvSUZs7P5SdyHnc/NIHfUvOVswdBoxM=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH7PR04MB9642.namprd04.prod.outlook.com (2603:10b6:610:24b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 07:25:42 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 07:25:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: linux-block <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug report] WARNING: block/blk-mq-debugfs.c:620 at
 debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
Thread-Topic: [bug report] WARNING: block/blk-mq-debugfs.c:620 at
 debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421
Thread-Index: AQHclQi4zTHgFJyxQku7COOrTEJD9bV1SYeA
Date: Fri, 6 Feb 2026 07:25:41 +0000
Message-ID: <aYWQR7CtYdk3K39g@shinmob>
References:
 <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
In-Reply-To:
 <CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH7PR04MB9642:EE_
x-ms-office365-filtering-correlation-id: f0601a71-0f05-453f-9735-08de6550ef4b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3OCIWgaJlNijxU7qz+aifS7SRXV1msaBAbCRGNjIFVCBluO1IwBa5/FJmykH?=
 =?us-ascii?Q?01g1RBjTSQ0+pXFzg6P9+Z8FS+OdPTh5s854Rzcy7hdKzdOSWil36p8PLe4l?=
 =?us-ascii?Q?JrQp1zhwAUGSKHCnoyLjHbVnovCMYI2yKmdTs3B7LGizBM+wEEjQT7rcBhIR?=
 =?us-ascii?Q?N4DAjkQO2m1h1YssLkBgbkrA4oMoj5d/p8QMxWOBDjVTLBokYreQX9Rk5+3z?=
 =?us-ascii?Q?PfJjoZabGE7s78+6UHfHS9MgNSaYB+oNsp6/QuvM+kTWFRhNk1lknuNt15qr?=
 =?us-ascii?Q?25pkGot03+jvj/SLmntzU1dKJVmdw5hkAnBwfFvS9S8mO7VpmE/Uc0BvPoNy?=
 =?us-ascii?Q?ocnV+4Hb+NJx7Sr27WeLxEHs84JR2PEHlaA3QtMnpRTee6GdZOiq4svNrZjC?=
 =?us-ascii?Q?Ism4Z0EYY30Zgyf5gXqAdnvmxNsQLASqHOvUXMel/yWbUDwhrJkvC09BCUjg?=
 =?us-ascii?Q?KTmO0awfsl6BlvQHoojC50T7Z2pNXuEVziTiensdk+6cjFZed2W1/DbVfdb8?=
 =?us-ascii?Q?Az4hqDgaNq4xshXLSHTwLmoyEytv8176x1LGm66hYMlVw9pZpOYRYkyl2y+s?=
 =?us-ascii?Q?EoHfPM9/UmeYTw6GHdFT5R1uWJwh7LUwqbTYPVO8WQZP/QBaO+kjwi4NVuo5?=
 =?us-ascii?Q?gBIZhZyWkJrgp8atLgSd+n5Ew0RVWhHqBKdO1DOHT6bTxQNQ5BAbLFXTHxVM?=
 =?us-ascii?Q?WUI7e+/ubgJmbisIPUglvS14FGBQRn7EReawk+Ikpo3vP9QiM6GWjW5exBr7?=
 =?us-ascii?Q?oXgrpl6urdKKUpvniqBTgZr3qd+EG1y8hjzNhJ2dVQuzixDRvCoQ6bKhCe0h?=
 =?us-ascii?Q?XB88T4HjY9BzjibeqE1Odgp/DGYkvma5uL9XO+UiJJxRA1ua+EdrOyUr2bOA?=
 =?us-ascii?Q?AI0XKpGdFreBnJoA5bkiS5Jm7U5o77za1jbs2dI07g2j5XCYIoglwGl9WEQ5?=
 =?us-ascii?Q?2WLBlPyFN+JNbFXO8osl/lqUMUgQzKPxScmRF/HX6imxBJjIOm4khSVNCEK8?=
 =?us-ascii?Q?uyRZv4XZ5JCco7gXwnHLoMkf8omHSL1ldBhJKON0j+r6z6qTLAE7jm6r+2QM?=
 =?us-ascii?Q?Dnxg/2IbH6FopmRYvaxD9zeK9W52RNRb3dEwykpOn9J+/fd+DgaOyJ3KLvSF?=
 =?us-ascii?Q?uJu53p/HH7DS9pPizhdvW7v91dfT9cXgzW/n8xRs6yL4zbIbkoZCsJ1oEVVb?=
 =?us-ascii?Q?DjN8hz+tWNJurAOtg2Xxeh9jGvdsxmR4iKlXOl6TZpsnxRcWSbPvIEw0Jhsg?=
 =?us-ascii?Q?Bt8CbqhyV8+Badv3L9EUleRZXrCwhDU+0SY+0+gS37JBQP4DW+uys6+vydrL?=
 =?us-ascii?Q?l08b5C7KW4wvr0fA2Uo4TF5NVr7BWwry0wMY1/kOamhnYGPwSiwbeCH9E/61?=
 =?us-ascii?Q?X6kyHa0EnHO/3MEBOGuelydBwBHytv99ka8WtR52wtY4WZy+w9+F2PRhqcOt?=
 =?us-ascii?Q?Lv2jAufVebWZgvhuxXLf7DxfQT8VN8J2yZwQNPuudV+KG0G+5bQXXck1eqvj?=
 =?us-ascii?Q?nS/Q17QZMK2VUZLZp4dpfurtdibMCU2W5+vM5bsT4CkfMOYnBM5KdBUtntmq?=
 =?us-ascii?Q?BsbkKtMVIHZx0oVG7Q9IekeSOYWCDP3bfg6vJiq3+1yRS9B3YczkJuYRtl06?=
 =?us-ascii?Q?zCTLfy91DgBFPB8aJmsAvKc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W6ZpuqH7TOjYXgqns7YNbSRR9ck8gUx9Yf+MIgGLae/VsTgn3IvpXUfaMmBO?=
 =?us-ascii?Q?ssBhgUh7G+ONybd+wVohd4TdFGpkC5r/Iv0XnqVhjsyvdV0sEM9twfhXNW1g?=
 =?us-ascii?Q?kDZnowA9X7hHrC8kBxZzqNsNsOfOj9X45BjnjbYpiHg1YuX/Gocj3l61gBUY?=
 =?us-ascii?Q?pchaiZoWelMq3qMVtqwIrEjQymyaVKEyNe4e1x7fMNGwpEvO/mZUL/92+cpY?=
 =?us-ascii?Q?nwpjqmmVpj1BQ7Ih/AUmgPNsPujmc6Ca7Hij8gIQHzgHJwYfcRaZIi2/Q8bn?=
 =?us-ascii?Q?DiBX2+RUDKfsHihPIfrL6ILloXCRpvSawIm+1sNwXhOuJlEIWinjaaTBuOyN?=
 =?us-ascii?Q?gok7xkiAGW3sjAc8Sm+Y96+gZrk5c+kVOmE8jW4vg5N9jEGi0IJJo2aG6seA?=
 =?us-ascii?Q?wMqoXiYXKWVlT7e/Nal/uWpHnxsy369z6yX7+vZKXIvI/Bh0MUMdXgtdUvW6?=
 =?us-ascii?Q?ZNtdks7S83r4A5CiVgYcELcU2pekuhW0HMTq2XB+SAwoZcN+X0P11NNqyRMP?=
 =?us-ascii?Q?XsJGrQjdC1VDHMrqgw/bLkVCuT4gSZeg7LJPXYmT+Qvkov/KdrEGu/es3W2L?=
 =?us-ascii?Q?rl4xfZBr/42+zaRCUEbAWFuLGiZFaZjke+x6HCSO0/lFajiEoeytLvdsUQd/?=
 =?us-ascii?Q?7ky/eo3GMPbXC3mooLurdVjB0CEs2JGoYeA6y8w9GLQdLdcul3zzJtcsnCcj?=
 =?us-ascii?Q?QZND13N38BHpRZutqrQpzsgVJNv/kxPWiY/NfngKNoxx1AcLFcpAIvVrFztT?=
 =?us-ascii?Q?Oi6xLXImQFkXbUj77+tgsdiG/+EuQKUWyVR+ZgRazYsLRU8IYlK9ddAwJJxz?=
 =?us-ascii?Q?H9KJh+EgXJMYTAgwq9rAleWdkjD84/9DhRFoZYYXgo1MDzga1nYhQ+GSTDTq?=
 =?us-ascii?Q?2xeiBhT+opr/PerAcvFZkUjYDhe8r4MfIFV4nKHDa2Jo886ZBtlA0hK0CM2x?=
 =?us-ascii?Q?1E4dq1d3ylLKyo/YPSuJrjdT9Q+GoH4XoqPHU09TX8pyiHwzEZczF5L2Njq9?=
 =?us-ascii?Q?ERktTQNH/FQsX71Hx/fjL0oG//4PTsfI/eCCXmy1FgWv9cxXIgeObelgY35i?=
 =?us-ascii?Q?PJqb11WwcBAyN2CaYUNW3JYQA6qWaXUVYsM5N3FqI/7Rw3ylxi/JpLRqQrjH?=
 =?us-ascii?Q?OqjOS6MJ1kLi4KhUP02qG/aZ9rZ6ALFc1s9+Doc6+FhiAdmHX8EWkJec9YOC?=
 =?us-ascii?Q?gUuzNFVDmnrEOhjw7OpVG09FBysDtCpZ0Yow/iy5OCXMW9SkFm2N0Lr2FmWG?=
 =?us-ascii?Q?sMUFsiuq04gP1sYqPWXbuFy965R3yWDHjQPtE7vRJHh5kmeify4Vd2vhE8S2?=
 =?us-ascii?Q?qVfFsbAhrqd/1bdACapZdipf5WgnWoKX2veIA27N8qP+9GqezvJ+wBknRt/J?=
 =?us-ascii?Q?rnhYwfF6Yawf0ewfQGs8Gtqvwy87C3QuhjSZoAlH42fxJIZGn+OfiunAU4cb?=
 =?us-ascii?Q?0nvkArn0RazqQw+xa1tzp3HsjtT7kZp5sbh5NjQOZKF67pLzZN1L2t2H5eZP?=
 =?us-ascii?Q?s1iEsYRWuzHd9LOKQNe0A38K35Mbz7Kl33NO7ecgo/niIUHG+wtRNPuvMkX5?=
 =?us-ascii?Q?JQAdod6uMPK+aeClRZdw44TVwFdnfqL7XJO/dTvOqPkUCvXx/oKa3VeM2mjA?=
 =?us-ascii?Q?Xu+rs7+DJIaph1wNE9krmylv8fij/gyfkCuDV8x6JaJI0H8UB8w9mV36mBJi?=
 =?us-ascii?Q?CTsiUTP6lM6O3i9dvQA90zJZ4sQuCc6IDAAcAcLBk1JI3tMKB6bhQi7nK6ps?=
 =?us-ascii?Q?gxfyHBfimkKftNSiyvrvnCDDaO07Z3Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0281481874183D4791A951DD14C5B027@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MVQPgTZkFEAc6/Jo1t5F0H7a7103Vr64OTgcR3wOHtGyqHJ9PvSq6HakzgeJ2L9TT15XdHzXfm0rxyexxxH96RzF040vVEOCz8glMHnAYJeWtVLHyum8RIoHKFdBTQ1IRF14P59A8QyzAizxCrq3BVboIEPB/pY8tJjqoSoYOToLX2w4SouYNw7y69VoSPOJDo1S+Js6J/tE1mitwEEGo4JBjYr2LTKEx1v+fEZOL+i1N8Hsdm3ovfoUoaXKxUqhWi5Qz/rRXG+mRls7C0Gc4GSAVzy+fk5WI36Ncpel+smkCnr9iB0PElBZUH5od36wpr3ieNTJwvcEE50/qo1uQznXZio3l/eR8mca6PSHrvDOgzc01QZMLj13Xts0ADAKx+8phkYQzJR51cjPCcYL/ykP921LwUAYrTxmGemiHL6W/rE0b9CNilowtkn+cwyMlAPU2HDZUPYMDlhADHbwtUrMBvs7otPx1WPkMOVeDBYXNaIQ2hvCkappvF6MFMDLyhUDyW7goSTOLfCLRBVtR+Er0aojtn3+hEoqfw9BlYnJ66b8MDhaJIswd176Jk+4aS2eq60ZM0Zm98gLrMMp8ionmb+P9M1H0WTiRmkqh3I1xh9/B3WJfyZdz4VafwwJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0601a71-0f05-453f-9735-08de6550ef4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 07:25:41.9212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGqYnZ7L46sK9xSEePCWZcnCPjYM8+kmKvtTF0IYSwzAOk7M7bGgoLlY7E33l2H7AffvHpDTeWf8hla1oNpWDH5iPjvDPpE+/U+EEvrH+YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9642

On Feb 03, 2026 / 20:28, Yi Zhang wrote:
> Hello
>=20
> CKI reported the following failure today. Seems it was introduced from
> the recently blk-mq-debugfs update, please help check and let me know
> if you need any testing/info.
>=20
> Reproducer: blktests nvme/tcp nvme/005
> Commit message: Merge branch 'for-7.0/block' into for-next
>=20
> dmesg:
> [  951.319384] run blktests nvme/005 at 2026-02-02 17:59:35
> [  951.346116] loop0: detected capacity change from 0 to 2097152
> [  951.356428] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  951.370823] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  951.397438] nvmet: Created nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  951.412081] nvme nvme0: creating 128 I/O queues.
> [  951.425914] nvme nvme0: mapped 128/0/0 default/read/poll queues.
> [  951.467027] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  951.784608] nvmet: Created nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [  951.798920] nvme nvme0: creating 128 I/O queues.
> [  951.871600] nvme nvme0: mapped 128/0/0 default/read/poll queues.
> [  951.880680] ------------[ cut here ]------------
> [  951.885309] WARNING: block/blk-mq-debugfs.c:620 at
> debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421

FYI, I also observe this WARN at debugfs_create_files() using the blktests =
test
case zbd/012. When I repeat zbd/012 several times on the kernel with the ta=
g
next-20260204, the WARN below is reported:

[ 1304.543824] [  T12755] ------------[ cut here ]------------
[ 1304.545792] [  T12755] WARNING: block/blk-mq-debugfs.c:620 at debugfs_cr=
eate_files+0x247/0x2c0, CPU#2: check/12755
[ 1304.547377] [  T12755] Modules linked in: scsi_debug null_blk nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reje=
ct_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 =
nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr netfs i2c_pi=
ix4 i2c_smbus loop fuse dm_multipath nfnetlink vsock_loopback vmw_vsock_vir=
tio_transport_common zram vsock xfs bochs drm_client_lib drm_shmem_helper d=
rm_kms_helper nvme drm nvme_core floppy sym53c8xx nvme_keyring e1000 scsi_t=
ransport_spi nvme_auth hkdf serio_raw ata_generic pata_acpi i2c_dev qemu_fw=
_cfg [last unloaded: scsi_debug]
[ 1304.554851] [  T12755] CPU: 2 UID: 0 PID: 12755 Comm: check Not tainted =
6.19.0-rc8-next-20260204 #383 PREEMPT(full)=20
[ 1304.556421] [  T12755] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-4.fc42 04/01/2014
[ 1304.557886] [  T12755] RIP: 0010:debugfs_create_files+0x247/0x2c0
[ 1304.559074] [  T12755] Code: ff e8 1d b0 83 01 83 f8 01 0f 85 67 fe ff f=
f 0f 0b e9 60 fe ff ff 0f 0b e9 59 fe ff ff 48 89 ef e8 2e 59 69 ff e9 07 f=
e ff ff <0f> 0b e9 6e ff ff ff e8 fd 58 69 ff e9 9a fe ff ff 48 89 df e8 30
[ 1304.562112] [  T12755] RSP: 0018:ffff888147b77530 EFLAGS: 00010202
[ 1304.563343] [  T12755] RAX: 0000000000000000 RBX: ffffffffaa567360 RCX: =
0000000000000001
[ 1304.564728] [  T12755] RDX: 0000000000000001 RSI: ffffffffaae6910d RDI: =
ffff888130361a48
[ 1304.566104] [  T12755] RBP: ffffffffabe49734 R08: 0000000000000001 R09: =
ffffed1022804075
[ 1304.567487] [  T12755] R10: 0000000000000002 R11: ffff88812610c390 R12: =
ffff8881140202f0
[ 1304.568850] [  T12755] R13: ffff888130361310 R14: ffff888130361310 R15: =
ffffffffaa567af0
[ 1304.570246] [  T12755] FS:  00007f40d67a1740(0000) GS:ffff8884011ea000(0=
000) knlGS:0000000000000000
[ 1304.571721] [  T12755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1304.573019] [  T12755] CR2: 000000001e02a810 CR3: 00000001148f6000 CR4: =
00000000000006f0
[ 1304.574409] [  T12755] Call Trace:
[ 1304.575361] [  T12755]  <TASK>
[ 1304.576229] [  T12755]  blk_mq_sched_reg_debugfs+0x28/0xe0
[ 1304.577287] [  T12755]  elevator_change_done+0x2f2/0x610
[ 1304.578342] [  T12755]  ? lockdep_hardirqs_on_prepare+0x50/0x1b0
[ 1304.579452] [  T12755]  ? __pfx_elevator_change_done+0x10/0x10
[ 1304.580469] [  T12755]  ? find_held_lock+0x2b/0x80
[ 1304.581346] [  T12755]  ? elevator_change+0x2ed/0x4f0
[ 1304.582246] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.583142] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1304.584087] [  T12755]  elevator_change+0x283/0x4f0
[ 1304.584970] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1304.585887] [  T12755]  elv_iosched_store+0x31d/0x3a0
[ 1304.586784] [  T12755]  ? __pfx_elv_iosched_store+0x10/0x10
[ 1304.587724] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.588597] [  T12755]  ? kernfs_fop_write_iter+0x257/0x5e0
[ 1304.589523] [  T12755]  ? __pfx___might_resched+0x10/0x10
[ 1304.590396] [  T12755]  ? __might_fault+0x97/0x140
[ 1304.591265] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1304.592185] [  T12755]  queue_attr_store+0x235/0x360
[ 1304.593064] [  T12755]  ? __lock_acquire+0x497/0x2230
[ 1304.593929] [  T12755]  ? __pfx_queue_attr_store+0x10/0x10
[ 1304.594787] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.595629] [  T12755]  ? sysfs_file_kobj+0x1d/0x1b0
[ 1304.596473] [  T12755]  ? lock_acquire+0x1c0/0x340
[ 1304.597261] [  T12755]  ? find_held_lock+0x2b/0x80
[ 1304.598107] [  T12755]  ? sysfs_file_kobj+0xaf/0x1b0
[ 1304.598937] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.599766] [  T12755]  ? sysfs_file_kobj+0xb9/0x1b0
[ 1304.600598] [  T12755]  ? sysfs_kf_write+0x61/0x160
[ 1304.601378] [  T12755]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 1304.602276] [  T12755]  kernfs_fop_write_iter+0x3d6/0x5e0
[ 1304.603148] [  T12755]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[ 1304.604048] [  T12755]  vfs_write+0x523/0xf80
[ 1304.604784] [  T12755]  ? arch_stack_walk+0xb3/0x100
[ 1304.605573] [  T12755]  ? __pfx_vfs_write+0x10/0x10
[ 1304.606283] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.607038] [  T12755]  ? get_close_on_exec+0x1f/0x230
[ 1304.607774] [  T12755]  ? get_close_on_exec+0xfc/0x230
[ 1304.608502] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.609150] [  T12755]  ksys_write+0xfb/0x200
[ 1304.609803] [  T12755]  ? __pfx_ksys_write+0x10/0x10
[ 1304.610495] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.611181] [  T12755]  do_syscall_64+0x136/0x1540
[ 1304.611845] [  T12755]  ? do_wp_page+0x168d/0x3610
[ 1304.612505] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.613151] [  T12755]  ? __pfx_do_wp_page+0x10/0x10
[ 1304.613803] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.614439] [  T12755]  ? do_raw_spin_lock+0x124/0x260
[ 1304.615078] [  T12755]  ? lock_acquire+0x1c0/0x340
[ 1304.615697] [  T12755]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 1304.616369] [  T12755]  ? __pfx_pte_write+0x10/0x10
[ 1304.617022] [  T12755]  ? __handle_mm_fault+0x12b2/0x1d50
[ 1304.617677] [  T12755]  ? __lock_acquire+0x497/0x2230
[ 1304.618336] [  T12755]  ? __pfx_css_rstat_updated+0x10/0x10
[ 1304.619065] [  T12755]  ? lock_acquire+0x1b0/0x340
[ 1304.619677] [  T12755]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[ 1304.620438] [  T12755]  ? rcu_is_watching+0x11/0xb0
[ 1304.621074] [  T12755]  ? count_memcg_events+0x106/0x4a0
[ 1304.621741] [  T12755]  ? find_held_lock+0x2b/0x80
[ 1304.622376] [  T12755]  ? rcu_read_unlock+0x17/0x60
[ 1304.623047] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.623656] [  T12755]  ? find_held_lock+0x2b/0x80
[ 1304.624290] [  T12755]  ? exc_page_fault+0x83/0x110
[ 1304.624926] [  T12755]  ? lock_release+0x1a7/0x320
[ 1304.625553] [  T12755]  ? rcu_is_watching+0x11/0xb0
[ 1304.626170] [  T12755]  ? irqentry_exit+0xdd/0x6a0
[ 1304.626793] [  T12755]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[ 1304.627499] [  T12755]  ? irqentry_exit+0xe2/0x6a0
[ 1304.628114] [  T12755]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1304.628821] [  T12755] RIP: 0033:0x7f40d681277e
[ 1304.629425] [  T12755] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 9=
3 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 1=
0 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[ 1304.631432] [  T12755] RSP: 002b:00007ffd15db4a60 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[ 1304.632364] [  T12755] RAX: ffffffffffffffda RBX: 000000000000000c RCX: =
00007f40d681277e
[ 1304.633275] [  T12755] RDX: 000000000000000c RSI: 000000001e02a810 RDI: =
0000000000000001
[ 1304.634198] [  T12755] RBP: 00007ffd15db4a70 R08: 0000000000000000 R09: =
0000000000000000
[ 1304.635127] [  T12755] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[ 1304.636044] [  T12755] R13: 000000001e02a810 R14: 00007f40d698d5c0 R15: =
0000000000000000
[ 1304.636962] [  T12755]  </TASK>
[ 1304.637532] [  T12755] irq event stamp: 6849
[ 1304.638170] [  T12755] hardirqs last  enabled at (6861): [<ffffffffa76e6=
bae>] __up_console_sem+0x5e/0x70
[ 1304.639207] [  T12755] hardirqs last disabled at (6872): [<ffffffffa76e6=
b93>] __up_console_sem+0x43/0x70
[ 1304.640247] [  T12755] softirqs last  enabled at (5936): [<ffffffffa7521=
b66>] __irq_exit_rcu+0x126/0x240
[ 1304.641299] [  T12755] softirqs last disabled at (5925): [<ffffffffa7521=
b66>] __irq_exit_rcu+0x126/0x240
[ 1304.642338] [  T12755] ---[ end trace 0000000000000000 ]---
