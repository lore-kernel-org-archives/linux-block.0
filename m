Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFDAC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 19:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiGRTNR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiGRTNQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:16 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF652FFE7
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so10082932iob.8
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=HU5bWKva0n4CR+ZgzHRD+NVBi9ldPcXdDIl3yM6JOW8=;
        b=KaOzmEIAiHqAuZNxCUhdjdpgXYRyV2csPEYtKzGA/T7I72R/C7jMwz5AfiyzjHqsQ3
         GAnuQ41uJGMxL298wb3fxKH4JmiDA7nyvFusKQSljrm7wBCezHEjDRUFf4eoLz4UfBcZ
         VHS9ZMfXBpYdJUBD6xFlBUoZ8GoJ9dJqgMOx4xJcsaS2Ww/dxE8VT3WWeqHIjF6Cm1g7
         ZrXXMUv/VYtWF53pZgh9vERGrhZP9kLVK3k1m6xPEvmgMIK7LcLqiYDZUUEZ1dgNxlZW
         f66pfLAutXYU14pswNB4GMUNGHD8w5j+c/9yKbV+LXuxtUZWP7aZPtm5t+5EbYEXl4uU
         hrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=HU5bWKva0n4CR+ZgzHRD+NVBi9ldPcXdDIl3yM6JOW8=;
        b=RMfGTGykCJTCpB4grBluwDJl0VWHKmwN9GL8swKAxpLuJ/NS2JfiXAGMS+EEFh3u7k
         FhZFr6xy0NrWqvP+hasgnX9wZ6w17IQ0aLRYQkAobjRZOaRfkEgIuta0Bl1nMCzPIfAM
         /w/S2NWTZpSKS3asGf7WofzOuIJ/md86MSIE183BQj+O1U0kW5KGpHiHOHull2x9hgMq
         9XgOehhgMH7S1bU/+q6KtmXfqK4eGT2FjlKaWWZIBlgcf3y2wBImwYqNVA7OHeOJujj3
         TYqlCGAIA1U8PeYPLSrnIg+fnvI+Lm10o6xzrGewkq6sASnfWCSKBsy3fV1NPt4craUX
         n8/Q==
X-Gm-Message-State: AJIora9RbnjCWxTE8/yPi2cEg9Q2nKeLRQcoFEFzXXBmqMnJL5sEkCpR
        /tTC0nA2NzOVlM0puqR+T6bMoQclUwmenw==
X-Google-Smtp-Source: AGRyM1t+koiFVWZ1enVF4A83oSuEeJ5xgLN76E9IIEdPjCYDaTPonCxhy7VXSTLQn6fdMTNDNDvrmw==
X-Received: by 2002:a05:6638:3709:b0:341:471c:4c64 with SMTP id k9-20020a056638370900b00341471c4c64mr10677356jav.226.1658171595395;
        Mon, 18 Jul 2022 12:13:15 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i5-20020a056e02054500b002dce11c89c7sm2148060ils.14.2022.07.18.12.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
In-Reply-To: <20220718160851.312972-1-ming.lei@redhat.com>
References: <20220718160851.312972-1-ming.lei@redhat.com>
Subject: Re: [for-5.20/block PATCH] mmc: fix disk/queue leak in case of adding disk failure
Message-Id: <165817159477.144996.10465399315575008612.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Jul 2022 00:08:51 +0800, Ming Lei wrote:
> In case of adding disk failure, the disk needs to be released, otherwise
> disk/queue is leaked.
> 
> 

Applied, thanks!

[1/1] mmc: fix disk/queue leak in case of adding disk failure
      commit: bf14fad19ffbb3d37a1bb1324f966973e7d4a7b6

Best regards,
-- 
Jens Axboe


