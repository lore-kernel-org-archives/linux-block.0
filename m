Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86796C433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DF6103B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237923AbhI0We1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbhI0WeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:25 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE8C061575
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:32:46 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id k13so5772130ilo.7
        for <linux-block@vger.kernel.org>; Mon, 27 Sep 2021 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8L7WBKlOMyVb5BT+nzrW922i/6GSsSa4MZObyfmmePw=;
        b=2f0qKNc3+SH9azaa9xJB+la/LwqMqExSLyNizm3JkjHX61Q/3bpKanPuj3hWBxJkaK
         K1t+dw8VxRbmoS2t1qqxLgVxfXqlotPI6h9SUEF1qYD7F3e9ptIf2tQ3q+epNAbDt4nA
         OGbr+7qEpFAwZ9pplTK+d80rJO00L/SM22AzTxOokqPeH9WWOV6UTUzaRW8GxOXhhiPz
         bh+7YyMv3UQU91ZHpqhGYzekWWLO/ZlFa9SS//fvD5SxSeLXrpUiz3NmF+ePrXx1GuMT
         9qT35lmN7rRgn1JTBHaEN4kB7zwIeS3AvubSIgjpYE9F6kvljmdLm/o5JZNC6YE9fJHI
         4d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8L7WBKlOMyVb5BT+nzrW922i/6GSsSa4MZObyfmmePw=;
        b=EN0mJaqzJqRY21ImzJLkjJjCuOPDb9x/KshOpFXS+C2fgBmb7T6/6LJmX6iyHhZBZ4
         kJMNxiwlkoFy7vj7sawQntFxDjf5SFRHiRmn8ALY3QwUP0GlGraVjynzWozKGW474/+S
         xOeTq+LiZc6c17FRGaEe9CixvNarJ0vzh2TBmwXgpiUPiriKHwkpgAcjlMZomV+j2icf
         rVahoeARaPVI6JML00ZLjU1r8j+xhiyLIpHaBbtNUDsjFVqbS9Z0BJCwxYfVUpzrfvt0
         6Smg0gxybN4RNMPmg0qeWmdlz/ip0yD88W0yrvTy+chiyY1yx6V85lpumMWf2+Cvdbxw
         X6xA==
X-Gm-Message-State: AOAM530/P0aHlwNoOAPMoCUXZ6p8eossP9swstTPY991PeCMxMlEJmqD
        hOsCBGU6FktG+JBcTgInhTlZww==
X-Google-Smtp-Source: ABdhPJyMM9HrVHXjo+7XcJFIwN6fp1tP8HdT4ANnJEhIwMO2P3IgnH+XNk630Mgar2HmI4FSgMaZIA==
X-Received: by 2002:a05:6e02:100f:: with SMTP id n15mr1785369ilj.174.1632781966092;
        Mon, 27 Sep 2021 15:32:46 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w3sm9855601ilv.47.2021.09.27.15.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 15:32:45 -0700 (PDT)
Subject: Re: [PATCH v2 00/14] block: 6th batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210927220302.1073499-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <661b9e28-b360-585e-22c7-fb37d0e2aaf1@kernel.dk>
Date:   Mon, 27 Sep 2021 16:32:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/21 4:02 PM, Luis Chamberlain wrote:
> This is the 6th series of driver conversions for add_disk() error
> handling. This set alog with the other 7th set of driver conversions
> can be found on my 20210927-for-axboe-add-disk-error-handling branch[0].
> 
> It would seem the floppy world is not so exciting and so
> the only change does in this v2 iteration is rebasing the patches onto
> linux-next tag 20210927.

Applied, thanks.

-- 
Jens Axboe

