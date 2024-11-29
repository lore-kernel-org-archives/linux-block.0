Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54355155753
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875646; cv=fail; b=VR2UCqWK7nFtqDBVnA453u5qCz+AvgFossIiKz4q1rV3iCm89BLYJHbrT+c52ljSOIx33nME/3/ooKV7Dyct0Mx30ByAmcOm3O06cHBRPBCtUojPGSaBmVFMfDIshEONoCiL0mMAexwB8L/VnsQ9JBJT2YRsRqlNUbs5lf71PfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875646; c=relaxed/simple;
	bh=YgxB+10zR2JiexxVtGafw8nRf1znwl6g9pBdEiRqAZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WA8c0TpVnhLnhXlWx51CCpY3bWQz2TGcW3fhxHrb2nM2Ao4bbzj7Sw62tMQK8RW+b6ni7MMm/Omlxp/ul6hpE5JR/zioGIGZ8tOoFXPBs8Ry0msw3lePnV78YbZWr+/0RkIfMY0tE1nGZfmr2JR5uXtFj4DZwqhPLmRi+YxneLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BJDuyRP8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u6UqcBXo; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BJDuyRP8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u6UqcBXo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732875644; x=1764411644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YgxB+10zR2JiexxVtGafw8nRf1znwl6g9pBdEiRqAZs=;
  b=BJDuyRP87nZGQ1SmzKzpDZ4LeZfGLHNTgr40IKOd2Xgshz2UC6LPpvpI
   JKUDx2oW8wmUpbDl7cuXzTb1PhGVkwyn25MvRxD2M+CCwLOm4bDWGSdDb
   CPjAsOMkV4DyaajooJo27LHeTpdJnYYdVcljizgfSLvu/Z7oC4SqcweKl
   abEGcFMiSxf9c65l+9I54g3wYRvm9qatc624qXg7QFbDtwzISgdmBibqe
   ztsXTHX4/cdPtOKU7IA9QmPcOpQB3Rfrj8hOqFcjFBp40M5c7hxezftu1
   KceOE65Iq8d3TABhXXLTIRACzKxOFcWC4YzM1Dp/QUqw5y7x3LqtcvG5S
   Q==;
X-CSE-ConnectionGUID: c657PXQITV2LZILukN6anQ==
X-CSE-MsgGUID: JkYmovEKQ7GRVBLPr4mS+Q==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="33712744"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 18:20:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKgA9aoXlZWrOAGmKiwkqXUrFuRr5YD6cb4tvLltqQ/3NMu0swqCm3bRZzwzBwWpgb5sGouTCzvTGlS3l6s41RG96+vIXh8NO5/SshWZRwHUw+YOBkQ/WiVeHk/44nmHdqK/w6H9mwBlpThFrG/L2NfzpnwIYl2uuo3EGS9Lux9nkbc6yOeDES90tQm1zL5VvgIAMk+gBj23TaJ6kSscSMMZdM3WVkfLp17+EDnCqDilK+k3geKBC0RNvP23ooLOHPG+BoaMn0ttZ2td/1FNQ9ngi0YT8mEnygDivDOqENFKssl3bvMTliZg7XU84EelhDqmsq140abTWuL0v9oBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHsylfy8UocxVs+nXyrO9deKi0+NiFCUgYVTrEMKCOo=;
 b=cVeUzZCZPDK87y3W+tOb1MbAqv6ign24B3ObGxcej7zwNtl4YxE8avyIOKjC6Mrs9wK+49oncabsdYbVR4hjWxfrwzA6V3EmyyUskUvFBUmDFL4BfHu/ZJc9PQYJ//oxCuoEs3XjbJ7Y8RDVrBjcu4mU2dHpo8o/IgXcoXS5jrmEj8vyPwaM9hVbq7pA6QTVs07oBELd9s/UpvDcgdF7XAMup33lQ7ULRWQ/9L+Ipo17yd8mAXWue+6OQ61jeAeoe5C747ILSIGcWI0+AgrYbG2XZWx0W2VWFU0PG3jhaFG6SdBukODmK5thYGeX0/JFPPOSxIiV97NHPENj338qKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHsylfy8UocxVs+nXyrO9deKi0+NiFCUgYVTrEMKCOo=;
 b=u6UqcBXodbAMNFm5JEK8Nou38qA5Xu0anX4JgRTdzk1QnYDy6RoNknP1x0r4ENJAkJrN+mgPzMsVavUK2pBjairG3icjMiUT5OPnGdWZ2+bMwzzk7P2/leT0WW9rHwQ1aOltvTVZG1zqrAd7GDpZ7oAasGdCO6sRATYDr/KUh4Y=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8424.namprd04.prod.outlook.com (2603:10b6:a03:3de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 10:20:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 10:20:39 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Aurelien Aptel <aaptel@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Daniel Wagner <dwagner@suse.de>, Shai Malin
	<smalin@nvidia.com>
Subject: Re: [PATCH blktests v4 5/5] nvme/055: add test for nvme-tcp zero-copy
 offload
Thread-Topic: [PATCH blktests v4 5/5] nvme/055: add test for nvme-tcp
 zero-copy offload
Thread-Index: AQHbQENiKiQJ8UDoe06XnqNZWI9y+bLOECQA
Date: Fri, 29 Nov 2024 10:20:39 +0000
Message-ID: <5eqjhfwdxqiofyabkzon6qhcjwgpr7sqz3smlchorskyf7xoxh@t3j7og24ggdh>
References: <20241126203857.27210-1-aaptel@nvidia.com>
 <20241126203857.27210-6-aaptel@nvidia.com>
In-Reply-To: <20241126203857.27210-6-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8424:EE_
x-ms-office365-filtering-correlation-id: f8e7d5b3-5c12-437c-c023-08dd105f78ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G53Pncoj07GhOBn9aE51Rijlb74bNshGcA22Pm1ibGp4/qIwUwoPt/7pqqvL?=
 =?us-ascii?Q?i4U8RFr66QOjNZ5alEHBu1X5fByutOIqIVH+LyjUX5P4ExmrwwznWwnJhZOW?=
 =?us-ascii?Q?/ZKPsKC2EJavngDuO8fC4yfaXmJQRAgt7A9i8yV6NMm+JBDiGxw02kF8xwsj?=
 =?us-ascii?Q?GP73x/lHU+DKq00e73Y0mO10VHixWaYPyJC+o80f2u1bboztuaZy7iiM+roB?=
 =?us-ascii?Q?GWZgIKUs0qskXmbnyDJ47Trmu98wacGLaTlh8GVds4yNKtDuTUSZbHjIJfj1?=
 =?us-ascii?Q?w+dvcJAdv/GAyxKtHnAQFa1DLZ79PvD4crj4h8VCaqnj2ivUyLOhc18Ttsms?=
 =?us-ascii?Q?MQPeLUlJbNwT/nWkOEQvwbVfmz78f4G8BiAx/1YgPs6S6himQ86FF+HqUJYz?=
 =?us-ascii?Q?3P6P/2aJcRbezULlOBaFpHp2i1wgmU+ZNTf0z+Q28fre2CwOtYEsYzfSe6nc?=
 =?us-ascii?Q?Wn6p+pZ6QEyCgsgW2FuOgbJ3Fxq9X/mDc1JpqglHhYcRTJI7qKDiifT2eu8f?=
 =?us-ascii?Q?ofxK9QLwUXVwyx9VX6nDQaKRSvYctv9e09IUjJIhtUE4X1irN5wIXUVc3vvF?=
 =?us-ascii?Q?gqOmVB9nhLqI/iv1npz57dEk+ClQI4WB/5tmnqmywsZNPOihLw/DfDaDd2t4?=
 =?us-ascii?Q?ELsi+UCy4wyEjXfmxJ2Psed6+D6LbUCm7S1XlXLtCX2Nc1eD9xPi60S7Obbu?=
 =?us-ascii?Q?MR7bQaxYOphw5nD4FH/fES5dHR2xB8PKD7wXXIwedk8zAZ31w6F9YWEVYIiE?=
 =?us-ascii?Q?3K2nngo/biVfZL4i2kAAkrnoJ9oxCMa75pyFA9ybaUrMm1RspELi5FqWbh7K?=
 =?us-ascii?Q?HYQQ5a12iFV4auX6p6++3wkM4422ikzmWUM01xWydFXe24+ctxNusRo4Bu0i?=
 =?us-ascii?Q?KJ8t9c9t5J76aaYdYiIMIKYMHGnM+2w4BgA7B49+1D6dv3W6FMTzapJChPSQ?=
 =?us-ascii?Q?dEJ5H1IpZvZQEFp8CK8Asl7uxhShp10Jx1oV4a/O1aHCOlqgn4sw3DvBunYa?=
 =?us-ascii?Q?gjF36rjlnb0il5yS4eoRpUjY3KD1Y9D/GfEC9zbGuPoOUk6t0ZG0t1R0XuHV?=
 =?us-ascii?Q?n51xa51OggdD/BATIXWeKPC6Pher5u+Jr6J1TnsqlBAHVesOZfqJPnM+UQsO?=
 =?us-ascii?Q?TBoFiv1QtK0PO9ibfhqojndJVMuM1zRlCPUanI+uq/bPx5oaJsOXKJHvILYp?=
 =?us-ascii?Q?ZyEBq5V8ZhMhLMDNJh1UBKax7jMb+GaBrc8w4WPNtaqervIeyS8LNUqbAg8J?=
 =?us-ascii?Q?265GMYjgFHCGR5MWZZkSFlftsva4BqZDi910bSIBSO/AjA0JZTb4XjpzGfof?=
 =?us-ascii?Q?Acer1INUxBw5e67AwcoGqA5erna2RUj1v8nInuDXsMYXXiDjVe2AdGxuxv26?=
 =?us-ascii?Q?AcOiB+rvqBILYU5TF02Q5BOaRhxCoT5hmWKcHZbm3OB/LJR64w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+ijAJ+JMZfkxX4Vd4iFiEZ3dwlQm10AIA1r/fQkUHjizNsqLkpcuM3r1kkSo?=
 =?us-ascii?Q?WRmTuaDAbszZ1qM68QxrvIUZRE1eNRxXjEsrsckFyzylocBgDmtGMFFg+Z4n?=
 =?us-ascii?Q?H8Qh+BO3GeT31xxPbNv7LBoryjEBgbdH+KznsJdrfZ0z7w3qZzwFUgrov+9N?=
 =?us-ascii?Q?EpSnjByWDkMTlZlMZE107el3YD96P6g5wKLih0XSZ968DpK8uhaetpavxZCJ?=
 =?us-ascii?Q?wONIeAc+OEkQjdeAYuF4XLwz2p+HkdWPQgO+R/OTKOzyg1TsZAZE7qXkeQN9?=
 =?us-ascii?Q?zI0u93CsjDAj2IKklwZ9MbX/mUc4RFUYgkgTljxxgowujG4h4UQTtpT8Ck4g?=
 =?us-ascii?Q?CYPjXYdJIT+/xJ+PQO2duO+dglKyZxijahFEwb+JqEcmN4AX5jh4NZqNNdJx?=
 =?us-ascii?Q?7VFo5hNWs5kCqdJ0g/PGT9hHYDbUOHdKD12YlYDKkGfjTvx9GKdedA22HA/g?=
 =?us-ascii?Q?A6M4h6RG+ejjAwZmcKlB267YlekZ84SU3sEGWyNG+0C8RvRVep4xlNx29f5u?=
 =?us-ascii?Q?Z3kUIOmmximNtj47+UVsqcFnHUTt54XMnkTfRPS/V5AAZn5wFCF6rYQPozQt?=
 =?us-ascii?Q?fPS11YwjcSSCYiiafnDk/pmpyWZysc7IkGf3aXH83P77b4KEFv3i1r9O5ojR?=
 =?us-ascii?Q?ZpjGGQtjAxHkJRu32u1r7I62nQct52Wgoh97Ha4OG0+cvMhsFLum+2JE3z8p?=
 =?us-ascii?Q?CbcKO0K2mCqwKnF763QwonWpo4mnKHA1m9wLGK33YTC3C/k536u5ytd+Gtdu?=
 =?us-ascii?Q?eH4fNvfCE5DdYkPctHqm2jo2qfLT4YFUJsCwd2UCtaefzs/Yt4YyE4P6d4YI?=
 =?us-ascii?Q?j/XMc+ToAEmJew1Y4JeL1rvnEf8AcHiR8ZvLtAXSPXdvS5etsWjn6C3rxOzf?=
 =?us-ascii?Q?Qbm3w6QSDf+Ci17ytkivJ7Ll8RSSuM8jUPoD6Z1297d7sHZjN8G35nVuaysN?=
 =?us-ascii?Q?6sznPGOQFTNSep6+m4gqdceJ3XS/ZpS9XK+o6Hr/KNCxurqyMTcIiYdMA4z+?=
 =?us-ascii?Q?tU4QMgIJ6ZF+KhwfI5oKyAM9m5zyt0QI//gRc9LZapBtUUTv3wywm0hEAyYz?=
 =?us-ascii?Q?ElBp/Ee63Pd+0K84SoeQHvMcYvtGs1uCRxIRGhXW2mlGBzhKZucn9NIEIVoi?=
 =?us-ascii?Q?fBEmZPlrHJS5kcss0iTPr8GbmZb3kVbQssfO7J9+oKRpCpq8+fpRZMZ8xb4y?=
 =?us-ascii?Q?SrjlzdpyCWdJT6dnVUw0hofQxVo4riZCSkNFSYbqZCgJyvu40BmKjh9XzVCP?=
 =?us-ascii?Q?wuBmWl0Jbwm2fOJjXX1XlqEsWaXQm3qyy0KGwqzyygyCJ0vGDjVFzKmI90W2?=
 =?us-ascii?Q?y7Kp4XzdzlANR9CDWIJdu4mIZ449ttTfE6IuR7XE6Ob+UIb+GrhAB27mPNuM?=
 =?us-ascii?Q?0m3hgzZqgm1hcVm3kRaz2/qYu+zJ39Ut4e25W2YjCbTZsLCLi44D1nBrBb8y?=
 =?us-ascii?Q?S+1x8u7XYquRowl5hJeLVJ+jrX8cjPbHYXMfflxCGeMYIWqppRMPHKQIltKa?=
 =?us-ascii?Q?xCKZMQeNczWHiqC4lB0uQTEjeNEB5T6IXghXvHNngJRPTbxKoI2eN/hbZy2r?=
 =?us-ascii?Q?P9a94zLPcxpsoTXf3MWm/GKuhLZ0TdHzjE8/w+tpFNHhH6TkcVEb/03HEUUq?=
 =?us-ascii?Q?aVrJVAC3C6W5AAXlLwi/x8c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB122BAFA3FEC040BBC4A5D6575A41C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QlEXzgpS/BniA6TSFNpKqFrML5mK9b/IxJ/Yy/rjSIqOM3eLejYIL5l3ELPSqUEHKUPWn6Sh2vvRr3R0UyBRRMp+5DlDmvlbCLHvsBeQi34hlhwAFD+ShMlrQOo3KDdok1MBj4cUhxVqavKPUZXRPDmTCRcjquK59JZwg//u6tXpeM155aZrqcoJpl0ouW4wer13d/vRhbTyeBSbfGl4YhYMQlvPyOu/Gqvv8PJqKgoaU3pIazuoUY4oix0DqsTRm4MqLbIUn42luJJr0KuEJEw96vdpdGUNFdoG5dcEu5rPQ5fNdt3Om8RFU1YuPNFN91/Kk9fKY8KCIeQy+h2uDltojeRbnhDLJeJUGRmvSBtjxd1ZjxBMe9Sy1EevGj4TY9D6PjfXZN+F1ka5jZjVcjEklYE/fc3Ted/AQzBdlwtpRTg+exarWEspUv/JEAXJgq7aeKGSHNG2hooDPJXAZh+9ZSELo3syVmqRX8X/IR3fSY+2aX7TCnVen7JoUUjwoi+OxlNpnjYAsRowFVL7HYHk1wGJh+ypCbiEchBE938n3MhhwO22hlb72tf7aAaKmNMe8gPAlWki1de2ABNQ7KNfLaFVWiHiBvRfyw6GFcNHYJgKZ4er4SZ7uDIXOP8R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e7d5b3-5c12-437c-c023-08dd105f78ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 10:20:39.1173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHmfunwbzxEVnICbri+FO4nQdqoT+mhV4bSYHp8qIhA7wLtnp93eLV81oFpXjM61j4MrIxkvD4B9Yhdpb+9yCVJjrmgMdw2lDpKf03nfWCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8424

On Nov 26, 2024 / 22:38, Aurelien Aptel wrote:
> This commit adds a new test for the kernel ULP DDP (Direct Data
> Placement) feature with NVMe-TCP.
>=20
> Configuration of DDP is per NIC and is done through a script in the
> kernel source. For this reason we add 2 new config vars:
> - KERNELSRC: path to the running kernel sources
> - NVME_IFACE: name of the network interface to configure the offload on
>=20
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Shai Malin smalin@nvidia.com
> Reviewed-by: Daniel Wagner <dwagner@suse.de>

This test is interesting!

[...]

> diff --git a/tests/nvme/055 b/tests/nvme/055
> new file mode 100755
> index 0000000..7e76126
> --- /dev/null
> +++ b/tests/nvme/055
> @@ -0,0 +1,285 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Aurelien Aptel <aaptel@nvidia.com>
> +#
> +# zero-copy offload

My understanding is that this test case requires the target set up by
NVME_TARGET_CONTROL. Is it beneficial to explain what kind of target set
up is required here?

Does this test case require specific hardware for nvme-tcp and zero-copy?
If so, it can be described here also, probably.

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION=3D"enable zero copy offload and run rw traffic"
> +TIMED=3D1
> +
> +iface_idx=3D""
> +
> +# these vars get updated after each call to connect_run_disconnect()
> +nb_packets=3D0
> +nb_bytes=3D0
> +nb_offload_packets=3D0
> +nb_offload_bytes=3D0
> +offload_bytes_ratio=3D0
> +offload_packets_ratio=3D0
> +
> +requires() {
> +	_nvme_requires
> +	_require_remote_nvme_target
> +	_require_nvme_trtype tcp
> +	_have_kernel_option ULP_DDP
> +	# require nvme-tcp as a module to be able to change the ddp_offload par=
am
> +	_have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload

I checked the latest kernel source code but could not find the ddp_offload
parameter. Do I miss anything? or Do you plan to post kernel patches for it=
?

> +	_have_fio
> +	_have_program ip
> +	_have_program ethtool
> +	_have_kernel_source && have_netlink_cli && _have_program python3
> +	have_iface
> +}
> +
[...]
> +
> +connect_run_disconnect() {
> +	local io_size
> +	local nvme_dev
> +	local nb_drop
> +	local drop_ratio
> +	local nb_resync
> +	local resync_ratio

Nit: some local variables misses declarations here: nb_packets,
nb_offload_packets, etc. It might be good to declare multiple variables
in one line, like "local nb_drop nb_resync nb_packets ..." to reduce number
of lines.
