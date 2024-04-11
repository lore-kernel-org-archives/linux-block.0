Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAF13B2B8
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813358; cv=fail; b=LIx2JiysRp1trjOU+LOWsoM+rCpIqIvv/Mbx150jd5n3FdzUWHVHeA/EUPHkBXTpTC/+NFdVwZdeA5ZjpnJnafoU5tbW+HgE7vE7aaGJibDvftv0PiTn9AFycF1HoBNoQztSygmRPbuE73PICnh7rBgw81/PsbdIjkZ6219E9IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813358; c=relaxed/simple;
	bh=FmG6B8NRG9wzIVTK7S7bZqMRcmBFJrcbLcP5OIvSXok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ekYW7j8p8399V1qXBkr0WPjpERar06RCDx02yAtV7FtVbvpmLvSFdEpop0JQEDDSNPL3HSdnskVHZJZXFy/EalpYWZTkD76hUpYUHDGdYlfQxU0J6Sjf7lxzgmk6ZAKBveOgg7YzyEX15A5iGYq5QEHsFEqsq177HeOc3dvCs+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S1nlzTJy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H6MBFulW; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S1nlzTJy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H6MBFulW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712813356; x=1744349356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FmG6B8NRG9wzIVTK7S7bZqMRcmBFJrcbLcP5OIvSXok=;
  b=S1nlzTJypNy8LVBPDf3tBFVEz0rbsH1RcmlFinGFxqLAvL6uhpekNaIj
   11OURMLPYZ+bjhX7XyN+lnFyoOAHHuL95QebHwiyK8kPyJE1yacYdfJ3g
   EZ6XSwgCPtIj/al8Ri27E48+IDxVBsz9FtPGZ0hAb4qHqEAvb6WT3u4++
   OAobTAdAqCX8slvkdxWvEqUPSmQ+ufWGGaiQulIdWBIAjQxRXjhjnxlg8
   3m++RMdZS7Hjz4r3ygeMJxFRd4hvYqRaxB3rhAgib9crs9K46TmjpNKdx
   Oah7sOiOR9qDSXFDb30dFqUvqm9qtmkYC04AHyXm0lOQoR9eNpUiyHUNV
   Q==;
X-CSE-ConnectionGUID: Po84GnTBQ4+b08T8tA1NFw==
X-CSE-MsgGUID: WkaSwlU3SjiRwI1QB7sRPw==
X-IronPort-AV: E=Sophos;i="6.07,192,1708358400"; 
   d="scan'208";a="14438582"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 13:29:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNIZabWe8HDrjNi848hSPugCaBjlQuZg+y6SNZbqeN0VMh6lMo+LOh4OBfoMpCtebwmajIVGH8066XMO8Acev4yOOHWDSlDtnccCmO5SUewMi79jAOx6+1czj1G5qjNpzAtOAbcKn2dfGp0tJXnUju+88a3RIThLqz8gg0ZxSzybN9t0Ifk9qBB9dPgYeGP35avZd3a+rtfRiuqEvfdQYqTloicJi1Nu1hY/ltGeMWN1VV7/I8AeY2YALt04GaYVfz8mnH8BHcep02o5ndLgEfBXTEHOjKsG6sOITNSPx5qvCmaCHLtIwpExryLlcLZVLry5CL7wrcv63Mf0qMmqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCPsMLT0/KziGRpVqJIzz0ATk7/AW+gB3POnT+o7nac=;
 b=nvZnuqBtIRgYbSZO6e5tsSbGSG17WUMs1lNuFtVxDD5CwyRyHe1uI60OACVmANEhXGImQvJdYfN1or5mmjOpwvmxMQwRKMyRdzxlI9UAnLVr6dX2tLQDRyBBH313pQPhSN1LneWg7ZQq4aYU30IaKenGHEAHebiGY7YvYwwBS4VFZRK06y/H/C3NHBhMI7NInSCyNqyo7GnJ0SZuJ7xEvjF6a101CPED2ofXZgvgQxTKru0aQzY5ORR85W1wJwsKVQKP3wTFqtqUXuAu+vV/MVaIFT/3P7qzRdYbCWqmlSSz7+YPYI9GJ0R2FjIpF99Nkl0n7Q6kH9D4R4iKXmMhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCPsMLT0/KziGRpVqJIzz0ATk7/AW+gB3POnT+o7nac=;
 b=H6MBFulWKCVN8+LQFJKrLepmqC3wkGA24veL4AcAwYrmnpMx2hyPBKRg5BZGkkYf5KPVj0W5dVsEs2seIZourLRpn4VDWrR/lg48vDvNARzkD/B9P2M94zR3SRXe43tKuoVuc+wkueJf+ARPv+XVwxISZfQAMhn9BhWGWeQCQm0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 05:29:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 05:29:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "hch@lst.de"
	<hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Index:
 AQHahvyWiheVndYbAU2CjNmML0/vjLFZTnqAgAFeVoCAA0XkgIACt8UAgABTNwCAAMYigIAA0IuA
Date: Thu, 11 Apr 2024 05:29:06 +0000
Message-ID: <7ksgwjpcdt7up3r5rvvxoojllbnqnxu4fdzajpyzgns3sax2yi@hbkgnensb7i2>
References: <lfv2rqcpyyeqv7efpc4ozru7daycx4nv5nmc2xh4luzgtk3tjf@oq33dghcnt3j>
 <20240410170241.66966-1-saranyamohan@google.com>
In-Reply-To: <20240410170241.66966-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6723:EE_
x-ms-office365-filtering-correlation-id: f620bccb-70a9-4d7e-86dc-08dc59e84e8b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 owm5Hg63iBIWpbXeJK58ORDpNlKQQSc7uSJBgmk+mD1nQJXAVy+/fqPWijmHGgYaw5dFOd+Lonwgj9JzoMJbSoyTG+qvknHPNQfB18J2kmAGQZbk50nTM1X3xHBZ2AKRBjf59dU2admSi3BCFEElaCkIlG/dv5TuezT076novV5CxksMaosbbwq4ox1OgAvYJks16Ps4HcnmogFPokPh8DC8DTStyYq2/BUuTQ5qgKwoaVXvTgSkjLzQBcyJh1ktx90aGpt/URzcXIejgbQhLVQ/R7oIHNibVIJyInxNqpCC0Hd+ZZ3tg/hcu4Ff4cmUunnU/6M1Td1NBS6ed/qeDMoiqTaYOWUWm4BrWxozuIjOGoduRUYdCRPqy2y0ae7aKIzqUOfWIj5Gjr/+2rbMWxLDkgLTfl4N1K3bh7U/xKtY3PbYYva91mtCIB4bZBWUWn22zKZdELC8Fw/dUS4s9oHmJtNnoBYdEtlx5oiwDwWHdDimEv7QHX8OpjsFq/gSt4J7pdKHuCcOt3g4lmvEWb8o3KcdAc3nYZr3PsvI3npHo2LGkQIlXBCdCr+qYx9lpkk6ny/dHR/gOSCcz107ysStD22OyGiILJws3NCUhwthcczoM+zeqp9GZJIyHRpqrdHOd3WEeaAAVOh+QQTqKNElOvsQwuf6h+/uW/VRoIcsYc3rugRZ2gWkddrqPeseesHY4dRRFHxdo0cN+kKUOzmnMxfcB/VX0QgrM1xi3IA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B1sbrcDlna9UUmySPPHcWEpRVI63R3vyJX7rqRAqNVLIRLQKcF4hm1SpL0xy?=
 =?us-ascii?Q?qlPhqifCPsvJIeZf4VuaI1/hV2kBMB5ktf2vDnk7Vm4HLkg9v2v8Gyqx9KkA?=
 =?us-ascii?Q?NQ30MyERV56ethkZMlnCWRPz5x6hUHRZXKCcou8Rl8q0SDIiMcWr7yQNdjla?=
 =?us-ascii?Q?MhsNSJV551k4MgKD6WkRkKK1ihHyrmLi7Z39k8T422yYYTUd2GlIWQk14Iun?=
 =?us-ascii?Q?Ydi/rKhnDViKgjTyecwBH4q80rWpm/NGeE0Qs+5UHVOFjRI3WB+VzVdCpok5?=
 =?us-ascii?Q?TCIvQGp8Y4EdFAyPt+6ocTpHiaEsEMG65x5q71HWvq3sQFk4V6DIjccFBDqg?=
 =?us-ascii?Q?frs2SmnJoYptJQR1Ybro4X2m3U/ilPjnq28Uf7CaqhAD3gQzcoCqoYnt6wjv?=
 =?us-ascii?Q?cs4KzF6/UfDYpqOQV51+cx0+AtHLIPx+h/yBsBGwoMRMYehJX73infP0jJ9f?=
 =?us-ascii?Q?0vc0fyF/4faqOPgRMoUuurhQe3ejyhhf3uSg55P+sePwmPusCXMUqDwGDe65?=
 =?us-ascii?Q?QsEcNZCIKJn5nPWIEZ3N5K0lEstiEx139yDY0zXPaIcfvgm+rwYZk7wbN4zY?=
 =?us-ascii?Q?xRdm7gCcXn5PvUtsCK5zyVJfGVe/AHkl9bnxKlzxutQaGI/IVuZ7f0dvuwLf?=
 =?us-ascii?Q?5Nw8ouZyEPcCNw/62JpKYZRG9TgzTOO61/FhhyjvhcW1FbdN8Y1v0PQm42jH?=
 =?us-ascii?Q?skoIsZhqJYqFBGKCmiwzZ31EPfwKsFRWqApsbQMB7R1i+VGJW4y6hBkpGIUV?=
 =?us-ascii?Q?ZcDAMzE57dyb9HZahcjWPxr9WHaomFrNo+G19pkcdpsJGE9NHrRpi31cMx8N?=
 =?us-ascii?Q?qt0+Xi7mXerlRga+wCNZOl4Em3vSUi5eEJj36SG2ivediMpUyOD0Q6+7uLN+?=
 =?us-ascii?Q?bbSkccrkF6SDj4bA1MiaWbKstN1lDpToeTKVcuOh1oOfi4q9gk9w4N43f2yX?=
 =?us-ascii?Q?ewGdLayZvgye4l5Psz1HxmXCC3c3Dn0N+2xQvUm6/s2h9yJfqYIvtK/aLd1e?=
 =?us-ascii?Q?eO+grkw/XORk6hYYrGwnNhKbC4LUI6ZcnQ7JRZCYlfpilT413T1OO5Dt1k7M?=
 =?us-ascii?Q?R/fDVfK1i8zdplNCqcymIyHpayi7CMNIydiUMxQ9Z6XGnlIprXqVgjy+Kzx7?=
 =?us-ascii?Q?qSLDySk9R9gCkvdT3FqzBOxQMQpd+9tiJdKBN89YK38S4dRFeb+c8N5gCzsV?=
 =?us-ascii?Q?s0gSa/rv5LhDLF/tml64pHWsNIJPSDum9JjMkRM04QCfvw0XnLjJaGww8CJe?=
 =?us-ascii?Q?RBy9uGLoMjmnBcYxvYMS020+ke0hkNE152IzUT7CcdmVlZR7B1OSpLiBG5QZ?=
 =?us-ascii?Q?qb8u1uwUk+BB5hWdMI7Oa0WrRG1EIknMEP91yZEtf0oiiy6YXXG+YMx8kSLi?=
 =?us-ascii?Q?jFuh7xOl/VzyXQ+5e61U79vf/1/GBVZIwKg0tNwb9a0Gn8g6fQxahjS+bc1p?=
 =?us-ascii?Q?rEjfTG6PU/u9pz4Og9cHUU7YQLzKjdy3OUqo5SiMB+kK7Vq7pkNtKwH76OpV?=
 =?us-ascii?Q?qWm6UK5c08tNwfLPx4drGK7aO0tKPT6cKNd782ju5BEGFEXSe+NB876qALyp?=
 =?us-ascii?Q?KNXv6O5iJd8F9gsi7079fv5QVDuXEtb9OK3THv9SRnR87Ps1c7PZMjQ9SiqA?=
 =?us-ascii?Q?nQzpZzZ8un8IPKQilyw+TI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8B171BAE6714E4AA8406657E7495198@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O6Wr85fcIaYY7EjeFZ/xygqnYHab92mByj9955Am0pIzeGjOYcAWEg9ut1NzvJKWU07xEyljmtcLQIU1/3OjvK2HFYX5YyEGZQLCPgb6zEZTcgOSUxqm5CBFRYSW7EgIOuXKMJSnMJd6aO9Drhb4A+yJVzU5UDstj5uOqQiVCuvLH/i4/IuOXR9E1CptmYYXD08achTpxe1l2cDp0JboyH/oKuYDyCXr3elF334FmF54RLMCVK9356f5xJ4hw9g37TrMb9kTT0G+qrtjFJauYRjqIXn3JUuH75nYbk5hxg5w0UIuFAiJXkAv2c99WzkxDYHvYoeUoJHPx3JnKRtC5QmoJtVHc1vq48D5c2fORlUGyUtFiB7KKaX8bEB5vVK67mnl1gdTQhMoA6/rccECG4ef3JNrINnztL41cqbCs/EKJsVSpUY+/CyCs3hP+E/yxMCs+yBePMV9Nt9XR4fV5msMbm1toWz+d+WN539Bgov1ANWdKPED8BFC4mC4eKq3e0A0hQSvo+vTP/11/ocePDyhCf96XBkuUfimMKgspZx8/9T9eTtcStfCLF8FdoW7peftynIbjOKoJKX82ewkhTcYblL5c7QCFuq5Wsw8t8d1RlsGqVxjHLBp5D1M6g4p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f620bccb-70a9-4d7e-86dc-08dc59e84e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 05:29:06.4319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsSfQVgVtmuUWnOUGv8o2k0rU/A2yS+bHCgIUDcTureTvddFK7dZ4YbOV9KQW4/uwr+SIsux3tuppxwSlqDbBxB8cl2QPaHOXOct+4LDbvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723

On Apr 10, 2024 / 17:02, Saranya Muruganandam wrote:
> When we fail to reread the partition superblock from the disk, due to
> bad sector or bad disk etc, BLKRRPART should fail with EIO.
> Simulate failure for the entire block device and run
> "blockdev --rereadpt" and expect it to fail and return EIO instead of
> pass.
>=20
> Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@go=
ogle.com/
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

I ran the test case with this patch on the kernel v6.9-rc3, then observed t=
he
output below.

block/035 =3D> sdc (test return EIO from BLKRRPART for whole-dev) [failed]
    runtime  0.049s  ...  0.041s
    --- tests/block/035.out     2024-04-11 13:40:17.938655578 +0900
    +++ /home/shin/Blktests/blktests/results/sdc/block/035.out.bad      202=
4-04-11 13:40:19.808650194 +0900
    @@ -1,4 +1,3 @@
     Running block/035
    -blockdev: ioctl error on BLKRRPART: Input/output error
     Return EIO for BLKRRPART on bad disk
     Test complete

Failure is expected but the output is weird. The line "Return EIO for BLKRR=
PART
on bad disk" indicates that EIO was returned, which is wrong. Please find m=
y
comments in line about this.

BTW, "The canonical patch format" section in Linux kernel Documentation/pro=
cess/
submitting-patches.rst describes the patch version descriptor (v1, v2...) a=
nd
the patch changelog below the '---' separator line. Those practices help
reviewing kernel patches. I encourage to follow them for blktests patches a=
lso.

> ---
>  tests/block/035     | 86 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/035.out |  4 +++
>  2 files changed, 90 insertions(+)
>  create mode 100755 tests/block/035
>  create mode 100644 tests/block/035.out
>=20
> diff --git a/tests/block/035 b/tests/block/035
> new file mode 100755
> index 0000000..0ba6292
> --- /dev/null
> +++ b/tests/block/035
> @@ -0,0 +1,86 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Google LLC
> +#
> +# Regression test for BLKRRPART.
> +#
> +# If we fail to read the partition table due to bad sector or other IO
> +# failures, running "blockdev --rereadpt" should fail and return
> +# -EIO.  On a buggy kernel, it passes unexpectedly.
> +
> +. tests/block/rc
> +
> +DESCRIPTION=3D"test return EIO from BLKRRPART for whole-dev"
> +QUICK=3D1
> +
> +DEBUGFS_MNT=3D"/sys/kernel/debug/fail_make_request"
> +PROBABILITY=3D0
> +TIMES=3D0
> +VERBOSE=3D0
> +MAKE_FAIL=3D0
> +
> +_have_debugfs() {
> +	if [[ ! -d "${DEBUGFS_MNT}" ]]; then
> +		SKIP_REASONS+=3D("debugfs does not exist")
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +requires() {
> +	_have_debugfs
> +}
> +
> +save_fail_make_request()
> +{
> +	# Save existing global fail_make_request settings
> +	PROBABILITY=3D$(cat "${DEBUGFS_MNT}"/probability)
> +	TIMES=3D$(cat "${DEBUGFS_MNT}"/times)
> +	VERBOSE=3D$(cat "${DEBUGFS_MNT}"/verbose)
> +
> +	# Save TEST_DEV make-it-fail setting
> +	MAKE_FAIL=3D$(cat "${TEST_DEV_SYSFS}"/make-it-fail)
> +}
> +
> +allow_fail_make_request()
> +{
> +	# Allow global fail_make_request feature
> +	echo 100 > "${DEBUGFS_MNT}"/probability
> +	echo 9999999 > "${DEBUGFS_MNT}"/times
> +	echo 0 > "${DEBUGFS_MNT}"/verbose
> +
> +	# Force TEST_DEV device failure
> +	echo 1 > "${TEST_DEV_SYSFS}"/make-it-fail
> +}
> +
> +restore_fail_make_request()
> +{
> +	echo "${MAKE_FAIL}" > "${TEST_DEV_SYSFS}"/make-it-fail
> +
> +	# Disallow global fail_make_request feature
> +	echo "${PROBABILITY}" > "${DEBUGFS_MNT}"/probability
> +	echo "${TIMES}" > "${DEBUGFS_MNT}"/times
> +	echo "${VERBOSE}" > "${DEBUGFS_MNT}"/verbose
> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# Save configuration
> +	save_fail_make_request
> +
> +	# set up device for failure
> +	allow_fail_make_request
> +
> +	# Check rereading partitions on bad disk cannot open $TEST_DEV: Input/o=
utput error
> +	if blockdev --rereadpt "${TEST_DEV}" | grep -q "Input/output error" &> =
"$FULL"; then

On the v6.9-rc3 kernel, blockdev --rereadpt command succeeds and prints not=
hing.
Then grep -q command receives nothing. It fails to match and returns non-ze=
ro
status. Then "Return EIO for BLKRRPART on bad disk" is printed even when
blockdev does not output "Input/output error". The if statement logic shoul=
d be
reverted.

The grep -q command prints nothing, then the redirect to "$FULL" is meaning=
less.
I think it's the better to redirect blockdev command output to $FULL

The line above is not working as expected on the kernel with your fix patch
either. The blockdev command prints the "Input/output error" message to std=
err.
However the pipeline '|' only passes stdout of the blockdev command. Then t=
he
grep command does not receive the message. That's why the message "blockdev=
:
ioctl error on BLKRRPART: Input/output error" is printed in the test case
output. I suggest not to use the pipeline.

> +		echo "Did not return EIO for BLKRRPART on bad disk"
> +	else
> +		echo "Return EIO for BLKRRPART on bad disk"
> +	fi
> +
> +	# Restore TEST_DEV device to original state
> +	restore_fail_make_request
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/035.out b/tests/block/035.out
> new file mode 100644
> index 0000000..125f4b8
> --- /dev/null
> +++ b/tests/block/035.out
> @@ -0,0 +1,4 @@
> +Running block/035
> +blockdev: ioctl error on BLKRRPART: Input/output error
> +Return EIO for BLKRRPART on bad disk
> +Test complete
> --=20
> 2.44.0.683.g7961c838ac-goog
>

Based on my understandings, I suggest the additional change below on top of=
 this
patch. If you are okay with it, I can fold it in when I apply the patch. Or=
 you
can respin the patch and repost. I'm fine with either way. Please let me kn=
ow
your preference. (If you repost, please modify the test case number from
block/035 to block/036.) Thanks!

diff --git a/tests/block/035 b/tests/block/035
index 0ba6292..d4e67fd 100755
--- a/tests/block/035
+++ b/tests/block/035
@@ -73,10 +73,11 @@ test_device() {
 	allow_fail_make_request
=20
 	# Check rereading partitions on bad disk cannot open $TEST_DEV: Input/out=
put error
-	if blockdev --rereadpt "${TEST_DEV}" | grep -q "Input/output error" &> "$=
FULL"; then
-		echo "Did not return EIO for BLKRRPART on bad disk"
-	else
+	blockdev --rereadpt "${TEST_DEV}" &> "$FULL"
+	if grep -q "Input/output error" "$FULL"; then
 		echo "Return EIO for BLKRRPART on bad disk"
+	else
+		echo "Did not return EIO for BLKRRPART on bad disk"
 	fi
=20
 	# Restore TEST_DEV device to original state
diff --git a/tests/block/035.out b/tests/block/035.out
index 125f4b8..0f97f6b 100644
--- a/tests/block/035.out
+++ b/tests/block/035.out
@@ -1,4 +1,3 @@
 Running block/035
-blockdev: ioctl error on BLKRRPART: Input/output error
 Return EIO for BLKRRPART on bad disk
 Test complete
