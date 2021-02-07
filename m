Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D52C433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CEA564E75
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGF0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:26:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32213 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGF0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Feb 2021 00:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612675570; x=1644211570;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=N873zojmM1xvPSSNum01yNQqasVi/Q5SVqvphq9ubfM=;
  b=X6mp/JFX2GKkSj1FTqcJBhZWpHsXvJ3A0eEvDzpiUQJlin8AbJoPyLlv
   S13rZIggbPJXXGUe+yGNT4y+2amhsxby0+s7+c2f+NWa0KmnHRE59XhxL
   VHH9kBtWHQWR1XBVkY/HgsGT9qS3QakGTAvrfLipp9VZY7PdcPkhxQONA
   nsJrBFVgBflPKWR89Ug9hamIqB0kDJXIZjlrgtQe/T/fiH2qlfJT8jSJM
   k21eDvk85Ar7WOCYRpb3omVz1hxWwOjG198QISxlr5/JT7RtuKymUBgsX
   PvX1dEZs5c6rb1cmwIJrkbWUbxckW+HjCoReS7QxM23wgMOP2gSeIRSQv
   g==;
IronPort-SDR: CKBrTv1YY975qPB16aPPIPwjAKAL/jdxk+RDKmbL/5tzi7at/aZk/JdLKnABG1uhuoWfjgjwyO
 EENcCk+FGwl3B6ZHLWJC+ANHdza5Sy6cZouSQwrW7s8usSoADBK3OiPYwdBjxBjK4gCFUptw4j
 fWa0lbXZgKBA7sAfgJgx9AErtDA2isSgYgjQqoMwn/zfrhTkYAe8q/auoWhcqwm+t4k5r4omdw
 JXQpl2bvwVZyeIQgrn+nyrG+sFjoOePAT2iFWuxw6LMHNuUutV4gIp4cx7eUTVhxBTnetpcSHw
 5MU=
X-IronPort-AV: E=Sophos;i="5.81,158,1610380800"; 
   d="scan'208";a="159361098"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 13:25:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqtWIX6FibUFlzLSTCf59NXAwZ/G/BJzlYbNTZim3GQc8Qo9AhBwimzjVOdkre/df1yenT0r76rp6Q+uXkDfN1XDjnASbWVujpEhFz7i73CCiYtNlYi2oOfk6q6M/l+YNA6wd8S8f6iBq3u62wpOTS6Hv6WoKVPCJxqzjxaxUsOLTbAhW0ZdlvWzt82c95/HQYHx9NjpkSyQbeXl+bO3Zfkf4ufM5rYryt+gxYC6zdilWHS5a8PrciriRt1HnFnSr7zwEGy9xo/deNNrNS6QNBE3bxHaMs4sepkvmaR9YCxFoLMbdR5N1xkSbNZd1wbkgc+G4JfMe7pEM8UTGGTdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p866NJr0Toi4GqaP5yMVOzjdI7wh03C3AGe9IzDtjB4=;
 b=Y9m0BLaZb8UTGTkrTPsDNwvTZZXZEhciSqmzsJxGJvFuTea88Zu3KOynxryxqDbXrGQ+/DCyq98OuoMY/vd6zL+Q2kJNlgH6EmG+ozgVM7DKKjJeRASSuX3LiH8We3Vn/t3bJnJBv3tR/ctbjBeT2tTXiaORRVwLtvD3MErSujb4+CaM9HhT7QoVka/psMXBJ5d9Jvk4uPGDg0pyonmRSjKGucwI6VuE1e+/mJseAEDf2/fLjJMY3TPnFDZ/Ciq59OMQ2zWyt9n3dfbU9akzXesec8THCZ9zdMMr4tdg3a5tS0nknFXP7p5msCnEbBJFhQOhdd2etlhqyZw5WHNHEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p866NJr0Toi4GqaP5yMVOzjdI7wh03C3AGe9IzDtjB4=;
 b=uKWdpkyDWXYLAhRo19lFIPAZUr5Gc5duQaw5kvw8Cuz1lG1A6AqN9sK05vbLexA59biz+MNFfDGnd4JQCgGcpVEQUHl73mhGe4B0FjyRXQRsIhgu3LZXxi4kPBn/uPbj57pOG44LOXjAx9Wt3gdXpntbPgF1RmLC8eRojguNiQ4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Sun, 7 Feb
 2021 05:25:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 05:25:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
Thread-Topic: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with
 blktests nvme-tcp/012
Thread-Index: AQHW/Qz4wyJ1jVpJcE2ugUQsAFy3zQ==
Date:   Sun, 7 Feb 2021 05:25:03 +0000
Message-ID: <BYAPR04MB49654E940FACB778A787B68E86B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9428fad4-e306-4008-f55b-08d8cb28b8b9
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB60245BB74781EB0ABFC8867B86B09@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VS3OtKWzOybIkNu7uAbFMBrp+NSHTiwBKGeEN4HEfzrJqdwzNa/mRGHNlKHhypPoh0LWE42UbEykmJY3QcL6UMgOrfgAy8jAe62Q2bqcnRGfTa3iZ01uj28kg5wIVWrPN/KMo5v8a2XaTrhRLBtFfmIszUbbU1jWlZdrn0jUKAtIdYkVVmW26cRXLFMQywxxZDVy710xDNEp4ajLVNi/xhQ6WOW0vcmzxsA8tbSmpF6joHFMSJIF2898wGVOFJoknsZWtr1OITJ9QBKwPTLM2lNTivtZYyBhzzYDaBjBQO+I3F/F4AUVkDNDlx41G0q9v3cpe+f8ACjAxggJFh4EeDkVhcdKe0S08Ra2Sah9xADikoH5QDdxXFngR6AuaehEo6fd8v4/Mr/+VSfZr11TwKmRfBvlnYM+YqVsBjp93XwuV5qWgnG/eVYvTw6XLFyFJzs8A8vWcraiRlIGu2wNWgmaKi8hy4nNvYChl1s61PX3V4Uxcjew6+c/faSo2f1A49iy/dgyw9HFY+5ZbmKZ5/j9yIQ+4TmJW1fqP/mRBvbLMQAgOGwvBnDF9t0nNSA0z5ardwQds49ieIkBhc8kCyobckINsWZFaqXVzD83XTI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(9686003)(55016002)(66446008)(966005)(66946007)(7696005)(8936002)(4326008)(83380400001)(66556008)(64756008)(316002)(66476007)(110136005)(186003)(52536014)(71200400001)(478600001)(33656002)(86362001)(6506007)(53546011)(76116006)(2906002)(8676002)(26005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?thALHZXKJ6RLatbFKDO/YwQAxCduOXLawdE7YeNb3EEl0jMeQ2PdIuab9Tex?=
 =?us-ascii?Q?D5O92+6fYPMIU5pXE6VcR7+lsDJmaFLH+PBWVAOAAnoxZ2KCSy+O6fyPU6km?=
 =?us-ascii?Q?oZjPYjAmbXuJftjePOj18sQ8pwls8Nn2ivjfOk2P00knZf109tenpngSmHup?=
 =?us-ascii?Q?be/sxgEjm9MoIRje3j2xSoIKkCM3ygDuoe4B9JyN18RJIz2ThqeUYmoOD0/f?=
 =?us-ascii?Q?r9IZ0F9z7m1yRpEjAVjW0BniBLz3eWd3UypNPqFmRR7+DtPYMvipRtcTeK2p?=
 =?us-ascii?Q?qQqI/in68w/G3oOybPo+o+xJELWr75jFemQBjlp6i5ML29mHBk3t8+MNRIaH?=
 =?us-ascii?Q?oAmqTTo1l4YwcOWVybM1rlQyguiAtoKrfmPGAn+37YLgbq8uzthojm6GIXvd?=
 =?us-ascii?Q?NlWstpFFmncIk4iP8+28AzKa07GtIP62YsP0dSDdmaSuCh/V+zWM7S8JqXcv?=
 =?us-ascii?Q?cWP1OWl2awkskPF4+HNSisEoiUcm4qxRS9UGfCg3hYt5ElE94tBMujB60+B+?=
 =?us-ascii?Q?ycY+lzWHpuTrEOF3y7MDIe0M7fQnOJXPvjAmsNz2O8a9N0NlekbyOlLvgg1w?=
 =?us-ascii?Q?kTWZTODE+lGh1lZqdt8UmT6ZuMRz/MEofy0eS3jjqdBgMh53gjujYSi4NSOq?=
 =?us-ascii?Q?rQJOpQhuAuR2lXzNFfPVPffySBkCmCmscvffVEFMzJFNZfXa72VSg3OxLCjw?=
 =?us-ascii?Q?W7HbeIpx1guZi3jVEWZgPzA+twaR2op+Ihif0KYKcH3FCjh4SEec2r/iNCe6?=
 =?us-ascii?Q?Kj+V/R2nJ0TfOBq/utBJBB1vXUGUmGDZw8y+EP76r2e5Q12/vXkEP++yD0Xz?=
 =?us-ascii?Q?R0aKJ8s+Dg0hvjG+6xy/KHbBTGtuGEyRT2PFUOAOf90Gu9uSn2dh0AFEPyDG?=
 =?us-ascii?Q?cjKrOgqa4oK6grjhQqMYKoeis+AcLfmIPON123hCJqgxdfpJXBBmPkiziOxI?=
 =?us-ascii?Q?rap3LC4262sy0dYFysgTVV2xomHEOlV+NST66joRgz70VDsJRw8lVZOcyXG9?=
 =?us-ascii?Q?glu0l1TClo5135528eQieyHtmQeLRDrX6d5Vx7u7d/p52VoaQF8eXs3sZI3r?=
 =?us-ascii?Q?qwVda5HWccUMp3LNvFqiY+H4gYT1w2ZdD7nikv/XMBYGMZZVzFo3v7XiwEU8?=
 =?us-ascii?Q?dvXDuA/4bxtGurfqUUOMEh7tV4OaFNYS9wTwiq9I/Y7xw9yhaCmooqZ4iu/x?=
 =?us-ascii?Q?p6zdsmMbpLvWI1KMGn5EElWhj84/WYKHPo8LZuw2+Ie08tBrE82EFlpuhAE/?=
 =?us-ascii?Q?qZQGjpRxLvbHG9Gg6NR0JuL6KzACYZZ8HhkazOX1CEbP3xiShQp1uzAAyrYz?=
 =?us-ascii?Q?MOr9m4dRijZerfKKy7tt8EEd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428fad4-e306-4008-f55b-08d8cb28b8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 05:25:03.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSraeEN49NT8DA7LQrtpNGKFDBCIHGf+vpiMCrHqUJlrK5Dzv2DIbOzyEsT3sYOEv4NIOl/z3HfRycxpjWWXQHVXOCZUIGn712RSpNq1HFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi,=0A=
=0A=
On 2/6/21 20:51, Yi Zhang wrote:=0A=
> The issue was introduced after merge the NVMe updates=0A=
>=0A=
> commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)=0A=
> Merge: 44d10e4b2f2c 0d7389718c32=0A=
> Author: Jens Axboe <axboe@kernel.dk>=0A=
> Date:   Tue Feb 2 07:12:06 2021 -0700=0A=
>=0A=
>      Merge branch 'for-5.12/drivers' into for-next=0A=
>=0A=
>      * for-5.12/drivers: (22 commits)=0A=
>        nvme-tcp: use cancel tagset helper for tear down=0A=
>        nvme-rdma: use cancel tagset helper for tear down=0A=
>        nvme-tcp: add clean action for failed reconnection=0A=
>        nvme-rdma: add clean action for failed reconnection=0A=
>        nvme-core: add cancel tagset helpers=0A=
>        nvme-core: get rid of the extra space=0A=
>        nvme: add tracing of zns commands=0A=
>        nvme: parse format nvm command details when tracing=0A=
>        nvme: update enumerations for status codes=0A=
>        nvmet: add lba to sect conversion helpers=0A=
>        nvmet: remove extra variable in identify ns=0A=
>        nvmet: remove extra variable in id-desclist=0A=
>        nvmet: remove extra variable in smart log nsid=0A=
>        nvme: refactor ns->ctrl by request=0A=
>        nvme-tcp: pass multipage bvec to request iov_iter=0A=
>        nvme-tcp: get rid of unused helper function=0A=
>        nvme-tcp: fix wrong setting of request iov_iter=0A=
>        nvme: support command retry delay for admin command=0A=
>        nvme: constify static attribute_group structs=0A=
>        nvmet-fc: use RCU proctection for assoc_list=0A=
>=0A=
>=0A=
> On 2/6/21 11:08 AM, Yi Zhang wrote:=0A=
>> blktests nvme-tcp/012=0A=
Thanks for reporting, you can further bisect this using following=0A=
NVMe tree if is from NVMEe tree :- http://git.infradead.org/nvme.git=0A=
Branch :- 5.12=0A=
=0A=
Looking at the commit log it seems like nvme-tcp commits might be=0A=
the issue given that you got the problem in nvme_tcp_init_iter()=0A=
and just eliminating by the looking at the code=0A=
commit 9f99a29e5307 can lead to this behavior.=0A=
=0A=
*I may be completely wrong as I'm not expert in the nvme-tcp host.*=0A=
=0A=
=0A=
