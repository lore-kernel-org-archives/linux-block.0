Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3BEC64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCDE2074A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 12:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P0RvPFm1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z1sxdcuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgK3Ma4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:30:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16994 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgK3Maz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 07:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606739730; x=1638275730;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WCY02q+6arzTKMXB8yvWHgwM3dgBCsBJVjh3vCtarYQ=;
  b=P0RvPFm1Dzihl2IMnwfmsUaLeMKM+NBXo8uSuXHbWRS/1qk5vVWsEeM9
   lDkEWVRTV90GwXwBnJH3xBI9eEiuxN5Nq5Km/EO8EX7zUFIbIpJpU4tDT
   GtqRsDag1Owryln1qzFAOpnovaDARspX73ZV4lVYDKnINNO9vh8UgrgiO
   nZEBoB9j0XGu1eHGojM/eP82PTInzaujsuWat/YrcZ+zsZdNkedMvVcX2
   i5hCzU/3hnecxcnztGuENCoYgop1ynNzmbxWOXl13EL5MHMizdTEuKKuw
   HcJEQsBc39wOWjdu/w5rMh2Gfvso+Qw0ildugTH6ol6H6GCnqRVCweUe5
   Q==;
IronPort-SDR: 3akjqz7DGznetLMpT500qY334siPGpaxflPeVjy3GWgvogaESkl/HDhhsqgTDnqC3Tcl6WwqNc
 viTmmFAo2W8Lpfl8c32bFaY0xftPmJE8agHfghsX4RYx6fU+y56OZGYGBsAMsgE6ZeWLkop7UJ
 OcntXAfGlSqzjjrANugHgBv5BZX+JTY2IEvxF+GiHBc5g4WPfVDiu5vdWDPqWIGOe8WYfthbhA
 yRUrbNdOa1PH/6IWxAZ13CeS4NyQ53oj9DCJ6zi0jXqsaW0yKNXp/OPAWWok7n+jMq3TZrUMsa
 UZI=
X-IronPort-AV: E=Sophos;i="5.78,381,1599494400"; 
   d="scan'208";a="257487802"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 20:33:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cojLsWp103iElLNjMp5bI8GpzJjeYFWrhjeJ5SLx48gzmqrin9fkMVzCoFnCF1OBdPdR0uH3OemsLh4XRtSNSRRDewA6ViqYx3S4S8UxFuUGvFHVe7gGYbPRLCYbX+MRyrm9vx3zQkC2tgWRceHLrxwAsE9HnEK2EQNy9X/aFzhks1Md0QmllmEW0kN/1EzQ8xyhZ+YWPB3ZAuFqU1K2CPTSTCAZDDuxx7dSK2bbjI6euE/rxNPlGOz1qgAN3xr4cNfyS+w4Myn2TFSw+i934J4WMfm7HVs4hL2KL7S7JmokboYQEUP7PIgYUvJdsaVZ/IqRgPnZFKoWCV9C03FzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apAXbdaLLVNuiF9sM5Ix1xWIFtkC18oLtFHaXCwitfo=;
 b=RFVb6gUjWJ3X31KNt2iCRReU6uLJXfmluilu2zHb8zdt1vHAWtF90eRbl71ANPykj1TbhZ+qF3lp/6naMLGscHnGtemEAI/VyQlWl3xs67aMtps0hnTjwD8I1jG4K6wB09QXsK8vvYluVttwwK6/flofrwqXo+2n48lEcq0wfZfCNjDX5Vb1GSO9hTesBsXPFfahZwT2LSJjDY4FajHLr3hXXApSwjkw8Vb3ePKc/ZG2eJmol+Qs+MoMOwinISTiyti1lXmD63VSevvo/M613ZATYEEBU5+WOFjeUEHPB9STYClLJqbnM5c71eqdHhxHHM4AxpKO6ouDh7reYsYjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apAXbdaLLVNuiF9sM5Ix1xWIFtkC18oLtFHaXCwitfo=;
 b=Z1sxdcucgOgHHeo9XEDIQMfZb5iYpEklJATwXTldyEHaen3WMr/fAskVJ5G7r/WOhFLQGA3yvQN1RgNnnirIAEx3jBxnKbugu18BII0to6Bq35FzuM+7wqaNnxBktUT5tld4HWpDVKYKgc9FmZN2/U/vcNTZky22ObXF1ef2I40=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 12:29:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Mon, 30 Nov 2020
 12:29:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxsl/DkSBeYlhG0OpN4tsfc2WHA==
Date:   Mon, 30 Nov 2020 12:29:47 +0000
Message-ID: <SN4PR0401MB35989F591B47F3A8AD3E2AEA9BF50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:2c26:fc00:7c60:29b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb26b93b-cc86-416d-8c87-08d8952b9fdf
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4045A09B10F7261F1DBF881D9BF50@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzQ8X8K9X+u3uqSdigjtJBe7aHtu/LMrxAYFwiMUSCu/kRu6JSGOyWDQi568AbZn81DkCsC9zR6XMo34rLxOksriGdvtXUICvc+QQukyywB0muPxPR9cyfH7tDqJAG0K4fs7+gNBp6gYRmvtvtmCl+oR/KZ2hJNn+5HM5ftNDM0yyYiWcl/poZIn5ESLAcITN52nye9Sx3MBPRNvq7wxjklE7sgoEyguIoRlobjeuY0jeImg05FDgHCMmq9iHdFDyaN5xvcicEA9X/l3HczA6i8RYZHk+cVBvgXCveJiVXjsCS2mI3dOEtLBrffPpeK7Prt00cgovZp5qA1qaqutNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(186003)(55016002)(4326008)(7696005)(6506007)(9686003)(316002)(53546011)(110136005)(54906003)(83380400001)(33656002)(86362001)(52536014)(2906002)(71200400001)(558084003)(8676002)(478600001)(8936002)(5660300002)(76116006)(91956017)(66946007)(66476007)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q0eknnpkZNnlsg+W6auDc9q3KIUDMdX8y6uMh4WSd0HuHiLIvAVkJLZ7ubGo?=
 =?us-ascii?Q?nMQD7O0D5oVjw+s4IOm/SEN664q1q6g3f+QK60FPN52vv7ERvTYpd0j5Noio?=
 =?us-ascii?Q?QNK4mnWhkxgpgu3L+gPd9uHNCsGaF16ysSJqk9K4aoz5sJqrDnTxyQi/l9hm?=
 =?us-ascii?Q?pNKe+krq3O8tCyFb1qTf9qUlBPvqRqLHreDnSdNFDK3msOv7/EKqlD8QdmgO?=
 =?us-ascii?Q?osdFiVl/y643P0+/afU2SntoAgj2/p4c9fmgm/1fCG+9Z0b9Xav3qZOWNYEL?=
 =?us-ascii?Q?Wr7uIyYtzWxAlAiC+twSFBpAlJNNfo1Xn2QAwzGDIxVu8Ft6gXnqtd6CvTSN?=
 =?us-ascii?Q?DunNG6QHEJU8UQpsERWgZDfRK46wacyUM0k8ObNUUy9sBpQYAT1lh2EtEElQ?=
 =?us-ascii?Q?Csw3FckEWUZJn0pfd/jNW/gp07niqLf/4+7BoGCOf4V3QpsCazykYjOKLCor?=
 =?us-ascii?Q?Kfet7C3W6e7UMe6S8iS0/KrZn0pk+D0pA412wTedBrOArxdWX2PSpyGqd7s7?=
 =?us-ascii?Q?CBwtSC7c5ICyUR/URqevKXeMMCecMxFlrHAOWLd3hmadEteFrkVUBcMS6Zb0?=
 =?us-ascii?Q?wCcOkpeeuJuOJXNi8qfRr0LKlSu5dum/Q+SKs1aidPJWwytQcu1MUHZ3hDLW?=
 =?us-ascii?Q?wBlNEaDsb0qTL1E8VcOL5UQVTh1fiDH4L3xvsMVZLoNgtO4V2mbcY/o+ZuTX?=
 =?us-ascii?Q?w1rPYBs3R6D0T5VtKhb8TROFfbDPaXF+/dl1w0clfAzv07iaYJyyavP9Hzyv?=
 =?us-ascii?Q?I7rdTK9aNgOcynXk/x9PFjodk7V18hWk+5eSYHfdjSAGQL3F9UiqxlD1L219?=
 =?us-ascii?Q?QcEXhHe6aUhOabC5D4eGK1sOLA89dC+/h6lsOnHyz6qAA5kbw9A3IixQ1kXo?=
 =?us-ascii?Q?KQMurWZALsjf4qe/3eG/HpHsz/hVB01cbOkzqO7yLGF5Sm9ZrE9JG0mQ7RBk?=
 =?us-ascii?Q?ZQ8sSAqwwrgF6Qm/OlqQY13Xy+CSxbJlWHAifWZTO/8P34BIuK66Ls0brTEy?=
 =?us-ascii?Q?nOzTaE61BxXRNyoz+1oAIMSmjysZpykpQc4j6KbI1lt20drW66qlRFRkDje2?=
 =?us-ascii?Q?GT4enPbd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb26b93b-cc86-416d-8c87-08d8952b9fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 12:29:47.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqocvpjGSUEART+7J4iHTXylWswveWWxMEzw7MxiMoEyARTYb7PI4nViKlleAdcYCI/HGmwoDEAh7judu0wus20wb/qLSVyA6Yan0wbDMqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/11/2020 04:32, Chaitanya Kulkarni wrote:=0A=
> +	ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
=0A=
Can't you just use bio_iov_iter_get_pages() here?=0A=
=0A=
It does have a =0A=
=0A=
if (WARN_ON_ONCE(is_bvec))=0A=
	return -EINVAL;=0A=
=0A=
in it but I think that can be deleted.=0A=
