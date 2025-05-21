Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA82620C3
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828314; cv=fail; b=ij60XEnndfL7HDwnxoldcMJwgzkz9wp+Ek7ZzHm/Vutl73vTxvw8TVlhdeztmou/oxAzXR0xj5mB98cOnH1Fi2AKm/8r3NlO5bfchrQ3k5YA0VGLognlGnzjoG+hzS6ykXCzU0vf2uQKuW9tanHnUofnwwm9e4CL0bblxyC/ulU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828314; c=relaxed/simple;
	bh=eddd93MRo/nOt2AIcrLACwwgp8aIm+PZjpTJyaYJAGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSjDoHO72vrCJeNmZ3rAemIQ1ueu6rZKFbWtucWUqFvdwOxf0PBD81NCLtvkJ57MpsUxbGUwAxsNKGUIRaG3Alvef4w7VIa/I5Jxadbhg9F9gzodkbU8+nYHvzxwPSQuOB8DvZy+t6XfYYZu1cHJaTrfhwMUvaMhBkbHipHOXjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fpawnKyl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kSe2eWmM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fpawnKyl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kSe2eWmM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747828312; x=1779364312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eddd93MRo/nOt2AIcrLACwwgp8aIm+PZjpTJyaYJAGY=;
  b=fpawnKylsp+J+MLYhYiQTlG0Db3W3qYdtWnUWuOowZK6eplQzoowPrEK
   +iEFujgZMJUo0guYUNOuJm/QjtQz/i9fLhnn2jUu3BB/E3hXnWqRCkTWW
   1jJCQkSmU7sx+5UjrfueFMK98Y/y1jAHMAipEQNWyA8Pw/00xHQa5+iJ4
   vzSFY3ZRe2aV09tE8NilFn5rc5oYCoASdQG9OdZdzERy7DA4LSPBR5hvx
   3RccpcLJWufFtUEpNM+SdBCeSEgBXjhhxDqjEUA+axW1in64jJCLN9awz
   gpZemNQhgXJvWe1/vsxVwQcf7zkGWph6IJQglBS+O4QCR5Co7J2nFlG3L
   Q==;
X-CSE-ConnectionGUID: yYmUzR8KQaagre4Ln8pmRQ==
X-CSE-MsgGUID: 1z2UrZT1TC6Oma3O7cBzFg==
X-IronPort-AV: E=Sophos;i="6.15,303,1739808000"; 
   d="scan'208";a="88657043"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2025 19:51:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogkrVSjowgtOjJNa7/owGdcGb8q+kIl5DeeoZX3c3sflMpxeD3DpjrZ6kncWEV96Ta4I/0WwASvAPxWeI0XWY+ReosADmfEgIaZqrV7xPGNaOlWYP9ED/M8rsBS3CvC2kThuy7N/NlY7u+KK18t44ASvgD0AAPBjcbBp++IsI1SBu0/oGSQSlWC9TKAH17BPMPVUC988zHUypTVSdVGjp/rL1y/TCvQZp0srJxUCtzAocgZ0lwDxtyKHIwUrrMbfzqcKUkiiqN/o9Bmoonj2ueL/jg8E1yl9ZKhh75WpXJv99aZToHU2dCTG1nO78R5FrPcw/kofdDs+L6LN9HbGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdB2l837oTpMQGPpMyvBPgzjSy8PM3BepSCBV0YSJu0=;
 b=AyfW15ZQP/gbSFpKIW9hI72pAHvRWTyfH7+l+ZVj5moYh8G4CND1RDMSMKI/LQB5QswX9d+jMcxwWjKloO6R08xqQBqAxNwVFC4Y9olsXqhdgpKqp3ri2pGXMeBL6zh0hHLZg0szFbZOA23kf41Tq/Z/wE7gqrH0F16tVkNI35f8Hx4OvtDNfD1XS5Zx8+MccLG8urMgsDUpQvTTHhn254WxIWYm0CWnpOOLfNIQNB3WFsGaJ6Oq6J5ZmpsuA0/ze45N3EJ19wu5VR82OJ09Q3C1J8cQ+laA0ssZbWUzMAHnMIykFKsmJo5U1Q5ExPpi2WlooyW7ehOSNx6Nz/i9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdB2l837oTpMQGPpMyvBPgzjSy8PM3BepSCBV0YSJu0=;
 b=kSe2eWmMwABYJkBNw4GRjVlds1PgrLSic3N3xtGfTrvK3wYTh4wqWy3CpdrrYK2Qkb8kKEg18shjhedZurkSK1h2F1bLMnm4k60B63F3c73Q0YIqp5tjppUthzOZcJjih1dSIKpxpeKUqdniMRz/LyCnB755mbv/keQBaVnIB4k=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB7524.namprd04.prod.outlook.com (2603:10b6:303:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 11:51:43 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 11:51:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [bug report] nvme/063 failure (tcp transport)
Thread-Topic: [bug report] nvme/063 failure (tcp transport)
Thread-Index: AQHbxl5rVv9Lmn0H9k2g6oqO9vi3LbPYKvgAgAAXfQCAAQNPAIACJskAgAGUJgA=
Date: Wed, 21 May 2025 11:51:42 +0000
Message-ID: <czrjrtn2q5srlg664xryrzhjifkuz57jip2qx4b7aagky57xpz@fertvxdzaknc>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
 <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
 <3ef6roj5exuktcobnailtjstndhnyyw264y7uwzhtuaaptst5n@gl6id4fhjhcu>
 <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
In-Reply-To: <f540dd31-75f6-4e1c-9bee-304530984610@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: 04a601d4-56ac-4f1a-42b9-08dd985ddaea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rMoOx7zIfm04aNQOtqoUlVg/iFPtCjbLrEBfnzO45blp59IUaJJGXOASfZCM?=
 =?us-ascii?Q?a47fvieTulEL+Y/sFK39cExbr194scrX+/uPN5asyfclB7MGiEZYLJ63Xzdd?=
 =?us-ascii?Q?dmHIISAiqlExXBiNKckyj1V8GRawmOgTreFY7nzOd6WoYz5KjkmLoSAzyPnp?=
 =?us-ascii?Q?3Hh5tLKyoLcnbfxpkpzmvXN1zS4EBSgM2ByNgXrqQ4vMbtQlsWBdgjUVok/E?=
 =?us-ascii?Q?PTc9V5cgobzQPp6eXzkb2Z2bVukZAyMTl0kCXXloDD8VpZkdI3owb88aqPUf?=
 =?us-ascii?Q?zfDDI7T+jQlqbb85N54w+gPayZ096ME0kDLwyxcrolUYr5QYX32fZqOPbGxR?=
 =?us-ascii?Q?c/NgnXHdSt78B+++TWHpdHYRk2vcsi1n5WHHUEy+JaKQXlRe6VTaY8s9S8fE?=
 =?us-ascii?Q?EbcePpQXGILk3QeUHutKkYY0KDI4OeBSLotNDa+Yu7+eCmmJDyTRNglaezPY?=
 =?us-ascii?Q?85fFXDUtvEpHB77i0gZ4ZtqtPp52QCk8jRKxjozZx/EphCsscE0CCanLZuxR?=
 =?us-ascii?Q?svcOEow9Mn2aWoZzvCdJ9B8TtKEEeMw/swcj94I/2WbR8gOQQQjkXa2y+upK?=
 =?us-ascii?Q?uu9bvdrCUUCsuBhjti5nIZPW/B0PezGvo7JDlewEnGMZpadjUKFiXs2Evkhs?=
 =?us-ascii?Q?nK0evmmZnsRkPTgbyI009LmZeWDQZ74PFBzYr7dcqH7uqB6A1zRJPHPoNH+d?=
 =?us-ascii?Q?PRcwbcvRQqgScLeEVJlmo32mMHvf5VmMQ6pi72TiK3CGTPsRYdckHbtIClKA?=
 =?us-ascii?Q?T3doA0bqGK+GerFAmkMkzHoupuT3uooJYs59+KZYKi1zViuvbKrPtlqhbLdL?=
 =?us-ascii?Q?IXln849a1++6gcxgPyimXjGaEt4xY38HnKHKbVFVhcGVjTwHK6D7gtDzdWdp?=
 =?us-ascii?Q?WHKLl/8n9P667PZdsBN3qKm+d6zti9VQjhyxa6iv0rep2neLbM7Xa48AnJeI?=
 =?us-ascii?Q?cjtLrvGyHJo12KxRf7huGzZR///St7OrVhry/8jEVl30xZ7bSIF+KRocRu9l?=
 =?us-ascii?Q?yWzFdK35PqpMLb7RcYGxWEhzFWzdWvYx+vC37ANXVEUzTzLGBiYC32CCU1EV?=
 =?us-ascii?Q?9/8rq2jm3T/a0oWDhj9EbJ6zA7PVxFWRkVQrBS4lBgEKHJRH0iP4bRRHHWaE?=
 =?us-ascii?Q?bL4SQYZkm/F34BCDxUYKsvbzeEMdCZYlM0qqyPelfUAxlbAFXRcEH5jm+vOS?=
 =?us-ascii?Q?1Ehu0iKeOIRLu87mQCx0mirseoh4Gn+4+QftAmApF7Urb+5E0n2/DVNcg9T0?=
 =?us-ascii?Q?umj8PKqDGecA9SVA1ExIs4Xkg21yJ9qHhomeRZpZBZEZPsRi+mZq8LJmfATL?=
 =?us-ascii?Q?i6/ZhijOcP2SuYJ8PYh+Lx4nhJOB09k718MRNxFBZsM7jpid8Bl3WuyH0sTt?=
 =?us-ascii?Q?j8V2QqSv0/khelEJBIK5mVDiTFFVi8TSr9IDobh0+jsWo7dlxDPqzKrKQrFl?=
 =?us-ascii?Q?QCGgdaZPuGNfvAVqtrh5O6FtJ4JJ5nbhrcQR2EQlZHInbJQ/wqDJT7S3YYr2?=
 =?us-ascii?Q?MGlkzb7S2HixlcoXdArneLXIwFI7U8KilVr6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ackv5uiib2eDQ49nCaGcIGa2TFC+Jvq7oyJSSm6vw62xWIMzxBIbzVEhbazq?=
 =?us-ascii?Q?rAcCMfyczywxLzoZr62r+B11+tfyGdoMc1J4HCdkvg5/wwnqSvuIuKZ2MvT5?=
 =?us-ascii?Q?6RaZ7fqrVEFqY7AFFzCK0MQGmFZW565ZTveXyRjW9b7X3VUA2w2C5wZd2/Ht?=
 =?us-ascii?Q?rPIGuQCaqAotv0kkfnROqBpWp/xox94PWNnyevqJ3hiHXlSzhYw0IH2LGQow?=
 =?us-ascii?Q?QKcl0IUNtME7/+VQOzIYgQCVi5p4TgIT/M/8T2IJjTwVutEqaMu/i2Gbe7+J?=
 =?us-ascii?Q?ncMFF+kzGJG8zeWSHKMeGHNhBFVTJXhNOc8+cHuLxgax7BaXjMrNtONNqBUF?=
 =?us-ascii?Q?1532HDHn2RNR9qAn7bf0kG+XZ/t51oQisDRygd8wSMps9FhzYNN3y/+YepXM?=
 =?us-ascii?Q?12KrGhUadQk6BocuBbaAgIWZKSN96fGza4XgB6hhO7Lgl2eKs5/wgEy5hwSj?=
 =?us-ascii?Q?8bdnGYn2OLYlY3wdbXKasd2OmpvQ/5ck9VVPG3bX27r0MdWWOUW9RygOw7VY?=
 =?us-ascii?Q?Ymx+sLgKjzdXrROlPJ9GPYEI6bzsxP51JA+EKtIEsUrbTfkyDHoDrdOLVQ6g?=
 =?us-ascii?Q?4+IdKeUH2Z5267zQvWbPoHCVwNbzeXQc5rN9zmvVsO4s419m3zubspPkKpt5?=
 =?us-ascii?Q?tDbFmKsb7aSpIUSjD8fA/9m5WFlPt8QAH0gPKsaElM4RfIUju7IVYr1Xvn/1?=
 =?us-ascii?Q?8EN9Ir+QXZPoBantbdF376TuX+L1tgROsYCbknwxNkb/Uo58MCYTXCye0rTW?=
 =?us-ascii?Q?lbh+YJxp8COk6nuEPuHp0M/Fn/GVxuynPoYSzu9KF+wkkn8rmoyESt4nLCHa?=
 =?us-ascii?Q?6R35jD1FuIzaxFPFHavt/0dSbXcm+HuF5vAvWcRFt0mNcOisnINZjWzE46ej?=
 =?us-ascii?Q?zqRieu7ZBUGQb/F/i11XdEgrbUPKkjf0/vQyDQKii7bwz4a4A9u4mbig9t43?=
 =?us-ascii?Q?35Us/8mnfhttC/BSWjBb7Uglj7X1PxzDlju1Nm0IMsmi6Nys8MQbvdoY+RF+?=
 =?us-ascii?Q?7TF5X2jI/gYOZe/d3flBUlniVHih/UlffBWoDF2gi2yxboH7JsicfFFfi/bx?=
 =?us-ascii?Q?th2OuZu1FTOtQ/I2NvCxvgNrVZjgAJ2jplzJ7rlYhNCu8eM//cMy+zXgIybR?=
 =?us-ascii?Q?J4N0Ru51PGZ8b8zXEB5byxmOXisiAyLdpuYZwIiKR0FVbLydMuqidVxdRrXo?=
 =?us-ascii?Q?RRb+fMkTe/NjTbpBCLUqTyEbPw0bDmmaBgC9eTMGcmMNiz8A/kZiqpLNEl6V?=
 =?us-ascii?Q?3tLy9HoAMHqEfzowQhlUzFuOgzCluRq1ViAUGC+Gidic7m1xAAJol5ZRamgF?=
 =?us-ascii?Q?WppoPr1SzxaVS+jRwI3H5xY7Sxk+apvLVYrNXnFgK2n18aQQPCqeUrEe1LzC?=
 =?us-ascii?Q?IQDP4IO6Pt7O35/JYFjbABdZiXCVtEnWbQVfn0VR8O9cR9tIP83M7jPrKPOW?=
 =?us-ascii?Q?2c4c89klhSHe2KjA2QiWEf7bFoGBYUCgUoXHGcgMION+fZFlWx0di28CvDZ7?=
 =?us-ascii?Q?oMIu5vtdJyi3m03JmlC/hikWjmyyrsvVodwKSp1zi/+cerQFabdLdCgY8i4Q?=
 =?us-ascii?Q?q76/yHrj2/284RB9K7W9N6t/XwaCs2qZhGPsH30xQ6RWgXyuflXhdIEPuQ7Z?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3D8A6A0F141284C8DD415471A7B2F6E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MdrZMpzwOPvLIG1gHPXdaUImw9XER71iomErWTQ74r98AtFRzvy4QIM/inHz+2mLDjWzu9z+JpeND/lxE322idCF72L0JPk7eoeVJoAG+lFbuOVY8x56+Gah8+wmxJzKz3aXse+CZVwi0KW5PGwsG8SvBjGhUXbv11mJubNg3b6WA9wbAfTMqxxnK6tW1UTDyJ0z9ewF7qXBFUfEvOsdbyKDg+BqVNbhmBuWCC5sloa3QtHvi82Lgxo3DsosUftaileUJOi6eZX09g69v8JOP3hA4GxzNJXiKgcyZTsoDbdPHDYddX3pnPmoXiiQgTRzcJhHTPDnmKEZfFJcCT5CPO0tgmjttOwyt7evHGvBTwly+osl6IiY0jVZhlWw5ToIBVLC0YLpiTbo3b5OayKnstZBHW/40xSpfPItb5IeVyoB2cP8ExI0dr+NBQmwh2vfL6JKnXavuzrBWwtrijdeGt+B9evCPGkRrrysoGVv8YIHBMaS4InSDe3+WwaX+wtxS3eDUycO4IrPs/QWc26NcaZHtm85Bul9tkJfi07H0uvrmbjUtoqymsYCUCo1eBSCFianuxZ8yuCSGJjTiqJKulPYatM3sxTtI/jEIzg2ctR7YH64qkGS+lP/IpJ2x6/r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a601d4-56ac-4f1a-42b9-08dd985ddaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 11:51:42.8252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHFhc7iKvJS+z1h1KXYYjm9LU6Xd6L+kKK2Gyq5ndkTsWlaQRC9NUTliRDPaDCeYx9oqwr6S5L44+Uc9Mi1rOrjfaTAzdOK4npZQcAOrdyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7524

On May 20, 2025 / 13:45, Hannes Reinecke wrote:
...
> Hmm.
> Can you check with this patch (on top of the previous one):
>=20
>=20
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 55569eb7770b..43d86e8c6df3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2197,6 +2197,7 @@ static int nvme_tcp_configure_io_queues(struct
> nvme_ctrl *ctrl, bool new)
>                 blk_mq_update_nr_hw_queues(ctrl->tagset,
>                         ctrl->queue_count - 1);
>                 nvme_unfreeze(ctrl);
> +               nvme_quiesce_io_queues(ctrl);
>         }
>=20
>         /*

I applied the patch above on top of the previous patch, but the WARN
and the KASAN sauf were still observed...


But this patch gave me some hints that the nvme_quiesce_io_queues(ctrl) cou=
ld be
related. Based on it, I took a closer look. I found blk_mq_unquiesce_tagset=
() is
in the WARN call trace. I created a debug patch [2] to check how many queue=
s are
allocated for the target tag set in blk_mq_quiesce_tagset() and
blk_mq_unquiesce_tagset(). Also the patch leaves a log when blk_mq_alloc_di=
sk()
is called. With this debug patch, I took dmesg [3].

I interpreted the dmesg as follows. The number of queues allocated for the =
tag
set increases between blk_mq_quiesce_tagset() and blk_mq_unquiesce_tagset()
calls. Hence the WARN.

  ...
  [   44.459818] [   T1163] nvme nvme1: resetting controller
  [   44.460220] [     T13] blk_mq_quiesce_tagset: queues=3D1            ->=
 The tag set has one queue, and it is the quiesce target.
  ...
  [   44.472749] [     T12] nvme_alloc_ns: calling blk_mq_alloc_disk() -> A=
 new queue is allocated for the tag set.
...
  [   44.500687] [     T13] WARNING: CPU: 2 PID: 13 at block/blk-mq.c:330 b=
lk_mq_unquiesce_queue+0x8f/0xb0
  ...
  [   44.539174] [     T13] ---[ end trace 0000000000000000 ]---
  [   44.539967] [     T13] blk_mq_unquiesce_tagset: queues=3D2          ->=
 Two queues of the tag set are the unquiesce target. One of them was added =
afger the quiesce, then it causes the warn.


IIUC, this happens because of race between nvme scan and nvme reset. The te=
st
case creates and connects to a subsystem, then do nvme reset soon. The subs=
ystem
creation triggers nvme scan, which adds the queue to the tag set. In parall=
el,
the nvme reset ioctl context calls blk_mq_quiesce_tagset() and
blk_mq_unquiesce_tagset().

Based on this guess, I created a fix trial patch below. To avoid the race, =
it
flushes the nvme scan work before starting the nvme reset work. With this p=
atch,
the WARN disappeared (I repeated the test case 20 times to confirm it). Com=
ments
on this fix approach will be appreciated.

With this fix trial patch, the KASAN sauf is still observed. I guess it has
another cause and requires more debug work.


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index aba365f97cf6..d89c89570d11 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2533,6 +2533,9 @@ static void nvme_reset_ctrl_work(struct work_struct *=
work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
=20
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);





[2] debug patch

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2697db59109..d8d09eb9d2e0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -344,12 +344,15 @@ EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
+	int count =3D 0;
=20
 	mutex_lock(&set->tag_list_lock);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		count++;
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
+	printk("%s: queues=3D%d\n", __func__, count);
 	mutex_unlock(&set->tag_list_lock);
=20
 	blk_mq_wait_quiesce_done(set);
@@ -359,12 +362,15 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
 void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
+	int count =3D 0;
=20
 	mutex_lock(&set->tag_list_lock);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		count++;
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
+	printk("%s: queues=3D%d\n", __func__, count);
 	mutex_unlock(&set->tag_list_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6b04473c0ab7..2cf6ffb6e178 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3917,6 +3917,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, str=
uct nvme_ns_info *info)
 	    ctrl->ops->supports_pci_p2pdma(ctrl))
 		lim.features |=3D BLK_FEAT_PCI_P2PDMA;
=20
+	printk("%s: calling blk_mq_alloc_disk()", __func__);
 	disk =3D blk_mq_alloc_disk(ctrl->tagset, &lim, ns);
 	if (IS_ERR(disk))
 		goto out_free_ns;


[3]

[   44.040470] [   T1002] run blktests nvme/063 at 2025-05-21 19:44:31
[   44.146521] [   T1111] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   44.155990] [   T1112] nvmet: Allow non-TLS connections while TLS1.3 is =
enabled
[   44.162932] [   T1115] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   44.266116] [   T1126] nvme nvme1: failed to connect socket: -512
[   44.273193] [     T51] nvmet_tcp: failed to allocate queue, error -107
[   44.278519] [    T181] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   44.289935] [     T51] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[   44.290873] [   T1126] nvme nvme1: qid 0: authenticated
[   44.384515] [     T68] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   44.386596] [   T1126] nvme nvme1: creating 4 I/O queues.
[   44.404887] [   T1126] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   44.407213] [   T1126] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[   44.459818] [   T1163] nvme nvme1: resetting controller
[   44.460220] [     T13] blk_mq_quiesce_tagset: queues=3D1
[   44.464021] [    T181] nvmet: Created nvm controller 2 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   44.470700] [     T12] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[   44.471345] [     T13] nvme nvme1: qid 0: authenticated
[   44.472749] [     T12] nvme_alloc_ns: calling blk_mq_alloc_disk()
[   44.477396] [    T221] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   44.481052] [     T13] nvme nvme1: creating 4 I/O queues.
[   44.500307] [     T13] ------------[ cut here ]------------
[   44.500687] [     T13] WARNING: CPU: 2 PID: 13 at block/blk-mq.c:330 blk=
_mq_unquiesce_queue+0x8f/0xb0
[   44.501065] [     T13] Modules linked in: tls nvmet_tcp nvmet nvme_tcp n=
vme_fabrics nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet =
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pn=
et_virtio 9pnet netfs i2c_piix4 e1000 pcspkr i2c_smbus parport_pc parport f=
use loop dm_multipath nfnetlink vsock_loopback vmw_vsock_virtio_transport_c=
ommon vmw_vsock_vmci_transport vsock vmw_vmci zram bochs drm_client_lib drm=
_shmem_helper drm_kms_helper xfs nvme drm nvme_core sym53c8xx floppy nvme_k=
eyring nvme_auth scsi_transport_spi serio_raw ata_generic pata_acpi qemu_fw=
_cfg
[   44.503782] [     T13] CPU: 2 UID: 0 PID: 13 Comm: kworker/u16:1 Not tai=
nted 6.15.0-rc7+ #39 PREEMPT(voluntary)=20
[   44.504223] [     T13] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[   44.504673] [     T13] Workqueue: nvme-reset-wq nvme_reset_ctrl_work [nv=
me_tcp]
[   44.504990] [     T13] RIP: 0010:blk_mq_unquiesce_queue+0x8f/0xb0
[   44.505239] [     T13] Code: 01 48 89 de bf 09 00 00 00 e8 dd 92 fc ff 4=
8 89 ee 4c 89 e7 e8 b2 df 81 01 48 89 df be 01 00 00 00 5b 5d 41 5c e9 b1 f=
b ff ff <0f> 0b 5b 48 89 ee 4c 89 e7 5d 41 5c e9 90 df 81 01 e8 0b 1e 83 ff
[   44.506202] [     T13] RSP: 0018:ffff8881008efb50 EFLAGS: 00010046
[   44.506530] [     T13] RAX: 0000000000000000 RBX: ffff8881248209c0 RCX: =
ffffffff916b96e9
[   44.506913] [     T13] RDX: 0000000000000000 RSI: 0000000000000004 RDI: =
ffff888124820b10
[   44.507312] [     T13] RBP: 0000000000000246 R08: 0000000000000001 R09: =
ffffed102011df58
[   44.507763] [     T13] R10: 0000000000000003 R11: ffffffff912f666a R12: =
ffff888124820ad0
[   44.508843] [     T13] R13: ffff88810f138078 R14: ffff88810f138108 R15: =
ffff88810f138450
[   44.509918] [     T13] FS:  0000000000000000(0000) GS:ffff88841753d000(0=
000) knlGS:0000000000000000
[   44.511015] [     T13] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.511990] [     T13] CR2: 00007f957426bd70 CR3: 0000000136504000 CR4: =
00000000000006f0
[   44.513022] [     T13] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[   44.514086] [     T13] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: =
0000000000000400
[   44.515190] [     T13] Call Trace:
[   44.516014] [     T13]  <TASK>
[   44.516824] [     T13]  blk_mq_unquiesce_tagset+0xbc/0xe0
[   44.517689] [     T13]  nvme_tcp_setup_ctrl.cold+0x6f2/0xc89 [nvme_tcp]
[   44.518633] [     T13]  ? __pfx_nvme_tcp_setup_ctrl+0x10/0x10 [nvme_tcp]
[   44.519564] [     T13]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[   44.520454] [     T13]  ? nvme_change_ctrl_state+0x1a1/0x2e0 [nvme_core]
[   44.521408] [     T13]  nvme_reset_ctrl_work+0x1a1/0x250 [nvme_tcp]
[   44.522289] [     T13]  process_one_work+0x84f/0x1460
[   44.523157] [     T13]  ? __pfx_process_one_work+0x10/0x10
[   44.524012] [     T13]  ? assign_work+0x16c/0x240
[   44.524854] [     T13]  worker_thread+0x5ef/0xfd0
[   44.525660] [     T13]  ? __kthread_parkme+0xb4/0x200
[   44.526508] [     T13]  ? __pfx_worker_thread+0x10/0x10
[   44.527315] [     T13]  kthread+0x3b0/0x770
[   44.528110] [     T13]  ? __pfx_kthread+0x10/0x10
[   44.528882] [     T13]  ? ret_from_fork+0x17/0x70
[   44.529696] [     T13]  ? ret_from_fork+0x17/0x70
[   44.530451] [     T13]  ? _raw_spin_unlock_irq+0x24/0x50
[   44.531232] [     T13]  ? __pfx_kthread+0x10/0x10
[   44.531982] [     T13]  ret_from_fork+0x30/0x70
[   44.532734] [     T13]  ? __pfx_kthread+0x10/0x10
[   44.533464] [     T13]  ret_from_fork_asm+0x1a/0x30
[   44.534217] [     T13]  </TASK>
[   44.534848] [     T13] irq event stamp: 520990
[   44.535526] [     T13] hardirqs last  enabled at (520989): [<ffffffff93e=
98974>] _raw_spin_unlock_irq+0x24/0x50
[   44.536455] [     T13] hardirqs last disabled at (520990): [<ffffffff93e=
79f1d>] __schedule+0x2fad/0x5fa0
[   44.537356] [     T13] softirqs last  enabled at (520682): [<ffffffff915=
18119>] __irq_exit_rcu+0x109/0x210
[   44.538264] [     T13] softirqs last disabled at (520437): [<ffffffff915=
18119>] __irq_exit_rcu+0x109/0x210
[   44.539174] [     T13] ---[ end trace 0000000000000000 ]---
[   44.539967] [     T13] blk_mq_unquiesce_tagset: queues=3D2
[   44.546746] [     T13] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   44.567319] [   T1182] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[   44.569415] [   T1026] block nvme1n1: no available path - failing I/O
[   44.570557] [   T1026] block nvme1n1: no available path - failing I/O
[   44.571222] [   T1026] Buffer I/O error on dev nvme1n1, logical block 26=
2030, async page read
[   44.617517] [   T1182] blk_mq_quiesce_tagset: queues=3D1
[   44.620374] [   T1182] blk_mq_unquiesce_tagset: queues=3D1
[   44.887578] [    T180] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   44.904335] [     T48] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha384) dhgroup ffdhe3072
[   44.905297] [   T1195] nvme nvme1: qid 0: authenticated
[   44.908055] [   T1195] nvme nvme1: failed to connect socket: -512
[   44.915363] [     T51] nvmet_tcp: failed to allocate queue, error -107
[   44.920798] [    T180] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   44.935868] [     T51] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha384) dhgroup ffdhe3072
[   44.936914] [   T1195] nvme nvme1: qid 0: authenticated
[   44.977465] [    T180] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   44.980717] [   T1195] nvme nvme1: creating 4 I/O queues.
[   44.998589] [   T1195] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   45.001977] [   T1195] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[   45.083722] [   T1234] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[   47.457819] [     T13] nvme_alloc_ns: calling blk_mq_alloc_disk()
[   47.478144] [   T1234] blk_mq_quiesce_tagset: queues=3D1
[   47.483764] [   T1234] blk_mq_unquiesce_tagset: queues=3D1=
