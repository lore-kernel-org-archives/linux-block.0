Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60BC3524D
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 02:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2E2086A
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PGno+Sbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBDCns (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 21:43:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36953 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBDCns (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 21:43:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so687012pjb.2
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 18:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bLnbFVejd+3O1F2qSJJv9BCdZUK0W2Xr7EIvWhOc4yI=;
        b=PGno+SbowrIU8CKbP76n7XJnkCyx2RPzHD8cjSZKYNNQ+5PDRUyfuygaDKnX0jdF4H
         fN3Ru1Vy6qSCGSAF8pTm4AiRKc/s/9cwJjWAQjBbM2DM62cg6VhLmF1o9nB74Ik+pYKI
         tkA82JcbrFs/daJ29fMcfAKpJF0+O2O3+WGZbRNE9aJQXLmeBW8mvLEbHWGvdgxAdS4P
         D7ShfiG3j4/aFD+DFBZUHDE1BlCU6sXN4e/u1PsjOuSqyPEFqwNz/anE3iSQPvu+ib08
         3kMVBaOQHm2hoa3raW+IVBY/PWtCtNikvghn+PhIBgyz+hYPmDN+yOnMYMqta6pa+HjB
         Mk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLnbFVejd+3O1F2qSJJv9BCdZUK0W2Xr7EIvWhOc4yI=;
        b=P3rX/t6dXy/hZwrx9MGabuf+Jc0xQpzj/GWqKE3ePoiPiK1FFYYN8JttPu0prviUvp
         iBothDSiIwNhMDvn0fOeGPqEZ3joSdg32sDOJGL5rZ6nz48dJ6yiWp7CrJVoILXbDfYi
         CbElsaixR0HXtr3XxdCSfwzdKJTyxLJj0NPa6MsN7HCDjfeU62LGX08XXiKmF2mqBY10
         Tn+ZCPP7IekLkS1L0+Tu1KsWHX6/KBpUr6Z939Z0k1cq6g3W+KiSmTZl5ZGs1N25HlB5
         63Alwdjo6rZHCgXff5QpSM7sZGWGMYNzmR58KZNlIc0AtrxPL9XO8iXO7/tOlWLDCHl5
         soeg==
X-Gm-Message-State: APjAAAVL7EiM4AE5UL1JwoVHwj7Ag0yWQ5ys1f7QAmmlD8zp2NrqKxvg
        CePVggoaQkv3zwLtpfLGyH/spQ==
X-Google-Smtp-Source: APXvYqzc6ciA9jRBi+H4LmQjqeOjXZrmG//h1JNiFsJW8mgEPZYLd9jRNeOJEU9ROi1FuxWxvdVw1Q==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5mr26272336plz.219.1580784225969;
        Mon, 03 Feb 2020 18:43:45 -0800 (PST)
Received: from [172.20.10.2] ([107.72.98.248])
        by smtp.gmail.com with ESMTPSA id r66sm22716079pfc.74.2020.02.03.18.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 18:43:45 -0800 (PST)
Subject: Re: [v2] nbd: add a flush_workqueue in nbd_start_device
To:     "sunke (E)" <sunke32@huawei.com>, josef@toxicpanda.com,
        mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200122031857.5859-1-sunke32@huawei.com>
 <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03c783e2-dbb1-5807-90a4-1d51e965a0b2@kernel.dk>
Date:   Mon, 3 Feb 2020 19:41:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aaa74a5a-3213-7b97-7cc4-89686d985ff2@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/20 7:28 PM, sunke (E) wrote:
> ping

Maybe I forgot to reply, but I queued it up last week:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.6&id=5c0dd228b5fc30a3b732c7ae2657e0161ec7ed80

-- 
Jens Axboe

