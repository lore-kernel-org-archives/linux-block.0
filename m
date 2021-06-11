Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCBFC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E047613B3
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFKCCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:02:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35479 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKCCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 22:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623376838; x=1654912838;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WbIwLodas8X1ZQmJxeEL07aVFT0NWEf8mfBNdsqg6ng=;
  b=RmuCck8t1cwcQ+Shzac8GFnO7LzybMKFDb0xdllzcESOQfCH+CRn+FNA
   zLqwn4INBiv97U8fSrpZ3C5kL1T6Pzh+ftg/bH+3NGLVgF6mZWJG47OdZ
   6OynvKqpKjAO+Lfh70+LcO79DjNMuDGA6VMQjuyKfBxfhDE+JtWjaFV3u
   1bZLji5r/iklK9TqICfK8ehMRWiKMmhVlJ/2VT1DkNur+zko0qeBHfK22
   6zStmYPPOItMLrberd7sJzyL/9mUXuyHhiWnEcu+uVcRqTLEHSuY7IQoR
   KLPZchdIzlNcbUtzF+BrT8ZLgcVeZbdzBcwenUZTjFfcgbqmNiA4lZLCj
   A==;
IronPort-SDR: fqHUxRi6LbDxHwElP4olINXT7PzVrXg045MJG3SqeuvfidMEIXtfIS2S8JOYI5+p768SrTnt34
 AzxRJbXoGxpIWuu3/28s/5yeHcIWkPusF5+d9Uqg0Bgz4jtQuDiSZfYLo0R6h8ee86FTkLBOgf
 lR3xaOtW+a/qsc6BSIy4wBDfOpH1yZ1NkPtP1T+etykalW7z6xNPZ9ZvBDqE9OUU+yWjRfBQOI
 YShWmNHbtwSorAEXajoYhxuMZrSrwgqwP5Js/iqbUqq4nl5zl8B0tYXr8MF1X0cF7reOjbjNUx
 rIc=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="282973276"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 10:00:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2pm/seitLHv49hzeWIBJA6/70osfRcr0m5zjlCnizzhBv19pto3QsnO3+RwlQXKfY6TVSm1NuT9FcErlU4B87Yb1GZRcDzhLWzh57C1j5hcGLrzvx8ZbEqJQD97+ZlIw6W6N36XzMo9ecOfNC4OId6Sf2wWl/pJRE+h/Fv715yZ+EvLDxSyOpBG0fymRUz7q9LGJ2OkvbN+Bpu6BRg+LneugPO+vewWFCnobkQM54BllPfEAoKO+Axohyk07IPSu5oK1hewLfbX2bxeWj0Hz1Z1aBmdOaizu8mxv8LepLB+hGmzoWT9kL1/EDCLoClxcOtvs2wIb7qH2OCf5mS8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbIwLodas8X1ZQmJxeEL07aVFT0NWEf8mfBNdsqg6ng=;
 b=VR9qfbB3x3SOLYP4uhUTloNpxRkanW1is0qchorJuL2PZX+SAK5yePP539ithUnSWPgrh02lTZkVHT1cY/aX0z6zRwW5Q780xMc7I8VXY9srLlKTyiunwqAEi35CrBFRghTSq5bHQTJagndpMh0Jy4XdTVV/UaXOrIKo47G9Z7Fh3KJ33PEFDuNt1eCeV+izVNtVKBvOhLC5A8gmSaQzptU1bFphwNPYH40nBH82QV3Yi4HB6jxjftej6Dda5eVlr2+5hTHBEgCPffL8mfyaTZhEOJpon56hoCM9aRu0DKGH6mIpVKmclXCnOGhVCiQ/RjRhemBNdsUSswwCCSnK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbIwLodas8X1ZQmJxeEL07aVFT0NWEf8mfBNdsqg6ng=;
 b=ng3qL97aXO+5OMa/UdX3Zsg85/4hilj3OnxpIoCMifsMvO5DquAHF4S+X4Uinm5hMb04avJCHL9fC//e9mUdr4odrWCxze93ovyTCXGH/yNdvbnBsEf0+uB+rkgVlJqJhvIn5IGS9LPYGG0+b3tnGj70AH2Cu4523qnEDVjjLps=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5432.namprd04.prod.outlook.com (2603:10b6:a03:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 02:00:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 02:00:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 4/4] nvme: use return value from blk_execute_rq()
Thread-Topic: [PATCHv4 4/4] nvme: use return value from blk_execute_rq()
Thread-Index: AQHXXkHqEAv1w4G0W0qwJEX1Nm07yA==
Date:   Fri, 11 Jun 2021 02:00:36 +0000
Message-ID: <BYAPR04MB4965A4FB6B655ABFAAF72CAB86349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
 <20210610214437.641245-5-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54aaf50b-e385-4ffc-75eb-08d92c7cb483
x-ms-traffictypediagnostic: BYAPR04MB5432:
x-microsoft-antispam-prvs: <BYAPR04MB5432BFB21FD8CCCA76A690F386349@BYAPR04MB5432.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Png98WbT9wiVc43Kn22Z2MWzzksga6uf6c6Px1mjQ/TnRjcPFIYQPhPQbEolDpQzNJYQHkaTneZ5llfcMDlNMUd7XZ4vCdEtTY+iP9VRNXpoWifGob8X8uGy3WENBExLLuZCscAZNXzSr6Sc3L7zSliKKVCkZ7FWwtlmNCRXkuW8qcrWXgb8b0WqYFpslAAz7Mlnp9KrQcdKIRn1okTyK1/fdxNJDIQ2KcwSYHJXVEPKj0Wn8JtICOIsfQppDDNtTcYHSxOGUStcvUMB2oIwMfC9lwVoNJCflFqbrQvvY75Y/w+4Rvn5wQSCOiln0onmnbqhOd9VJamXmvFSMv30q323SWWMobj23UBJXgbmX2xzlCZ3dy9TjAdfIaKKUmjKxbh2Vmofw2I4peJIRFor+QXrGxPkXOIAtHawaRQvNsTpcwHPpTJF+yiDsQrVCKftJ/UMASVz69CbVPyt1zCOapYMgSPU4yCBzwe5Z63rOa4MbBfN8PP4W6TUd+5VMLZ6nuUQk2rRuuupRoQuhTNvIG/MYchVETDxl8HojOWStbDnc1ETj3nxwzgfXrNq19vPHSlrxejnVECR2h4+8Rf5/Zn+xQgY2uOAalHT4/+bULk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(110136005)(53546011)(83380400001)(26005)(54906003)(52536014)(66946007)(71200400001)(8936002)(66556008)(8676002)(186003)(4326008)(66476007)(86362001)(33656002)(2906002)(76116006)(7696005)(316002)(122000001)(38100700002)(6506007)(4744005)(5660300002)(9686003)(64756008)(66446008)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/47wenYNjDdcKC606AOHwQnNBdi6/BOVEbysn/ldfICe7RDR9dVQOxJvs81B?=
 =?us-ascii?Q?JnwE90OVln4kWY+MQ1e7OLBL2GiU4UbPz0rsE932gE66tRc5SaKBPMHMqnjm?=
 =?us-ascii?Q?Rp8/1QUSvwfure4/q3NHuObJ26SDlVbwM6BHM/aTl9n+A2vjWEQoAZZ8PcGB?=
 =?us-ascii?Q?d/LYqvHpavACVOwGxBloBmScc3LUNOefg0YZ9bKV2PI//CFfPZNCMfx2AJr8?=
 =?us-ascii?Q?VnGNn9hpC5Qa/UbxKC6aaa7whHvNN656EpPB3s6xI2uyvF6IagKU/BQb17zJ?=
 =?us-ascii?Q?HxETlPCgbQz1AJG76oCe7t9IVzH4iZe8CW8gExAwN72ZGb8kYYAiY3cNxuKC?=
 =?us-ascii?Q?76oq1sASvSuDzblvy4gcfEwgSUVbUfnPTCfJxt3bJqfzeyiZPXMSnDVmQ3PD?=
 =?us-ascii?Q?9TKD2UEcy3MHpHxEz06WZcdyknwjuQPStS3+K1g8vbPBgIz2le33TZRxWuIt?=
 =?us-ascii?Q?mhMH3VWp9FwzLVHa+4prfxxu7/L0p1KwX1Xr1sJjx3Fv37ekysPBK7Du7UjY?=
 =?us-ascii?Q?rd7U+ejr2LQxDAtGSKUwbT2v5ADmvQJyXydLGWHZGAysEQHvpjCHexvHOx9L?=
 =?us-ascii?Q?SldV7Zh8BOOlUyB67baoBZ68NUY8YoeIf80TpUCJHjAPBi2cQaJam4Ztdh+p?=
 =?us-ascii?Q?xf3xOgPJOQZsdHRjGzD+VzKY8YSuEPh8QTZTZ5VjltT6YdibG2Uz15oerm/m?=
 =?us-ascii?Q?bs8wFSCevY8848kJuzxpQZe7JIkyuOmCU81oLLXrcfqnBbpAWHgdIEBZsiOG?=
 =?us-ascii?Q?qPPmeutdGs9YWwwhPIrYyrZCMo5duthvtNYbS42loYIO7CMUZRMcb084neQ7?=
 =?us-ascii?Q?fgZBFO1lkRAQUFLfC2kMV/e+40QcUQboYhXvIMRf1ETtX6dstt2J3Ygr5F41?=
 =?us-ascii?Q?p8owwq+VdotjsYotgID37XhJY7wPkf+2nxgMrwuLdMWWxYA6wxH2lrQZ48qe?=
 =?us-ascii?Q?6ex3j+EL52ZVoY5tz3aXTDwPLaDZ1dPXBGCIyeN+JDlmC5WOO9nicS4jd76I?=
 =?us-ascii?Q?RREbFmaHKcAH7ArdfQg/WCNNSO13soe9vwHPG7/BnlKGxst9ssb5zaXmG9OC?=
 =?us-ascii?Q?8wzz2qZ8065W26qFFBNvmFnBqf9jlPIuhnJ1mqVTT3SXh7e4/JTCbs6Dxjrc?=
 =?us-ascii?Q?Alt5+9ZGvGf9HbdhkYdQkgy6dhskz/VfCLQJhX/u4pB1e3sQSG27eZ5YYzbk?=
 =?us-ascii?Q?M7guCMHk1PqJ+PsWIae+kDjuheCfDpZGwJoYyebLxHuJTD8sWkdiMOrL87gd?=
 =?us-ascii?Q?k7t1PVf4GksoaxZErB9tCDmcf8oB5IzQ/EbJtwlYYjRA2gF4Yi3OdlqLDGcV?=
 =?us-ascii?Q?HPICq+9zxgdHT8EBLdQdsQa0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aaf50b-e385-4ffc-75eb-08d92c7cb483
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 02:00:36.3597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIKQRxWxmpy1MeeYN7X+CEGxkBzh0WeKev+4ez7Zal2c43va1nPmuTp5sMYZIunkVfLJC4yF+XVp1Lk4LNKO3w2+ACH/PkjGTSlolCNXJL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5432
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/10/21 14:45, Keith Busch wrote:=0A=
> We don't have an nvme status to report if the driver's .queue_rq()=0A=
> returns an error without dispatching the requested nvme command. Check=0A=
> the return value from blk_execute_rq() for all passthrough commands so=0A=
> the caller may know their command was not successful.=0A=
>=0A=
> If the command is from the target passthrough interface and fails to=0A=
> dispatch, synthesize the response back to the host as a internal target=
=0A=
> error.=0A=
>=0A=
> Signed-off-by: Keith Busch <kbusch@kernel.org>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
