Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 01:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A95610A0
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 01:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhKJBPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:15:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25404 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhKJBPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 20:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636506788; x=1668042788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TQ0PIOFWYEplmtg78Zll/mTTt6GzYbORs12AYgdOlFc=;
  b=aeyCeN9+b3ROMvt4ttRUIzhaO5AgyaJ7AeTFq0JEMW+K2fsvYHrX0oHA
   giNpDQRUvC6mgnhnh9d4YC6Y6ozzaFwNqSyhuY08YoXpCmSCGSM27VZg3
   sLCTR+A3iR7ipCWnYrCnEjbsorP9oZPl/vSAP3EGX5GvxuQ4qTLmY204x
   cAc0ZlcwPOb8mB9iegeI4Ag8lbhIWEKihDbuRCQHHw8aubI5iAG8MJ2qB
   bS2VqgudJZg7tVRf7SiocDKRmgPT4FmRyXzP3G6r/NlEOoKNbRnzPr01p
   Queh0tMxOvnQFbhmxhHKhmaBpOA2twB++NDvEZPK1R1N8gJUZluItfxYv
   A==;
X-IronPort-AV: E=Sophos;i="5.87,221,1631548800"; 
   d="scan'208";a="184188136"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 09:13:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFTisKK8WzgbwRLbQCOJqR+26exSVegGJR86N86MJaFHclS3ofDGK17eidtcY+xUZLRciNkn1Ms00OAyB7FelmSWJ+PSigNifqBP1ztxnW4usBJneiXZcHB0aXig1XwcldU46XunG9rIcN2iGMwp4o6DgGcb/uv8n4iTfEp6XILFZd3t3aTb5G3H212K2EogxZHu792dX4LKPUUEuLea59xuYq4UBC3/8ybhXe4b9hsylFBw4cC1hUZ/AbaS5DvPwJV0f09ydjNnkGCNFiCiN8hO3iqC8ASJO14OWg+M+VLQUONh7+27P/zbRsHC0bX0RnTIz5OyCWYY9J+BgeS0bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANw0oq0ydTn3pF6in9h6p0IddATPEsqCoBTfYJb563Q=;
 b=HHmu9/zSx7FJLTbTzVsZl/cKRJBXCEu+PT+GgjVflYauUSUBRrVSCMsVPDmZVwkcAgEeUUOMzOqcqT/mYqVAPU6Hj5ytXy3J5QlqoiVgU+KuKvS9NfPAupbOc+HBDxOdXKBraQlyG/il+CYXWuutYypLyOc+nm3r+Oq1VIYwo9iTQqXl/eMLe28NUbPnlzUO6i1AJWH5tOlAeUHyByvlh+esV8UVcvt9pVnNx4FoHYePKeHNQEjIFi0KCxqwUI70fBa6S33kz8B8krWLUFXeX9EPW6cueOteMW5CL6f5oFvc/4AKf3KOJhXngr4I1llyMMLFWmLNrutv04KPVh3BSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANw0oq0ydTn3pF6in9h6p0IddATPEsqCoBTfYJb563Q=;
 b=d8BDVMowKSc9SyqSEGIuraISnyZHgToC2gDbaCzMANWrGa9DFGg7XtmgNw41Iy2+yKw0Tx2R4Z3Hb7zb2UzJcgmwWugTdhT833ZYymp3kiYsvvU/0wcZZLivDU+qY9Jf/EsKzpLwI9F1DYs9KI4ftAQ1QjG98IU12gtRu7MmuY4=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5574.namprd04.prod.outlook.com (2603:10b6:a03:e4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 01:13:06 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4690.015; Wed, 10 Nov 2021
 01:13:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Topic: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Thread-Index: AQHX1VcwTtZXEjytAECIHF5qRqlc+Kv7QrgAgACy04A=
Date:   Wed, 10 Nov 2021 01:13:06 +0000
Message-ID: <20211110011305.jkhbioramvjygy3n@shindev>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <de540f73-a512-0ac4-c822-d84ab931957d@kernel.dk>
In-Reply-To: <de540f73-a512-0ac4-c822-d84ab931957d@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e81422e-955c-4dea-7d22-08d9a3e74076
x-ms-traffictypediagnostic: BYAPR04MB5574:
x-microsoft-antispam-prvs: <BYAPR04MB55745D4665738067CED82F9DED939@BYAPR04MB5574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7hGoq778RarLGhLxRvT5FGo99eExOiREQZeiG9OAyxBXjJDEfzVOy3/qubp31YGsqC9aeEuaRozHFXxv3mrJVQ/ikAhvxI5olNIUifbzYtPx+LbqTuryW65IrgzdlKJcb1pa+tMUrKMj+opZ5x/EzbEshda2ThwOb8q2o7TbbwszoY6S12KeLpxd7YpsUCFnzV0VKIgNyrSQWoMp/wchAcBAjcvXywfGn20hrfS39ssL9igy2aLJ4uHcObBjuVZSPbr2ps89Ium55aEO6f68E2qs1xQUeLwZFMbwnMsRAAP5IHHJPfsiSm+fPou+GwQasSMug7cB4XsP2SNxKS3vyGSUw5DUk6inFtSAfdizcRopD8bNrUyyd1hNOfsCmjY0YvWxXDwrDyV4KMIONigAVtRXkmBTrNTLQFyDf9WlV8z41NTnHP4Dqr6mXiPcykwLbp65j27I5MZ6GPFziT4I1ZeIG7HLO1CmqXdRsYPYEXnDy/4L4kRqtYI1ibgSLNG3SnaRC9rHMFqWc6nhA5E/9WgksUYhOcJw/3WpPia2vfvsSD9+kgsb5FvHVpPYUqB2HYABbaViD9RtYwYym0B6gqbWu348pDoqyCX7pE8VnqQ5LrT0aq7zkeo/W1nO0nKLO9KJhy3d1qvKgfkj0zJGw9wUMLVsIphbVduWVc0C/B6sklwAgCS/pUwFidj32bC4ih3FrK6ct7o4rn2S3Upn+aaR3xokBoEjQcaaNQma/IIgiKc3rmv9gFrm1Hu7wSHTKJNaEhPfpzcoffKQE5h6rMf/pDn1j4IZ/TEGnSeimQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(966005)(186003)(8676002)(76116006)(38100700002)(64756008)(91956017)(6512007)(53546011)(33716001)(82960400001)(44832011)(6486002)(5660300002)(26005)(1076003)(122000001)(66946007)(83380400001)(66446008)(66476007)(316002)(6916009)(86362001)(9686003)(71200400001)(2906002)(54906003)(8936002)(4326008)(6506007)(508600001)(38070700005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E1f0nUEKihZoP4OppFel5FB9dZ7dz+HN1ii7qJIN213HrP/5b+CCEHNkdZZq?=
 =?us-ascii?Q?JXv4ZWLLua5iJKrS1POlhc3l0aZe7fFg+vMDii7u4IaVY1KheYRT+VCwgcIi?=
 =?us-ascii?Q?2lMCuAqJEPiT7R609gO9eUiTe7NkCZ/WymW449Gd7cyDXYQRvS2NzJLMATF9?=
 =?us-ascii?Q?E0otXMYE9dQ2SNZCAG4xi8ODJ0VWNiQfyMrn8y0FHHwaHxFotZ0qM8LOJxsM?=
 =?us-ascii?Q?uyDbtFDrMAZfn79iRoN3l38keKRsSbzR74BbrUEp/0OaaDq6s0SFH7ouKJ07?=
 =?us-ascii?Q?GV4YEPLhyxYcC6u44qiM2kWKf39Zbjka5zqIUdnhFUIft8UeZ7QsO7LWIuVC?=
 =?us-ascii?Q?aNbaL4Oq1j4CT5TsCf09kFx9LYevBe62Pm3jmZlg3Gj8W3hL225+0XHCSplr?=
 =?us-ascii?Q?bzW2XClJEPKqjLTXuftoRKflL9wSZOHb9msynyu6ofHjqtCvhl1DuzI0fbjL?=
 =?us-ascii?Q?etQdQcF7sNsPTSdPwJ9+b7H+QurouZkMwAHnoc2GWPHWGHdC8cHm+LzhrsUd?=
 =?us-ascii?Q?fgDYmjQ/9xe4vEEKzpQaKOAJRMgew+h1V0l4aZ5g28zcq8BsCI4Qyk7KP0d5?=
 =?us-ascii?Q?ohP1VrZSIfL5wTZNO3CyLctC2UW5tKcv9uMIAfdDDp/TZl8NNS0S/POu3zob?=
 =?us-ascii?Q?PzlArt6aFq6DpF4G+QDjy7vLgyORz/qiMV16tcsZJ0Th0rgXtumF4npRDSdH?=
 =?us-ascii?Q?/RGz7nvSrXvsjxGQ6HX4LiJ2tMYu6CQTHRJiDiv7qOKkeTpPqWGetpnBz9t/?=
 =?us-ascii?Q?yGVfRSG3rCpxVTDTkr+SJgK6Ysizwlyu2L12uLHpfJes15WmZNG2wQmZCp0b?=
 =?us-ascii?Q?4MDavB/aewWTZCbTD/oWXhATxndZi3JW4nRxIrrsPStH6dPoYZQghoTH4I7P?=
 =?us-ascii?Q?xZ9j7rXFOCSLt2WJ7fUTCeORhc0nEhcTqy8iCa2MNvuX0TmY/bx2QHrdqSJh?=
 =?us-ascii?Q?3yRMuQq/IlnRTOpI0Ti9FFnlcO4fCTyYnqCtAHY1zLnpS6OHok/rcTQunCvc?=
 =?us-ascii?Q?CRN6Sl+y+Hvq9XMR6O/IfFeGF6ZFxw3ZOzZHdLrcR//NovrBupZ+QSu+Vxdo?=
 =?us-ascii?Q?6aRRXyk3py90pFQMw4H7LNZls83F4nba3TLfGn3Mjrdon8T3ctbiV/y0U5fn?=
 =?us-ascii?Q?ikkP3vMq5XvvS8t7JTrZiOJf+xMNNcmJFQyoulc00mAsfW5kv/Mh6QC/GLk0?=
 =?us-ascii?Q?ddnWHqhjJBOVTbI9feo8MlDTzwDe2JAJvpLDxTQSXzwaRCNySavgTIBwN5W2?=
 =?us-ascii?Q?jUeGTRhghQfB0mbKEumos1ho3qr6RtMfn4lWX1q+377TKFcCMcxeItwJdU+s?=
 =?us-ascii?Q?eI3h6BQlOdnbECKw69qe+tdUIshebDHCH7WPrVTU4CQPdepGCPdZuzJE65rm?=
 =?us-ascii?Q?ZsdI5HXFeRwfD2GmtyQPTBlB811KkpiLPgWL/HGD8d9KHs0/XyyFKHsUsk/B?=
 =?us-ascii?Q?ihKg0xHBXmNwqChbAOCXEi2PrlLUrzVBmBYov4zqPbsUcu+mMgAQu16UXhOq?=
 =?us-ascii?Q?0CoAYtO+bwektcqRh1+0geGFQmx3Yp63EqQnXws/Eo+XdWiN+/Jw49YxPhg/?=
 =?us-ascii?Q?0RFfX8zhPiY3JtEYdIIrDtOl/i04Z00TOoPq/0CTGO/OIV9D8WmxYdaKbloB?=
 =?us-ascii?Q?4CGwx6TOOkUMkaNaFFnKN/ShZBPWsmHg5t+mF1NI/9eLo+zFxoDGSWEiOpzW?=
 =?us-ascii?Q?4LNNKXwUMRQkr+O8pGsp1Q7Kbhk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08E8A515D4E68C4E97D5CCF4BE307B55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e81422e-955c-4dea-7d22-08d9a3e74076
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 01:13:06.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6UaMGOPL8J4VcJ6dp6l41cZ+apmeVGeBVbKVIOjOrDgpmC9iQhKljIpX3sETl2f5BjFzE+TGrtu3vs79gyLorPjBoXsjl0Za0Ru+ghmKFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5574
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 09, 2021 / 07:33, Jens Axboe wrote:
> On 11/9/21 3:47 AM, Shin'ichiro Kawasaki wrote:
> > When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cac=
he is
> > left. This patch series have two fox patches for the stale page cache. =
Same
> > fix approach was used as blkdev_fallocate() [1].
> >=20
> > [1] https://marc.info/?l=3Dlinux-block&m=3D163236463716836
> >=20
> > Shin'ichiro Kawasaki (2):
> >   block: Hold invalidate_lock in BLKDISCARD ioctl
> >   block: Hold invalidate_lock in BLKZEROOUT ioctl
> >=20
> >  block/ioctl.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >=20
>=20
> Do you want to do a v2 with BLKRESETZONE added as well? I can do these
> separately. but a bit awkward right now as my main block 5.16 branch
> doesn't yet have the bdev size changes. I'll queue this up post flushing
> out the remaining block bits for 5.16, if v2 with BLKRESETZONE happens
> before that I'll just use that one.

Let's separate the BLKRESETZONE patch. I'll need some more time to prepare =
it.

I saw the BLKDISCARD and BLKZEROOUT patches queued in the block-5.16 branch=
.
Thanks!

--=20
Best Regards,
Shin'ichiro Kawasaki=
