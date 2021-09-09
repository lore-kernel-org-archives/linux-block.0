Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E0C433F5
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6591A61179
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 20:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344661AbhIIUZi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbhIIUZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 16:25:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64AFC061575
        for <linux-block@vger.kernel.org>; Thu,  9 Sep 2021 13:24:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q3so3997456iot.3
        for <linux-block@vger.kernel.org>; Thu, 09 Sep 2021 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OybFG9pUPwR/fnE8znH9FLHXr+scTSP+Qko723tBqWY=;
        b=RdLu3kA2N6cIsL7LokCA8kwbXm2d1ORznndCRwLnw7N3uFStJdodVlSWkejTvmZEzU
         HQ+wcaMGY227c4Q5aa1CGWQYxKyqh1P0ENiiq4olWFUvF7SGC5POtD5iH9G0Y1G7CkKc
         mwXfNrpqRbGqKQEyeXlLr5owL8dS7V9oYZY864cxiHIvdxRPDqLHa8N00PX/UYoGVtZJ
         vael8Gi3VJ4EmJFthcl25mbBcie04J/RFotzfN67S0e7SwM21W/DcUhSOpghS/gVuVI2
         hyVahjEBbmhUJb7nzynr555C+5m5JWrliJXwkRw2m7+DLaqyoxXQ3jwBV9uIDUAMOJT2
         +4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OybFG9pUPwR/fnE8znH9FLHXr+scTSP+Qko723tBqWY=;
        b=aZTotIiZ7IjLt8iYeWAtkYX7m8GREvFOnK4kv1mAPZtYKJOdNO7Uou0Kp+ZuP1K6T/
         OmBPmOnLzS2qowqX2syCw9I2BlD4CMFqLd5uNMN3M6nQ+d4av+sCDf1ubHQSLnSk7w20
         tbRCaq8e/MhM8iKAZM3i0mRvKUk+qsZdj+O+92D9WDRFJGsQmNOXUixIjVIe3b4rHvb3
         jIKtP5fLf1eeXYodet5swM3HZNv78quqgT2gCo0PVJ2sOpvkwU3YXgfxQtAcPcgDV9of
         OE737JvWJOmoU2I9L32FdnzHFT6dmqOGm3HrakRoBYBQnZqvPatZgRZb7V0Yq5Yfo7zd
         G53A==
X-Gm-Message-State: AOAM533e20fmr6rEmB5bkOhTnoCdFAuz8gXM0LGBB4kYwRbhmuD3R+w+
        sl9HPsUXJxC2l+Qkl5Faxon58EtWbiMpXPlCK2I=
X-Google-Smtp-Source: ABdhPJzd3eqYyitt7qw63VxVF0Cf8uY3onxrLNIIoV6n3HQYqKZt2OVGb+seh3eAkhthzRQrkHYPBg==
X-Received: by 2002:a02:9542:: with SMTP id y60mr1451689jah.87.1631219067801;
        Thu, 09 Sep 2021 13:24:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m5sm1442765ila.10.2021.09.09.13.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 13:24:27 -0700 (PDT)
Subject: Re: [PATCH] n64cart: fix return value check in n64cart_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20210909090608.2989716-1-yangyingliang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1bbf463-2b1d-0ec2-8e51-155dd6565f78@kernel.dk>
Date:   Thu, 9 Sep 2021 14:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210909090608.2989716-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/9/21 3:06 AM, Yang Yingliang wrote:
> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().

Applied, thanks.

-- 
Jens Axboe

