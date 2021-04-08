Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB63C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3608E610F8
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 16:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhDHQ1u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhDHQ1t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 12:27:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A502C061762
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 09:27:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q10so1778112pgj.2
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 09:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mafwIgopHuKv2JdRg8SzHbRvbYIcqRm0q3UqzPBMTPU=;
        b=nCyXz9vc/JIbvPkYqTPcIv1RGNS8z0+C3jWE0/EEyz1RfnrvLA7jLS+MJ0a9NIzl3V
         YSSm8MmNXvmXtgAqC47EnbcLsiZMX4vf4DtSDV20VDh4QcbbuBJ+bbE6TuWNnPtfk+lM
         nRZoHJBtZ+/6pN2mKvXT/vcZgWt8hoQfBWStoErr6Mj+eOBvLq+w9uwZXN9FkgYP7wjY
         o8WV4Zsa4jCP/2eEMziwg6aGsvb5KDFRht3Yr/xR3BDWn3EfuE4y4R1yHWpCGQi0LdyN
         rViRMXGsLl7CxNw+QRKfBvSRQ/v02UwlPPfN1mqemBL5kEUR2EqSeD8cjU0TWtCPE3qm
         l7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mafwIgopHuKv2JdRg8SzHbRvbYIcqRm0q3UqzPBMTPU=;
        b=aS2WiY8Z6I2TWJwCU7F3GcIduEgPrM24TNGbCbZXIc2G7+MUvLi3taIctuTctu1wG3
         BqD+4aLODOxcbrPIZ7tZKwmZM31vV+DGavYBK0rv22ox4gvaSew1QBSiTz4Y9kfPLOWn
         UTIOg5Hv5tJQEdFXOSXvsPeg21JFs6ZFTNkM62xnOQHrIZxJUDFcoqN4/Ws/CN7gGcCW
         ZXoa34UnaVAPZMBcWOqQTDAKbVko0b8G0rhqLV8GRt1UqMaX69oiG/6vq8JBqk0IbS/d
         JrVOqub8oWS2L/KVIY+1z0wRgrWDt+eBMVZW3++nZGBJ87q1VndumIzwgcSRUMY6PzPY
         xQIQ==
X-Gm-Message-State: AOAM53029HiT0zTI0IjMzIGYc0SL+J3/oNuHEW9QrO3oL7DsHTQkAh32
        /nGS27bm1YuRkiHWjzYtNnvh+ZbCe66zaA==
X-Google-Smtp-Source: ABdhPJw66BiLxEXU2GgSRwCraE1st+Sx2zRrs0ayazKN8Xlkn+uAVfg0Q9jQxjsAQUc/17B/X13l2A==
X-Received: by 2002:a63:c157:: with SMTP id p23mr2638830pgi.162.1617899256524;
        Thu, 08 Apr 2021 09:27:36 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z16sm24531022pfc.139.2021.04.08.09.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:27:36 -0700 (PDT)
Subject: Re: [PATCH] uapi: fix comment about block device ioctl
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210316011755.122306-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2d4443c-741c-88b0-ce38-05e9fc47ea65@kernel.dk>
Date:   Thu, 8 Apr 2021 10:27:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316011755.122306-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/15/21 7:17 PM, Damien Le Moal wrote:
> Fix the comment mentioning ioctl command range used for zoned block
> devices to reflect the range of commands actually implemented.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

