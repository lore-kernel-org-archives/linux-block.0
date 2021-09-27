Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AABC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5713661058
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhI0Wa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhI0WaZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:30:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327FBC061765
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:28:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r75so24850991iod.7
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=Ah7jkIIctR0HcnVgB5sWbeUdZwsGT2EehBK4lb+q32xOVavNWfD82zKlDGRJA1B4PM
         /2U90/0SvcC9l1r+IDSlahEN/NC+QMNdf8OLk/ooOlydqwz6QGg8wDViFrkfEGikp/c3
         /Q8A/XGE1SZVGZ1hcLnLB6Er8MX1tmX3kUoUHTd8fZUIlpDxvC5pwUQYipgCc7oJVSI+
         rkiNvqR6Uh37Z5l+Gj9S3tYzBLrJ2DlUD27NmkKUe2vWKFh1TgA7VLVoziOPGtTGPqo8
         dcSrTDLSWV/lT8K2aextSKUoXJ59tNYXOpE1Usf4pH7xnmSPdZY6piFtoxoW38lIHPW7
         +BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9ezsQ1UkQZeC53NkFhy7B+1aNQW9TNDf1kl1c4M4R4=;
        b=LUoiJwRMGIuSAuW6lGR7HqWwiGklf211MjiFsn/agwC9NyryuYNfeLKgKevRcfIclY
         y5/ZpOv7zQWD2vsQig90ZdUnxqzUL8uazRa/4M2WLqQ9xVApDRbSTJi4SOjwdsainF8a
         XR+77JV6AYni2qSFntUpUjiHad6W8+uZUHbRXURxS6OKGynxs2qeX9EGXf5dIZvfmU8M
         WoLxwwqV0WsahoEqLgngKE62RiZTyty1lefl93gYORNP8YXuAij+CJn/GnLMMqv3O5W8
         tZ53V8AehEEXMrts56GiZN8rE3sXA37C61Dl32uBX+c8oubx7ZhaUjGOLvfp+7PuMwDe
         pknA==
X-Gm-Message-State: AOAM5316C8tZt+gX5D/TMd2IgQqIgOo2eC4+o/zSqstkZnPCxYaaNbJt
        fCzIrHWkTr2MliY8//1H1i8LNg==
X-Google-Smtp-Source: ABdhPJztY3mK3ksoDQMf3OrQ8dUSONHNyLP4EfHo/dO6kIiAhPp9t/W2Pe9f9RD+PJfpbL6A6UQe4w==
X-Received: by 2002:a02:22cf:: with SMTP id o198mr1814887jao.37.1632781726231;
        Mon, 27 Sep 2021 15:28:46 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e13sm9446741iod.36.2021.09.27.15.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:28:45 -0700 (PDT)
Subject: Re: [PATCH v4 5/6] loop: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, martin.petersen@oracle.com,
        jejb@linux.ibm.com, kbusch@kernel.org, sagi@grimberg.me,
        adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-6-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cd6103b-1251-cc22-93ad-da7f207147b4@kernel.dk>
Date:   Mon, 27 Sep 2021 16:28:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 3:59 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.

Applied, thanks.

-- 
Jens Axboe

