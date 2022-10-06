Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B574C433F5
	for <linux-block@archiver.kernel.org>; Thu,  6 Oct 2022 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJFRAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJFRAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Oct 2022 13:00:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82D1C420
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 10:00:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 2so2363686pgl.7
        for <linux-block@vger.kernel.org>; Thu, 06 Oct 2022 10:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myylvuvgHaQ1KsIGFy9DLpcyTy0Pi4uSVkyvorXXTLg=;
        b=uEUcSaDafId7nTd0rz7oK9fQpvY7/rzDh4PX6dYxUtR6uwTwHKHv6b9TeuBehZ4gtf
         lAbvm6NZagqdHyD188W3MLiWFSlJTlWP5sKxLAP7WwqOnIQdlNQ1LOaDuYoQxvno9c15
         5eET3EQELBqRjwnxv0IWkAWlrc9seVCPAdAu6GNjWkMtxP5zLSVHk/Z4A55MMET3wl+u
         xOrZaF2O0wGt7JhdhGQu568xn9F4gaJFH2/9iidtQpZXlc8bp8NsOz7BaQmr5s33UFx9
         H/AQTyyCxqnpp1Y+aa3cKBbtjxCQ6Z0HbdPcHZvn4FCX/at1P5A8bc5R5JuBvZFmlxe0
         XU8w==
X-Gm-Message-State: ACrzQf3g2zOmq0wWv4VgdjaVjy7P/lhxYgUGTNkrhlx5aEommNfBTuK0
        QUYv9PhKv1J4JJFSPfxvl6OZR4kKYbgctA==
X-Google-Smtp-Source: AMsMyM6ozuPaeYOdG6w3cAQkcq9OcD22SFcKdk5dhtOvqPLlvR9RBxQq4YOWmN3BG805n780cOHMFg==
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id s16-20020a056a0008d000b0053b2cbdfab6mr607661pfu.3.1665075456456;
        Thu, 06 Oct 2022 09:57:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:1d3c:9be0:da66:6729? ([2620:15c:211:201:1d3c:9be0:da66:6729])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902cf1100b00177e5d83d3esm12602912plg.88.2022.10.06.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:57:35 -0700 (PDT)
Message-ID: <acac67a6-3331-75dd-840a-40b509ada0c1@acm.org>
Date:   Thu, 6 Oct 2022 09:57:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: again? - Write I/O queue hangup at random on recent Linus'
 kernels
Content-Language: en-US
To:     Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc:     linux-block@vger.kernel.org
References: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
 <206b68b7-e52c-969c-a08f-a309a86c1ba6@acm.org>
 <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAK8fFZ48N_VPSZ6SiknBtasDtUZiRn_ZsvcR4D132rj36W0KsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/22 05:36, Jaroslav Pulchart wrote:
> I apply the
> echo 0 > /sys/block/vdc/queue/wbt_lat_usec
> at the production servers. I expect it will disable wbt. Could you
> please confirm that my expectation is correct?

Hi Jaroslav,

I have no experience with WBT. But what I found in the documentation seems
to confirm that the above command is sufficient to disable WBT:

  What:		/sys/block/<disk>/queue/wbt_lat_usec
Date:		November 2016
Contact:	linux-block@vger.kernel.org
Description:
		[RW] If the device is registered for writeback throttling, then
		this file shows the target minimum read latency. If this latency
		is exceeded in a given window of time (see wb_window_usec), then
		the writeback throttling will start scaling back writes. Writing
		a value of '0' to this file disables the feature. Writing a
		value of '-1' to this file resets the value to the default
		setting.


Best regards,

Bart.
