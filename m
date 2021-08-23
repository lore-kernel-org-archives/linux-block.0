Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA7C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 23:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86CE61052
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 23:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHWXCD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 19:02:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34072 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhHWXCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 19:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629759678; x=1661295678;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZxVHNX9dx1zsT3HI1pB4p6wUtR7+Ot+utKpLwMVnsWY=;
  b=jx2Ai3LEGQBlJDKInildhc3AVjzlLbCn6Q2CSDmEXrgnB1bRU4WkobbE
   4xg7AUhTsvBAsjZ2Q6rQS12wtwW6HoJMfieEEOsJGlsZicSNgToqgd1M/
   bxQDZgLFmNwqUiNQexYJ5VminW8hDWIzZq1qCx17b50th8JXMbIWBuwKD
   Vx8ujRiZPV3iriJR0YHoYovAhXjmwCeA38rsHCh/ben9KtWkK4Yq44LmY
   X3ZwZzvZOH0X79elKP7mhqsJWdVX0XSr92jmVYe6MOhwq+Xk4KozTheFj
   K1AFG0gNiuQwcZruh5W3Agmg75T1hELSdl9JNgfV7Yvggyb9oSV5TgZRv
   w==;
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="289754279"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 07:01:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChkfjqQocgP2e9FfyrEwZ9b/rk1smHcxAOXz6GAR6CGe0xl0KWCavgoyTK0bA13Ck3knnJ5xwerckDaZDsvEeIo+J2u2+HmwVx2HH1sxy495hMCtnbgwltgClGmvkDCtC3CIWGTc2t3NxYUKeaoxeHiR08OLuxs5XwvPHu+5ZjgRPQDeZD5faC5hDo4Pzx/chRXel+0EDJjjKg2UdiT+YzotQSAc8t2rjRgeXWlRbpxafYeGq76OrbY3riHaeLMpdlE1iy8NxHyYy91QGHQz/LL1RbeuE8+wbMKvYCAShSr2upSAsSrD+l96ofWz+5ksAPJmBgY1DX8CAS0i1LnkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxVHNX9dx1zsT3HI1pB4p6wUtR7+Ot+utKpLwMVnsWY=;
 b=QiqmPP4wOzkswkvPa7H3YVrgprrGGfSOcBhYDFydt8Rgmxo7KRMWCcojwCA52Tg08iNhaB/yePb3nZmKddFTT5IXtkf60yGW81PATnSQVa5fkyhBYUT2Nd1x5o0gg09aBV0L5JQ0HAftEaTYk/9CTL4Lad2+Us06oJw56k5pGLmRknQYoNOnLGCK4Tp6tOJsC97OoQuxnH1/lGJh/2zdSTfQOsJAE3Vl+CXMTX5a55vr6DkPhKL9hXsK1JnzEsYzwPC0N7JXzb7C+sE75VUb2ctURuO2GxHMgumeDVcPsHiJLfOoY1T5H436bQxIn8i/cIrzNaTSbv69q3nlMruoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxVHNX9dx1zsT3HI1pB4p6wUtR7+Ot+utKpLwMVnsWY=;
 b=uKJ7LEWKb1/q9y9rIx2JHldRdZteji71gNmxmT8Ow0rXgIIOL+a6YoiEOhcFA89zGlPDHKa3JYGzoWcOvgrPisOJCCGmvRT5BhwYpeIC83tsxttbWmuud9bo1y4yjiziTfmHe33eKQZgxO2qGEmhtPImLKwjLgujAb1AUfNHCT0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4346.namprd04.prod.outlook.com (2603:10b6:5:a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 23:01:16 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::e521:352:1d70:31c%9]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 23:01:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXY9tAcljGY1JaPE+BA6SKWl07GQ==
Date:   Mon, 23 Aug 2021 23:01:16 +0000
Message-ID: <DM6PR04MB7081B83F99942E45212817EEE7C49@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org> <YSA1JWt9soMSs23Z@x1-carbon>
 <e94f62c4-a329-398d-5003-d369506d7f89@acm.org> <YSNQAu9uXrmEteXc@x1-carbon>
 <b6131780-8b67-8efb-a942-e40b68df082e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 695719a9-cfea-4815-fea4-08d96689e986
x-ms-traffictypediagnostic: DM6PR04MB4346:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4346544E6AA928734D6DE184E7C49@DM6PR04MB4346.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKPSpHcequTNGc8TexYZZ2BG0FKDZvqSCNHSsYBY4Qw1lqJOz1hcIEfNkjVm4DG/AFXKAMsoR+KNYYXeHCqkpMkRUHMRn10T62LCi4lYOiWWoqvrPYt2UFB2rztm4Kc0ncXshlxkrkQCGAMQJLyOzCfIk1BRbxWIkxsr9bYC/H+TQNBzL4Y0k+LLE4e3VhPfpRAlmNzEQOL38PHHNZW5nrBg0vIwWQ5Qb5eemLO7MtKuxMymAVCr00TRrnqyVea1JSbVXQmRnAoBWFn8VyGBM9LaiDes9fHfAcY0Q3OmWLwfwRLPZmjjIKxU3mlt3b/1h5iy46f96x35MObk66GPF97tK5XvUKIelnloEMPDz56BIwY7KKUu3tcpNHh89+vrso8kBG2m+1QiRIJGuM5i1u4uhAcY1pOjEVkdfcVxggLzRbQ4cutqiD0SXVl6sD+QKtAnq202zfvc0c7lbfq4iVqnnG1cSoNf+eCjXjCvW9vnTMIr//fbrEfzM6WtCVl0Ax+aQ2lqlbTC47J2BJqvSa4V0BdcRLk/7UB3JSBTQ1r+GfNNwCxBv+MGVJfU5dDgAhf6n455V+8ATA4eRE0tysz1NH1HpxEUuFt2jyFy/Lx4ZCCLVYGQN4kUac0WT9Myuo8ZSC4AhSneuKQ63sgW9kSy+gJs5lm+bZLXV3U/QCAkGUHf1eVtPHspSIy+ISulEebITxGpqMJHCC1z+jPstg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(53546011)(6506007)(66476007)(66556008)(76116006)(38070700005)(66946007)(33656002)(122000001)(64756008)(478600001)(316002)(55016002)(86362001)(38100700002)(110136005)(91956017)(66446008)(186003)(54906003)(8936002)(5660300002)(4326008)(8676002)(71200400001)(6636002)(52536014)(9686003)(7696005)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bh70JNcAmvh4cKXBMDHJLzX5CALf1Iw4oJDuz5uOnpws++oaHLS/CP/FvNxp?=
 =?us-ascii?Q?abWFxd1ZD1gy2vHSKf2fCpayqx9jDNpdEAw7BLK4BgU91dLoiKB3pbY7f/AH?=
 =?us-ascii?Q?F8llh9wThGoablwbgJtleWntiB6SMUtcjQ7w2ArYJ7p6lfAMPyzHj1Xv3qfx?=
 =?us-ascii?Q?Fx2NJy7kH2+i6kqxKHK6lkngErZa1E2eEgk+XpovVgkx436wEn/jZMDJWbQT?=
 =?us-ascii?Q?X78w6yB5+R4PgTNmg1vjnwL9xqWCipKpRRnOVougFcO51mjzmcdh/GaP0SG/?=
 =?us-ascii?Q?s0Nlo4C6P423Gbni3UswrPK6rd9Ta3gwMf8jaQQW5P3CfXgvtHduiH6SlUNd?=
 =?us-ascii?Q?0bdBAm9piiegO18notoiV3Ezm45+YID8g49OwfFWwn1zh4l0OHpnr1IwX+jh?=
 =?us-ascii?Q?DbzYaAMYZTJrsbRRydwJIG/+86Zkvq6zUNIVGSt754zbDBhHjg6X1+UJT4Ce?=
 =?us-ascii?Q?1v4L6C/S54cGBOxj7Z0vzKMipOzQHYIA0oWu1Sl1EG+gjuhfko0beODn4Y9J?=
 =?us-ascii?Q?ASsR2Mf6GHXNahJpzwR0oL2L8Zzxv7n2iCmHF024e7PUE9Fj7fOgxeaj+J/8?=
 =?us-ascii?Q?fEazCFYXv+AU7DPaqjJyp3hjYfihOo5dP1xJMQfSVHbRsBQVbddDqN7k3sWO?=
 =?us-ascii?Q?G3lPdEZyxwl+54GSlO0v1GzsWmKf1swEs50sCG4recBmp9XEElcXVmzQNXBz?=
 =?us-ascii?Q?GdcgHAU/b6TzH1pRjRLBdfCrHFqOxIVpgbZF6ti7HRhqMTVZu2C7tWeG8l/g?=
 =?us-ascii?Q?19Qo8eklxetNQFBeuWzXrtNjPsj5zov8SZQ+La/NzTPxezAGKPLrUfgkPYwl?=
 =?us-ascii?Q?ieJLnda7/Gj3hXgO/gMSnLTmTgmVlllqOiV3U/q/ml/DanAeKTjpXUG9ibXR?=
 =?us-ascii?Q?5roNbkJdGozXNh6jRaRtporsf+1oRRKEephPdK91q+g5BrnBKRmNi9mdb9RS?=
 =?us-ascii?Q?KZt5Uf+hBBkQWzcwKulKx//v1nO32+EkocgK+wbSHIdk6I7V67B2e8aOADTg?=
 =?us-ascii?Q?FumER1yhO0Hfla+w4GG71u89AQ8INIblT++zI3ZnFblw6Fcw7LONzvUxyNVl?=
 =?us-ascii?Q?iUJDCN+/9n4zFqSStcO+89agnn8LU8XF6LvbY4gl3FlMwDYRgjq1ViYmRHx+?=
 =?us-ascii?Q?9I3T1xaJZXckIn7GQdU0geMp00oLSnw2Il17PP6Kxo/Na5JgmBepv09RRJKA?=
 =?us-ascii?Q?rbI+fAHjVGLjUen6x/xoGG8vXEkkPfT3Ym4Zghe1MKTv5jQOOBwEVhJhtWmT?=
 =?us-ascii?Q?5BuyYUgYKNQuF/FeRfILKGUqOK3tYq+41W6gs+zJK8i6XzEEYupHPKt4TgK7?=
 =?us-ascii?Q?xWQAFcNdsnoFyXW2WPpwp46Pc9nr1Sr7dS/GtluVK37e0MaPvtFyae+tCqu6?=
 =?us-ascii?Q?vOKH0GM8LMweBkjum8dqvvT47N9DiWMdpPuQZBUx77uhM4kIUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695719a9-cfea-4815-fea4-08d96689e986
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 23:01:16.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W2ysOaj/331PpLct2JH9e2jyWYXF8I1VUDq5cYadkyvq2OH09ILISftgZbUo8GTMm7S2mCFk4Ynsb/KUwr8OTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4346
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/24 2:15, Bart Van Assche wrote:=0A=
> On 8/23/21 12:36 AM, Niklas Cassel wrote:=0A=
>> I was mainly thinking that it should be possible to do a generic fix,=0A=
>> such that we eventually won't need a similar fix as yours in all the=0A=
>> different I/O schedulers.=0A=
> =0A=
> Coming up with a generic fix would be great but I have not yet found an =
=0A=
> elegant approach ...=0A=
> =0A=
> Another question is what the impact is of scheduler bypass on zoned =0A=
> block devices? Is the zone locking performed by the mq-deadline =0A=
> scheduler for writes to zoned block devices compatible with I/O =0A=
> scheduler bypass?=0A=
=0A=
Without mq-deadline, in the general case, regular writes to the same zone m=
ay=0A=
end up being reordered and IO errors will follow. Only zone append writes c=
an=0A=
survive the scheduler bypass as zone write locking in that case is done at =
the=0A=
scsi disk driver level using the dispatch queue. So bypassing the scheduler=
 for=0A=
writes can work only with very special cases, namely, the user issuign smal=
l=0A=
request that are never split and at QD=3D1 at most per zone. Any other work=
load=0A=
(larger requests and/or higher write QD per zone) can easily trigger write=
=0A=
errors (that is fairly easy to check).=0A=
=0A=
> =0A=
>> However, it does not apply on top of Torvalds master or Jens's for-next=
=0A=
>> branch because they both have reverted your cgroup support patch.=0A=
>>=0A=
>> If you rebase your fix and send it out, I will be happy to send out=0A=
>> a Reviewed-by/Tested-by.=0A=
> =0A=
> I will rebase, retest and resend my patch.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
