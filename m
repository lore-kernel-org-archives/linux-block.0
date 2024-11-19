Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F01CFEA7
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024315; cv=fail; b=UtkrVlzjJlBtZSiDbwSECavkiXlA5BNZUyMRpqmLP84rIYrgPUMMtFDeJfi8TybFtqjh20RWFHoELCKZsg28JXwMDqASmhvpDOpQGlt4kJ99kEBMjN99lVlGKA9w0KJ0aUDpeamgMpe6QIlI+IzHOh52CFoPyvAIWU6r8FncfDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024315; c=relaxed/simple;
	bh=X0gHnmvBPVq1wATbCRcQsJrYmZ/4TzF2Gt8NvrHyDs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/X/z4Y8axF8cItAlPt7uU7uwRJ6ElaIqQIUxp8m3e1HK2AC9p9lwBdZmFCuIAsWqOwA+JtTCUkpa2kj2TXnhUCLxXKjUpN3Ippmsjex4ZBxSGoW2wHWsOzWXfae1lzAJekwZyl95atzK0fM4Qz5pndjCdrDpV0kYN/S6on9iOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z94rxG3+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bF28Gpwx; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z94rxG3+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bF28Gpwx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732024313; x=1763560313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X0gHnmvBPVq1wATbCRcQsJrYmZ/4TzF2Gt8NvrHyDs8=;
  b=Z94rxG3+y0HZDejbRxy6L6hj328+g5R/e4H7ekRrVopmBtzJmtMq+AnI
   ePWTWQRtNznx15Zm4LaGEPPRP5roZUxZBgBcgAVXhEcowwTQVsjl14AgJ
   fs8sOuYmZUKuFQ7kjn4PaDnFzEPexpFGvrnU6wzbbtYKh+dmXtG3Xy6sh
   iKvmHIbiWZjnbxIkBi2CugZIxOVZcEahfCLjXroP466jAoQd2f3NCeJCE
   qkVtSuOnTCYtwEqXlJBgGQ+yQ33ulmlsZy/wqnS+U34nsHgLBLskPPGY4
   xFlqt0Y0tH66gCztQziduw3odMWudtKT5yCBulSsykAnjDV7u6+j0pnWb
   g==;
X-CSE-ConnectionGUID: BpAgk/I5Q5GtSEmj9lwgvA==
X-CSE-MsgGUID: +npkAjbjR7qvin+6ADfkaQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728921600"; 
   d="scan'208";a="32357793"
Received: from mail-westcentralusazlp17010002.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.2])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2024 21:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS+9nNjl0C7Z05kfuYQkIfD5Ns8EFfDPME58Z/urBtCqYxtG/WgpHLr9cCx6i8j9KqyKuouBZMeKHx2mfahzugV7lTJMFhOM1gzhWY4yLB2u92Bf/4RJYnPUH9HTLlduXzTPwFJrChuL5oj6wEHEgV79Fob7qIP0EFbQZODwQqDfKpSwd+wOBzyQZyvyCQHmWfEixmaB4LfthUz5FJ2D7DHgZ55hnlLQETaJrx4JQ9pyaA2N0UgQTNXk63nnVsznFw0FgZvP9M82NLxk8H+tjzsrnjC5bUXIqDxlyVvarRxm3ecno3yvBdSWVCPw49emks5OMRrsBywPSRupXKkIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0gHnmvBPVq1wATbCRcQsJrYmZ/4TzF2Gt8NvrHyDs8=;
 b=nELf69+T4Ng/BPhBmWaiQSAD5D3sLLxQs79E+pDYyltAwcmRQgIKpUoVHHE2mZft/sLxZgz41eFAPqYkPmC/ua5LajfHHce+osKoY2t9dLgIkXFeOXvhmrfnesGGKCWAXReBpAQuBoBHzks9WcIh4+VR24PIN9P9fNMqqhmJP86ScvBvUMu41AcuUCeMz0zj1USemQIq6x9/t6SHRhmgdzoNjEcYvQVck+8pqpuN3Sr2bpcqeye/FOTaLBBFW01e1Llq6Ggv3FVmY8aZTXS1IFgoIvQrjGx+N/aotI3Nt7BXgnOR2KHd0CI2s3Nh55BR6oVixk04036QfqEsiBHQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0gHnmvBPVq1wATbCRcQsJrYmZ/4TzF2Gt8NvrHyDs8=;
 b=bF28GpwxAEe5t1rFIf8zwomI6HjYRlUjGOtL+dIBXIbPsIdObpw5I8iKuf3TgS9daXJecTaIywLhvcerLKY/NWVwfgA54CVVLX0pdQqLRbnRDdkyb7+2+2p2UiAG/VqLxudKdZozhwwIIMD+0hsBBaMJL0AHrV46rDOiaSqgN1g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6447.namprd04.prod.outlook.com (2603:10b6:208:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 13:51:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.014; Tue, 19 Nov 2024
 13:51:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH blktests] throtl: set "io" to subtree_control only if
 required
Thread-Topic: [PATCH blktests] throtl: set "io" to subtree_control only if
 required
Thread-Index: AQHbN1elDH/8WELCTUSDAQNw+IowJ7K+paYA
Date: Tue, 19 Nov 2024 13:51:45 +0000
Message-ID: <6f6vusqirfseshgk6a7jko3uka7wuqfqvpdrv3tom6wd3ssesy@gwx7ppjgxhsl>
References: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6447:EE_
x-ms-office365-filtering-correlation-id: 5caf4b63-02c1-4e98-75d4-08dd08a14e44
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dH0wdZV6H/5s2oJw0hdN+4U0h4lYYIk72LYyXfS+wxslkj79uFGuRpwwSLqT?=
 =?us-ascii?Q?QQkpY3treMreifd3ZSRRqG0lErPOmB1SzPbfenQBYteP9qALS59C1ikYJfOS?=
 =?us-ascii?Q?AVTKqu/Xql69uCe+F3nB4LHXMp0y2OwPcezrxGN7TRPra+84qzDRG++esq5A?=
 =?us-ascii?Q?fM+R8bdZGmU+jwmQmpOlBbfcMO93UM8hQ50dMED02DrHIUQ8RDU0wvImAF9K?=
 =?us-ascii?Q?iIMm8UK96DoDBtFG+DI4oEXARoSnffxaFj0ujoqCVQrRER6ctfWTsCV6Fdvw?=
 =?us-ascii?Q?T31MtrDxXtEvCyiCBI0CJKM85+NV8jq2sKuWvETFSDqVXu2BENyT1V/Q+5Ax?=
 =?us-ascii?Q?0A0ECC5QwX6JKK9ViTEPiXldH844z2/QbJoExCODYbEfnoup7vnsSEcjtvwA?=
 =?us-ascii?Q?oHK31uEjj+MFZuI2qRGdWxwuqN3MzYYDLDJUEBX2fg5dv6+hnjax+bLl6quD?=
 =?us-ascii?Q?X/umB3jpWtnv4TtlGuCqnHAAQ6jLsbz0m0Dw0TP7yCbaHbsL8VGHRc1WsJ81?=
 =?us-ascii?Q?mHZq1gllNCA0lol/IhbmIlYQQk3c7212yL/E5Rm7XWEzi2DgM5r5l5To0/rR?=
 =?us-ascii?Q?/p6jHd8z/lVYGzAA0QpmEqC9Eo0PcKSgeamJQIoZq8gGK822IVIQ0j4NAHZ/?=
 =?us-ascii?Q?Hsc+dGi9U59OBPCImW2vgCCr7W4F3GaCcXznRxseW6Ujs0KvF1LEkyjz6+L+?=
 =?us-ascii?Q?9SLNf9ybwVD3S3YDzFwn83D5EO1AYppXF/4Flq9Hx3RptTk1Lz2TGwwPR+oP?=
 =?us-ascii?Q?uXFbH8VLDl7LMLvog7+lEBMHCdmKZwVwi0sk7jv0u4+Fxp79J6O2ferGLpFB?=
 =?us-ascii?Q?zrSOkFZtFI8cyBrQxef3Q55h1AHupVHEyfMojS2oE4uruo/vzl1h4XDJOo1F?=
 =?us-ascii?Q?+YJINxL/nVT/+mLfQmy+jZZ8EcYuMlZJFMN/1OCPpPMIQTEbMug/XUTh/osg?=
 =?us-ascii?Q?GiLsynfrRtrb1o8TNArYfcT1Dnr5jSW8Yg6AlcMrNCbzCHhLsfkettbYAMJy?=
 =?us-ascii?Q?kBQA3VWbXFCjLCHDGZD5MMxsUQqDrbp0dv3RdUYtbB9abCMyTrA8kmSTg1dP?=
 =?us-ascii?Q?EEC8pGKuBSfB6rUmHPtyvx3A2op/k+/g+LRxtDwLPEQ0pE+rhTEPtoNfTHzO?=
 =?us-ascii?Q?/fnFMe3u+64Ran7rR9HukBcvD7ddHIPrSczfsxOCu7ba3aEdzVGEnbIpbRKe?=
 =?us-ascii?Q?NFGv22nRlErbcn6LeOk3xmsbOltIuce9mRNQYXWc0GT8t6dVBxCta6Lk+5yL?=
 =?us-ascii?Q?jQFuiHKo9LDjfEHfBkpiSMouIHNs9qttw2pD2a2JLetPUoWVROWKdrZPWirw?=
 =?us-ascii?Q?bDeV0rvsG0KbwLYBQU5v5X10GRTpSLKja9c+ESngcSlj761QAXDbsixj6nrI?=
 =?us-ascii?Q?bNAoihI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F+Z3vF8ycm1I+SAmm3iOTykeAOPadyqO6yrZAsnn0PgUAAkP/9nJQds7lNHg?=
 =?us-ascii?Q?NY8cpLVj81QgQvXrDWwTrZem5QfR+xT6bjyI0iTHgvbTOsvY0c6tNEGauzij?=
 =?us-ascii?Q?PXICvy/EVRTcdM832nomTpet0C4vX6WavcypknBO8Elwn5ADGb36b9N4+uws?=
 =?us-ascii?Q?1cicKyaC2Sg6PD9YOsw/FU//Iqr5nZTQLjcxOeF/WURpaT7Jm+ymvZBjniT6?=
 =?us-ascii?Q?Cm1iAlEaGQmlKWTT3yaHq0SQyO/tl64EfSPDd3w2qu0BylEAmFIKRWIlaN+d?=
 =?us-ascii?Q?xoZvOjVHe77vdg4gjuGSICJP1RW1q0HvLzsm7Vg3VIg53qJphnnlwlZBOX/q?=
 =?us-ascii?Q?rK8BjJMgmVVp559qQWZa94f2zic1X9Zmog8Dxktlg8twGwJLlxpCeuP1MI3E?=
 =?us-ascii?Q?LpjFFATINE6AFPE31ydQwOTmOvgfdrv+lPxOJkUmTm9OrPxpux0LmZhhANvl?=
 =?us-ascii?Q?MCaEF+9FMVMwPLcRMvpBPZzRnPTGGpkEZ1zMoQziz125BUce0N0Fb2fRvQsA?=
 =?us-ascii?Q?ng1BUwmvh+57V7UUSJ+aj/ggXmZ9ovbm8aqb16EnhYjUGCedEQOLKGCqeCXI?=
 =?us-ascii?Q?DZV0l2zGxkYGnLsBs5OwZB3B43OEwdGLv5ycjWPnVKzNY0AYBm4vfGCSigXi?=
 =?us-ascii?Q?2/V4isfHeQkQMFpizodNxSMRnFdg5bywLKT7Wp8zarKkc/KGtYbqXTGT7cHm?=
 =?us-ascii?Q?uQMLht4A0QlRUC6W05evL5SXQLtJzgApK34V/wIbFUigsKjbcM1t47ILrvbm?=
 =?us-ascii?Q?SYefEG5B3SyeIXdaVOk7qRynDis+xCjm/qryRNCE8/Th6cX5cyvbbrMkJ7th?=
 =?us-ascii?Q?6xZXpTMqLf0mowRw1OHpPiwiZFyv4KhYGQ3Lpy/p94lQIB9t7v3lgnWAHv8A?=
 =?us-ascii?Q?SKr2TyzmZg4R45wHe41wWUCGBS1gDdE0sQC6yn3BYMLDEyIKKVWcGj0YtW6U?=
 =?us-ascii?Q?S/wQGhl//fNqxbDJIoV45Wm4fz10bMkeKlQP5l71s4mEMi7Qd67LxJ+SS2cn?=
 =?us-ascii?Q?RYgq8abAY/ERq78Vpfs+hZVqm5oiC1GJo4iN+jXfjp2ej74jbMGSGT0h985u?=
 =?us-ascii?Q?O1t/97DJm8f+G4WfJucNVVixJcuhYakCQPfcmQz5KsI5aL4iq0ga6XN+Gstf?=
 =?us-ascii?Q?7+PJC/hlJ57HIQPenaDRE8NjYjZM99A+tpamjiGOpp+qe5fY4M+MercrEurA?=
 =?us-ascii?Q?5yBQir6B9jVs+JRGiIkvU8Q+AkQPnkFn0K/EL0J68jGXotvdBKhcMSyB7PS1?=
 =?us-ascii?Q?iB5MSHuZ1vHB9GJD2qQMsHufJ8owIOQbkbmFmrD/JXcu1JEe5hYAWArhKaq4?=
 =?us-ascii?Q?smU+RbHBs/g+xOPbTylI7ZdyktXX2araZpaIv2hCFRbmWKLIaG2wsF9AQZGz?=
 =?us-ascii?Q?FZyfQBuDfglmbBQJsmpXNAFiYCn+kBQJQr5/tM4JT1D693ozwUNB7cOgtgAw?=
 =?us-ascii?Q?+IaToxHVpTQwFYJUdJy1qdwYtvZc0xtUt7EqDfEmORWN3C/fUHw9DwxVxVC/?=
 =?us-ascii?Q?XNL7qrDYVjvEvfyxs9PSb2iHLNpw8QbFSh6AvK/kI1dIix5dGsh8MkXBlpv6?=
 =?us-ascii?Q?iWZ/VZhTVQPaJaWwD933FIiIecHMBC2e+2m9UTqv2Urznzw1kKqdRCqRwbWQ?=
 =?us-ascii?Q?XujPY3/3LEYkbsXXkaKGBHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A3B6747973D824E824AF3F2F944A5BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2NiffeYaxj4xAqyQfB37Lkve/wHUT2ljIHAYhIZgvk97dp1rO2XFj5ZBdxZDW/cJL9iKsqMeoIzed9q80p7DuetRoa1HnLFLqDOpQ+Dk7PbvYgsTX73yZOMd4GZ+ZKaJucgCjxfUUPatzAKVwTL8+XHKXkvLGzy6e2u7IC9aRiStxal8jmUb4gG22NY81ok23gY1Ixq/lakBUw8uD9m6HqY9Wcj0PfEac4MGRwJPk54Br0jbMpMKwWlW8GoqvBl53mlMiCq11QWgLxNwFuduGoRLxW+sEsjZ6PxN/S4pRFAKDFq65wZ5xMSR4GJFUF3pngt4Oenw4id+gTQdPc47rtz7OZ43xKoxvYvUB9XPQf0Z6EWvPYz4qtL1gkXFFhsBYloynvf1A/FOLKsk+PfrRKqjOsH9a22sLF77Lox+fYHIYJ2FxVSUJSPapLzX96PBKeGlKY5xXMdl2+1vSnQ7GUoQj4IuFHXZvWojkyi2nrhRaSpEd9eQ7ZlAGvyHASmWwzDTJ8eMbvobWunp1SE46Y7dFyMwHWon4tDSbY0HVra/b6VTqkWHDFdenTM9y21I9gSl6l/cgttIc5bDlRA9iZpYxsvvKj5aqOMnpSmeTwhgL9NGNVehTgt8/3HuGOre
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf4b63-02c1-4e98-75d4-08dd08a14e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 13:51:45.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbqFHxTRUuX114JnjMJ5wLPxip+0jB5BbXvwcWRPhimv3ec5+uwGe3uVxmZP2OHbbI0+2rYlTwUkZ+miWcDauVoLcvgggubz+UgvEK8eRY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6447

On Nov 15, 2024 / 21:12, Shin'ichiro Kawasaki wrote:
> It was reported the thortl test cases fail on the systems, which already
> sets "io" in cgourp2 subtree_control files. The fail happens when
> writing "-io" to the subtree_control files at clean up.
>=20
> To avoid the failure, check if the system already sets "io". If so, skip
> writing "+io" at set up, and writing "-io" at clean up.

Thanks for the review and the test. I applied this patch.=
