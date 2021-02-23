Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BB4C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 20:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50CC64E02
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 20:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBWUyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:54:41 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27380 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhBWUyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 15:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614113674; x=1645649674;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=w5MyFR5PWpsWXHC4sKdEYuCLpKuA6uyw2EgIg7XnV2Q=;
  b=QsMZeghdyTdEGAZ4yvaVt+4Z9iFQbW/JpTVQIEqF2Et/AhKByYhvV7+M
   YSjsow8rIqIsIjBzxsBff9prG/1nGqhCJfQuNucOfZ9BLFGHaoKrDw28w
   87vlvzzfrtzCnPcsJIcMy5M4fJoKQAjZvsU7w7zIyCWsnKHsMzQAg4Pwo
   1o5sSLpvTXqzPxWBvPhwt0iISA9J6yt+LBzrachNEjgkl3/yrLHC3SquG
   Sgt8i6V58ZuPw0MHAgdOkPXUTLfuxMbi1w9TMDVZDgVLdekRZ0g7Do89+
   Y+/B2USBMo7DBC15smCNlVWDgJU2NfGBV4YfyTDoMY898b8HTTFPq25xy
   A==;
IronPort-SDR: AeCJ0zKvTyNP4VgFkdZWdJGeBgEbBV2jy/10H3phyvGLCdgRuAvniysVX0ZgcqMhXA8j/Bul42
 CFhVppLHJnVebm4jsCeFumMOPW2AN/MZQH0UeRoBERu+k5sM85QvKsREnBIHYdnL7MtE46QCGK
 gcdkk0y8oAvw7pB95zObWNdEYhCECLJUbOsaCARw7QvEwdPEQ8R+i3hbH5sgmyk5n+wqgPiI1s
 aBR6UEhtQ94EdRsEMrsDGm/+gmDV9nvp/ZSMH0QDKMKxR106p6JgU82gg3XCiK5P8i9Tm+cp3x
 7Js=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; 
   d="scan'208";a="160643355"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 04:53:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXbNp/czRDnJJdVSJwmjoWxNqtFUk47FiccK4XM8KbT2fVPWFnhhEUXRaknU5LVgRDPsaqhYN+iZ7F/ucNJDzSFHlNWy1Ag814WV1w9zmmDmsBchXzTEtwujCSlzfozSS67AjbUE9kkzZUfNUawKYMf/BamUaSdbfwlMnh5kXkX9Jj/TJsTttTH9lZMnADk97hRNuESrnqvEiC/y7TXLNCXFzFLcObWesymYG1KTxQKXVOnX7lDHposE9yXOCHjeWfdNRt0sayu9RqEdxJyQhDBNaEYt2HfyM+MsZ3g1x4K79CuW1w/lmVhf5fS53D65NGQ7tH2vdxp7Rid2ebVHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz2lBfVmmPPRxDq4HSdqVZiigD19GTZLN4+GBRkiz3U=;
 b=ayH1KpxudjcJhU9RBgn8A7EZw8p3sfE+IrLNr77waGV2T9IoVEgOB0RyC97+6vidlKuMF0xUUqH1cxGEQ0bTuBA/L/+8XZrsslWj7b5/QYIGx+vmxeY4p1rTyXaCNAL1VKs0mSm3A9wdkl65pLiiYcqnHmITBRvuEF2LmsM04RFa01BJGCaLKBfADBry+/gxVLTHIVy7CL2JnUMw42Ya1kTU7jbk1vxz2zF+1VzNtSwXZaepHG9E3RW8i0asL13mUgdpWke3vMgh/XnXC1RLvmFWw61UcCSu5UPnWYdwccYoOhb5Yst/AimPo8ciZZPPx7r71IBn5GMfwz64xZj5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz2lBfVmmPPRxDq4HSdqVZiigD19GTZLN4+GBRkiz3U=;
 b=JJWcu/jOQzmxblnA6+aBqdW5/XfjqsLl2tJWF1DCon4M5gHoYiWhYWIE1/bryWRltZomUqAgFikdEPU2rk/15OQOlTwTsJ8u8fZpHZIrXJ/7zlbuQTgzPCZaPjZ+imJTNWvcdUcJxDBm/FePM0ZMS20A0RUAZltJgC/Eo/fMGC4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 20:53:25 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 20:53:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Topic: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Index: AQHXCZD3vAo2wh9jek+o1gtQqbdo1w==
Date:   Tue, 23 Feb 2021 20:53:25 +0000
Message-ID: <BYAPR04MB4965C13CD9A5E666764E3EAD86809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210223071040.GB16980@lst.de>
 <BYAPR04MB496574519941459FE83C437D86809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210223150852.GA17662@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 274e4a87-c55a-4ac1-083d-08d8d83d1095
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB582968117820A52BA9B7BB8786809@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7z9zFWVRo2Zm/uLIpRwQsyvM39L36vsQmxH8SN/1FZbVgINvWiZRwWsLRhO5W+O9xm7K0+JYRnJwFCGVe0A3HA+YKtnK1WYJOJM3EaJj6jtw1YrE3WCPptOpV3yHtmuqioHVDuu2Auo5M/XFdQDcYRuBXDzUTGtMfCbB6rI0lQwth4fWzRcfFCSgj0gh9TXl6fq8MdwEIUXyJ20lXkk1Q1yz7StyCupkRsl8BSSinht3hKHR3R99j3r1TEsP8Jr/8UqFu0o53ZDnjBnK7+TzjoZRkqGYhHxVyVNVAKSpj5qsYUtJ+95cv2QbJWUQ++x3Y685jlXylxlRPIft35GFb7ylJz0euK0DPIPGrZwes4INov+pQ/gzZNiIyZ4s/OluHP1ATwBQB4XEFjgO/KIO4ALHz1Ea2q5qZiqBQPruMFzGt4YkmYnTk7E2QRCBfCOiGCpifIUjVLIPc8ItlgwDHQl1jlIKyg/GS5n3eAfhpcABU1zPOmqIkQEI/ydm+L99NpP5OuHb141yrPsk2PV5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(6916009)(4326008)(33656002)(54906003)(66556008)(478600001)(66946007)(66446008)(64756008)(4744005)(316002)(86362001)(6506007)(53546011)(52536014)(8936002)(66476007)(9686003)(5660300002)(26005)(8676002)(7696005)(186003)(76116006)(55016002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zEnlFejGuIICPevNd9jkFnxp5Y+bsGxt85HYAc0xj6uGIWToNUDzNgsA4CqD?=
 =?us-ascii?Q?A0t9HlThO2vCUtFLFzpBnZacbq8YHa+A6NIU+PfotSYlpw2N6/CyJyZGIUBW?=
 =?us-ascii?Q?XpqZ138EMKmlGNHAInB4sLaA5LlYgGwJ2iWakyGWCS5u6/DIbR9g/aeYk0Ts?=
 =?us-ascii?Q?M4YbUNEhju4L2NNRri64Sb7ONoctNS8r6UOmwpKwziVfHQoeIczGN0Hqpvrf?=
 =?us-ascii?Q?a0EFd4sdxQD1zcQjQPJzzge5QI5YIctN/KY64qKzMJWhGZbwWfLF4I1+W2Do?=
 =?us-ascii?Q?iYIeigUNDkP1slstrO2TXegXe/BMIHpsJo5gW8six/KdmNBqnPc0py+m6xdx?=
 =?us-ascii?Q?pa8zcwuSdtH49QMJngEYkKOmfpM7CznxtzRW3F+gkl/kOLXHbGxcp7CqIS8K?=
 =?us-ascii?Q?b7jFi9s51grg2jsb39MHHvdyNbGNtXNqGDDRtesDaC+Y/3+UFt+IVQ8G7lID?=
 =?us-ascii?Q?kvoE+zINF8ZAD3puilWTdv8TAqegojTV3bNg9hBuahTQ/g7stZEk8/KUQF6a?=
 =?us-ascii?Q?o4Qa8kXHQ98uCFdoA7GVRjrzJOeJO0BrAEWm6/BX1QZgo+yvoVSIr6w9PmfH?=
 =?us-ascii?Q?6rKchWtlqpR/h/H5za8D6vZtnCYheozW7Ru/oN/PT7ylrwdAZdblCeEstxcB?=
 =?us-ascii?Q?4pnFlg/socyPUkAmBt3QhwgckcAcD7/t3ydhYQwk1a/TMJnJU6TNIe1rDI6k?=
 =?us-ascii?Q?KqVVfkisRg63X808FeNp6AwaTr+S81auB1G1yXnieiqwFXreXOY3w+q0/av/?=
 =?us-ascii?Q?0+dNsmguRkGlzyWwKTsAe5870kTTPmHORQN4xtO2BFMBD0sN6qswpO78Slsn?=
 =?us-ascii?Q?fSSJpc5dBaoZ0AkSPcCTE5a2c77qYrR78lgjBO6plYehF9Fnfa6Wo4CGyNZu?=
 =?us-ascii?Q?8AfSSaYYqPR13IwirJRRqub7wAJdryjyuij6l3UZbWDcjZrWj/B46ztJJ9+Y?=
 =?us-ascii?Q?4bO2COtGP8pBwdLBSh5q92DbB/ywxQ/QtPvLd7v4VMXkgwpg+aQu3mEYa9XR?=
 =?us-ascii?Q?fFYkH7Zm8VEmpCgKGhCsGMsJ+iUgadvTDLSaUo7zbY7pnGOcYuWRXo4c0f2y?=
 =?us-ascii?Q?RynZ4ga1jSypHLM22t9BKKjOMezPjTe0K/nHHpuAKglyAT1p/VjY2mJMgp9F?=
 =?us-ascii?Q?1iZ//cCWP+CBGjvF7fzkl1QHTfpuiiJ/6UbcogIQOySO5AEIxFEy4O+E7V7s?=
 =?us-ascii?Q?ftUl7iolJ63dtxzJhOdu/DY7/AJFLnWXX6CGyCMW2MPdLubZxjoMU+jEcjyI?=
 =?us-ascii?Q?andw2I9eTR12GkBciopRCcYtCu5EbYW/1fChMlI8B+hIdAUTI/Vwb1cul29z?=
 =?us-ascii?Q?BoZW+pOJaXpjj6+lgst4OBHcr7+4RkSY9fP6Bog4GQ9gXQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274e4a87-c55a-4ac1-083d-08d8d83d1095
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 20:53:25.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PN1x09STkIn5rCCu4U9cbaAWq9WKDvDrW3hS72TBxB0/Nbz7X/UlEEmHzigCBZbDPieEWTYXPV49ghwoQee53327rESJJz1Vd7xI8+/bSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 07:09, Christoph Hellwig wrote:=0A=
> I assume you are sending this patch, let me know otherwise.=0A=
> If you do please add, looks good.=0A=
=0A=
I'll split the gfp_mask cleanup out, and will submit it with your as=0A=
the author if that is ok.  I'll need a signoff, though.=0A=
=0A=
Okay, here it is :-=0A=
=0A=
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.=0A=
=0A=
I'll review the patch(es) once you post again.=0A=
=0A=
