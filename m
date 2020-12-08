Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B079C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B01723A04
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgLHAOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgLHAOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 19:14:42 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07EC061285
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 16:13:18 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so10516849pgg.13
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dc3t9mRBpnlT44bCLhGzwWThsrC3gxEqUeJxmxZZ+lk=;
        b=xsirvh8ATlDyuCU+cX8nhCJ8eA24b5LLLk7M3C7wX0+d3uwYveTYpU5TpRd1x1IyPv
         hnaAveAfnRZ5Ce+nrl9/Nxt94ehpdMHVdHahwkZ7sfJAPR0ECdxqHFZaBnEYBX1n3oDs
         Rp52vz7lvJWg7JKFsdZIIt2TrS3bb54frwm+2juNKE1+mn31NKqrK4N0mj/fmIw7HE1h
         gvWPBaDxtIN/IzJ4vXr8mojoCyLQPEFprgtw5o8vEgODyyKpvxEfIWP29X3xnYYlPcNx
         xnv8bIjKmEBMOYblSUsNLG3OShkl7+iuDo4cjCcdziRIp5hNwYpCTTMgngmW1mn+dAdQ
         S6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dc3t9mRBpnlT44bCLhGzwWThsrC3gxEqUeJxmxZZ+lk=;
        b=nm64W4nqDkIvXNp5SgBIztK9m/flXuLE6aXTU+pTKELuiOGra6ALTKgKLtfLQ/62kb
         +5Bt5yyo+73tiTqubNAqrHUG6+/P9BXEK76rfMMLI3F/ZoWkmERotUW+tEgaAcvTG2KU
         e3rTnQorBe83+HLaw1zyC32vXHAOU4ZsVi+M+B5NgcW8vAlGOvyxSVwVwL7heI/bcIGa
         NbKL3iJA2WID6s85mEpE3lfUnbv7nmdbofCFh6QjJifmw81pY7dnCCjHNL2k97dpVSAV
         cx7+dOZxCuryVBfKzmaAVlctyPjpkld/6H/YtPYRJ6lm8IRed0hNySUazQU8VYOCCwkg
         acdQ==
X-Gm-Message-State: AOAM532cW1OJGw8HmIu3t4IhF94J1UQob2GA3QJ7koTjDRcLyGX+rpnI
        e9fyE0ATeQ5s5rHhcI6dLAGmNNZUKhsnCQ==
X-Google-Smtp-Source: ABdhPJzcYjIjGcWM85g3oUzqjlr5TcChOclvb0wo6EHyZavtmXqLSW/ZEQ0BdaW6sx47Tz71feoFAA==
X-Received: by 2002:a17:90a:7842:: with SMTP id y2mr1335115pjl.36.1607386398251;
        Mon, 07 Dec 2020 16:13:18 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gz2sm522596pjb.2.2020.12.07.16.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:13:17 -0800 (PST)
Subject: Re: [PATCH v2 for-next 0/4] optimise sbitmap deferred clear
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1606058975.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ebc2f40-201a-3617-f521-66e894de95fd@kernel.dk>
Date:   Mon, 7 Dec 2020 17:13:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/22/20 8:35 AM, Pavel Begunkov wrote:
> sbitmap takes away some cycles for my tag-deficient test, removal of
> locking in sbitmap_deferred_clear() gives +~1% throuhput.
> 
> [1/4] and [4/4] are simple, it'd be great if someone could double
> check for ordering issues for other two patches.
> 
> v2: add 3rd (CAS -> atomic and) and 4th patches

Applied, thanks.

-- 
Jens Axboe

