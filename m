Return-Path: <SRS0=DpIa=RF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45B4C43381
	for <linux-block@archiver.kernel.org>; Sat,  2 Mar 2019 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781BE20863
	for <linux-block@archiver.kernel.org>; Sat,  2 Mar 2019 19:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UrqyAqsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfCBTrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:47:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45317 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCBTrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Mar 2019 14:47:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so578341pls.12
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2019 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rsPCfDVK0R/2njFogiLTKQYHmn1XKohFVbExvQHVVAg=;
        b=UrqyAqsq3Lr0cOvigoFiUJ8gb5pmIXROvbCV6W2J7m+faVbuxuNidUeeLHBAuPeNh5
         I9+Xh3TXbyBZ7+T5QjwuUWAUn118KhaLBKNIWCeeiVCiJ2cLledHSChvC2XDNrWXx8MY
         FDO3w55uwD4kjYoVmv3abyb3g+OZzwOf4EMN46veY8x0SIaLucJG8+J8amqrN48JI16b
         fkjnbrwpqZFYrvyt80KTyJ2nSrPC8wdwmhsW7PWAvXCgZhMm4A/0+0fYLZlky2ume/U0
         fSGc/T+2HBFa9lpcK4BsWCl3ZjRwCdQHAPdnuPy58iRnitFUU5evtBmY96Hsyv6OiUvA
         lpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsPCfDVK0R/2njFogiLTKQYHmn1XKohFVbExvQHVVAg=;
        b=fHQ7FQbQrrsOCNsggQRdZKwg7h8W7MCnVSTs28EJ49WaRRlt8Zd9TUBbbOF4CTLuEs
         Yt4+9zO1ZoWt3JoNulgaFRsTjqbPhVExzPjVFtxsdHlNra6wxTWETj26O89qSj9kKV3/
         AMJfxWh1UIelmr06MEFh0g52tdcakq4dnZQAMwkmcqzKEUSAl4jPWN8aqffm4Of0UPe+
         4fIbwvdVYXgy3h6sPT+Ok7x40S6Ou56szh21gKG/rx5a7UhnXxvVHFQz7yffCHCXYCLE
         +ZAwCCXOlluMnhRW8irZ81utjz7Ri1/sJ9tuNQ3TZOYBvAeG+j9wnyEsfDIg9GvLZ+vk
         5Xfg==
X-Gm-Message-State: APjAAAVbLwWkNL1zbfYCnUgdzrfZ9AnEyUKBXj+kJVSs9Ha3bgrvJn/O
        6VRF71Et1YsLoCkrA6vWJAcJdg==
X-Google-Smtp-Source: APXvYqxLxUcR4StoGqankNRiYgv97AruV5rpx3+0apJl5uPGb/6RDpwYOsINHOSugN5cimDKHk4xcQ==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr12264049plp.34.1551556050621;
        Sat, 02 Mar 2019 11:47:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z6sm2719211pgo.31.2019.03.02.11.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 11:47:29 -0800 (PST)
Subject: Re: [PATCH] block: fix updating bio's front segment size
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20190302084344.31962-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa527acd-2bf7-7efc-2832-d95885bf7c90@kernel.dk>
Date:   Sat, 2 Mar 2019 12:47:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190302084344.31962-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/19 1:43 AM, Ming Lei wrote:
> When the current bvec can be merged to the 1st segment, the bio's front
> segment size has to be updated.
> 
> However, dcebd755926b doesn't consider that case, then bio's front
> segment size may not be correct.
> 
> This patch fixes this issue.

Applied, thanks.

-- 
Jens Axboe

