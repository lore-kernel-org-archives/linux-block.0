Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18416C433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B94236F9
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 15:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgLGPBJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 10:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLGPBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 10:01:08 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98DC061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 07:00:23 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z5so13588864iob.11
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=1NEufdHSymr8j3EL8WZgOmhJIcbqI2wGt84NoO4iva3eNuVoH19thUUrZK3CjpgQaq
         kRjuH+34VN4mF2Hm4k/m530RGOUFbeaPEr+CgctCUSmMlRbyX5m0xmESoXDMKObOm0E2
         gpwOEeQhc2baue3w3yx/HO1zc6bYi9bBw1SJlPW1Vl5UhKaqf+MVtEjpgGtEoXAuos2+
         UNFPYN4souZcRySo70hNgvq+hnj0CIBvWphMT0qqkF0Z5L3b9YOG8KDYieT6s1qsvhvZ
         4TB2b5sRvqe5cWoAG4V67Tm7mN5F2MZtDpKC/SfXXTkwJfC+9QWWB5K/pgYHWD9/aPRI
         gu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=C2yodrpKWn3x4jK6JeGdNYxWehC7inL1f/bUwnR/VEpgro6944DqnzMMGOYB1eLZMA
         nzKdwXbfjXIaPeDWprE1OJhQZ2rWsMBL00i8+K88+aC9V3PfaUaiwnwvtJIwf/xkd+aA
         rBcpSNR0X/EVMHINkE8ZparjVWp7uoIVOpysxFydmwKrAFwGh1TdZul+pQE9DKe2ACzy
         dU9iSeVXKuBuI/9fED7jMDuHSMDNFHopGat8Dtbxq8yTDzxpbQ+41kLghytb836bXfuN
         0VrlzK9/kek5rrPkMzKrtR9939i/9p4rTzt/IreAGYHI/AYG7EQwSNf9BwTqoQvOptoY
         rmZw==
X-Gm-Message-State: AOAM530OoQbRtj8MSotBJ27cnuzUgaPvp7tNh2nwZ85m8EfpICQTnN/z
        a6WGGvhancc3T+Y/XDDYoisLYw==
X-Google-Smtp-Source: ABdhPJwhlLtQqxbveVH/NUScV8HcEwnDWryZR3dvWY2WS8FQ4DbRiCa1LhzmlWeNC9hG1uIY77HWOw==
X-Received: by 2002:a02:b011:: with SMTP id p17mr19518135jah.114.1607353219101;
        Mon, 07 Dec 2020 07:00:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a15sm1230633ilh.10.2020.12.07.07.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 07:00:18 -0800 (PST)
Subject: Re: [PATCH] blktrace: fix up a kerneldoc comment
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20201207134048.2253938-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5c0097e-dced-c5d4-51ce-9ab73ee38087@kernel.dk>
Date:   Mon, 7 Dec 2020 08:00:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207134048.2253938-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

