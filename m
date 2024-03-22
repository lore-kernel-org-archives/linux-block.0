Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41536199AD
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098878; cv=fail; b=lAJg3xS7A8Ko8UO+LcKDrG4v+f+x26p0PneITqhOJst/Lq6/ZcHa6ar8XFnvwqd1zglEFjtyBGAn6qy7B/BhYn2nk9o/KEuhxauPXQGsedSHDC+5o3pHY3ZJhKnzvfXnVQ0uf6uCZiz9j5IV+RfpVp1ttrLa83x3Cx+6DHh+9cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098878; c=relaxed/simple;
	bh=QShMCFni0ukgDGvnfOVtF8VmaWx6xuhUy0DOuJryRP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxIiQBL9gsq2suuTokmkX5InjpDg6IlT6w0cwE8GdJ/tqY035L0k0LParG2PfR7owVnlodLSEUT7jNRmHyv9DC6x9NMw3oonyOhcBdQBRNZHwD8/yzy+zK2/Qaff3lEdJmO/xx5z1W4qpBZuVlihD/ZszBuOsDUe0Gv3rqIdYCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JlPqjPlt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XWBuuQoI; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JlPqjPlt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XWBuuQoI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711098876; x=1742634876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QShMCFni0ukgDGvnfOVtF8VmaWx6xuhUy0DOuJryRP0=;
  b=JlPqjPltwK07C8HhdZnxY/hz5UZvwDOVDE4nQNbDNx8IEZ9Do9J7N0mN
   8VlOTvUGx27sQaLcBd3F5dz1TfPWTeuxtLt7bW5ppdAAffF8Lm3BRwEJw
   bHOfFjMAdmKoWf98rVLCy83X400gEzj6AJ8ox5IUTXrecdabbQamLVkHe
   AbfC+QrnaZwhn0vdf+FgdraGgqfuJQ7sbw/HPqhb2pfDdB2vap4v4GDoX
   /DUwE+oCPkhSvPSxGxrZX9DfH08UcpqpjR7ZRNjAsmjDw+wpveEi/t0wA
   6LTPF6G2QvgfndeKtnTcBJYaarwQXuZNf5sm2k5WuB6jFZa+KoxCuJrN6
   A==;
X-CSE-ConnectionGUID: Gv/Jj6LyRRKPnu7HWhzHiA==
X-CSE-MsgGUID: PwamfymkSOiGYSSebqPA8w==
X-IronPort-AV: E=Sophos;i="6.07,145,1708358400"; 
   d="scan'208";a="12232877"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 17:14:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDwU574vTERYQyciHbL5Ct5MJFmL/3HuS+WBykLN2ziV8VvREwaLIa5B194fpfeG1F39D12nQgjgsRXU9dHDgUofEJLDbGF19d7YIMdv1aZe/EE/0c3KqYxJjFQbFznHY01JMQQDlZup3OhysVlmMmfD6k+Z4k6h8EM4feit13QYv56TlEzevPdYjo6N+wP0SJb+esxnELLBx60JzVkVTUHZ7m1g+Z4HYGvoS/XvBEPOx2ohEtu0Bliy/2pTUETUyhIIBXu07H8dnsdwgTN/Gb/6iZ9dUHf+2b7Lgkivj6DN4SkxSXrU5DP7ZfqKDSndRX1Xb61wb2o+rfdbahfbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg2BJYgrtKjtcXUNP5r19G+5oAzc+Dw9FXeojPxt7X8=;
 b=W3xcItcz/vRviSCaN61z3Q9s9JQGWfP358Ebz+fIOahXQcb0vYCisf5R+3/PqNH3j0BJ03I1YBK3nrpZpOY2uU4l+C7cJuj6bwePFLYGyJwo90sJVs7si16iT/QhPj11EBWAUjCCZALbqaUEsC66HQ/32QJduKLcsAEuxQv05sQ7wCi94Z9F9L6L1LofBua2QE/IML98vckrVbmqZ5deiVmDSGtUgSE76tCaz+wVLw4SgJlAeHIjgJAXkxzm2Lcgg3K4PFKZR92WfdVfk86adKDAYzSmg3mbozW4YA000iH+wwYCv2VNnlH2dvqv6CASFfv+63hgHaAuGvFEk/4c/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg2BJYgrtKjtcXUNP5r19G+5oAzc+Dw9FXeojPxt7X8=;
 b=XWBuuQoIXUV/dwUdIBQ9K27OMVdmy/5TobE/EP9ZavoezqD4ZNzN9LwOE4JcZT+PuyUxGKOz0/XbhvzOwhhHUBC+oQeeWD/2hb1a8JL3Xdw28tgkr/71c8pSB6UjyjktbpbB3UJTBgO266PZXXekF+/L76Q57Zda8e6mLn6fvuM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7827.namprd04.prod.outlook.com (2603:10b6:303:139::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 09:14:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:14:27 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 02/18] nvme/rc: silence fcloop cleanup
 failures
Thread-Topic: [PATCH blktests v1 02/18] nvme/rc: silence fcloop cleanup
 failures
Thread-Index: AQHae3TOCf4kfF+8Zkizm7l+0SJusbFB9ZIAgAGGL4A=
Date: Fri, 22 Mar 2024 09:14:27 +0000
Message-ID: <ua7jrwofymcka6otaivuurkmn2wjjztlhnarfm3tgnm4uyuugq@p33z74uj72lw>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-3-dwagner@suse.de>
 <ltt4ymu4sioby5tzlhg25lbspevul3p4vp6jj37tjawjuc5bw6@pmxzeozgzn2e>
In-Reply-To: <ltt4ymu4sioby5tzlhg25lbspevul3p4vp6jj37tjawjuc5bw6@pmxzeozgzn2e>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB7827:EE_
x-ms-office365-filtering-correlation-id: 33b444da-805b-41b6-a461-08dc4a507950
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EqLln4vawSKG4/BSGdBHLLWEl0RgKfSFHj9LpCPjd0k/Zxz4HCoXsHPHGJNevZa+6hxUq8KdepKbvSu1nna8zfbtH5qU043WFfh4UxMPRt6XrmJthRqyKVpW8cHx7zNIxT4HPFeolnyEBsQQyAzC8Ogy6U5pZVXIP1bncFZvQddaWmFtC5xpg+p5WCZdNX6NIFQNKptQUc3fwzt4Q0Iv+9DN+/jIZ5iwnSBnF6cl4G84gx+606RayFixNc9wPzV84UqYwdI50eJd12qTvet6pLgiU0ugf3rw2eUVflRhyCmb/Yns4J/tnytzIvlxtlvhiWm1xf/Pc9aXfzQBoLBAoMnC5njHI8sVcWMYX/S3AC138evVT2FUR2IoP2V47W0jGKRzQ8+txlAXtP+lD/KgKm62ou7VD3N6kNoco3d/ScaUQ4uap/LxLK34cfWPgjg/NIylawiEgYJ1eUpmtMIIpJbEIY9SUiH9qMbjDDigURbtJi+DcUoc7Ku5wda0kltwFi/3AbHBQKhq8Uk+nuHKGzjb63kT8F4JsxkDTA0CkYR0m6KgXk2JZh5Jb6VVSzTngvt0sC+y82uFbZBwPMgf50/vwAkL5N6lXVTMViqmmMkGrvUB1dN/sPS/HZupxUZwcdfto5RzoN/3C2t08r7cx8+9Xsu8ChCHnUpY5P8oThUMlKQj5Rhgh+5QtdoeTEWuMTAUZIC8A12U6c8kWiMskgr3o0Dc/Pgukl3KfxnhIIQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2mASmDEVVBmHhrCKdqHtWJiKOP8ETPtWTbGU8UAQA6mDvff+lyztFsa9ZKdA?=
 =?us-ascii?Q?xtBiU/vxJSO+jkcqQ1vifzpKV1Njd89v/l1ywFBonPeKGzv//CHCSJFPMl4g?=
 =?us-ascii?Q?TPlaeS9lX3VX8VmUzWbroG16l8NfDkM3U5lwcBxUk/6I5kST5+u8Q+nkhyoE?=
 =?us-ascii?Q?dVgjQ/SuJf7O60GozpXGrMeRlJBGR9aBAeA48un7vkupGe0FLOi6jOlatl4P?=
 =?us-ascii?Q?cAZ3xr/+cIJIKpN8MmU5bNtw0nqNrIYuIXbk8RZZV8aAbbFNFxtVo3W4m/Dt?=
 =?us-ascii?Q?tJrR+365YB9qlfBDBZtyMO3NH+flQEsHx1MFaBJYie44i1bALXDSKwjDCQUy?=
 =?us-ascii?Q?sz1G9aFDCWrXGCGTp0gdUtTV6TG/RrICKz5/vOselcM/So5Kra+RFIaKTdVJ?=
 =?us-ascii?Q?UYf3vMRVVU2tcgrgheu11DeAYs4At9Kl3p422jf8ZsLX9mXDtoY0LPEaTNOI?=
 =?us-ascii?Q?7EN+4MkwVlZIHES4cVm9TCWMHZkS/oJ0BXsNSFKMgjkowDJrDn91O07SMcUc?=
 =?us-ascii?Q?u+5+wkCLrzgGDzaqEVr9nU7xH1Xgk+tHInHFXpa5IsRRv+y4fTcPv+biKSa2?=
 =?us-ascii?Q?pDGopNlpHA9cBagTN25VwtsWhjRNeabiejSiyFQMfJd9lKW+KVHwA0FoFXEW?=
 =?us-ascii?Q?f2rxhcAiCXhL4I9CU+o8NqJB8oq6OsbJDJfk8uCUgvpEbmoAGXyjylITQ9ES?=
 =?us-ascii?Q?01TgFV0zGsqnh/LVbBMjKchdq3OvMN3b+5HW5BH9FcpffxiibP/gHHeuSjea?=
 =?us-ascii?Q?Re/uTa7wLAYCH99yJTfpTPbK6QgokqyiOFLykfbuQl5Z5VvlD++/YemfBbdK?=
 =?us-ascii?Q?fEEwniscKx01c295Eu1M8IJAIlfj3jD1BngoNyn+3DVzCHuNGwxW9c+fjnn9?=
 =?us-ascii?Q?JF+W6275OB7ODVc4gfLiutQd0Cv3ZBEvxRmMkucT5fUs6BzuWEFFbtkzpUJt?=
 =?us-ascii?Q?6w6MpJsQ3ujXpIsXbiWP1Zl2NBhJ2Yy8PDSv2gtj/c4btnLp9/uUlOwjBqxT?=
 =?us-ascii?Q?KQwSeUBP3XoDV7O6tNFBdVyR5IkwiTQw4IWfOU8f6iIzlV7TD5TezkI2ZMEc?=
 =?us-ascii?Q?ub1YoB1w8ciBVytvqQgyQz5ZuU/IpSUYghcNS9N5sxVPqNxGxIUeOywelIgE?=
 =?us-ascii?Q?Ll/UTgZ6YZ2JlCLBakr2FI3KRkwwB+6Oh2NeXqwGYcRS+5vZnhntg9TKJbEK?=
 =?us-ascii?Q?QDYxOQQq23KVF7mldEC/kZAnaVyGHAa/hvx4d4kTJugHpZ3i598aTa/eO2LR?=
 =?us-ascii?Q?kTWTshfRDKbjxNearPyRfDIOzV7SHbv02tIem8eusuOREqjnYui9OR4V52Zv?=
 =?us-ascii?Q?awanoh6B7E6CrepYYiDDdpTY9I06vvs08+dRu9NXBwlwHVlTkcn/RcxpSbzS?=
 =?us-ascii?Q?zf5iiudRR6ZSqsrIU4EEhVNUsjaM2UWd7eEsj5FuU7ryIdKZWzxpajk6mDMc?=
 =?us-ascii?Q?Jr7z0s/P8xVIEfUHRdUZZ0OyHbs8vDB502IXnZO10ypXJQA4Pr2LVTgniUas?=
 =?us-ascii?Q?BollwqvqHW0pO0UTSNepUzARnF5JLDPynmEbLuCtaQvkK5OTWQceSsFfPN05?=
 =?us-ascii?Q?6CV/BTNLjQ9V9w5VmM43X6+i473Rt2SWX7oqhlQLiITCY7YazCd2lnzs3hMw?=
 =?us-ascii?Q?ba1Sk4OnoR3diAH/0WtsviA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD1F5BE464BC30468B3C88BD12F697E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yrxe5P7MjwgC71K6qrmHtBHeTBLfqQEna3clAzoA38X1c+KXpcy+zHrnm51R2+iqu0Y/YZjGi0JrIG14yCbdiRbEAiaTpRx54RgUwuMQdsrypCYpySwIEvWjJh4Ni2gtGMdpYzecUgDMMAPCax9+inrBgVb19BoZypw6XNONWUhIx8UWtJb+w/S5xK3irgguESEs4ZneHf/gOmhydXVE3ho2UDUTRa8+V844BiFm82A6vbxTbLGZm7RkOGLXWa2N6p81O5KAJNniqeNAifhQw1af8tWSykExQWiBKTXpe2f8O2kqkoqCdCyFXb2kGc6YGxFIlR7CQD1cCw2cxvajtYkrod8iq6bRMKRFCcVfPMThTrLV2X2kvZPEJyulFVTkSBtdG4Aghjq4klK7rYk1CLJ8JHbYq3m1QpJ6TImN83kNxWfsErvhIJMpFqWX4QrMPsukAqXI0sJFMy5gjM+eblOkaIWp7No5vBW8NRc1k6/y9FRE2EY4+krJPmx0Kwb2HkQxj1yudTw80Gj7gsL+ns6MHvAECcXKHTZXPaORHfljoYPVwt/6jjwNe2T3u4Q38MPSOgmmALyjd5NfGhAGqvj27TJeBJYGEBsCb39jhMMVvg3wMwvWrTKrxnpZsf4M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b444da-805b-41b6-a461-08dc4a507950
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:14:27.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5orrYDfht3KU+QJvehyRyUQgKejeaPmeLdXMDW7MQ6atglH8Q8GkPveET5E8ZX6wXsh0THx2BJF13Dqf4pvXvsepBf5IcqmUt1uP6LZGGdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7827

On Mar 21, 2024 / 10:57, Daniel Wagner wrote:
> On Thu, Mar 21, 2024 at 10:47:11AM +0100, Daniel Wagner wrote:
> > When the ctl file is missing we are logging
> >=20
> >   tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No su=
ch file or directory
> >   tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No suc=
h file or directory
> >   tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No su=
ch file or directory
> >=20
> > because the first redirect operator fails. Thus first check if the ctl
> > file exists.
> >=20
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  tests/nvme/rc | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 78d84af72e73..53fa54e64cb2 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
> >  	local remote_wwpn=3D"$4"
> >  	local loopctl=3D/sys/class/fcloop/ctl
> > =20
> > -	echo "wwnn=3D${remote_wwnn},wwpn=3D${remote_wwpn}" > ${loopctl}/del_r=
emote_port 2> /dev/null
> > +	if [[ ! -f "${loopctrl}" ]]; then
>=20
> This should be ${loopctl}, obviously. Same for the other changes.

I see. BTW, I think the "-f" above should be "-d", since I think ${loopctl}=
 is
a directory.=
