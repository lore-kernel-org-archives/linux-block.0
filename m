Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5928B514
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518775; cv=fail; b=XlTqR2bPtfyeH76huRZeGmCBbx/asfZD+yER6VTbERA9wjS9MoHnuuuyepZQj9Pyf/gEvz/pNsk0hpFF5jvoczAXs/ldu+n/8eZB77zQXMFIq2o1s3+eRyP7dGoJAtfZLdKYew/f2diporYxn9SOeegDamiPcCOzfFh9RuUFEZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518775; c=relaxed/simple;
	bh=Yu99nDxBTgRpsSglHBHdauMR0huMojZo4bzMe4zMn4k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=auBAx4r3Ea/+1ibhh3fbRiWy+3Qbfkvc/LZ3U/HOFc6RzPbafKLwFdWt1puLU9SXkaoPTaq1FGGin7rBYU+Ld+tZ4owk1D9Z32/SXJfg4+5uMGZZwdFClY/isXV7ENVx1eE0W9QDImJgw/60Np5TaYCLEvDt+Q/Lay3mS0qE3ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YA4sCpJf; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YA4sCpJf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5kwaU01+dkAW8yQDCNKbEnVivm1sVyWgZrX55oshV+rETIBErpvKkYm8OzxjQPaXUxyZ33G3lauHEVYfITmtdYexTzYwpyEdCupzZvFh9N6I5PxTPJu+wWF1CyMOS1SOPySjDKoeSX+arH5skTvdrxFE6kBN0BetNdEifc94JBpbhz2X9+tfL0FtX+e2kH3Shl1EZpIuDxpIL+c7sb/P6SJ6dn3lzaKfNhgkUkB7/Nb3jDtsKvOO1MuYqNtnqkDI3iIItt8WgT2ksJp9r24NRzu2hKM5qBYp+ixKH9a9XpsWFGSOm0OvUH5NICUHkDoMyKEeUlfcsNKmRigD4rDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7sorJYy2K8HnCdgGdouMPSIJEuDRgTJP5qXriihV9c=;
 b=uyy5dE0PxCfz7fBBYris1kIiU++yjAyVHMdPg2Zf1KFYM04p+pxoNlwQgWyJ+oo/y0X+fekagYpxHxiqyEkcA7K5ywB97zsny4ybujVX/Ia/f62JM4Lrljh7YzNRcPfMey5SHiBw158hZzNpM9Q5hXLtimUgr786yb357/+pviHaE/FCFNcIVnxdtwJZdrSNr/Lm9WgHYLP49hrSx8nbaudazd2ZlhZ5GJpzvruoGwgu/u+R0j4MW0qxY3cWeNjTpu0g80XS1UztCqwRXIc+qUfX1VKG6diVvtcrf3RJvShq/0gEsDp4O6yVFkcQbw+nIw676g/OYyjRZQN7cBNPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7sorJYy2K8HnCdgGdouMPSIJEuDRgTJP5qXriihV9c=;
 b=YA4sCpJfQojyIdMFguIcy2wgt2iogDfvfnaCsIqT52N1q7WmyCO0F5T0nxqco7V340K/dpSvaweGmfAtTB0YeJPJ/SyMuCHyFgZqP4RWT8c9CNifyk4fl7wF+UDwuNIommiQ5I0fzkDG0ulYZeiNVI9Mj1xprYCQnaU/1sBjRWNcyTxaogStVeJ/1zcSJviJ3Mg/DOe/pcYyIawYV6fArzy+HZtSFbpyJ8arodiLrF3iOurPz+46hOQU9NE/8I775QPyonwJuwshgCB2How2TTcd6ECli4sFScAIXsqS11hwOx3YOW9z3ygkRYHh4ebDud46wBxlrrFSGhubO03htg==
Received: from IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 18:19:29 +0000
Received: from IA1PR12MB6067.namprd12.prod.outlook.com
 ([fe80::ec5:d70e:98de:e13d]) by IA1PR12MB6067.namprd12.prod.outlook.com
 ([fe80::ec5:d70e:98de:e13d%3]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 18:19:29 +0000
From: Ofer Oshri <ofer@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, Jared Holzman <jholzman@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>, Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi
	<omril@nvidia.com>
Subject: ublk: RFC fetch_req_multishot
Thread-Topic: ublk: RFC fetch_req_multishot
Thread-Index: AQHbtUTtH3Tf0nZGzUqlIHCxf+6T5g==
Date: Thu, 24 Apr 2025 18:19:29 +0000
Message-ID:
 <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6067:EE_|PH7PR12MB7819:EE_
x-ms-office365-filtering-correlation-id: fc202d0a-7e3d-4fa4-4c69-08dd835c8d90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?4XOWEL68nEAfKGwMyRmITvd7N6wuZeBbOPRvxJb6xnocZRKmWdM9wVl4?=
 =?Windows-1252?Q?+xdUX0k2z8YDmvM6JC3BHg6Erme8Uf2YHk1kPVP7j/vA17i8Y8P+Pviu?=
 =?Windows-1252?Q?p+1ujwfTe8rRKm3hT6z3O1usQ9HEqKxSo5Qdt7H88R1sIOJx6SwIa8rt?=
 =?Windows-1252?Q?ZaepHpAGxgpTvxa+NXlkMnCYco3VUATiI4xdhNXxSe9uBv2MCPCj2fvH?=
 =?Windows-1252?Q?UltYR2TbTKwFKXjtBntuAW94TappT943NFHcCfHP+voo8gE7aZsaq74q?=
 =?Windows-1252?Q?uOMrc9vS5A3MOk90rrmUGxUOAC5w5sY1VVUwuzcEFUpH3+pQpsM861wr?=
 =?Windows-1252?Q?A6VC/KVIGEJ3DmxAz2pt46jZx4WDXdVMMnbaPCGyhYiS0By96T6RuVbX?=
 =?Windows-1252?Q?kZtS32m8wWCoGtFY8TRVPlgAyE/1bJvY7zzx9AWgjKe8KXbrq1oQGhfy?=
 =?Windows-1252?Q?kRCYelVnH3TagB5TD5GXH/kN6vbUGNY/Kkiu6AlAz6/tGpdEk69fTW3u?=
 =?Windows-1252?Q?8zLgjiXWQ7Kimky8scTtx1WgLCxxxfJwJxaVEpbiimD/UObwmpU8jUAM?=
 =?Windows-1252?Q?IfTjQPjte4enMLHK9tEOHfHkIw3HSgMKSlAlRg3+4605GGxJO6syclEo?=
 =?Windows-1252?Q?s16ZAu20JmEP7An/DxjpstsCRA0/y7Ihk+LL2fgJfNAOggGlGmImOvJD?=
 =?Windows-1252?Q?r24oBZNLHqbWv8CQ2+U6GdIbodujkOLFucSoHv7q3Y9U3MwzxGnOB6a8?=
 =?Windows-1252?Q?itN9TA7l2qJ1IZYqVDLVpD8dIN9IWBkzZ2wlRY0GZkQESYvTiNZdw//g?=
 =?Windows-1252?Q?MhpOKOvuK9xLigbnSuuJMAvLoIMondc/b3lbs/J5fJlU2ITb5LzWDWd9?=
 =?Windows-1252?Q?O4BvF9OtlLxrkYUzpROMEaRVIE/8G05xjaKaUPjviTLyQqbZV/hFKozv?=
 =?Windows-1252?Q?kSPspo+FxhB8lrbvN9Q/gFx8N3uQnwslZH14i4sC1CSXaq2hCs3+pIhe?=
 =?Windows-1252?Q?JstqSY4yl708ItnJZzdU+bQ/X4LjLW8c34sSc54Uu9EmWbTXoYxsUJGh?=
 =?Windows-1252?Q?SC1FDskBPTgr7ToThejw1mmYDQ8PzTBqvL3cJh/taqN0i29eL+2b2n4E?=
 =?Windows-1252?Q?HZQbAHs5PXFZJSVAhWb26rPjSAzYTvJr5fa9wLZQP+KXSAM0doTPnVwK?=
 =?Windows-1252?Q?XzVP6s176ivz2dkGTNry1D1lec+W6Tb909YTU3EEajnQ2h3KETgdtkys?=
 =?Windows-1252?Q?17TYN6xPTf2n+AQkCg2FbPdX8ZxtVeQvfRSiePiJf+t9Ot3IEJEdZozE?=
 =?Windows-1252?Q?eGt1kyCTyJn5ZJdt6vWQZJcpa2bQlNizU3XUFMXul5dViejaWjNRzUTA?=
 =?Windows-1252?Q?lIxPteHPnk3ay+4clkG7nFJs546QnzDt4pQWeanTmyn2QYKJMNb/kfke?=
 =?Windows-1252?Q?0eK/YdPr5qdgB7wZ737eD2MFVNjXGy3s9ZnKwSCXRKYjoOfgg4AQd37r?=
 =?Windows-1252?Q?kKaIB4UfN4Zk8MUGuL5o7dF3zClLv4SRJnOlDUfQFjEv4mUEfPpzeAfV?=
 =?Windows-1252?Q?cn4n6h6ZGcXkdCo0U5ZTqQkGvO7yBQqzQPCiuy8nKrB8LKWcKSfx9cc5?=
 =?Windows-1252?Q?pdk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6067.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?uMNL7IvOnG2KWQPyHMhfm49jQOR5yiepouARt4IwZhESAPMud3kOO31e?=
 =?Windows-1252?Q?IMUT+WeyQcoSMkJy7n3LmhprzlrpogsCQwlV4thUEimSp4LuQ5FA54lt?=
 =?Windows-1252?Q?ZHenohuhN85O//VBtgugu1aMnBHIsUiaZhGaOVL3/7ZOy4hW9cXC85S7?=
 =?Windows-1252?Q?7kr0EH3/nnIpC2TplUekzNIZREzIsMvF3jHIWuI9f9VkVQsIlTUOfU2m?=
 =?Windows-1252?Q?OfzuU8ehNk5IDSXqYMHIBg9XK26fXwKC1a76xGepLL2QAjs7tNCTWUfr?=
 =?Windows-1252?Q?OBkpMRYDG9d1tB8JejXrj2TJ4MaxSTtXvo8rnwIboio4mLFKQfrSw2xK?=
 =?Windows-1252?Q?G/v3TJVCC/jREIYaWsbLfnt41TS22kqltwlOcViXeBhtEjtK6sVTEIOB?=
 =?Windows-1252?Q?S13cYWWvnnZZDWxXF7UKfCsnh1esSTHjm81oryV+mvOwwWm0Qww8FaJj?=
 =?Windows-1252?Q?DnL8TLIhn3xY5Y69twjgo8KDsp1e+a4KAGWlFWjS9IjzYgLphKcaxVDU?=
 =?Windows-1252?Q?7xTpifZ+t7V33EgPOuexeaL5+AB+O6OEOj4p/q1PUqP1S+X/EDyx5ZV0?=
 =?Windows-1252?Q?zd93cJrAdudo8FVOTcG7RU7HvX8mr90dBL/0NBJ2AxC1LoMf2nPzR2oH?=
 =?Windows-1252?Q?espeYFE6TIlcC3xt4F8cKicNhoGprVLVAVy19OKtnUe1KumLdhFWtmTu?=
 =?Windows-1252?Q?D+PU/XwTI5DLVsZY/Ih7MwYUArfRQOPHeqmrX5f3Y8n65d5xPuGLrLiA?=
 =?Windows-1252?Q?RxAw+24HfvtwAvC8T+XVB2qRCpEEnRw3qyElX6gyFeDtYCEeRem9QpaW?=
 =?Windows-1252?Q?UBxetILj7mR3J7dc/09nae85KZ1cKNE8XUHBQ0Ou2tga19dTKu6bVXxB?=
 =?Windows-1252?Q?fWKz0PO3/UBVc0AvhJ7s1vDPIpLhQKplxCyLdNKPFhCeaEiSfOwDU4ii?=
 =?Windows-1252?Q?b+eKbkocykBckDIl0tEkSfxXCzJnKtWveFjiEo5Nn8pd20wxYajvhUrE?=
 =?Windows-1252?Q?ZLY1OwmF9W+jT9X3NbNwfOWvlH44f0xQBL/dTe826fbd29CjeBYGisPm?=
 =?Windows-1252?Q?PRiNSJShg7X985XdeUQQ9313qKeJNoMepRPW3ZscHCJMIv15XHyaCj+L?=
 =?Windows-1252?Q?xsMwDgRX7v+BdOXbXioT+/C21+cjeWCM37ZWUurqPYyuk/g7bujSYAzm?=
 =?Windows-1252?Q?cHpcb4O+shnOrT/AvPjOALJpgYGhzsaNZE9TVk7cO2C2/Dne109EFVCi?=
 =?Windows-1252?Q?GkFu8qLJWwwdm6pWdpS92rW2+GKvWzP/0bfMYKubEknPtAWkTVnQEIB+?=
 =?Windows-1252?Q?JQnPTTeJ5z0F+ckdpmwU14ozGYraN+ysRqibTyn1bxsi52Ckvh7AjAfv?=
 =?Windows-1252?Q?S8gPwq79rgxj71gCoM7W2b2brIklG2sO5bss9mJGszaWEzZEmYM/HE3l?=
 =?Windows-1252?Q?H/UJotqwhDQCm8QAmrD3YKzvxXnyaKMh4PXR3YDWp7+K2UA4MCTDaAp+?=
 =?Windows-1252?Q?d2TFtLOmx0WPxwFBdT3XWGHgjzuSp6ygeWf2k63jC5hoAm4pv4PcCg0q?=
 =?Windows-1252?Q?U135tOqmFWxyLo2qKly5KsUXNBqx374S9Q3jCXsniqhx2svdk3Hpq9qE?=
 =?Windows-1252?Q?jpPCHUEwRcRp5WHO1pYXL++j+HNxjhZ/9Hcyv9PkEz4Y38aGonixZTsC?=
 =?Windows-1252?Q?oVSaR5eSZlQ=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc202d0a-7e3d-4fa4-4c69-08dd835c8d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 18:19:29.1502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVcXodBQeXGzCifpVsouOedQqfxKIcD0/Dv3VRLBfWbaaNQKmxzJcBxcHiDarM3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

Hi,=0A=
=0A=
Our code uses a single io_uring per core, which is shared among all block d=
evices - meaning each block device on a core uses the same io_uring.=0A=
=0A=
Let=92s say the size of the io_uring is N. Each block device submits M UBLK=
_U_IO_FETCH_REQ requests. As a result, with the current implementation, we =
can only support up to P block devices, where P =3D N / M. This means that =
when we attempt to support block device P+1, it will fail due to io_uring e=
xhaustion.=0A=
=0A=
To address this, we=92d like to propose an enhancement to the ublk driver. =
The idea is inspired by the multi-shot concept, where a single request allo=
ws multiple replies.=0A=
=0A=
We propose adding:=0A=
=0A=
1. A method to register a pool of ublk_io commands.=0A=
=0A=
2. Introduce a new UBLK_U_IO_FETCH_REQ_MULTISHOT operation, where a pool of=
 ublk_io commands is bound to a block device. Then, upon receiving a new BI=
O, the ublk driver can select a reply from the pre-registered pool and push=
 it to the io_uring.=0A=
=0A=
3. Introduce a new UBLK_U_IO_COMMIT_REQ command to explicitly mark the comp=
letion of a request. In this case, the ublk driver returns the request to t=
he pool.  We can retain the existing UBLK_U_IO_COMMIT_AND_FETCH_REQ command=
, but for multi-shot scenarios, the =93FETCH=94 operation would simply mean=
 returning the request to the pool.=0A=
=0A=
What are your thoughts on this approach?=0A=
=0A=
Ofer=
