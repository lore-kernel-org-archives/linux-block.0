Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C053C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E67E613C0
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhE0RZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 13:25:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5186 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhE0RZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622136220; x=1653672220;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SO0o1IiOdjE7nH+sw/9p9CmygGYi0V3eIn7i1sro6Rg=;
  b=bfEd3Vw83GlO1pJWTsCIeD7KVJpvqMXd0+rPsidD9n531EEM3Hd2lhzn
   uv6QTXPsyalRkkUN6QfWJxe5fP2HaAXeSk5ct/YVjWdIL8qW/LumXL+Z4
   XGVG3tljSwYVwGQzQ8/ZfurtUv0zeuc/6GU2Oasql8U9cVEkINBG4Wr0p
   GrPAIVPcEBa7ZtI2/oojnaYfA4VSAE8hcuDtWHMWXfBi7VzRTvVwPDyoH
   mIT6o+iG0yHw+Y40KHG76RgMntotMjCqyPIlEZk3ryIPgJz6VrOu+DawG
   pYIKa8hWIQHaHz2Ekg8C8G7bX0L4eZCM6L3gCoknNWmVCniiXKXeqBN7j
   w==;
IronPort-SDR: g64DzOlb9kcpYc9AbP8ksgHnxff5omd83eiKz+rLeRozjPbZEbdaJCF4uAlAhA6QBFy9wlEDy3
 I1y5omm74KRv4oVSNK2bckVcx2susDsQUE4QfpZ9QvuxG3y716TTFg4LSV4Z7Gs4jDhbXp+31L
 JQZIEFf26SE8u6mgH/HCy8h/U5kLohQ9ycUuKzRfzBJsZUrBQ+ozwET7F1ScID+h+HHV1yWZ9i
 YzNoWRSVzVbAPzsmkdmYYQQDa8C7atpYCHaKhXJ7T8PMHmG2tnghEM1/6sQwXXz+LWKOxpw8Q4
 mbs=
X-IronPort-AV: E=Sophos;i="5.83,228,1616428800"; 
   d="scan'208";a="170214336"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 01:23:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXHGYc2AgmMCnAC9c6QS6z+TUosJEgOYz9njoW+eQu9+X2Gbo7oFyElAewAvDK84qskbmAQbgF3+bq4tf4BVLbJIdJCKUix+K2ERZ7Rk7gYGc7Ve+fHqfiW9cXBtZtvPIAE0W5os/2Hc0OMdoyTx3m49YgBp48kjTfGQs0ecWCg03KhCgamfyY9LXKFJ73JX4fmrDc7xCdII5idjq3GfoDY+eKfOYyv0/m84cy+da8WWfLwpW+5Mny1ZMkZshyOBFWwA2u8hU4MxQcKMNjqAbyZB/nZy1KdnCczunyM5fg9OihBfR5Y55GalCVBfpEm/YYT9STGD1o9Svz1Q/VTkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJUVw25wFj+QLO7OafaCCidZVjB9R1hlWqVE+N5e7GA=;
 b=LZK8o1hGnVUHbSTaRrCPDAtV8ixG3YeV2kDIwh7Iqh4aE+D8TGaws9+SdjaH3tvKftuefu8R6wZAo5r7d5WznxlioaqLvVzPvfDBNddqpDP9+3szNoiOLQK9tAn7MsbkwwKZYEAHTj37oOzRiEaXr4tMD+YRL/sozXWd9xzu5lWjC6k49cjclu7D9hZ+GwmxJBlT1+hMMYT7G5K3mQcQ1arQwKGrQ8meNdo9OnbrkdNYJnrEhnJyFwfmR3DI1IjJUQ29iAaYkU9/jwtXM+cgetDRXzHszVDsaOlr4yhSVQjfGPf1iFNkIe/Z+/fopzNE/IMfwjRMXaTVrRc+I3bezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJUVw25wFj+QLO7OafaCCidZVjB9R1hlWqVE+N5e7GA=;
 b=r5pkJM0Us9G5icTv6pqJvvQC+J/V/gFtckJBMaVMs6ws35+99a13Q5OcXAIgXx0vaDJzAGJh/8WCh/Q7FVBXwsbAR+YXhft8axQourq8wrvRZwWJDrZ/+ZGVmiI9OEdwL9zHc23X4EU7wODZ20vO47vzLmq7Jly4aXwxaiXhXeo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4869.namprd04.prod.outlook.com (2603:10b6:a03:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 17:23:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 17:23:36 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>
Subject: Re: [PATCH 0/9] Improve I/O priority support
Thread-Topic: [PATCH 0/9] Improve I/O priority support
Thread-Index: AQHXUpPk9Scsw3Oj6U2O59JQWPaEVg==
Date:   Thu, 27 May 2021 17:23:36 +0000
Message-ID: <BYAPR04MB49655AE60D23813CCB22CF4A86239@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <PH0PR04MB7416F36FCACCE792DCC5AC1D9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4d69430-40bd-413a-f194-08d921342926
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4869BA54B72112C49E60494786239@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/mUqKYYtN7E40GfDRGXVocSe1fhMPuCNy/UurucTJbtiV4+yNu9LtnrhCAh1yhfS1RRt3QR71ajikYlzrkOliiH9a77PWTE6mU41+tEzfznsobzjXdZDERychMeocTwzqBJzbZiE5wwurhNveCXQGA0Ix/qRM2hG+j2efgsimzinQ8HebPgyd/ysBX3iBpcDQ/gqCtvg8kdcvB0vyw02b1aR6XOV+tZwJnZzAzZKUjzaj8nbS+rMUn+u58MOnOuQIFt+tAqFRxeg4inVR0GSHLhg6wM93XJ+1MFx6zeWWTd1NFiX2UqhQQdwiqjBwF+4l3H6Adih6GGw9bIZgEIVoiHNzE6Av+4tHe9SdXd7VstxUukaPlvLYZb4fxrm62koVW3c6kVd93top9u/mWMtfKjKku/2uzvGAS+Mznj1OSSet/iCHfOnG3+rxY5VtqWdtQ35J/AkwdY5RbbwvYk/9UIQ+QvCX3h02d1qTKWijwOYPPNT0PR1YK6DXRPGWhk0bHEAYZ5GtPK091ZKjMe0ZoF72PTpFKe0PmpiqiZzYmpZFRn5RVB849FbbAkzC1l07hW9ARGogsw6LL8fhvuunREmUrzBZ3CKQnZcoeRTvg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(33656002)(38100700002)(186003)(316002)(6506007)(76116006)(86362001)(26005)(53546011)(122000001)(52536014)(54906003)(110136005)(2906002)(71200400001)(8676002)(8936002)(7696005)(66946007)(5660300002)(4326008)(9686003)(66476007)(66446008)(83380400001)(66556008)(55016002)(64756008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6Fs6fabudhUr2HRKKvPB1csJbghMz/iAVyGzif2q6zyl6kENBC4ZipW+yN2a?=
 =?us-ascii?Q?GxWDpBlTL1+DOaoHea+Xykei5PJKc//Rp7+hYD5u03URupXC99lmqkw7RW3v?=
 =?us-ascii?Q?nyoBSOb9PpgauGEI1evAdZc/oGZUwknuBfvpF9Bj1GodKfXBr6W0AmaWYwza?=
 =?us-ascii?Q?h97TMTHDGif2CoH935n+RsIiWMjkUDyGB/bsCNN34aqjSTFc1UPQ7obTg08T?=
 =?us-ascii?Q?DauZfRf3dwMsLEXgR+/ZbKRFh710Ch/xuEzCIdWUnEZfWlh5L2nkzG6dKtGo?=
 =?us-ascii?Q?+X9FAX7M6hWjh6Lgn3B7nbn02QB5jBQHKTq++5pFNnxOPVbgLGT79c9OhzYI?=
 =?us-ascii?Q?AhLKHwt9av8RKqrx0Qs8CiRV/rXEW9EEbdC98JK107YsJm4eGnPn7k9y4QUa?=
 =?us-ascii?Q?AwTcItjpN7bjilpVvy4WeY/O3zmNZVTtCYnWGDuS2gCO9l81SIN8CYwayP6z?=
 =?us-ascii?Q?SrtmX2xYj0KRSfxkpOwjrZUb5QUFunBYdw+8R1zgWIFZxQgENQ3l2B8fq52m?=
 =?us-ascii?Q?9UGXAGdDuVxM/TjTQmdg/AINJg2DZKEkeoceMWaUSICdj/UPS6EKbOG6PjsV?=
 =?us-ascii?Q?DPOXmLOAnPrHOVv89W5m6WOT1+X1hbfaBw+jHD+CSnQGRmCJZ5XqZ5whjJFo?=
 =?us-ascii?Q?J6mUs74IczVkA0A34w8AohbErW+SbPbm5ytPwUls4j5+GJQ3XhFcf+zHofCq?=
 =?us-ascii?Q?UOyPNDsS3KB3XwIG2FGj9dv2xTmABA4IqvbcbaTUqfKWcQfUB+IuKaLEryyO?=
 =?us-ascii?Q?kt3Z0qZsVWkLAeTFMBfnBg4QtTmxQzeBf3pHy3CNVQaf935VeOP6HKiKLG4Y?=
 =?us-ascii?Q?iIwbaj9MHaE2gpuQUo9O3EoR0r1MVp3FCK6RAOApROS8DKls6PIpj0EsQjhh?=
 =?us-ascii?Q?ePy08KKd8i7VLaN+07SIFITYV0F4K1ulrm8AsdolMHglTAEQOTdNueYCvu2T?=
 =?us-ascii?Q?zm0oPYVakGU9plW7dXCKIp0Lb/px0Vd8O//Fi9rU2gAUSAbc7oNL+3+m2KpG?=
 =?us-ascii?Q?MQ+5/BBFKF5WE6fylg0CT8gBu6emqizqYWZCvIXCWrs7lKwJ2Kfj+uc2ubdC?=
 =?us-ascii?Q?/y0kAvZzR7R7EzHZmO0JYeRR8HYtbtaxlX+r6jTG6qbtPXsusLs8xOFRpxy6?=
 =?us-ascii?Q?QHQjbML7PdWnzj/QsMuagt0i9413YW4VBSqy+t12TsyU8VOzaNdji6AMwLb2?=
 =?us-ascii?Q?OP5s2OlgtINCSmGxx16omLPcylEeaDJRgSaZr+RRC8jWOL/RO5NvRE2R4Orq?=
 =?us-ascii?Q?itX9WRzip1j51gvvESe8OUz/q4HOFWNrOp4m4F1CNMjnUbi9xD97JBpXyaXo?=
 =?us-ascii?Q?BWCt9Sc+K3S5MI4niwnw1MRY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d69430-40bd-413a-f194-08d921342926
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 17:23:36.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49AOage8XDEGldVHTuLOIf3FqYP2F3m3ijQ6gh7Jp3B/ShZk0TrJcwPbg8ZSSGZmmh+l/FyJRXUjdN0kHzpfhQA9ERazXC1oTHiwvajh21o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 01:56, Johannes Thumshirn wrote:=0A=
> On 27/05/2021 03:01, Bart Van Assche wrote:=0A=
>> Hi Jens,=0A=
>>=0A=
>> A feature that is missing from the Linux kernel for storage devices that=
=0A=
>> support I/O priorities is to set the I/O priority in requests involving =
page=0A=
>> cache writeback. Since the identity of the process that triggers page ca=
che=0A=
>> writeback is not known in the writeback code, the priority set by ioprio=
_set()=0A=
>> is ignored. However, an I/O cgroup is associated with writeback requests=
=0A=
>> by certain filesystems. Hence this patch series that implements the foll=
owing=0A=
>> changes for the mq-deadline scheduler:=0A=
>> * Make the I/O priority configurable per I/O cgroup.=0A=
>> * Change the I/O priority of requests to the lower of (request I/O prior=
ity,=0A=
>>   cgroup I/O priority).=0A=
>> * Introduce one queue per I/O priority in the mq-deadline scheduler.=0A=
>>=0A=
>> Please consider this patch series for kernel v5.14.=0A=
>>=0A=
>> Thanks,=0A=
>>=0A=
>> Bart.=0A=
>>=0A=
>> Bart Van Assche (9):=0A=
>>   block/mq-deadline: Add several comments=0A=
>>   block/mq-deadline: Add two lockdep_assert_held() statements=0A=
>>   block/mq-deadline: Remove two local variables=0A=
>>   block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()=0A=
>>   block/mq-deadline: Improve compile-time argument checking=0A=
>>=0A=
> I think the above 5 patches can go in independently as cleanups.=0A=
>=0A=
=0A=
Yes they seems purely cleanup from review point of view.=0A=
=0A=
=0A=
