Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6FFC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 12:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383024AbiDUMFJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382953AbiDUMFE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 08:05:04 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146893152D
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650542527; x=1682078527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hbCUnpnn/TL8COyqTUk+h0JySzLBqmqiD2u3+uUHSLg=;
  b=cUdzgqSiP0WH09xgySwOPA+/OO2xo7fzvCvspxz73bZ5xbdUbpHt4wZ4
   nUYr+/hkTcoi9FXmoj/fIXPk7J6JI24QUQ+TzZNrXSeDavcz90ZWX44e3
   6pi/rcZwG8HR7ELBwlhc9e9K6EZyZfFzJQtP/GdvXYKgif7reGrGLnDa5
   N3ZdrynGF8zo+TtL/AaoP8dQ7blciSMLK4RQTKCQhdGvxn0Jpg4FxnF+O
   mzz7D3cUAgPq4mhECr/AZ8ysJd8sdtzrto23F7Q7Y2rhLgLdwszAOvOC2
   W0J5IabwBPB6LqRomKwR2IsS/qLQPCqRj99enosWalwL02WXWsAbxN27h
   A==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="310433377"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 20:02:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSZuQeAltEx8n/xJS3Fl5wIwHhDiP13GSfaVivW1LwmqYwWOoIUy23cpKEOkL7akd3cMLGhmo6MlNHivmbMMy+G/xXKI3R5IYSt0QOvgMvF9YMnk1bwyTGrCp9neArtCb3jrOu6pamLpUfbvtaMDrTXMSgtmRZD6qiI0EW98AAyJITzLV0SKee57n362FOgmHIYlPPkP18EqWzi5Y1qKc9HY28Xvp7laBxng2WabaeSvDFQ4PCWbI6Lr2fc30ZDMcP0vYAidqu4hreJr2UEYMFPwH4W1yTqT/55cWYvaCkEehdoEK8BVsTXVJgb/X5P/DabPmkoPnl4SHjO5D3JZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbCUnpnn/TL8COyqTUk+h0JySzLBqmqiD2u3+uUHSLg=;
 b=jlUg9k/uVxzYpYAENe1B8sjaNTxF++ML3hlbaLNa5E2B4kCOj95btaJFZoNBGM9Fet0bk6PX6QOgag7JfXCpgCoOFtrCWXWfDR4VXRl7DkqK4Fe06PAuntveoduyHinNRWNnYa1mFNLOD0omdGcuvrmJnCtfbCxGOnmp4cE+8PXbKT5c4ThNV9vGD5T4wDCJZBaS/2TSDcnwmkT4LwlHp3XubkdiR1+/Eg4mqRKt7aXw5rN6HANEko0CGPSD76YsSDf4ZW1LeF7Xv7UO6jiVdO+SJDOlL9RU1CjWzdKa95HwdMN3P+aElPgt/N+S1Z5gzJqq2aBIX16ihBInprp1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbCUnpnn/TL8COyqTUk+h0JySzLBqmqiD2u3+uUHSLg=;
 b=NIK4k6SjB3pQ+jTxDgIqdAIQEywpB87HvEfaOLyzSY+1QLBjMHHKk0sfswEI+j0E+dfRddvOUSsy9f2UDy2pusunNdGj9JlJGjbgEDwiPCwEvZxV19I6RXN3zqJqSum7HMQF1gBRJNLrhssSg8cyEapPq9DH4xG8Ypz4KpUOYHU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0911.namprd04.prod.outlook.com (2603:10b6:301:40::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 21 Apr 2022 12:02:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 12:02:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Thread-Topic: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Thread-Index: AQHYVVqujt2TU/FsjEiJPXoSf28DR6z6RISA
Date:   Thu, 21 Apr 2022 12:02:04 +0000
Message-ID: <20220421120203.kkjni3nbzjnkqqql@shindev>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
In-Reply-To: <20220421083431.2917311-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85772195-c9bd-4738-f947-08da238ec038
x-ms-traffictypediagnostic: MWHPR04MB0911:EE_
x-microsoft-antispam-prvs: <MWHPR04MB09113A00EA35D11D51FA2249EDF49@MWHPR04MB0911.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Na2fjoWdPjIWTSNx20HYrF/7KPWcnrI/dGuqckmq2nXjDChi1gVfzJSymw+R+LHCLPrbp7t5NuV27f1IovrZykfrmhtgJZI4Z4rnDcvIYZnVQW1N+0ruoAqw2wdnccY2WkFkKDQPv7zXLs/qZDwEg5GCM0Sdar85VzBGRut0mFIYfWfbQr64qcpV1mV4XW5xbUCfCfV4oZsq+5qb2myunCOy3sIWODHzot7auV423HcnBzQQtsO0dUUKEDAd4jDoKlYrNCSN4rKtFoEFjhkk87vVgopBsb+cUO2r843jUya6Bo9OelnbQzCTTEyuyjRduSzaiao4pKh4bdFgk4zU/og0LZ3NwaqosKPmejZKiLSSCbg4Uati49HIRy5dZWOa+a4+30tOmF3ukG54BFK8yMg09iNm4DoMlA4sWiOO0nj6hZ5NRly65ulZ6fT+RXdFVguAoEHhye/NA3fWFGer8T62qoVlHZc5Yl67eCmTwLquZxKDRj2mo4euqW4goDJhq+xsNghbPXhUTEBHXxP1hUgL1tGmltFMR1/XAz+l51Fkzy6R8Hha1nt9h6eITA5RDwI0kQyZW71RXuPsylfSpL+xka24kIbhRRgd6H19JSnVKWcAn3D14lKzx8SdG5e4SaFWEDkCFT1gMROAfu+FG5AnIdGIj414Qr2ocDj2Xu+2FtSoPhcyO+uHWdhP1TiEQ/2zl/1YsMJg8ToLh3tbYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(6486002)(5660300002)(508600001)(8936002)(2906002)(44832011)(4744005)(71200400001)(316002)(6916009)(54906003)(76116006)(91956017)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(186003)(83380400001)(6506007)(1076003)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gb+JkDctLPtRg0yKRYgbRLGUTTxSRAhTWSCc8MO7XaxCfCTdDXboErAnJfls?=
 =?us-ascii?Q?xmIMuFM/cm79nFJdnBo1BMOYKxuPaLYjZnt/RNjg2mCHN4jTwSLMBxH18nGx?=
 =?us-ascii?Q?FUYsotxaBUK0LOL5hAFAuDgeOwVYHVnoyBjKD7ycmdiCjCSHkBB6ZyrH9fO2?=
 =?us-ascii?Q?Ttq0l5Yfek7JpIXmsOh/amCr+PyWpINz4L7jcrW9Ic7ADHql2GJQ/5uSH69G?=
 =?us-ascii?Q?hQLYSV+ugaj7UauAL9SPCx9TPITctQGaDxVM977GEnnUSZRzyvgw7UhFfckg?=
 =?us-ascii?Q?xVfCWuSvzfY62cietDEcNHI9Qa6517pdvPCbXg5azhU9m2Lv4jE+VvIwIFl8?=
 =?us-ascii?Q?UNTSwdKVPoBvWp66/VPWiZ4Mdz1fjZQL3OwIiA3zZW0VyGRNK1Fq4eOdM7SI?=
 =?us-ascii?Q?T/tYmjE+zQ2BkuQSk9taruP5rRjRBKBUTLQrYTQBDRkyMaKtS78qdbqbtDqw?=
 =?us-ascii?Q?fFs2HcZfUVjLsJLvLAh0qvd6BdQg6hYktZB/Pvmj/C73C1omV/arSxSwR2oh?=
 =?us-ascii?Q?i5J55lSisSe7Q76NpSNSIiRW6njJ4h6d58sZIMmmEauvfOr0VW46n1Le2u55?=
 =?us-ascii?Q?aVOa+0v5U7d1iAoG93xDYEtFZ6AChtRqMHZEXMZuzxalvahzoQ6gYZAgQuss?=
 =?us-ascii?Q?6Y4aDbIBBWB50C0ILgXI7TeiuOUWUXj79LAKcUcyL7gVU+dM5ib02RLD+JZ+?=
 =?us-ascii?Q?tECoUhLlK1kgkSGqbZM36RUMkc5XojS5fAsZ0A7H/oMHyqZ2Uqi0WiLGssuN?=
 =?us-ascii?Q?p8EXtF0MioKkuAf92BynpYpPuP//5+YgbdCZa0afV2UUcl7D3Mtw/dTiWw/3?=
 =?us-ascii?Q?DeVO8WLJ/xS/k9be8Zv+JFxWjFdzMreGej0XZc5bwGt9us41y+lg4KzGcZzD?=
 =?us-ascii?Q?fLNYfpwWevJx+7QlQB1KD3HMUwsFut5cpn5uTxZwsThNSiwN5RaYpjaXnEzv?=
 =?us-ascii?Q?AJL79cs4od9vmWzVqxTOJN4nwcTlDFnx0qwztG9OqZqoYx9LLKzHmZEGdFZ+?=
 =?us-ascii?Q?xTmYrWsbZj6jl3cBz9bch+eKzhgELRITq2xirK/afBk+Wx1IGaM3XE91SKEw?=
 =?us-ascii?Q?TwJHo/NmJSnU775C4TW/DJK9tm2bVdTAKpXnwbF1t0qDz18z+3IurMoufFuL?=
 =?us-ascii?Q?vDa2JhjPkxzDd3Z6SwkUrmzWG1x4c35ca7OeWvZrQ9cggT3/N+ODDvFAU+O8?=
 =?us-ascii?Q?fmTPXGTGQ9Zah9EUQqso956m3UV5bjGnsdgA/b5Io/vPJ4YyCIf2d1ddHHwS?=
 =?us-ascii?Q?vHIZpZEf2RwX7VhZn9i/mzamfuozqlBQ+ptGsXnTogs9YZ5uUMHyDM19h3o4?=
 =?us-ascii?Q?Gjkc8q1OUg8uhqzucc3UzBf+LSeGwE6BVkyWGgmqIQ0KB3BBkfOnN7n+KNJi?=
 =?us-ascii?Q?4ng7LK2NAUu65SyGuRY42enn5shad+KZK+RjRCCFHoNISYOtpyeDOuBRMAXH?=
 =?us-ascii?Q?Bl0gCmGp26jKc6zHbanPaggSCM9ss3sF1UKyOKWTx6Fxb/k8tRSMS4pZofzn?=
 =?us-ascii?Q?GhM7xv7fN288mlku3GMibk5KnaYT4mUFTtqv8z0wUax4MancZ97soyRmRY6q?=
 =?us-ascii?Q?JIZG7hCgS0sQES5f+HkyRVonmckSrwAUQQDfWdEOIBmwX164b+GTTPPJNesU?=
 =?us-ascii?Q?smxEJ7VzqYTsMmarUd6neWOPqEb3ezRyrjXNk4eOp9jTlKTpmGUcLAxADYnC?=
 =?us-ascii?Q?AJbqinpce0t73ii6rgTzyqPN6tDZ3aPjS8s1+/2zcRqmA3sNojE8eahGpVFM?=
 =?us-ascii?Q?94iD6QDGa7IEduasZqIX4nmFwtZ+cJEVzmSDuR9GrP0EgvIHiOsb?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5A22EEA6EBC4C46AC05717AF061A253@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85772195-c9bd-4738-f947-08da238ec038
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 12:02:04.3009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODtP1oQquHmYd4S7vopQMCgRt8Y9vCOo7tkZK7OHQmT6Ix/LiHzU9T13JJDA9+ELtyu44JbUhbzS2ZdmNMRu4RdN1rKo034/pMydv2KRJNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0911
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 21, 2022 / 16:34, Ming Lei wrote:
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
>=20
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
>=20
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release(=
).
>=20
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Cc: yukuai (C) <yukuai3@huawei.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Thank you Ming, I confirmed that blktests block group all passes with this
patch, including the block/002 test case.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
