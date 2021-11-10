Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6CE61184
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 02:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKJCWv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhKJCWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 21:22:51 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEABC061766
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 18:20:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c3so1048112iob.6
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=EiumqE+Ob9nsD9TYsj1dDHr7J2bIG9X/FfUb/ar7UDE=;
        b=jspmo3wRnpx6hbPV7ChuoOQHhcKCxLk8deJA01bg2zNwZ/x/M9zSUktS1mUSi2qjfn
         5iKm76sYxys/g/AfBdSaemBAjfzzgmIToWGYFNugmXA/XhPLQ0HQ702AtZHWH4PN0GiD
         c72eFmY4I4lNhaEL1LDAt2yQhAPDVlfnOJ2y7WRnUKxaUhXyJ48PDMByx573GezMrDws
         k3Il5YoBWyhpzDAlwUoolnJYArT26R8qB0XzLkSgXkeiZY8OFyzTkR1Iz2SQp2WXkL1n
         p8BnAcKlXPzuwzkrPIQMU9vC7iauUSfNioWovilZdgmUNWyFMyicP1pbE4XaKEI87nKk
         K7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=EiumqE+Ob9nsD9TYsj1dDHr7J2bIG9X/FfUb/ar7UDE=;
        b=7JaFDVSusVBiDr9YHu76HU+xrgDAmHWf/R9OlZD5u8Kps9Fx2JaPlQo+nsaJ1n0XKz
         s79DbendAKaIaBt0HJB8ZkzW+3qEMzyl9AKRywaUr5NnUIHYHv5Ty6I9ev0ulVgRlJmr
         FjlwiU/txhH8N4jlbuAbl2gSa2ARlR388xcMLRkw2ZsFlJCMULG+kqgGhG70pbR8b9b7
         ObagH8SWjrc9Qcm252E909y825DfchbA1TBFtBUfoAd1EsMgU+hpNfofSobIDYso77dE
         JBhYgUUZNNFGT+V7fIB68LqGPTwrwiNBvltGW0ANCSkdxEQYqQuIwPum0KTmOMjmGcOd
         UuGg==
X-Gm-Message-State: AOAM530lavbAhsr4WH82JvnGmR5VLUy2H+VdhdVmJvF6QT3ch9BXtA5z
        cIyZuAlufk2G9G9suxLwXifl9A==
X-Google-Smtp-Source: ABdhPJxCYdPwkwFrjv8kpwwmEdgGB+jihMacG3QvY0FHXqEbpAKwrDkSQdkGJJ3Rd/BM9OgkpTVKXA==
X-Received: by 2002:a05:6602:2d43:: with SMTP id d3mr8332758iow.6.1636510803494;
        Tue, 09 Nov 2021 18:20:03 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g7sm12663643ild.87.2021.11.09.18.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:20:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, jack@suse.cz, tj@kernel.org, hare@suse.de,
        Luis Chamberlain <mcgrof@kernel.org>, ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20211110002949.999380-1-mcgrof@kernel.org>
References: <20211110002949.999380-1-mcgrof@kernel.org>
Subject: Re: [PATCH] block: add __must_check for *add_disk*() callers
Message-Id: <163651080191.12234.4824381787720799712.b4-ty@kernel.dk>
Date:   Tue, 09 Nov 2021 19:20:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 9 Nov 2021 16:29:49 -0800, Luis Chamberlain wrote:
> Now that we have done a spring cleaning on all drivers and added
> error checking / handling, let's keep it that way and ensure
> no new drivers fail to stick with it.
> 
> 

Applied, thanks!

[1/1] block: add __must_check for *add_disk*() callers
      commit: 278167fd2f8ffe679351605fe03e29ff3ab8db18

Best regards,
-- 
Jens Axboe


