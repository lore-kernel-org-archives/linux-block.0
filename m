Return-Path: <SRS0=vf5w=DV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B1FC433E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC8522246
	for <linux-block@archiver.kernel.org>; Wed, 14 Oct 2020 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A69RiEBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgJNSbC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJNSbB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Oct 2020 14:31:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A331C061755
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2020 11:31:00 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so385903ilt.6
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2020 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FEIa6TZi1gl8k/Kuzi1wRaNTSDsRO+ZiNXMqLrHUkiE=;
        b=A69RiEBRUcH+o8TCpYXBCPEaIqdxjeNUfUhJENQNfZCdBa5zz5i3ndOMOaowI3blkw
         jnj3c4UW/Lr31jhQkqPWfnICQpEFynzenq1K/vQ723++EY2jnhkWkHFaIWFhh0oPfdOe
         Zl78HStCIfz14P8UUEwCjeepPAUzo1uD2jRo3nPM7lW7I2etCQJ7fsEgYnkLtgiTHdoS
         YZ+WEE4UBrPNZ4MHhT5r+Gajg8FJ0I/iZF8c1m9oosXztk/yoTOZm2tsOd7Rg3Cybno4
         W9MnyprX3BJUHbGka0hlKT4AniVRySjlpCyZfOb9KVZ7vevF9TlXgkV+jT3QY0txDzOe
         S+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FEIa6TZi1gl8k/Kuzi1wRaNTSDsRO+ZiNXMqLrHUkiE=;
        b=GCILjRjmg5n4sAq+birG7jbg39Diw3ekjsQ7v9Vks+wZxtSjWTvrWinZv1ViTU+mMV
         VLeEgAdJIrFbVbJeMw6v/nmIicrCotrEkq0bE90wv9vYYYgxJHvshG60qoIFnO5bUi5P
         zrABdprJcY1ZqFs5drDtfT6ar+56Fzt8Jg0/UlZcxYIZH9AvIhTAQ6EJLjv3R37fzSvj
         Y/FjHnuSs8uHYLkmBjzNOZ925zvjN5+b0aP+Yg9HrMiKSqXb25WiTqEsJvEt3yFgeEvQ
         Az+xBBExEK/DxMjew9OZaTAWSyEsdcDZGxf81uahBp+lbVsFGQpPajgFysSCwR7BNA/U
         VAJQ==
X-Gm-Message-State: AOAM530GjzhzHRqCo7jyDzOGxSQgnKsRCVtZcZA21qmP5aHrEeZ+c8qd
        OWyHVTfaVeZqvEWugBHAKj6t3w==
X-Google-Smtp-Source: ABdhPJwgMJGWkAAkyeWGAKdaXALLHhUroa5yCDNLtnJC/Ehdw7d6Ckz9M1Ty7Nl2L+Y1Ic3fPbcm3Q==
X-Received: by 2002:a92:9183:: with SMTP id e3mr408282ill.111.1602700259884;
        Wed, 14 Oct 2020 11:30:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b9sm136777ilq.51.2020.10.14.11.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:30:59 -0700 (PDT)
Subject: Re: [PATCH] nbd: make the config put is called before the notifying
 the waiter
To:     xiubli@redhat.com, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20201014024514.112822-1-xiubli@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <180ba921-5fb0-e360-47c9-4b26433bf5fa@kernel.dk>
Date:   Wed, 14 Oct 2020 12:30:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014024514.112822-1-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/20 8:45 PM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> There has one race case for ceph's rbd-nbd tool. When do mapping
> it may fail with EBUSY from ioctl(nbd, NBD_DO_IT), but actually
> the nbd device has already unmaped.
> 
> It dues to if just after the wake_up(), the recv_work() is scheduled
> out and defers calling the nbd_config_put(), though the map process
> has exited the "nbd->recv_task" is not cleared.

Applied, thanks.

-- 
Jens Axboe

