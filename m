Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786BC433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D4023138
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbhAMFEN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:04:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28579 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAMFEM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 00:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610514252; x=1642050252;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AeU5Kk/OkUz7GC2RTZfPx4/IhXWL7EJxgfv1UVpj9fo=;
  b=mahne/osddM89DhYdvCRzzPRzhnDS9N0j5yuDxMWms43azWTdy9tEAG6
   zG++wR1EhzChHI4KChe8fU/Hj6DiNBeQAJnEMbxDQTPh9wNOvqTl4tNyE
   eDbCrdiPOuMMML49goKKmWNzzSgmNCGMTM/OLeOpLW1/xgqVdk2tYx63s
   czPNNUWeMjEh1aXR7UKflM/oo8Jt+8guRr3c4OQulc1TAFxk6Dy/7yXpa
   6eafO0LTG+xoVQ35TeWexF2M5I284iStTuwkJeBOSE3iUYBDdfTtXAHb6
   l7i18VjzPYPws9lTHsHyInhfvun5PXmLf7t4qcsRJXDZXorHdKSO1q5jt
   w==;
IronPort-SDR: ZCgQmcpNEKAYZxClrC1ch3548KZnh5CuRfBklDZm87YQsa1RC+qyNJ2KWYi6zQqLrhok7Nt4Kk
 /3tShmFAHRT2DnxNPIjQRvsoMJSmdaMYks8HEbmRzcyCdJtwdN5UZ6n4Bck7HKLnLp/ucDlhGm
 T4aBQ+Z6aaw/YVvPKjIK1RwVGQ9i4RQWOs3yiyX33q++s8vBcda0nk3XUZPtxym/smtxVALMmv
 DDfsfBwlkoXSBO0OkUzCa+09J792xKRK82xZLSPCk2D4BCiAow203ugrLtjX3pivlyPUthEWm3
 g/I=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="161744893"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:03:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGEJuBC3DEyi1PGG46BY3G7O1kl83YPZBYmZqMQ6/52jhsn+IZbNXmvSizJxqdUqmMQvSML2QSfJ6C72jSfql/Rlh/Tu8eYaNw0wTKWl+RtDukfj3M546pYzmE1NsLdc+BcydrYyEFMkAMZlIEdSBwJCxoVLSmdM2sqVDVNWxSX0E1KL0JGRKTj7t+HWrZj8lXCFjvYXdI7RpOVc+X4Mjkih9ACVKz/af36jqO9+j++Kxz94u/8wIQm+wX3U2tsMT5vuRn6noZ/JFWtp6pSqb7mm58nXVRfOiyeCPRQKhoxy567Psa7eb84U7K2QL6WrfE/bSQZ38xDP+BjaIxUYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeU5Kk/OkUz7GC2RTZfPx4/IhXWL7EJxgfv1UVpj9fo=;
 b=mC4E6c37xW0rdhdPaka0IT7whTZo4ux3cCQyKWW/v8xyIMgCHnq3gBcxAH93v/q6QwTa6/A+fDFhASbUpu0JdLofKotHz2kt+95lIjl0M8JppUVmy+a6XGhRy9OdmeNcUSrPfW6Z1WcUqooAZeZBE9OiT0+oanRYtFBxhHBmuuEKeft6CEhxD5SE1GSrK95rtFHStzxpWOFp1Bmq5QvLAZDdKiB/FXqG4vPRwsib8B9OVkuSMnzVD8mCJgdL5bocaoIZp6/D4XyEalAxkdpD8MVnidXBaNc3GvqqP/FoPhns3jPeOs8d+tSmLKzi0kpLJrvK8ou5ZktRvaH01ocDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeU5Kk/OkUz7GC2RTZfPx4/IhXWL7EJxgfv1UVpj9fo=;
 b=A2CpQpZ1ub1/292x2xD91UFdZsOzmrBAxGPD0y67+PtFc5XW0yMUZBVyThDjPiLuuqjV4Y3yG4+05pcszUipBi60ffBtwT+gcjuJtD9Sqe6SXidlCsrKoeiVeL2EcLlZQiY6eeM/3RBuVbeBKm0XlNQAayTY2bigPdgkTHfhR3I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Wed, 13 Jan
 2021 05:03:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:03:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Topic: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Index: AQHW6Js5srDvdWB7Nk6D2IdsRVTi3A==
Date:   Wed, 13 Jan 2021 05:03:05 +0000
Message-ID: <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
 <20210112073315.GA24288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b055b839-5802-488d-24b6-08d8b78082d1
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB53330EF4B55166051A01888486A90@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nht52G82DI+D2tUq3ELQfYMJ20lDR3/92OEEIApD+8suC+RSZtWsp9lNNwDVvPkS/wjsL8U+dnk/2Ng9BrbKOs+tnte95wuSKfEAwjf2Fu6gt/q6UeFuLKjlMUeyjOUEPqNZ06oVOq9LlJKV+pKSaWAutzdmp/tV6YlLbn3dDUyWM+bec0byzk2+jQVYGKaN7Uzd22DegxWvd36Shu3wBynu2jGOIot8ZHZ8mZ/rGREmK0YF6g1GguxPP9tjr3VChBkPa8ru3CooxyaUgC4PpDrSO4nQq3h9uh4mwyqXa+q6J1U2nYUXNMONrRrxd8HiNRPrSct1StwOqsB4Pdm0uAoy/lfh+S66UjSpkyAa6shNqJNVYiTR+VvSUFcQnx6WNYhd+VKll9IN8XNXF1BDNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(8936002)(71200400001)(478600001)(4326008)(6916009)(4744005)(55016002)(2906002)(52536014)(6506007)(53546011)(33656002)(5660300002)(64756008)(7696005)(26005)(186003)(66946007)(54906003)(66556008)(316002)(66476007)(76116006)(9686003)(66446008)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CN6k77uUtSUkGls0XlY//GHJsQ818YyuQQTGEhFfbqOvg7/qTEJvYWu64tTj?=
 =?us-ascii?Q?YxnJyCyBndwm9t7WV7pV9rA88rxdSgpZK/82quzjddRmuLCZFR+d8tIKx9rj?=
 =?us-ascii?Q?5+tXQ4gAnqmHKSU07JBfELuoqymGyJDawCLo4sZeXA/UbUD3w2MoehwDiwJk?=
 =?us-ascii?Q?OMYazON/Ih6rPov5JDEMbu6vDBllI4fAsgLmUIyY99Th4500remdCJlPGhuW?=
 =?us-ascii?Q?6BvwNAU9rjP1qXAWxTjK42UmKSJJ9nU9jqy2CoQzoE0dJBdHuuESDzaQhOFb?=
 =?us-ascii?Q?2UX/qp3cTAbe0X4u3DfeA5XPAjthfBM6ly2PEikbPW0iBHIriUyqBCqe0R5B?=
 =?us-ascii?Q?jBi5kA1lSfZ48fiAp3WNZWvpSGtaisHFlc72Orh9r1Eq6QfqDTotG6/RCOS2?=
 =?us-ascii?Q?b/rqXm7e8ADDsC/0TGhkGj9SxP6zXMdWbNGvkFgDL3TSkqoADAJlpzbvODGp?=
 =?us-ascii?Q?dZIl9O3JW7lQRNn57/Cjv8oiGJyTul7nogA6FAQYwnmN1c15887mIpPMP7XE?=
 =?us-ascii?Q?6pI1/+tbvctnxlZG436cWxJToTIFmM3cGSiOk9dYRVA3SH0k1FhYB/G1sPAL?=
 =?us-ascii?Q?t7FX3fx3L+RyhWdr49ODgKzhCfrBROSqbBqJ4DgXoC7KIxk5UDWfXmQ7eK2R?=
 =?us-ascii?Q?uiSGDX2BcKnTCQaQYZhTmwjFDiZOkoNdt0ROjrnTB3JqugBR4FKTvsm1iF/+?=
 =?us-ascii?Q?4RUSq+GE8+HUH8m5PrASfiDNC2qmNXh0/1/20kp1QP078PZba15fc23cb56v?=
 =?us-ascii?Q?y48DimQth/2e9REMlN1Hd/MdpsJ7Trf9oAnJVicg3SpBIKCuql6BxW7T0QAO?=
 =?us-ascii?Q?kObI1q0/sXYAFUZzlldF24yf1PWJnZT4AsNlCJDkK7kHx7fNC3aridlKBWPX?=
 =?us-ascii?Q?S/VO0760PDxOyoXx021rWH/4xudS7+FEasXrUe3042cvAEyFHItCSPDmMtYQ?=
 =?us-ascii?Q?R3EC6j30Ph6zqOo+MB9RD6OHYQ8SWtMcUMN3vlEzqPHhHjU2n1SDnOoYoLgp?=
 =?us-ascii?Q?YQbS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b055b839-5802-488d-24b6-08d8b78082d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:03:05.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dr5Rzx3+7X3X/+bDszliCIPH2OX+HyYe65eoqBEu7ZMkUmShAN1Ra++szVXQy39IzABienBtnBHEddA27x7b5fcsCYr8fbwSC+Zz91k4bIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:33, Christoph Hellwig wrote:=0A=
> I'm not a huge fan of this helper, especially as it sets an end_io=0A=
> callback only for the allocated case, which is a weird calling=0A=
> convention.=0A=
>=0A=
=0A=
The patch has a right documentation and that end_io is needed=0A=
for passthru case. To get rid of the weirdness I can remove=0A=
passthru case and make itend_io assign to inline and non-inline bio=0A=
to make it non-weired.=0A=
=0A=
Since this eliminates exactly identical lines of the code in atleast two=0A=
backend which we should try to use the helper in non-wried way.=0A=
=0A=
