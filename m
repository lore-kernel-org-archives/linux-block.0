Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012084.outbound.protection.outlook.com [52.103.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F954766A3;
	Tue,  1 Sep 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255750; cv=fail; b=KFPb9+ttUTQJzxN3bJV6CLX8eWDTmpGPTybXMDY0Tg1MUy7Ku6YiIILhAptE2CvLYDjrSyTSGlSkUn0TbCvdl6byOmS0gp/KNgYeL6e/vIAT2DqyOA/HB8pUH8PLHkgtXY1CiiN0c5goma2mObdSa9fX4K1Sq/Zr1V6JOO8QhSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255750; c=relaxed/simple;
	bh=c6iV2mG7XDnGt2TUuM9YylRNKUq1bTUTRUSduuQBVxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pA8dVnUAsqepfK517QhOCoZ4KKlLILTnaZTItunw0PGnbQ3IcCbaSAqx2PbYgmd22SNgL20JWu2ZftzgqTe+1SL30vZwIHZn5WJ0xbFqE90uA6LWuS9/x+zQjaUwXTIMrKoP44CE7wCHU9ZdI42Ck0ZsekPSIDehdVd9QuF7xQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GuHMw5eR; arc=fail smtp.client-ip=52.103.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GuHMw5eR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7y/b8v2YjMv8EtRDF37JHwwJr+Kzfb3BbstiWMz9c/A8cKoTwwwjRI2tSx3wVbAP3g8l2wyP+b6Jz7Ah7KR/SzUgs8wCiPx92TdX3WYACa4Fg9M1MPnADvgg49W5SGoBun3ICB8BwOkeI95n3/EEn8cAvGyxgw1tMG8A+YJJ8RgwBCW3Zi5buw/ThrsYdjtp+DX5ABlJ1PByIT9jP3GuPAXYqifiCZTkGqKcJz50wk8GhMedkv+e3nPQPhvKgRIt2oG68BJJ1zsMYLiPRHg0fzLAcA47k9EN3N4K3wJUf0A+pMPsDtJhlyjHMmqC3keYJpTAfRuENInsd+jTR2q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6iV2mG7XDnGt2TUuM9YylRNKUq1bTUTRUSduuQBVxA=;
 b=fJ1CLoP4cUpG8nHyZidKnCL+o/9IDpD6y0UmdGtdwFfnMTCCxBmZwlk6ZQh1fpBwbCTvY1B73UEn6QpK78a0qTPGJdq8Z4Vd/IvaN6k99ORk2orzfm8PLdCsxIQy7yy2Vz72JF6B3JaVl2MSz88Bhnjh7yN6RVHHdz8eMIvcIhsPJhxRRXD/abFGBotOrKe80riltDz94ostg2Z6GJWIGC6QduQZCCXE3Kxf7bpaITk1cVNx5l22qbG3Qr2tdwCRsG/chI7k80id5e9h+p2kE8vcoQVXJu7kXe6zk/1JBGbc6/059E4JSskvf+JhC/30ls5ZWD2zuxakmfenNWJptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6iV2mG7XDnGt2TUuM9YylRNKUq1bTUTRUSduuQBVxA=;
 b=GuHMw5eRRPFan5i4AxrLeRyxi/t7WW0dGu5Lj64H44lOKMahV4tKsDG2Ck5o1X57wes+b4sLyjlOOO4pusgiBu79veRmrHSfXw1sI9ygDo1cy9SN/nNOP8ReInAlgxHitlyf7tVBJ3DhGoNf3d8cACG5mFJpHze4rmGQzK0DsCt9KO/qLadh1Co2w7Yio3/tFpgO1Puu0WpTiQ2UBoAfzEEXnGfhCfRnw8N+xyl1plKxfJi50y9TMybZd2riXEASSiLtvq5NEI2hFhcBrgkvenvQws682HEdQc/GMZBHOQzBHY1S5xIfymEyCVY9tBVRzWN5VNUqlmNjt0pOhiGAVQ==
Received: from SN7PR07MB9708.namprd07.prod.outlook.com (2603:10b6:806:32d::7)
 by CH0PR07MB8945.namprd07.prod.outlook.com (2603:10b6:610:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:42:18 +0000
Received: from SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c]) by SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:42:17 +0000
From: ai qubits <aiqubits@hotmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, Sophon Z via B4 Relay
	<devnull+aiqubits.hotmail.com@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?B?T251ciDDlnprYW4=?=
	<work@onurozkan.dev>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHJ1c3Q6IGJsb2NrOiBGaXggR2VuRGlza0J1aWxk?=
 =?utf-8?Q?er_block_size_documentation?=
Thread-Topic: [PATCH] rust: block: Fix GenDiskBuilder block size documentation
Thread-Index: AQHdOPt9FzRSXJq6QkquH+B3Q4UPHLa4He6AgADaE/2AAIIq/w==
Date: Tue, 1 Sep 2026 09:42:17 +0000
Message-ID:
 <SN7PR07MB9708FF3A9D85C916DCA66561CFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
References:
 <eqzS1cYG2bYJ10oFrfX_D7UVNqb_NuK3wsMUUEXpdBj7yCtzD24WOzI8zIKg2FlD04VFp_R9xt65fGmEqpt6QA==@protonmail.internalid>
 <20260831-fix-gendisk-block-size-docs-v1-1-900546005799@hotmail.com>
 <87ld9mxxec.fsf@t14s.mail-host-address-is-not-set>
 <SN7PR07MB9708ED760C7DDF833BEE80E1CFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
In-Reply-To:
 <SN7PR07MB9708ED760C7DDF833BEE80E1CFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR07MB9708:EE_|CH0PR07MB8945:EE_
x-ms-office365-filtering-correlation-id: 78525c3f-902a-48c8-546a-08df080d4fce
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/7Sp+WbupuUgOmQrdMtx8UvXVqh03C5p6XOcT2I5waFbCIhAI6AFi78APOdrFFpLpJBnvcL7NDD/towVrRQPqBR8VPKnJd+SkQ2TpBBliXMHGSfQMntNV864tWAAG0z0rCpcHrq1JDl3pA1mVgTeKZ8HHaewXa+cDt0DCfxdxVcZQm/C57i+chZFVd/0nXnbHK0OuivBpoDLaBv/S5y2hm7FGg6Z1NCYdTKYuLRdypb5J06C7KrGrsVmPp/tcDhL47VK6zVqlWEw0tSc/zgyUQgchwxhPH0IVB21mypd6vlRFu0GHNcqsZkDhhDaaLL2AYQ5MUifDOzmQNYPu88GryLnGT3tqSMBiQwcAN2nmp2SpiQhkvdIB2SHBczn/B6Qk94WjJtnuetUiGzdS69W2GhlpzOWNKHR0n/K33hPxbWiqqCiME/IDcnSG4xoyEr1ybNvDbCmgJqrMATIYJtBJ4mTLcYT15eou3pqQ/cGg9VN3MXeBpIEncQmN7c3sH8G8GUHlAMLSDzHnC5v2mrEDeUczUOEpHv/FFNydD+i4pyGSjC2ZsOX19RJEmkmSnZZvNPVUsBW8UOYo1M7V0KuF8LX1D7dFeNJKe78h3wBT/C8Hh20CCYDo2xTypAoOlvCzgttuWs10SGBq4eCmSacuE3PGrikT4Z5iqvKYebE4XYRrf1OWDg3/dQIvR32lauZnTI80PWCTn254YsinJBdPcprQZfITC2hN
x-microsoft-antispam:
 BCL:0;ARA:14566002|45011099003|24121999003|22091999003|12121999013|15030799006|7042599007|8062599012|8060799015|19110799012|31061999003|51005399006|15080799012|6140399003|40105399003|26121999007|2607281247196008|3430499035|12091999003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTZpQlNTVkpMaXQvVXBBT3FSL1lySnB0SEI4TVBBTEczemR6eU1NTG55SVV4?=
 =?utf-8?B?MmVTcTJSSTFKYjhvcERnUlk1ajVwZDl4MTJZSExhS1JhUDkwV2RwU0crRGxq?=
 =?utf-8?B?c2VGNk1DSWY1V3hJc1lyWUFhM2hOcG5MMEtrZGo4SE9idnZPdmlpMkNPbVFX?=
 =?utf-8?B?N2lHZTEwWHdWU1JJYWdiYWRpWmZPVm9mRk5pN1pPTE5RZ3ZPL3phWFdGcExQ?=
 =?utf-8?B?ZVJ5MDc1L0N5YUUzamh4NjQ2clRVZGw5a0h2d1Y0ZEpZREVKNW55ZGJmdUR6?=
 =?utf-8?B?U1RnRlZzbVJjUEd1VHk3QkxKbk5VZUEzKzlpNjgrbURnbFN6cm01bXpGUzUz?=
 =?utf-8?B?NVBnZUU1Um9DaUxhMVU5RkRHVFh3aHpBMHZaWFhITGwzOGZDQytEUDVaOUc1?=
 =?utf-8?B?eTFDWEVxNk94QXdtZm5mR0lTekp6UnJ1dURZaFk1QlJnNHNlV3Fxc0ZhMGhv?=
 =?utf-8?B?YWpCWm44VHFpdi9OYTNrNXJUYlNsc0dQN3dQdmdyT215WHdtc1pSZGc3L0RB?=
 =?utf-8?B?NHdzWlhYUEVPQnJEb3gvblA5WVlFWjdramNzT3BYaWNKWkw1akQxWUR2anJM?=
 =?utf-8?B?QUFhb0x5MFlNcUhXbFQ1clAxQWxCUG1DSE5hNDQraVRoNGIxZDBDTWttSE5S?=
 =?utf-8?B?dm9udjNWOGkrZm5BQXVFci9VajJUb1laU3cvMkJydXZFdGtOVDFTU0hLN2M0?=
 =?utf-8?B?Mjl6aGVvbzhFSmJ4M1Y0Y1RtSTR3YmZFUzRURFg2Y2o2QzRhUk1vcS9GK2Mr?=
 =?utf-8?B?L0xLRmJyVlNWM0F5MlQxKzRrTE00TTlqSmw2Uy9kd1lRZWhnaWk0Y0lCc0kz?=
 =?utf-8?B?TzdGd0xqVnRLSUpEUHpibElmZERvY0lKNnhpYnlKL2NNa1dORVJPYmVPbWkw?=
 =?utf-8?B?L0hJeXQrWEZmRHBzVGZ0Q3VYODB6b0ZnZlNDd2VUcnFHZzV0am95S2h5Wkk5?=
 =?utf-8?B?SmlkV1kxMTFDbFFxUVI3ZDFoVHpRTXAvaUlUNFVxejZpOC93T1JrSklvWmlp?=
 =?utf-8?B?WFhLQ3owa1hlb0VIdnZQS1p1bWhxUFdXSXZCYjJMa3JZT0krUHJlcGduRWU5?=
 =?utf-8?B?Y3JWTm80a0c3R25jYlF3M01BOVlPZlBYL1VhZjFlY0hWclNvY25rNnI2cDNW?=
 =?utf-8?B?OXdLZFpESGNUSHRLTHdwQjdkeUJXNGxUWE5OeTNNTTBkNE5XNDJrak9RYS9L?=
 =?utf-8?B?RjF6M3FIRzVmM0hwejRoWUVGenpScld6VTlKandZZUdXVXVISUxzMHNKeGdY?=
 =?utf-8?B?cHlVem5mbFZySWNReVFUUktmZXdtcTcwclNub3AzVVB3ZTlSSGsrUkttQjFW?=
 =?utf-8?B?ektZWmNoR05YbnBKS1BKOURITVFQZDRSQUY2SDEraVoxak5QUlNzS0FVcGdn?=
 =?utf-8?B?c2drcUEvY05qWE42bG1jNWxzcjRQRkkwZVVCdkZZUDFra29EK1BiZW4xc3Ir?=
 =?utf-8?B?MUIvRWlVWXNaYXpVeHBLQSt2RWJEZ1k1aGYySFQ4RTZNTVRMdmVMN0pkWWEv?=
 =?utf-8?B?M1p3Mmd0d0cxN1NxSW9tU01zakFZVDB4UC8zQXZIdmdHTHBFYzBLemUvVFZs?=
 =?utf-8?B?Vmh4UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEQ3N3FXc0YzTlRRNWI1UU9mV1hLL01VZkdpZEp6d1RYZXc0RUkxVUU0NWJu?=
 =?utf-8?B?aUZDVHE5T1FUcWd4cWdQWHB0cG03Wkp2Qmx5Z1pGdmlJeGpiMDZVN2RGYzRX?=
 =?utf-8?B?Sk9WT2NNNStYNU9samVZUlFPZkkvcmN4eEN6M0Q1S3JBdisxTyszQXQ0WTd1?=
 =?utf-8?B?SWg3aUJFRzF4T25TRFgweEFrUlJNOXNwR2NpbVdhSEV5VFRmc21nQXhyYi9T?=
 =?utf-8?B?V3QvVVhsdzdOWTJ1TXM2UHZuMURGejZucXI2OHFHZFNEUVJmMXE3WTU1Z21t?=
 =?utf-8?B?QVhCUHhPWFZURS94dC83RDN4NVkwbjJhdTgxMEVvc3JLcU9tT3J6TGYzbEVY?=
 =?utf-8?B?TklEWWRRYURTVHU1Vmh1VnpneGFVaVVtWW1mOTZ1YmNkdmU4ZkJZM25RZUdw?=
 =?utf-8?B?Mk1wODRhazl5OUlQTjlhTWVzWGdIaVp5OFJnY1VqQ0FnY2tRdFJTaDBBcGEw?=
 =?utf-8?B?Y2MwUTFCSnRER0FvZVFPLzVFMEN4UFVMK2hxaGJmL28vQUF6SkF2dGZOeUhR?=
 =?utf-8?B?RTJwc3ArU1ZJSDJqMjNOQ1lDWkN1ZFFxem5xNFdpTno1K3J6cU1ZRGV0Z2Za?=
 =?utf-8?B?cy85UGx6VHc3SmFiZWFPT01OeURGUFV3VitIdFFBL0paZUlCbmF2ZFJhTVpZ?=
 =?utf-8?B?SzFnYU5oZFJ6RXJkODl5TG13WENmS25zU1hpeTI0QzgvR2RkUk9FK3U3TGJn?=
 =?utf-8?B?NkdjcG9lalE2QlQ5OW9EOUprVEQ3dzhmNUtrVTVYemU2SlB1N2pYUFRrZkd6?=
 =?utf-8?B?eVdmR0RTMmNGY2JVMjhTbDg0VFcvM2ZvaXFXZ2Y5UThHbXF1M0hjcVRuL0Yy?=
 =?utf-8?B?RnNrcmMzMkpjUS83UFM2WFB5UEZxZDl2Mjc0YTU1ZFI0SXBvaU0zMVlpbWt5?=
 =?utf-8?B?ZDQrUFk2WFVrLzRDb2trQ3AzMmxiU3pXeVJFdk4xZWZxK1Z2a2FvdTFCTTRI?=
 =?utf-8?B?ZGoxVlVYYjdTMUhjZFUrSWtvNXEyY0poZzNUWFA3NnZZOGNSR3BJb0tOVzg0?=
 =?utf-8?B?R0MybVlrQVNGaThMVFdRbTRRRzh0dVMxOExDcVFIcmd0aVhvaS9XYmV1ckhY?=
 =?utf-8?B?dVkxSjlFcWl6djY3Q3FRZDNyR2djSEJTT3J2UHVZN0JLeEhkejdqUjA4Rkho?=
 =?utf-8?B?REhwZW9xWlg0bC9XZ1haTzBqWHkyR3Z4WCttQ2Q2cExPUDg1enpNcGVUUmtq?=
 =?utf-8?B?Wll1ZVBnZ1QwVlc2RjV5cmRzYlVFMVBEL0JEQ3ExelF0eXVhSVV3OHl5VHRX?=
 =?utf-8?B?QW8vM0toOERxMDN2TWdoUmlTVDdzbmovdU9oNjc4Zmo1OEJBNXEza0ZtNUtu?=
 =?utf-8?B?dFJyTmVGK2hKa0t6Y244cjFNbGZGeUdoNEtTb3dac1orNkIzSGszZmJGRFlE?=
 =?utf-8?B?QmpBVUhzMmxDNDYyd1hpT3d1MWxvRDR3SVRHaVQwKzBnWko5Y0dKamlBQ1dU?=
 =?utf-8?B?SzVmWHQxbGx5dWV6dUxwRkYwNXBOSHBUWnRtcy9wcWd2VktMamxnYVIzTldQ?=
 =?utf-8?B?QkFtVUgyb0tOdHRsQW9BUnJSYWQrRHZ0NC9SalU5UTd5NCtyRzNNeEswR0V5?=
 =?utf-8?B?NnAxSDVkYmNqb3QvUm9IRmk4NjRxaXJZUmlwTXhNK2tNKzVIdkFFaVNWM0hp?=
 =?utf-8?B?ZjlWSlFqTFdFMUFnQVlVRDQ2YkhjK3U4ZXNOOTR1dTUxOWlkMVhkMmQ3ZFF3?=
 =?utf-8?B?MjBRTDkxN2NUbzFRMUwraXZNdGRXc09VbnlCcjB1UlBBNzRKSHJFOXpFRGU4?=
 =?utf-8?B?SWVydU4wNG1OM1lpNWRKVWo0amREMDl3UXFGQmZUc24zYVdlNHkyQ1kzUStO?=
 =?utf-8?B?VHplRUFOYUZUdDBKYUF3djFKcDJKSVRRbmt2ckRDWk9xSUU4aFQ2Z2Uyei9K?=
 =?utf-8?B?ZjJhalpmc1hFbjhhQXd5eUsreHNTN2NObVhMNWVuRDRTanc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13ed7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR07MB9708.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 78525c3f-902a-48c8-546a-08df080d4fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 09:42:17.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8945

VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCB0aGUgQWNrLg0KDQpVbmRlcnN0b29kLiBJIHdpbGwg
bGVhdmUgdGhpcyBkb2N1bWVudGF0aW9uIGZpeCBhcy1pcyBmb3IgSmVucyB0byBwaWNrIHVwDQph
bmQgcHJlcGFyZSBhIHNlcGFyYXRlIGZvbGxvdy11cCBwYXRjaCBhZnRlciBpdCBsYW5kcy4NCg0K
VGhlIGZvbGxvdy11cCB3aWxsIGFkZCBhIGhlbHBlciBpbiBydXN0L2hlbHBlcnMvYmxrLmMgZm9y
DQpibGtfdmFsaWRhdGVfYmxvY2tfc2l6ZSgpLCB1c2UgaXQgZnJvbQ0KR2VuRGlza0J1aWxkZXI6
OnZhbGlkYXRlX2Jsb2NrX3NpemUoKSwgYW5kIHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiB0bw0K
YXZvaWQgc3BlY2lmeWluZyBhIGNvbmZpZ3VyYXRpb24tZGVwZW5kZW50IHVwcGVyIGJvdW5kLg0K
DQpCZXN0IHJlZ2FyZHMsDQpTb3Bob24NCg0KLy8gUmVhc29uIGZvciBSZXNlbmRpbmcNCg0KTm90
ZTogSSBkb24ndCB0aGluayB5b3VyIG1lc3NhZ2VzIHdpbGwgYmUgYWNjZXB0ZWQgYnkgdGhlIG1h
aWxpbmcNCmxpc3QsIHNpbmNlIHRoZXkgdXNlIEhUTUwuIFBsZWFzZSBzd2l0Y2ggdG8gcGxhaW4g
dGV4dCAtLSB0aGFua3MhDQoNCkNoZWVycywNCk1pZ3VlbA0KDQpIaSBNaWd1ZWwsDQpUaGFua3Mg
Zm9yIHRoZSByZW1pbmRlci4gSSB3aWxsIHJlc2VuZCBpdCBpbiBwbGFpbiB0ZXh0Lg0KDQpCZXN0
IHJlZ2FyZHMsDQpTb3Bob24NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0K5Y+R5Lu25Lq6OiBhaSBxdWJpdHMgPGFpcXViaXRzQGhvdG1haWwuY29tPg0K5Y+R6YCB
5pe26Ze0OiAyMDI25bm0OeaciDHml6UgMTA6MDANCuaUtuS7tuS6ujogQW5kcmVhcyBIaW5kYm9y
ZzsgU29waG9uIFogdmlhIEI0IFJlbGF5OyBCb3F1biBGZW5nOyBNaWd1ZWwgT2plZGE7IEdhcnkg
R3VvOyBCasO2cm4gUm95IEJhcm9uOyBCZW5ubyBMb3NzaW47IEFsaWNlIFJ5aGw7IFRyZXZvciBH
cm9zczsgRGFuaWxvIEtydW1tcmljaDsgRGFuaWVsIEFsbWVpZGE7IFRhbWlyIER1YmVyc3RlaW47
IEFsZXhhbmRyZSBDb3VyYm90OyBPbnVyIMOWemthbg0K5oqE6YCBOiBsaW51eC1ibG9ja0B2Z2Vy
Lmtlcm5lbC5vcmc7IHJ1c3QtZm9yLWxpbnV4QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiDlm57lpI06IFtQQVRDSF0gcnVzdDogYmxvY2s6IEZp
eCBHZW5EaXNrQnVpbGRlciBibG9jayBzaXplIGRvY3VtZW50YXRpb24NCg0KVGhhbmtzIGZvciB0
aGUgcmV2aWV3IGFuZCB0aGUgQWNrLg0KDQpVbmRlcnN0b29kLiBJIHdpbGwgbGVhdmUgdGhpcyBk
b2N1bWVudGF0aW9uIGZpeCBhcy1pcyBmb3IgSmVucyB0byBwaWNrIHVwDQphbmQgcHJlcGFyZSBh
IHNlcGFyYXRlIGZvbGxvdy11cCBwYXRjaCBhZnRlciBpdCBsYW5kcy4NCg0KVGhlIGZvbGxvdy11
cCB3aWxsIGFkZCBhIGhlbHBlciBpbiBydXN0L2hlbHBlcnMvYmxrLmMgZm9yDQpibGtfdmFsaWRh
dGVfYmxvY2tfc2l6ZSgpLCB1c2UgaXQgZnJvbQ0KR2VuRGlza0J1aWxkZXI6OnZhbGlkYXRlX2Js
b2NrX3NpemUoKSwgYW5kIHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiB0bw0KYXZvaWQgc3BlY2lm
eWluZyBhIGNvbmZpZ3VyYXRpb24tZGVwZW5kZW50IHVwcGVyIGJvdW5kLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpTb3Bob24NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrlj5Hku7bkuro6
IEFuZHJlYXMgSGluZGJvcmcgPGEuaGluZGJvcmdAa2VybmVsLm9yZz4NCuWPkemAgeaXtumXtDog
MjAyNuW5tDjmnIgzMeaXpSAyMDo1NQ0K5pS25Lu25Lq6OiBTb3Bob24gWiB2aWEgQjQgUmVsYXkg
PGRldm51bGwrYWlxdWJpdHMuaG90bWFpbC5jb21Aa2VybmVsLm9yZz47IEJvcXVuIEZlbmcgPGJv
cXVuQGtlcm5lbC5vcmc+OyBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+OyBHYXJ5IEd1
byA8Z2FyeUBnYXJ5Z3VvLm5ldD47IEJqw7ZybiBSb3kgQmFyb24gPGJqb3JuM19naEBwcm90b25t
YWlsLmNvbT47IEJlbm5vIExvc3NpbiA8bG9zc2luQGtlcm5lbC5vcmc+OyBBbGljZSBSeWhsIDxh
bGljZXJ5aGxAZ29vZ2xlLmNvbT47IFRyZXZvciBHcm9zcyA8dG1ncm9zc0B1bWljaC5lZHU+OyBE
YW5pbG8gS3J1bW1yaWNoIDxkYWtyQGtlcm5lbC5vcmc+OyBEYW5pZWwgQWxtZWlkYSA8ZGFuaWVs
LmFsbWVpZGFAY29sbGFib3JhLmNvbT47IFRhbWlyIER1YmVyc3RlaW4gPHRhbWlyZEBrZXJuZWwu
b3JnPjsgQWxleGFuZHJlIENvdXJib3QgPGFjb3VyYm90QG52aWRpYS5jb20+OyBPbnVyIMOWemth
biA8d29ya0BvbnVyb3prYW4uZGV2Pg0K5oqE6YCBOiBsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5v
cmcgPGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZz47IHJ1c3QtZm9yLWxpbnV4QHZnZXIua2Vy
bmVsLm9yZyA8cnVzdC1mb3ItbGludXhAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFNvcGhvbiBaIDxh
aXF1Yml0c0Bob3RtYWlsLmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSF0gcnVzdDogYmxvY2s6IEZp
eCBHZW5EaXNrQnVpbGRlciBibG9jayBzaXplIGRvY3VtZW50YXRpb24NCg0KIlNvcGhvbiBaIHZp
YSBCNCBSZWxheSIgPGRldm51bGwrYWlxdWJpdHMuaG90bWFpbC5jb21Aa2VybmVsLm9yZz4NCndy
aXRlczoNCg0KPiBGcm9tOiBTb3Bob24gWiA8YWlxdWJpdHNAaG90bWFpbC5jb20+DQo+DQo+IEdl
bkRpc2tCdWlsZGVyOjp2YWxpZGF0ZV9ibG9ja19zaXplKCkgYWNjZXB0cyBwb3dlcnMgb2YgdHdv
IGZyb20gNTEyDQo+IHRocm91Z2ggUEFHRV9TSVpFLCBidXQgdGhlIGRvY3VtZW50YXRpb24gZm9y
IGxvZ2ljYWxfYmxvY2tfc2l6ZSgpIGFuZA0KPiBwaHlzaWNhbF9ibG9ja19zaXplKCkgc3RhdGVz
IHRoYXQgdGhlIG1heGltdW0gaXMgNDA5Ni4NCj4NCj4gVXNlIFBBR0VfU0laRSBmb3IgYm90aCBk
b2N1bWVudGVkIHVwcGVyIGJvdW5kcyBzbyB0aGF0IHRoZSBkb2N1bWVudGF0aW9uDQo+IG1hdGNo
ZXMgdmFsaWRhdGlvbiBvbiBhcmNoaXRlY3R1cmVzIHdpdGggbGFyZ2VyIHBhZ2Ugc2l6ZXMuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IFNvcGhvbiBaIDxhaXF1Yml0c0Bob3RtYWlsLmNvbT4NCg0KQWNr
ZWQtYnk6IEFuZHJlYXMgSGluZGJvcmcgPGEuaGluZGJvcmdAa2VybmVsLm9yZz4NCg0KQEplbnMs
IHBsZWFzZSBwaWNrIHRoaXMgb25lLg0KDQpAU29waG9uIEknZCBsaWtlIHRvIGNhbGwgdGhlIEMg
c3RhdGljIGlubGluZSBgYmxrX3ZhbGlkYXRlX2Jsb2NrX3NpemVgDQpoZXJlIGluc3RlYWQgcmVw
cm9kdWNpbmcgdGhlIGNoZWNrLiBGZWVsIGZyZWUgdG8gYWRkIGEgcGF0Y2guIFlvdSBuZWVkDQp0
byBhZGQgYSBoZWxwZXIgaW4gcnVzdC9oZWxwZXJzL2Jsay5jIHRvIGJlIGFibGUgdG8gY2FsbCB0
aGUgZnVuY3Rpb24uDQoNCllvdSB3b3VsZCBhbHNvIG5lZWQgdG8gdXBkYXRlIHRoZSBkb2N1bWVu
dGF0aW9uIGFnYWluLCBhcyB0aGUgQyBmdW5jdGlvbg0KaGFzIHNwZWNpYWwgaGFuZGxpbmcgd2hl
biB0cmFuc3BhcmVudCBodWdlIHBhZ2VzIGFyZSBlbmFibGVkLiBJIHdvdWxkDQpzdWdnZXN0IHRv
IGp1c3Qgc2F5aW5nICJjaGVjayB0aGF0IHRoZSBibG9jayBzaXplIGlzIHZhbGlkIi4NCg0KQmVz
dCByZWdhcmRzLA0KQW5kcmVhcyBIaW5kYm9yZw0KDQoNCg0K
