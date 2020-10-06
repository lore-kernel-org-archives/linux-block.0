Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86538C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3622C206CB
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kTvuDNT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgJFTfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgJFTfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:35:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014DC061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 12:35:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i3so2101291pjz.4
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9fErTHL11kpWfWuwGPLZ+SmduNMj5QzcAAbL5QMQhjw=;
        b=kTvuDNT1nrKQ6P+303eZbTcf2P/qp3biwQ80uRdb2OX/qQaw0ai/Rww9/r+aXre2GI
         eLvfJmxMLt7EM9nj4EjpT+V3jFZAbxxW7ANaOsOKvqVFEgD87BHVHt1z/dcLjQhpU/c6
         UlmBT0FtA7nrMq86dTHpCx2KKEO1brAQL1izbECDVe2DlfdPY0HMDtDybiZMkU8JrS5O
         Rup6Zh0xAWGH9boMtUWM6GPE4L+NUJ2LEsbNopDEvh+ZvlKcO1PSlROIdQQAR+T2TBZ+
         R3Esy/Mdcu+ksQptFdVstcf8hWp6jKmYghi08S3P6EviT0mbEyKsZNx4hvNXRYzGQz21
         U2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9fErTHL11kpWfWuwGPLZ+SmduNMj5QzcAAbL5QMQhjw=;
        b=tgm8rjLwXj+FYj0Q1/eTGoItl126f9buvyK4PxI9AZ4PvzgSLfB73pkZcghjPCK2Ps
         aziRx/Z2wu6uosKjh5CLY1NcBTq4qSFgzkTBiMsITG0zSygbYEnVAOaoQKkLitI75RZd
         iNRT0lssqNeTWqo5dQhxl24EJnpqg0AOTt1Xmvlf5emXq2HTHtc3jwE4XlK4n2LqKj5L
         a15/l6dxAu6vKxcD7P1dODZyP+IbZCPKQHgeBoL270P8zkTnH6DqwWz356bL/WvmA3Ra
         BcvYJ2J2vTcI/B6JAco9NOP9fDVm020pqaMNwEwF+82LMsMGH4AhizWl+ld3nWYJsXhP
         ikVA==
X-Gm-Message-State: AOAM531s0ypXtiBjdo/wNG+H4qh6WpbFE+MA7X/Mcc4ZpOPQukV3ropH
        9jeFkoC7sto1AVYdkkGSm5C38A==
X-Google-Smtp-Source: ABdhPJwSEA9DWQM6MW5pyCBuf/5QJdMv1K0DRjVgMSFcHj5nnsZl2ru03fIzmGAgyjIvWikNF4FRYw==
X-Received: by 2002:a17:902:bcc1:b029:d3:9bdf:32e3 with SMTP id o1-20020a170902bcc1b02900d39bdf32e3mr4508449pls.1.1602012923690;
        Tue, 06 Oct 2020 12:35:23 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g4sm3997726pgj.15.2020.10.06.12.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 12:35:23 -0700 (PDT)
Subject: Re: [RESEND PATCH v2] block: Consider only dispatched requests for
 inflight statistic
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
References: <20201006191509.2482378-1-krisman@collabora.com>
 <20201006192038.2484672-1-krisman@collabora.com>
 <8e53dcca-bd5f-4b81-cf73-d905f2c36dcd@kernel.dk>
 <874kn7no97.fsf@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2126313-066a-11f0-32bd-8cd407fce3f2@kernel.dk>
Date:   Tue, 6 Oct 2020 13:35:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <874kn7no97.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 1:33 PM, Gabriel Krisman Bertazi wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 10/6/20 1:20 PM, Gabriel Krisman Bertazi wrote:
>>>
>>> Oops, I have no idea what happened, but something ate the hunk at the
>>> last submission.  My apologies.  Please find it below.
>>
>> Care to just resend a fixed up one? Saves me the time from fixing
>> things up.
> 
> hm, the first submission had an empty patch and the email you quoted had
> the entire fixed patch ready to apply with scissors.  It should be good
> to apply it, I think.  Or, what do you mean?

The point is that I need to manually fiddle with it.

-- 
Jens Axboe

