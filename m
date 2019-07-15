Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDECC7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2AB20693
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 23:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SjT/O28i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f3xW5sed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfGOXl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:41:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30369 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfGOXl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 19:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563234088; x=1594770088;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PulYK5tgXTCWoBrJ85k2zQ4m2oJhPo5wQKVdrqNYNy0=;
  b=SjT/O28ilezNMI8Oq7WHP7qTNdKsmWk/f6RFLJlHw5OGM8aTmmrROCyQ
   p117J+GTiYY+x4UfPWo6l+et/Gx/eK3VbpAwyDvjF5JtDey2duHbJLVOE
   avSSEbsDlhze9UHa0yWvQDKuajl0JoGoJ41o9ip/QuJ+YSWv5skZo6QSt
   /+75Ham4uS7T3dvzl8PC1fDZ+rf7Di2eNzXUu3lu1HLxv1IdqxBCci6EW
   fdS63aTHOfGuLjKGJ+ifUqnizU4pqiBO4I/2z9AB84YXTVTWwWRs+W/rV
   A07ACqI3lWc1tg8q27lQFslp3mCqwWpCd2cosFZerMVscDTLz5Z9HwwrY
   g==;
IronPort-SDR: MXo2OPCjt4QUk1npKIF0DeYBX1qh6qCTjn+w0Dr/N6BaXoGutERxWUkdGpi3wj0UiaF9oWYQow
 vgPgVefVj2d1Ivfwkv4FlZteZGzxmy9tPeG7+XsDNzf6HUlpYDaHLZ+6QZUw2iHMLl1ORhmDx1
 bGLYcHq9SeEjv5zN0JWszQTUgDpaW+3Cz3/MpTAmKA25GI8hJtcX+ki7WN4ePZuD2cnFcGwq/D
 NDmX9BHB9Rk8C56RtLGtIsclvaaIdi7nemIVdS48avlsSCpOewt6jcHcS9IFFKPPTWIdo9Lbkr
 FBo=
X-IronPort-AV: E=Sophos;i="5.63,494,1557158400"; 
   d="scan'208";a="219559255"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2019 07:41:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2ZxfAD7QdupdB0+a3UX9XWlPPlb9amK0lKmcDIfoj7/yT3gpIPMJqXLggwo02sc+MWQJ18X+VpQb5OqXCRJo2pIj6du61OQ1VPjg2suevNlEL4NQeMvBmNwcZ1xbFoTP5obLjvV5KZEIOCHFsT7FpsTcQHlQ/cS2uqWCRuUYDTppW8kFFn3RzWHxrDWpr/RS3jFVgN7sWIL7IPwZsQL3+/tDib+pJH4Q1SSrrZNRk77mctXa44F0S4sAkzJa+CaXB8oc+5Xh1rVLnGqH04TwebGj+pff645O9xrt8XM9Q1tc6jTUbFu7sGikevOQtaJetpNctA3JERaEs+g6f8kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGWmj+zzJojqBzJbvOlLY2eRqW/qk+sit+x43TLc9r8=;
 b=mgyZILoA/NVTh+ezP55l4olv9eQJnWJUOIhuHeVAKpq2PI0KshTJIQ7kZAkf3giBJwpQEjACsL1AoWAvsdN2FO9nOucAHur9AyNy9P9m3aRuYU5ACFPMdiC3dO/9ly7KOdTKSVWKT0GRwhoma8lr09f9PS9NvkEhAfx3adHzRO6gOzsxeT9sLBSJ88jfqPnbvPaB/wC9ak5fF83Nyq0Dinyftp+tMJf+gQWPXldfomWBoPHbB8J9a4cKG1CXjIFQlp/0XOb1cXNozQT+1dI5CGkMVmR0IyAE9qJ/7sCp6OON36gtVg3Qc5l7QhY92Dpf3MB5g9+Ba9uBISou2UdqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGWmj+zzJojqBzJbvOlLY2eRqW/qk+sit+x43TLc9r8=;
 b=f3xW5sedo1qKTklEdJ+0FPLDa6F64vL8cYFnSLVebhC+mdGcrv0zhZteFacXssb3aiDZinUXQVt6ZyyPHs3FYoY98KUCcSYAYIxjCQSrOPoiNGUA7xStdbJDmLb5fXXrsVYEuglECQ0IwX08HH9L++n8/EK//BJjBDAphIk2I5Q=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Mon, 15 Jul 2019 23:41:26 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 23:41:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [block:for-linus 20/23] include/linux/kernel.h:62:48: warning:
 'zone_blocks' may be used uninitialized in this function
Thread-Topic: [block:for-linus 20/23] include/linux/kernel.h:62:48: warning:
 'zone_blocks' may be used uninitialized in this function
Thread-Index: AQHVOVrdX1MDkvxcvEijEWF8X5rW2Q==
Date:   Mon, 15 Jul 2019 23:41:26 +0000
Message-ID: <BYAPR04MB5816248A733264DC19E050C0E7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <201907131730.Br9OqtbO%lkp@intel.com>
 <BYAPR04MB5816C2EFC9D3C9FEF6DCCD2CE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <279546ac-9089-d5fc-f26c-9e46db269623@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcf16744-3834-4be4-e8dd-08d7097df444
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4901;
x-ms-traffictypediagnostic: BYAPR04MB4901:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB4901E602808E564DD7FFF5D9E7CF0@BYAPR04MB4901.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(189003)(199004)(5660300002)(7736002)(2501003)(66556008)(229853002)(68736007)(64756008)(4326008)(66446008)(99286004)(305945005)(52536014)(2906002)(316002)(53936002)(53546011)(6506007)(6246003)(7696005)(76176011)(74316002)(6116002)(86362001)(71190400001)(8936002)(8676002)(3846002)(478600001)(25786009)(71200400001)(66476007)(966005)(33656002)(66946007)(55016002)(76116006)(91956017)(14454004)(81166006)(81156014)(110136005)(446003)(19625735003)(26005)(186003)(54906003)(476003)(256004)(14444005)(6436002)(5024004)(6306002)(102836004)(9686003)(66066001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4901;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3tmme1iVAV1hL4QA3Fke6kYjnW5yg6kAzbFOhy9o8oaj+Zn7lpKam1nbJBT3knxSyii7UfOPqTDCRxl8prjsv3Oq9IhBkS+l3i4ysPaIW6ZPVWXEFzovfqMK34qj5We7U+ujb7lCTspzqede5SAKG9kifN7sFupCbCMB1sKT2MWetnAljcFdsmiiIM3Z9pfKxRPWr0bZ/VBU0lF62Q3HwJP7uEyhqv0tjeAjL0+Dat0bPO0jBFxFsJVsshb5vr7TixpFgYJqM64V77c+10Z6dSX53A9cE2LVu6/y+TSvN0nNGwOjzIoG623pG2mxALVvPpe7KpcqNSlGkXhqeJxSL9UTOFJakwL2iI98DnJIU2lkLaLy3DEyINqS4o08McJuD/9mD20CU0tVNngnkQOmnepIJZ9TRLL43XWMSFECbzY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf16744-3834-4be4-e8dd-08d7097df444
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 23:41:26.7744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4901
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/15 22:56, Jens Axboe wrote:=0A=
> On 7/14/19 11:43 PM, Damien Le Moal wrote:=0A=
>> On 2019/07/13 18:10, kbuild test robot wrote:=0A=
>>> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/axboe/=
linux-block.git for-linus=0A=
>>> head:   787c79d6393fc028887cc1b6066915f0b094e92f=0A=
>>> commit: b091ac616846a1da75b1f2566b41255ce7f0e0a6 [20/23] sd_zbc: Fix re=
port zones buffer allocation=0A=
>>> config: c6x-allyesconfig (attached as .config)=0A=
>>> compiler: c6x-elf-gcc (GCC) 7.4.0=0A=
>>> reproduce:=0A=
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross=0A=
>>>          chmod +x ~/bin/make.cross=0A=
>>>          git checkout b091ac616846a1da75b1f2566b41255ce7f0e0a6=0A=
>>>          # save the attached .config to linux build tree=0A=
>>>          GCC_VERSION=3D7.4.0 make.cross ARCH=3Dc6x=0A=
>>>=0A=
>>> If you fix the issue, kindly add following tag=0A=
>>> Reported-by: kbuild test robot <lkp@intel.com>=0A=
>>>=0A=
>>> Note: it may well be a FALSE warning. FWIW you are at least aware of it=
 now.=0A=
>>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings=0A=
>>>=0A=
>>> All warnings (new ones prefixed by >>):=0A=
>>>=0A=
>>>     In file included from include/asm-generic/bug.h:18:0,=0A=
>>>                      from arch/c6x/include/asm/bug.h:12,=0A=
>>>                      from include/linux/bug.h:5,=0A=
>>>                      from include/linux/thread_info.h:12,=0A=
>>>                      from include/asm-generic/current.h:5,=0A=
>>>                      from ./arch/c6x/include/generated/asm/current.h:1,=
=0A=
>>>                      from include/linux/sched.h:12,=0A=
>>>                      from include/linux/blkdev.h:5,=0A=
>>>                      from drivers//scsi/sd_zbc.c:11:=0A=
>>>     drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':=0A=
>>>>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used unin=
itialized in this function [-Wmaybe-uninitialized]=0A=
>>>      #define __round_mask(x, y) ((__typeof__(x))((y)-1))=0A=
>>>                                                     ^=0A=
>>>     drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here=
=0A=
>>>       u32 zone_blocks;=0A=
>>>           ^~~~~~~~~~~=0A=
>> [...]=0A=
>>=0A=
>> Jens,=0A=
>>=0A=
>> This warning does not show up on x86_64 native build with gcc 9.1.=0A=
>> I just sent a patch to remove the warning, but I do not have a c6x cross=
=0A=
>> compilation environment available so the patch was checked only on x86.=
=0A=
> =0A=
> Is it a false positive, or is it legit?=0A=
=0A=
It is a false positive: if sd_zbc_check_zones() returns success, zone_block=
s is=0A=
always initialized. The zone_blocks variable is not initialized only if=0A=
sd_zbc_check_zones() fails, but in that case this variable is not used at a=
ll.=0A=
=0A=
My guess is that gcc 7.4 warning is due to the error path, while gcc 9.1 do=
es a=0A=
better job at detecting that the variable is not used in failure cases.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
