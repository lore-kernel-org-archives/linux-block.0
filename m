Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9721AC46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 03:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjAJDTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 22:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjAJDSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 22:18:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7341D5F
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 19:18:41 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id b12so7303112pgj.6
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2vMuRifEflR0rqW4sVbUmQc1/LuBQa1QT5vJMZvjAc=;
        b=X2TklK6j3bpjXI8F9pl0dTcLZeEW9rmtOm9P6qKtQjrt7FgcPXyioe0lNefGzeViIB
         +pLK38NB74PfUxiGi2RvEBwD89DoJW+RQzzFMVsfcq5Y8Q6GYw/KyUmJVJ2L4TBqWj/E
         UwMzHyubCpYuuV3dZPMsMJNpzrYn+kcIoaeSE+0pkejMvaBH5+VSjAFhjU5RchZwPh9I
         yY6NthoZvdF4wrGoCc70PbufBEVRq+AwbYzI5L8EaiZAzfFUkAK+xhEuRUHYebPxGvIE
         DxBweGNr4e1HnPUV1SPYBQ1QGD6FSbqYhH/tMf2f7nMpxZOWbIb0mwF0MQkBqcnKBhkE
         0O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2vMuRifEflR0rqW4sVbUmQc1/LuBQa1QT5vJMZvjAc=;
        b=pvwtn1H+hltDbTfTrOGczS6mRZawoDcYPajNwXAilO7qhLYxqODbFVEiKZ43e31+cg
         M4w5buCr8xSjctpJmkgov5zx1ppvVzjA22utkFYpRPQDZM6q5DH5r8svuqjso2t2PNP8
         1FoYp9DLUPwmkfqDIJQ97hvuhF86L4RDqQfz+qepYIb4yFMJ8vPYv+CfUB0Ui/Vfac2C
         KX+dueL2IFQmvziyB6baT8dy3rEcXhDLH+kqF/RZ+zCqjWSsGh/Pale1DVjcHdZQp17r
         MklRvOeEPYJDJR3M9w6j3qRXhAk+EXASC2J8a0MqW34VzDbCpimdj6MF6fEgfOD9qy7q
         3Zww==
X-Gm-Message-State: AFqh2kqnKP9vWDWfyjg5ZEuybvS16Oj7+mc+QDLCZ0nayKOYsdL/L1vd
        3xcvjrXa4aiUAw6UAidw51ksyA==
X-Google-Smtp-Source: AMrXdXvBg0uBp69ddXdGZcOkOEPW1BK7ZjQr2Kd9Z1AjIxSSnX02TnQVanCB2HrHkQ+GP/UBL3z07Q==
X-Received: by 2002:a05:6a00:2a0b:b0:585:4ca7:5c4b with SMTP id ce11-20020a056a002a0b00b005854ca75c4bmr2754545pfb.2.1673320721376;
        Mon, 09 Jan 2023 19:18:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u64-20020a627943000000b00581816425f3sm6480835pfc.112.2023.01.09.19.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 19:18:41 -0800 (PST)
Message-ID: <f37f8e60-d580-0b7c-0fa5-a26ab49c9781@kernel.dk>
Date:   Mon, 9 Jan 2023 20:18:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] lib/scatterlist: Fix to calculate the last_pg properly
Content-Language: en-US
To:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, jgg@nvidia.com,
        logang@deltatee.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, alex.williamson@redhat.com, leonro@nvidia.com,
        maorg@nvidia.com
References: <20230109144701.83021-1-yishaih@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230109144701.83021-1-yishaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 7:47 AM, Yishai Hadas wrote:
> The last_pg is wrong, it is actually the first page of the last
> scatterlist element. To get the last page of the last scatterlist
> element we have to add prv->length. So it is checking mergability
> against the wrong page, Further, a SG element is not guaranteed to end
> on a page boundary, so we have to check the sub page location also for
> merge eligibility.
> 
> Fix the above by checking physical contiguity, compute the actual last
> page and then call pages_are_mergable().

Reviewed-by: Jens Axboe <axboe@kernel.dk>

Andrew, can you pick this one up?

-- 
Jens Axboe


