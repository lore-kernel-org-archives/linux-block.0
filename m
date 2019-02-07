Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6862C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9247621917
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fquKS+Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBGWSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:18:30 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39729 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGWSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 17:18:30 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so4028654itl.4
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuAQhn28Ak5HyuzhEti2AYU+JGn8fhCYJBc5rGr4heE=;
        b=fquKS+SaMVzC0CtnTcEGXWLOqT4UDSUDssqEvtoD/IFU/J+azJHsmHFLdZuYFgb7uc
         AFgC+84WS7DRDTdxpo1rA4sAJwTz4r3/+Ue71dTR3XnLCfJi4jVpMDZgf4PrFaclD3bD
         rauf4S/Ky073MkIhFaNDKEif2GS0onkmGIovQk4kibesg7j9G3T1UL1DoPkAYQa96e9N
         uai98iZFBmByPq1PEhUkV5yRXaFgV2qf3Fs0dBsQ1hBQr7rXAhBBx95smfd3i0R7Mlga
         O42pTyUAXqqQBipOaXqujVmytqnVW6NHi4J8Ec06IkAVgKn8H/TBh+LEUICAvkwlXbSO
         aGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuAQhn28Ak5HyuzhEti2AYU+JGn8fhCYJBc5rGr4heE=;
        b=fzitB1mnLvIEuMYPQBEXtcU3+2oB7dAWCmfwMA67KBoqsfp8GgrJqPfSEW3MvZQAS8
         7ySrdoWNoYUIqR5z2YS2biZMrC2+4V6Z9rabgpNZYwd6LlJlOoG3usiB11OA96HRtIbS
         12dGl7moqeVX7pqeAIW32JtwlH9Ws1q6IYJzu0/oL1nykvA45y1gQ8I7KBDbIIwbCQ75
         wCrrVKCwzVHre18dDL9KIIMdzoRg4jyPpk9qLRX5FrZbcb24fdlSwj1tztjkQGGAxW1V
         rzckAnh9OrFOXF9UpgSrLZbu8KZ7zeZygcsPB8Yx5whgLlQgBPsFdvKI/XAqDNy3IZM2
         +i3w==
X-Gm-Message-State: AHQUAuZlqNlXfh5Ci+AbhkkLeeD3W3Jp3hTNfAkdq4mi0y/EixWVlKCP
        AELtHdXDEleyOUgtsxBWvSfwjg==
X-Google-Smtp-Source: AHgI3IYGqQTcxoonkBeiUeqc4cNLQjKHpTqpEGN4qF5eSUbzANOrCPHPfhKcSqnSjMzOXNyN4VTWTg==
X-Received: by 2002:a02:bb81:: with SMTP id g1mr4431797jan.130.1549577909616;
        Thu, 07 Feb 2019 14:18:29 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t194sm144175iof.3.2019.02.07.14.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 14:18:28 -0800 (PST)
Subject: Re: [PATCH 16/18] io_uring: add support for IORING_OP_POLL
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com, viro@ZenIV.linux.org.uk
References: <20190207195552.22770-1-axboe@kernel.dk>
 <20190207195552.22770-17-axboe@kernel.dk>
 <x497eeb5jtq.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1e93d14c-0d9d-5c88-7bdc-fc59461f4e65@kernel.dk>
Date:   Thu, 7 Feb 2019 15:18:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x497eeb5jtq.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 3:12 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
>> +static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>> +{
> 
> [...]
> 
>> +	/* one for removal from waitqueue, one for this function */
>> +	refcount_set(&req->refs, 2);
>> +
>> +	mask = vfs_poll(poll->file, &ipt.pt) & poll->events;
>> +	if (unlikely(!poll->head)) {
>> +		/* we did not manage to set up a waitqueue, done */
>> +		goto out;
>> +	}
>> +
>> +	spin_lock_irq(&ctx->completion_lock);
>> +	spin_lock(&poll->head->lock);
>> +	if (poll->woken) {
>> +		/* wake_up context handles the rest */
>> +		mask = 0;
>> +		ipt.error = 0;
>> +	} else if (mask || ipt.error) {
>> +		/* if we get an error or a mask we are done */
>> +		WARN_ON_ONCE(list_empty(&poll->wait.entry));
>> +		list_del_init(&poll->wait.entry);
>> +	} else {
>> +		/* actually waiting for an event */
>> +		list_add_tail(&req->list, &ctx->cancel_list);
>> +	}
>> +	spin_unlock(&poll->head->lock);
>> +	spin_unlock_irq(&ctx->completion_lock);
>> +
>> +out:
>> +	if (unlikely(ipt.error)) {
>> +		if (!(flags & IOSQE_FIXED_FILE))
>> +			fput(poll->file);
>> +		return ipt.error;
>> +	}
> 
> You need to drop the reference count on the req inside that if block.

Ah good point, because it's elevated. Fixed, thanks Jeff.

-- 
Jens Axboe

