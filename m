Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 10 Feb 2022 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbiBJN5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Feb 2022 08:57:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbiBJN5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 08:57:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95201CEA
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 05:57:13 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d187so10339430pfa.10
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qVzYl3RlPID/1J9EWvCP0Ca8Qcit/GaDc2G90eYSD+Y=;
        b=LKl4z5JRyaO+PUQiRs9JHd7OdFbbp52Lv8apqasXRv4aStNfB+l4IFQQVUlXc28apu
         uh9mhThuVQTf3LXVfbdwp3kjdP2leon4kcPp1St8klcjimLjOwz14ITEGliL/dygvA+v
         KrhDCsvRuDYMHL765CS/jHpsU/FCvpZiRQidxahdxxqdY4sWTSLUzB0RvTRcLTjkEJqD
         TGs4vUkfS8JHQwp1/wNIR0enaaLEKxTSUmqYYAUJmQrl3AU6bC6wZjdcxDYW7+r2FC6A
         66e9wgUCfNaHEYIXOyXBuV0oj8SpS3CZzh7iUyIFPaK7uA2zVr9iYVnRzqnjvkk+l1tw
         nY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qVzYl3RlPID/1J9EWvCP0Ca8Qcit/GaDc2G90eYSD+Y=;
        b=5oAM2gdo2z2q/49P/FUzfGZd7CDyYECWqJiZxj7sAf8Mvf+XS6c3kB93+8qUEdzDEH
         dWyYiYOwyvNkXrU1msF9BS+Z268PEP8lr2zvLbOrbhA97R18AbuYqPiIYGMee8Hb7fSO
         Yhe82H0n+76wuw3v6JhPL4fdA1i4rBOmwgDcT1Cmj34zJAx+VudzyRZIhUWVHRUucbBv
         04S0wkXFA/CcKkh+B8ets17uZ4vlOLdVot/+UJ6N22OATl0X0elDd3LOGNNLP9bfMfVL
         wS+lpgpqISjgnGHswrZjR7Zj0VZYtmkQxix86/WClDfP/OxatwPaxnCUIfbVdXRwY1ln
         KsxQ==
X-Gm-Message-State: AOAM5317McktcFe4QsplYH8jMlWy63KCVov7L0ZjzuOpsdRYo3+Vs/E3
        QsuwJeg3e2mdb7xinFyNpJWgMQ==
X-Google-Smtp-Source: ABdhPJw1FKxiTUNd0OpgPlNdACQm6dz2Y0aIO/DgWrV1QOf113ghOARQTDstU8K9fNFH7D7b1ObIsw==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr6228379pgr.494.1644501432971;
        Thu, 10 Feb 2022 05:57:12 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o9sm20902431pfw.86.2022.02.10.05.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 05:57:12 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YgTB0csAbKyI5WvN@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
Date:   Thu, 10 Feb 2022 06:57:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YgTB0csAbKyI5WvN@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/22 12:42 AM, Christoph Hellwig wrote:
> The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
> 
>   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10

Pulled, thanks.

-- 
Jens Axboe

