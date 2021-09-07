Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A5EC4332F
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543DC6103D
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhIGOXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:23:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17679 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhIGOXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631024516; x=1662560516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NfKgIZnJTpnqdTH7n+03JPvfkUkveonE5vDXeKwOr7g=;
  b=E0EGMAAcwjgq/tMVEGSLwwANe8WLq2A21BJUprZvpIvRgJdU0ZpVnxXI
   HD7MQ6jm4P/ziiOO1NmGXZJAZ8GBnTL+b4Vr24NY4A6S4jewPNW6Qa3G1
   rOejIjoFz8JcB1iaInrwu7BuwScYRNhA4jePQwlXuPSdV1bdX+XPFOeSw
   ELtGXOxfT5M5Mw7FNS6D7h4C6+qkxKFctQ3Gis/tx20LQVaa5tNlb9lfk
   tGcLXQtIoCViL35xKp4CARW4yQv6EZXTsMVjpJLyKyL6NrkQFcbKBAtad
   e5eZB2rsWTsC3lPcQaGL2FYrP/E/tBWHwdk5zx+4+gRQRH90BJuq0prk2
   g==;
X-IronPort-AV: E=Sophos;i="5.85,274,1624291200"; 
   d="scan'208";a="184162950"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2021 22:21:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6h0jrxShObqfBT7nsQszLKtmzQY+sXghNgsmbP+kboOS/VWJp7E6qctgkq2Ano8+8FAzv7JE7DBye3bA0sWGsa4tstPTwWwi6jDXFC2mJsq5oYyCQz+dtw70slYR/GMYxesCED2xdWYOWWi5eDsXpHfsoeG3M6pHPPiu3/FM9sPgqB2GB2IEv1cB+rIxqyJ7++sFawIo+nawJ1W99V8Fy70ehwh4pmXLJrYpT3hwhzxBX3WrRYTwBdAfcrjfD/YlLyS9Yq0xWp39+82vRUuzV5Q5cI9Wv4sBeTCCTeWo4xtuvpe+FEmVqV2HQwNObg16i+1LtDr/iM7mC0xVVhH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cRbK6/CmJgEd3dgnXdcRLqexu2Y4uNocW/0E58DQUA0=;
 b=VDd8Qln8fB5k1ZIP/2mGxXOYzCiiBEYt54QI0g7kXCEm9jL5tZ4dWvWHuqkvN60LS9/ez8oc3j05cHcjMI4h0D4OGlQa3Xnh3xaf00gGT4uGBUR1xJh918oYe+fD95zFdguQwrI1iKeZ/GnBXXhLc4MkxcIkPtZjUYQTnog6XY4fFeeh3vw9wlzmE0etrernsamDb8pUCVwm5GyAD2uh4lKucwIv8e0z5b8CCvPKeCF0S8wcl/WgNcM1ICwm+ujkurbpH5miX3dBBDi2MtTx8Npt/auC9lyqL0wn4XrYHtkjEB0YUVHjcgvlp7UoSVdKeOxgu7YnAw76UdQca7IlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRbK6/CmJgEd3dgnXdcRLqexu2Y4uNocW/0E58DQUA0=;
 b=Tuq5bIgDaYQflyiHEPuB/QZAe+YM9b9i+sVHi+OG/J4jMEf6NYwz6UMUCnnQBrl6Ty8R3JJPnapyuacExTHrcdGE39iDnkyT9feE2nZT/eDTQpVrSoPbgdU0K57h5TZqtGdYPMK5nnCiKLSjKdWU1sQEc2yvfhvIaEUHX/xh8ks=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 14:21:55 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 14:21:55 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] blk-mq: don't call callbacks for requests that bypassed
 the scheduler
Thread-Topic: [PATCH 1/2] blk-mq: don't call callbacks for requests that
 bypassed the scheduler
Thread-Index: AQHXo/O1j+Dxeg06HkOKzFhsF9jhAg==
Date:   Tue, 7 Sep 2021 14:21:55 +0000
Message-ID: <20210907142145.112096-2-Niklas.Cassel@wdc.com>
References: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
In-Reply-To: <20210907142145.112096-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eac2590-4489-4a9a-9f43-08d9720ad84e
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7382AD7E97EC4769290F8BD3F2D39@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EI5LCfTFsZJMmLO4WfD62UuKP/VgnoKMKFQI1LG8yceaXrydwxQy/p7hq6JG8Qx2ORqFKH1tA5NykWKRT5jL8vSNj66YzlwVxJL9lRj6TJZt7x6uotPqh3AAy5mBYKQsn/6j4+f4cmMN/PXV4VOM/8QnC1Ino0Ji2D5kO8jednHV0BcgqufChO+wKsiSdGX3fxhBcMzfJcz/boZShvvDiPkQm/xp0ANmkES25UZAeZjUrnlsuKBUZgYgV0ZEVqDie6cZBqNeUQH4r6Hq3aJ8vnlmZu9jg1B9qA04QH0KvpGh3MdjKfhdumplO+faH9CsTKYEb0pOBqSVZ249N18piR7njWije6ORsaN/ZowDs56NsOKFUDq2+ExO/h8VZ6LtlhpMUcOe2LSwgRsPDhJG0OEdWvWKRJj+OhE84RZlcuqgQi1l+Vops/qCEuAu5XogN4s9PGAuHR1OV8B/KooJ+rNr0plv+RngHK+VuZGX+Z2YyHiI4YtEtsI2lu/aLaoIIRPcCSLvKxdmTH8H5VRtLKVHDtXlbQn7vi3zOQFFBtoiMHyxggvRcmdz+x1nKmZpTInPIDjRalMabp+PO/ll1YNoJAPe69OQvBrI7JCcHL4oXgxgo4yOVjI59FLUjfrxSOjxeZpmVtsLmUJFB9KzjFDB9sfNiQbjuDFqivXKQOOYbYoY/By1TiCvE+2FQqPI8tdA9tAUAhQVSadAcFBnug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(6916009)(2906002)(478600001)(5660300002)(8936002)(2616005)(36756003)(186003)(1076003)(64756008)(66476007)(26005)(38070700005)(38100700002)(71200400001)(6512007)(122000001)(66446008)(86362001)(66556008)(76116006)(83380400001)(4326008)(6486002)(8676002)(6506007)(91956017)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TxTU0HNC2n0uFsHex8u1RDbMceoUu74vp8a4FUVJOhzuiIhs+oGkfaJ4iY?=
 =?iso-8859-1?Q?D//jz+RcHoNHtohbnF1HhGrStz9Vjad0KUlA7lhLLrGDz9YP5N664Vri4h?=
 =?iso-8859-1?Q?iox5px6lJ7MfwhcdNFwPVonnc8cwTUWvXg77b8BdnkWj1gP8YwNLd0ptMP?=
 =?iso-8859-1?Q?FQkfXL40WPCJwzFSeSpy3lZVqkihTnNnzjEQTk7jnJs+EAGJgxAVr3cY61?=
 =?iso-8859-1?Q?ADrTcsXDGiFEVCxYJn33lzHAcsoEjFR7yF218BMZ6Qic2TUCy79mfThGdm?=
 =?iso-8859-1?Q?MZ5jZhIkkVDmlb76OpisHNTGLra00fw5p57T/NIbF5Gh7ro1C+HwLLpFYP?=
 =?iso-8859-1?Q?9FDX2hoHRv3pZzMnIuFy7lnaqCzk1ONS3qy0bKgAMWW6hq/CnfM7OPHrKf?=
 =?iso-8859-1?Q?l8HK49Ij3glQ7FlKiUgRN1SDk8isxrWSXSrDwo2ChSI2x110gSnnIO/RC5?=
 =?iso-8859-1?Q?5c9eoufN6Igid49iD8GhZSZd6ZQADseQ2bSQzDQj9W6D3ydVeLKTASyxd+?=
 =?iso-8859-1?Q?tbVRZhH1kFe2v6LwKhBiMv/aBOuwLreIXINwdgUi0r1e6ONiyg93gdgrX7?=
 =?iso-8859-1?Q?rJYq/J3u3RhwD8msBcvMnZaeRK56Cr/LC7HjUi8DfXSRXJitBYAnTd5ewu?=
 =?iso-8859-1?Q?DGvBI9qax4nSuGSpUW1CpOQJ/coWKRGxNfhjvdfxPDd1+sgDR7oKlVVR+M?=
 =?iso-8859-1?Q?aOBmJQ0s1cnuGtX0g5BctvwV4Flk9kYNcX3bO43IXk5seJ8TVnR7TnXXfr?=
 =?iso-8859-1?Q?9SYvWyKVBzhSbaViIJcgWsxVcwhu2arT77QzomqXeMgsiRL0vnnGvFO/mF?=
 =?iso-8859-1?Q?RqgV1An3DOdTsj1847C1KgaKQSEw7bobfP0BkpB0GTA/Lqha461qqxSDqI?=
 =?iso-8859-1?Q?mGjEQw8w3+t76NporHNFUs28cWKjWplVZ8L1sYM6wcNFLNCF3B/iO/Fsy/?=
 =?iso-8859-1?Q?P1sQZxteBprSSGaPNHtTQIX6J8upPvxpmNe99zHGmHB8DZSK4iMZ9y+f7T?=
 =?iso-8859-1?Q?ZiEyo3kYpTzy+Bu6ELCR/TqQTrPN9sSTbZsrMTvzakG2VgTfofnp6F5g0E?=
 =?iso-8859-1?Q?rn8tQb1+CaoWX/KhV2DUvsWZfvPTRvpHJQNpEgMzlYiEh64t0lWPDI0aH5?=
 =?iso-8859-1?Q?OPRQFEDO4ouhAwffQ7l4BOKstfBR0afXp5ipRBlMjHU0fkZEViDNNLUYdt?=
 =?iso-8859-1?Q?puqKmUNZGC0y9X/w8g2erO3imL6uIVhQQifrN2FwsA6if9u37anpkSOxDq?=
 =?iso-8859-1?Q?5OEOo3MvhQcxuyB3NrYhSykMGhuBmgCLYXTevwaw18CIGypUd+XvLcorEL?=
 =?iso-8859-1?Q?dMi7aNmXEGsfjW3b9G//48ZbKG6tPjohQtcAlY6HBxkBcLgtq+mIqmoPKB?=
 =?iso-8859-1?Q?FbRDki+I0PC+Kebc0mhkBwZ9BQqi1DMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac2590-4489-4a9a-9f43-08d9720ad84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 14:21:55.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZ7xs9Ti7QGdeBSldJyHMhsv5b6NUWyKRQPXJn/I/h5JCLUGSLi2mI/IiVdpRn3YZRWAOBki/M1sdF67XP7F9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Currently, __blk_mq_alloc_request() (via blk_mq_rq_ctx_init()) calls the
I/O scheduler callback e->type->ops.prepare_request(), which will set
RQF_ELVPRIV, even though passthrough (and flush) requests will later
bypass the I/O scheduler in blk_mq_submit_bio().

Later, blk_mq_free_request() checks if the RQF_ELVPRIV flag is set,
if it is, the e->type->ops.finish_request() I/O scheduler callback
will be called.

i.e., the prepare_request and finish_request I/O scheduler callbacks
will be called for requests which were never inserted to the I/O
scheduler.

Fix this by not calling e->type->ops.prepare_request(), nor setting
the RQF_ELVPRIV flag for passthrough requests.
Since the RQF_ELVPRIV flag will not get set for passthrough requests,
e->type->ops.prepare_request() will no longer get called for
passthrough requests which were never inserted to the I/O scheduler.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 block/blk-mq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 65d3a63aecc6..0816af125059 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -328,7 +328,12 @@ static struct request *blk_mq_rq_ctx_init(struct blk_m=
q_alloc_data *data,
 	data->ctx->rq_dispatched[op_is_sync(data->cmd_flags)]++;
 	refcount_set(&rq->ref, 1);
=20
-	if (!op_is_flush(data->cmd_flags)) {
+	/*
+	 * Flush/passthrough requests are special and go directly to the
+	 * dispatch list, bypassing the scheduler.
+	 */
+	if (!op_is_flush(data->cmd_flags) &&
+	    !blk_op_is_passthrough(data->cmd_flags)) {
 		struct elevator_queue *e =3D data->q->elevator;
=20
 		rq->elv.icq =3D NULL;
--=20
2.31.1
