Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03852F43
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341865; cv=fail; b=Uv7QwQrtrLZwp35RR2w/tHlj3oevNdk3fE3BIE6ODT0FdETLj9OAnySHgaJCZTGQ6X01eY3GsxvHtik/UExNVOCtb9HLLx0yUiCqQLSpavKxPJwiena8VWrB1UHoSpXkKnOrZqfnFeZVwkAUEMkOgi1FOkqgl4F36LlorclXqfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341865; c=relaxed/simple;
	bh=ZgPABQeoSBKI7t0ntmz7QD3Dn45rufnJ+Qg/JemQnqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/JlH5QEbdw/PnB+p80GhjYA6O+aRCU6QwQzEAztOaFxtyqAqnALFOJKD4unMRZ87paqLhCm7kootGQoLaJyzkijuQREevPMD7G8fG5ODXwPa+r+yigbjo84FrQbNuwnkeEQ5RxZSRm0BkE/0kXATjmSzl7pORWT0ozYiOoUkrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GQdjDqyD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=AUseNluw; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GQdjDqyD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AUseNluw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718341864; x=1749877864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZgPABQeoSBKI7t0ntmz7QD3Dn45rufnJ+Qg/JemQnqo=;
  b=GQdjDqyDGaIFwv0wYwRyEQIkcbGGrUFxfXrZxsmSUztOMtTjZwCsyYuR
   36z8aQDObdA/6ymM3sSV4VN42KCnBN79K2WBrm/N8xxj6WMmVuHuFk/Nh
   3lSFIjLNqtuHawT6UTD1nC4JLX6rlEnk84sOhFbgh3ZPPwhiHF38JUowk
   lGmmx44zze++lSR4n4zbqdc3xqE+UPj2W/IQMX5WF3d1CuBgIDcnUomAW
   +ROAJ0wOkRTRDUoKx9+e65M0g71BCRUyszMQcIH/hfYWa4wPFW29mWGiu
   ZHaWuIN0R/IBhIEUTkJllX+tJrdLm4zqt4UH64L7hqCAEPx6iFkpaPT0K
   Q==;
X-CSE-ConnectionGUID: MPKSrTM7TKa94EY3hp37gw==
X-CSE-MsgGUID: PTrjH1oBQ4WhE1K2p9y4gQ==
X-IronPort-AV: E=Sophos;i="6.08,236,1712592000"; 
   d="scan'208";a="18815919"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2024 13:09:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/YQmhnxjNd1UN6X4csQ/m0KTugrnJ1dRkjefj50vStXYRQ5IykGbcR+5ijb+zgeIdQKwdSu6hEDRzhwrsnbmWNwvsYSvW/9PyL5Ij3eziz7ejpMAXQ+I++3ds/YRB00wWjhz7UIqm2OPbZjo4oRRKZrph+jccByVerMOXkTQ46WTOEfIdnyAyKBeMLzC2IUpeYfc9IElSGHNgGLI4Ovdxdhn9knIebKN4AImA3NVSGiolI61t9GLfwpyBs+XB8viDrzJ5Leo2kwci3stN2eBHMkVhOaJGBSqO+rYMF1aC7rYPjh92OUZpwZaSKc6yS2+LnGunOMVcPgs8rvXvafrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkyhftn9JkXnYgmeUuYdj7RIDZBEk8zDYEZJjZFJ7G0=;
 b=obz7jeQs6ILzZnlPS7/WK3LPspoEMcW87Kfr5U+NZbQassnYuG9ad+uFUcsh30GOfVcu+jb1D0qJ7R0phf+lVuElgUyRo8FV7wOR762R4Px9VQktgMRBS7JQS7u8n+0qo+BFNTpynd2RcnFyidnCf7I2e7XmDR021JSKchiVywbjbOHx4JzK+dGffjGTy8sLH89VGG/Nb2/HwL9vWQsUr2qpmkoh6+va0F17056lO3T3HaNIcSlU0no3KfXQ/fo5Bx7wYjOBYNAUrH0bXGdjXX5RL3iAgo9+um4mxsr9BznxgiEfdhRkRYbjku/M7xgWBnFWq53JlIhL1MJ9K0RhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkyhftn9JkXnYgmeUuYdj7RIDZBEk8zDYEZJjZFJ7G0=;
 b=AUseNluw17r3Umo5muQCebbmGd8EhxK7JJ8MGrCzP8pQ/xAWU8XDL4g0YVa64P5Obtm/8fgXyJ+dT27zc9rc3eywnNyvdokWezf5C2wpbzkmsEvmDFO9mQ2xa2f7PjUhgqDHIwbO9doKLG2Bpxs+SnpnCENwPkZKAOZguijcfbo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6678.namprd04.prod.outlook.com (2603:10b6:610:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 05:09:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 05:09:50 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC blktests v2 1/3] nvme/rc: introduce remote target support
Thread-Topic: [RFC blktests v2 1/3] nvme/rc: introduce remote target support
Thread-Index: AQHavLhb6A74pYtrNkupeK7VR/QY77HGuLcA
Date: Fri, 14 Jun 2024 05:09:50 +0000
Message-ID: <77zwkxlvyp6sxfhosdeylgmcamfafafgxy3uzzipt6lbfnzl3e@wfxckfkkd2nf>
References: <20240612110444.4507-1-dwagner@suse.de>
 <20240612110444.4507-2-dwagner@suse.de>
In-Reply-To: <20240612110444.4507-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6678:EE_
x-ms-office365-filtering-correlation-id: 1e11e34f-bee4-4f6a-c110-08dc8c3037bd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5tk6roxhM2lct6as6h9wLAY4Ov4j+FyxKvCGKEC/ol7YTbnVmRWn4TJXVR1g?=
 =?us-ascii?Q?6QHo5ioo34CCec/1Db12D+hFtFlxjPFv/42aSwc7nBV4YkUKRmdeVcfRfLnh?=
 =?us-ascii?Q?JbpNX8Fn027yOreIhJbOnDpSQJgY4GJn4Lc4BqE1rspEj7P6zKrlKxPtAo+J?=
 =?us-ascii?Q?s0fhMI6uzRTfI3RfOCalFf3wzJJ6ChLYozK6P18mPFL6OvyKVAoOQqKYXAei?=
 =?us-ascii?Q?GRQ6MeC1jPGJEdy5vi7FWb6ZYgrktMIWTYoD/EcUNdYfZvI/wXjDZy4QMSof?=
 =?us-ascii?Q?dn3YvhCQVBuPveup7wYCYm6hp7e9khKFPvpJdMEfuI4HwQZLgiILxq0OoySN?=
 =?us-ascii?Q?0vGwSsTCV++1sYQr2D7tycNgezTqa/sz3CX5koBLCzJJyQc1Ifb/8y1CW9W+?=
 =?us-ascii?Q?jreVgNg6F3bj1q6zJl+87LXNQio+LbrrA3cYWq90f6UMRKa219VDohs9Tblb?=
 =?us-ascii?Q?gImBOC+ti+uBpXDYXUowyn4ZxZVISK2R1+q7VxAWpHP4AgZ0XYo7DfyjP8/E?=
 =?us-ascii?Q?Y9F4U0//TImoNDOxrUYU9zZQWSt4wrgt/haShaQdoszJrBa0pm+XrS1nMgxH?=
 =?us-ascii?Q?fFJ8a4vqCfO2NmtxnOx5qa6pqiAm3uP0NNLK77pvAWg03WHSyKwn5UmwzOe/?=
 =?us-ascii?Q?7jeBAvXEkaDhc0s+bdmq2k5c6SgGlg0BDe+fPpTEWtmyOcrY4uRIZ+SdA0do?=
 =?us-ascii?Q?jt6oAIj+EL05ZIppjGTxf+xPRteUEMf94Rr5mZ+t4TSRMoZ7qxdl4Qpxdrna?=
 =?us-ascii?Q?E7J0L1VKnM95ra7/1zOMV/WACA61uE+8of7MllCT8ODqBq2q/zDO4+B0dCWs?=
 =?us-ascii?Q?Q5UvZ8rylmOmWrtz+Xgou4Ih7lVivOAmtCL0xhaUakhJoQDPPO0H4SU1PGEw?=
 =?us-ascii?Q?Y4H3xLulMhpHuzAyLj4it3GVQ7YBWougxeS0S+lIxAiUGD8aGqkViblzc6Yj?=
 =?us-ascii?Q?HpM7K3uMolL//fP7bToxir7s++Tkq0DEcXBE7X5DvvTk/2eRS8F+D/jqojOB?=
 =?us-ascii?Q?7NNh6UlBl6K2PZWwDIOdljlncB/JsXUTdjp/qYGTc+s6Tk0+CV164J5OMGBl?=
 =?us-ascii?Q?kfZd7IyPLOMgZcEsGs/pf2bE+Brc3119oYFPxI6Sgt9w1cEw+vo5FuDSmoqk?=
 =?us-ascii?Q?iuUNYbYHbpOOb+LeePrOKhUk37Few2mURtIiLHH1RS8qZbDywFmF0YPfD3+W?=
 =?us-ascii?Q?Vofikk3iCDoP/rBeRhayy/9jQ56avo9IWSc2VO8As3iajhHf+6uWiEiAkUR+?=
 =?us-ascii?Q?MMMvygYbo2jjsdTWVI/gwa2WFpn1EQX8DTXrdrzn+N4qNNuN9r0H6fMGkpVm?=
 =?us-ascii?Q?t+3Z0yu6RJaTEZs1F7fpCLH1lTfkGWdO5c34Novv8KpfBmZ3p3BvstG3KWTn?=
 =?us-ascii?Q?2c76/kc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gN40MAvX8tFu31hJg9cU3JwRd64etCJfvNqyMETJTMNDbzLlTz6FXfG4BplM?=
 =?us-ascii?Q?g9czkU04iEMjG/u2K7zb7gToZqyISLT/73JTYSHpUyr4StxZSOIgK0jX767y?=
 =?us-ascii?Q?EBSj14tEoKjmxnRgnNJF0DyJZAWhO2oD8mJhpvEieKac9Mhky2fAMGousipB?=
 =?us-ascii?Q?neQcc56/M7sXjXhN2QbV7dhxj28X0eDdDBNvVMLHYKvDFag3oWPtCBJvt4wW?=
 =?us-ascii?Q?SM8bIevL5LzcX+japADGiD6mNMDWAP/wAgeJaH3JtzhxFXAecV9Rr/tQW9UA?=
 =?us-ascii?Q?cEfV9RSGwU9iIz4YMN6deblgJDiJWOUUz+RItrOBt2tzBf6a3EM8mpj93ZW2?=
 =?us-ascii?Q?D/rziyeczs8IoPx29UFTWdK8F2XzR3qn6poUvXk9UxyI2tIPtRl56IozTu+R?=
 =?us-ascii?Q?2BhfrN8dimcuZOan7CECnM7oBjfH1Li9C1QQZMqpsOU8CfYOqd7bBZUG1Qii?=
 =?us-ascii?Q?Rf9ZYf5gANfBEGD7sFXWXvUeEgT19ykCBnAVcloY8CDdvu751fCw3DnZP6tq?=
 =?us-ascii?Q?aFy03IT2cdfY7pNgtVg/jKCUIqxGGkFb1fOJsbIZ3bd9rRpwyTkNBBzA8LoE?=
 =?us-ascii?Q?6XskS251QAPRVXuR/VVOuV1YcnVF/B8RqAwAU6DVPmXlUigHxs4YHX/LEJqp?=
 =?us-ascii?Q?mxeNIluzWYgkMxJe1R3JOon6B14hOEzZyzAdS/ckWrB1okLjERmeOLNwBgHm?=
 =?us-ascii?Q?M01HHctqX/MJAH3VX65PxqqoMaPI1eHL3fGDfvKJtAs7A3QsKMumnqTW7aqb?=
 =?us-ascii?Q?v+uc0B29mGWyrYEaiof+7dUzlm4OeUY4n27mcTD2Xs9yVMaqtd/p8JJF/yGR?=
 =?us-ascii?Q?PK2x15/eIJUoA5W2mGBC/eG1ACu5Gs3Z6sivFG+xmsQkzyvR0qmqQQtMKh9P?=
 =?us-ascii?Q?jEJxBjf85WrqOKIyFgsTt5wZ373ExsTZixOfh4K2SyePRWgi3m+/nHymhF3n?=
 =?us-ascii?Q?CvLtFLWd3mgPDl+K3cN9nhY18XLtWXup1JitNp3f+pF2YOrEa4XjBYI49vbT?=
 =?us-ascii?Q?9pdeoHK6XgUzEZm9Y2mhq64aMPdehIDmtSvBOT44wuO4xR78SdZ9MmAckAh/?=
 =?us-ascii?Q?n6dG4YOmXtMTC1+VcJ3lOXP1NjLmWI09vMPyRULO8DPkfwleNAEERVadDU67?=
 =?us-ascii?Q?lQkbFa0u0Q8/pf9cAorWr8Wd/4kKI8AoM6sp135mrBBw5ttGYy5AaKtpoYIQ?=
 =?us-ascii?Q?2zcOFN4pxgsVKS7hyb4UJ+VLcbMrVrRqcyU7njEov/l8zzO/6hF8qv/RGm8j?=
 =?us-ascii?Q?mb3u8sHxQix3byDq1KcGMgfXE+o0nhDe5O/RWzffQjYTbBAUaaUFNJ4kFi81?=
 =?us-ascii?Q?yp4ixEsABgc7mNf9sOIVih2i9Dk7Le/ZGiRLin+eZTUVSnQSaQ3yBRyDGVDj?=
 =?us-ascii?Q?Fyc6a5QZHp60W30uDryBdbn1Pf+7MbiWp9fv923RHt/L3a6Hy3CJ5kSO7VoI?=
 =?us-ascii?Q?94Cp0aJ1kMh6PSQ36Dj/+b2H5XBQ6a3kRYo1mgYto3mPlSrfghKGPujgr6Wu?=
 =?us-ascii?Q?+OHh02moU4F0G1IgJeqmTZ9EggfMMXFKVmGZTWrUZgqb5MxHYKDxW7qbEGKm?=
 =?us-ascii?Q?W7Msqrc3B+Ea3wfk5txTY09v7UwR52DYRBwcZV5MmOoOZ/VoYgq+LF3iDPdA?=
 =?us-ascii?Q?14GHl7oN0lX4WHooi3lLTqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <376EB81D15652E44947345EB83D38F0D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qoInK7eN5xxlp/M1EgPS4UC/04y6WeZvn+l9ct9UXky7+dpVGDcAAgLCZTXekQovKlpeh/1T0JegRT9zZJxWpVmNMW3ffuwRC/cufQt/MchsHR02avpCt2RDJIWlcE0rL8LtxljIvHG+vFUKhYwHtQQLowjoQX1Qf3tKahWU/bqRek5HtZdNekF7jPD8EEi4uS3X95JHN8Hd7a50ViXwGE0/mLm71o/U4RfVw3eVWgUU5dQoHslgB+v4+AKmHJJP3wpe8twJZYvgn8nZGlEL/fWDZRPxBJZ3LFnmZsTOKI+XCUH+19vaCa2oZDPa4R8/11UMb7wTcH6WER0FeHqBI0ezrt0yk3KdkyJbs5agoibEUTfpfBwhf/rfHDoUWnKKPO6373wQTbbDbc6pWnA2Fp6LJsU3KCbJBNl63IhgQ12ivqQs0PkTGO6hZPStX6s2BHP1vKmyak2JBVcJJoEhUG+gfUdxfpkoZDYX2P0kEgvvDzA8pz2Qw91Ki+NSrVdwS5SxerEYJ6PKUmd/nv+4sAhUajQoL75ao/gy3gDvohCxwLMTP5NGcXPSwPj58MeDYFQfDv/b82FKL5MX7fSaoOud4FvsfmDgxZXhEKqBXcuwRuZttYt7I4DXDi2EAKk0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11e34f-bee4-4f6a-c110-08dc8c3037bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 05:09:50.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kYM6h5tVTNhLC2QBDXGrelWDc+RU8O+PM2UuJxSKPv8l6t5i3ssMFMkHQS70fD2X6pmwaPpWrBuFm9G+tNWg/hMBz831x19KNDr1zdd0Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6678

On Jun 12, 2024 / 13:04, Daniel Wagner wrote:
> Most of the NVMEeoF tests are exercising the host code of the nvme
> subsystem. There is no real reason not to run these against a real
> target. We just have to skip the soft target setup and make it possible
> to setup a remote target.
>=20
> Because all tests use now the common setup/cleanup helpers we just need
> to intercept this call and forward it to an external component.
>=20
> As we already have various nvme variables to setup the target which we
> should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variable
> which points to a script which gets executed whenever a targets needs to
> be created/destroyed.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  Documentation/running-tests.md |  9 +++++++
>  tests/nvme/rc                  | 48 +++++++++++++++++++++++++++++++---
>  2 files changed, 53 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests=
.md
> index 968702e76bb5..99dedaebfab0 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -120,6 +120,15 @@ The NVMe tests can be additionally parameterized via=
 environment variables.
>  - NVME_NUM_ITER: 1000 (default)
>    The number of iterations a test should do. This parameter had an old n=
ame
>    'nvme_num_iter'. The old name is still usable, but not recommended.
> +- NVME_TRADDR: transport address. Overwrites the default
> +  transport address. See also NVME_TARGET_CONTROL.
> +- NVME_HOST_TRADDR: host address. Overwrites the default
> +  host address. See also NVME_TARGET_CONTROL.
> +- NVME_TRSVID: transport service id. Overwrite the default
> +  transport service ide. See also NVME_TARGET_CONTROL.
> +- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup co=
de will
> +  be skipped and this script gets called. This makes it possible to run
> +  the fabric nvme tests against a real target.

It might be helpful to add the lines below:

  Refer _nvmet_target_setup() and _nvmet_target_cleanup() for the options
  provided to NVME_TARGET_CONTROL.

> =20
>  ### Running nvme-rdma and SRP tests
> =20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index c1ddf412033b..aaa64453fe16 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -7,9 +7,10 @@
>  . common/rc
>  . common/multipath-over-rdma
> =20
> -def_traddr=3D"127.0.0.1"
> +def_traddr=3D"${NVME_TRADDR:-127.0.0.1}"
> +def_host_traddr=3D"${NVME_HOST_TRADDDR:-}"
>  def_adrfam=3D"ipv4"
> -def_trsvcid=3D"4420"
> +def_trsvcid=3D"${NVME_TRSVID:-4420}"
>  def_remote_wwnn=3D"0x10001100aa000001"
>  def_remote_wwpn=3D"0x20001100aa000001"
>  def_local_wwnn=3D"0x10001100aa000002"
> @@ -23,6 +24,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_=
size 1G
>  _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>  nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
>  NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
> +nvme_target_control=3D"${NVME_TARGET_CONTROL:-}"
> =20
>  _NVMET_TRTYPES_is_valid() {
>  	local type
> @@ -359,6 +361,10 @@ _cleanup_nvmet() {
>  		fi
>  	done
> =20
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		return
> +	fi
> +
>  	for port in "${NVMET_CFS}"/ports/*; do
>  		name=3D$(basename "${port}")
>  		echo "WARNING: Test did not clean up port: ${name}"
> @@ -403,11 +409,19 @@ _cleanup_nvmet() {
> =20
>  _setup_nvmet() {
>  	_register_test_cleanup _cleanup_nvmet
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		return
> +	fi
> +
>  	modprobe -q nvmet
> +
>  	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
>  		modprobe -q nvmet-"${nvme_trtype}"
>  	fi
> +
>  	modprobe -q nvme-"${nvme_trtype}"
> +
>  	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
>  		start_soft_rdma
>  		for i in $(rdma_network_interfaces)
> @@ -425,6 +439,7 @@ _setup_nvmet() {
>  			fi
>  		done
>  	fi
> +
>  	if [[ "${nvme_trtype}" =3D "fc" ]]; then
>  		modprobe -q nvme-fcloop
>  		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> @@ -873,11 +888,13 @@ _find_nvme_passthru_loop_dev() {
> =20
>  _nvmet_target_setup() {
>  	local blkdev_type=3D"${nvmet_blkdev_type}"
> +	local subsys_uuid=3D"${def_subsys_uuid}"
> +	local subsysnqn=3D"${def_subsysnqn}"
>  	local blkdev
> +	local ARGS=3D()
>  	local ctrlkey=3D""
>  	local hostkey=3D""
> -	local subsysnqn=3D"${def_subsysnqn}"
> -	local subsys_uuid=3D"${def_subsys_uuid}"
> +	local blkdev
>  	local port
> =20
>  	while [[ $# -gt 0 ]]; do
> @@ -909,6 +926,22 @@ _nvmet_target_setup() {
>  		esac
>  	done
> =20
> +	if [[ -n "${hostkey}" ]]; then
> +		ARGS+=3D(--hostkey "${hostkey}")
> +	fi
> +	if [[ -n "${ctrlkey}" ]]; then
> +		ARGS+=3D(--ctrkey "${ctrlkey}")
> +	fi
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" setup \
> +			--subsysnqn "${subsysnqn}" \
> +			--subsys-uuid "${subsys_uuid}" \
> +			--hostnqn "${def_hostnqn}" \
> +			"${ARGS[@]}" > /dev/null 2>&1

Nit: the line above can be a bit simpler: "${ARGS[@]}" &> /dev/null

> +		return
> +	fi
> +
>  	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>  	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
>  		blkdev=3D"$(losetup -f --show "$(_nvme_def_file_path)")"
> @@ -948,6 +981,13 @@ _nvmet_target_cleanup() {
>  		esac
>  	done
> =20
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" cleanup \
> +			--subsysnqn "${subsysnqn}" \
> +			> /dev/null
> +		return
> +	fi
> +
>  	_get_nvmet_ports "${subsysnqn}" ports
> =20
>  	for port in "${ports[@]}"; do
> --=20
> 2.45.2
> =
