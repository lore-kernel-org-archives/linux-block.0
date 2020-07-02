Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9387C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14DA20772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JgKuCacz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CmH0wo8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGBITT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:19:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38665 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBITS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593677988; x=1625213988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CikwZJW8VNHWx26znTojCb4ecI/4/i+10obxJCgnBCc=;
  b=JgKuCaczXG0puMTRjhetySiw5vW9zdVQgUWe+SLxW6tw/dTl8FWMu3Vu
   VNPZCaUbOVdMpksb2iP4LnfhK7sEcxqkp9EicTg9APkUqyp+5mXb/eIvj
   B6ZhdvvScycnAdMfbcaRHXRYeUdGGa2DkaleJWT6QNaqyakmUyd9gZBDc
   Q1Y/z37x5lfrJiIt/W8gVWneIBwUrleaFSinveL/XpJyAP5dq047F8rYa
   lxb4XqG/E153fzh1aIkonOKoAEDJtRY6d+1Z7/WxZ8MFfwSyAUnHPLkkq
   mtyZVrMzDTEKPpEGFTWTk/CEClEFtzCOoTm5kCdvdxroE2U56xUpwAzlc
   g==;
IronPort-SDR: L5OuPCC74wUpKqsqLpTx1Gaallfj3YEq3qJMos+WjQfDe9YGbolUw0Mymk/VeTQ+8NvGUQ2pMD
 mCw6sEuGELvi+PH3/J7DluUDWNmT5lqJJOTL8K2Dwi4TY+3XycNXqwnNl2hqsZKbO4gNLuipsi
 9UrqBXmRhRRMb2QXKXiVkX14LSxcNiSomgvmWvoMkrWH9jZA9w9GRbWeldaJnp23GmVH9kzanb
 y+/FqxsbRuv+tk1nwBnHobz68VBi92RdtTDBqYKOhF7JsSH9BeiHxwB7qx3yCV10aGWf8vA7CG
 fV8=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; 
   d="scan'208";a="244482742"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:19:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTRuQ3YR/t7FWK4zqdl9ydkNwxf56OcmvWFRzBwma8jXsv0Qc9G2fgypBj5k8WzQpct5NGy3C+TgMi0l+Dfvm9VBHYzpkQXFNc0mLXoizb0t+pywJjfcOErql5GWWH3+Ci3THS+XrRwj9HMpJk3MY37BqvJ2jYgdt9NE93bi4wrWZ9i6cJQ/rAOJxj2WprRzPEGlYW3lJr0/Ql+OcUWXOXjOHL83zJB8lmLHd2g16TPlN562sRrPUDwDBmA+TcwDzSteOYzYew7TnEpJY2u9hcJqZal6D6tB5LMF//nQkQv3jUyJX2IeoQMXwron1lBZ0Sxccd+HdlNPFk0xvJ644A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk3CfVYCoSItK4738Eb+t6Yu8KpCON9TBDucFRhKIgk=;
 b=al4RQhESB0mupiS9m5p55WiQ80fwaCCFhT6CaX+0vzOXKs9xfq8WFP+zXFurq2XB8jW8bWqdBSd04bGvux/CseYf0lpxNkKYA3vxnAlMUxd8iV/9xSbxuU5rGPFsYQbKMeNwlk4G481HfOImE9sjqpiBvy3SYlc+rQ7B89+ElzRrGetT+cJYnybDP6Qq5v2e621UwpDK5orBXrrE4K6LJH26MzQHn9n9lbi+NF47WvVkOkuIZ1fN2cIBihvdHFy6jXxQzv0HQJZ+X1W9ESujyj+ruZSNPWYp6cGJKMGmlVqIa+kHybpS+6SUwozlBylKCRC5SK5mzFcdADiBhX2SpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk3CfVYCoSItK4738Eb+t6Yu8KpCON9TBDucFRhKIgk=;
 b=CmH0wo8WOYnnxu8e3hJbcvZbCAfpckrMI4InNX4FJrF3cWiofe8RV88cE2YC2PSvgk9hsQZ4bGUd1f/gDB58iQXUTR96rZtyE2SVrUm3j8XJ2by/slhS+qcrDMMyTX4sL0C0FcB2JbnHlc5fWz7WauMvUQnFmoNWcZ4HPBeFF+Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2141.namprd04.prod.outlook.com
 (2603:10b6:804:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 08:19:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 08:19:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Index: AQHWUD291bkJAxiw9E2ZyLERtVBUMA==
Date:   Thu, 2 Jul 2020 08:19:15 +0000
Message-ID: <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:1941:c6e7:22b1:48aa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2830f7b-73d7-4813-6074-08d81e609c0a
x-ms-traffictypediagnostic: SN2PR04MB2141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2141819BFE9614BA8B3F634B9B6D0@SN2PR04MB2141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eh0QmfuhGs24p3kWtfGGe8tfovzZODbnSDLapaH66v+FNrtRDvwG+qNa4O8y+Xcnrm8VKqAz7drVElnnKSDaAIgnqUkh1Se+zAqIy3lk+hSzHmlUS1DISqLeRJ7SAzi5pb1ifp1GAZvysNwvGpNyBbvZQ3+E/dAIINAhasC2sYaf1UyTkfKIJeMcqhcBNYkJfZpDQaq9qmNMA1hjY5ZDvgnXQGd/m7y106J/X2lfZVRLjPXnW8jsGfxumg1HC0fOw2uBNU5idaCDCHvKb8qU8m2gglLZK1ax2c7Uw+x653uw70NsSFyBI5JAC2FwjAvn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(54906003)(52536014)(4326008)(7416002)(478600001)(91956017)(76116006)(33656002)(8936002)(8676002)(53546011)(186003)(316002)(6506007)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(110136005)(71200400001)(86362001)(7696005)(4744005)(55016002)(9686003)(66574015)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NPuqj1Myy6PABX48JKwqPEjUc5dqoiuslvw6b9MyFHLNDHnCchUi8VOb+wQXKHv+x+sRNHV8JeE4fCgw2i9fPA+wah/fH46yAUJfqPTULpna1KDZedvqnYUTHpFAJHoAPrqY5W/r9NMjwU03x6gunrol5lPFaT0UADy7SNTt5fHfE0l0K9RW5UHAFEuQalx0RQwRLLopReLQoCvlW2oEuT3iYJVR0o/N91E0ieYFcJ+AG/EocqAzQdKrZ5cDZLXEJ7yLplkyUpkEj+N3qVDnTSYU9zZvICS/rie02w69nV+NXQFu2teJQtfAR7pizeY23zzwfVlSYK1DiiBwh9L+jb7R58W1NE0SZSTjIsa1TZEOSgApqa1OyO166xBdGzTiQTd2aS6bagGJeIX0GbTdR3SrCqRybhm3d7czxFxvTFR3uVJiBhwOCgVNOPRJh9Tv9Tdeetcp6mD0bsNPNDcbnBYdNe2GasaouwQBbtOfziX25ir6mb2WyPATNNTrbiRK1Q/bhOAsH1Bx49DMOQE8quna3xR3G7O+zJu7XGmMwDQ3dCN6saOEFJ/gvdgDqNM2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2830f7b-73d7-4813-6074-08d81e609c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:19:15.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GwCsXUmSnQc0hsIHTDj3uJ+tkKcFimVTu8hOv0zNRtse71d6eT8gL/HgCX0iKy+ZD/AUhvw6weRRPM3A5nPc6nfSr7CzdwfzVC6XFUtyI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2141
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/07/2020 08:55, Javier Gonz=E1lez wrote:=0A=
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,=0A=
> -			  unsigned lbaf)=0A=
> +			  unsigned int lbaf, sector_t nsze)=0A=
>  {=0A=
>  //	struct nvme_effects_log *log =3D ns->head->effects;=0A=
>  	struct request_queue *q =3D disk->queue;=0A=
=0A=
=0A=
Please no C++ style comments and no commenting out of code in an official s=
ubmission.=0A=
