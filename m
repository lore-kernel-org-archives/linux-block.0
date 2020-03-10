Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD1C10F27
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7F222C3
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JPTt320t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgCJULk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:11:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40502 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJULj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 16:11:39 -0400
Received: by mail-io1-f66.google.com with SMTP id d8so14129405ion.7
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eG7L3qqb+Zic+vN721C4EBLLlIqZ+y5BICYOwe97x9Y=;
        b=JPTt320tbxoG1bf+0265UOAE2I4RlvjJUsWlfs22/KBBewti7s5/wa8lq/9g/aNxKZ
         rUyydz7bZhfZ7nktX4NoRGiiLJrTgN4SXku26TxW7BFWPSK+msa8MhnRowUIkzVjLhkD
         5uLsfMJGcugXoEbmF63BNszlaK+E4jNt0Rg5vXj0bZYNYHf6k0DRuq0yCwklnXHADtxu
         YElPgQJzEmqUB1gtG/C7SuclPBV6k3x877ooEakxtszzPQocFRlFqUvVHMk3bYpbGcTf
         h6k4nFxTmDDBMgMzVieSfgsO7V5UsWFLlYAYOi7PU4nQ1ezkv0QnxdCQv2PqghQmRpqi
         NT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eG7L3qqb+Zic+vN721C4EBLLlIqZ+y5BICYOwe97x9Y=;
        b=hJq+YRLmMByvLxUhfPYFHWyg+SPW/ipTKqEmCOYh5ypPnKgFbLxe3/cs27Ag2A1y9/
         rXJXK3l7X8U0pZnT1u9tUXaW90IyGyKLQZPYaWsCk6rDfTF3pO0WRVeqFZ/03pIB/dAH
         0LCBS8cxyrC7XjDdm8kgLaUvNWsSpyXt85kTYZflZG4OuxewBKhmjK+B9N4y/m43+T7g
         wDrLfkRBMgKWX2TGekSDkAshByWALDTAtkwB8veyb25Ja1baMVM+lVfUoq6C6TbWPg+0
         Dte7ESDEYZpIMzqRlntBqPQfVt528INcVMVbKUUTqnnca55LoIzg0v0Yi06gvj/DTznR
         6+Vg==
X-Gm-Message-State: ANhLgQ0JsRz0xiQhHAvhyUYWMnazl/2lrvvNQ1zPJPh5rU0Owcn2Jy6/
        IoNMx7l8+Fg72BTk+N4WQcgwUQ==
X-Google-Smtp-Source: ADFU+vsWRGdsrXRHC9rXtQ+/88zEbULBG/yD9ULi4zRlN4pOefH9EOT4xjUpLH8qJAx8yL+B7CUOJA==
X-Received: by 2002:a6b:e70d:: with SMTP id b13mr18756129ioh.91.1583871097819;
        Tue, 10 Mar 2020 13:11:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d89sm5787193ild.3.2020.03.10.13.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:11:37 -0700 (PDT)
Subject: Re: [PATCH] loop: Only change blocksize when needed.
To:     Martijn Coenen <maco@android.com>, hch@lst.de
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200310131230.106427-1-maco@android.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64c5bd67-4bf0-eecb-2393-589521df3727@kernel.dk>
Date:   Tue, 10 Mar 2020 14:11:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310131230.106427-1-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/20 7:12 AM, Martijn Coenen wrote:
> Return early in loop_set_block_size() if the requested block size is
> identical to the one we already have; this avoids expensive calls to
> freeze the block queue.

Applied, thanks.

-- 
Jens Axboe

