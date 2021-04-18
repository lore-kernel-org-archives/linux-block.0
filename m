Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C53C433ED
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED546134F
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhDRENt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 00:13:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17744 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDRENs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 00:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618719201; x=1650255201;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ffEt++UjxxnLBOX2YLKm7XTE0yoPLpNQMnw0Q24AJ6o=;
  b=ZkzmnBoJalDVatkKmw9Ucv80DF7AzsjP2Q0Ew4h2rXnQK1d0QCcOTfNl
   rX3aw/X5V26RVT9/yW3Gam5BHbncbZXLIwS/bDAAmMZcLm/tknDxdtXwy
   mwcnG3BI9FbZIgUlL+7VKC8bQKDFfEbF3eatXoxLWIrmaNVQFn32OuPUk
   RX25syz9/rlsuvQNkUNBHSObAyHCdTc+VK83HvIwCJLIf+FmSfFpaoLV5
   TrwCgKfaSt6GaaSNzgHQw2iYHbwOjdo5btp8Sbna39p1rHY50IGeJ/eb9
   MO+6bHSSRfCNpDUfv4GwLKQ2NjI5rkVwbYsVNngTpBRlunIx7/PjUC6wi
   w==;
IronPort-SDR: e8U6hX6c/kvB2uAycBO0WDALdqUswYhvkQy0yVGjAWzLU5MXnkryrjr8AVXyQmACXp0VLkd/Aq
 fZL3kUx9mm1amOiB4xmEMzRrQOJNqnx9qgty/AFUyt4aLWaM0tmy2FtVFhempXOKAUnXfVGS8M
 j7TCKr8Nbjnf7SOnii+ZFF8WJvnTRnBhUTGhRrNq2PimWH7dksE+r4wwcHlpJ8dapw63E6mwXS
 Ui6bWyP2Pgh1KgObGE7gBcwC07ZR4OP4rR4JnPj1oZvAwLJhi+Ub/gUNpg7T9XIOrgcb45eJGI
 Uds=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="169853666"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 12:13:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzctGk2m1MOLOmi8mOG7y60lpzD6emWiKu839g3mGl1PrCyViVjA9FBKNGXk0FBFsxdea1eqTY3SIWE7VMr8A7/XMEcOHdM/tBNQ0pvDo2AdPbYzK/jAkHAK3JrD4/vk8J217hHmf3pzip2edglmxeVjqaYa2iQgaFGwNQ51BWrlNmDHN2wB+9t+2B1/JfcrJgG62hkIeAobkTRnoXSqikZwENTN/Xw6MIX7vweu4KTVCzKRsedGECX76GwMkbxZ0vVx1HgXby3XegQ+prMNplEYheKd2WiK5uaw5Vzmp+IvTa6bkpwJ67x7v4CaYhtmXa24Znp+/aQ2IA90RYjuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffEt++UjxxnLBOX2YLKm7XTE0yoPLpNQMnw0Q24AJ6o=;
 b=IEPYwN8+0ssy2lPCTJSB+24jWIqLXRZeWZaNfgB0/Q8OQN/PldAhr5nPUHBPvwm6tABkHaSt4erRPzaicQzwpiGYedD71kpn3qqY3Bh+rYn9ckMeMTTinTlRhPrESCSCnUKfFj7nD2J5GqKuTD4bztfko9fAziMA3Zi987HSof4hHPFB5z0PEkzjfiMDFCvPtXsbmcixqBCKeq1bRFypwIaatIT4SzPzqIR5fO0o+RVkT3silSyGPmDaSbWyqqG7LuyvJ7emxBNXyMAl5Fb3fIOXX5+mp3NXu/nD6etPrs6mZ99jQr/UTW6Pk+cxjNPtBvQ1DV97e0uplr1Fxmxstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffEt++UjxxnLBOX2YLKm7XTE0yoPLpNQMnw0Q24AJ6o=;
 b=s4GxsyuX7olV7jsZd4RH08UIcCA2oDrdOUiJcyPFtzwWlUxBNoR0bMJwpjqAVaIiLYCF708+wJhbl937eocsIE5cpcRAbDhtjzJtt/H07vpScPJ0vgDGQN5C56mKHoBKab/yxmFFiwIl8EMA+9fsVnphI4N4I8bPzHbbdnD/DsI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6279.namprd04.prod.outlook.com (2603:10b6:a03:1f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Sun, 18 Apr
 2021 04:13:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.019; Sun, 18 Apr 2021
 04:13:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Yuanyuan Zhong <yzhong@purestorage.com>
Subject: Re: [PATCH 1/2] block: return errors from blk_execute_rq()
Thread-Topic: [PATCH 1/2] block: return errors from blk_execute_rq()
Thread-Index: AQHXMuEgJt66/02TcUG1x7zF84rulw==
Date:   Sun, 18 Apr 2021 04:13:18 +0000
Message-ID: <BYAPR04MB496571B8C33E8DA9159B9C8E864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7055b73f-7f43-4681-8773-08d902204bbb
x-ms-traffictypediagnostic: BY5PR04MB6279:
x-microsoft-antispam-prvs: <BY5PR04MB627969E610A0A37171B0313C864A9@BY5PR04MB6279.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cRP28bJJC96fWx+iPMx01Lw0cVxfgeoC2rG5oqswVZWtqO+C4kUcDiBYHQDOfoys8+/86wR0xblVZtjsMsXccHwWYN+CS7eVY1PgVQZtsB6K/uHqhdksJr6vG9HrU7jcflJBJBOlAc85q8/3X7TUn94QGKKFyI5CWe/GVfB+5Bqv5SueUofpVisNa+TSk7rvU/QvLc8ChmPkM6PKbBu4B4f8YPbS2ERGnKE0ME3Zbol4hQm/UdoDPtMfTnJDPpzA2He90Hzs5mn6HwKRXxv4YNxv+GQ0SFe9eZpVjAM5XJlPTT9lm0QLilj7Ji0XZZOcrGXzZBAtI7hjywilLujVWKw4dPfZp9ErUJz9w9SzT/51rJNa1jR4YT4ofNkxxvlwNfTkUjyO5YUwVvTPL4458jdc4yt0H24CnIbXfm0o+t3Cf/ADq2pDdSrvkFKTWM+QGgSKTT3sTW21KbJ1WwzIYQzpKYbWDDh3WlMg641C/HWv6gQmSjkyh5m2AwUACOBrqknPoVdn7kYGJyUbSfXbbjISFuZlDxICb6bEnVNkAuWSYeMkiBl0r47LeQWJkzJDh2rqaXEWeMJJ/88b3UVcU5IFkt1XS/8rp9ePJlYQWwA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(4744005)(110136005)(66556008)(66476007)(8676002)(64756008)(86362001)(53546011)(8936002)(6506007)(122000001)(55016002)(4326008)(71200400001)(5660300002)(66946007)(478600001)(66446008)(38100700002)(52536014)(9686003)(76116006)(83380400001)(7696005)(2906002)(186003)(26005)(33656002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Aqryg+zlbinQLXlwyDU8YfMFt6KKYBdW0z1Qm2yqnqOCeTPANDB3SlSSOgXo?=
 =?us-ascii?Q?ActG9fXlDRwvuzeCum6c1h7dwKDBa56uGgeG6JEDnN0bypN3j7xZpUPreoUe?=
 =?us-ascii?Q?lMybuP8fhj0vOsCWYYpkDZ65pwTsUj/3DMtiUbDrpu6qVI5xG8IbOjiZRv/f?=
 =?us-ascii?Q?qopOR1feNZtIdjySfz8bfL9A6sI2EDU4MPDK05+4eta/j3eDKoKH9Rt8jCfS?=
 =?us-ascii?Q?JUIbjcsve2QUwX1CaLNbnPBTNJp0nsIkZEkPRx4vHeJfPyCvDL08JC4saxma?=
 =?us-ascii?Q?g4QYwpkfuqaP+sz7N9Isun1XvbWgdvN62A/2UyebuGbCWBE8IZAt1uVBp2uU?=
 =?us-ascii?Q?i4Ilp/1rxkT3dmQHCoB4GLI0N3leWZshf4uztL6UTw8yRRYTfe4veXoNXVi/?=
 =?us-ascii?Q?EKa/CcSFmVzwgtI0ONV8/+PDEkeivN2xe+JiKqZDV+s1UNctWA8tuErm7qIL?=
 =?us-ascii?Q?BlWbfAE4428KDkE/+EY9UswUYvCsLObRt+IdvdvxndSV83ZQOtH0EKP3qbcn?=
 =?us-ascii?Q?qkEEotDL2P/CuNBwtcfVK3pJT/ny0luMomxLIwSxzzKfGzGJl+FW5ybFTRsy?=
 =?us-ascii?Q?l/7Cr7873LzuALEPBd9O8Oo5LkvgX6O3Rh5m3vz62GGneyI5EkfMo20e9NKC?=
 =?us-ascii?Q?l5PFjqs4LqPmx8efdX9zkCqqPx/2XNou1ykypWm2RyzhE81ipsW6zMBtAHKD?=
 =?us-ascii?Q?/ziWO2iPA6cRpg9A0y/bp6RdMaocqMsHcuo8+UzlcpibxoutVsTpkLjPge5O?=
 =?us-ascii?Q?EN08qDb7zdEJW9YDMP975a7QZG/ei+OUw4C1bIFDsttfhwarYIK3X8MaRPU4?=
 =?us-ascii?Q?sLnTxJ3TfEzdDs0cvhIIT4xyKJGXm1gJbDQfhtnOnJjVam87RlMaWxuVwQeE?=
 =?us-ascii?Q?UwjOVcA5R2KM1JaYiZMyQYqyC8s5xCrjLoJSXOGcwY6xD7fNpk0DryV/nDKs?=
 =?us-ascii?Q?XAj2u9FNlGKRS6J0XoXqgfECD7at29qWtXCe30WCX4wjokcFxnDwvOxnEye+?=
 =?us-ascii?Q?hpNm8IXvQyDsofceBy/cuaoHGSNEr3POGCA0IthR+fNZ5KShNCQ188ippH87?=
 =?us-ascii?Q?GgBfFDksOaIleqglvtrgfqGj34/u0fFscuXiAtllAcWXzF0ujfM2Tc//9lSe?=
 =?us-ascii?Q?D5ndq6Mb21JREzWf1Jd1P1T8cAX1JtSS8lPDakelRKfGrTGB7F6N8DHaQFyP?=
 =?us-ascii?Q?6NQurTGcUEe6aQfn3Tlsd77k00bjCeEYRG4zVcD9DVjbEmObZPy/9w5/2fV6?=
 =?us-ascii?Q?I0LOfeqa2ErJCH7JhjGDWJpvH2xnMROIT2pyKrWNdTK9Sq2OV3M9vXvDMmHY?=
 =?us-ascii?Q?UJxI2GPJ6qaDTRNju6aum9rv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7055b73f-7f43-4681-8773-08d902204bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 04:13:18.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leVY1dxyE7lgNW4h1VNRaXgGTUQieb3s35YOMEz7yIKtLlWyE46hGUGEAlElSF6Ejlk/aiKu3E2Ol16md889/M6t29tGT3G8Vj7vpWKIi8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6279
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 09:54, Keith Busch wrote:=0A=
> +extern int blk_execute_rq(struct gendisk *, struct request *, int);=0A=
=0A=
I've not checked if it will work or not, but we have been dropping=0A=
the extern keywords for the new declarations and I'm not sure if that=0A=
applies here or not, so looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
