Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20954C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA52F20831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 12:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NfL3c4ny";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C09f//SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52F20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeKSWw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:52:59 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29404 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeKSWw7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 17:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542630570; x=1574166570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o+LYMg96f7M+YlplGklEC0JdWaJoPPt7r3ACNEbYjiE=;
  b=NfL3c4nyDMRWv3JPcLAqEE59qMCk8fHXZh6BL5RklL0uzkHNhoZUNIQv
   RJicGIjcKmt1Ut1b0eoePo7Ckh3ABcvT2qLFXK+mxIC6O7ptaL79OmIAv
   0ngRM+c9zbUGvX62+PVpEunPLXhHED+k90SnsIsi4qogyQmn+Vpw/3zDD
   lk8+DcvJEkiN+G59clLgrHblKRp8mzgJ3/CvIOIdl8g9RGliqn4Nhgblc
   j3T210TafmUNvp8MlgOjXFwcZUnRTjARHwjXa/TywPIsb+qaCyHhZ+Gg0
   aZbiEEQGQRelcCbo39AGMi8gqeyH1vXP1bjnQGoc+qJJlv6qg3qbLVF1H
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,252,1539619200"; 
   d="scan'208";a="199130012"
Received: from mail-sn1nam02lp0024.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.24])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 20:29:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUpjfmbiLgFAZDOi9p9L7+RKFu1pV2u9OtGeE+vn2M0=;
 b=C09f//SSBpOAIhy6iOt2UvgUJgsuMg663XsPdvRbFefp4KfQzVFrktJH57EXOaqvwjyQGTuhQPmqa4lKaO2KQxbPhT+s75AMb3rlHYDOHBLeQluc1dwHF0hlYxKbYh1wJbgR0yM2gZV8sLeRJxVCDlrSYl1bWNFH/kf31aP3Xw0=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4157.namprd04.prod.outlook.com (52.135.71.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Mon, 19 Nov 2018 12:29:27 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::4c22:c9b8:6198:5fd1%2]) with mapi id 15.20.1339.025; Mon, 19 Nov 2018
 12:29:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Benjamin Block <bblock@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ooo@electrozaur.com" <ooo@electrozaur.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/8] bsg: refactor bsg_ioctl
Thread-Topic: [PATCH 5/8] bsg: refactor bsg_ioctl
Thread-Index: AQHUecM8NZu7ZpLgHUiBBH4M8t8leKVNwHAAgAlSa1A=
Date:   Mon, 19 Nov 2018 12:29:27 +0000
Message-ID: <SN6PR04MB4925E6D8EC8D401B8C947F37FCD80@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20181111133211.13926-1-hch@lst.de>
 <20181111133211.13926-6-hch@lst.de> <20181113140550.GA7222@w530-pk1mzal>
In-Reply-To: <20181113140550.GA7222@w530-pk1mzal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4157;6:07tAGyiplTEISxrpmJkz12FDGYCpbxrP5tICGOCseeIx9/+YUbH14AuzbyTprhaL0OVeitsctvxZCzM/EdFqvrpzbLnokSX1KKaUU34Ssj0tf8ZBzc3MmVCuM4F1WWSxr+PMv0XmLa+MdrjU9saB0ZkPu/ny/UbI3Oi2DwMB4nHkYTgBbn4RTeTor12lyFE4nugUU3Wy1H5Uc6IldWz1uHftUIugmDCcngfPt2qM/MdjM1pQwASG9XvQIf3JfpkAytMxm35CywrQOS1mcW9bwFfWp+YIBep1AMVNC09DSKZ7WdbdgabFK1LOdIy4QuhfSw8LMzeeeqrp6L+Ge6RZCVe1jeRm53IhFdPM2Mc/odDvzwBPGfgLl5dyZmH5SZMAvS6aIJdE1QGim2lWZyFU8rnKafd8DkLQi5TNwZSFIkqKBH9c/rL0+WXExeiQQMXIURM+J8bnMa8T2soCLNgDfg==;5:dRLbU8iTfF5uW4ZdsRIkoMg0wVDVKoHo1RM/6kXMeu85g8hn6+HTwkQo38Zt2NK+DTYqjeYvLRPVrSSVyGLihDx4NBYRxhEv1nRlIm2QEKd/9jB3/lrQ0jP7lNvcXQFHJ8V3WHMoYYO4XLqDq4nrMhbmcbgOSRDAotx9Po/MktM=;7:hExNOulfu5u3Pf3NlN2rE8wXz31Xb0zMH+tPGoq/zTOrY+6W/yp6b14qW+nnzIugFLYoRjRv8zkeEZyO3Mc/bBvd0swS01O/0KHRIGyTVyvDxddTvxjHIUqqr/3JUXPD/FaUwG5D1WekiByFj5BHiA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 898e2ab0-7059-460b-40aa-08d64e1aa5e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4157;
x-ms-traffictypediagnostic: SN6PR04MB4157:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4157B57B30BE825276F65056FCD80@SN6PR04MB4157.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR04MB4157;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4157;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39860400002)(136003)(346002)(189003)(199004)(256004)(86362001)(33656002)(7736002)(26005)(102836004)(72206003)(6506007)(7696005)(5660300001)(76176011)(14454004)(316002)(74316002)(305945005)(54906003)(110136005)(7416002)(99286004)(229853002)(106356001)(105586002)(2900100001)(6246003)(71190400001)(71200400001)(6436002)(186003)(8676002)(53936002)(55016002)(9686003)(11346002)(4326008)(476003)(486006)(68736007)(25786009)(478600001)(446003)(81156014)(66066001)(81166006)(8936002)(2906002)(3846002)(6116002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4157;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sZWZAoFjB55T10FZ6k2e9KmdUunTrMoNRZpqKvExT4uASG/Aegb6MAZ4MrskIKz833WG72TXUHqDA9gcOt0br6ctWcoQhRD1yIrVo4SoILTBHgS7P3v5+l1QXyYANC4YLo7La+RU910ViMh3WxzrzG+Fq2jp2oA74hFojF4Hrm/xWr/SpfL3XsiIzXvXaUj8HonfpFT+mwXLsGoBteOj2zC5kQjKxq7M2ycWeHKrD3bpjgCKb3Fw2wFXcfrByuZJX4BPmJ8Tq/ndVOPs2pKTjeync8ozYKRpyc8VcVWMFXk3VJBWMerASoc2KeLGiUVBQZbCBWx9YHX6OdwlaZ1hqkMEUqaoNhr93cQ+APCYQmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898e2ab0-7059-460b-40aa-08d64e1aa5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 12:29:27.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



=20
> On Sun, Nov 11, 2018 at 02:32:08PM +0100, Christoph Hellwig wrote:
> > Move all actual functionality into helpers, just leaving the dispatch
> > in this function.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/bsg.c | 158 ++++++++++++++++++++++++----------------------------
> >  1 file changed, 72 insertions(+), 86 deletions(-)
> >
>=20
> Looks fine to me. Did ran the same small test-tool I ran against Jens'
> patches, nothing broke.
>=20
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Tested-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Avri Altman <avri.altman@wdc.com>

Tested the scsi pass-through (ufs-bsg) path - nothing is broken.=20
