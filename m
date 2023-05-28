Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BBBC77B7C
	for <linux-block@archiver.kernel.org>; Sun, 28 May 2023 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjE1Wcx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 May 2023 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE1Wcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 May 2023 18:32:52 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E7BB9
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 15:32:47 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-64d3491609fso1981724b3a.3
        for <linux-block@vger.kernel.org>; Sun, 28 May 2023 15:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685313167; x=1687905167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPwPFDRfFOO8wWxaY+n+WpJZegyzu/CFFsHUwt6YYxY=;
        b=L+zUIgyI2VlOnreWj0rlTVna3kPHk1xca5C+TjngTmg5ElfPgYJjLNuhzY+hZwBMdz
         yxnZIkcrrIMsDq671lDCQnQ1uHGVtmCTH2sXeijly6Bja7+UX3WbTVzuq9SiN9Bzx9Vr
         d+tiKqZowHU/+FzU8wUquRB7zsYaEkA//X7FmqKHcnNfVcxmyQFD/N30VZ9xjMvp107Y
         zGcGBIXU60WbEzp6m1PJQlSQqnIwekreDTV4e7SstOFY4shQygXMCOndDS1LZTqkjpJn
         9F8eYEOnDVachIxmazMjeGzkktPAkY/PvtS5daRyNAMfWU/262AgDH/5OTnTVwA9svzq
         gzZg==
X-Gm-Message-State: AC+VfDxy4U1oSyLAyLRX9CI3bJn2SP0DdWz9zmx8Q4QWV3I57EaInk+V
        JwP5O3NUkHAbOeva19+zHF8=
X-Google-Smtp-Source: ACHHUZ7U06greH/AtP25an7oAL/Ozso206enaoW7yg6p1ur4itL5/R3xWr4SB8x8//15lWXXreTcdA==
X-Received: by 2002:a05:6a00:15cc:b0:64f:3fc8:5d19 with SMTP id o12-20020a056a0015cc00b0064f3fc85d19mr12979374pfu.32.1685313167264;
        Sun, 28 May 2023 15:32:47 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79215000000b005a8173829d5sm5558002pfo.66.2023.05.28.15.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 15:32:46 -0700 (PDT)
Message-ID: <8cc92543-8d3b-6ec5-86a0-349c55a46e37@acm.org>
Date:   Sun, 28 May 2023 15:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/9] block: Support configuring limits below the page
 size
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-4-bvanassche@acm.org>
 <ZHF2Hbv5qBJl9CZl@bombadil.infradead.org>
 <62e672ad-be3a-2ce8-ee11-c9682ab7d21d@acm.org>
 <ZHO6oYt/y2lKPBaB@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZHO6oYt/y2lKPBaB@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/23 13:33, Luis Chamberlain wrote:
> That's right, so the question is, is there a way to make simpler
> modifications which might be sensible for this situation for stable
> first, and then enhancements which don't go to stable on top ?
> 
> What would the minimum fix look like for stable?

Let's follow the usual process: work integrating these changes in the
upstream kernel first and deal with backporting these changes to stable
kernels after agreement has been achieved about what the upstream
patches should look like.

Thanks,

Bart.

