Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DDF125A8
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jAqp4SS8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U3oeBNOA"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70803171C
	for <linux-block@vger.kernel.org>; Sun, 12 Nov 2023 22:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699855765; x=1731391765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W1qVycjvkI03ExRJwvh9RuT9PaKmMkD47x/G+oFhLjs=;
  b=jAqp4SS8xQRpEO7l4tbPLaJFuBZ+FIBUfBGEi4VIE0wTlhU8OVjDuwTl
   ZWH3km5nivlt9cyrEKeoD+dgjYY7OeCrkXUj2KdnxhSC8rMNyCxUpzmvM
   VLHBGFau77xWIJj+tqk3NHzqWLUNPlS255gs3d4pKR9dU57aDOEESyghx
   O6ibF6KBfQcnjLQwTEAvBGiLmwl8srQCBZJHS33RG7iG9+sUQe866MAxK
   qVYFSsggnB1Li7q/W+OGVXaqPT0XAkgQtK8SI3zRe31PIw+5UWDfTic3r
   /DWvTZ6SG2Izu+bMC1S1tF9G/Su1crbvBIM2E9yLgtjO395OvzHkQtvqx
   A==;
X-CSE-ConnectionGUID: anyoWxOrQROBZ5p/ntC0wQ==
X-CSE-MsgGUID: UyZmK6zbQs6FilZNPjGSzQ==
X-IronPort-AV: E=Sophos;i="6.03,298,1694707200"; 
   d="scan'208";a="2137823"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2023 14:09:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WloITL6idXsIq5tH0gHizK347TjWGR2K293+OsytBBWrS366XA8cc9nJrY+g8IjUyZ8YCjEHN6R4D2qR64p08sWmw/jk/BctdHC6fv9/RCqzj9/FrdJStWftNTbYmtYztoOBT5GsZd3Ar22S1QyiDtITx/pwzYEH/CSBx41NSb2f0KuKVoP9DkXWSvla5NwhUiElFvge3DVJXTbHYhLYqnzzk3FGvSBe8W7FWlRGawImHvq6CsS/sd8681DBKId4XWNOTu02HbfNFL4+krFqgoWYC5uqfEpH1QMqDfTu55NcNBcMJGEJeXGwPbonRSAHmOzRTXK147VeP20VTV6z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1qVycjvkI03ExRJwvh9RuT9PaKmMkD47x/G+oFhLjs=;
 b=MCxMMVjo/ccLlLhgAR7gtEU4KnywyS2fvK90PgRvAx/L4mq1FtzDjWUdFfSjaYUolg0ZG8a06oIyN36QpHJ6CMknjvOR1sdJuZh2n15vGoSTD9vLW7v/l+PouChXGWH6M27AhffZqpWz9/dQbmKs3fLH2F2QbJ5NLr6IQBmlJlFLTG7rHvBcwFqGHpI21Ahi3YDGcFxxdxcW6X5mpfXpHNpyJzK06+kzLBf8WJJIQxQpbOJq2EukaoXwfWhp8plNxPMGZiDM8I9TxVgneVvdqBLPbjFGSHQ6Z8LFNaZQ+v+fPgcDIh3o9lxglpMYzch7XqOX7vTVHae+dp0O5gAl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1qVycjvkI03ExRJwvh9RuT9PaKmMkD47x/G+oFhLjs=;
 b=U3oeBNOAdA2IZW+qNdaV1oll2XxlhxG/Nxt5IBwGqOgw7Pp2SEXcSoI8Bhz6OYAyYPonP1valeR4LQIPxM+cjg41DPt7qss8gs+JXroCp7tinr3t1g4ZGBKYna7DGMort+gBA88QCCNnBT0YpbiIzmHym+zRb17GX8SkNSZUVN0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7494.namprd04.prod.outlook.com (2603:10b6:510:5b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 06:09:22 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 06:09:22 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] ublk/rc: prefer to rublk over miniublk
Thread-Topic: [PATCH V2] ublk/rc: prefer to rublk over miniublk
Thread-Index: AQHaFJQ9OEbye11tP0e7RfipD8PyTrB3xqmA
Date: Mon, 13 Nov 2023 06:09:21 +0000
Message-ID: <7vokrcsmv353xhvvz4azktzlggibkzat6yb5o3povazinfg6kp@dm7dbmn3haqj>
References: <20231111114253.2665981-1-ming.lei@redhat.com>
In-Reply-To: <20231111114253.2665981-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7494:EE_
x-ms-office365-filtering-correlation-id: 5034cb46-73d1-4a40-b891-08dbe40f1450
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h3oBoM9021opQM8fme9z1R6i/I8ugEaNagIP4TebTzBtvOFDknOApmyZXf0BFZyhu9MKPKYU45WbLxtCqNdJaZglFSFQRKlmFwnyqSHZnc1jsexV5Ezr4NS0EX9xoB72sBLIBz3QbnEsaXKAXbYNwKXeGrKCPNpwoFrbyyWHU/7X9efjszOmhfgjS50oRrHV1Ch4IB0uyYtx4MAwvy+e+XU8SomAeL96sGYxb/9j6IBnp5a3l3Vq4rCCyDCOVeOxTBqRCloON/g1TZejat416nLc/KqrOw4um/axOGNJHpqtlb6SbpRWyUWS/bA07pBpyTV/32+LMZ1WARiTwOgG72IpU7ZZAqDc7rntl9toJ7z0hYBT9tLTJIQ0UzR96iBE9hECOjKSgluYuH05rRK7Fwi5somOX1N8snuOmPcI7M0qLGbY1XL8tyk/xY3b3oeI2Uw03p5p0+yy950RCXut8hAnzVBPz6nm8BX9o9cEit5R7+KhHJoE10S3EQRORkr9ODsvzr6vbJHt19X67Nm+UN/CjCu6rMDsO6pORrX17OaqIFNlFcP3Cf/Nr0NZhtt9q9PLhmpFQzeOCg71SgHJcQv/pmTr2vb0MB/n/HiOXUk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(2906002)(4744005)(44832011)(71200400001)(5660300002)(86362001)(41300700001)(33716001)(26005)(82960400001)(91956017)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(6916009)(9686003)(6512007)(316002)(38100700002)(966005)(478600001)(122000001)(6486002)(6506007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T67r2d9YR8/GIZm3CdnPn8NCjtPzFc5SMvRPZz+bWBsbDHlR7fM5SFErfjWG?=
 =?us-ascii?Q?ApkuTHxlaDCX09E0xGnDDOSQtK4Y2HvuRjCSBmUvpjUIMiHtVtl6bA6TPg8z?=
 =?us-ascii?Q?utFscC3KME5fbk9W6cFcLkiyPc+pVL8wsmHnzHL7So0xfdEB76M4TQJK0k/l?=
 =?us-ascii?Q?IonU7JbbAMRNsBDZSRSEHawmQSraw+B0jP+AA35rJ3aB8q+CsJz1tzQQtJr4?=
 =?us-ascii?Q?u8ToOFIPTuZGfmoNOMNMxpI5O51e6Vihie2D+yOOD1PHDtCCB0jKIQtK2637?=
 =?us-ascii?Q?dk0bvlkE6BSeJ03JzLayCiO60Sk+60+kbwXJoKR1Y5a2dorXpDsdtivZROig?=
 =?us-ascii?Q?erW5fDliTqaIe3WA4pmnTbnQVCErow6Hm7R4J7Jc0BUomt52Gbk8JDTdIE8t?=
 =?us-ascii?Q?hDAprAMqPe1x1nO1W2kdP3p6GXuhSzDoEpTf0vT+ZM6V2AfNGlA0h24GG4OI?=
 =?us-ascii?Q?DRoAWMD2DNh8TGqbFvUyKcyWV9zgN3wIBQT5UR4kw0qessf9DJDakLy9X9HF?=
 =?us-ascii?Q?nB2Zu0z7o9QE1AV5qRwbCR2hNojhWZ4JvNWG/rm5uBc7ejiohOU9jTMIYoP1?=
 =?us-ascii?Q?yPzc8ClLxqeGIyITlfunskPkj/DstlOlHKLAGUCasGua/6xWSko5f9T60IwQ?=
 =?us-ascii?Q?e5AtH8OO6sMnRbd53fM3B5WSZHqLMdiLGeaCepMDN6sFfd+tGJX4lPQiIUD9?=
 =?us-ascii?Q?oZsPU2EKgA2afrIvTjBfDBpyqBi6siqskIBtQY3BjcAOgJ/6W2qGWWP9oYuG?=
 =?us-ascii?Q?h5oFiDuwniXLG4+ovC/JtZjPfgKlvuMNtgsaL/XsHl5lZ8793AHqOgTi12zG?=
 =?us-ascii?Q?xljXwefkIUVqpIvVFQ552eMfqf/6BGC9TBoBBrdRv7wo9bYc+NAHH6vnlS5O?=
 =?us-ascii?Q?VPBY26tAu+xxhxMvhDum7H+ebO8VW3elmka+UZ/U5dPFG8d79sRc8BKkvjMD?=
 =?us-ascii?Q?zdc0B2AVtE5K8pMmkYBtqRl1zNq8V0sro7QCCxVx0h2r5Qu82uNvhMBN6sJS?=
 =?us-ascii?Q?NeqKSHXRxV1zKGprMN/gY1PWzPxjTsl/lYyuV6J+WL5parJsA+O6xyhq9dRq?=
 =?us-ascii?Q?Vr1xyjEfc3cH2T4XVN2BGtVK1CKyaa/iOL5NQtB18caGK7S8EAad9e4vaIw5?=
 =?us-ascii?Q?XVBTzBB8p4jNqoRipCk9/G9GOk3UN+RsplKRTy8mePuThr1zFB8D49GkadN7?=
 =?us-ascii?Q?UfTmqSScfwtraQJD+buXtJlOp2nJ1+skEjzbnRnkmgEAlbSuCOWkmSvTrIBC?=
 =?us-ascii?Q?GIjrFg6yghF5cBU/+8+gTyUy8x5DQVC6c7J+qEQT6fYXTEgnraom4Tt3/S3D?=
 =?us-ascii?Q?2hRvZeJ+yKWNs2c3+AWTdtFf+hc+fZrRo5UK7OUSSHwsyrD/isROx9qUPHXx?=
 =?us-ascii?Q?F7qmxy7f+pAcihq5kJCHAlrdwH1q1x+EZm4T79eTYPLDvWJ0Mv5yT35phWkJ?=
 =?us-ascii?Q?yNV27HhWQOxml/apHvXUWSvW4LjNyfee+YJGCK5wu+Om87N11hrJPIcFKy7m?=
 =?us-ascii?Q?5Yd8rFZsg73vR198nAcja8hDUSPZPW3+9y/eq+a9u4Jlgu7UbDRMw9cO0+VA?=
 =?us-ascii?Q?TlQHngQYfAlZrmdm2B/ngnXH9EZS+FfKuDBk3NdMnRlOaQxhMHl6cOk5DZsy?=
 =?us-ascii?Q?br5mPR6PAi5oq4ZW7nkmGm0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3BDCF100C129F48BA9FDF253CBEF070@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PetGXZvnt1SjZam8xZMN67NwcwSt0wso4mocPaO8kXFsvU6hoH3y+Y3VJAkkIrFIBCBvmziAuWdc7kw6QUtOeJCytWUfX30RWppUPCHrBaW7u6uaob/bJ7PNCs+V0JsnHvTGvHEcuPnGcJFrhF0wky5b1uI+ec9iS4/HhTfx/VfDfpbh9aDCISsWDYUbTlQKTypj8C0PXKgArR0jlaof4eMrApyIfXJAp0ciAZySGBrtUquj+iZp3qmflt6chiw6q77sKVBPbqPuoUhOOaqFhjXUiBJMnjZZhGFqVW35JfRCl4i5ZA2oiWvpCVsI5HhAxsqeKe6v65KBa4WPja0mCNODskF3iwwl5zVUeXjYUb4odChAWSPp6W5ToHlBfj5ur/0euZND8n5HvwrBmcCnQkhNp+ZNe8z/B6YE3D128B+H7dUx4aaTKmq8DJ9IwPwwZrqONURqbwMF10DW+2ZfUd8Fox9TS1zkJRdBJpulXGGIuyjc/HLZOIIYsVQB1WV4ITY6j1o3AvWZH05gkZspWWT6aKDShRzAmcv312fDZIn+m1ihRmZtu4513ONwAGLz7VYyF/0t6qwzY/VEzOJVG+CqlVJUvfem78RYSVoy2oGghx+r8vmgzN5vH2L6FgsPinE2ehcFQWrqd19FyT3q5gV+38DyJLLGVcwV8oMDmpEyHzRdARVDl68o09x0AcSIIj+a17lWz7sFhCJgCQDo5Zse2JuzEBU/AWLJHhM0nQFfa8fEEqH2bVyQ0lKUEfyIh/cfsqiB/ENS8e35qABH6F6e2ptSI1eb54EBLpb6Y/I189+iMeVAF5g01Oc63nx1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5034cb46-73d1-4a40-b891-08dbe40f1450
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 06:09:21.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Z0iC8Uo9RHMxQItvRITxFdlmjj+PBVekPhxX7+M+gjOWe8ls3CswVLRDWUYrqu4fz/pfXIh6x5OQv7/Eq+DlJD5s5Wqanv30dZ2rITB0w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7494

On Nov 11, 2023 / 19:42, Ming Lei wrote:
> Add one wrapper script for using rublk to run ublk tests, and prefer
> to rublk because it is well implemented and more reliable.
>=20
> This way has been run for months in rublk's github CI test.
>=20
> https://github.com/ming1/rublk
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I've applied this to the blktests master branch. Thanks!=
