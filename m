Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3413BC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8072074B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3h2iJIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFEIeJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:34:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726062AbgFEIeJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 04:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591346047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vqqCNDLCGuVhI3JnJdw3+w+o7Q/xj9pV6Zqjob2bfZM=;
        b=g3h2iJIb4Ix02SK0CKZk2fd+EbnFLU+gy1nIW1y1TnrpSozYMQMfDPzvSYrLaLj1U4/S3Y
        xUEtM/vZpfE5F9qko1nJ4Yivq1unHUp/ayk8Wg8PdEaONv45UgSEzyiUG5K/Ud9zqUxYXx
        Q2QgLPZ40LFAxCdLENL9PWh5zMlQ9b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Szfg--8yM8mCIc5xGd1UyA-1; Fri, 05 Jun 2020 04:34:02 -0400
X-MC-Unique: Szfg--8yM8mCIc5xGd1UyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67571801503;
        Fri,  5 Jun 2020 08:34:00 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 966C26ACF6;
        Fri,  5 Jun 2020 08:33:53 +0000 (UTC)
Date:   Fri, 5 Jun 2020 16:33:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200605083349.GA2392879@T590>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de>
 <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 01:45:09PM +0100, John Garry wrote:
> 
> > > That's your patch - ok, I can try.
> > > 
> 
> I still get timeouts and sometimes the same driver tag message occurs:
> 
>  1014.232417] run queue from wrong CPU 0, hctx active
> [ 1014.237692] run queue from wrong CPU 0, hctx active
> [ 1014.243014] run queue from wrong CPU 0, hctx active
> [ 1014.248370] run queue from wrong CPU 0, hctx active
> [ 1014.253725] run queue from wrong CPU 0, hctx active
> [ 1014.259252] run queue from wrong CPU 0, hctx active
> [ 1014.264492] run queue from wrong CPU 0, hctx active
> [ 1014.269453] irq_shutdown irq146
> [ 1014.272752] CPU55: shutdown
> [ 1014.275552] psci: CPU55 killed (polled 0 ms)
> [ 1015.151530] CPU56: shutdownr=1621MiB/s,w=0KiB/s][r=415k,w=0 IOPS][eta
> 00m:00s]
> [ 1015.154322] psci: CPU56 killed (polled 0 ms)
> [ 1015.184345] CPU57: shutdown
> [ 1015.187143] psci: CPU57 killed (polled 0 ms)
> [ 1015.223388] CPU58: shutdown
> [ 1015.226174] psci: CPU58 killed (polled 0 ms)
> long sleep 8
> [ 1045.234781] scsi_times_out req=0xffff041fa13e6300[r=0,w=0 IOPS][eta
> 04m:30s]
> 
> [...]
> 
> > > 
> > > I thought that if all the sched tags are put, then we should have no driver
> > > tag for that same hctx, right? That seems to coincide with the timeout (30
> > > seconds later)
> > 
> > That is weird, if there is driver tag found, that means the request is
> > in-flight and can't be completed by HW.
> 
> In blk_mq_hctx_has_requests(), we iterate the sched tags (when
> hctx->sched_tags is set). So can some requests not have a sched tag (even
> for scheduler set for the queue)?
> 
>  I assume you have integrated
> > global host tags patch in your test,
> 
> No, but the LLDD does not use request->tag - it generates its own.
> 
>  and suggest you to double check
> > hisi_sas's queue mapping which has to be exactly same with blk-mq's
> > mapping.
> > 
> 
> scheduler=none is ok, so I am skeptical of a problem there.

Please try the following patch, and we may not drain in-flight
requests correctly:

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 97bb650f0ed6..ae110e2754bf 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -265,6 +265,7 @@ struct bt_tags_iter_data {
 
 #define BT_TAG_ITER_RESERVED		(1 << 0)
 #define BT_TAG_ITER_STARTED		(1 << 1)
+#define BT_TAG_ITER_STATIC_RQS		(1 << 2)
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
@@ -280,7 +281,10 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	 * We can hit rq == NULL here, because the tagging functions
 	 * test and set the bit before assining ->rqs[].
 	 */
-	rq = tags->rqs[bitnr];
+	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
+		rq = tags->static_rqs[bitnr];
+	else
+		rq = tags->rqs[bitnr];
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -335,11 +339,13 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * Caller has to pass the tag map from which requests are allocated.
  */
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	return __blk_mq_all_tag_iter(tags, fn, priv, 0);
+	return __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
 }
 
 /**


Thanks,
Ming

