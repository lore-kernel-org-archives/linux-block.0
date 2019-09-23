Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA4C04EBF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EE620673
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 14:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407619AbfIWOlH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:41:07 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:33221 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407614AbfIWOlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 10:41:07 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY m9a0003g.houston.softwaregrp.com WITH ESMTP;
 Mon, 23 Sep 2019 14:40:27 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 23 Sep 2019 14:02:03 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 23 Sep 2019 14:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLvMrxLj3BVIrnYjUVilPxByCxpLTDARRt6zuXu9CnIlFkKk3RhEJGFACRcsIOmhommd3E3C1PxjZ0fXnELD9CaCGDqFNT1o8+AcOd9j2svq3H18/7gpA2bYwrXVSaaER95xIChSEJqNBp2hV9AWYhyeTk+Q//eYLerPD3h4Emb/zHl9gSnk8yiHVThaA1MzZm/VEIJ994JkaH5+0dpmPtIFmnlCuokRCARWeNyn5UtKxNYKRJjCKC8YzZ5WEZUpcXQc6kLbbcbm3Spc+rEC6ykt7617BsNeElr3GhfMRQTAmiqt5pyA6s2M2QLnILbYy30Wbw4ycoo6wJjGn24OXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aSpVoW4mIFex6eK1isNgd0tXSLMGWUw7OvMpnddRq8=;
 b=jLOr8mDcCsLdiHOcvj1ie6++kJ13N3o3jdNQER7gdakbv/CaZtH5qkhCqiDWci/+UXqXZvH+jNJEDyWNS+8hckXh27jlK55uP5hkwaa3sRRoQUAAx8k1zWBTXKn+NI58qMN6MpBE8DFB11w1gp0Z9HzrOKyU2zr75+IFdMwQ/Uwsly1CU8lXERYJy0xe+Yxiv1eCWJ6NchoOcjFlbKhlg9TNBCo/UU2nPMwdypSHLfs0IvTQZKxRU/XKR2FjdUGfRpP8tCuL6CpB0MyDKSp4D5jAQ/NpsAs/Gn+gMb4lCiaD6sQteUXLSCs7MYsOjxdaZy5zHCaFLCXSr0oWVxzoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3349.namprd18.prod.outlook.com (52.132.245.83) by
 CH2PR18MB3191.namprd18.prod.outlook.com (52.132.244.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Mon, 23 Sep 2019 14:02:02 +0000
Received: from CH2PR18MB3349.namprd18.prod.outlook.com
 ([fe80::1075:2453:9278:e985]) by CH2PR18MB3349.namprd18.prod.outlook.com
 ([fe80::1075:2453:9278:e985%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 14:02:02 +0000
From:   Martin Wilck <Martin.Wilck@suse.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Martin Wilck <Martin.Wilck@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [PATCH] block: drop device references in bsg_queue_rq()
Thread-Topic: [PATCH] block: drop device references in bsg_queue_rq()
Thread-Index: AQHVchd58urpL6Qt/0uvKjMFlb+bag==
Date:   Mon, 23 Sep 2019 14:02:02 +0000
Message-ID: <20190923135744.13955-1-martin.wilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To CH2PR18MB3349.namprd18.prod.outlook.com
 (2603:10b6:610:28::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Martin.Wilck@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [2.203.223.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c38d0f35-7fef-41af-05b9-08d7402e9ba9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CH2PR18MB3191;
x-ms-traffictypediagnostic: CH2PR18MB3191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3191B075477AF95E1AC78A63FC850@CH2PR18MB3191.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(44832011)(476003)(54906003)(6486002)(6512007)(1076003)(66476007)(66556008)(66946007)(64756008)(66446008)(6916009)(7736002)(316002)(8676002)(305945005)(5660300002)(14444005)(6436002)(86362001)(81156014)(81166006)(50226002)(8936002)(4326008)(256004)(26005)(186003)(6116002)(3846002)(2906002)(102836004)(71200400001)(14454004)(66066001)(99286004)(36756003)(71190400001)(52116002)(2616005)(486006)(386003)(25786009)(478600001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3191;H:CH2PR18MB3349.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: elKIAdeRX25as1ehHkhvYGoLC0NCCbn4/ezENfwReuxCVgvqlQeS4C7pkLAQG5JQkj7QdHYKdntoS3+L2HAvy31NM9Txpw+SmcdRKtfKVhsJxsbLQMigjRN3rYSgkU7XBOyjw0UKGJa2+reUozWVQCt5VOuT8VZ4qiasj/sUlaqfR8IEFd3QCjlJCs2skEhg3KRhTRmreZ5Dth51wf1C+4zAqOEfjaan0z4kmbE0p8LOKmWZFtMZBgiKWs1O4zl1xTAZaQxrpuEuCEcfmuTSevz4/xWJ5wNTiJToxoGjk4rSknAIROfj88MTgL2M7txUqD5tPTWSMyCSJuIJdOJmcQy4fRIhySqyKb5LMKYH7XmQlhk3Lk6XHS/QA/UyPCWU2b5WYgqrIXclN52pOIK6bpH9qEpM06dzzuYBGp4gbto=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c38d0f35-7fef-41af-05b9-08d7402e9ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 14:02:02.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHCTe8phUPEBHVtfH0iXdWycuvj9JqqYNv+wM/JvolhQN0sOI7k2FQzdOrbQ8lz5zFkkIrA6+LJd5VrkBi8RNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3191
X-OriginatorOrg: suse.com
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Make sure that bsg_queue_rq() calls put_device() if an error is
encountered after get_device() was successful.

Fixes: cd2f076f1d7a ("bsg: convert to use blk-mq")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 block/bsg-lib.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 785dd58..347dda1 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -266,6 +266,7 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct bsg_set *bset =
 		container_of(q->tag_set, struct bsg_set, tag_set);
+	int sts = BLK_STS_IOERR;
 	int ret;
 
 	blk_mq_start_request(req);
@@ -274,14 +275,15 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_IOERR;
 
 	if (!bsg_prepare_job(dev, req))
-		return BLK_STS_IOERR;
+		goto out;
 
 	ret = bset->job_fn(blk_mq_rq_to_pdu(req));
-	if (ret)
-		return BLK_STS_IOERR;
+	if (!ret)
+		sts = BLK_STS_OK;
 
+out:
 	put_device(dev);
-	return BLK_STS_OK;
+	return sts;
 }
 
 /* called right after the request is allocated for the request_queue */
-- 
2.23.0

