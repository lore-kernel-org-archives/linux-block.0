Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D775809
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610959; cv=fail; b=ZUjDFhuhK1hbl/RAljutMOUl4bRYgW7U5KhT96yLIqrj3VUoyy5kfdfaqJz6xKryGIBjZT8KnC5BSq/qplHPPCLNj8ZIF9/hLhzWifH63k7Og9wHdL0OEb22tUMqU/d9VQ2zYWuvVHJfl64NDE98dDF2OPxYWdQbcmxenEPuv/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610959; c=relaxed/simple;
	bh=6jHWm8IWRy3T0lTaKzmB2Adq31P+kag7TejueCKtEgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2dq3VXTct125zqLqMVwduHoRvC2W2/K6OZde+/YWvb0w0gjR9TNPFhvqj0NDJp1isPnKYmuWp4D1me86Zb4lsyw41Ckeogp4D1Xf8TLaElfBCppp1TV3uuCKQzdHmn51fh2gDuSgULJfSTTIZon/KYuy3SW+nvGkQjhmaD37c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d5kTraPn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aTRIuHfT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d5kTraPn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aTRIuHfT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725610957; x=1757146957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6jHWm8IWRy3T0lTaKzmB2Adq31P+kag7TejueCKtEgA=;
  b=d5kTraPnYvBYoQG6r+sgohF1JzF/4QPzEuy6TZ7+Jd5IHAdUpx+RSv9J
   +1zxgQ3UDNlQXowJ5JV2dm6j9Xp+mrGC2JqcN2F2l9DrFjoNih9YSC3W+
   JwoeFSXU2ZZjEgJDUmbAb8rqKTx6cuDEMnd1sJPupg4G9yFf3df59iAyG
   rYpFp+JOdnAEhn+vz40TZMZA0EIm4tjvwCQ+HW9zK3PhU1NzghEr8+f5w
   9j6mHjr4200FaXA6ob6zK4kb1mtUaufn5nfkTMBBj2TLUUBpG78H8mnwJ
   1uWU+plmym2LxGSrrW+eFMSBz3KB6Qsk4Pj8PfsRbuOtWIHaecVuqadhi
   Q==;
X-CSE-ConnectionGUID: HsVYsjnrRyy6YKKx1LuvNg==
X-CSE-MsgGUID: 3MjpBM5ASpGoiUoNHr+KSA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="27093851"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2024 16:22:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thXPJ+IUWk3n16ZWd0/M6Ol7yx2CQbMt/et7jLC3xI+A/deWbpuI8Zv09EyfwzcP951weXNoDRYO9qekOnPBbBXLQj3ZaOd/YmL3bijf6Uu1fZdgXR50CF5x2mkGS2TQgQJwSKzFfOk1dIYw/rE8UsFPkU3as8l2TSDuuZjKK/RmDy25+NWMzZceRptekT+GkeK7qxKhKqfg3Q3oXSjMiX952G2xxF55ey7r024SdvuSeV5hZ99aOY68P/wPORyirSEsr6W1BPca0VeYG/gABifZfhkpibhGXlFI+W4xglmmNRRmqP6Xyd+YHe0ACBj1c9LrTN8jAXt+OoJxt73Vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jHWm8IWRy3T0lTaKzmB2Adq31P+kag7TejueCKtEgA=;
 b=bWSG0dV/blO/38oR6f49smvmQnrYSY1Jcq7jbUqoMp1oGzLepn23ACdvMIXRTE44lv3plHMoqwzXlIg90jYcFTwh3ilcKg07zWgOZY1cCnxiY+yXBrY6jlhsQzxSS+oW6VrkOCB5DwnG0HpkInshKScEpDu9Ozk86r9H8GOl+PmvNvSvHhNTkEOqK/XgNj2rMh7TKKdASfFRffoH2IO5HdwGvEAFvTnvh9D2+vVW4q5Wl7gmjpwnr9T5nrkZkqa5BaLPATjvIVXLnB9BWW/fUXWNKEW56NxNjB0+0Ltrwvin71ZJhoRazRSv6z/mEOM7sFfH0sDzUaQJlajD/coxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jHWm8IWRy3T0lTaKzmB2Adq31P+kag7TejueCKtEgA=;
 b=aTRIuHfTpZSFm86PyBDR2MPAAI8FEvsxCKSB1hEp6S5VL06sOS8Y5BUVpNlogbkbxXd277ft2EwpmRcS0iYA6lpsE36+djnswpydfqOHZIELdoEyoBQ52PYRhYz7f+MA5UUh6t0Sm8GReLO1KXP/Sm9z8a+yq3wRk2l1KbG+ZNg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9254.namprd04.prod.outlook.com (2603:10b6:208:529::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 08:22:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:22:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Nilay Shroff <nilay@linux.ibm.com>, Yi Zhang <yi.zhang@redhat.com>, Daniel
 Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Topic: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
Thread-Index: AQHa/SaPfgUQna9pYU+FKZSzxQd41rJKcYqA
Date: Fri, 6 Sep 2024 08:22:34 +0000
Message-ID: <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
References: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9254:EE_
x-ms-office365-filtering-correlation-id: de960635-8bc3-41d9-7e61-08dcce4d0f43
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/WkMFAcRdZcHueeVp+Sz2h/bH840AN+razhMgFay/G47TrxtToC2CoSxQSW1?=
 =?us-ascii?Q?qYnmHjXXq/JzYtYTMlgyG4M70b0JfZkT4i5Z2mPGtcosXdQIfW88+RXqime9?=
 =?us-ascii?Q?gIv/Wjh71GgOXS89gdlz1umBCrh8YYB8peB5jVbQ0ODgEYNe3XEtOitR8JNe?=
 =?us-ascii?Q?S38Q/eBeXMjobod7gAP+jAQkgAGsh34uiD3NU+Pkc58DozTMn17lkf7Z5yyz?=
 =?us-ascii?Q?AqWdE7LA387s/H39nRFme5ZVIvZsGi9l6vXPM3jw9pdE+LKS5OQMjtRgEn5D?=
 =?us-ascii?Q?TNyOtSoNIgLUnhxKlbNnq4p/FzwMdvBWB2Rp17LVzP8dyfTmQBV75pg8f5zG?=
 =?us-ascii?Q?rBayMPYfGJ+AAYUdGNrmjpQSFRsVpBAQ4pUM2vjnFBQOqHWBDpPqL8vXaz3C?=
 =?us-ascii?Q?CKQZg0dh8arOVTRmTZOsbfairUq18i8aRhG6tBk6mrPYxOolIUdhp9rPz5yb?=
 =?us-ascii?Q?XeUoW5XNIWldbb6MkHpgFqCEIi8gouUpw8Z8o7Tx/p6u9bB+HnYWYfkrB+4O?=
 =?us-ascii?Q?YcIvM+TMWGVrm1I953xLyf3A+CIZt1LqdVBtyYcfz9/h3UYwsxqy2Q2qNVDn?=
 =?us-ascii?Q?1LE5xu6fa+ghBKXilIN4HU8UZGnniiVMfaSIGqJkHmTGMbIFT7UvmO49EliI?=
 =?us-ascii?Q?vquOUaGfUCimqJULCz7rOooPaRwXiiSEOWSwLoloaFPmzQ+JH/YOwK+fJ6M5?=
 =?us-ascii?Q?Itm/UggZ0u3YXW5OYS34Ubz7xhHtix5LKd+UilHC5FbQ9VGKjRrBsEvuU5Og?=
 =?us-ascii?Q?LUjzudzp+hwxk6ASPiKxbJc9mnDxZ0JKd8zQIAQ9vH0KjjnxnNCMjI66uwcl?=
 =?us-ascii?Q?V2h8JkSj1YfS2TAx7hfVSF8zi4SE3fZbf63fXEjoYiuZTSvWDqeb68w+oybl?=
 =?us-ascii?Q?FiTy2CtqznJA4mvs65DvS0JxcLtNucJGz9pvLAuna3d/ONCttbLxngO5Bv3K?=
 =?us-ascii?Q?/3VyJgptfUoTi/6co3T4wcsvjfpBwkYvOYOTWDzmMaJTQk2Xfle9Zu9jdmX0?=
 =?us-ascii?Q?u2wS0RiV3i8R4cj+87Pwuk+aW9Nd81Uh7KCQ+GvnTqzVlgXIeUGTLNt2la0Z?=
 =?us-ascii?Q?vdfVICWv0b/UIde3cA3v12bIMUeXJAPDCSa1iuwXXYjrBDRqzUDtHcGmUByd?=
 =?us-ascii?Q?A5Rs1nL6ePwaboVonrH2LMKHNVWfNxTjCXNJFCSLRdDyclDnQxI/qbGcJ+qq?=
 =?us-ascii?Q?ERVfA5j3dApiz6oz6xXfVZ+FOa5ozXeOVPI+DrCGIPV26XoW0oWic0ItTFjg?=
 =?us-ascii?Q?L5eU1Icvob1WJnaa4sfFpuMwjqhXxD6qafPFK0WXX+Y1xDVSqxCUSrnwk9Z1?=
 =?us-ascii?Q?leSiqh+TzC8Cpa6sz5+7xbMuRekvkl9gO0Wy3e9VfwXGukE5FsRjDMECgs6i?=
 =?us-ascii?Q?2ZfS3mcBRbGXSpGG19EYAFl6dkQiHjtQ77f1Ky7rvG4fZmWPEQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LA0AyKOqtxf1lAoWhviV4AOXAJsc1ZKT1ZBVPD8cyUJFAE+uAtRrBYuBy6RZ?=
 =?us-ascii?Q?RBcrEeewqD+MHzJxhBWtwVjhXkUl7q21Rj/NmKNv0W5igupFgGyqrdR4Ql5V?=
 =?us-ascii?Q?rXgKylvMbajGxdXftZiFq8j+c8ggwGKpP2KqPlL+UGY5E9uSg3g3Qbb3ZrJb?=
 =?us-ascii?Q?+51TNG9k+VZRucLTIHfGWH1UaM7dexZjfHMBRrTLPK9StP/VNZ7HgrTm25j6?=
 =?us-ascii?Q?xsnaPlUNfv55KKS0zGoh7/h8G92Chb4PLMRQI64d1niZxs0kD7m2UpTGC4FV?=
 =?us-ascii?Q?3Iraw2zIdOFNyR0lc69GPdcWefTFgMgQFV2FaydiLKuS3rIno/udW0wXUnl6?=
 =?us-ascii?Q?56kK/Nbm4SUwO5fX8jMXa+S4HilFNip05nt6iBgguL81TRcJNo+IzY2u3Whu?=
 =?us-ascii?Q?p95wiURuvm3/PUnHMh7hrafK6FZGboyMwwhCSpfASCtmxAgkV1ETxd9el8+a?=
 =?us-ascii?Q?sxKH7sL5qpNKLzJ0LdcFSPY4B9L6dormfwJ2LG8KhIo3VD7oE+fEKe5NNVJb?=
 =?us-ascii?Q?cGwmHAZNT0Z/DMSZrvFMPGZnfDtbD2CohsZBvAk9LEdDSzpDYdZ0H8WCm0L1?=
 =?us-ascii?Q?hOa0rX31KGqtWRPaYhWnOJX/tiWopjB/AxKcG64jlzAOxwwYgfb4mSehumnc?=
 =?us-ascii?Q?2qjOXhAXf8yGaPVQEqJOcEM49tQ9UdYRC9THdLEVA78EZGwTcqRxw57GI489?=
 =?us-ascii?Q?vqPoK93Dkh8+WldLYnMFIE39+dMzbdmPkoSuchth83pn3JqchhkpnSaNIkVp?=
 =?us-ascii?Q?U5VcIPVdBLpM+/LkUD1kdNi8Myr8F4FPGlZzwrp1GsXGU9bPhUhszjeUmB3Y?=
 =?us-ascii?Q?8hCjFQOAb/BSECVr+OJDl2/tZjfXfnsECJw1hoWpvRjsN9KxQ6wUkh9HDf5c?=
 =?us-ascii?Q?qktyAFfSiU3+fWikOB5TKlBA5xuxnRiivGM5fN9WqsDltQvnXbl95NBwDmBi?=
 =?us-ascii?Q?MgL/QB3LzkhFxXrkgsHFUafxAYpXGLrqxbvbbj296DvZhvhVjMFSdSXlf3y4?=
 =?us-ascii?Q?Ava4QrNaSRn1Nz0B8LE8VO+3kRZIW13GvH66vLCJwz52XAoK5VycYN3Awfgu?=
 =?us-ascii?Q?JqHo4RKbqCiPVuS0blGyHQZCOQzYrwNKBC6IjGoqgj7UU3mOfXI6hASVqBzS?=
 =?us-ascii?Q?JeiD89qcOL23NTvInCrmGrXdyWtdph31px7f3H7uf5lcyy6/5wTNh9lZfoJd?=
 =?us-ascii?Q?AuQjUh553vc+MIX6w/azRXiF9cz0G4Bw4D32u6FTbtqLXQrYaecqxs/+GHnZ?=
 =?us-ascii?Q?bAtgKHl+UfWN4jge6NNIy1qq6Fnn0/SGH2f7krqjCEpzpFiFAGSijkLSpJsH?=
 =?us-ascii?Q?ulNGFcRmJS9tZlb0z3+JkptOKz+RQFblglmvTk7SETQDrwauBkC5C3kl4wnU?=
 =?us-ascii?Q?qIf1VISuY8wit6cy4ljz/7o8SOJMmHrM0W9pLTnKM8xd1jFnDR/WwIoo9CYN?=
 =?us-ascii?Q?+BqZ3Eh2w0/6JNBpQEqeCnbhuHyX69FfJNmzl6/3ubOlVmbFa0oOsDgWm6Sc?=
 =?us-ascii?Q?EyOYE4lIVrfBZ3F+wKKmK7h9GE8mPTvAK3vqA0QvXmzBctb1d0kUo5FU7G/k?=
 =?us-ascii?Q?MPyruJAUZBcofmDS1E4nbGZGieBiLHO3aroSPbhDHH7r4BhFS1TpVW07ism4?=
 =?us-ascii?Q?ctTPAKWZ2+zVFCccwZpF8eQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5906C2B5A489A144807536E5D5A6F600@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	32HJU0jVCu3ylKqa9jDDQRmCdlAPEob9BN5k9IA62LYPicBwwyeZXSqyIamA9U8LaxCr5KUiSRdQ5o3UdFqYN7OAAin57YPI9irJh6/QbyPPDDLLS9iMlLetRq07fHqXF3PipTOwjNXg91ZzAxZ/cQ+73NQjnZX+awv4Iw3n8UD8EwTjBNHID+LlDu95NUNV/ahMhAUTmoag1uBDTIshnOXEOqaiqTDdO6HLpGjCRGzXYlaIajiMiKKnx6VfDqsrd2es3ow1StdsmAn+sd2aR6DlU0lfYgYpXoDoH7yffvjJcafV3uT47gwGA5Ac3SDYzWUub0uX5D5482raeznkyF/LrMffZ0jvtSHIPw77r2sUZawl16YdfHRQRuSxDELI1xw/U4a4d+h26FpuyO/bgeagbjOcv7zzdKeTDn1UbGk6TaeDpRoAs7T3kfnOuo9eNPi/jYfPq/LADEgSeCXt1oMjnuKAPerbsqOJ1oRnn++TudgB4iGxJTXzm97TYbEqQa3Gp9tkH1wZPkA55wvdxvB/O6zfEC7HMfj/LCoSM4a/HjgS5RupxnBzoWxpnCpjVya2S8rx50fNVTJuoUmyax4wIwK+5BIerRCgfjdrKaM56/99R1qWqjw1esi/LQ2Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de960635-8bc3-41d9-7e61-08dcce4d0f43
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:22:34.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkS9D8ngHlPxsJ3zC4pgxoTqk6fJroc+ZDTVNwowyMEqrkrs2ltDQ1T+15hbdmv3tFzQm+sV36II8jFtA4wjz8jGhey3BjlYjRJFFcMngHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9254

On Sep 02, 2024 / 19:54, Shin'ichiro Kawasaki wrote:
> The CKI project reported that the test case nvme/052 fails occasionally
> with the errors below:
[...]
> To avoid the failure, wait for the namespace removal before recreating
> the namespace. Modify nvmf_wait_for_ns() so that it can wait for
> namespace creation and removal. Call nvmf_wait_for_ns() for removal
> after _remove_nvmet_ns() call. While at it, reduce the wait time unit
> from 1 second to 0.1 second to shorten test time.
>=20
> The test case intends to catch the regression fixed by the kernel commit
> ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
> from the kernel v6.11-rc4, then confirmed that the test case still can
> catch the regression with this change.
>=20
> Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2yce=
x6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
> Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I applied the patch. Nilay, thanks for your help!=
