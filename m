Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6DC77B7D
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 00:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjEPAIe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 May 2023 20:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbjEPAIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 May 2023 20:08:31 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5998A57
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 17:08:29 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so1620572b3a.0
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 17:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195709; x=1686787709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLsNjH7omrsR35+IpX+9TXNAmxcXHqm/WeNdcaaPTto=;
        b=igmNyynER5aYVQIRlBR5b/dCs3Cbxm9H7FBe8zb6TvyOJ1jZRummSq54kUvennQ/4v
         jQMpvIyAkWahiAvathk2GXwgaoyTQ7qlxpvrySgkAeAjRpzXs/ZRYeEQfSRKJ68KbOW5
         /VlvBH4HKPMzSEWGJFKlqrz38SdxYzHaBmlPAc0zXsf6ZbSwmkdZ+2ue2Ndl6uiU+RKD
         hWcGSz65Zw7br39oajHthIJemCJ7kFK3pa31exQk5fL7/FUs80kYuoJXBRSXhjkkzfqa
         Z/vMpJodSQT05FlJmrfJYcV3wa3exxYwXZ6bYjiWWN0KELy2rUWqsFWfwjCfD/gyIhN5
         VuRA==
X-Gm-Message-State: AC+VfDzilyJHvteWphNBXsZS2KxsP0n7D3SfpAGcgcAvgMexzEVzgxVw
        0m8DFGtrCpbdSEgkGkNFPSQ=
X-Google-Smtp-Source: ACHHUZ4yRtVX5SjfXZ38SWU/wuwueHfOtVgGXKKsL01///h+Ki874E+LqqtkxOYsGLtL6XncsvewVg==
X-Received: by 2002:a17:90a:7e13:b0:252:89bc:1cd9 with SMTP id i19-20020a17090a7e1300b0025289bc1cd9mr19295551pjl.20.1684195708975;
        Mon, 15 May 2023 17:08:28 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id oa10-20020a17090b1bca00b0023b3d80c76csm197201pjb.4.2023.05.15.17.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:08:28 -0700 (PDT)
Message-ID: <2dca2b99-612e-97f7-32de-9713ac1891f4@acm.org>
Date:   Mon, 15 May 2023 17:08:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: RFC: less special casing for flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20230416200930.29542-1-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230416200930.29542-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/23 13:09, Christoph Hellwig wrote:
> inspired by Barts quest for less reording during requeues, this series
> aims to limit the scope of requeues.  This is mostly done by simply
> sending down more than we currently do down the normal submission path
> with the help of Bart's patch to allow requests that are in the flush
> state machine to still be seen by the I/O schedulers.

Hi Christoph,

Do you have the time to continue the work on this patch series? Please 
let me know in case you would prefer that I continue the work on this 
patch series. I just found and fixed a bug in my patch "block: Send FUA 
requests to the I/O scheduler" (not included in this series).

Thanks,

Bart.

