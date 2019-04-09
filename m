Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85276C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F28220830
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 09:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeX1TV8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDIJz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36135 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJz2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 05:55:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so20035774wrd.3
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=tyoWhWdZUBvYV7DswLvreVmZqypuNDo7Toc9d1hFYCc=;
        b=QeX1TV8YXrcId+jstLvo23LhQCkfafCo4lHsptLWvu+QFgZdDoynzjfgcahO09Ch96
         UzTohAnpR76JtLfnsFkUV+/HNcoapVdLKakcjfjG9Tvihp18leWRCvCZR09Kb3Zia58n
         njDy6h6aXl13o9r3g0opRohKj99kfWXhPVYo/kTZQu9Qmn/Y6x5N7ASYD0G9EQV3RDyt
         /4sxP3R6xYPDBy/bbeijvXJsrpmXwywko3liOp/UFiGdvHLMv89f87KKIrFdyNkJfWaR
         cLUXqKcAi1r5z+ahDJmhOEKuKknpAY6iXT4Y2t1j3bmGGeLhuqQJs8/zEzhuFvBdKdYr
         0Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=tyoWhWdZUBvYV7DswLvreVmZqypuNDo7Toc9d1hFYCc=;
        b=aYFdIDm4kcyxGS+NZgioW8jOqH32zjV0seP3fNzTYMM6LDQzoDAEY76XIDvFHpFIfF
         EHNJAidk9hMkgJJm28+59bbVUB4tpxNvq/rzaaWBc8qa2aMvD385JSCC0RJw/2cTrh9F
         PckRY9VqtHFJNsxweFVzFP1JEWhUdGDZT8mtdJA6K/lBa06d3ltbr8I2QGSB7H3BMQf5
         KLT1Rx7fN9bF8qzze9SmplokZEhZi9Q2IeqbucTUuQTtrmw5DNkhUVze8UNkZWutHiK+
         NVQfNY528lbfT1sB1rHrkICk5C9l4RTICpV7UYdTW75EcZWPThwxC/9JETiP4l4vbAt7
         urFA==
X-Gm-Message-State: APjAAAXSlOBOoOK3cQuuFzU4UWBxMgjOmYHzGFg6I6idwOpNolU3NeHH
        xWEt3OeipPQ6Ws9bzZNttn2Uew==
X-Google-Smtp-Source: APXvYqw3AgNqv3F08lPSkPDMEc2x7FCLih3Vwd/G+xaqADdEu80pc0CWfVkIxPh0DeH4jNo4IP0gCA==
X-Received: by 2002:adf:df08:: with SMTP id y8mr22037921wrl.91.1554803725690;
        Tue, 09 Apr 2019 02:55:25 -0700 (PDT)
Received: from wifi-122_dhcprange-140.wifi.unimo.it (wifi-122_dhcprange-140.wifi.unimo.it. [155.185.122.140])
        by smtp.gmail.com with ESMTPSA id l23sm12080072wmj.10.2019.04.09.02.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 02:55:24 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <A90B593D-4831-4DFF-89CE-0E59045E9093@linaro.org>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_EF4F07C2-BFC4-4863-AB1C-67E109FA0E8E"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
Date:   Tue, 9 Apr 2019 11:55:21 +0200
In-Reply-To: <20190404222257.0cfb1130@fire.localdomain>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>
References: <20190329160227.7d55c8dd@fire.localdomain>
 <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
 <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
 <20190401115509.76310e03@fire.localdomain>
 <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
 <20190401122233.3e861312@fire.localdomain>
 <EBC090F1-72C0-4794-91CC-37F9A2A1DEFB@linaro.org>
 <20190404222257.0cfb1130@fire.localdomain>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_EF4F07C2-BFC4-4863-AB1C-67E109FA0E8E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 4 apr 2019, alle ore 21:22, Dmitrii Tcvetkov =
<demfloro@demfloro.ru> ha scritto:
>=20
> On Mon, 1 Apr 2019 12:35:11 +0200
> Paolo Valente <paolo.valente@linaro.org> wrote:
>=20
>>=20
>>=20
>>> Il giorno 1 apr 2019, alle ore 11:22, Dmitrii Tcvetkov
>>> <demfloro@demfloro.ru> ha scritto:
>>>=20
>>> On Mon, 1 Apr 2019 11:01:27 +0200
>>> Paolo Valente <paolo.valente@linaro.org> wrote:
>>>> Ok, thank you. Could you please do a
>>>>=20
>>>> list *(bfq_bfqq_expire+0x1f3)
>>>>=20
>>>> for me?
>>>>=20
>>>> Thanks,
>>>> Paolo
>>>>=20
>>>>>=20
>>>>> <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>
>>>=20
>>> Reading symbols from vmlinux...done.
>>> (gdb) list *(bfq_bfqq_expire+0x1f3)
>>> 0xffffffff813d02c3 is in bfq_bfqq_expire (block/bfq-iosched.c:3390).
>>> 3385             * even in case bfqq and thus parent entities go on
>>> receiving 3386             * service with the same budget.
>>> 3387             */
>>> 3388            entity =3D entity->parent;
>>> 3389            for_each_entity(entity)
>>> 3390                    entity->service =3D 0;
>>> 3391    }
>>> 3392
>>> 3393    /*
>>> 3394     * Budget timeout is not implemented through a dedicated
>>> timer, but
>>=20
>> Thank you very much.  Unfortunately this doesn't ring any bell.  I'm
>> trying to reproduce the failure.  It will probably take a little
>> time.  If I don't make it, I'll ask you to kindly retry after =
applying
>> some instrumentation patch.
>>=20
>=20
> I looked at what git is doing just before panic and it's doing a lot =
of
> lstat() syscalls on working tree.
>=20
> I've attached a python script which reproduces the crash in about
> 10 seconds after it prepares testdir, git checkout origin/linux-5.0.y
> reproduces it in about 2 seconds. I have to use multiprocessing Pool =
as
> I couldn't reproduce the crash using ThreadPool, probably due to =
Python
> GIL.
>=20

Unfortunately this failure doesn't reproduce on my systems.  But I
have a suspect.  Could you please test this patch? (also attached as a
compressed file):

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index fac188dd78fa..0a435bcfed20 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2822,7 +2822,7 @@ static void bfq_dispatch_remove(struct =
request_queue *q, struct request *rq)
 	bfq_remove_request(q, rq);
 }
=20
-static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
+static bool __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
 {
 	/*
 	 * If this bfqq is shared between multiple processes, check
@@ -2857,7 +2857,7 @@ static void __bfq_bfqq_expire(struct bfq_data =
*bfqd, struct bfq_queue *bfqq)
 	 * or requeued before executing the next function, which
 	 * resets all in-service entites as no more in service.
 	 */
-	__bfq_bfqd_reset_in_service(bfqd);
+	return __bfq_bfqd_reset_in_service(bfqd);
 }
=20
 /**
@@ -3262,7 +3262,6 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	bool slow;
 	unsigned long delta =3D 0;
 	struct bfq_entity *entity =3D &bfqq->entity;
-	int ref;
=20
 	/*
 	 * Check whether the process is slow (see bfq_bfqq_is_slow).
@@ -3347,10 +3346,8 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * reason.
 	 */
 	__bfq_bfqq_recalc_budget(bfqd, bfqq, reason);
-	ref =3D bfqq->ref;
-	__bfq_bfqq_expire(bfqd, bfqq);
-
-	if (ref =3D=3D 1) /* bfqq is gone, no more actions on it */
+	if (__bfq_bfqq_expire(bfqd, bfqq))
+		/* bfqq is gone, no more actions on it */
 		return;
=20
 	bfqq->injected_service =3D 0;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 062e1c4787f4..86394e503ca9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -995,7 +995,7 @@ bool __bfq_deactivate_entity(struct bfq_entity =
*entity,
 			     bool ins_into_idle_tree);
 bool next_queue_may_preempt(struct bfq_data *bfqd);
 struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			 bool ins_into_idle_tree, bool expiration);
 void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index a11bef75483d..a0c60c47ed1c 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1605,7 +1605,7 @@ struct bfq_queue *bfq_get_next_queue(struct =
bfq_data *bfqd)
 	return bfqq;
 }
=20
-void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 {
 	struct bfq_queue *in_serv_bfqq =3D bfqd->in_service_queue;
 	struct bfq_entity *in_serv_entity =3D &in_serv_bfqq->entity;
@@ -1629,8 +1629,18 @@ void __bfq_bfqd_reset_in_service(struct bfq_data =
*bfqd)
 	 * service tree either, then release the service reference to
 	 * the queue it represents (taken with bfq_get_entity).
 	 */
-	if (!in_serv_entity->on_st)
+	if (!in_serv_entity->on_st) {
+		/*
+		 * bfqq may be freed here, if bfq_exit_bfqq(bfqq) has
+		 * already been executed
+		 */
+		int ref =3D in_serv_bfqq->ref;
 		bfq_put_queue(in_serv_bfqq);
+		if (ref =3D=3D 1)
+			return true;
+	}
+
+	return false;
 }
=20
 void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,


--Apple-Mail=_EF4F07C2-BFC4-4863-AB1C-67E109FA0E8E
Content-Disposition: attachment;
	filename*0=0001-block-bfq-tentative-fix-of-use-after-free-in-bfq_bfq.patch.;
	filename*1=gz
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-block-bfq-tentative-fix-of-use-after-free-in-bfq_bfq.patch.gz"
Content-Transfer-Encoding: base64

H4sICJdPrFwAAzAwMDEtYmxvY2stYmZxLXRlbnRhdGl2ZS1maXgtb2YtdXNlLWFmdGVyLWZyZWUt
aW4tYmZxX2JmcS5wYXRjaACtV21v2zYQ/mz9ituXwW9SJFl+7Vq06FBsHwYUaLEvwyDQ4snmqoi2
RCUptv733ZFSbCf22qQTEtPi8Y738vA5+l2lr2EayiRbTJJYxpGQ05lczxbzaIGJmE1FkkRyPlkm
8ySC33QJH3AH0RzCcGX/IA7DyHtHZlbwXuhCw++iwNIg/LTj1+DGvb4uVCkqHehq88r7WRhcwccG
x7CEN7uKjERLCJerabyaRjAKyaj3oVn/hZlZwR/v33x8+8ufsC509mkM63y/AkM2hVE3CLm6A51D
UyOI3GAFeYUIqvR4YUr/+xTvdqpCz/ugNiVKX+e5v/78BHd93/fc7ldkz1e6zrYogwz+gYi8pcd3
z7lVW1oFMYxOhLd5vCd9eshEYk10D1uZUFQF1pBtRblBOeaEq7LGyihd1v3RgGZCkFigm/AHnidV
noPvb5QBcXXO2fW5WU+VEu8gF1m0WEg5X+QiCEKRTKbrLEcZh7RROEsSzsF5ux75fMH269fgx4s4
Hs9h1I40VXPhMrjRStoSSVXvhMm2aYXX+gb7tamazECF+wZrk9JngzDcj+FUAMNqP/CgxyacZtpK
+rSWZC88+OKB5x/vl6YPQNHtZh0RRsCQvsn7vXi6dYCVBt6otbbWuvh+a/A3BXA1pA8Ywq85mK2q
edUeaKy3okJKEZpbxBKum8KoXYGwq3SGdY31mPCB2ac2zdO5S7MdH6T5+x1lB3Xlct9Yr3JdIeAd
Zo1R5YZcRyjxzkDelBmjcgy3W5VtnWqFNZoaRFEQjn0C8o3KSLs0yhDMRQ2lhms2qEpopYHVvPL8
3r33MrV2UlWm7aI+z1KlR70KTVOV8A1rLSrgaji0iZvEM4tPO844cffA/Hq+GH4MhLrQt2S415S1
pRgoNKWEzietfAkhi44M2LA/w7AdX8KPvJP/yr2/oIhVyTDPX7Cj9/h4y8WmpCKlurL5bpFgwUIe
QL8m5rv3XNUpzw4CF+ckmY+JNEb0ZTZePD1QW0VR67IrDPSOYFVhJoosXTdyg6bvwMSCcas04LAo
JIrWBWvD83uPkXnQZR1ORg59q/kSogHV7f6AbHRJDaRDjrCoq4FaFFEg+Teymv+5AZ3nXu/bLUKv
hZkrjAtEldylUHYwcwX/ChtvzzLmtmXjcBZjlCXzxTxPgmAxo+6L03CSieXX2Hh7kY23FgXL5ZTB
7gaaOKIxiRzvDXXmFqD9i5BlOPR63L2cAWpNdM6MTpUsMDXUf/mYWRFTgqOS9Fp8Tncku96Z8yhj
pbMElBKm0oOli9r+KdmdoYBLmqNTPn+C5lEfOySQkfE0im1TeiGdYyewABYMypONv2PbwUWktjeU
9aOpFqMiiqgHzKfJYiKDQITZLCTEooyySxht1R8CtJ1mdEaz0MKzHW0TezYcKKFtT+BAu8vAMxHy
bIC4Fv84jFbRlsxxomQq6ay5ZRf6Rqd76B/H1g59xKU0XhLbj+wYHWj/OZFwC+hIjlEJqLgVjbkX
lcTzBTE92sbUrSLaxgpLXq+dPktdChS3uB1vXtLNoG/EJzJySxahK7GLY3C4CDCf/3Aavf9K07sZ
tGx/QUpFsETPn9DSPdER3WLsrwUJFAYdMrJg83ynjDtL9ojAVtStoiiom0nWI1/d3Qelk3G/6fo2
leS0Iq6X9+xdddd0uD1eY+8wp62OJzoIU0WQV3zxRoe7Ti6KGrv7zP9FQ3RovTiIwyDyvH8BEZoH
Ax0OAAA=
--Apple-Mail=_EF4F07C2-BFC4-4863-AB1C-67E109FA0E8E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




> <crash.py>


--Apple-Mail=_EF4F07C2-BFC4-4863-AB1C-67E109FA0E8E--
