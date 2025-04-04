Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA574689;
	Fri,  4 Apr 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743737481; cv=fail; b=Xsv6AFymi8uvC9SY9V7rQDKE6UrzuRm6v5y4NkK1EHiovNrIU6rROFUVi8vb8d4NzosRMVRH3zN8uNh8Llx6CX8NRKGNAC3kEECfFfeYxK5WUj8ZVss7M96mdKwhkEd77zbOw6geNCpza8/XfBU3Ce7HISUtYb0Jfb4i97FsL7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743737481; c=relaxed/simple;
	bh=UbhVN76isQ+sbmJ4yVSs/lyVM+EePkWn5SZEnV+dC4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+auW6pASrFgS+qjxgpNNsyVtK62kPLqnMkLqAO0fIHYODIioNkXzGrHmNWtFnUteH46/qWB9l8Bt/epI2qiK8w/o0Dfr992PoV+uVqxkdG3rGwpihvWx6po6wQEUz7aufhuD1YuZSfju5ICRCFsX90GDwnAbGO6LbtArJus9ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=C1gh76X/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GatxVCWV; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C1gh76X/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GatxVCWV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743737479; x=1775273479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UbhVN76isQ+sbmJ4yVSs/lyVM+EePkWn5SZEnV+dC4k=;
  b=C1gh76X/iu9vMJUIMvBgo/oOD5snhSFcGjS0q0oGPdcl3PZD0rSEmvcS
   +YL2yq8DTpgIin89ZGwMiCh/8xOaLvQJcGbIXDPLrcFZckFB9gycRYXSZ
   liy5mwgk52uQ2SAKD0ZE3T/8IJJE9kO/ejvFBYsKYKxhi65dh77knkFXR
   ujsWbjRcMsvmr206ImMZwvU81/UrUCpWLB+0YtsP7I2IvyQVngF6Plmv4
   2cZSwS4/VLi3zarpGcc8T9LOA6hxOlh9NET3rGRvWZv+r4voq0cqz28l8
   m6XZQQulc68l4/5Ya2DnyAkTfTcR/Nm2uSIMaPkSBEg7rcxKWLN5VF6dT
   A==;
X-CSE-ConnectionGUID: a7BdBNcCSHGKTLxfv5CEhA==
X-CSE-MsgGUID: uVw1xQ8+R76zJ9ZgxbnQAg==
X-IronPort-AV: E=Sophos;i="6.15,187,1739808000"; 
   d="scan'208";a="74357309"
Received: from mail-eastus2azlp17011028.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.28])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2025 11:31:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpP1Cso84fy4z+x4iTOeZJetiHFJPQw62cqBR3XPWzZILoM33khH2mcHdDU/BUUu9Xca6zl5/x2TjeIZ5piyEbPxDMK6/Cp43WQCCJndpb6qvMlIZw+J2C2tm4vLXoBrLuB3hVINZcWadumBFeYajKUurWw0DKxtHMPzatFu1rj+/smEmU8ks7bxpVDLlPpWCkx2jE78bYIc6JiEApFTBI8dPsx8asOm9pZom+WAmocww5B+A6QO811y9f3PrSE9STDmJ0iQqOpD+UlhPbDH3mewdzVRrde2r+PncHHJVMW2ZZGDiWU3Tb04pwLGYsZEZFZmj12xVyqpzuoiXmAwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbhVN76isQ+sbmJ4yVSs/lyVM+EePkWn5SZEnV+dC4k=;
 b=ANI2J9/Qt+4V05Y4GmwCJzbc/vo4/MvM5ODjCFq42BzmGdwfxq7gYDLjQJykVPh8hqbnL86gt5hMdit2HiOXiegJk7TQQP4NevcLLTOvnLmZxsYq8rSr6FjY/e2LOVxDGvzMxVoYRNT+rPNETPM6lApV/twcYAtejO7w2OmrBI/gWSSYoR11va4saoBgQarP5odg96SwZcar9DWt8C48DsAC1n7cRngxqhbXovWvpknmLPQNBnKbD++DqH8vwkjU0GUt20llHCCaI/S6E3wuWQV3hEnlaT3vW5Lt2fCDdFwd3ymHYAjXOp68mEe56OVFBew6olGTFx46ukMnfWfeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbhVN76isQ+sbmJ4yVSs/lyVM+EePkWn5SZEnV+dC4k=;
 b=GatxVCWVdb3uZaETn+QWSv6vafYg1we02TYWhRNc+EFe4LNW77fi0ppObeRpMhdXpmF9nJzYyhCUes+zZFbU7baD3QhIIXNPsor0SmGUnNx+gD0+158/I71KNm9GsnMCee0r+3ZHNLWHvqBwD0h5j7wJnkl7y9NnaEQuwZen/JI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6338.namprd04.prod.outlook.com (2603:10b6:408:7b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.54; Fri, 4 Apr 2025 03:31:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Fri, 4 Apr 2025
 03:31:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sasha Levin <sashal@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens
 Axboe <axboe@kernel.dk>, "kch@nvidia.com" <kch@nvidia.com>,
	"yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>, "zhengqixing@huawei.com"
	<zhengqixing@huawei.com>, "yukuai3@huawei.com" <yukuai3@huawei.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de"
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.14 29/54] null_blk: replace null_process_cmd()
 call in null_zone_write()
Thread-Topic: [PATCH AUTOSEL 6.14 29/54] null_blk: replace null_process_cmd()
 call in null_zone_write()
Thread-Index: AQHbpMsYbodJwTH7lUSjvyf4d2KtZrOS2mQA
Date: Fri, 4 Apr 2025 03:31:03 +0000
Message-ID: <qytrsydugyz3ksuzg4m3aznskweuhphm7nkhm2faks3oefc7ok@jmteb2yigxj5>
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-29-sashal@kernel.org>
In-Reply-To: <20250403190209.2675485-29-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6338:EE_
x-ms-office365-filtering-correlation-id: 570894b4-6cf5-445e-6127-08dd73292096
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w2QsZbCBAI0QfMUn9uLLBQLGNCmOmbqI+mTVeGmdUoCekrCR9oZsr03yDJ6A?=
 =?us-ascii?Q?pSzYKPUtc1/73cY29ZYmZ9Ux9ZdkhEJOkOtwGzq7JlCPCorSXaXXyBTmYyoO?=
 =?us-ascii?Q?o3K/SpJuhVigwvKDIMNfVgd2iy9NDnF6MtzZuYmlRCO+ifLWman0NNoFdCip?=
 =?us-ascii?Q?uMoAhaHFGrfpwTkTUuld1gUEJh77IGfx48wiTVRRPLmG3Tc3tpbcokM6A3AE?=
 =?us-ascii?Q?FbopeyUdqHu/nNcOnK6NVseKWyg9IOlAxZ1ei/nYADeSGPolgfs7xvMgF/76?=
 =?us-ascii?Q?Htz5v7IvXC4g5erXJUfARC2CS4XgTmnGGaAG9M2s+KMNMcAoNSwkV4wZp3Td?=
 =?us-ascii?Q?NfF+R1w0Qd4zkAn0lz7tl8KVHxLln0fh7VYVp/sWx2r5xJ373B9tLYBMaedt?=
 =?us-ascii?Q?jAopwTilsaCNnKewb1Y09dUPnzk9gQP4dJ3p4+Bx8+CeWNUouCWOMCC/Fv1Y?=
 =?us-ascii?Q?oV5TG+umK32RrYWizgGX+rxJ8dY3ame3klTntb7L6YCdYExitIqTXKyMN2wC?=
 =?us-ascii?Q?KNswY56wop6aIOUsnt+capTt9kdrAEdFnB07IhoHu4dMDD07r/ZLuxpaZoPM?=
 =?us-ascii?Q?V3FbssLtLdfYbOUhgr31r8KLedGEQn7Nj8+1zlK0BNM3Wxjcg8AwXob+Ttmu?=
 =?us-ascii?Q?5vL5jMqJSytSYi/K30nvprJwAhqVyFeCP+KTPZEEp3D/TGvt80XvxVMZLq1P?=
 =?us-ascii?Q?t2UT5YZ5v/lfpGHm/4k4xhjIIoetG69OykHaGZhU3Z6CdLQUF+fmoVNqxUll?=
 =?us-ascii?Q?N8pYk1Ojo1q0L6ZAUhR7xXTlFaolkbVFdcLSiYLAimJLYjSfxTnJPisJsNvh?=
 =?us-ascii?Q?GobVzN4NvuZNuQX0Sa2DFm7HSEGXfXUSeA4PJj8OK5WNKd4dCux2s1EsfG9W?=
 =?us-ascii?Q?XW0V/g+4lGQqGdwTqxCSGiLYu+RhhC39EuZgO8/0IWUmnWZR6dY6+J6NjJEX?=
 =?us-ascii?Q?ecP8NJ21Ex41hcazrQ0O5px3jBPQHQbMyhU8utv20dL9pjNhEJqjywTv3n5i?=
 =?us-ascii?Q?oNEzT8KPlws7nWLBks377nSuSocG3hnwLFK+bvmucGLPMuLgE0CYDGqtYJvl?=
 =?us-ascii?Q?CpgWGMIxzL5wetjTQ7P4kKPo1b0VLT7Z7ikPKlIKyb34nYpVnZfGm22cUBPm?=
 =?us-ascii?Q?iehPlLnBQnW42blbz8lni6dUEn0P1iCyFpR2Xj3ValvcsDuS5fGaCHaZxLbQ?=
 =?us-ascii?Q?BA7rHp8gMmHx+WOAEpP7sEU49lCMTByYoDv6loRwmyso0Sq8jNYAlkJLSfhc?=
 =?us-ascii?Q?H+0H3LC0AMP03EAOxfRbn+c2D7IYrPtVpwHw2Gm8VDsupEWG/HVnhGwVV9X2?=
 =?us-ascii?Q?Bup3ZISuLjS1AuK5JW+y3jnEmPgjnWoWo1WnP51g0dAExuQvS/49n4RtrVgT?=
 =?us-ascii?Q?z+Srfh/FaTj2AnzTbhBO4kETEILj/pAMIbjEPauceR1JEn4/AQMN/bPSVVH5?=
 =?us-ascii?Q?bIOaHzXiyLFwPZrN77UpxDh+TrFet81k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kX3WrCIqKgCeDAmC5vSr8xZF6nPs8UHsVyxw3a/bVwjsTzh6ph8Rx3E0OXlP?=
 =?us-ascii?Q?acMFH7fS5NQONQSj9hC4NoPpQAAZCGCUgh9DnXm2r2iQTtTgBV2J2FDr7P/c?=
 =?us-ascii?Q?4CEOT5aVv7p6+gvo6c451NRQnTUmJ+UJd9YRmQEe00oF9r6WsN03wg8IeuBn?=
 =?us-ascii?Q?DVsx0rhs0/EbI3uluYX09Hn+IBQaLQ9ze+pbRBWwYsPQoYn1/sTsUc6xrWNG?=
 =?us-ascii?Q?5tVVPx8Lc3FULbXxcwLVXG6fPLPB80K8/Pa5ML3X37sFCYRLiL5hB9hMhude?=
 =?us-ascii?Q?5nZGRxaVVHY23wQox2FuFXBWoDO+/A2CK2Sd+uzQxknjHl4JuUBVAmoWwXyb?=
 =?us-ascii?Q?rEcyGAvG/MLph1VtMg1KWWwAYuacRCUhTA+VbFSba8d+afR7DKlcE5ha6AxP?=
 =?us-ascii?Q?OkhXtWvJbhKZ/8alhiHQM5FKLal+sB+kDc6ZYw77LxGE3dmVYR8zOwc3K9It?=
 =?us-ascii?Q?SIUiNSQ/W8VnRUt9LihhtdJuHjD2FxqoSEMaaFsvdozCyaHDnPp+wUOMBkRT?=
 =?us-ascii?Q?6BlmuFCrdFLzdXTKV9oNC8rub3XJnYkeg4HnjKqCVyUbDq3aFtUa5cqhJDwU?=
 =?us-ascii?Q?YHx9l94E1EZ/HFXd0/KeVplEt5fJcccfj6CEGaPX4BUFanhELT0yWyMIcdWY?=
 =?us-ascii?Q?UZT8E7DofVuOkpc203fP6cVclVvsyih4AWgdnepYdtipQDLytMALS2KqmZj5?=
 =?us-ascii?Q?9QewV3ua5y1ehFlF+bvm6V0uYLiuyLBtim/CL+Kji8w7Cu8Wnryfb42tf2pn?=
 =?us-ascii?Q?7kVO8SJvi6KsmC81sotenoyBRDumwAswpDzraYxGpLgecBFFyfOLEqYClpKz?=
 =?us-ascii?Q?QAKUhzaLXnw5m1nXEyh6/sOueQ1E794ObkgpaEi9ijMSmND1Ka3g7ot0nDOs?=
 =?us-ascii?Q?+3U15IrvWgXsqXCxwVM7Z9+h0+2evZ5MlQFj5kEBv133ImUraFWEYldmCzqd?=
 =?us-ascii?Q?eCabZxuQyjtuHg0VjxLrkefv8Kd3lkuHODNpFTZK9B1eE5A4WoHscYnCs56p?=
 =?us-ascii?Q?qIx1qT5wcIqp9Ns0fWXqb0IXMHzcsWK9HSciJCyyQ3bf/qe1NjPhc/286LBm?=
 =?us-ascii?Q?lk9lipZrqoCBv0sNdzV/5dczeOvu4PvdsxM3dJA+Rl8/ZSF4buQQHmVNp/9D?=
 =?us-ascii?Q?wkrqRQxcW7+BRJkYFnceLr85ls62wc45DF7K082j+DCrr2LG7vx62/Y5PL+T?=
 =?us-ascii?Q?wf2uvfUPTRgVHfKuAAfDDwUlCyBLE/8Xu1q3Kzz9ZocXkjc2lDo3qSu4YzOL?=
 =?us-ascii?Q?i5IrWA8v85GARJRXniDNl1RQIBVhWLZWoRxd6AgohF6UbLDG7WzrBbknLZ9y?=
 =?us-ascii?Q?lB6NIbik6Gp9iAP+HMtRqIlHVUpb9onwcehXQwXmDfeOHN9Kcr4sPPfrOmin?=
 =?us-ascii?Q?eQREKqHQq2bO4qePT4LnyX2S2y5ssOHIZfEFAMICcVA+gtMV5eiKYkKvY82i?=
 =?us-ascii?Q?SjPTY93BGUUNCslM4dTFDJnLDEjJ+Mz5sd31AGRSZVPJrRwIi6/I9iQPPho4?=
 =?us-ascii?Q?KpTj9Rhnpi9qEXfrj39KhPMTrb+4zsSyMDhYpKX2+WSEUVa2WF5xMraXD89M?=
 =?us-ascii?Q?ZW9arPvWURIwWIFAmCO9xUIWW7ba7eMbVT6RhPSDdWP08eOpMK0IW7paQQQJ?=
 =?us-ascii?Q?UlZFKohjTvyvlapNUvE1CkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D67742AFDBD1C418830AC1EF720705E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UtKns7ICoWnHboCqdtul2/4aDuG1CSnfh8+blfbBXid/WsFWIr2CxXIOhaemOS5ITqrS7NgMBgpa4EpIt+HGeb+f3IX4zkXBsNvG4cTysUO8AfBRoOT7KI1pDmT3u0iSJV2C8fzv2cyDt9PZBY+F2xVreCVlfPqZTlfSUEp0mZLeiQx709dMzk2gW1eQHuNHTxsfA4T48KHZjrQnU6Herw+h8nv7C518kPF/W04Ou38KS+ta6g64GjNx5YVNOOFyALvnrGft6rLp+QL5rdTAGQmCVe8ngS1UqU3s5SnFQKVpyGir0N7lYOtcecx9twO8/lb4h/UvdWTUBmNnSJpcFpAMY4pNHPVUpbV3B67A3Le+HsbpawGFLyHqvFiz3v9BT7wRAoELNqnhxydU9PyOlzzdHAUc05bKz6qiLIbGzMBCHFzRV9d876NYYVxhcqy6/O5IejiQjM/DAapqhK9eNYoaKdq6vD9wnBpFCt4/rqufzWTRpTp0UnP/t8ap23lsKajIjxlreMcqYb6FMC+qZziGWc6PzoDy0+msHg4GDdYPWLGb/Vep0Y2MdfC5RW8Q7yA9je19KZo3b51xserpC0O0PmfjqmDDMcAJZfp1P2ET72txlqOdwVnVViFmaYaZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570894b4-6cf5-445e-6127-08dd73292096
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 03:31:03.3449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHvW6GZ8UIRq0XM+wdm6A9lEyHZ3PVNz53Xq+RrfjfP9HkJWB8yyfFYt5MS1qt5ADAj++no36GsZ37aZhsrdkVJSxpREdvr6X9lerkiJo3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6338

On Apr 03, 2025 / 15:01, Sasha Levin wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> [ Upstream commit 4f235000b1e88934d1e6117dc43ed814710ef4e2 ]
>=20
> As a preparation to support partial data transfer due to badblocks,
> replace the null_process_cmd() call in null_zone_write() with equivalent
> calls to null_handle_badblocks() and null_handle_memory_backed(). This
> commit does not change behavior. It will enable null_handle_badblocks()
> to return the size of partial data transfer in the following commit,
> allowing null_zone_write() to move write pointers appropriately.

Hello Sasha, I don't think this patch should be in stable kernels, since it
just refactors code as a preparation for another patch. I suggest to drop i=
t
for all stable kernels.=
