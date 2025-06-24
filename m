Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859A26B09D
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754616; cv=fail; b=N8dojpPBDu0jQXf+JWEMth8Te9lueTM0mJQz2gb1C4DAlsnPuamtdO4wuSByWYUwljNC4cacLzma2GApHHxIJy61ddkFDK750yGkiUNAqqdeDHwh4Sb0dFEwYW77lkIDgoCiQFyGD5n9MgJiqVViPhagJJzRJFfh5Z+wvtsh11U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754616; c=relaxed/simple;
	bh=+F1CH4FSrGWXeUVGM5uzjmLD9wH+Qneuu22ofj2A2b0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GfZoQnUSraQi3S/pVOiFi0cI0F650pFJOSxY15y1oIJxLuno9ZSERYcaSZRw0mRHDCuHoz3CekSr3eJWySCXTRhb2u6pdQMEukSF1Uklxi/R7n7d/yANxBCVdXqA+sgMmuSMbz5xM01Q/Uv/PCdgng8a1YNwTR2GkbzpJYuys3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cys574B8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mtIuek9w; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cys574B8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mtIuek9w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750754614; x=1782290614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+F1CH4FSrGWXeUVGM5uzjmLD9wH+Qneuu22ofj2A2b0=;
  b=Cys574B8qL2b6gpRG/eQ1xh28TYDvCLikRH2WpRbOy1S1B7MwKZNB66P
   2bkx4wNKz1XoT9ywOxmXNgYOcxkYKIZqkrbzF9o40tTRg8U4XvE/cG7yQ
   lTmEm5QdyxyT9eaY2AsAck4NacwO1zlsyrOibY5s39+v2CdlgskYthpbp
   G0qh1p4D9T4tzjKRhkIUam+SmuwzeNX2Y01gB1Ma8avvtENVym2iYLUZx
   0B7V6AgYL86LX1vWU/yzn3Oq3T+fZCQoPqjtiDRhjMCbn/BRe2pLxnrO4
   BFgGlllmEZ58Mw0wZhtrbfj7G8iFajVQlh0xmhzv1iXCjGecw0xnLUgfG
   w==;
X-CSE-ConnectionGUID: mPes9t9uRVCOzlLwAZOXKw==
X-CSE-MsgGUID: x6qidqTvQjutqkUvvIMY/w==
X-IronPort-AV: E=Sophos;i="6.16,261,1744041600"; 
   d="scan'208";a="85875400"
Received: from mail-co1nam11on2064.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.64])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 16:42:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU4baRKRLxPY4QBJtBjkKMADEfydUPkHMiaEVd2phlya5Gzo1hYO/AENZF3/ebhaW+g1jwz658KzE66Aq/XjuKsJ8r934CFRR9QT9GOqqQ2ksALqDUE6IjJP8n1rsjSsxQL9p0AOpcEyPiBKk5QXsi+bqGgN88vHQ4tDvJZoSfiFZ/6zNpY6ZQHORFOTrjqoEiFu+yUXdRmdykJdzpuZp/X5dKoskUcEGfFFUwo2XTZPiD9xwkk+R2bS0PNFyZwmPIfnMxYQw32+oaXx9/6YLYpJXla8O6ep/FSGgyihhOXjdjvJnjKifKOaScGO+cWDmAbfTgZBK1KVv8NYy+KZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F1CH4FSrGWXeUVGM5uzjmLD9wH+Qneuu22ofj2A2b0=;
 b=LbIa+NMcxH/U5IcSj+Pq7Q0bqCMwy6ubwHD7iWCZJUp27zNmhACiP6A0t2DPyxLp3WyYhdNc62xOy/F7825XNNrUavcWzdVA7Bg5tn88u2VF/WN/gNHGIHEFFD8fFXBV/U5MV8nUk/sK9KDY8urs2cYD1zkmI++2ZiIhB9gJfv6+hy+LtNb2k9I4qRkiPmY8JllmIhzSsnVvmE8FgSDch3bb3q0YmoJLUKJnOS9K9Siii54vzJJkzPPzXfwnHsy8GlX39dSzM+mPkqXt0blAeb3Qtlcjb8Y+d+rfvZvlk5gtYv6sD0w5+ifapJwWTY+VX15I/ZRy8umjYB4rzgvqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F1CH4FSrGWXeUVGM5uzjmLD9wH+Qneuu22ofj2A2b0=;
 b=mtIuek9wAaB4+1e5GmcDfkPUGluiIfFJeltOv+icJ1TIA23HnuLWGdOQP4DVFs1qGMDfwdVO3N/lW9OKKSpRmHSFpNbSRL/VhT+hc9dYI9zNNkEe9Zv9qFV/pwJ/Q2OKBYx8aaTryPELyLzWB6y7t6yzP0moQ4LgOQiY5T2NHC0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6892.namprd04.prod.outlook.com (2603:10b6:5:22b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 08:42:21 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:42:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH V2] tests/throtl: add a new test 007
Thread-Topic: [PATCH V2] tests/throtl: add a new test 007
Thread-Index: AQHb3ycmL7IZbykp70OAk4z062E6Cg==
Date: Tue, 24 Jun 2025 08:42:21 +0000
Message-ID: <y76djjlciilzukpegsbptm5xsmr4f7pmif55x3vetsqgagvptd@qcewiidvz5pj>
References: <20250617012159.3454463-1-wozizhi@huaweicloud.com>
 <riagf22zp3eg2iipaajujfdnaid2zr5tu62xikf6kuadvz7uze@i6fftxqzrnjz>
In-Reply-To: <riagf22zp3eg2iipaajujfdnaid2zr5tu62xikf6kuadvz7uze@i6fftxqzrnjz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6892:EE_
x-ms-office365-filtering-correlation-id: 442daabc-ab74-4933-e5bd-08ddb2fb090c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1NV2r8QlRAU4xPWNECw3NkevrALI6n3uDiIJTbYSyQ11yxAmSK132PZNK6di?=
 =?us-ascii?Q?2usbLsNtTDwWI3ZR6hnjPuc1LMGDF0rTqsms+kQWr1cND+dhDl0V+4OlImYN?=
 =?us-ascii?Q?mLePhWUJRLv/AARil+kyj9zQnvHLVJGJaEao1tre/jQbtYdOAfk3sDtryket?=
 =?us-ascii?Q?90UXxD1wLvxh2nodp3mGHu8tgs/Dlw0WQTzpu26eBap4WmjCoi7JSrSYkYcI?=
 =?us-ascii?Q?kvRTB/JNnpnVeEaQ4JYbDKa/e+rBvlhBp0a6c8MF+9WoJDDWDqazm6HtoxKh?=
 =?us-ascii?Q?jFLb7l7LO9GpSKF4YZbKn4Pg3nI2fnEK6myNkkSKlyrirQJiZwpbJog+BhBS?=
 =?us-ascii?Q?VuM2I3EdcJMNl6TxD40jVRZLIhO6sQFGSsqdpY2nVTdtKsDNryTBVUD5ofg3?=
 =?us-ascii?Q?DtiLTEB2K5Orc2EtV57RdL54me64LfAJBhlMPEkZAUBh3YAKQ/WoBd9sQ+5g?=
 =?us-ascii?Q?koGI+sAIINrZYXErCft9nxozNC2HLK/rLpvXF/cqRoDAafPh4QPEDWDsyr+A?=
 =?us-ascii?Q?M68PEW2de+bEPHlZQLHcufbT9v1URUm5jPwuDFUpHvw4ksVaOm4UW0i6nrA1?=
 =?us-ascii?Q?yz639vA4M7gEraDPwMvl9VG6YpyscFKBgE/IKye3OiuMrRXP05H02wKGbGV9?=
 =?us-ascii?Q?Ne9YFZf3lNZbMgIqFwcLcT8gMRAV+jsnfp6aGjGXz/MELlj/tdS0koyq8gJl?=
 =?us-ascii?Q?hgF0cvhbUV1f196mzBU1GqZopP6npE+r7LG5Fj731FPWRuYjoOh7gtxenUvo?=
 =?us-ascii?Q?Cg0cjYe4aRd/ou4jqlHHb0JI2KU7emBb5V/Q1n9/T4K/08tIDa6lZYagSW+I?=
 =?us-ascii?Q?0EknTJJ3QC7In37Qk6gQNgvl3Rt3H9F22OKZxmxrmg1psLHe7wIW4skExPA0?=
 =?us-ascii?Q?ozU2SGUET5UuMveSRDHJWGyoPg+MX9jiZVqHAsNn9YvoryEOVoE7zaPyv0nR?=
 =?us-ascii?Q?H8/2dpPLbAvlyoWdDJjeRpt7gkEO2Do6TIidpixMbfQxgf16r81A35wqYUUh?=
 =?us-ascii?Q?JkBSFTnARoc/T9zJ+R4wlK7zpZ0YmhrI36BywCEfxRb8dw/uiimZ+Z3DSRj1?=
 =?us-ascii?Q?8ThmenM+Y75kkKiQDdiMFCNTHTw+sbiIdB0nn0/4coHrLGZ++sqwqN9znb1B?=
 =?us-ascii?Q?B8yK/59UiRliylCQ3sJdy61hvddrvlNGl44psbl7VX9VCx+eoNAJQNJStTpT?=
 =?us-ascii?Q?NVWAasj/n3rbKv9sSasavo2r5fxUntzAJ0kesvB/7Gpo5qHncxFMQCAv/o2L?=
 =?us-ascii?Q?rR/cT4QOTqtqMtEoKW9Z26pA9OQJIkiWXdAJiJ8maPkZF3MbbKlLO6bwl9Uz?=
 =?us-ascii?Q?HW7TMa31tFBn+leqlnViHA1rFiaUnmJFXTh9Ki4oWeJYIwrBbWm3jmMo9abB?=
 =?us-ascii?Q?YH4UihM+9XhBiPWIDw1Ly4ff2RPhYDxjPi9EX9XmDN4Xn0phSnUbs5DVM31l?=
 =?us-ascii?Q?woE1sXHblpE/9Ejc6Pi2v45JMShjkIKnbNHH7KkDpgaGPbU5EFKkb4I7QolY?=
 =?us-ascii?Q?ROEKegsJmvmP+E0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jyfuCaC7iSpfUJx3RN7HvWS2IErS7xs+NevN1cnRmWL6vUQQxAUGBOF81KlN?=
 =?us-ascii?Q?4lNGqWkIBeHjzZK9Pvm24H/fCUop046CKgtZHWxdCPttLhoFvFIKcfuA4078?=
 =?us-ascii?Q?Gdq2HunMyPVwyEEe2KiJ3aayOC0dbbG35OotA0WNCWrcCP+XzoK3m3dqFu2l?=
 =?us-ascii?Q?+b0WSXVRbal0H75BTnAmm5/ZwiiSZh2yPG8QUFV+PEDNTE2s8XACq4So5Iw+?=
 =?us-ascii?Q?VWflwsX74KkklDaqcuQNmxH2h5/6N9V2h5Bbu9m+KZdcAewYtdQd22fakY/M?=
 =?us-ascii?Q?CVWhz00LpOnaLyDqlUoRic5x2g0lspA2+7EIoEs70ntVvvxbt1+QgblNz6wy?=
 =?us-ascii?Q?NgRdtLg2chblnh32QpSz4jfGjIqKu2JYcFUvjj9DbuLE0ic7SrLG1rsJllKi?=
 =?us-ascii?Q?jpjicDvuwGo0G3VjXtFpxfX7dL9amhx4s47VcN1jL92+cs9eQXouDPAuzqWt?=
 =?us-ascii?Q?ekI8RthUCB4Gme5Hp6bkvrPv1Ci/Me2Tb4TFmR3UhvPDP1YSsAIB+IlsM1Oh?=
 =?us-ascii?Q?K5b6IjfpEgNksf+SaIEJjlKE0MH2ZJ9d0Peifta7mAAKteTdlBlSc77B+q1L?=
 =?us-ascii?Q?FOgqkhgYggHa5je9kTxiOi1fWREsrm0l/b/ne4CY3ewwe8ccLAzL566Uq/LL?=
 =?us-ascii?Q?2WzjWqCvtV+PqNcB7gC5whdmTY4tWHdU3AuuxoUBsWDsnTk3hWr45FtvKXZo?=
 =?us-ascii?Q?tO+zsX0XERAhtKj4o0AfzhyJaC0xMiW/TQqAFpopef+zyneTko+1+tBL16cd?=
 =?us-ascii?Q?Aqk/kHNYnc+nKRH6v6ft0ZjzxPthJYCqmfNFYEDyB7vWOHuqlMJE0gNxT9KA?=
 =?us-ascii?Q?yQPUsDyLz2HOZbaZHk4lU8kGgtnbuY6MrOuifx6FB+V8kx2S1aODifrfIbDv?=
 =?us-ascii?Q?2O4UB8/8bNlcjECBByvQM7DajBMJkJ9vW6da4XiKXcMXdA7zn9vzXykGr8rd?=
 =?us-ascii?Q?MFH+khysfADOIo8WVpqDnr6gCMYTiotDgo/OkZWt2ns8aA+9c/Sg12DpnTw8?=
 =?us-ascii?Q?TvzE5+3M8CmNMLBJSa8jQx+JKFn7xkpvS3va+Q//dn9d1K9NDE5TVS9vpTaL?=
 =?us-ascii?Q?LnehgtoAatCiWo5S5grweo13t4md68YOpBY7vtdPKabppebX/ZfvFEhordb6?=
 =?us-ascii?Q?B15PqHSUyKT4GkOLCHfi5VPeMRO/a+cwPCkFOZluD8dFK4in8+AGu5HnOgPh?=
 =?us-ascii?Q?25bnIo+WydtF9Qs9ijVXEwWIoRMjymz+45/NTDIchrACK7Mq+Y1eWSFkUuUa?=
 =?us-ascii?Q?1TtrS6EPzLy6BhsrIJ9OjnxgkLOiWUKTznZkLwK9VacXXNm76d62hfsolyoU?=
 =?us-ascii?Q?MVdxYwmKGD6iBYuCG9rhu0vhm6TznCL14HmA2zPD2P4APnKdGSDakIUxFs5E?=
 =?us-ascii?Q?iz+nyrKmjZvyShEdoBD4JjbzdjF7QyNUtj8DIOZT5J+5ToM2hP/W5jknxnQr?=
 =?us-ascii?Q?CZ9x3bMnediHRIFLatvluJO4CsK/dO+UqK5OIYqelNDaSILJDmYEBNBsCZdm?=
 =?us-ascii?Q?W59uFhMUCyGtofh2j5vHd3uKLMfI7pWG/vFVUoCK+ule9Td+FKYBuMQ/gs0z?=
 =?us-ascii?Q?qNR2lWdbt7KBWu4RWp8Jkl0GRxebWWPNfBoAAiUvwfN6Q4eAf/D6kaeUbn1i?=
 =?us-ascii?Q?lWkBYU5WH+RCt4Od0zafX18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD125C5100A9C34CA5EEE48C3D65E39D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2UfTJqIBbJ9vNBPvlg63NjW873GXKCqechDy1Jjw8OrPDxPCRTFloSzkxLDWIMFw8lQV7NXnWNT98af+O7VvGxSsKHfff7ExPz3ej0F0wtywlBfR7bsKzght3BTMUfyS9G1oS+bFK4fMlaDHxqcnF9PJGwZhol1GKc+uLYZTWhlDGri5H3hIA8rD2EOgX4XrbHuw9ueNB6KPdvmd6XugyJtfFAHVsrHlUpwsexazbksEIwlaZKFvH+HBLlMjzNuZNpcyJ/8QjSI5l19Pv6ZmpEXs7FCOrCtCgfNveZigOCU6XmMkzBbNth2STQxyD6Ok7QwO6Wcw5KUvLoH/F7PfKftMXptmVpU/h1IgMhsDkWW6URZy1oboLPZCfbR8Hi8GDPZTA8bZpFoZ0JPWRHXREjcsqZKUx0y7tHt1WgeVkE0dVKxsjb7EnTZy6egXTA762eizn3OlCQ9O/WtmYVmGrPFVA9r+cC4O5PhmUXCGia2/i32EeIpGppFMHhZhAkHagQGej96Ik7PkxMMSGyLzbgm5LEH9qHjbef16m62dmjzr51ByBdmA5r/vCFOcv1VbjFpJopZ1Wkxcpkn4Y91ocJskimGrTCB3VmB3kiwxy8Xx93wknwxTV0mBvA60ewTe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442daabc-ab74-4933-e5bd-08ddb2fb090c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:42:21.4702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1V8cFsXVyc3vMLhyDa/8rp2h4ExrLHzqF8FelyzSXsv+p5bNyluxywwfkjs9qFlxWvWWlQQFOJA/+PAO9eWnlbXLYsafPBCOIrEsu+DcUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6892

On Jun 19, 2025 / 10:26, Shinichiro Kawasaki wrote:
> On Jun 17, 2025 / 09:21, Zizhi Wo wrote:
> > Test the combination of bps and iops limits under io splitting scenario=
s.
> > Regression test for commit d1ba22ab2bec ("blk-throttle: Prevents the bp=
s
> > restricted io from entering the bps queue again").
> >=20
> > Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
>=20
> Thanks for the patch. It looks good to me. I ran the test case and observ=
ed
> that it confirms the kernel fix d1ba22ab2bec. I will wait a few more days
> before I apply this, just in case anyone has some more comments.

FYI, I have applied the patch. Thanks!=
