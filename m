Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70C212B0A;
	Sat, 13 Dec 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765609693; cv=fail; b=X3IrZUJpf+i4ViXBpqRSAQKZVgr6lwLSRggD+oh/tZsSlYT6P7M1tQ0QqmFLLQOJbHBzFS2FmE50lrFulGGnz+h90T/pi8J95qyNLLImPpC702RYKDdLCItqTEQkjca46P6ylW2obSnUdzi/I0s6OCkzkpEoHO2r6JEXLM96eGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765609693; c=relaxed/simple;
	bh=NBfbEkgmVQJuTsPAFYjLK5lI+E/8eBe1Zp0hY6oU+hE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MALa6iiAvtH/bQfdVCoHZYCimTw71K4S7lE3b6JtlZ7igqiXQaPM5BQzBIpLdf5Ukxy23f0t0ljuUoozk7mK/fzvemiKDadGBUoqkygjUqkUiNCHI6CpBXRhHuo9fA1gc7aICw5CJg1afPPL3kxmxByn0j8vn7k4tLU2q3td7nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=CFMLbdmf; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="CFMLbdmf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1765609690; x=1797145690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NBfbEkgmVQJuTsPAFYjLK5lI+E/8eBe1Zp0hY6oU+hE=;
  b=CFMLbdmfJPFbRPxFXPmkCsmoGAe6bRyex54BgeAZCC6TnhIi5Tbqusta
   gO7pTHmzqmV8kiWpqIqZbr5G+Our22kstj/6w3qXJApafS/2m4zH/UbXL
   dGNzqC/3jWTvw69K7lwUKe1Ew/zqJrw76/ABEboyqC8vs2t0/ItFRHXjJ
   0F4+Xzr9sG/c2ilryv18H6iCbT0t+WBDa+eR1sIJRMD6UzDgfqAaP4y+x
   TWl1f2zrJ1ANOU/z3JXH0dF30sliHRhacuGGYEvx24pmLBGb/0OY8HCKu
   0ESsNPT8Gj0CmimXje3Bht0q2UldgxQJ/FTNb2on4VgLvc3F7FE9H7vwa
   A==;
X-CSE-ConnectionGUID: Bv4sMyiBQS6bgPeZ29XViw==
X-CSE-MsgGUID: ke3wJkxeQIyz+4mKdpaSWg==
Received: from mail-westusazon11022136.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.136])
  by ob1.hc6817-7.iphmx.com with ESMTP; 12 Dec 2025 23:08:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWk0EYIp4yeNoIKfg8tyGQ/G6hZnmsrCqbrZT+2tBvJHAiliTPtLEUblxRYfYH/vxINoLZWDf3dWzOPYceoUOhAWcCpdI2PNWEjyQhxWKzfuYkZNEU3hUQbl+LDXgh+Smm4Y7JrBJSO3rjzIK34LDNl/cc8Ev8xKAb5nAwWL9r0b53IZfcTQb24pFnkDGZWLoZCuLrCM4+1ym8Dj57l9/aKamyM5nKR1MsZotknWidnWPe5exP7Z3Mo5X5r8XM71wMWPRlJm8uUwToFik4RQWqrVmM4KsGlTkcgFxjg6gri3N3pQO09i95rStfD5E50wzDn2GtxGemlkqMbaAwbcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBfbEkgmVQJuTsPAFYjLK5lI+E/8eBe1Zp0hY6oU+hE=;
 b=VE+9fS36tRs7qDiugHdIEnrWLGskktx43dR7HsWTy8Uk9aoFbHFLbMFHWf/bqATZwRuDjNp+mulbhX43JidUhPHI1CpcteoWkbg4fsVqJD57wbVrsjD64VZhuKIbjicbHdtSSojvO2ZZqHNpoXKUfGMSiSW22ssJnICkCaVRRw0lmxxDrrrX39xdduMnl9rliPnwMAxXJYTyEvbkZvI9qtkxVe5yg7Onz9ey9yQqykDcpHgZX+ahbU/nuZK2ay741M1SKXR6A3CPt5G+623V9/MGUAU4QUdkR/P7/O2d5rdTfvoye0hz1foHQEvlSGSVSXO/7cBqeH7MAscTH/4etQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 IA3PR16MB6607.namprd16.prod.outlook.com (2603:10b6:208:522::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 07:08:01 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%5]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 07:08:00 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: "ziniu.wang_1@nxp.com" <ziniu.wang_1@nxp.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
Thread-Topic: [PATCH 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
Thread-Index: AQHca0HTcDoVcKJ3KEaLqoj7rKEi4rUfJi0Q
Date: Sat, 13 Dec 2025 07:08:00 +0000
Message-ID:
 <DS1PR16MB67539E6FE1199DA045DA614CE5AFA@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20251212083246.582806-1-ziniu.wang_1@nxp.com>
 <20251212083246.582806-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20251212083246.582806-3-ziniu.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|IA3PR16MB6607:EE_
x-ms-office365-filtering-correlation-id: 9d0c704c-7126-408c-fb18-08de3a1659ef
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iGT2lAhEBQfv1UuyrkL0SVY95if3a2gikRVw5MNTxy+3yUxvyJUECz7hi9GU?=
 =?us-ascii?Q?qpWJi0ShZpeZORFh44IQmXTNZXd/dW4e4qC1h/Y8hFse9ZymJOQpz0ZI4JrQ?=
 =?us-ascii?Q?GuM86sBTLbe2uCfOR7Jt2A2FjdMcjfsMh29jYp4YJ2gDMxBbBcN6TmUKlpJ3?=
 =?us-ascii?Q?sRv11AGF8UchV7vpVpdYsjhR8STzaDGDwRQQaTWFZx0PG1dVtJS0hg7Ssxs8?=
 =?us-ascii?Q?NykZUDEdApOBkyqc3/ho2n8C+G0oQAtKTbBkcPnbukLhsGV+BCpSsQyObhwn?=
 =?us-ascii?Q?WzgvMZGkV97KWIVgu1AsJkYBJVJEEsyHyoR8wZPKK/HPrmdi/HIQNQaWWAnd?=
 =?us-ascii?Q?Nhj8IN23/OqRSya3miH+gn8x48WHecGvb08eRHd7RNSQZu83LH6d6IFFX3Si?=
 =?us-ascii?Q?EhGoIBk3yz2atyw9pACNxHkSmbaZiEW/m+BAxFm4cEzG3ufswSsxyYJVvc/P?=
 =?us-ascii?Q?5p49tKp6xaXTjD6DFVaMErKLaXoRBLN6eIWwpiu+DqBFbecZU2Ti+rfGSiqH?=
 =?us-ascii?Q?zeGBSkWWsCPQ/M1WCcQPt7fM20Z4Shv81Q8pnWgtC07GL80POEeduP4KGnv2?=
 =?us-ascii?Q?8bpXAQi8PeORkFkOR0Ew+C5UyWlz2WzzFtP1A0tHebh8gw0RwnTsNjN1aPuN?=
 =?us-ascii?Q?dNWXamfku7cavHesh+VV9aLx2WXeUtoZ0MUL5Uobvh98ODUwehU/qltNNcAA?=
 =?us-ascii?Q?DrXyiJmeqeR8DK7AU6bEYNN1tFtq3e54ehil9ruj/5B2Z28OAa3cRfjiPg9x?=
 =?us-ascii?Q?8m+RgFZKvX53bXyvtAUSFg3BmVbESq6aY+GjdGczX16hv2LfghYm55LGEkij?=
 =?us-ascii?Q?/i0YIWrzWNHDZ3KwcSNZpdylAJvwjI6jX1P2VWl9KUa6fFs1azXd6fJ4ESI/?=
 =?us-ascii?Q?UM4PTFbzUIM+Pa7kHqlfjuIDP28Wg5AacvFv358NL42SiLWO6g+P5ek6WKAc?=
 =?us-ascii?Q?NOvPwVxvVC/+b+TnqR33OULjvShrNh/Ci4Mms5sMBluti3i++IuQjVagjlE5?=
 =?us-ascii?Q?Zoreow5SUfmAb9kn26zAT6t766CDJxGT67yVNU76W+/BFBvWUXP1KTcbDO6n?=
 =?us-ascii?Q?04G5c4Mc+W6pbNDKtZRVsPgI/98BXuWcH6hbDk0gOv2XSQgNKsyIZS3j+ARP?=
 =?us-ascii?Q?wtiw+orGbn59RTNO2ZqlDJUvX6vsPq0pe2b43JZJaJ1Jk+gAGf1Dy+aXZCyR?=
 =?us-ascii?Q?4kRZiGtHzM9+tg8Id1FdTypxcRGvPuM92xvuce/3a8nOzdnMGlvU3vrIIqvR?=
 =?us-ascii?Q?wwyqkhG96L0CX6Imy3RKXozULuVj1arxcZfU1stRQHt21a1kVG3stZuHwLyL?=
 =?us-ascii?Q?X8TJuF2rNJ5/ru+Qmmi6wEmkjeWSBy0HbtbiQp66rt6r9ZKXTF0InPohboMC?=
 =?us-ascii?Q?b82SCLZU+jPXY5sqsbckaBxZT9+uKodF0S3WMi4IOoH5skRmLrks3dicYFo2?=
 =?us-ascii?Q?GGS13HsQDgFZRGHTAYlYg6+NH2o2QyMUG9DUSP4GDyvSrdc5BOANt69lEB+f?=
 =?us-ascii?Q?ZRaXALzYf8EBsm0gUL3K83i3UE7mDwQw3Egj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2QXxSG61/yd4OGD3o6kr1iZjZK+8PbMCKiMM4U5Gmej+CnjEEzvtAn2/T+aN?=
 =?us-ascii?Q?12AlOhj9wu31Y7MqTdCP+IN5dTuBG58OyT8OTcIjeZYNbvf2MrT+nOujJfMX?=
 =?us-ascii?Q?Wc9cCiFr0jcIDimfb5e+YCGwzh1dXwh9b7McSvjZ9Y6c+i5pO34J6wnya85i?=
 =?us-ascii?Q?zQXveqsgKMZTiQpP1h4JnYe980Hjv9l/f2r0ejeQ7fHuL/seS5eeMZcTbUFQ?=
 =?us-ascii?Q?+bhlMAHZ3N/0w41wp3rRRCYvMU/NMKB9nYaaqJmJUPRG/OSFynLd8g8CFeSB?=
 =?us-ascii?Q?SQZmiJ48iCI1BGUk+aF6WZ13abi5SQH82pPwsoZw+O4i7U4Lv+ENhEpFJZ8U?=
 =?us-ascii?Q?pezqdelmZX3SZtqdsjjzOJh8H9cq4rbiF3PZZGHaq3RNVlCgxh8yJIY/TIro?=
 =?us-ascii?Q?QZKGUWz0oqKT9AF85hBIFSfX3/pO6W3CnuwAr+fzNhFXSiTaLfKaxNcleZrw?=
 =?us-ascii?Q?e5pH/tzGQv0N+50nFzvzXTRFdNHXWRZTg1ftNv7hQ+rBXZTim0sE2ygKQ2Yx?=
 =?us-ascii?Q?2xIHGpudp6x+weTa1rWJ67iBOmPQRjC6sW6IenY3o+3F4Vz/Gu9sERj37wg8?=
 =?us-ascii?Q?VcIEkdreJHUpAH8XKQaBqxh4OUMz63Gav4wyx6xq2ItdaOJncM9lcEyjUA4Q?=
 =?us-ascii?Q?/sZ2elkjd+hVjNLv5GC11N4qlj5JCRGmK9GbiAm3Q4g3gQVOFG1QnQmbFL0a?=
 =?us-ascii?Q?SVpjinPUbKO377FrQ/gGD5ceG2uQJzvIPATHptQ8mUttsABFm6suffgpYIin?=
 =?us-ascii?Q?EQ/aLRR9hpCrFni7KNlb4OuasWLcAVpayEWue1lGlxdKT435q7iQzSPu6OKZ?=
 =?us-ascii?Q?dAv9F1KhFIbhApAEfksmB2yAzOcyhMXKUMGP5QguO1VlgNMozX+/yH1nZ3Ze?=
 =?us-ascii?Q?782rjrVjZhCo3Tlp2cjRf3yVBPF8Ia52fStwDZd9l8F1kXsMNxfWiMawCUA6?=
 =?us-ascii?Q?2PT3IIyK0Hb7LRcrIpz9nQ4SBRL+/bgLam3Job5LnJTWIMkws22+NqqLDl5F?=
 =?us-ascii?Q?3ShUlgs+Gg8vYP/6BrWufgBP21tiphOiu+qz37RqwILhNMvlIvmXqM6JUaqp?=
 =?us-ascii?Q?XxXigBRQUS0tlFxL2lauOa7u5lpSn8xxWpw253szY8d5NhjYbRhm1lwAgum8?=
 =?us-ascii?Q?dd8vL2ZCyUBlS4I8LX2Bhb/ExgxPqRlDNwCixOaGWb8XKpNtHq3chrUSuCgN?=
 =?us-ascii?Q?JuSbdScCCGTw822Zljbc0cJddOjFjfmuidrNyDCgHxNVfcF1JGBsyOjcVcse?=
 =?us-ascii?Q?Rj/9hKlhDxIGILR6GY+MD0A2Q8/wS7pZVzqFFRNPfIp07NJa/IVtPkqhn3wP?=
 =?us-ascii?Q?3Ez1Ndg7R0eRp6wDfJMv9Pg7LG9UCvTwQ12A7ITxdsVtMnplaFexPikJlIWq?=
 =?us-ascii?Q?OxTO2fL/9mjgD1wNVSN4FSsstDCH/weaKGQM0XhnT2es9EWJLqGdL0firjK+?=
 =?us-ascii?Q?G9MTQD5vsI8yjd4ZdAs/cQBB8SPqDnoVT/ytT0yT2BchDFKPq3HOykBcIlKj?=
 =?us-ascii?Q?bR7Pn2GDJO0vCmMW3K8FWFjLJ9BVJGOC1Vf5CPU40/DyZRQeu/y2C2UwcFDJ?=
 =?us-ascii?Q?S5Lld0zVtc/qSLYlf0XFjMu87IyNz/eTdT/wfRQG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xh6ChBpdehLQ/ExXMWp8qvNzqsKbnDkEonGI9uxuIlEI5b5lbpCmEFlbsDohR4gc7tSaUuEbyTzsYCOcW5n639z+65PANbeSVXE+5IxP2ICZlOm2YRNW0zyqG9St+c3U7MB3fw9R99cTOMXl6rWSUWP1JoNLewyffrLGLH4V0ISP68HWxKu3Z2ek929SgVFoX+b3HMxgd++P9phTbwC1982y2SyYUp8PgsQdNPO3mIzlmgpNLavpolhkd5ywuDRR+rNXASzSvt8jYJiyr9O879h106MhvigEhbUxGFoXEoqsOlYVicOO0iLp8/6eSq/OxktezaK5cxMaVtrOhH2U3cZrzXwuKCKOt4n+CzyO3upX3YeHtjvJFnrdeAzYCmQBEfg+9nirHsv7rSyCfD5JUl1uHsjwStqoBjpX6rQqtNe1zki+pA3BsRBdhHkPsD8xrKH2R684yvfYgDjBvZNkbaajjT1RouxVgsDTNoU4jsoYaBA05Exbn1Zs3uwWUx/ShTNA9e9S+Nbrhvx9QCtob9bl48o6gKOtvKJAoCI4FU564DfjlDf4GG0tJsgDoPxdBb0/9hB+wq7oPy/alZ7RWc66rLhfju+Nx0Zy9xikJT5QjZ+uhsa71IEqm6gBWfL5dE908ywwoEtsJvZLi8iFpg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0c704c-7126-408c-fb18-08de3a1659ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 07:08:00.5608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: accFkkIllNxHz6Fivtw1ts3nfLs7Sw4PACGDCu9gPoZ5sKto3fup3sUmtVefH0ainUP6z1W1zUg7Ds8jbSZ1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR16MB6607

> +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<19) /* Secure
> erase/trim time is fixed regardless of size */
Maybe you could rebase your work on:
https://patchwork.kernel.org/project/linux-mmc/patch/20251128052011.204735-=
3-avri.altman@sandisk.com/
Which is expected to be applied in v6.19-rc1.

Thanks,
Avri
