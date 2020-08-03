Return-Path: <SRS0=nSht=BN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A46C433DF
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475AA206E9
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 07:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EwKJD8gV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m219D8be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgHCHMo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:12:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9585 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCHMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Aug 2020 03:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596438763; x=1627974763;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QjTZ2J8kJkOaJ7xIcENYTPj9MvBigSgLVrteVAcaO4w=;
  b=EwKJD8gVnaWO77YgrtImqnWD76DExwZTrqK3oU/W1fgXajjJ1IyPVS2g
   kGJnKn6YCQFZWKV22ShqA7TE9V6EpKagJAuQ3YBqlJoFBqBT3xTZ2edL2
   +on1LKV33l6izUj4rGA6cWDYbIy5Uhj/hD8yqOj4caBVsv1Bn75nu8EA+
   ZJUyOE2tHgwwJdHbXcKPHAOKK9FDGh+jGlYrWcqyjVr2kPh/M7CgzPOIN
   ZF73V1NeFnJOJ/1a3ZoArcPUqZbXcfhF7GHWyn/JTNaursWitFKPXDO7e
   +jWsKra92ra3js6+W6PbOFPyjFptblyC5K11+i6Roj5b1ZaiFWLeGk8V1
   A==;
IronPort-SDR: lp+4EKXWhP9ZvpkUtMu9mQe8RthmwB9wxVXKXsYUXBy9vFnQFkxnZxxF4zQckVF8n4JAfKhjlt
 M0Vg5/UDOM5d0q5KjPzxbk/eNSqJqxd/jAqaj7/amIh3HFyg8zIuAT4VfuGDDBdaeJN8eIFDL4
 wa8HQ/sN2AryklNpwGFZ58er96T8BzxfbpD4m8cN8JraRKvsVOUh5n2ojzmIYTXgGI6opyp9V5
 iLPJpAlVCod/qUQd17xUbEKmekkg1MbhHyZWSH9vUemFxYMsETPn1YH4S/FYsSVPNVYKKClygr
 E3w=
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="148304002"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 15:12:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buy94bofRfwePEV+IUK5eQpkGF4wAC2BAkt6h13QoqRpCkHNYyPpoOkCNfazVpW9/hXNoEug0yz8CMC1Ujq5dt1fvRAUZGylYC4g/6WykHrFQQJCj/o/hufG7uuh3h45xQa1HkOIe2h4L0cpRktdnSDayLWsR00HySSNP7KXstf/hdvspsdoHjxyN5UZST+z2XotLOK2g2MbSV9xGrI3I5a4NHsc5kE1iaduy9z8T1gx++Xb+ycuqV67Oq3M5PO+Zetqr5RfIzoqEPL5YCoc4RD+8BYUeoCovsg5TXO0ix3YN09/jgivsf+qKVTdqQc8obIttKEkgf/Oh3e2MmbqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lRC5WJe+dU9h0+myVfNXHjjsegXQtx9pXgsHUB7kck=;
 b=lR+Cv1Ob5FqZYcKwUNB6jTyBlXPES6JMfs1jDaeLkYhuhrhQEabnkE9eFkgQdonakdzzIZnCeX9PQwxmaSUnQ4qJ6oRHqqMA6aCnA2IIQnqlcrvg6HppFfW+nivkNp2M287icmX3YQhz+K/1UB79qk8bUHfo7AIBBIL0TFQ1KvFFGexA6CWXTiTA1A2y0XomJcIp9jJLvSdsGs1tRnFhcDd62ELQREXFieCEISpOf932SUFNkMwyLVU/VgyFmUYNr5h8abFu7JQ9h5b/7HpK211YX/XOCLWbWfWJWx2u5fK2TiNlyNto2aq2a/9Xh5ILB3aXdQPGB177GkDMKB6TMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lRC5WJe+dU9h0+myVfNXHjjsegXQtx9pXgsHUB7kck=;
 b=m219D8be6b+xVg+/hq4BN+v8clQAzGle3nYsLBfHEC6X/7jI+fD84LfuChGOPIkY7LLTs8r7ZOQaNBZMOG7Pl582WP/6v8GiQWhYMG7erCQ5YpJsMs7MoKdiYq4lh5vN7I2upV5YAZt63SxHic0OtAkwrVONmDbojM1IhMMOtOI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 07:12:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 07:12:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH rfc 2/6] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH rfc 2/6] nvme: consolidate some nvme-cli utility
 functions
Thread-Index: AQHWaWIr+io+eDetmU2zfj8+7yVEKg==
Date:   Mon, 3 Aug 2020 07:12:40 +0000
Message-ID: <SN4PR0401MB35987890796D42008153A7CA9B4D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20f54224-24e3-4876-03e8-08d8377c9c4c
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44649A49AC42023C20F85D489B4D0@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tkZ6l7nG3h3IalvcKAlP1jB5sa9frpGdWqOAV6rs+gOO5gRf21tX9GmBl9rq1x1V2A+/7l/u6LnKAyIaQ8utbBND1zEODOcW/Y24otdev9/dbjx+oAG5EpXtEON13El2cVQoH6nvf2K9mnS25968Ncd2TiS3DXvVGjvxYujjg8JT83hKyfK3bUeU5uG/dpoWeDtoSxksijfoJ5bkd05rdJSkfra2CXdYBHTpKrJXL/z2rcMhLjRQTunV14OZYAtNNNiJtCQ/NrqMZIrl3BT3uYoG+VXsiI247CdJGcHwu1+GYAinqSDvWy53Qo1JGGXrhlHWYGsOPoZUxilDSwO4jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(66476007)(66556008)(66446008)(64756008)(55016002)(8936002)(186003)(9686003)(76116006)(53546011)(66946007)(6506007)(7696005)(71200400001)(33656002)(26005)(316002)(91956017)(2906002)(478600001)(8676002)(52536014)(86362001)(110136005)(4744005)(6636002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hy5PbseYKAPITCzoPsrPFsQ4nrrbxBiGzgpCOKtKJS5ESicUsX9MUjP0h3HiBbtO+kgwREZjjqjKn8OpkLlvebrWWOkDBr54CbPB23juIuJAyaa6mv6i7H6+nHdM5Jc0h+MmAvEz0ZonDb4MrVNPEq358h2+uzybLfINjm7L/b2NAtJG1jHlKNbynsTQJ16rQxM+z5UpyPkFKf6e06Ctm1iIGwbz6Iub68iOWzc3Y6SPblDGLveYnCENpQUtLNuJLKwTZbFP9f9qQeGmacg108xov4IZzrUo6dBWSahQg15+tlZ8lK3zU3yXNUyAwYGuP/XnKWevJKgeG97HXCb+cyiPrsI60uQzXXclqpzfTlM4fJ+rxEgQV0j7WZGVKz1yFl3OBU6seeL5N6LNHdOv6MMBRiCooFjkRtdPa740AFTKqDNiZJ8nkM8o9Pm1onG/khR4xW+KGXkGnghs9Z16/M2MpEpdeQnDM66uYcmjSW6G6aKKDS+8Zv8dQp4UVaDdE65fjyCS2F2m70q6/6EL3w12RcwwQ7SxecKB4vQhR1lrWt6LFrr/thcITMjUe3xhCx2quIf9ThVCzOVqySwQIQv5JKuOZwkmEzGwWe8TYKiebbsw9PSNYDdItyR7J52+voZLMjDNSacRw8+zMJ6+WQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f54224-24e3-4876-03e8-08d8377c9c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 07:12:40.9315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDYlSXkVYVepG7DhQ8vY7hipvUYovKmt/k9aqjoRgt3SyHJhVBgMmhgQkCYSYJjcQ0584UWSRBHSuv5KbTKvykiRCyEyze/f9k6KrWQELns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/08/2020 08:49, Sagi Grimberg wrote:=0A=
> _create_nvmet_port() {=0A=
>  	local trtype=3D"$1"=0A=
> +	local traddr=3D"${2:-$def_traddr}"=0A=
> +	local adrfam=3D"${3:-$def_adrfam}"=0A=
> +	local trsvcid=3D"${4:-$def_trsvcid}"=0A=
>  =0A=
>  	local port=0A=
>  	for ((port =3D 0; ; port++)); do=0A=
> @@ -109,6 +152,9 @@ _create_nvmet_port() {=0A=
>  =0A=
>  	mkdir "${NVMET_CFS}/ports/${port}"=0A=
>  	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"=0A=
> +	echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"=0A=
> +	echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"=0A=
> +	echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"=0A=
>  =0A=
>  	echo "${port}"=0A=
=0A=
These look like they should belong into another patch. Probably =0A=
"[PATCH rfc 3/6] nvme: make tests transport type agnostic"=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
