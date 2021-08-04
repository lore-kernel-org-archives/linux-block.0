Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9249C4320A
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB66761037
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 19:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhHDTz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 15:55:59 -0400
Received: from mailout2.w2.samsung.com ([211.189.100.12]:26484 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhHDTz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 15:55:58 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2021 15:55:58 EDT
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20210804194925usoutp0234e135e6916244b4f36407ff6290ec47~YMkurL_XZ3260332603usoutp02D;
        Wed,  4 Aug 2021 19:49:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20210804194925usoutp0234e135e6916244b4f36407ff6290ec47~YMkurL_XZ3260332603usoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628106565;
        bh=iPJJgN7exbTX3nbTqld4O3ri3RIJFi3D++eQxaJTlwA=;
        h=From:To:CC:Subject:Date:References:From;
        b=bpAQ/TWvlJ9Dqdq1zw2QG7lyzvGhfKZeeXfyXand7hyIc/DaucOf1rGFm5x7RE6oh
         kFUIUI9sLsrXsMcfvCrJb0wYT0KyXt9LA35rKjC39F8te65AMMdoywQevLXcwnMeWG
         xqwKI/GQUuJ6d05RechBe/TA30W1nw2Wg76aGQEQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210804194925uscas1p19bca600cc4a48d6025ef92f5af41278a~YMkuKu_T-0698606986uscas1p1y;
        Wed,  4 Aug 2021 19:49:25 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 02.14.19318.54FEA016; Wed, 
        4 Aug 2021 15:49:25 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1~YMktS7Zfx0034900349uscas1p2C;
        Wed,  4 Aug 2021 19:49:24 +0000 (GMT)
X-AuditID: cbfec370-c37ff70000014b76-5b-610aef45672b
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 80.31.47905.44FEA016; Wed, 
        4 Aug 2021 15:49:24 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Wed, 4 Aug 2021 12:49:23 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e]) by
        SSI-EX1.ssi.samsung.com ([fe80::1014:4c20:6d82:fe0e%7]) with mapi id
        15.01.2242.008; Wed, 4 Aug 2021 12:49:23 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH] kyber: make trace_block_rq call consistent with
 documentation
Thread-Topic: [PATCH] kyber: make trace_block_rq call consistent with
        documentation
Thread-Index: AQHXiWnSzGvWUauQbEyrvzyTV854vw==
Date:   Wed, 4 Aug 2021 19:49:23 +0000
Message-ID: <20210804194913.10497-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djXc7qu77kSDVon8FisvtvPZrH3lrYD
        k8fls6UenzfJBTBFcdmkpOZklqUW6dslcGUs/7WdqeAKR8XfwyINjHPYuxg5OSQETCT2PZ/K
        0sXIxSEksJJRYkbXc1YIp5VJYn7/NKAMB1jV5uWuEPG1jBKrer8xQzgfGCUmLXwG1bGfUeL0
        2vtgHWwCmhJv9xeArBARSJM4cWUF2DpmAXWJYxs3sIHYwgIBEvPnvWaGqAmVmLX8BSuErSex
        6PwiMJtFQEXizYafjCA2r4C1xL/p/8DmMAqISXw/tYYJYqa4xK0n85kg3hGUWDR7DzOELSbx
        b9dDNghbUeL+95dQN+hJ3Jg6hQ3C1pZYthDiBl6g3pMzn7BA1EtKHFxxAxwsEgIf2SW2b10J
        lXCRePTkFZQtLXH1+lRmiKJNjBK7uyawQiR2M0ocOCUDYVtLLPyzHupSPom/vx4xQoKUV6Kj
        TWgCo9IsJD/MQnLfLCT3zUJy3wJGllWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiBCeP0
        v8MFOxhv3fqod4iRiYPxEKMEB7OSCG/yYq5EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxzIyfG
        CwmkJ5akZqemFqQWwWSZODilGph2K0bpv46ScD8Wblj8dUn3s4g5SXamp65c61u8hcv37S1/
        dgf1u/P4vzJMF6xIKn5/eLvJhh6zi9OfTf/IaxS9aP2daPlpFXO/HGPX//X5nOyWjA8Lnl3d
        U+pgGOvP+GmfwF3ryjWbHbe9ERK0jJV60uBc8KgzkeNQ6f3H9w2f+Isf+K/3qNNb2X9r5CR5
        j08ymkJ1qgmWZn8K3pYvrgu91XpgqWu+7McOg/tMd752bbm555FarepN3vhbX/3527PZbzwJ
        85p/QKNTWfv1gzJl69b9F3z/Td/+dhHT8p17fm+S2GryNvnkZG2LK2/yWf+/4z4Qtu5if0mK
        8NRbH7zmBW9Vutw3+fyee9OTORpWKbEUZyQaajEXFScCALzEhb2HAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWS2cA0UdflPVeiwdtv/Bar7/azWey9pe3A
        5HH5bKnH501yAUxRXDYpqTmZZalF+nYJXBnLf21nKrjCUfH3sEgD4xz2LkYODgkBE4nNy127
        GLk4hARWM0r8n/CaHcL5wChxbM8q1i5GTiBnP6PEkhNiIA1sApoSb/cXgIRFBNIkTlxZwQ5i
        MwuoSxzbuIENxBYW8JN4uuE+M0i5iECoxPWHGRDlehKLzi8Cm8gioCLxZsNPRhCbV8Ba4t/0
        f2BjGAXEJL6fWsMEMVJc4taT+WC2hICAxJI955khbFGJl4//sULYihL3v7+EOkFP4sbUKWwQ
        trbEsoWvmSHmC0qcnPmEBaJeUuLgihssExhFZyFZMQtJ+ywk7bOQtC9gZFnFKF5aXJybXlFs
        mJdarlecmFtcmpeul5yfu4kRGB+n/x2O3MF49NZHvUOMTByMhxglOJiVRHiTF3MlCvGmJFZW
        pRblxxeV5qQWH2KU5mBREucVcp0YLySQnliSmp2aWpBaBJNl4uCUamCKsmD02xbqd08iQv2+
        0da4Vslvs/qdXthucuibxcO3IEFO68GqmU84GvK/eN/95zX12mclP4UI1eX2jsxLFKQPiegc
        bomU//tC+pFsWdy7wO0r2bq7FhrffLF7VU/rP/79C0OfrEp2EGWzl4sS4Qn0EHJa+l/voJ9U
        luD25JmT1h59pdhx+MBxzsuv0oXUHVpSeKaKSfny2BicnH/3X87O3qpz/2Y/vK78fbEqn9Tc
        wqln9ex6N9yaJCD3Z+m/qlczzwgypIUqODPzbv45+eqcB887101o/hYxU840u155QdVjs3tc
        F5/qcpbe+rDg7gnrFa/ydzDLn3cK3Tu/YiU73/l5agHs99o1Fztytj9VYinOSDTUYi4qTgQA
        HY3n1f4CAAA=
X-CMS-MailID: 20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1
CMS-TYPE: 301P
X-CMS-RootMailID: 20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1
References: <CGME20210804194924uscas1p2922dc9e7bb44fbfa10abe8157fdd43e1@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kyber ioscheduler calls trace_block_rq_insert() *after* the request
is added to the queue but the documentation for trace_block_rq_insert()
says that the call should be made *before* the request is added to the
queue.  Move the tracepoint for the kyber ioscheduler so that it is
consistent with the documentation.

Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 block/kyber-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 81e3279ec..15a8be572 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -596,13 +596,13 @@ static void kyber_insert_requests(struct blk_mq_hw_ct=
x *hctx,
 		struct list_head *head =3D &kcq->rq_list[sched_domain];
=20
 		spin_lock(&kcq->lock);
+		trace_block_rq_insert(rq);
 		if (at_head)
 			list_move(&rq->queuelist, head);
 		else
 			list_move_tail(&rq->queuelist, head);
 		sbitmap_set_bit(&khd->kcq_map[sched_domain],
 				rq->mq_ctx->index_hw[hctx->type]);
-		trace_block_rq_insert(rq);
 		spin_unlock(&kcq->lock);
 	}
 }
--=20
2.25.1
