Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68313C54E4A
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3331820746
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZUXqIhnZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rK2egdhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEKNBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 09:01:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31247 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgEKNBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 09:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589202074; x=1620738074;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hMpRQiJ3iTRvK563mWS/RC1fZoFaDPt7OWsNZ0Lt3Mo=;
  b=ZUXqIhnZMoXEt+fK61FIaeLBrideJDRfcdS3PSbQpG1USHXORb4rkDVH
   0cWHvabiLTqh18tJwms0pwnwzcJ+UYF1EDDA1oIwhZgCMaBS0FbW8x+MV
   g62Chu3MWPVR726saE53roi5zocrnxmy4AJf8zhOpPqRYvRr40mvbmM2j
   oqOlYR6fIgWwa0wPAM6IY5qG1lkHoZTWKzFDgO2rB+Nkr/T1jyuN+RMWx
   xWftc9AAf64/mmLHjnFLvGuj/FM2u0Xq43Th11dj2HwE1e0MreOn2CgoT
   1NQAj2k8e2CbbQlLN2giSHRXD2auBlaDIumVsMhyoDOnhvY2NfHoxehWk
   w==;
IronPort-SDR: +uJ0uyf4tF5vcg/w7ah+TSsg0idyiYrBYSsVzCowc86dm8SXNWYL6hSYrzV9V3dDnC6lfWZJmf
 T2hneMPcqKp+5fqkOOj5Zq62m0eK4eU+5YmxcBlEtk1q1zCeqrgFPCNMTQmC6SuFd+u4aB7cM+
 qPXk+SPwHHdJ38UyBudUnLBcP4WTYSGWeHkcMtzqFiECsSNLiDhqtq9PwR/MDm8ixtc4W9KwZf
 yUM4GVbp8f+jdrRyeGtvs4BXVx6C2KRHay21XlowvMYyayDyZ5ami95isHspi9/xVldiauQ1b0
 sYs=
X-IronPort-AV: E=Sophos;i="5.73,380,1583164800"; 
   d="scan'208";a="137405392"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2020 21:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDXSdswC2Ul18L8Ff3LVztpeN4mTxblEH7slm4zBVNIXDmGWCyKDLsEQ4rowgy64lbavg+pCZHahXGq92SWLZanPRla2ae4bPaAyJBQntUcdXIncxecXzC9NMGvBOzYEIX28V3iy5UzAfiOf+7qXSflfVuGs6JtDfnoKWYUfhUCKWsGdvAoF4L8OrabtzHRp07Q0YnHnjQ2etkcePeAXF2FmICe6T8gx7i4wKxTpL0wx8bAR5V9gttWI82l4fmPM0ihLHNbAXW6CplV2A5BdXVC+P5y6GeQtC1pAVTxfahe4sx5qLUu58M8xKpUPbdH441t/nfMr16A/hHFijdAmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q548dDc89Mc1wNr5FY5shP5ZcLuIegONXBc2J216lM=;
 b=E+VL0SGv2ofccxZu1/BPOyuwTeub6DX1R4tunqf8aUz9JUjpwLHojiYhIYspZ+vPaAkCgmNirn9IZMzNoGsL6ChamjGuRltkEV161faVOHlJlPEbFO4ZJ1Cs9VYacJCayhKLCVHtpzZoV8maxY0AaOx3KxKmUq/pOT4jvLAg8NlwcO6wTZo/45lKJvfg05EXNywB1+/1lhbTUwKxltsSb3PtOfvax7mATL08Cn0YZuQy0LeMtnRF204pvCXdfCx91SsJOeU0qTqdz/Ii4bMXxQJm7fXq9JQZECrlcEULh+pCgrZEOqO8rACUpIcSqMirKb095qzhBx6Ykxe8eI3o7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q548dDc89Mc1wNr5FY5shP5ZcLuIegONXBc2J216lM=;
 b=rK2egdhKolFmJp/hpvLVApDFL3BWKO/xM0Xv14i7zzO6e3gVf89FkluLxWZGwhW7r4ajDfSCzpQLBr/jO3n2j/5pkNqany1peG50Cq903tn4oXX72B4CZDADa/3nVcyevZuniE1kbeDPBOPM/Rf8h4anSqSkjhHnh0KRICDF4Zk=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5SPR01MB0035.namprd04.prod.outlook.com (2603:10b6:a03:22f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Mon, 11 May
 2020 13:01:12 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 13:01:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Alexander Potapenko <glider@google.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
Thread-Topic: null_handle_cmd() doesn't initialize data when reading
Thread-Index: AQHVm53GT+JHqNkf70+buklNLC0a/A==
Date:   Mon, 11 May 2020 13:01:12 +0000
Message-ID: <BY5PR04MB69001D14C2318410930ABC03E7A10@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
 <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d8d68d2-6832-401b-dc53-08d7f5ab619d
x-ms-traffictypediagnostic: BY5SPR01MB0035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5SPR01MB0035AA84D2D14DC7FD889744E7A10@BY5SPR01MB0035.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2gYUL604+MkXRnYOPbeDeB5mTjlStVQzPN/N5Kh8Nh2KH8ITollgU2Hfuchqfy9nF2IrswMPF1AQm741KhoswIdTMOrB2Q/fd4G/9ndXMUXPuLGZHvJoS6/xw3xuP4cEJXDLwh5bGEY2MZ27X7hmeX9ZeOsOQf7Fug/Yg+OZl8quMXJyfrfwjYSZqV+sRAYReUMo5Xp8haXZoeDJ9g7adQPbAI5t//m4xSd5HPdF7Lxf/0GewOT+FldM0LS4xeCTnTrfy090s8foJ/tsfGi9r4i2WfxTBC1SR33RiIzLX4cbk0mgnCs9d7Eg4/OzjbIVn49PYVFrL7mu+lY0lZ1mQXcHqkuP4EcUq/SX986IAX8mzwcigQMri8QsbaiUZFs9AYfYLJ8cTDHbRve4Sl0Geu6Jnc22CuswWO/CBQpIPGJSWOMI2FSsc+bmnxJQm4pmz4YHDwF2rlX/fPZncwJ5dKTBjQZsHUJ4+c1eHxLdnFYoj1Pu7Z0hG00VudMItaSebaCjS82XQuUSUgtntH7aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(33430700001)(186003)(26005)(478600001)(9686003)(2906002)(4326008)(55016002)(52536014)(8676002)(316002)(8936002)(54906003)(110136005)(6506007)(53546011)(7696005)(86362001)(66946007)(66556008)(66476007)(64756008)(76116006)(33656002)(5660300002)(66446008)(71200400001)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 63zPEiGz9/W6ZQgOaxsyWvAzUWi51epMId2c08R5j/8wM0TkFfa/At6Ns4OZ5tZb/YXOjzd56Y0bap8WpI0lpcNP1QK4kb7Icebxi1PNX4LSBI6/ZPwvgyTMZjcJLD4VSQVrKFSz4n56ZV2Gl2AsTywX5TzFuhM45WgbchVCaqrQPAFM8X374Na78g4wNBrLB8ytM1t/QEXkDZvomjMh8NuZzDEuBZqyEtNPgiLk0EJw8fOXNFDwZbc6wxGX7iV0s/V+afzvI3BFVvcQppzdRZ2Nii82OUbXW9goyzxG+wLCynx/JbwnsEbl6SCLRgs6tYLP1Gu23Ow0Sm1VNf7XQSSzH2EjGrM1f8jKuPyAEEsl4ivJqy01Xqz8dOioYiy7DZ3uWq6UwNjd0H/8JZOghVc92lFQp914lLG6/1/720XcNwG1kZVPBoQ+Fv9XhlSqBesd471gfWT2YspJq1n1TXhIRQw/mLoM04IDVUixA1FFtJHKQvZu2OzXgHte8dEz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8d68d2-6832-401b-dc53-08d7f5ab619d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 13:01:12.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BN74WuLMkFx4A9a1vjgV++JZ+DO1ZFsLxXbvRydGR8EyZdlXfjETRx47sgmD1eLtSVbeoG8rRB9ApJTnHCek9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5SPR01MB0035
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/11 21:58, Alexander Potapenko wrote:=0A=
> On Sun, May 10, 2020 at 6:20 PM Bart Van Assche <bvanassche@acm.org> wrot=
e:=0A=
>>=0A=
>> On 2020-05-10 03:03, Alexander Potapenko wrote:=0A=
>>> Thanks for the explanation!=0A=
>>> The code has changed recently, and my patch does not apply anymore,=0A=
>>> yet the problem still persists.=0A=
>>> I ended up just calling null_handle_rq() at the end of=0A=
>>> null_process_cmd(), but we probably need a cleaner fix.=0A=
>>=0A=
>> Does this (totally untested) patch help? copy_to_nullb() guarantees that=
=0A=
>> it will write some data to the pages that it allocates but does not=0A=
>> guarantee yet that all data of the pages it allocates is initialized.=0A=
> =0A=
> No, this does not help. Apparently null_insert_page() is never called=0A=
> in this scenario.=0A=
> If I modify __page_cache_alloc() to allocate zero-initialized pages,=0A=
> the reports go away.=0A=
> This means there's no other uninitialized buffer that's copied to the=0A=
> page cache, the nullb driver just forgets to write anything to the=0A=
> page cache.=0A=
=0A=
Can you describe again the problem you are seeing please ? I can't find the=
=0A=
first email of this thread and forgot what the problem is.=0A=
=0A=
> =0A=
>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main=
.c=0A=
>> index 8efd8778e209..06f5761fccb6 100644=0A=
>> --- a/drivers/block/null_blk_main.c=0A=
>> +++ b/drivers/block/null_blk_main.c=0A=
>> @@ -848,7 +848,7 @@ static struct nullb_page *null_insert_page(struct=0A=
>> nullb *nullb,=0A=
>>=0A=
>>         spin_unlock_irq(&nullb->lock);=0A=
>>=0A=
>> -       t_page =3D null_alloc_page(GFP_NOIO);=0A=
>> +       t_page =3D null_alloc_page(GFP_NOIO | __GFP_ZERO);=0A=
>>         if (!t_page)=0A=
>>                 goto out_lock;=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
