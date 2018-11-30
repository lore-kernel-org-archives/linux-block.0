Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC33EC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 04:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946882145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 04:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="izlnNZvj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d1J+tgDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946882145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeK3PKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:10:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5973 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeK3PKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 10:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543550531; x=1575086531;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=g86Xbno1OrBYIT+LBS53OJxF1E2Bcw2KOF78z6gxYig=;
  b=izlnNZvj0V+CAWTvz3EOCsahqQPNjuckcjlrP3jhsP71h1BrGLdym9oj
   nBvcx+LMz4anIUB4gSntkfBteV4f1x9WKsMGlYOko02QLSBLBnTxEqWk8
   +5x9du+potj4AOH/eIYBw0BPMr91u8L4PUaMyO2kYVKp4eTyZpJk2sfxp
   0f2PVQwrfh3ate+p4m+zkZqcMhMwjMrovYbNfLQRQLKV6akSxjw1Fhu/z
   PCPNi3drtgIGK4rsEezHtRJ2rZUvGyFUcldpY1aukaNpXYD3MkuwMPbaZ
   g/XrJ4mK3Jt3lK8KkBbIezf3D5akRzSK3XA+EujSTutJ0XqYfUvSwVrrO
   g==;
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="95472335"
Received: from mail-bn3nam01lp0176.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([216.32.180.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 12:02:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g86Xbno1OrBYIT+LBS53OJxF1E2Bcw2KOF78z6gxYig=;
 b=d1J+tgDr2srssz0fdm1+vHFgIvdE6ywGxzC5JgfA4YWgVhQhLEbGe/OKr1sobo2HAJcLt114IojQzEfhr1+v4tNlLOvMoE6iZRC/ZiaWM/vHaYBpxmzrItAb/PzdwYb7r93hnTbE9A2uK83mKZk7vDS+wgOGAYpyIbEf7BzHC+A=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1332.namprd04.prod.outlook.com (10.161.208.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Fri, 30 Nov 2018 04:02:04 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::fcc4:f2bc:acef:5d0a]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::fcc4:f2bc:acef:5d0a%3]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 04:02:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bryan Gurney <bgurney@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: update documentation
Thread-Topic: [PATCH] block: update documentation
Thread-Index: AQHUhrlSAxZp+4biPU67xHwB0AllYw==
Date:   Fri, 30 Nov 2018 04:02:04 +0000
Message-ID: <BN3PR0401MB164035D6F4678FB529B41C46E7D30@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181128012552.20568-1-damien.lemoal@wdc.com>
 <CAHhmqcTR1TTdA3YL6X6VSWXWi4T2zBqNk1obYObjj4ncsgrdRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1332;6:mFaObMVVLOEXoDOXziwfb9Gu+EvH1+OL8nQpULMsGlqKuvSV3pmnmJmhSLpap149zKbDgAx+aMUsy3eMZS72n8xBOwZTEf99TtXp+jXzseDqcFRVKKV/M8R2A54uVSZoLVMZGqu2rq6ZeoWaiTzDYqUbIaTJK1RV15g3Xk7JjcUMTWXm0XMsEWNyo9f/IN+HMnyMnHDKBPeDwnE+VWUc1WncweFy/3il4CzrR/fUKFJv33sVYRDPV+SNzUreJfE2t4ulOJCY/wRvWU2jg4iEA0P9fNK+bpLK7Kq89K8QtfRqs55YtbrHH1I9d781Y7uhKeIXv3JUznGback/XpL/rI4W6QGAhZk/9imJvSgLQGtpayEyZ1Wuto3I2033A+VWu1COcgGQWOWDWRBNGEmi0wPFWwiJ2aN2tf2QBqUM3vRRQtuoUP/onpXFiVoqs9MJdPh3FnmxlrounW3+WtSksg==;5:vQmscaIx+YEnRyuWACbjb5sMohkqv0z+wl0lADIoOUFIDd7Qyh1E0xfQUvAbIKOW8SKdkIesrdYPH/W5PV8OIHr7llEE2nBb+0sUSMlHJywxD+BSsaLy3MQDwXG5HybV9ErN5cGqVk4tcgy1tilzQ853otOkmwC93iKZZS2OQXY=;7:3/gI0/LRQckVD8PRSboOsRsrLTR68ykxfyRsFnaI5tB/9NwTWIIm4dFQKcnVF83av0+VC7H//EtbAaoUDdxylvJbhh0PDiecEZkjnkK7gekfz4AFFqSrNIubwVUgKIQ4YPFIynpFHQ00qfCNRM6Jeg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: df8355a8-216a-4f15-14e6-08d6567896e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1332;
x-ms-traffictypediagnostic: BN3PR0401MB1332:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1332571926F12DC151A3DFAEE7D30@BN3PR0401MB1332.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501459)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1332;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(72206003)(229853002)(68736007)(55016002)(74316002)(71200400001)(5660300001)(71190400001)(478600001)(53936002)(66066001)(9686003)(14454004)(486006)(446003)(7736002)(33656002)(6116002)(3846002)(305945005)(14444005)(476003)(97736004)(256004)(86362001)(81156014)(186003)(8676002)(6916009)(2906002)(6436002)(53546011)(6506007)(26005)(15650500001)(4326008)(6246003)(81166006)(105586002)(106356001)(102836004)(8936002)(316002)(76176011)(99286004)(7696005)(25786009)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1332;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xSGDpA52Ea677ApjQqZE3drtOBoiB8PPCjTS9ZHjtbIcXyS7RWgiVsxHqQv37PYumgwAIRTHu3vM2D2X0bYTG5IT+V9FuxixpiiqojU/60B/UTFxwrSbCYIBaqHKJPPI8KlIDg9BR/R0pXAkQ6EbNX7gtkvB/9l3Wp0wxpE0HPHh3uHTXJU6aVqhYBTUn1kRTZ4eobt4DjcQWBGS/5aQ1dvJVnAmwrxV/cVztQI1WJduuapUvnBnNLOj6o9F5boWoxkN8qbQsODZhbQERraV6Nhz8ekKcne3CDIHPoxs5zBpHdrdX0u09tpHNXEVfmy2oWMsG+DK8dev1bPrRTcW4CgcYQH164jYJYdGA/4vXAA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8355a8-216a-4f15-14e6-08d6567896e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:02:04.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1332
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/29 23:54, Bryan Gurney wrote:=0A=
>> +chunk_sectors (RO)=0A=
>> +------------------=0A=
>> +This has different meaning depending on the type of the block device.=
=0A=
>> +For a RAID device (dm-raid), chunk_sectors indicates the size in 512B s=
ectors=0A=
>> +of the RAID volume stripe segment. For a zoned block device, either hos=
t-aware=0A=
>> +or host-managed, chunk_sectors indicates the size of 512B sectors of th=
e zones=0A=
>> +of the device, with the eventual exception of the last zone of the devi=
ce which=0A=
>> +may be smaller.=0A=
>> +=0A=
> =0A=
> For the part that says, "...chunk_sectors indicates the size of 512B=0A=
> sectors of the zones of the device", should it be this instead?=0A=
> =0A=
> "...chunk_sectors indicates the size in 512B sectors of the zones of the =
device"=0A=
=0A=
Indeed better. Will send an update.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
