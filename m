Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F9156C6F
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702955; cv=fail; b=hNqt06AdRvBi0cB6aL0P+OQmWScxiFula7k35nSZfdH61oYS1LELL2pUXDzyo8jA1C/0KXGy4A88ZG/TRO4195G2Uflhq+n4m2YXLMMxNWYfRlF42Hnrx+voTiaINYEtO1jCRf7YEQubQZt9B3np4/ejKNBV3av5vqTbru+dCGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702955; c=relaxed/simple;
	bh=hafRd6pD9cGSdYbaycm4wZWZ5ginyI+lus3JWx4FqxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HbZddNrrfZaNTqQTG+9+E6bQqtZMwX+2WnN8oc6h5nRODZv+28RPjEu6ZQkIPZqA9WhmhnQavf68ZtEqv+3wU2PtWnykf7WbfnpFZOwdqm5OuOyPImSIFYLzEW9VZzSomH//BKy6j94h1CnboYMA+gjj+5RJdCJaLmF5bssjdU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nZzy3zdP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NyOgVjWM; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nZzy3zdP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NyOgVjWM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718702953; x=1750238953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hafRd6pD9cGSdYbaycm4wZWZ5ginyI+lus3JWx4FqxQ=;
  b=nZzy3zdP3DWBtQ0IwM/BGa1+lCKL+fs4zDH8mayd8Pr5mXK7rq2QvyBQ
   byhNOtWbB51f+xYLRZU+Is/rh3UxG3yZY8bRni/uTYB6lPWt7soCg4tY4
   r+BQDLGGClEX0MA3b9hIXjJGM22ejtqp1noNNC1lIg2Qbe6poE0/O6+Yx
   8FU7Aehv62W3kfNtiDJ+U9Xudg0QGsjC7lzzFfNgqUykHBUS1uHTFBnXC
   L5tAnn2YB7nsTygoXhTZUge9ncDWFrPQiSdzxAIxKIRZsx0jg30WT6ZbY
   35qWR2McqkUBk7bqxL3eNvvFqOSAlgOfh+oBUvMIAYcAtyIdRMlLG9VrW
   Q==;
X-CSE-ConnectionGUID: EaR/Ps7wSLiMhjHZsF7Csg==
X-CSE-MsgGUID: D6buPmV2TfCAI+pT9nVOvA==
X-IronPort-AV: E=Sophos;i="6.08,247,1712592000"; 
   d="scan'208";a="19362457"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 17:29:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTnQJPb3FKYGTI9/e9hos5dMwayOD68s35tLV79/iedm+nPRAunM+ifNcv6a9zGlo4YWiy0zJSBUJcFf3INGO76NkmqQw6kN8Rc0lvzpJtIDaU9GooRajF4o71rZiAy2dK0ye20F7KmtFIftTSfINebrQHWRU0Qb4Xju402XNHcd0WG0mmC3qF6fAoxiuga5H77Uv0o6mZOvDZfbe9nHNlC12q9CEIaUwe+DSS0RyqjPwl0r+2LeYQl/qQ8BGIgscW9UAufgwjJUi3oVmYaq764cAF3hC9HBgz5Fk5yOWR2xHlcbwdVm/3EDGZ/Jawgj2GZZnqR6TBJX4EAB52KIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obkkh3VmLuLx4bRdPQ12yKFNDHsAcW3TVen91N9cmAU=;
 b=LefxntaiihsGCsbD5hLSVGbAEGI7ZJSF7cat9GWyAXHIEvkaGKO9qL4GtG9fyPxpGDQHMgp1dWznWDbhwC9ZZ/wZtBAq2JLm3S7jc0YX28uK9Bqfu8JDep9TkYhdQhfy57oVv7br3a0IWgA4aj1R1rI8F6Vh65Rg7JbqVaMJsmn09Exham77/hFn9wGFnp/v+gxLJfFOUzxiCxJmobIZtCE5KZLrmrBUcK4tryzs/3Nk3Hj+2P47OUQ2lqWca+HJNVai9UPlIv5C5OOCBwjRcWallREoAwMHqI8UlQ48ql2J8CEIWacYntl+Zjm8odB5GNM+fwd/I/Mmi+pGqlGQdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obkkh3VmLuLx4bRdPQ12yKFNDHsAcW3TVen91N9cmAU=;
 b=NyOgVjWMowpETMVyouDn/MBi0JiFrVZAvLfE5pzXczmJqUtND/8nBtMJu7T/16aqnzJdQEbVD9AgrhPMJWVtYS/XOq0fxllpd6LCigTzXm5DEHoFx9X4vl0h/0x1drDtFqHsxN3lrTg6S1Nhs2nZr+ST2pJCWk9OZaL8piiCbmI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9410.namprd04.prod.outlook.com (2603:10b6:610:23b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 09:29:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:28:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Nilay Shroff <nilay@linux.ibm.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>, hch <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
	"sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] loop: add test for creating/deleting file-ns
Thread-Topic: [PATCH blktests] loop: add test for creating/deleting file-ns
Thread-Index: AQHawJe3Nmk9VXdTPUa+gt1SehBfeLHMvkgAgACEboA=
Date: Tue, 18 Jun 2024 09:28:59 +0000
Message-ID: <6jp45jz6ms42ue7eeto4ogjt5c3rdrlzc2bxmxk5myqg4x2hek@bir7rijdnw6c>
References: <20240617092035.2755785-1-nilay@linux.ibm.com>
 <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
In-Reply-To: <d0f6e41a-4cd3-42b9-865d-df75d3ffd2af@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9410:EE_
x-ms-office365-filtering-correlation-id: 779ba9ab-4e10-40b5-ecaa-08dc8f7915bf
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BD0fYU9Noiw19lIfaRkwjKzCuSlbyUPM7gbnwtMPgJ2C/FEcVJ0CFt79tIQT?=
 =?us-ascii?Q?nmC2WMCrchIgsD0xu6rDRT6VF/FmeyWVXgMkJYsuBX9hyTNocdFxD6S/MfJ1?=
 =?us-ascii?Q?QVk10VBXhhzq6GR03P4CnA8mKGvFmOQw2cUSCXOJowbaaDLnv9wRBvpF2mrt?=
 =?us-ascii?Q?As1BB/6YHszFTsKyhZrQ5TKt3kpJMTdF9SFGPySlWooSnzciZ3w0juSsIVsR?=
 =?us-ascii?Q?4MCBTZKraxc2nFPcrwMosyxlDtnIGIZBpwK0LKOvd0/UwzDifIgmMZNtnDH3?=
 =?us-ascii?Q?40D6gbj8agZGgf2G5TYGcckbpeV9x81vmhUGVHpZ5pNMqCD6Cj5r6RGn05u1?=
 =?us-ascii?Q?kWLF3oT4XuUkF15alinXiJcEMPg69By/+/jtf9ODeAWJP8VzZ+tPFUEU9OhT?=
 =?us-ascii?Q?uPr2ud2I3L2jWlP/NssAmCF3m/cfQnHcsn4tz+XdhuJyHvw0JNaQpc0eUzbf?=
 =?us-ascii?Q?lXLSRrRDGqvuFzai71YQuctl4Zj+p1mnHkD23Ml12OUZJ+lY7Ppb+sPH47UQ?=
 =?us-ascii?Q?raaqUpp3guaZoE9+kFkgdJrhlsyvm1Dv3BRWZUP+YAzZThWAAiQYu4Lw46vM?=
 =?us-ascii?Q?2JnErQS1tIbliOmv2YU5qnWbpjaXxCKEpgnNdU6MfIZqisPo7WoZcchiSuYe?=
 =?us-ascii?Q?ez7s18ayBlA/eujzFD7E8AkE0IV65W1MbhT3jKRJQIpLo8FS1WmVm8vp/cuJ?=
 =?us-ascii?Q?zX4ghr6pgJapewma5q00Klopv4VjkbadAcZ5xrrT2bH0My/eTGl9t2jFyy5M?=
 =?us-ascii?Q?vVqMmovdAiTiXzj+0YSfy8DmiY0x86+n7njuVcAlVar79G8IBDNHzF8vGYjP?=
 =?us-ascii?Q?7v71uLv52GVPRkJ35Z8P43p8s6lgeGDZjn2XXeETbRFQ1hoyDaxEellFpoOP?=
 =?us-ascii?Q?Jsg/wyEEZWPhpZ2jhhnjkog5r5uO6bL+LSjjADtYDZJCgqKF6fQXE5pOqLP7?=
 =?us-ascii?Q?3Wpm5YXycT4Cu/ees9MtlSG9k0L9Lb+7bVDrlcZLmUjXT2Elf/I5UUQ6yfi1?=
 =?us-ascii?Q?xSMrLyfE5ciCYb4OCcynw30w5epK9oSQe89YvZwKL+BO78oogVljqWEM33/J?=
 =?us-ascii?Q?w3SQebSAl+NIMlgnEWd838aS2OLtWo5kuBOhAEFJMly9N9EWgQn/QrVf9ZYP?=
 =?us-ascii?Q?T6fjW4/Ywemo5KziU4sLmKnzTcIQmvGvTenKTn9fwibcENLVVaQPH4TMdEdA?=
 =?us-ascii?Q?k1NxJexilJcw7SBi2zqz2GeKX3t6IdlaM2EGRaQOm0I1iGvUs77SLHIKBtsW?=
 =?us-ascii?Q?K+nbg4Lak5lScRK2CWGpAItxVZXs4ilpqowr0yNO+lTutECn+lYHrPjxTvj4?=
 =?us-ascii?Q?wwprZLiDKu/iKABJY/LO7Mxt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mkLKalPiIos5SAdF5YoPkf65Q23fRBZxXqR9cZp5s1vRLAR7oHbcOvi5KbXK?=
 =?us-ascii?Q?76hK01T+RexyV77XTpGBFLX2CD2hvA3Qe1BCULllKEXhjczxj/taRKKyKtfX?=
 =?us-ascii?Q?hcq5oejJTZiX2YeXNO6JI4ezswFJkwsoi9CmeyImNQci4Oirp50Isbnq0sQM?=
 =?us-ascii?Q?ApDCHHweKX0xu+C+fVLDBQhMyhOZ/NUDAc/Ohmfoh/ax4RDKsaaGbL8Kyn4r?=
 =?us-ascii?Q?HCRskF+nITI9I5Bc4lpk/oc0D/0B/0ez02RkUCgrXsXwaRwtdfSGzASsnrmH?=
 =?us-ascii?Q?KZXIBs5+cDFQL5u6XpWZ3hCJtWRprtPwP7rQbO0kz2jea1ZT2EktHtHY2UvI?=
 =?us-ascii?Q?egYwODS1ZYEjPlBflU0A2JzidKerhfzCSuZK0+H1jZcrhBM3wbBhOzwzDPo+?=
 =?us-ascii?Q?tAGuNhidjHAjrQz/i6ZAbSm7riVQzDWPzJeaFB+YfdPaPJZ627c4xG1bZia8?=
 =?us-ascii?Q?7onXR/XhAutKEh5Q5MiCCQ/FxtyzHphSRLuk/ZXTE+yjnF8jUmKH21xkf7mW?=
 =?us-ascii?Q?ctqMOWLwQ94yZiefETtizVXHTzZic9yhlFPvLYU+qZo2SVNn+7Fx7KZEuE+u?=
 =?us-ascii?Q?JzExrhH036786f9XuDYX+6jD9moIxYwZ1bnDWq+y+K9bfEX4qVEcnqMBwyLJ?=
 =?us-ascii?Q?e3eNpPZzvrWEFi1STdIbOU3rEbAW3LLBY0Eyer0BZ/v3zkK8GpvS5XZKO0ZQ?=
 =?us-ascii?Q?yaKrTNn6Ys7IMHr1E4+VYYF8ncogjaYjO/EX80A7TXXH+U0/Cb5KK3aX0PZK?=
 =?us-ascii?Q?tML0hCxXLYt/B3Mq8SjEKqXD+kbcC4302iRgXOwJNxwm1piYfdFWCsBfdx/t?=
 =?us-ascii?Q?dgje3ZftcilghHFan3eJVlSxHUskBDxVg99kXMKw92DErdG1Skhzrf0mZcU/?=
 =?us-ascii?Q?SoMcrITh76TxI/p8VGLfgnJCmaqZh/qR+Xb2oS5gWT06e8+bT6TRvsYWYLEl?=
 =?us-ascii?Q?mpEAP1LISfWgjRmwskbYJVTGESnUWv5UxNIiJdFau2uduxGagf/g1tXSHYi5?=
 =?us-ascii?Q?FafGBYAj7FrzxN3vr8RrYsMvkbgJ89zzAUQHFVHcEJqP8zrhV9TppJagYanP?=
 =?us-ascii?Q?nCxXORfGa0ffPcj/SjTSr4YXJxkle7HGDmDJSN36Ub5kMgi6poaJapwQVa+5?=
 =?us-ascii?Q?yKpaeQcvkviCF5uQkf6zAdKbS+OJ4klf6SNjGf166mywHafKb0/qVpNUhnUC?=
 =?us-ascii?Q?iYZSU1rHSfFlAhAwUJZAOU1zRt1xJOnLnWuA14EdA/4OiTdKCZhVPhaGVbdC?=
 =?us-ascii?Q?Mn+66w77Bhq/IHBnqIPE2DKlTCiiCX1oxCPBlFqJpIpKYCE8MEu8GLW4lsQ/?=
 =?us-ascii?Q?QXD8mosS2zpP1vCBbHmcG4dDyz/V1IFL66roc1YcrC/C2V3QtaBbMPRcqQB+?=
 =?us-ascii?Q?MDCHBbWi64NklkQ9etmLWmqXHukYFFrNy5sm81CwyTMAY0UNXwo9GfF2cHz4?=
 =?us-ascii?Q?hZY9EM8mSlOGNCRYIjVSKXzlYJ/wiIsUFLbTmi6EhR1otwFP4ql2rdj/73Qd?=
 =?us-ascii?Q?tyj5nmPS3RNiT++99ORXfegphxzIwy9RwAKwZhIoyaiVPGWdMvW7J3FIZEI1?=
 =?us-ascii?Q?KLxh1SqtLEJzQgxowQJfItx4D+/TgB8coyG9U1HRYQcoUVdJ5khGlk/P0Eih?=
 =?us-ascii?Q?lP0Q3iQPUUSy1dtTXH+rBzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29082A8F6BBE194CB6BBB2834AE95E2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UDwGzic8JEmtFFNGZVmKsuc8kiy9ZCZlsvX2pOjS4coZ35z7v/9/dR81t1stiKiR85qc/E7GuqvQWCMe3NNxvq39ExDrJKmWjuDOxKB+9i6yzr2jwQtMin9oyGIlCE1q8NpG39vsI+Sr1irTgjkPlh1xFN6pO5oLQiH2mgoXjF1i12TwdA32nZURH+HTjY9+v9iwVB0yO7gPkP+jeAUCRvaVah5u7GV5YYjiTb8Ya1N/1EkPasrWyvfzKa1uM22D8O2WDXj2V/qMbNwZVyuka3yFg0XtEhcCq0Cax1degSr4+4Ax/ts+LAwI5gxddwwpBvFZnkMRxysv4mcbJaHQSVDFSyASK+t6o+I1Q04eue2gsXpZvrgvlzpffv21/rCVrZ6qLlESux7GBAiIzDeO4q1egAE/1ylXd0WbAJ9tvERkFmQpQ8RsP0cFWDvvje9Q1b/C3fajOlageNn6OaZx3T83CMxcTwQkxvv7j/POTn98CObY06cYszzIDbVo6eUhJ/AdSM3/UVzXBcLzJZ57+ZfRdsk/A5VrCyg2sMipY7VtqO6zrGbRmVQ46sNqDmISsywlGWj1XEG8F2cYKyOfqBvCTTI6DEzUu2VzetqDenmKIuFa95A1UU1/RzGJL63G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779ba9ab-4e10-40b5-ecaa-08dc8f7915bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 09:28:59.8299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9b3qYCA/61vHW3lY3TZoeS7DmPKU92cJG9R/Cx1DB/s49bX4bS5USPoGRczQhg4nUQIG/KUavaR9QrFjfPqSe6TvcA4eNqzPn6wIMGO7Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9410

On Jun 18, 2024 / 01:35, Chaitanya Kulkarni wrote:
> On 6/17/24 02:17, Nilay Shroff wrote:
>=20
> I think subject line should start with nvme ?
>=20
> nvme: add test for creating/deleting file-ns
>=20
> > This is regression test for commit be647e2c76b2
> > (nvme: use srcu for iterating namespace list)
> >
> > This test uses a regulare file backed loop device
> > for creating and then deleting an NVMe namespace
> > in a loop.
>=20
>=20
> s/regulare/regular/ ?
>=20
> nit:- commit log looks a bit short :-
>=20
> This is regression test for commit be647e2c76b2
> (nvme: use srcu for iterating namespace list)
>=20
> This test uses a regulare file backed loop device for creating and
> then deleting an NVMe namespace in a loop.
>=20
> > Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> > ---
> > This regression was first reported[1], and now it's
> > fixed in 6.10-rc4[2]
> >
> > [1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@li=
nux.vnet.ibm.com/
> > [2] commit ff0ffe5b7c3c (nvme: fix namespace removal list)
>=20
> it will be helpful in long run to add above information
> into the commit log, Shinichiro any thoughts ?

Agreed. It is helpful to record the kernel side fix commit and the link to =
the
discussion threads in the blktests side commit log.

>=20
> > ---
> >   tests/nvme/051     | 65 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/nvme/051.out |  2 ++
> >   2 files changed, 67 insertions(+)
> >   create mode 100755 tests/nvme/051
> >   create mode 100644 tests/nvme/051.out
> >
> > diff --git a/tests/nvme/051 b/tests/nvme/051
> > new file mode 100755
> > index 0000000..0de5c56
> > --- /dev/null
> > +++ b/tests/nvme/051
> > @@ -0,0 +1,65 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-3.0+
> > +# Copyright (C) 2024 Nilay Shroff(nilay@linux.ibm.com)
>=20
> not sure we need to have email address here as it's a part of
> commit log anyways ...
>=20
> > +#
> > +# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
> > +# namespace list)

It is also good to enrich this header comment section. Especially, the kern=
el
side fix commit will be helpful.

> > +
> > +. tests/nvme/rc
> > +
> > +DESCRIPTION=3D"Test file-ns creation/deletion under one subsystem"
> > +
> > +requires() {
> > +	_nvme_requires
> > +	_have_loop
> > +	_require_nvme_trtype_is_loop
> > +}
> > +
> > +set_conditions() {
> > +	_set_nvme_trtype "$@"
> > +}
> > +
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +
> > +	_setup_nvmet
> > +
> > +	local subsys=3D"blktests-subsystem-1"
> > +	local iterations=3D"${NVME_NUM_ITER}"
>=20
> no need for above var, I think direct use of NVME_NUM_ITER is
> clear here ...

I ran this test case on my baremetal test node and QEMU test node using the
kernel without the fix. On the baremetal test node, the kernel Oops was
created soon. Good. On the QEMU test node, the Oops was not recreated, and
the test case passed. For this pass case, it took more than 15 minutes to
complete the test case. I think the default NVME_NUM_ITER=3D1000 is too muc=
h.
Can we reduce it to 10 or 20?

>=20
> > +	local loop_dev
> > +	local port
> > +
> > +	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
> > +
> > +	loop_dev=3D"$(losetup -f --show "$(_nvme_def_file_path)")"
> > +
> > +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> > +
> > +	_nvmet_target_setup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
> > +
> > +	_nvme_connect_subsys --subsysnqn "${subsys}"
> > +
> > +	for ((i =3D 2; i <=3D iterations; i++)); do {
>=20
> small comment would be useful to explain why are starting at 2 ...
>=20
> > +		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
> > +		_create_nvmet_ns "${subsys}" "${i}" "$(_nvme_def_file_path).$i"
> > +
> > +		# allow async request to be processed
> > +		sleep 1
> > +
> > +		_remove_nvmet_ns "${subsys}" "${i}"
> > +		rm "$(_nvme_def_file_path).$i"
> > +	}
> > +	done
> > +
> > +	_nvme_disconnect_subsys --subsysnqn "${subsys}" >> "${FULL}" 2>&1
> > +
> > +	_nvmet_target_cleanup --subsysnqn "${subsys}" --blkdev "${loop_dev}"
> > +
> > +	_remove_nvmet_port "${port}"
> > +
> > +	losetup -d "$loop_dev"
> > +
> > +	rm "$(_nvme_def_file_path)"
> > +
> > +	echo "Test complete"
> > +}
> > diff --git a/tests/nvme/051.out b/tests/nvme/051.out
> > new file mode 100644
> > index 0000000..156f068
> > --- /dev/null
> > +++ b/tests/nvme/051.out
> > @@ -0,0 +1,2 @@
> > +Running nvme/051
> > +Test complete
>=20
> thanks for the test, I think this is much needed test especially with
> recent reported issues ...

I also appreciate this patch. Thanks!

One more request, recent commit added a test case to the nvme group and it =
has
the number nvme/051. Could you renumber this test case to nvme/052?=
