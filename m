Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F2C433DB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F131564DEB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhA2ATb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:19:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43134 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA2AT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 19:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611879568; x=1643415568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SFueZjveC1SQyXYWMxfzXDkTtWUJa1YdXJvbEKjVJFI=;
  b=IJ7Hw4+EQ+uFiJyLtOJ6BA2D9IveZyXULss6PnzgVwqeoN0jp3a1Riiu
   v85guPifrnPpJRwCNZe/H9pxsXQ899eo0qQlY4f2Bla1vkPBcfuzpOe/M
   hmXoZ7kAXJOd9U/9fZCL/WKQIPqoZPN5KrAzTWBUfuGWMprUBofDdapVq
   KhDo3QjsCqTlQ5rMThR59104TNNN2O+t2ABbKapboSQ9hHDa7uxr2h4Hb
   TOY2IZ/AvniOV1Mp2xmF8CCh1z62ZiD4J+VzLl0eRqJAHqRUm9hp6M3bZ
   cNzrMDtm3HN2VEHi6oEExcMbHaIwlOj7d13fmabDsyII5OZhENQ7pwQ7i
   g==;
IronPort-SDR: P57JIXpfDbk2LIXUMRdIR7J0zRiOz5bYFNPzRcArU8ShxXn8fRbariqSrQWWYcYBXr7AeAEX/c
 PYJvU+szREbBy62JAlc8P/2x+GuyB7PlKKIXWe40N9oLLMuN2EsWdIUiNWP1mpIX0VswzvPt0g
 yfiNprHP9AMBlHfpsMFl1G8ScDFXxWMzx4Xwx5Ck6+9NRBp2gkJbF38EtG5qjGmih3VIFQr42L
 QHR66h56GikH8bwNwj5WI3kjlI+z8sbAWB1gb4KwFmouHJoNLZNd+rm2zNofrkQZQSobF/oti9
 o+g=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="158587777"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 08:18:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAESHL11N6bcmVt7kC155iewQu+HX5oox49AxBy04yONXvYHUjJdwYyvKwsr+cU+KzwcTbcCLJ+mEQPl+TiP4uxrfjab3NI4O1Xc9PI6erRfbVFDSi3d4u3ishPQQ0nN0Dmq6p8sqEGNESBkjDV4j1/AbynU5RfSawdIdsFW4ZskFI9H0aeHJ/C71sBB3y1f6d6ZpcfzB1rQJIDTQciRBRj50a59t6QgriTntfojjrRP2qZzb9YGDB62vKRpfifXVxLDUUKPrTDSQdgoc+UeFf9l4BQkqcd2LgU2Vu6kbACsWWjIxQqKD/vvQVnVN/2kJU5lhTVweHGyGXUAVagD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvrmHDvKfsZK2HkYiBA1mK/HDqFneTM4SJneu8bXDhw=;
 b=NEhiFN5N0hMA3Ozu1y5HjF8sHNnusF+49IExHxpKTH1o+AM8gT6jca7cD0X8o4MmgXkoY3CgRK8gTcNdu4VdiEhXQ7KdPbVGM4pwwC7rdFuRxxRuqjalRYuzU7/HgCdS80UFKz/OoNFguvBg0RkKB3uyIrhcuAz/kfOMGUcFTnlrCCrTOXEY2fWxum8Yj7V2Y9PjNKAj30H5I4WD+0vf1CG/ToGJAapQp0JzU8q+CET6H1XZEx8tHCdPOUyEuQr8eqXZBc+c9uXB8JqDIxZACeuJxrs1vKfY1nEQcPrYKYo1E9j4dhASeMsX4oCIM9LQS28x2Iz3n4Yv7fnP4Jd7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvrmHDvKfsZK2HkYiBA1mK/HDqFneTM4SJneu8bXDhw=;
 b=XIzVMJRdMAXGG1Apfker08fQUZZf31votxWQoIiTlOC0NR5SksrGDTM4HI4GW+bQNDlp/CFpQPrZYRAJYIyMl92hOryWA5zIj/iUkUU32H5XG0PV9Yu2KZmbWiSgqnbx1j6ZT3BhocDbZJl8Gv1XubnR2SKyxY+gFK6wP3gWJ0g=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6671.namprd04.prod.outlook.com (2603:10b6:208:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 00:18:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 00:18:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "hare@suse.de" <hare@suse.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "pavel.tide@veeam.com" <pavel.tide@veeam.com>
Subject: Re: [dm-devel] [PATCH 0/2] block: blk_interposer v3
Thread-Topic: [dm-devel] [PATCH 0/2] block: blk_interposer v3
Thread-Index: AQHW9ZpYOoPcS4N3gE2Od1Hg8ibopw==
Date:   Fri, 29 Jan 2021 00:18:19 +0000
Message-ID: <BL0PR04MB6514A510F37C59F52D87E2EDE7B99@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1611853955-32167-1-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8103a45-f76a-4589-c4c5-08d8c3eb61aa
x-ms-traffictypediagnostic: MN2PR04MB6671:
x-microsoft-antispam-prvs: <MN2PR04MB667116131FAF1F092C2002B4E7B99@MN2PR04MB6671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxS/bunBBSIB9Mv8/6ICFgDQzMer68QYJxbrYTm8PsUApQ2M3XZnMZMTO3WWkRqTHfCFz8pFFYCdhu3Blxff+IjJ+YxMfD1XxcZ1+PN+WouEwDvYh61GoRgP/gRSiH/+GtFTQoUhSxQLFAUQMMkC4x6idtgaZ9l+jnIVfUkAd8WgjI5DToussKrokU2XGm0EmKdnbwHgkz00THk/MZUNCsdii3H81MLS+5/o8q1rTqxWzfXSwrF3xWrWAtzgf+ApEimmdK8tZqSTIVud7C11GZQKWx7i6XHHlARFbJR/ziopbzIhQiTw0WOgesqm3dX2lVBYAjMum2EUTlcIP2OwejX/qOwnBQcMd3IJT+MWltc8xDsWXFx5zBcf8pL7GOG41S0Hl5n91j9UwGHSMYaQhuQTA/C1C3ksHnddADxx/sZrRZka+MYH9EoZsGnXEzvQ8c/zjyKTYEy3l5xRv4xlSYc4DjH3/eaQfkZs9fQ/A6p7yJsTRaKejkQwtLJexjVIWXLNcONEBMEnwQ9QoCUrPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(55016002)(9686003)(71200400001)(478600001)(8936002)(86362001)(2906002)(52536014)(4326008)(7696005)(33656002)(8676002)(53546011)(64756008)(66946007)(66476007)(66556008)(186003)(110136005)(76116006)(66446008)(6506007)(83380400001)(5660300002)(316002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wGKJIzdFKn80dlBxH38hcZUW0LUhQsdWSCpfECTDDIDCrNjLMzVJ8i3cos/G?=
 =?us-ascii?Q?/csJF4SVMvp8pCy5rha62MrUaNN8UheTLK1DcD5O8S4K1flNMYgZ5kpsuAUN?=
 =?us-ascii?Q?2gCrgmrF3lEqxkLovKZHdivlZsvyW5CGGK0j6VdWbHcb8SfnStV6FUvqC6GN?=
 =?us-ascii?Q?LsMJ/osBcM9UDxY35Jil1o89ek6Iw93T7y5NU+/RS3zelBOzu6bltloTXqny?=
 =?us-ascii?Q?FvyVVJxVwq9DR97gL5C6hkpeisSfKZHOhrlDGm7GugjBu9pUpnMiv2diQdCx?=
 =?us-ascii?Q?MRxcc4lEG9XrnNEdImLXaGZRMeUKpC7MAHdxlnS5AjZWtRz3pQ1rTom3VRZ6?=
 =?us-ascii?Q?rc52onk8FDKwGOE6TR2TR99JPX/Fapzl+1zVYCwf046y9BZR9DQkjEaRhhcI?=
 =?us-ascii?Q?4Ew5RfJ10X0hJlawWWb2a6jxtFNmeWIi/mMn14BWsTrXhv5p6tjuuIKyN3Om?=
 =?us-ascii?Q?/SZsb6Ye3tYJOy03jXNKwpqMJdxXaCzkT7ExJ8czkO21ZWqbqfqzGPb5iwHf?=
 =?us-ascii?Q?dtXkFvXiVty82XCmDwLmEGDhUriFQ6z+rX8xrJ95LHe05S2TutpmjQCpJfjF?=
 =?us-ascii?Q?lyrf2jzCPpd/rJpgWFAjxkvxZv2nnmOFpav5WOVV7y/TDixNhxPHj5Noe7EF?=
 =?us-ascii?Q?tIMCcGEoPdimoSAcmZAHTGeq9xlPnsh665GPDf8sjmoMOVreNiLDFQs9FRLC?=
 =?us-ascii?Q?RniLOJRIoJLcFMrpM0rX69TAtjZjf+aUMKKqf88C0nFOCuaKSfqLhWYihPP8?=
 =?us-ascii?Q?490VrcPkDyNI1/wFDqR4Zh9E2Vl67Lx2kWFE3UVHNJ+lpioM1h5+k2UTgUKt?=
 =?us-ascii?Q?PdBY4w4PcmZ9mjNBP5G0aqzLIEnbG+N83eSLc3QB9h7F2/V3Ar3lzVMElUTr?=
 =?us-ascii?Q?zDI0sM52cJMpp6+lgui/LAvlSOPfVSXRFhQ94VJ7uaNgby7h6Bs1nHZv9iwW?=
 =?us-ascii?Q?LPXe43E3LWVq6/AdFZyqNhabtnyhtoV850zlML2+BH6JDyW6vMD0KketnD9C?=
 =?us-ascii?Q?a3tv9ZqjOWr2mTd0gPwv7BsGam16aSul4T41yv9/33TmyTLCt++TZ6vtUOCb?=
 =?us-ascii?Q?dRDFlBGfOzJnDFYiLdf6JftGZ8wsk5j4YbGSp9yaJIBD34oyneIbBO6SChEE?=
 =?us-ascii?Q?Amb9JF+03SA9RR+PH90HyaDgFueFnP5I/w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8103a45-f76a-4589-c4c5-08d8c3eb61aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:18:19.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0NKIxynenoZEVZAtAy/CnX7erBkC0mBxFjLw/Dmjjs0NjNGBf0nplG09i4+aOgkiAV7+pwQoU8qJXfLWDcsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6671
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/29 2:23, Sergei Shtepa wrote:=0A=
> Hi all,=0A=
> =0A=
> I`m ready to suggest the blk_interposer again.=0A=
> blk_interposer allows to intercept bio requests, remap bio to=0A=
> another devices or add new bios.=0A=
> =0A=
> This version has support from device mapper.=0A=
> =0A=
> For the dm-linear device creation command, the `noexcl` parameter=0A=
> has been added, which allows to open block devices without=0A=
> FMODE_EXCL mode. It allows to create dm-linear device on a block=0A=
> device with an already mounted file system.=0A=
> The new ioctl DM_DEV_REMAP allows to enable and disable bio=0A=
> interception.=0A=
> =0A=
> Thus, it is possible to add the dm-device to the block layer stack=0A=
> without reconfiguring and rebooting.=0A=
=0A=
Please add the changelog here instead of adding it in each patch. And keep =
the=0A=
changelog for previous versions too (i.e. v1->v2 in this case) so that the=
=0A=
changes overall can be tracked.=0A=
=0A=
The proper formatting for the title should be [PATCH v3 X/Y] instead of add=
ing=0A=
v3 in the title itself. With git format-patch, you can use "-v 3" option to=
=0A=
format this for you, or --subject-prefix=3D"PATCH v3" option.=0A=
=0A=
> =0A=
> =0A=
> Sergei Shtepa (2):=0A=
>   block: blk_interposer=0A=
>   [dm] blk_interposer for dm-linear=0A=
> =0A=
>  block/bio.c                   |   2 +=0A=
>  block/blk-core.c              |  29 +++=0A=
>  block/blk-mq.c                |  13 ++=0A=
>  block/genhd.c                 |  82 ++++++++=0A=
>  drivers/md/dm-core.h          |  46 +++-=0A=
>  drivers/md/dm-ioctl.c         |  39 ++++=0A=
>  drivers/md/dm-linear.c        |  17 +-=0A=
>  drivers/md/dm-table.c         |  12 +-=0A=
>  drivers/md/dm.c               | 383 ++++++++++++++++++++++++++++++++--=
=0A=
>  drivers/md/dm.h               |   2 +-=0A=
>  include/linux/blk-mq.h        |   1 +=0A=
>  include/linux/blk_types.h     |   6 +-=0A=
>  include/linux/device-mapper.h |   7 +=0A=
>  include/linux/genhd.h         |  19 ++=0A=
>  include/uapi/linux/dm-ioctl.h |  15 +-=0A=
>  15 files changed, 643 insertions(+), 30 deletions(-)=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
