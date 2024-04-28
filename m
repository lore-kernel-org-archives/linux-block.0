Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F41B94D
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714348706; cv=fail; b=dwyCcec+pH3Xz9idj0GMoSgX10+RUSCG8sIVxfV0HdAtfzbEavsCMFb/+szJPfPQDAYys47x7Aeayn5ZXiwsyCmwmVIF3NXyBichewaMV2z9CeIxGRUsdSrSlzaUHasHxHXBOjV/sheGfP4zMqvWVc6GWYfgr74unGEI/usAmoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714348706; c=relaxed/simple;
	bh=izH2MfWilLT0TWPf27NUPv5GNNc1vGoRAtBNxPj6wWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BWiTOoSVw3lBmqa5fU9ix4NW/B+GyoHOr41ibE8IBP21R9W9o/+9MVivzFHoo+Y1GRoShhlFG3ykP0d9bYOv8+fYZAUBwR+FS5jibmn/ncblFQ1ZPhvqa9+I+8SwcQs1UfZlGFI0Z1sAHo2bltH6T/BkqS1hatgqZOAW42sNJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RUm5ffJA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aOauOHNa; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUm5ffJA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aOauOHNa"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714348704; x=1745884704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=izH2MfWilLT0TWPf27NUPv5GNNc1vGoRAtBNxPj6wWw=;
  b=RUm5ffJA1L0CtLni4669ZMwJTabQOHwaR9U9GD4yI94K0oWdK0fK3Rvs
   Ioh9S3YWvzsCwUnDApf7OznG1FTGjOmU+4F0FaGIE2RREOAqyGwePnVkA
   V8TFSnS6tOeW1NiWkudw9AAfRqjccZMoUoi+FXt0jKuz+nHyeLz8WCJlH
   M3BHlGvhPbK5RTGCaJ86Ors9jzNJd2k1tQmt6fV5w3oFKri9BN2HpmStq
   zHWpzeBom2e1ZbKRlDhhK7W1ocFXKoJNsbwZWWpJ6Y2flunSUmRLAARCB
   +qMBfXPHUpP2atoFSLh5EJzCbPKYKUg1oc5mpApbDM3v/fpI9XbUJHIOA
   g==;
X-CSE-ConnectionGUID: lSGA7z0xSbW0wSFM4C7bkA==
X-CSE-MsgGUID: nDAFyNZ4SQ+ZhY7yGlqRYw==
X-IronPort-AV: E=Sophos;i="6.07,238,1708358400"; 
   d="scan'208";a="14829981"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2024 07:58:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apx8009cNpQ2jNxKTahU4/xoWYZVguNgRRqEidsmtn1JeqiQ2cHIdFe4iyhYr96Ns4ehMx+X1Fi+nwBtbRcaMedB6UX+7CSzIIQE3dTjbhyOI4XmS0MXrmDG4fNTh7rFR0oqdcG/X1XNN2MfAFi2QQ39nXFETm2LI6Sefqlau2vu7cP6TjXUe1mO1wgxwEZmSU1B2V74lLzTZAL2spZpy7ear7gQplDkkoowb46fjd7WyLBi3arlDRFlLuZVkB2Ik/PXY8nnZeTU5+6xwljTsBFO9K+WO60skX0aBUjgitr18dZkuyFlxX+LNR7jUjfgiivwnqxHJj92SBC8qhoySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2EDroNaH55eVdwdW7eEfpRKDTtEnivqSq7HFje/o+U=;
 b=ctrW3/b0aHN2Huk8Jh6f0+LvcOkuMHW6yfFQ5teF/+tw51bOMODDQMNsZd8DtNByV6Uv3hYDYsnQtCuq4FojFs6ERxvtOSzABWcmdtKCMQ6XaqG7EBrlhno09DaNOwImy9Xorft4DeFmULUEgnBr4TGzwrTqZch4wzTgC2v+TD5lbHXe+sywuJtQoyCoB/K/JbZ7n4yLBoGwjbFxe19pxWNCKhCmgd04YsY0KR99RfndnZAS+N4G8Jz7UyXaZcgoXBZF7mGjKvcomlBIG79p2ZfFFZEPGA2bInjnPWZln3UCJgJtiqCYcFgCyDlUKMZCADFUobjRhDqEK4Uygtgvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2EDroNaH55eVdwdW7eEfpRKDTtEnivqSq7HFje/o+U=;
 b=aOauOHNaRzWar0P8gYf+cxIo0wj10Gl6X498T3dpXXpxY74BhsPJnRPOK6ZBgRxFYg3TTD6NNArIXi7JMIXswBuvU+g4yGlBc3+KjH4tJ9VT94uMOKcyo7MK7c22stCMIZAsBbAFB7sMpIm9//GpfZSMqx6Yq772x8sRDfcGEos=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8889.namprd04.prod.outlook.com (2603:10b6:208:484::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 23:58:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 23:58:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Topic: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Index: AQHamUo6D+gVl3vVR02YXq3wno0qJ7F9fAYAgAAs7oCAALQwAA==
Date: Sun, 28 Apr 2024 23:58:14 +0000
Message-ID: <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
 <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
 <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
In-Reply-To: <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8889:EE_
x-ms-office365-filtering-correlation-id: e389a730-148b-41e6-09ed-08dc67df117f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?z2QPi1dFauBycTPFtzhjZ5iyuY5TLGiUP3v305IR4UBGhdY87d3jbhFAmKSc?=
 =?us-ascii?Q?ZIO/Mvox/k59Sa6tx8eKplrrXr26tt+pljDbo9POO5VPr7e/nTWACM4YsssP?=
 =?us-ascii?Q?24U1SliCSbYOIDLbl3T1kr17zfUzI4/PCGSPjXj4tVpAaR9SyrhBhISsFs/K?=
 =?us-ascii?Q?f1u/WhTCIso/RCwEG3ZTLIoo5USQNTWxuJIlrG0Llwqd6YZXiqM8hl/Vkf2y?=
 =?us-ascii?Q?2Ir8dcSOWyBF3XKpCZ6b6+6Sh6iPYKcX4Vrmi+dXMTLbqLdahgg17JThUFjH?=
 =?us-ascii?Q?zBYYEXnBjQf8Jbf9iAIb1Er//7nSYH53ttBzNhpBdPQE2N7OOIHeeA6ZT7PC?=
 =?us-ascii?Q?wlyAJUPQN39/cZVZer5Li4OlOym4NBLRqrJwPa0kDTJ9phkycXwjhIxUjJkY?=
 =?us-ascii?Q?xk8TDaTVIdJkgLTHaiGWMR/xeZbU3BokoVOKsA8tqWy+/RYfN1JWfTxN4oTJ?=
 =?us-ascii?Q?QYfvV5rOFEpE9HJRMiFAXlWa74xAfaOFSnrtoTsqn1P5HZiewnCaQfUy9QQx?=
 =?us-ascii?Q?g7ay4PoAF5qs/+YPHP1a7oIimm0RwZ+tqESka42kz/D/7eQSckuSGhudr5ID?=
 =?us-ascii?Q?dwVey0qykYdkbGf9Ou1WAFxcCsECdspwdqf5Ldw8rY4d7dgRfOUN6fkKi1uV?=
 =?us-ascii?Q?H9y0gik2ROraifDAsV6R3Uwvzjtt+MoCiXIGa5ymu4xLEn8VtwzeaFp4vByz?=
 =?us-ascii?Q?FkYW05NNhKla94S0jx+n9U1Mw5dIe+xsq9GzuswpbBO+s/wfDwiTj88LspzL?=
 =?us-ascii?Q?hXeUUL3b9vWPqRNp5KCcskmDiWzHbzTfG1JyMvDWmtbJskKqRO6sdLaLCrJv?=
 =?us-ascii?Q?xyLwK4vYDMgyI5YBZkh2u14wvjeCicaSUl0YxjBI6JYx8BcM96aM2zL9IKfa?=
 =?us-ascii?Q?IbJgKIkViwtPnOh6EZ1Q0yGV0+E4FtzbEkSzWobOFdQFRwVMsH+L6zCDd0Za?=
 =?us-ascii?Q?SX7gODiRiiWHkYyzGRx8sUCRmDDT3ZDPj7jhZc/2sjsiu2dyzMKQKgjJJEZk?=
 =?us-ascii?Q?qj7OByVVaiy2lGdsDL4zgwDoA28xSYr4vF/OzaThRrCgnXken0cNesCCMiUt?=
 =?us-ascii?Q?MD9kWnBnuoGB8nBIdnO7nhK0tzxZ5Xc4hKgVTRX66IZ/HUSJAcS8DLkeLZo6?=
 =?us-ascii?Q?P2sN5K05ZiOMOYxLV2NG8XyOliTrpuVLViFG4zRt8dsIobFj5W+s5zGnKZhh?=
 =?us-ascii?Q?XwvE+OUGqFORSyZhnXCXuPzx+t4f4ap4lmeBqcwy2axNCzoE0kJ7kKGCY/WC?=
 =?us-ascii?Q?eIYZfkh1u6PMccF+EUOmgSlbtU9Nc8ajbj9tlcsemQxw5k0M1ENIPJ29NImF?=
 =?us-ascii?Q?F3KJWyN9tEPe3lbFDii7qeYBDjJQbYnqRJRCWXNiJMpduw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tLA1mbMr9kBnixELiaiKrJxg3C+o5KEcEcob2WkhnP+5tEoejUTVtjfWI4Z8?=
 =?us-ascii?Q?IPBHfjc7fgivWrhXjtrd8szOqUEn2Cs7q6GJ2qfIoA2TRio9wxoyKCQdmr9Z?=
 =?us-ascii?Q?HJVS61UVztqNop+6gCpssV3VpVcff0mCk1GV64QV5++2jZzaOCXkvaZPXajq?=
 =?us-ascii?Q?SkO6sCZCNg8aRmzPXMUYR9Y5YpWiYl0FyNTr+PlGOZnhfHu8akl6wl44Sh4B?=
 =?us-ascii?Q?VZLuHtZExy6CmtSDRF4Mi3eg5QwTf5Ct+yylDk5m4dgZMooCSoxQo2Jr6/6k?=
 =?us-ascii?Q?7txCGC9jjGPqniSJUNAxzP7XA7Nf8dMrwI/+uOJP8cMAXLAgTfmr1upYegTa?=
 =?us-ascii?Q?4gqDDWMyJzsVCZbLXWXbkwMHhJZ5U/nVtHdciQG6CyM4p1aiZ/H5CEuqtuRJ?=
 =?us-ascii?Q?7TKRsbdpjcoczwbIwR00qhhkq4jCizSMv2DAiJ9ShlEJ4F0+mRWfufQPh/Jg?=
 =?us-ascii?Q?DPhKD9ItTGpEjkN0mcaXTMsDykl1AjxHucrUtBLNhyX7pnQuhCTn0ppkng+h?=
 =?us-ascii?Q?Dz3Vp8Cku3p8rYIwLyDxzhXLTHSwZ3KjA2HhpbscuVyHa1pjR4bB/FcMl2U+?=
 =?us-ascii?Q?sbU3oXwp1g1YToMkTBt9Xp9oVJZPuFhd94U8goivU6JyXf9AE6UyviEY0G8v?=
 =?us-ascii?Q?1WYD9jdfSNeJBgQQNVj1XhNw8+8NdAuEPjdk+d05Z62I9HYMMFPyf6yFl+d5?=
 =?us-ascii?Q?xK34PcXVsS548AqE5aa4KGXFX04b24gLK2D8rsICsNrLyizkBHNBmeTmT38v?=
 =?us-ascii?Q?jfmGq+E8/asc+96tkykR766cSZskVpEMytEytOXfEB4ut4BDl3Z5yT7EEZOD?=
 =?us-ascii?Q?wIyTZBvtSnILGg0vjIiSmwRcAL/W2uDTopQtoPiEulqlJKqP5yKXhmVM1DEJ?=
 =?us-ascii?Q?r57uj8b2v6xOnE/m5zh+6mYOQOIte1ASxSYpUVb5BjAhVY6BFT5OFhUy3zoW?=
 =?us-ascii?Q?/g85Io5MsURK1T07V/S2+Sd/E27zRGE/piu15rPD5E3iZNVxev9/DvAKcdGz?=
 =?us-ascii?Q?oi3oZkHgCfBQAfz8o4xliP/RX8DmSGBuqPtSPMGzHlp3sLI4P5xDq1nld8Um?=
 =?us-ascii?Q?CFPd9voSvJz/jHBbTNgHc3gVfswyYrsGqFQ7VA9HUwzFBsL1lT3en2AE/wwp?=
 =?us-ascii?Q?hJWtRQZjcIToKIabYyQkg8qa0AaqrBMmMTm12J3qst7bnJ4lln32IArPwttT?=
 =?us-ascii?Q?osgdxNtQAzQywQdBq8uzWBp4MeOhfOEoDsjrYUaLBnTLCLzR84gM4D7dP1Hi?=
 =?us-ascii?Q?3CzCZZLqo5Tp3rDy2Q1dKXE159TbOUHTQz95yXgrW0CzMD0vAZxR2miKYekj?=
 =?us-ascii?Q?kRymIYe2MrVSJVNap+0DJm8VKLEtcT8on+5NVEB6nnBuU1fjk2Cls0dby/PV?=
 =?us-ascii?Q?Hl/BrbOlI3gU8X9HdeqB/wG0xih1B+giY3mvpXOze+u8jpko1d1NmrP/dQHc?=
 =?us-ascii?Q?MFckEUP3bZ/0/Vu5DA+iD2PHywLzYOSviRopRuFRnPHS+nIJK9tg3MWXtMXQ?=
 =?us-ascii?Q?+tiv1owj2tIf9onsu3SQBnwYocKx2eTAPrlI9gpPtjVnc9FtXktbxOdCDBzw?=
 =?us-ascii?Q?UvXLtosbC9zhTz7trm6uOb1TOJgOK5ItZnkDh1zHk60T184mY6L2RTGmxT1D?=
 =?us-ascii?Q?sMT726Nsxc/Nqc1tbe2cS4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7A2D073B245D9459273F587A6CF7EBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpih3xiuwY9uuR2QeKKsQwG8iWCbnjV2yq8Va+36cym0uzoxt4+XP8LvPGMvhKfQAzUklEMy5IRRc91joQNi7ZEfKfoyAhbVF/fvR2jn6kPJrZyG3mjdAd4l14RcRwczgFnzD7Qm2NWBIs3ihIHPVzoXvb1QAEqiJrd9pb1XFlJDwXE2lY4HL8I3wKAWb6V3fCBfrvLZyKudS6VVmMyBQa+swp+fq3FHrGlAjT93rhnPL+NY/+kRqFuFlMeCQak7iGGrk2jhK2Krf9RyW8pQYMVLD4EJwCOsWYzy2p/JyHm3qGeuNa0142yg4HZSPFxsKvbUEflrYDDxPr9xTu+OriQwPiyIUeXF57y02S5vVA5uyNX/ii+eDPGJDguEBZGa/7pfzWty3C69EcYqpwpEhZqw+kSOfFM1BGsbnewdSaGKqHQGs0Lft6Nv79yfd5160geofmI5vikafbpKRaIXv/7P7RouTZh1Q7lLvd8Qu0Es71CG2HEbtLvxb/GQow4QI/+mLGxAlLR1yJq6jKjaMkKgfU0D4HHtseMa2uvrblRYHLZ4ve3yRJIb1Kef6Vptx5+wcok0T7PZZYkg1py+mLzfPWiZOVDcJ159mDnOLqGLNYBWkLpLBZJp3nxhrkze
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e389a730-148b-41e6-09ed-08dc67df117f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 23:58:14.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zfNddsGhlpuXQEgMCiB3uO62tFZdYtE4pA728hcAOdm6Wir9bnoQoQnPWOKvxqT8vOITtDAoUjTfK6NtzjW89bopskMk7PwXrBOVir8RQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8889

On Apr 28, 2024 / 16:12, Sagi Grimberg wrote:
>=20
>=20
> On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
> > On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
> > >=20
> > > On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
> > > > Enable repeated test runs for the listed test cases for
> > > > NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
> > > > _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trty=
pe()
> > > > so that the test cases are repeated for listed conditions in
> > > > NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
> > > >=20
> > > > The default values of NVMET_BLKDEV_TYPES is (device file). With thi=
s
> > > > default set up, each of the listed test cases are run twice. The se=
cond
> > > > runs of the test cases for 'file' blkdev type do exact same test as
> > > > other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
> > > >=20
> > > > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > ---
> > > >    tests/nvme/006 | 2 +-
> > > >    tests/nvme/008 | 2 +-
> > > >    tests/nvme/010 | 2 +-
> > > >    tests/nvme/012 | 2 +-
> > > >    tests/nvme/014 | 2 +-
> > > >    tests/nvme/019 | 2 +-
> > > >    tests/nvme/023 | 2 +-
> > > >    7 files changed, 7 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/tests/nvme/006 b/tests/nvme/006
> > > > index ff0a9eb..c543b40 100755
> > > > --- a/tests/nvme/006
> > > > +++ b/tests/nvme/006
> > > > @@ -16,7 +16,7 @@ requires() {
> > > >    }
> > > >    set_conditions() {
> > > > -	_set_nvme_trtype "$@"
> > > > +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
> > > Why not calling separate functions? having func do_a_and_b interface =
is not
> > > great.
> > In this case, we want to repeat the test cases to cover combination of =
two
> > conditions: M trtypes and N blkdev_types. The test case should be repea=
ted to
> > cover all of M x N matrix elements, then the hook set_conditions() shou=
ld
> > iterate the elements. I can not think of the way to handle this iterati=
on with
> > separated two functions.
>=20
> What happens when you add another condition to iterate against, you
> introduce set_a_and_b_and_c interface?

That is my current intent.

Another question is how it is likely to have more conditions to add on. I g=
uess
such many, multiplied conditions will result in combination explosion and l=
ong
test runtime, so I'm not sure how much it will be useful.

Do we have potential candidates of the third or fourth conditions?=
