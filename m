Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD517C47404
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EEA21835
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfJKRAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:00:44 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:44243 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKRAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Oct 2019 13:00:44 -0400
Received: by mail-pg1-f179.google.com with SMTP id e10so2135180pgd.11;
        Fri, 11 Oct 2019 10:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKGWBUoxMayF3T/j4ufkanWg28YnrdRQH1PezhJ8qHw=;
        b=M4/RsPfmEy7qjawshMo2QYhzuBUHg/p7I+k81pq6WhxxPXFsPj8YGZat22X+o1OX5D
         AgePYsdSIM16j27C/X5IEQAgQ457nYqnK8CSXn8Ydj+p1Rg8wJbinEHgtVF2DxmYrqYS
         moYOjiwVM/99HS7MJhfUudJ48YUkZLle+O7mk48vxtHuSxkyRjgNCaJ+r8xYIoIi1r7k
         M17YKO7Ln0kkJ+QLigixmJDzT58w+8JQntBUiaQMWjQYf8G+qFi85IHsEAKhIRWIrC51
         kLwLjii++ixcXIHrvs+S8RuyyzYiL1XuXYBHxbRi9sPFUakMdwFRxUrJr0cBva5daIOD
         65pQ==
X-Gm-Message-State: APjAAAWjvCgf4Wsuo3LN7ZSJUjQSeTgg+WoMzVMgute9ftABOMEIs4kd
        Rjt2lVvOe9+APaRJ7k1DPEXHP25w
X-Google-Smtp-Source: APXvYqwFac5zhGscS4LGq/zNcTYHsmwYguLxLfTV758NqKQPjgyn5vnlMT2VObNhextpjTbXZ6lFlw==
X-Received: by 2002:aa7:98c9:: with SMTP id e9mr17932097pfm.142.1570813243804;
        Fri, 11 Oct 2019 10:00:43 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x72sm13692986pfc.89.2019.10.11.10.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:00:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, kernel@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
 <854l0j19go.fsf@collabora.com> <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org>
 <85zhibyt14.fsf@collabora.com> <86de2c88-5812-4a87-b5d8-1b7b1808d013@acm.org>
 <8e20f2c6-c165-5b5f-7497-9472913d0ba8@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <66011772-9f04-dfc3-611e-7dc820d9263f@acm.org>
Date:   Fri, 11 Oct 2019 10:00:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8e20f2c6-c165-5b5f-7497-9472913d0ba8@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/19 1:38 PM, André Almeida wrote:
> Seems that it's not clear for me the role of these members. Could you
> please check if those definitions make sense for you?
> 
> - hctx->dispatch: This queue is used for requests that are ready to be
> dispatched to the hardware but for some reason (e.g. lack of resources,
> the hardware is to busy and can't get more requests) could not be sent
> to the hardware. As soon as the driver can send new requests, those
> queued at this list will be sent first for a more fair dispatch. Since
> those requests are at the hctx, they can't be requeued or rescheduled
> anymore.
> 
> - request_queue->requeue_list: This list is used when it's not possible
> to send the request to the associated hctx. This can happen if the
> associated CPU or hctx is not available anymore. When requeueing those
> requests, it will be possible to send them to new and function queues.

Hi André,

The hctx->dispatch description looks mostly fine. Can the following part 
be left out since it looks confusing to me: "Since those requests are at 
the hctx, they can't be requeued or rescheduled anymore."

How about changing the requeue_list description into the following: 
"requests requeued by a call to blk_mq_requeue_request()".

Thanks,

Bart.


