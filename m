Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02024677A
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170209; cv=fail; b=m1Zt8JbXsVOjNQTRvxd4UFSoFNSjjjAo4pmV2vYX30DFqd0ebUwigZrXzrH+io/CpvolAw2+pjRXRtCtq0zLvuZyI57SioCN1m9EKCKw1NO6Ib7pmTBY4z7SPme7/6CrMnHDkz16Fc90zBiY7P8LBLGQRbMvMq3jvyRw33BBLEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170209; c=relaxed/simple;
	bh=lC/h4cqWDoHDLALXK4A4iv59WgRNzy2C/FWD3LUwJ+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kcW8fIpflpFcKRlXVR8M32hujKRTNjQZXNlhO3/h32yGWX5D7RtKtdwvIkQQB9s0j4+EFlCYTHXcrFMHvptBCgX98tnJXbUqXOY/i5kCqJ5To428oHrhVVtVYweY3zkQe+TVHTSfZzrceFyiEhu1eiGZYOy5LNKE2ZFJ29yvp3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NZPpJdph; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xVWO+XAw; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NZPpJdph";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xVWO+XAw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758170207; x=1789706207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lC/h4cqWDoHDLALXK4A4iv59WgRNzy2C/FWD3LUwJ+I=;
  b=NZPpJdphu9oW4zimz98vdIgoksTBjKqDUaRdNBPY2PvTW15OwuAhL9Pf
   izqU5VM8PoQERcdgADwFfJdVku+p51q1y6v0KKAcsPKwjksDR3VqFlDTC
   hxchZzqPaG9ZpOp5WGcctYpCunSTKw+LSy+exIhGtABDX7mkuIYjhnAx+
   2fIaaXUave96RmxxbuAFcwPLdzJWd/mDoQEkcUOZXb0NnXz1oD/00icdv
   +FW7K/h+HXaa0Iep/du6+Vsk0iVpqzjAUhHRYimztR5hMdv/eait6nRBX
   pHJrIDy/4InRR6SxYo1p1CXpl4RAscsd3u5NhyIEEQddp0IIK7Yrb83k9
   Q==;
X-CSE-ConnectionGUID: 7Hs+V2/wTEWPAkaEJhpc9g==
X-CSE-MsgGUID: bTgqy2FAQbu29i78FgpdWg==
X-IronPort-AV: E=Sophos;i="6.18,274,1751212800"; 
   d="scan'208";a="120434635"
Received: from mail-eastusazon11012038.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.38])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 12:36:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAMjjcwl0T+rRZkFQd+ZTK4iO3NuodH+O21dl6Jh6z4F44lJW5O1RUGf4h2/3UygzOts5LCy4xqZrTEcflwxEO2ifzjEtmLp4ylBFTDkENjjFHD8vHSpkTrnz0fqBIEOf3cFUAPNBLnX7HRrp4kZRCcm5Iht0UscEFhS//hsXbVmiMuPEGajHaUg1xQCZ1QRkNkV+07KjG8fnhlwCltKnzmQ/KFjDhmtZ8JXt7lvpu/mFRmPZZE1sPDWpteLvdJ66STzSf+/zfjYxBsqRAOZ8jLYDUJxASmaBZR1MraLVg/oJ3f2fQilCOL4f8DnZDm4fTnrIUlRSncL7i3niCg0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC/h4cqWDoHDLALXK4A4iv59WgRNzy2C/FWD3LUwJ+I=;
 b=JqXELifSDzpUaV5220CplH8Lbk8IPnB1HJVSOSIfz08ZC8DIEh6p66XTm7HZZrQQdPRxfY5hpw/G77T1lzw+/fgkYMtiVojMWyBoNhRggwWvUEMg5tPrReXP/LvjrpdprI58myXveeionAkSokChzX6Jw87H1swEg17iu2O1/0eaErJSh0DLggOVC+FlmC9qki1mz6Il/H1JoOn5xamESJpetsmYIOLFCMbNKUItHQcb57gBqCqTU30Wa+VKtaje4QgQZcOHvyzxUrTaSV6158djA49KbKrUuJrcmJ274JcRk2kvTDhV5YpERo4DTbxSd+uuDtnl8lXm7dWDnxXzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC/h4cqWDoHDLALXK4A4iv59WgRNzy2C/FWD3LUwJ+I=;
 b=xVWO+XAw4ZymxwBn6KuTHTcWmN3YZD+QYCBL0v6hwXpWrhQxbVeFd8vuNuW5fj1ic8U0GWLfl9uvZ6skSpLZFqIDT0QN0iJQpkCGsyP+1xDu4Kx7MBEKj6eW9+t6YbD7WwP/AbT3gcZ92JMFupMMNGCSPRf5OTfcTS2vew+jPQ8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB8474.namprd04.prod.outlook.com (2603:10b6:510:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 04:36:43 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 04:36:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/7] Further stacked device atomic writes testing
Thread-Topic: [PATCH blktests 0/7] Further stacked device atomic writes
 testing
Thread-Index:
 AQHcI8u2iSuhaaPAf0qUtMrB+Xji4LSVh9YAgAAXnYCAABqIgIAAB+oAgAABAICAAYtUgIAAE30AgAA1QoCAAM0ZAA==
Date: Thu, 18 Sep 2025 04:36:43 +0000
Message-ID: <zk2a2pficfjptjkjsx2wd6kxh5padaop7ge7n2georpofke4fr@lzdzzdmef7qu>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <5eri4pgxaqhd2mcdruzubylfjshfo5ktye55crqgizhvr34qm7@mhqili4zugg5>
 <39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com>
 <70d8a0c1-5000-4a3d-82c8-2ac7a76056e1@oracle.com>
 <vpds7n4kuilakmqajzmkeipkkbd3wpehuf2ku66wevq2dlfwnf@wxne2chta3ir>
 <78cddd6e-b953-4217-b6f6-deab7afc38e4@oracle.com>
 <gf3x3fisrgfdeqin2dbjhzxyf4ha5ek33jam3orike6tt76b4f@6ixrvnqmktyo>
 <0b6e3e32-81bc-4e3a-bff3-816089892882@oracle.com>
 <267b6d38-061d-4798-8af4-13ef5f0ac6ba@oracle.com>
In-Reply-To: <267b6d38-061d-4798-8af4-13ef5f0ac6ba@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB8474:EE_
x-ms-office365-filtering-correlation-id: d8960d7f-bb95-4a7f-8c6d-08ddf66cf7e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lQvlfhOef/8rQ924yGfznA3umqNLTfrPsnRxWDJ2A6jfrgtLz9TFdmiBWL31?=
 =?us-ascii?Q?80pj7Qfix8nYX52S8DWlnewAEIdoGM4rK9mmYJu6kCpVAI5Zt4E9u7DJpQGC?=
 =?us-ascii?Q?sTvorjZjKnPLarr6cSuEi18+lX0XzzHZByqkJjOD4vQ5ItjGjDDEikTIernI?=
 =?us-ascii?Q?aAC7+8rp6W+kPJD3JhKmJMX64w8Z3X2Y4XEdN8RsMsLPfRN8ExgeReLcFfGO?=
 =?us-ascii?Q?tp8JzYI8YyZNDxt+OtvwraYiH6RfjqXjP0EFxGVBZDnJv9wY3wMMWE700nFQ?=
 =?us-ascii?Q?1af0F1Wth4z1zr45sr+cdNouHtpH5pCZ1E1oVT9IGfZeTN01CHi0hb8NnAlO?=
 =?us-ascii?Q?cjRKXz4oq0vYqFVYpyYBX5mrETvz49x1Tw5e31HIRDBM1C9hAKOKpwRleZO7?=
 =?us-ascii?Q?SIIeiF5VwmAF7QCMoO7HJM46uph/vzM/6N0go0z5c+PBh2UAHdjJpDUlBr4J?=
 =?us-ascii?Q?pdxcwyFQjzpAijsKcyMDF2welfj9lJhxLwNuoAUvSFrSF5REGm3eF+dXN+mV?=
 =?us-ascii?Q?JxtX2iaKBKz7umH/z1Pr1/nR68x46n/zeWkH9SMejsVKR3k6Gms7HenQrELV?=
 =?us-ascii?Q?AVlLdok9NPGP59RkT8+YIriG0APThUoOoBuG4MuWHJ1JSbs9VPaaR2dwYEK/?=
 =?us-ascii?Q?2F/YXSbU3wtGgixEQcEFTOg8r2YtOol8p5nu63xfTPrgQYP6DlOjzGoPMFDq?=
 =?us-ascii?Q?sYCjiefidaLuriRvcQ6Ybu/4hS3c9LOHlw7xFn0KGOU2OGmjsWCHdAZCA4oi?=
 =?us-ascii?Q?wCcBlmQ6zOruYEr1gGTwj07nS+9uklM4lHHXHDyzt2ZXv7kFck8aW6/DRxlX?=
 =?us-ascii?Q?0UcntebAhsLOFl9sgggFWm4zNnqJYT7Vli5Myqxg+kaDEfeBXpjnKhgR6BSx?=
 =?us-ascii?Q?1pmeaK6GWP3iyWZFk/EOXW7W5tg/UekzJGdF5fNdVizW3F9EyEA19EZVoG/8?=
 =?us-ascii?Q?4WZ5MEX0trZUSgZvdzxTv6FiHABN5ECF94x/TwVDXkOtRzargoeGVX0hE90m?=
 =?us-ascii?Q?ODv8zxAOzgOrIZCH3f9SqnoRESAlS9Ka52LNKqqZzHvcxpw1DkQnCRAjbwCk?=
 =?us-ascii?Q?YP4+Yt+c8pNEFw6L4WQsVmP2nR4aYfjaZE0v6SrpjTdYKPttsrxmyLjTGdnM?=
 =?us-ascii?Q?H1CkZMnBXG2EwvvqKkBEiVAwyTMIf1xZXQNgf2MzoRPjLR9BelnZCzX7vVt+?=
 =?us-ascii?Q?kKEwnqn+M9879kelRPocbq3vacVeLiZt0xKX+ef1xmqfhEvj+EfigbVVBlGi?=
 =?us-ascii?Q?sgWyMRSSRY4JhTWldfmI3mbi86p0358K+uBMqwujblp/pWDMi5tjNjDr8t5n?=
 =?us-ascii?Q?Ykv2qRd8+0F68GLPDNn4g+dgOQt64o+T+o0/7RJyEeuV35U5OlUpd07eEy84?=
 =?us-ascii?Q?ypq/6E/JUlXSepjV1y+V8uCQnRl9RPOkZPkAzZIpSVA1dij+bdshzOaU0Wkt?=
 =?us-ascii?Q?nswmHotHLdQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?obvD9j5JgiZzo3dR0XRh+oc1U+yG3hv9N2MlxspvazEX0YrvKiAn1SRwlvum?=
 =?us-ascii?Q?FxD0RW6PNV9rCZ7feuzpu/jeiz4dRJxKkvx2a9wnlVwmcwtLnL8n+uKK95Yz?=
 =?us-ascii?Q?J0wVZlGkLJiSXEsN8fPzQap8wsxY9DvOs9D2mx4LpKryiKXRNBmuyCd11y6o?=
 =?us-ascii?Q?0fWyNa2thAOfrYvx098nkuA/1XJC+OYq+fuRHb8J78lmm7x+C0Z/SKnvJspe?=
 =?us-ascii?Q?j1uy9h3kFGUDI9nFmPp7izzI4CXRHtPnY7tO0NiShkW1JMnRZdhJBHhvA4Sc?=
 =?us-ascii?Q?iSMg59cvXrXvQuWtkgU0L0xvGPj1Ps/5A6cDV6AgyFl4NX/Mc3Qzfc8pvthD?=
 =?us-ascii?Q?iT5vskkrOG586VPLMRIPFqeMsg2UVQUpPYLt0RE9ehb/F5uMQuK2OIZQvtNA?=
 =?us-ascii?Q?r0hV4CS2pktlSTCDjoLi4UaHbvAKe3feHih846JwhnTJCSkYOmpE0uWRSDfa?=
 =?us-ascii?Q?+9uhE8nEZgmR+4+ZQC06g/U7Wqb+VcPw3F824ZROvp4ezxCbt3sffyPB/50d?=
 =?us-ascii?Q?Aqz+5yc0sxH/eVntICT4ldHuJYgE2bK9T5ZJV3VMcmo/3qJJvXNyuw3/Vfvg?=
 =?us-ascii?Q?5813gJI18qr4x1bZ8U+dan8+/CSKwuRY5GAXedqOKv+1482+/tK7H+fsK8wC?=
 =?us-ascii?Q?ooU1RFLfh5FrUaq5dCCoxS3NVf5AOhiqGS2PiC/IhLbnmWctTq7yS7gsT1Fp?=
 =?us-ascii?Q?aoq7Wq/KRfv5qyMROW3ewz+H5nIN6ARIwy7JN+9HQwmbr3gW0kAnCTpCmjhN?=
 =?us-ascii?Q?QsAh60d5amzZQMYvhixRM2NwTar47+asn/XPglCtqQHgesQ8KGCGL3Pb9Hzj?=
 =?us-ascii?Q?Q9v//gMa4vKpKxVxWRHAxswdahjMHz9rmCBVJra0mkQPr8Mt8UiZxwwTR7ic?=
 =?us-ascii?Q?uE3qbBlaJlBnisC6ixHcGtwVfZOUwgD8DcA5+OSALH96O7RqgLkfDzjyPduy?=
 =?us-ascii?Q?y68nb/AE06M1upze5SHrB33SVAuIh768VEJkhaBeSSBBdiyXwERcVYSzProL?=
 =?us-ascii?Q?fd/cD16KNbizVViOrfyMyE9MtiruBnOTkNJU2in2IqVz/yys3N5Idt/Vqjnb?=
 =?us-ascii?Q?93wppaLcWYvZ2NOvXyqf9c5U91ijg+A/raLNEyAcvyqi6qv48svy27N+nLsp?=
 =?us-ascii?Q?3vlsbJD3FQ8xiNJyFa+Ho8ZgvlaNu0ZB3onmi/J+YcfXZursfqmjMYAz644n?=
 =?us-ascii?Q?TmwjDA5mckfVyASMDz8bg4MWaEzn9aUP0PNPNmhl15i9he5vuiPIQVjHQ+sv?=
 =?us-ascii?Q?026/08Cz3QLWZXTjC/JkD0+tnnqJYBlUNp6uq2eQflpZfXIBRrgsfEJ/NX4y?=
 =?us-ascii?Q?OyHiqCBp6Az5zHXblUX1J/2TRBDIY/jHtNr05zc6oRUb0+t2ZPWHf0iAtW0N?=
 =?us-ascii?Q?O+HaULRFYYbxxa6+iCNqxfJTLJO1sv55Pgz0vCybpxm+vDGzvOT3v5d6QWj1?=
 =?us-ascii?Q?lq6Y04mspnkevF3tme6AsxfV+y7vW/C1HkgE+nsrhv0Ba5eHcP+1MHWNYhle?=
 =?us-ascii?Q?tTL2SM8P3d+Y/RwSlnjXMevHEhXEVbVdPfGLL0rKUpi3g85Z+R4WmrdKzmcq?=
 =?us-ascii?Q?+VHylJtf9OGzt4/Xoxm0ZrrG6h7RvIIReEHC7t05hLoqDPOuyQMP1jGgKMNO?=
 =?us-ascii?Q?1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3C1EB7AC138874A9AC0BE462E9ACB3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8b9ZQpgdw3/ERsEe3/Wd4NozqC+a1TOBDHokOyP7w2JkeoDqyHhagWFhDMSOa02lAIieLpbWLFkZYI2dQyabHOezFF48pGr0vO5KYWQ6I1GK7lQ4AzKOHs0QGUoktYgTFXJMv/Fn8/cZsdXJ/ANYb0rEMkv/jalJ9mKhGkqJrm8Zzs/0jM7HNdcBEZxP/eVW3THX1gFZ+dqWbkmClsy0glOBkHktWp7Y64RNrtKruQIlNRf9EOb/7HWR6AETvQKtdZtTZUHOzGN6Vg+IqaMtw0f9wdIeLkTV75QtlM/RQaYTKV6byN5kvKuDPfehLP7VH52TQiSyHWSosoQCmkV/FtHB4o+qk5yi9bGxfo1D5tKCfCxLhn2Xlt/rylw71rrlcLAiQCrFEv4t17Yl+Xv/ERRoRsqLuh9Cc9IiDR9nGhDlFTG+UVbd68V6jjB5a+dCaKUpmVdccloIX9jVqpiQAgXOH00KLjuiMy0R9GZIsx4UQX3vFkvUp+zlos/5gAFrm7CO5IaHjAcWsmwx5f8JbSXLl/MiLGBN6X0jNW5B/VT7JFr+or5A2ZjpF7cFVAVRDKkMAxvujTOm/sX9lg0wJefertyl6P3BWjjMwF7ubh2iChzVmk8Sx+Of/bOuzD1n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8960d7f-bb95-4a7f-8c6d-08ddf66cf7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 04:36:43.2149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xyS2YrRUpLLUsiz7ngo2Qj98z4GXo8GXIKR5BMyMJzykUe7DBiIOOzreb6lRSHPxSwMGRNEjZVyfekZdAfUfw9APUtIXqxynrkLKNp5aw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8474

On Sep 17, 2025 / 17:22, John Garry wrote:
> On 17/09/2025 14:12, John Garry wrote:
> > > It also has slightly different variables for use in the
> > > test_device_array()
> > > function: TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS. As an
> > > example, I made a
> > > quick commit on top of your patches [4].
> > >=20
> > > [4]https://urldefense.com/v3/__https://github.com/kawasaki/blktests/
> > > commit/
> > > fae0b3b617a19dab60610f50361bb0da6e0543ea__;!!ACWV5N9M2RV99hQ!
> > > NNGuj9SVoLIwKksQudWC5ktgS6vIXTX1dGSmibli2-httSpUBfSHAIL1i2z-
> > > aCmYSXUZxmwGZswO2KJ6Ei8gwmoYAPTl$
> > > I will review details of your patches tomorrow.
> >=20
> > great, thanks.
> >=20
> > I'll test md/002 and md/003 today with all these changes.
>=20
> I gave it a quick spin and it looks to work ok.

Good to hear, thanks.

>=20
> About TEST_CASE_DEV_ARRAY, is it scalable to index this per test case?

I'm not exactly sure what you mean with the word "scalable", but I guess
you worry about many config lines of TEST_CASE_DEV_ARRAY[X]=3DY for many te=
st
cases with test_device_array(). The series allows the keys X of
TEST_CASE_DEV_ARRAY can be regular expressions, I think many of the config
lines can be combined into single line when they use the same devices Y.

BTW, I made the detailed comments on your patches. Other than the comments
and the adaptations to the test_device_array(), the series looks good to me=
.
Thanks!=
