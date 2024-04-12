Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146D4E1B3
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906054; cv=fail; b=c1Df34D3A96ZTRTf4G++lfoQu3E6QfiPYT26udkB3PKrL5dnfpXAEhyTKITFEvZET3FZGH/0DaSYaOmplfGjUxxrBg+iXcVIGUO7kAM2vauhQ5n/jckE0CYuhxRr2Ajry1DuAOTD6OQifWer+nMPOpDBgG5fKWsB7HbMerakloc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906054; c=relaxed/simple;
	bh=/Y3wyAWKh1R5j/dB/ImOwfkDxVwbIAOPHhhBlpKaxvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1plJFX2dr0G3b0Z7l4gVaITPDuVshDUgITAIAfxcMmdr/R9glOuBrVW5dNaA7h3ehFg6xR3Ng4ww1kHEgzoAxo3J2cI0im2uf6fuMkubQatvaHYo8Bw5XNcWfW5gvPs/Vm/4sJhxyYUpxw1iyAh1w7laEFWv87faBj4iZT2pDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S8cjYwj6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=inhxvQeo; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S8cjYwj6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="inhxvQeo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712906052; x=1744442052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Y3wyAWKh1R5j/dB/ImOwfkDxVwbIAOPHhhBlpKaxvU=;
  b=S8cjYwj6TCswMV2Ev63z8EC2AQIEcgkuLAYeb/0U+9o+NKUqjke17Zsm
   v6fAXWvPYUdFPbzND3cmzJyTIcjOCKNXgQfsIaduZAESIja0f+gPsp+y+
   uRQTK0w9knkQWyRorEYoFCndJYMM8+OKcDaUsF5GbcEA5up4THOt/5P6f
   LYWnzx0vw29oy1cdrD7qFA03gREv/8neb8mErQkO9P8qRsGEiYO5rswdt
   TLILnYsi4qewO8Y1LpEWeFbMI2c47U7lAigZwS50BRBsvMRG5kFtQyqt5
   A6iSzrgWQQgF3tUX/GXU8gvsZlN2sWyzkg767rKCIvNdwIYKXgf1yIWKp
   g==;
X-CSE-ConnectionGUID: nrLTqAvwSd+upRvi6sG2PA==
X-CSE-MsgGUID: EGubhVkvQOSarRggDcya4Q==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="14535389"
Received: from mail-eastus2azlp17013022.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.22])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 15:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZT84Be0YpUmtjBVGfBYWScuvKMy7zdkD7BIVgOskZJVPfGm0jkSf13CphVW9FH96rKF3BQJGmbOaCDOcoroZDhNX35TOD/8+hKWWe34wYzouhcKT7q/CMmYpP469mQcodXRor/h6ND+/itHbCHyin+PKlFAEweF5hNAMJi9+aYbwYT3FVn2rxBpGCHgvyjgDSSGheuIbifTKGeN8vZaA3NhJWkk6jprfcO3pw5TeLrmiIuw/x9YNHIC1HJvAdFuh+JCwHamKp41ahiqx7Bj6CCMMuhTvAgmjhQqzSOPb2642mgcJ13wVEBleeJBcP0CqRELQTjQ7KBQSFmI2bVZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y3wyAWKh1R5j/dB/ImOwfkDxVwbIAOPHhhBlpKaxvU=;
 b=nYEzg6/d9sGsxxUcGgZnyPW1q7wNI+XIx5rR0Tu6Iag35D8ZFTn4NYR3KSDiDJbimaqpuVQMN/tcJMiXm38hLuJ7UW83nwrHfOZyI9rJoU1hq2N3B9fVurY/ULTE9TMwwj/gF9yPZTPE/v0iaJ8MwARdf4xyF/1UnYpA3Suw6K9Xpwf1qzDzTf9FQzHbAqPAsOROt0M+YgKtPeNAQbV09YFv7L/saGyck8/snQKJujyOPFxH2S2R5jbpg9CT3fLHUNn1k5o0XadYBWYx1XQImSeAPk2m96VLmfbWcDF62d4vAao5mOaTNp3cVgudY6B4p5dt+gDSPH0p5PSTFyHOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y3wyAWKh1R5j/dB/ImOwfkDxVwbIAOPHhhBlpKaxvU=;
 b=inhxvQeo/fSFf5TjV/xed8DhkAA8xzxxXtQEXtjZaRhrrXGaBKB0UGmDt9FcPdh8VJlIhfGJ3VaiOlwFvt/aVJz8LVDsUo7CZAPd7jI37fVDrl00EqQrSs0GN0gllJ3W4eiOvixBLrWg/D1cFvGPnwW0vyD1Uvy3PtSCtWYEh00=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6309.namprd04.prod.outlook.com (2603:10b6:a03:1e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 07:13:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:13:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "hch@lst.de"
	<hch@lst.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH v2] block/035: test return EIO from BLKRRPART
Thread-Index: AQHajGqy2lxJyREHFUiF7JiBCD2VRrFkOSSA
Date: Fri, 12 Apr 2024 07:13:59 +0000
Message-ID: <tdaviirkvzqzemugdc4ursq7zbaabgpl5vowd2nt4uviq6i6z7@2wrp4nrwp6lv>
References: <7ksgwjpcdt7up3r5rvvxoojllbnqnxu4fdzajpyzgns3sax2yi@hbkgnensb7i2>
 <20240411234742.590340-1-saranyamohan@google.com>
In-Reply-To: <20240411234742.590340-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6309:EE_
x-ms-office365-filtering-correlation-id: 64e5c7f4-f610-4882-ac3e-08dc5ac02006
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WKz1e9jcZyrCUC9sIh1pHfCzXmKZAXaNWGwImQKAQSP1GqwjujwJgZTXlinLh03UnsaJiFGHFzLdJrPwQAJ7/+T8t2B1j9Kk/Yn+e7ZIdalUTdpK8InwuAvFFQnvkki2uoxRI816Tbh3TWWsfYEcDUJZLHY19rhUnmRnmahajD9SbCJQW+wVtn9EVEUBdyEQOSZWgBgFJ3b5dJLZQkg6gOLkwN1DKAgMNwX2KWJtQQmNnagIyBldut8KeTKqS3T8yyzy6uA/bwWWtjSIT8b68qJMIyVD9pI3ZC8LE/mseuVMHwT8nGaHYD87ukGibM9RINhVHSfGs4dQY1za8k3Zd7ysp7C1SLSexgVmIHGiuA6gg+mh4hWBsCZGUaQIlT7HyOn84yKasdjbvOa//EgRaOOtQQF0DOOI+6CweCxcGLB0NuxE2cLAokO+47YO93cDIzAX2pgnN+qnB1a/Sr/2VaVm6p7DeVanLWffeZ1AiKcGX6ybbQXtaS1qDcw2ce3WXRr7gpXWqxWA0CtdEWPJP7CLdsoQdZt6m+KDrammRgkgdAwRJFIr17Tahxb1MbO/DTC+qbCk6wDN99kNfWglWI3Slpd3mGEOGKnlHIMMAV+khThf5uos1E4INoW6qp/HQCea3ccN3/0/Nnz4VHeE6la6XAVNAX9VqfrJ6bwJD9UpnxjYbhCa5/+A6g5ah5oyzpkDYWl3CvwoMM4zFHzMW/9YfMI0UGCidWnNjTQ9V8U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IOF0Gq+yfhqXeKrR2AqgkoeWJZsy3DxkZ7QJdhreHe+4gqn0C0HN829DRwBR?=
 =?us-ascii?Q?3EC47Z2tvTZZ0y8brW3i8Kdm2ZCa0ArUEUlGdRLHR5+J05bzGi581+k+HJUt?=
 =?us-ascii?Q?wNkihKGi1niTpiLdEwAP0fUGpP1RujmDz47L/44uxL7PICrt4lT32RrTbSz1?=
 =?us-ascii?Q?nGgfgOgUTWSGI7k9+7wVpxnhbawHzxM+PC9uBTGATbwwVBZAVJ9oxxS7H0Pc?=
 =?us-ascii?Q?Wi63ZP6qH2M7G+dn9qD19n9dT2wRZqkMmlBIdoFLxV0JZt2qb7kwHEjej6Tw?=
 =?us-ascii?Q?4CwVMy8yj/TyU+Ycz9CEUMVIDf1TmcvCwpmybslOUu9zMUQ7CvPxKt+wP853?=
 =?us-ascii?Q?TfdVE8gUmLj5HCFGy2ySGYNOKXRUATfg0yUPPrdVGb4qKZ2hobwaWjP+YDiB?=
 =?us-ascii?Q?lZtCixfSbN9iEt/13iGHwBk8gpmLBKXdtG/CfXTTQz2eMdhDKkqtTkhy+UXO?=
 =?us-ascii?Q?UwW1NgWSewWMJx3aF/rRhFCvp5V7ABCw6rpbYqzQT+neDlPPAhmxjmEf6nyJ?=
 =?us-ascii?Q?IRrVt2IFZsItVW0a+8fbEvozWD1cf/gLRulSnePfgGOhi+PG5zXF4bmZ6VcN?=
 =?us-ascii?Q?qpes+VApRn1oG5fk70ppHs2NS7Bwc+85JJA9SPtjTBiJwhEC1ClEtTuo63xB?=
 =?us-ascii?Q?Ik4HLFg2rTQDE1/FY1n0QExr0UH0Ba2w/4OjlQsHExCKPKMCC7FtgCAJm+J0?=
 =?us-ascii?Q?1+dfSBYqJXdZgiHrNc1ZefKSN1eWSNVUnbOYgZ0pMvWkT/g7BwVzKJku2+z/?=
 =?us-ascii?Q?NgGiPc5b56G05O/4qPtYm1tiWIQ/u/KK75XEF4L/+AqDOWKpzi0XGFsV8Tfv?=
 =?us-ascii?Q?LUfH6TgUpJ6P+gzL5Mz82nBw4a9BM/Egd43XXi2MCt6pprd91fts6idwbnEb?=
 =?us-ascii?Q?Y3hHnR+JBe4DMTtWz6osU5464Av+QDdO8V3roDhUa9ceKVJBZ/+orZgs0kMx?=
 =?us-ascii?Q?+I40ZAwHzEveFK3af7nSEMQNkBrbn8mrM69jCh0RZeK1U0XGRtEmfLzXLem+?=
 =?us-ascii?Q?C4EAr3qj+69j0hYb5ZyqI554DlciYofSuRlxNsDg59vc77BTU+e9Uype9ryG?=
 =?us-ascii?Q?PN+TCHqzE1DtdqKhQL5Y+yLvoFEaJJd9GM5GQpYxKEcodPDGroCnSQL94IX+?=
 =?us-ascii?Q?jJCl4nNEWAQJDzCgoxd9XHlccFgFF6K/4WJo3i6zV/qR+M8HoXhZesCKnnLo?=
 =?us-ascii?Q?z3eoWj6up9kDKT34BCCuhpSA/ZCIK+r3r4qjNI9CgtB5YRO2Mn+iOZ7vAI4V?=
 =?us-ascii?Q?NHDJ3tW4pmoKsEkg8HXFf66ST2Q2SOf2dTvlXj+nx/E6+XAEpEhE75li44vE?=
 =?us-ascii?Q?QNvqOVchlGI9yGbj0i7frixBu9F4VH2zGaFqw+kDMoBiz8ewLNg6I3vYZGm4?=
 =?us-ascii?Q?eBgbIMSzKR8R/QdlFqSFTMfLDDfGB1TA4YBR78Fcbk+Mzpfjo1u3bjaqDPf+?=
 =?us-ascii?Q?2ATrc/t8VkZXjEc4+kQA5H607NUtLL76jB3kYsvXRASyF4Um4RgO66i9ikSv?=
 =?us-ascii?Q?b56opkNlRj3UCJUxJsQ0G2CMmMtsZ9a3upFceJ4sRrYR41A9GVyg3naniT0x?=
 =?us-ascii?Q?eyn21fwi1i0++zGRTlSu0+/Quzx5nive6BoC1mXCEku86n50MgNHcIIjq+hf?=
 =?us-ascii?Q?5ZOlyeNnhKbCsY+kzKCzS0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CF5EA4E34F6C6459A5E317164757D1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HYo+NbxK48cFBz7bxbgU672NaaL2PFj/Y87uyYAG26J2juk8HNP1hzuudSSHuscnbYEu1mjWYq6UV7NfameDq83H+Uw+QPFjiVVQdyumZndWk/LM8dnudgEJCmbcdpME0YfuOGS5SsZytiEPZ8O1SSP2y3dk6J6VuhuWvfz/ggbfyMzZ573frC88NCF4HzJrGTMCbTUV+Zy/pmixchXxNa/TdO9MooaPRBGvowKwxZWfUVlTwCaYU4ne4U4KKF/1EagndY+N7ndYvztq6nqyvXYDH0sVORXXNuLKUwqM0qAqZkrSG3GIaxjvJsE6I42o6vlfbH/u+hAx90NvsU/lYly8uHxEYLtaUKakvF/Z6Mr76J9UPkvd/hMmJIrOWyc9JF/RhoN9WF2+b8cA4i9uIthTFjVHuIDnVuLCvhONYOk3vadUVE5B1qbd4LCOXjOQbITzYja5U6LbCPMw2LqNm/aWcqTMloqbp6+KQLPHniChJTFhizIdWeTU24LTjQ7UkN9bnjMmAcwBqRCQKFhi+VXPmyUFQUNQAwwMDxfzgmgH0ppzZQl1Q1cnBwmOsoYa4931SvcY3ixNmqxv5OQ1eQKqfy8KL7nxMZf/iyRsrALM2H3yA9j54VvpF2zo04fk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e5c7f4-f610-4882-ac3e-08dc5ac02006
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 07:13:59.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xfe8F6BNrohxWSx8OW91cJT1nkn8V7felufDesXn8K9jOLM88gRZ5uOipc0wQRKMnMJEuzkCc80llpYAjUEnolgpaoXnx8wRes2XSTL+MJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6309

On Apr 11, 2024 / 23:47, Saranya Muruganandam wrote:
> When we fail to reread the partition superblock from the disk, due to
> bad sector or bad disk etc, BLKRRPART should fail with EIO.
> Simulate failure for the entire block device and run
> "blockdev --rereadpt" and expect it to fail and return EIO instead of
> pass.
>=20
> Link: https://lore.kernel.org/all/20240405014253.748627-1-saranyamohan@go=
ogle.com/
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

I've applied it, thanks. Please note that I modified the test case number f=
rom
block/035 to block/036.=
