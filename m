Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D57BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C37A64F3B
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 10:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCRK0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 06:26:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9465 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCRK0V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 06:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616063181; x=1647599181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f3QsFtb+f9fc80ImXjHSTL/yjL3YmCNu4bFDRJ0BYrA=;
  b=cGmk19dEhOM3PuB8ebfDCaX3PdmoqZ+H2FFXiZUqh1Cg9iX9UNFRDX2L
   t58X6jU4nZpxZUgV9K5TwMX9jO+E8gvAgdkGK9CmslDjYsDaxdQxHrbpu
   4mfsaeaqcCjdvsexj+Cep53DVHP8l1vKcUO5Iy/tTzS1dv/URi1iQ1YFw
   ECVThjWv1ZpvfZco20hOu74Lb3VPC4v2dlLgaS9/ruqkpLw15/yUKUA0F
   IdgWBXSaARhD7iwuWHlOzYnuhDThfXvwGikxnnvGnixK5JNCkE9+uqXA1
   opdZKp2MODnPOKWI++62TKPLvc1eGq32m5bLBGVvZm18n+PKskw4QlbMJ
   A==;
IronPort-SDR: MHyK65OtMj1t2efgeO3MqUtix1pAl9RFj0XX6rqaJzE1GhiFlnYjX80sSPCQ8fQmjBc6VgWYH5
 4j4WuU06gbxxueFvxEzp1dP0S8aW4ZJ44Gm8nVZExBMog9Mng+sIiPNwvyfQS+gFioG4VxMlHl
 q5rKCqPl9RqNT33GM2YkE/Dzblo0ofhFZqi3Xc5XfRdOLlLuxZsgYz33pXhSlbA1DHxH888bX2
 jRZa1Zu4K+BKvnelcCqJsvIE5gkVANnma98m5hdhlYaeh7l3Nmln/mhaAb87pXwFKU2td2dtCs
 8iU=
X-IronPort-AV: E=Sophos;i="5.81,258,1610380800"; 
   d="scan'208";a="273181079"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 18:26:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etA6+NbdbHrveaKC6zqqZ/QAJ+t3H5sVtzoyeQiHt+++HdpcHOUDoGE+oUWwhNbrUxsswG539WLjFKFpcFVEMZcLqD+kSTVWJxrdhFWoi8GALlbLoGL7Oz6ReHzNSvFh0HW6Kew38TuTHhATWOIHQzr6lJdL37rAnK1F1lj5+tkzfnbogxZkABbRb5XXIl2HaqKG9ztT+Kv732uO0xCi+zPcKI90IAWH25or5tSQcacBMSLrpnX7mQM6ZIMSalAdrL8J4LfhE9kMc/95xNsK4mKX4p8+ZnSjliKz4Wf4JPoFyn070uY4hR6ceemd7eOqtdi+Ebk654gE1rbXJpNE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3QsFtb+f9fc80ImXjHSTL/yjL3YmCNu4bFDRJ0BYrA=;
 b=E7kDCok46QGgEGu+kAfrR8xFK+RPsQmgfKY327hbiCFfos/44XJ9HJULqpkDDdN9UL5RZNe42QtdA7FhakkqVUdUHc92H4owpQEQ7EHzDJeb38dznA0QSLEVdU9MlsHqYz7Wr2sGbgZM+4UujSDiarkJgRJgmvhlRqzDkIr2VK7j9s27QZSb2fntggp7eymnJs5HZgDcDEI732KQIDiTGp5zJOCItqysEF6ACTwof/3ped9r1b09Ik7f54jnt7i58QYLmt5BjwGhO1xs2izy+X+JqeCR9vL4MHXbfkfEZWSWrah/HWsoTU1CR+4cIzimdmb12tlufZ4i3bhwoaQkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3QsFtb+f9fc80ImXjHSTL/yjL3YmCNu4bFDRJ0BYrA=;
 b=FeCI3wF0LfSrNm3yFlyyIklpYZIjO5/kggoDqCUsteq54TkckerR6SY3P2imAK735yLIr/fXBL/2y+s5R/hYDr5ZDYGGvCgk1MXp8r7DYOgBCxaeGYj2+lfrhhnu/zqZafHeh6qNh/YZsUQ7vlZK35AQ9xRwL2SFezyXKr1Fei0=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB4791.namprd04.prod.outlook.com (2603:10b6:a03:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 10:26:15 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.041; Thu, 18 Mar 2021
 10:26:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     "hare@suse.de" <hare@suse.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        "yuyufen@huawei.com" <yuyufen@huawei.com>
Subject: Re: [RFC PATCH v3 0/3] blk-mq: Avoid use-after-free for accessing old
 requests
Thread-Topic: [RFC PATCH v3 0/3] blk-mq: Avoid use-after-free for accessing
 old requests
Thread-Index: AQHXEdMJZXQrE52GNEm/GZZfpXu7C6qJnpgA
Date:   Thu, 18 Mar 2021 10:26:15 +0000
Message-ID: <20210318102614.5tatcdqmsphouydt@shindev.dhcp.fujisawa.hgst.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec521c2a-e467-4ad5-aecb-08d8e9f8430a
x-ms-traffictypediagnostic: BYAPR04MB4791:
x-microsoft-antispam-prvs: <BYAPR04MB479177688D65FA3B342C37C2ED699@BYAPR04MB4791.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/P8XYfN6SVKSf4I+zVeOQ/2pjPi5KBVtStj17P3tydS/jspRw01QWMhuLpCINPCnE1qujuL7xN2Mg37qj3eFDUil+ETCLjRtE9WdHdkqJO0EtRUNQzL1PNSX5hNBUh21RwmVt6dDVe9ok2i2mKVw+/R1ZAcRb2qYzfUSa3GtY+lYGjH8ut7+b0bUE3u+ih6ARlxXP312eHJgAIfntXVFyT8SEhKlBXWXtwtNN2zSm2/1t5wFsn/EBVQjyb5y+6jkqWF8OgGZgn5FSVuq5A7snOgiCTxH1tDsPspe5NLp0dYkC+2Ct0slTgoyW35eiRcYdu7iQvydhFcWzGhirw7KdHjjlo0fMD02rRt9V7MV5DBNc8Vm+GNjgDwXVldCuEN9aKxOvSc3k5G5Ke2VwCwNTOBCMrDdGjDH6i4Yg7mC93TbKdUH/99sNw94zKoOEJ+Qy/nTlgrPzKEuJeqSfrmyarw6a6dqkPOCYi+6Qy5uOZy9pUbRW1hjpYF9KSjZUmRyyxZXozD9p0Rzf24S/Ck4S8nk3mBGnWEffRJulva6YYI5+xJ1513KzjioE4gTyvHt7iz1btQEECEglktHaiiGBBsgGrbDW8ta8TkV9SMtYIxj0U7dlo++rZNuGSsgrPyKITkLafSzH0CGGrdc2oeZONZW8pHqpcshEf5KbJBlBj8nkbvBxsyNJgQ4ZNJVUSWlgc9NNaPb1MXqT/6hNb6jzI62Lo3mXi7LMZ0HcZ9FYc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(366004)(54906003)(478600001)(26005)(4326008)(186003)(1076003)(316002)(6506007)(71200400001)(5660300002)(6512007)(66446008)(66556008)(66476007)(9686003)(66946007)(76116006)(91956017)(6486002)(83380400001)(38100700001)(86362001)(44832011)(2906002)(64756008)(8936002)(966005)(7416002)(8676002)(6916009)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WlMLK4oGckGJWBr/zBRDL1B++53Y6qweSDMVyjzblpIboPBfJiYEoIRTEBGC?=
 =?us-ascii?Q?WkTBoL5V8uh/bbt6h81gwX4URuTf+tL/XoHfidFNNZcRm2EkdnqBRM7Z+1hl?=
 =?us-ascii?Q?WSFSWjiIAqc7A7FOuJUtbXSsNr2bFashUvcNy7DQlqeYrImJ+lZ0r1HA0+De?=
 =?us-ascii?Q?GN7lJnKzdy6VIbb+8v9kZSAeDXyPBiOW2ZiWKE4bEDtTVNe3ERgIx3Cx9rIA?=
 =?us-ascii?Q?K+O03ISydImUP8s6Pl35IBXukaqRrA5ez0oqAW2219is/ZNxonBMe+sU3cMN?=
 =?us-ascii?Q?e6hBMh8BNHGpn+esdoM1AsqcPOsvN4QnT5hVWjJC9Zs/moCdZG46aHj3p7UW?=
 =?us-ascii?Q?dq5tsEiZ69SjMSL5/f7uvOxqNuhzhh2wh12wcPmLkShPY12Y98fTC6NURj+M?=
 =?us-ascii?Q?pvKhphBaLGWmYog9Nwy3PbxR1D1ahCHUwODkzO42gXZUxu3h9LxdfrZRm9a6?=
 =?us-ascii?Q?I1n1hUCMF04YfzLKzDgyUprno2o9YlzQu5LRGgtDgUSZYM0WWECpHl9sH2Bd?=
 =?us-ascii?Q?yZJyiz2rn8JSgEb/cecT8tGgG4ume/Q7l33MauISeM2n0Tj/KsHzdXvfY/vI?=
 =?us-ascii?Q?i0JaCP1xtumHG/Js9KJHht9BaNJTvgqPHpuknYMvlsz0L8LiPKzN3vtB3kHv?=
 =?us-ascii?Q?ywvYJvFxrK8q+Ug6vMhNdq6I1/YUfye6R5fKURh/NuGmd/7Armz2amocVdIV?=
 =?us-ascii?Q?eiH8i2u/AFUOGv3vlJmblrRunnoFakPv8ZbwWdhQtDnKq5y9jAxhcQvjkt74?=
 =?us-ascii?Q?6Vba+EaK5uqV13d/mdBNjCgEJPld2z/5IIy8akw8lPuBBnE+DHMYaK8skK6p?=
 =?us-ascii?Q?yafWidNCWFq6zrlTiewSPJbzCXTu1guT1XaMMYaYwaL48/nyvkX+h2e6XPIk?=
 =?us-ascii?Q?lHstlkVPeJN3iQRmyMXHns6TE8WIuOmr0BfYtQTLuX40P5KQ4q/3xcqmpdNk?=
 =?us-ascii?Q?7SnLzCussyLCLUv63hRtw7tf8gr+iu1os8+XF1u4ZkFX6sttLUrf3fEiVPY0?=
 =?us-ascii?Q?LPXHR7HHT9L7X3aH8evAX0/vft7ZDzr/00XKJ43UPSdkgrpiHtLt3lHxM5vo?=
 =?us-ascii?Q?E/OKuSUEP1nx/rxM0IoXEWA1lxK+LxDA2xDfcWFJIIJfWuPMI3ET0tHsHrL3?=
 =?us-ascii?Q?jUOiGkRvbL9fR8W5yRHLo4hWev7eq3QgskMmmWBUT9U/DdcRYBqLfZr5GtTC?=
 =?us-ascii?Q?w0vzXX+/WiWx7Z+9XlEKab4ZUI8CKU5/hviJEImHN+swiEmvLIZVexcYop4U?=
 =?us-ascii?Q?eszm1pvMrN22fiPa/vdfkBi1lZjazYlAReRsMCcEwnnUzdQGFsiY5jmCvuXn?=
 =?us-ascii?Q?zCQCDktMFeRRPGyAyJX/qeU13JV49yg3P3XFalXGnvsh7g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <062094E985769F458E6D88E7C2870FAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec521c2a-e467-4ad5-aecb-08d8e9f8430a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 10:26:15.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: El88AgBwf+SDfG96blevH3CvOQlrFvAdaA/VG7xs19EH3QlAf21e7G3L9CFXHzeuOkfesO+v4eV2EYGVaKFCVimli9zPsq+e7ZQq4Y6SPkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4791
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 05, 2021 / 23:14, John Garry wrote:
> This series aims to tackle the various UAF reports, like:
> [0] https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96f=
a96@huawei.com/
> [1] https://lore.kernel.org/linux-block/5c3ac5af-ed81-11e4-fee3-f92175f14=
daf@acm.org/T/#m6c1ac11540522716f645d004e2a5a13c9f218908
> [2] https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f6=
4cc@kernel.dk/
> [3] https://lore.kernel.org/linux-block/b859618aeac58bd9bb620d7ebdb24b90@=
codeaurora.org/
>=20
> Details are in the commit messages.
>=20
> The issue addressed in patch 1/3 is pretty easy to reproduce, 2+3/3 not s=
o
> much, and I had to add mdelays in the iters functions to recreate in
> sane timeframes.

I also observe the KASAN UAF in blk_mq_queue_tag_busy_iter during blktests =
run
with kernel version 5.12-rc2 and 5.12-rc3. When the test case block/005 is =
run
for HDDs behind SAS HBA (Broadcom 9400), the UAF message is always reported=
 and
it makes the test case fail. This failure was not observed with kernel v5.1=
1. I
suppose the failure was rare until v5.11, but changes between 5.11 and 5.12=
-rcX
made this failure happen more frequent.

I tried the patch 1/3 by John, and saw that it avoids the UAF message and t=
he
block/005 failure. I also tried the patch Bart suggested in this discussion
thread [1], and confirmed that it also avoids the UAF message. I appreciate
these fix work and discussion.

[1] https://marc.info/?l=3Dlinux-kernel&m=3D161559032606201&w=3D2

--=20
Best Regards,
Shin'ichiro Kawasaki=
