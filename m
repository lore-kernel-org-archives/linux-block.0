Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E8C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9520851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dXaeKEIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD9520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeLMUFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:05:15 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:48314 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLMUFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:05:15 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E6B4F24E2169;
        Thu, 13 Dec 2018 12:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544731514; bh=/3EuU4GtJx3m/O9kzVCKyPTlPQcUHqWvPObOVWItNG8=;
        h=From:To:CC:Subject:Date:References:From;
        b=dXaeKEItH/0xM/LQl3sCR6rrg5R29dbeVcm5jyEBUREJDkHV+6nNSNSN77R13bQw5
         O3oInHMYvOLkO1GaHpbKYdFxE4L6AMJ+yj+ioRThYl4Fw49Lk3CngNMEBwosLYzTzj
         BeB4kHxxjbB6QBsx/ct6vcCMMOqKqARCVhCxjHOK96JbvcOdZfPL4huDkrps6qS35V
         BIM4bFbsU5iWGibgk6yfuWgY5IkVUrEC3DwWk3TQXVpaq9S6jynryjwrEzVUBSTSK6
         MhT2WO3XE2l0bW/MNGXKoQ3Icrccgtk2JMP3lYtHsnr3ZIBfEwy5YBkZUoxzRk9E7o
         oBRYsxQuZvs1w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 88E6A5A2B;
        Thu, 13 Dec 2018 12:05:13 -0800 (PST)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:04:57 -0800
Received: from IN01WEMBXA.internal.synopsys.com ([fe80::ed6f:22d3:d35:4833])
 by IN01WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 14 Dec 2018 01:34:54 +0530
From:   Ladvine D Almeida <ladvine.dalmeida@synopsys.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        AnilKumar Chimata <anilc@codeaurora.org>,
        "Satya Tangirala" <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Manjunath M Bettegowda <manjunath.mb@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Thread-Topic: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
Thread-Index: AQHUkX263UDDRFD5F0ekGH+h/ea8Aw==
Date:   Thu, 13 Dec 2018 20:04:54 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C30227F0B@IN01WEMBXA.internal.synopsys.com>
References: <20181211095027.GA3316@lvlogina.cadence.com>
 <20181211181647.GC221175@gmail.com>
 <CO2PR07MB2469AD9C0A121EBF94129A11C1A70@CO2PR07MB2469.namprd07.prod.outlook.com>
 <BD7FB879CC136E419544C8E2AE7B9C30227EE5@IN01WEMBXA.internal.synopsys.com>
 <fb17d794-c682-3261-cbad-94ce4c14eea1@kernel.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.236]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/12/18 7:42 PM, Jens Axboe wrote:=0A=
> On 12/13/18 12:39 PM, Ladvine D Almeida wrote:=0A=
>> Suggest to take a look into the article https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lwn.net_Articles_717754&d=3DDwICaQ&c=3DDPL6_X_6JkXFx=
7AXWqB0tg&r=3Dz00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=3D-pGzV3wdSje33=
7vKOYoYB6NgU_DGDmQvfQ9egLDRYNQ&s=3Dc4FXsrwD0BLAjE4UC47R2ngLnx_DP5jiOr0dtZ7t=
Gsw&e=3D=0A=
>> My real concern is how to achieve it without any modifications to the=0A=
>> bio.(because key slot information has to finally reach the target block=
=0A=
>> device)=0A=
> =0A=
> Guys, you both need to edit when you reply, wading through 650 lines of=
=0A=
> text to get to this...=0A=
Jens, Thanks for your reply. I will take care of it next time onwards. :-)=
=0A=
=0A=
> =0A=
> You obviously can't modify the bio if you don't own it, but you could=0A=
> clone it and then you have storage in ->bi_private.=0A=
> =0A=
=0A=
I agree. I can clone the bio in the crypto target and use bi_private.=0A=
But, when i finally submit the bio and it reaches the target block=0A=
device, the information stored in bi_private is lost.=0A=
=0A=
Regards,=0A=
Ladvine=0A=
