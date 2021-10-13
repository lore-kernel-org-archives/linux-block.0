Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1645C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A24610CE
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhJMPo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhJMPo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:44:28 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B9C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:42:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id j8so132516ila.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kglxkgu3Zijkub6nOdn+9EtAwKMAB9h9DcN8AlXtqsE=;
        b=4SYNaTp7E1ezeJVxESALrEtaZiGYYNA8zRpiYy1+UpazVo968Ji6WhecZMFSEX0fW+
         oyewCI13MGR76lpHZKWIqzqSIGOUeo5IyoFJDliKIecqKvUdn4E2sMCHT8kTu0HGgveU
         SkERidvSXFIzTkoSZXoBWrBHEcN3VkKxasXZzccPFc7plYRHXjhn3WWPle+KSllBeMIz
         fyHFpoCWe/xTJ457JXToJhPS5PU7Fd7h/XpqkUAHDwqRh1dL9yZJG1h/gSprXIix308e
         S6z5anQLucHu64qfvbmKXIkGCf8Caozyb9mCkZ8f1TxoT0BcKtkXEgJnwkKTkl1yTptJ
         HYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kglxkgu3Zijkub6nOdn+9EtAwKMAB9h9DcN8AlXtqsE=;
        b=5vO/HII43APuOkK93MaGydOSRaCQ+TO0zO5Qb1kWLzrNqNe9riJGgV87+RsN+g0DSy
         q9Xz7AmgS11u4imzVE9e4l4H+gt4cQdBoQn1CDdXWfd70NptpR9jTkzzl0q0xQ9PaHwv
         C+0VcAqmu6GCaIuojSQ1ti0dny4jrgGAE1arclgq+sP3doWzcuQBFH8kRaekvVRHc8zZ
         a7SxQ5DjXz9kq7PH5cGo6Z+7y02ET+GdVVhYbryy3BPDPOmTeAk115gBlmhxoYYn5yXw
         2dNYWKhnLbJOb9S+GG25+vf2n7w5cJLdIm0hfyEo+R+jMv7AsKUaRw2KZaUffQrwK0uz
         U6oQ==
X-Gm-Message-State: AOAM533zSZKancjC5RXNTKsAavqWlbF588g48FiSEAn/TlZeNIhT6i2E
        kxmWXBipnjfjrYEE8b6s3jWaV10b8ak=
X-Google-Smtp-Source: ABdhPJzJt/VZPlZRYy3QSuYra+6qmKp7dOcP/BfRxbfu3ci+l+rr9Pf8fMAL2yauCEKVMVw3ucTSNA==
X-Received: by 2002:a05:6e02:1014:: with SMTP id n20mr198011ilj.222.1634139743987;
        Wed, 13 Oct 2021 08:42:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u20sm7134042ilb.2.2021.10.13.08.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:42:23 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
 <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
 <YWb4SqWFQinePqzj@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3b138c8-49bd-2dba-b7a0-878d5c857167@kernel.dk>
Date:   Wed, 13 Oct 2021 09:42:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWb4SqWFQinePqzj@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 9:16 AM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 09:10:01AM -0600, Jens Axboe wrote:
>>> Also - can you look into turning this logic into an inline function with
>>> a callback for the driver?  I think in general gcc will avoid the
>>> indirect call for function pointers passed directly.  That way we can
>>> keep a nice code structure but also avoid the indirections.
>>>
>>> Same for nvme_pci_complete_batch.
>>
>> Not sure I follow. It's hard to do a generic callback for this, as the
>> batch can live outside the block layer through the plug. That's why
>> it's passed the way it is in terms of completion hooks.
> 
> Basically turn nvme_pci_complete_batch into a core nvme helper (inline)
> with nvme_pci_unmap_rq passed as a function pointer that gets inlined.

Something like this?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0ac7bad405ef..1aff0ca37063 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,15 +346,19 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	return RETRY;
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void nvme_end_req_zoned(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
 			le64_to_cpu(nvme_req(req)->result.u64));
+}
+
+static inline void nvme_end_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
+	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	blk_mq_end_request(req, status);
 }
@@ -381,6 +385,23 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
+void nvme_complete_batch(struct io_batch *iob, void (*fn)(struct request *rq))
+{
+	struct request *req;
+
+	req = rq_list_peek(&iob->req_list);
+	while (req) {
+		fn(req);
+		nvme_cleanup_cmd(req);
+		nvme_end_req_zoned(req);
+		req->status = BLK_STS_OK;
+		req = rq_list_next(req);
+	}
+
+	blk_mq_end_request_batch(iob);
+}
+EXPORT_SYMBOL_GPL(nvme_complete_batch);
+
 /*
  * Called to unwind from ->queue_rq on a failed command submission so that the
  * multipathing code gets called to potentially failover to another path.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed79a6c7e804..b73a573472d9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -638,6 +638,7 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 }
 
 void nvme_complete_rq(struct request *req);
+void nvme_complete_batch(struct io_batch *iob, void (*fn)(struct request *));
 blk_status_t nvme_host_path_error(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b8dbee47fced..e79c0f0268b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -992,22 +992,7 @@ static void nvme_pci_complete_rq(struct request *req)
 
 static void nvme_pci_complete_batch(struct io_batch *iob)
 {
-	struct request *req;
-
-	req = rq_list_peek(&iob->req_list);
-	while (req) {
-		nvme_pci_unmap_rq(req);
-		if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
-			nvme_cleanup_cmd(req);
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-				req_op(req) == REQ_OP_ZONE_APPEND)
-			req->__sector = nvme_lba_to_sect(req->q->queuedata,
-					le64_to_cpu(nvme_req(req)->result.u64));
-		req->status = BLK_STS_OK;
-		req = rq_list_next(req);
-	}
-
-	blk_mq_end_request_batch(iob);
+	nvme_complete_batch(iob, nvme_pci_unmap_rq);
 }
 
 /* We read the CQE phase first to check if the rest of the entry is valid */

-- 
Jens Axboe

