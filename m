Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447C848D
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714717427; cv=fail; b=E/TJN2T10trfBjbJRhi3MvsMqKAVw+L+TCv04QeLnBrd56E3I9/j8wszkwffDo5elh7VEHJVMVH50zkFZJV7sjGqau1t3FFGCH17m8mDRCuLukFU5FTbWUlVQQVuqzf1t9l2Lpcj7FW/eFxgYMELdfAiP/lsNLzTvlxD6A47m1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714717427; c=relaxed/simple;
	bh=V8L5/8xBSNcp8d6FeFrtZyvvs1OT+6YVQ2YDeVR26ZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujaLgnRGMzwkHh2NgiYL086Ql3/jA6IK0XAdBWgV0y9tuaRp50p6iANDYI1uf2Nlbb+NqRu6pYlRA4Qc72IV/mzczB7SwXtDZjHOEJKH2hMlBD2tYILaahhLphS93+h1vWcY9npCOoK7UQOabliX6BQuWBb6SZhTqKYNsWA8IIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ido7I54p; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ii59wYf/; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ido7I54p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ii59wYf/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714717425; x=1746253425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V8L5/8xBSNcp8d6FeFrtZyvvs1OT+6YVQ2YDeVR26ZU=;
  b=Ido7I54p5e7cr2WV7m9tq7BSoHBkTP9cWQjEW1wTWqZynU10bCFI/png
   EoJjOPFhPA3iL2nXfnGqe1bjaktgyMWCxp9xG7Kl8pct/QwGVugbVt2Qf
   xUoHuMRmktmolo2aVr1ObMtKPLkMoJWWi94K2gknul8qSlSyzP+HR5wfN
   4FoQ74oidyTVdkaGwV5LaS1lHwFE3Q4l/5kKbRss82k+oXWn1Zzsawh43
   vonOoV6/CpEdHiF9rnN987Xvdg6vW2A+CgkLTGDOCVQEliuqcl1fds5m9
   qPGC4d4UZ2VGHO8h1DNjjcEa82nONM3EZLkwKmW498Ag4Rx5t/cDqLXI/
   g==;
X-CSE-ConnectionGUID: rTsEksSMSn+g4IdZtGlm0A==
X-CSE-MsgGUID: 2tEFbfuwSw2wMZIMmskujg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708358400"; 
   d="scan'208";a="15716952"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2024 14:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZoS42hleIPjQ3yC92XtNu38AJguRvGLNYBFuS39RGaVY1lOuiazoz/Zx6TsMhiTbqn5gsSxTfU6jmMjl2eflvZX7MfD+h+I1sKd8uytP6sRMPbBNKMX/D8P6YL7ejSLqeAKKcjnh+bntAS7uXqP91oEL4aLijO426pXSrT9dFTM2P+RnSAUFuGvAUTRAzEJN7qcEjRwldz5zalAxMatTAUxMF2onhW9MSARsNSoSkeoQO8vJTGR6fi/m86yl5MkCcFvpxwBwkgjE3j6tTksFbKYpR8hnRGJg4qpSsHBzF+hvzZlsquN8tXcTOdb9AyxNyY1o96lHC0UINSwoq20Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DF2FdUymddZBqs8PfyrXT0GMo94F9bMXblOI16TNBU=;
 b=ChpG8LHzUEHZ1ekkNz7ckzfOjtwUFiOk/IG1sZNhjRHIX6OA5TVrldu9Vz3OvJFsf+NojzITBk9LbdJFWWiUqdqFkZDUAU+0k9KaNhFlYv5p1iEcPrk5WuXxqaq9BwCHfZyxesZh/cSz/KDsd+RiKRHx+/zWkGbnxsykvrAqVsW6ixYXhTGjh9nPWzfkoaMGbEHl6vfMhieLTt7k4NYeRSJlPmwJ2rJbehB1dIJEiPKVAZdxz2VVYVCqlfb3NN2vkwYZVCq1NcF/f3hOP7PhzSOMztfhQkYsjemAe6G5LCv8+oOMoy1/NkMsFHdEx8SmSP10Py0Lpzyl6uDDaCfZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DF2FdUymddZBqs8PfyrXT0GMo94F9bMXblOI16TNBU=;
 b=Ii59wYf/beGfmfio1So4fgzzgIuItcF6KPBoPU37oBxYJ3QSs1kkkMMB1ET5C/mEpDRTFfQ6qU76Dw2XxCEsOGTVTs0YhUEd59tiwNo1Ifc8boOSynocy0apYHnDnDEGB9PW1fAKvzWdTQGUvXba3mCHk7zFGJ/vMQW66aupPsw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8167.namprd04.prod.outlook.com (2603:10b6:8:2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.33; Fri, 3 May 2024 06:23:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 06:23:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Topic: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
Thread-Index: AQHamUo6D+gVl3vVR02YXq3wno0qJ7F9fAYAgAAs7oCAALQwAIACXDaAgARY0AA=
Date: Fri, 3 May 2024 06:23:34 +0000
Message-ID: <bxklo2o4onybsamatf2nyhecnkl3wuoz66p7nq2dyndnfc4vxt@hkokvvx4c7jy>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
 <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
 <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
 <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
 <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
In-Reply-To: <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB8167:EE_
x-ms-office365-filtering-correlation-id: 59b96b7f-07c1-4135-c962-08dc6b398f51
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RP2loqcTGqbl3RHx4Lblz2yFrTi4m77nhdRnOHyCP5+9PEu0tm70RHDIs9F6?=
 =?us-ascii?Q?fwShfw+209eJe/z48T3P8YPCHo8wBrVGEz8UpKxRsxXUOsBLH+gJjEYwr1GA?=
 =?us-ascii?Q?PXyN+CwkuRuRU/d0Df+MJo3yIAOJKjnLJmGEHC9sGZLLboCV/T540elSMAga?=
 =?us-ascii?Q?MIGhxueQuKaFliSGRyFb7pD8wxZk0yCHnOc2EftnM9+7pKI997vMSg8Dl/39?=
 =?us-ascii?Q?icaqN8o8dWVWh3HEO3l2qRypFof4ZDGTfoTjqzvRGSm+HnTY6IoklPVuYAWe?=
 =?us-ascii?Q?E0VzsvqiSv/76cJxlD+Ae43+PAK5nBnCIZCzt9+LrVHJsiJDz8gaMlK8zQFe?=
 =?us-ascii?Q?j+Jd/Aj6416C8Qq08j25WqUNM3MPYGedkYlWiTeuOZuUPLUd0fcsAcz2S+fk?=
 =?us-ascii?Q?sZ82HJ8Kb3gFMGkQ1iwY7O0hnOU24i2Gwe9gD+Gx0fazB0vLLVaYuwe1K8oM?=
 =?us-ascii?Q?sKdxJh+e7sHNc7T3MM9CSlPqcFjZNzyDwQcVvnWNpvn4Y8nbCkK/TpwLvDMW?=
 =?us-ascii?Q?Gwydy2Lzb+Zeor564Dcjcs5f/V4ImtaOM0qVphMH7UZGXXA+VHslUrIDy6q8?=
 =?us-ascii?Q?TQeBLjJJ9ATTSom81D9B3KCv8ilUdmLjjgvJxJIDdjkiZn9TCoVyRwZ/x6Z7?=
 =?us-ascii?Q?m8dSPi72X/jGW6uJVd6lAf065iz3Ne4yEHYUXZ5e+W5CYRTiRPSpBrtLFu36?=
 =?us-ascii?Q?jbDab8wXEFaIiVtcim2dxzHdf+2LYXe5/i3d+Cy4SZHB6qKFmw4LwpLgtRwy?=
 =?us-ascii?Q?rhLsrq8I1o6RjfiFuluTtTN3UvFuT6qw+WVyNpwAyDAeD1Nk8DtpANF9lQLX?=
 =?us-ascii?Q?Ay5Jd26qOe6yyTGIEFyar2J2nLc1QQQzQRCXYj7UmSCoM7cNBAr2DEDi9zcK?=
 =?us-ascii?Q?wB4oy/r/xTiY/yD5SqGtYElPNp1itgj0fvJbVRnz8umGRqigXzuPgRR5Q/Fa?=
 =?us-ascii?Q?3uI2QItuUM7Zts8BHCvT6XJtAT5N27CTLiesLMI0R8EAJIDGscj8GTQuGNIj?=
 =?us-ascii?Q?f9YuX/RPGM3P1U/mmWT7TQw+lAhcwCue5VrS/g3lZXroK6qefESmUxyJn7PN?=
 =?us-ascii?Q?9hIMNP6amchhmidDzdHmyF/NCOQcY52Ahm0NfkoriF9bRdl56igo6V3mH++P?=
 =?us-ascii?Q?n5ZIJB/3tuvXPaoOtVYPJhfjgGvnXXbEHz6OpqmCqis9tkOoPue9ofQFdcpV?=
 =?us-ascii?Q?eYodYgqjY1hVxNTDkbftluFmonRwsQfylOChEqHZjy2lg6fihPeiavh+WLCM?=
 =?us-ascii?Q?vGrBDbAUj4lRCkwg/5+c1Gq7k4cuSY+8i/chn53CBoxAzfAgDkzes1DDJrlB?=
 =?us-ascii?Q?rSazbNVgDVrEncI9jQYOWLdo4HRn3iYrlSmHz69PXcFh/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FXzhIJFFlhZxkREOgoF3XmHER/UihFxE5cK+PKCEvmMG4a/0lmxVGGgUxWl4?=
 =?us-ascii?Q?GJeGtfx7TAcb4zpGdZBrgOifX6dQ0vKEt8G2wmnhJrt3WdYz5zoKm/enSzTA?=
 =?us-ascii?Q?I9j4qC2XVF0AxhpY+ZdVy1rZfwmxrEcgFDVlOzyZNwvuNV5hD1sFPH9jtIx7?=
 =?us-ascii?Q?lO8vkK4IBZfcGl+5JnphB+/5GvL2V2pRHp0qm31rcegQxFnYabs8Blr7L6wZ?=
 =?us-ascii?Q?Yi4NXeInpAUx7GokZgoWHAhmvZtJgWp7lD2X7oPuoSZz8tWIIH6q+p7j72KV?=
 =?us-ascii?Q?J6j1CGDVJ+JuaGb0Nu7Lgj6yH3imCY2NfJyPDL5X+s3yYGOjoZDk1fA2bBcs?=
 =?us-ascii?Q?DxWMX+v5BbF1e07R7OICqypEDec3Ttw6iuWJQYd9KEvA1JgH359Cyi7FzsjW?=
 =?us-ascii?Q?fvAxtbKXtEoF3wHxyqwcLDz7euVHu1PdB/P3VoH79LqKpWYhF8Dzi/n/nRqB?=
 =?us-ascii?Q?Z3Vjsw6WTako3cYsc68UTXZwKbMRRkBshlS6OxKUu7l4o4jQcYNKf3EQxDBU?=
 =?us-ascii?Q?ylvTlkZuT8dH99GN1mzUofrEzHLgpZO/x0+aImZNSr5eR72gzN4Y+GUTuG1K?=
 =?us-ascii?Q?tohhsOTj18Pv4FpltfyxndiSLotoV3c3B58EIETAT3Mo95ACWC3ap6ruma0i?=
 =?us-ascii?Q?dgHzh24QFs45eO5ZrJVwpmyIg6W4zAFWoCaNnkUf84TMXIPfR/GEiW9dUPKX?=
 =?us-ascii?Q?ThbL194pkmc7DAvPzHBgFw9t2Q8xNG8DAE+jvZn+74ICbkA3UmgT7GfCHdJu?=
 =?us-ascii?Q?MxvU9CyCSynmv0vvVcTMqsTSWYPsmmeWIwLa6Xtm1FSpyjIeE1jCwBdvSEh1?=
 =?us-ascii?Q?sD/u/kkkMFpWmwmvevOEC/UASucl9Rk4L6v5AeTIkd5tmRWX+SRUyHcOW+GS?=
 =?us-ascii?Q?hU+NMJEXf43dFOoFLREfUccCnuHM0mWOScO3qFdO2nOqgUCAhBzOtdBvSZQQ?=
 =?us-ascii?Q?yXwzP+7Ig4lPp04ClsdaDLi0f2WwTqffQkHo1QB42ys56X1uuvB/mpB3vdYn?=
 =?us-ascii?Q?ZkleJeHBC3WWCCZ/l7swsnd+5aiTTlkLvJaft6ydMj9myqQgHw4d3IydPmsS?=
 =?us-ascii?Q?e/kwxE0dkXWrMzKaWAY/zw1/iMTRSDfnHDAU8ZnooMGzv8SrBWtK8kzkqGV1?=
 =?us-ascii?Q?Xiv4bR/T2FBbZcZj2NGEfdc6xigTR9Ya3zqGzn8imC4+yq7SSIev8iqe4GhD?=
 =?us-ascii?Q?HBRTJerJMl0swdw78+faxpMQ7YCiqU+g4OzhCYdKFpqXFRoaIcexz5/aRBE2?=
 =?us-ascii?Q?l1LvOIknvzwuWa1tFij9GhpmDghzjnxzsfQctsD5FVZe5fDgCb47tkwp9ZCE?=
 =?us-ascii?Q?PAbYvlJeHGwVwJM/Kg673ef7NYs5K4OvvYZRtqpuF/KMUmvS2EOJVeT16KNj?=
 =?us-ascii?Q?wwjRayxP5T/7uEt2y26r202RVuFO+pNvhf1mNwgzkU+dfqEW3beLIxd+Xps+?=
 =?us-ascii?Q?L01SJSupIv90hGrr9PB96tzd9GzSxpROnXbWH/vo5ab3B20Fm+5wPjqzCUvm?=
 =?us-ascii?Q?vI2mnyZxAc/vRYuAX9DVRV01B6xymU1pvcXznsz1r2VigsyfWI9R3lu4olMf?=
 =?us-ascii?Q?0Ht5oI4uqDNobv5VbhESGzyk5GD/SR1ZG4UcjWb0pyUGEaznWPhRdtJpmwYJ?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D585215AEA3DE4CA84E0A7584B775A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4KrGskXakCaZBX+5RpO8U8jVtMn34seTuRjVgUA/7Q/MfMjp24WQv8aAdIzbIEqmKcgpVQgTxTL228kfJ4PbjVe6DZrYhbYA5ZkWFDlTpU3mlJOPLMrHGCi/aXS//vlCzdtGSvnDsG5kycSiPLtsq+0eby7U60zBKnaUre9m7qvPS8TnrNM+EQxsvLMspa5j+YwxWqHYGhxMv7sxwSsa1zcOhXzYtyigNiCtj44n7ofWqWMB4q1wH8ChdXCHJRDJNu3MFHkkpIhRSy3bY8JTBG0+vA4UYALMQE4lbzQgl225GBJPxadGRRSgwwjNWN2ZR2avgN4o8YWsqPQBI15UuzmHXnK9UmGLzc8FqnyWJ9nH7ujd28H3/bcN/XYUGnu/tmDd5oSA6YV3B8FykkXZrAwgaHHvhHAU722Njbu0OJf2t1tREtFEcN0SqamhnbNOS9HXhFz7YJJESP7wiEuyGJL2Q6JVS1ZcIVLnruGhQ/Fg6sSxUkzl7pMA+Js2L1NVSPGH811VEy5W65QJ1kw2Y3BOXGZ+oWr2YgPkWZJnau3V3g3BVOfCgjskreUPK3DorST8nZjFBSUnijRkxnPMt9tJEP7MFTQbEQFNIXfL169+oTJ61hu56SAy63mFd7yY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b96b7f-07c1-4135-c962-08dc6b398f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 06:23:34.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUhGr0AGC/XW2MOsZKQJNv1M7ZLSXxWhpCjRnHcUp77Fje7LBH+1FQ5/Os67zMXIyBc9e7XyqvzvbVzIKEpztLkkqphjjOXoIXMk7ci1FXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8167

On Apr 30, 2024 / 15:00, Sagi Grimberg wrote:
>=20
>=20
> On 29/04/2024 2:58, Shinichiro Kawasaki wrote:
> > On Apr 28, 2024 / 16:12, Sagi Grimberg wrote:
> > >=20
> > > On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
> > > > On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
> > > > > On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
> > > > > > Enable repeated test runs for the listed test cases for
> > > > > > NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
> > > > > > _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_=
trtype()
> > > > > > so that the test cases are repeated for listed conditions in
> > > > > > NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
> > > > > >=20
> > > > > > The default values of NVMET_BLKDEV_TYPES is (device file). With=
 this
> > > > > > default set up, each of the listed test cases are run twice. Th=
e second
> > > > > > runs of the test cases for 'file' blkdev type do exact same tes=
t as
> > > > > > other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
> > > > > >=20
> > > > > > Reviewed-by: Daniel Wagner <dwagner@suse.de>
> > > > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > > Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.co=
m>
> > > > > > ---
> > > > > >     tests/nvme/006 | 2 +-
> > > > > >     tests/nvme/008 | 2 +-
> > > > > >     tests/nvme/010 | 2 +-
> > > > > >     tests/nvme/012 | 2 +-
> > > > > >     tests/nvme/014 | 2 +-
> > > > > >     tests/nvme/019 | 2 +-
> > > > > >     tests/nvme/023 | 2 +-
> > > > > >     7 files changed, 7 insertions(+), 7 deletions(-)
> > > > > >=20
> > > > > > diff --git a/tests/nvme/006 b/tests/nvme/006
> > > > > > index ff0a9eb..c543b40 100755
> > > > > > --- a/tests/nvme/006
> > > > > > +++ b/tests/nvme/006
> > > > > > @@ -16,7 +16,7 @@ requires() {
> > > > > >     }
> > > > > >     set_conditions() {
> > > > > > -	_set_nvme_trtype "$@"
> > > > > > +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
> > > > > Why not calling separate functions? having func do_a_and_b interf=
ace is not
> > > > > great.
> > > > In this case, we want to repeat the test cases to cover combination=
 of two
> > > > conditions: M trtypes and N blkdev_types. The test case should be r=
epeated to
> > > > cover all of M x N matrix elements, then the hook set_conditions() =
should
> > > > iterate the elements. I can not think of the way to handle this ite=
ration with
> > > > separated two functions.
> > > What happens when you add another condition to iterate against, you
> > > introduce set_a_and_b_and_c interface?
> > That is my current intent.
>=20
> I don't think its very maintainable.
>=20
> >=20
> > Another question is how it is likely to have more conditions to add on.
>=20
> I expect that people will want to add more flavors moving forward. For
> example
> ADDRESS_FAMILIES=3D"ipv4 ipv6" RDMA_TRANSPORT=3D"siw rxe" and possibly ot=
her
> features that can grow in the future.
>=20
>=20
> >   I guess
> > such many, multiplied conditions will result in combination explosion a=
nd long
> > test runtime, so I'm not sure how much it will be useful.
>=20
> I think that running multiple flavors of a test suite is a capability tha=
t
> is bound to be
> reused as more test flavors emerge. But that may be just my opinion.
>=20
> >=20
> > Do we have potential candidates of the third or fourth conditions?
>=20
> Yes, see above.

Okay, the candidates look useful in the future. Fortunately, I came up with=
 an
idea to make up the condition matrix from multiple set_conditions() hooks. =
Will
try to implement it and respin the series.=
