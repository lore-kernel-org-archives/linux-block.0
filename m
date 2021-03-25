Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1426C433E2
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7061561A1F
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 12:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCYM0X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 08:26:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26904 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYM0P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 08:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616675193; x=1648211193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A1GjdpgYrwXJdEZ/2KmP9tg9wVMVTywluGQRWt+gauw=;
  b=gKVNWWHA7wygnTjWo+ifYSSPAkzyCD/gFvX8IcHnsD6CRdUey0MRmDWb
   CdWw8TEOQDJctnl4IB4nA8Gi3ZqNUu1JUw97CAx8QJtm1VcmAUHOLi+pZ
   0k3lAiK3qOES7QA/KlwbXeBC6n2NbSnluxLfduX+BIVT751uzWRLu5k0P
   2uaGkLqe5aib7fUaTHP3el+J3ELon86huAU8bXFkagEvvR0azOwR05z7f
   pyxSdOvaipkXSDtrFiSHy8BeYxgbNYKyZVS0SOBiSt6fpG9KLJm46nhYE
   PG4UIHFhM+wbAjk9Nmwj34e4sBoBfDVL3AssmE4AyqujJB0n2TT7OXNtq
   A==;
IronPort-SDR: 49Kn10+XbDZkkt6wLvJILdjFGNUEaiVZvCHgPuZjALgSg4FLhSc7Fv/jnZs4PP1X3v9nzdW+E7
 9n+X6/n5kgwjn+Y+Ft1MReUFlLFyam33ISq/v80K22DA1XVJ/6C8QSvnIppzLjIiP0nPTOyBqp
 J81c7+rQU2aG97P2Ry5j6yYCGSVcbIeEr7cp22TSLMPtBERSgdY9pr1s+yWy1nPmJS8QlEXQTm
 Ms3JxEWKuCtyiVW3rsbKvBFmD+zZcVxj1QD75tfqex5kb+cDpmic3CiUN+NJYKwMZMNZP/i3Vl
 w5w=
X-IronPort-AV: E=Sophos;i="5.81,277,1610380800"; 
   d="scan'208";a="267406325"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2021 20:25:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/xgjTm5U9uvMv/oSYAfODKC4NnxOhf4deujvO7TGVvsEuHGDKmpgZxk6zBzsytPo21xyYRw+nNmsCH6O9KaQCtioJy/Fm26hoh+2nwLfdeJXUjPSgVly0vzd2nHr98KGdHR0x8cVFdDmgsmXLNxy87j6/TuIZTbYD7Rlg4Ovc6mzkilgqLyOo6j08HKs0H2C3kjH+oe9e6Oog8QzMcQuP8ArJ/W4ZfRM1dnI0MXNr9Tx/dX7O0uoqZxwfofXeRI0rk8YAZQTLtf5btUmfTb+wrVGXQkowEBYK6Iv8hSuOEraHycgkPPE32PofH4LVYKKRVZjoKUxC7IWroOO8Lr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GjdpgYrwXJdEZ/2KmP9tg9wVMVTywluGQRWt+gauw=;
 b=lsmMwa+iCr2wedJvqOfSFewJVtSomMoHOF49zZT3nSqDe0G4ZqqPYe0/blNlM4GMvG9RKWXllYZCyNzC7aC0rthpLDiDY5RvpXRjL+RyAP2t/CjX7ZArNiIiPWoadlEq+nBwcqkUhTTTEFHdk0WeM6PZQaljM7LrB8WTr82Ikonw+3nhrQOoe2ee/3c8+fyj1Br0xpU6XCq85P+30owGaxfFpHznF6LHUfeUHNwKYnb9nc+e77SVdkHzyogWNBtR6TYqbraxJZvk0pW+yt5smX2X3ohWU9MZfd9vtm3kcCaPW8aU5VCwvot81jAYSIr6/RoRxs7gnVcyh1nn5cV8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GjdpgYrwXJdEZ/2KmP9tg9wVMVTywluGQRWt+gauw=;
 b=e4cXr4nM/W/7fGjEBlvay4bLtYUV/TckO3WRS4CgxW/oiBDIuXvUi8gdnzf4Erw2UW/Xx4yeFTMV5ipgnPPc0oDD51oxe22H1Ta87W+jIcWWQ08Lr7bFWIYnJ1uR8ihCftaN65r4GjD6zp95siT+P1VJ8NNmmwPbioPpANmw1cg=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM5PR04MB0349.namprd04.prod.outlook.com (2603:10b6:3:70::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Thu, 25 Mar 2021 12:25:24 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::f0ed:1983:98c8:3046%12]) with mapi id 15.20.3955.027; Thu, 25 Mar
 2021 12:25:24 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "javier@javigon.com" <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Topic: [PATCH V6 1/2] nvme: enable char device per namespace
Thread-Index: AQHXIXHt58TcqiDl90OEMALlWkZSkg==
Date:   Thu, 25 Mar 2021 12:25:24 +0000
Message-ID: <YFyBM1qq+AmYQvdl@x1-carbon.lan>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
In-Reply-To: <20210301192452.16770-2-javier.gonz@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65e0c80e-9c0e-44e1-a3b4-08d8ef8910ba
x-ms-traffictypediagnostic: DM5PR04MB0349:
x-microsoft-antispam-prvs: <DM5PR04MB034936967D65DD9EC0049C71F2629@DM5PR04MB0349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nlFy589mzHZHeRN55UgigPVAToG+mLyOJaxXA8UupTAsjSRzCYlG7u+EzNL5/aqKgpkdGk14gnXl2CCcSLttTkgoLbF9Rq0EG+nU8M1ghWy7UDlV0E09A948QHZSLUlNg50bnS3UFhqATVFCYhBgBiSCbBIj2Lz6cJ/Re+wRXaWbX5N0YF1tGfWsS1jWT2p2GYayLYOEAcTb9R4cX0le3hQz12Uy8BXkg40LPhaVEzeVS90tmFJQLmp18IJwizm+C38aV59Id3Efif9JUQw23uYI1mVBXSR/YB3+VpgHnj2ksovzJf8TkmF7g94xJhzC26Ht/b3aUa3bS8vGaYSx4HIDlR5MsW8iDljMN571b9+fDxjvRFJStgzGpwcEhgtlJpWlCfsgqM/0fnL/L31tMrvJNc1OFMmKScskUNFBgIRjmw8yhAjQvhwhFS5uBtdWFF7pl3jWMHYvWpx0DtczntM8ynpFJxkLOqe9/sxpn/OxAnqQG8oGC3LPD7BO2iHMrVATaxxqQAxCXMTXf1h4U6uAX7rPNM7gGoykQnG3VJh+L0saOyXJ7f7zAU7TWT3SdqvPzGGlOy+4Gz/+emYGoKcPZxw4fqJcSWdhybUU3JdgwW20NouTCho+AnCxRdTAixvwJSxks3rIXkuQk8QyIw75SYc5AFxBZMZ+2yZ1MNjFznREg1+mY4cQrJB8HLjk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR04MB0684.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(66946007)(64756008)(5660300002)(186003)(91956017)(66476007)(54906003)(9686003)(36756003)(26005)(316002)(4326008)(76116006)(66446008)(71200400001)(38100700001)(66556008)(6486002)(6512007)(2906002)(8676002)(4744005)(8936002)(86362001)(6506007)(478600001)(6916009)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?n5sUB5RWx9354e8MJH+yHv8E+oPzDFVCGVOCiN9yi3Q8NlOxi5vxJ3JEtZ?=
 =?iso-8859-1?Q?PbG37GYH8ooxz79+B2k8fx2GekdbrjhXZhgd8ktS4fKFMQOEA4tKoTPdez?=
 =?iso-8859-1?Q?Udy+8MH+yZXDVrRN0bHlt7WDPg8e3WAPVNUkdPOOeGAn4Iof50BCHc6goJ?=
 =?iso-8859-1?Q?hivF+z/vpR3ySOCulC01OcKc/pzJmCnh4CtZ1SRyBDSLKtqrBOGnZb11WZ?=
 =?iso-8859-1?Q?ttEOLOWvrQZW0SxR4WA4S847Dk03j5w8y9239t/oHPwWlWlXBBCqSyy/hY?=
 =?iso-8859-1?Q?9EIQnOgfC1LmdGP1BUyw7z4AaWS6vX2cOHkU96a7aolp2kSgY+1Km2XExI?=
 =?iso-8859-1?Q?yQfgtPq4HwZjm0ZRXPsmMEEfyfbPnBX/dnr+S0x+G7JKRTrxB6hxDDmWZY?=
 =?iso-8859-1?Q?NvexkAKpXAMvZYMMqFx9bzOPzdL6NL+x6Ouus7UAYvCMdk0kmS/tcqGepP?=
 =?iso-8859-1?Q?3XWjfMVHqj/GLsvhvH6qhsRHvTUCdBTGMXW7pAwlaC5xCzx8xXcguk7kH6?=
 =?iso-8859-1?Q?u4jtEGYmZ3Dr+Fz/+D0yVDcXtRk/jL+a/1Y4EtVMfjUK8fxD57orhCX1Kz?=
 =?iso-8859-1?Q?XzyzhK4IuGVy5+7kizfixsSobn2Teuw0EROkvCb9V6QwzV/LyHSkno8smp?=
 =?iso-8859-1?Q?Kjik9aLAlkBavZ1NepWUIJUIa/85Y24E+DeNbyDZM7s7hCHzZ/8RtkKcK5?=
 =?iso-8859-1?Q?43YGi1tZBM26O9/0ulmnW2o+TYdWRS8pe2x1BfER1s6xQnhu7dPvWm3gNz?=
 =?iso-8859-1?Q?MlTLnPZZq2/mNGCC/kezIdqrPR1rrMriJZuN8zNWYvi8xrVVgNEpeOLLyR?=
 =?iso-8859-1?Q?DmjPPdoqKC7TEkR0tjYXcSc0VPmUO4TSlBR4WMypWNerdsYN41Q/KSDHZE?=
 =?iso-8859-1?Q?9sxkH0+LuyTnhYnB/qtv8QH0r2rTEvqicnGG0G0MIhOtgjFJar6X+Dsmfq?=
 =?iso-8859-1?Q?RmRr/8QIgaI1hS82257Dj8PSBToJueCJrIAzklFZ2dDIZKU5Rm2iL1Iu6I?=
 =?iso-8859-1?Q?y8PQBWVheOXxBepRbBd8AkO1tN3YlB6Cq0CXxsl1wO4WV8Ibd+eSkaw1+J?=
 =?iso-8859-1?Q?QuzeZXOstcm9UyV1eGbZjqR7KH0M7ph6EICq81fp3QFuwOhhU/a7yuD2PA?=
 =?iso-8859-1?Q?I0vCZ3wpJei/HNKgpUAmLEGknq7qXeBPIbwJr0cT2ge+9oOHb/2p2g2Hh9?=
 =?iso-8859-1?Q?UgFPYf7Z9GuU0JrLqqDg0yptnNZTccLeFkqdZAH8w3U/rVxCcldXzlzBFB?=
 =?iso-8859-1?Q?uMaYeHMJXTNY6/UaCNYaDiU55ywYjpji6QEFDtHOq5ACW9lbn2szasyQ4b?=
 =?iso-8859-1?Q?Tr5CqYdI7LJvZ8eOAv1KTfiB+BhgPTEK5h9oFQL6//ZMCqMfQ049UlmUhq?=
 =?iso-8859-1?Q?EJ+77jzEhI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EC5A095E6A231543BA6158899B6134B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0c80e-9c0e-44e1-a3b4-08d8ef8910ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 12:25:24.1780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/hjKaTCa6iVLpP8y3kzgtrUXv5BZlZenkFqPqLm6sInMoghsz1CtvCFT7taIPebpfyE4QaFc356Kd11emDhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
>=20
> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
>=20
> The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.

Do we perhaps want to put these new character devices inside a subdir?
e.g. /dev/nvme/nvme-generic-XcYnZ ?

Otherwise it feels like doing such a simple thing as ls -al /dev/nvme*
will show a lot of devices because of these new specialized char devices.


Kind regards,
Niklas=
