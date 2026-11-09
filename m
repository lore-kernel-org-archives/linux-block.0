Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237242;
	b=VCF/zNWHbTy6lc7kE0GzZhNKVrtXDEifzCbQTooVRl4y5auuoArDIUFe5lPLGM7N1Q6I
	 iUnd4s7x9F4/tpybHOEjEEA0W9VDvQ9qASI7pKubJdVEwJAF1QV97GSECeXtjaAqwqAMP
	 xC+ynby2wICW7Gzcw27sRe+Bz6pcX+f952k6LQyCkEZuP7nrxlPX7YbLcQoaxH2M6+Xyv
	 HOce2Zy2WzIo7JJ+muE8wSmAKYtA+gR/AHKVkaPNawh5fS6YtHScSTC3t2sdL57NV7J15
	 9FjsOV37HuVhmzDnIGbyHGkcAIQ37RL9mqsXC5sMZZGY77/fKAfp1ps6ZNvbtZtMGhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237242;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BQKfqqFIW+XWKnskeiNVtv2CbvQX15ixpJt8mqa+ARQ=;
	b=3LOipka5P5OvwDO2AN/NQh++r+BJF0U9FFvrG3lkAb4DQ1mYE5EtRr1iD2jNKEagt56t
	 i5KsSFSqGq3u2/VYQjYkocgSnG/5pRN3OIAmXOfoxpbtWv0IQhp5N0nCUDbUBS1CCsW9y
	 7BiywsfP1BeD+6Tq0C44vcGaPd+6vGujnKmD9YTuQ3MTSPuGgz++qIQpsFsZwh4kgf5ne
	 g31oZtVJB60pkGlEnkBH5PXVRDDBhOLKQcCy8QRerlpKCKXSGgmFMXBixqG1yC2GSj69v
	 BZ5eE1FVy+YOMSSr4jTQX3HczhrfXlCAhfZ2W+ClAbTjzrzVRRo3V4r+DeUGY88r83A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=tek-up.de;
	spf=pass smtp.mailfrom=tek-up.de;
	dkim=pass header.d=tekupde.onmicrosoft.com header.i=@tekupde.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-tekupde-onmicrosoft-com header.b=iFkX1TZO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.117
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023117.outbound.protection.outlook.com [52.101.83.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC725606A32A;
	Mon,  9 Nov 2026 15:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC725606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tek-up.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tek-up.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tekupde.onmicrosoft.com header.i=@tekupde.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-tekupde-onmicrosoft-com header.b=iFkX1TZO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsrniidUMHwLBe9w4w9Nt02fMa20fdTzNd8lxslmai2iL1yXVzybAiofubt13f/MxUIAh+dG6VaG4AYUnGg7gAXKKsjK5fuVXSAQC6yR5KWrxZ+gU9Sk22nxyhyoYJllByLNdusiQPmllN36ZWisO9gWu2Ib1ZJ8RalgdT94Ku7KxBW7utnaq8G3sV3nki7PR9c1b05Jz283avaSVdpu0FlpAhU02LztjvFfzAaEjYZXZ32/SZ0lT73JS1lk9d2Lkvickt+/sShgJAyWpz9j3T3+9I7YhLupQVpXcp05c7FjiLFp0vJHRhEJrlqJZXMoyzrbHkdQU+XaU6PROQXmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQKfqqFIW+XWKnskeiNVtv2CbvQX15ixpJt8mqa+ARQ=;
 b=B7NE4mxa2qPZG8MPfOtP141S+Q/7IuOF3s9THPRiBG+4K24whQ+4gbsPu4dxQNXSzHzeGnmvq0ZHqfENAXMXHlXU01OCtBxN53F0UDNgH9sVv/jn7e5P3PXqE2w5weOvXx4ZFicXrc4KV4j9dlEtXaGIICALKu2PbnB2BX+ZlPwkmvXSvgFyWOHSsWIc09/jilWos783oYR8rYOEr3LEPUnlTPM1XagwvhdVM0AmlyyUj3IELxeCCCnO1FjAJwTd3d+b5Pzvu/j+nwoeSFkdWRAkWMsxC+p7uMolRVRJdDAvLO1TObt8nZHFPaGTrN4vpglXSWdUE7bfk0H37aB+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tek-up.de; dmarc=pass action=none header.from=tek-up.de;
 dkim=pass header.d=tek-up.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tekupde.onmicrosoft.com; s=selector1-tekupde-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQKfqqFIW+XWKnskeiNVtv2CbvQX15ixpJt8mqa+ARQ=;
 b=iFkX1TZOle4aRC5Vkp6vjCmeNTvnEe+jNyiZjtvYJuAEBFEYsZ96TfG6064nGfr3953tP8y2CbV5GpbDGZ1iW6Q4nJxtwwJLfH0VexbbNXznW9+565sdlKeamaHSSbjr/3TZ3oeib3skjls77rs6M71ZJEIG+jZuqvNW/3W+jc4LfKu6M532p7cI1WzLFOgtrMVraPjZ2LvSwhPXTKKDpYagZdmo5oETggpirQus4AjOqBRCSiaKG6yjakg+Nu3UpnD0tAL6Zera6B2JNIaktiXEucRZkCCNoWh6DYMsDPsvQBdDXZ7/R53bWIuKp6/wDapw2XHMOZ7V/gqL/Ytfxw==
Received: from AS8PR07MB7560.eurprd07.prod.outlook.com (2603:10a6:20b:2ae::12)
 by DU0PR07MB8490.eurprd07.prod.outlook.com (2603:10a6:10:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 15:13:57 +0000
Received: from AS8PR07MB7560.eurprd07.prod.outlook.com
 ([fe80::62d2:70e0:fdc3:d89a]) by AS8PR07MB7560.eurprd07.prod.outlook.com
 ([fe80::62d2:70e0:fdc3:d89a%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 15:13:57 +0000
From: Wael HASNAOUI <wael.hasnaoui@tek-up.de>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"usama.arif@linux.dev" <usama.arif@linux.dev>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>
Subject: [PATCH] block: order timestamp flag clearing before plug detachment
Thread-Topic: [PATCH] block: order timestamp flag clearing before plug
 detachment
Thread-Index: AQHdcFYyoG1mW+zVQEu1Cwt9IJObwA==
Date: Mon, 9 Nov 2026 15:13:57 +0000
Message-ID:
 <AS8PR07MB756032CE87F3CC0F35611CFBB0732@AS8PR07MB7560.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tek-up.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7560:EE_|DU0PR07MB8490:EE_
x-ms-office365-filtering-correlation-id: a4d961ea-4e97-47e1-2a58-08df3e7413b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|23010399003|10070799003|786006|376014|18002099003|6133799003|10067099003|3023799007|38070700021|5023799004|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261022115727099003|261021135927099003|261026140227099003|261009223027099003|261026121527099003;
x-microsoft-antispam-message-info:
 f625X4c1POxYGDPWU1cQqjnEtcofx2oc3wuJqor3AFl+0TEgtB5qqUr7qClrTO2yAaPT0f+9VYJAVRN7pCdqno5+ytY8aoo0MlKK+1o0f/y4EGgz/NgemzqC5i4FByKTq0BexPg2q4qLowA7sukHZVGzxtobPEg4M+bcNSbSI2GjQ9P7Y6ySqxcW2fFitwpGckykHQTLEbvaXBnqvso+PIc4fMHmxiAOpXsTW0EtcysJv78WH+QO/UJhtWuelkZLotxT+/qqmUQWJOF/ATKyOROKup0wTuA1WLu09KLM9KJj9uqb3I6oFuEwwb1qZdKbuYdZePK3f3NdSR3PU9/ToT9zzNlA04x+jTxs9tXh7zrdnVISB+dsXcWIw8ixvBWM0yh8sUe2pQ66o8801bo1Rta+0o8JaKH7NF5MnpvvYu/FqY7sPuKRVjOMCVCmvKQLCtKFWrGCG6uv0BWyfSFN2ArtRePLuz/nhC1LcwfW/mvkQC+dRWAroffpgMQLNIrNenUgZ2VJnjqgGIeUWGwI4q01q62nUvNsaT+Nt+GwwNALLz+7SugRilFpXYniAFXwhll8WRX6U2hNuJjvTrDNmNCcp6fM8wDL+zBkobrGOaMNG05LEFGxfPKOX5M6DNpbFmbGnqX1gleVRToPNz5ULvNJLfSUOadMJ2cwCrfIIBv0N1oYno6GskH6z8n9ZcXY+QuSSebP6toRcZ1ylHjRfv0wbnAQ7ZOVDvZC2unGjj4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7560.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(23010399003)(10070799003)(786006)(376014)(18002099003)(6133799003)(10067099003)(3023799007)(38070700021)(5023799004)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261022115727099003)(261021135927099003)(261026140227099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?snPE7fKjAUzOgHfF3MJ2PmtFKcOilRU/vSzP8m4XoG8Zr8Xp0B9KBNjn8x?=
 =?iso-8859-1?Q?WOLlEPuXz4zAPXDB2AWF4E8eC7gIqmPgzPymP61prrGMwdCA83u0pERukX?=
 =?iso-8859-1?Q?w5Zw/MEd/bjAa+pUmURO7XzQYFBzv+Z7qQrWnBJ+rJLBimvy/uOuXys716?=
 =?iso-8859-1?Q?AXFy7eKYKbNO9Ugk6n3wCPQ1jYlYBUSGocluA6sw6DW3m8Kys502+zzz/H?=
 =?iso-8859-1?Q?y1XOwi2NtuKY5kXfEz8eeEQapQPqV392OW137MgAI72uVDmf8+6LN6/J3A?=
 =?iso-8859-1?Q?0EN/WvTSjslzhdzt7GTvsE+90iJMTFKPNmWIkjB/BMFXIPTjAnbj+otFvu?=
 =?iso-8859-1?Q?NNetDiVXJLkCLCiExhEan8lw7MGXhDiVPEV/tyds2AMRYZ8OpZBzBLBxhG?=
 =?iso-8859-1?Q?36aFEuseNLidm3GUiFxS4au0kVfN5wRv07+ETrQPNqMslbpk7biPTTSg95?=
 =?iso-8859-1?Q?XDkzTZbLHgH436O9xJyhrthDW4KR0l/PcM3q8M2oyYW5Ohdp/oTsGP8Um2?=
 =?iso-8859-1?Q?phcn+mIlwcRnDT7MYvz98BK0bKO2XHdAaW1hYigGKmf/yEuYo+APGb8UxQ?=
 =?iso-8859-1?Q?x13wocZ/1E/CkrwWjTtxK3+4d2YjCu68HZ/DLX9iW47/4ZZ48G5yUMO0Z5?=
 =?iso-8859-1?Q?4Yx06T0TW5u9Oe+ujMGBY0xa4LVSHEdDrpHmz27+lzbBmE1ECrRnqSmU9/?=
 =?iso-8859-1?Q?CfHLFJCR8iu9CntdtuNa1MGxY6U0tJUdjU75ZjDav/Tvx53e1imeiKS7hn?=
 =?iso-8859-1?Q?bgEYLt/a+TcFZqvkZGa8bNGXaHpnpU1ZgFdCpXbXhdbsplV4uwMWoOwXOb?=
 =?iso-8859-1?Q?Ewqv6I4Dvr8d4DCG9onxrNly/6/noYGzJ+rPRE3o3Zeg3h9rW6IBIX3Yiy?=
 =?iso-8859-1?Q?c6zOCONU9Dbh2QC6/Urz2kbFywD3ieDXS/JvznqFjfGcHp8/jDriNsyy+w?=
 =?iso-8859-1?Q?KnYG3NiZ9EKLqEL4T/TJmDEAN6EmQIwbU9JIn5PbcMPDlXnn8ufwLMCoqL?=
 =?iso-8859-1?Q?dgPTUhAupbdXKc9JXUAoZOOwiStsQq3St1eXLmN6nBjOxQ5RSLBJO+Jnvu?=
 =?iso-8859-1?Q?tuSf/1zaMmdYQFeoPyHTd2Ny8DEmM0P7VEBOAunkTqkpk8lcd0+fsLq27G?=
 =?iso-8859-1?Q?1XswSE7+uOhU7/FJxAf4g2tthW/KTrZ3QKfiexgKVY6NF4/W0MqCIxVoRf?=
 =?iso-8859-1?Q?yHTG8y0EfLpNxISywG6jiuDohEXJlI6dyKCrAeOGlMDETPk8+EAJshyuqu?=
 =?iso-8859-1?Q?U1qgeRAXNWUpESEz9lt9nS9ryB4JZj14kDm+W2f+wqLbzlxehU9ET/nfvj?=
 =?iso-8859-1?Q?U3VfeZFV4y5m6irgzIzg+9v3uCZPAK4slC9aCNsoB8MRrDRJbZQn6KOJuS?=
 =?iso-8859-1?Q?JqakjQIHuRbG0bBGdrmMbKaM+flvMhcLQNOLXIWFsMSaqBqZXE3UtbZugl?=
 =?iso-8859-1?Q?4QVku2JRpjbmOW1i99VA32XresY2ZzT090U4pGdAXY/zlzm6rjs3ysg0KC?=
 =?iso-8859-1?Q?JZvwsFyn3FXQyRfFpD3y4CfOn05C5ojLXuMciFns6yJ1m4IhABnk0n6nQu?=
 =?iso-8859-1?Q?SneMof3i/HbgJUsOO48/xBLWtKC5puZ4aWEBS8HSCbOSNNMjd66FdIXXnd?=
 =?iso-8859-1?Q?YmbUE7Lss9TgJG9AIUavZv6Xt8OnDcLEUnud2Ol73susZw18ffbLkfPogH?=
 =?iso-8859-1?Q?qUPjBy+3tvBhN4dbfFcgyRt1hAq/H/NmH4kc9M1kK6zh0kBNSGXC0tkXt9?=
 =?iso-8859-1?Q?EVd0FG+Uh7bpcZH6wWUGavIYWidnYH++FUAs5YNbgkcDy7RkPWFecF0bB3?=
 =?iso-8859-1?Q?dmxkOhmCEnAv8w5cPg85NDa3OMfA5VW7AKrsz63CsTlteyIucGq2MyvN95?=
 =?iso-8859-1?Q?yV?=
x-ms-exchange-antispam-messagedata-1: nhQ3QzTvjr/27w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: tek-up.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7560.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d961ea-4e97-47e1-2a58-08df3e7413b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 15:13:57.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889cdbee-d881-42dc-bd06-ad3237c34a53
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TE2TNRBPenzL1KzyyweM90LGWHb4KCpFqqZdBF4u8mEeq7oQIbo/ympB9TFoPtJ6Zek8oE9G9LVdMRP2B8UVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8490

From: Wael Hasnaoui <wael.hasnaoui@tek-up.de>=0A=
=0A=
blk_plug_invalidate_ts() runs when a task is switched back in and assumes=
=0A=
that PF_BLOCK_TS implies a non-NULL current->plug. blk_finish_plug()=0A=
clears the flag through __blk_flush_plug() before detaching the plug in=0A=
the source, but nothing prevents the compiler from reordering those=0A=
stores when the flush is inlined.=0A=
=0A=
An arm64 kernel built with Android Clang r596125 and AutoFDO contains=0A=
the following sequence, where x19 is the plug and x20 is current:=0A=
=0A=
  str xzr, [x19, #0x20]   // plug->cur_ktime =3D 0=0A=
  ldr w8, [x20, #0x54]    // current->flags=0A=
  str xzr, [x20, #0xad8]  // current->plug =3D NULL=0A=
  and w8, w8, #0xdfffffff=0A=
  str w8, [x20, #0x54]    // clear PF_BLOCK_TS=0A=
=0A=
Preemption after detaching the plug but before storing the cleared=0A=
flag exposes a NULL plug with PF_BLOCK_TS still set. When this task=0A=
resumes, blk_plug_invalidate_ts() dereferences NULL before execution can=0A=
return to the pending flag-clear store. This explains a recorded write=0A=
fault at address 0x20 in the scheduler's timestamp invalidation.=0A=
=0A=
Add a compiler barrier between the flush and pointer detachment to=0A=
preserve the invariant across preemption, including when the flush is=0A=
inlined. This needs compiler ordering between accesses by the same task,=0A=
not an additional hardware memory fence.=0A=
=0A=
Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after task sw=
itch")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Wael Hasnaoui <wael.hasnaoui@tek-up.de>=0A=
---=0A=
Based on Linux 7.4-rc2 (7475ea8b58616b33c04afb976cf0fbaad9dd63fb).=0A=
The same code is present in Android common 6.18.38.=0A=
=0A=
Validation:=0A=
- The unsafe ordering is present in the installed arm64 Image. Its entire=
=0A=
  blk_finish_plug() function matches a symbol-bearing reference ELF;=0A=
  the whole-build IDs differ, so attribution used that byte match.=0A=
- A focused compile of unchanged Android common blk-core.c with Clang=0A=
  r596125 and the public GKI AutoFDO profile reproduces the ordering.=0A=
  With this barrier, the flag-clear store precedes pointer detachment.=0A=
  Both compile without warnings under Kbuild's normal warning policy.=0A=
- A bounded model of the actual instructions reaches the recorded 0x20=0A=
  fault from a valid state at two interruption points. The corrected=0A=
  order passes all 64 combinations of the tested switch boundaries.=0A=
- The patch applies to both the mainline and Android common source.=0A=
  Checkpatch reports no style issues; the absent local Fixes history=0A=
  was checked against the public commit separately. DCO sign-off is=0A=
  pending the author's review.=0A=
=0A=
This is not a full-kernel runtime reproducer. A full mainline build and=0A=
on-device validation have not been performed. The saved panic does not=0A=
retain the interrupted PC, so its precise historical interleaving is=0A=
inferred. Supporting compiler/model evidence is available on request.=0A=
=0A=
 block/blk-core.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/block/blk-core.c b/block/blk-core.c=0A=
index 8836c70..99f79bb 100644=0A=
--- a/block/blk-core.c=0A=
+++ b/block/blk-core.c=0A=
@@ -1299,6 +1299,12 @@ void blk_finish_plug(struct blk_plug *plug)=0A=
 {=0A=
 	if (plug =3D=3D current->plug) {=0A=
 		__blk_flush_plug(plug, false);=0A=
+		/*=0A=
+		 * A preempted task invalidates its cached timestamp when it is=0A=
+		 * scheduled back in. Keep the PF_BLOCK_TS clear above ordered=0A=
+		 * before detaching the plug, including when the flush is inlined.=0A=
+		 */=0A=
+		barrier();=0A=
 		current->plug =3D NULL;=0A=
 	}=0A=
 }=0A=
