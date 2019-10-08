Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E227C4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 20:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7AB21835
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfJHUBm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:01:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40822 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfJHUBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 16:01:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so8365pfb.7;
        Tue, 08 Oct 2019 13:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPXZ9kF4GFL6v89vFU2ZEHo7SfcEsi52mwigB/rCYtY=;
        b=BhI4JlPi1lB8pPxSfgsAth6LhYsw8p7P5yuNRi37rMX+qWOcNBYGl8KeFR3V2TVz2N
         2v9VFIVAmv9P+eo+as+cjYCs6EaDPx18OLjpSj2hX71zbYQSHGiajGeg+r6r4PuLll4O
         PUIPHRX1TU8Z76NcOSdnSXabZEZEhaWkEtrhX+d/U/i1Ry00h0H3gNcw8lGIxPrVm8Jf
         gaEW2cactPIijXISDHBBQ8NaZiDHTRN30Ek7JbF4/eDF2X4THDaGVy5tu8CzMkH0oUhS
         VRuTiUf/Ro/SEfFCgLA8uwHPJ8hXiQdbZkUqkMTegV614E8O6cfJpT78y0KlIdVAgXTT
         duHA==
X-Gm-Message-State: APjAAAXjV0nitAyGxrzdxV64EQmrvwruEZSQwl/qfFnU29L1pyek/dTv
        LH3pVYnipl0Y3M1mLAkMhN8=
X-Google-Smtp-Source: APXvYqzsPBEPcjwVojznWXBeDxWR7tzrTuazlMQklON6Ok06EdIXuptFWD3mT4f/ths+IK6uvLL+tQ==
X-Received: by 2002:aa7:96f3:: with SMTP id i19mr41662272pfq.32.1570564901292;
        Tue, 08 Oct 2019 13:01:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id z29sm17759300pff.23.2019.10.08.13.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 13:01:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, kernel@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
 <854l0j19go.fsf@collabora.com> <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org>
 <85zhibyt14.fsf@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <86de2c88-5812-4a87-b5d8-1b7b1808d013@acm.org>
Date:   Tue, 8 Oct 2019 13:01:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <85zhibyt14.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 11:46 AM, Gabriel Krisman Bertazi wrote:
> Hmm, sorry, but I'm confused.  I'm sure I'm missing something simple,
> since I haven't touched this in a while, so maybe you can quickly point
> me in the right direction?
> 
> I see blk_mq_requeue_request() being used by device drivers to retry
> requests that failed, but if I read the code correctly, the flushed
> queue seems to be moved to hctx->dispatch when the device
> driver returned BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE to
> blk_mq_dispatch_rq_list(). I thought BLK_STS_RESOURCE was returned by
> the driver on .queue_rq() to signal there was no more resources on the
> hardware to service further requests.

Hi Gabriel,

The simplified version of how requests are requeued as follows:
* A block driver calls blk_mq_requeue_request().
* blk_mq_requeue_request() calls blk_mq_add_to_requeue_list()
* blk_mq_add_to_requeue_list() executes the following code:
     list_add_tail(&rq->queuelist, &q->requeue_list)
* A block driver or the block layer core calls
   blk_mq_kick_requeue_list() or blk_mq_delay_kick_requeue_list(). Both
   functions trigger a call of blk_mq_requeue_work().
* blk_mq_requeue_work() processes q->requeue_list.

Bart.


