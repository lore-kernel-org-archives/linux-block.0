Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5B8C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00A62070B
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WHcp+hHk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="moBv0UG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgELBmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 21:42:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14305 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgELBmJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 21:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589247729; x=1620783729;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W7j3e8sF5RQrlPSJ0sFhZKd3KqNsEGLzcnsyGvgLY+I=;
  b=WHcp+hHk2kwZxSDtnh9CmVKdvXQTfe0ChweuCLtZmekIiIx9UUFmfJBK
   d6PbbVmNW00Upt/FXhoqXCptlts93zlAabxP7zP86ObnU7WwAaiuL7jDV
   lc2KzBAWKaA3tbVyik3aEaWOkqi1fCz/4TZUBCaxm9dpCCTbox5CGbi+p
   lBwb5XmvA5vEV3N3pW2SCAEx/vcbHD/D1SkbWHXcLJvbFmxoUd8T5O/K2
   skaImjyX9XLMAX+CsRfyncX7U6I8TZSuX8bgWdb6/YuVN+4C2MS+2/MwF
   3d6Tgr3p6o7mvtuK0e2DB798cIL7E6G6Q0yy7Lb8Fs68ZMpC3dOqfmzKV
   A==;
IronPort-SDR: xGBK+K2k0A4MJwxcItUNsZUZ2Tc7Z3fNVdEZNcpw4u7aH7VPuSyP5mtCTdtK5cVSH2PTZPrKp3
 UtocVuSR93KIMFOaqTQmD46X+Q1+Z/ODohFMzzFqm9YpYbIRLUjVGensXKey/5KCA9Q+GMobSF
 k1XYLVkRdiwSgFpHXAC8BDhZWGqx3a39vSE0BgfsDGAQxwdHbrycBF/8x2xnEADk1JMk7WFwHj
 6yp5Lnc+lAJJosNdImyvYsxU0bH8Ukg1rBeExFYW0M4ITWQl+AbgfheNAmMIwwZl/upmiXyZn/
 dnY=
X-IronPort-AV: E=Sophos;i="5.73,381,1583164800"; 
   d="scan'208";a="138881834"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 09:42:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb2zo58yfuMdMYTX6y7MHaSgUIpvze8LsCXuwDHdhqJBAMrJ/Bl9b2JodrtcxZNghXFbdmRIT8+WZY88eaZoa7xYNZZkYGx9BelrMaAU2lcYsZHQPCACku6CQeiUkfLPSVIwroGTUqgaYC/Ze2B2Me9/ZYxbTBaOI1n8zATXY8Hk6GvSBmpLjAiCb+ZtfVbwUO9Mha74gTV8koVgRvufN/cfSuntMbLGjuFPs3UgbmYW0mCU8z+1MLNbf63MClcDfsdck3qwpPEafJ9DXK+9Jls+A+kjmr8hlokVrvXapp7sQCBQSj3pujFtUo4wtiEtJakRe6xSrs0tzj17hahW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7j3e8sF5RQrlPSJ0sFhZKd3KqNsEGLzcnsyGvgLY+I=;
 b=cCNRE/4SaMG/M8t2U7yUstm0qmQcoi/86YcxPXLdSBfjRNxlgqQRRUX4mfscIYfddGRDqsyzAwUDBl4bLseOMFKRAcW25+Ox2SK3/SpvEiIRYSGiR3sf1ox1ataSgvvgwyvWIwSW/SNu9AebcntvsdFlIqxj85nHFAFley7fK4vJudrXU1pqSng7KfjVAvvllkEVCMOyw2Wcr6rzzYtFi3MSA7TSek5KP+fYyNG9HjeQj6iHxFjFXid752/zZTMGmJvBFv/Udn2xSeJynt0PUNNN6sKsasKl0p6yDWxAUZ1MlOEtIPYt4pTZyJQb6LN0Y4VsXQfHly8ci6mPcfmrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7j3e8sF5RQrlPSJ0sFhZKd3KqNsEGLzcnsyGvgLY+I=;
 b=moBv0UG1s2ZoWwREPb3TnBImk56qc1nBgPouPJxDHPYc96w+YWFWTmv/Z32Ww8uspwGVHerFF7lL1JUD/usLDydSPqqvDMnmNdo0HG0Uwbs+aykNN3Xl3wbU0zuTT38zS5Mapax1DY/Va8IQEQMKY5LlB7hFjTaCWe5z74cdmks=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6294.namprd04.prod.outlook.com (2603:10b6:a03:1e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 01:42:06 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 01:42:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alexander Potapenko <glider@google.com>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
Thread-Topic: null_handle_cmd() doesn't initialize data when reading
Thread-Index: AQHVm53GT+JHqNkf70+buklNLC0a/A==
Date:   Tue, 12 May 2020 01:42:06 +0000
Message-ID: <BY5PR04MB690045ED7665BF98A2EA7ED3E7BE0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
 <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
 <55674c05-37dc-0646-af78-db4c3b112683@acm.org>
 <1e455c9f-4908-f476-f674-c0c920c17f9c@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76028546-3672-4d31-cf55-08d7f615add0
x-ms-traffictypediagnostic: BY5PR04MB6294:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB629431AE9C1F9E0122DFBF97E7BE0@BY5PR04MB6294.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oS2DNvpHBDVakxdSAiiyEVLvHhrUo7jGQ5+uelXz+AQrdRrmgUGevLDHEIVrd22SOOmnWKYnvtQ2DX8Zgu4I/yMPm+3JXB1FAyRIpoqaKJ0tmVgOn7m6YWAtSMWOfR+IbJUWYcfeERKb8btyxcjvmsgMqCxGBxCkP8qBvfJPLfLuRLouRrQO0nzrtqGMwJw2rA39bfPyJwwZ0/lH+b2xoGgBqUGz4ZALV9OINkeGvFSTGyafKcIv+f0nOHSofk8hTUqgWj4cf1NmO7OE5atIpFlW3zzcn56HebmEIp81afBFxXdDZUDNs2NAsJ5LHxNIGVh57HwVoE2gE0oZLIcunbQYvEF1z5k7QblcB7elegTwtqGp43cMEQdo+lkIrxmsK7tCYe0dZsbNuM7Pfs9qNQsR8FHAxfsgb0UuNX1hoV6idTjTWMVlvKcCcN92hzc+SLb6yotqY2aE1eWOwRHJGTVqYZsBWEmSK7t8wdGnrUClYmcyxJFx+IcOANZW68anOm9SEUfAyDjwMqs4GknOZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(33430700001)(86362001)(53546011)(186003)(6506007)(64756008)(5660300002)(66446008)(8676002)(4744005)(66476007)(8936002)(66556008)(54906003)(2906002)(66946007)(478600001)(76116006)(71200400001)(110136005)(316002)(33440700001)(26005)(33656002)(55016002)(52536014)(9686003)(7696005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cRWycNXNoXjEgvZl/p+SPV0XXW+MblQf76TdP8+CaObaAYfkfNpvc+0DCxesGEGA6LuHoRRkLfKqlotrddGb/HpRR/G8FcewQKstrMRdcLcTsf4g+RkF22ITlBB//i5OaO2RVag/UiXeNSFkwGA8bDLsy7kATjn7VooQzm4ZkLRzCYn8zcdWZz6tuZovHHtgikf53PdrdlXGiwUThRqSzLhfnpxN2z4k2pDVpWmUeKKwYaRr4TrlzawDLiIS24echZfk0NrK9HasqtaNDoljnnDsx/ecyYBYiLZANtsijBRICCXcTOtyFO01lLVpJCNpJojIw6peOzYyPu6IMz8OjuVAZugYy5THENf374QpJLztdqwoIJTb6RgjYJ0EKfuMwnaDS6xRGHUPEZnVtsCgDBn1i1DxEJLHb++bW0R/vKOmjR/y4LnH4XtCf9WkiEpvIGNhPQ0FbKgNO1wjmV2KEmYipK9hMFDjICmxJNrj2wbcjIkHP+3X19YTgdqgV2qg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76028546-3672-4d31-cf55-08d7f615add0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 01:42:06.5829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUSdGmo3pJQ1wj9WRpE4rLsRv2s0nwhHdth2FfwfSwUca0yA5GwiSh+85fxVAR/RPZ/XeKzvaM3MX6lX35CeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6294
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/12 10:25, Bart Van Assche wrote:=0A=
> On 2020-05-11 16:18, Bart Van Assche wrote:=0A=
>> Anyway, can you give the patch below a try?=0A=
> =0A=
> The patch in my previous email handles MQ mode but not bio mode. The=0A=
> attached patch should handle both.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
Bart,=0A=
=0A=
The patch looks good to me. However, I have one concern regarding the=0A=
performance impact of this. When nullblk is used to benchmark the block IO =
stack=0A=
overhead, doing this zeroing unconditionally will likely significantly impa=
ct=0A=
measured performance. So may be this zeroing feature should be driven by a=
=0A=
modprobe/configfs option ? Doing so, we can keep it off by default, preserv=
ing=0A=
performance, and turn it on when needed as in Alexander use case.=0A=
=0A=
Thoughts ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
