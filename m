Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CDFC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 19:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C17864E07
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbhCPTh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:37:58 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39314 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhCPTht (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 15:37:49 -0400
Received: by mail-pg1-f176.google.com with SMTP id x29so23297298pgk.6
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 12:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T74rBM/tRSmbGhYyhhjhqsWTrXH3aBckblO3TkAHslU=;
        b=T34oO7mp5Ta4Xt89Y5FLATaM71SXDBJ3mTGSzrgUw60OgdUnT8bfvSWPqNOl3yr3nx
         gqJclnhRs23PTmk06btDlqP0skNH4pD2ZKcjLAk7SukmWBJVHUYO+ECWLJGHRugxGqNh
         9JniKh8S8hTODZ1mMFEm5K6L8+tudmqBbLVvqI/Nkhd+PAl6+QK+jb1KIK81zclCDCKg
         iglEtPRQ4OkuJBj+dvb6RX0KAt6mANHOOo3MYkc2wn1YaCTVuC1fEkTamgPl5/1Te83U
         gCiwMlaaAPwBWMjaRN+FjGFiYNqhYZbUGqGIAXI/zTRkPADuEJFqIdybLxTkAmlzmMyL
         pfqg==
X-Gm-Message-State: AOAM532WPGjSqzn+m1ZDnlFCQ2tuhUJdSK+Lq96vOOdtK/2U9ee4Hl0/
        LzvTdwFqdiwc44hJCP9WvRw=
X-Google-Smtp-Source: ABdhPJyLfFzD7Rc31IivN+kgtLpXHpoMTd75qeP/BGo3hi/qM6kcr5NtjNv+0Q6YIeSDT+4Bxgu8pg==
X-Received: by 2002:a63:9254:: with SMTP id s20mr1117836pgn.33.1615923469182;
        Tue, 16 Mar 2021 12:37:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b6b5:afbd:6ae4:8f83? ([2601:647:4000:d7:b6b5:afbd:6ae4:8f83])
        by smtp.gmail.com with ESMTPSA id o18sm199691pji.10.2021.03.16.12.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:37:48 -0700 (PDT)
Subject: Re: [PATCH] sbitmap: Fix sbitmap_put()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Omar Sandoval <osandov@fb.com>
References: <20210316035420.2584-1-bvanassche@acm.org>
 <b578af4d-2a2b-375c-396e-2ad57f6e579e@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b3e22b50-c9ab-9b6e-13d6-4dbde942efba@acm.org>
Date:   Tue, 16 Mar 2021 12:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b578af4d-2a2b-375c-396e-2ad57f6e579e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/21 7:32 AM, Jens Axboe wrote:
> It'd be nice to have a bit of a description in here on what is being
> fixed, eg that we're preemptible and cannot safely use this_cpu_ptr(),
> and why that it's OK to use raw_cpu_ptr() instead for this particular
> application.

Sure, I will provide a better description and repost this patch.

Thank you,

Bart.


