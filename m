Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E65D727
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006726; cv=fail; b=AJCqOASv983bPjZTOTosS4Jyyj9OvTSCpzHZpR+BTagGMEG0Nl/1aJpzTUFjxlhBZqfBZ/LCuUg2i8jbebSvpOfGuqr+LxQHxJ0MKSHPu8s+d+lgUtBeA57/Or51xTCLLOfHjfSMFY037vlPB6+CIT61HiB86tlXyvvA/IXBClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006726; c=relaxed/simple;
	bh=k/WtmNbk10QWLIzlk56Iv/14JR9CXxqeNX/GX41nFps=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZnlgNZpb9StCGkijx/HIZB7cZxjAIDEr6tHQBorhiPBhair1cKdTCvJ9BPZ8XpcU4ujodpB7TZ90m0zewZiVnZDLsuTdJOSSYYEMPf5nbXOlzRaScUDEDWYmvR5ndwW9iXKq+ASJO7aHqebGqqMFFCc+0SQC8DiTie1K1c+sDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mAzLrhS4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CbDlDDWy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mAzLrhS4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CbDlDDWy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706006724; x=1737542724;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=k/WtmNbk10QWLIzlk56Iv/14JR9CXxqeNX/GX41nFps=;
  b=mAzLrhS4Yc2ZLNii1/vSPeJ2zRcEukYgTB+CvIbwR9VnR5EuhvAEn87+
   B2qaXIpj5UWgurw/czKnCVE0QiB2VNjWsi2zRqp5OowiFOo6ztcBZF2Df
   yhmf3KwHvRtAzicpfhgUNoh2JQftkR+t+yb7HlSFOjEZ7CAP3dAxT3VXm
   lsO/WPNdDyVCWW2qCkukukCbpGi8iNEefc7DVHR0002MZNlJsgG/yEd0t
   sRe8Tv3IZhN0JNuPbpG7Zm3TOZby4df+UBN6tdKG80eDZG2JutbQvMels
   5hkH7PcB4g2oIM/VcQ9WZcm/0HpnRo398L5k8OAp5TqjjUNit+514CdTV
   Q==;
X-CSE-ConnectionGUID: ijvIUkOUQOiX4wgZv+h4yA==
X-CSE-MsgGUID: bmOJSTTMSRqEnhFYDeoZrQ==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7517876"
Received: from mail-eastusazlp17013024.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.11.24])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 18:45:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k33NSiD7m5w7Fq1pE6XKzlzLP/QaUuBsK/7bSg6bjjCJdHoIw514rmCmXrEejCZAanRG012UoUKScOw5LhKIl4DxbGSAxli3MS8rqe+HfFNCp9fPxDSOYKQD3QphWBUl+A3WI701K6piTOMtGtCLUz3orkvUb/lyfdEoj8UNC/r8JTxzOPBVzWChlkdFvdLGISFM8rUwKw/5QIRrde3KASqvAGwWM/Y4L6ZWM92MlxCVhJo1j5dCXqRNAfuQzG9pt+5Flv43rmtEWjNfx9AyeK+jpfV7tbYKL4nuNsidlOXhrvOZk/XcPJWBDbDMPo0EzBpgE7f6KLFQMFDB5ie/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/WtmNbk10QWLIzlk56Iv/14JR9CXxqeNX/GX41nFps=;
 b=k2wD3wyT6Jg4xXVerE0oJd1aXS0iROXSaeXUYUu5H+v69w67RJ/rHEKe9FFTTK7Qf+zCVxSVF02A2v3IcEZyBhN5R81oUXQ7br+044QgxedTPY8wTa6W/y0n+Owh33kuWcXfTk64Y//Hr862oc7galG1gpjx9lt1f99h3/c6RBKijwJCd6T0mWFdh7z+jZQ7L6QuKvqsmyCHjx9hl1SYizYL04r0PAYk0W9KAYn8iVQ6KRpPfgab4T1utOLGUAXa/pdQ3L5Srs3jLEyC2V/Jy5REospQg57TYy1GqbgNvHYkR+Hg+frLhL5CVvedt0LvsHnXwWXd/jdUR32baP03Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/WtmNbk10QWLIzlk56Iv/14JR9CXxqeNX/GX41nFps=;
 b=CbDlDDWy+CZIcULUpGDAlm6/Rw1f7kN6K0aAlabsPjgcv0mJAM17cYz3WUTnJcFYt3TCoAFZrHApRoXvufdO6b7Q59WfOEZ1Ij8QF/q5VtqS8KGrYJBEBah8aEOeTdVK71fMjNpUdf+1hbuBWkA2BJlgFSt/piQudb2jCP0zDCo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8461.namprd04.prod.outlook.com (2603:10b6:806:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 10:45:21 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 10:45:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 0/2] block/031: allow to run with built-in
 null_blk driver
Thread-Topic: [PATCH blktests v3 0/2] block/031: allow to run with built-in
 null_blk driver
Thread-Index: AQHaRGyq9Q76T/xt3USeBN39WlbOqLDnSaqA
Date: Tue, 23 Jan 2024 10:45:20 +0000
Message-ID: <5sm4e7lozq5suw3ndi7uwtdkb2aqxyatr5cve7e3ltjjgpfqyy@l4va7fgk42lm>
References: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8461:EE_
x-ms-office365-filtering-correlation-id: bb1efbad-bfed-435e-ef2c-08dc1c006511
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PJJOFelRRn5Cpy5IDxPbP8VsSUBpeZy+h+vFDOU0mUECq/7RU2DKWWpqwYn+4vfsd8hWmhq/N/wz+ehPgw4eGd+7fzVhzNKwciZYDglB3cDLCf14+6vkuTLV7Z78rjNewLSVIzVsxTX9jATSYC6iPZfCh7FbV2YlIzWheEkdFv0JvFZvhWQFKYZY/JDSfksc4Nuus3urCGVbM2lzvoHX/7S7X/jF8QYB/T9MpE0OnhrfAwQDBqetsXAc6PAYk/YxCaMyPoRYmARVrmhMG8lhtca9HyuXuaTdecTbDIW6wVNxWcEZLTyGm67xJViqacPkYsvhnT9u1HsiV+M/GGVbZDNtBvkvlZVP71IQWpzP7OEdMsFKiQ6xDhRTG38v9y6MpwaiwVGKT5eYiSq/lqHfoHXDHFkf6NiOIr2WR7yhxcTiwJDc9BJlqET1BKTzGycUu43xEIBHEGCAIIsU1YKI0/8BIRfeu+V5IkzZX+Ql7dA5dAHektFIhZXaPuUwVr9o1KI8NfAhJaY/Q5C8k0DJTmXXBJccnAjyUbugiqji49e0OD2OpdB4YxZFK4ZFrJm5y6YEGBw5Kwc8/4qbV8tQdcZJUGFcYsJLxH8WjLfC1AQZnkOQDA/gf89fP5wK7WX6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(83380400001)(5660300002)(26005)(82960400001)(33716001)(66946007)(41300700001)(66476007)(66556008)(38100700002)(122000001)(76116006)(71200400001)(66446008)(64756008)(91956017)(44832011)(8936002)(2906002)(8676002)(6512007)(9686003)(6916009)(6506007)(6486002)(478600001)(558084003)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xevMOsS5bWcybD9EM+U567evq0cafyBBTE9erk3xhEjmpoTmE4FfEld7iBfX?=
 =?us-ascii?Q?x4hOhNbZYvi9uID7D0h48cYWSUnkrDOLhYxCVSqLrf7SFOyHu9ln6LAamoiu?=
 =?us-ascii?Q?vPZAYMdSW6Eae1zljojD88KMtgn47/LWKMn5BWhqPh5AG9BS2GtB7mqJwevX?=
 =?us-ascii?Q?kVbmxs8NijmYjcCBk38WZOH6L6LVtkov1CSqt+udTwQWWeNfL36Fm0Gq0egT?=
 =?us-ascii?Q?Ve4BZos+bSffZ1P87dflaKdMX5jCfAuRKJSrYYc6pyOY/IVUXDypVkhF2RXl?=
 =?us-ascii?Q?YU4rNgfIKvmAY4S0DydT0uBj5GrRmDvCDNdyAikdtuAbwmZHVJA3+3R3sCc9?=
 =?us-ascii?Q?W1Nmhcbt9OJ2/J0Bh1dATnn0DD1KI+F5VSl3bhgVS0sxmi7gjSHrMyOtE+a4?=
 =?us-ascii?Q?j71UpdmPTWBFG4Rgf+3nfU7G7UWnaCJQueEO8ozhUtbS8fZ+zGDQ2kPDTQ7g?=
 =?us-ascii?Q?b5JlPONN2cK1GUlAjrxhaFJSc5dBLOyzPW9+WoCfTaHtmr9WU51qzaf/qZ0D?=
 =?us-ascii?Q?FTmQG/+X/FStj1snOLIT0UnH6i9IvAP7ansNyiJJzWOuhhsttUuBoDKDDUeN?=
 =?us-ascii?Q?RExk/LrbNyj5wfq72HVOPB79EeWIHm22XboyivESfQRh6FYpiGbi+pfmgZXc?=
 =?us-ascii?Q?rPvfhXu6w2ki68Hhl4XD0e7JZVXj5d88ld+jWozFU8F4QjsaJ+ZpvaF1baoA?=
 =?us-ascii?Q?OZqypGZg4bysP/8JxSmOTaw3/09cLER8NDwGZRfdcJggkHAUc6MLQR4Xxs6y?=
 =?us-ascii?Q?TmzCH++NUPzaqKtDAYdb4RH3+yYsUEYuvFeVwvhEcblHTUcihZxUBI9+wrks?=
 =?us-ascii?Q?9lLC4OXtajYMMghrMHKNqpCL5VRSqgyL+j7pYccgP3TRJID3wgD99cjAMA2K?=
 =?us-ascii?Q?SprRVW3E77h/QR711lWy/CRxp5AUyKE5lgMKyKwmvanZGJQ0lFMIBBaRHywx?=
 =?us-ascii?Q?T71Ju8up1EgjQi37KSEyfPfmPOWGntSc9G7V76zHSRsR4IwmbJx4PMpJSi5h?=
 =?us-ascii?Q?kIoWV2+KlQZDA+5xBm5TWdmI9cO/Z4ArnItNUS1ZOgyAbxJ6pGfqvmiBk4hi?=
 =?us-ascii?Q?ReJQAyUVpyFamrTx1N2Cp0qbmU6NW9BKbWLXEn+0yVqeT1Me7xOB34jKvb99?=
 =?us-ascii?Q?uVy/J1pfnAjHGCVvepasyuK9Tv0aFrBkUvAj+/qRvNrRxtii1SYh9Sj0GZJM?=
 =?us-ascii?Q?lGd8Z/7kCHpYw4WupWxoIX+Yzw2a40AJD/PViGkzFv9ALdKQ0JV/AYt4eMZ1?=
 =?us-ascii?Q?klW7pB5mL77etUvuKFWLXsEb4ZbUA2xSVdzHTnPimAAPX7HpqHKS5aul/doC?=
 =?us-ascii?Q?8YfJdMlCLplOFdIwjlsY31loZ2QxKLQFNmbFRjkOlnl0wGfhLSuKL5AXgbrY?=
 =?us-ascii?Q?3sqx/z292HPP1UymjUvOU7/NVN8qerqfcybHro1bLnkJZ6liEwBFddsrAi2E?=
 =?us-ascii?Q?IbgVoMbdf9JG5nC7+2xuJlG8txTHHd0vOihjTxm7bBiOmfwwrri9El9qMHIm?=
 =?us-ascii?Q?fWAf8XlsPs8/MNvj9U+A4wjCXaSrdhMrR+5IHqksjePrwyrWUpiLRnYZuIU8?=
 =?us-ascii?Q?OVXFEw6RWye1oOBT4OWt7ZLOPWxdqUw86jpH42hAskh1Qirp+ib4hAWiB9JH?=
 =?us-ascii?Q?smRCuEjHuKNoxI5SiQMfh8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <343FE19A380C5A40A2A80AA0046A8B60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NGOCNUoMke4Zc8sXLwlHwYgLNRkBh4a/Hfkt6IUHVRnOvNr8kkKrjw0/VGQMqf1D2mXVb5yuYdtThp3YPabpEBAqOqJgsPCCi0aqD7uOj7uO4BEcO2Y1ByjCI0T+LsfCZ4+Njt3/zdji4/7260luyURs3+7vgXVOO8PWj6ERFBZhVm9ZxtQ+okTVnj7dDw/9AVFBMyVIAqgeiT4eoOqzBKWbxhKV7X8v4wiWw8YQ6pkuReCmFUI1kgzZ5eTw/Wag8jUTu4Dm51gWSe++X6KDEL3ikX+vk478bWhWiw754gev57v7BlfxkQNx0NXnyuzVOSrjUWAOXFw7p1Rli+ZNy2NFxAO6LR3qMDbAB/7SHurUFnJ7ljPSWOZOAKCFXbxjQatLLJXaWnxT6TORrQRDOk26UZD0bBjGXZkqVxD09Fs1Lb5gJSLrzJh/0alBfaTgYjsb9WoCPjW48PM7PGpLGjRnTTWlGf3/OXpByzNjek/1yp4szZqqLjj+8/8XtbdblXW0sUsDBmAFptziyIbVTc/3zbXCVVQgq1sdXxo3TdIB2p+mRpwzU3yD6R7VQ3TcjilX82QKaW341vDk2XkynUmhSCmD1ZFph0JC1X3f6ddrzcvWZGRgiwERcAunHOsN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1efbad-bfed-435e-ef2c-08dc1c006511
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 10:45:20.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EgW0cSDyLVZLQWB/P5yey/IZ+HZWaJmi4g82g/fLv8UGWn1OeDo9qNEcjB4icI36IqoLqW4dXZ4zHIMaV0XjSxpz9bi25L8R29zvWgeCW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8461

On Jan 11, 2024 / 18:00, Shin'ichiro Kawasaki wrote:
> The test case block/031 now requires the loadable null_blk driver. This s=
eries
> allows it to run with the built-in null_blk driver. The first patch prepa=
res for
> it. The second patch makes the change.

FYI, the patches have got applied.=
