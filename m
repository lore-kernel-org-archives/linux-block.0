Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2338172BD5
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349802; cv=fail; b=XKJbnlHfjf+j6uvXpHQ6lhvHEDmjA0Fyb6SI6KZaHSm/wGnvILQWZnpGpvNHNXSewC/as2j3TYo/DkkTlv93Dtx/EO9GaHY+fc8QqbSJqy0xFT5RoIRc7hiFMmYRfWqX41LCoFH62W8/8ZDQvpKyoOAz28rrfHQ68Twq2Cgog0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349802; c=relaxed/simple;
	bh=jN4NF2WXo2klQW0lCLyJ4JueXPqRvK6DHK4ypHAr7rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQGCCykSsFzoXmzA5hPTewCA6NfugvCQHgHyRGMMWnMDygTs5hJFIkNTWrJjhjYXDFDCOln2ss/VjW4p32TtJENzthm8NuKZU6oR/OCg78iaOyyTgJygDAvXzEz1CLxZdbRLoP9MP3SrNijLP6VfoYqZbdBAZ/Tfu+RNreuQ7QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jcaBLHqd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zvw+MdUW; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jcaBLHqd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zvw+MdUW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711349800; x=1742885800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jN4NF2WXo2klQW0lCLyJ4JueXPqRvK6DHK4ypHAr7rE=;
  b=jcaBLHqd2yFdYH2oaLNAR22e+kruhmBZ16iPfeW1Z94PP3HoQwo0z9SF
   b1RZmqRXQdACnBE7+adMD9knnDJWWUqriWrniNWY12RFbzq2Q8RyN+rF/
   rW9jn7VZviqFd7RK79448JuiaCbnXYQYvH2C9OKYwDnaop06x/EwMF8PP
   +KWt76TtULTrsztmOmLvv1QvWqzd9BQaIPfQ+bIo16lFJUUyfisOvoNOW
   fBjWFyj2SM/knMva+KYaOQBZtwxzxE7aK/DxAuqR6kzKkCKsheWHjyrqn
   LbgFzx3WnuaKhzcnSSf5rMzhoWVZzhx1RgPS9FsNHGjwk1KRVHgV4UezD
   A==;
X-CSE-ConnectionGUID: jxPacnARQzi6zhAx2oyDKQ==
X-CSE-MsgGUID: HzZFFZPORBWhzzlxqFrXCw==
X-IronPort-AV: E=Sophos;i="6.07,152,1708358400"; 
   d="scan'208";a="12626919"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2024 14:56:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/5QSAptQccDjQ2p4BYtXh3Q7npq/9DCs3SZnVEaehUW3zV0qwib/mZB25c+kCiQ0CH2NBlH21WJHlrjmmeWMZkiMNyjjEVetdmFUS8mnLzuEaNcPPgjw1yIMAGoeTBAwzbn7Jzbn9jUUzog5lrektQMPgepSXBU2B+YcLcRZxMrBdFtNDAE9Rk/0t/CyRLmTow+q6SYv29vq529O2maVavWskmMEeixPIgceT1UqX3YU1i3ek+JmNPsEFRSqfuiqhVSXDZxTmXm/wr8xz8+ERB51hEY+X5vUtPIGskfOH+AVFlVJ25KrRw8BYS2PZo0B4rB5r9RDMPwK4e6Fzdp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJ+tkUKleD21L/jWcqadOmpYaHYvCiyVTZeB9Vn1GUw=;
 b=bhXLzk4KYxU6cB1WZC79+AVtJJpAdXCGlaa4H7g52ZK3Dh1ijeHK5m2jwXqRP2+fTGRDy6PB8CndUcjuexE6UpUc8scy4CCUGAfaC2z1nGdDYnX0JPs3lyIVr8aD5ZAj19tdPu74U7TbpC5ENCzhJHzcbuCFZKyiFYBOx/y75M+68BpMOP7KhIgAUMBwq0jd/n1GWOnkztUGbrfLc0+7cxxj4+O2DyNurlK6wyeCSKkGhZCZPDIF86lBDBxLRIGV3AewD6b82X9Izw6l5SoSdLFXsrLAmZvTwLd1O/3HZMxqkznH+FL8Qgp3aIApe7+fX/mZm05qysMeyfMfNnSxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJ+tkUKleD21L/jWcqadOmpYaHYvCiyVTZeB9Vn1GUw=;
 b=zvw+MdUWQRgTjyxPwNKaOYmxs8EdHQkpd3xjuijH88taepBvNd01Jv7p+qs5rVB+aeXonpqIph4aPMszxD+irQO8zr/M15p0oEeXXTPPnOa/d4EWCXeq+cBSnB1W3BAy4AFaNUfZEWMUAxPr/mrC9L2jm6T44OBQTuT5vQlz/Hw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8617.namprd04.prod.outlook.com (2603:10b6:8:125::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Mon, 25 Mar 2024 06:56:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 06:56:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chao Yu <chao@kernel.org>
CC: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index:
 AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86AgAAQ4ICAAtxGAIAQ9nqAgAAi6wCAAE15gIAJLoeAgAFZQQCAAJQmAIAH7J0AgADqy4CAAA58AIAAQGuA
Date: Mon, 25 Mar 2024 06:56:36 +0000
Message-ID: <z2akreemu5xu5s4xj5lagbxzhsropp7ga7b2gvl3eook4hjshs@thrz3jcmk6um>
References:
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
 <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
 <f4f1cfac-8520-47a1-ad18-b9922aa0545d@kernel.org>
 <jpgro32y5r3mpyh24hoqnwkbcg67twbmcxeicoa5qt723u7ehk@4imddarhtt74>
 <cd11bff9-46cc-4148-9dcf-4087e1621985@kernel.org>
 <l7n5vbvpfmeutotnznxubhdr3migk5kpxgm6j5n265dnfgdtzo@iod4gcsfy5om>
 <bd72565c-052e-457a-ac08-7bf40077992c@kernel.org>
In-Reply-To: <bd72565c-052e-457a-ac08-7bf40077992c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8617:EE_
x-ms-office365-filtering-correlation-id: ebea1242-5002-4698-5a0f-08dc4c98b6c8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 17mnwoFu1t+WO/l4mWVRe1QxZFG59wxzqrP5pos07c6lUaYpijOqN/NEyrtS7h3Q+UelMP8EUa0qVMKvfbPhncZ7bPBpI9QxfYPLXSTIahCBIQBp3YyhOzcwxJBE+O0vEwAuVmWeRH+AI7VAql3NRtQu6xewhUVwRWNHOI8lT6t6E1wtfObelqZ0yyEuBIPgY2+vGYVEmKRYAwsr8UAqeL3EEPJRQTxIQsc/MzbbsVoC/PTUuTex55xY2lYEkXG05vobtQxnSH0ehItLZ78+jerYU1MaRXQVJHHvL29rE7MNfl4DQMEppiPP3KA5hZKjd+f2Udl6Y/wWidEx3HofEfQ9zGioPaLuxbo4kCoAr93SVvPWYhaEBkbnylMXK1MBIMjViPuluGz/k/C7HH3gGxG4YBsNVLILf1Ni1fK+i6wPZNJtwoem9OkB0xPOmgHBzADSaNQj+TpcwaV+rmpQ/7yKjL50d4HG9UpCq0ixZ/9nDaKEHpoLWzZi2LQsV3uYHeVDgh/fjp615lHXxQI/cWi9omWRi0j2AETjUjj2fle6hR7BVDNmBMcbPu7JipKZYeuSb8mJ9pzketrh+aTheoZCVzJ2BD4Fw/LjpYD1dioq0geZnA3WoWD+MTEXb0MKsw+m5toXiHwtxOGo4uZX6X/LPdiDkZOp1CXyGPYyKjzCqV3RxVp7cS/mN6vGoihjSWT0nGWGvkAtviyJv8RXeAY/E/edxuSlWKGldAfX5rU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dCC9X85TfIBdZKd/KlQwDyFdPw4feCkl2CJNARFvLasOvQwNjUkl14PQbqXL?=
 =?us-ascii?Q?Olv5KHxAfmSmGBHn92Ry0QBHIpFwFTAiSumq1spgNftbIUcIWN23cG1WwjYe?=
 =?us-ascii?Q?Pgph4JiObrxuN328huUr3SMEAITxbnzlT8jGBEhloAXq2IC0ebPUAbhuQh6g?=
 =?us-ascii?Q?ToBdw8m3hxXGM5fmt5HAHIuKX9IR/qpjKC15Xj39BHHlONOovLbZCp3MSIlJ?=
 =?us-ascii?Q?MtNzxpe4Ay14Y7TxgC3tsFVYSNPmrptEmHEjPqQdqkFT0XzK+Ta7slCgoUui?=
 =?us-ascii?Q?AdlZ/NXYH2TdVB3CE1OByW7RlfMqpx8rN1Ai1moG+yuuyLFe7mf0FovWk3bj?=
 =?us-ascii?Q?8SXo5hAHnR/uSq9HveLcMu8ue7OOFWlCSiH0lleZT2AYTZ0JNeM5leiPiG10?=
 =?us-ascii?Q?n12rW9ZWCyI2DYqZMrNvyd0iac7nWmSArqKBNIyVfbbSB2H4Ujmmr6cJs55m?=
 =?us-ascii?Q?IhS7hXlLmrw8+Sew818zW0xf+0Ay3tYm26XSNmmn3WcV7a6AcYBeqFtT9+Up?=
 =?us-ascii?Q?643oaWBYdJc8zZs089LD6ErynFSXyuuVbejeIAG5ZBzxtEjieeCt/z9LehH6?=
 =?us-ascii?Q?nO8ZEbbyOhzLYmMXRfmKTf0/9LjqRd0gz20Ztn4EoJX1sD9MH3CU/0ugIUGg?=
 =?us-ascii?Q?Gok2rhKX6ImXfMjfONa+32dhzU8FhuHDuDR0jBAQRLzOnpC4SAiqj3tH5ABF?=
 =?us-ascii?Q?U22GxxS2msA0wtyM4Lng7qqML+dxjhykI82fyi4M8Ls/eUNzZk4TnsCWVH+5?=
 =?us-ascii?Q?2coneb3S9KqkncccSlM1GzJnC7Y/rB3AH6kUdPvSL05ZoAUXeGCkFEw4AnuT?=
 =?us-ascii?Q?HGvCQjgaC1PvdLkW/kepuqDztcZ1dqo7DUc3+6gXTNovNXdkSnp5oH1ss7Qh?=
 =?us-ascii?Q?I0DhBWyEW/ZC1cGk0AOrFcY0exhHXp4NeazwokRwrmycWLbfaburjOz51vZS?=
 =?us-ascii?Q?DyOzh5pxTyB/WEEbCys1+P5ROoC1rv5QJlGYDYQfH+L2LVtJJ4G1ualj4mmH?=
 =?us-ascii?Q?E+ar7YYIKHhcFMbsfTGwYqJyn3KI1TwWYL4XhUWT8+Kn/+eCLmZXhaOZsGuL?=
 =?us-ascii?Q?ijbAMpFqb8cXYbwmtoBhj2A2jcrusI562erK/QPbc0jSQ8Vt3SaEoVV+Gfc2?=
 =?us-ascii?Q?E8mpOLzNUF1gaPp/JgwwDuprzsOpWucT7/t8oh8ikQ0NLdIPMqj/PrFSHHA4?=
 =?us-ascii?Q?Mkst0rXQ6AcoOdURnxNRQx138a3FeaPvnVswd3Ge+rBlmUy9AnXuer6rNwQN?=
 =?us-ascii?Q?Fv4EJiM4c+IOpZrQT8C6geKHWLPJexs9K+UP4ylFfaFXjizAVZXqPveNWgWF?=
 =?us-ascii?Q?IkdKq/uImkf8I0CMgHsTXEMho2TDD01vcUULjFhYA/VGcIZh046UdiFwIcYw?=
 =?us-ascii?Q?XVlnz7CodUIiA5JTffUYoEu1+qDrhzBY6pDiSfrmIHwPiI0x/4TVMXB4FqAc?=
 =?us-ascii?Q?QsiNynl9e9vLfK3HS6YhyDnTQ8hPOnimWHgN3/oSsdbVVXwAqtwZy12NO9UZ?=
 =?us-ascii?Q?jEtT/rtAk6LMvRrR+HxcUOrdjl2C4PrlKFO9NqzQSFGloCOsRuZY9w7OrgU8?=
 =?us-ascii?Q?Ni6zbLGXZVOQcpkcChqI3//6naHOe6jb0woYs2WM2RxgiZweP/r0lWRh35Z9?=
 =?us-ascii?Q?vrUgsoWFxcxSD3mA0Bk5xxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FCCB2658201FA438F7FF629B32A9A18@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8m8rO3EuuonWTzwzzHAiF75b3uDqsRtQaCDEN0cDqT0ifYpurqDJFsjPqQg/IPp/tBiixh99DfP3hrB64QfPF8WhZ+u/PVKNBZZH5rtKM/leUjKJEEMGyimRMOhAyFDvfBxtb8NgDAdlBkMmhXqVla3jrvUfSotVCr2zRSh8/J/j2db/VB7kjhiFfzxBkOj8ZtXh0DgvBEIQe07Gb2e1inCsLc4QfzvtnPcgRQxu2ZcvJXEwFwMdmqjhSB69epUpJpGzOwySXnqHXMu5bZchTDVUaSwYmxMR2uekNNddRriPSJeLdHHg6lNOzWeJXZBJwWLl+O0AcHqrUNQ/K7O+ff6AmyOvWZgMvI+xgNBQ+rVkIsKRQlpalqZ12ut7jkdoi+SFLTK+z+Xwpy4CBpB4FL9t6M22isT6PPvlj7m9QGxK5Ka07JyAPXLlp0iOUKl+zMecWZB/Ryq/fDSMcLMyLU90TQhWhOvDHTTBTmOHFbJuolwqpzx/WK/JFXFGsRET8AQyKAjBoOU0GIwH7XuroqWs68a1oIVgHNNVhu8YmbE7IIN6rCSC/sEWGLhf7w8v8a4nHCIfRjsC2hQDMrGm+49jJRwfwoz4x7QPiu1xg6tG7zmhnS+tqlbR2mXW2nRC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebea1242-5002-4698-5a0f-08dc4c98b6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 06:56:36.4893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +I56CUkzxr3SnthLr0Y38DWsh/8V9x1j+X9aeO4nsFbVSaIr4a2DXfDrXk3OLxIZ2opcVSdYkIovk/aawAjzzubAHUkiehDWLOXZcQ6vB5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8617

On Mar 25, 2024 / 11:06, Chao Yu wrote:
> On 2024/3/25 10:14, Shinichiro Kawasaki wrote:
> > On Mar 24, 2024 / 20:13, Chao Yu wrote:
> > ...
> > > Hi Shinichiro,
> > >=20
> > > Can you please check below diff? IIUC, for the case: f2fs_map_blocks(=
)
> > > returns zero blkaddr in non-primary device, which is a verified valid
> > > block address, we'd better to check m_flags & F2FS_MAP_MAPPED instead
> > > of map.m_pblk !=3D NULL_ADDR to decide whether tagging IOMAP_MAPPED f=
lag
> > > or not.
> > >=20
> > > ---
> > >   fs/f2fs/data.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 6f66e3e4221a..41a56d4298c8 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -4203,7 +4203,7 @@ static int f2fs_iomap_begin(struct inode *inode=
, loff_t offset, loff_t length,
> > >   	if (WARN_ON_ONCE(map.m_pblk =3D=3D COMPRESS_ADDR))
> > >   		return -EINVAL;
> > >=20
> > > -	if (map.m_pblk !=3D NULL_ADDR) {
> > > +	if (map.m_flags & F2FS_MAP_MAPPED) {
> > >   		iomap->length =3D blks_to_bytes(inode, map.m_len);
> > >   		iomap->type =3D IOMAP_MAPPED;
> > >   		iomap->flags |=3D IOMAP_F_MERGED;
> > >=20
> >=20
> > Thanks Chao, I confirmed that the diff above avoids the WARN and zbd/01=
0
> > failure. From that point of view, it looks good.
>=20
> Thank you for the confirmation. :)
>=20
> >=20
> > One thing I noticed is that the commit message of 8d3c1fa3fa5ea ("f2fs:
> > don't rely on F2FS_MAP_* in f2fs_iomap_begin") says that f2fs_map_block=
s()
> > might be setting F2FS_MAP_* flag on a hole, and that's why the commit
> > avoided the F2FS_MAP_MAPPED flag check. So I was not sure if it is the
> > right thing to reintroduce the flag check.
>=20
> I didn't see such logic in previous f2fs_map_blocks(, F2FS_GET_BLOCK_DIO)=
 codebase,
> I doubt it hits the same case: map.m_pblk is valid zero blkaddr which loc=
ates in
> the head of secondary device? What do you think?
>=20
> Quoted commit message from 8d3c1fa3fa5ea:
>=20
> When testing with a mixed zoned / convention device combination, there
> are regular but not 100% reproducible failures in xfstests generic/113
> where the __is_valid_data_blkaddr assert hits due to finding a hole.
>=20
> Previous code:
>=20
> -	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
> -		iomap->length =3D blks_to_bytes(inode, map.m_len);
> -		if (map.m_flags & F2FS_MAP_MAPPED) {
> -			iomap->type =3D IOMAP_MAPPED;
> -			iomap->flags |=3D IOMAP_F_MERGED;
> -		} else {
> -			iomap->type =3D IOMAP_UNWRITTEN;
> -		}
> -		if (WARN_ON_ONCE(!__is_valid_data_blkaddr(map.m_pblk)))
> -			return -EINVAL;

Hmm, I can agree with your guess. Let me add two more points:

1) The commit message says that the generic/113 failure was not 100% recrea=
ted.
   So it was difficult to confirm that the commit avoided the failure, prob=
ably.

2) I ran zbd/010 using the kernel just before the commit 8d3c1fa3fa5ea, and
   observed the WARN in the hunk you quoted above.

     WARNING: CPU: 1 PID: 1035 at fs/f2fs/data.c:4164 f2fs_iomap_begin+0x19=
e/0x1b0 [f2fs]

   So, it implies that the WARN observed xfstests generic/113 has same fail=
ure
   scenario as blktests zbd/010, probably.


Based on these guesses, I think your fix diff is reasonable. If you post it=
 as a
formal patch, feel free to add my:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
