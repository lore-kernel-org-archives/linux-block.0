Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14726137E
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713502033; cv=fail; b=KOU0R4ycq0kGaBYOYsFsbJUVZyn0jJcVkIHjH2BRWP5fjzK6QQrAFzBGtg8i3I40p6kBomkdVxpVyXq63eVefLV1wUcPIRVJb6plZe0KY0j9TedUBJikvuaKpCzAjNISNJvbnl6UP7G6lAtE5wiyLv5rZWJ+HCNEWB5p+YoqAaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713502033; c=relaxed/simple;
	bh=+7b1shRasCCY1vTDeu9U1+Io8palSxwKquncHXU1jMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YKGmZ+QPPrJW5A5sHyLZ2H3sZ4wEDTc+CyzoF6QzO21yfZdHXv4GpzuKC0dXQM6hc+yY/7mktWS8W6KKy+gh5Xa/eC0kKl2WuvabMi0rQKWt5VgiOqJRaE/dZaXM6MN96yW3a9EIdiI5UtaHyDc2UzDp1CtV65pprwSvXXpx3R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HW2Jfmaj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XhUSNMam; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HW2Jfmaj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XhUSNMam"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713502030; x=1745038030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+7b1shRasCCY1vTDeu9U1+Io8palSxwKquncHXU1jMc=;
  b=HW2JfmajlE9Z+dfxSdnCS/rMKduWluOPCvbN9X2jbLSVKxmfJ/Jh8FjE
   idCmS/qWgyodSH0SFiU/z+eDyFhcGUbn6kbyVV24rLtw3f9nRHa6HiHOn
   23w0qDzdi78QeWvya8ICLPLboQxAHfiwSGvrHTSOIQ9NzrrDrWmtG4BGF
   +3S7TewKkFWW8g0CHD3164r7kKxmks72huaZzm+lJZVdqZs3DJpmE+v/1
   lpcQYLlOh4dodmZ+W4FOibR7C1/iejOYMxn+O6Upn4I9HiGNgpUmriNJo
   CiaJERUsOKdZYMQEbHMZyDUoc0K0+aKuVrruwMfhAIHSJsF1dIMkjM8x9
   g==;
X-CSE-ConnectionGUID: f+9RBaVrTd6vRpLf0j0E+w==
X-CSE-MsgGUID: FHW7tJF5TSCr1szGk4Dm9w==
X-IronPort-AV: E=Sophos;i="6.07,213,1708358400"; 
   d="scan'208";a="14381365"
Received: from mail-westus2azlp17014040.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.40])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2024 12:46:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt/EzhzU1vvrV+Mqyvxt9UR+hMx1OVRpE0q+XDqPNPD5vxnCbsTDNfq/yJ6fVSPpmTNmhviQ+DiVu0UHjuXuh2l02sgKGQuSCCj0CzzI+tsl/bRbB96PK+k/367Qwvtg1+4k8tvv6Q1JBoLaAdKlFBPNPL2pn9tN8yTNKmihVQEpjHMJJniU0PRCmmqF/iH3iPZBkvN0iXRo0sEufbNVWCYn9XcHmu9ZEs9wonk6lhOS4cR8YB9FxW2sL/K9x8OA3ImoBNqydgRFnfxVklNcR4X9nWqzigvv5PFyeYXyXIr0XTVAdMkXfMOXv0CboV+KUxDADATBQk6iUMcKPIsSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+r1k8W6zArOVoL3PMrdF1tcZoum6UDD5BQ6GTCUOew=;
 b=AGB//8485IuShJ3BfdteZUUTEhDKPfP5jRgy6jlV0aF+V/BjHPSX32HkJWB9/1pHkszx2bRsRnaLPFyqxMO1zOCuaQFwNMeil6V7Wzyw1uDh7jawu9Ghbp/KGwulsmt/mAqXjtFm7VeftxDRCD1ONdlRSd8BqMSukXBA6Oiy8nwmUBXBO9ZFPaV9kDPvUKr2cYcr5CV/rAfZqZ/3PQpBXmJ/ak319e4FVi72GsQPGpSZC+QZFERbDN6Z6UJZmwdK5G2e8TjSO5nCeypq+nY61S3vV7SAcKykVfDMm6gxlVnTkJbgUt+6Qx8tAyX0vtt6GQOr1JO9XXEQRyWRK739Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+r1k8W6zArOVoL3PMrdF1tcZoum6UDD5BQ6GTCUOew=;
 b=XhUSNMam/SzBRyx80oBk4n5nx0L2mGVbrXtQkcGWSFE4vHSOBE4pxwOh+8eHyWIByAZBXRPWMrRjoLjjXl2g6q+x2wEZ6QNr2gRfTqrS1QA3Qr0AvIFJXl42lFfYJ7qfGmUi0ubT7xsLWCZtYRaG2jX9Oa+kLelfkVruCmkQsws=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8065.namprd04.prod.outlook.com (2603:10b6:610:f5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.43; Fri, 19 Apr 2024 04:45:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 04:45:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: "saranyamohan@google.com" <saranyamohan@google.com>, "tj@kernel.org"
	<tj@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>, "yangerkun@huawei.com"
	<yangerkun@huawei.com>
Subject: Re: [PATCH v2 blktests 4/5] tests/throtl: add a new test 004
Thread-Topic: [PATCH v2 blktests 4/5] tests/throtl: add a new test 004
Thread-Index: AQHakhR4LuJm5THDHEGp5yU/OTjMJw==
Date: Fri, 19 Apr 2024 04:45:58 +0000
Message-ID: <yh6dkc2tmne2log6bsoz2rvqwxjla2bz3zz5gwwa7dqknvco4c@pzb2dg7s6yqg>
References: <20240417022005.1410525-1-yukuai1@huaweicloud.com>
 <20240417022005.1410525-5-yukuai1@huaweicloud.com>
In-Reply-To: <20240417022005.1410525-5-yukuai1@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8065:EE_
x-ms-office365-filtering-correlation-id: 85c91b20-1f31-4ce0-304b-08dc602b9b2c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r+xx5Ajsewl2Mk1lV8+jCyDSQizq5MphgT3QLvUTuiXaaix1sqIahGSlnm2n?=
 =?us-ascii?Q?vFI1ulBqpy6CMme+ef7rlBBXgQIbkxTQsxtVz/OPGsx46MS75+XE/MDluRza?=
 =?us-ascii?Q?0cQt/G7G/2UD5+X07f1B56InHpZutDzI/uTh4ZL3xMN5JDU5B8BehRRrtGX/?=
 =?us-ascii?Q?6agS2USc/TbqrRP6bRkp+R2Q632pIOvzn8RMw5ZQ24bUm+CM7bUOWxQuulrp?=
 =?us-ascii?Q?9U8+VZrviXLR5f/ItFd+1jm+wJJIM7aCSWs9w5BLnLDZs6ffW17SarJ7y8lw?=
 =?us-ascii?Q?Tk7wtoy5HQI4LBA+i5gQhmUuCy2+TanRAv0Sl6EzEuqmnO6Pbl0bkQruH/8m?=
 =?us-ascii?Q?LWUQ6yikhrUNV8H67989yfVSg4ECb86lk5pDVq4PTwv6zu9TguwQSfSzA9x/?=
 =?us-ascii?Q?fBD/7F0VgrxDdEWpjN/FFT1R8ElS/gS55pLGANQjvwOt5xmTjMn/MR6A3GJ0?=
 =?us-ascii?Q?IU8emv6ouKxDJe7BzENFth4C86Bf1oa/6amBaRAY9/mXvkV/pwvBdueq8Vyh?=
 =?us-ascii?Q?TjIX9tQ8xeTeX7j5ohBCf12CxDNF8SuzCuYhpAv0ji+fsAumbS92LRw0Bwz8?=
 =?us-ascii?Q?FN8om3NDolgdwAWzve+iCaq+jESWN45KLYqkXy0Cui88igC8KmDxn4j0ZupD?=
 =?us-ascii?Q?rnqM+Dea1KAD/+tuZUgyAFj8LVR8hutySCVUCbGRyeDgihteOgrd93r3ZQKl?=
 =?us-ascii?Q?ljQyM0uaYdVNBTudZxLbTexDPJN5LvJlPjpIW0tD+0jKrQV4PJ7PuI4dcU8A?=
 =?us-ascii?Q?wxjTXZztq7zOfQwRlPbRRG0vz/h/cdHuXVpRnnIoCjFIQ9HsJPLxJoIQLIUQ?=
 =?us-ascii?Q?4ldLshxi2QQwy4ykwtBu4j8E9BhFD9u8kdZMKLm9cBXWa9e2IJrssoSlJXyf?=
 =?us-ascii?Q?raQ4+dOGJuGONMTBY2fKcP5ulOr+9j6mJmmZuX+/H/RlAORGsf8GzQIK0wvN?=
 =?us-ascii?Q?2jbTnCs0HoQrXS4vyf6Nd38UuLJtMpAkJ0aTr2zF5AJ4SivqGJbMGvtS7nq4?=
 =?us-ascii?Q?fgpBN8dlEcr/tnSMDD6RRcglSVjUGC13+J+ZNduOHJMF5hhriJlozPlTZ4SU?=
 =?us-ascii?Q?xR6Lch8YlC1AMXDaaf8+5/9Ubi3dR1K6Hvvx2ikc958N2IlporeBJ3QVs38D?=
 =?us-ascii?Q?DxrnNndZFzrQ+wK7L/7c4qXjMIBqaiNeCgN1tTBgSULGsSOiHUSPRx+x/zLy?=
 =?us-ascii?Q?O6bBz3stYgVUd6emjU4l0oRkXSVIkIL1TcmfMysjvwzcwbI7KqQ553zd7EDg?=
 =?us-ascii?Q?lTy8O4aM8HowPrgbAZVl+IeoudeN4yryPPakAZkZCRWzV5i5Vxh+RDx/bx+F?=
 =?us-ascii?Q?ZNkUdW7KgoPBpx3zYGcXIej/mufkXkAEuFqaAsVp9njfVg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9udmfIofOTkFI+yZLUvzWIWM0HPPNdqX23rfP9ysGTZzwSyv/PmpWNfv/+zS?=
 =?us-ascii?Q?D0MH1PyqsaoRcw7/qkW29442Yg4lE7NfnV69qwCMeemy2KabXpGV97QB8e0d?=
 =?us-ascii?Q?9+8LKO37aPF5jFNHmdXUGs3XnHOV2pTtPGVSMUXk48TSZeNp8yPRBQJM5xd4?=
 =?us-ascii?Q?COhMUweriLhuQVmdYJ3RiQIiDCX8MIRWNMUmxUCVR0Sek1jSrwWDMfvTuj5q?=
 =?us-ascii?Q?pZpYC0C1uJkvB7GjZAk9mPCMlJe4MpFW4kBL6ytnb9esej+rLuGAe9zZptuH?=
 =?us-ascii?Q?9ff5ffbTpKSzVXmabgyoT1aB4mkDYRoOiiAX00HjqjLxZIIFXOSSWvArgZi3?=
 =?us-ascii?Q?lP+tT8QT6G2NGyudtuIw9zVYXX/GddyRZbg5aJOYIPrqeWV46xIxeqVXRxLj?=
 =?us-ascii?Q?Vusl+oXxqvXRGjDjpU9P6yjwEKkO89SRLOpE4Om/OZlVKa4fKGU2QyhWwYbr?=
 =?us-ascii?Q?paaRhdhjO6L/ShvcGKdVmkKlykrI+XJGmFBi+wvyLZFLDUI/L2nS3mX9mUEn?=
 =?us-ascii?Q?MBui0nj2kpmW5jxXghbCJHi9N//zOg2MJHeCzAfBMJj+5tVVxz9cvIjvk9RM?=
 =?us-ascii?Q?vPHV30Kp2BJDZkn+NK7a/rZ9/Hf1V6qe5+YiZqY91Av0UxQGeIXt6Ykck+rA?=
 =?us-ascii?Q?gTDZy8KmeUV/R05LyqCuXqRwi8TGkgE+QZdS/JvuKOriDYp2QsWs9ubyn2Wr?=
 =?us-ascii?Q?kI8rsg64Lf6lMQktWy3JGm3T8SxVCKCwisH9VRTEaVaGof4rxB1cAp4c3Fdc?=
 =?us-ascii?Q?eDQGvegGtJLqp/1U4fIe1Ef+WiY0/OlcrfLxJfD35OyNQLTVJ0Ujao1EmzUv?=
 =?us-ascii?Q?yM+GxxpM6iNVPgdGGA1rsULikQHeooAeuBGlQf+V6xvjVOQrg1CuLpvZkLOW?=
 =?us-ascii?Q?lDOubHDhuXNqc4jgGcPzZ0OYX4e394xCjHLtDXocYC8onO7xPxVwL8mZ7YFM?=
 =?us-ascii?Q?IjoYCEHuIKRLwsAc0iRc9LdToK550FJF3v7t7hKBNwOJJjxwaSoaky0zWVzP?=
 =?us-ascii?Q?DSWFrGtczB5KruFBb17M89NK5dcQe9i5BkfpdC1UNgLxg6VDO5RdOU/xokAW?=
 =?us-ascii?Q?JbqK24BczFxU30VufmaNoj8otpf/ZTkuJ0tOiOE5f/Z6cpFZenJyhExKy8hE?=
 =?us-ascii?Q?KKgEicjrVmsSR1mYjqmba9P4Lwcv5gepAgj30s3nchPo7xeK7AQgc/h9J/fk?=
 =?us-ascii?Q?Wnf8f7hQG+D32a1qzK7nXqHCWI3TTVIJBeU4inN7M2Ka0kEcVwDAsAkdl67z?=
 =?us-ascii?Q?pXHPqDmKpJ4v9qDchyQB1a4UKfaYyDk5c5tpzN1pHKO7FXgN/+ilaAaguiIx?=
 =?us-ascii?Q?TBGRynDS8hSYP3gaRoq09xx2Ey4rsahSW58ihiUOwjUZjCcC6vG6WRIVO3uh?=
 =?us-ascii?Q?Z71Fa7wy6ja+dM+36lqezHN8JvD0kaamGyMvgR42sF0WPhwDvxGb5L6S7P3k?=
 =?us-ascii?Q?J0VF+mc3tt/TgVgml34tph41zkoIF2JiW9lbK+nig2a+1bYOoir1V6ukyJyl?=
 =?us-ascii?Q?2xRZ1+2phBo/EKNeT84jN3utsDi0+PumEJ3QobpRar6Uf7xa4EOWAdyNUJuN?=
 =?us-ascii?Q?AqXmZrNU8xQAyeQN9+ADXuFM+qj8nb2yRTzodApgBMMnYIClqGJXHqIuARR7?=
 =?us-ascii?Q?XuHY0m8GMm8ZmPJTez92IBk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8953696BF0E4384EAC9BD281C4FA5CE1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y1i3Mng4xYZkjOghVpSIpUHBVF0aQ1EUKKZrVCFJ/n95VjhWP8gWjKNzo1NyG7VuSwdWDTzMm4y0Gpi7B/2GWxYoJyE9JDrX2mhBy8mQUBpSYCM+tbhshNG51Xw6cmbXeB2MfQ9L+iLFZ58M0WJ1dCbLDc1F99yLJB4xJl0I7bbUIsjg5DxXTt9VUR0FU6Ko5QFHraXcAI/B/Oud7TSwG55SfXWWPAbs3J0eF4JvIuaXa/9XW59lJ3/9oabdF9A0lVDwcqbyjqtXYIq5arbq4ia9hh9DZy9fNoLXAVgNDHCvETUejX+KL6nSiirV3ELqZlk//JaASMW8c/x5bP70HQTFqnUwCDkfwRdcqdwake2rMttx+QgYTkF8XyaqhFxew//YruXeHsdyhIC8Te7GuldjbClmdlU4NiUG88Uo5sCbbHPlpW07Qg8ssht3Yb6si6H8vHCvA4bbI8O+uVG1LUR4XXCUt+2sTSP/fy6o6xUkv3/WCaW0tk/LgaeJARatwO0c0ptoZNYdJFTcZ2N9bubg82MeumTkzCwNSni9s+G3sToU30PoaQe9QMVcHwN6usEh+qend+xXFCaG5TtSNzCgh2bq/EH0Py/PBXWKlj3tENLIF4o2G0XtQBfrAYEx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c91b20-1f31-4ce0-304b-08dc602b9b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 04:45:58.2862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxJ0YJczIn4iINoEg8VRc9Iziz4VtDtF2V8g+hKYhgsXV3hieaI7eYp7n/CnCD3OZDuLeYjXTNmPfvvLgloIk2j4TnchM7d7sr/OvcF8Xwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8065

On Apr 17, 2024 / 10:20, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Test delete the disk while IO is throttled, regerssion test for:

Nit: s/regerssion/regression/

>=20
> commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_thr=
otl_exit()")
> commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk()")
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  tests/throtl/004     | 37 +++++++++++++++++++++++++++++++++++
>  tests/throtl/004.out |  4 ++++
>  tests/throtl/rc      | 46 +++++++++++++++++++++++++++++++++-----------
>  3 files changed, 76 insertions(+), 11 deletions(-)
>  create mode 100755 tests/throtl/004
>  create mode 100644 tests/throtl/004.out
>=20
> diff --git a/tests/throtl/004 b/tests/throtl/004
> new file mode 100755
> index 0000000..f2567c0
> --- /dev/null
> +++ b/tests/throtl/004
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Yu Kuai
> +#
> +# Test delete the disk while IO is throttled, regerssion test for

Nit: s/regerssion/regression/

> +# commit 884f0e84f1e3 ("blk-throttle: fix UAF by deleteing timer in blk_=
throtl_exit()")
> +# commit 8f9e7b65f833 ("block: cancel all throttled bios in del_gendisk(=
)")
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION=3D"delete disk while IO is throttled"
> +QUICK=3D1
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _set_up_test_by_configfs power=3D1; then
> +		return 1;
> +	fi
> +
> +	_set_limits wbps=3D$((1024 * 1024))
> +
> +	{
> +		sleep 0.1
> +		_issue_io write 10M 1
> +	} &
> +
> +	pid=3D$!
> +	echo "$pid" > $TEST_DIR/cgroup.procs
> +
> +	sleep 1

When I ran this test case on my QEMU test machine, it failed with the messa=
ge
below. When I repeat the test case, it sometimes passes but fails in most
cases. I guess this is because my machine is slow and takes some time from
the disk deletion to write process exit.

throtl/004 (delete disk while IO is throttled)               [failed]
    runtime  1.085s  ...  1.997s
    --- tests/throtl/004.out    2024-04-19 11:26:56.507007360 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/throtl/004.out.bad   202=
4-04-19 13:34:03.766045990 +0900
    @@ -1,4 +1,4 @@
     Running throtl/004
     dd: error writing '/dev/thr_nullb': Input/output error
    -1
    +2
     Test complete

When I change the "sleep 1" in line above to "sleep .6", then the test case
passed even when I repeat the test case run several times. This changes add=
s
some margin and will make the result elapsed time to be round up to "1" not=
 to
"2". Still 0.6 second delay on the wait process and 0.1 second delay on the
write process has the gap 0.5 second, then it is ensured to be rounded to "=
1".
So I guess the sleep time 0.6 is the valid number, probably.

> +	echo 0 > /sys/kernel/config/nullb/$devname/power
> +	wait "$pid"
> +
> +	_clean_up_test
> +	echo "Test complete"
> +}
> diff --git a/tests/throtl/004.out b/tests/throtl/004.out
> new file mode 100644
> index 0000000..03331fe
> --- /dev/null
> +++ b/tests/throtl/004.out
> @@ -0,0 +1,4 @@
> +Running throtl/004
> +dd: error writing '/dev/nullb0': Input/output error
> +1
> +Test complete
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 871102c..f70e250 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -30,6 +30,21 @@ _set_up_test() {
>  	return 0;
>  }
> =20
> +_set_up_test_by_configfs() {
> +	if ! _init_null_blk nr_devices=3D0; then
> +		return 1;
> +	fi
> +
> +	if ! _configure_null_blk $devname "$*"; then
> +		return 1;
> +	fi
> +
> +	echo +io > $CG/cgroup.subtree_control
> +	mkdir $TEST_DIR
> +
> +	return 0;
> +}
> +
>  _clean_up_test() {
>  	rmdir $TEST_DIR
>  	echo -io > $CG/cgroup.subtree_control
> @@ -46,23 +61,32 @@ _remove_limits() {
>  	echo "$dev rbps=3Dmax wbps=3Dmax riops=3Dmax wiops=3Dmax" > $TEST_DIR/i=
o.max
>  }
> =20
> +_issue_io()
> +{
> +	start_time=3D$(date +%s.%N)
> +
> +	if [ "$1" =3D=3D "read" ]; then
> +		dd if=3D/dev/$devname of=3D/dev/null bs=3D"$2" count=3D"$3" iflag=3Ddi=
rect status=3Dnone
> +	elif [ "$1" =3D=3D "write" ]; then
> +		dd of=3D/dev/$devname if=3D/dev/zero bs=3D"$2" count=3D"$3" oflag=3Ddi=
rect status=3Dnone
> +	fi
> +
> +	end_time=3D$(date +%s.%N)
> +	elapsed=3D$(echo "$end_time - $start_time" | bc)
> +	printf "%.0f\n" "$elapsed"
> +}
> +
>  # Create an asynchronous thread and bind it to the specified blk-cgroup,=
 issue
>  # IO and then print time elapsed to the second, blk-throttle limits shou=
ld be
>  # set before this function.
>  _test_io() {
>  	{
> -		sleep 0.1
> -		start_time=3D$(date +%s.%N)
> +		rw=3D$1
> +		bs=3D$2
> +		count=3D$3
> =20
> -		if [ "$1" =3D=3D "read" ]; then
> -			dd if=3D/dev/$devname of=3D/dev/null bs=3D"$2" count=3D"$3" iflag=3Dd=
irect status=3Dnone
> -		elif [ "$1" =3D=3D "write" ]; then
> -			dd of=3D/dev/$devname if=3D/dev/zero bs=3D"$2" count=3D"$3" oflag=3Dd=
irect status=3Dnone
> -		fi
> -
> -		end_time=3D$(date +%s.%N)
> -		elapsed=3D$(echo "$end_time - $start_time" | bc)
> -		printf "%.0f\n" "$elapsed"
> +		sleep 0.1
> +		_issue_io "$rw" "$bs" "$count"
>  	} &
> =20
>  	pid=3D$!
> --=20
> 2.39.2
> =
