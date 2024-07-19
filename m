Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787252BB04
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365650; cv=fail; b=LLH/ogjPahtDFws4v7NxcYeUyacPTZrcvmir6cbSi4/zjx4YfDjNGKjp84IG2Xhdbe+/lBdSgg/0k1aU6EfNw2JqKMMOy+4yveuYIholNJq3NaLGdrBV6sAbOwVFT1E8VmRIm30nv4drX4XpRoLAOzfZF9MMBO995cHwRTkvCbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365650; c=relaxed/simple;
	bh=GRjz8CA/s3kv5UexkG74u0M11cRFh14RWtJ0FagZO9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lc++QBAhaS7U094+Z2XD1LCsFEHD3RmUP7OduvrJOo9mp5dsN2SqOt3ipjZFQ+r61IXt3uv/9vc0rqJwiLKZJmCmHw0kp0yZNvkBJ+vm9LpWzRQUHGL57e0vI8VzRv1q4VVvag0f/uVNiiTZeJflPSJp9v0bhJKyhdOvyH/aTtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cl7OYSKl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tAYQbu/w; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cl7OYSKl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tAYQbu/w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721365648; x=1752901648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GRjz8CA/s3kv5UexkG74u0M11cRFh14RWtJ0FagZO9U=;
  b=Cl7OYSKlV/ifxRV4SyTPeON0F59Ezg23GhvhXWLX62V0DSI/fN+Uie/o
   zmPVaRb0EHmLloEzdiPuC5jnbIhkiNtP/rjKwDHm256AMozwpgJMZyZ8f
   pBo/XARK5OY8hlVABzcsfBM1sMBCY+PF2+zGr+dtY+AB/bcEHPQwbtlgo
   Pt/oaULEJmFVQasdSi7Eq2mmtQrG91AjbKOiKJNXkNcjb/qWcmtQsQq5R
   Fx+apjOVXIxTIJXnDTmcFCRIFouxEgqY1pzkgxfpje7m+M76FGfXjTGRL
   OOZallfSTbXLViAhGR+H87/ZqFgsasnahgz1TTXcQO2Mmz0a8m5D/J5q4
   A==;
X-CSE-ConnectionGUID: y9DU6zV1Q6uXckbYOaAg5g==
X-CSE-MsgGUID: t3IQRtpcTaKLdtZikis1/g==
X-IronPort-AV: E=Sophos;i="6.09,219,1716220800"; 
   d="scan'208";a="22474269"
Received: from mail-westusazlp17010001.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.1])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2024 13:06:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTlFILs/9Za2g7Q22yz0xdJfv7uggMA49pXwKAfe06i5Iydj9tAY2oTJeM9Ylc9MxmgbPdMlOzORUdZdUsOPqmZ8I2nSf9arP+5Nf6VG/Q1R1cUY+I52km4qVxkqSZgxoSpXrkyF7XYmxVS4CjEZMv67yyRgfK79ql5UR9/4Mq4pmWjyJcMnr9r86IKQTf8wbD2zqRP/mDbuF94Tt4nzjC+5V4+vdZw6JAWA0xyFMYpAD63osADeGJlbNy3VtHePYNrCmlJWgwq9+OdsWAffkKV93ISF15DXBXCtM5tFfoFBl8jCbILGEl9xxdfNnJR1POm32Cs09/OagU0jrM/8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxJCuytdt/B7N3RqLyBQDj3+1REl7N1YxDf2dM5eYfk=;
 b=G3cWJG9U+I+3sOUIZn+F7OoCWoG64ONUPe8P+Fz3lT6Gwwv52KeotbgCFlb9AeruIo29nf780NsmshvjeaJnXYiZZtbxYmwqPN5UHADBqg+4FOiFSSaGqIfNobz3XNLQZ0oHlP3jdHm9rM8tOuRjEtzW5mBUJZ1lX8tO6oHoThEVU7nPse5EJ0tuclMRqK5Ku/uu1SlcygMoZY+cTi7EJmwiiR8rZoxJNfVIq1bcEC2mxzjcnZ+Bo7U9kKoN4up/n2bnIrp3gqgsBJNVJMe4g/WiHEdw+Q4INlNCbIc65Tj8zgGayQGV9f196zd40WN+5MAwdLa2rWE0CKwjtEq3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxJCuytdt/B7N3RqLyBQDj3+1REl7N1YxDf2dM5eYfk=;
 b=tAYQbu/wuMQrszmdQrmDs8Ad+I3r9FZdeydTngk8g/JiPAanLuHGjcqbw5J3tY23CkmhrjNRdXWXC8dSOLCVuIQsqO1RGztdwVHeyqkc8pDDcc+Mz4v8AG2RHT9dMq88AnZWGmJ2TVKs1y9ohKXY/tSkhXJy0nzVYAyAIJuuLc0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB7984.namprd04.prod.outlook.com (2603:10b6:408:157::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 19 Jul 2024 05:06:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 05:06:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
Thread-Topic: [PATCH blktests] nbd/rc: check nbd-server port readiness in
 _start_nbd_server()
Thread-Index: AQHa2QNXJ0uVrY8r+E+TWb6w850jqrH8jV0AgADzYYA=
Date: Fri, 19 Jul 2024 05:06:18 +0000
Message-ID: <jxuru7czauf5ua2qudhw664soc6le645cbam6t7kzll24o4624@uzdifkdulnfs>
References: <20240718111207.257567-1-shinichiro.kawasaki@wdc.com>
 <72c1c93e-4ee0-4830-8950-ecfd72c0e102@acm.org>
In-Reply-To: <72c1c93e-4ee0-4830-8950-ecfd72c0e102@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB7984:EE_
x-ms-office365-filtering-correlation-id: 9c4175a3-9068-4a5a-09d8-08dca7b08611
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7mlqRAxiFhD0GDbOAobjCekEVwJXueJJk4/n153TmfWFtcqEUGYIcBEnhqFf?=
 =?us-ascii?Q?3SRib92r0/XLRMpPytieSuwjrBjxCA0CnWuxTeW9rt+tJOofgIeBAmjGgj1D?=
 =?us-ascii?Q?fzfV1BVNZJ6nX1CEp2mMuKboIlKM4vlLY3gm7VDW+zzVnruRildcVPRdFu44?=
 =?us-ascii?Q?0UdC/mftskjTfIIq51mg8yLLm78Gzd8dx9FdWQ+2QaQHhfJdqr2iYIrYdWeY?=
 =?us-ascii?Q?0xHRvGudbnZcMHoiTi9KRCVQ6PXAyXS9ESpUGGf7CG9TvcuPSsRg3RvPUtJB?=
 =?us-ascii?Q?6CkLRcI9kApzyhLdrSm84PbmdndOI4W2U6mXUq48s8bDdYJhSOAKoTxxzL5R?=
 =?us-ascii?Q?6oMLlGJzxJ6DO4ylIYnNGpgfntQjM7fhtii7QXXvNNjtH6h9p58hOXW5LPfc?=
 =?us-ascii?Q?5r3+oWBTBAC7lz1WZozKexVWwBHdn2jr9vnun9AtJC2inS7GniWKX6FMX6ZV?=
 =?us-ascii?Q?RQfsPa4VPCayosyzmhdQHrRj9eiY0Qcm8vanZ8ppylrjsSBO8CB103J5P7xW?=
 =?us-ascii?Q?XgAIM5+oZ9Rj1LfyDB996nI9AHpJ200sY7WhnfRZ9aPkvPNfgwGeS/7EZYF0?=
 =?us-ascii?Q?yjrNU2GZNR2dZ5q7doY8hS8x+ojvPTVVgU+CsYxZl2KuBsgtZvERDS5I5Ftp?=
 =?us-ascii?Q?cqx/dP3c6mGln57lFHQw/vAa5tedHiXcMGwL/TzDAqyXfQK77G4aFH/BiGAt?=
 =?us-ascii?Q?xMSCseIYjsM4WiBDihJDcPS/PXhFMsu16fn60xTNs8STqLVInocYW9DbU4F6?=
 =?us-ascii?Q?ruPOb8ggb2UaaM4FUXtp1GoCsHXS+dAMtVayfFPUxlW4AuMotb3v10zKgY3l?=
 =?us-ascii?Q?W49I4DYvM2Pjs8ZXT1uclsV03MEYdntfO+7unrzjopsz+A2Ve1onU+m2bMas?=
 =?us-ascii?Q?P3lQdfTNPHnB3yXIpcbLGu10TePjI4wFVISMQNaGF73fxlaWPNoViCbB3TdS?=
 =?us-ascii?Q?W2Jyd5MRr3ZVrqCurDQQMQb6r9QX+bjfSV5m16bjG98vyaIaXOweQc2p3YAp?=
 =?us-ascii?Q?VvTaF3VJPF7cTrSjd/A0h6s67nboRPxQOUySZcHO1DOSTH34R7XuPwdeSYPF?=
 =?us-ascii?Q?2zAUX9AsfJIsN/IQUjO1Iyr/hCHAVpzPGinFk8FziBWbkRJMdqroemqqD8pR?=
 =?us-ascii?Q?t1jH51uwCrH+4lQH7Lm+1chh3d5ETvTHiwpSRWTQtUDFNs4ttkpA9ipoteY1?=
 =?us-ascii?Q?Vtq/eHwHiX4P/Dk33Okg1/VIDwt/QZ489c/FWEtqxSiu1t6cTFqBuqjIvSdu?=
 =?us-ascii?Q?Bxd+ETRYxwtZG4+VP0n/0yrIJWRr8fJ8FxRdlv9PYnGjBzTJ5ch9iUomlJGx?=
 =?us-ascii?Q?9+T9i+QDFaLaLRYgDc+cJENQhBXBLWicm0aoEhwyDaG+Mpxyo3CfeVw4cAzu?=
 =?us-ascii?Q?N7O/bb7DMJ4U2woU8aRgiHsNRFpxSDNvWekjaFNTnvHriR3SPx4Li8cOYFjY?=
 =?us-ascii?Q?qDI+q67uy8A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?R4vHDIXZStVzEq+CG5t0iSmxyFQ7Sb+2a4vrTdfagY2Ozsdd6fZv18SyUEq/?=
 =?us-ascii?Q?PMU546wLzqrMVGQ9KDOgyv8RpaiPUP0T/YUHw6HYopmwQnCwKQ92BNXo0Unl?=
 =?us-ascii?Q?1p93o4yPVY31Wamd6NjmnyaQ8qkR53MZksEyf21zi+zmeYWagbX1R0LClnSo?=
 =?us-ascii?Q?0vb6LqUBNy1iBj9Z4p41IgqqaP9Ecl9BFzTCwcywXKzLB0bDR9IdnuD5qBDU?=
 =?us-ascii?Q?AJoOWUY1zIJ8+2njR42IRAXHTu8pLBVstHYqIgLwh+uTZuag4eRoMQwsYGMO?=
 =?us-ascii?Q?5FG+m9hc9Gav/f19uijkY896ODHpR61TEpB9j/vkWq/iYo/XCSaDZAFETujI?=
 =?us-ascii?Q?34+a/Lo5bQwyl/tkHo8y7jfBOnBPAYZA40QbNTWXFJw+q6IYhKsiHqvzwaK6?=
 =?us-ascii?Q?No67wrQjYZf3Gu783QNWByrfwxjwrhdVhpwcgJePt1Qy9tWF2cf6e2SQKiTO?=
 =?us-ascii?Q?G8R4o4jD2K/OF47rNFhtG/rUDvAOcO47frOoNSm4wu9++E+M4jGSww7fIPKK?=
 =?us-ascii?Q?5I9r4GIktcuB9cYhXw2OmYWMETF+Ge+nJaeD1kxWwqhk8090Xsmgydmq0kJP?=
 =?us-ascii?Q?BZ4w56Vxfzcg5QfFELInQdIZo6swu/VKrnf4yS/+jbxJqO3nkwsFeS7YWX7J?=
 =?us-ascii?Q?pGR6y8n7nzcuNs/gMWAnDSCUF2kXUrf1VGMpTySJJXj67+8JASvrHCOy2T4w?=
 =?us-ascii?Q?YDwThVfekE4d4hZPm3H+TVqedDd39uEIXHw3VF4o9mxtfxthni1o+/HC7V95?=
 =?us-ascii?Q?zpUzRYOWBhclJTFNKKBzIpWo+1B+tNXF2urGOcevkmyaZijhOwpIIg/9Vyhx?=
 =?us-ascii?Q?L2HGVUp3MHenGJjMU+NCnN5pY6UidMt8sgJ6+pVoUKNC7tgSo2SJ0OBgo/ay?=
 =?us-ascii?Q?5SqOxJKky/xCTj6FRvR2V1oEA99LBglNbJxiXEyYM2xkNbSV/VYLX+a3C7i4?=
 =?us-ascii?Q?XGqKdZEUQnRT4ThFUST6+7FbIbautu1gSoV6NinTmgw+5sHQCzdhdAYIjIJa?=
 =?us-ascii?Q?Ue/UEW9a009iW3CvssiLUQaqUVUgITQFWWb+fxVWF+H7rXRBzT47RDNtC+oA?=
 =?us-ascii?Q?q3ZlU7U5w2f1wimHJnKiHj9s+kvxmj0PxChF1Zucu7txl7MIepPdiNK7F4Vw?=
 =?us-ascii?Q?5YKC6HbTgRTnV97XJvmQq2yV2d9PZ2xHKOd1gbL35/h9lInFk4SbQ0pjDvez?=
 =?us-ascii?Q?13smtqcfuGi/+3pS0XaVGesBsyOAxvnjD3GaoH3sz7bG4qo6XejkRCgMtVq3?=
 =?us-ascii?Q?SimlJYsENpqrvF0QD3Jg2kBiJL878l92WX6tct9TcUM7Dhmj224NXWvxdblU?=
 =?us-ascii?Q?q2TgpgBV/WeGp1cWVoCIbmGSFdS+/421CPZUtczsC/4Y5QdDYpxJR6DBTj6K?=
 =?us-ascii?Q?0Fcsu6uFV9iwU7FQdktnyBDaKpzX/OGMDwnHnY+fYanibx3Uv6dAfcOnXJKK?=
 =?us-ascii?Q?2CqIdKi1vNb9TfQmUf8xnMLgUSwypMXAAUehI6H9Urr/0XJ7hghFeQY7Y5h1?=
 =?us-ascii?Q?zEr5F47qHxa5bj2TaQJzhqbhzAQrjkuwAX382M0en+rlRXK+O4s1sTG4ZLPi?=
 =?us-ascii?Q?y/0Pc8GGpiEEREFJ3WyqvkfbZ7vvZ5u9kghiDfNfZtKbQUyZULPFoUunsrDt?=
 =?us-ascii?Q?Nhrkg3+AZLS2NHPLXu2ZWDM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <220583AAFC8E2440B3DD0A86D2C1E6A2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vvqm7b3CA4F5z3weguRUn9y43r3eZRPV5/hLWErSNWZ77FlE/GWrxOY0/S6uiwVdo1hwv+MImTjr1GnGHHBoPOBT+NfOLtI7miVz6ClEyepgthgzdyIl57OkutzWg3xRYbkEYToLJ0GM5rNhH9JHHjD7t68yd+s9Ugi/3QaJ9yflUnzeXNF4XWgPUvy83VtoVIbRzobTfbplnJfJbaMZjOI42ovziv4IZi1GQys6YhjNT+pzrLk+G1v5oqIqxYcj8S703USSrh4BlD/Pg2lGAzGly4sOh6KxvvNOmn3Vy/mkPWdYqK+WvrMbXGe/5ZJzLN6UawhVJoP4dRLkwAd7EWcEpDKAuwVxvVg9yvGEZoQ5FsyQiS+wXSqYhA0r1YzNu604L01F6zHAyZMtyOKIfZZgRw1yQEVvqy/vRJ+GSliQuJl92CuhULuKa8ufeqWVLGTlyjPAXcewwuO7kHP9QzWYFxnK71vwrtcegNzIL4WgJ85S4AMZFJLz2GuVgAZq54tHTKa9Kv+IYk0I5d4jDd3rnLKZwZaIkNfIF0t328EitnND65iKH7pNWU35o52ma2a+3GXfZkpWZtmv87Yxdd6g8C8nev0w/kBQ/p7fM8wsO3mam4DbNpHxPOg2H/uz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4175a3-9068-4a5a-09d8-08dca7b08611
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 05:06:18.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq+h5JmkHGj/UXSyjReifRCpnZByy+vL7VL11BFMaw8DBCDcYU5kd3WqfCn5UzMZe+uJcp0XuRPXbAkVhWhcyd0Ao9eSh/MH+yuEpahjous=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7984

On Jul 18, 2024 / 07:35, Bart Van Assche wrote:
> On 7/18/24 4:12 AM, Shin'ichiro Kawasaki wrote:
> > +	# Wait for nbd-server start listening the port
> > +	for ((i =3D 0; i < 10; i++)); do
> > +		if nbd-client -l localhost &> "$FULL"; then
> > +			break
> > +		fi
> > +		sleep 1
> > +	done
>=20
> Has it been considered to reduce the delay from one second to e.g. a
> tenth of a second and to increase the number of iterations? I do not
> expect it to take one second for nbd-server to start.

No, I did not think about it. 0.1 second wait sounds the better. Will post =
v2.=
