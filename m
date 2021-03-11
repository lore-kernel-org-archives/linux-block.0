Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FB4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0494E64E46
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 08:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhCKIZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 03:25:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7621 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhCKIZn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615451144; x=1646987144;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=VSUpE/NlGuMvSmp6DWJXy8GzIoZroZwkgFb78DN8Y6F3ZAVYVCVR64hh
   Kfca8BhI6iBqtoQQsJ7tnxJg/HjKZrRpZizUCEEgIhHqTQkYsSeas1z7L
   IbEQnvnKx3BwNePNso1Tuplfo8O8hWNlDrJ1Pm1fNYi+Vihe/tgw9L308
   m0mJL6m7YO5GTqX4pGl1ZkPYBdZdq6Zorz41mbG7IJ/tYHao9+rOe5KJz
   ADAAKzldkyEU/4otuJMH9YYblN2IwxFeQmhf/7wyd/NN/gB4UhcKZ48De
   ssrFsIuedk+R3SzzxsSTRChHcfxb8r/4mUrrAtbPIbbQ3qpnFbMtyCxAB
   Q==;
IronPort-SDR: nzCDx2KvEQHNtimdtw6LSMbxFct+ZJidP+3c6iXPjxv+eV/NAOFFjZEcKA+kLf1GZKpuPSYQVy
 shDNqTOURFQA9hfIGXQecNmhYX096GVVA3XEuV/2MlJ7p/vJIijHdxXDQ6g5EKB2CSk9cYRJON
 1Su/bACFLCh9AkkaW42U+5uO6qBGzyTv6D/zhL8iAlHhqXqQUvVa56VFdvK1ZOk51au6pkGA7t
 m64u+dIqnkuQN/NFD2zWdjz4mQvzaO17KC/x7QLplNUp678apQHi3l4sJBLTfm5gsUBHZmsTAI
 uPQ=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; 
   d="scan'208";a="163057784"
Received: from mail-mw2nam08lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 16:25:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsjBV8v52GW7iATcGe2fuib0MuEfIm3m3GIx0OhHHKluNABPPPsRIZHODcGUUgvDV8riUghffM8du28y7iKFkGU6MvJwmBh6lviwskvGetypfc65/bOYIKrfsxRCulGnZWQRRjnekEAa9Viwk+chdkbJBlWuydcVFgbz+R9jcRhhVFiNQSZ0vWiJPoZWxF4MCB24Kd/GcPfFgcPv7W2DmangZFqcdGNRLzTQ7BSpT4iqmI0LQk4BiWGbS1DkNJrLAhBnviRSUNq91gbiEX92BMUwNx2Bx7pGzBssebnnlaf1u8b6EAlMepBQMVE+KqcflWTI95WD548ofA53/LZ5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bRl2tTJ4TIHh6vz4wGuClCEyiPF37ygCRcxI/zjns3nP08ckk3dwUYuXvlBzN9dfWJgfyRrG5jfs4+G9ieNCOXcFih61O5xpsynOWRncn5DF4IFdG3oOW+JWn1wbz7qWfiDpHGQ3KDsSGfIsmAE6W0yc8e0zCioxeOFywjmGbXNzxKyVuhkJA3k1jo6nahjrD/lWUh9xQcza8TKWtI7tOF5s26Y2yELg2kUR5xB+5VzTGdP7ZFHfNq2jjAYr5JG9uYgeun0LGtacZ5+aVXnsSm24G5QlgSmZVozhwwSChoUrPcxNj2rBQk7ONdI6IVHFpUvvRgoYEp5W63iJm8GfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eHTE/MPk1Md+X/w2mm+gbFE1dmW8Tq05nKa92s+sUiupuONeDCOG0NMZeuuxqf+ILw64qc5IAlb6yUOzhAHIuh4V9kF3jOJN+/fNZnieH1pX2uBj9XRWsz1sGGCflZXZyvkGHWukdxqT2QRmIlyrQ21txOaWwi5MXakCBOTPoCE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.21; Thu, 11 Mar
 2021 08:25:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 08:25:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
Thread-Topic: [PATCH] blk-mq: Always use blk_mq_is_sbitmap_shared
Thread-Index: AQHXFk8YMsq56ayAeEitsRoFrlDEUw==
Date:   Thu, 11 Mar 2021 08:25:40 +0000
Message-ID: <PH0PR04MB741664407703FDB7002D0FC49B909@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210311081713.2763171-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b4c1d8a-3911-4e3a-d873-08d8e4674178
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-microsoft-antispam-prvs: <PH0PR04MB7160EC1433159337C8E6F6E49B909@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: US7aRCFqH5bUCoqJ13ahtOLCnzuBPsxm3FNIGn0/k68EXXsGsFpuUtg7YFR1Wm0Pwbwy8a/KfnXYaFvjQJBWFD280WQWS2sZLB4dNdB/zJfGLj6X8bk7s7haKwn6rgtZUhAQ/fYAP1R0bj8taIvFkRYIPtFacIOC9ARy4LSlYzBp0FRq6IosBcN97CJEYOSryLMuIx8MRcWUINhmAoam6ScnL+TB6zRvERqlwFF6riyPoLb8kiOH0R+52rvpADMVEVZwZC4XCYZ3BRUZXC4wRCv2sX/yPYJPv1AQXGdKLTzH9cGIS6J8GShjb9oVG7ZlKL6y+mDc09iVmAOlV4bdrkoAqfhWCxKPciO9O4UfyuIuuorX/sgFWms0JBfsJDJcR0JqvNqestR3UDeR9P4p6ibWt01/YAHdNXidZelDtZ2yyWvdCo0YxwRztXh4YCaQ4ZvqIkjDlMdk6zfJJTiNrwPrna3f4ZU1UqkUeLCytZC3OnTfJHURbzYVkWXzQwdES89cPu6Zd0BCqMy9AwtIww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(5660300002)(9686003)(2906002)(558084003)(19618925003)(110136005)(4326008)(71200400001)(66476007)(186003)(6506007)(66446008)(8936002)(76116006)(52536014)(7696005)(66556008)(8676002)(64756008)(4270600006)(91956017)(478600001)(66946007)(86362001)(316002)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y9AmEvP7h4U2gOt5Sk7X6YNplC5g8ZwAlCVBC1JIyq0pxsBrM5Yf+djuYpJaN9iBva5gizJiTJbJYIKnpjydX9n14Bz0dhEe0jeweSGMELWeMRgxiEkxuIf1ob16bpQS/gtGtHZDjq8yVma6Jv9nefxhfz25DWKzkCDAXZs1lvh8s8Dg2YsnH7J3/hyVBOsPNVcWceRTl2sIvlrC7W4vDQvJxxogpOUxtPxhfbl+gZR2tl+zN2kn4kQ0yLvwEdK5/IyHY5WopM1VCTSJOEtBA9GEdc6xm01pe9W9f3wCU+rS0NcIJGhyyBcBiDUIDj3Pq216WUp/2cd7qiK8TOBmKHv+BDO3Ijg6HZxyLBDtjJcxKN4FDk90YA181xHG2WWytHiLvRIe8Nq3Yd03JxKzUKY1HBGEm5jPU4i7vJg+JAs/lv3l8a2adihFIGu+Q5bmbmMOOrrQPLAwSMqm9aERB9J6Ay5gNejab1nIpDIKTK5nMSh4uLzmGYB0Ytv3YpHZqCl1mwcthPF45/5ovJvj9GhKr574xQiHanAb9u3ZzPyS6aMwY0+rb4w+p/3KvsKVvl8dcVADWLRSLuDvEP4AEZJSt6d/4xqPTo25DJ8SPm6KIF6+TttTNdvVA2oeTGGqqjGQW21xX81pmHwb3ZoOLPFkty9j7FXV5SnjLn/LOowmKTfZUUjPFfwuFtcuFDfZjKMC5MRBhrG00SM3XsljborYYtthDPgtbHZRaLNsxXJjohHhAe4IFCI0lSxB3g72m0CbUsWRE/10xtkrRUUUxsAjKAuEQ1rRa1w21oHoZJ7GxAlXywgd5X5oEeWxYg31
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c1d8a-3911-4e3a-d873-08d8e4674178
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 08:25:40.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwxNen+/k9zynQGQXaF0+DzLCwPGWVTC3rEMGWpwVplQUjfWnwFysg+9PVzK1sktWh0XJP+dkKc42+E+0wYW+E/6QupE0ScyZKuXpcmq6+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
