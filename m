Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C0C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349038AbiHSOyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349546AbiHSOyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 10:54:53 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF763D477B
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 07:54:52 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id a22so4544973pfg.3
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S9WE1VT2O39BRIHN4nvbWdQt1RX/mUM2458HMmwdI+E=;
        b=hl2GL6uDgcAsRow3Cnm5bYFOLo+4zgUfOhBGuEaGjBUTQIde5BI3st2IppAtO6ItZV
         6HcAxrbdLqsjg1fk0/WPYQxMelx3va4/tnPoX0aPwcD0oQDWAvTzKVNyS8UXiHAPxJA/
         YARdaGKawSdZM5zjIg5A8GRYQ/B3/YEMccu22Prkr4hUhnCT6smFfTqFeZT6699ZyY+p
         pggu6NpKMnX9XBCk6o9E5V2ANv+J8Sz2hf7MNGVaJ0ePHBGJAXiNCcuSpqPl0QUrqVkb
         +AEfp38qJQlNPpZ69cJhfqoJv66lHTTfns+ffze7MFpSEY3Lk5fKkeR24ne3OXrUSQVA
         F3qQ==
X-Gm-Message-State: ACgBeo03+qnjr6GfgdIMg2z7iY4q3HNz7j/GfzvKIMKKp6VFuZZfyXmz
        6gFFj3AA8R2ULzFdef5PcmM=
X-Google-Smtp-Source: AA6agR4qR8PfOy/lCL0MawfIBhEM8YcAOApwclW3j8x7mj8m/jOqS9wds+47eNFFyDby5L68L7OfQQ==
X-Received: by 2002:a05:6a00:1496:b0:52f:734f:9122 with SMTP id v22-20020a056a00149600b0052f734f9122mr8223719pfu.85.1660920892295;
        Fri, 19 Aug 2022 07:54:52 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x185-20020a6286c2000000b0053600e49d5dsm1763713pfd.20.2022.08.19.07.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:54:51 -0700 (PDT)
Message-ID: <090d88c3-6ae5-492f-3bc0-83c6f5307c2c@acm.org>
Date:   Fri, 19 Aug 2022 07:54:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH blktests v3 1/6] common/rc: avoid module load in
 _have_driver()
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
 <20220819093920.84992-2-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220819093920.84992-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/22 02:39, Shin'ichiro Kawasaki wrote:
> The helper function _have_driver() checks availability of the specified
> driver, or module, regardless whether it is loadable or not. When the
> driver is loadable, it loads the module for checking, but does not
> unload it. This makes following test cases fail.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
