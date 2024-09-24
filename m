Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66601A7AD2
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180067; cv=fail; b=GFFiN1FymJ8UieVSwwf2T1ky+3zitbMrZeZqg0CJ0UpgvXaHcCGOwjyTW1dVrZpfB3jMpAR8ZVfBV2DjEMwogJ6KzrlCTV06rMJKAWfrV9xMKMgSLrziDGKQzN6TpW+FvXy6nomiK9xi/1lQG7Mqi4avKKyz4h/3yE7BkPh60Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180067; c=relaxed/simple;
	bh=WY6mSs8trdNdbMoGiQo8Prt8iH1xz2T1tGbsir0GtwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDL0GQGWpFMtPggVMniJZxUSyM5zFxpMTNBpDd2edL9Bqe+JZ+Rc7s/PkNzTPeh5eL7p7ZP5F6n84hIGGShHBH43HADp+u9ETPCSoR4gtArBEcuMQMETxF8EGjAoEfo0l6cha0j/sQC7m3JHaKdldO4AMJzpJlOeuhnk+KKnoUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gwkMfuvT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lri6DS4e; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gwkMfuvT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lri6DS4e"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727180064; x=1758716064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WY6mSs8trdNdbMoGiQo8Prt8iH1xz2T1tGbsir0GtwE=;
  b=gwkMfuvTP3RL+Dv1f3BsIceoAb4hQqBaJDPYMedAqhCyiU70AfzXEfWn
   u69+QjgxrzpXTFcJDTmf5bmPF4mnqakeC65O4scvCTABzwEDnujFHv6qX
   RbxBLT1xAjQ6WtHrJfZ0ZeVO8ACjFEWq9Bje+xzOoaPLP7U0+bM15TmBJ
   Ds95LWd4SRnp3TZ+qAh+BH4gNeAZBui6xikRzuCP+nLyqT9mYJtm6laL2
   XyBKDFgc60x0q3JdOnpTq+gg7znMeICVUWgHQXKBj2Vd6Mr2mb6tkgyqH
   Vw9/+PHshvH2wek4i5CB9rlLe2hL6wdtx2fBWpoB5QibEnXmXCLLAFt2y
   w==;
X-CSE-ConnectionGUID: PpaCwuj1RMyMTsBINiHBUA==
X-CSE-MsgGUID: YcFAva/QTm+kL8NBexN95g==
X-IronPort-AV: E=Sophos;i="6.10,254,1719849600"; 
   d="scan'208";a="28456528"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2024 20:14:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghmK8yK9Qi8/TI4WHuJKtPrUzeVa1clG6UVbyJvbi0+gMkcS1N/0aeSGnXirJRLRqF5gUHF7GZpDNd5cQeedGDLbxT48UVnvg3m3Yq2tlzf7slDIwnnBzrRP+bAtJvWdBVTELXQn6adan1xphNP0LKUmv7sbnCe4NYOAtqmKCY/pAuYrPES0WhcHZj4hDO8xYihTl1bN3YO/if5LDqrkodB/KIlQcmk8L/e44fm0BB7beS85RApQREH8Co5T5ndjul1NRFX1sjWI2vk4e5bTlw4cJrBrFUp9J7oE9IB8c+Ja/cU1ScbGCLP0C4/9Cc1kinVsgAFAWDZyCXm9S3LLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxD+mE5CPoDRJ6ibKc6fxVQLoumG7WzoXxV7D4ABR8A=;
 b=szjvXf/l6hrxb0wLf9N6uUQ5XINyS2OJmEK6p08Q2vhbUP4mwk4ISWOdBcVfKH6rNyfHh5udU0VRlohSr3CVuaI667NdswXIo2PePdG8IvcBD4XQdoziJkH6RfAfEBmKyy07e7F3Ye5OodXIYZYOHu6XRPmbmxNzKx3MeNR/ofgIK6Qow65NZLR5owxGi0eeM69XOQIHDXqFpzxKQxs/0KV84f67RCTGapTcS1ZH7XeocCZ671yRRX++4vkKYp4GtrOYCkM52LQYuXFjlc06Fvk4ZlwxjJWDgL2J+P/rD17A8QffyO/FL19u73yKMRIW4P9oOWKEOlANNc6z3+EqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxD+mE5CPoDRJ6ibKc6fxVQLoumG7WzoXxV7D4ABR8A=;
 b=lri6DS4eZAv/ND/0mKiIp5tk5ExqVufyhKxXcFzgMW9b4waew2HuTw/UFasd88ANW2Uf33PQcsT11zOK6h+oB75sKmcuLVHdVoJFonbhqy6NwiRQBfdNTsEcG+deilXEstraHOPmfI13H1IDRsBFbJtnFMgqgtSIFSGfVQEo1kM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7241.namprd04.prod.outlook.com (2603:10b6:806:d9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Tue, 24 Sep 2024 12:14:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 12:14:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.wilck@suse.com" <martin.wilck@suse.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
Thread-Topic: [PATCH blktests] nvme/{033-037}: timeout while waiting for nvme
 passthru namespace device
Thread-Index: AQHbDl6pty49muxPrEafGJ1oJ2MnZ7Jm2cuA
Date: Tue, 24 Sep 2024 12:14:14 +0000
Message-ID: <e4xvyahvmmwcv7uenm4mptqp452kl2qq6ve57j7y7z4ylqli36@26ceqvdvry4k>
References: <20240924084907.143999-1-nilay@linux.ibm.com>
In-Reply-To: <20240924084907.143999-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7241:EE_
x-ms-office365-filtering-correlation-id: 43bc62ab-3171-48ea-5420-08dcdc926797
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nIeHxA9qbklw66m8ECn/Gxtx5Nl7GJI/sdAQ6zdsEE5BsSAGbXYVhXU+pMyE?=
 =?us-ascii?Q?pItHGJ95I7YA7ugXysx5Wcx7YoMMc/+9iXflbKlw+y/n9fOszNl0/PwIoWl8?=
 =?us-ascii?Q?dHxiWKLmTNBnzY4BfwZOSnwd2gFxvO05O+cXLpnyX9i0B1kV3ai/u72PmKDD?=
 =?us-ascii?Q?E42by1hRQTR7g1/mnHUi2gjF87FH0/QAIyc9ar4pDzcBlIWsQSkjRqZvLjm6?=
 =?us-ascii?Q?97RGcLUN7jXexm2Tm1vKuYyC8dpsE7Z0g7HkqGWCDYDMZo9JvyKBtCRkPqbc?=
 =?us-ascii?Q?MUvhrQQ7tXi8p9g6KlwHjLKhW7BL+7tH7jCjTZgETl4xlEQ9zwL/CdfiFsyV?=
 =?us-ascii?Q?eYh+xZcqXmHQzkJqhrLI4xu1w+S98MI35KCPbgzYGFuFVL82wUkumUVkuvcu?=
 =?us-ascii?Q?W7K9dFWmKbOoPCfoX9rz40ztNR0Ri++tbxVOMyIueOc7mMGsYSyMweCsuFjk?=
 =?us-ascii?Q?nVRfYDruxaQF3KFzy8IrXkZFS47slSIhms8c248k6ep/pHSGQcqRYsjGYy2L?=
 =?us-ascii?Q?xqRuAqAZ33/6V9y7pKtq7GEGSjQ1iBDXSxhZka+spJ9mNtj711zUwom3Uxkt?=
 =?us-ascii?Q?Dh1oGhTQVchgVyMncrcjxi/levbws6aBVhvZpHWN5BiNFp2ByCfRzJDN8RfA?=
 =?us-ascii?Q?tarmCuMNxPfPRYp5cT80u7x/woSaQ0ZA4Q9EbgI0GpaeTuhH14bAK4Wr6RFo?=
 =?us-ascii?Q?zjLobHLF3bP+Hdv1xMoXOqDw3ncFbzmP207YvMXOGxBAzD2P8CVmjzGYfBHy?=
 =?us-ascii?Q?RugFfvI7UutnZ+UdPWF2zg0pVhS3YRGUXWoE1DO0mF2AYaj8UpmROPZ9D1zw?=
 =?us-ascii?Q?fn3Itw0NE5+zGQH+qs0YOBLsXZtA9b8E/E+2OuuOs8La6GwJBb+L0+xaxE6d?=
 =?us-ascii?Q?wVwSCE+kEk9P9pdsQvNU4C5sN+Hrzy0RVWuETWPcN7SVddpaMaqH7y0w3g+B?=
 =?us-ascii?Q?uTBCYMiraJKIFqUCZQHU3vWHJuUTMCWJZouEAmzWKMRvlIX2Kw+dOj3gtHRC?=
 =?us-ascii?Q?0X6aV0qeSp1AEt2Hbk9AdWiF9BDrWL6MU1t92kAQ4dl5hhjAaMx8QpqwJEUm?=
 =?us-ascii?Q?Jz8Tfb2+qihQPzJFnipsl9AXpW1yzbVNgkIz6/b9Vn/idtO8BKTR7srtleSa?=
 =?us-ascii?Q?7bs5n6tuuoWnY+XYYMqfQ0MhvhvISTsHU20jyG8RK1A9iFwgJUb/etT4Xe6z?=
 =?us-ascii?Q?FSmqvSpHDXpbqJKA69KtKbYKKZE4WzYkh7IYy+z3LszuTtdyPPhEQ7fRmljl?=
 =?us-ascii?Q?rBcxDXKFH4m2zwm39fuOSAnz0BRe9+QurrB70+0Fp07mzJPlaGczpU6ckuaW?=
 =?us-ascii?Q?SuGjwDHca+PIcPyd2YF/1GuOshqjw2+TawvMBLHpr3syySKIDd+ByZWkjUvC?=
 =?us-ascii?Q?4wf7tlM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4OF+OKQUMjnq40wJL7UvqA+FL8/VwHQoypq1iavQuH8gY9asML9p6cemOi0K?=
 =?us-ascii?Q?CUuiLz+jjPal4HYFZyTZ46vbevKJ2vK7/WZEd13UNzx8CpyC+F0S4Pjfq3Hu?=
 =?us-ascii?Q?vFs08Q264ibsXyBc/fql80E9mv0s+swtY2D7Xx4yJeR+eIKM9JXRUtDI0fvt?=
 =?us-ascii?Q?+lG0mQyefeW/C85FgfeQB3SDNV3Ka8B1UhRby+m0yEB4vczUNexssLDtGtN8?=
 =?us-ascii?Q?mbHRRFQAgG//vwxmyYDYPA6bkDMqAt9lne+EUlHcYpGUmsGKKksaPnEDF6vw?=
 =?us-ascii?Q?SMPbGMIr3czlz2sdZYfLLZHwmLV/PNF9/vvrBtvwBXb844ei1JQZ96L3APIL?=
 =?us-ascii?Q?Rd8xyPR5D+UZoBJyBtESkgoRYDHqeeXXinGoSNe9O0LA6jnFgu0VsxyW+yuT?=
 =?us-ascii?Q?Av2qNhq+V8BCGdfHdIMchCq2mMbTHaCN7gzQlFCUckL7zyzHzqMpc8ax4XC6?=
 =?us-ascii?Q?K+E7I7G+ZQWc6hAzKmrROsRooK/1BNh83j5tHE6tLBS8nyPxy4tH7WmaxzDl?=
 =?us-ascii?Q?5jyGsM2IACadMOjXwI2yFqNIm5LVbf7voG8Xh3r8Nub+pZe8eq4lWLk/fUn+?=
 =?us-ascii?Q?fx4/h9L0fTgDkH4TFqtIERkGaLTjwmjrAztgcfwqD71KLjTC8DYgBs5wbmx1?=
 =?us-ascii?Q?ZGPUq3LFfEbf6TXV6DMU+5mbZGMHmOKT+M8sO716PcQ5BA1QcDAW0uyjfd4W?=
 =?us-ascii?Q?i4ULjqYsE8wFq40DzwMtdx2+n2brTTqDVna1090VBj55tMBwLbR+nw06AhpX?=
 =?us-ascii?Q?gWir0Xg7M0Wrd+VWAtKLNkXCRfmawgjLVo00LS7AoZZy5UrYUoL+RNyl/sK5?=
 =?us-ascii?Q?cKBePBZ0sY50K29vkNuRlDe9/pF7HotYRGFUhLYhmJ22IZItmVXZPOO4flDO?=
 =?us-ascii?Q?zdurmqY+jWsuF4ETNnYegFPnpGuNOzs09Yo4h8d4mWvJa1I5zZspoOmJkFEc?=
 =?us-ascii?Q?rAbQNxmNS4IHV0NXng2E7C61RfflBX6BQGgQ5j2Oq0bSCqGz4QL2nFMDQav/?=
 =?us-ascii?Q?xTAKfpZR8aPysTVuCEDji26/s1mHqAXnTh4cf9ndcgD0VSvVkaAmQidKEoM7?=
 =?us-ascii?Q?5d6lZe1Y0Oc8KbuWm6Hin/6+C50FQ9gs3785T/m0a2NsDnVTlMirnYfmtnh+?=
 =?us-ascii?Q?71EXDMAANPQSM3Hw15TnmqGTwUXeLeHiqTcUAFrQ4LI8bC5cs2fTNsgK721q?=
 =?us-ascii?Q?3p3c7OgI32zlI9FcPLwGd+0fxeIsS3fmDBVPSQtnAV51Rvo++BiHZ1CXzLen?=
 =?us-ascii?Q?BN+15UcLK7vMe7xj2U4B72TYZqef2FxTlNn05zqB5WEMyzvMqD0d5bCiVnjV?=
 =?us-ascii?Q?GMRiJNMircAyjTh6eSfZSaY2fa8oh/LFxPpmABTXH6ig5FtY2x5c+KU/690c?=
 =?us-ascii?Q?6ZJDTO4Paf47QLv5IGdJxQC/i387R1tPtmgNfjc9KRVvEhVsK6AMY0CDlMOf?=
 =?us-ascii?Q?KU+ft64t4yEEtmXnWZJ7abMBQFNlfmlitZkKXqHaA2C2o+z1kIDVS3Py+iNQ?=
 =?us-ascii?Q?gkLz7Vij3EazwUl8EQKVS8jmDV3y/hTNBBMla5BsJ7ldCU7Kcj9wqXed7g+M?=
 =?us-ascii?Q?MrEvUTS4N4jiEHcEtZZHokXnYzg6wj6edS3vtnaMfwJJONmeqVr9dkCtuvnw?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0949955377FDEA43805425B53CD973D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZKE9QEuzP+RvT7yI1bW5Bclhyi3hwNsf59ig/cOtNLQECC4fZoYf3T0MXnyAz4MYELMx7aecTU46AV6QrF73PiX0Jwg30U3tWMVYkUh+6TOA33AgC/RcOSdAbtaApU/tKHa6DSzdcZUD+fXFHqavoAj4VvsNuLcRIQyRL9Eq5jvYR9OeXEWksvQVZcsoklLtcgqlC+oEdQaRaZKS3/p8QhQE1O2u+g5U5Igu82sgUPZxi4lLfujXR+bMcozhMbc6lqZ8HAHdQg5Nz16/bsqVSoboA1SJd4CvUcMNNsHPkaf2DOSKgCpyc1yEZafBaP1czXlq1LbG1FWH+obPse/skgPSaCCdQicP4dI+HmByGdv/qfoujBRTa4yew19i2tn3axU5Wmht2Av0nAVSgX+wvE2v80olWan4cSPGwv7tShWndokaGOQG4ByInTnyzy/6FuK1FcWGwXWJz3iIvyiOaRFhdQdyok5VelKfzH14ExHkjAcZKWky8xYoU9mV3Y9QWFt7N3elbz84/OtCi5GcpNV9U3l66Gpruc16/CJ3zFcVls/H3xszg/mqbhUaf1QMZweXPC37YTK9xXQFOXG/+uQx+C8VO6js29eQQRyMuRM2YlT+qPPmNZqvjZKtKDkg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc62ab-3171-48ea-5420-08dcdc926797
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 12:14:14.0551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAZh96qPdUdyQ1FIaKnqPF5LBcjCqNE0sLiItKq6vVLBSWr4/Wufsbl5AfBpMorGiNfNK0ZOftMnyiJSdfsW5088P5D1/C/bMp/RWNq3JQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7241

On Sep 24, 2024 / 14:18, Nilay Shroff wrote:
> Avoid waiting indefinitely for nvme passthru namespace block device
> to appear. Wait for up to 5 seconds and during this time if namespace
> block device doesn't appear then bail out and FAIL the test.
>=20
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Hi,
>=20
> You may find more details about this issue here[1].=20
>=20
> I found that blktest nvme/033-037 hangs indefinitely when=20
> kernel rejects the passthru target namespace due to the=20
> duplicate IDs. This patch helps address this issue by =20
> ensuring that we bail out and fail the test if for any=20
> reason passthru target namspace is not created on the=20
> host. The relevant kernel patchv2 to fix the issue with=20
> duplicate IDs while using passthru loop target can be
> found here[2].
>=20
> [1]: https://lore.kernel.org/all/8b17203f-ea4b-403b-a204-4fbc00c261ca@lin=
ux.ibm.com/
> [2]: https://lore.kernel.org/all/20240921070547.531991-1-nilay@linux.ibm.=
com/
>=20
> Thanks!

Thanks for the patch :) It's bad that you stumbled into the infinite while =
loop
in _nvmet_passthru_target_connect(). I agree that it should be fixed.

Please find my comments in line.

> ---
>  tests/nvme/033 |  7 +++++--
>  tests/nvme/034 |  7 +++++--
>  tests/nvme/035 |  6 +++---
>  tests/nvme/036 | 14 ++++++++------
>  tests/nvme/037 |  6 +++++-
>  tests/nvme/rc  | 12 +++++++++++-
>  6 files changed, 37 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/nvme/033 b/tests/nvme/033
> index 5e05175..171974e 100755
> --- a/tests/nvme/033
> +++ b/tests/nvme/033
> @@ -62,8 +62,11 @@ test_device() {
>  	_nvmet_passthru_target_setup
> =20
>  	nsdev=3D$(_nvmet_passthru_target_connect)
> -
> -	compare_dev_info "${nsdev}"
> +	if [[ -z "$nsdev" ]]; then
> +		echo "FAIL"

I think some more specific failure message will be useful. How about
"Failed to connect" or so? Same comment for the other test cases 034-037.

> +	else
> +		compare_dev_info "${nsdev}"
> +	fi
> =20
>  	_nvme_disconnect_subsys
>  	_nvmet_passthru_target_cleanup
> diff --git a/tests/nvme/034 b/tests/nvme/034
> index 154fc91..7625204 100755
> --- a/tests/nvme/034
> +++ b/tests/nvme/034
> @@ -32,8 +32,11 @@ test_device() {
> =20
>  	_nvmet_passthru_target_setup
>  	nsdev=3D$(_nvmet_passthru_target_connect)
> -
> -	_run_fio_verify_io --size=3D"${NVME_IMG_SIZE}" --filename=3D"${nsdev}"
> +	if [[ -z "$nsdev" ]]; then
> +		echo "FAIL"
> +	else
> +		_run_fio_verify_io --size=3D"${NVME_IMG_SIZE}" --filename=3D"${nsdev}"
> +	fi
> =20
>  	_nvme_disconnect_subsys
>  	_nvmet_passthru_target_cleanup
> diff --git a/tests/nvme/035 b/tests/nvme/035
> index ff217d6..6ad9c56 100755
> --- a/tests/nvme/035
> +++ b/tests/nvme/035
> @@ -30,13 +30,13 @@ test_device() {
> =20
>  	_setup_nvmet
> =20
> -	local ctrldev

Good catch :)

>  	local nsdev
> =20
>  	_nvmet_passthru_target_setup
>  	nsdev=3D$(_nvmet_passthru_target_connect)
> -
> -	if ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
> +	if [[ -z "$nsdev" ]]; then
> +		echo "FAIL"
> +	elif ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
>  		echo "FAIL: fio verify failed"
>  	fi
> =20
> diff --git a/tests/nvme/036 b/tests/nvme/036
> index 442ffe7..a67ca12 100755
> --- a/tests/nvme/036
> +++ b/tests/nvme/036
> @@ -30,13 +30,15 @@ test_device() {

This could be a good chance to add "local nsdev".

> =20
>  	_nvmet_passthru_target_setup
>  	nsdev=3D$(_nvmet_passthru_target_connect)
> -
> -	ctrldev=3D$(_find_nvme_dev "${def_subsysnqn}")
> -
> -	if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
> -		echo "ERROR: reset failed"
> +	if [[ -z "$nsdev" ]]; then
> +		echo "FAIL"
> +	else
> +		ctrldev=3D$(_find_nvme_dev "${def_subsysnqn}")
> +
> +		if ! nvme reset "/dev/${ctrldev}" >> "$FULL" 2>&1; then
> +			echo "ERROR: reset failed"
> +		fi
>  	fi
> -

Nit: unnecessary change here.

>  	_nvme_disconnect_subsys
>  	_nvmet_passthru_target_cleanup
> =20
> diff --git a/tests/nvme/037 b/tests/nvme/037
> index f7ddc2d..f0c8a77 100755
> --- a/tests/nvme/037
> +++ b/tests/nvme/037
> @@ -27,7 +27,6 @@ test_device() {
> =20
>  	local subsys=3D"blktests-subsystem-"
>  	local iterations=3D10
> -	local ctrldev

Good catch. And we can add "local nsdev" here.

> =20
>  	for ((i =3D 0; i < iterations; i++)); do
>  		_nvmet_passthru_target_setup --subsysnqn "${subsys}${i}"
> @@ -37,6 +36,11 @@ test_device() {
>  		_nvme_disconnect_subsys \
>  			--subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
>  		_nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
> +
> +		if [[ -z "$nsdev" ]]; then
> +			echo "FAIL"
> +			break
> +		fi
>  	done
> =20
>  	echo "Test complete"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index a877de3..3def0d0 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -394,6 +394,7 @@ _nvmet_passthru_target_setup() {
> =20
>  _nvmet_passthru_target_connect() {
>  	local subsysnqn=3D"$def_subsysnqn"
> +	local timeout=3D"5"
> =20
>  	while [[ $# -gt 0 ]]; do
>  		case $1 in
> @@ -414,9 +415,18 @@ _nvmet_passthru_target_connect() {
>  	# The following tests can race with the creation
>  	# of the device so ensure the block device exists
>  	# before continuing
> -	while [ ! -b "${nsdev}" ]; do sleep 1; done
> +	start_time=3D$(date +%s)
> +	while [ ! -b "${nsdev}" ]; do
> +		sleep .1

Is there any reason to have 0.1 second wait duration? When I changed this t=
o
"sleep 1", runtime of the test cases did not change on my test system.

> +		end_time=3D$(date +%s)
> +		if ((end_time - start_time > timeout)); then
> +			echo ""

This echo doesn't look required.

> +			return 1
> +		fi

If 1 second wait is okay instead of 0.1 second wait, the if block above can=
 be
a bit simpler, like,

              if ((++count >=3D timeout)); then
                      return 1
              fi

where, "local count=3D0" should be declared before.

> +	done
> =20
>  	echo "${nsdev}"
> +	return 0

This "return 0" looks redundant. The previous echo succeeds always, then 0 =
is
returned anyway. Also, all of the callers check the failure of this functio=
n by
referring to the nsdev string echoed. They do not refer to the return code.=
 So,
it is not so useful to explicitly show that 0 is returned on success.

>  }
> =20
>  _nvmet_passthru_target_cleanup() {
> --=20
> 2.45.2
> =
