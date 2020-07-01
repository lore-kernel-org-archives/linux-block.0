Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE136C433E1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD6120772
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="peX9/cCp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tOvNgMhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGAVjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:39:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42019 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgGAVjC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 17:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593639542; x=1625175542;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ewT7FvtzMl7+fm22L4SusG4O039KMimQfs/v2/zyzQY=;
  b=peX9/cCp9I4jOb2dtpyUMcRpXt1LjBaBaUjCweoVaNNUxNyFmBHuWIb9
   iGXU7W3IllviEKguLaeLHGpz46FhsRpkdBkcYY4UTbd1HoizTRiZJ4nSF
   ZZDiNJaGGoLja+ie9r+eblEGsTd2uqUrgdyMhtd7t9k0ec4C9+dENLsbR
   OZy+7KOXPJzf4Senjqf8MATPM4eJVEudzsvalcEMySWQjN/Rz7xt2jGIf
   9LVD+KZIz3Fl7fU5zPqVlAW7jg0mfdLZXrP+++OOqNhkvYRif3XKGvHoe
   wW3/tnGV/Hk1drOxLJD9BSQQwYEgjlJePi9zHIlfzaG8nahRHYKz6o4e7
   Q==;
IronPort-SDR: 5kvxmJS8BVedqYBCIkwufJAsggcenRQNQzpdOatYNMYm5jatxazHWTeYzPQHp3bCVpaEmbbG8/
 E7f6HcfI3USrcK30cHz5fHMG6fQO4DEi2aYq7pX79Fbuo5q7udugIBFvVFFa12QK54XMxqw4IL
 YLERwD2bLVNM/pULov3gDAmxPGx9per7L0BPHV4v9bUyeKo6Szd0DFLTWBPq8SUeVEI4AyT0rL
 4wTAbZBlOcgtyyYkWASn9kIxaRv5Iz7ok/rEU0XDWkfTwL858hjdyzDtWmIUZpi4XyXpF/jkNi
 NyI=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; 
   d="scan'208";a="142772269"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 05:39:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHjzrn843KVkWEPrlN/8gobPo8Cu4vx2JMKZd7M3+w6IxGjwplMWipOPbW0p/ZbK4E13U2JfnUZOJYSbgckjhwTFFL6HW2gWyp6kysF6Hh5HOd+x3DiieeDBLSBCzumRYshWEIw8VulyIKP5S8e/ZZYab/hadVRP5DTaVU63lIn4lPTVmOGu2YApM3yw6h9N/wOTdRtD9T0RM3+AFifrEDUBQGIL6R5Ov2wTO53Cwczv6TpitTo101t0sp7pCXleYFRnYydinWGgDXJbV6ntFOpgPGH5XuwONXHlDvuo27s/GbW2SyTsLpizHHvoOA3d+v9eU/9jOCLy4dEA1nH8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewT7FvtzMl7+fm22L4SusG4O039KMimQfs/v2/zyzQY=;
 b=ZfBM7BDiLiNrGOemwrmKxpOOdTwNC1kdIVCNx9fXztefNCacBvwbJ7o/kckZOLTPtEjWU12nrkCniDryh0EbU3K3F4GUcyMldQJMThtDZVPe1nF4D7FQdzH9Uf2w01yi1DOGKqCtyD1wVVSTE+onZA46DnapoX+kXJIScCFcma6gf2sUsEz0TtCI670ETouzPAtBnVNtqrxWE81Fwg300AO9msIcPLM6XqkUzxncVOCYEsGuovxFAaGCeQzUKJk+zxIhZlxf+v3PEYmYfP+QPvIQCjy2OT7ujgESOMD0p9GmEwb6yWCr0ffptx5NZZjg4dtkgmD76TQEgU95+TY8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewT7FvtzMl7+fm22L4SusG4O039KMimQfs/v2/zyzQY=;
 b=tOvNgMhNExiL3OUbZ9OpkWuJm49YeEp9Nes77D9/bzeljLVlvqc5d8mf3UazUVGJTiNFV/KPvXgDu1GLTGxzSFEmaSKRZ14m5C+tUHkvHkFcyjVUsVY9gv/n75jsgcQJ0Jmy0AfmsArC7kIQkWObFxUJw279ws7cIyAi4DsjeX8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 21:38:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 21:38:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Topic: [PATCH] null_blk: add helper for deleting the nullb_list
Thread-Index: AQHWT1/biaZTnaGKVkig3mq80wjSXw==
Date:   Wed, 1 Jul 2020 21:38:58 +0000
Message-ID: <BYAPR04MB4965B21154FC796B1D4AAB07866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <812af519-7bb3-586d-14dc-d3a529b49b69@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98bc24bd-b6a9-49a5-618d-08d81e072a02
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6884773598B394453A7A1D31866C0@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4H6fcMlOsgWRJpuzsnfci/2kEwIj4PAdIMi5uFvVJcwj8pJzAA3Ri9V+V+/OOFzdGrxlLBYDT3QrA3nAYVPs+9gtyFNqlYzZcbf34cbgkT1CRjWgwaPekz+2X7fxJya8jBSf3/TsJq0T8l7ipczaFZ4F9KCZKSENHiTbVrR7je1cc+cgtWaELkrKxdzbbXYXMlx5vM06Y/Ib/I6nA4PebL07b4wKbxReKCHuoiZ/FoLMk/41Ij2HyMlw/kSGv+DK6eaonbwfOxlPDM0cj2eJhFgdOnl2/H2EDDsLTS8aVTIxrJkSbOMtb0ofnuVfjZgCyc/vjJjKqe2k660kD0TOoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(4326008)(498600001)(54906003)(2906002)(66476007)(64756008)(66446008)(66946007)(66556008)(8936002)(55016002)(8676002)(558084003)(6506007)(5660300002)(6916009)(186003)(53546011)(86362001)(52536014)(9686003)(71200400001)(76116006)(33656002)(7696005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oJu64tMOK0peI04pnoOEQHu7VS9Zl2Az1cxuH3d9UVvi/AL74VVuaOJjPyN2aPdVRMCM077E4K+bNEqk7bAANOdsLwUb4YAZl6sBhmtJ1t43EAeyCbaKOZRxFakxvbOETuisIBCEQZrpN30kcd3KmMty+Gs7uW9azqdc8xnNwWWEgbN4xEf+QtTKYo+TaIaEPAearlj8J8twbv3bzoiVVUkMTgZZ7ZBThBVqBAjk7OprtXAymVNvO04esQMrJ8Hu/OmSIkxdn3JFo952FpMZ5I5mcRZCySeKyfVd/LDIcsUbgHWmOkxjqfTPulU7ykyrIj5vpuyyAegqLSMHrcC+wp8x1HpTs4iKi/ShMwUMBKLlpXVcKMv+xWGRqdYsddXwTEqVliR98VrZITdZL2ApNS07OIW0FXbaOAmdhe4mZ+74ANFZzercYFgiQ0/2WUmR9UYG1SjsEch/N1uX+FH3orlJV9+4cR8ogsmXIDd39DtQxxWLTey5KjTfXpLI0NSq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bc24bd-b6a9-49a5-618d-08d81e072a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 21:38:58.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l89EQ4lHe6qPd/BlyZ3jP43N2z9VNXRbTogLxgp+Rpge20OE6/ODI01IYKnMpf8Tb+sfekA1PFMLLLVRc9K0W4S+/aBmnQELxCsV5OPr3ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 12:08 PM, Jens Axboe wrote:=0A=
>> Can we add this ?=0A=
> Please don't ping me for something trivial just a day after posting=0A=
> it. I'll queue it up, but it's not like this is a stop everything=0A=
> and get it in kind of moment.=0A=
=0A=
Okay I'll keep in mind unless it is stopping something important.=0A=
