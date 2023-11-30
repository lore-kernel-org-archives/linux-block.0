Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J24qJXnc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yQfqAEog"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB61CC
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701312876; x=1732848876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NoiFpq/ubZbE9zOEuqrSU+kvXVf0y7qpvtgr1KVeCfo=;
  b=J24qJXncePrgAwXHMhxe60TFx3E6CVHP/7iQ+tYaZHeTxNhX2aVq9ymm
   x0Cb00REASn1WOJAyZaa646A+9Pslnyqxbsuml5f5Iw3bTl8tt6WROBsH
   PQXPH/an2rSHf6xAPA4Vv14BWYyU0pW80fT2uRfMhf1DJi2bGHb4WJc0S
   ImKvJfLowNiwG+BzJYnraI6MOAULhNmYiQuhaQmfsw7src9f/WRQGL+Aj
   +caeNOj+jWMujt5SlpDkVd7454Kz87jfKvh5MCyGG92WXZHxF1vuqM1bT
   3CfZ7ghQktae5Onl8d9NED5J9ypRUvziUA3WdjZwAVa3bwu23kit2LSnG
   A==;
X-CSE-ConnectionGUID: 2JI/+wzgRBq+px/+DPKPug==
X-CSE-MsgGUID: S1iafCLFSW2Yu0pIpHwcDw==
X-IronPort-AV: E=Sophos;i="6.04,237,1695657600"; 
   d="scan'208";a="3627910"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 10:54:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPmKPCGzqgFpXP3pR2+woJRtmALNSXQkaSN+rgRpvEsLQnjNf6WIPh3jkuNWhjbtWBt4PZOtU4uyAkVqJYBaqyDD186uppqEeC4OEQzfDEEFFJJmP4YMWlCshoZGjmTsk1aE/9r5eA7ceG9fNKBx4MhDIiUiEHmx02wMqMSvscmNpvyihalLsPS58oZHtj3cBUbl4/w8qk8IUkIQscgIt0k6+d/fDYdW91F3+rvaDjB9Y95zgkCf/CQVfmrvpAvKqXy31F7H72rWhJO5Dzn8TxRco/39LRMH04O1kYT8ThgwSG7ZiyEQy30MZ88UOF2HOWEGotZzYTxVJbZZpfhhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKEjaJRzwR42ije4LZBru90TqS/rNisL02C0++WLoTI=;
 b=Qc8BOu6oin7SNTVA68Eg5ImdNm8oOJKjGTbJqoqHAAYkpwNy77PNBN21fyPjMo5GAxxObc2JhijjO/VdxKrxNlo71lWwkyosDD8n3RT0djzbEx7W6wQQiEPfLY/frisw+aXSgmPBfKvjlt3BUlGxl+4/drtS2gKI/+9jBWpR9BKNt3aa0ty9eQR8qLh/KHW639gxYMJCw1N6lMF5bzpH8OvY21KhY7m8QV6Zdk+745AX0UaWvaC6leEZK3SPZAKT8enq4naYWVM9NtzFxjaZITSeSMJqxW7SVP9zG4u7EUAzt7rHBgRFklGD2qxXa6frRAwMyzbTtKjpDJfr8HysqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKEjaJRzwR42ije4LZBru90TqS/rNisL02C0++WLoTI=;
 b=yQfqAEogepPcLnaX8uRPtcme6CpEJSXG2DGh7nlFc2+pa5sGLN+Y0j1esL4SA2dlz1nGzU47/0c4pJeIFLSTbOsLYMeOpndIvd77JLk32Toaa9XIVYpTGwWOwngOqvnoJNgjATeet11H3mGkOA/5nmaG9IeZ490GXCIKo3p8/20=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY1PR04MB8654.namprd04.prod.outlook.com (2603:10b6:a03:52f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 02:54:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 02:54:33 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Alyssa Ross
	<hi@alyssa.is>
Subject: Re: [PATCH blktests] loop/009: require --option of udevadm control
 command
Thread-Topic: [PATCH blktests] loop/009: require --option of udevadm control
 command
Thread-Index: AQHaIrhIty9CQNVYYUa7IJZLjIom5rCRlheAgACVj4A=
Date: Thu, 30 Nov 2023 02:54:33 +0000
Message-ID: <fvjbzyfocfruiwlkpxa3uykui4urt4kyvmuvs5nevqiftu336l@we53jtpd54pc>
References: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
 <18ee474f-80fd-4a46-a8f2-0cc213618a43@acm.org>
In-Reply-To: <18ee474f-80fd-4a46-a8f2-0cc213618a43@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY1PR04MB8654:EE_
x-ms-office365-filtering-correlation-id: a7877139-8bb8-4a30-028c-08dbf14faea8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vHgaljibia7VXuQx+unEB8LMF1RhmynL/qw7c2hdpF+orTrU5YkDeJ/+dU0WAaHsTnQ/+B0S6Hn2dbJLsfvNCHg43YVOvD2uP97YN/jY9SvhflReRIFgkRt88+StQS7I8SWs3gU4uhyWDLwmRyk/i1Rlj9qjI6f+DuVYvG06g/1Wj2m7tNx/yFcl7YRj3WjaZ/WqhsUyz37zsHqWiMbe6V88kykqJnZVfQZZ/wcUhEPeIeCmLGffJ70cUn11fHR1tFT+TkwIWMEIF4NPVUI/HMp/OkO5p2GJa82qoXD7fUdNq9J/8AFaEXp17Uhs3iFsIKmnJmVUxEqwwJf5LEEp99wU1v2tKsFrIdSZbbJcBclb4aFylFH6D38J2S46pbTPyj2gXrJJ1pGLpBLjDx02H40x3THnMh3ZSr4CtN2D/g1O+7KOUGl9TwSBYAZsFw9OGcDvD/clrrgHvZV1HKK+ZyiPKRI/7ThWm4zxKRilQQSUYfAKoiI0U+1Hy7yiB3dANhYRpwtV0vmeslvvsL1NtX5ZnKRrEIbLQbKoX7jhlqMisP3LanvwVi03meQFlEBMPeaNYMXxDtcVTa7cy/9GCyZea7noZTeORnlT2dewUcy0zgZBdwntceRvTbz2M2s7Ab7xO6OtrCahBfLSQQHVyg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(9686003)(6512007)(41300700001)(83380400001)(202311291699003)(44832011)(66946007)(66476007)(33716001)(66556008)(64756008)(66446008)(6916009)(76116006)(91956017)(316002)(5660300002)(82960400001)(122000001)(54906003)(8936002)(4326008)(86362001)(8676002)(71200400001)(38070700009)(53546011)(6506007)(2906002)(478600001)(6486002)(966005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k3920EEyvkHJ+H4ckQF6vSdOqvrVd4G9HxISjSZKtdHs0NmMM6af+g/ZU6uI?=
 =?us-ascii?Q?8TGIYc4RtvZcKuSgtoASUYBUKTrAanL/DGCTZ2fTO1RwTOHvhG4OfrrfD8nU?=
 =?us-ascii?Q?xiZREQgsGbP19ftkwLA8+R2YEvvC0ahPk7J23e4RmubROVwlywoBbE7VNBAB?=
 =?us-ascii?Q?nf+wXeFmWz7eCb8PCXJkeqb7ZH0JN/lQUSXk0ClaO6EXUOopEfFEKQXpyt5i?=
 =?us-ascii?Q?0marfVZk+D2+jnluWfgl2sPk/iMMAYQVu2CjrWnTNFxnXFPWygDqde5sqbhU?=
 =?us-ascii?Q?G5TCo0aTLtMTG6idtMc1FTvig0tP8YnmrbCJkm2YrKy2eeykDnuw30dSGqIE?=
 =?us-ascii?Q?kQLNS5UIz69rr2jJUWT6Uzfsr6F7dCF/+j/wwWYiPbQrSIX6J2RP7/9k/Owu?=
 =?us-ascii?Q?EluLaRR4/bTrADOUmnAVmlYzT44ITwsKS4gLDd6OGUttoYLOnjj3kG2ErILR?=
 =?us-ascii?Q?jUKORhuMtZ7HTn2D//y0BHH4SoTOz+RENq2OLzJ+wuRNvEfLZX9zG+rodS7I?=
 =?us-ascii?Q?rDrVo5HesYHJzGeHRrX4Uwz71CWVoXN25+iBMb1k6GhmQbBI79TdfqvRSxjF?=
 =?us-ascii?Q?n7Jbbij7POHLpRpNYFBCK2ZLYaUWeb8LgTGl0kTizccCqTtqoPebbZvC1PY8?=
 =?us-ascii?Q?viE+g1CIaSytDRdOYoBoFHqf+XKXOtpxLdIKl1xiaFHvprw0guAdl6Z7qvQ7?=
 =?us-ascii?Q?zpdp+GIkY23B+wL8MWErXUvAS8LW7VokC70lXdm5ROiG7+gkAV4SHvVpZa2p?=
 =?us-ascii?Q?4OfPPcAWzNpNth+LbPEfDZcndwyjfkNORV/BusVwr19+Jje08BhO0XVnQ5Mb?=
 =?us-ascii?Q?L+uauIlIzi/FsWRBwBide/JejDe3uo2QNs7eGwc+KuKJKkSyoPHg7Dsw3dll?=
 =?us-ascii?Q?xpdvk9aOy4Uap994f/dBzv/pqY5cMLFBbEkx0SMdpuBUKa4QbhuZmH4Mp+Jc?=
 =?us-ascii?Q?IbhhfTaZ7K0BNIcP/ErDIzX5j5h5kIbWy0a7TAd3Tkqr+TP4q2omCPjAVoeg?=
 =?us-ascii?Q?Eo39uoL8ACkY6S8Z5uhTQOk3dsM0of3P/lHClOdKGpImuPUjpHqw2l19vTFP?=
 =?us-ascii?Q?kazhQxBBotQ6eEiSYF0x5wh9iVxPMmLIMbx/WqpRsksGO7YipsuSVpPJCUMS?=
 =?us-ascii?Q?ZTl3YKpax42lN9WVnmXWjVFbz0OTG4d6/56R1+qVVzWbiipGk5cnZHnknNx5?=
 =?us-ascii?Q?gWQoydT5JufaGaovrkZd/xOO1loaI7xMKrrP68Htf+Ae5tbtPTON15mAMM7G?=
 =?us-ascii?Q?rsiTRhc2Qu8WHgWGXv+54pOnCSmNJvj6nWCR8r0igd4aAfOMIAOYLNZT/J+W?=
 =?us-ascii?Q?aiekCTS0XKI/O/NIj0+pWWkQs18FfaTwxj3pyTGrv7qdqqxBypMl2zCBTCDr?=
 =?us-ascii?Q?UcxTzvr5Ii/X4yZTzTZHKsUYer54dg4pVxukLyjI2PgGl8hHXUx4x7WMeITW?=
 =?us-ascii?Q?S2wsGjBXEmqEot7OrLZpU/OwrVe+wAz0GovI581BKXebJyR3D+xSm36IzL8g?=
 =?us-ascii?Q?rMmnk/IjlqKtshuNkCd9nfW4EubVNTJ4ci6kzkNxrBdCJ2mVkcZZAwBERM6C?=
 =?us-ascii?Q?EoS0q84/HaztdrIMZiJ5VGiaEN7QiEy/lFBPDoM1wVqzgi7LJg5rWTtzRTBe?=
 =?us-ascii?Q?jizC7UBILCasE+WYZhhvXk0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <675A8DB7F1D5A746990C7558C24287D9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6dHaqbApl+WCX1YiFQwj4/Wiw2EJnATPmuS02o9koPVdNll5/EqiT2ERRYMzHcXLJq/As9dFFXoAlZAl6Cb89cpa32bwfMgOek4Cu3bi61E0UjBmFi9otGUEUL4sRJJ1A2wcXbxRmUj20wNf7BwnG6MpWu4gO9RQ1E/HkQu4Mu87m/vA+M2oxGL4reQ5JNa6LA3VwIeHZ3CpxHmuCTIadR+cPM6f9Dpldy9nw/+hIrb4VouT9DQApBG81203LIFkMrvb1YZYXfnd07SZjeDc9llr+D2lDV04PzG97fXoKRhLw1NdmDHxCSDZCzM5tW+vsFCl7LioB0/PLAXriGFj7hg2agA2lV92MdxMY4sMDzfIMwzUpm40h+8Bu8wraSR6Z5w3r+9Bv1cxqyGwDEoDMBHADFUMSb3hQtkEKKoFYp31rDidvNgM+/E3dYqCMHykQOiW2BU6bIO66tQIGYYMX+eK9p3UQ7b43JIM12dL269DzIGoOOsoNOU4nTDPAhK3LyIynExBfhFhU2hpv7eJseohh70Xw2EKnnLMZ3iNu13LT6pV5JzsOqNC6M7vym7W89kXwqmWyvt5pZu3gpVOEwNK5bYIhvHA/bwW6ffrlkDUfwHer4IL0pbd2fEYUPGMRhmxONkvnZgqF/JHNci/xj7uxzddJyr3IihJBYmgzmLAyacVAgaj/xYICMqwaE8SYUHMyp9bXrnO94VUsP3/JL0VlsnwslPXl4u/B4U72aDTy38DIIA6QAAWjuS8jAsmW5VFgpX0yonnjVAn/8elE9Pst+gGGzuxANBJ3m7O5v+OPun8j5RcG+CBvyEX1LiX5nyfZZ187WGtuhqFx2qdlQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7877139-8bb8-4a30-028c-08dbf14faea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 02:54:33.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZ02IqPqwCVV4FSwt4ONGxwifg9s4DuR5QbHLqG9qjd3f8BDK3BkssKesYsUWstW/I12phsEPL42hDQmjNRqYBbgq7XPANoy3RWJrlwpzbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8654

On Nov 29, 2023 / 09:59, Bart Van Assche wrote:
> On 11/29/23 03:36, Shin'ichiro Kawasaki wrote:
> > The test case loop/009 calls udevadm control command with --ping option=
.
> > When systemd version is prior to 241, udevadm control command does not
> > support the option, and the test case fails. Check availability of the
> > option to avoid the failure.
> >=20
> > Link: https://github.com/osandov/blktests/issues/129
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >   tests/loop/009 | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >=20
> > diff --git a/tests/loop/009 b/tests/loop/009
> > index 2b7a042..5c14758 100755
> > --- a/tests/loop/009
> > +++ b/tests/loop/009
> > @@ -10,6 +10,12 @@ DESCRIPTION=3D"check that LOOP_CONFIGURE sends ueven=
ts for partitions"
> >   QUICK=3D1
> > +requires() {
> > +	if ! udevadm control --ping > /dev/null 2>&1; then
> > +		SKIP_REASONS+=3D("udevadm control does not support --ping option")
> > +	fi
> > +}
> > +
> >   test() {
> >   	echo "Running ${TEST_NAME}"
>=20
> Hmm ... why "> /dev/null 2>&1" instead of the shorter ">&/dev/null"?

No reason :) I will fold in the shorter one to the commit. Thanks.=
