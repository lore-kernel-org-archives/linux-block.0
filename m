Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F9C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 13:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjDFNcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbjDFNce (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 09:32:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C15FCE
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 06:32:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-325ac3266a1so256845ab.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680787952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTqi1Ajv67oHRc5tROIKfGkaqOKRz7sRDcwDqPC9v1o=;
        b=wrYh3BkKHG6FRKoBC/mXYvD58hzSb9ye3+XaLVLgJSfU49kpt2BOYOXzvi5/WIZs2j
         qcx5efTRjgo0NjdgUWhxTQND2+sGROHWOTjiMQZA7JZjbFy2iGmy27JF+Sz3Q1bS/SCy
         6fe17hYGzJDZCgWZXqvmZMqgTyIG50K4iddqfnnnSG0Btzer6WvQ+PD2f11FxtonF7HU
         ATvfIifpAe4XeL5jvdlVPh+zUVyQovXezrjFOK+gc170m/cwNEk9NTVxa1XjwPkGCJ2v
         3Ahet13BCJB90TDL+kuT0Gj9I8McOK68jZMv/9v8isihQRt4WKwQTDJjpjzc8i6xw+92
         otBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTqi1Ajv67oHRc5tROIKfGkaqOKRz7sRDcwDqPC9v1o=;
        b=3hK6I+t27Vo3eovHYbmxo2yH18pgh/eCQbQqgo5zLl+CStfjgXbiENkvgZ5bC4JN7v
         QjdzS5tgAbA74fD6aYR9ChDOdG4OGTWGIIBHfRj+aCqiDX25p9IM4ft9xmxBgtfB8XZv
         Ix8SpqcI0e9IyxQwXJjQcJrMszGr32sCOpLHLLLtw986OuygzeCix3ljkj5wk+jkmzoL
         i8bvlFwSrAcoW7pHYbYh2uAQJegNeIuo1GJUiZnlfAVp9S85yB5NHCyl2KRVHG+t3U7k
         gLxmYWbhCJeH+9FFd02I3+NRJAyEotxTW49MenSSeggYUFgpI6lxyClZmHJBMjBddNSl
         P3pw==
X-Gm-Message-State: AAQBX9fAlpAkYrgD4ByWz/ytpkpO408l0z6U3qqE5LMPu8FAX2u195Jd
        /+MDW0nVNsCDt7GduCPYcKCP98S8sbVGF66+YUVkJw==
X-Google-Smtp-Source: AKy350aF6SAwbPdndWPPnppug7AmRG98ip4sIdPVteltqZpMQOxCmgNuasGzfKKj6MH148+IfZtazg==
X-Received: by 2002:a05:6602:2d11:b0:75c:f48c:2075 with SMTP id c17-20020a0566022d1100b0075cf48c2075mr4116486iow.2.1680787951945;
        Thu, 06 Apr 2023 06:32:31 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v8-20020a056602014800b007046e9e138esm381425iot.22.2023.04.06.06.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:32:31 -0700 (PDT)
Message-ID: <f3dd02c3-4113-d1d1-58d6-1d3877590b32@kernel.dk>
Date:   Thu, 6 Apr 2023 07:32:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] block: ublk: make sure that block size is set correctly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20230406124059.2035969-1-ming.lei@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230406124059.2035969-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/23 6:40 AM, Ming Lei wrote:
> block size is one very key setting for block layer, and bad block size
> could panic kernel easily.
> 
> Make sure that block size is set correctly.
> 
> Meantime if ublk_validate_params() fails, clear ub->params so that disk
> is prevented from being added.

Applied, and I added Breno's reported-by to the tags.

-- 
Jens Axboe


