Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2FC4320A
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4EE60E09
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG1SAV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:00:21 -0400
Received: from mail-bn8nam11on2101.outbound.protection.outlook.com ([40.107.236.101]:22913
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229556AbhG1SAU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 14:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnUf3l3BApts6FzNl42OBPyJwaX2v40sbM27RDZei4XZ0+3nwVeyKXF/WMorT3bQ4VJfZDCuRwcOrawzrpegzYHqcloY54rH5pFKnOKDBbm1mfiAV+AcbJsXECCjrTbkNUh+gZAC+2jW8OeRxyNKLEleHPhHSiclobfUjW1tt81hs6P4/c1HHxafAIzlKRpMhUzkWC7G/rWXSpJqGFVvnNqvONCLn9RUTPWQKN0yW7zb/3aI07wWp3PREyAbPLmHA66Umh52ZgZ8Yld3lAIQ7pPbU+iqDG/I6AwmehSnck35un/WYxukWp6jlUNQ8chzC7dNcqimaraaOySVj3Riww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNX1ZSTlNaWQC63X0YAXx8KYcMG0Nnx6EfxoC+8A1sw=;
 b=c/oX1d3000g2lEvsXylPUF0+PVQw5gHq5t4pt/zX5g7WwXiYn4z6Wp2C/VVVG1EinoIVTuAXaIoRTmpOIZOq+Yzi4SWsKND+CUt7tvFKyor/D0U7ywmqLN718HinvKxydmwIh1qfxIcK5fHB51a14Hvm9MVcSeRV85FaIx98Wfgpg9ml2T6207Vxc/zEYWORHuXmecnl0CYra2H59kaP2aSoBPyQeC1wrmEgvMuIxiVpj7KAaAjYCHKlb3a078F7YTb1Okvl+hu4Iw90TJobdZRhkbtFxZRDX/ZQtAxlDtubuOZOSkDyilASXodVrEIx3NJ/JSlWmp33sawSP4TnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNX1ZSTlNaWQC63X0YAXx8KYcMG0Nnx6EfxoC+8A1sw=;
 b=L3lCsTZzbMHwlnMx5HCvuc4c7vXXFVtShPU/N1mAG9k518Nndc3nvj8P9a0bIuY6FJ8nPaBouOi8CUfLZTMfokwcmkwpAENtf1XqHNDUDZgFWRf3Z42aYR0ZHiQkvDiHGRhGw7Hk9BemxTjAu3wwJMAGvEsd7TNosMJIHtdq57U=
Received: from SN6PR2101MB0975.namprd21.prod.outlook.com (2603:10b6:805:4::28)
 by SN6PR2101MB0910.namprd21.prod.outlook.com (2603:10b6:805:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.5; Wed, 28 Jul
 2021 18:00:15 +0000
Received: from SN6PR2101MB0975.namprd21.prod.outlook.com
 ([fe80::1d1d:8845:1b1d:972a]) by SN6PR2101MB0975.namprd21.prod.outlook.com
 ([fe80::1d1d:8845:1b1d:972a%9]) with mapi id 15.20.4394.002; Wed, 28 Jul 2021
 18:00:15 +0000
From:   Sinan Kaya <Sinan.Kaya@microsoft.com>
To:     Karel Zak <kzak@redhat.com>,
        =?iso-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>
CC:     Jens Axboe <axboe@kernel.dk>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
Thread-Topic: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
Thread-Index: AQHXgzHeweNCdRuBtk6UKgQVpdHAeatXaheAgAAEyICAAClPAIAASSUAgAA6HICAAJLc1Q==
Date:   Wed, 28 Jul 2021 18:00:15 +0000
Message-ID: <SN6PR2101MB0975A55F768A97B08690AE7386EA9@SN6PR2101MB0975.namprd21.prod.outlook.com>
References: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
 <e7f64d43-2a26-e386-b208-5c35d6a56ed4@ans.pl>
 <7de1bd0b-b8ea-daf0-b677-f92db1c1cdff@ans.pl>
 <c1c9d728-c4d9-eaf4-63c3-d13b99da3a3d@kernel.dk>
 <72947cba-6a12-d54f-c9c8-588729631306@ans.pl>,<20210728091405.cqvkgv6c2vvsmacb@ws.net.home>
In-Reply-To: <20210728091405.cqvkgv6c2vvsmacb@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-28T18:00:14.484Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 445c8e36-d8f5-4c48-0697-08d951f18d9b
x-ms-traffictypediagnostic: SN6PR2101MB0910:
x-microsoft-antispam-prvs: <SN6PR2101MB091027D53FF1DD17BCDD798F86EA9@SN6PR2101MB0910.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWBPg74m27kQg8Xchsb8FYae0UL0wiSrEm+CmiIGbqTqKnQw60pSh2rk+5H/Yq2v2nx/rC755iKOQ2Y/0T3d1j0lDvDrBgjL5OI03aSBEmmUIq9nMl00h89JRfxX9uyzjUCSgLB94KnHtJR7Ta6+6oLxdEfXL0atUrTNVC43gBRjs7McYqfDlZxGJEtSgdy7i/Xqynw/suGmjRQ9NEeYbMzZAFubDafzgo8kiopptbtQmV2hvrzlVVtBmA4XGGGCeEi7xN5cIoQ+jpSOB2fMIfmb8mYUt0h9BSPI2XZY7QKiRj3sczFbzkqwMZki4YQOSQAj7BEMF89VC+78c3QBD+Xd4vr7AVqd/2ejVmuPVKipDpxwRROnyyql3rLnqIeEqg8dBnqpBJ7Oe0gthiidbReytUvENzK4hXTdbNSjKhvUkytIjat27tfIu0/SF1+hUSek8LD6cCaYI367FJ+S/nxL6e5DtCCUuo3NEAysL6Tpf9c4sH5uII75cyQ9P4SGlXJeNWdghl21nytJCX05iEJrITqzDAsdzxfynrk+n7EYhsUrkfzlbfKM1fvoVRusaOtyPdu5m7IsMSdWJkKvrHSCJ7I3ZWeC2iQDF5w6xqN0hZJxdbXdhp8B59LLzboofCXdxjVsn5uJu1xX0hAfLPwNxbRaZYyO8Iyfne6ENK2LYjnxWGQA3E3PqzOVnNMZfVbblx9MlHgeOo+KWcexpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB0975.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(558084003)(7696005)(66946007)(10290500003)(110136005)(26005)(86362001)(5660300002)(8676002)(508600001)(8936002)(91956017)(64756008)(66446008)(66476007)(54906003)(52536014)(4270600006)(2906002)(8990500004)(76116006)(71200400001)(38070700005)(19618925003)(316002)(6506007)(4326008)(66556008)(55016002)(122000001)(186003)(33656002)(82950400001)(82960400001)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?VJNJPAUpdlX1dqmhm0bjCuBqwlcnltGej3Hsvr3WolOrCN5qSMntbg5bnM?=
 =?iso-8859-2?Q?d42+XDVuxUxmLh4vENGmntSZWmJkagKheMGdd3hCvUjuO9aH5aXwjNTv8S?=
 =?iso-8859-2?Q?/nfhw10DuhPOOGR1aAlydu+EoA8i03grfdGWvyCVI8Cf41HewMp3YRZJ/Z?=
 =?iso-8859-2?Q?83m09V7DcwBIb6Y7RPEz/G3CSIUzYkxH/Ehiut9rncXQh8sgaz/bXHULmX?=
 =?iso-8859-2?Q?a7wg0+G65kvo2YEdyTmliAQW5j35h+1Ddeu4it958uad4l2DWuzYIciAz0?=
 =?iso-8859-2?Q?8vJAiL1bJbsmLsygvN0PeYKwIoGvDFZHTT860bW8u1/d/vRHAKybbmIAhT?=
 =?iso-8859-2?Q?BFEHJJ9es+9AO3MlYDInmVnIf/wch+OQpVuiNVwv1/u4tvF91dH0H0Nvq+?=
 =?iso-8859-2?Q?4jWgB6TBJ2d10HfjAPpHrGg2fluyeezLaQ5scUvqcXqw0o9fqRa7wb/n0+?=
 =?iso-8859-2?Q?GghOKRZf2UT4AAP9+xX0Yy7r+brecTbHhKE96w5buZBao/9ngU7mT/UIVE?=
 =?iso-8859-2?Q?8knNrAaMWVago8HZpYPQ/xd2aMRVkTdyCdZkyujPmIjzv7pL4OWbQvHGWM?=
 =?iso-8859-2?Q?L6uj6MKhU5ggDx88Lgs1hDrgoGBrPVZDVubTP8cVg2sGBis3jT49lQ00Pe?=
 =?iso-8859-2?Q?PPvsnlQbFInstZA+8hUtTsMICG9JIaBb6KQe7PR/YhViI72tcnz2W8Zxv0?=
 =?iso-8859-2?Q?7189665cxErhuFI4Wo/YyGLbeaFQcOfKvVGfLaL03GnTXdHNCf1anZhMuA?=
 =?iso-8859-2?Q?KP/2lcdb40fyLYrPlTSH+pQnyL6OjpL7ZHDXjj4A7w4S3i7xZ6oINFb/by?=
 =?iso-8859-2?Q?KQSV9NhSynvzrQqrf81gXL9UQligQILOP4iwwlIHStljdSNovg9wRGDGph?=
 =?iso-8859-2?Q?WRhhgW9fPerXXhRSUeGrNyHgiZ9liqES8M5aC5BurLgN2Klu43UcWaBpUB?=
 =?iso-8859-2?Q?V+HZ0X5vvoEN3c0TZi8vMtvHdkiS6OyYYemhlElwpmiL9Pu07nJAi7q/Qb?=
 =?iso-8859-2?Q?R2UBqKD6bZdzCNOsd05kN69b0J1a639soYc3YaFEUTHzNORGdY6Z/klIzs?=
 =?iso-8859-2?Q?Qh6LkQSvRb4wxt5GKKqBLHRrTd+URbypeN0VYdX6vekjADkO0l0OXFzrXC?=
 =?iso-8859-2?Q?Cxnf1cBYbdLDUeWZHiKoCuHT+CH8fa7m7MTRVRwZpNwedObY9h7apt9dN4?=
 =?iso-8859-2?Q?AYiZwjUfdRWzFWodaifaqSX9oUQRt7ulaeKlJblDM+U8xvsc9qL11kfxJt?=
 =?iso-8859-2?Q?8YR9xq8vRv9+vAKKZTAh2x1mVEra3ySjlhicN5aq0tf8sxnZUtb27N/rws?=
 =?iso-8859-2?Q?Tuzx/Hy9NaDVWi1vCO6+natdbGfP41VpG0X6gCHlpKJVYSk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB0975.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c8e36-d8f5-4c48-0697-08d951f18d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 18:00:15.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CesGWJWlhjZWrnLa8EjF9psYpiki0XSGsXFobAOjh66CAAFaNeWLad8uMlD37789IoDYtJ+LPhDEzrrhG4b2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0910
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for fixing the issue and making it more robust.=0A=
