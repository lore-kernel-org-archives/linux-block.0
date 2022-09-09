Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CEC54EE9
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 02:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIICgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 22:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIICgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 22:36:48 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B8D5703
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 19:36:45 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id c24so288982pgg.11
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2022 19:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mlnPdUr6XXbF0HZMHJMIKtXJYhw11TdJc7fvNLQmh+c=;
        b=cj3yphs5zDceDxRMaCsUtslni526BwAXXabSG3s6KpOMb93FaT6TsUq1+c7mtLfNfY
         b/DzKuPn39rVnwx9WIyVdOAGxOs7SE66fHl5jNJ86QqGeCc6hKyyKgalLDd/6yKLy3aN
         P18go3o+P3gkqkuxUel0ATjU17KNVoZCQ2dKb0mfkb78WiTtH6L/MKYlTYkQsSDQY9bU
         bXALS6q7KNC0UULNVDJXD5YXlhcOMmk8Hbe+M9yaw8DFryQx2JhLt6jaobrwlAPEAolq
         28frUEWHQD5mD/kbKhNUmMYUl0CpdIwOC4Qxlk7G42CDUB1lW/82klFdPxsCvFY0MA3+
         cUZA==
X-Gm-Message-State: ACgBeo2nxyA7PkC+6ypLdkZHlKQsbS6XT/cjZiuQ6rTi5A5UsaPZofo4
        L+ppSWIkAQTzw/2Igcbp36VJgxcOZiY=
X-Google-Smtp-Source: AA6agR7EUd7CB5DzdZj47o+AAqiqAceksp/v+ShLJx3B5o7BTAWZUs0q4IVCRhlAZCWBvM2xId5hbA==
X-Received: by 2002:a05:6a00:2906:b0:52a:bc7f:f801 with SMTP id cg6-20020a056a00290600b0052abc7ff801mr12477031pfb.49.1662691003744;
        Thu, 08 Sep 2022 19:36:43 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b0053e4cfc5440sm345865pfl.29.2022.09.08.19.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 19:36:42 -0700 (PDT)
Message-ID: <ef8abb52-f9b5-7599-4766-a9618e70d676@acm.org>
Date:   Thu, 8 Sep 2022 19:36:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] block: add missing request flags to debugfs code
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <cf3a0c34-9969-27e2-5fb7-5b5263e0af1d@kernel.dk>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cf3a0c34-9969-27e2-5fb7-5b5263e0af1d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/22 16:28, Jens Axboe wrote:
> We're missing TIMED_OUT and RESV. Particularly the former is handy
> for debugging, let's get them added.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
