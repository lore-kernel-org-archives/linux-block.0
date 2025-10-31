Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37126B75C
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896253; cv=fail; b=gOlxKcIPIS/ffoZGXg/tTb+aCmqDytlY0rb1uULLAz2UitE71h58199wBV0Hy02yL0Pfm3LFiaJnI0NCY+sRZoN0JOsxj2oNCOzdT6rpFArzq0Xh/8d2Tzkgz1Da9V9JKAt0HiD7/b4ICgh8e4s+CC6LuKT0qwddfAuUCqtHmto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896253; c=relaxed/simple;
	bh=U/ZLzp116Ppq60b7MF20bmLXhjPw/zOmt6lA/t/XZDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikx5dyDo1PMColApi56cAx4INUP/ElZakpmL/muPmrrWJBpUoqwmeWsBksqoq1gCEHEHby/qWVi0FmmSe0Ja4dxGStDVNTp7sRQxNUrbhEkTY8hfPi8zP4QDLnRtvUks1p+TraqVpoIGrTQTNeV87Mo3CNMf4uQoVRduAHPRY50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eUeMvinU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H+yZJIvU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eUeMvinU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H+yZJIvU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761896251; x=1793432251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U/ZLzp116Ppq60b7MF20bmLXhjPw/zOmt6lA/t/XZDY=;
  b=eUeMvinU20eybI1R0c9kkfQNVCWn8azas4ABaZ4Y7GjR9bzIr40CUqxP
   oqZDOJbKy/53HPQIWAyPlBB4wENI9/IbJvF1PcO5smrv1qSkb8M0jutCB
   EfJAAb8+Td1wBE0XL95raq1z+PpFR+MGnvhZLHXbHrq5gL5Lv6oN2oKCh
   b+VDvxtlibEBmrouSLO53AlXCGGlU5JXxVGA2q7F5SV19uSnEiht7KcjM
   8PsvaQoZo3u6D556W3fZJ+RZzJcVR+V1yJkJM+l/2Kr3awcwF68BCY2f9
   9Br4I5+Z+j31h0NWRh+CGK8J2ZZ9D068CDEZhcKaA+mMlb2lAWVfsNd10
   w==;
X-CSE-ConnectionGUID: Zt8rdX1ySge41QOgl9HU4Q==
X-CSE-MsgGUID: zkmzZaHVTmeDt9LOnNz9tA==
X-IronPort-AV: E=Sophos;i="6.19,268,1754928000"; 
   d="scan'208";a="134257841"
Received: from mail-eastus2azon11010045.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.45])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2025 15:37:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFn2O4aEUA7AhjlhYLicZWuZ0cp21bG0cowOplqNkXwCSBqq4djcdOiZjgUVhoRzNiSZeKc/gPZUMbRs9n7irZXuKd3V5iAkxXOZ7XJIHMEo8juIo8WWYk54rZlt5wgNcOCFI8EWgNIV1oMscPDzJ+ryYD5XDxaIYVsvoqAhMdVHCjkq7bI7ce2OPh/zy7XxozyG3Qv3tE2y8eFaxlf7H2xZpvy+OZx5eYT58HhRIuChLaohtOc7hQ87EVPlJQiST3TynOC8O3tU/M3irlT/1jkxNGpUIG1azHZPHtUu7W1CJ49NV0lML75RRUIj/gbAepNwzGiSDQjnCtfzoF5dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1cR6h2fiZJ4bWOvHPLfryvuULXiZ15ZpwQhbdUd2jc=;
 b=GjkGmc9A+Nj++q5VFo1wR/RN2Pd1csAksXvK6vBctyrpYkNROSIXUDtSXS3ELS78Nqx3kaWiwU1LoqDnnDxZpQ1DILHfQZ8s6T8V+FZ9PfEYO4CSyab6/jokto/7GgWxso+DumRdp4OekH7YspzS1QBYBw6kTi639OUE1eZnQxr5O+gPR/iq2uWtMjE+9aWfkygHUA3JrlM/dHT+u8RFNUI/IOreN/7risyyH6AjzMlSp5NMvf6CFFE5+NIIklyj07qXE3mWp8GwphoB+/lz5GUaJS91/lBI9+f2AvOCczbULNkCxua/DdqO+0z+JwXyCdiBqtJ1IU+ntGbckKUH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1cR6h2fiZJ4bWOvHPLfryvuULXiZ15ZpwQhbdUd2jc=;
 b=H+yZJIvU9HjdaAbXmPtL0WePCyEQZIuqrPAkcESP44tOlQW0XqrxMemnugMezmpQ80Z9p1+zgabh4gOe1fXvaK3mfUV5/U488+udzPBl1Q3CpbOEJVxwnYm9cPc/c+EfqxitbPLN5hyvJKh/Ubxv/SUiUFrm0YQMgMNcV7c4IkY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH0PR04MB8097.namprd04.prod.outlook.com (2603:10b6:610:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:37:21 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 07:37:21 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Topic: [PATCH V2 1/2] blktrace: add blktrace zone management regression
 test
Thread-Index: AQHcSD/9RwSTpOblOkyOH/PIFIftCbTb4eAA
Date: Fri, 31 Oct 2025 07:37:21 +0000
Message-ID: <rzusdqnb6my64syib5stekerczfjluqc7ddcyiqh6ea6s6lwrk@onumpctdad6q>
References: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
In-Reply-To: <20251028192048.18923-1-ckulkarnilinux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH0PR04MB8097:EE_
x-ms-office365-filtering-correlation-id: 4f3608f7-4936-47a1-5467-08de185053b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bIrMG3UlM1IMWo0TDQzpT+si1Zrac3Tb/MZeiCYz0BbP6PQc/2Sl29uDMfTa?=
 =?us-ascii?Q?+GFE8jo05PGgUZNg16PX7zs25UmBUxlqv1dzpUhfM/XiLq+Kcs0J3MhVdDZ/?=
 =?us-ascii?Q?/cDxLxN9X/8XiZ5xFRvBVvxrx+JAq93QInhi7xBToqpuLnyD/ljfIfEsZ7GR?=
 =?us-ascii?Q?1V0I1MmDWa95DVqqheHA/HU87Mv1ZcDt0mCoyjJbb48ejXCar7HD1cyCqXI3?=
 =?us-ascii?Q?bwJQWvTtMxArYAwGJZoxyjUVR/Zp3+OUgqZVd5iSGIUUHUGI1vFBfMxeFwBo?=
 =?us-ascii?Q?1+eYl7bXCeGGnI/XR1gFfiUVcXs/73QS10USRqc0dgE42zYA28oDaloFCUcf?=
 =?us-ascii?Q?nAqM5hZZxgdGTwb2qtPR+/EomFQTa9xq9QFo9CBLqaWcJ5LxckLBSvIy5tBP?=
 =?us-ascii?Q?66p/IQzFrXHImod8pITkg5gNWLhTGgZdmEielNA+8L42CYu9R54E5RtIp+84?=
 =?us-ascii?Q?FeTEEeCW0j1/qEGCkkpF1h89wLXo3ILBQbqZZwT8aF5w/Fb/v+WQXEKc7EJg?=
 =?us-ascii?Q?bMe1KwpXltWIan7L8H36MiJRASuTG5wc/L41ORoE+N4eZUCOcgCuHbLH8TKj?=
 =?us-ascii?Q?gHdxa6CgtMNYQcLqbWzBwmKsv69WdhJj9ZkRyoYs4ezrFDhGjc/3usltTupC?=
 =?us-ascii?Q?bfR74DmJA5ANHDok8XQp2HOC4MuPv4T9pHU4qSzPIqyRQQNXCnV0vheWLwcQ?=
 =?us-ascii?Q?JmQq95BT1L/V2l+1ORNiPpZjul0AxCzEppomQcdJvfC8diZNsVzSCqPrYGha?=
 =?us-ascii?Q?yucULAExflMsbq8StZ6rix/vioKWL4kdBQyZqetxYQe8nB8gE/9xdUfktU43?=
 =?us-ascii?Q?KCsRZLhB/q5rBsNCb2F7RxorOZeO8IF+G9HWomlv2fomMGW8z/Ke7xWru5pP?=
 =?us-ascii?Q?BrmJymvaDEZ8L4SFiTmnb2B1UkxnaV0MERhaD86oyIbINGHb3GEw3JS7Ep1v?=
 =?us-ascii?Q?PcuXd1wZWNsKIF51GPwHYjXe2Hhr2RVKvdgDm5L4su4b2Zh3h2Ct0w0ys+oU?=
 =?us-ascii?Q?QscGwa4MtnVKTVOlveH2Y0p5brnA33w/lsaVJ5DUA6ha8GrHjXDMa9zDBrQQ?=
 =?us-ascii?Q?Ob7FfavIDUczBRsKE+GruE1vdp2q3TgiYdCr1xB3AQG6t07nNtj0VlCnh9sj?=
 =?us-ascii?Q?yPvN5puJOMRznRkSYHaTiGYHRIBwUfCRb0WUwgRVF33WaEZBKOQt0PwJa/a/?=
 =?us-ascii?Q?uUkMr7hxuPeWwGK45YPSgqWu9YArN6dAePWnBXD7RZr9iTPigQH28knaMaOk?=
 =?us-ascii?Q?FQUwDhYZJQdsTMLfem7XvNc/T+7z2PHLtFY3M7L8ocKYROvc155G1rf76YkS?=
 =?us-ascii?Q?GN+2QRoUABgcLnaKK76aOvyjgejXDZ7l+4I+2XgkEVHz/D6w5UBZ9CBKfEUE?=
 =?us-ascii?Q?UtYQXLl7oHPxJnQ49HDP8f4pM+/aN0oa+8qH4gwJM03ge/n4laPEsukbWwfT?=
 =?us-ascii?Q?yOqgum/MTqg6TOBRE2gZgYR6okul+LppXX3+59my3TVPX+z5jXTJUA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ls8e3DwAKyf79osI7z6NV1Ns8Hy4svymXVIL4XASc0BllS9kZff5VZarnf+J?=
 =?us-ascii?Q?JJEt+hZ8LDLW0RQpTsdMYdwT5VJxHXFf8IuvHMz/MtH9Vm6S5Ehz2W1/lcra?=
 =?us-ascii?Q?1Tati5b1GTENB+XxT9CG8jjRMG2OI+CRdiHiRNPuLTkKNgqcNWOocQx0kNjg?=
 =?us-ascii?Q?slKi8+t/bsciW+RBEwLmDcHBdvH2Z9RsbS/L6JR3QCNcVCB6nzS4UJDYrcCQ?=
 =?us-ascii?Q?WahiQBc6V9YXxO6ncclfpdVUNldAPVy/MTIaStye3By3Q/c7/m0klOND2eal?=
 =?us-ascii?Q?XbkB7jSp5pMh7gY2dqNqP+xCxUOMXwBSc7w7EO+LzrwXXlthKRhgTUfhy2/m?=
 =?us-ascii?Q?FMoJL5VExKhzfU3VGw1nNcJoyOvVbeQdeIWx5i12gd8fe0jAnAfNvmsWp3OM?=
 =?us-ascii?Q?CYVvvGgmFr3+9YoBQhgkSW4f3eb2hR+E3jEtQN5V5yfmibnf3uQcHKGUqvU/?=
 =?us-ascii?Q?R25D07Hk3BbeFic+JWOuiaFOG1puo/TeLJVLu7AakaLEDayMsSuFfH4jr/GV?=
 =?us-ascii?Q?xNiRqlM9G6utyIFSPWOj3rXatP8C8T0sjulc0cr26DZfpGa+gcebShsV5qmG?=
 =?us-ascii?Q?ef2kcv2ImeXcisycgwpdEFioNTrugPaBcOOF9hRD33QzvMxvlbwcSqwSH0IJ?=
 =?us-ascii?Q?qrFjVs2mfuqBhvTAroneIF8tgjYHH4CX/n/pJwV+MLs9CwoTgb35aiLPeb8t?=
 =?us-ascii?Q?CcpTxVvjvIqW4InqRB2ZXAMp8D+IGeJOGp5oe2aGGS9COFA/+9n2c8U7Vm1E?=
 =?us-ascii?Q?Ef4CApLEPoAs4PdgWFBP5+wAYb9DHzlcc5kF69MgRm7AgDIQdbo/ut1kpcLs?=
 =?us-ascii?Q?dPGkFhSiFBFz6o2c8AfkZ/BRkrikhOUSEe2sQEcOhvXOt/JVzQKbbZYksDKp?=
 =?us-ascii?Q?fZcDgiPLFhzhrclx4nQgDuocdJrU82oRCWpRZQBakT5Qc0PPnVSYvAgrt+qK?=
 =?us-ascii?Q?Qf1A15LL9KcbJyQWKxgzolKPYlI0ZvMSx4qGf3nhS/r2mlJYXZ4nydRCBBuM?=
 =?us-ascii?Q?PvWi04upPMOrFX/DdJl5tCTzAA4ZKW7qgy8mxK/7m3+gMH+heHoPjkgpFnnq?=
 =?us-ascii?Q?Uv5+uR1G3wa+2iEbc58WHW2KaLzFPfBcjb7M+Q+zhvt6CM7rdyqZeTIDeLYH?=
 =?us-ascii?Q?B9L84bg6G3I5vK8aDF3EOidGN89oQaOqICJiO/ksaIF9tLG0P5EXwFjspy5i?=
 =?us-ascii?Q?EiSoopeyGNYjg5GsoU0p1l/3rj7rZGgbbUobZj8ab1jt5KOXUT7s+HmRA3V0?=
 =?us-ascii?Q?gQeJhbsdfotbDfsftPdBTuAvTWF5j5JykyZXmyN2f5oidA0bGy5NAPParcLV?=
 =?us-ascii?Q?8ihkq/BzFEWcP+7MkEFo8Z/6HP9I1m/b1XwLEkett17lzamyldu1Vp1N5aCS?=
 =?us-ascii?Q?s+WgkNEsyBs7oEdZDfNANvEIZVbuD5j0WQgYKPe25xfYWd7z7AfeaAZdjiNX?=
 =?us-ascii?Q?7E0fOMlEwFlYZqzVtRioTMrAMjJFZx720RdizfWnn0Xjh+5lh05agKwUaUfW?=
 =?us-ascii?Q?Nd2HKedh9By2RjflOefriZqm4JoYPvezbQ3pbBTbFVizEZtSyLHfPEHM3nT9?=
 =?us-ascii?Q?Hfz3h9kvyV9AmoC5cdiJSd+2BmtBcjsNnBknXI+3sy85NvWVMDwaYXL63FWt?=
 =?us-ascii?Q?ewvmN5lgJ2zQsPBlRiKEtLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7798DADAB4DD24AA9356CCFF479E112@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MaEXpOG1A48hdjnyWV0JJeArN+XbPJJD2lS4O0K5a6PMENwZjTWax3W63l5onKG9WfO5fuwhOLz1ligTr8leRRw9GA78ElCw8iMuHZLd616nTqATmG5w68Aknvj22Rz1QXfQuuTVEnqPOgrpJmiiWwQwTz/SoFOaFZt0V8zm8uaKsVRvV1T+fAJ4fZeLD7nzWki8H3vb15gEJuyAFEIyXAF/wBO6Z1kC6aXtZTfLPGqBJjpHOVN477uwEkLigybyqddkWSuuREQXbGfBuu6FpKu5jYeE4gEOW4XiY/ehw4sPfxoYkMhz7uYonZpj/Vqsda0TeLJ0RDbRc18zoA3TJ+f0cU04tZfwzRRL8Xxy6sTbvhNnNyLEMnOiIsZ+9oTeR8++UOiiHQTXuMp9cxWVyk4vOV+3iE736xSEZBrhgrjKEohFx3ulSvDan9FYRO0+2YAEpEIbMCdft8jnrjx+hLLau1HOhToxC6XvTPPMpPNdPuYbJ6Xv0vYuflipgObfaS4zGyRJcOBwYCWWvQWUThELZPPDuBJhNUs9bLUzt7auhoJ52bu1EYJiYO0VRFHAaa4ERzGhJKQfKOGjzAFz3CMjIGwH5Z42ZKwNEVwc6maJBFlHC6n5KGsdIU3WLHHx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3608f7-4936-47a1-5467-08de185053b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:37:21.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hboQ4fqzVWLyeO4jG3ix4UFIyqWHjhqRTgVFxbtC2thN00NNs6AZtk43h+s/QXqZOljQr2E2ux7JcGftBr8l+IBxP4Km+EcWGnKAIytlvxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8097

Hi Chaitanya, thanks for the series. Please find my comments in line.

On Oct 28, 2025 / 12:20, Chaitanya Kulkarni wrote:
> Create a new blktrace test group and add a regression test for a
> blktrace false positive WARNING that occurs when zone management
> commands are traced with blktrace on V1 version.
>=20
> Bug: https://syzkaller.appspot.com/bug?extid=3D153e64c0aa875d7e4c37
> Location: kernel/trace/blktrace.c:367-368
>=20
> The test:
> 1. Creates a zoned null_blk device (8 zones, 1GB, no conventional zones)
> 2. Starts blktrace on the device
> 3. Issues zone open command for all zones
> 4. Checks dmesg for the false positive WARNING
>=20
> Device configuration:
> - Total size: 1GB
> - Zone size: 128MB
> - Number of zones: 8
> - Conventional zones: 0
>=20
> If the WARNING is found, the bug is present and logged to the full
> output. If no WARNING appears, the bug is fixed.
>=20
> Note: The bug uses WARN_ON_ONCE, so it triggers only once per boot.
> Subsequent runs after the first trigger will not show the WARNING.
>=20

To clarify which kernel side change is relevant, I suggest to note that thi=
s
test case confirms the fix by the patch titled,

  "blktrace: use debug print to report dropped events"

and add the Link tag to:

   https://lore.kernel.org/linux-block/20251028024619.2906-1-ckulkarnilinux=
@gmail.com/


> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
> V1->V2:
> Removed dmesg -C to avoid clearing dmesg buffer from other tests
> Use _dmesg_since_test_start() to only check messages from this test (Joha=
nnes)
> ---
>  tests/blktrace/001     | 94 ++++++++++++++++++++++++++++++++++++++++++
>  tests/blktrace/001.out |  2 +
>  tests/blktrace/rc      | 11 +++++
>  3 files changed, 107 insertions(+)
>  create mode 100755 tests/blktrace/001
>  create mode 100644 tests/blktrace/001.out
>  create mode 100644 tests/blktrace/rc
>=20
> diff --git a/tests/blktrace/001 b/tests/blktrace/001
> new file mode 100755
> index 0000000..43331c1
> --- /dev/null
> +++ b/tests/blktrace/001
[...]
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	local blktrace_pid
> +	local warning_count
> +	local device
> +
> +	# Initialize null_blk with no default devices
> +	if ! _init_null_blk nr_devices=3D0; then
> +		return 1
> +	fi

This _init_null_blk() call is no longer required. The helper function is us=
eful
only if the test case requires loadable null_blk. Also, I suggest to used n=
ullb1
instead of nullb0, since nullb1 can be created even when null_blk module is
built-in. Please refer to the diff I attached [1].

> +
> +	# Create zoned null_blk device via configfs
> +	# 8 zones, 1GB total, 128MB per zone, no conventional zones
> +	if ! _configure_null_blk nullb0 \
> +		memory_backed=3D1 \
> +		zone_size=3D128 \
> +		zone_nr_conv=3D0 \
> +		size=3D1024 \
> +		zoned=3D1 \
> +		power=3D1; then
> +		return 1
> +	fi
> +
> +	device=3D/dev/nullb0
> +
> +	# Verify it's a zoned device
> +	local zoned_mode
> +	zoned_mode=3D$(cat /sys/block/nullb0/queue/zoned)
> +	if [[ "$zoned_mode" !=3D "host-managed" ]]; then
> +		echo "Device is not zoned (mode: $zoned_mode)"
> +		_exit_null_blk
> +		return 1
> +	fi
> +
> +	# Start blktrace
> +	blktrace -d "${device}" -o trace >> "$FULL" 2>&1 &

This blktrace command leaves the trace files in the current directory. I su=
ggest
to create fhe files in TMPDIR so that the files get cleaned up. Also, I sug=
gest
to use long option names to avoid confusions, like this:

	blktrace --dev=3D"${device}" --output=3Dtrace --output-dir=3D"$TMPDIR" \
		 >> "$FULL" 2>&1 &

> +	blktrace_pid=3D$!
> +	sleep 2
> +
> +	# Verify blktrace started
> +	if ! ps -p $blktrace_pid > /dev/null 2>&1; then
> +		echo "blktrace failed to start"
> +		_exit_null_blk
> +		return 1
> +	fi
> +
> +	# Issue zone open command for all zones (triggers bug if present)
> +	blkzone open "${device}" >> "$FULL" 2>&1
> +
> +	sleep 1
> +
> +	# Stop blktrace
> +	kill $blktrace_pid 2>/dev/null
> +	wait $blktrace_pid 2>/dev/null || true

Can we drop the "|| true" here,

> +
> +	# Check for WARNING (bug present if WARNING found)
> +	warning_count=3D$(_dmesg_since_test_start | grep -c "WARNING.*blktrace.=
c:367" || true)

and here?

> +
> +	if [[ $warning_count -gt 0 ]]; then
> +		echo "WARNING: blktrace bug detected at blktrace.c:367"
> +		_dmesg_since_test_start | grep -A 10 "WARNING.*blktrace.c:367" >> "$FU=
LL"
> +	fi
> +
> +	_exit_null_blk
> +
> +	echo "Test complete"
> +}
[...]
> diff --git a/tests/blktrace/rc b/tests/blktrace/rc
> new file mode 100644
> index 0000000..9b987a2
> --- /dev/null
> +++ b/tests/blktrace/rc
> @@ -0,0 +1,11 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> +#
> +# Tests for blktrace infrastructure
> +
> +. common/rc
> +
> +group_requires() {
> +	_have_root && _have_blktrace && _have_program blkparse

Nit: it's the better to drop the "&&" operators.

> +}
> --=20
> 2.40.0
>=20


[1]

diff --git a/tests/blktrace/001 b/tests/blktrace/001
index 43331c1..79f51d6 100755
--- a/tests/blktrace/001
+++ b/tests/blktrace/001
@@ -31,14 +31,9 @@ test() {
 	local warning_count
 	local device
=20
-	# Initialize null_blk with no default devices
-	if ! _init_null_blk nr_devices=3D0; then
-		return 1
-	fi
-
 	# Create zoned null_blk device via configfs
 	# 8 zones, 1GB total, 128MB per zone, no conventional zones
-	if ! _configure_null_blk nullb0 \
+	if ! _configure_null_blk nullb1 \
 		memory_backed=3D1 \
 		zone_size=3D128 \
 		zone_nr_conv=3D0 \
@@ -48,11 +43,11 @@ test() {
 		return 1
 	fi
=20
-	device=3D/dev/nullb0
+	device=3D/dev/nullb1
=20
 	# Verify it's a zoned device
 	local zoned_mode
-	zoned_mode=3D$(cat /sys/block/nullb0/queue/zoned)
+	zoned_mode=3D$(cat /sys/block/nullb1/queue/zoned)
 	if [[ "$zoned_mode" !=3D "host-managed" ]]; then
 		echo "Device is not zoned (mode: $zoned_mode)"
 		_exit_null_blk=
