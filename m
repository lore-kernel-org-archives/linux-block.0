Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCAC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F666103D
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhH3JtC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 05:49:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64411 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhH3JtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 05:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630316888; x=1661852888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R5bPAz2omLl3HgRJBPf3mMI5XFbhWHDYbhYZ109sVyk=;
  b=PUwf0+5Uld7NaZ3brTtS1N8eRK/dkJTBQv/vijPLI514hi6EQWgEWZrZ
   i/azaXkXDF/HTKEVkF5Dmazq+BJIjJ3tO2GkOmt7Nq4Ym2b3bOq+ru6p+
   PuXokKQg4mzo1UCTnf5pfV64XCcAx7npSD9bsBNZj2boaf1Bt0rcmmpPN
   21W6Z6RskNMSvQ01z0QC5OER4q5mQacS+6njoAkVAHBaq14gx2bs40fKd
   or7Xezo8qUvUniHtzkzuKfsvw7TWDd9nKoffxClI2cTWAsTrJJpX7b9sp
   4HSXb2xYVN4xn2mxMnmdOgz/a40HRGGIZsjz+ed0PfN8O3+GGnqZcnaNI
   w==;
X-IronPort-AV: E=Sophos;i="5.84,363,1620662400"; 
   d="scan'208";a="177861111"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 17:48:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8/z86zaQiveij3/nVe7ufQiAFRN20aJIeCazKddhwV0sxpTwDXazCtcSjFUKc95AH/TA2UP8dAAyHb9xMtgrDBbvyst7RMDvXRDrLqu9mzbRRJC6d3DErqOX71jRHL7L/KaR5RsBS8PwSkxQBlErfan1wDJN0kf+w53txUAaDJv1f2/NqX4ka7ytghthR71fpPsbOYneEyZVIowqzoPa3m4Wf4YB3Y37zXOyye44REiCBFDQiT2x4kBiYKt2gbthKo2lfqkdXSmqpDfuVlXG4XLfzfXqmue4LLFdHhhBwlSXWjwyPjeTOM0aC9hig2TMW1qrB5B9uJoSUBYnFaCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt0Z1hF6OEhPsuqIxsAEUurJo6XSNMUSU/JlsJ60lTo=;
 b=K9cJcO6NxPqg2BF7ya87dwmWXDABnXALwSeQYR9kqFF636z6HifyhPPT8PCZwNuaxxqBlD4RkUqhMYRu7fl1oooqg3o2vwVddQWHHfjmdXjdhH1VHWETu/tbbBvmwDcc8zt9Rpi60y0vQsUI1paZH3Ic+G7TDhKRvdZ/m9ONUbGufdATQKi8QFgbzuK99l7EpT8vjbUIYVTTwYq3wktAUkawe/qOWWVd4XAD/9gqDat/u7CqJHK1XT/CKr4xbnlv9I7hyjolx+GbdIdL9yddZMf7uXcigC4CnDaeINxY5nMJvnvc2RqWb7lmV0Jw0/xV2yBHPzjE7ckea14VFuZCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt0Z1hF6OEhPsuqIxsAEUurJo6XSNMUSU/JlsJ60lTo=;
 b=QUW94GOz7JAQJUB+XQ0B/Z+ofhNBQVnRLqg1CnjbQdZbA80Y0tGSLyJ9AsW/jchirqGTkvMODLygCSvv1ZTiGU18hJ50ESUw6rJiio80xRSTaBi+/4HNy6pexpDTZQWIqaT7dxn3dDwb2DUX7zCmrU3ZKwiGM4PgZ00SIOJEong=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7623.namprd04.prod.outlook.com (2603:10b6:510:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 09:48:06 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%5]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 09:48:06 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Topic: [RFC PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Index: AQHXm0DcNbCoMv+LuUuRBM4IFE0DyKuHWDyAgAR5gwA=
Date:   Mon, 30 Aug 2021 09:48:06 +0000
Message-ID: <YSypVLe8vxmA+pUn@x1-carbon>
References: <20210827124100.98112-1-Niklas.Cassel@wdc.com>
 <20210827124100.98112-2-Niklas.Cassel@wdc.com> <YSjoZ/cul4w2l8tG@T590>
In-Reply-To: <YSjoZ/cul4w2l8tG@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01d93346-b962-457b-a704-08d96b9b4485
x-ms-traffictypediagnostic: PH0PR04MB7623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7623BF7A86627DED275892E2F2CB9@PH0PR04MB7623.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5NS/qpePr7kq0I/c9RRTh52fIDeCRmH7ySbf4u4YQGTd7wkHSg7TREKI2ufLvORKDzFo0+UGdk3P3bRV78Pj4711qFJPHHUQ7/YgN57KjuuHbTaQ3EUcUf5Z/Jds6SDVb3Zh7eaBjwwqATaFZMtRV5hhzZ9pSgtwEIy71KqhuJAOQtt5aeQSmDx4IEfa4BhrOOgjNnunX3JxYQKKXn5s/VDUxvjP7LObt9aE7wQL00M9TS5GJxXBPDZbKUOBL3wjCcbAeizUynx/Mo0vJk2dpPE0RoufVZ5ut10L+eqmCoBczUrO57potZaytFkIFnpAXbDl0Do5R/Mgl+N0q/45QzA7g8WoijOHue/a29wnsURexl7vjwPm/r+LUI1x9mpPV+NFgBmnfAjn7DocAzgJdGKjFdczTkQM806QL3XIFDH01u3X5+NTbSOvLCAnBKiebExnAhFU7Uo1w1WnmDZtg8UX54JBFcnuPa9ho+lF9Qx5UdSJPvRO3gE7nNj0qNCJ9W3jE/8hNC6zgD1Ddql+tkQpaLJq5CcwT/mcmDPJ1XHx6eje7Mj0fTkufI1edX6GTadQqOoAzKAa4f4EewumNDZ4R0u0xqNpxvmKlibNrfXRjxATGgxGFmIA2xzW2qAJ/sh4U6LvBLM59xwdgihEYKdZEUAnN2ZKoikLx5xYV/q7GzaVyhlxoPBoxTMrD7jGW/ILjtVz+i72rmb6HfJ0A4xMOutyr/KkhP5aeZEZoLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(186003)(8676002)(38100700002)(122000001)(54906003)(5660300002)(86362001)(316002)(83380400001)(6916009)(9686003)(38070700005)(4326008)(6506007)(2906002)(6486002)(71200400001)(66556008)(64756008)(66446008)(26005)(91956017)(66476007)(76116006)(33716001)(66946007)(8936002)(6512007)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AcsS8hLUbCyf1SJUHGnX1piRkEmXIXplBj8HktpSbLz64domCYgrl6JtVMhz?=
 =?us-ascii?Q?Fuaqxh3TNEyfU0UH9krP3YfY+a5yRe579e1JoWdXV+PbiDCcCqYPd2sPUkTj?=
 =?us-ascii?Q?jVBpnPe7d858/3h/l85BKnCUnwyniqU3Wc+U3du+6ftN8K5jV0XfQpjeySAw?=
 =?us-ascii?Q?ZXlpZkzkwDvH50900nrco5xIeDL5m7P9kMrd3/7MbaWSk9M1AO8JYQYqXRcm?=
 =?us-ascii?Q?GISh/+p0LiPglCYObrWQyXhp11Mob8guZUetVXrgFqMfpR+6OYOzY6JR8bkv?=
 =?us-ascii?Q?OxeJZzVduRUnYriYH6Uc42GqoWxFPWrwyH1/Mi2jshvXS5tY6Iu44EmRJYHM?=
 =?us-ascii?Q?M9qJbCwlGEAh6GqzgZpWScZc5f5Prsp8yQVvEoz+0ZmhS1so7xdX+WzLYOeT?=
 =?us-ascii?Q?3QLPOukUOkDc+0+yFL5w1Kyhyl5vSL/FEkVxFepARzB7qVBHaCjyJwdRXWlJ?=
 =?us-ascii?Q?y7OCfkYR5qe6XEn0+s/XuclhQf37U2OmgP2Bw7iwBp2M6zj7mwboTLvy3Ftw?=
 =?us-ascii?Q?7amvoZRwKhZuWhD7ZnSD1OAPEttS0Mjg/BtUNRLdQ0GQcDqzjHZMQ47GfexP?=
 =?us-ascii?Q?OoFI3Pq9S9jgFBP73lgzkVS/Bki9pPFOjmLlctEruK7FJfipCt1ITLOyopVX?=
 =?us-ascii?Q?+PUpmsZ45g+msq/ZsYvP8Fud3Bfkd5WNx+X6zOgv6ujf35XXflKBgejVjG3v?=
 =?us-ascii?Q?5lh0UmEDH8h3BBs5fwxv5sJ9dl9BzEitiQMGtQYflYLkU080JZyv4yDEYU4l?=
 =?us-ascii?Q?1uRQPZ+QFmTmZ6t2BObpRTAtUz1HXAyuAyTKQjuqsDr7dOBaFeMcFkDMy/R2?=
 =?us-ascii?Q?74K8APY/s2ywU1Vu0lAa2oIbzuA0KB3fAbfASFIvlgW5a1Le8f9E6VzIr+Am?=
 =?us-ascii?Q?H/7wBNdELh57pYmyaF5TgEHthFRJxqbZr2PqAtpi/MfFYzgVHmHmrwIXhWUy?=
 =?us-ascii?Q?/zm24fx4nuyeRLH0TSd9JMsseZ64xNqcjZYJFk7Q4o8SKYPKYZwE62pO2pEc?=
 =?us-ascii?Q?pxV6GYjYkVfrlicGojZ8Okton9OAEdQTg9bv0q9RWgEdDYhUAMUAqENOURnY?=
 =?us-ascii?Q?6bbDiFtn5AT/3agV1wJBRbKWVqIM5i+/ijUzUyO0vonV6B5SThFR4ienbzjD?=
 =?us-ascii?Q?6qFYuK3vIk/o1YkXPcDEC9Cx9VgAfJxVQBl/Je9MsSJqZBVpYCONwDQTC88V?=
 =?us-ascii?Q?z9pdct7mwwitGzslLzL9nOgqsqoNKeMnAgNQiQaFXEiwRY1acHDMGg9xt+Wo?=
 =?us-ascii?Q?6ZwaRs9nc50tA9Zjr1NHVRwnkwYNVHBp2BWiuqfZdykHYLCeBuszqZPNLtXB?=
 =?us-ascii?Q?JXv4l0czrsdHONPJBxvVHIQaxkqfnr+snYjnPIiOrw3XMQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B181402553EE2B42BA03F7E60E7F5168@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d93346-b962-457b-a704-08d96b9b4485
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 09:48:06.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVRkSV8FgnbFE3sJvufGyWVX2yzCUsYB1zEn862FBfqg51mRtH+DHQyVz4+qbmxN2sQPJOc0YaTFF5Op29fS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7623
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 09:28:07PM +0800, Ming Lei wrote:
> On Fri, Aug 27, 2021 at 12:41:31PM +0000, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Currently, __blk_mq_alloc_request() calls ops.prepare_request and sets
> > RQF_ELVPRIV.
> >=20
> > Therefore, (if the request is not a flush) the RQF_ELVPRIV flag will be
> > set for the request in blk_mq_submit_bio(), regardless if the request
> > was submitted to a scheduler, or bypassed the scheduler.
> >=20
> > Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
> > if it is, the ops.finish_request callback will be called.
> >=20
> > The problem with this is that the finish_request scheduler callback
> > will be called for requests that bypassed the scheduler.
> >=20
> > Fix this by calling the scheduler ops.prepare_request callback, and
> > set the RQF_ELVPRIV flag only immediately before calling the insert
> > callback.
>=20
> One request could be inserted more than one times, such as requeue,
> however __blk_mq_alloc_request() is just run once, so is it fine to
> call ->prepare_request more than one time for same request?

Calling ->prepare_request multiple times is fine.
All the different I/O schedulers (BFQ, mq-deadline, kyber)
simply use .prepare_request to clear/set elv->priv to a fixed value.

>=20
> Or I am wondering why not call ->prepare_request when the following
> check is true?
>=20
> 	if (e && e->type->ops.prepare_request && !op_is_flush(data->cmd_flags) &=
&
> 		!blk_op_is_passthrough(data->cmd_flags))
> 		e->type->ops.prepare_request()


That might work, and might be a nicer solution indeed.

If a request got plugged, it will be inserted to the scheduler through
blk_flush_plug_list() -> blk_mq_flush_plug_list() -> blk_mq_sched_insert_re=
quests()
which will insert them unconditionally.
In this case. we know that !op_is_flush() (because if it was, blk_mq_submit=
_bio()
would have inserted directly.)


If we didn't plug, we do blk_mq_sched_insert_request(), which will add it i=
f
blk_mq_sched_bypass_insert() returns false:

blk_mq_sched_bypass_insert() is defined as:

        if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
                return true;
Also in this case. we know that !op_is_flush() (blk_mq_submit_bio() would h=
ave
inserted directly.)


So, we could easily add && !blk_op_is_passthrough(data->cmd_flags) to the
->prepare_request condition in blk_mq_rq_ctx_init() like you suggested,
but since the bypass condition also seems to look at RQF_FLUSH_SEQ, wouldn'=
t
we need to add RQF_FLUSH_SEQ to the condition in blk_mq_rq_ctx_init() as we=
ll?

This flag is set after blk_mq_rq_ctx_init(). Are we sure that RQF_FLUSH_SEQ
flag will only be set for a request which op_is_flush() returned true?

(If so, then only adding  && !blk_op_is_passthrough(data->cmd_flags) should
be fine.)


Kind regards,
Niklas=
