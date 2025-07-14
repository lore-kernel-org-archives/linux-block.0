Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC54E3FB1B
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492426; cv=fail; b=X2B8Cf9UxX/g+iTFdktRKDZV7xZtX2S+JlXBKSbFtCnBmRBFc5chq6OcswsoWU5VdNkNnQRF4MwtFfF9cWZtIroO1DB+AvjITe2iOuowZOWrg1cKROji6C4pxO+5H6Lqbq1EwQ/W1u1tvd3il0NNZyN755RM3G0AC8eIBFctiH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492426; c=relaxed/simple;
	bh=/YLTiySuZoRCq8f0qHAhOVirk3CcoNB1jEpTx87VMFc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtC26SiKGp1/pTs/TE1DLPXhDGzrRZHxVNLlu7YcyzvywZqvIk2NCPvOTtLUdkp+R+71CG1bVmMUtngc8/GAC2xY6W7QiBaN4fPFqWCSywK/2pz+TVxktMOh5FmnSMW69t1G3Y3zefEx7UyjbUyLZlfVLF8CgkbA7J4EdXGWHNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eVjKa3NF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WP8Wyejl; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eVjKa3NF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WP8Wyejl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752492424; x=1784028424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/YLTiySuZoRCq8f0qHAhOVirk3CcoNB1jEpTx87VMFc=;
  b=eVjKa3NFycEON0U48XKu/p/c+a0aREVlvcGxnxsSn+2P0LuNsVOChgVj
   rPbm0RHAb5dqhzK+WNO0CquQH0zFS+nZwaryWE5awPjQ2huLaftB9Nijn
   xJBoJuFNwjQNSl7+e5pTYLhOhyPUtQCj/zcO9KQZGdbixbqlU6V9QFpKC
   baO9arfOoHndLYGL0+ry9Mhjun4pQak8DVRYECOHB0zGf151VMZF5wEA5
   39Q/JIYm2Kv6mv95fCRNnkx4TikVkyesQXE9OD9uhNZ6UtJ4Gmw5x7jXl
   AvMfDQD/HfOhGbyAd67AAOnLixEstPbB+RJet6bWVYBxeT+1jZsgPMJFd
   w==;
X-CSE-ConnectionGUID: OQaZWabgSoqL4PXeNthCkA==
X-CSE-MsgGUID: v3E0gxEgS4WoHw30Sg3v8A==
X-IronPort-AV: E=Sophos;i="6.16,310,1744041600"; 
   d="scan'208";a="91745521"
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.61])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2025 19:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owyeUbl48+RjSKQh2ZYFRsNBAuz5AzzTG0OfIC7I71lFRhmiJdDGOuf/y5pVF01dWi+LOpy/S773+u2MsykRQ6tHsJ9PlEOckaAQ/lRBGjy13a3256XP2qogcYeHaw2bdsV+2vm1FwQU29LYJ5vLy2nsR3iYDrIuRdyxWSSTw0ypeHEurOFnAFgPIyTCppcPcto0uAY9J6I86dU8KA9LmGRxr3xREDulk2SdN6F4tHLe9hw3DsdfxU6FqStNNQQNhhOazmcOwhvRJ+JJpltC4PniEtZFne6y3tsVcjLGLRaKD5H8tz/kFAfKDTc37zNvQ1Ewfhanx3KE6cgwOS4OVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ696Sj7o8SjGS6F8IkZu4eL/xVhxHF7K4gpSln6Nck=;
 b=stYhjpspdp7J4cb/GGLOfy3sp/ARh9f04fZfxfvzGZIAwVF2mnN0mNSR2B+26mrBK2Gq44WFl/sPYBVfkONxITTv+3I6nOlgY/TUZapJG79S/Ep7vPuyvIZ+iJS0FeMsm0BbcPH2UO+ptvhdnVi3mZD3bCVNK6MpWustbM+0Xg25AiFP3GRuHDOwm6yyr+P9Xcba83iiEmfPL21ArOLcmYx/TVTC+cEg3IBo2hChKQGyy4rk6J56YQ8I9Vwl6u+1ihhLJtjlI/mwpzddMC+xqHNumhr5nFiRYurvZCPuRj7MmlHJZfvmZeErLh7UXJIGLaBGFvJTEq4ALsvToIw97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ696Sj7o8SjGS6F8IkZu4eL/xVhxHF7K4gpSln6Nck=;
 b=WP8WyejlZVfIMkR1IzfnBOwVgRkYzgbc2pqM9oUEnBXvV4N+MP3RRBa0Dr4WUTExjvmuSqQ9KsS89KKIYDsy3h/wqlNQIcIQ6dXgvbhBra29usLfGyM2MdQsk17I8XJR2teYpqgLmAjjG6QlfhYOV1mNYzUPJiG4a+4bV3vv1ys=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB8936.namprd04.prod.outlook.com (2603:10b6:408:18b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 11:27:00 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Mon, 14 Jul 2025
 11:27:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Daniel Wagner <dwagner@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Bart Van
 Assche <bvanassche@acm.org>, Gulam Mohamed <gulam.mohamed@oracle.com>
Subject: Re: [PATCH blktests] loop/010: drain udev events after test
Thread-Topic: [PATCH blktests] loop/010: drain udev events after test
Thread-Index: AQHb9I09toVb8pO2h0OhtfsAK1jtU7QxM2sAgAAA4gCAAENEgIAAAL+AgAADAwA=
Date: Mon, 14 Jul 2025 11:27:00 +0000
Message-ID: <iei24ox5inun3du7jhgmbronqsruntqgeqkrs5lpktqrjnbqz5@7sxyr2olkbur>
References: <20250714070214.259630-1-shinichiro.kawasaki@wdc.com>
 <auydt3njlbdh3ths3hzyiew46svwxxtd37dxzjbeyoqfk5n533@mpm2seuds26o>
 <ce654347-ec66-495d-a7e9-551bd6b4a002@flourine.local>
 <xzeoilk6746sjqejfzfbk4rue72jsunfga5te6ynipdgaks2u5@qkjsbwwworas>
 <e3a1a10a-1f1d-438a-bf55-2e26b4fb6c31@wdc.com>
In-Reply-To: <e3a1a10a-1f1d-438a-bf55-2e26b4fb6c31@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB8936:EE_
x-ms-office365-filtering-correlation-id: 4e5f5db9-1353-417c-a5a4-08ddc2c959cf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y8sVM8nUpFS4PqMT00RQ4m5Al5LbDzzWr68EA2Bc+wrya1wpdzcMcmVMvykl?=
 =?us-ascii?Q?dCCdwAFKmBxW6gpRcEIgbON+QGrIxEA3Mc2G8XNIySb5wqeY6cHMoWiJjpMQ?=
 =?us-ascii?Q?EQlOg+YgC0Ya/GFWE7PLMWZMCXnhX0SOKYWbwj2720ENGLzDzfxmqa1A+WB4?=
 =?us-ascii?Q?L5nysxOGTWzMxkr2fjiXS36L7YLvgywCdHRiPQdgQ4NiIvPQdt9XQ/jfYAXu?=
 =?us-ascii?Q?ju2iDz/bAp2iQAXGCeCT4slsvVVML3KJdRE7XLLlJzEWATOahjXmY+Ivsf1v?=
 =?us-ascii?Q?VzDH0Q432kSM/dB1MsBDKQiD905DHAjUvB9XmahJa6tHJSgQYKnZ9USE7qvA?=
 =?us-ascii?Q?O9VIrUHhVZ27bGe9ZTVIwpEUkD1y3NuYVrahrEjSZmSmvhf9RmPBuPjGMFhL?=
 =?us-ascii?Q?fnnBIHZ1GuZjmpwe1wJO4DSTAZqwa/MTpEx61Tljn+eZJW6vm+KBvmXP+ZZC?=
 =?us-ascii?Q?b5qsr8KcwS02fA6FDie/UXfGA1yeB0ra/FOwRhYMysfoNbE1XwO/S3Ecs17g?=
 =?us-ascii?Q?gaogeUgfeg/NOXH7KhExtq9mZHgD41EvMi4MWHrS8/UIBf3A4MOGWogXYJL7?=
 =?us-ascii?Q?os8y1jasPyQFXljj5eTYAswRc7946TJAUTp+qUogWBhWtLv3RL90X7FDqGV2?=
 =?us-ascii?Q?8OD4xw9Nf916ixJIph8NVVbWu1hwamwnna+8KJhtexIV4CQ+uEdlSUovXdPK?=
 =?us-ascii?Q?oyiUYhVv3Rv6n1q+qTqHwSg5eRRaK+vxvK5GaSc9uarctB531dcBoY+JxUvq?=
 =?us-ascii?Q?iHHTrkPx/4HDIMXkcIImpLlQ/kSny3c/mnWuax1mZHnZ33RmibjipGTYdoHy?=
 =?us-ascii?Q?bLPRrpmIPkefaGyXyljcmdpt8g1t5vIBy4f4QANF061ZRSNuSuJvf0yQf8AE?=
 =?us-ascii?Q?oslXt7i6fFl5ryTG8VyO3ETKmIEiXeDPwxzt8DXkd7j/DOM/OxJUvoFnIOyp?=
 =?us-ascii?Q?+p8DdFMgCDP3fMFcH+/EsASBi+pXyzwdLMq3bl1KMh1Ut3QKTY8mWrDEr9L4?=
 =?us-ascii?Q?Bv1GVVy/tcGf7bGmq4aTvflZM+MrCLZ/BrvvFtx2pmTX+k3Yqxh+/LrpjY5b?=
 =?us-ascii?Q?74BP9ogZBYZYqLEe2shxTEkZvJYi5sv+xR2/1QcO+3eF5PviZKyJm6ypjmRU?=
 =?us-ascii?Q?czB2xPQKKKELu6cx/wjYdqyT8ibz//ODSlN+Crmne0wWOawC/FXS/5OH5kpP?=
 =?us-ascii?Q?odYA7FFidoi9fhjysgCwsq+XaMDQ8060tdrgZALQdIsaORLyC/rUcc2IJzw0?=
 =?us-ascii?Q?deHD0G9W20Zzyi1eWKjk105RusGtq23kDX/JVnXWK9XOQaOFX3Yg2XFFsscC?=
 =?us-ascii?Q?Q+mURiJq8YUW6hiSX62sHTN+1bdRm+B9/AvvG4aYziyRpbyCDjDtKL07ZWZr?=
 =?us-ascii?Q?Re0mMR5+n3BQZyh1b30rlyTSmWXjaXHmk00+YeGIzuqixsyAHa8KUy6VS67w?=
 =?us-ascii?Q?QS8ryilLcbO/eGy8WMtFLF7WGP8zXdYFWksl1+MBQodXKvtxrfV70A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MxwZD9YTiK7nysLNH3O9Y1/lvCzW22pfTqcqFnyH4H9oGInvNuB+YAp8Q0mY?=
 =?us-ascii?Q?uMouGJ6gaCk3HKfcCuaM+CzKLdg8g9WwnUyz4otmtxkdPG3TlLCrESviFx6U?=
 =?us-ascii?Q?e2rYgbUuaA3VoQhoDcgxLCkv48f0epMDPwjWuzcisUie5N4ioOyD82o/opxa?=
 =?us-ascii?Q?Av/kmYjDa47OJ9up0fi3hy42CsDgjNWsQs7tNPHE0qm1trCEsttr0p6PMEOr?=
 =?us-ascii?Q?j/9dSGuPvVT5yb8DFlR3Rd0Q06/J/7vOzgWk42ROcL8WITlzlxH42oXaCkHQ?=
 =?us-ascii?Q?Ch0F+44Jw1lOUT4vJ6N8y5k0+qKCav854DT4SHQY/Kz9WKcHCPVJJ5fhd/Gm?=
 =?us-ascii?Q?vb60RQO3iwn4noiguoYFINPVESSnL/4S4bLLHV7Tgo/Je45lU1p93mgnf/MT?=
 =?us-ascii?Q?ekG7FqmgNhv3R1mg0EXKtlNaR7HI7e6TtzLKLliZQ6yQ4SRdy93f/jrqqKhz?=
 =?us-ascii?Q?W5B4RdOGFlMthk3Y4VdydaE0xwZGX/oal0E9GBuJrebKEPYPfspnsqT3E1r6?=
 =?us-ascii?Q?OGhVj4wMKfwBxoSBI0hbBzToCbcAdsVU5RcNjgMeluFJZpRnzaMuR72ov3FP?=
 =?us-ascii?Q?9y/VfHq0MMQmCpptR9zKf1GNyCWYQXsFrUFSJ0GjNqNtY9oHctIqesYCCa4y?=
 =?us-ascii?Q?m6BUr6jDukDMICtnUBd8nDRqp36zEEHNB/CfygDLlA0vevynQzyWNLRDlkrz?=
 =?us-ascii?Q?Nttc9TUznyth1CCkDryHDkanrOdz/wjIFCS1YIkqbi5UiOon6hGqmbw2WwPP?=
 =?us-ascii?Q?YxqIPikOzg2jSi87f+/xSmpagf87qSCcLcCHWhFnIfSqCZ8/EEeD6OoqInhn?=
 =?us-ascii?Q?/Gm4haaHbT28mkcnIBrR/zFbEpHGrvKS6Rfo4JDAD7fMtMYG2jufXO5kCmjf?=
 =?us-ascii?Q?KhHwetr2+QKueZu6oBTW9QGdWS60+SWJ8FmTylvxwPG5hiF5hA5qscJkyxwX?=
 =?us-ascii?Q?dqk/6qA8xPiTVwI6JGMGDJoRniYzkXrXzxj/+YjRaMbfYLrKGLGR1KHVL8jd?=
 =?us-ascii?Q?s0UIM8jDcW3eqtPZLW+IMLbnxwku3AY25MlcuI0yTJobEvQ+RrILTS4cpHtW?=
 =?us-ascii?Q?O5f0j9M7WjU6FIZqlvGy8FVBuNU41ea3eG73EXkq9j3g93k7YnZQIjzmiQXY?=
 =?us-ascii?Q?V4ukSqT+42jBzB0co0LSywoD1UDnh3dA/2oqBNn9HoIQd5uoT3kCiHRTMyp7?=
 =?us-ascii?Q?Y0mhHDj7jROyk+EHHnjmLFYPfE3TV/EAmS9AR+uTqrpvGmBkK7zJD8qiIFbD?=
 =?us-ascii?Q?23uWpsPV1V6/SlVZEgovn0StGS9Qn8LdsoBPQnZxAOOrtV1YpO1QUtraXCi6?=
 =?us-ascii?Q?dZW0nF5LlodlhRLegfn/+VRlXf+KkOuy2lpYmNrqLT3uVW9FyasijhQthUR8?=
 =?us-ascii?Q?M5Nz1BmUPQasbcdQ4QplBYKAVsgUdQYeoeL9V9IjCa6mf7R5BxI8yxEPzSF9?=
 =?us-ascii?Q?MVi3KaMf5x15eWMBY5tV0P8Hd/H9yRP/37DIffcXfey3ePyjxvhONMEkiQDS?=
 =?us-ascii?Q?lZKQVyTwzuuY61L23ygsH7DnTzbq7jHlJWpXOAoLr7HhvAc5n7Uv43Q6br9L?=
 =?us-ascii?Q?Rz4CHb/gCupIO2rXOHpTz36yUXma8a6DHPfCHFMwBOZKTUCjNiU2yohsR5uN?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED433B9A42BD7D4886ED8847EA969277@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Aroa/E0K6zpMqRPZXjfRBYj3jzvXSm1zVzgcJ9qh0qGgzwXTo1ZFTUkyTvF1y7jAd1CSFcNCk8KRsyMGrAe+eKvtySvEQjAedT5j7gcrBwlnR8Lny4YldqzPdRZ2z4RVMYSpMjvR4hhcHA4JJbG0+ksYh1+dNoR5AP812D0973ZLWlIIxFDYDt0OKMeKAv6VGuOiSyqT0knl/Qehlu+zLdTybRBi37wUdPP4MDB8OrNzFlicbs08t5xICmvuDkZVXxaH2r8Q35x2GbgY7XH6y83erXN0Q4aXUTgHmll0yAqgtGaPVJrMG4Bsdj6vWzRCQEHcQrsFLNnNcT0WrPIIG9yNrCIBB8xakKzaf6bU4pms6kdbLkpHOnG5xDOVuBf8SgUZPQvuPWC67VddaR0oWLtVPLkJNAIe0jXXzC0e5GQVX/pRrugbuOHRoaEtjLdcUTqwqd/B7HeiqQb7MV0Jxeco+9aeBVwXhjCwKhYJCSIEi3qEK4wQcsOfKJb5I1wkMV4mUTM9JOTPJlrTFrEP3szBUnG/T6y7boRiFMp4bfk4XO7p2xBbpMWUCUACAmXfv34sJnW3oTLzl/L6TL1nbsvxIpIB6UIQprwqwfbx98uvAcWQQWfj+kX80xe+cm2F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5f5db9-1353-417c-a5a4-08ddc2c959cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 11:27:00.7390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfOXQVkzHj7BGc6mjg/ppX8k9g2WN+JnWnRQVvSdVnkY7oFVhrPKgG3C0rYMATyBD3lSzwJb7aOPMPqExO2bScspTRYRwMC7+HqukmWxk94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8936

On Jul 14, 2025 / 11:16, Johannes Thumshirn wrote:
> On 14.07.25 13:14, Shinichiro Kawasaki wrote:
> > On Jul 14, 2025 / 09:12, Daniel Wagner wrote:
> >> On Mon, Jul 14, 2025 at 07:09:39AM +0000, Shinichiro Kawasaki wrote:
> >>>> --- a/tests/loop/010
> >>>> +++ b/tests/loop/010
> >>>> @@ -78,5 +78,12 @@ test() {
> >>>>   	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
> >>>>   		echo "Fail"
> >>>>   	fi
> >>>> +
> >>>> +	# The repeated loop device creation and deletions generated so man=
y udev
> >>>> +	# events. Drain the events to not influence following test cases.
> >>>> +	if systemctl is-active systemd-udevd.service >/dev/null; then
> >>>> +		systemctl restart systemd-udevd.service
> >>>> +	fi
> >>
> >> Maybe adding a warning if udev or a 'udevadm settle --timeout 900' wou=
ld
> >> good when they system is not using systemd.
> >=20
> > That sounds a good idea to make the test case more robust. I will add t=
he
> > helper function below to the v2 patch.
> >=20
> > _drain_udev_events() {
> >          if command -v systemctl &>/dev/null && grep --quiet systemd-ud=
evd < \
> >                                          <(systemctl list-unit-files); =
then
> >                  systemctl restart systemd-udevd.serbice
>=20
> Btw you have a typo here: serbice -> service

Oops, thanks for the catch.

And now I think,

   systemctl is-active --quiet systemd-udevd

is the better than,

   grep --quiet systemd-udevd < <(systemctl list-unit-files)

Will revise it.=
