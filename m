Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E6C77B61
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 17:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjD1RE3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjD1RE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 13:04:28 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A761BE1
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:04:27 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b5465fb99so218642b3a.1
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682701467; x=1685293467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5RD5AOKMPlyQU41G/7rS9/+nMwoeg2+rIoR0L7gQNs=;
        b=kXs8T693YYNOMJcKk7c+VbJwfEbtE9jvVhbO/IDfeIaQ7bDPNzHhWvbkv24kOxxdAj
         WDJOzw1p5bbxw5fZ21Ed/+BON3+BRd6vY/IswvmdXM2+KnEhGaNprxIN74ugSTEvCHDX
         Z8PeZ1xG//DgYBgiT3A83/JkvAJXO/pudSDT8kG4+lYyegeNhqLYJGsj2qCqHfFpsDr+
         y3xK9QqeJssp8P5RCwhgseEqCpv+crCYTCxYIBnbJtvCygAJ4cKdQaKWU2nGri7hg6EZ
         MvgBovhu3iEG476doAJ5QbBs7FyyBYVhhen1OskAXe/6nsEHGrUhQrBUI4iTjOBLsnQD
         ijow==
X-Gm-Message-State: AC+VfDyHzD7mkz5KZV20OvM9Qxu6/lLwQ6OcPW6yrDR1rT9ziC8z24jx
        9soOOPvsWyFLcgev7lct6Eg=
X-Google-Smtp-Source: ACHHUZ6cGqYaKNQJWR2wnI03o7Pkqzr7v38PWLkn41X2lWm39VC01Zobcsk6K8Pa6bwC0vyoFvF/gg==
X-Received: by 2002:a05:6a00:1681:b0:63d:46d3:cc09 with SMTP id k1-20020a056a00168100b0063d46d3cc09mr8813541pfc.14.1682701467116;
        Fri, 28 Apr 2023 10:04:27 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b00625d84a0194sm15541841pfg.107.2023.04.28.10.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 10:04:26 -0700 (PDT)
Message-ID: <0d4c0ceb-eef0-d583-9515-a0ce0f6a15a2@acm.org>
Date:   Fri, 28 Apr 2023 10:04:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/9] block: mq-deadline: Track the dispatch position
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230424203329.2369688-1-bvanassche@acm.org>
 <20230424203329.2369688-8-bvanassche@acm.org> <20230428055005.GH8549@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230428055005.GH8549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/23 22:50, Christoph Hellwig wrote:
> On Mon, Apr 24, 2023 at 01:33:27PM -0700, Bart Van Assche wrote:
>> Track the position (sector_t) of the most recently dispatched request
>> instead of tracking a pointer to the next request to dispatch. This
>> patch simplifies the code for inserting and removing a request from the
>> red-black tree.
> 
> Can you explain what the simplification is?  As of this patch the
> code looks more complicated to me..

Hi Christoph,

I will rewrite the patch description.

Thanks,

Bart.
