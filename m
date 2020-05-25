Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA3C433DF
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368A6207D8
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MoW9QFCT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="duo4hvJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEYPv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 11:51:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27884 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYPv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590421887; x=1621957887;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hiEg4Qd+ZKt+0JflI29BwPSZaBgebk2jXQJrTh2pnCo=;
  b=MoW9QFCTjTPhiAL44yTIfdYtaF0gjIIbWpIDVy+6c89lE28sQTM4tAkD
   imAxcVCCD/lUygDmPQIuCaz/s6VU8EJpq1APFWkdvQe3ORDPogjALSUMo
   ZuPYffb2Mk/ZD9e585MMPldW527PacfvATRV7TGTXqyduy0xQ60NBY3CK
   gIE2NTtz8DQpyclP4ngYSUb7JOad0Qx9HBTLsHYuZFuSA8KnkKN1Kq3XG
   0fCu/PTvNlpXSy0FzICLRkptmMXxgzwB0x6tKc8onVeVPXLN+7lmHeM61
   Og+C0aNHE5L+4MjQ3Q3cyqYJBEzxrMV5aswYQeAEnZfUrdHB9jwAoitx1
   A==;
IronPort-SDR: xWQ98UnUraru9L+ZrkhgXmth4GcePUI9pmJWMVvKTHKXcMNDXO1Hi1roXziLvT5EgTwLkEfRil
 YC9YJyNkROCcQQVLaVogDxNoxyfbZVXSxTCAV41CPsRi0uh5e1ARH8zvReiLVUfLd5sjhnhKGd
 3tyxRfI76Ma7Zn2IN9+bvxzAZFKFljEJP0XNw6L57cimWZusJ9nxc6NQmrVAuESF/OpBkus2Rq
 K0h9Rg3HrkXKwIj7d+wpkbcYV4Hz1ye/WC8bdhHQ7NYHsJ/Bfv+dCLbUoA7fe34OnRildf5MOg
 b8w=
X-IronPort-AV: E=Sophos;i="5.73,433,1583164800"; 
   d="scan'208";a="139905535"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2020 23:51:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEOtFKuzF4s7S63yyr5f4UN0M+kqenopIjQarAY3QdczFJ+TFo2tx/X+QLblfFegO5CaJf0KgWCZL1UdFX5mJOAstN0thbgZkP0ntCTCkEcJN85rOk19KW5HuiaO7FCLeFdRIhtJKZ/gbk8BLZyVWxREvQKfHAqCzW5s3+tmfuBow2cqKcbfmHOephc9O5Ek8OAOi9+IEvP3WwBxa9XXaJMYR48R/tSEL1xu0E9OfCyiMGJM7cxsSbHt0sb7zaCpmvKzIICvUl/VEtQeOkjJloK3FDAWLnP4Rrpl2mr23V9niuVVOY3FSaVd+jjsrpRDRrjF0OgUcbHj80OZ0kSc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh7pvKTaJr1yk82Ztb5e+D+mJi1uoCtu0PfYHxaQ7QA=;
 b=QiXq6jUx5ZW/UhpMwvCOkNX1u6eylL0NEJfXEy5eTdEH5TBbHZkmJJFsy7/TSPZ2z86W7g9HKhPvsRbnbdY8yaKev4oudbPSnyhGuQ9REWLfY/fgtTsLiI5uD4N3goCNzhAR9paQauK0kQiNbHBkIpKFNRpMZLHXX5Cz7SBzvv9CgGnlTCzpF34bYnsHzQSUbP5ArTS7BdWtAG9ta0U1N5PLi1rXWuNQt2/mUSyiwvmJYqO7JNBKXPOXCMoewrVtZL1E3eWdRfn8IUc+HNEIOVTmLhpfQpY0Al95iES8neTNOSUbLr3QdEK1z1L5m5Y4uKODMyjEB5WYCDne+5tWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh7pvKTaJr1yk82Ztb5e+D+mJi1uoCtu0PfYHxaQ7QA=;
 b=duo4hvJyP7zCGXBHpu7w3qqDw5spNLmSoSG+fbLCJxT9WykVUSeWRyga3ppEvV2Ks3dP0ND9B+hHt2dirZqXGX57d1T08qPok2e6HoF3PzSnxpb2uPXoBnlRKczNCqubBF+BbA9HFWqIxKuAcR8x3FfZdl2tQOFyQ9ZFew9OiKc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Mon, 25 May
 2020 15:51:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 15:51:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Topic: [PATCH V2 5/6] blk-mq: pass obtained budget count to
 blk_mq_dispatch_rq_list
Thread-Index: AQHWMnhT31E0DDF9T0iuK90q5B3Etw==
Date:   Mon, 25 May 2020 15:51:24 +0000
Message-ID: <SN4PR0401MB35986A6003B1801361BBAE049BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-6-ming.lei@redhat.com>
 <SN4PR0401MB359822F483E45C998996D49B9BB30@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200525134820.GA847759@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26da4265-1b19-4baf-cc69-08d800c37a74
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN4PR0401MB359782A0D216500EDF0783149BB30@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJ8gihTAmaoLSDYB0B933RsC1ReH3bl+1zhFo0Bznv+uXVKJEpK4FyvkQN/f8K4R6pD6chdexUEQwrhCRRgr+YMZxmyVz1fplWmGaYtf5IxwtVseDDnrGHlUEeDe+vrNP0grQ4OCYqSN3cVc6fODrbRgcR3jImEDBxA/LFjCd2MAu1Jg4lswzF8OLuPPISt29Fbe9dPzQA4QJKcUswbu4c6+sf0u13RTNyw0gw1eiULjnWWfq1ygU/gwgeWYqXyhOqcxWx7yfH63MpWUj2Hyl8TjeKRGK492J000HStuKVZ/7b2NBgwXt796eB1R+drl5Pqjp7bT0DEKCHwnwHjLdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(4744005)(33656002)(52536014)(54906003)(2906002)(8676002)(478600001)(71200400001)(6916009)(6506007)(26005)(5660300002)(186003)(8936002)(66476007)(9686003)(66446008)(76116006)(66946007)(66556008)(4326008)(64756008)(55016002)(86362001)(91956017)(53546011)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bJOEJCPQBsCIdMHDoCuBc2qFrCQa2vEVtVZKKuZILM9/qpxKjrZPDJS4l1GFcbF7clpx4Nlv6bD86joi0wPBAQ1ulMXoxPE3sX1ZK4g+juTpX8ANRqvDpGUmoe4LEp4SnefXeqLEE+Bjj7ShHPzjjaDh/wKhfbXsP2fqau5K9kg7qjfrR6V8odBTkbKLq8H3NFMWwNFJ3QxVuyHpNJzYGV74jwEmwzJB26jVc/qnaPIeJFD59f5ZCFP+W0IeJn0UhE5E1W2/rwktibwDLGoNRDt4LocyMCk3D7Y/U4L2UMQbKE3oeN76NNQuDHQ2ngFz0pVO9q76MQD3PJe9wcld7x0g2pudHlLnMQXZ6fBGJ6e9heSgaGwdHRyqA6VCiJLH6EP+1dlmsyK2o1zc1m2Aios8AwXhtMZuc5mVI9Hb5VRFSHXmipi5pd73Z7xJ9MOxyUoICMtaXP+1Ic+HTCldyjW7pQIq0dNDMvAr2cbOZleji/4srb2sHtElGiKrW8a8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26da4265-1b19-4baf-cc69-08d800c37a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 15:51:24.4073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5l3Xpx1Z62IRxgOSJ9PvgcR9DLcctN95TrcM4lfAjkGdAZFA82KlWUyy+NZfqYe3QFIrHs8GUZDDiaPoXNW1v5wY9LOFELXhi1kzSRJ8HCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25/05/2020 15:48, Ming Lei wrote:=0A=
> On Mon, May 25, 2020 at 11:01:29AM +0000, Johannes Thumshirn wrote:=0A=
>> On 25/05/2020 11:39, Ming Lei wrote:=0A=
>>>  bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_h=
ead *list,=0A=
>>> -			     bool got_budget)=0A=
>>> +			     unsigned int nr_budgets)=0A=
>>=0A=
>> I would probably just call it budget instead of nr_budgets.=0A=
>>=0A=
> =0A=
> It was named as 'budget' or 'budgets', but Christoph suggested to rename=
=0A=
> it as 'nr_budgets'.=0A=
=0A=
Hm ok then I guess=0A=
=0A=
=0A=
=0A=
