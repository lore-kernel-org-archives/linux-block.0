Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1182EC61DA4
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 02:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBJCBZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 21:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBJCBZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 21:01:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D359EC
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 18:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675994480; x=1707530480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S0EdnpW/Tfx2KYMQoAApvpfcCuqWfFF6pYSmD2ZXIr8=;
  b=VxjnWwABLG5iRuPrpBbRJHbIM4i1VCAecGTRos7ibH+0pn0WNC2qAj1P
   PDz3U/lieCvMBfrJ/HlcAlFNIR9O2nO65DiKe+qucrL2USmN/ItHRu215
   PXsSLAqnOxZbbrvLWk0eK1exG8/a4A6Qmk6zEpY1bCrRi7RMSFFF9K8F4
   eJjcEruvIMviyrpGDna+JoYf4Q7ooGXF1ViQ3VMZJ70q3F36fkO9CWGnR
   Y61U0W0qWCezP9IbXwLSXOYvWNcA0DGtIrIxEe+IJec7q3BC23wmR/HEL
   b8eNk5qFvSBzYoPgtfNY/izoDpeoFr73c0JB3p4yNynyn8rcNdG0sbq7S
   g==;
X-IronPort-AV: E=Sophos;i="5.97,285,1669046400"; 
   d="scan'208";a="222760479"
Received: from mail-bn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 10:01:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhAIxJGxNobMF4NLYhZcwnYo7f0aWq9MLhwpDI7L2J6wKjLsF6fjJoEtbVX1KnZS0QnVscr9S0XalWG1eG2bnm2vDZfx6ofiKEoBig5vJuyswjHgpN8+69FmTzcBF7DzG09NmVgUWYgxk7uqH5FrcxPDtBnmrCNYWN2k5bPu1GkuEPq35sPm/NrlVfWyuwxIAfvbkbmaPCh3QJviQc8uqEajhWqQTM9UpZUFCyeOynKcPZjVrtDLj0aseZOOHJ1PIob4+VmxQcNFNrxONGbIDeQJXFMEVnCIG3irJTdDcEMnIowUJBZmEgj7SO3drosTQXEwlOb2pTPSGz75z9t/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0EdnpW/Tfx2KYMQoAApvpfcCuqWfFF6pYSmD2ZXIr8=;
 b=iUmdBHKT6kUQF4YVQfEwPeUVMt5hA5x+bYtJCfUYoF/ci+bse3L5xVm/mxCCaeMXz/Acm+NZKxlw1gRg139Fswu0gx00CgrqRYKGtydQcRfKzxnoK+eaWfx7+i6xY0BonPV3YTpXhX9NYi9/1ZekoZr82ztmllXI1jBUBo9A8R6DZ2LUbMEgfeLUCRqFLI9J3hwZ5gqbNagBDoUK356bMTDkujqbK9tN2r7IomcrTq8VDKv8HAtj0+7gsbdXONymzRxgnKNFayj/nBifHUbda+DtVqIQoXDVphnQJLEJluHvkyMdVdq0FiCsHb77mcH+xUCCW0gdUtjTJB92RL1Hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0EdnpW/Tfx2KYMQoAApvpfcCuqWfFF6pYSmD2ZXIr8=;
 b=nWi8wBP2v9trYxEboyNPrL7KsHxp/5e4L0ujsBK6AEnyM4NmvGQZHhQ5jqd7PThudb4sUtt/7KFLVCZiOA9jzljftqrjXuYesGeQM5r2EQaZ/MpBQhftxeYzX8TbgzFSz+mdeGFcAgLNLlbq2M7oIAv7JjYZJNWzF/vqRSKDmmo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7774.namprd04.prod.outlook.com (2603:10b6:a03:303::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.20; Fri, 10 Feb
 2023 02:01:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 02:01:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Thread-Topic: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Thread-Index: AQHZPGtrXToTKK9KXkmyiPMPihGYAq7HbkUA
Date:   Fri, 10 Feb 2023 02:01:14 +0000
Message-ID: <20230210020114.zzmazatkxeomowxq@shindev>
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
 <20230209094541.248729-1-joshi.k@samsung.com>
In-Reply-To: <20230209094541.248729-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7774:EE_
x-ms-office365-filtering-correlation-id: eb8776e6-93a6-4b6c-1884-08db0b0ab0f7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xP9YMKlbHslygYUZwGhB80qlKfOf3wrybmtCT7ci2wqMSGzVK742wwRdwrcVm8T/9RYqBCO458WzAKEUfQibdTSMOA5xyzGMXS7GYY0+aV9BfxKfc0n9LNhn4wGGS/64jX8lSsKnKb4QjaHuyo7mnLdTXRmR33L5O5yexMYrcYWlZf2FNT1FhwYrv2jaHlEVmp5vjWkDMi60263szfImg7jdx/tolsXyn1JlEVJB2Z/3Xdwx9f+oapbUCmFpkpJCrrlUabZOTHCWSlHMYhxyGRGSEGr6bfSbV+9jePJh1JkI6JWMsUTyrsdfMwHxvBCV9bZ2BFUH6HtqlrY1U+XgCDR9VXpbYo+8FoRePYTin77ql0gwOF2JaKXXg+VCMPE8q7YJQjAIlGUNJlHAElN+Kt20P3vViSbaxEfIQXClrcp7COB1AOOg1Z6OAcRFgYRBYdMAZmAC72S4QZIjYWKcCfLP2jlQjcK35USHuZ0iNi8NUJ+j4x/3GoAvZ+WsXkwUmiRTktgBDdXVUZe3kJ3cRHJ+575yrSFtMr86FXTrH+Cu0H2tJB+hzgL3zDrw5HITXkOau12+OLPCqKZOCBM45eoChhGF/pbr0R2cdIt+fHAfUG3jdApGEUoIAZlms7jD8HtjBM2Dghb1k0xrtRb1GfxVkTgGtSaRjBBmn1H77uyhroJddc++nt7c0Q0rPLjW8T3Dbkx9MSqgHD9U/y+kAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(6486002)(9686003)(71200400001)(8936002)(5660300002)(26005)(186003)(478600001)(6512007)(6506007)(1076003)(316002)(54906003)(44832011)(8676002)(6916009)(4326008)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(83380400001)(38100700002)(82960400001)(122000001)(86362001)(33716001)(3716004)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WNZpGsNSs+bx8NudvPWIrVKHAP7OfuIuyw7tF9oLQ6eFT2USC2NTaGEAlxS?=
 =?us-ascii?Q?YI9DrruMaB5bTBNT7FKhSAnLXuNcqEHAG/lDjZnBGZcc6Xi3bo768IhMK7Hc?=
 =?us-ascii?Q?Kz682s0pt1/tfLIHIF5L+CiTd4746Tie5OYqIf9WJ+i1Eh5IRmBh7Xy8s7zx?=
 =?us-ascii?Q?k3OXRVovgOyBikxEIFFhxG5hD80BW5bAcqagHQt9BaOdcHPBP1b9Z2ecIX/i?=
 =?us-ascii?Q?7ySbFpzGRrTwYM9yo4ErL+4dGiPGmrbkqiNN1TAUgscSt+9pVpeqnWR60uir?=
 =?us-ascii?Q?1vgTx1UeEgkCYhB+14YlsRLU+4fSbgspwFY0cG18tcU3wDwDQ8HAT7Fuv0KD?=
 =?us-ascii?Q?u0GyqRBDTi8zpK7EziPO0BH2xMVNOBV/O33m0Inrtx1NqdVTHHLmmX5cxqvF?=
 =?us-ascii?Q?3BL+LElrdwZLSfb9UgNDXrl7nhhsqSLxkm3R7PeY92pNePw8AUrWUWdWSA0g?=
 =?us-ascii?Q?JH33KSfwBmbd+pMH02bbm/CmuwVq2CXAwXa73fTp88ZrPTzqNL3OHvuHI4jG?=
 =?us-ascii?Q?BnaA8KcDohsRMW37caGe7oV4x2flIb2wAHkqQAXB6RkPWzOZViVv2QLy0+m2?=
 =?us-ascii?Q?O2sEgEgLlHaYWYZ/2OD9cOdL1qdl38joUwZf+mCPFkwBaqvIV8lu+80leE4z?=
 =?us-ascii?Q?EaqnUiNG7wkkup9BSLn0Z//Lg/2eklX3KpRQJER+S4GEjuNrYSVFPmcPikIM?=
 =?us-ascii?Q?jkiHcOLcmJe3Onkd/Ea4bpZepwsRNlc5GEPKXrEwOzpaQXNyKZ7qEQM8niYy?=
 =?us-ascii?Q?RrNV6vDx/2DhThkHusDGtTJchnj93XFqlVUaJGykin1b//SC7zVKF49ewXyl?=
 =?us-ascii?Q?eeZtJwz/LAAWBb7ucEI2KHt2Yk9W3lNCTS704cghm5VwZLcBXf+t0iDJbUl/?=
 =?us-ascii?Q?nQa3aSNVQrrDcJuGnSGZATln2rHh88iXvBRw5l2Aji9BnoYUF/EDuFPnLEuO?=
 =?us-ascii?Q?ZVkeVo5mP/fn4bdMtXkJH8UDAdj+XEnIdpK1b7nU/QtRzGKXtVhKYorLtypN?=
 =?us-ascii?Q?qPHOL1xD/SL9UkhvH5PIE5ztRTPHQ/dYiWy0v/6RFYz5LvgwSfAYs/fAR3zE?=
 =?us-ascii?Q?OUYSYxydcECSVDhLFrtvtRhLexIm1x5kW7fHTA89QI0Jdo9NGUflhmU0Oius?=
 =?us-ascii?Q?4AY0Ifsi8AD+xedzj9CgvWx1xr4HbF7unhHdKWydqxcW6Fe6IqMdxBexGKpJ?=
 =?us-ascii?Q?0BoDRJtI5uPxhAWf6DC33VafgXDu3syZoZuDHEgljB4jpiAYZr//Y+B6BQMf?=
 =?us-ascii?Q?mbhyGsxIaXIybvgsSF4fLneWcDdS+YlTMF8M2kg/+YEVAznu8A8x4WwlqXAj?=
 =?us-ascii?Q?J1o1ED2xBt5dedw0YIzjYzhCIz9m7JBqbdDiTZeleS6HYdSowv/z8t18sPH/?=
 =?us-ascii?Q?ScNQpnHJa+nybJsy8ukvEsQlGrQJrUd3a/HH0BGh1zc9UPuqxiczPWwlQScI?=
 =?us-ascii?Q?S0jjhRBF3fRT0bkW/KvEC5W+SFTQC/2JyT1KFblQFjLKnmBrwomEe3IE9HPd?=
 =?us-ascii?Q?jZN0TJfM7a4zwXFGiyvezF7Mztabg+KigqBa8P/jZqZKb8aesj4z31332Yhs?=
 =?us-ascii?Q?CJi8yplhQsHLZb+vzC4tiyFwmPilE1wXymxV613GCRItj4vIBj/GfntnnrGl?=
 =?us-ascii?Q?Lf24+kBE1NqZR8chfiuWkjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E352CDEEDD70324AB225CD3C5D1E1B8A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ATpGqlmV5Mt5jp6t2tBa0J1pi/gUo/EftCq1hxew3YoWu1ZWwxY0rsrNZMN8cPFPsyAMVvlJYFnYaZ385tX7tmIJkl+2pKeg9twse+Q9/4hYmPiO7FVH0hoBeOqo/9g4tn9yWzJ9aSZs5EJXmzuzz78BpMPCpOAs1XIVHDDMo87bXlptp0xPMICU0p8TYorJsefwm06v5A42ZU9e2Xdeqr8CSK9oqJcilBCRZ3UB4IZLqJbsz+KD2IZ+FAEu/iMkZNoXMMCUQlEqeZR6U9VrencJ/cHgM1cHnm8r+JDFIm2pj2F3qoxj3qnZ+NZT0n1UDJctt6wVvwlpD7FaIlFchFUEMinjzKgPE2J7H3yfxA2LzuuC4fwNEDIPYlsQNXTD/Y3piMTOFxgW7oVA6u1LGIQhEvXhPqDKfPXKBGNZvAmFnZjs1MAQ5b4Rb8I9XZ/kXKbjOh/Xz7Y1IPf5purtxrriUvtEErXitEBLdDIkrXDhzxsJJwm5l+CyhlnsGjJz7F9prIoZDCOCxHD/2jePki5JVyEur2azj7frVJG5OEaimQw+WMOEaMmlQDeO6QL8J8yVaaiUh+1TuFr3kIPodWXjuPT2BFgMAn7V/tZogiIvEKJT4Pn4e8I38Tl6FMU0lfhW0EHgZy8wAKKVimlyf9tDux9yafYIIv8a9TK9pNZpPIcHjs2o0O+0TNjNL7opi26ybjsVFe3sDX4xEcFK5ExIjOpy3CISY8pvwYX6opq8NW6i0qWEgR6/0UDB87PAVXZimtgvmJh8r1vEdNOvQK23RcbGunRVxH0x4xecY9ydRs72J0YEzI5KgANAPVqyARczjBmX2jArnKJbyy5YigtelgWx6Cp+LSREEFAkKZyp3I6q2h0EVYt2u95vq2uq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8776e6-93a6-4b6c-1884-08db0b0ab0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 02:01:14.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEosqRYBc4osxveTMWYMfmyYzmwsImCQ8orJzAdNbnHL4AtOJzNKJ9H2OLKZcLN3xETB/2h4DGEkO88v/ivf+0INCvJNqY67+9o/i/d+spg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7774
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 09, 2023 / 15:15, Kanchan Joshi wrote:
> Ths creates a non-root user "blktest46", alters permissions for
> char-device node (/dev/ngX) and runs few passthrough commands.
> At the end of the test, user is deleted and permissions are reverted.
>=20
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Thanks for the patch. I guess this test case exercises nvme_cmd_allowed() i=
n
drivers/nvme/host/ioctl.c. The test contents look valid and good.

This test case adds and deletes a user. For every test case run, it creates=
 and
removes the user home directory and touches /etc files. It does not sound r=
ight
for me. It changes system set up, and sudden test case stop will leave the =
user.

I suggest to ask blktests users to prepare the normal user and specify it t=
o a
config file variable (it can be named NORMAL_USER or something). I also sug=
gest
to add two new helper functions: _require_user() will check that the specif=
ied
user is valid, and _run_user() will wrap the "su $NORMAL_USER -c" command l=
ine.

If you don't mind, I can create another patch for further discussion based =
on
the suggestion above, and modify your patch to use the new helper functions=
.

--=20
Shin'ichiro Kawasaki=
