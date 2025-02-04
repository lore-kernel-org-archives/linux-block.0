Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AD920B1EF
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670120; cv=fail; b=cchBDCz2pNEadQfpMKRE/7QRW2SjTNT0CeMW5jOKEMa/PtQLjjFCLJYeiJmkj6li6BSB0u72M1OwRWPaWArQHEgg2T5Ejd0aQeoETcc2Qovb/Z+IakGSlQjuCy5itG6ZA9nkwXxItO7PHkS941ba0fus+tu5PuFgwkLEYmAJw1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670120; c=relaxed/simple;
	bh=HUNwNM7bBUa72Q4xNBCAJ5b8VgnsSYeThyvmiHo25kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxglfTZXE95n+iHDqK7Wr77NsxGXHYvLnd89Q9RPl1SBajqlQP/DgltltrJbJKl1PwQSL4t14cR8TJfOvrbTYvsWBPAm9OWKv2jXKvV7TQttYgs7uwN1p6FUY0xcLNtXwvC1irRdvCivcgWNRRCcZrEe89Pqq059knEd0adxfz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UHq8roTs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HqCIN9um; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UHq8roTs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HqCIN9um"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738670118; x=1770206118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HUNwNM7bBUa72Q4xNBCAJ5b8VgnsSYeThyvmiHo25kk=;
  b=UHq8roTsaF48mNvF+LxRwan5Cq/CAq/PUvNVP+vRlSZmENx3EOX0p0r3
   bblbEtLYkh4RkUYPif+ow52hREo/mQ+sonjtNVCsTI3bujA0GaHjYSiIv
   3xS3RBcATyNrwaiStaSovvN9nJf8bou8+kiLyYxVYFbu7OuH/Gu7DahFZ
   CsyxC5tDZ1RlPT3XzxwAT8SIM6jjrqMo1w/ITRkZ8WRMEwOB3D1vz/NBE
   aW1dZyZyPA1HY5m6+zCmXYYqD1TzJ92E9OPhwZY1lkZLqiopaMNdd4UIz
   dLrKZWF/hKg34xyK40eHXiNZHTIIqxlWRRXwgWXIdt8/PJsu90aO6sT6S
   Q==;
X-CSE-ConnectionGUID: SqLXuz6nT0W8C1jNXuWt3g==
X-CSE-MsgGUID: bJf5xUWcSD6Tky8BSBfnDg==
X-IronPort-AV: E=Sophos;i="6.13,258,1732550400"; 
   d="scan'208";a="36939954"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2025 19:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfiRGU2tbsl2lMMuEAY31voxTKqBjJoB0Cd+P3c27KVr3u7r3ECBWWRPaMLFzNZh+tZPQzxdoUCsaDYKK6f1AgbgkJkDgwTMF94m8my+pSwF4sfH1yEoIS0Kefsmab06+yBZkhitCDa6MMr+HOa7o2MZZSkNgyzO411aUuaAFimfrSz69Heh4OPbYh4MPVsyTd4/3gxdSspefSDOPPHvrSTxiQ12NhSnvU5osm5jvBSADacY78hr+VpcsqfuEaRCBQdWdOr23a1Bt2Fka9G4BfzeuxESVQL30y7awzd9BPzCVcst58Fp+MBxXa6ALJO0JIm0vlDssHHC9vDO0mmFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz4xB2SMTS6nvcVCSA3n74JsIxJiU0KHCc64xVkpAZc=;
 b=AqCMITFtyQjN/YC0ovlMcly2c248QlHyaG9qAl7c0GqQQpGMuSSV4GVrUcUz8l9B9KVQ3BsYjCI5oPj6HcFaonaR3PEMRQRDcPsiMWVCqlmqXGUppTbDTL+EexjuIKspJZfFHCYsLMYm2M6Ylp6ZctXNDIU64lXsZFvM88JFoQPutxdPhk8PP4jaREyN+MNBX44L7BF1LdD4EZpYHoAqsGBwrQ2qdT434VWfhR3+W1eIq21N/NBq93tr00q04gOXG1h7aKt1xJ3wRhQx+yWT6p7S+BR3Glxqv0N0213vabrDX9m7A9Wslr1Nihc78qtHrVS/H9xZHuU6WbMKTPa/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz4xB2SMTS6nvcVCSA3n74JsIxJiU0KHCc64xVkpAZc=;
 b=HqCIN9umvKlL9CwJiTFnTnBdOaSHCquZS/9w4qLeKSho7qgZSeGGbvReHe/F/lBCk8DBmyLz7l30VMdtdd51qgBn4eYWqC8UZpy2jSOW/es8iX6RgLLSRrIWM8iMsKTmy6lCo+1aDEYkyicFrwZmrt/6NLkXnr05h8o3DZJO0Aw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6972.namprd04.prod.outlook.com (2603:10b6:5:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 11:55:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 11:55:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gjoyce@ibm.com" <gjoyce@ibm.com>, "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
Thread-Topic: [PATCH blktests] srp: skip test if scsi_transport_srp module is
 loaded and in use
Thread-Index: AQHbdNjIsQzSwc1JD06PJkVYYw0GIrM3DZqA
Date: Tue, 4 Feb 2025 11:55:15 +0000
Message-ID: <xcgbpthn7v3xpprcqyer7jvfgzlaavvm2i3kureaqc74df263h@vuv5a23bbocp>
References: <20250201184021.278437-1-nilay@linux.ibm.com>
In-Reply-To: <20250201184021.278437-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6972:EE_
x-ms-office365-filtering-correlation-id: c9b6b75a-c665-474f-1c56-08dd4512c9bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Vn+pvrdeqtjegacuhGA92a1GIA0ketipx9lmsthINJd39AVawPvtxMucH5yP?=
 =?us-ascii?Q?9mibDPRGyG6u9xJIGyl79dt8JcYGjxq4AAmBwi1pxzPBupGa9XbOOK8k25+B?=
 =?us-ascii?Q?ZTp086c6v8+pQ5fLyaYOXESU2vw6ZYU0zEdsDqBOGWOjDjV+9DMOko+FtCfo?=
 =?us-ascii?Q?gl4MyEqHPsG4pgJC/HKkZnfxer0vvrlEmC2TeGYyoazzYO5Hm/MROG55kGlN?=
 =?us-ascii?Q?yretJdsJuJow0KwRhmFMmmlq7twissiZrpAkhk9z+rGwY1nk9qZmxfgDoGYK?=
 =?us-ascii?Q?3uNYwXuOZSoC9xA+marF5GGVL8065AbTb03MNM6qNR+TLM7t07mpNusZ82cb?=
 =?us-ascii?Q?R6zR5GlXRQkhJBZ6Ih60EAgvBgzdbQqBKM0/wh9iwe2B/1xfqyWg1coCoupf?=
 =?us-ascii?Q?sVVX05/zR+ybOk2Foab1H21hbq2jQZEpx3BT3I68IpWZX936dowmPdKEZP0S?=
 =?us-ascii?Q?MclSITPduvNzwOUpaOjJGs7W21VNpUDzHt63eeW1FTiEkf76iUEKIALyK+Qi?=
 =?us-ascii?Q?jSDXw60p3xTnimjIn4pznmxM2qMMd2ChVfMcmLO/YV8nToWNnylZgCk2HAvH?=
 =?us-ascii?Q?0M+o8fqZqWsWBMh5jclloE4PXBmFAfMe0C5t4R1PHZGKMgYAqZ5/OTwOgX3Y?=
 =?us-ascii?Q?VL9jJm9O4tq+EJOi4O18EvcRovYRrmFwap9pYyxjUUkQNOuSXHZJH95t7LdJ?=
 =?us-ascii?Q?k/c1fBEe1hZ4/96JFkf/yhgCswFQe2bjItqxNpsZulYcYXzQiQiTo3pHXOWa?=
 =?us-ascii?Q?wk0Or8Dv+nk56hmuzXLoGgZo8PEWF0XM9dDUP4XenNGwCSK0AtS9nuCqIFIu?=
 =?us-ascii?Q?hzX31C2mTIKHhmoP1wbZcP5wDA09n9YBMXHo6jfpucDYOGHDDiNbee1EFQky?=
 =?us-ascii?Q?r3ZGK4bcXYuFTPAhcOKpz6R/uAquKM9KPPFjIsHYzJ1Dhz6B08O38XIFEl52?=
 =?us-ascii?Q?UM+ziEw475VVcQPPTKJeNh1zbX1OuJXb/SPR1BZpuJDb/fyaHmf6c1SntSOz?=
 =?us-ascii?Q?mYMTlzPJkiOGuIYycWNgIhVj2VBVLJgodiF7V3ChBgj7yRXR6fKjzhc/09O2?=
 =?us-ascii?Q?h/aRCeFplsq0h/5nQD2lp7VLcvTMv6QQxXJrvUkwzGRFKGqMSpDMiSzwVM7X?=
 =?us-ascii?Q?XP5JofqiLDKBClRHLQBFi4ChMMrcyHEsJ8RSB6MdLMJg3t9u/5e3wtJi/tsA?=
 =?us-ascii?Q?IcEExRxrLkcaHPo/nUjSnToWDePVGC1GD5mq5zfAfO8C2Kmgsr9yii7FVTH1?=
 =?us-ascii?Q?adDNyFuMKJQDd8FVvKqqjRCuRYl8OsE13TNBH+SYOGv9BfPvM/LPK28KJf0l?=
 =?us-ascii?Q?C7+Rn2wXo2xK4KFEC0j3LAsNeWNVuwNKrrb/uw+C4Ok0LoOUs3GxfxHcqd3c?=
 =?us-ascii?Q?sUMSEVp7TX/+8kpEEbaeNwY+wcUYMs7ei3YtAf2e2xxo5QtTOAg65XwS4MXe?=
 =?us-ascii?Q?Klxu7UAK219MdzjcePMeXCNdZsuJJZN+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?os++WnDZmbU1czin1CrDr5AITLrtVrAFuFcPoJ4+vTsWiHog6g2JFxjcm4U+?=
 =?us-ascii?Q?sVEk6+hqC44ZPq0e+VW0aW9VuwKjTXcMPzJwc4lAwbqOEQe8U04DqDzAMWjX?=
 =?us-ascii?Q?+DvC+0jbv2fGlHP/f6RAzaRCed6dDtT4j8Bifp0H7l2+RuPDik8Kfog2ogUm?=
 =?us-ascii?Q?qPULFYqWj0dMLI/9uI1IMDJo0FbembqZNrGgDm7/9FCLJpfiLRPZiJel1S0z?=
 =?us-ascii?Q?4RoRQ2p1tzqv9qABrcl3aAJA76LcvUAbnn5H3o9tl3CHAVl9a7fZcFXaO/K4?=
 =?us-ascii?Q?lXNEijs3Qw9lQArBDgT1wTJWpG5TJVlb2bSp8cbN4OsF9fAqEdt2lsTbaxiu?=
 =?us-ascii?Q?hRF8kEBe5Jf0Y1xiVa/xd3SCn6PmfAul2zRWS1Ske/acK7/lUUxvtS1+jT6c?=
 =?us-ascii?Q?4iHui3ZBazGiy6DoSlZ24sl+ja+VR7edbnH/lIkEvko10zgh/B/Z/ZOTebx7?=
 =?us-ascii?Q?YC9Y7yMDw/d+CRNFvnUsn20zTYPwOgsDEHwJFFB6KEGuOeZiNbPCy+nppUK1?=
 =?us-ascii?Q?+zc8C0wOPgoW0dNRKXsFfLDb9n4wD7svovxnEblBowPxnEMv+xXh1Axxk5Wh?=
 =?us-ascii?Q?XwNPTpcsdzAeJVrzB+rv9DT3UuOQ4z/hyi2GxjqTtNZwzoUIT02Pz0KRM26R?=
 =?us-ascii?Q?m9iCwn5gsS02RUBhp1hgxxakbgOIKMFRHAXPUA2oh6k62GYJmZIT23yGW6kp?=
 =?us-ascii?Q?Q7QmqR6Q/fv2+6EK7QR2GvmpM1xP/0mVH9vYli5YC8QLEGx12zXpzKmbZqTj?=
 =?us-ascii?Q?5/t9uuclBjtHbDLY1ddk1+IVbX4w1XnFv+VmMLEJOYv0zlzz+znyBNBG2YDU?=
 =?us-ascii?Q?jREHV+vo4N06paaoOaXrhWTuPu2wvkMmf/OLEJjE0OIWvJfI8XTr7W7cD0Ph?=
 =?us-ascii?Q?3Z/De4h5pflF8WZ0Af1pDzL5vjnWbkJlBqh3B5NP+TA1R0ouPXtIXWzzFVP+?=
 =?us-ascii?Q?GVGdL5p8+OZDhKtZDUlGvhQffu9iUcNr67drA40wa2J2l47pTfhKsaSF11ns?=
 =?us-ascii?Q?kPbYlcXT0uypsu3Ibi95XwusM7MqG/9WMaWSNipHm0FNHLX4gG0WOZOnT+Rb?=
 =?us-ascii?Q?Pi/ai3FrtLOCaaUlKlJy62WWnjoAWJqUQ+rjhYQH/4CWVfHz246PfTFIlx/d?=
 =?us-ascii?Q?Qg48Cdtfz+SZDXZcF6tKiVsjFJdCtNW7rmLfqfVojp+nR7pJEB2gY4hYTYMn?=
 =?us-ascii?Q?yxFFLyjyoLbOXRiyxMApIN2iXBXDH3XyR1N1qLVyumkOlkKg1DMksdYO7j/p?=
 =?us-ascii?Q?YRZwhhOvlJTnK+r9U5SrlQZzcCPWhvy4Y9DMH5xUPs9YTh3VkSl0PmmFkK4f?=
 =?us-ascii?Q?gZSP2y2uRzsyGXkQ8UXRh4OUniTo3PwscmgYGyt6ZE4/JcI5EJ06W2rpOwpX?=
 =?us-ascii?Q?s2QouzhvOHFdyLP6NgxKH0ktqbiQCGV1qj8oBGdjWU5G7wvSahsdQiBSZcLp?=
 =?us-ascii?Q?J5cN/85SYkzt35eT2oCycAG+a+4c31ZFMXRqfvmU8eNtIoE1DGUuq3o6TyGc?=
 =?us-ascii?Q?ZexaUpGmsETKc2ZUqH/e1CNwpn6me1FVSDhuLEQvLY4KhnrctinEx2Pv60/O?=
 =?us-ascii?Q?49hdMMJwoXNONm8xU+OiYupe1I1gQ2bWPZnRKliZQ9posoRIMxo2xjv3Ji00?=
 =?us-ascii?Q?aTMdfDBJxgUegXdhTCD/2Wo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D563CA33BF01B14A8C12E6D718D472BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nIt2omBeGtsxVLh6LEiijxm6Zuxljs6qK0xGcbfPunP2JBiEMNZJps9z6RIDw3ik2pXe7fX7g2kaQU/U/zM6+ctvXrrx+5EDxuJ/NXZAFBB5n+Ue76l5tVkVgZED4HnQt0gUoezX+J8vIfk0HqTTNaE5T/XmvBn2/ubehkjFZ1YlpfU6AMzJPlIRKlbGCQRrLgPz4HElWMXWxOlxDtyZ6DTd6pv/O3ZRJuEeGovHPjSLug7EUm59x4yG6e8M4GRYTj9T2kUyNPcOMSTO2X7kZ5HhaanaY3upi1gWsuccbHS3vnzsdJygO7w74sO2fPjepg8hyPo+OO3QxbUrNsj5YqZJ5ZNRiZh7Iqo0KjfRNGgyyUkB/MINKhGJ9rldT/ZRzOQAVJ5vBgM7MxRbFBX1abWyPh/JNrua57N4OWREgDwvXZDJEvN6BSfnHtYVAPbThcwdlCRCisDZTefJdZcdElziXyl+t2ab3VfreRe6z9byQKNiN3DIVQ9/QEgAKyqQ0HS1d8khNdeIpCornWNOGmK5zUqGotXBaSDK0xs6/I15zqKAp0yr2My5O0osgpzhq0DgQZHETQObChA+L+HRsVvQwHMzpZgGsScpCMvhtC+aCO3BsJNtk0UwlnsITIlY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b6b75a-c665-474f-1c56-08dd4512c9bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 11:55:15.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCktejRku+mjii4AKuSESLhyRMVDnTjsL+OtgkEYjT3oH/OYJ293NZvs/zu1ehyZ+ZLlaKEghPAySqL4+kt2bb08/083d1Xlx9kys1ohT40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6972

CC+: Bart,

On Feb 02, 2025 / 00:10, Nilay Shroff wrote:
> The srp/* tests requires exclusive access to scsi_transport_srp
> module. Running srp/* tests would definitely fail if the test can't
> get exclusive access of scsi_transport_srp module as shown below:
>=20
> $ lsmod | grep scsi_transport_srp
> scsi_transport_srp    327680  1 ibmvscsi
>=20
> $ ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>     runtime    ...  0.249s
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Perm=
ission denied
> tests/srp/rc: line 263: /sys/class/srp_remote_ports/port-0:1/delete: Perm=
ission denied
> modprobe: FATAL: Module scsi_transport_srp is in use.
> error: Invalid argument
> error: Invalid argument
>=20
> So if the scsi_transport_srp module is loaded and in use then skip
> running srp/* tests.

Thanks. I think this is a good improvement.

>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  common/rc    | 11 +++++++++++
>  tests/srp/rc |  1 +
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/common/rc b/common/rc
> index bcb215d..73e0b9a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -78,6 +78,17 @@ _have_module() {
>  	return 0
>  }
> =20
> +_have_module_not_in_use() {
> +       _have_module "$1" || return
> +
> +       if [ -d "/sys/module/$1" ]; then
> +               refcnt=3D"$(cat /sys/module/$1/refcnt)"
> +               if [ "$refcnt" -ne "0" ]; then
> +                       SKIP_REASONS+=3D("module $1 is in use")
> +               fi
> +       fi
> +}

Spaces are used for indents. Please use tabs instead.

Nit: "refcnt" is not declared as a local variable. Let's declare it. Or, it
would be the better to avoid "refcnt". Instead, $(< /sys/module/$1/refcnt)
can be used as follows. Either way is fine for me.

       if [ -d "/sys/module/$1" ] && (($(</sys/module/"$1"/refcnt) !=3D 0))=
; then
               SKIP_REASONS+=3D("module $1 is in use")
       fi=
