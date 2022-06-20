Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84116C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 11:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiFTLQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241912AbiFTLQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 07:16:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71415FE1
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 04:16:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d14so6442987pjs.3
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aFCMWRRrgCRPgnMafsTkd22sVhyJa38gf/9TsQ+0dpg=;
        b=MuNRI//tY0EIwccGmsXnUWr20rJX5IJaKfIhzUHsSSbmVFlOxmseN15ejHXcUXDEy+
         NOOkYm5BH7tEhSCKxpl3TxAjwV6X+zOdsPdZ7UxCUmaHx7Jhhg5zg6Q1B6xp2JujWh5o
         eatgkj+JtpMK0yIx4EP/nEeLbG0nfp1/Xn/Tre4li2/ylaBPzThOy5HpeaL5w88RLlj+
         iEJ3QQKpnWXOEPlyelx0axTfKGPCgJnM3eX3mKcvD9J5WhcDwXELMsl+wcMyJT+HUGhd
         JWfIx5qH1vQYRLjPMwrQP/e34KtG4HXdv8YDXLzvnB+7DmHYPoWlZlMmXXC8m2IY1CWr
         8tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aFCMWRRrgCRPgnMafsTkd22sVhyJa38gf/9TsQ+0dpg=;
        b=EjrPHtGEmWEF0T2xieAYk7Kpq8N+HEurZ3JEv+jnFE7rPfKSetCDybgBQn2BwVkQ6N
         W02iS7S+uHt4omSSmxDosTahVWbvyLpxaFb5rSMhzc3QNv9nVbKE52gPIzqgav9mPTMD
         D2lFlyhT2olFabhYO74AZXRTlBuxY7jaogaA0HoWPuml3RBkfbbLCLH2ETSNJZmxMgi9
         mPmh3DT6FuWK5Dh2ayXNqY9RcdOrCEpf2wyNQJn/OLGQ5GWyfiVy01/cx5h0AiJB75Tk
         ValHLrHpQtLrA//QrxifyPFF40K4vvcO4jurRk4D0VyLEu6n0T1/u884aFvtFsbBY2sO
         1NCQ==
X-Gm-Message-State: AJIora8zllgVqBXtDKBbNbtvqZF8xQEIK+uS+ixEuUf6yfJ/fPGa4Xnq
        jb3Myxe9H3dNj5aarTGCHRsmuA==
X-Google-Smtp-Source: AGRyM1v827aBqOkLdOkIAaBeTegFgzNbrxp3Jm8IVPQnxfiWj+MV72LWS0hNq6jJTIYcfNzjV9DujA==
X-Received: by 2002:a17:902:9b83:b0:164:59e:b189 with SMTP id y3-20020a1709029b8300b00164059eb189mr22663955plp.91.1655723766171;
        Mon, 20 Jun 2022 04:16:06 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709027c1700b001693bd7427asm7275968pll.170.2022.06.20.04.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 04:16:05 -0700 (PDT)
Message-ID: <1e3f054e-eec6-be87-7039-e2b4260addc2@kernel.dk>
Date:   Mon, 20 Jun 2022 05:16:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fully tear down the queue in del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
 <20220620060948.GA10485@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220620060948.GA10485@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/22 12:09 AM, Christoph Hellwig wrote:
> On Sun, Jun 19, 2022 at 04:21:39PM -0600, Jens Axboe wrote:
>> On 6/19/22 12:05 AM, Christoph Hellwig wrote:
>>> Note that while intended or 5.20, this series is generated against the
>>> block-5.19 branch as that contains fixes in this area that haven't
>>> made it to the for-5.10/block branch yet.
>>
>> Side note - I rebased on -rc3 anyway because of the series that went
>> into -rc2, so we should be fine there.
> 
> It depends on elevator/debugfs teardown series that has not made it
> into -rc3.

Guess we'll rebase for -rc4 again...

-- 
Jens Axboe

