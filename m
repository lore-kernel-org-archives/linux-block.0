Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A5DC4320A
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CB613AC
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhHWMne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbhHWMnc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 08:43:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F9C061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 05:42:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so323264pjb.1
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6gT2Pa3MSS7M8ZYtAhXndotmjTHBjRnhqqV82YeQiaQ=;
        b=UgcnGpjl7F4yEL0giemTWHUoLohrWkYxUJ0XkQDStzRaLgIP24OLidPgusGyNCb0gp
         cb6Q6odaXx/j/DjLGJwWhfBBHvlU36/2Gd3qcoXNpHdbSbo0H//UmSy0lBeNBeKBhlVC
         hNCP50Hn+hCIAwW3QB6mU7t6cV6FIBTORawo6G0W39Djkj/9OY26BHLZzJVYdCVq/TVk
         bcpzBQaxT0abEvzgSLb5v4npBm9ETUDVEZrPgwtdIo6+949ktwvYEBuhajgsHeRjW3nl
         2Qm4jyUNCc3G4RvKjg86eVaiv2HkkHOs68CsMZhEsoGguyQElmXC4KIx2S5QOKvV84TY
         7WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6gT2Pa3MSS7M8ZYtAhXndotmjTHBjRnhqqV82YeQiaQ=;
        b=sZSHDVCPjOlnlwbKJNLnvvknKYtJAZ5uD7c4oyvrvev6ZNEY9SkKeHwD9HROFb9Vyp
         4W0k+UeEZWzGVbh/20Nb0j8/WDX3OLiPtmP5e/5GAWPbVeap0YAQLEncFx7XYf0M9qiC
         EYXeklAA+5NxwiTSs82M7f13K9jYNnHQdfuvinu+McKTxLh7ESW0rNPF5fDeye4Fgmn9
         WSAhGZytaAaotcQtUtvgPpHrwIg7PLprH7yI1KyNEREB0wy2Q5GowV48UYTb831YJZXk
         zro1dZZHf4zJ5l+Yk8xtDrLqmXXBdwJvynGUKX/r5uj3FMYFWobfMay5weLp2hYnGTP1
         n7yw==
X-Gm-Message-State: AOAM533125Uy24aRdLbyw3pfuKbiR7MjmFj8Rz7dsDD5L2FJoPomJQjG
        /SySEt3swpkYi+L73rZ9u+E=
X-Google-Smtp-Source: ABdhPJyuSKEyxtQxTti51/cAYFecjf0dua99c7rcWEwG8hAxXPpmMnznZPB2jajNEM3xo8I+1GRCPQ==
X-Received: by 2002:a17:902:7045:b0:130:da61:7778 with SMTP id h5-20020a170902704500b00130da617778mr14883979plt.21.1629722569865;
        Mon, 23 Aug 2021 05:42:49 -0700 (PDT)
Received: from B-D1K7ML85-0059.local ([47.246.98.150])
        by smtp.gmail.com with ESMTPSA id t42sm4080254pfg.30.2021.08.23.05.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 05:42:49 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix is_flush_rq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
References: <20210818010925.607383-1-ming.lei@redhat.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <ae6c32cc-0bd1-601a-559e-8d6e2578f0ec@gmail.com>
Date:   Mon, 23 Aug 2021 20:42:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818010925.607383-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 8/18/21 9:09 AM, Ming Lei wrote:
> is_flush_rq() is called from bt_iter()/bt_tags_iter(), and runs the
> following check:
> 
> 	hctx->fq->flush_rq == req
> 
> but the passed hctx from bt_iter()/bt_tags_iter() may be NULL because:
> 
> 1) memory re-order in blk_mq_rq_ctx_init():
> 
> 	rq->mq_hctx = data->hctx;
> 	...
> 	refcount_set(&rq->ref, 1);
> 
> OR
> 
> 2) tag re-use and ->rqs[] isn't updated with new request.
> 
> Fix the issue by re-writing is_flush_rq() as:
> 
> 	return rq->end_io == flush_end_io;
> 
> which turns out simpler to follow and immune to data race since we have
> ordered WRITE rq->end_io and refcount_set(&rq->ref, 1).
> 
Recently we've run into a similar crash due to NULL rq->mq_hctx in
blk_mq_put_rq_ref() on ARM, and it is a normal write request.
Since memory reorder truly exists, we may also risk other uninitialized
member accessing after this commit, at least we have to be more careful
in busy_iter_fn...
So here you don't use memory barrier before refcount_set() is for
performance consideration?

Thanks,
Joseph
