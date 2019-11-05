Return-Path: <SRS0=uUnX=Y5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE7CC5DF60
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 23:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343502087E
	for <linux-block@archiver.kernel.org>; Tue,  5 Nov 2019 23:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I0aElMKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfKEXmn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:42:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39376 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfKEXmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 18:42:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id 29so4438553pgm.6
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 15:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wHGZcQfy2ZioU1kQv4YHUzapKJ4rMCrpot0rUiuYyeI=;
        b=I0aElMKPkqx+Xy0kvC01BW7ZZa1j1AXxPpk4RledCc45oGAZdON575ImSWo+ijrqBU
         njgS9TCf5Tnk1A+UHmdJPfqAGXJv/XC3yL+REX9WWLntgeG62CuMM+dzYIvVBwBtFdMS
         DzuBaPYOsTJBNw3XJmD+194/U2mOlNdT+hURe4TogyWsgB8F8t/MZZbbnAUzcG0m1LWI
         e9FakHDD513kMQ2vgXQpseLy9Gmtl5RY1p6ONcY5JGhOISAp0Gt7gT2dI4d/HuP+4gus
         ZDTycrrlpiS6MKAXNrDaZoGRJlj2Yp7Ye0DZK7ghHao2pB3gWLfxNE9cRjavrRHZnfDW
         Q8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHGZcQfy2ZioU1kQv4YHUzapKJ4rMCrpot0rUiuYyeI=;
        b=cHucbgYC0Gz+VdkGjkBzRJ0XJzNl0d5SWJdXKt3XfkxAmEB4lvQmvES3EpTYXHG1pA
         XI1a0zZMwG8oEHs4zlv2MXX27MbLXoQutfoBTwoTnVOERnC5b7F5s+ukliDmqo1+wYyN
         vCCwXCNo/ZJEP7oNgPnd6gbk4/nyEl80sjziA2i3XR3+Ay6mLt0lr1lA+Rh5lspPnt4t
         35hXM6/QWW+gaY1u+aKaPeIDUnQnXj36R68GuzaCpyDxmtxqQTMuyp962M59oaQTQfji
         i3GvUQsQT2TD011jVdujv0uoxG1R3D04tZ3uPVmYL1mTFpcTm3oA2Y7gr+2gZUbpG6Id
         2Kkg==
X-Gm-Message-State: APjAAAXznl6WF5o1ik5Y5DuBSc7rWhQDtvZUbdvtkmCCmXAtqnEJ9dSm
        1wf4vfV8hAHLiIyc3GPF+MQN4o53yEs=
X-Google-Smtp-Source: APXvYqxON4+d7slrw38z+iCDHs6hE7P3ocRpSou4KJfMLfAQrMEpLEdSOF1IzDTAXh46ZvxgNpRFPA==
X-Received: by 2002:aa7:9156:: with SMTP id 22mr40999353pfi.246.1572997362326;
        Tue, 05 Nov 2019 15:42:42 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::12c1? ([2620:10d:c090:180::d575])
        by smtp.gmail.com with ESMTPSA id j7sm515504pjz.12.2019.11.05.15.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:42:41 -0800 (PST)
Subject: Re: [PATCH 2/3] io_uring: Use submit info inlined into req
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <32cc59cefc848ba2e258fc4581684f1c2e67d649.1572993994.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <130e2396-aae9-cda6-f087-7c11ac5b1e5d@kernel.dk>
Date:   Tue, 5 Nov 2019 16:42:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <32cc59cefc848ba2e258fc4581684f1c2e67d649.1572993994.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 4:04 PM, Pavel Begunkov wrote:
 				if (unlikely(!shadow_req))
> @@ -2716,24 +2712,25 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>   				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
>   				refcount_dec(&shadow_req->refs);
>   			}
> -			shadow_req->sequence = s.sequence;
> +			shadow_req->sequence = req->submit.sequence;
>   		}
>   
>   out:
> -		s.ring_file = ring_file;
> -		s.ring_fd = ring_fd;
> -		s.has_user = *mm != NULL;
> -		s.in_async = async;
> -		s.needs_fixed_file = async;
> -		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
> -		io_submit_sqe(ctx, req, &s, statep, &link);
> +		req->submit.ring_file = ring_file;
> +		req->submit.ring_fd = ring_fd;
> +		req->submit.has_user = *mm != NULL;
> +		req->submit.in_async = async;
> +		req->submit.needs_fixed_file = async;
> +		trace_io_uring_submit_sqe(ctx, req->submit.sqe->user_data,
> +					  true, async);
> +		io_submit_sqe(ctx, req, &req->submit, statep, &link);
>   		submitted++;
>   
>   		/*
>   		 * If previous wasn't linked and we have a linked command,
>   		 * that's the end of the chain. Submit the previous link.
>   		 */
> -		if (!(s.sqe->flags & IOSQE_IO_LINK) && link) {
> +		if (!(req->submit.sqe->flags & IOSQE_IO_LINK) && link) {
>   			io_queue_link_head(ctx, link, &link->submit, shadow_req);
>   			link = NULL;
>   			shadow_req = NULL;

Another potential use-after-free here, as 'req' might have completed by
the time you go and check for IOSQE_IO_LINK.

-- 
Jens Axboe

