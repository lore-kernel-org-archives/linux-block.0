Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93610C43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6075620767
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z7YZLv8g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GMes0nR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIDAVh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:21:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30246 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDAVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178896; x=1630714896;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CxSkieF9FAAFtBw1WSndjkoNnerivxggiVYjQdhYQaU=;
  b=Z7YZLv8guCwIUXekstupAtm8Khuvm6lxQrSozhjrVsSm71SJ0K9JZH/+
   YjsDtiHKxUiX99gobWf9QGMbxyvCUeZCZDMQLcfHNgX1CwI+pdjluSgUh
   FWDOE3ahjV/ksWwZRmmOshvcK6YlJ7GdBWVJRL8CqxX4jdGeZiiTCJ/gm
   CU+LA29FfbJCiBBcXkdN6LRtwwW4ZuzNWpqauDFM0l60E6OuiLLIpCmCn
   13GuSm51mcH+76yvYkpCj+f2Y5Hyle5wzAhlmv/foxIU1RT7J/eeOrVbQ
   v0Fncw66St1VSncaLN/Jr2V1z3xWdg2nK6mArR9OwetKv4BzncPqhAZks
   Q==;
IronPort-SDR: WvK6UGeyyXItlcdzzgZECIWnCnrex/YlenwRN1YJbwPwNESzmREYhQLGWGhBE7cqVr4EIWi/ZH
 6FB7UWJdm/95tyE2lUfhtTk0+tMWtcm/3NmTkwp5EuYDUwAwsRXE1JlBuaDwtQsiI/2X3ff672
 KE1EiZMigEP0UG3cGe0kdOPNwvEkPO4WOM8tur/fBUkfmjvaDtLLlP6BGpEJ4mcdbdM0QyN8jS
 7xFJaN5dtuKwmxKePJXnlvQjsV0xEJnV5R+9jKLbxbctUw+OnpJaw4vYzG6j9/vCIi4dhX1dCy
 VL0=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="146469159"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:21:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOBg7zZbiPm0+dHMfWRK0b6ulQ9ELH4SKM+fZGlI/gTgYW/WcI3svoL+xpo4chUQGM/iLtqepdoGXt1edwsWd9Pr9eT2nXq8aNOBogAcBnWHSwtpsP99C5RDtv0ypf0xgt7hXBlarUf81aPg8WWSiJI63yv/cR3z+N6aw6EYLDGq3nVuPLGV93L6SEorsV63uXkBgzZtPYO7ia/9pfplQ+A6Fl8c5utr8QEaGCcjmAHHPJ/SsXQpzFVlxvKz+CeGHF8qEZyY8vgTL35DknDxDuHuzCDAfBb9368c4JO8u3jgYSMoec55JLXLUJAKbHPo4qz8OpRdmKJU2Bmx5olzwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxSkieF9FAAFtBw1WSndjkoNnerivxggiVYjQdhYQaU=;
 b=Cbec4WloEOqb+yBAnWWwi0Bxo/PW2p9aBTalv94IsoJLy+L7GSKt32H5RPLvsgCk5EJPxZ7dFbZRPApFmzXvTBSsa9ogEQEFPlAps3iP+v+F+TPIPUbTzU2D2PcMgwf2NwD4Ke3BPj3XIKISmJLiJPKlR9rhjxb/F7RKUmwTPdSdVAI4Dx2s1PRIONP2gfTXBc9SuPn4zxOzfJDKzEkqWD/N978of61LBr7qYVz3oYJflGgv+W/dw8As1ve8pg6Jmpe6uXHPvzKw70telU4PF+UNtyW09Usn0rgwSivqGftdTnmb+DDa+Kr1v20imCh8xltH5MZpz8/bZqJwo0FVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxSkieF9FAAFtBw1WSndjkoNnerivxggiVYjQdhYQaU=;
 b=GMes0nR7bP5t4n3GeI7slRV6EDxd1f3NXCRQY9DikIVFaI3LmcNWx0fSdsaatMEiiACZGfPneUtSQ4vjUJTQ7oWDW+rQoFnz9l+dx0ePrAnBhpeZf1i0NWfukZzfo1JdfTG8n4VYJ9Lzobzu9AWWPfTJ1QMU1BFqz5wMCNbFuiA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:21:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:21:33 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 4/7] tests/nvme: restrict tests to specific transports
Thread-Topic: [PATCH v7 4/7] tests/nvme: restrict tests to specific transports
Thread-Index: AQHWgk1/1JaYre0Ux0mn9nscd65SdQ==
Date:   Fri, 4 Sep 2020 00:21:33 +0000
Message-ID: <BYAPR04MB49654EA1FCC72CF2C848921D862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5927a877-0de0-47f5-9200-08d850687aa3
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424CD4B3645CF05542EE24B862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/dvqjmlcHEzK2IV8ze62T8mpQou1k+CVBV3E9PZPnG5Me40JlyYEMEdV7xOT8Vt/+K1rI30uNG+rjbkct5XswZ3+jxrZ9kBSwrheV/oIHbQf9u58/85XptBIxSLq/nsgamRcm+CiflOVTc7JJFinGN/wqxaUUm53VEAbaWw3VNQAEppSbCcYST8tatbq8XMtUG8YDMLMBsitmIYqZZxn+qybsumXA4rh+ZJgXt97GnrMCrzjau3kahRHLnAXMIQuWVn+CfTMCkzRkzZJ75fG606XIJNUKr3T3qfEW9GG0qMvRDhYH0A3wkuKAQtdSibmiWyMpqM1Eci8zxDUx1HmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(83380400001)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qZfoq108cHyVNM6XFKMeZleoUqeRXuJ0Bq/2HadyjH63IR/Ys1zJBVh+mWw4cnbFCOscJyHH8bkvQ3e9p+VZw0i4sDeh7Au7sjFTttPIRweInZAljrfVv9ytIaY52Rj9taFxs0AdLCDKwdn5rYOOWk7ic5OSALfl1oobu6telz8T9byqNFizbNmTIddtOnDnG3nry67UaBhWiBKipNU8lqO17bLV3Qm2QtOkiLyEEGZIVsohDQHIUEns9MteBrcPhH4x8TevIf6FGYM9oFjKjRwpjjWTSLIAcMwt28ROgSpS7YUCo+8VOIFw/SBmBtG7F/xcL924hmWvaEf8vZff1EAACeucG0cJUdONDZHZHvglGvENy9IagWsDFg+REPcFrK6lCg4sFnhRcbk3K34fM65JbW7CEnwW4IrEpuFKPunNSRy7I3bi4rmr3t+VSIjuCVh5uMdfL+NDTUzya01iiufcv1pPncJsJZumanwPJYoq0voxyuy+sKLVYNuNN/ZU87q93slcmlSuST6bNr6six0BDZkL94rPk2ehTatJhAn+E31LHIHKvdLg56t2gBw91LrJQrZEwBPx3RJGh6lxhMXJVOufYMLcvPVsX2EeQDR2Nmh+YrIsHmB5Bzzje+0SvHPDDCX+kv02LeQo96AI8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5927a877-0de0-47f5-9200-08d850687aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:21:33.5457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A5IZGe91D8XyQtk/TFhMmwctHfgW9f6lWXAEBfJpj+CMUiLzG8KqU5OOn2AVFjvNdCvcVGOwtHwSe5v8hHga/G724uosw7YP2oWxYg3DdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> Protect against running tests with the wrong transport type. Most tests=
=0A=
> cannot have nvme_trtype=3Dnvme and discovery tests expect the $trtype to=
=0A=
> be written and verified in the .out file. Adding a couple of helpers=0A=
> to restrict the transport types in tests.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
