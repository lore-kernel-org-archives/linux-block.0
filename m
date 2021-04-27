Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485DAC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2229C613B0
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 02:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhD0Cfh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:35:37 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41907 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0Cfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 22:35:36 -0400
Received: by mail-pl1-f178.google.com with SMTP id e2so25706589plh.8
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 19:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WmYk+H/ujg7IBab0b3U/NqtK6cgz88Naq6RDksRBwY=;
        b=i9LO34RaK5ramqjFepGkl3XtZGbJn98LcXMMacj6htPAlm7naY8z/TBDtj1vgtLnjO
         POOgAiS8co9ugSxldYPn3/83GpR736JDTIU4EapGg4g7o5BZA44jQ64kHrYHn0UGETB4
         sPhJ4ZfgWzv3xh6snEnIGIFk5KQq7jzsFoDxQrRTtzLYdFLOIrQEvDSwYtui26wElqVG
         +EoO3lYZ3/e3bmnj7a4Y+ZzE1I7+n+toPfAl5ujZf1d8/3dMEENrj2jIQaWZfwuIRKbM
         sgMaHzB5ZTDwIslrtFdFHhYuiEiHXutzQp8rXk7AjjNkuSVZBe1/jF1gf1SvoSwx6dKC
         4kOA==
X-Gm-Message-State: AOAM530+eR4znto1FX9Aw0MSQHPJ5qDlZiqOO7HMXPnTeEzLZoQQPIln
        B/PPY8sHTt7Dl9ng7ymAtYk=
X-Google-Smtp-Source: ABdhPJy0TpfLnfHkC5L/407U5EEVfT6TQB3+R7oDdExpmC9pQOLBI2+harei2LLNFkP0pktB8ncpmw==
X-Received: by 2002:a17:90b:511:: with SMTP id r17mr939815pjz.64.1619490894283;
        Mon, 26 Apr 2021 19:34:54 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id d26sm846042pfq.198.2021.04.26.19.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 19:34:52 -0700 (PDT)
Subject: Re: [PATCH V2 3/3] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210427014540.2747282-1-ming.lei@redhat.com>
 <20210427014540.2747282-4-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <f2ffc395-f696-6f4c-7050-22faa13dc8b7@acm.org>
Date:   Mon, 26 Apr 2021 19:34:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427014540.2747282-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 6:45 PM, Ming Lei wrote:
> refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> request.
> 
> Fix the issue by the following approach:
> 
> 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> refcount_inc_not_zero in bt_tags_iter()
> 
> 2) clearing stale request referred via ->rqs[tag] before freeing
> request pool, the per-tags spinlock is held for clearing stale
> ->rq[tag]
> 
> So after we cleared stale requests, bt_tags_iter() won't observe
> freed request any more, also the clearing will wait for pending
> request reference.
> 
> The idea of clearing ->rqs[] is borrowed from John Garry's previous
> patch and one recent David's patch.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
