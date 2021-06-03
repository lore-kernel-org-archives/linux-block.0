Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD548C47083
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 00:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92301613D6
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 00:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFCACE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:02:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36176 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCACD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 20:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622678420; x=1654214420;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SdUpJvvyFR9K10zvTqThC0vjfAQjqJZ+6ncNcNrAKUQ=;
  b=XwTQj5Qf77khw4YgQNETGgvISosEVKYw8vS85TJtkEDREsUr8OFIaDOk
   Yocy4o96V8RJnFp4mzUoxVZ390Firfm+M7/ffK11eLbM1Nk714uwtdsuK
   yGk/02397KAvvzjfyn0DQkRX8/vsxUCjgnRSVeRzOQfxtA1NntNHINa52
   Tdx+PIVNnkACTF9TOjAkNTtqf8PTHri9yCjOaaZ+LhSfRhD6dB4B7eo0O
   iefdJVPGYkZlYtDEsKTMdE/68nSdQkn14z2cwn1HcSw6Z2ByJWmPybx/d
   zncHEYbYNXU86eLWJViOE9fPBBqgLoqHQ4wTyjfrtkbJ9Vq2Ci/M3mqPp
   Q==;
IronPort-SDR: 4fdc4bJ+vhcdnM3VrT+uvYaIcnhc1DsuSC+x8bTEJvpVu/x3kiR9gL6J/RCstwY6I9L9b/FIf5
 r4uovFb81g8uiWYt6lU/ymxjFCCZaH7QPka8ynxpmi70Z82SxNxUJWlOP1f4HNcdInfWCMDIxz
 +Qm5ynSNolISgXw0kA3KhjxORtXsViC5U0FFOe8pvT0TMCMzUG8A4pZkWDW/Y+3iZ5DGkzasTB
 5e067YlqjWRCvdNhm37/hDVpG1WTMsFv5jbNH67SQtTeHtf02IAk4djljl48akEQwtbRVvVd2u
 /5g=
X-IronPort-AV: E=Sophos;i="5.83,244,1616428800"; 
   d="scan'208";a="274374127"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2021 08:00:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RumM0Oq9jJi3hnGIQ2tVYu1mRLg+MbXoItbcNaIUwtVFnqNyPX2VVHAO/sHMxi4FOpCSFi2OclCQRpNLeQfYtxhB2GZWbt2m3YiB41XipOKANSEc+ULz2yLU0x/cmrrSFnAzTomdRMhm6X6xsTxGVUK7/NxmEIiFI3OcZEXlZSD4pgN4tqPDBXeqk55T4qsNWblkr2rt1StpLr7uv7NorNG/Jz/bCrC13e7Ao9+lw1MpuN0kKlDu/rr07ZGdXw+N6Lt2N3qW8IwOeWM8sv85jSe2qB/WTFr4LeWc92Ka6+Hj5yYAEOaUCiVmYeP6WBMnBuwlUVQ/jU2KpHZZg023Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdUpJvvyFR9K10zvTqThC0vjfAQjqJZ+6ncNcNrAKUQ=;
 b=XeQmsWTV0Z1KNQVsKAUvN967FI9y943gZikwOaQKUuu5LJZ5XqQaLF4ys51emtLODPxXX6Npoz+DMMzMABFSB9YKGEYbsv+SYH7ur9Jq8w9xoK26KSdzt5nMdjA1Li1uKKaR5kjiYuqHBjFsD/kW+M9SQjUaeTUPnQu+4rr0jshNT7yxgGCwoky2pPJfLwoZaSmZ+dlWTwE3UBcfi0FJyEl+YjOb/3gdM0y+v2qQI3Id9H2w5opzmbJsdA9C5KxNNcry0QDFW3dLpr8d59FmXFqn5G92A2+/1fjD0CZB0PSf/x/+x0CxsWHgYjaTfhQuHodBswNBLzdz9D6/YQh1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdUpJvvyFR9K10zvTqThC0vjfAQjqJZ+6ncNcNrAKUQ=;
 b=DrfMmQmNqoSCO/ff/v1fQ+hxiYxLUPISgTQemfHssEk37K2Vi0l/HwasUBVeO9KbXfweefng6GANgza+6mYKC/bmFGkKA36/lYZLkoOV1xBMCtlyuRKEdaKqg2fTsicZWM2h1ACtY3ksJIv32a8BGpOZX+HwqjhG68NkDCrMGO0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 00:00:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4173.034; Thu, 3 Jun 2021
 00:00:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Colin King <colin.king@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] null_blk: Fix null pointer dereference on
 nullb->disk on blk_cleanup_disk call
Thread-Topic: [PATCH][next] null_blk: Fix null pointer dereference on
 nullb->disk on blk_cleanup_disk call
Thread-Index: AQHXV5cd0Xp2C0SVXk+O11uWdyIruw==
Date:   Thu, 3 Jun 2021 00:00:15 +0000
Message-ID: <BYAPR04MB49650078EC900016480DFA59863C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210602100659.11058-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f07805cc-9f85-4297-ce60-08d926229135
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB53339B87FCF2AA2C28351D4A863C9@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aPDu1ea94bdl3UtJbN35Li9aAljJO3eCYKjaQwE+YAvn6g+++kxvtVSCKKmi9KK8lyNNOcI6co30gN8eevA9sl24I+vVhpeV8jRq5RM0t2b6xnMf3wZd+JUcEM7ffKFuHmSGhwcFRsEyLBlZtXJpDECNPpHz2/uDCFmXXaEXdRVErYAB4EWEv1EqyqrZg892CMYDtofZwuCxW6D8Odi/h4L54Hfzk0X6HVvmDr5PgAr3Bc7h1NNaCteOFrxA9qzZRUrP25n/NKia3hmH0hjeLvl1m5tG6h5G9LmFBoksGoAX3vhX14f2cBXNel+ng8Rljr4cYs8i7Mx3WJ1vEfgrV2ovr+aKD8SAqDHJKHDCm9Pa/Dg8VMF3q4+X5orhxLvCEE1qRK3TfN+d+3H7ldY7y1tVTGl8N33Z5KfeR/gLogmBRpvqqjqQRFDhSbncgQpWmcX6Jt//JS4C9XlWEuNQMvPxiaz5DfS4nVzhLRn8NKyfSjnLWnYSmZIlQj7nhthWw8U6sEcRfiIBHvDtTuxtp0VUCT1Wdqu4NApwN774p0S94DDxhKTZXt+LMr2hZl1DcKZp2E212wI0PUohNF2UYqL9Bij3RB8IMoJfjCem5JM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(186003)(6506007)(7696005)(26005)(4326008)(53546011)(86362001)(316002)(33656002)(8676002)(110136005)(54906003)(478600001)(52536014)(9686003)(55016002)(8936002)(5660300002)(38100700002)(122000001)(4744005)(66556008)(66446008)(71200400001)(76116006)(66476007)(2906002)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bKXd0oillC8pDvfJz8c+RuqinBQhJ3ZbRvHf1LXqrRzgbWCxnunq0P+RaysA?=
 =?us-ascii?Q?+JSLyEleklByDUY3qf7/d9a9E0hHqPrcnc0E7Wvd8jSkSNi3alrSCy9NGBvF?=
 =?us-ascii?Q?ERNBg/rPZkZqiMpCM1h7ittxm2jhMBZJFNlBlK0umgrDzyxGWwZkSpT87Q1w?=
 =?us-ascii?Q?CReSMHj/3BNSC8W4A/2tuSUXWgAhsA7DHTUFUVhqgf4albYhTCa4HkbJLcw+?=
 =?us-ascii?Q?HGq7szr/66yMJ52VYxK5i3YxFYzIfSgAIDpt20CwRBX/N/sru4yH2OylaYnO?=
 =?us-ascii?Q?gmuENsYrGVeln9/4Aq2yHaJrzegxHmgFGW3F75oDa6GtTf5OIlPksLu9d91L?=
 =?us-ascii?Q?YWkmA06nchMTdM8vFrAyKANJ2pGTQvmCjEQQoj9mcO1xYr6MddiLIRpe9VL2?=
 =?us-ascii?Q?CPDC7ZXw/FkjrYvJ85s92Dh7nilPEdd3B+2gFv4XWEFhj6p4PLR9JHxWIHGO?=
 =?us-ascii?Q?WX50GaslNDyyR9korI5xKoUhEKduZ3JS1glBr4Jun7iTVNmjBrsTpOBZNeCx?=
 =?us-ascii?Q?xbqoueo9Z3kdu9Q/Fbb1vQNrwpNWNt1I2WBiRfr4Xm864ibJKJFgcdJfwTyX?=
 =?us-ascii?Q?u8envLs53YVsT/z+fj5AYHWTr4KacAPrAA+rmIOW41sqHz/O6uNy5f7rnNRt?=
 =?us-ascii?Q?hmXYd/SuSXVp9TkqWgCPCmyY3VFD6snam/FANF/hkCRnbNpNz7pjjM6ZhcRv?=
 =?us-ascii?Q?JKwkcJhbI9N1DKNMs8FdV1+UQtNXir36TVloSPj1lOyO0bYMeVk1hsu/vfv4?=
 =?us-ascii?Q?xl5YxVsIKKbFD/5RbhC7GAhCv1B4RqB70XdS8aa5JWbB20X9ZUtNlLXlASD8?=
 =?us-ascii?Q?bKUvtyNFcTwB2H2b+epSprkgc/fta5I+HJdcDn//qeFWGSN0/0h6MPCi2eN7?=
 =?us-ascii?Q?HRpIFLNVZ88kkeNSY0y26Fa3WZ2wFcyUTLT7W1rbGkdeUQoPM5W/LhjyJSrM?=
 =?us-ascii?Q?VJCf9u8F8R36NeeYCqEijjO/ELMkyYugCnluMRooMsgjlV4H5EsPsH1HU9DF?=
 =?us-ascii?Q?Y/1wWqt+b1t5b8jKx0XsCRlUuevZrJnFV+19mrmdqLGN3oW7dNZC7ml0tHJO?=
 =?us-ascii?Q?heTomzI+lPNce5Eax8lA+m4tJRhqqRCltrKZSYqVNrTzNfw6xZ5iZiDg1nhY?=
 =?us-ascii?Q?kauE30/KEHr/qLN1qi3R0yV2MMdv5eKneCFdlfIy/15GL1hgDJ5SNeq7spEH?=
 =?us-ascii?Q?btRpR52fXCegt/o3shdspEVTIKP5FK13V7OAJhbWdALZ54aufZVszXOO/aDy?=
 =?us-ascii?Q?4kqHP6ZjtNnMTx+cozetftXZml961OsU3xHPJBI+19onKD6prcwu+aKR51+P?=
 =?us-ascii?Q?foXKHPSBdrMd/cYXoIrkyV37?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07805cc-9f85-4297-ce60-08d926229135
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 00:00:15.5272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9ZL9y15dNHRQr7esnG/EeC2EzVF3jW2dbFEBciW8U1XzTu35i72OB4N6ISMLpkAPde+lhixzhUbC9n5bUct0IhQ2BD1s0x04IsD5/47WrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/21 03:07, Colin King wrote:=0A=
> From: Colin Ian King <colin.king@canonical.com>=0A=
>=0A=
> The error handling on a nullb->disk allocation currently jumps to=0A=
> out_cleanup_disk that calls blk_cleanup_disk with a null pointer causing=
=0A=
> a null pointer dereference issue. Fix this by jumping to out_cleanup_tags=
=0A=
> instead.=0A=
>=0A=
> Addresses-Coverity: ("Dereference after null check")=0A=
> Fixes: 132226b301b5 ("null_blk: convert to blk_alloc_disk/blk_cleanup_dis=
k")=0A=
> Signed-off-by: Colin Ian King <colin.king@canonical.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
