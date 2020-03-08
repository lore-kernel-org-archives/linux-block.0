Return-Path: <SRS0=O/R4=4Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E3C10DCE
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 03:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34138206D5
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 03:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=northeastern.edu header.i=@northeastern.edu header.b="uolg/sRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCHDw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Mar 2020 22:52:28 -0500
Received: from mail-mw2nam12on2118.outbound.protection.outlook.com ([40.107.244.118]:45697
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbgCHDw2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Mar 2020 22:52:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJK/ONrLcngARJ25s+JXUuN9+SOZo4NqLxhAkDJI/EjJxImjKxfrSRA9PJMDY+PeopNKD6tVBIBDFX4jQBVsx1/iBZiN0qYLljdXajbb7NVWAtfdcKUZFpRkIZG6uclQoCWwWuy2e28+u7QyIyRtMVWZqnw18DFGj9F8mKYdLVI1gObeKJD2Z6+IQWeVwFDcCpm+ORfXKI2EsxPp2C+X87r7QIKIohFz3jzGZOtj1V/vMOCXLShsOwvqt8Be2n9CPx+tHZ/DemErNRzFDrSo9wX1gp7xQVv+eVCdJrXHdMoejIsal27KxOzDbHeBX39FadnBF7hwJ06a4KLeihm7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LuyuWNgkXu8Xi6uY/NiszWudhCh01yuk0Vs0sXSnKo=;
 b=c+P1egRAiFkScABvAcXHb2lWLmAmfoh+iQowll0IaL7NglB48LSeiOdIQ2BKFmun8wmlP9hBiUb3+o8LwGXmnKSiTt+YM7uhY3fyulc+eJXXDEzfcJtEaq8tIYaS2MqY9g/dGHFIOb3Uh4nQKifYxQxHU6nfN2RlsoCuPLS9kumxDhOZURdgPbZgN30N6fY32p754963vEKVbNY9raITOwAI5Ayvc39eyW5Nrr2dPEoVAu6dLSdoKWx+LgIwh78XQ5NyLkChvu24QBhQcWUxsf88eNsx2X0bOrJqYGQG1Qsxs/sG1NRT4wQt+E/9hzwMHCGA8rUE6VyCTGLZNu3GAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LuyuWNgkXu8Xi6uY/NiszWudhCh01yuk0Vs0sXSnKo=;
 b=uolg/sRg6Sj+YR7rGwqbQ4FwzglcCAep6lJCbXNIGQDQVcebSQ5P87J0DT58NGErbwnWxmrI+e17grUiaWe/6IjTnoN4hRc7fAQuS1VKA7E+tqyMS7puz4G7QR0qAqx+1Kpjl5/iF+i0SxBiDECoaPopSFdPBo6GtMIZxUjp5go=
Received: from BL0PR06MB4548.namprd06.prod.outlook.com (2603:10b6:208:56::26)
 by BL0PR06MB4433.namprd06.prod.outlook.com (2603:10b6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sun, 8 Mar
 2020 03:52:23 +0000
Received: from BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2]) by BL0PR06MB4548.namprd06.prod.outlook.com
 ([fe80::20f8:a2f2:5ebc:da2%7]) with mapi id 15.20.2793.013; Sun, 8 Mar 2020
 03:52:23 +0000
From:   Changming Liu <liu.changm@northeastern.edu>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [Bug Report] block: integer overflow in blk_ioctl_discard
Thread-Topic: [Bug Report] block: integer overflow in blk_ioctl_discard
Thread-Index: AdX0/NoTSdBEELp9Sgu+quzhDuo20w==
Date:   Sun, 8 Mar 2020 03:52:23 +0000
Message-ID: <BL0PR06MB454833C4DFF442D4F61C4783E5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=liu.changm@northeastern.edu; 
x-originating-ip: [155.33.132.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ab3eb8b-4ecf-4f47-ab92-08d7c3141c56
x-ms-traffictypediagnostic: BL0PR06MB4433:
x-microsoft-antispam-prvs: <BL0PR06MB4433D552B429D9897541ADDDE5E10@BL0PR06MB4433.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03361FCC43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(376002)(39850400004)(396003)(189003)(199004)(55016002)(786003)(9686003)(33656002)(966005)(75432002)(71200400001)(7696005)(316002)(53546011)(6506007)(8936002)(86362001)(81166006)(81156014)(8676002)(5660300002)(186003)(6916009)(66476007)(76116006)(26005)(2906002)(66556008)(66946007)(52536014)(64756008)(66446008)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR06MB4433;H:BL0PR06MB4548.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: northeastern.edu does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ins1ktMSS0SAvkxdPbYSxveY5Y9eTh1+qXdot2SYQT/Ph00K0/gekeICENFofFB8ORc8WP+DSj6YCpxDR2rY6EJ/VCNOeyql/XwPb67T8NL0f9kzlVyHJhGjcKkbKydzEmdYKdcXWS5emwNI5O0LxEv/CzfjsM8qKUgF9SkYlX7eL0WH4Qjc3xU1cmHNAMM/QN2E27xSnj+ZHQtP9tvF9WG+Q/27LvhtTehzq5/6XHJYw57W75OnMan3krWtjtZg7yE2N1ma9D1rlNWwOaKLtAtiWxgVdKU7B3chzOVIczvOQinriGv4tPjt+qsoMtgUR62/oNpBkOlWiOF7TWy938GM/qdAag6H841Suag5DOtPMnAzWRu0QYEZAvGEpOEGjohaPOJsC6Qyqaojj3pr6UNX0XsSI8jmY1Dzo9XIZJsXn0Q+Pjnk7aa8GoeGydDnXvzsy9LdFukHH+NGNKIRo+E7yTIKC7uDhlPAp1XWIPXmfln26LVL/FiEJuf7G3EWDAXSwoI5276hENoGnHdH3A==
x-ms-exchange-antispam-messagedata: 8aNL2FZMt+AUkMAc5hZyRoeed6TLZkxzv5jFMYxq1IRuiIwqhWHGbR1MBioS114J8xXpFBQVZYUxD4bHoirhmJgyPVlIMsXXvFVztJ1ODJfJwxJ7udVOGRmRMChSTrvUsfGyUhOxz4/6RMexMMUSDg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab3eb8b-4ecf-4f47-ab92-08d7c3141c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2020 03:52:23.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvU3Ajof6GQpLcTBAJ41HAhIzLKWfqQ/iNbNwWlfGd2BfAcB80YAGhAF8ETpezQfmO5szMik4sbvQ/d1E/HfPkDMOso2ChlGNAzvTCIq8E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB4433
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This email was sent because the previous one was rejected due to it was in =
html form.

From: Changming Liu=20
Sent: Friday, March 6, 2020 3:59 PM
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org; yaohway@gmail.com
Subject: [Bug Report] block: integer overflow in blk_ioctl_discard

Hi Jens,
Greetings, I'm a first-year PhD student who is interested in the usage of U=
BSan in linux kernel. With some experiments, I found that in=20
/block/ioctl.c function blk_ioctl_discard.=20

Two uint64 integers, namely, start and len, are directly from user space, s=
o the sum of these two can overflow and wrap around. As a consequence, the =
check of the sum against function i_size_read at=20
if (start + len > i_size_read(bdev->bd_inode))
can be skipped due to the unsigned wrap around, the overflown sum is passed=
 to the 3rd parameter of function truncate_inode_pages_range, which might c=
ause undesired issue. This still exists in the latest version, i.e. linux-5=
.5.8.

It's well worth noting that, a very similar pattern can be witnessed in fun=
ction blk_ioctl_zeroout where there are also two uint64 variables with the =
same name from user space, and the sum of the two variables are passed to f=
unction truncate_inode_pages_range too. However in this case, the wrap arou=
nd is check at line 262, thus the value passed to truncate_inode_pages_rang=
e cannot overflow.

So it looks like the issue in blk_ioctl_zeroout was discussed and fixed in=
=20
http://lkml.iu.edu/hypermail/linux/kernel/1511.1/04403.html=20
But since in blk_ioctl_discard has the same issue, I wonder if it's worth f=
ixing the issue in blk_ioctl_discard as well. If not, I would appreciate it=
 if I can know the reason, this can help me understand the system a lot.

I cc my colleague on the experiment here to keep him updated.

It's a great honor to reach out to you hardcore linux kernel developer, you=
 guys have been the hero ever since I started learning CS. Looking forward =
to your valuable response!

Have a good day!

Best regards,
Changming Liu
