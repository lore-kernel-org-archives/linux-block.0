Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70BC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8220645
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 04:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ETV+eKf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeLNE1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:27:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNE1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 23:27:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so1460712plt.11
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KPHbDV34yzR9ERzXsDpefC/OdXUniSJP9yj/1sPWB28=;
        b=ETV+eKf3iJQ0jGIcJ9JqJfN+yZWK/rsZN+XRWhVe6xp/XNMfjTtQcpTidP3Jeqc3JU
         TU3BJa+WZLmTUUkgIJczqsIw8QoNi5t0gWpTwhYcZ2z8iKiL5KSN53c/M0vqPduFlZhf
         kSnG6DNxj0M1dR4sDrFwUNpZ6jpY/3GbrTeLl/fUpVzSiBOa+6FjvvS33veBpgWSxesf
         hoyr3wgJ4GYkww4K1gN6WShwx4v4+LbaAp+04AZffYfoXe02QFx5XE6bIsVE4b6TkJHX
         o0KmsQ9+EHbzCXXXXxQsknoW96tZzuLzxIVbVwjLiZfwIPHchr/VsbvYYAyZ0nl0Tuno
         aKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KPHbDV34yzR9ERzXsDpefC/OdXUniSJP9yj/1sPWB28=;
        b=anih8bCJ0L05CgqgnZ+cle8xWtM+qcxMryU1EfMroAfJ3P/S2y50/MR6KwnNlxHdzy
         +eoobsS5wEWVJ6uXwN2X2ChByRLD3GTUfMVphJOvd1WKkoFI4DqNExcZMnZgCW7xw49a
         CzghMTJ9ibjrR9OHwFYzNJWjtwA0hD6Hb7erslg2L4aD/G8eaeqWmQt6dSSXowd7ajHq
         1rslLYfpMk5IAPXbVJzd8AziRrLPVtF6H7xCHJMf4Ym0uCiyI3YMRnzA+5wtjdo6Kqrn
         sUd3uyTAclmpw0WsW2FI+vUPWealDccgDskiCg/2ggIrR9jEcCPEdNsnuNNndb+o1kDJ
         BKaA==
X-Gm-Message-State: AA+aEWbZYHyk4AAM7MeIJGVkGpSYLDGfXP6Xlg7Ql9nuOmfYtgnJpwTl
        LHvEXwNZHsYWXywAlpminCjuPw==
X-Google-Smtp-Source: AFSGD/VLuEMLa6QbDOUxUm4EFELnZ/jTKROs/FZQme5RyHCNUtK7dAmEGH3geC0YYj+tsMljKGmVpQ==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr1477889plc.137.1544761621557;
        Thu, 13 Dec 2018 20:27:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id w185sm4625343pfb.135.2018.12.13.20.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:27:00 -0800 (PST)
Subject: Re: [PATCH V14 0/3] blk-mq: refactor and fix the code of issue
 directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8035ac66-63a1-b03a-95f8-c11a5482e8d7@kernel.dk>
Date:   Thu, 13 Dec 2018 21:26:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544750900-1549-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 6:28 PM, Jianchao Wang wrote:
> Hi Jens
> 
> After commit c616cbee ( blk-mq: punt failed direct issue to dispatch
> list ), we always insert request to hctx dispatch list whenever get a
> BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, this is overkill and will
> harm the merging. We just need to do that for the requests that has
> been through .queue_rq.
> 
> This patch set fixes the issue above and refactors the code of issue
> request directly to unify the interface and make the code clearer and
> more readable.
> 
> Please consider this patchset for 4.21.

I'll throw this through all the testing tomorrow, looks good to me.
If it passes, I'll add it for 4.21.

-- 
Jens Axboe

