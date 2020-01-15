Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7BC33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B61F24671
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oNwdoIwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAOPSy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:18:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35027 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbgAOPSy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 10:18:54 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so18189851iob.2
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f/Cwr3cVYg9TGbBC43+dyrmsQ4FjqkuIYj+Bl4calbA=;
        b=oNwdoIwvtDWap5ugw+cD7ynOZFCEh1Ez5Qz2Kqg6N+V9Xvv3csWoaNQiyg+c/5qlQ9
         aFGmUG7iA29bhpfP7VKvNauzUYazIsvahbkk9rwwA1ktT/zmHOJZ6nDRyDdJoRjj6PUu
         EeKLzrTQ0gj8L6foFxDqu217Q7NA3HP5N3fqpVQaWZjyncuRa0gHrz5vkCTSto3ygjlE
         jvagxPeH6IQs/bPZdgDdDDhmDX9qpHNuGpecR+ViX9Jalt6reH9LxVp8D8i6MFMns8Y/
         IzYZUfhSk5IytBNyF6uG4swYKIvNkUBQHhIr64WD/mmy7TFvrU2BuWMMLqioA4Cd4MoO
         1I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f/Cwr3cVYg9TGbBC43+dyrmsQ4FjqkuIYj+Bl4calbA=;
        b=dI0AFr93cz2yxWXlR0qoyyY4BynXJ2nc/wra4nuYsv4r8H3TNo+GfJXccBMOE0FCBh
         7Sps/zFaE5t6Zh5updz0w2WB+vg/WbPISEhOO0p1TwTD3EiTKDonE7Lx635NhYhsciRj
         Mv4j0D+32h0v9Awu+7vUeDrIpLz5moGcKw9iVKjcxAUTJxBs3vZ9UOmfQp8t6JL98nm8
         Jr99J2rYjBM/xoUyiCs/s/i6kHX9jWIWGttOi1NvQtkYe0MPTk8/UwI+ledvz4TO7gcT
         SKFoptODZNUPAgS+R6ydSPDi2M1tMxsoRZoGINnJLmn6V9BA5ajGCak1DXRC+2VtxRvJ
         ECVA==
X-Gm-Message-State: APjAAAXu8ctI57KnlqPT3k9ZL1ApwPSKkLfFTwSFNSEG2AmVmKXwANfb
        iJkJJWZyWAWRQnH1Q1PFmx4xPRFS3h8=
X-Google-Smtp-Source: APXvYqzHtvLKdXfo7gnv4pLbh1/7vpSlieipmW47rkMGyswk/UQx/Kn1sau5i+sNvyn/DfscgzKHuA==
X-Received: by 2002:a6b:c8c8:: with SMTP id y191mr23131522iof.104.1579101533106;
        Wed, 15 Jan 2020 07:18:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u64sm5955612ilc.78.2020.01.15.07.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 07:18:52 -0800 (PST)
Subject: Re: [PATCH] null_blk: Fix zone write handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20200109050355.585524-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <98b642ad-6642-88d8-ed5b-bff296297bf6@kernel.dk>
Date:   Wed, 15 Jan 2020 08:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109050355.585524-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/20 10:03 PM, Damien Le Moal wrote:
> null_zone_write() only allows writing empty and implicitly opened zones.
> Writing to closed and explicitly opened zones must also be allowed and
> the zone condition must be transitioned to implicit open if the zone
> is not explicitly opened already.

Applied, thanks.

-- 
Jens Axboe

