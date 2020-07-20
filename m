Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D0DC433E3
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97529206E9
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lVDe0o3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgGTQ42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgGTQ4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 12:56:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DCAC061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 09:56:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t4so13928012iln.1
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VP2nB550LCm9f5amiI4hf7RrVCu1pcK2lzmvzfZ1TsY=;
        b=lVDe0o3bN+yA/jUNW84yekfdG4ELTxibo4Z4+y+kWe74S7MJypffKWTwxc3g7f9Svo
         hE4QK7tUyIsfB2QeKZct0sysO+xM9OZ0ym36+VQhW8eUHCpuQOwNjXtjdLEH6/kLt/XO
         Cb+Q/umAUYnJglnK8f0MV6ogsgyFIc3FuywSCTkVO91uh6Z9RlSUCn6hMgHWo2vbxsb0
         P5wskmDSANHCDh2cDG0k/QlGbaNRpd3gQaQmlIY2Z+HK71Z0E4qGET6af78TZAayv3+2
         /BzJDtjU3aXhXYrEjTPv4mzo91Mp/ShNNRSMiPoe+dEE+qAa15R9CNcJeJfoSGry0duB
         WzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VP2nB550LCm9f5amiI4hf7RrVCu1pcK2lzmvzfZ1TsY=;
        b=pQTbMqi01LTUbSG6lCdk+eBXyM4elWE6VG93gBRahqjtnGq/RH2DSfv8z27YYJCNyg
         0VhsIpg94vnJr+dDgVGUIP91IWqCPZK14U3bo2hk5C/EC/YdC0/3TJ+qbjZlfAIb3uB7
         KA5gTVjnr59EDuDePCDkWDpz7nPHAaV3SbWriz4NgrIPBXNXYu/0c9fzEmJk/cYhKcEJ
         SJjv3EmgCrIQ3MgIu2mKsS3Ih3YedIwF/dQ12sMOIzogplw+lONLTs6JtKxlXvU7hvkS
         KWpWH6zDCjp9zp9c1ZiqeATuR1Gw06uc1RLvM1K1ogTZmB8bXQjdgg8kv45RjC0PXOFn
         Bqjw==
X-Gm-Message-State: AOAM531eJ+RYiUlFMmlJJ+auj5p6zUTPPuqMnnE7FWXepoJA2eGUUbxm
        YMrGr9V08oqXJCIz3k9uBnIt3MHUNWtdRA==
X-Google-Smtp-Source: ABdhPJw1cGdsnGdd3eRJFrNgk4zjQ8yfTB5C639kXeWtf+7dgPZWeRXaP19mTHO8+c/Fq3IrY+Wkow==
X-Received: by 2002:a05:6e02:4ca:: with SMTP id f10mr24127244ils.291.1595264185179;
        Mon, 20 Jul 2020 09:56:25 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o19sm9141493iob.5.2020.07.20.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 09:56:24 -0700 (PDT)
Subject: Re: a fix and two cleanups around blk_stack_limits
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20200720061251.652457-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dfe56cf2-db3d-3461-9834-be314f4080ef@kernel.dk>
Date:   Mon, 20 Jul 2020 10:56:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720061251.652457-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/20 12:12 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series ensures that the zoned device limitations are properly
> inherited in blk_stack_limits, and then cleanups up two rather
> pointless wrappers around it.

We should probably make this against for-5.9/drivers instead, to avoid
an unnecessary conflict when merging.

-- 
Jens Axboe

