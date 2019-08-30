Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A6C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C981423405
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S4xlxo1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3NnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:43:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33056 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbfH3NnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 09:43:18 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so14128117iog.0
        for <linux-block@vger.kernel.org>; Fri, 30 Aug 2019 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYGH3fN4v8plY5qOryvWCm0ZkkSEcqIXPLFE0LXF1xM=;
        b=S4xlxo1McUe3ODbG6lFGApEUyreIy3lVJLjs+cn9444a0h0+Rw/NY4ZYuiUhvrjZPo
         DmB3w8J5vYckaTr6NsZa5XfN94OcZxbrVgulnZbOWhB6mRLpe4+kLyv43tswN/kHk4GG
         9UHMiIN5cFXivXPg3y9OVT9Tg1EsF/bMJHpgPMOgiv6k4nDTt2wvthKF6hoO3GMwReXK
         fIQpZ2YrA/op7HljEdDrnfM3cap4cNptn4aIL7Tiiue5UgTXJiAZOyYcBEvGwX4MJfyC
         kYCa9ot7vwFWEc/WqwgS2OomWM/Ed1tsIkDvT7jB8a7sXwHTnKsiDO4uIU9ToiEeWM30
         Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYGH3fN4v8plY5qOryvWCm0ZkkSEcqIXPLFE0LXF1xM=;
        b=bRxrjYwdbpRLop0IgrjGEGmQ+sR2fZDq9rVgE7ym/NVbfOQUqCnDlNdBgqHxTtjwND
         yCsHAp4X0YnGx6xNl2pvMTyFiwZWhjc7PfXa/VYZGAs//yL3vIfFTlD4AGIFH0ER5vHM
         lj6V2N8nC7H9/Ml4qsdYNci/I+/HuFPHMFiv4be1UmKtN4TanXjmXBIcbTop+vmk/Z8g
         spATp5PDNvTHuKX4Q2a/Sn2EYkeGuO9/bs9Vj5wYoApxvZ1jZIbts8LpemcYruAQ8L+B
         r7CDPgtqniX/0ScwkNUSPRIWVNHDiHvEaPzN8dpuh03zsz0ZiioxCPQYMewhqeFq8zrk
         kJBw==
X-Gm-Message-State: APjAAAU/Lk/hxH0SDcqeGbyUs2Rq0VJsVq4CB6kquRZBH8S1fHysppdo
        mU5dFdYPpfCqRAd3WwMojMc/AtBF5gtzpQ==
X-Google-Smtp-Source: APXvYqxv98ySoIehWYfQrkiVnKQ7682zkf1UCD2MmgpAND0sCQpnfidFJwrCLdPl9ybmgBa1NkKwWw==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr12501340iob.282.1567172597938;
        Fri, 30 Aug 2019 06:43:17 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o2sm5032889iob.64.2019.08.30.06.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:43:16 -0700 (PDT)
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a54af97b-b9c2-3e31-d7e5-bacd40e74711@kernel.dk>
Date:   Fri, 30 Aug 2019 07:43:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/19 4:47 PM, Tejun Heo wrote:
> cgroup foreign inode handling has quite a bit of heuristics and
> internal states which sometimes makes it difficult to understand
> what's going on.  Add tracepoints to improve visibility.

LGTM, applied.

-- 
Jens Axboe

