Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC7FC6196
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 22:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0FB20865
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 22:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hbO9LySd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AwFJscnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfKHWSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:18:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52717 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 17:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573251518; x=1604787518;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dRY9WmJIfKZ++b40hanDOcYBsXrzvGKmtBPtFkbk3Ao=;
  b=hbO9LySdUU+m31sV3QQaBzYmU0r/fznvTWzHoWuEiaAH11YRSLYytlOn
   luxeJM9QbUnEQZ18tGZa0sVX+7Lzqy/wOfqO+FuBkHsDHH+k1ygXWhpXf
   o32XqoPiWHuzyADvMMRWAYI4TyKqeX+DnQphSF0H9GQRPYBmMZVyj0znA
   veMSPbZi4mQ+gwJXjh4kGobMxWIk+HKBtiY1ssx0PjUXDA5RvEXsk0zhD
   9nWuDnvyQJhqB+SiifAin0xRP0hrncwrAAeCYzUttGjfTg6RIsHcvQjYn
   nYa+tcf8b6tIn4SesO7JqgFaHHB4AmNTTO10Cs7GrggDaURF+4Ekh0Mn+
   Q==;
IronPort-SDR: JAw3lDbWt5/PmdxPmZJmSJEkAq26+Em1H90jZuoEevFzOQ/ODaqshQJfa/GcXgDZq/g7hXn6Gp
 r4UpKC8lJTc7XEWSgMDFk5LnVyxyM36YvwDbCr0N3cZ2Dxe4UroV+UpGXh4VRM0HAJnPKPRUIw
 Lbjf7SptHKHFnWwlCvT8X0v59vJ6Sfgam8xMbtVEfKOhoEl3D+daWYs/RP0BT4geEzqil8GLo1
 fnis0+fmf4XHmKBJMDzjH3ege2JJXHqzP2rkZsFAi0+XDOQQqTuk+/PjxdL0wJ4E+IqCQ+w4Tb
 sPg=
X-IronPort-AV: E=Sophos;i="5.68,283,1569254400"; 
   d="scan'208";a="122537398"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2019 06:18:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEFXUfOMWyVoRlGRSSwwMapwFbfrWYkyK+nfqkC1/0rVbIof314t+s/0AnryWznyQJzR5bVnUg8ifOqc2MWsYHrUJJlcjZj15LTEDuIrUnYBjEVziWT5w45Hq41ik7udg8T9v5IPRCqBNBTU+NmDqNM9G9R+1ubQzELys7WQtdrza2ZUJbDje5fIKDWV1rUN148iFbzW5QDAcuyHBlom1NJoV9KLLSkxDxHAQvNc+mwbk9W4aOTaPhUIAgx2IggFmdB//gba3sqzouzLGqv/SIXnIBzHggc0TnyDaYrSfksK3fxdp2VB2wP410VED6Y1lJXdww/s/4gjCk/Sqk1mKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRY9WmJIfKZ++b40hanDOcYBsXrzvGKmtBPtFkbk3Ao=;
 b=QN1xg18vTuuLb8nm7XUCCFti6k+rM02Y5D7z3TjfQ7KasF2ZI1hPZdDoVZcgdqDvYuicIUsCNIVoUzrIBIfCDcpB+NLVMmyv395FRtBhkoul4ROs8nQaJeWM3YtDyG/08jxwMg9b5X6mgu1rKK68dCvj+zFfrNvrqK/SrPgYZc8AEVU28/LsAvXRB8V2wckmeFRlMOHyWi753gOOHlP2B55bjXVzT6bNTxdaEKzqsAAemcLrcQ7uD4hx5ut27I9yzgXD6g6cZvP8WQqG5xqInxXo+DvLm/H+2f49cRAd9EfAnK57XLW8NdQ5ucFTHO8DlTn9SU0DE0PGjoG2pY7JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRY9WmJIfKZ++b40hanDOcYBsXrzvGKmtBPtFkbk3Ao=;
 b=AwFJscnftUKCGMc6Zqgb7J1eLyWs5l3dDm21QC7qXxJ2TzqZMEqurUteh8XKs2prZnrPXscDPOD9cbkV893Q8gHn7+fb1iBxii5v6cmtBunPUofRcCE3n0oY+bEiBicpRth0ZWvEIhFRmU6XHpWTnPf2b3TtqMXVtCPDBLlxqWA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4583.namprd04.prod.outlook.com (52.135.238.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 8 Nov 2019 22:18:36 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 22:18:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bob Liu <bob.liu@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Topic: [PATCH] block: Bail out iteration functions upon SIGKILL.
Thread-Index: AQHVlis6RTlSzptCx02pPsSyxswoAQ==
Date:   Fri, 8 Nov 2019 22:18:35 +0000
Message-ID: <BYAPR04MB574901B12C5F5D68D9B172C1867B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <000000000000c52dbf05958f3f3a@google.com>
 <3fbc4bb2-a03b-fbfa-4803-47a6d0075ff2@I-love.SAKURA.ne.jp>
 <24296ff7-4a5f-2bd9-63c7-07831f7b4d8d@oracle.com>
 <8fde32da-d5e5-11b7-9ed7-e3aa5b003647@i-love.sakura.ne.jp>
 <DM6PR04MB5754F53E04CA4B3B96E01233867B0@DM6PR04MB5754.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58132944-e39b-4caa-022f-08d764999961
x-ms-traffictypediagnostic: BYAPR04MB4583:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4583CE0E9DFFEA9CF40D9C1E867B0@BYAPR04MB4583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(51914003)(199004)(189003)(2501003)(6506007)(52536014)(446003)(6116002)(2906002)(6306002)(66946007)(71190400001)(186003)(6246003)(5660300002)(55016002)(486006)(3846002)(74316002)(66066001)(9686003)(102836004)(26005)(33656002)(476003)(256004)(229853002)(6436002)(14444005)(316002)(305945005)(8676002)(76116006)(110136005)(66476007)(4744005)(71200400001)(478600001)(7736002)(76176011)(4326008)(66446008)(66556008)(64756008)(14454004)(7696005)(86362001)(99286004)(53546011)(81156014)(25786009)(81166006)(8936002)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4583;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPu/QaoVoi+C8EsoLaAIaMRuRktmMJ/EH2jT27GS/rVqv+SnfCuXFrUGMqlHYC5L2W1e8eI63rpenGXNjaNJhmiKhlPHGvCxNCJ6OCyfp84Ax68ohFGmPi8BN1hRs2jT07wLbIYhLdtxVxMnwW47d6W3z0fE/me0KwtFwT7ur0VIMxX2GUAYDJB0Fnm/wmZxOK/SM8BXt/LihHZ8pdWfAI0t2pU3yVRxnasE82Aa7QKgrFM2LtketZ3IaitlGkZRDq+QxmfaLHh91vTnSPF9Xw6eVlJUWhESpiiVvG/fZ++8Aj4lXHc4CVl8/hW19LespYGYrxrqDjEkD5KtiC+lHvUOxYrVJB9pRsFj22kvIC7FqnAEpFf63gBK7EdhsCrtgCH0k2pk8/01EduWAu1RCw4oSSBgJMKXeJ2dzV2jYcj5msATireekZLC8dWuCM65YsLdYPxB9mcsAnxoAjglU6PjZiJodt7NyL9v9f/2KEAKoah/ck3pmbQLNRPmLG1RbvQ4b7scCLRD1S9x4KPYJdoUhyA5/hfg1Qrhz6MZ3fw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58132944-e39b-4caa-022f-08d764999961
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 22:18:35.9331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExAfbgSvi9Fa3PrVSQ3Z/mrBX7dQeRSqTEl/Gw5zGLd+ekaKpLFPY7JQJDqJB8XgD4ITITF2z+W4APjCa7MtRYNjPWCH6jTdfjZ7GODXMzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4583
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 11/08/2019 10:13 AM, Chaitanya Kulkarni wrote:=0A=
> Thanks for the patch, this looks good to me, let me test this patch=0A=
> will send a review then.=0A=
>=0A=
> On 11/08/2019 03:54 AM, Tetsuo Handa wrote:=0A=
>> syzbot found that a thread can stall for minutes inside fallocate()=0A=
>> after that thread was killed by SIGKILL [1]. While trying to allocate=0A=
>> 64TB of disk space using fallocate() is legal, delaying termination of=
=0A=
>> killed thread for minutes is bad. Thus, allow iteration functions in=0A=
>> block/blk-lib.c to be killable.=0A=
>>=0A=
>> [1]https://syzkaller.appspot.com/bug?id=3D9386d051e11e09973d5a4cf79af5e8=
cedf79386d=0A=
>>=0A=
>> Signed-off-by: Tetsuo Handa<penguin-kernel@I-love.SAKURA.ne.jp>=0A=
>> Reported-by: syzbot<syzbot+b48daca8639150bc5e73@syzkaller.appspotmail.co=
m>=0A=
>=0A=
>=0A=
=0A=
