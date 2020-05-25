Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9E8C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529E92073B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 09:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kmn9Dpyb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lCpbpTrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgEYJsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 05:48:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8359 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389374AbgEYJsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 05:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590400125; x=1621936125;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Kmn9Dpybl0cre8N8wDH8MoGn5ZpUG/Al1Z/9NlqivPpACQ4Jj+q2Y0/P
   cDlIvXcXWChO0chatO3Og3FBt2os4RE3HfyR8eQXL6Ty20vHmsGuqYqva
   dyOT46gkrgpoA3mF3bXwvPwisnzOwsXJLwpL+cvhxfKzrma6B5MvOGlBW
   DYk7UME2HhLnuegKPJdvZnMz1MwVMIOIVDCwwdZ1ucem/RusDKzhccHSD
   OuQutf+hM1/8zXqMRR8IAmkcBwI/geYTuKwFSUpBJYMOEjycNKQlpfEGx
   nHUaUqAFR9PUM/Ucc0SqhpX/uQTu5ZGLy634owD3UaF1FcRsxH9NUXZPv
   g==;
IronPort-SDR: +nhMSWte6TZ3/aIWVJ9d1rkuxRBU2C0MYM17+gN5uLyZBXrdGAsjZ13LOYuKVNu5zvxvVZGQt0
 7uKD4iKW7mDxXC2L3hJPliKK9fHT/PVNVRI4kfbWJO/mTzksjchoDTzvpGSHqVgd+bUktdHBtF
 IbnDLF/AyZf+kvyfEYZGozeChwk9gFK8H9p3HNMpDQwAU6TCWV+eNaVCGyuu1PBCNUKL1Xsjub
 EbOaDkYH64EHHnuwE1yQaLy/342WqRaVh6sTnhkccnWm9ioYdqaaYe/Rj8zTqD7dSaZls9IBhH
 Zl4=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="142782580"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 17:48:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9kiZDE3UzUoYJ44dNgst5cNH52/5taOfKh3O6fnLsMsoSrFngeMtAPX6sNIlEjhBqwJIjxbdPpvzCgBdTs0cZE8IO7Dwdo2W1+m4nZhsCnL/HQR2bZwoc9EErE68HPewugAUbL3wuI2VO6YlwrVCjYDCGztvzoWuovBrG3pamzogTTjDZEG/DR53KiHifXRrHHjZbCm9Yl53LfWmTr8EdNqK5iqE4EfEF1wx58nGGQwzD33WB3NpccnfFegx8qwFUnb8VoYuQfbqtkI1NSGVbUDAytOJl9FrNWfmN5LuCayO87yAwXznPE+aAOrz0RUSfdqRjPqDnYIxSJ7i8yHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=d7MEFzZ0o8sb8YbP815eI9JGmdJ4KeEjrRgla234Kd1bnHxrQCaPcd6hwPjlCiB5PSYs6tYqvDGKfahmOCsyDp2WEc1s7Fwoe8Kq3B0ps5y4ZyvPxR2Lc3c56wlEgARIFn5TnNTeHr6QWSjJSwnNO2t5fGTCn8mJbc8c43fkW+sc8hLmeEaYgmPVau6unzyE7AS9cxMoXSIaHqNkVsK/eY7IbVVQCpfiQ2sMtZzr95YrkH3boqHnljRrt6nT03DRNn9God9n/sBfiy3GPmCMcYIw1ZC2FOfisDiYLgXxoFLfIEb/sHUYUZrBkFAkeYq2MiRiF4+jJQyJjXQlQEIYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lCpbpTrhcrXISx/37xcMg2gSXs3Pfh548vj8I7NEwC14wVlemobSL9/kS5tT5HkHVcmNzPim5XMlMsnpGWmf0jFaaUmwFYSk10x6wEoSjf/WACtM/AXT6PujogLgsjEW8Qgix/0f8biucVbW5FwWHiEiXmP9FTY3D56cPRSwY90=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3653.namprd04.prod.outlook.com (2603:10b6:4:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 09:48:42 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3021.026; Mon, 25 May 2020
 09:48:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2 3/6] blk-mq: move getting driver tag and bugget into
 one helper
Thread-Topic: [PATCH V2 3/6] blk-mq: move getting driver tag and bugget into
 one helper
Thread-Index: AQHWMnhM6EECYxSVnE6POAFE3/kTag==
Date:   Mon, 25 May 2020 09:48:42 +0000
Message-ID: <DM5PR0401MB359159ED59A0ED68BDF58A229BB30@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-4-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98ababc0-8e52-4c8d-872a-08d80090cf71
x-ms-traffictypediagnostic: DM5PR0401MB3653:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM5PR0401MB3653DD52C6DDEE21CD7A926F9BB30@DM5PR0401MB3653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7e+W1HDeBtdewMG/jNT+/HEIAAEEkxvcy4eytZKULduoXsm7O+gL/XP83Y0JYKGjOfxsG3IKkIkTlYZZblHv2MkWkmx962cpNomrXRIi9mwK5hbvDSneqUNHbImFaYrK3jfWMgWj9CgknSrBe5+WBc1wAGigBRsN/Y0kcRYwU4M9S6X3enB8rdy06AYkXGeFeA6si+FsZTnrRvIMpCBaLKMhmBdJ1GIGdnUuENg2QIoEmwPZ0XI1Myab6HMJ+0u90Pxu43rBsZS17tnUZab8ckrUV5puB7J8EfDMk+T5o42GnaE5av1zjSGAPIeX3hx11H3rc0h+evUlHaDtFU4hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(110136005)(5660300002)(2906002)(66446008)(54906003)(6506007)(4270600006)(9686003)(26005)(558084003)(8936002)(186003)(52536014)(478600001)(8676002)(7696005)(4326008)(33656002)(66476007)(76116006)(91956017)(66946007)(66556008)(64756008)(55016002)(19618925003)(316002)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oi/4DuRH5ThZwNZ20hgoVYKXWQz2aHzlZnUw+LrpEpz7leLPNgf1LHTe6lmqpaEwp5sxah6A6mMHBmwA7LFnKmG3oLdxhsdld5+eWUQx7S2TSDqzWORCg371wYXbtGoCQ2cpRSfq2uqYk3+JLnb54RsP3scuRuR3gAlDC4FZVOJS+n/uStBwUnrsDARF2tRosQUWxf0F5unUGVOX9RuNEYEcDQJJA3SEzqaJgr131AUMVDcqPlJl34qUI8Zu3JAk8YYVBj+zS+ICOdIAqtTel/Dgjicwi83XlbH28G7VFW+qBPegrAC1lIMAz7GJ/iwXWteK7mEcDt8fzAjymTbRswaLv+v50NGbazlS155mSgDf0GwBkWAsozFd/8BPDzgDDn8UhjxoRic9ZuSgrw1Cu3VQn7JXA0Squsmegd+Nu2IxFfmLhg1XW2+WTB0iTLIgpA65tDWA+yuRncksQ5prFvDxjv3gr82yef7SParNAI8pHRdYyZDcPrC+vakKWB2+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ababc0-8e52-4c8d-872a-08d80090cf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 09:48:42.7500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9J37+6tPXAzI0daZm+irbnkk77Dnj7Plt/9m8olY1P+nyQQUgO0t8iBUhfMQAh2UNlaRgiT+fiWuL4B5B0EY9RPEGLvalau9z5yGfa/nLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3653
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
