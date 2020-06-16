Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DCC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F0520882
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CLg0sfUW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nKcGsQfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgFPRGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:06:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52145 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPRGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 13:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592327170; x=1623863170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HqabQkYrzzZtIQTIaZomSjqYN3blCKK3v7FJzbfw68o=;
  b=CLg0sfUWTqeoQ4tcpGfRLx/w6yjjQnWbnI6rbclLV+zGPf0ngxuq/trg
   ci7ocomoQWFrYWrFLaJAxUtgy+SiQQ9SbWxDUB6RF9f5BFSSxFVDAKMlk
   zrWrtBuLooNmRgqvBZ84z336sDdbpnrohE10MMX943OfIA/FkoXRPfy2b
   wf8jSL7t+lw95ttr+/74SR4ViF0oQ91Z5UVMRTzxqeF2er0eldarY+zk9
   7QnbFknZHPfSJBqkgYtDAbvPJ0jdN++/JH7CvSECoZLmtA082PV/wj8EC
   r6am1rhxb18wQBnVjazoeQLP5rwToEokZlKVRU8IYgIKgTqZRp2saG0tX
   Q==;
IronPort-SDR: ssacxNvF2XmHQO8mjdxfMQ5TpMyTsWhUsj93jzuTGGLHYxTBZRf0Z0ckPQPDdKoko7RaN5uZch
 s8PookmKwisouMHpsrV6hxzpfc0Y0E6uFRhtFeTc6RU29Wr/IR1ylzT5s7Gk0FdsFUaWUXACZo
 q94FDiCPIzWlIOa/a0BIgG+Nv/Xsiw0rWO44840A9KWrKodI2WJg0jd5MqyMl2v6YrjEWXXO9f
 n/FhYB0vyT92ZDHTCFX27jBFBZyXdUKwUq79YdqMF9ECmp1kBev+V2Nllk7NqP5vy7kBguBIKq
 IMI=
X-IronPort-AV: E=Sophos;i="5.73,518,1583164800"; 
   d="scan'208";a="140147344"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 01:06:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMiBC3YHHKWtBNVuP5myZ142X+WNhtLgOgy78w+7jBpNI+WHesj2SkVONcuwmq9OJBF+bpqThpI+9A7JxAydoVfxCp4qFY/989kIAzuOXqt46A5jrrRiW//D+df3PDg2gNZ3O7iJlhwITb68D4PdDlwGDHAdzuxFjf3xRFLTmRcs71s3s0+vvhZ6kQZtITxgyeTJYVv+40giBWgmAQym5lYnFAaHn/tdWl895IwIlQX2ZilV71IEmrIv0AfxFEHG4m6eMcOWhcnrFzuQtlrCQDTRcMVrGRlr/O+nbQlh7KDK0uPpl9rPPZKh0WpfnV2mLfcFZSZvpmFvu88kUroztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCEZHFkKc4Rh/vKDGrhDXAsYH+Uy/eEvDfZHpMCBvu8=;
 b=jN4yzhgrAs1MOilB1Jui0Kql0B/1kD42qMPXZN19oauHwXjGMTiwsCDavgh7iNpWHqIuFCAqpo7kILbE2Pw9wDuoy1hPzKmcoEzAT5EunI+AsOv1V3JRyk5agyktO7mj6RvcVjngl1FzT1Yb0M3rGT/I6SK1Xa7rKDP4VHaQVCLryr7GkXKoheBXddPQqu0s8K2O3TN+hiZcNwhpFwBTW7R4cWClFV6i5iPdGDq5XNeJYYQBB8jM2AARgv1xVrNWBqs2Ywjv7afU0+k1ZRTP94d4LWm5nGDDwyEvd0hM9VY0CygED1tT/bVjC3G0Ni98J7tYMFm5muhhUhKTwHDkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCEZHFkKc4Rh/vKDGrhDXAsYH+Uy/eEvDfZHpMCBvu8=;
 b=nKcGsQfrR8Ejzl+fPdV67PompreMGSaohvOutQJz0fUKTmXldqCkSKND4dc6Ozmh1QoAMijIpO+cFjEpXnv+JNRIg38QEfVX0enC6EhNQBo65f/9CanqVAnWNzPmMaPbR3sbwKhLFSFC14swZE2F0yeA+TsA7Ye9rYkC28iCKRc=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4998.namprd04.prod.outlook.com (2603:10b6:a03:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 17:06:08 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:06:08 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Topic: [PATCH 3/5] nvme: implement I/O Command Sets Command Set support
Thread-Index: AQHWQ22jQiOvuxhpcESNmwORkrTj76jbZ1M0gAASq4A=
Date:   Tue, 16 Jun 2020 17:06:08 +0000
Message-ID: <20200616170607.GA507534@localhost.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-4-keith.busch@wdc.com>
 <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1ftavm29u.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30027361-8cdb-4456-38b8-08d812179038
x-ms-traffictypediagnostic: BYAPR04MB4998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49982A7CE0757B4D930EBB97F29D0@BYAPR04MB4998.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9XG7TRk/9PsDKDAMjCFpP1ZSh9pnzTynlQGujk3pEt1ze4LcacbYErux4nL+NZ6ry1voYW/wPJ8fdjS+FsDdfB8aIJxs1uWXFRIRLS5/Xi4Fq+81MfwgbeASronQxr8scUz+fiSxNneMG+62egQnHANjp90I8quCCS/80+xtY/cT9/PCCGGBLyYlc2XKA28I/GqPGR21hVvTtJXHbiHoS16Ugsd1KD+YSY8nLZEngChS80+tvCMPUQBwxBwh4wEJxehTUEVikXtWrpyelX9zwalDcoJy5zkkweKqBOhOqQhvxth/lqDKLSTQ8qDzyXRv0P0YuptcLqucnDyoeCD4KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(5660300002)(76116006)(91956017)(6512007)(4326008)(478600001)(64756008)(66556008)(66446008)(83380400001)(66476007)(66946007)(9686003)(1076003)(86362001)(26005)(71200400001)(2906002)(186003)(6486002)(6916009)(33656002)(6506007)(316002)(54906003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rJbEZyL1qypqOKX6c8IoSHZk9BpQJPB3c/vUZBUW02Q8OutHYl9rRYf0gcnMVSw/GEkwXVdyNzhC1harWL6+W6aHrT8WAaytUGBjAlakv6e4DIYeJyZKSQxZo7pF0t90Kfq9m3kQxMGYF7dh6c1DHARTXQhebTtEW8fPG6Z8+dRMbJaavLHVx01MmReXgYSc9CoIJL+r1OyeWgiD9fGvMzKR9oPbFM984sm6j4oGpwWCUEN26ekVIuY1ZgEENAj0bzZR2bV+47GFhldBh/t+E5e59N8HaeowOMmve81qsMSYkhEnIAUzXVwPWG1jn9YPxelUzb89A2KYlVFQZFMa++AiyAIS2tZfeBkgDkrM8cRI3wpdVVqm0reoWttPisvs3SvEk5j/va235UQsFeR9B3zuy/qCX0RNVDsFOwkc3RE226ffK5/L86peLYxOfZJeRf8gCo0LywztoabhsXUvDWDFuMqXVkfMzhB8QUjh0msn4ny+9TckJ41ZwUziSIdy
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F27FFC0FFB7B448BCA8E87D4382F52C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30027361-8cdb-4456-38b8-08d812179038
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 17:06:08.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRdvam7+EJLkRkWl1icILkf+4/YDmD/XXxzOJWZEGsVqapN3+KKZiCgBxxgHH/HSbKSlPBK6Za9VB70Hx3Lgsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4998
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 11:58:59AM -0400, Martin K. Petersen wrote:
>=20
> Keith,
>=20
> > @@ -1113,8 +1126,9 @@ static int nvme_identify_ns_descs(struct nvme_ctr=
l *ctrl, unsigned nsid,
> >  	status =3D nvme_submit_sync_cmd(ctrl->admin_q, &c, data,
> >  				      NVME_IDENTIFY_DATA_SIZE);
> >  	if (status) {
> > -		dev_warn(ctrl->device,
> > -			"Identify Descriptors failed (%d)\n", status);
> > +		if (ctrl->vs >=3D NVME_VS(1, 3, 0))
> > +			dev_warn(ctrl->device,
> > +				"Identify Descriptors failed (%d)\n", status);
>=20
> Not a biggie but maybe this should be a separate patch?

This function, nvme_identify_ns_descs(), was previously only
called if (ctrl->vs >=3D NVME_VS(1, 3, 0)).

Now it's called if (ctrl->vs >=3D NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))

Because, if someone implements/enables multiple command sets feature
on an older base spec of NVMe, we still want to support/allow that.

(Although they would also need to implement the Namespace Identification
Descriptor list command.)

So I think that this change belongs in the this patch,
consider that this check wasn't needed before this patch.

>=20
> > @@ -1808,7 +1828,8 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids =
*a, struct nvme_ns_ids *b)
> >  {
> >  	return uuid_equal(&a->uuid, &b->uuid) &&
> >  		memcmp(&a->nguid, &b->nguid, sizeof(a->nguid)) =3D=3D 0 &&
> > -		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0;
> > +		memcmp(&a->eui64, &b->eui64, sizeof(a->eui64)) =3D=3D 0 &&
> > +		a->csi =3D=3D b->csi;
> >  }
>=20
> No objection to defensive programming. But wouldn't this be a broken
> device?

When you format a namespace, you specify a NSID, and a Command Set
Identifier (CSI), to say which is the main Command Set for this
namespace.

Someone could send NVMe format commands directly to the drive, using
e.g. nvme-cli to format a specific NSID, using a different CSI than
that NSID previously used.

In that case, the same NSID will now have another main CSI
associated, so it probably makes sense for revalidate disk to
detect that it is no longer the same disk.


Kind regards,
Niklas=
