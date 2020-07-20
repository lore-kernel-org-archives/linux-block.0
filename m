Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC76C433DF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68722070A
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 12:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EccSA4Ly";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jZe/8Acq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgGTMfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:35:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49637 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgGTMfl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 08:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248541; x=1626784541;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Yl2Vjg/UnHs0NHZEq5dUKyZC8EzdUJNVNhCzW+LBD60=;
  b=EccSA4LyPgNd7b4TSBxk1wBBTpwWcxYgUS7pIq2IDhHC3u/GpBE/u9ME
   6CwgHSbu5bTMnlm3C+to5GmmnTtX5Z3UAAKrC/3ffVJ/oie1JNCWV0tfN
   uf2DgPcvHU05rwDXk3XpZv6EW9BcORlQzUk+hEo1Ahfz2XtYMRbHvR3Vr
   WrFDjm8xA8XS0LgOkal2jAjjtL48vvUbvf0M5PWHBXJjwSprwPwz++MCL
   9vCitMvGDJok3Fv528GNPPSfsAiZwn7ME7+i+t6ewi3DXbDJDG/6PSBuE
   2YwQK7Dz5QLymW/XvuGTq4cARX1UbeYbBC9S8XgPO/18o2kNgfPJ96nV8
   g==;
IronPort-SDR: aqrj47wdHbE75lJmbJjYSelpDgF7D2i94O5b0Xs5HMSigNGq7gp66vLuE9AVKvJ8otR13EAn5a
 Ig2TSEQKQVr88PMtvSR0Ik2wDjzwXSPIn3ZG7NsBXJu89X/olBoIvRyWplvzgfiPwrIzEOtOyY
 OdFutdPNkedmz72XI1aws+1WkL0Fe5sYX3BNbbiKkgLlRjDPWgf3acdQA3QrIAPjIIPApTUP1s
 dIAQ5cCVuTdlKabHQbbig6VmuwwhJ+HH25q3/k6cbAW5UNKGNWj46nuY449Igc5qHPrM8HheFr
 a48=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="147225198"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4shg8JQ0ARmycHCx+Q1S3p2WGqKCf7qGaDp5662FxPwSt9Bw7YqaYFCwSZnWlidVwr5pvIYNOThMwGNgwPcFNJR3IQz8VuMpOagRdp7u1AhMlhdoap4+3dUE9mj81wlkVD3XZWCNUyIxURgQQBVWXutoHaY2JTYSpWOf2roAq3WxRDEG5dZWHw0SlKEqtEnLOaUiPLaonA1yJTGbFzya0sK8EN7qxRcJcrwd244BLU9kKshdhhNnFUPa7Y1hupryHbm98uVXBx7tX5Oe1IK4sjFJ4RS/RgWy5XWKEd11vos7C7FSvXqa/gDuOEp8UnUlLUDMVl7jSn5dXJPFzG3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl2Vjg/UnHs0NHZEq5dUKyZC8EzdUJNVNhCzW+LBD60=;
 b=B7CyHKu/x5nvbxilPBplsrf7tJzpqT4aD/fx2EvMA+8NhEMKwdmtnwtmuaBxEkbUm4X0IymOuU2uCbNm7ejGrG37ZmjwkcerVxQUoYfBvMDtRBIOKu73BLqBgeTb8XIBpZUsBHs0HLR4PMSpQyP0RkZer/jCrbfwVDQka3woBp8eDKagbEigCjIeXt7ax6nDvsiU8EUqKqEG2bZfZC+iZlOPEBLDXtNoeLduv6OgZdd94R3+Li8t9nw2jQdMnh97B4uuLxFyxCVvjKofQ8R8Owt8flNc6Ct2XrpPa28IRxFugzzxLaoZ7UOh6dQgAKWHngr99dGDDdb2GF5LjQFjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl2Vjg/UnHs0NHZEq5dUKyZC8EzdUJNVNhCzW+LBD60=;
 b=jZe/8AcqSaTos0G5zHTOb4wjihs19PmidoZMaeOA//tvUga7/WQxQoX6hL/PAxVPUWH+RzNkrqHI3KmK4sLmaB4+uFLDRETsaptawxKsE8/F2qY2WoY3nTZQOrmad9nvQkXo6WeLuStUCaz/0CZMNQD/nynrge9TN+31PVP/XOQ=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Mon, 20 Jul
 2020 12:35:38 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 12:35:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Mon, 20 Jul 2020 12:35:38 +0000
Message-ID: <CY4PR04MB3751EF9DA47E976927CBA8D9E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717100232.GD670561@T590>
 <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720110831.GA28284@infradead.org>
 <CY4PR04MB3751CAF3D387E973AB6D9D29E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200720123427.GA14186@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c1b72b5-82a9-4927-a23a-08d82ca96871
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0726F47B8EF1BF63CDD2DD74E77B0@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmTcU+DAcMl2eubMTnad51OJ14BDyrTmrJCu57Tn9ruTLpjXIbeSMWxEX5zB/KpT+pm0JxixP3CKBZ/iHZX9j5Q9FYzWKgEf52/5+o9g0X/IRVBxcaaz1uu5osQK+ogBGnJE0c6i1fMKiUVDCMM1cWrUzEMG9V3pbvV/r8czG5PhDZ8F38p14PWGEpdzDPhbPIHI+AUk/5BYihiCIYYPVnG3Xwgkgl63mBqnwdFz/bU/eduEYBebSuaJ07GQw9JC5ljwTh/Qlfw9zkuNkZ05mv1aDgiZlwSveQwip0LmTuk3yvkCgs5f/W+4LTOiPeG3jTdIfgZ/4ugKfmA/wKbzxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(26005)(55016002)(186003)(7696005)(6916009)(71200400001)(86362001)(33656002)(52536014)(6506007)(53546011)(2906002)(83380400001)(9686003)(4744005)(4326008)(76116006)(498600001)(64756008)(8676002)(66446008)(66476007)(66556008)(66946007)(91956017)(8936002)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7AhEYOm3Kgvg4azA/Hw64iIObz55pfoUUH22G97SH7HdsemT5GYClLanLCf2g+rNIH1rQHpznix5OGYJ6MLPhx1h169tKj3qc77/gXJ7UX+UO8Rar7HFyXfN8wEwVlSrVeEKIearq31GR+lPzfT99DgUyUfUpGDVU+WzeR585AMeBNSSFMkjK+pWvdhzNFPKvTQ66dffxAISxyLLuoz8X4Ny2ZgExYqfQrspMAs1ucubFhI518Ar5qgZ+zmuu35JUORB2zwanhApZe/sr0b01sH0MhUuTbGCoy/Zh11by3/fiLEBvMnrVSLBh2VLM0R8kN24IanCPaq1JAkA3lcjnSG0SXq6EbiklrVH8/Ac9kZwi0++IUXQYr18cb3kM9JlOAWCfLHVxhRI52LSAvDGbPQ+E7IhUF0pCeQpOBx8R4j2XKCyzHdEY9LehhgqraEQIQjHmT04O6ObxyXw8apBt/eWf3kwNhrEJiNv/5hhmjaC7lZpFIeLsOxxo5XlEZXb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1b72b5-82a9-4927-a23a-08d82ca96871
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 12:35:38.4638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0yv4P6XdUIO8xA2MvH9erJiDAnmRTaQ17ouClucYU5RIdabDynoaSoUdQ+ePEwgNuEfMk+7hQpzYOUrBt69SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/20 21:34, hch@infradead.org wrote:=0A=
> On Mon, Jul 20, 2020 at 12:32:48PM +0000, Damien Le Moal wrote:=0A=
>> But for regular 4Kn drives, including all logical drives like null_blk, =
I think=0A=
>> it would still be nice to have a max_hw_sectors and max_sectors aligned =
on 4K.=0A=
>> We can enforce that generically in the block layer when setting these li=
mits, or=0A=
>> audit drivers and correct those setting weird values (like null_blk). Wh=
ich=0A=
>> approach do you think is better ?=0A=
> =0A=
> I guess we can just round down in the block layer.=0A=
=0A=
Works for me.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
