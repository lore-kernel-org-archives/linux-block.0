Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06BF8BF5
	for <linux-block@vger.kernel.org>; Mon, 25 Dec 2023 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S3YGKJH/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jlexM527"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1703485032; x=1735021032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zHage+e+Vz1JVV+X8rzaxwWk+g9hHGNlkqh1STuHiz8=;
  b=S3YGKJH/FehFdg5l8IoCZQn1trzug1+1HFm/DyBtrLoGIamw47WL7AFY
   VJcK+90U8VKo8yiaOv0tyL6GmsImx9Y0BEbLMAWwu7vaeh3S/+fygAUkU
   Rwzrn+uY6LoybaBs3O3rhS5kDK75qC+J2WSJHBZcC3OYpQFFNvipRD2SF
   ogj9aZ9/VziHZlnT0uJbD8DWpBuIo8WwbeNWSHNOzBjmN3pOFeLC04Vl/
   Kz15Z6s0ARaD1SYcUGLGo1Xd+Ygj+I7Ko+HQSogDQK2ePYGDa5dLoCXpL
   L2VBZOCyyOJddP3CgLb1S1O9JYQR7Sk8m31zSKKKFxnB2f6XP+E2wYfVi
   A==;
X-CSE-ConnectionGUID: 9CxWpC/LRGC3PWIPxcBSyA==
X-CSE-MsgGUID: mZokl01/REOCseJ/5qbfuw==
X-IronPort-AV: E=Sophos;i="6.04,302,1695657600"; 
   d="scan'208";a="5609710"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2023 14:17:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHMksTCpENm5UrJjmyKStSLzNLImsStzeToGwRsbJDvaX7L6ItujJqdeqe8m6M9t1fd6k4/7M/eNi5fxUSlV9tqNjFvhMy32pf3BUmzq17eWTUcaobOAmVBWEyC+PDXkUQMdvFO0SCVoxgITW4UaH2GcIFU/GU6F0S3VOmqspiqqvE0fMGpdPbFu4rSlzKHHfOHtFcbqm+Cxw+jROgvkJ4C8M30Nr93HmOpyJsTdj2mE1hJmgbG89WobBzy9pJridI7roF7iIX44irzh4PDZJ83qhkt0lx1rp8CZwxNqAmXRLFigLTKiuS0ZlrXuWh0Prl2Bg2m9uhM/S3cwkTUF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHage+e+Vz1JVV+X8rzaxwWk+g9hHGNlkqh1STuHiz8=;
 b=aru3+ytJabnPPZC7T4xm0g0AGUXYbYvvogLZTROVfh831MDv0F37cZVPLaRs1cmIgz9deodIKNwHGpgVjSE70NXe7xn9lootK6zWJkCPSfiGV5VdEbOXpjVVgAj0/qVK4R5BUpTgnwLfHbqn+gaJPb5+niXmS5OeV0/Sg+5EXGj4Zm8cifVr6ynIbCyirrv+PR9GB0iVkNmhh4cTyAiyAtrKlZoqnFtlz2nPkxvHe371XaZImMXVu+5By+2g6lNywq8+cOlyG9uI9oH12UmZaRonryb+N4MLzPrhN0mTkbqdxWk+tHkjxr663IqoPKy5WM384gkjOy7gkcoLfSsE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHage+e+Vz1JVV+X8rzaxwWk+g9hHGNlkqh1STuHiz8=;
 b=jlexM527eOU4mSUQbc6sMUnstQqB0Tt+Q2PWVzkkNlTSTXO5PPcNN3Ln0DE+IkA618C7Meqij1hLGZgWvL00Hs3C7+D/TQ57sNs4SfX9TF38+LCnq9wJRkPcSI/98smKokJ/znS+1IuSeJJ5BDAsd2ZULl9zDpZwnYzpfjGQkzQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7186.namprd04.prod.outlook.com (2603:10b6:303:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.26; Mon, 25 Dec 2023 06:17:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 06:17:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] block/007: skip hybrid polling tests when kernel
 does not support it
Thread-Topic: [PATCH blktests] block/007: skip hybrid polling tests when
 kernel does not support it
Thread-Index: AQHaLaDcZTlrbr0b2kGdWO2hHkOzHbC5mK4A
Date: Mon, 25 Dec 2023 06:17:01 +0000
Message-ID: <uxyh5wqxao5ib45fhz4rhz2mht53nggljhmytb24qxpjjfwp5g@ti2dsqjv5kns>
References: <20231213084619.811599-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231213084619.811599-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7186:EE_
x-ms-office365-filtering-correlation-id: a0606f1a-c127-423b-3088-08dc05111bdc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UI55vzjclvsyxFKXxEnI3qppXYwi5wNaeBIzWsysLidtRc7+04pe6aUow0S53HZ7gR33pFKjiXZEMbA2cMCXdp9p+4JjF//jjtDUNsFA6SJJKYFDShNqvcaruSws+MSGA7kx7BWCSigWkvWSW6mqx35OGqSL7pXIHuGfy8Rod/S88r8uHrzZDMo3Q/GY4LhCLNzhM9oQ4kLjVZMvrhfQQkA10jvchybhkWIwO77IkN2+Q0+7O86S1zFbUovzOtbN11mzS/5Imof5Y8gPOvIuc+/oZ5p5qFGyDgcX7YLsl8e/LIgV6+7oGLcnisrfc8wrwbJw/T+mRTm8js3YAA6KyQSXaxOcWMMH7t6YYFu11VozhcS1swM4A+AG//mOQoQxjQ1F4gIS3Fra/VUuCteOG05ldHaECRrx48Ht55Xx3NH19Yju5EsKQV5/LnbRLWxNtUbxd7CTVaDAflrI83j2KssKzmHHKpU/ARC2ET0eEhoEGob9o0qNGMXGHfufbDEKFBcT4+dzuW/kJThXOXMAk1mE+gXF/Rw1PlOaGWuE6qbqgTMZBLlyPJSle6spkParBHJc5Ou22t7NDBf3gMiRKt8EuchN1ImIsw3TePRej+nxsAyFTdgOQC+Ge6CGFEqo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(33716001)(41300700001)(122000001)(83380400001)(38070700009)(86362001)(38100700002)(82960400001)(44832011)(4326008)(8936002)(8676002)(6916009)(316002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(4744005)(2906002)(5660300002)(9686003)(6506007)(6512007)(26005)(71200400001)(6486002)(478600001)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vXZqnx+adiIN8TaNTBmS3Q2UxEBTxHBevIXFPVfaz3TRzJRZZXNNlvyLiVk4?=
 =?us-ascii?Q?oFM44KVb1Cp3dFUkhYgB3yNtXsIzUzenpclIjriGOkRitwPIQtw543y2tJ54?=
 =?us-ascii?Q?s7yYxW4OpJT9i5ikK0y8GFgJKtJ1zB8u4zuM911eb7eEH1YW2gzq8nc4x90j?=
 =?us-ascii?Q?AUGC4XowUF54o487LfawiUoMVSdnTsNurQzrPynpA8BfR8hGQ4woD+Ro17em?=
 =?us-ascii?Q?srCCx1JANZbs3wKpeVs7R9KMvr6jCmscOkOaUBW2mL9RY4JAtN5+rA3YFsur?=
 =?us-ascii?Q?v5TyqaHRFcDlQ/dprAX4L7o1fcDQSFMc8cwgb0EKy0IL7tLQ98HJL8BcFPo5?=
 =?us-ascii?Q?IijtP5J4E+Kf2Hk3+qoN/hfPR/nwO+ZMCTT0vUM5YgjzxhOEwYVu+Dna3y7H?=
 =?us-ascii?Q?2rdLnRFCBPZek83Y66qqS5BkvASs1Q7ETiaaW4h+AhDMqwO/ozzfC2D3khZA?=
 =?us-ascii?Q?x9tKDT4JLJSzd1bttAqIW98N37Ph2QKzd8sxUAH2Qhh9KKmNvwkMtX+zbsdL?=
 =?us-ascii?Q?W1jnyee0Zzna0jL3oj6ABxreCA3Eu6UJkRT+5St4zsV1c69uZvLk43JC+Yau?=
 =?us-ascii?Q?7YI0PpOy+H25rkfKBb+1biinD05rxEAgpaJMqC+NZOd9z2qHh1ZMpbKA/XhW?=
 =?us-ascii?Q?PoJm1h1t7YC+ffLUNOXIydXrX/uRaojxEDzC7tis72xHvTUHJjsKnVQJG2Yr?=
 =?us-ascii?Q?THZct7wSzf60GOJe9DKvuwXJntXqsITO6uIzBwUddo8RX86lqEoFZyekMb/6?=
 =?us-ascii?Q?5a3PmlvwgGQQCvIv5AedBw1cS0d0wT9tu8dVKWQbozTYfhNuhM4GCPGH9DHw?=
 =?us-ascii?Q?deiKClo+ngBHNmR/i3rGZDpp8040WwdZodLFve/I0Joqq9GeljZDy2jdP4+0?=
 =?us-ascii?Q?7EetqSGNHBVEnKEnqdaLDCPczPlsWMoCS2sZl99oKI6Xcl4NRLX9kUIbxisI?=
 =?us-ascii?Q?jN3oCDZzSrGFdcKBNnmDSR7F0mITILDY7QXqFt2v98h152upTuXre2jb8TIz?=
 =?us-ascii?Q?VDylQ2uUnQC30lo3mpYpvvQE+XFf4SKWngCEMild4HApK30/IcTbM9EhdlPZ?=
 =?us-ascii?Q?OzwnwlfE7wSO2ps0MID8ytod+3rhY1n7YUNpt7DGvMQnkJtCcJwxzT98RPtg?=
 =?us-ascii?Q?Kmvv6vozU4WrrUijMp+Qbldv0nupjt3C/2mF+8Sn6G6gKaOYrhxpAEejyQY+?=
 =?us-ascii?Q?k4F4J5Wqv016K2hBymth0Vg9EgdfLm2zOA98aRAUA1CjMBMioDulozFL63vK?=
 =?us-ascii?Q?zl+MGBbsKGl/PWDDZg+8UJNMtFykW4G6S4nNEejCGzeLVPuBazoKa1NuUEwu?=
 =?us-ascii?Q?OMVvmNMv/s/FpHT5D8LXnUXvn7INVDBbSgattJQP5PuhjsZ8uVPuQ9qapuJ1?=
 =?us-ascii?Q?kNsxMrZ0U6purBB2VBC4m2Yoi/QQcSOjcxdyBws1axUXUO6+XfcqU+V4xPmH?=
 =?us-ascii?Q?M3RhmDSpKn1i58+KdCm61pgB25inqRFQlisifdRyXHwAJlBAl6NQiNfHexcB?=
 =?us-ascii?Q?faB5kbsuyS8NI+ViACQoj3cR9rFxANBSn4MxhWi8/pYIOVCzlYt92XXcVtDs?=
 =?us-ascii?Q?ctJLpnuSoU30oD5wEDRXpFtNGHSthnGOlzvAnB3r+rozW4JxwZC0YDuyON8k?=
 =?us-ascii?Q?qxc6fvkr0C/SwRsmLo+vjoc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AFC492A3A1FB44CA9EAE8DC45BD174B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	djg8aPtSqpDnWYjOVD7YKwLq+YNaUk/zPqTpHs80ZpmsJhAxZKYmvCrRvp48VQGYY68cLrPz4ixQmi5eLl8wjMxIZ59HNkzB49Hr9anXh9jR3G3SuygnjuhAk0MTnyHhAVwnC+gTNpbwz/1/+hLbYgiMCpxRCpeaB7EkdAAQWsxqe8ScbScAoBYYfs5xoXD+t34gYGT972XQ3neUIXyOEn6Igjug7OC5S/GykwPQykgEZyOrdJRrWI9TP1m1G22O23u2jSGMeaGYy/38+O7KBpadEhHRDKGVW+7DEjIphAnlCAPPwHl6e4biOuxIJihswvP0+SodAQ3Lz4PgB2HgMPFyMzljSQk6Ck2g/DMW6f6Sk4iSEAAgcjYA+GTynxAQYBonrItdNQuLYdrcmBIHpnUtdiHpgRSiWHBi67s2ceNg7nK1dvKml5473lApGAfghfXpJDEkNM/beXjLKbBG5XLOa3G5UqhVeokyNo/Iq0DEcp64DXAWv7QlxdlF5znZ4oPfzQwQm4r5hCTs/ZGGRAyQWUHiN/oqnQZ2UfZPKHRTun6X9XsJ/5vB7uoieasp2GBeGXRIqEvemiyRL/wJo2zYO7O5B/doUagQMFuEFDY0xWhrFHSi8TPpDQdxlk8j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0606f1a-c127-423b-3088-08dc05111bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 06:17:01.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uh0ExjEj3CpToxSXT8pxk1SD078kutcL19ibc0IK0cClXiWNnigVJg9nCI976SnY92jeRZgOvN8EkYg1D+JwxGJZKAL56WR6BkwIiQJAtWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7186

On Dec 13, 2023 / 17:46, Shin'ichiro Kawasaki wrote:
> Since the kernel commit 54bdd67d0f88 ("blk-mq: remove hybrid polling"),
> kernel does not support hybrid polling. The test case block/007
> specifies auto-hybrid and fixed-hybrid polling for testing. But it is
> confusing and meaningless when kernel does not support it. Check if
> kernel supports hybrid polling. If not, skip the hybrid polling tests.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, this patch has got applied.=
