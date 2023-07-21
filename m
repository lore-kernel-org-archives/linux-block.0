Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94992EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 14:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGUOAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGUOAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 10:00:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FFE273C
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 07:00:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-760dff4b701so28477239f.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689948044; x=1690552844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yowB+SDYz3WsGB5u3KbSB7coFl3FEU+ho0O0+py0Ukc=;
        b=2ziMtz9YyzgfSBLhUc1oOXKhL9AKaqop1axLHbKTYlFB+2Dr2Dl07WL468pS2SisaE
         udSJ78TBuZeK6W9WH1dyNYdGBLU9Cjb0v39zWgq+q2nluI5eK94Pf0DvfOL7eUu+uHjP
         eq4LM5/aRMSp38ls+YtCK3sfk4dYQy0elqlGSdlFWqCVjyAJuhpxzZwuGJkouo70sQi6
         n8TXnpULDukNmpOktdv+wl6Dt1sDHKxGxe3E21vXbgXMXTxnBjD7gL38uEV4Owy0rapG
         ONHgxm8ZMhiLbvorVjYeSWpqyLsbEesmAL9UP1z6N800PUwsy5ns+m46+wmRBBaKwSNy
         jxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948044; x=1690552844;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yowB+SDYz3WsGB5u3KbSB7coFl3FEU+ho0O0+py0Ukc=;
        b=OsiLgs8YflFRzu7fKfa7W7FahLJunWOAH65usQobfZsD9Nhjm/FmoCpzJFYPgrKKIh
         ZjcIPStxO73R8EkKlGV9vs4fUUWtDefMJP3yErdafRgHplPsKBXG/rzeTeGb/8/Kkz1N
         3xbb1PX896qzmDOhXUPuszuViAVZCJy3HdhTCqwosSU04pvN2C09sLo/Tk0tyc22FVTt
         r6qsGaEUJOziP/ouN/Y/yTa4I6Q9Kgrxaigz3zlcqTT1Y+7lyQuWNY8BTWxyn0Aaak0G
         5ltKsjfguy4lCH1JR8ZzQ3rEGxdESqZWriRLMiK1Q9fX9qZNy9zUsSaEg7SHRmHt7+QJ
         vZeg==
X-Gm-Message-State: ABy/qLbl8lN6SvHbBxmZ8gqZWNriTFh1xdYmbFk1oo0Q7AsrEjr0E4+R
        eHQgQ3N1aa6IZbl2lpuVL9Kclg==
X-Google-Smtp-Source: APBJJlHMT+rxz7f5suX2hWoG4yc3KEkLf1UJ5Q0KxS+wamMFFlkkxKHrGWKDrLBg9z5MlQwuTgUyMQ==
X-Received: by 2002:a6b:b789:0:b0:787:1926:54ed with SMTP id h131-20020a6bb789000000b00787192654edmr1799444iof.1.1689948044181;
        Fri, 21 Jul 2023 07:00:44 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b10-20020a5ea70a000000b0078337cd3b3csm1065191iod.54.2023.07.21.07.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:00:43 -0700 (PDT)
Message-ID: <6f0b9cbb-6752-6dd8-c184-10798533dfed@kernel.dk>
Date:   Fri, 21 Jul 2023 08:00:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/3] brd discard patches
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <9933f5df-dd43-3447-dce3-f513368578@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9933f5df-dd43-3447-dce3-f513368578@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/23 7:48?AM, Mikulas Patocka wrote:
> This is a new version of the brd discard patches.

Can you please:

1) Ensure that your postings thread properly, it's all separate emails
   and the patches don't nest under the cover letter parent.

2) Include a changelog. What changed since v1?

-- 
Jens Axboe

