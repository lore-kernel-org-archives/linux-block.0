Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9FC56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721AB20DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A+a6WnOp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xi89M0J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKZIkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:40:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18352 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgKZIkE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606380003; x=1637916003;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2mC32DNmRPm5xvXtwtrH0MRSXNsXQncq6xJXJNTEsck=;
  b=A+a6WnOpFIOCnXJwLcUQ5LOgj205YQoo3MgyAvCe7oP3LezeyuiFU+n2
   1BdHz2ArCY09YZD/aB2MAANNbBZosgeT1llQHjtHW5icy+gGbd+/BEaoD
   OOaArE+/ZuNf9x7SwtggZEBYJRQ1d2MI36EohRM7AtV6SKOxYRWLKkuGJ
   OlHr/9Zr0GrC9szD/BH+Te7tmHRAKSI2rD/IVEOX2iz+YvzQ4oS0InJeE
   M5zoiCepx0ksZ1ZZGX594bL/bm3JgqIVgMsE9i+L378bCi25o4asIWUYU
   +M8IWxUTstL18GNxt+fBYmmf1D5QQqU5Wqn1JwplgkvQwEr8lJ8R8tEAX
   Q==;
IronPort-SDR: cIvEjW2ueAZmsCsVh7jlDbKIY0AD6gFeFb8f+gLE0vnqhQ/rIIfwk7hSZ4WPD6uXZQHX3ctm5s
 /hgxCyLp9TIXfmNMRcK3tHgcHb2nmyPQwNo+Ye1aCYsepzN7ln7PEXCDEHEgHrOwr97jjN5wIW
 B6YgOQVQGO0UZ/UqZPMyhluwl6m8OBvycQNeftKCXegz8fQ0dbwje2IpQCVJMZnYvsRyKjK9v8
 erJRzirkVtdqCQUNnMW4nY4D7ehbCqOkpy9/gM/PdEk9cEGNHSo9g15gFJPkkVEbIVn7y6eMmx
 I+A=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="263621795"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:40:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHgBiZXcm73eneSJ8gtFJ4tUz/7tNVVgfUFajUJOfV0g/SwuiJvJ5O/msRYqCCahZKaG+kwMF+rM5l4B3kwfv7QjfGBhjpBprCGVw8Z99RiUw8WwNXNEXmoknQdmg5bL8Eu7e7uEdCUh/R5Ey9kJ3zfviEuNWnSg/fkOPhjlycFx6QB/z4MoNapCLGG27VI3tSfpk+Z9fODTPrtLW6fQG5g1MG77OcpudinfqUcX2jpoBwimeJa1RB5SjW6bB6uFMWswM3Nr1t5FCjMIZQAQz2BYjiTvkWir8ZBUpcCq58noJNR5/IxLUDwY/wHzXrML2av396FtBN8IT1zT3Z0/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJw8O1i95lrEpK5tIYKoU9LWf20nw99r+u0GIxoRVOE=;
 b=OvOr+5mtHBB3qpnnai+QrRDqGu9jEpKDlTQRRR3XcnMqz4eYNcKx3q+CeXy6SZirbMQzzOOgyuwEbHQ7wjYrhWe27SZN9edN/RmlC84XckprIxDCLX8Pzx5pvdri6GhI2nCC1x/MPMRP5rz54ifJhhs/YD7s1iiS4J7bRiQgb4exWxHY6mfJEq+67jYREKNemWUVEQMtGsGv3OITLquY59xfu2YMtDy2juRqB7tzoul9wrDrmrkN+sN3cutCT+pBph/+Ax4jeFloQo1fTnqWYvxa6EoOnBs1MdSSULyFnJoU6gGDqG6TlslzNICb8CPNWA+RY1PjKHmCksLeQYzVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJw8O1i95lrEpK5tIYKoU9LWf20nw99r+u0GIxoRVOE=;
 b=xi89M0J4WPxR8lPpDjadMCQ+XDFuDgNYSo8HJcOz7gAwtdEshbIF8bWGHWIaS0ugxUjxiSa/gfA128+paVt5Rta0VqQ2R2xUOSS+QVjoejpYV9YSiQOovk+3pfGZUB46pUqxyCRcBQy9NnIc33CTzD0l4snI8s8ycF8VtC9BDSA=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 08:40:01 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:40:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Thread-Topic: [PATCH 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Thread-Index: AQHWw53EyVrFDensPEahWhqZAwj70w==
Date:   Thu, 26 Nov 2020 08:40:01 +0000
Message-ID: <CH2PR04MB6522CAB48E0507730407D012E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-7-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25a32b4d-15f8-46f5-44c7-08d891e6dd87
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB69816A017B269733ED3A9B9CE7F90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4E7DAgeuLe4en3kgCXKBVEh/4htIaQ3XLY+AEtVoTLSyZg4VtFWQbGEz2ZHy810rFiCOXPUDhCMb/gRzRFB25ckDTQHlyzolpXA6vufouFqgAfZu1GMFguK5Ahx/ppejewWMbtuk1PfCnAO0mpOkr3+/vFpC5msK9n7arjGHUe837SzCth/aTBtgGBik61Zc8u9VWJb1iYBibtkOk7/gry8NOPJd2GWfzBsUPdgdABQdjy+Izhnoujn44CMjm9jBonEhRMTs0+vx43qWucK7KsX01czRlnHe/mWYWbk76/kBAHOH4OjMeObaExCxSK6U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(64756008)(66446008)(186003)(4326008)(66946007)(9686003)(54906003)(110136005)(53546011)(6506007)(2906002)(7696005)(55016002)(478600001)(316002)(33656002)(76116006)(66556008)(66476007)(91956017)(8936002)(5660300002)(86362001)(8676002)(71200400001)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qbFYcWOhd7b2Dr1Wvsy009mpJNJb5fL+6deTonov46hDA7Io4tPmrcfmp0FY?=
 =?us-ascii?Q?jIHRWlswEv8mXGbkd4fxrMq0wvNFVoD3WnN+ReqqrKNldgxzzJlr4c5K8yOO?=
 =?us-ascii?Q?0tWRojnyElCJxGBcfcu8/m0J02Bfzzsk4StXObYsVjDHeSPXhLQlXfLiqTkT?=
 =?us-ascii?Q?gKji4yU1I4SR+mWqTS6IMLxz5E9Y8YOCfVqMmow62kzLEsGsCyRUDJrYJQmI?=
 =?us-ascii?Q?n7qQmgiRE8r9ZlGrv6cQO5qA8z3uxjH9Q/3H7geBDmGwvqH3lF3B2ZZEmd84?=
 =?us-ascii?Q?rTbcMjwAt/3MFE2vPlh/XkU2Pcij1Efb/ir0ozybSJXuFON9v3p58kMYPH+p?=
 =?us-ascii?Q?ylOhBpxYZj7L3CzbJrbxCQgnTnm8Qnpl+929XmBvOacZPeaHBwwt1vL1x4YB?=
 =?us-ascii?Q?sNUptwANhxF/dxfZZ1me2C2aSMTNmyJzsoXDVrP9+fCPNiteZxKqemjnqYaa?=
 =?us-ascii?Q?WwiMJBfgq+XInECdEUhLdKyf9QenmtDqxHBHAEPJhaGVP3OB4KYoLBcdz6M1?=
 =?us-ascii?Q?WnF1jFhbT2j0JIvoZNFMTSAscECAfQbzjYcdH5kvM7tawxmfxZ39KqU70PTR?=
 =?us-ascii?Q?bfBjQSxRx+3jFA6c8a3z2mA/tjwhu9VZVjT0T51UuttS7dlHaFfnQ/lacZ6U?=
 =?us-ascii?Q?K7RpOnaaec68D3Wsx5FMTVih2KQJbWNfRMSLbnxOejZheU2bVDLX9ZSaCIqu?=
 =?us-ascii?Q?rVrLSqKdl7ZNv7XwbAbjE7/Q8oxIpLelrF6qSYKi33pOk2xavO8zTWZYR9B3?=
 =?us-ascii?Q?0QtNNPcTdLwBHl5yebog4fs95NFEg0nwJ/Aqatjbit2cWGFAOmsKoExC1kPJ?=
 =?us-ascii?Q?WnfW0Kjb3DnECQjAVadbKHdWxd6W9OozLHvvm03nlcKROiU/w9UQ6EhjpoSS?=
 =?us-ascii?Q?zupDHMrEOpNxQtcgI00pJhTloOPLy9iRptFjTh1fwY29RDLlGxYtiGJLg41G?=
 =?us-ascii?Q?ZKmFcZe2wYWaEcRp9bZ7ikOzTJVlmu63WxT6Bc/OlT17DRGG4Cn3L55R80HX?=
 =?us-ascii?Q?bRYixcxOs+iFXTdRdeBvsghOTebbA34y1pNT1hCIDj1j2xMPFc2/FOXlJnfN?=
 =?us-ascii?Q?aUGpmrBE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a32b4d-15f8-46f5-44c7-08d891e6dd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:40:01.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CotcgyTBQHLT+EhRbV5B14tXx/vycdWwvr6IQXrYijBjyWgCO21kSLScghprzi5JyVcU2215nCs+ABLjLj8DHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Update the nvmet_execute_identify() such that it can now handle=0A=
> NVME_ID_CNS_CS_NS when identify.cis is set to ZNS. This allows=0A=
> host to identify the ns with ZNS capabilities.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/admin-cmd.c | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index e7d2b96cda6b..cd368cbe3855 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)=0A=
>  	switch (req->cmd->identify.cns) {=0A=
>  	case NVME_ID_CNS_NS:=0A=
>  		return nvmet_execute_identify_ns(req);=0A=
> +	case NVME_ID_CNS_CS_NS:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_CTRL:=0A=
>  		return nvmet_execute_identify_ctrl(req);=0A=
>  	case NVME_ID_CNS_CS_CTRL:=0A=
> =0A=
=0A=
Same patch as patch 5 ? Bug ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
