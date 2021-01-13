Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDCCC433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471E523117
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbhAMFIZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:08:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28892 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbhAMFIZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 00:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610514504; x=1642050504;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pSIziCE4okotwmHWloYTyPnNYUKKjKYL7jNzsM28PvY=;
  b=AqbH/zFyQnD8oKQibdCxzDp2Vklh3G5OgaVLl7BrlOoasRGDmjeo0jEM
   bee6kE631dDRXg+d+4Dqj13rdUl7+Ph2lbODyUu8QFsC3B6O/7QAZybFn
   n5RGlpVxVmImcPGMsLXsmwt3qAMqFrL9ijXZCtNd3jFe9WxmV8OZJQsat
   LM2nOffjLMYNzUO+FGIn6nUj3ThKLrCXDu2qhgSHJpnbcjLTytwKGWKL8
   ndSwOHVO+TpblLn0kCf1hXLLT7BenIeBPr77eNER6XJkRt/2u1eyZnZML
   wZgJfLEycVJihl4nEEmePgIqx7ZZD56bvIkNcN9+xCk90QEBpSzGcvo0K
   g==;
IronPort-SDR: DpKL4IuoEhOlVe8QaGiq35Vu5N0mytsgMogGWUrsNIktYkkBfptEoqpgrmwwMJvgKpEfkie8nE
 rElhvZtXXuIJ8NaY3IyPnsncwfkIwYj9MUUw7LI2A75HNCzCrU0kVod+z8IwH1x7SbTTdW1xc5
 k013yWiOCKzYus1CaD7K1ZlW9CxhND8E2GZea30k9tJIsziLh0MDxFOFNX/JRUYQFwzfgsYVez
 gTZWC3y4b/LK79jNh3oYpbKmu8Ey/icNkEQYz12vx/sMx3uZPfrRCyM5rKhMPuLaF2RK6chaz0
 Gxc=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="161745276"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:07:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQVnmcRMJcElxwh19b9yiI1cwJee7utFdVWCTj10R1nSVLFmHVrbp5aQD6rHBN56ByVKs8gujPz5tcTfDzYD96SDdjy06mNqpcpM1HpR/NCUrpE3suMn7S8vpNRxLBw0dyn3kNv74WWKoRlI8ocbFSv0qyZzpx1wEk/9p9RrFIAhss5F7XBay/R1k6pnYsrWBqe12qmdtyPa2S5lcDxcsdUiGdIBUYf7q7d4e6azY84cpUR4eBb5qDjp2hsw+NiQL0a9FGyidJbMsF3jZOYOi1H8QPunKUqG2Ildf0ss4A5UyFRqZBtDTc3473yVeZ42zdKYkqjgN2d0G4cne+GK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI+JzR3rRDG4YhZlgk5oc6cgXf6Rf6bzYMhL2hrtDaE=;
 b=ES/ssz/7RfH0PQ6jNje/KlJpJM9xtNtTWIXXuO1Nt/KI3xrR45DNYOC5CVf0m1ug5brepg6o7Yu/U6lKRNsuBiXMeowCAlCmrFF5+y4Y5XAvHFiqCrn7ervYcOjz22ax3eX0tqK0Dmlad95ibUtiUhNaPyCDIXBigZxAffzR7r3py0ET5+GOO5A9DY27jORr8dOcAkPkhC2fcLpzWyph8ZUToUXLlBya7IDlKSVnl0HN597NtZ1K6UNavbXBDT1HaaIhO5CdL1EGOHvHUIH6qm5YRdrJKMKQuEEfnULUUf8A4n6nE1MPDx4NJ706saW2K555tgQZrAFAGk35G/StOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI+JzR3rRDG4YhZlgk5oc6cgXf6Rf6bzYMhL2hrtDaE=;
 b=OjWMMoTldUXXUvMxwHgEGmE2Mk24sqAWJUq4ORdwnJQIBfJIs7uMuI30WhuhLlx1zlLzf5EK0JJ5YPdcbmkTTkELZH9TW+svU+NgN9npqqGjo+fSbMzpzo6k5hfE0USSmOSp2aS+SCfknVWTTlJxkwH+ishQKf+uuSHMtoL4AoA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5685.namprd04.prod.outlook.com (2603:10b6:a03:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Wed, 13 Jan
 2021 05:07:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:07:16 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 8/9] nvmet: add common I/O length check helper
Thread-Topic: [PATCH V9 8/9] nvmet: add common I/O length check helper
Thread-Index: AQHW6JtLukouJDcl4Uy/mSarsbmZdg==
Date:   Wed, 13 Jan 2021 05:07:16 +0000
Message-ID: <BYAPR04MB4965136E54EA80910B9ED43986A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
 <20210112073503.GC24288@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9260ff4d-c4ae-4e0b-b540-08d8b78118a6
x-ms-traffictypediagnostic: BYAPR04MB5685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB56850D2B3DED892FD4E35EDF86A90@BYAPR04MB5685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+iGkYQHDQxjYfXogKoPFBiGx655T5IK2iNfimNVv2W5Oh2CiCLl2g1XxZw6Sn23lJzUbSS/EVyFtBflcA3rdguhRqcS5ECfEvDT3K845evOdhIsDTfp3e4nZsXAMEh6Csc4J0Oq5YiWF31Xq+IrH4BRjiTsyY+djhizG0xRoeP4EBW3VYN5cTkLpzjS3USupj0MgQ2y3msinLvDOo8Hnq4k6Jy5tbJrw5tacHiRVaNExLE/CokeZFxpnpLCRIBdvupNoMON3RtEaBZ6TNlktmF1sBMmhNEvHYQsIlvNefRs9k/TnUqvRbvf5R0r3Dz2+VjQu+qPjtHskkxiUKamyKVzr0e6pfVsVUIqF8CESl1MnsWljYF1xrIcz80GkE/8iCCOKT8rwMSiUu7R2zb/wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66556008)(8676002)(86362001)(66446008)(7696005)(9686003)(55016002)(53546011)(2906002)(6506007)(33656002)(66946007)(26005)(4326008)(316002)(5660300002)(4744005)(71200400001)(54906003)(478600001)(186003)(8936002)(6916009)(66476007)(64756008)(76116006)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/GPl+LAKOysjgCHd6wyMCUzFKdgcOiJv4JzHP8ZnnOtW99vCdR87Fda85Ngy?=
 =?us-ascii?Q?Fw7XT46KPWKP+4gmNnIebWqW0/GmmKDl9pXa2qiubSepQWRMaNhENrTHx3km?=
 =?us-ascii?Q?dkpgt8KYAksZp7BmMjeCBJN3VnXtURA/hy7vxbQqRb/5QTbIJkzuScBuGuPg?=
 =?us-ascii?Q?eWOHS4PxxPOIRZwt8qwn7PRQoZP9xt13deQsU/fhNqDddRM9O7juA6t9HdEv?=
 =?us-ascii?Q?wOmStXUaVk1ZwhPcKny28LrRupWXQS9cRRmanZudzpbdOArTtsj37YSSpaoA?=
 =?us-ascii?Q?lMzd+w6k66e0Mzd0nYfDVEqICh1J+7dQF+34vKngIYiV23kn3F7C7QTcVgcK?=
 =?us-ascii?Q?jzkT6Ko9P6IRylFq6h6RJ/jLVpjZ4yquUX1EPilLzO0DFaQiwss1NacHs4fQ?=
 =?us-ascii?Q?sNHHN9dSm/i2y8Uy8T5T2VDfdeSe+GcZLI3TZBVuA5C2enVng9OaYmOcmyIY?=
 =?us-ascii?Q?hLXkKQJczq6AFcwMD3g9G99sKc7mzQ84rCa86R7gRU2oEhFcoNJObKmg7sWF?=
 =?us-ascii?Q?BwwPsm9jGuqg4k2EjZucPbA0sKi3jqMsXKQhhqlo5mpr13Is3bVaEpBuMuBr?=
 =?us-ascii?Q?D+uWBod679+XdU8/POFkYB+ADIwe8r7SdlZiRfRLf/ED4L/i0VSKoU6n0GBZ?=
 =?us-ascii?Q?nURqJn9oWRf/hehs0qzD5RVOrhHIdoZzR3evyleqg6ryUUCHa7EWaVNrmPAS?=
 =?us-ascii?Q?H+Vfv6gDtQXiUw8GxNlEeMFHB7arwJbfhK+t7xIv9jau2RXkjMdNER35iZca?=
 =?us-ascii?Q?LetnpxNMOo25ib9fqvSgaZX9sMn9GVazSBeRsC3A+//pLDghsrFs4n2ZaRZo?=
 =?us-ascii?Q?nrE+meixpNyRoVBgNWhobMmVGgyMqQlO/D0QF0S/5AnWYF7tHpohmjKVvUT1?=
 =?us-ascii?Q?7Mlonh5DTfVOMjatXdecfZb4hVw4A07HQXwx1t7nJWMHl9v624jzWNx9WieT?=
 =?us-ascii?Q?0WRRfRzmPme8FOZ2FyBF0tmY5fzK4mDEXcLOyA3zM9JGoYhHIAScFWsg2zB+?=
 =?us-ascii?Q?slmR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9260ff4d-c4ae-4e0b-b540-08d8b78118a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:07:16.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3ItRX1xfGh2S9IV62IyKD+T+oS3UDn0DUpJv09jKnwHXDdegOBva3d9XFBPpa3zpyO4lkwYnn9eQ5sXpfS/wwqfaY030v0fJrUP5sNgUQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5685
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:35, Christoph Hellwig wrote:=0A=
> I can't say I like this helper.  The semantics are a little confusing,=0A=
> not helped by the name.=0A=
>=0A=
Is it because of the name of the helper ? if so can you please suggest a=0A=
name.=0A=
Because all it has a same code repeated in the three backends and it really=
=0A=
bothers me to see duplicate code, but that just me :P.=0A=
