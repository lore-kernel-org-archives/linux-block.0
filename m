Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A2EC433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 03:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A06196F
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 03:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWDqT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 23:46:19 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36808 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCWDqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 23:46:06 -0400
Received: by mail-pg1-f181.google.com with SMTP id h25so10360268pgm.3
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 20:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQohhoHNI0iXfeHD5Zwk4VUO1Vj7NH97ijqHBjTVA5I=;
        b=J/nc2PAle6Y3xLbbOwrM9axnkzL0GOpU8qEpBqNiT1a31yuWEGAIPcIfAjf50WUA2D
         fTQ1XEZaFjUjnXfJFluxJ4J6vD1fSBaar7YN5nbDe7gRGfgkOpGJmlbEcK7tcE/0RQ0s
         OvYBsMm+4V22jhH/yEZQyS6IJiTnrfe+gN6SN2fKyLWvVjlY1D6o0bSJR7o4mHmlUS+V
         rGk+oOn+hZZ3XWrdHkumVnlBWUH1SWndEVzWAG6LPKFX07TpTknZlqX2p2xqpFzX5/9I
         1NNhKv4DLc1GXt8NSNtoAoyL0pcSoVO94MFdNqWjezI/4HBparyQzttTUylhrjoAvKb7
         GekA==
X-Gm-Message-State: AOAM531ZFDcfrc8pMRYVo2t3ugaLg5qp1RDfHN4kkmBw/K38qHKeW409
        RfpnQMIHFnvlAp/4wXOwlgQ=
X-Google-Smtp-Source: ABdhPJwmedZp89STq0PIkMKEWtugmsX2OXYRIcgiHPi7IsZMyYW1NGFCN0q6xZd9TAwj/7P95k7GeA==
X-Received: by 2002:a17:902:9a0a:b029:e6:bf00:8a36 with SMTP id v10-20020a1709029a0ab02900e6bf008a36mr3028144plp.51.1616471165897;
        Mon, 22 Mar 2021 20:46:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0? ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
        by smtp.gmail.com with ESMTPSA id y15sm16062282pgi.31.2021.03.22.20.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 20:46:05 -0700 (PDT)
Subject: Re: [RFC PATCH V2 09/13] block: use per-task poll context to
 implement bio based io poll
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210318164827.1481133-1-ming.lei@redhat.com>
 <20210318164827.1481133-10-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <522a2c87-e9f3-e62a-e09b-084821c698a0@grimberg.me>
Date:   Mon, 22 Mar 2021 20:46:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318164827.1481133-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> +{
> +	bio->bi_iter.bi_private_data = cookie;
> +}
> +

Hey Ming, thinking about nvme-mpath, I'm thinking that this should be
an exported function for failover. nvme-mpath updates bio.bi_dev
when re-submitting I/Os to an alternate path, so I'm thinking
that if this function is exported then nvme-mpath could do as little
as the below to allow polling?

--
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 92adebfaf86f..e562e296153b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -345,6 +345,7 @@ static void nvme_requeue_work(struct work_struct *work)
         struct nvme_ns_head *head =
                 container_of(work, struct nvme_ns_head, requeue_work);
         struct bio *bio, *next;
+       blk_qc_t cookie;

         spin_lock_irq(&head->requeue_lock);
         next = bio_list_get(&head->requeue_list);
@@ -359,7 +360,8 @@ static void nvme_requeue_work(struct work_struct *work)
                  * path.
                  */
                 bio_set_dev(bio, head->disk->part0);
-               submit_bio_noacct(bio);
+               cookie = submit_bio_noacct(bio);
+               blk_bio_poll_post_submit(bio, cookie);
         }
  }
--

I/O failover will create misalignment from the polling context cpu and
the submission cpu (running requeue_work), but I don't see if there is
something that would break here...

Thoughts?
