Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB34C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGUGdF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGUGdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:33:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95CFBC31
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658385183; x=1689921183;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VkLAvTZtszzKIRNc2VRCKK+8bcEiz3yoso0mI0OgCn4=;
  b=p5TN+U87QHTkb/Flo8cjhP0o9gL/+fK1qN1Jv3IBo5HxGeR37zulR8KH
   lco0kN++ZwdqcBCzXCYcyDDBCPZ9/lovBMssbo755Qz7sK5K0M3+IvSYW
   IRfcxagB7QCCoAGp9jLc9Zfo967vhBQJx2FWKS/sQZAq0o796HX2uKSLM
   wPEClvuuYOCpoG+PgsHWf6bCwITM/6cKaZERCBltGNe0JtZNOxaQmQvXx
   hEWAMljzKLdlSyJVNkJ2LJpMXZDR/ZKlg1/1JW3gyrLwtlw1mLbyjFZDI
   kIPU7jUs1YqGmXYhiTQ91RGM093mRdUJhPznaY3hz8eu9S4I/sH7o2O0h
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650902400"; 
   d="scan'208";a="205096012"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2022 14:33:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku2aHa0ySkRMA96ExTXC1Syqn8IEa+4ICJ/z+PsJhUTr0eVWT+EIPlC0rLb8osjaqSaHNsQSTL7opgU5ZyrsFHXgDYjXVmWiFZ9SofsciRcl8ZKTUKXdJK+JmiFMz24cTWuza1DKqIhxsDYySEPhRlRr69D+nozpu3qTqNrbdy/79UOoKSNTUPRJ4VZq0pmLzYDGkhTL+5JbloxolPIj43iozF8E+clot1Me/uhlsXkghedqxhuXaBjfM2WC2QsHwDcFqrC80eu3qJlJRyMzzebYcsnJXKOTVP1oF1o/g8tjDOpi+TDmwKyxR0HMFMgTfiSJnKCWwoSPABgc8AknHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FtCbQJFoNBPHVHGe8rwPN4h5BQGlpX8smkJE6QVPmY=;
 b=l5BZUrsyz+iCXfSgxUE6jcRTJp0rTabLfxs3/zAzQ0pWqLvLL6bJjTwW0YPCXaG2f1bxutuoLx4yGBUSsk0OrDNarJEQ7bdEqJWBnhq/KCJVAom7qe4+Kz8eKVlpLgZrIA54zxbbvYP8QAFsdKcM3PHqai94u+jRaBBRCpTqoG5Buj7Hj4Mh+01Jt7uclzt78lPADogBymGHbLj+gXru6bTFwuFlj8P7mjqt7lj7vwFeuK9uJhRMw3COBejmsFFM0ezHh6gVVMD0GCjVXL2+lV9UotJJwEHyL7Eha0IPOEjMaNITGO0HvP5IDIbvDqZqdOIPV12XaN5QvVwTBr/nRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FtCbQJFoNBPHVHGe8rwPN4h5BQGlpX8smkJE6QVPmY=;
 b=rJHpB/KKofMDV2CImlPGTY5o0miVJjsaCKNNN/9spy6Aud1ke9892LF/OvrKdWDJ+S7iBnQqEEDBMD19K4x+ce2de6W1iw43PCgqSRhWkhS4l2b1hFYzRMlUWsc0JHyAKHNZLBq/iXs9v/G5iAg9hemZlE0RKasHaT8pJbsl1nU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4878.namprd04.prod.outlook.com (2603:10b6:805:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 06:33:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 06:33:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: bio splitting cleanups
Thread-Topic: bio splitting cleanups
Thread-Index: AQHYnESQSBmC0LRYi0CbVwnBPP+4bg==
Date:   Thu, 21 Jul 2022 06:33:00 +0000
Message-ID: <PH0PR04MB7416D12407319489225645399B919@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220720142456.1414262-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 735997f6-acf2-43f2-0c9d-08da6ae2db76
x-ms-traffictypediagnostic: SN6PR04MB4878:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DeGRSa3HjoyIceGWxyJZrvMYO/bFpea9PrCpQqwpk9FnD24WX2Jy2yH1QIU7u2pLX0bH6/KZkQnMzA8oAE0zhU7jGqvlLfYe2F70BUyN0J5sWGOvvL98z/7kIjbcskTVnph016KMSG3BgsMKNqZgim39yR66FjU/aVS6cC/tdfLHRBhBHum32RTXHQYWmdf2Ziwocfdfz9KdM2aZp9q+1lMR+dlfwm7wagbXucVx+yMfc7/SpDxucMVObLTHQ7W+HxoASznFUSOJIOATOPwGNk0XpFRxrBYcvnGzNL3MOsweEpmurOLdJSWYkOtzXtaHQQ+mQKWqoX+/+fDtRNAFEOpGGBOLO3BWtP9YC9W23gVLmgBg3AU2g5e31PTaIR40xJD3BdMEtaGwqULPWcHEektZugh5M/swdtsVouys0yNsX7mnZN9VOvT0ug01ckEcgDnfypxG3p5veR/OTUUnHVeC1yf9oT24rw/jwZ7FT67RAckhXWg8dLmzsAjMm/amdxJav9NS0Si+fYoANBW+DWO60V6PyX6+gP4gg5+rQ//YFwDcDMWhQhjJ0U0Cu4bOTxbizA7rjGWq+yJr5OmpHHWjPnoTims+CZMD+1/RSbhsS4kvizIKDIhf6jVl+kH00JO2nRXtwpzPDNOPQCrubhR9CV9aNWAxFboHnLHRAIULQjUFGjr5Rq3yV+b7HKhlItP15mEzrqIvNmdJbpsv6vaJrQGyoYIZaVeofjOmsyGVKA5XY2W9W5CuuoWlw+ur3mLtNmt2vYupdV4siGoua7y68ME1OFFJPd1VXiCKDy0yC9uwOVdx/hYzr31nSQRP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(83380400001)(76116006)(55016003)(8676002)(64756008)(66446008)(66476007)(7116003)(66556008)(71200400001)(110136005)(91956017)(66946007)(9686003)(2906002)(7696005)(53546011)(6506007)(41300700001)(4326008)(38070700005)(33656002)(86362001)(38100700002)(122000001)(8936002)(5660300002)(4744005)(316002)(478600001)(3480700007)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M72rcg0/lx31C1TjImBfIf6Bkd5wZ9t9Eu7X+sXjrK4hv5SstFtgLcB8Xbdi?=
 =?us-ascii?Q?pLHi4dG2nEpjhjbGegAPFOgGQMuW0cM6npfv1K93nBy8o8/2SyH6eUckEIPX?=
 =?us-ascii?Q?hL7/8E74vE2yGczgii54lHNtkMMeUo8HiNt4jaFaNFk6LIl0aKs5Td9+47v4?=
 =?us-ascii?Q?mQUwKdKF0DErBgVlvb3uUFWCNWjkVgEx/KFXLm+jypIdAVlfy6c4icGswsZO?=
 =?us-ascii?Q?o+nWaPFlKUn53VcD7pLgMyMHJk2/UC5fvH5hv6Se5dqEIu8/wXzduQk4kkGd?=
 =?us-ascii?Q?h0OUodGrKSaDNyYJd7cEFuow76oNgaLyK337IS8m/RYl6X531vTFioxr/mul?=
 =?us-ascii?Q?9kjPkdDdttMJyjHQ2EyM2pyhXw0TJ4cfx2jZlIpLgCB64xkTh2nTIGDhEuFI?=
 =?us-ascii?Q?HmqLgDQKzYRS49KRDqeWRN1Im7hZ4aYaOTgXzB8K2G+PmS2CIUuWza9J1SKa?=
 =?us-ascii?Q?r39JlwOd/RvktlaPjA8KVYgL1sShwA0ZuQb/9luqntDqfcPKEchLcO9QXoie?=
 =?us-ascii?Q?P8DCkz55gMdZZ2m37cRe5RhqO60nA5CXn8gfe5NqOU2vxE1FoPkJ98fhIVyj?=
 =?us-ascii?Q?eXKI3Bo/wFK6Awn+Lxp5wEHThP/QUz5TLZ+ZYwX89lQLuDfO+Ssle6lgmAsh?=
 =?us-ascii?Q?+frcsiYTSw6TM/F3aOyyxo0nLodlgbuE0j168SY+3tW1ZYyWpruYbh14onPF?=
 =?us-ascii?Q?hisMN3po01K11dbgg6/WLsxmUFmfIvhIrsG209g5TH9ZkS5vHPVmgf2BkHZB?=
 =?us-ascii?Q?Qk6CSGkkXvWEzmX4C6fYsvkS4DFZ0I3eUWUi7rRUMvVEsdXvAoxsXl1hnNf7?=
 =?us-ascii?Q?UhxbfG1ig5LZxXQz5shu80WvbdhYecg49oTWDZsctMipqwSJZFLMqYds6T9O?=
 =?us-ascii?Q?sl3YdOD0m6sAIz2E2ms7HEi9NQgThB7CzWbfGTZoXDHLjkKcCj/+J2Y6hFqD?=
 =?us-ascii?Q?9z/hex84XVzWpJytq60glUKrP2RQqKr0c7dlKgGyg+5CUybI6NkXh4SxHlZo?=
 =?us-ascii?Q?/PwwsJKjaPGce6BTeuTNZm5jsHC9T08VC44bIpKDS6CP1u4pMcwYB4lze0JP?=
 =?us-ascii?Q?Tsvt4cNQ3rhkT1s0qlVVlfCXJV+tflMbi0nQe+Gf8TqCGlG1up21QinoKn+q?=
 =?us-ascii?Q?e1vbQeR+QzwMGRJq0v4zrZkUNDanjxCcmuvUnt14OVcu8jijafR+u27dJn3q?=
 =?us-ascii?Q?Z9jBLX2xlMj6X48syLFQvWvmhQ7/AesHaOh6Dy1lKjdonGrHSo8VQrumedxi?=
 =?us-ascii?Q?2w0e3VoGfiNGb1PTe26ZSiDQSBA0+tbUJ3o5U0N6yLukeEQLlfy49pvPYtXE?=
 =?us-ascii?Q?x9CLWKUqpaXAImwqgCfBCu8hQ6cFpcU3SFlwr6cb2oYU/VmUvR/cMSS+zuqS?=
 =?us-ascii?Q?O2mp8ave8zjicifVDeL0BIHOPHzfw4pUKQnB0dyBtNYuu69ZU/G72n2eWiJu?=
 =?us-ascii?Q?D0uIpNiblX7vDGrdjgcUFRZFLbC0oozwPUu4xELASFe+RGKn9Ha4vbVPqT4P?=
 =?us-ascii?Q?Nfx04/S7dZZzlEe2+gMvu+Ev2neJ7ScQEdNaeLTmWpYGqBnR7JR6/T2bIeYB?=
 =?us-ascii?Q?RLPkdWyHbyyIZFjI7kvoaEYYcPWkCNOE5YG5IE5PD6xQgf5YYcTIENz8YBMW?=
 =?us-ascii?Q?ohD+OA4rI74HNWq1Ag8a0OFayCqu358MC50YdnBenTo6tnl9InWMgqcG+kR+?=
 =?us-ascii?Q?d8eEr0YOGjxbD7zZJj492v0bPJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735997f6-acf2-43f2-0c9d-08da6ae2db76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:33:00.2821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGBf5denNHlsNBkeU9Uxtc0F3qraVKci71DLLKpxmHC5tAbzsHJVV59CyOT5Y+w4M90fl4c0RQXNgOwrQZckW9JFSLAKHYEEAUu81czlnXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4878
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20.07.22 16:25, Christoph Hellwig wrote:=0A=
> Hi Jens,=0A=
> =0A=
> this series has two parts:  the first patch moves the ->bio_split=0A=
> bio_set to the gendisk as it only is used for file system style I/O.=0A=
> =0A=
> The other patches reshuffle the bio splitting code so that in the future=
=0A=
> blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios=0A=
> under file system / remapping driver control.  I plan to use that in=0A=
> btrfs in the next merge window.=0A=
> =0A=
> Diffstat:=0A=
>  block/bio-integrity.c  |    2 =0A=
>  block/bio.c            |    2 =0A=
>  block/blk-core.c       |    9 ---=0A=
>  block/blk-merge.c      |  139 ++++++++++++++++++++++++------------------=
-------=0A=
>  block/blk-mq.c         |    4 -=0A=
>  block/blk-settings.c   |    2 =0A=
>  block/blk-sysfs.c      |    2 =0A=
>  block/blk.h            |   34 ++++-------=0A=
>  block/genhd.c          |    9 ++-=0A=
>  drivers/md/dm.c        |    2 =0A=
>  include/linux/blkdev.h |    3 -=0A=
>  11 files changed, 100 insertions(+), 108 deletions(-)=0A=
> =0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
