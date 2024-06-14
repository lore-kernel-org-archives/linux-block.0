Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A92F43
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341541; cv=fail; b=RRgXkdhFTmmAyQ4vf1iCjzA0KAdMiZfJGx8gZanZ4Y/RrT1YWVfYceuXUQhwUWbokF8F2Z+9sLkQv+mDBGOmbO6QAJJjufaTo/GIgdKhBs+TZG3mJkruTxMoggwxX/HN3NR+H5/DcRitejt3AgvGj5iZNgx9oCc84Git4pmp9Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341541; c=relaxed/simple;
	bh=vJmEqLTBIY6OdCcg63a7ArEVWgDpbROPecohDI7ilCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+Mrv/z+a3QNWvApODzMDmnrZ54R1A8MegMXfxGDYHWyLSfnXZqcQBowOLtnXm7AF5UjBnk9EbH6+n3efK1A7keSJfanttzaKWbuG/ei3GFtOyuEVta5fEvFRZ+osxpYq92doAr7K3Jexw/zqcQJ3CF6Mf4Q1PZF14c/keFY7jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cGQN4xvV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WXF7BC6h; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cGQN4xvV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WXF7BC6h"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718341539; x=1749877539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vJmEqLTBIY6OdCcg63a7ArEVWgDpbROPecohDI7ilCk=;
  b=cGQN4xvV7WOaWh2mPHgWV/8V88OglvHC0JJbaJmQZA8YUhMcbdD94QbF
   B4Chi94ziQDyKuyznYp3s/In+OIEcRwPr+pmRMMC8xygd9wFcEzPYZKqj
   Tuf9rwdjNYqY48iWtPylQ8lm3JOKVGLlWUK5bO1e/db6XLjKiIFMYy59L
   8tiZlWRdZ6Rsblelg43AZjMZc2N6KCkCCkYt7dKE+9gMVXlBL3W8CGTPJ
   yxyKwqia4/0P06lAx9UZqpln2fXo9WBWjpf7/YgADxfNkISG23OcMSvVL
   i9TdDN64o04B9EFY4NIIJv7V0XDEB7HqOjLQpn+4t321NgPftPTjcepLV
   Q==;
X-CSE-ConnectionGUID: K4WnVnoPQdG7pgHyaUWzEA==
X-CSE-MsgGUID: ZZaVnjtBTieVa9aWvkrorw==
X-IronPort-AV: E=Sophos;i="6.08,236,1712592000"; 
   d="scan'208";a="19891128"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2024 13:05:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMo4by20oLaiQDNKFG98cXXAmq9TgsEwav2SNxuk7grc4cPvkOYtu+/scWR+n8H6Yt7cxKPrEUzeNBT8vAbAzgQDZa6jEQ7x+RwjWfNMoUWV+WUsWBbC+91kS2QZA0g9bBUEWceXOaIqBln2afVHdra9ebYA+mKyL0/JMCmTHPo4pVb4VjoAdwpENdpG5nZM+m7A+Nm9Tbd7inqrcotMEXEcqXB/Xk7IYtpaxVQm+1abcTIMxnY+P5hQaEQMjkL2Y49zIh/yVvMO7JOHP/99R5uPNvwMFhEYmvJW3ba077hVMkUfVa01pCpFJfSxSTz9ut88X6WZyR63BcNUbMIGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJmEqLTBIY6OdCcg63a7ArEVWgDpbROPecohDI7ilCk=;
 b=H0Qnn2Orrr6zxtDOFCtgODW/u4ZvPgjSSDNkgIiUGKlbwwSOV9pyHpIzGwd/PminRbwgIErVXdshQKVUELw4Wva9jV/OLvQ68l2Kx9c7QdnKBvuo8Z6EIy6uFCr6BkMuPNUr/3Eyf7XKqAsbcgWNEyOp0x9HKsM9DTDk724LiKmcKcBFQnXJIvoqNpL5SjUviv+sueTbj4zOCf7vHeNiCnm64S6R9LLFfeq7i4ltzOmORnkER8PZ8iklXHGxIuRPf1wQGHwDW/DbOyXtSn6gt6msEHpQS5bPb39F2nkBZQevCzHmJqZe3UQp38B+7G2sS87tLUhdbok5YhiKT0WLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJmEqLTBIY6OdCcg63a7ArEVWgDpbROPecohDI7ilCk=;
 b=WXF7BC6hR96qlZQJI+4t9D+Glzq8cDZ14lycxyquBVUbYDRjFF/mvI9xK0iX0+dZi0tpcl961u1kKgd8tXBRdkwsH6ZXY4zbQ94wXGAAzWxakesyNQ/SsFwAJERr0ov4Iva6BfAeOFOU/ZMzr2WbKDDOO4k+MEPfZumeA/zTLuc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8583.namprd04.prod.outlook.com (2603:10b6:a03:4f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 05:05:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:05:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC blktests v2 00/03] Add support to run against real target
Thread-Topic: [RFC blktests v2 00/03] Add support to run against real target
Thread-Index: AQHavLhbqb9slgpfSkuIy6JJVNiTkbHGt4gA
Date: Fri, 14 Jun 2024 05:05:35 +0000
Message-ID: <zdonar5q7m6h57fiqmoq45kziblfhrr5anmeaqc7vhbwif7d4y@kqtvx772lfsj>
References: <20240612110444.4507-1-dwagner@suse.de>
In-Reply-To: <20240612110444.4507-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8583:EE_
x-ms-office365-filtering-correlation-id: 2ea8be0e-7458-4054-59be-08dc8c2fa01b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q5gJ6fu1dk1qW7OeIOKKgGODHLnbO/g+zks1kA05yWPJ1y4PWradxKxuYyth?=
 =?us-ascii?Q?p49L2//ShlFWNYe7OoRNMc8Q58InXDqeVMZLepBRc06kmuSZDvuCLe1dXS+H?=
 =?us-ascii?Q?lIi/KxtsDv3Mtp6ODLa5HQY7lJT5DIdeHsIcb5wlEL97ZcE4tk5EbdjpaxG7?=
 =?us-ascii?Q?tF11haDxO+YGOeSgF/LoknoV2+cp5+LYoEkB828p+YsBDwqo4EIib9VLGMmI?=
 =?us-ascii?Q?esI2cjLEs/nRd8fpP/nIZGULNRNjF796TN2Iwnz1KIQZlSwPwmxUv0S+VlAm?=
 =?us-ascii?Q?9JWvQNVKj6EeSrlThzS5fxeXNan1JljVlbSRwtsU49pPsirfhq1AYJ7Lu4k8?=
 =?us-ascii?Q?8YS3WCkN26CwLgQqE6yMe0Uc9dlh+sIiLm3naodFhidudynQSb7uNWCEcROd?=
 =?us-ascii?Q?ry27PyJ0sNVxUO5+ESlHDlDZfwInT2NW8gHSPXSEDIMJ1rnCSZE56LwSgEjJ?=
 =?us-ascii?Q?F9i0Cdj0pSZ4yaUA0CYzINj+shqb6lk46gowfawOFRBkq2hQoTnaqti//1Ej?=
 =?us-ascii?Q?Vt+CGQubtDMsRLvlTRb0tgesLmfikQf8EHgBf/iPhyojyHIGaboAVGJfZI1c?=
 =?us-ascii?Q?fI6ACP9AUyeMjr/t7XToIqDN0/BO4yb5yomPthMKKB8/PFxCSuupObLiV9ry?=
 =?us-ascii?Q?7c6R/tLXnUg99creU7ZuzFivVKEPGwPVTsl0n2PC9oUZwoSaAeqni5vQLBwA?=
 =?us-ascii?Q?pZJHE91o/Cfb17V0vOJPhlr5bzw5Rt7gSbc3DTfVSRLcam2r1FddjWACtrPP?=
 =?us-ascii?Q?jiC8ClqNj6LYQ4VwH9MYje2sFlZfVXzArADKqxpK6Ouy9eWxgSJCbhown4Jz?=
 =?us-ascii?Q?xIVum+pGpxTyrwfZLjBoYXktrcy4ZukuOshG2INXubJBw0sYAZFpsOs5Mk9l?=
 =?us-ascii?Q?Tvt418iy7exEx2zQE9bZPtMfHZNjMs6pOeGMB9oB/TY1FGp9bU9ql3+9R8Zc?=
 =?us-ascii?Q?aa7k+1ZDlQ1gZ/AoCqdNRUC4KBVB0dYRh+8vn+vS3ARfi1p3tEV7BRjAeEIg?=
 =?us-ascii?Q?kynelVw8zi9OJF45GmsRxlyUwcexv19ZHN1t4AeLoP3Nm81x6M2xhbW30KT/?=
 =?us-ascii?Q?gAH4N90tLrHVD1Q8TuvqvVF8c3E5NYVrmfKyPxvyiLiWIZHpC9L/tahC5blF?=
 =?us-ascii?Q?la8dkYkQpG2+SAK1O2/c85shUfUdh0njAT/2zjzVT7lDsQ5aH6LgWOjOD3mg?=
 =?us-ascii?Q?s2+5AUrxrHNpVqGYFvMs5856TmKRjhfT5Kcxu2EnhH+FdXLtePtMhqQcp2Ga?=
 =?us-ascii?Q?HqD0RWa4+r1xDo8epU1ZuYSSMmz7OdtuwlU3qAtMqQ6HDJzXQQ/kQkVBKQZq?=
 =?us-ascii?Q?emf32joS2uksdbB4K/HW9AI2Lh5uZBWx33qr+OvD1/aadyL/lngG7TLIByr9?=
 =?us-ascii?Q?HPPq6To=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qtzLCgX8h6eILNfI9HGkSeZY1zPyxa6TMK2Vs2HZJEy+weX/hSs7CH1f+duU?=
 =?us-ascii?Q?PgDRtswRcP6TTp5eJl+01hA5S9CUE3YTcN9vYbUzHkugg7qiblqmov6HjR1G?=
 =?us-ascii?Q?+LOoN9shdPt8ilhR+K0P44BK7PJyNsmNo5EQzi1S1sJ9k830rm1gPYd1z//s?=
 =?us-ascii?Q?yOe6SjAAV641sJwAYCrLbITHszLBMMdOZ6JohNPvHYdZSctkwz5A0PhsDctr?=
 =?us-ascii?Q?8cYmfk0Db7qeNgpNXs3SsP1f7YzXz9HzmPO3eSWx2Nv3YSlQxrBASWvxPAyx?=
 =?us-ascii?Q?QcCKGk/q/Ue66va49BE6FFznhoHU0T3cCtzb1dlM7VHJmomAhexGHAGsJTzz?=
 =?us-ascii?Q?V71nlbGnDBwgKonGZmAEIUdE9jKLd4Kpp6o+YgdTBhUPN0YtUH05cSRM0LES?=
 =?us-ascii?Q?p/3rb2uvIrvqJWDe6tURldAVgSYQUaYqze/IzTjx2wec+X49XbISk2+PTf/V?=
 =?us-ascii?Q?kgz/DrcMo8Z+oj/j+0m+2/qOr2+1/G7EVRadurAZIjClewZZHvwiRjDpuIBl?=
 =?us-ascii?Q?89vr6iDvbjJqzfRRrxgLqMK0N8sOQ0tThME2Pny4Y9r0BdILQyPGqKa5OFld?=
 =?us-ascii?Q?iiTiyV5kTtLv5R/PRC2aFeicrOk70DLh/nKaFTsruaKu/i//rB+wgNntwWEP?=
 =?us-ascii?Q?tZAw26DOTNoLdIluFp1QRJZE3slcdFeEh84g7zavf3jBz854/smxYjEXI66h?=
 =?us-ascii?Q?N2NsY2mSHQlwOIPUt/W+Y5H93ECvNr6yJHkUGK9mk1L5RJHbeF3OEVVd010n?=
 =?us-ascii?Q?FMbf/bpUW7uAVZI4Ej4zRmQUosRq/Q2DrG5F7FJPQ+3aTSur4Zr4Ie1eqs5S?=
 =?us-ascii?Q?cpIz4XPWw8pOK9mkZ53X0grb2KvQnjkFwlCTjtovTBWePKu1ig4J34OZFFVH?=
 =?us-ascii?Q?eBcK/vnVjPgx83oj+LUgSwslhGvnCvXdIVdbsg4axA95FuXlqDXJmg+Jonv8?=
 =?us-ascii?Q?v/0Rdwhe+AJwYrlDE/Iu9sKZtHEA+tNPUD5hMvV72xz8kbyT5fTzjxqOkiqe?=
 =?us-ascii?Q?j7lVOfTVX2fybTxraE/UUJWkzDY7oW/FB2my5pBysXuY1+AvDVKeh2m/jngI?=
 =?us-ascii?Q?fqEDubeHd8kXOSTd2xaTHOSfRn9DMmeaZrr7Am+FoGtU1FP4QfKup3oJfL44?=
 =?us-ascii?Q?qE3f9iGp94AUtVoWrNL0I0AUn49PHILJXgG/695ydQeU2XgcIFspwna6EVa6?=
 =?us-ascii?Q?8bvY5pa4E3iT/KTlHSkyJapTGsm6N1bNYHesY+keCAVPQ0MSPEN6a1c/QRWb?=
 =?us-ascii?Q?K2u/MyVxJljdhJ+MLitUSwONmfNUQpSTB8RMdy2XBC4NdF6HT48ctXjQDfKZ?=
 =?us-ascii?Q?EyUa8t37BhWfs6cEyt8Ai1Kh4bx07+TkC54H2V2G1+qVIguBkLJiynRzp4cH?=
 =?us-ascii?Q?jjQpfYe9ZWyltYDW6RWsRwC3rM690gXMFlGNx2xg3ckZ+7MXeQCGxTWMqN1n?=
 =?us-ascii?Q?AQHYBXr1Ne9tjIcQdZTmxPne1o6Luj9BVcypDbzyjJB4OzQ2/6QqLV7UJe3A?=
 =?us-ascii?Q?PR/3gFxEOQngvTc2YcByzSxnsr/ztyDrWj4YFQomd2oDXccyvPd6cYudDmIS?=
 =?us-ascii?Q?3GFmO+t25AZEBE+g1XwsW5AT+lPanYH3yOwIZnMcTZ3yfy5/bi8+gzl+owku?=
 =?us-ascii?Q?i8GkFpk2aJLay/XzxmEBijg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF20B97B4C5A574FABA35CBEB67FE1C6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZG+IO6r9BWW9UmVDmqkMArO/xW6MmyaWF7WCZjwW7uijo6EzQ4e6jSuIlDwEs3cestnPyzejZmFlaAs3xXNaIS5FHWVGQE/rLjnQGKZH/wWDtJHwKXnIQw/cplsOy8cSdGUjpqT8gxN7jYi2XCh+s+eP9po44ojZZ5k0C78WOPbIam3xN9mo3sIu0eiYd35QTqW6wB8+BLQn2v8sEPaxz3JqUVkIG/e3/kSf/plWDgcZ27qKHklYpjEFKCEUBBxrQQR9VFS9BZ+WALo5SjV1ByQiGPWhqd9hWXPgUoa0OsbEFD3A9w19kMV1G+ruuAyJ7xgO93OrY3w1OMbuZvv4AWkC4bDabuLEfauqOTy4eVb1Z5deQBJv+atkdo3ij4nWtA70KDj9Mc8B8WRmewEyYPlYEVnuxtcZ9vlJvlP6rVLhfWX3tJ3GGZR/0RgqaSMQFI3eFl55GCzNAzvf8ekipYBONc+C72eeSsVvbVGip6A3APAnanaO9tzdGg+B5/htAibJr4VhNdKCUQhHIfK7NbWTRz4H8G3B9eLMQqvalrw07VFeq08WsdxWxy7nJ1QhI+qm9EVh3sxaeO7cMxf2QbQH/I3GeIMcsx/j9px/DdQDPE2YkMGBP+xzZ4bheJqR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea8be0e-7458-4054-59be-08dc8c2fa01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:05:35.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdojEQiMgf+VTj23dHIxNzfEldqXuYDHsHrW/H/CLRuEds4T3c2V0g4G0j5pOw2XQRKtm92Zzcn1aCg7s+ZQcvXO169yUQwtktlCeINfCPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8583

Hi Daniel,

On Jun 12, 2024 / 13:04, Daniel Wagner wrote:
> I've updated this series and added a simple example how to use it. I didn=
't
> really know where to put it, so I added this part to new directorty calle=
d
> 'contrib'.

I'm fine with this. Some other helper scripts maybe go into the contrib
directory in the future.

>=20
> Don't know if we want to keep adding environment variables for this or if=
 it
> would be simpler to pass in a configuration file. The environemnt variabl=
e are
> fairly simple to handle and it works. Adding a configuraiton file adds mo=
re code
> to blktests.

The first patch added 4 new environemnt variables. Unless you plan to add m=
ore,
I think it's fine with the environemnt variable approach.

Overall, the changes do not affect core part of blktests. This looks good t=
o me.

I'm not sure if the NVME_TARGET_CONTROL script command line interface will =
be
stable or not (setup/cleanup, --subsysnqn, --subsys-uuid and --hostnqn opti=
ons).
I wonder the disucssion with Hannes may affect it.=
