Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B23FB85
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110220; cv=fail; b=aGAns1eSAL5DZZBT1t7UdnDRGAOAntG3tPyro6oNbWt9NNvfnzuxZCb3GnMX3EoNFd5x99kygjCe2zj5sR/EkIz03TO/YNr9Dp7O4wadY1+shpWVdgKGpV//53lDRrelgzL4gZo021ZTogrBUUG6zBOL1sbELuEcuyZLVCRtbHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110220; c=relaxed/simple;
	bh=nIEaVTP51aMHMXvdxu1xWDm/lakqFzktIh7Td5M0my0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoTMo7kgQhi/uBlvHB9D0LcnPaUfrJ5bnqoJre7i0yQRFUGZWYchk5P6AAdKrMnoaxizcOpQC9uxKVQfGeKfTabvi4PbAW+zHlwr0s5fQMo6vCXfDyM0dkW8zAPYma7FXkObwAj3cP1AL4b0xrQmOM0tEKy8WkMMi4guIo0zVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nXf9Ikth; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IqIGQSj3; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nXf9Ikth";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IqIGQSj3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711110218; x=1742646218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nIEaVTP51aMHMXvdxu1xWDm/lakqFzktIh7Td5M0my0=;
  b=nXf9IkthRD8lcAYZmyMQRAv7LUwfkwZsOEOFL68CM3h8ZZooZOndgpkS
   ddoYPYm5X3EreuPXiZ0Fb1Xj/SSqrG5iVHWB7n5yAUTPRMsfK7ohtLgPY
   JRuoA5UArugPmP9WJ1kjewitYbYf2GoQaIET2/27ASGg8DZ0HsKXJzUf0
   aOg7IhBHPUsS6g09rLOU6OYPVa9SuwePsKKSICUAXw+mX4G+b5V3pELQ7
   wW/VOdQb/ayoPbo2uopWydhL+KSp3NSVQbUtiEcTv/zHAgzAG3k/2ieKA
   bh4jYzUXSwAbIwdpIQervV/+/HLPJZal9sTuNtkZYQVh1bcu1h6ZF+jqw
   w==;
X-CSE-ConnectionGUID: QYnVIKgOQSC+YxH27Oy9LQ==
X-CSE-MsgGUID: uKtJbEHiRIq5D6LOYwBrkA==
X-IronPort-AV: E=Sophos;i="6.07,146,1708358400"; 
   d="scan'208";a="12244872"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2024 20:23:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGyB/w4y70Uk1eb4RVuBsPQubaskbNEqvF+gQVfhSAxznBd/+YvA/XSJOjlA7CZHCSro54NUhsfLW+KdXJRng2FQvhBpGc/AFc2mR2H6ciRQU+W/JyfoOWDWl7y80WW8wtR48Af1xndZ6EC4gUaMPgATVWS6Y0Gxwn6g4rX5HtPp5C7pGIZWZtTvyU2NIx7lCRHQTz7cb7mHHbhMaqSbahylwSbRJJYgK80yh6ogGGrxqMZOm2YFxPxgLY2CVe3/CBXq6PWK9z/AYBfcvB0R5g+QLGnMVfezyd+j2b4nQr23kjXIGHEDIB4IhrIeI3SSfhzzjk0d10SoJIl0XSaiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m0Wy2jl31etnKSr3KEc3CAI4bddPTXgmlQSfmsDY0M=;
 b=V4WaGoH6suE9bvadECd0VFAUbeArYdpBhcNAeTxotgQoZYADY0BHEDGy/EZDgEaZQO7alFAA7saEUohIg1LDjmh3AJpGaRtCa/3dQog4HTMHKWtAvqE1W4EVWZ6rdncQf7cY0TsTNxJmz09r8JBVC16eNLQCXyX8+aaDLV8yyeQOvS7xo3IP5nOve604X3P+z3fVgz3PHFCPxfJlzLWEqsZ8J/WWzKsUJQvKcB8BAEyFtu2N4H2HKkalu4rHRnvAWQNCFEKL24LRtqj0QYsah6Z565mAnaaH3Ex4i4A/muSzrwSy0Xn8xWWI5eQd+JRTd85j3vgd1m8vYDuRdzVCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m0Wy2jl31etnKSr3KEc3CAI4bddPTXgmlQSfmsDY0M=;
 b=IqIGQSj3YnEgEUjR5fptseZHoytjz58tJrELYW7t7flY2fueNff/wKsydCHVhhbt3agRc5koYqmHdJraIWU2EyaFZUP26/ZNteFvHqqN9zdK1QzlmfEVFUG5uUS0oN9SaHRjl+e5OrIJ7ELKth+twdV50kIHNjFfC70nTMm/fQw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB7938.namprd04.prod.outlook.com (2603:10b6:610:eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 22 Mar 2024 12:23:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 12:23:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nbd/rc: check nbd connection with nbd-client
 -check command
Thread-Topic: [PATCH blktests] nbd/rc: check nbd connection with nbd-client
 -check command
Thread-Index: AQHaedp7JX6c+mxOuUiGcYNi6ownSLFAJ2mAgAOMZgA=
Date: Fri, 22 Mar 2024 12:23:35 +0000
Message-ID: <lecgttcqtjsolotcowjvqwsyrphe7fucllkrzupc5guf2gbq5z@grmwusovo22b>
References: <20240319085015.3901051-1-shinichiro.kawasaki@wdc.com>
 <CAHj4cs_Z_qsiAtDgX9ZK=tXmF9CJXCtXYL5qMWWhQvrAdmTRXg@mail.gmail.com>
In-Reply-To:
 <CAHj4cs_Z_qsiAtDgX9ZK=tXmF9CJXCtXYL5qMWWhQvrAdmTRXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB7938:EE_
x-ms-office365-filtering-correlation-id: 0b27454f-115c-442c-ad8d-08dc4a6ae559
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /MHKVPnjjzmhUfH5lcLxhcDt+qjZKtDSrDYjG6XRb3OIReF860P/1YQABrsO+PZVu9VPUZJal7qaCq8a7ickK4v2iotge63vrGCi3gCNJ2V4fKufNnCgKLvgYsNf1g2Sg/wDqt3/XeVBBCBXRR3SpgVnarRy0Y2ay9JkcHUTvRhIKdd0z1Ae6JEQKIrGV60/PNNQTOHZb/D7SK6y1w/0+adVqOr5UOQPEnC1mEbKiYfRSVLlpEq++iFa1QMJ/nWrHms30Bf9YxDGGUMI9Qt5D+XqxpdLm7wr1taE/KrNCEZJHpdEpRIAzrM5L5KhfDWu0fEw9HGSdAeOtOQ1tBrFgXzkJ80TD6QBMjQ3DS1eaMHF8mpn+m1YYbKFwbP7yFRGPldyse7vqm/rdXxugjwm90MhNXY8UHqDTFykS43IIllRN77zNxL++NcTXxEkBXHG3FnfV84BqkXxDdq6jJprmu7U8HJpwdqcKMMlPK2sRxZBYzDFuBJIcmv5wMjT1BrpHqQ2rrZVigk0b646KG0xIZSONW4UsN4SmZkbc+OS+gDKS8ptnrc6/TWEQ6joIZDgMVonLN5n38Bkuiw4QSywU0ozsbruv1qqkq0+Kjq4aBxgTAtVEaCtpecSlNNUBdZLyNXPvgzELAxZnMuiJYWKNR/Qw1cEZ9ToswfBqz02LwRQuodFUJo/UOpotmLmXqQaejZHVMQxBddTFMdveJM3BfmS9Orf/CXZlvIlr8FCvME=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwpfwF/5CWRoLF1HFyZ5zHCcLwh0t2y0TYQKollk3uCpOhRQ2rN0v4b7i4Ub?=
 =?us-ascii?Q?CP4B/XPpvN4NumtwNikoV9XzHjsyjVRHdQVVCA/GEE3idDfgR+qXO/J1ARVJ?=
 =?us-ascii?Q?XPyBXKjckewN2mfg2/S+qQMSFlw4lDxsV+vHfp25/F3oh7f++h0HTs3pzPN/?=
 =?us-ascii?Q?NfoRMUFVWKXJBAv3PX9h9LPqgV9oG8y4lC1zihvpRDUXmihhAq7M9O6cDj2f?=
 =?us-ascii?Q?OHT5F5oCu8V/VwvRXZzKdlsLzp5e1J53hQjJGQXU6nEnhIyO91+cWKoWBZYZ?=
 =?us-ascii?Q?9YmBboer64folM3xcycXMgrakAwHZBWPlbVjJOa8HE9OINJYRa3CYT0ahoPi?=
 =?us-ascii?Q?C0VO6PJpo3pAgH4bdWpTzRPSegTtdsnpVsJMLiDs+NoFZDqtSzZ2Xt9JaR0u?=
 =?us-ascii?Q?VGVGZACu3/YklXX3yyiS5uFwVjfiCJ3xuvCI/MVf+GVw/4Msp59HyCr7zUQS?=
 =?us-ascii?Q?fdPfZ3C8FOGtf0qe0YOSDTw9DVBJHuFyc9aqeeHNN1mUT/CrFPJqfiz/wwiK?=
 =?us-ascii?Q?blWtvHSBkuKKOFrJsGc1sshqnoB/46yJXDGdwlTKxaKL027XfnGWE922JZBC?=
 =?us-ascii?Q?HCCpxt3RCIoQfDdQ0z7cLrUlX5oVLbFculoBIy7SOgz7DgcszrWQmiiRRZeF?=
 =?us-ascii?Q?EytCF0ijiZDvpt6acZ1Sq7z3S49KL0exGK2JtdZ52/MJBaBD3a/B7fAEEN2M?=
 =?us-ascii?Q?ok+fiOAg+M3AmXlWGwIxW6XRxW5jriz2O16BBsLunEyY00ZZwA3QPm1S0WJC?=
 =?us-ascii?Q?NFO0WXp5siIvIfEKqDgxeeZab57EzwcQoLKBb1MGfFKbm9zEQKWvPtNGeGRF?=
 =?us-ascii?Q?WfrXryOlCNeK3hyyM029nnqmp/+VMZ3nhR7o+mgwCJwu1REQZ0NfnfnPRC9H?=
 =?us-ascii?Q?bkq+9G5iQTRWqKtwCKut3g9yaZ+OI/ovjM1lMzHyqkC10SolVF2aZ+1KF8Zx?=
 =?us-ascii?Q?REDf1MOSFQTSYHkoyB8zhfcNibCOm7qnNOkVOgcxW8q1CtbXkR3Tnnyn8OPw?=
 =?us-ascii?Q?2j+MVOHTwemjLgZBtFa150NE7WnmBGpA5u92Sgz+400RdXrVdHB/YwIkClhJ?=
 =?us-ascii?Q?iLYWa0zwkkqA3NeWamFpNaMwAg3DYnJ886LF3zddfsbv2Em5NtH37C/Lvhyx?=
 =?us-ascii?Q?2ENXfLF9Scy/ogWAjrw0g9l2FjUfpjeOtGB7LkuVNo8UxjZ8w/GlKBdJHV07?=
 =?us-ascii?Q?YO07PLUI/onvzZ/we08ny691kC+1NLDnsx1M/6QY9mhuTnLaGgVzGieChqdr?=
 =?us-ascii?Q?snjFxFSg8nvsk+0AhYI0TQzZklaxcAjNvGc/1EEX30TKojEPFQSZJJnbbucB?=
 =?us-ascii?Q?xYNuWkli+ZEhhArrdZzeYhyhU+JXtl8dbXnqru200IlpIz59gm3W1nxmMkRr?=
 =?us-ascii?Q?q502SLmSPTNFCrGPUZi6NZIeiigd24hRfcZVDeuKMYkpdsvEm8tOT2x1ow8l?=
 =?us-ascii?Q?S26ocUqg8r5Fyi+MZR/OSw2IucZUJ/aIlcDC34NDO1oYmYZ9fAtvw4Hum/Cj?=
 =?us-ascii?Q?ZhnT8oJnjR1LspSAhjN8tLoy1xrK2sXupWnTx1aUMfqEnuUTDPL4m7DGtSVY?=
 =?us-ascii?Q?x6HYbCIV1RJTaV7ErwkHrYhfVum3s4drNKzsn9dr32buXiHmUiZZrL7kNNH6?=
 =?us-ascii?Q?yqC+tHfRoeFojnxcrglIvQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8ADF6FBA8F5DA4998777A23E9E8C052@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yEeio5ZHVJdG3FTNig0CxLACDEytTYxelwqpqIt4V7UsJFD98rtSKDsKrUQ+O2fRrQbPBpOGLGvAxw2YpSkBnnvhfCdygDW1QcxBO0ZvTrs883Oq4aeNqhaV/6IC42TSyDtbUH7e7TeRrrNzcGxby6GRpqvrSiafzJyjOGvggB1kRXojfXFnDZCiie6ZvWCtGLHqvurvQ+9sgwP9Rpw19JjKsa21huKhPLtthjeVZruXZT3TPa6dK31dPpAI91EH8B7NeGaN6c2hsm3WPrChuM+PJ+Vvc+Xtmb7+NCTawqxsThshtqW6y5p2m270pnUiuqvshKK0IxvHi7gU6UC36EwV0M1TrejYaUVo5khVsDgfYPjwchDMB3cFVT3AhIeMnABSbyLLb0iwQhcHFxqz1yG0xdcMyM2UsAGykCKqckkuBjGGDLOSKjUHmvlYD9XoniEcPOFwYw2UOkAhIKwDDSYLDFWCnYmLBHFPe73kYRnJfi2I0cfg6KjyH2JvA1cJ1TK1a+kqLqPvLU5yp6ksmY+chyXJntLjSt49pYU0pE9TA6HtRey3d+RWDnVgMedR+pkiXDeIy+95vo4DsYoVGqTifHHZ2U+OpaGKk8WCsqlr4F8JLz0w297+T6n1wO30
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b27454f-115c-442c-ad8d-08dc4a6ae559
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 12:23:35.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CM6rfjBQHk447u42/2z0lxuGQc68kZaVaH0xWz481mTlZAcOtaUD3Tv16RMvLy6/v8KfHFR4554TfQTazYFnWENsE4mp2riRpIxPkyNHFcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7938

On Mar 20, 2024 / 14:12, Yi Zhang wrote:
> Hi Shinichiro
>=20
> Thanks for the fix, with this change, the issue still can be
> reproduced, here is the log:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D98
> nbd/002 (tests on partition handling for an nbd device)      [failed]
>     runtime  1.436s  ...  0.917s
>     --- tests/nbd/002.out 2024-03-19 04:51:34.051614893 +0100
>     +++ /root/blktests/results/nodev/nbd/002.out.bad 2024-03-20
> 07:01:28.769392087 +0100
>     @@ -1,4 +1,4 @@
>      Running nbd/002
>      Testing IOCTL path
>      Testing the netlink path
>     -Test complete
>     +Didn't have partition on the netlink path

Thanks. The patch reduces the ratio of the failure, but it it done not fix
the bug completely. Without the patch, the failure happens once in a twice.=
 With
the patch, the failure happens once in a 30 times repeats of the test case.=
 I
will dig in further.=
