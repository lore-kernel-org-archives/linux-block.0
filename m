Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB81C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 14:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiBXOED (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiBXOED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 09:04:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADE20D830
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 06:03:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d187so1928650pfa.10
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sCiNyIsGOxqAa+8g0kd9PqEfF+2jVxczpLK8SIG1Tw4=;
        b=vMJN5Hl2knWeVOSfwAjcnWQuH0oBr3rK7YpSbZYkcxyPIli93eNnFgorZMWm8NUK93
         QoWx0qFY4JUtcjf7/+L1tor6C+LeEv0Srjbg2J7XMWkfPqrHaL6+Y6u/uLi4Glv1hG+W
         x7Mn+1MiHbcSnKiog/r+nFdM8+fJNJAI825reF0kc4WVinQC3QUN6Jnh/FZvAeiyP7hS
         nG7+YKFYQT8bQBm46v7NZmTi4jbANmO2jIP78GSuShM/jtbAfCTJdTcHBzmZ+DnarT07
         JR5g9eSkvd7UigAlhpu3XQgjU6XjmuMcaOskihpRA//Bf/8tQK0vsmZusbrp+MUMuerU
         uCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sCiNyIsGOxqAa+8g0kd9PqEfF+2jVxczpLK8SIG1Tw4=;
        b=NV6YTaNZ9QrdzxSTBGwbtpBpEYI+ml4jcYwiT/LtjS4o1zGiGQU8rz8lrCROEZrYUn
         TZD798hvezBEsC9CrLqmOT81LP5DW14Y6CuLVZZkN7/WLgqpRCJI7FJgCrZZWEVAXT/Q
         4EIWmyqIFjYqNH/oCP28xubW3+FTcik/2aDsBFWxMLrc50rFmzpLyhWxQfz8N3OnodSO
         HKiWV4jGtxDfHR4XlTZaNhWzXJDHDXvSUWagMrbz1YbSZe6aygy62JKxjNLrytZ3EVwM
         AcZDRxkeaTuByRBYq2N2CeuGQZMdorFJK6FO7i0Sudd05uBDvXsDHVhW/w5scteGNtUO
         1YvA==
X-Gm-Message-State: AOAM5322+h0oM0mdffZjLeLx/6vhLXxl4NGr+VRt2fNbVd4TCh+H8PSq
        NXd1raUAguiC7JxrYnZnHdCgdW8DBnnP/Q==
X-Google-Smtp-Source: ABdhPJz+ePxqdtPzoVNNFzIfNBpXfbeumQrkwTlau6nf8NoJJjy7oossvc42Y2IijnEM7zJ8TD4xIw==
X-Received: by 2002:a05:6a00:1a04:b0:4e1:294:e1e5 with SMTP id g4-20020a056a001a0400b004e10294e1e5mr2754361pfv.51.1645711411849;
        Thu, 24 Feb 2022 06:03:31 -0800 (PST)
Received: from [192.168.4.155] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h4sm3931052pfv.166.2022.02.24.06.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:03:31 -0800 (PST)
Message-ID: <60b3efbe-a4f2-71ac-dd3e-54643849df17@kernel.dk>
Date:   Thu, 24 Feb 2022 07:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Yhc01AadzWuqPuAe@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yhc01AadzWuqPuAe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/22 12:33 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-24

Pulled, thanks.

-- 
Jens Axboe

