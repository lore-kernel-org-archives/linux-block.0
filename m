Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB01DDDD
	for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789087; cv=fail; b=Yl6XBif9609NWUZNhJRY5glwwu+BXWivQwl1PW85hGH2VL+EwP4BREnmYE0TY5x93UThRYlk26l1IzUl760zyKiXHKiKoNb8Yb+tGU1rx+14/gzAVlN+qQgY+nR4os9nGQfiy1vzqJHIXahbE4eLu8KDbbvUvkJf832/54PyQCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789087; c=relaxed/simple;
	bh=Am8cX4PukRsAD8Tm/aNxZBYOAZpNDUBtennmkg61V1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dz+BmGa1mni2bxFz+4MZEBaAQbbImKfxmbEenpfF6o5K7VMXLLi25Cks9nCZirOuy6X/WBDukAWXrpuAU9WVri8QTuQZth7ZLaZITd2PYErnGNzLlwgYBwP7wd7DH+k+bIb1ZaoGE1ePbn1t1UXIQNm8pXKidLLl6SwnHbb9dJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rAVjMpf4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WBPpwKb7; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rAVjMpf4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WBPpwKb7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758789085; x=1790325085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Am8cX4PukRsAD8Tm/aNxZBYOAZpNDUBtennmkg61V1Q=;
  b=rAVjMpf4f2fQOEg9thkJ+awv/weGMh2pi/QbvaZ3UZlznnWYlFBQYfWG
   NT7NzK1kvFtvK5gJB5Xep5piflxzW3UAEx8yToIC+MnY365O2zQacc9eT
   HwEbg9u5m871YPiiJ5Eq9d3qfF4gYHOm//CbT2kYgD/R8+4Dr9A/ERDCU
   oHsbC5nX3Fx0Q4Kb2bOB7+4rV5v3i0YDs3iM+fBaNJ54xpaK9UKgKTOWK
   nm24R/78xGWpuvKCdWoKNRFsgCPeqtUbu7z7FxTCjWE8LVSf1knbP0bnP
   L1N3TngdjeBzwROMIo0sEpr60z95wkwHuVX2+JJa3sxKAz4XtsWgV8gE4
   g==;
X-CSE-ConnectionGUID: qCM84HhPQRGeOpwx6KQt/g==
X-CSE-MsgGUID: DzCoub1fRaSVLrPz6BnjXw==
X-IronPort-AV: E=Sophos;i="6.18,292,1751212800"; 
   d="scan'208";a="130403655"
Received: from mail-southcentralusazon11012009.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.9])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2025 16:31:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovGuHiU2I0OZ5obkphdeM/1/7T2oIsR+3V7VzNBdEvI48JV3n/RuUsbT4QHTNw2FySSJP1D/5FTLoo+l7/Hs7UxCZjIP7qj8f1GCIbSYjQVFcLVCx9a42Xb+t1kqZeGe5vXkR7d445Ddb0RyerBKt/sDV8N1XY3FSrBm+KiQ0ukq2Vo0OdF0olSVu3mGcKMwhdKhd5+TCl7iE6W614/T2WI82t+WK+UK7X/QdW6rdSrywhcXCx/QtYd5BCbKQe5xi9K+wZCphK9zkV3KmASViSY24GEcE1GPw0vYa3AAwEV3O08Zoi3miLnwh4LxTCpwMvZjGr76Yj9Dlmb92YMGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tazciDRMyADue0xtjtGtntuvQctu1agMsuYD/fH6rjE=;
 b=zGreUJzuldoNEvL8Ht/+SN9FDD1ipKsnEIvk3Ot5oeRuOuzFHLxaqcVp0PdH0RKB71Nip46jVloogCKG39uPnJH4zmqrTM0SGQgr9HNomDHU6LYp7FhebxpXo4D4DNalGETlfdAYdKlJPmZb0Okyls6WGm7uudrabqSbNmp7VINcxAghYtqoT3CtPLCEqK1RdZaAk/OX3jCunqn4NItvp8oOk1YiN0MLHkK6ZVtozFr2SMVh4oi5yHc1W4ICIwQXY0zculzaYvwSJRGXQDIHmUSKbx9AJLuL9nPQvlE/WHKvrOhwhI0J4Sc1lxNoIox6YDjS8asxj1XIjitR2j1wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tazciDRMyADue0xtjtGtntuvQctu1agMsuYD/fH6rjE=;
 b=WBPpwKb7jkqdfInUr5nhjj0DTLveJxFXu7VxTCzzMgXK5Ya2Vv9rJzlmhJ3k3EU+hX11AUH5j0dIT4Q/vCJVJfPbq23p/ntjZ1kv/ONZTu/UX4BgJps+tnuYEgGMvXLMtja0oc4Xn6rwVkpcA80YguegxY31FpCPDVWfiAaoi70=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MN6PR04MB9455.namprd04.prod.outlook.com (2603:10b6:208:4fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:31:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 08:31:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH blktests 2/5] check, new: introduce test_device_array()
Thread-Topic: [PATCH blktests 2/5] check, new: introduce test_device_array()
Thread-Index: AQHcJ8kh4hiGMYaaFE+MZ7LqQ65817SjnfIA
Date: Thu, 25 Sep 2025 08:31:17 +0000
Message-ID: <ndp6tijg5r3tiiayshiageylzqbsbepappv67nej6zzsn2btfk@6m63dp6kjdq5>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
 <20250917114920.142996-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250917114920.142996-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MN6PR04MB9455:EE_
x-ms-office365-filtering-correlation-id: 50317a1e-e69f-48dd-3e84-08ddfc0de5a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W4gBVUOivBH5295qWaxDO1cCdTo2bSegIhcwntcqzJnv0RvoqrMG085SHIYn?=
 =?us-ascii?Q?qEL57TxwpmWqGDD33vttsN+jY4HuefpaO922WU3pGhPtdwNWNIv2fvbgD84E?=
 =?us-ascii?Q?1KWbFoUWReXIPYFRkHzhgDbrtOekcSFvHcIPHWHOIAZ7rzElhCefXbtX2irt?=
 =?us-ascii?Q?YAfwIf7wBg3BNwjm1O2+h4f1P2+8WRzhxb2o1sdPv0xayyAnUPkKK6ha//ag?=
 =?us-ascii?Q?nBEuEpabR+o0NHohXtXvH03Jz2n6c9mf63IeqXZsUWLHRDc1PH7u2g21UlAA?=
 =?us-ascii?Q?xkUvSJbVJeLNtSQ8uiwXTw0POwqaZTqiHddgdHNlsLnC6IeO/kg+i267QrcL?=
 =?us-ascii?Q?REunm8eCqO937T2s8j6xSmUmMAg7s61+XBc3mH6icSNlGpNjT7GJjvimzalX?=
 =?us-ascii?Q?uxEEaBiRiTnfqHyrHOZ2Lwiz19ZUBNS4N11kHorNX3tWS59+fr3dwex8rfTT?=
 =?us-ascii?Q?rS1/DCQVWMnI6OkrqxdzwGyPQ8kPOf/oCJRkyqZPHg0wLuh83+eC52hc+vxo?=
 =?us-ascii?Q?6sja+4923w4KcRaV/QqnQb1S2KBwEKUgk0lPmDl9Jrl6/AbcKR+U99kJsyQE?=
 =?us-ascii?Q?TApVtCvDTRX5bI1Pc4OLKjjx82XRpwZuDsM22h12hKuzNKSzbD+vvCS3tWWc?=
 =?us-ascii?Q?8qrkQLMBTxiIgr+x1f4MYbBlmk5KFZjGwWU93Czcz5B5/WtYhHDvxKxQ+QO8?=
 =?us-ascii?Q?TPyMXcxqfTs/14cV36K9AzZK6ExgRPMD0kfLCveAZKWfpiDxutli/N9H1bpW?=
 =?us-ascii?Q?97YFQ3v2wVfWRMsXoSp+0zRbbfUN+Ha4dzjRsXq4gCQxKmhvO4+Yoi8CzrvI?=
 =?us-ascii?Q?sYJqtfroKQH3gnZqjNExKA7Xe+ZgxrUMNxzgtNrCCMtaIzhgMtktAgpaOZug?=
 =?us-ascii?Q?tAZsU9ExJT7Q2nyzSYZ7EQFGSsmd+XguL71qw8XAhuFyX8UWywJaRy+hY9dP?=
 =?us-ascii?Q?L/qso1gmgodEhmgNAm3EH7pJuD1B3CoRfLMYfbWBy8c4AdWNC+XGDQ1b5Ikz?=
 =?us-ascii?Q?vjGFDi4qBVAL2wwck90ADI7zicfFgtOIZfpscpgkg5lha/poe0t3Paa82Cfp?=
 =?us-ascii?Q?pnS3MTchv+YiaJ0DcqC8E7ZH5gvGMSiYTGjFH9B1UmhMJ+ZwhIJwQeovcSto?=
 =?us-ascii?Q?ZAcs1z6YUqzBDg/RCzG0/EBgbLMxeccHdRpVjxzBO13HOqmlv6HSCWBOAbAe?=
 =?us-ascii?Q?hK3X8hOt/BdLIgE2M9iRYqzqmlXvF7EZ5FTCCsAXuYUahlosQEddqMJlbjRX?=
 =?us-ascii?Q?dy7+BOSaNIQ7z46X6BoClCeNg6oKAjG0jHqXMJM8VulqVpB4hwuELZpG3NOa?=
 =?us-ascii?Q?/uBWyR/vTq+9W2P6JW0ug18KS0ALSMGC0oSK4OXeFVS6OKVNe+Kd1pRropkL?=
 =?us-ascii?Q?Op1A8WFSgyqwkTP89Ng56G8nPZBNL2fyrVUe7SReZTwFlQNrmiQInkCA8lBC?=
 =?us-ascii?Q?HijGKzxN/Cb8Hn7++09g7HXeAc/jzg5ljwx81jGXVgcIWlL+ow+LWQRHSdrU?=
 =?us-ascii?Q?59nlYwmx0RlfaNE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cdJByoiC1AHxjoZ57SakzBAV8KPWWiQ8n1dpA/jbhH8ZYxBqEgk9bQZVQNv0?=
 =?us-ascii?Q?AaXLWyYsHsZWlMjG9HMvPziEx3hnxdDl2/201BeeYkOaC8ZxvfVQUUw8UFlm?=
 =?us-ascii?Q?POnAaupv0l+PhvjatqHj/VRVM/cmKNHZySrf/FL6nzoaZ7z2avEOwWLh7dQB?=
 =?us-ascii?Q?nhWNIzrdGCvrX0hDEhjRnER/EJzBZmHyqNeHWwwCpQmxGYIIthnJZ1agMrCc?=
 =?us-ascii?Q?N2tpPNhEXZLMGr0p/8/jyIktKRRLxM1wIDQj6x+thkt27/Xqnjq/wbXtl+Ok?=
 =?us-ascii?Q?edCYYloDZ4UN61jROKVCw0D+XmDdd0nmwkqpanEReWEsE8XS7Wc0uI3bq8fF?=
 =?us-ascii?Q?caflFt2vrTftrAn4u6zNAZsWQLyRmBCNRg+d7/07g8pOT/yY5PpsxFf808nK?=
 =?us-ascii?Q?xk7bUj3Q+uKjYsLqCHwgIfotAjCN6HrGu3E9Qanf1h5Oddj2pfw+BhJNTbHp?=
 =?us-ascii?Q?29JdlKf3InTbaEFE2LVDGz6vvTVP1M4zWeJXGYpzHZxpUAmEXRapiJhf0ul4?=
 =?us-ascii?Q?xSI2KP01lXvnSbZnOquZmTXEsdmk1+U0l7HjF8Pf9MlEmQE3IBOSqHJK3JaI?=
 =?us-ascii?Q?zrFb+RpHwaPwJ0x6y7tylrMHR3DYQrx3YW5St+MrF7OE8z9QNpmAeAcYPvRd?=
 =?us-ascii?Q?rAC0DfaRBVspqhz+yB8wnDV5J2nOaJja8obuz/drAmCXi3BXT9nBYKLxcMfB?=
 =?us-ascii?Q?jShb1mUEfleaqnEXXWPekAagwg//bUjlfPS9wePa1hC98yFgXNxLhu1RkRIe?=
 =?us-ascii?Q?1MJ21OdHMoZHlqlPriARsyMONWu34R1tBZlmpLJhonLh9qsUSTc8MYGmJY6Z?=
 =?us-ascii?Q?7KO+17/E0d+fo1RyT4SZnr1sky0RNchjP5av0aN5ggAX1nUsRXtnissAICkw?=
 =?us-ascii?Q?0/0OLPl3B++zFiXTBSsx1vX+3DT7iNgXbLB89MmebvJJbgl9nn8OKdTFSbtL?=
 =?us-ascii?Q?5sd/JoVFOKXH8aKvayEzdYAPK6udUfVsG3t+Sqk7jCj0YNjFWNfpCq0XN/Na?=
 =?us-ascii?Q?nms/TK3HUpKm7GPP281Or3P7elgguWcdqjkXV3dSJk1+LH39mRthHDWV09sd?=
 =?us-ascii?Q?Nv465wfUTQj//5LwDCKOid40Xpf6/ekk094ZLlROa5DaU2efSzCVMnQA1ip2?=
 =?us-ascii?Q?QG/ov7kzOt/ZRP6SRAm66Xg9us8s3XnWBhPx8T68nTd7XOjcsDt6P00B+XKj?=
 =?us-ascii?Q?y1sCYN4M6IrIqxFrfPwzwaUvJzTVmjXWTTxB8Q85ZRCaiuXdzqElA8Qkewj7?=
 =?us-ascii?Q?UK7avDWVsFWSS4jz6oR3waNFGEy0ZY6lGj2MqIdSC8OsLjVvrUXTJu6uiRqd?=
 =?us-ascii?Q?L9DpPO/CkoqONMjfFxWyONayKBwEtKQBoqR7xjvHpWZgpQ/D0zqmfUbeKYdo?=
 =?us-ascii?Q?xproltbfwEMRxnVQ6e8C9aKP2IWDr9DHtlj+vatiVPrNL8LxJzRx48s7B3v/?=
 =?us-ascii?Q?POG/sN3fwweAenBm+6yI4YRVTHqAfKKZ9r398vys+dKLbYY5EnKNk5v8XGya?=
 =?us-ascii?Q?nj3DLaU4+EhGn4UOYuio3y0mWleMXuodDVg0Sv4ntfSF6zeqDjsz4yp+vpNL?=
 =?us-ascii?Q?JaGAiM13e5Pf9/RPE3XUVctkA6/Gvs6ngLsC4AlHQ+CKGzmJNfhbCq8yeWyI?=
 =?us-ascii?Q?gNuswEQ814yptv8+DWG0hic=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <986D7601CB9168409B8A6710034D029C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qNaTOvCl5HVhqQvHfw0+R71T/6YwnqOCernr03zw6VO8ny7M19Lh2rae34Oo4N4S34nu4Y6iZ464PkoQZyypYjqVdaFK8M/xftx7J0YWnbo43/kTJoB+8r6WaApOL2VYg66Pro375knft4pmTjG1wcoKGBCQ889yl6NuKDe1+GCeettujN3qCd7il2KuX/r6gsazDR0QC4hT8vPWBqORWdAtirjne440BF0lAJBJMFv+v+CriQV1frgDazBJ61wdadOWr8mw7zXBYnHWdwdOpccLhadAC1fZ0BCEAluC770jDHnpherHrUWraCzhr629b0LNvcoKsMfVlGt6tgG4UWSoca2TOXtw9xEL1N4L/q8nASEQWZMRSUhz9PCyvaIQ8Wjkrdg0lsupRPrgm03mp1Pzgyr+mQhTQvLtLOcK58BVvsuShYdypw4FiQau3zqaZbcuDqncEytfTwk+I9i38gtrWEuJIJcBqkoul7JYX42aV//yRBNMwYEcH2V1m6D0DW2Iu70PdNGGvj4VIyDd0VTC5cKen7E72TYLp5wgZnggc6MiplkZbIezz0OKeM3cpZrPGwPZhTC1p32PIhKeyyH42gWByPgHvF3BBH3odZaHgeewNclvXOghmVoZdp+3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50317a1e-e69f-48dd-3e84-08ddfc0de5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 08:31:17.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEZh0tuWJGeyJw9yGFv/UluaQB40t5PtuMN7mk77q4EzS42w5D2C8SIQdCTQ+BVXE/YUP0yPJQBsakwn8piN5jXrNlp6O59NcD0h/aWSNx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9455

On Sep 17, 2025 / 20:49, Shin'ichiro Kawasaki wrote:
> As to the test target devices defined in TEST_DEVS variable, blktests
> assumes that each test case with test_device() function is run for each
> single device defined in TEST_DEVS. On the other hand, it is suggested
> to support a test case for not a single device but multiple devices.
>=20
> To fulfill this request, introduce a new test function
> test_device_array() and TEST_CASE_DEV_ARRAY. TEST_CASE_DEV_ARRAY is an
> associative array. Test case names are the keys, and the lists of block
> devices are the values of the associative array. When a test case
> defines test_device_array() and users specify TEST_CASE_DEV_ARRAY in
> the config file for the test case, the test_device_array() is called.
> Blktests framework checks that each device in TEST_CASE_DEV_ARRAY is a
> block device, then call device_requires() and group_device_requires()
> for it. Blktests prepares TEST_DEV_ARRAY and TEST_DEV_ARRAY_SYSFS_DIRS
> which contain the list of devices and corresponding sysfs paths, so that
> test_device_array() can refer to these to run the test.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  check | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 148 insertions(+), 11 deletions(-)
>=20
> diff --git a/check b/check
[...]
> @@ -637,6 +719,33 @@ _run_group() {
>  		# Fix the array indices.
>  		TEST_DEVS=3D("${TEST_DEVS[@]}")
>  		unset TEST_DEV
> +
> +		for test_name in "${!TEST_CASE_DEV_ARRAY[@]}"; do
> +			if [[ ! $test_name =3D~ ^${group}/ ]]; then

While I did more confirmation runs, I noticed that the check above is too t=
ight.
When $test_name has rather complicated regular expressions like
"(md/003|meta/020)", the check above fails, and group_device_requries() is =
not
called for the group. It should be relaxed as follows:

			if [[ ! $test_name =3D~ ${group} ]]; then

Will fold in this fix.=
