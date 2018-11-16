Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0EDC43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596C72087C
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="atc0vyN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596C72087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeKQBcl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:32:41 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51103 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeKQBck (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 20:32:40 -0500
Received: by mail-it1-f194.google.com with SMTP id k206-v6so35168246ite.0
        for <linux-block@vger.kernel.org>; Fri, 16 Nov 2018 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lMSlct3BzaGmlMeozfWQkJp/ZNhko7ikqfqiEfrdMrE=;
        b=atc0vyN1s1Eq8CIYRxz1qqk5EmXKBkxru5VvTvHpHNf6lQHptaCQmErndCkzq5tQEv
         t1gN7R8SPXsBxolAd402/8T+pqqLQHTMqAZBHLnddJ6V7r9rmqhqIw82crdxiNuDozaw
         36tPTeErrcs9ww8zjSCpkfruo9X2o+6gyKWWb2CcRKkJGcf5XA6lxy2vbF3mLMPqStu0
         HXLHTdcw8fz6SMLXAS/jcdpgCXIQ62DS57xKOryn0ri0auWQ99jBSSE7KYlYmDZjMIPE
         DzZ+K9F/jGFDtSq687YtFwH7wMJHpVj5TlupCJBlzbAiXOJcQcUlhn6Z4hJA88v0QTnY
         Gkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lMSlct3BzaGmlMeozfWQkJp/ZNhko7ikqfqiEfrdMrE=;
        b=gEYuukdT1TZYEWhWvGYvMGxXwiyEcxOLsJ6BYaYxpLZCThPnGD8JBtuUiFc7mcXEzw
         5xvcIS8VAehDx6zQu31wHoovCYytHvcrdOOTq2qpiAFl0bcjBn/FITAqBB7Op0O2PQ22
         ImXAVPbfVSTwpQl6WD8w0gWse/PnFNijVFp+8pZuukCJCy+WSDSeGl5g0Hl24jRk9S6g
         N+8ZR2idPTA9iPKixKGf9LoUDjMvoagVm2BCT3vdKVx5n958eF36hM/BpFdvOQvoBMTu
         qCNiu67MKS6J+WPE0O8Xu8WlcujOaE8ahvQGXNZmaJPOdtfJPXQNcoFoMcRMalM4igtZ
         vPaQ==
X-Gm-Message-State: AGRZ1gJiDURA5HiGmcdBj0aeZH5yodsUaATV2CNJVKmpyq25+pnDOQur
        4eRWDO/j7fDWTU7aEBPTfufSzhUDsqw=
X-Google-Smtp-Source: AJdET5eOkHI5vCzcABlWsTHPgAHgkPjsjz2eYlFqM2T+wH50mplAkX8gVfD3M5YRrvrzXJZ47RfqYQ==
X-Received: by 2002:a02:8cce:: with SMTP id n14mr10623367jal.125.1542381592279;
        Fri, 16 Nov 2018 07:19:52 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d133sm4772559itd.1.2018.11.16.07.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 07:19:51 -0800 (PST)
Subject: Re: [PATCH 10/11] block: for async O_DIRECT, mark us as polling if
 asked to
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-11-axboe@kernel.dk>
 <20181116084739.GI9023@infradead.org> <20181116084853.GJ9023@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a47dd01-cc33-f16f-797d-93c329c0051f@kernel.dk>
Date:   Fri, 16 Nov 2018 08:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181116084853.GJ9023@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/18 1:48 AM, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 12:47:39AM -0800, Christoph Hellwig wrote:
>> On Thu, Nov 15, 2018 at 12:51:34PM -0700, Jens Axboe wrote:
>>> Inherit the iocb IOCB_HIPRI flag, and pass on REQ_HIPRI for
>>> those kinds of requests.
>>
>> Looks fine,
> 
> Actually.  Who is going to poll for them?  With the separate poll
> queue this means they are now on the poll queue where there are
> no interrupts, but aio won't end up calling blk_poll..

It's a prep patch, I have patches that enable polling for libaio.
So aio will call blk_poll.

-- 
Jens Axboe

