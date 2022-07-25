Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A8C43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiGYXGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGYXGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 19:06:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F413F6B
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:06:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w10so182495plq.0
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SJFoiqmQ8plDLeQ3sWWaeQm6tFg5RKcOk+MidDZPQ+s=;
        b=YYQcEoeNV6aJqK58y90zjQcEGsL5Alm26w7I5NxG7MgXShbb31SxEYsm6DeO8hhEa2
         tvBEUcVBG8FbeyROOeKo0nQDJzXHjjN/fl0kqYzYg8er2pajsg1dFPldh1HMVslefatO
         N4liRLOM9iTdQLzOaJESkXPNWqFn/ynd+oq2U/ueZVdbB1bDA6T2UAhmdIznXa3r7k0I
         C0ZEuxLwrS6mvyrk6kcoT5U0BS5U1xaNwzVMqIaqdAPQtnB6Hay+H+1dW4tdnOqjOqKn
         3myf36UDLuJq5c7bBCBZT1i6rZ9wONKiAnv6wevFnt8Q1tnVrv25vDKAWXD8kLSkC4N6
         dcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SJFoiqmQ8plDLeQ3sWWaeQm6tFg5RKcOk+MidDZPQ+s=;
        b=ln+7gqlLO1F1d+cY9SUTQQUr5FkxvIF4Ft5ri5jeH6rm0DPAxU8k1V/ZBKqmB/8X4i
         eaGxjXTGBST0xujEWdfMpLpl7pdReBlc5q6b7jMLV1pI+sR749m1Opod+k3Kg/GspKbR
         hKh7dJvz3gLrUarC4hHXfEP20yrX0zN6QWUk9owCCkLIlG7k6QknOfGTBbGrEea8E1Pt
         eBBcK8ye80ntPyjjbpp5IqCMdzk9qqDkAvAIFvuKnchhynZ6QDKHjMUx0J9CVj60dgzO
         tZAvRyl0MzLFClRDlIaEv09kd0VFXWH0rBbqT61IUxCzbTIkjhaX8YW6rt08QAj112VD
         AdiQ==
X-Gm-Message-State: AJIora/3TsO9ru8UsY149qBdhPkLKiyFC6L0q8nTFJJ5z2AFeoyh36v+
        /KCtsuttpi8DN62sQiCYTvEl9w==
X-Google-Smtp-Source: AGRyM1vrM6M3vuD3hBwVsiFaJcg4zY24mazwHwORdU2bVyuEEfbjhMvwk3zkWtjBlgwIYUFCwOFhDg==
X-Received: by 2002:a17:902:bd8a:b0:16c:dfcf:38ba with SMTP id q10-20020a170902bd8a00b0016cdfcf38bamr13974101pls.35.1658790381230;
        Mon, 25 Jul 2022 16:06:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n7-20020a654507000000b0041ab83d39d4sm5004907pgq.0.2022.07.25.16.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 16:06:20 -0700 (PDT)
Message-ID: <155c447e-9e4d-8e07-0810-c58973d65bae@kernel.dk>
Date:   Mon, 25 Jul 2022 17:06:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: bio splitting cleanups v2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20220723062816.2210784-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220723062816.2210784-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/23/22 12:28 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has two parts:  the first part moves the ->bio_split
> bio_set to the gendisk as it only is used for file system style I/O.
> 
> The other patches reshuffle the bio splitting code so that in the future
> blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
> under file system / remapping driver control.  I plan to use that in
> btrfs in the next merge window.

Since this clashes with opf changes from Bart, would you mind spinning
them against the for-5.20/drivers-post branch?

-- 
Jens Axboe

