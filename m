Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D558C63798
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A056E20E65
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ffq3WNjM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mitu4Yw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKTHcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:32:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16213 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgKTHcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 02:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605857554; x=1637393554;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Ffq3WNjMm0W6Qi8ssLnEaKDAf4TBz60VH77FFgQvXNStnkdeolFE0crm
   YTB/wP2wyr936qskPIc3koKLIQgXxe2qicqk6SjMMRH5wkLe/hX+vKo8C
   vbmy0IINg8/ldJgifapEcoUlJ1iggl5g1G74Gz0+UNQNBRwKu6jD/HxTY
   yNsnb1R5UeQd8QcxBubVIaug1wqMD94Wvx5iINHRTAxd7bwuLBplinEdR
   RwNPP1spTZmwMgb7LQYAwN+K2IpEr680ohCg1VMIwQBO/wSXYebrh0NZy
   dpCNmEo/XBTANoI4wt1YS8IJOLwMbgIqCZfVKH469fSY+VXL0KdAYe4NX
   Q==;
IronPort-SDR: 2AJinttNAoaRBvFD9wSnfjJkaPqmbhoDk87UTAtKaZi1SwNBKrvNjwNDoGiGDqGWYV3EaSNieo
 EdoXYgcp05gFXJssfKZIFA3EQuk5fAPrKEY+21ZSid4AD14PXWALrJsHbljtGXbut7JcitcQCL
 i9EMRNsR/ucJTzs7leTLhiCfTaCcFlnHsPD/URYQ7I/WQ2i+HAyfxDlWNptxD4fNRdDsX4SDKN
 +4g9wwzwtx/U1pujv3cG+9uisdLv4vGLxLTEQc3S21MmvfUBdYe9nEIE/Df93QgD6df3I1FOBP
 aaU=
X-IronPort-AV: E=Sophos;i="5.78,355,1599494400"; 
   d="scan'208";a="153143633"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 15:32:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUj/UJlZVomGhG4yMovU/zOz2SBjJON9hW1ftx6UUt6g+foABIukgDA1kpfyZxS930WaziWQArmG9v6RaZboXtYYjEwd9AK/PiPcejM5K25+ErsI3tIBAmbvkGfbLxX8JZSbiPthxfTle2W7yuDcMrdsvM4CYQ20ybvCjMTDUJz1EiQ891KOhKRrRxzh2C6hBIex2C4lUwX/9ClohGJmClgg6nF+5k0IFoG3Oepj3/IvcGXKg6r8qeLADVF/rpgCygN+Wl34+Z2Axei8g/rKnEuYbp2u3yOZHkM+su7xXZ1ra/ibdgw9Aoq1T4Jf7CC+29/pMsdB957GXngf5Kl5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YapIM+68A1bhpS3zpHB+pkcXG/lwpfERiQuPSjoUz5rJ4U1AIjEvI+kshESc9fC2IgUq+IlUea3EhmBfMQ8elOBO8x8rym8m1yUHEAO94PZvoDFMTnHjr+A2DO5Tybd2mUoau6NbNlqlirVfvYmWWpGYoUkDGdWTOMwGYqI9+wvufFl1L7EvI2iit4RECbgWrQzNln+bfLNQooTQp8dsFsQMEis/x/1z6TMD03j08S+NYzNQW8qQ3u3z13XqPDiOr2mc+A2kbrC3+cn/MbUhzl+wio26LIcq0J+cKteLfiEe3GM+AcWXsWoLJT0tLvVrlA4SInxqYrpzRNzPPpTq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Mitu4Yw+CkOpvCkoo/+yTg3VbkW2frljk1fJDR12sZGjRwu0Tn/fAH1uxRYL8SkzhDOCe4WhT08SqTzpXIfYurZ0Zf+ynGLtaHDctAmhdOP3/BhpuGPqnxXjN+jJi2otK2cgJkh5lDMIRL9jYOKGJOz5GPaITuMlEzo6FEWQohA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 07:32:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:32:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Topic: [PATCH v4 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Index: AQHWvuCIbb85T4+7aE+qwtxqj66tZg==
Date:   Fri, 20 Nov 2020 07:32:33 +0000
Message-ID: <SN4PR0401MB3598DEE71E5CB1028FE46EAE9BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
 <20201120015519.276820-9-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:ccdb:5e02:85f2:66cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b241c77-e3f4-45ae-f8dd-08d88d2671d7
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5326E712ECD2D4633A8837D89BFF0@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXjLlxOGMWfwqdV8pDp0zTWNojQdT7Q1634QZfO5Sf5Px578wwbG8PFpyEb0bNM8A7unDzL00+JmfMA8B0BQxmJ859Q5/Hc45JH7TdHScC914+H6/kYDB/ebcPTTtOr+jow/QJVuowZpa1qc9039OF9t5IrjimGK8dk7rLjrBSohuMdbCwbP/SyLGVdYxKBGOaHKmlk5FOyFmR0obDQjT+OCzdZbh4vhmjmHTE/e2G2WqDgqpsy6mqIZ3CdaMtcbZCoNPmlgfrZL0aExFPA+fSRqlxvHTgBB3D2NyEHdInf91ecgwmBEdMB+xrvVpieKy1fQv1UN/Az4KsuV5KAfsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8676002)(91956017)(66946007)(76116006)(66556008)(86362001)(33656002)(71200400001)(4270600006)(7696005)(64756008)(2906002)(66476007)(6506007)(66446008)(55016002)(5660300002)(52536014)(110136005)(19618925003)(186003)(8936002)(9686003)(316002)(478600001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pSTzZb0q9rd7vdLlrG3NaJVKW228JhI+nOoOJmDlFqA3PMyyuv27PBG0Y473A/KWU0jfWaiOpOtXjVZiw+h2wfRTGIIM1W+DQMeKoWUcuFjPPayIpPgd1AMUPGE6E2LJ/By/y7P7VAxyUpM1RyLngym2QRWD+uQ+5Nf1PfazSyB0IyuQcimYOLw1bN9U073MrRxAMPopnGKPzK7of+71CycXVGPeN8Dd3iew2L1WIcWRFvKHH6mNVIH8QaKQZd7wN5m5pgUe1STPEJwZ3KWg0Dxia8Qd1VcfQX3h6JX7/jxZvs9It1+q54vEi5iJgzD5BRATEm4PcFuY0DevzUYwP6GCOGbyD5nMJvZdfBXUhavbVgv/9d3hizJqsHtpSW26XpssrLQAYR8YQM1XjbiyvoBev2QymLEZY+0v+/laQo45SYyLXYQ5w9/J1VsBiij5FRUFA7pAbf4QevTv+XEDw8JrApNIVbUtb4dPxWr0R1FLPx+feB9JxgN3jnBtv9KQW8kLmFtMx5ZlI+235NDFhxhCiojkFU8XjadgST2RBIsiUSGplT+tzfFOkDMN0jrTL8V3GoDQSfbxLFky2SHyKL0/WFC/LxNvVkuni3nhs8xv9CIhZkFlxNq3tAbG3PIXTGkRbLPTyUaLHV5Rt77OWskC/pe+VlLi0vzI5NoszB/nmlWvtbYvTeaP/bTQ8gW9A/OoyJ1y4gQmdaDQRBUFZg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b241c77-e3f4-45ae-f8dd-08d88d2671d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:32:33.0588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DO9P2i1uWhebp3QnyLcOQ1QqtDs4GjtW+yeuBBMm3csewdBmAuR5uReufbnPl8ZwtFfDfTyzAp+wwO1mIAhhHwrWzvCnBnLT5mnPo6OzsTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
