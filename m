Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549B4C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A2D6120D
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFUUKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:10:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61810 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFUUKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624306087; x=1655842087;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qbknmibNWULMDLVOrfT4jLBNRCwsXkS4IR+P4+Hjefc=;
  b=I86okP6G8N9uYGysp2DnEQeise+6G2X58MW29kZS5EvDz7AO+OSCR7KV
   ZQcxcDJjPRThuabL2dXGOY8gjGtaYlLNC23FnFHPNW1UpnF0tx+nJNMpc
   5gu5fS1eeMYsSj+z14G3/qmBn97fvX7YKgXjz+iuPhk90u1nYkD3AN1uJ
   +Oi+bfpDo54oTXHuOQAXea9mBix5HrmYP+90/0PPeEt5UBb8SKKMa6UGy
   quQH+MVqU3neA4N21gRG9dWprv4AiWxzJHNst6R57LaJmKdrfFC3BJ6ND
   iI5r0Gv/1b0Yjbe66M86/NXsJukuBpRog7ehKj0IfzeAIZ/tfJrRLCNR/
   Q==;
IronPort-SDR: jXrVb7fEJQfFIbd9QgW7sHVnqmenQgHQPGq7/apLelx3FpzZYl4LFvyvr2eKpeZnPVfslX6aD/
 cRu8ZtICJgXmAnaRUmiZj/wJgthQjtmcegBqHs99M3JYSiOGAW0YgrTMlrFSxwgzhR5G1WUxOS
 viT9GSZNP4wa/J3JhtlL3HxUHGgCuzbBqJxWuuJz2bjcLef7RpatXi302YF0ETxGuojYFgonle
 ZKXVefXU+up2lWV94mbD3L0WHvQ6Gjl1MMmlzSrM0htF6nOTpdJn8tA9XNhRqa5i6znTITAFoL
 xig=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="276304111"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:08:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+hzEg6SA/TarrUZa8zEtGhNSQ/7iFMqBB1t4vMSCx4lWRDiDwXmvPcsHJ0KMz3d5kVtqAAYV9xZX9iqduI7EwDT+PFuWDXxNVnzzEZXXp6PoBbUX4EIAda4XUYlhFhrmFyRIce8eSX689QV9mLCusLrKoAqG4akSiq/tfSZM9Wcm8bNAkBEzmhD/bog3XhQI0y8GrWmpWW+WU4vLScVx6Mq/JhJtJXMbhEmfwSl/LKn7y1eQQSU0W7+gavf3mNbGhjvK6MMyYYnRiDiLhUd5m/jbvCwK3B0zUm5X+71PMhs6t4Gv29E2vlx2NDGpPLtrgnVEImIGYq8U3Ti2RFEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbknmibNWULMDLVOrfT4jLBNRCwsXkS4IR+P4+Hjefc=;
 b=Gk5blPNH6tNFlINJJRgofRU8WU0kfSbpeJa3Hlzs6vOwse73TFMxzSaY6kb6jnJ3wCXekb/9R2nrWGfJ+Mf2A71ZJ8JlU2M+SWh2z+oH+Q9tZvSRZzTx8u3gUHEtJc2CSUffA4vgMNA2KcH4BIMpthsjrOhYwLu8QaTgsMHUG3ZTqiAPJnw8m+/j+QHF26m3f+Q6ipRZo5zaocORSgV7Hl6oJRY72VuL9H9PrcK6TudO9MuCop1znovLzQi5yVzrrhg/CR7VQCGk2+OZiefxUCkQs6e4Pq4RrBhmjXDKUzAoQ7J09MseX69NX2gtSUgFqMdPvS3kBS9a8rfkZayuxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbknmibNWULMDLVOrfT4jLBNRCwsXkS4IR+P4+Hjefc=;
 b=ZEwtcCFFz+mprKojJdaACo/O95U72KGVQvyg785iThJIEhssbcvV6er+UEydXPDEh0/X9R7aw4mPA+rXzBh/A/S6Sy+ThfrYuLOR8WBEvyt6AbAgzCySb74jiONbFuTLKa2ee6spd9RrDBLHQIru0gJjmLAdKfUmu2qdip7lXR8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 20:07:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:07:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/9] loop: reduce loop_ctl_mutex coverage in loop_exit
Thread-Topic: [PATCH 2/9] loop: reduce loop_ctl_mutex coverage in loop_exit
Thread-Index: AQHXZoeTnMIM/3VM0UqLIGOB/TBFjQ==
Date:   Mon, 21 Jun 2021 20:07:54 +0000
Message-ID: <BYAPR04MB49656EF96AA9D402D3B14AD8860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da98f140-e1f3-4426-e471-08d934f04157
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-microsoft-antispam-prvs: <BYAPR04MB5525FC34F8804755403AA992860A9@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iv9M25TMt7bCa5XIqT/PUehPTsNxKGxQkUcp2GSFPm+c132MvW4uUnY3HgmliYOYTXbNjxLoE0crbhUC6bMKd1gHUgiXdPrJ4/J5H/RFowLp/xVxMShJ1AOTuC92Zv4gBfi/1HPNK2vmbqxJBLVBOj81ane9bGaFOyWRgPyPY6sAjUFphQmLKAXk30FMwx1ZLeikxtsYJ0furbxdiZcxjwIXQRcBf6Bb9OEuMTi5r0IBVULCXRpPbUqhpkNJoc6DVFyLkeB7xH8cBWN8rrSXT4LjErsUTVWQT8qo07qNSJtkuh+gujZOe62hhkYAg5dv+H+kXO9Ckbz4SgyN6xMQys3f+ZdCV4tr/suFO8rcSebUzObyccKGi7Jd5kee6/IbwRGtP51MKVpSrpl5nIOdt2uUVxl53w5INTKp86hHVXic8p3cvftOg1gVnNkvIInF3JGmcH+ESYRUb6Tw8Bg6QDaR+qVSOdyiBYmhAGLBq7N2r+gori+/2aNFzupz/iCfBCUqhP3qx/Cj9EtnRbgbbLREfl5cGukF7IlIT+bajGvyVPd1oKSGUcwntTW6nrXvH+qoYSuMwMFI1bHpTegUwSSJn+deiOpoFJTu1gmt5Tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(55016002)(9686003)(478600001)(76116006)(8936002)(122000001)(7696005)(5660300002)(53546011)(6506007)(8676002)(54906003)(2906002)(86362001)(110136005)(316002)(66946007)(4326008)(64756008)(66476007)(71200400001)(38100700002)(52536014)(26005)(66446008)(66556008)(558084003)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wUMI16kuOhV+gs+xKquiVJsOseAIjTLEjB66Q2T+Ua14kFqqLA8LUoYlZ0DC?=
 =?us-ascii?Q?v0ai8WSklTC36RZh+ViDQjwlYRSZdOJNxw45COkVDic3+YJ6+2tQsrX6RY18?=
 =?us-ascii?Q?eaRpsP7Auw0fhvtbUkdU4JLzmHamnf1i1HyWHvBCn7RtOTVHHv6G7z+zfLjQ?=
 =?us-ascii?Q?erV6x3IqSf8ZORmigTGTB6boAlVoulpgUGhhcujl9bqHUlr82BT9a4EVbLxN?=
 =?us-ascii?Q?hDrNiHNIatA1R7Xngi5Laovcua2BcPSBRW9Zd54e4hgijZvQjiCJphsrBnk8?=
 =?us-ascii?Q?C924ajgjK5o4QJYG0kULcj8JMSLBVRhK44L35eEawyzr6vq9/Vgi4xyl9OYV?=
 =?us-ascii?Q?m0Eawf170lqSOKCz2Jtwj7rwoqsdds8VSb4jVrmG0J4ruTPE95CUTqRKkGUw?=
 =?us-ascii?Q?vW7PIL/BUH6BAleSa8ORBWx1BoAzunnyUruigYYts/hDVFjRC13g6BGLmGis?=
 =?us-ascii?Q?6bRgeAIaKxY8ofNVeZ6Arpz81O59yUENxUr0w4CQsprDmxcwI8iEvWdQn3Lg?=
 =?us-ascii?Q?xaF0dSIdTC17rcMS97vP8iRXREPKih42nYY2CTzT1FLhOodYuDzVikJpk2O5?=
 =?us-ascii?Q?cb12uDkfL9WmMpkQ95tFGtVxe+mD+8XIeAZbZao9SU5R7GK2FHaVdhhsPCzx?=
 =?us-ascii?Q?tTVYb81DEbG+LKDYuy438Y6SJsAQpPbOWkEwQsTaBQq06o/Xr8bw0tSLhc5k?=
 =?us-ascii?Q?Yp/TZMZrbnMnvqcEX5xTfSsRZGos7xKiPQKd8IGeVrjsyrnWWvlWfY38zQiG?=
 =?us-ascii?Q?DO5aUTsDufZ6+6HBNb4ZId/3IskfCLovu5k4T5mo1JXMoPd1DHovxv9VGmUI?=
 =?us-ascii?Q?vpM2cSRgiviWwreHLAeMDd9wn+5jzmzuNEsA6Id5poujsR5QqzWML/KqkQ9E?=
 =?us-ascii?Q?OADPeR5V7MKP3NpK5/WFI9Gjcn5Yc2xdGA60EGq2wB51jRkjK8Sz8JEeLQgW?=
 =?us-ascii?Q?IEzJhu7+3qU3alCpY0dtP+kXdZfpVlsTB+B9aCeB1KheKsY1nZrMyeRMFecM?=
 =?us-ascii?Q?TLoSbnydOLvOHwspfzSiYrxZOEmEeMUvptBA7d7CkZHf1hLccBrGHXxgnTJf?=
 =?us-ascii?Q?8sQI6MNQdbUFh+aEZ0ha7t148hyEshoh/q3mBZYehdsBmHby3YVxOBQ+q3fw?=
 =?us-ascii?Q?fxvz1snVoCqttp6RpyncpauzlwDhlFawF2LbXdCKrsdJqfcB+UeZDcoZouhY?=
 =?us-ascii?Q?QyVUBMuQr1iaEv49FAzxeDIZnx1XGvcIJxoba0ur7ds/x01nBPF7QhsrjPWw?=
 =?us-ascii?Q?dq5awsYZH4p1I+/73aOV+fOE2vLbduCplOJjGOalbya+BorWbLm/ypOpHt7p?=
 =?us-ascii?Q?SWxqDwH0YOcVUf79LzYlyo+G?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da98f140-e1f3-4426-e471-08d934f04157
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:07:54.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PG4Z0MUPeD7EM+jbrhvWrt5fOS24f0EvJmEmmYOfftSm2ndcWuDdtMCLXrwjdDFyzzudKVo/2X57Oo3IBOltFZp4DHi/CtYcRbv6cfDDI74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:24, Christoph Hellwig wrote:=0A=
> loop_ctl_mutex is only needed to iterate the IDR for removing the loop=0A=
> devices, so reduce the coverage.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
