Return-Path: <SRS0=bw4W=SC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C2C43381
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 15:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51220872
	for <linux-block@archiver.kernel.org>; Sun, 31 Mar 2019 15:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfCaP3s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 11:29:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36817 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbfCaP3s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 11:29:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so3471769pgc.3;
        Sun, 31 Mar 2019 08:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6H6ZUj+H0tveWUWI3TM+oGlKBv/MK/R+ASBGLg0OQi0=;
        b=M96oDXBefk8xLKixownSJPuVeYhOCPON/oe6EyAq/u/81D2tf6K+l2jzSsPvZcytc4
         bYm4jaPxIrRtIm5LNIxzA0D6m4Q1vUfTLFiTW1pHYRN9Jf6d/arE1CVaDaXAzGWmdZTi
         GH8fDHCG4NCLdEALagz+O6yVbwlLfK/6EN8u438Z5tbcX5z3f5W8PZfrfvz8XTBgEoID
         WPSR1LZisZkHAxd5SMlxbif6n+Ph1S2uLtVYHB2wRd7ec4aLXiTqKyywecpuHyXc3FrM
         20/DZh3j8AA7wKlOGttuLRKT6ZLTddEGDVgFXrsXV80TnrlwFJxKv/lfSsnv5fBwM7Wq
         Gahg==
X-Gm-Message-State: APjAAAU5Y38HNy4V7UzECMMPmn8R9Ak70sRfaqVaoQBlijepPJ2pwvYz
        s5KFwGKijnK1kpEvDZfl2fo=
X-Google-Smtp-Source: APXvYqyYT9AUmJC6GPEhknwazlOFQ2+njLako3ZDDw5LLPPh1dMRF+VnIsKfDso7d3M3ls6KVpZcoA==
X-Received: by 2002:a63:fd07:: with SMTP id d7mr55722851pgh.199.1554046187377;
        Sun, 31 Mar 2019 08:29:47 -0700 (PDT)
Received: from asus.site (c-67-188-93-131.hsd1.ca.comcast.net. [67.188.93.131])
        by smtp.gmail.com with ESMTPSA id f6sm2352659pgq.11.2019.03.31.08.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 08:29:46 -0700 (PDT)
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
Date:   Sun, 31 Mar 2019 08:27:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190331030954.22320-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/19 8:09 PM, Ming Lei wrote:
> Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
> allowed during cleanup queue even though queue refcount is held.
> 
> This change has caused lots of kernel oops triggered in run queue path,
> turns out it isn't easy to fix them all.
> 
> So move freeing of hw queue resources into queue's release handler, then
> the above issue is fixed. Meantime, this way is safe given freeing hw
> queue resource doesn't require to use tags.

I'm not sure the approach of this patch series is really the direction 
we should pursue. There are many block driver that free resources 
immediately after blk_cleanup_queue() returns. An example from the brd 
driver:

static void brd_free(struct brd_device *brd)
{
	put_disk(brd->brd_disk);
	blk_cleanup_queue(brd->brd_queue);
	brd_free_pages(brd);
	kfree(brd);
}

I'd like to avoid having to modify all block drivers that free resources 
immediately after blk_cleanup_queue() has returned. Have you considered 
to modify blk_mq_run_hw_queues() such that it becomes safe to call that 
function while blk_cleanup_queue() is in progress, e.g. by inserting a 
percpu_ref_tryget_live(&q->q_usage_counter) / 
percpu_ref_put(&q->q_usage_counter) pair?

Thanks,

Bart.
