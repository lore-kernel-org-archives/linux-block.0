Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77929B0
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732941154; cv=fail; b=Oa9YK21AkYwTBkcG5lbkori8KUz79PDqdM7CV9fJzCw/Xzn0/hYcR2BpIEPa/IIhBV11VVUeSyJ3wbFD4OQ7xLquYRJYjKhQrU2C8pzJjXKIclLWxwd0W0cLLVUPo+UcqOnSj1LPo4OtYgWjJ02S5sL5BrrqgM+sB5WMXna6sKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732941154; c=relaxed/simple;
	bh=lZ0uUAVxd6ZE1SkfMNZiwT9ynqaitqcrRfvBxdVRf8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CvbepN2b594Z2DEw1tvQkUxFasc9RXXGzUFfu+1NnoSqy3CPkF9HqrrbrA2QRNB90VGga+0GDtVQQVkB16RzlfvgFRdsjYVm43uFcZKoDHOJIKMn5P7AeAVn31dvqdpS9r2sTFR81HVLDol7uMMi2PbDb2UGi8FKyoDJi6a6QRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KfiWgC+r; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=W+rq7W8G; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KfiWgC+r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="W+rq7W8G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732941153; x=1764477153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lZ0uUAVxd6ZE1SkfMNZiwT9ynqaitqcrRfvBxdVRf8U=;
  b=KfiWgC+r5aFpiIyrJxbh0nFuLCumFapfttp3+O2JN83flk5/HW1YUaJC
   qwjK+Toi42vlCxyvOrHuXBDaJuaY7dKmAigsuPyIWRhZBPTWUprHS88+L
   fdrXgq0naJhJfDgQWmcjpD/ygPACkoYXO+RyjpP+7iNYhvgKRGMAePvZu
   LGlthrUe5X/E1TXk3ooZJGOoUOFj2p1mUmfsm61pL+dyB3uAArarj+OS8
   +7sjyRsQAqDILgSX0WQaNukObHiC/o5N5Sr59fJ8IRId9ispxRCXYBQ81
   6rYwKgya3lwenxJmz+g0zz0CgWmUHDCsI+A67S+tnQorIj3SArGnQcYrL
   g==;
X-CSE-ConnectionGUID: hD1S7LldQ/C56k+0J2ix3w==
X-CSE-MsgGUID: Pj3q1gWfTw6+xJ7BW/vWjg==
X-IronPort-AV: E=Sophos;i="6.12,197,1728921600"; 
   d="scan'208";a="32760734"
Received: from mail-westusazlp17010005.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.5])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2024 12:32:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbMuVRDzeDT0+jX5Y+HHQrckC8JpFRVDRkepMsjPqOrVmoX4cJaTGnedT1FjAhZa+mFUmHjBQcSlgIrGLVUfp8pcTiZ5SamACGkyJpolmnyvW6f5I8RyQu41wSAU9dWSga7kYQKJCtnu8ZZPaydFc3gSBMbfb1IaCL0JDPWaAXIZKWOqzWKki7s/0l+oyEf28jHS2UbHYJ68u1vwra+Uf8zrEI2yaLFP93DyU/ni90b42Qc3H/k0j8fDU45R2Mc1sTBpmG09bxLF/xnFNtVC1N2aWsPN68tggR0c5nyuPrzRBn0nf7WrErYAG4c6WSmauqzIM/2FC9kcOvRRJixVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX7X+fPsWs/be8QT9ABpsfwbrZyrYzOe3KlSlXnyT4E=;
 b=nrJVdUP2OK2GbiLT7oR18A06XpmD6xLtlEKphq9n9gFc3k6R72d0eaYjXiEm37FJgHX7HGldrjKDOeICghgibSBSH/XQDzlpSncd+h7Z756IG93BUZqjrDN8jaJHp8KPqLilFu144oXoQlNRU+4LYpLRjMEpg9dXkCLRoCdzT0otV3TedYtZOxXw91DZ+DFHGs7VnNoPLYQX6UDbsmZp3AexDIe0huC62hyZTk+zsa5F8OZK+VrgWKB14G3RlhXnZzd/vBq1f4rOlJp/fWJeLGy8tHJpPVnVbJtLvAgL5aNMQE0VwdNp1i9da/uNMs9eSfdEQdAhbht+Edh7tYplSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX7X+fPsWs/be8QT9ABpsfwbrZyrYzOe3KlSlXnyT4E=;
 b=W+rq7W8Gc1YMvrXSJPEhqwGGjrOcuQJoIgtXJEh0rOh7kwNDtj164WV8XkHnjxeE+bsA3dvet8pGOq+hCP1kTu0+IXxR7lfBw6h6RmbJVj9Fk51B/RFUKroAzaW1qta1VZRzLW+PnntmSofikQtMJF7w8sF4NZkVHyRNSvV6ILg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA6PR04MB9471.namprd04.prod.outlook.com (2603:10b6:806:443::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 04:32:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 04:32:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Frank Liang <xiliang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, Changhui Zhong <czhong@redhat.com>, Ming
 Lei <minlei@redhat.com>, Libing He <libhe@redhat.com>
Subject: Re: [PATCH blktests] block/35: enable io_uring if it is disabled
Thread-Topic: [PATCH blktests] block/35: enable io_uring if it is disabled
Thread-Index: AQHbQuDYp8OEfoAKz0ycAO1EWMPqEg==
Date: Sat, 30 Nov 2024 04:32:21 +0000
Message-ID: <ok2wvd7gkc5jileqw5bi5oz4ecs2dkwxu4vnrucit4ewj2pavo@f7jxdivpuuxe>
References:
 <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
In-Reply-To:
 <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA6PR04MB9471:EE_
x-ms-office365-filtering-correlation-id: 1285eafa-78d8-4fbd-f4f1-08dd10f7fb27
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7CSE6wJNptKtByHaUU6spVe0sNaaLuv9smJkmFW4t/uw/mXb8no9GwPtbiHf?=
 =?us-ascii?Q?UWAa4tpp1gN4F1uFKTYzHXSE2okFBWRA+QggvXyyjjZXqaCYe5p3NgHpyh3P?=
 =?us-ascii?Q?jde3F57hlL6exypCVg6qicawWkOkMdFiMBwMI/MIFpBMlt1PjPfLrq/ZzFbc?=
 =?us-ascii?Q?25eTmDz5FIKzNOw/zrEN+wnH2Dgv5FsyncL/93tli0bQ/lQQ+ePT/rTNE0vK?=
 =?us-ascii?Q?7ohfYPqnpj8aClOMSf/Uvxh7oJyJNMGjglv7YNqao6QFmJM85TReMnAshqVa?=
 =?us-ascii?Q?bxx5VL/fr8QJvmGxoSiQ2oRXaTX+zmDoXu8B33nvzxsG2Kj0Z0TZW3SkQPHO?=
 =?us-ascii?Q?zJwyF/1Fr6IMF86AQT0peLqC9bH/Mz0dHPl2lEEBsjaP8iiNzHgXyvTmd50t?=
 =?us-ascii?Q?igikJn0hpUzUPgk0pCEzabDZBhf+QfPyoo7JdQ0+Zrn3JGeh/UgECAvxrsL4?=
 =?us-ascii?Q?a7s72kiyxZ5Tz9suUIePSEByLD1a3TBWmyV19f6c324+nCT1K+CT1t3TibPf?=
 =?us-ascii?Q?xgLuk1YR5oJbz6Y+YOprWGXxjhHPuWfp9MqUut4beTTFhf1T/4xlAgmk2Dtc?=
 =?us-ascii?Q?izl67IYbM8EJMpUjjT/9TdWBQav65R3yXV2FaZaCjndkWhs1zL8Er9MVWPvX?=
 =?us-ascii?Q?u6vpxiLdhvsHujHuw2i2RogBcg3zPaw/JyXxjqtcbrgfXB87F8wR/3zAP44j?=
 =?us-ascii?Q?7PoVlJjzbozDsaLt1qYV+Hd9HyEU0yEAYpgmfkWkc4+sNiALXM/b/hGMOobO?=
 =?us-ascii?Q?QuGwYhSRThmepY9lYMWSY5itfXrF/qESSxFUbYrFcMrsMi1RDSx1rWpPu3NP?=
 =?us-ascii?Q?P1Y4asX8G/4aqEURtnfc6EBqj85JeW+TK3xCUBccn/hgMuStsAvUB0PFQKft?=
 =?us-ascii?Q?rZFIQhG66A6Rryq+GKbBqrNcUj+iS68ZXDefWRSKaTPGjQrhCJH62yFra6+H?=
 =?us-ascii?Q?mpw1kLbvCmbCBYBZgfzX6QYQ6ZFFbJ5GVMq4Pl2bmOFUZg/gk6K+C9mP2Ja/?=
 =?us-ascii?Q?+AWKvWWJYMswFMarC/k64JK1kWBVxvGGB7siUf03J9DzyAv8H8FSg5ZP8UFL?=
 =?us-ascii?Q?+pgCGx+Jn57xOtn/EAtwaCJt6rYTWR67fGe+Vf1Acrk4fUUcgt/BIwe/8eFc?=
 =?us-ascii?Q?LfevzugAc4nVesu8jRyRMozkFPGiQyeaMBMHwxUHNDp1mgBM9u8YJKWcY8AL?=
 =?us-ascii?Q?zg6IGu898UZZap/F2kE1pPEdNED6aSKFE+g9Gmt++TArmOi32jXc3Ywm099a?=
 =?us-ascii?Q?MDpbdZiR0DcCZ/5x56Stz7iidcGMEkFedtgOXOCc1/4Q8mCqyFphJCnzCXxB?=
 =?us-ascii?Q?7a9qmoDDzONzu4DXOKPIf5P/qJjS8e1WQKAr/RQIiWeJOPA8xrTsfZJx7Q0A?=
 =?us-ascii?Q?OwuWq5EOCpoJAEQveMu8TkJjYuPaKBbL5XU7n1gQmpFiCNBZPw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ugj2Ad5OxQaNFAJCCfjPHvXTpazdm5ktbVRKb5E5/Ce15lbkik7gDk7MPiCr?=
 =?us-ascii?Q?WIXVNSRr/kxzPXPZ6r2N9gCa1rmOmpF4UH/exijB6s1JzvVQSdB7bbjE6Rsj?=
 =?us-ascii?Q?MWyqgWMCWjM9dKRSkruSJ836B4kjR4XwI6zgI7hM1TXEUVePWqOuJG08IUhn?=
 =?us-ascii?Q?jtaicaH7WfxV46sqS+VfenmfWjpNMvt5IpsF2o7Tk6tRY1CadokRuUaSiA2K?=
 =?us-ascii?Q?0S3HeWd1/1H3OkKQt1pfzew6DLV+/jqUpQ7GAl+Ni6ZDkkrpWTfk1+Ecdcbd?=
 =?us-ascii?Q?Ssp8wNNNwGC4fY9W/pJyPIWBtO++eYb4Xi3xAc/S+LwpBnI8VUyJmrIGj+L+?=
 =?us-ascii?Q?fGxEsk+K9e9fRKfO7oibsImFIxkep1/LtxgrCC+Wzt35niqP1eJjxvejaOzI?=
 =?us-ascii?Q?ot0RauSagXW38kuRGTSfg6FVXtw4MH653lSky8+RYwRYvcBccDEUI+pwH4BK?=
 =?us-ascii?Q?yuq7BMrKKr3BJMm48A9fyOsF21HFn5muSWfyMlCR7pI1rLqvbH771etAwZ8o?=
 =?us-ascii?Q?2jOwUWxoj73IJoNeBgpP+6ahTbzOPsTnzSG0/VPixCQpLSoT8BFDdgXUdFbA?=
 =?us-ascii?Q?FzG1291/Yu6+bNxBwj55aB5uAm5RoqQ5jbsTuT9ooDk86HoR97DzkVUqK/aQ?=
 =?us-ascii?Q?fClHIVCB3qoQZjAm5teZSozO//T2i8T4RYpuXaYpbAfmElYOBoVj61Ru2Bys?=
 =?us-ascii?Q?LF/aYXrt6930RolE+q+qEqhnVgAF6Ws/JCjNk9vn2XolWb3jwo1KrPXk/wCz?=
 =?us-ascii?Q?ruGgKFsplhxgvmppZuzGnVoz0SXYzkHAc2mozwLHQrWdHN+xZIVLFQ6VDkek?=
 =?us-ascii?Q?vZgIoZy6TCbUUK5s/zZspFn0Pl8VVsNiSWDC1JTgodV2QfmJBfjSH7CZaL7Z?=
 =?us-ascii?Q?w3kmtu8cZgLFagjj7vvbrgl5bs/6pqZibCxxdWmftj034D28Nar/EKJ/Fcff?=
 =?us-ascii?Q?T87KwsT9sFB1Qk5HPRTYxQ9JKjgP7lVRq4/UqVH4vFWNviRRLk0r0Z1J+Tuy?=
 =?us-ascii?Q?EFjcHYFox7ocebaPaD48Rq0faFT2XEL3e3xKpTQyuNj/3IapE9YwH/KHj4x1?=
 =?us-ascii?Q?wAwXCQmTeEMmdwp8GMbRtS9y7zA+caii9COAUDgB/QARDCcRwvyhvZjKvoiA?=
 =?us-ascii?Q?bQ0UfBJAoUN2qRupfcSbyaHA0PKkqAquqxbkOO/ril/Iae0haPRc8AkX2fLc?=
 =?us-ascii?Q?QIJJON0/eB+73v8KApt2MIzApWrdgdVKF3vmIM6RFSmXeveBDPhZ2qtMMTpr?=
 =?us-ascii?Q?VjQ71I0VIRGyI8ZD9L0P9VyNO/CzjQ/mD5F4VTCsqc7O7KBdm66+AfONTdCK?=
 =?us-ascii?Q?NgeSlwtZkqQRKk7ce7N1AB+U1GH3vMY7zfJCHVdiiq6pHPkJltekM4E5dusT?=
 =?us-ascii?Q?pQ7EgA/TBfsLVI6I7RSRIKlTWp+XRFmO+4bWj3tsn1ycEyuuQ9yKUQzWgrov?=
 =?us-ascii?Q?A7k9pja09+h1ozG4vU8ytWMqnMuPNRBhfGjUSty/fXGq39jjn2XpZTqZ9duT?=
 =?us-ascii?Q?UDrNoJsf/7ZHoJ5lUtmph3pwpHiKf/4wZR2C56hp0BCE1JBcsJyaCY8fdLfg?=
 =?us-ascii?Q?7B9CMW1HKSMngAVlp3NRfZJ01fi53naX2YD2TsUUhFW/ZeARBIi3Tu3sYT89?=
 =?us-ascii?Q?1xWcmJpNnCdRJCeS4t2kxgw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB70FF6531D9014BA3492D0E0F3290F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LSHCY/p4VjPTazkjV9dwwl+FP7+sG8IBZf/NCoUFQC3aB0z/xijlIlPKoY0s5pY4z0LfFmcHFp6K6ZSMNxq/cF05JP2y1Ixu0pJ6e+yIViIwKV9QlTVZvNvrIu+SYqkDrZAMFbTqu71WoqyHe1vP9/DvEIoUq+GdbPJZlEDuaWNR1i3tkfFSM703csKUdWCXkiVfiug9xtZ2NmlUnRAmz/q34sX/zJzG34KV0DO4TkEdX788wcrlWn74HFPfF20is1uTvNZ6DBAgd3X/hGiK4oiKnrCd0DNkqYOAyA8mqKJ3amBV50BtNgUpqaP7MdC1lGe+4y+bMBK/18RMcCamdlWG0KOqaqTUeP0Jya0IxJpaC5WuNsDKnl6lfWEHJ+Y2naI0EwWc5xVA7w7tZNmSqTS3BKGP+Ra5bLeeeC/y88VT4Syx4ekrSpwwq8Kf9zFlbo+ls5fzj6YFrf6PsisqydhBJMo5FlO0EpifJOpELSIQNjXN9Gh4o0tbcZ4i4m2M3nfMb/oaQgUhurwLWYtcH3DxfXSPTgoaessD+pZidGNjQR56XjoiAtVfIsO23LBJMRea/XuGnhIVdFmIDE//ZV+BhAWeDonzZJcZ83W2xHtACcSeSmSLmtmQ3DbooYwQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285eafa-78d8-4fbd-f4f1-08dd10f7fb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2024 04:32:21.2988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyvz8q+U094ZRMpOgkzbxLwVPmiprXU9yraBoXx4bh8nqwspD2rwxmB3PCT2Xh8grh1+AF2CLrNzlJj1XHKCPhmozmAw3j84y3yPnU78FJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9471

Hello Frank, thank you for finding the issue and fixing it.

I have three comments on the patch:

- I think the io_uring_disabled proc file was introduced with the kernel ve=
rsion
  6.6. To care the kernels older than that, I suggest to check if the proc =
file
  exists or not before touching it.
- A few ShellCheck warnings to be addressed (SC2155, SC2086).
- Tab indent is preferred to space indent.

IOW, I suggest the change below on top of your patch. May I amend your path
with this change? Or if you like, you can send v2. Please let me know your
preference.

liff --git a/tests/block/035 b/tests/block/035
index f602e9a..8fcc9c6 100755
--- a/tests/block/035
+++ b/tests/block/035
@@ -56,9 +56,12 @@ test() {
 		return 1
 	fi
 	# enable io_uring when it is disabled
-	local io_uring_disabled=3D$(cat /proc/sys/kernel/io_uring_disabled)
-	if [ $io_uring_disabled !=3D 0 ]; then
-	    echo 0 > /proc/sys/kernel/io_uring_disabled
+	local io_uring_disabled=3D0
+	if [ -f /proc/sys/kernel/io_uring_disabled ]; then
+		io_uring_disabled=3D$(cat /proc/sys/kernel/io_uring_disabled)
+		if [ "$io_uring_disabled" !=3D 0 ]; then
+			echo 0 > /proc/sys/kernel/io_uring_disabled
+		fi
 	fi
 	local fio_output=3D${RESULTS_DIR}/block/fio-output-block-035.txt
 	fio --rw=3Drandwrite --ioengine=3Dio_uring --iodepth=3D64 \
@@ -72,8 +75,8 @@ test() {
 	rmdir /sys/kernel/config/nullb/nullb*
 	_exit_null_blk
 	# reset io_uring setting before exits test
-	if [ $io_uring_disabled !=3D 0 ]; then
-	    echo $io_uring_disabled > /proc/sys/kernel/io_uring_disabled
+	if [ "$io_uring_disabled" !=3D 0 ]; then
+		echo "$io_uring_disabled" > /proc/sys/kernel/io_uring_disabled
 	fi
 	if [ $fio_status !=3D 0 ]; then
 		echo "Failed (fio status =3D $fio_status)"=
