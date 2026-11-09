Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225778;
	b=bkm7IMpQvHwKxscSBAx9ve1zp6aB73qojOS72CRAfs/p3INJuTKJXkYEiEdvcxywK6iJ
	 Af1vFG0NMj1QiKOdTy+4uQtm0OWGcLRgz+BUF2EgYeW50JWsz2jDDieBe920V+Fx/pjid
	 J4s0n38Y4wgTtpCpFDqJB3g7xRn9LyATM/NGfc9VxJPDePJQtNw2qNFVJWQewcPjaI00q
	 Q+ehphsHkzbaAGjYL5vEIgPWi2nicv/AtCs3jbmeHS73oc3BroeIrnujJ7cIe+K7Bqqth
	 SrrnwoRTbSAHn3WBKPkvzOWfEiqf0U92l7XN/gNYkYrtkaKE8EfcbFE9y7WXv54X3Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225778;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eCRrjIWl9YzP6ni88Z6ece198enI+O564aGI5d3w8kg=;
	b=AJMK5XNU3KEh+7hgrneQpfWNAo2wqZX4coE/JdM82RqpYDgrH7Wmve8PzmX4S/rD1Tht
	 9/HWBy1C81wYSrQphLC60qf/VWspf0BmGI+CZwXo/JuWosw8SsJaF9ODgk5A3hJ6E/2Ki
	 zN/RBsIO/9AkJaZCClOabJyyiXUsgfrcuGiVsuESmeYbk82mDhl5NmITB9lfH8166enBY
	 36LMEJDauH5TfHunCyv/qqBO/zonCK2KBsKpgVEmY5iaIftgyUC8HgF29NLSQ8J2Qn3QK
	 2RRrjCKHOKtfw78u6cIkWOdGrkyU6W15bdLCuMIqXp49tA6YLqVR4Pg3/5bCdSyHReg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MVwZXvTN;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="t+kMIFW/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.143.124
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB8606A321
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MVwZXvTN;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=t+kMIFW/
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794225777; x=1825761777;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eAmDE99aVoWBFt2D9wf9i9/vCVx9g0Bmp2geXO03oG0=;
  b=MVwZXvTN3l2VubqXzqYzqwDp5SBnhahT9i2bSu+b9tlqzmfxWD+tkYlM
   VRNvW3JQtKdOTdr6JYCCDOsAEglnqfMzpVYZtQp3rTfMWHJEHGZSU2e6+
   +4QXUGXMVukTEEBFkumaALWcLc92rrG3LoZ4fDNT5LFwtU7mZKW2PQhJm
   vc230iORVqxojPzpRgPb/uFjuWlqAKyFvBjGW0BQBBOii4PVfTQ5wSpT5
   JmtnytHntjnyUcnG/ErMShKKoFF+AqmNLMYTKZGGQjwaUN5zVyx/wKGWf
   KQownAkFmlelHs/j1AqirGg+AyYSd1rAyIhj4Ix+nlga/tzsDhOc8rkWA
   Q==;
X-CSE-ConnectionGUID: 7XuTd+yOTS2jfjVpAg8NjA==
X-CSE-MsgGUID: mWF7yetmSDWvo+6Iwv4lfQ==
X-IronPort-AV: E=Sophos;i="6.27,203,1786982400"; 
   d="scan'208";a="161332876"
Received: from mail-northcentralusazon11012030.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.30])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2026 20:02:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vti2Cb8cRv+B2ihDGRS9hDJm3qn92XetE/4/EKP63xf5H/lFfrJ/0+vzvXB6QrS2q7PY6xa7JU6r4jhbFduCfwz4m7ardN349jCywUbRr3GmwFYwz/p+wx4qTyClv+BqdZyA7qqJLNf8sHKGsXwdtaHPUHdnA+poNYwauQYwgAOux5Npk5pI9hSZWPjymSyJyU2tGbAeRxB3148WKFaA6CzwXKX4v7JGRnnvAHL7yNA17qdyEk33ziXAkTUfi2nLqodf2wWF670tYq5Kgw3TLnBUcvQ6prINmuKY1oyUCXCvufdWVyKClzHd4uphgKpCViWzsvyYcwYjKcJlKGiMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCRrjIWl9YzP6ni88Z6ece198enI+O564aGI5d3w8kg=;
 b=JDVLVaqKbnl2X59chTKy9KZ5j9+7Anwb0SgxEzxofWZ+5PiJ5DaXB7Cp7pMtHq/IFKYCerjs5owx3iobVV3OtH5T81xtINCK8H7OVJz7UVIvnsjtbgTtTEZbfHobAW43zjuIHW4cQmmeqql52ZrQFswpxTV/s+kdlMGjuY5pwMqj400LpiX4o9RRVt6cjAoGIfZY+448ASVEj66gX/Cp12rkcQbsG3hXHy4JC8WYCL+ZPpMDQ3pjqi4F0VnA79ieUqK147Tglr0b1eyqKkN3Mfy2adt5ZibMU2IE1aKDDFNCMRhWMJYTllkebdH0Av1r8C0cQ7aHrXvmkUZNmGWuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCRrjIWl9YzP6ni88Z6ece198enI+O564aGI5d3w8kg=;
 b=t+kMIFW/izp3n/cWDWnL5bCAEn8ZN9+VNEZehS+h8WTsuDySlg3SdZwuKr8kTAOceL5OVDP4whURcPA+oOUw6rn2G6MBrs4WWFxuaP4ARwKZ1wIWBu74nBLivJsevTkyIen/brewAtNtbsGvQ12epF7Cf6iZiqNCCVuYwU6Nt54=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS3PR04MB993825.namprd04.prod.outlook.com
 (2603:10b6:8:600::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:00:49 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 12:00:48 +0000
Date: Mon, 9 Nov 2026 21:00:42 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/071: test reservation preempt with
 multiple hosts
Message-ID: <avG1szpxkIL-Sj8x@shinmob>
References: <CGME20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
 <20261002070851epcms2p85765994ffe5ee25f97ff522c29b04b6a@epcms2p8>
 <as9W9E4gkBjhZ9sK@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as9W9E4gkBjhZ9sK@shinmob>
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS3PR04MB993825:EE_
X-MS-Office365-Filtering-Correlation-Id: 086a94a2-3b68-4d9f-f162-08df3e591822
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|23010399003|376014|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	4C59KbZCYZteHlSddHEBQB/YuyzO0YQ+5XYjhavqJKzVARBcT2DpnqIjXhCcdAVgivVqvwzgGJ5LbYjMwNavjg1L8tFZ+pJ2ut+rclwn0RmgilaAUoab0/M3lMjUekCALb9uqqlI7W8DXm2O8PN+anWnFPrJNz3CdJ9TGAmcdoFAc/+TV6XwRLhXVWQlqi5fCwkVxbx/Tb8RDnL6Hsu01n/GISenUrcJqaPGbuv+z4vgLK07gWEzNymp9W7HkfHiCDGFXPgWbSfmU9c9pEI5AQuv1UePongiXSDVPCaruTJOjXogcOp0nKsYL2xisfYQaVVoJXeRX5OE0Qc7RYC2mdoTYGdRqA0/IYETnUcBe6TXEPevErkxwMtwuCPgBOTXmfnKAofOFCz+xmM4Gq835sE/gwVtfZBkrVEkpYh4RP7FHFqaPz+OJTUaET/I+vTMBqyZOGsOcId7RqcdI66xyOTkXrg+hHOf9hWktXVrJ6TNub1tkglmcDU4qDTUq7iQXjhIeUE/Xc+GqjlHAB5BAZZlOOEXrnrqeWRj14UC23RK7M7LA5tka1dgolPpxx6btY//b2XvZtPVkxbYsVQDQ5yubKkDM3+e6W3PR3f0fqJtVga4YiD+94TPdKR0vYjB8tebNy8doFmN89h6fgrA2dZYpp+r6Tv/9fUoYXfOl20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0JpiBkZO9wkklayYNKCelKu/G+ttV3ggd9oQON7KFQHal2wcH+y/aZDQ+B6?=
 =?us-ascii?Q?okINMCV4y0ksGVDD+SEdPTKRasIRxTjIAQrVkO9NaNe5DIGNMa1oDWPIDvYO?=
 =?us-ascii?Q?apJ0q0MvYKi/p4sxAbpZG0l8/k8lIxV5l1SbZFGOVUJF7EXTJxkWpuBI/w5i?=
 =?us-ascii?Q?KwrsJWZL/KXsgoBx/osx0uNL3HYtb44Caq7TYVKf3xNYyALNsExxWsA+gtC4?=
 =?us-ascii?Q?IZT4VTq+6znsK9xXiei43nYGqBFu3yL1CBLRm65Cp/tPQcaEP4DFHKRe3Xm9?=
 =?us-ascii?Q?qyDxMGQ3oHkQqOhEYrQtQ4Dof/RV/rY6Mk8fVgVhuHvAeuQkoPm0+JNoZi7z?=
 =?us-ascii?Q?jOh5+JH8It8OSSf8t1HbMhCKbaECajisJt9JYWL0Nx1oPoAZP2FXPqWeL3SV?=
 =?us-ascii?Q?i0yqRQzzeQRxoAmE5HUzZdl8Nj+G5t3l6z7stUL4TI87xJVuLDSaRLORaiQ+?=
 =?us-ascii?Q?i3A+Y7+7HNEcYIk7kYn6SQNydDmj3kTEnawgEZNrTA1cMVw54nYQ1XsYqYzW?=
 =?us-ascii?Q?UaLSh8QHu6uS7utn/sXDjhZ7sWxhOrwQ2f2I34CHvGtquqy15AFrwEckI1fU?=
 =?us-ascii?Q?Tc2avTV0rPghrD0Lw02lZejYgsZNokEZHMAHFWixko6P0c4CSx0olhd1PW8Z?=
 =?us-ascii?Q?apFfUdktL3vTl8Mm8BzVQacm4Mpui4mS2cCESy7JzNgsvFVR2qjkTKIQadD+?=
 =?us-ascii?Q?g4FX2fapV2hfNQQv7YpoORAgYOrUroJdYYJzlZyeWORTrHaeN8Wu7YwZiMlR?=
 =?us-ascii?Q?hFiUfBA3/eYGyaC3a6oV8dFAR4dtWMh/N7zxNlWqZRgN3ShfP8v+TGFu3yad?=
 =?us-ascii?Q?JJ9m6OJSHCt2JelKv3pqzm/ACvLljgeIq1SqzCnDsqgLbNGRSGhh4yJWK/tH?=
 =?us-ascii?Q?+Ojvvk8aEAiMi4l5VNHfbKFGusRDbsOdjHYuhsDDTFsXNCNKnSihrx/jF8zq?=
 =?us-ascii?Q?ohelyVThOG4A5I2pEZ8OZ9zE8UpbsTjZSgRE6JJaBatUJFFaBRjkSQF9gv1P?=
 =?us-ascii?Q?9BShvuQZr6OKH2oZKGD0jJ2XeI0fPPYSxUUsSUgo6GfvaW+MBty3JOgWTPo4?=
 =?us-ascii?Q?QLBbDI3kLxTX/WVtRRvKVdo9ruv+Bi1ieUj8SBD1qCZTYvKd5cIC3WdB2sk6?=
 =?us-ascii?Q?0jLeZLgOo5+TrmSCZVnudx9DOPI9KeivDyYB1yOVANSJy+wNjkhM5pSE1+lr?=
 =?us-ascii?Q?9FDEta5alVxOeT+N8PvR6QmBwrfTQkPsJnW7E4HELX2JCUOh6TRWEUPs2QT6?=
 =?us-ascii?Q?Ui9GMHIiQZ8QkIVYd3AYKa5yNLwMcP/OZ46zakizV3fmG4NrDvgB7llaG7cb?=
 =?us-ascii?Q?JLm2uIWSDNHD72XXiN4vk9V/uAsbXsf9E+FUAG1hsubnAyUR5vatuv5p6GNN?=
 =?us-ascii?Q?aU9DU5Hhq+wSCoAJBYKwf5dQovJb4XMaLV0iTz0t3RUIb/NEvSagxyyTpG4i?=
 =?us-ascii?Q?CDnD8YncL7KPQjz10yGDAWxRQmGKap4DXLJvQ9gz1mtomb5IIfuZvRQ5JbXr?=
 =?us-ascii?Q?sDZZcQmNxZdDkP9PeDeIBCRNdy0GuQuJOuWa6H0PT+XogAWcRJrKovhy6+U6?=
 =?us-ascii?Q?wL7dv6cPvmkNtz4Wgva7s1cedCgl28I9d5GvQ17WtTy1Ru+RSfw80C+kL7yr?=
 =?us-ascii?Q?JLquMGiMiNQKhPTRbWBorHEfNz4FaAsEEWgY1ZC5sbA9ZqJh+rZejAvf1ZFN?=
 =?us-ascii?Q?T/eF6a7HUCsQjrx1F0/Mm3+D7DgvkpJnh11PbBUVtWatzR8sB/DKrtdbEPnr?=
 =?us-ascii?Q?OyQIKToeZU7Nfgc6im/auWhOqWX5sCA=3D?=
X-Exchange-RoutingPolicyChecked:
	d9DHHwzcog886/boqP6GsYvfYMwoVxGMzkcarMItp2Q5mCrwNkbDEsAyWXFzgJ9szA2gc2H3l1ZtDBo5Xg2SvNoxZX/yOwbcICSW5ojNPmWk+999b4sQBlaOy57z5fG7E6AnRiEv8pi/GITdh4unmkS6C00fL8dCd6qAib5wIx/89N8wJ1tkZ6bvocw7AlEf+UbJvRa4wRXh/KBVmC6KKtBTzWO1XLMZuqIPhmb1Zz1mslB2QUKvbRGrWHIIr8sgn3Q1sc7ZW0GfXB5+tDcGJ26pEQ8+5eVqOQXqyZEeav0nNs+x5tRvwmCX1jGgL8AlI7kE/v554W1tC9VjvB05Ug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QxUHaqnlS/gVrIjvc4KSsz5PsBcF/7Bts8v9ftyQgEINOqpxJZy7cP40EWL5VxW/qyXc4kb3Y3N2bfSeA5+E9hYlsZv5Snd9aHzJIqGDcguDp8D/yOprUEErb47YkkR80ey1D7726rTVk1SiSRBpf9wC9rYkrhTIXqgsfp4U+tKESEfqP2oIPOqhv4FumHFRAvx2TyUmtyE+6DmClb8c6D69BeiUphh5eHwdaK6Ab7+x9OFWtGrE5jcwiut/Ay9rqHzt3ggvGYigomdMWu/fGeEgD9Hb3WEG38BweDObjwnnwFGbhNQPLUZoQfHdmGv/qkV23Npv04uCvy8m3MWexxAgKZc5/3/XfMKQW0DunaaIGEuCtL9VQ3kcSLxGfjaW4BTwYLC93VvJaL58xDnSt1nSgn7W+qsywYfDZSXWI3soN2DmNqeTSbRpetGuXwZO27O3mbQuPvPekXYrTIrbK2in+0hco7ZicgEyv0mOaepP5vzWx+MKcDXk09oGpX4IUKvoWqqgXAx5esJd7ZiJBh0XY5CRj+t4JnIsn5SoTlwoe1ShyyUACIt/EFptwXq3j2boLDl2iiPx9idRfybdsUNB8iBTIQVSKqUn2XQ4rMLbYgmfB8IipAgQCty1jcfY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086a94a2-3b68-4d9f-f162-08df3e591822
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:00:48.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B2FRey+ccGCmyAPbsUXFD5QqbdNwBuUOMF3LNo1J1HYsTqX99yNsh+X0iIwnfqTq78dbM8Wo5A4Il6VNAuQCiBV6k/3eugxQWFKANl4xrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR04MB993825

On Oct 14, 2026 / 19:25, Shin'ichiro Kawasaki wrote:
> On Oct 02, 2026 / 16:08, Daejun Park wrote:
> > nvme/054 covers the reservation commands with a single host, so its
> > preempt step can only exercise a reservation holder preempting itself.
> > 
> > Add a test that connects three hosts to one namespace and sends the
> > Preempt and the Preempt and Abort actions of the Reservation Acquire
> > command from the reservation holder and from a non-holder registrant,
> > with PRKEY set to the key of another registrant, to the key of the
> > holder, and to 0h.  After each command the test checks the reservation
> > type and, for every registrant, its reservation key and whether it
> > holds the reservation, as reported by the Reservation Report command.
> > 
> > The steps in which the reservation holder preempts another registrant
> > or sends PRKEY 0h fail without the kernel patch "nvmet: fix preempt of
> > another registrant by the reservation holder".
> 
> Thanks for the patch. I ran the new test case and confirmed it fails. Also, I
> confirmed the kernel patch noted above avoids the failure. Good.
> 
> I think the patch is good enough to apply. Said that, I will wait for the kernel
> side fix patch lands on the Linus master branch to avoid confusion by the test
> case failure. I think the test case number 071 will need renumbering. I will do
> that modification when I apply the patch.

FYI, I applied the patch. Please note that I renumbered the test case to
nvme/076, and added a note about the kernel side commit. Thanks!
