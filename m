Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F52C433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B180A23117
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbhAMFOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:14:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25418 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAMFOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 00:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610514881; x=1642050881;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
  b=ntwxsfDQFG26K6Rk0v3JwAePBAv+tvMYIcJgjqBy4+deMTtIIfxp9yx7
   4XKQlm5ZOLFo5sZoXo81pG7Mzh+nwbiPRIn5/bnzZeVwGwk0tMAqFFrsn
   bSjoYX3Hwg99BOjPBbTEeuW/s0Y40oXpyrSV5M5NQEw9hnRcVKIe8BDq8
   3uzrBHtm7grQAxrPapg1Cv9LLTLjsKqi/5HINrjP3KGoOJNw755hUS60x
   s+nof6rQDBv/uWURqgT4NQd35y8eYmO3J7j5jiXhADKjxcGtDGZvGyfMd
   NW47f+trom9MPjTAMhxoBJ7dqbMcM+OkqPW3YeefZAiJg0I4CILkrFVlz
   g==;
IronPort-SDR: ahAmkhPZEqV5/h/4QQE7bWG3U6zXUXa8ECI35ZZNMHJzyqlopHT7CqCaAX4CeMATsmQ0SoPxoL
 stBPfi79TotNFGMdIZ5a+rQhp+RhL1r6iYn6vQX/Eq5Cnc62lvw14PDGpD2UfmSz+5Weku8qWj
 rVF5oNmiYo8TMZzAybuNIIktwCh1cz51ESWtjEtwJA+OU15cpeRfD2XUEiwt7IbniqOaUeC2Y2
 zbXvjmvScuL/M70N5rkg9dwNYVx8mCgvrXNTuhGSo76GeAhdPtjIANfTmcWLviRQiPClhGJna7
 Tbs=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="158480291"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:13:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsjyvoCcsJGO6/4xg64TmRyksr1YVpnHT7fkPL2FKahFcwr53wPbAFcINiZcTBpWAxuedej+L13ugJ2OM250wwuJkbJPCPHtXk7x8wK2p2yT6zhhyZm+hbale+SVIw/Dqdacb3VS5o+30zrHIya+d0QzEbGPi8YgWh4sVOFcN9SPM9pDev9VAuNkYlxW+Y7bWopjdhKKCOL2alxw3z8TH8JqCPTR4zqr+x27rAjVifeolQNbabi7rDhGP/gNsYe+3hgUnVJQ0LPGvPa7uk6CgOdxSUUJLij7QyYmNY2EX33+KrY3uXpHEqIv3Gh8KZKDZcw5q3+1t7giNBBCGnQWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
 b=nfpbMkRmfmh1ZnuAoITrrT6c1g6rczcrBwfjKQGsB/CY+KUYH5ab1QzZYDcKu+MJS4/8VZQVH5CTn9saQihjQ0MQieQ6A5gym8yDIDInqFsC1AggYIQXDA1+V9CqlJ8RnHfW2JAGHma2vl4VZ09spSqzDm5gVHwFrjosdSsFg6P55EJRggTNOKpJtWjnaBjVTW9nCqoqz0xT5za3RCq9S0MM+92cFk8sOThcWn9jqN7RAAZmc2366njHi0frwdTnsA5tGJ2QtGr9kwjs7fym8BcDgq9C/43CcW30g8MIdy4gkgHiciU9eOrfDmHSFpzKq3Vy18pnx854xfNzbahgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1t14qaaW/aomAth9STiOb56hvs/gsI4GYKNBwMzzmw=;
 b=zLddGaG0akOJVFqAaw+udS6NIV6s1p4XIwWBYyXYfAzhzXWU5jCxStK/Ys59Q/vg3Gl2UqkkOgx7XAj41MjChvhcQJVuNAonhy96fy1doBf2EByZX4CORenmtOOUwrhb2D6zJxl+4G+EoAiIRBn40FZKSe2tOarRQCFTWLer0SM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BYAPR04MB3959.namprd04.prod.outlook.com (52.135.217.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Wed, 13 Jan 2021 05:13:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:13:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Thread-Topic: [PATCH V9 9/9] nvmet: call nvmet_bio_done() for zone append
Thread-Index: AQHW6JtQ0H5m8Jk8+0SzCyXjMBnc/A==
Date:   Wed, 13 Jan 2021 05:13:34 +0000
Message-ID: <BYAPR04MB4965963BCC2BC929CC4B730F86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-10-chaitanya.kulkarni@wdc.com>
 <20210112073606.GD24288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6868ee05-a0e0-442f-329b-08d8b781f9cf
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39594889613CC59FDC35DB5386A90@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pn4GdEw3u1WlKMzQRMaMVlCIYFY/Qlyibkaj9rYE7Q5553LM5FKfAhOxwFT0cPLPE1lgrB/yoveBeOlgzXjGyONVgNckH46ZgXkaW3fhQq718EerHymiKIl2JfpbflY0jCkXSwDg4Nb97z0RhnoXQsOtCiOvzzXJ7NwOTQIwiEtk2XVloGp+eFUfVisFuEmezd4Ki1qPzkFAVxRblBaOQZKk2v8fUjKTuUBJqs6fLvWgxqqTLbzV6EiSfQ1K0cbfjd6eHfS9dIHMNOi3YK+L/92TpVULPnKP9C7RwupY4RVG2aPUmwcgZiIuzszkCcaFc8Wg759Vfe75Y3qFdHmrcu/+1up9n0bFjE5Ol3kgzO4fnlQdSbIobV+Cu5vDnH0aq62jqyh+9c5GnGji6sVudg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(478600001)(71200400001)(7696005)(53546011)(54906003)(86362001)(316002)(4744005)(33656002)(8936002)(8676002)(2906002)(6506007)(26005)(186003)(9686003)(6916009)(66946007)(66476007)(52536014)(5660300002)(64756008)(4326008)(66556008)(55016002)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G1EgKmhxx80YiDQhqgSY12JQrkKDrEWtmOORPrdB4sDCOa9D0GaAFhFhgDRK?=
 =?us-ascii?Q?b5ldsUuce9RaOEHfspEmFoT9CgpguS36KFNHRRSAmU4aOiKa5/ICAmoPk8sH?=
 =?us-ascii?Q?TxiACfH4sCQTAxCtuhOtx6AeGgxvqdWLUBCK19uR0X1Sj7GCCd61AvTruCSw?=
 =?us-ascii?Q?3eFoS20ByczLYdciU9w6qCh/kPAKPfVUgsEx8mkk7C82XxJ25AGaqV8Yi1oK?=
 =?us-ascii?Q?0c3YYCpZBHX2AK1yN/juVYrgrk8mnC6WrmbFxJWiFiKzfpwsZw+shU+uuuqx?=
 =?us-ascii?Q?b5ilxELCwaacDgRwt8Jx+B4sDeYpqzZBj/ueWP3bMY7ifLeVk/c2AdHff3fE?=
 =?us-ascii?Q?XkkEy5MxmedBh7Ozm9EBEfX1xR+5p2UrZyyOnGJiF2IJ0EKNt1w4frj3A6h6?=
 =?us-ascii?Q?l563kzE/LteuS4Rjfh82A8i2vNRrkIYnuasEp+VQph136MnCdBDMFZ6Mb44F?=
 =?us-ascii?Q?ELaAgamXumdWTwnzs/zeuxPLBWW8bsssOSo3etn9YvkbU6zQhIlhdEtZqrpR?=
 =?us-ascii?Q?Dyx767mdzHtgLOiA46VPnPB+u+mecnzPswZyt9mQu7/BlWYlQa1X5SFGyo51?=
 =?us-ascii?Q?wwZVkBA5BgQWQfth7fxAUitWO4t13JxGOB2TheefcI94Q9XE5uGr9VI0mki4?=
 =?us-ascii?Q?rxte7eGkjrCrxKMMx8Pm9KbCCmne20eAxm955N6agItDwpZELZgaKGYdNZxp?=
 =?us-ascii?Q?Qwp1Gcs18wirHE0sGhA55bzObVLewtkKsOOT5m9Y4w1IpQRnws/jkhPzfhU6?=
 =?us-ascii?Q?+BKwGF/w8QcEy7anXkXsVT/DkixiJpIh4G4V1uCLQqI1kRWCnYFsKE5UCX9E?=
 =?us-ascii?Q?AFH+XBiBUM5p69WbT194Jpbj7R0u4SM9E9Qeyjaicz6Yipkk1qpU3VoSl/kM?=
 =?us-ascii?Q?EK4v1GbUMzQ/5gpJ5F4Tg7qnLdjBZeEZDNWTZq3O9KsaxQ0BnQCqZtl3NCvY?=
 =?us-ascii?Q?vj9Q91qPbmG0B9sOuIeI7Irj2k/O7SwgF4jpJk7wh3UWZyxuMy5UYkQJEjDb?=
 =?us-ascii?Q?85hL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6868ee05-a0e0-442f-329b-08d8b781f9cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:13:34.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kf5XVYDrhFV2XpXeJ62y0uhabM9M6+A3FZeog/juNhFptQ1YP65u0CElPY+RviyAfFnE59GM6tVRBAD8DvxFGsRZSjLmZ2R18BFxXpsEsq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:36, Christoph Hellwig wrote:=0A=
> I don't see much of a need to share such trivial functionality over=0A=
> different codebases.=0A=
>=0A=
Since there is a function which does exactly same thing thwn why we should=
=0A=
open code ? I didn't find a good reason to open code, in fact it made it=0A=
easier=0A=
to search for nvmet_bio_done() which is logical point.=0A=
=0A=
We can drop this but please consider previous patches as it has a lot of=0A=
repetitive code. (will remove the weirdness and add name fixes).=0A=
=0A=
