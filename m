Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96496C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiCCPey (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiCCPex (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Mar 2022 10:34:53 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06FF1704EC;
        Thu,  3 Mar 2022 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646321647; x=1677857647;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XW+giBebIf8t73l2e1s6/NEooD1tiDa78JRUqW8nKr3dbt3zlrL02F2T
   eN2+Mq2Qyr2krd3XxTiCcLPB1FeSJaZL2mCVk2+Bn18E9ehA5AURW4nlk
   tpUHdVeQ0fPhKOezN/BSzsLQJprXYygD6/a4dOYdcIeGcKuLlpUjcZn+w
   fKO0v7oTqm5+7EPRDODc1KMzumccJwyYLcdQ3oFzp1nxdAdLFzNuwLdm7
   6NpOz2TxnT7Xzu+Pot9kQHgLxbmskkUJh9tLNlayM/0d3u1Wo1XB5aDs4
   CCNp4HwOWZoRGhsglptKztAlpDWl+yNqECSJv69rccGmo2RbD70ITsKsT
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="193327833"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 23:34:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVl0ZeCM9kKl20aSMFTUdPbhOXmRPu3Kysc1fLTtZcpu7gUj+42bxHoombXpcsT0SGbvS5Yo9Dkv+03wQtbopWUFJPvKDD84H3So/GOfXu538BaHtE5Pha3Q07hL2H7Vz1xcGdyTsNjh/lq5UstCCbg2kdEFMhor2yfN18f1gNdfmeX3eAipLdIrrlxrOcJdVAynSLpCOfEmxG8yYEBX5lt6A6UvdY0Ybuv4DnMQYnhbOMB/kyZ7X8ZfLMJ5KrwXICe688V6VQ5vzpNB7VjEfs76NObn99Jj12OH2PHDADnk9T8FfnXUuhKq+nG0O9+oC26m1SNqs+xPUsr0Ezd89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CzUMdULzoQkDpKTpukbUe4D0h0he6zMLtKMWcBg3fhgzBfASqJXtXXZJ1UbmTCFeSA1iZu+9oArCkn9A73KJGop18VxYiRgbjjj75RW3vdJH+m8oWuXr5S8V3ncmUlCbztDu4QT1nXksbn3uUwjxw/IKVOWojY5jkxw+ugUOZRYookWV6oFmWrCuOtnpimF8458ZqslaLeJZfRUZeWK2FJf9UlHTX4Mdu2mcxG04W0rOFwnQDiDJcQiylmmHEck35r7BlN0fVhhvwQD/mO+YD2Utlc9HUdHgChJm4u0s1gQLE4QE7o+/ORbBdj981HyjykzbyVhazvijzLe7dLIdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=njJyVO3sVLDgDl0nDWEw2Vmme6Id2p1qz6KWmhs/zCg/UM9MpupY+3YobkGzPKPaTCUTKLegc9cFNxtVAUj0EEtmhUakNitM8LHyArTxVAnysQas0dIlrwioRxPCWihdvV7CgalYB4UwYPndqqsXZYP+ruTApH1Ce5/DBx4FkF0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5031.namprd04.prod.outlook.com (2603:10b6:a03:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 3 Mar
 2022 15:34:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 15:34:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Philipp Reisner <philipp.reisner@linbit.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 2/5] block: stop using bdevname in __blkdev_issue_discard
Thread-Topic: [PATCH 2/5] block: stop using bdevname in __blkdev_issue_discard
Thread-Index: AQHYLvK6WGLdBjX/B0anjA4cFX7d1A==
Date:   Thu, 3 Mar 2022 15:34:03 +0000
Message-ID: <PH0PR04MB741680EF060691DBC8782BE29B049@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220303113223.326220-1-hch@lst.de>
 <20220303113223.326220-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca4e4f32-1957-49c7-2963-08d9fd2b3f82
x-ms-traffictypediagnostic: BYAPR04MB5031:EE_
x-microsoft-antispam-prvs: <BYAPR04MB50318A3DD90EE5314DBBBD6B9B049@BYAPR04MB5031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /C+DQGiwYznWsFj5qjffCncj5hf4UxVDJjMYW02o5XlEuLQxHarUtKkMrM8fU/7ApGwoUizTt5vypDSvdrsrDvW6hMRylDorNRhRC4Ta8PId0HSwYXSLEInmE5iZMGzYyRTkguxycSVXlBZqbVsaPBsF1p3F/W8HODNkMT1rRpBP1GA5d27Wsk9WEYuEYf5QwY9SfMNOs9/ROSh9wQbcOF8maMHm3/8++FGfP8XFvehslBJTEVhzORMokrOiYsbqOsMajJiRcIDwhuwe3dk0y2iAoLThi+xH83DxKAm3OxhA0qt9S6+3LMYTg9lchAb0QHWaVtrO0DFw0LqkUf8NuA3dxMuZ2nQDhsnHV4/bxhTq/j+EKaCcPrkXZ4ivJePafMvXFOULi8E/8D6dhlFJ+dkll0HZTQ1J3BmuV7g5chvJIFRS6GdKx4Ti/K/qQSLupzmXUPOZt6MvCRNRLIeKwzNLmyvBKab8o9vMy7zbRC281UZOuAld6dpUjXpy49wtAKGYLehEhY7XEtwLg54HN9LYDaHy6sIfmYaC4D55Mau7QQMMY1de9DUIGKUdJFMpcOZ344DcxY09PskjTfmxMVdp4LJg5YVuUpB4yL20QqtU8OpWjZEn6STZtgoTG2/dJ65qL+lI9b7jiCoDjeeK2pPUeTb3DkQutF80mCralqrKswg9N5wWn/UXax7U8ARMAhviHoOyJMEzxT1R4BXeJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66946007)(33656002)(6506007)(558084003)(54906003)(71200400001)(8676002)(76116006)(4326008)(66476007)(316002)(64756008)(66446008)(508600001)(19618925003)(110136005)(2906002)(8936002)(55016003)(91956017)(52536014)(5660300002)(4270600006)(26005)(186003)(86362001)(9686003)(38100700002)(38070700005)(82960400001)(122000001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8SEp/NxcrWsLBtDuf+zPyRUB23DuA3Y/0PySBdytfRxt0gsFlnUVUlOlg7pD?=
 =?us-ascii?Q?lKpAgdOUufcMDhTjwiDGfLH+LZcGJb5qx+x//wAuMiMUzhr9t6uofo2O2CBQ?=
 =?us-ascii?Q?5GCZjNgRXX/ZpSZBqS32F9CXmQtYWLLoVkJ1g5Ohtd/Uc3PuK7Zj1zRvK6QO?=
 =?us-ascii?Q?TKQROql5qY62HeGbfQDO1PJKFbBqJAYmz1zNcxxXOsE3eHN3QPi5urLYzrdw?=
 =?us-ascii?Q?sXHhzfivBBkKEIbrWON0/EYD6wPphbnvHpIaLLKsfq0GEgkpiNvIIBxXu+9F?=
 =?us-ascii?Q?9Hg3m5rAc2v4N8DvUdYb3G4PJYi8FXKltXBKQzpfRMmbLZJVrwMUHggOIAjw?=
 =?us-ascii?Q?8u2ju9vEzvqblg7XCDSIZ0PVq23BUaxpiGEGSXM2K45QzCBCiTEWMoIHGF2g?=
 =?us-ascii?Q?KzUcMD16P4Ywxrx5cXFqOvJudbU6G9Copbc5ju2qnH5JqdY0kyZN74GsmCEe?=
 =?us-ascii?Q?NCC8xVI5AL5Afr/SpCAdcJZe4XiFN7h3cYfCTCfnj9yZG0/DCzWbKZH5idd2?=
 =?us-ascii?Q?U1hB0K+CZqhzdgEGPPMan0tK1NAu+kr6+rCWKz4DvRDbsGNqzJxYvuOp3VI6?=
 =?us-ascii?Q?E+I1IKaMq/eglA1iNh3SG1y+SgUe8jFrpN/TY6BK+zHK8PHP2P31MNkag/I6?=
 =?us-ascii?Q?SH9SJXktMY2xWALKmzGwXjNhI09KOtMVLDlblKBEWUHXAVPlW/OIBLyCQ5Of?=
 =?us-ascii?Q?6X3mDyOZwtSy9DMSR8l5CWadZWLHyYR/jsPUaqbSf1Bh1doePthJOz4JPd9U?=
 =?us-ascii?Q?UhIljkYR7PpSuwdLvUxr10XSCWVtQ7AWKQd3d5n6/aGwJ1Z0Zs4dSDScAk+l?=
 =?us-ascii?Q?GRaQAFDu/dX3INFSljm+Z7vjqIUgNo20U0FgLzs1DxXPHm9Xyyh7G0GGCt+l?=
 =?us-ascii?Q?EYK/muQw86la/3fwafuJ6Yu8aDLTK6jxqPJvaq2NvBtotT55XC26H8+YahVN?=
 =?us-ascii?Q?KYasT0rSACL60yAvmRYrhLI3rvXF185DJlhOOy3Arq7Dos7NKI6l4KVZwIEO?=
 =?us-ascii?Q?x5Eb+bIsFBLVNBIH8fub/Z0zWllaBKRHFk6JRktvtiMeQfGdbDNlTpNrgkse?=
 =?us-ascii?Q?LceQ3MPbgwhj+CxtBv2EKdPR4mObQtQJq4sgRXX3bn/n/zLe3Qdo0jrTCORZ?=
 =?us-ascii?Q?A4mI+C9ZvD49JbZhEUD9+6ZcUXMVQjUpbZZWlFo2SlawWvkF53fGQr+dT/wC?=
 =?us-ascii?Q?iZHzUVJXR5s90QO0D0uxhd+AI09p5huJze8QWg2qqQ4yVL5G1bviKCyULU00?=
 =?us-ascii?Q?ohK6H6Qk6AXiLLojIlmXhMBIl9qa1bWZQsL67LhdAcCMF2ip+68e8JaTVUvk?=
 =?us-ascii?Q?JobiiVHlgPPAeykyX+QRgzY0DK9tOEpklOASBnswy0kuP7EeeXXNA/L3RnE1?=
 =?us-ascii?Q?QVctxVnmkNRti1dT8MQP4+rhv+NFPxgnHNe32ao954LkiwSEh0QSDTEgZsj9?=
 =?us-ascii?Q?fyDPyt4sXA1q/i31a9Dp2jMEXh+vR+kgF0lLVYa3ELQa9AuonRyhU/gpXrjt?=
 =?us-ascii?Q?ZRQyvjR4uBo0sKaWOSvD91HNGAbYsla1pAw2CevQE5jM9sFAL9vC/i/X2922?=
 =?us-ascii?Q?N4kp9Gb1pWjR/VzxbUkM+3v/2HAauqMVb6/cyWUWyz+7jzkVs7xr3f3h8RNL?=
 =?us-ascii?Q?lCPKpoozwngNjle7ZuyyuiSkny/rluja1EZ0j+ei/TMkeQzZQ25VQ1rWsBm6?=
 =?us-ascii?Q?O+VJ6pjCCwNvlIeVBjABjJq724s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e4f32-1957-49c7-2963-08d9fd2b3f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 15:34:03.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NuDV4lUpTFVzwOpZnS7B3OEdKHhdefn5bcPEqFhB2ZbIIGZ1ayrb7j9jNbbLMYO3IbMROI4zi9A6UR8q44BGt7IstxMyatNjMKQuemhSqOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5031
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
