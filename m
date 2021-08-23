Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D0C4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 07:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897F661242
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 07:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHWHh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:37:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32434 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbhHWHh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 03:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629704204; x=1661240204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i2giRoWXwOSWPMArJMd+NlYKd2x3XCMB9khMUVgPU3A=;
  b=bFSiZkKbOI0HO2SNBemyFcvGQQJ/sZZxw8PUwbKcEyPk/wynmNRoLBg0
   vvAU84QKKcxMcuBN+nYCWKQf6F0ZbjryJ4WKOhZDsYuh5qbRcGbui4lV+
   5w38pa6Ci44Jt++Y4qnoG9ehEdihiZPp6L8gZkakmx0UpK4/ueyf4N3MZ
   jPGRvZDmpoiERKeVVCX0P5U/ysWrBGy5y+pWxFNtHCA/ldrCRDPEdqdA+
   u01d1T+GHwhYzovQRS5mDuCOgpeOPaiDAkaWfhXSY4A6Jz50vt9RUwuql
   GY/CvxfxuncVdjCbe4k26m3q9E28yiGsEldwr70n2P2r7d4TViHV2GyfS
   g==;
X-IronPort-AV: E=Sophos;i="5.84,344,1620662400"; 
   d="scan'208";a="182865377"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2021 15:36:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFmhU7lL83ZK/8dM6YE/bih/lM6NhOzn1sGJVXwm7Pi6z2+L68fdqsism7W25EXoQp+3u6G/hND0aDrnNDXh1fHseVzEM58r5icdRfyjlzR3x7B3lQOs0IjqtCJyj7fNK4WNMO4BGXEyIhZ0CucSakGk/bTXFecRp0fcsXLS6EfwGgxcRZ1aW56HfeZB2IN4kOG5x+yntQsBPKUpczRb8blVVBUG7NnyzMbM5LetAZfi3O8HJvxk+171sVkecx5xh/E0S3vqDnBSAM0cvLdM0qLQiTeaOkH8wvsD/tEIzCMcYV3GIlpuPnEE7Z7sdQVcFVr6Rvq+qHfUHq4ix1H5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6xgrTnR92H84o98+89YTcAqTOTqFbs1lgMm2isR4io=;
 b=eoBU/9Hry8zKo7gzQgunp7Vxm0jFYpLLASs+4njy/BF+EttOPcrotpOIoVoghiew4X0t47zRbcF9T+glP8OCj25xc9AC4TbCYpe9PiaP9/k3e/9pZMP9+hdnUugFl7EludNIbN2NNHX5Ug+ZC9rsjy6JrCs7PHB2ULS9nC11KAiV6uFH0YcF0d/826faBy9WeJH8p+O254sbLHM/ZJjUoUPuNFT4nfdttTpvzdXbSs4I4wQSwbfbgRDBDU6x89tBxnwg8zNsXnDOPjy4Lnk3p0y0EoXKe9JrN8eIbzsBtHHAslPzub0AGfQFaM1dNTbCbrxJ9g2WmS2SHoqwZ0ptaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6xgrTnR92H84o98+89YTcAqTOTqFbs1lgMm2isR4io=;
 b=Y3WRYzF+hQVmX6/Zdd5PqxaAaG5tROHC1paw/e/uLf0UPIpzH3lH36VaooIOb6n2b5B405oSY73ErpMPixfOx0XhcsHNDpvxl481ZuTwkhxzfGlvGRm1F27n7xjgslZ515VrUKZqQeNSFlwoHSMxWwL8nq2pFFEBJNzsvU7DGsY=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7704.namprd04.prod.outlook.com (2603:10b6:510:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 07:36:36 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 07:36:36 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXlVysvcZeBwZKNkSbW/SgpyhLO6t8sO0AgABT/oCAAAlKAIADqkMA
Date:   Mon, 23 Aug 2021 07:36:36 +0000
Message-ID: <YSNQAu9uXrmEteXc@x1-carbon>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org> <YSA1JWt9soMSs23Z@x1-carbon>
 <e94f62c4-a329-398d-5003-d369506d7f89@acm.org>
In-Reply-To: <e94f62c4-a329-398d-5003-d369506d7f89@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ff3fce6-2c09-43e4-3b16-08d96608bcd9
x-ms-traffictypediagnostic: PH0PR04MB7704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7704C5972CF736BBA146A4F7F2C49@PH0PR04MB7704.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzUVtaBcwBogaiafBChWfhImvHgB7QsovYFGjBz1Xb+KVF3ZBo6iVbc0IEfmJADOJeNv/2pZN4GocPfNAIz1GVTk2syBDZ80juJ1wyKhjSmtvPK1B6zeOCmM4YUfODpf8h/odvQwgY3dsCqfmXJTh7LZCCm2bA16gwTr/ZTsutBJWdhF0B+GmciXrwwnXFfLGfyCwiTW1/IM8/0QnUvlCBj94i29LvFKFBJxziAp9JerDhi4QBc/qvjHIvbj1SWxja7Kbnm5hPNgadtIyr13zVoP8rsoFbYj7rEQa9Kg0Wn3g5RCsglFoejZCf0jD92/evJXL35kvMpirfnAbMl2PxFHo3Dv09l9kMsLqD0jN8c8UVPBSpuBPF4Gk6uR8q16EouaLT6Si+JLoAswizM/+PpIzGYoXm0ZeYh9AnLApcfzFioSYKRUIdpD4GwOliKB2u9nYBXCLd6vL/w+FsoxPFWLYbfHYLOLrcWMtlY+dDUjJYlQEixUHWvWnISYaieTdeSjRFXbK9OsWPGUIZ9aX+bSJ2nSxrUF+k82OlScAAO2SZWIoeD+KXJVfzoLIg5l4LRRd8xND02ddRbvp+3oqbx5UVX3lQDNAmou7/J2E6725uXjopO50b4DHIxkIV0tEVY6Fxnhouj3NkLY1VUf/aiZtOCf6QBHXEoEwZsTGYBFfu5mvQvPkHj3elg8vUxld4xz8gc0u5IBXzM4CN/xGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(76116006)(66476007)(66556008)(64756008)(66446008)(6916009)(38070700005)(186003)(66946007)(122000001)(91956017)(4326008)(316002)(8676002)(5660300002)(6512007)(9686003)(26005)(54906003)(71200400001)(33716001)(6486002)(508600001)(53546011)(6506007)(86362001)(38100700002)(8936002)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OsyBeXIseKR1zq0NLEsxgYvxet3pIe0fFcfLUugNrOyk9Z2b51W8NSLAaVIi?=
 =?us-ascii?Q?pVAjJ+jGfxP8aENuXBZ1xMiTP1KvoBJB7vQ7Zok4WSxzirAJTRQWzNAtYNRo?=
 =?us-ascii?Q?CRVIfdRKNYljfjCHCB41fsSaY3Lh19UbnuSBP57XgK7N6aJsW3acXxOfjAQR?=
 =?us-ascii?Q?/pQ2KCdNG84o8mzcOw24M+qhSjahZ9IHPsKK36jIgGg4ApjgB9vcugNXv1DJ?=
 =?us-ascii?Q?+rj2YdY/11ipyKRNKKzyuasGdVK81Glyphz6yAGT65oLM5XtShKCZ7GsazDu?=
 =?us-ascii?Q?1Pn1xtZdlAP0MfmN+iWYtroaiFq73WHUmDo7IsG7g74u4rxERwuhdxn4jRZ0?=
 =?us-ascii?Q?on1Gfk5Q1Apl3memzzOBR+G5FujBj7GgQaVMN4CbSko0gACgUzXPGF3258+B?=
 =?us-ascii?Q?PeUbO/FLq4gQRNQ2tkCrt4AoEOPmojm+mEm60YyFXh+O6EhrpYIcibTHnV3I?=
 =?us-ascii?Q?mA4wPXeXj4xYSkjxDL2j3ndKjcXh8vKpCoQBV8TtU3qbneRtDc+WnVKZdGMG?=
 =?us-ascii?Q?/7Q513NkR5eDe2PCTkUE716OTEEDtMKWm+ZePoBnWZpIdTStv6ne9VGsGpf2?=
 =?us-ascii?Q?cFkM6lML3uscXrpaXkq/tKmZO6SuHLTMgmcHrZfVGMNvKLz3H4e33rCRUt9y?=
 =?us-ascii?Q?LVHHvgqB7KSoOjxSX6uySzJzQV6ygNtOvQkR6qAAxGiRQdaSSgOGFauas2hP?=
 =?us-ascii?Q?QYZMdEC1nbanDbhpE1UK+GSDZKFwp/8XlDwzziIpESYxP0lweEegGCxxBLWK?=
 =?us-ascii?Q?WJTVYLg8oKmSJfRU8sqZnYoyyQTIkvtt8b7cxHfal7CinA7GLf37xPwa1MvB?=
 =?us-ascii?Q?CzaYIAHkNNTDy8kO5uqGYR0arkta66b3/W5gG4tv+xrj1+XRr4M6iIsPFZEz?=
 =?us-ascii?Q?XXTtMnUm6NTO1EqMA0/ffR6a78gQNUTjD/sdTpLjoa1dw6OOPC7nKCNpNBjw?=
 =?us-ascii?Q?3KAANl+nyjiI3Cc8tUqjWrvyjxnI9lG9CPxIRdh8ihLCf7QvAPTxvJSpePh2?=
 =?us-ascii?Q?4C3EYwww9L2JKQzur9vE9pAW4us1L7w9tb+kv8bvp5I+DRW0QSWaF+vo9c2k?=
 =?us-ascii?Q?npQB7i6Ur3vQkWqeZw0N9nMo8pAIkjBbRtjXkWHnp2WM0QFs/c9gnGZkyWQE?=
 =?us-ascii?Q?G891tsUVhy+cRpN958JMMXwnY7qdU4MUmGOlznYCoqkJOY0UP0aJfCr1paXd?=
 =?us-ascii?Q?Mqe52hvRZP6wDPlmYIGRyyws7/0NwxvIXf9SJIHXzt3N3ykt+pN9hFj/PE6k?=
 =?us-ascii?Q?29oOIK+/umWBNA779qD5yKfEJKGWjtFxsmyeXENURpsuoHil4vlzUTdz7rPv?=
 =?us-ascii?Q?OZiKtWcpgmiyohMwwJINBjFO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9CEBAA3E6B55D42911E34EF31A69E04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff3fce6-2c09-43e4-3b16-08d96608bcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 07:36:36.1799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FEOnpkTvsLcV9kdx07Gh1BDiQOchaCeSdVl3neiEVUKYGWUfDQYjHXJwi9QfI6do9cLMEIntMT6nB3eSpHudw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7704
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 04:38:24PM -0700, Bart Van Assche wrote:
> On 8/20/21 4:05 PM, Niklas Cassel wrote:
> > Thank you for your patch!
> > I tested it, and it does solve my problem.
>=20
> That's quick. Thanks!

Thank you for the patch!

>=20
> > I've been thinking more about this problem.
> > The problem is seen on a SATA zoned drive.
> >=20
> > These drives have mq-deadline set as default by the
> > blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE) call =
in
> > drivers/scsi/sd_zbc.c:sd_zbc_read_zones()
> >=20
> > This triggers block/elevator.c:elevator_init_mq() to initialize
> > "mq-deadline" as default scheduler for these devices.
> >=20
> > I think that the problem might because that drivers/scsi/sd_zbc.c
> > has created the request_queue and submitted requests, before the call
> > to elevator_init_mq() is done.
> >=20
> > elevator_init_mq() will set q->elevator->type->ops, so once that is set=
,
> > blk_mq_free_request() will call e->type->ops.finish_request(rq),
> > regardless if the request was inserted through the recently initialized
> > scheduler or not.
> >=20
> > While I'm perfectly happy with your fix, would it perhaps be possible
> > to do the fix in block/elevator.c instead, so that we don't need to
> > do the same type of check that you did, in each and every single
> > io scheduler?
> >=20
> > Looking at block/elevator.c:elevator_init_mq(), it seems to do:
> >=20
> > blk_mq_freeze_queue()
> > blk_mq_quiesce_queue()
> >=20
> > blk_mq_init_sched()
> >=20
> > blk_mq_unquiesce_queue()
> > blk_mq_unfreeze_queue()
> >=20
> > This obviously isn't enough to avoid the bug that we are seeing,
> > but could perhaps a more general fix be to flush/wait until all
> > in-flight requests have completed, and then free them, and then
> > set q->elevator->type->ops. That way, all requests inserted after
> > the io scheduler has been initialized, will have gone through the
> > io scheduler. So all finish_request() calls should have a
> > matching insert_request() call. What do you think?
>=20
> q->elevator is set from inside the I/O scheduler's init_sched callback an=
d
> that callback is called with the request queue frozen. Freezing happens b=
y
> calling blk_mq_freeze_queue() and that function waits until all previousl=
y
> submitted requests have finished. So I don't think that the race describe=
d
> above can happen.

I see.
I was mainly thinking that it should be possible to do a generic fix,
such that we eventually won't need a similar fix as yours in all the
different I/O schedulers.

However, looking at e.g. BFQ it does appear to have something similar
to your fix already:

#define RQ_BFQQ(rq)             ((rq)->elv.priv[1])

bfq_finish_requeue_request()
	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);

	...

        if (!rq->elv.icq || !bfqq)
                return;



So your proposed fix should also be fine.

However, it does not apply on top of Torvalds master or Jens's for-next
branch because they both have reverted your cgroup support patch.

If you rebase your fix and send it out, I will be happy to send out
a Reviewed-by/Tested-by.


Kind regards,
Niklas=
