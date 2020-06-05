Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E838C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7051920772
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 03:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nwwZGmKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFEDQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 23:16:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E9C08C5C0
        for <linux-block@vger.kernel.org>; Thu,  4 Jun 2020 20:16:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so3047754plb.11
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bctzVQ8SIG8ea27wo554J62PZF0MOCP82/vS8y9jLf4=;
        b=nwwZGmKL2JSLcG3yJdDes19PRwsefTxEdzQXV3UoEaIJMppOnkNJ0yLzml+7eRhhr4
         C0tEb0axhGFC0uamROITrRN1H+727cRjPDTOoRr1LCOfnvojG+PpM9YRE33GaggHQKhe
         R40oxFAiS0MXAMKwUzhYZ/wgRD2YNxuxZeTqY9GgTtc0J/+3+mfkSOUuNQMpV0l8X1b8
         B2YYscM//GgYzMe3Biq5pUVJ+oULarPuV5q0GSua6MDxdTovUulXmKDugfoPbdhlJtpp
         RBmIaAFVCFGfqQus9NdgnzYxBOOLZAJonG74KD7ik1GWbtDxzaKoS1SAxGWrYhCVbqDw
         QQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bctzVQ8SIG8ea27wo554J62PZF0MOCP82/vS8y9jLf4=;
        b=feuyQH9Y4jx4AfGnZQb/hnwTdvuz4305Ez8J7LHackeIV0GHctXEcsD8JYMm24jSlN
         zKCsDd4561PaG7k4JdiwBI04Kwu513/07ItP5kIwArxI7pKQDd1DFyQPA/kPefe4NNje
         zZZJHMpgA+VzEgKGN+Yla7fA1Kv7N556I/QX52pmxxiC+WSuZfczxVx4VerZUoyAk0Go
         oivERX5o9sgLdEAoW1ZLn4RTcJgK0FaLyj6DtaSPXs5lAqlPtvIAMcjaDtf6UQCn45zt
         m0n6ElLKTTHT5ftJIYnBsRDgF2FDggZNSeTap3+Lg7Oka4vTctw8l5T4JkA91evRCLWY
         o4eQ==
X-Gm-Message-State: AOAM532UofsrVzNcXwtaNi+7ZgaACQo+5DH1PIiCzUeh+MRS+1pW+7kL
        5CgTFAAvISeZzQrMJ26DejJySw==
X-Google-Smtp-Source: ABdhPJwmPyXkUafuc100JuyhcxdTbOoCHtdt4NGHMPe735k0ADUTPCKvIHAO7A/vxQEvTYjqbrJC2A==
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr563999pjb.57.1591326996097;
        Thu, 04 Jun 2020 20:16:36 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k19sm6115552pfg.153.2020.06.04.20.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 20:16:35 -0700 (PDT)
Subject: Re: [PATCH] block: remove the error argument to the
 block_bio_complete tracepoint
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hare@suse.com
References: <20200603051443.579748-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c98a1900-7746-6bb7-2301-457df60ec066@kernel.dk>
Date:   Thu, 4 Jun 2020 21:16:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603051443.579748-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/2/20 11:14 PM, Christoph Hellwig wrote:
> The status can be trivially derived from the bio itself.  That also avoid
> callers like NVMe to incorrectly pass a blk_status_t instead of the errno,
> and the overhead of translating the blk_status_t to the errno in the I/O
> completion fast path when no tracing is enabled.

Applied, thanks.

-- 
Jens Axboe

