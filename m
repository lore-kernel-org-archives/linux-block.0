Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF83D090E
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439533; cv=fail; b=AoLqUTruYZ/M44YcZrX9+Cp4kujFy0GyKmF07KZdT57/Gv2zp+Eo5QmQTSBD3meLttUPV+2+iUYk7L1t1cAQFsXPp7wHgjrQjiOdOuEI/h5q0PpyLiN/3lkVIqQlD/q/DTm/6hGW66vUnXmeiEtMz+nqgGpSAouAO0x9jKkNRVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439533; c=relaxed/simple;
	bh=G9jq9iO5gsFEC8g85NaPA0g+smfSulEneBrRa7/D0f4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNADC4HtHDFyicezEvHsXP6qOYSk8UuMCqlkR99hd79Wesr/uLO8Qxv9+5+1xdzPjx1uxVuX9VZPYfIrEwfmucKJ8ZVZXoG3L5u3pVGaaFtXBUkQ5JM/3jk19SPIHMtj8u2glP0EKE+ePfi5hbx4wJF1jSMYF9KZi8CGxViLrXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RixV418I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZmMWwOC/; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RixV418I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZmMWwOC/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774439532; x=1805975532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G9jq9iO5gsFEC8g85NaPA0g+smfSulEneBrRa7/D0f4=;
  b=RixV418Ivye8TkWYiV+a0NG4v+qw358f6gfDD+gEJFYUElMdNQIm6Me2
   thmF1DGwC4zb8lgfvtB+JkgFICCaTB8iNKxJ+N51Fk31DwcLxc3zHe33+
   qtd9AZPUro1MyWtd0ljwXqbi8lGAg1TVzoTIBX6O4JWMYcWoIIn632DNm
   6YfHkAOjDQ+PbT9KqlugrFWlHF32bqOxTIhr+TgrFKlMDr5mdNpxx3UOB
   v3HcQ586ZSAYt8uLizJq4h4NrD4d8aMnZFCjyUElpQkqcwdBghnfr6zRW
   +yvH8f2tWoPkmN9qgUeGd0Vy86MyyKDsBJ1RAQW0HTiVUMJIbY3GPkXgv
   A==;
X-CSE-ConnectionGUID: mWHqCGBtRtSUMjgR7dTDIw==
X-CSE-MsgGUID: c2slRnOVSkCWsChurQ1HUA==
X-IronPort-AV: E=Sophos;i="6.23,140,1770566400"; 
   d="scan'208";a="143708314"
Received: from mail-southcentralusazon11012027.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2026 19:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJab84xp1DfPN2/iSpUE7uJjauBOBGXLt8chM1+9dxpRZmHWiCBy6weDkQPRZu6hRrqu/twAv6d9lVLzy2UY35sy5hLiegDGfMdmNRZVNIrPMC42UWZuhOXnobNOuh382zfSQKBmxolL8K930FTbS3whOYe2aUujLIL+275yMsYUDsNSu0ZU3RjkiilRuf4jedVkEzVvX420TxcOPCOeEUcA6Dn2wRp2yMAhwFctMZo8gC+7+gPTk3xILXySi2/HXbKfrgqziHCGu1FZ2dzNK34qTfyp/H2BV/nCAMIvHHPRXA1S2JhzJLTCJ1/UrS0jkc7+w20BoUOqu5m6geKlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koB3tx1fTux0C4mBnvk58GHQQI03Q9Tj61f4RJyV10s=;
 b=s2jyvdQEuLfmXe7q9gXiIKTiLszMqqMUBw+JsJGsRtQRHZDMq/xJVoi9/nu9HV2iEuXCgZUaItm+Z127ZJVa4AzgRaqGAEIYQPcnGI8sAAsLSYhDZfARCJuw/OlQlMr+IhZl56MDFS1+2/XWRkwfPv7WuHbRxIJgOaTIMGDylYkcbPRgUFevHfm3R5jL5xVqsUl/Usp9iTp1U2lel0OV8kV7+chknX0JuiVOA9CrM6clkhNipstSbP6LlE7Z5m5jFZfed4qdr+cTlaPSLMTEgMzlkxJ313nkUKBwmZpKk4TeHbGVUagtV/G/GNXE8M0PICEqDZ4ptGRpdLnEizrIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koB3tx1fTux0C4mBnvk58GHQQI03Q9Tj61f4RJyV10s=;
 b=ZmMWwOC/XNUAdNIvvpN8gMdHDjSAY8lF30aZE+HWYDx5HChg74OpqbRvAwhubEctdzdZ0IKTF4YhE4ujkUVqtVruBWcxCUJ0M2pifXgp7HPskQIdBRtn9Gd9eJFR8M1Q+3vwIBLIPL7O5PV7tHlK1Wogj+N5ZFfb2kSubAtNRzc=
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com (2603:10b6:a03:4f9::11)
 by BY5PR04MB6772.namprd04.prod.outlook.com (2603:10b6:a03:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 25 Mar
 2026 11:52:03 +0000
Received: from SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::7198:f387:b58f:e3e1]) by SJ2PR04MB8536.namprd04.prod.outlook.com
 ([fe80::7198:f387:b58f:e3e1%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:52:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block/044, scsi/012: Add tests for support for segments
 smaller than the page size
Thread-Topic: [PATCH] block/044, scsi/012: Add tests for support for segments
 smaller than the page size
Thread-Index: AQHcuwDB3Fan/XQyokC3oXPdsGqiKLW/JZIA
Date: Wed, 25 Mar 2026 11:52:01 +0000
Message-ID: <acPFQ3laJg0MDRSM@shinmob>
References: <20260323200751.1238583-1-bvanassche@acm.org>
In-Reply-To: <20260323200751.1238583-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8536:EE_|BY5PR04MB6772:EE_
x-ms-office365-filtering-correlation-id: a33dd014-34ba-40ff-e85b-08de8a64edc2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 7p5BMgJBmDRJi/Y+y2MZcrK0Kj0hPc3toquwaBGsHNDQMAWni3/qHOxx5vJNo1NOpx3NXBwMJ5zuLSDlGdW+x3O9/Nqyf/dnsesODI8dYHQLERIAoxUYichIBW/Atpfo2m8+fiUbWH9aq9jwJ8XbWFJhxs6T/soTSqNc7k+niQDMiwFEau+QeIvR+lD3fu16EBZ7CvpN0zqOG+x5e/e3x0xURxRprNZAP8MhN50zsBUoXzztnL+co9JBYEJZeKdO5h95Xtq2HUZPyCHa2sNhm7BYpy0ONij1uBdgxld2D9kRmGNp5zO+Xn1XyVe/vuTwZDqgzvO0G34n/CNqDE5fqm6630AKMkivBlq3Us9gVBZ+ry9v91DHSh1RRzfhM4Pai8XZNshlCAtUJyc5DeYZDz4jIwx/PZmDuKJVrG8IoFDrQb5cJ5xw6/wlzctZQWefxW6mQKuEwfTkUdIWmCR1XcgFlTpt5oWUoGqM6PO1qxB89XiTeXiTzvCxN4Vb1Wdwu79OL14XaJr6+HxMdNWbmYEK4twPQzPk9IA/HGxqUTANhTyzKOsgk6g/hJXUF1i5U22+te42CVLEHjw5tmgU3OsQpV+ZoAAgzJGwk0C4s8ZsX44iBshezOBhAfFZTXUDEF/3foWGQgnof6RFVN97vDnWT1AsD4JUgTr2I863E2J6VDA84FO/604uUYSyjcaEZy8LF7l9N2keV8xOUP4mzjwbXrOg8rZnQ+TBUBILvSs1okKsFRruKJ/1ve6XeCcgx9dGrbi9IZSwiVgq14f2ix/DsAcjl/DiAnWI/gze9aw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8536.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WzUIJXwSUZFrv+8yj8v+moSevbMhKuvRFIlNpk3Jby3z5DNHjx+U25Dp2hME?=
 =?us-ascii?Q?iu4o2kohpRLJ6bEUt4O8FPD2O9gaBEQYvCI1rMbaMCfmPr1QYKKWD+Pudb1E?=
 =?us-ascii?Q?iikgfSQHh4haE8PA/QzzQg5KMiQb3rgZHXRJgmeRu/gug2Qu7IRZ0l3Kd4YT?=
 =?us-ascii?Q?c6qRVkzdNg6i+SGSviZJ8+CQaDzPnkuI3Gopln7G5zBSmPL1fRI8BLfAI6Kj?=
 =?us-ascii?Q?oVshglcRImjfZUNFbjTtGREuY2TYh9d+XZMqCP19HHLCfWQh2DZXuSvgbOhD?=
 =?us-ascii?Q?Xu5AwgTu/chs8+frjLPqU6MDjpXFUmgy19e6Lr6UWQatpennkh+qIeS3cPhb?=
 =?us-ascii?Q?eoAcVW/Iw+wEXIwIjMPPAU77ez+1Y/678PCBpzX9MstjNmMVD3ng3OSspgV8?=
 =?us-ascii?Q?rn76v2EWLHeu6Tk9Mv3mTmNnN4bwJNY8uybb7U9teIVIlyBstzOfRS+HqwyR?=
 =?us-ascii?Q?fWKSo77JXOORm86coFX7ft1Q2HE1XN1IuLDVpJ7wYDae1t/iWF0/HJkAFdYZ?=
 =?us-ascii?Q?5S4/8HmJvBM4WVhAfAYr8ZcAz2Ffx92CqX482K6A92pBJmD2hE8Ghz1WGxlD?=
 =?us-ascii?Q?GP9m54Clekz8/pAHZCqYV/JrZ/MyXGlhtEh/NK5h6pqNWnNmGbV+pE/269AX?=
 =?us-ascii?Q?W0w9hxuliIJ/IZ0U0dz9hJdr0m2R38fQWLrx1lqFZMOmnumKIWfgDbkM4cFj?=
 =?us-ascii?Q?RuvLxE4u8+dNHls3tFiHtTUe2DIOPBIyVxopOjodFyD43AAV99+IL/xtXzS5?=
 =?us-ascii?Q?xW9q03IgRbHdXQsVJy71UB9vFN0IXkCp8iPXGcjFQhXquKnrOuTBmJNAjKVf?=
 =?us-ascii?Q?yPZwVsa/MImc71pWrO3sKWOEEuA9R4a3CCKcOIdVwQSaVpOOZHnHeqidvIt5?=
 =?us-ascii?Q?gAlEqYQFPKss/DycHkJD0bQBU+5SuqNwC5wr896fNBGnBh/Z92z7Xf8kFCDi?=
 =?us-ascii?Q?ceIbyMZUELkqgJxQe4zw800T0AUHjVRkTmUAdt7eEMdQOpRQPO8Abw6JubRn?=
 =?us-ascii?Q?RAbC6dOBeSNoMxWWNmqPYmjdDYQxtsoyMZwPVdk6S1OuumLC3yL3bg60e9vi?=
 =?us-ascii?Q?ht0YiM2piubIkI6+CeuFIqUJGxtmOwlppD0IQbpOyGJDHruBfLfCYneg0D1i?=
 =?us-ascii?Q?FOVUHM0hez3hArDkeP0nl6wj89qFdm/pdTAfWThg765isLjPk2xqnFwtMkvA?=
 =?us-ascii?Q?9EqqqnBXoUccfjU3KstawbFH6l0tY+olRjIg4VtnL3QzmGTwLDQqmwpm/vBo?=
 =?us-ascii?Q?NfExLTBtCw936mJhaaZUWPa02LKWBQC8tCUNcSL0H2UrWrREW9GybGEeqigx?=
 =?us-ascii?Q?iEn7fyCg163UF12Hg0+x6ANsvNb7vBbt70LkGNyZxBW397aDt7nPiNRYe5Lu?=
 =?us-ascii?Q?P+68Kr4Zyo47u83B0Xl1sUJKpz090CC5naBHdG6g6e3Jzim11M9eCk/I+ssc?=
 =?us-ascii?Q?V4Sz71wAN+utPf1ZIYrD0hS500c5J9FDwxC612LUKOPkywWbQnHvmYEpwe7v?=
 =?us-ascii?Q?8Ns+VdGv7P/nQsUmdQ7ukCaP5v6bUrg7wSkAHsEI47/Qw0QfQ1EDgoUOd+8A?=
 =?us-ascii?Q?I5z30Kj0q0FYnK4toswB6QLcS99fDf2sNAY6dyKVMJ/66lTF3Adn2mNlQ067?=
 =?us-ascii?Q?uRQT/XU4VcdnYra3b1mQGdoMf+WPAnz2szXWo7lPpYpnFOsLJ4AkTBZoZB8p?=
 =?us-ascii?Q?qlVxTHVLRa6w4jPr0o7i2E1sx/kpxMgwZJUHzJ+Aur6oyouVow2uWyQ36wXF?=
 =?us-ascii?Q?C6lVoILPY7Fo+MSr4aDj4qD8EZybrYk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03E08B4B43614A4B925B6264D718A72B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rcLEIZjXfTsONYiAso8ZH8QhC0FqI7rru8I4jAAi9o4uDh9SZ4mKvjat3xVrJwmTZFvtG/ch1w0UtU07JsmZGnc/Rz2XEhhSOyitp9EmrOkmtMciBaFi//cIiGZWOy1r9f7KQisJRIBUEmgRxkkJKBLsB2wuyg2CNis5oOKjGJTeX6q4IIIqHV8MG88WXlckwwU/KKFq5ifESUcQ2lTXtAC1BANfl1CD2FWY82AkaK1ieUp6C9SMLdy6LfxDjRjZbc1IbgCFG56Ao51VGVpN80846Pm36dl9jqBmn4zenK/sQGDslldmXrGhDTYdp3jvU4CaDlWDLFwY87dDd/hm7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PgRGw9x940qcyab3Fna4HfLssy1gjHoYXxhPUcUflXgK5OeT56+7ajPVdncNE5uMk5kuylrL/svQ9xRayXi2k9XV82IXLar/KRH+C8p9ZhJd6c413aZB2WT+XwOP5OHuXuGEE/Vpwo8hikoUxcKpe/jp7c2jdzA3fGtaPh5NHLNcO1CSvrwlNEVsNiOSgr3PL5Hkw0gfw2GRXHK1T+DsDC2RKCehBmJSTWRCFA5z80T++2hxk/6IOe+AncHd+JJD8gTCDMtKa7nYj8fQuRcBuzGu+IFZEJ2Qa0q2WIh/rXFclsp15RjvQj3IxhKSTdtQFRlgEtOL0cn+4v5CIFkgjwtJZHzgKn7Xbk5HZARFFwToRuzA469IJesn8j3YYD/us9j8AJFL3d3aAB6plWbT6id1IY+HdrWsCZsq5qXQ3+Dl41J6Od6tDCylvtNfJChJL9czO2wSnle29CfR1M52WlVx4WZEUg8oZGYwuWUWQ7G+aBY9uN5b+YQYqhcvSsbDPNoKPfn5MJS0hdLz+zULr55Amk+aHF0tXYiOhl1bBhVjd45nozsBGAbKZTa7wXoa49f6My7rcMi0miq3odk61CeHQ8rs/ViymXGRa6qFvhTLMbZtCVTunPa42Hzi4UMw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8536.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33dd014-34ba-40ff-e85b-08de8a64edc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 11:52:02.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoEVivV47VoSCQYkXdhaTpZ4pcJF5rNixxn/jEIjmGyw0A2v9qopx07mHVFWvDw+ZlinazhSuLfStAC4aBZSK/xgpDtZ25KxiMOVKqGsj9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6772

On Mar 23, 2026 / 13:07, Bart Van Assche wrote:
> Linux kernel commit 889c57066cee ("block: make segment size limit workabl=
e
> for > 4K PAGE_SIZE") was merged about one year ago and adds support for
> DMA segments that are smaller than the virtual memory page size. This is
> important for devices that do not support DMA segments larger. This patch
> tests the code paths added by that Linux kernel commit.
>=20
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Hi Bart, thanks for the patch. Please find my comments in line.

I think it's fine to keep the two new testcases in this single patch, but i=
f
the kernel side patches go into upstream in different timings, it would be =
the
better to separate this patch into two patches for each testcase.

[...]

> diff --git a/tests/block/044 b/tests/block/044
> new file mode 100755
> index 000000000000..e2ca2d9aea3a
> --- /dev/null
> +++ b/tests/block/044
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

Nit: many of blktests files have license GPL-3.0+ or GPL-2.0+. If you do no=
t
have specific reason, I suggest GPL-3.0+.

> +# Copyright 2026 Google LLC
> +#
> +# Test support for DMA segment sizes less than 4096 bytes. See also comm=
it
> +# 889c57066cee ("block: make segment size limit workable for > 4K PAGE_S=
IZE").
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION=3D"do IO on null-blk with 512 byte segments"
> +TIMED=3D1

This new test case doesn't look referring to TIMEOUT. I suggest to drop
"TIMED=3D1". When I ran this test case, it completed within a second, so I =
think
QUICK=3D1 can be specified here.

> +
> +requires() {
> +	_have_fio
> +	_have_kver 6 14

Do we really need this kernel version check here? The test case checks
that the null_blk implements "max_segment_size" feature. Assuming this
feature is introeuced kernel versions 7.1+, I think we can drop the
check above.

> +	_have_null_blk
> +}
> +
> +test() {
> +	local bs=3D4096
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if ! _init_null_blk nr_devices=3D0; then
> +		echo "Loading null_blk failed"
> +		return 1
> +	fi
> +	if ! grep -qw max_segment_size /sys/kernel/config/nullb/features; then

The five lines above can be replaced with below one line:

        if ! _have_null_blk_feature max_segment_size; then

> +		SKIP_REASONS+=3D("max_segment_size parameter is not supported")
> +		return 1
> +	fi
> +	local nullb_params=3D(
> +		blocksize=3D"$bs"      # bytes
> +		completion_nsec=3D0
> +		max_segment_size=3D512 # bytes
> +		memory_backed=3D1
> +		size=3D1               # MiB
> +		submit_queues=3D1
> +		power=3D1
> +	)
> +	if ! _configure_null_blk nullb0 "${nullb_params[@]}"; then

When null_blk driver is built-in, null_blk device name nullb0 is not
available. I suggest to use nullb1 instead of nullb0.

> +		echo "Configuring null_blk failed"
> +		return 1
> +	fi
> +	fio --verify=3Dmd5 --rw=3Drandwrite --bs=3D$bs --ioengine=3Dpsync --thr=
ead \
> +		--group_reporting --sync=3D1 --direct=3D1 \
> +		--name=3Dblock-044 --filename=3D/dev/nullb0 \

Same here: s/nullb0/nullb1/

> +		--output=3D"${RESULTS_DIR}/block/fio-output-block-044.txt" \
> +		>>"$FULL"
> +	local fio_status=3D$?
> +	rmdir /sys/kernel/config/nullb/nullb0

The line aobve is not required since the directory is removed by the line b=
elow.

> +	_exit_null_blk
> +	case $fio_status in
> +		0) echo "Passed";;
> +		*) echo "Failed (fio status =3D $fio_status)";;
> +	esac
> +}
> diff --git a/tests/block/044.out b/tests/block/044.out
> new file mode 100644
> index 000000000000..4718ff7bd595
> --- /dev/null
> +++ b/tests/block/044.out
> @@ -0,0 +1,2 @@
> +Running block/044
> +Passed
> diff --git a/tests/scsi/012 b/tests/scsi/012
> new file mode 100755
> index 000000000000..a2043f95deaa
> --- /dev/null
> +++ b/tests/scsi/012
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

Nit: in the same manner as the null_blk test case, I suggest GPL-3.0+.

> +# Copyright 2026 Google LLC
> +#
> +# Test support for DMA segment sizes less than 4096 bytes. See also comm=
it
> +# 889c57066cee ("block: make segment size limit workable for > 4K PAGE_S=
IZE").
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION=3D"do IO on scsi_debug with 512 byte segments"
> +TIMED=3D1

s/TIMED/QUICK/

> +
> +requires() {
> +	_have_fio
> +	_have_kver 6 14

With the same reason as the null_blk test case, I suspect this kernel versi=
on
check is not required.

> +	_have_scsi_debug

The line above checks that scsi_debug driver exists, regardless whether
it is built-in or lodable. When scsi_debug is built-in, the parameter
sector_size can not be modified, and this case won't work. I suggest to
replace the line above with "_have_module scsi_debug" to confirm that
loadable scsi_debug is available.

  When the patch series "Skip tests if scsi_debug module is already loaded =
and
  in use" [1] gets applied, the check above should be replaced with
  "_have_loadable_scsi_debug". I can amend this change if it is required.

  [1] https://lore.kernel.org/linux-block/20260324054949.3821569-1-shinichi=
ro.kawasaki@wdc.com/

Also, I suggest to add one more check in requires().

  _have_module_param scsi_debug max_segment_size

to simplify the parameter check in test().

> +}
> +
> +test() {
> +	local bs=3D4096
> +
> +	echo "Running ${TEST_NAME}"
> +	local scsi_debug_params=3D(
> +		add_host=3D1
> +		clustering=3D1
> +		delay=3D0
> +		sector_size=3D"$bs"      # bytes

I suggest to add the paremeter below,

                max_segment_size=3D512   # bytes

because the added _have_module_param check in requires() will ensure
that the parameter is available.

> +	)
> +	if _have_module_param scsi_debug max_segment_size; then
> +		scsi_debug_params+=3D(max_segment_size=3D512) # bytes
> +		echo "Segment size =3D 512" >>"$FULL"
> +	fi

With the _have_module_param check in requires(), four lines above
will not be required.=
