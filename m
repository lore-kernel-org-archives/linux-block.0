Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000EC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9724207F5
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 09:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DhgTYa60";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jquiwqqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbgE1Ju4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 05:50:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11453 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbgE1Juz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 05:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590659457; x=1622195457;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DhgTYa60XzV0ptHF5IyDkmP4QGd80twzrCAbH1RkefDJ64BsGqXKCqcZ
   cHCFn3bepUZrU0uw8AJ0WNaqxxRgztHDp6NH7aWyzxXJ2ikTsJwCR/tNF
   gEne846MhoaWbTeHovnwSJZlq8VL+6tHijBSyYUk8lHk0D+pT/1lUeA8D
   Zj2otTVmrrWCHcmx2vZi2jNdkzyiP0ppOCFJ0juCg1Xxndb/IVwx0DORv
   zM6xojI5dr/44KBnsfkYjtuQL5knqmanxiZOxTQL7gAn/ercuRo/fPOXL
   dhVB+xuLDNgKr8YgK5/PH/IXxaBpWnlWOgKSUcv2a4oJ8mm7HnBCsf7kw
   Q==;
IronPort-SDR: rtlQCN+EGlc+FalAvAfoZSrhw7CCjqp8aRBD40QCmoGsWhc/SAqE04fg1UlYRHS22Kw3DC3ZAF
 i1M/pd6U3K+wD+QtTuDwS/BD8AlLJUEN3jOl+g3f8HZr+3NKmuTl7ep4VTs3GhW6zNkJMDz6FB
 deGNtPQrGeG6Hd60Q2u6FwYNUoy3z0/Ly4mTAGqWQ1QuCf5JcaLoyola+dWbPhFk7fmXGJZsdw
 f5RVcroy0PxsaK774EfENaBGy828tgc3feuyZN3+g0Y20lVcyA9kO12N6JO7MPbawZnTuL+Qni
 hmo=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; 
   d="scan'208";a="143024486"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 17:50:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuQd+9nLKgPG+S37lmooct8w/wV1NRv3/mJBjLi8JftIUGp71cdXi34Moj4Bvn7WiZWtn7ndHKxzvfjDT39t9lsjRX1fOksIKK5p3c02l3BpMW0L8mLrIS/lO5EpVdWxl29cxYHbPuWYIfsYest+b73dNq9FHbiT5Y0VfIksIU1DVUW6BYEf0EtzBtPHO2LdW8EHx2vFMKlMkWlspGUIoNQ8LCbdYN+Jsfr+QBZDQJ4ag0YnbeXrmJK0stJUPuZUXeZQTwXVNFFfZZq86wfGJIMrPq40mpgCKI7ULAuSoOfyCQQBFbeR9ofl+VdYHOpLXt55dF5Wf/yaps8sZkD2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VvG33s6jBIn4BJ8SKkybPayPi4kp7B2W0wKh2Qdg/39OAkgwqEpTSfAibYSWlDseKf9AXrIQollq3a3hqBlxK/CLfp5fbs0NPPMiNksw1ThgwAOBRXAFQXrlnT4tyxe24pwqLtSkvm3wQLAM5omPnaaUp3Yxhx9/WKke3i5m9EOqBvuS3rjQf9h9mLoMJMfqoPS1zaWxR+ftb9DYEyN9aYnO75mMaT/8/VKWW8JZO3SIq5Hb4nDCRiZ3EpGwkHsAVXAu1rrB1hzhDwIec4cpKaVTG4ZUFamRfO9TT06MNijJXSrlV9M9P3UHpb9w5JYCk4KnTk7qNLMNwWw/HB712A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jquiwqqU1YkDDavqjHoVL5MJf9LYGeD5da02GygaTI6MrerfL4vGCXab3Qp4bYvP/93GJyM1JOi5ZU/ws8ay4lQ79nMsltLjmtMk8I/VBR5OKS1690I5tbTBBJQ0ruie5vowYp/tcp17xtOV9o2GTGuvvfJqFRlCN1VKevvXKX8=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3671.namprd04.prod.outlook.com (2603:10b6:4:7e::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Thu, 28 May
 2020 09:50:47 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3021.026; Thu, 28 May 2020
 09:50:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/8] blk-mq: move more request initialization to
 blk_mq_rq_ctx_init
Thread-Topic: [PATCH 3/8] blk-mq: move more request initialization to
 blk_mq_rq_ctx_init
Thread-Index: AQHWNFGevZ8mhuLO4UKdzudOMW4hiw==
Date:   Thu, 28 May 2020 09:50:47 +0000
Message-ID: <DM5PR0401MB3591412DD472D2E93233FF059B8E0@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8c6845c-b20f-4990-9645-08d802ec98ec
x-ms-traffictypediagnostic: DM5PR0401MB3671:
x-microsoft-antispam-prvs: <DM5PR0401MB3671717C82D64606DC7BAB379B8E0@DM5PR0401MB3671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7lJmT5ZpuLrzNFY6Q7plzG73UFXO1d83ulG8X93uVC7OOLzEIQacc3u4hhnDhkxvVchnbnl2BQ3qRyVxGJUWQFwFXGvGJk8yAi2W4Un2SzOiPdcC/Qi0J3t6fFU7Nh1eagyIEGgNbDFkjvgX1mpRKzObe+qf9JdOvKF5zf9pRdnWXMPPbUGyJDJR69RTaF3AicyGnUUHDj2DrYxOtSQD19XlAbi/9N8rFLsVxTJpeyGEdEPxQhO0gPlJacXu8HRimH1qItm4YLnoQif4zmVqpRLNYBy3eMQk6cLuPrBVzY/mT5hGMhvAoi7+Iw6fC1qavkfHF1J83h4K0nz+ZQaKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(186003)(8936002)(316002)(26005)(76116006)(6506007)(7696005)(55016002)(5660300002)(9686003)(86362001)(64756008)(91956017)(4326008)(66556008)(66946007)(66446008)(66476007)(2906002)(4270600006)(54906003)(33656002)(558084003)(52536014)(478600001)(71200400001)(19618925003)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a3IBaExCnLrpQI3LXX9ORljKvnuPUTOHQYJRsPugZaLkKO5XRfrh6oHW4XkcEd9SlGDfn8A2cjG/WqsFNHR50uS5IuMouwVeuJT+wQm7qo8OrD/set6G3//Jn5ZZIQcqm7c2SXF1XILnWyXkuEQCNcvX+gbBESlBelDn27xCrv0c95zrfP1J+he5E1uwIitjFTz0KUFbieApZ3vaVIbwYzjEdcRdDRB4iO1VKtztvbWYuiD9qYfsoQV7OkX99+ErBoMQiRPqF8w3l9g7aHpJ/1+ihoiIQEHsmcwT5AqUMIUnxaaSmKmg1mihTLORIk3gmg1xHSaTxHknXRUfZySVgGfD1SXQgVMsP4bATR2usRH9l3UTFfO9qj8WYblmXXvHcsvHVEMiyFFIxIy6MdBLKK7uU2Po8Cx8eT+abhXNWpQbKal2b2oGA29Hvq4FxtKRzXkhVAam5oXpVHRpfIwkUTBPdzQa6FQkavIs2ddx42InjKHSjX9TrgqPAn5516zh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c6845c-b20f-4990-9645-08d802ec98ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 09:50:47.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQScq0glIzATsmPh3HhL23gVNk+4B6aIN918jqwwj24Hijc+F49Ri/OEUCqS7ich6KaQbyyjZfFrODNHACrP08QgRSskwZwJ0B7fhBqVA54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3671
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
