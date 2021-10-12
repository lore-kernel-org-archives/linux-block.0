Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1BD6103D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 14:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhJLO4J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbhJLO4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 10:56:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D8C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 07:54:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s17so18807769ioa.13
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fwZX38FIogR45lbv27WzzEYuiDzDD9FxvQbDeIvY310=;
        b=M34Y/SHgxjgMSFb370zXp1/w0NEGEn5aEOESvaenP1+/U1vYgX7XZs+BPXgsuIelEE
         9vCESu1tcLfH2jgQ+LCUubOyeSnEdBU0N3ygC0dJR/3n++RC28O6IymOHPhjeyRgutqw
         ccNmFJDdjuGhl+zlpv23tJspLsIkJuvejV1mtb6KK51ZGc9PkvCOCX1wj+f5yn8rZwj/
         OvGthZjGy1dMg+WxWjbfRR4vLdm9mzI9/9uwDkBCmwszcR1pAzUCAbPAMPwYPFWNhTI7
         Zi4UOSBklP/fDc+IS5U6BV96inz5HwLDxteU3aw4DkkVIO0pCpfBes5s0AscmDfSqVur
         P12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fwZX38FIogR45lbv27WzzEYuiDzDD9FxvQbDeIvY310=;
        b=ghGnCUIYzrRZyUS6k2Sd7E7mCm6vS+7O98ta7v6sS4/5eATxNO6qQUNvhQ6VbnutbR
         s5Pm1azPzWfArACN8X2W7S6UctWcMTSNYH0BvmkWjV6Gw1PIOLG2X20jmb+yzbYm9E7V
         wkkUHq814Xn4VWKcBrvTyW7eGlwbLsqdSPqdP0FiUox/LWIU6KiGxL2+ahpbZ1ChxyGh
         4kve5f75mY+eV3R0j5xYhHQgFVgvXnJ4yKCbhe42sIpzGNGhTlLOnRjxsyROClwBYpR5
         2c0+gsfJPGBy78v/7ymdOjo/dmpKjTkzr25+qcOa0SRvhuZFAt0+EjcAm0/fO2RGIQ71
         7cTw==
X-Gm-Message-State: AOAM530EakV9GeUB/kULuvnT0KMMSVNhstpHIxvy4EJGu9WlSJNqrahO
        4XtkicCMBusYY82T10yV7Zr7JozmV9v9Vw==
X-Google-Smtp-Source: ABdhPJzfjoMv63mjLHobOQjt0xt7LpUrQmNf1/uNxf0ZsHuEbA+ABFy+bWv1MtIIc66cMOy4TroE7w==
X-Received: by 2002:a02:cac6:: with SMTP id f6mr16102540jap.81.1634050446628;
        Tue, 12 Oct 2021 07:54:06 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a8sm3697560ilh.5.2021.10.12.07.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:54:06 -0700 (PDT)
Subject: Re: two small blk-mq cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20211012104045.658051-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bcb900f-c92a-0f8d-2fc0-231da25d6529@kernel.dk>
Date:   Tue, 12 Oct 2021 08:54:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012104045.658051-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 4:40 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up some of the code recently touched for batched
> request allocations a bit.

Thanks, applied. I've got some further batch improvements and cleanups,
but I can do those on top of this. I'll send those out today.

-- 
Jens Axboe

