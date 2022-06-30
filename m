Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41677C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 06:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiF3GCi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiF3GCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 02:02:37 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081901408E
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656568957; x=1688104957;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=q2NOmw0Qs03ZMQ2vhVgMrblL9TxddNLPxMjfhDVLCNA=;
  b=iR36S5XTLsM1CPpQNZQlt1g6Gp9oTEcPDWNVSR5pufdkX7Lq+nEJJOK8
   8GxjFXZQGXyehXfd/VcE/T3QZbWZrnonHEi1HyvjttwMtMTCvMjId2jXr
   fbZQVi36cDCuwGyoj9c8ijOyocU9nUYxZGR4jZ3Y/UjINEZz6XDi7K3TT
   3Mz3UQMfgaVp8yv/tsr0oD9IecATB3gCsbAJvgtw10ALkUQIYUlGef+bE
   wR7Ydf8yXFNceFeLm/7aSznDk/i4MWxmBheQxdobjkJQ63Bj3mKxUR9wv
   5S9c12SOR1p+8gaqyrw7LFCRc5/k0KLyjyySo5OWjHLnuzjDsaSUYvC16
   A==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650902400"; 
   d="scan'208";a="203132080"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2022 14:02:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eW/Yy/ocA6zjvNcLoTZRF8auqHoyDjAZQw26IL7dVnHqG3vaoVGGzNLSpLLpJWzwa79YPTsK580YDmjevARNeUXBRAGIbgIMGS//2TwSAPB9pLjbOge9cMZdhqx6bSwF1S0/uUJE7R3Z1c5F3YkNcxutMgpV1RC4BqVQh7elYERJXMfb7/nUoCJKg/31swPZrGETzNMusdC68iDyF+J/prgUZxCg+LOc1ByBo/xZ7vs0v89e7jw8fDEJenbOKgORoh3qobzI28qzI+V2EYa+KXvnTFfNB5E97jLQTtLurK2Okxrq8OwRA2/Wx1YrCDnSMGFdPtuZYy0K7T8D8T47HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztbkzfi4L6rgU2rndSoWloyrVpobiJXSr88GehFVDfk=;
 b=SPajdycnPhEJ9yLThaySMq+5uOc2Cn7h2TO/rgT7L9yp/dgxdUcqcSdynBbcvzgmOa0hmNEEvRHswNmoKVSn2p5mWwQ4iD05FYx+shAP40n6dhVL4A+5HIGl5aiNCY99BptevculH7CuXr12K8sxWAkO0/YVceXgh+TDIsHguY+m8r11PI0nHYv+aT1Qde1csT9hjO/jXc84MuFTkIqRBLxQHVf3MwCnA97h8Mn5aKzdQtyC5PXcbLdwpGvtfk9vj8ARy58z/c0KCSn2/hHrEDunYDSyH3eyoHrbd5b3TcqrMrCaNtUZEWWTuJfmmHU73EBFflNt6C76/9pMKRUWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztbkzfi4L6rgU2rndSoWloyrVpobiJXSr88GehFVDfk=;
 b=ckNq5VMH1A9OF2vrZzT8YOVFy1vqLjlOXqlrQ1hUgj/O2TVIyklTaoAeX5Ff3uZPWFTnstFmUxVU0f9gkYupszI/3eI9G20oyw+x1vxbUlP2S3YOwJuftX3I56w+fJFV9P+wHURv8kVdHW1Xrp8U6ifrSABHrN5eU5sTE+soKro=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB6198.namprd04.prod.outlook.com (2603:10b6:a03:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 06:02:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 06:02:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request
 operations
Thread-Topic: [PATCH v2 63/63] fs/zonefs: Use the enum req_op type for request
 operations
Thread-Index: AQHYjBDf+RPaYO/lVkaScGz+qKTxYw==
Date:   Thu, 30 Jun 2022 06:02:30 +0000
Message-ID: <PH0PR04MB7416855D1B2858C0323EA7569BBA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-64-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fb88563-7064-4e54-97ee-08da5a5e1e1a
x-ms-traffictypediagnostic: BYAPR04MB6198:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlkS8SnQVFwe/35qCuPkSEtlNShyVm0L6pDa/GwxiwnGlF1ya3IqIRXtQkr4HEQa8g5bCfeUHTnOIU70yr/tPqRQxN1ghGOR50ku1irZZ8e/0vGT9c5lAR8tzOAKRYrDJ1YiLdcfaSiz5jxQKORDm0dzNXCkP5VAAX4pX2M7ACcrbT5Dd6GKw/ZDS2WlT4ITuC1ciaJYeNYvqQT+mVDBH/9288//6G2g0tW5bIUBkff09a2rU5HKD6MVy9+gV334fxjeHthvC0la7EsGHe+hwf6+6+eCoj1fGWwpJIpCrNMnDIgVhy4KeZgRRzIcIzIuQdM3pi5dXJ6v/nZ7iJX/bgmiAT11tEdfFWvFxzVvmp+zS7dcor4lU03kAQYv8LTCKEDdGsKgW5NANizqbQYR0ct7VkgFlSxuy0kO79wNqWNKt0Mklxyqy4bPLQhw6L/3TdHMmzZy65n2aHTTux/jRI33049ES6pfUEwDfVS5eVKxz6SOn2KrLzoCh++IaRCYBnkBrIONvVpJGm3fT6SOGusVFzod8rObWLsjeAJSHQ60f/zrEftfuGGLyLRx18mWKHU8H+gpY3DpDZOkmTmKGHr7eUe2N0prmxozhbMlBYHkwirvlJvROpK0Ed+sFYqFw+b5EQdSikgWatUzprJa+AZCBsLD0nF4TZyeunAe476E/gyVJfSxYANguUzRKOIVKFSwhGFV6gW2TRamkoprA9wPOk8NxQk4sUqw8+7PZMbPGUkJ4QUhtAj0fQ2aKDf0cOfAtS5AcTl7AXQ4rysQqwnvEQwjB21wuzArJq1fRmFd2HQl8EfNJ6Zl3d4kz8b+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(4326008)(64756008)(8676002)(66946007)(76116006)(2906002)(38100700002)(33656002)(52536014)(5660300002)(66476007)(66446008)(82960400001)(66556008)(110136005)(122000001)(38070700005)(8936002)(54906003)(91956017)(7696005)(9686003)(6506007)(83380400001)(26005)(478600001)(53546011)(4744005)(186003)(86362001)(71200400001)(55016003)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l1SoLcUF60pmehtfTSeZhos7K4OkhO0tlZN7OMLb2xzX5bqcImOUHU809/YV?=
 =?us-ascii?Q?+D8azV31/HnfDNOY3lQSr7zUv+azgVCZizRz8b0CQZ6CfCeWcPztrTWGiBYe?=
 =?us-ascii?Q?xNzQexpOyo7o9Mjib0UKwIjEJhnznc0i7T8gu9gGOMYYWyPwp09YBgYOQRU7?=
 =?us-ascii?Q?R2AYy0b0Yw5aSbiyRZLH7Yc8G0PrpWIFeNLA6LVT/VBqBnxljfVILv8Zb5vQ?=
 =?us-ascii?Q?wG5ExSgP3PP5iWJ0XcQvcVStd8+qfHm0gb9ZpFghmV333tj5Ds5zjlyPlb9H?=
 =?us-ascii?Q?m0uI3KpoOyftvsTfomKHdZ5zhi+WaaPGM6KoSMmiwTsauMb+CVNIRd6WKcYI?=
 =?us-ascii?Q?5z2hakRALKTnJNskqt1JTVUO9iu8VImk3d3hqD1xmHvvKHPVENYtU/sA9B7w?=
 =?us-ascii?Q?Js0zLP2I11rzSJ9MSykzePFgjaktERMpnYsEBJ7841090UFLg8K7iJZJOqdQ?=
 =?us-ascii?Q?WF5WcSVWKKKxMqrWsADUejumxw+XN0+fOLxN75zCewRatP5SD4To9kTQzuyZ?=
 =?us-ascii?Q?/8OjU+Gd7UyDPZ8t4rwHtJE39BYkuVp/5M61pxWWiooDC10B/OY6ESKVx4qB?=
 =?us-ascii?Q?Zu3Z+n13eJSv4T8xIQvkUnH+XvHz1lNRiyNDYfGdLL1gs8tThzQrFck+7uMA?=
 =?us-ascii?Q?eGEaqFK4Cyew2i85l59YC8gEcbYMymeLi15bu04Q3wgkK54YsBgsv7t5xDIr?=
 =?us-ascii?Q?fwDGw6kqpIgfjh2WyhE9fV01+q9P58ahT6yWQl237sVU9y1xAr0s+b03vLcW?=
 =?us-ascii?Q?JGMAsY9CBuSWi4lrcdgBrgP3HtY4wOxNKSHDuGQNFUPynZkB3VynYLlbCQh2?=
 =?us-ascii?Q?U7yXWaulrUcNZTyQA1NjGQ20HcAVMXR4Yj4yZ3gu1TXQiWAFy9xyTJ7oyS3M?=
 =?us-ascii?Q?3gpFKKTF1cYf+V+5FOXuEH+y7Ut2Wj8iIDrSZNbh5JrvePOAXjkJfMFvYiRi?=
 =?us-ascii?Q?GV1R96rMbn1fTPDhkvXDnmi/fXPfz4L28dzh/lFGCHY3ezlh3VY0SzhnUBwS?=
 =?us-ascii?Q?yXf7r4gQcLuRHuzyHsYnbBGt3S3lhpfWKt487Vvbe649xdrasEGH+3eidSpa?=
 =?us-ascii?Q?fDwU9AOchm7Z0w5WZqad7OzEf3m0bJTWQdWPefEtaAsTVMBEBI6NAQgxQIJv?=
 =?us-ascii?Q?zW6T6FPHMeb93aHxH34m6stokHGiAMbXMMFKbdt5n1vQpqwMH58z98CUYPeU?=
 =?us-ascii?Q?yEg4T6L1ZAkYJWVyO4bGFvYz6R8i+GKjBlEeesk/xDj6uYQiIkuAOBVu2+38?=
 =?us-ascii?Q?Wxbr9Jn90R3o+n2QmWNSQkz1RPuESDt2jummHZCM7Xck908iKPKKbVix6lad?=
 =?us-ascii?Q?EbnehFiuvwjerj2ZGez/geizy2iUtkpFul6Yo7P8PNig7xfSUtoI0Um6feOO?=
 =?us-ascii?Q?5vyXHzIqEWuLChWn54ARF4G4570F12smRa6jLGLaMew21npwFgq/vx1xGfqj?=
 =?us-ascii?Q?a0i55gKnIQnMuP6ua2xixvBneECSiGtKcBu6g2HvCUeqFUh8PPtcGnEQCE0T?=
 =?us-ascii?Q?TLSrE5MQ1EyB2Whuhlq9BNrhmoBkR0sG782W4vtnhQnJv8hDHnLEVk82qyih?=
 =?us-ascii?Q?fZz8WCoIamudu2mt9bcvmwumfmWEiEhufoRd8KMXjEHAI+LtvdKtVSKwmOMt?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb88563-7064-4e54-97ee-08da5a5e1e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 06:02:30.4362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1i6HLke+BAnzTsyNrLmYDYoyGRRNKDYjDhk/ZXd/N8H4ArSLo6I6Gvhf+c13zQ8Um6H0OZO75W0V+wuEYt4qeSQ0RVW+dX6M+Z3ZDBPuHs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6198
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30.06.22 01:35, Bart Van Assche wrote:=0A=
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>=0A=
> Cc: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> Cc: Johannes Thumshirn <jth@kernel.org>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  fs/zonefs/trace.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h=0A=
> index 21501da764bd..42edcfd393ed 100644=0A=
> --- a/fs/zonefs/trace.h=0A=
> +++ b/fs/zonefs/trace.h=0A=
> @@ -25,7 +25,7 @@ TRACE_EVENT(zonefs_zone_mgmt,=0A=
>  	    TP_STRUCT__entry(=0A=
>  			     __field(dev_t, dev)=0A=
>  			     __field(ino_t, ino)=0A=
> -			     __field(int, op)=0A=
> +			     __field(enum req_op, op)=0A=
>  			     __field(sector_t, sector)=0A=
>  			     __field(sector_t, nr_sectors)=0A=
>  	    ),=0A=
> =0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
