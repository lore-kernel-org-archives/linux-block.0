Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B5CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 03:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02321783
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 03:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="upKTRMSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfJ1D3u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:29:50 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46414 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1D3t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 23:29:49 -0400
Received: by mail-pg1-f174.google.com with SMTP id f19so5865304pgn.13
        for <linux-block@vger.kernel.org>; Sun, 27 Oct 2019 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+5aiWeXstBz8ObJ+bhMpKSFQ8KKTxMpPVZxxthb9HJk=;
        b=upKTRMSgzY1qcOKKO7XaF4D+/fcJSOPUFRMbjd44byQPY7nx7NKYSVck0yb4v1zr0g
         tCmjEjVM+gAVrvellGdMsq5mo0DBcNxuRs4SkW+lv+yrNcsOs73W16TeiJzNUYEjfhUq
         e4Mr5074QZL6VLme6sRzHJcnwWkX5fdF8aSabxd0MjU68nA+8vV4qRvWKv8g9tL69MDW
         xXmc+W+FUJrDZnnX/gGajOD9KmQ2IMCkaBWARSPv0jCcYTMwl9KmgPZFdOfGocBCDxUd
         m2vf+4snbnbOGaHudIELYsLu0q5QCK/C0Klk1/G3Q2gT1jdSpKbOQ9uvA3DyiJHkbcNs
         QZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5aiWeXstBz8ObJ+bhMpKSFQ8KKTxMpPVZxxthb9HJk=;
        b=N0dcaW+Ek6Rp+rKtYOyclFUnkOODqniq6AoE0SaObKXJ3+AN2cNcimees5JI5Lzlku
         C5oUMwOt5XjoPfXiPWqkpQC2yrmeYb44FLZo1qSWbIS+Ao66FIrb0eFZKHj8lGluCEHc
         r9cGS4pC+VuW+ezhDbhhFuCVDGwtgDh+PzV+SXwLK87JrlLr+UlKM1ZNpU26pY9LkFTw
         tZ0F/0mIYVCu29JG8Bm0Ze29frqvZ5I+Vdf/R09p3LIG+ELZT+YfzCbBKXfGILjZmkWQ
         h2RDg2fOfjWoRHnU1WSJJ6bPdLHm5vOhRrMrfbOd+34iEkhTq3l+Mg6ms9iHK20zUw1d
         8bbA==
X-Gm-Message-State: APjAAAXmSIoX8pLa/yWUXGUcSzEia2ALSLqux9jqzZ9AYWKcKxF1jzg4
        GIQVCZyCTWoWErq4ymSk/SZ/fw==
X-Google-Smtp-Source: APXvYqzyLrFdi71UNo4Yn9fhDhIiSFob12dE5++q4nV0gnj7wCd4j0bOeoI+VS3dsQ/wBH+ScRb/wQ==
X-Received: by 2002:a63:2f45:: with SMTP id v66mr18005385pgv.448.1572233388895;
        Sun, 27 Oct 2019 20:29:48 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q3sm11567489pgj.54.2019.10.27.20.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 20:29:48 -0700 (PDT)
Subject: Re: [PATCH][for-linus] io_uring: Fix leaked shadow_req
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <47835fb780667714ba2d21e9a00fe69bc9bbef47.1572203348.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b46e7b1-0719-d88f-175f-c9fdee224b38@kernel.dk>
Date:   Sun, 27 Oct 2019 21:29:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <47835fb780667714ba2d21e9a00fe69bc9bbef47.1572203348.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 1:10 PM, Pavel Begunkov wrote:
> io_queue_link_head() owns shadow_req after taking it as an argument.
> By not freeing it in case of an error, it can leak the request along
> with taken ctx->refs.

Thakns, applied.

-- 
Jens Axboe

