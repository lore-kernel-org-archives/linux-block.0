Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89DC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 19:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A52083B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 19:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wajoHSvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfBFTtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:49:51 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:39454 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFTtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 14:49:51 -0500
Received: by mail-pl1-f177.google.com with SMTP id 101so3580529pld.6
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 11:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuPykQh/1Dffob929+RHyWjY/EBuidVbCC8JFNYlleo=;
        b=wajoHSvxGGIdAQBO3H2I+xUIDL0v/PCIkjV4pSfzqCp9aE3Pbb8Rog8nYsvLsSpaJG
         bcd/OgGf4D4gfCfr1jLO7cv+hQ4Rrj5Wln1PCRMYbP3EUqHqDcn8swHVRzHe3cGkMidt
         zgXF30jamcPfbQeREY6xaSmnK/yGAlhaQvv0vRsKsi15LaJfTGrC7nelDBH7QNRPcd/W
         ukiPhtrx0HL6TuntZggslTIwY39ig4Of6xRVkMvWHDXpSWxKWRtve5NkGAQsaSVy1m7M
         0lCL8RlqM/8TPEo4cbRJTte2z9udQd4f6aehUmSAhxvEhXjDxEx8XL7L6d9NtKK0J59r
         yq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuPykQh/1Dffob929+RHyWjY/EBuidVbCC8JFNYlleo=;
        b=LwSGjkILBN27cdFPZyWwMdGuDspTXdYaL0FHOzb9FjrwGnp4kMNhiLQEk8m+zo6BfV
         GlFinh3pXgPbxJW8aYv+Zy0o650+qLZvnfJYjrpHPNZ8Ll3sKib4cpTRh8R+HGuVeFsd
         Rak9SUBm89d39YBYwQPE/67NZn+uohGQAOGfPhU7eaVGpy8Wnbxbj6hnTOlpWqHRmcZO
         g9nyDs9ULlZ2pVPc2YEbok+GLOF1tfifNbPMSJxzyDNQ87awvfz/4QdqfOMu2FDafuZF
         4KMCdhUacnEQcPS32jidF5c/6sBs57ZToEIVEbGamvkXteqgsgKL/wNbEy+qwcmGL9yn
         uxjA==
X-Gm-Message-State: AHQUAuZMH7+hmMvvLggDdi2huQ4Y8/ShtZ+aYQ+ZC9u0SbG89LA9tgL8
        7U6AW7Rx3qM36jQhkj5Ax7a/k2DUTipFSg==
X-Google-Smtp-Source: AHgI3IawQfJK7sBSP468jCxyuaOu9v9OPcNZ+SOt1EJLTCSs42wo3MobmLXvDoEFTE9XUCQ1f4e5Gg==
X-Received: by 2002:a17:902:a58c:: with SMTP id az12mr12002186plb.299.1549482589382;
        Wed, 06 Feb 2019 11:49:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k24sm11530362pfj.13.2019.02.06.11.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 11:49:48 -0800 (PST)
Subject: Re: [PATCH] blktrace: Show requests without sector
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20190206120440.26557-1-jack@suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04f7afa6-a137-823c-75be-a09422a63998@kernel.dk>
Date:   Wed, 6 Feb 2019 12:49:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206120440.26557-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/19 5:04 AM, Jan Kara wrote:
> Currently, blktrace will not show requests that don't have any data as
> rq->__sector is initialized to -1 which is out of device range and thus
> discarded by act_log_check(). This is most notably the case for cache
> flush requests sent to the device. Fix the problem by making
> blk_rq_trace_sector() return 0 for requests without initialized sector.

Concept is fine, but man, that's not very readable. How about:

if (blk_rq_passthrough(rq) || blk_rq_pos(rq) == (sector_t) -1)
	return 0;

return blk_rq_pos(rq);

instead? Preferably with a comment on why blk_rq_pos() will be -1.

-- 
Jens Axboe

