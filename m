Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91AC41513
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 20:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjJKUUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjJKUUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 16:20:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B69AF
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fab2caf70so788239f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697055647; x=1697660447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=xtMLL3AujsI8XG2mXYhKUB/spGXSmJKab1wO/UvQS/pPVYZARPmE+q8H5VdoRMh/IG
         2/ie0e4WfoJrxn7MwIUU1jey8Kz0OCtZ6Gx8F5yZ3p+Cql8E56xlX9sAnutWbqSzV7Kq
         Ml+SaWHjAa0ntgCwGDvYPs9VgVRqAlZxhKrgkyoCR/TmVHC41Waj0OVMNozcOCKhkZMi
         JkfvejHYT6yyKfAPLzUKORCZDE3qQxLDY+k0S0EbX2kS7B1G8gOsiw85/hYi4hp//0Al
         v8FQb1gOjr0mablPKIPxrSRweSLmtdr3J5joUQZASyPdGibvXxtduZF+i5hnEySIM4Ol
         v+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055647; x=1697660447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lB/j2LtNeMz/W1YQQ732duppdg4xiLJo45Q+RSgVAQo=;
        b=FNMFsmjegnVnS6gyWVQw7Hs7AZ5ZFEK+KMjPfeSQbo/hrpWsJ9nRp4OAXxebesM8ed
         6ZiRvKff8peaYR7/OLUgNhjn6Hm+z+cuByUis3MF0SPj4U/FNnFIGYMUJJWb2fQ45rTA
         +Om+Uwsl6l8JzhDn+V7CefwivP5LgWhpVk8P+NyvvB8/mLCqKldwnaDhY6VWChePRnCT
         dHNioZBLZ/BVIqy8oyV+DV0mWeKqvN3tvdpSr9XasHy/8mHNHGiqAbwGl4mpK+RnbrIY
         bFGStTQ65kfDirFxnsWOnC4+nUun+NVxCAmxhV3RFltbB6OGB7jOkh2pBzB+IQMJyIt9
         HYOg==
X-Gm-Message-State: AOJu0YzJnwRm8GzO1PAh7O3qdXBPeGXMhr0pmi7boFHSZ94VcsB0geYc
        eKRJJ45ISuIa1oiqTw2PJqaRDw==
X-Google-Smtp-Source: AGHT+IEruZKhD7bxlTjyy47l5LeM/sL4l3VP9Zm6qvwYHSSSMgVJNz0+ACbD8gaUX5jTiNivN3JKDQ==
X-Received: by 2002:a92:db4f:0:b0:350:f353:4017 with SMTP id w15-20020a92db4f000000b00350f3534017mr20611565ilq.0.1697055647337;
        Wed, 11 Oct 2023 13:20:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r13-20020a92ce8d000000b003513de0eae9sm177591ilo.24.2023.10.11.13.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:20:46 -0700 (PDT)
Message-ID: <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
Date:   Wed, 11 Oct 2023 14:20:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Don't invalidate pagecache for invalid falloc
 modes
Content-Language: en-US
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231011201230.750105-1-sarthakkukreti@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.

Fix looks fine, but would be nicer if we didn't have to duplicate the
truncate_bdev_range() in each switch clause. Can we check this upfront
instead?

Also, please wrap commit messages at 72-74 chars.

-- 
Jens Axboe

