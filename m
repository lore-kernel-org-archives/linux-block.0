Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09BC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 23:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjC3XCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjC3XCU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 19:02:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A418F755
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 16:02:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-62810466cccso1003471b3a.1
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 16:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680217337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF1QgqSfI6eYBYmuRVU27gxZ8qGqeFUUbPTxCYIROcE=;
        b=iwOdnUs89gfZO7U1pNWnkqJ717YOxxsVljjrfj4/9kRerENysR9IcKxA11WGXxzf1D
         tt9Wgl7SALv9CXgTVh4sCYyAfkSO2glbo/uE+jXyHKeO05xL7O486o0q4LsCYTfUpNEp
         WGAGp1MmD7uySPPaQoz/xXDMeRxqliQyf99tb0kd/LbJ76voo4rpde0KVlDmyueISCpg
         SpF/T2LJRaHteu/nODpKtA9yaN0qHQTtSuUmT9ojcl2S7MmSrxn2DJNEl3GI1IdWt8QZ
         ZV1568JzgvGNWcr5/3PhaXvMJ1albSsSheRUyjAzjUz3Usd1nk6hY8Pep/o+tE1/JOEh
         K10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680217337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF1QgqSfI6eYBYmuRVU27gxZ8qGqeFUUbPTxCYIROcE=;
        b=HauGulAXaq++AutQiDhbOuXlKptwHl/uMcwpLT+Iqm0JzroNI+wjQT1X0Dg/GICKb1
         5BzxwjZ99tlXY7s6Ji4TZ+UlRtH7JsGOVV1Fhon0aPREhQGRZxSeHJhZF/dBgu3x4tuP
         UzRZI9zRXORkSWhip14pP66yw4cZRxLok4Lfhho21DIWB4PKmBt54lbhGuxYGsIy9qbE
         /EiUvawawmeVJke5y4Zx/vhLtWfNUOpa+CXFfFnB1LchoZ1SF7CxVy9U+Eo2VfYwGjhd
         RDCu2wdm0e+YHnLowzK6O03H/yqp+jIBncuJavemMRWoo34CVdtInWlmC7iDeOlvBpki
         8EOg==
X-Gm-Message-State: AAQBX9eS3F6zWu7cevdA6J8GVd2E5nSmX7+nuoyGcf3vWlbF967cLkje
        KHb+2GfT87ldOqMkFDN7gezUmw==
X-Google-Smtp-Source: AKy350YxdH6mULJuupZPs4VD0m4GTfEewUIf5qrsYEs7rHOYDTw9JzmF4ZZs8HM28MDPxH0tsayE4g==
X-Received: by 2002:a05:6a20:748c:b0:cd:fc47:dd74 with SMTP id p12-20020a056a20748c00b000cdfc47dd74mr4238740pzd.4.1680217336772;
        Thu, 30 Mar 2023 16:02:16 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020aa78d43000000b005aa60d8545esm386995pfe.61.2023.03.30.16.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 16:02:16 -0700 (PDT)
Message-ID: <20f6de15-3513-c969-7095-7a93c1a4f881@kernel.dk>
Date:   Thu, 30 Mar 2023 17:02:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 0/9] null_blk: add modparam checks
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, bvanassche@acm.org,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com
References: <20230330213134.131298-1-kch@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230330213134.131298-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please take Damien's advice from v1 and compact these patches. This is
getting somewhat out of hand and silly, imho. Are we gaming patch
counts?! If not, what's the point?

-- 
Jens Axboe

