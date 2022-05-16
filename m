Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B553BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 17:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiEPRjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiEPRjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 13:39:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8127536B42
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:39:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h85so16729172iof.12
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=mh56sie1dPkPYUnwa6mvPMhYEaqSra4iS7JfXXMW55U=;
        b=qAJHetIbc57mNL80Bx30Z2qPkvcxnQSos1cYB90vvXD8rMCvUcp7tK+Ih0E+Uiaps6
         88iqtYzkzieHEKtlccMzu4XSr9aYh7Uc6X5fsNQvNZkoSSOtgEV0ItopxSe051SaPc8q
         utRyEINUgmS+GuC13Y0MWbXuUmUvv1g5GXftp0KAq+Bfvasck0TqP2+S2BRzI0KoX6pX
         Wwu88Nd/qrf9opIcav2IF2irJNp0+VDMN7wxGOoSy6A0+oAfSdXhLavHnf1IuP30OqnM
         ixsRa4y/YWE1SG8ReCh/DbVE+G2Aj6sHoj9DJWtaNvxEjj1GkQhPll2ZShQhxqgCIaI+
         +x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=mh56sie1dPkPYUnwa6mvPMhYEaqSra4iS7JfXXMW55U=;
        b=xvAT2lg6JDVYIKjSklIY0CJRWYrYhK2ihp25G1XRSEjpjPVK+5G5wo3fwnJVuAC9u8
         K3fhHKG1vPnhf1AbMrv/oCh7TGS/bSRdyq0qEYvjbjW8dmV334hX9/i3IKaIF3+TQG+M
         IzkMnMC+zB9FbjidjrLnmhkVic+i0N27jcG+PTkMcLpiFfTTITBPIAC6q0hf6gtZhjyW
         WWiFWkAQnnhfJffSWz732v7a26dJqKty9NkPI7EVF9AgmYVzUs9p6BfnS09exFICCoJy
         0NZp/NY5n4n+iL21yyBhJqwef+bL2rdfYNzTG/LQmca/jT9n8hrvIJLZ7/MrIZkxyLRB
         g7wQ==
X-Gm-Message-State: AOAM533rrcoMkarunxkYNO202JzW9DXiK/1o+vRi9FWWnzgLcw4DUD2f
        lv33K/L8JRKynDqUw9vrhm9kGW1wirbnLA==
X-Google-Smtp-Source: ABdhPJwOSAmiOY0EvbJnF1yn1IJ4NBeO1tm5aNU1l6890ES/z1ezm2dDKuRp3U6XlZ2eqcTsaci5yw==
X-Received: by 2002:a05:6602:1501:b0:65a:c412:2eeb with SMTP id g1-20020a056602150100b0065ac4122eebmr8148723iow.29.1652722779743;
        Mon, 16 May 2022 10:39:39 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c11-20020a02c9cb000000b0032b75b98013sm2953165jap.148.2022.05.16.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:39:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai3@huawei.com, jack@suse.cz, paolo.valente@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220513023507.2625717-1-yukuai3@huawei.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 0/2] block, bfq: make bfq_has_work() more accurate
Message-Id: <165272277894.181860.12420245970045700212.b4-ty@kernel.dk>
Date:   Mon, 16 May 2022 11:39:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 13 May 2022 10:35:05 +0800, Yu Kuai wrote:
> Changes in v2:
>  - add reviewed-by tag for patch 1
>  - use WRITE_ONCE() for updating of 'bfqd->queued' in patch 2
> 
> This patchset try to make bfq_has_work() more accurate, patch 1 is a
> small problem found by code review.
> 
> [...]

Applied, thanks!

[1/2] block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
      commit: 181490d5321806e537dc5386db5ea640b826bf78
[2/2] block, bfq: make bfq_has_work() more accurate
      commit: ddc25c86b466d2359b57bc7798f167baa1735a44

Best regards,
-- 
Jens Axboe


