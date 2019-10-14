Return-Path: <SRS0=kJgC=YH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F39C4360C
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84672067B
	for <linux-block@archiver.kernel.org>; Mon, 14 Oct 2019 00:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O+lN6zy7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uV5JDIIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfJNADg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:03:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:26127 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJNADf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 20:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571011434; x=1602547434;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5g5kloFy7mZnDVGfLZHkc9sNDbiOoYE6l5FRPY0qpLs=;
  b=O+lN6zy7iNgIkoTX/kbBEtTtnrvDuHzK/Do66dW58ImVbnNHQCw7/gqI
   5O++uTbN40Le1Zj7iraClofOv8fJSLz8V1lNFtT2eS21M7O5XaDlrdcK3
   dEqybDNZxb+ImEevk3lvYvCMZeWnYsgSFWZra34NlYkTQ8pEjI+dabwi/
   oDlXbZOtyBeZxlpvXjDRIdXhifraNVjU0eP4MVGZTNUpdCJfqM7/KePaH
   BHBvbSAcwd2ZJNF/NgawaPvNRZzEPN2HlIEwFUMPRYcI9tGbeMNU3ejyE
   XTi7HOCdnE40o6+XHdi8K8LRnvN5vGyUVqzb+2S2mFm146ywqRzPR/k7I
   w==;
IronPort-SDR: 7RFo9vB4q6AsgEb/Uri6m72hITMzc8/HFObPrjnMmmBaNuRqdqwsFIL3QZ8Ts9dwAthfl+34Ns
 qPuwIB+PpXCr+5+BUs/ShVPx9f9irFXwBybbOipI552Pmyoyxa4c54ZwKxvnjdNYJ49DMLEvwk
 EB5t7gyx7NWeGx99yGSKyEGyU711cwIuvhtQK52e++J9AmYhQHfcDdzprfD8bq6bVIKqoWKpJP
 bkczseci/TQfZiAAVOmz9Ts5F6kV4WsdTDmc1ypnnEOa1nqfBG+A5m+G1pEPcfJrUipNQI9Uyk
 NCc=
X-IronPort-AV: E=Sophos;i="5.67,293,1566835200"; 
   d="scan'208";a="221486646"
Received: from mail-dm3nam03lp2050.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.50])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2019 08:03:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvGOQE250kaa9oVYCnQinJuXWyvb5gA6yHybu6u7ABg9ThUV73Qdi5rUUTW68RQ36y4xphrfjeurXoYDdJOVDI5m34fKRjgChZ/+7ewkOsJGSFtqKGCkfNKh20tMUgycg3ktA6VuNXrGLU6pby4EWFpKQlnjzhQupXNCOQKSi50D98nXExmIU4F8Kwphb8/bSl80FGp6vOjgmRtQ9u3aGKSy5U6immwaEzWCdm7ByMm+RjMoU41Bmt0J9qGQEo+YgMn6lsgGkyvYDQzow803DIM9rLK0Z0JLufydr7AMnM9OZxuhtbfo+5R1l5eYQEOxPJTBMmiXc5MOwLAd+WJvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWz5ZQVek8b02ca7v/+ibuTi+oCugCTaeBcs9rDHynY=;
 b=UBaYAZ9fzW9sC9LuOPBAdn8Z1z/T1U8cbgKkfEc8B4p1jQd2WyKWpLsObxqelpIhmDFdyZvLqEX4HL1gSy5gOh/MJbb6HA/iKAWaU8urYv2vw7sHWWPPhsM9kLEBueqw7lqu072YIICKNk6UlZmvA4qT6z7/ZnL/nJ96eOvQV4IdHDrrW0pnQmGvivCmUgiH3Mdg0aWzngo7NpbqXU+/1i1zMVn2T6TZKu/o+fVz4rkkE4VaTYwzJwhhJG+fKAsbnteXld68B6yF5S6CmLXVE3T5JcVKq+Wnb4JJDRlh/aTBBX+NApSvaYsVAbhy1tCByL1PKLwqDoXSzoy3LxVp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWz5ZQVek8b02ca7v/+ibuTi+oCugCTaeBcs9rDHynY=;
 b=uV5JDIIvtAFUXZXBvdBrvYd+oepGS+iAoPnLLQ/RLTAf67iEnQVJ7blwkwBnyoZVDEvrntMykNOVIBJHOw6qnKf5qJHhG60PtOY8RT2FWlUffoW8IllCSUk3c0bAtn5RWRCeLS/h2bG0nuVVXtfHh+4XH3zOPG085BJRKb6dFh4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5719.namprd04.prod.outlook.com (20.179.59.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 00:03:20 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3%4]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 00:03:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH V2] block: Fix elv_support_iosched()
Thread-Topic: [PATCH V2] block: Fix elv_support_iosched()
Thread-Index: AQHVfilRulSndgyoWEaSGfkZs5UTLw==
Date:   Mon, 14 Oct 2019 00:03:20 +0000
Message-ID: <BYAPR04MB581615B3209B75F0BE608700E7900@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191008223954.6084-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f0d5707-68fa-455c-7631-08d75039ec88
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5719:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5719090B3F0532D7FC618D9DE7900@BYAPR04MB5719.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(478600001)(305945005)(81166006)(81156014)(71200400001)(71190400001)(4326008)(446003)(6436002)(256004)(8676002)(14444005)(102836004)(5660300002)(476003)(66476007)(66946007)(316002)(6116002)(14454004)(6246003)(74316002)(486006)(3846002)(52536014)(66446008)(64756008)(66556008)(86362001)(76116006)(66066001)(110136005)(7736002)(26005)(99286004)(33656002)(186003)(9686003)(2501003)(76176011)(229853002)(6506007)(2906002)(53546011)(55016002)(8936002)(25786009)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5719;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lk517YvWbjqlz+3Frm6wRe3ugA+RACrzUA7JZIM3ky7vzbaWY+r0NapxQmtSKO/D4DHxmudUU9t1ajA8EG3Zh3s2CbW+ManyZsLr4ZoDezkBIPFRKc60GlQnOMfO5PXKdDKc/YDvh7jie9IgcdEFGRgbxRDnMAfzUrNNPaC4euLeODMVCOo+2se7Fut6xKIWUs9lf53Garryb5eGjw/VtKcV1Oz8031qa2uFcigZIykR5e2kk75oiR9YDbMUUPao7TTXEomB//YjxJNyihMpHNkLYSHPDQgZ0tajaqh3LMGtLP1gqIqy28kaZVOPOY8jyfvenGcLbH16L4uqRbKYEOsqQ50v3MVmvDHJZzRTzHRqdZJrGBpmFnHc8Y/EgKixUAs7y3m4qVjxO5dtprv7ChB7zS0kXapRQB1aJXFH904=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0d5707-68fa-455c-7631-08d75039ec88
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 00:03:20.5819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tF6P/t9yimc5RG6HR6yB3gCdRF6i3J5qyr9KGgdpliNm2UDV4h7ub4TC0WDmyWQ5oIROlcrJ88+bGhzwvYpbxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5719
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/10/09 7:40, Damien Le Moal wrote:=0A=
> A BIO based request queue does not have a tag_set, which prevent testing=
=0A=
> for the flag BLK_MQ_F_NO_SCHED indicating that the queue does not=0A=
> require an elevator. This leads to an incorrect initialization of a=0A=
> default elevator in some cases such as BIO based null_blk=0A=
> (queue_mode =3D=3D BIO) with zoned mode enabled as the default elevator i=
n=0A=
> this case is mq-deadline instead of "none".=0A=
> =0A=
> Fix this by testing for a NULL queue mq_ops field which indicates that=0A=
> the queue is BIO based and should not have an elevator.=0A=
> =0A=
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
> Changes from V1:=0A=
> * Test if q->mq_ops is NULL to identify BIO based queues=0A=
> =0A=
>  block/elevator.c | 3 ++-=0A=
>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/elevator.c b/block/elevator.c=0A=
> index 5437059c9261..076ba7308e65 100644=0A=
> --- a/block/elevator.c=0A=
> +++ b/block/elevator.c=0A=
> @@ -616,7 +616,8 @@ int elevator_switch_mq(struct request_queue *q,=0A=
>  =0A=
>  static inline bool elv_support_iosched(struct request_queue *q)=0A=
>  {=0A=
> -	if (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED))=0A=
> +	if (!q->mq_ops ||=0A=
> +	    (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))=0A=
>  		return false;=0A=
>  	return true;=0A=
>  }=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
Ping ? This was not in your rc3 pull request...=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
