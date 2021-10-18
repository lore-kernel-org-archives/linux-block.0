Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B892C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249EB60F0F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJRP15 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRP15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 11:27:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29BC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 08:25:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n7so16808196iod.0
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xl1gQhAS96ALQGgsU5bwERUfEXFWE9c4lwvTSUH46RI=;
        b=S5VdjpnxrXOZev1PnHvNzh1dgSq2KjGhvIK7a78yjp4aVxaTFvjDgNbIl4heHOaKoZ
         FtgOy31XsTIDH3iYXy8dwB9TXzvmcrwawnYt8inu2rpINNyRWZlYBWQnlDbfrJYmYyXM
         QB978NdH8hprYfn+fnQATFQ00aP3FTpOLkgrmJHQgJMauih264Ah6i5zX6+y2caXv5bb
         RSy3Y1qKRtRd4EslAHLcVLxMwiseJkJ4BjCWxQdspTwUTK5QbUR9j7xXLAGvP6Hey7bq
         i12C/c+W41+drSr26VaMvWEDqjM4gRu052Defkl/V8VDeF/8gWGmwQH8TE7GaflSL988
         NBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xl1gQhAS96ALQGgsU5bwERUfEXFWE9c4lwvTSUH46RI=;
        b=iTNiUHKfJC/40TLJeSjIc0/mO/3gy78GfybI5VADNyhB9cVozxpF0ZPtJr3pdLIRA0
         JEeZPEH3MPZIlyZELU/r/DfgGDMO6IJ1/s9HIWOc8o+6OY75JrRZJpA8Z9Y1CJ63F/QY
         jbOHKqbWZtZYe17Jy8PhPfLWH9V72nKK+i+sWb76051eZnxrh2EkUq4hgcxPXGmU2rG0
         6hbCbIXMlRmCqJg1llYg6QfAq6LfPqQNo8AbAqQyuRZ7YyMy9yYJ0MvRSFu+gOYwRiHr
         D8h7jGCgSQ9p0kWKePggxT7yDd3yLWJvb+H51R9V089v5mg+WvjKjreX5a1pbGHMPv+z
         3XPg==
X-Gm-Message-State: AOAM5322xmWrnWOUc2OU+kMvi1h72+42rzaf+vBqGlFunOBjaMuqKKu5
        Jal/NaueFkArsK2+j/MM9g8D8b0w3P46tg==
X-Google-Smtp-Source: ABdhPJwVNC9wkROB/oWQYPwDWOAz+QcalUgUSsYH+Eyjci4c0NZLQjDvjRm+qMJdwQpHHCQv+foi6w==
X-Received: by 2002:a05:6602:1542:: with SMTP id h2mr15399400iow.198.1634570745071;
        Mon, 18 Oct 2021 08:25:45 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g13sm7218434ilc.54.2021.10.18.08.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 08:25:44 -0700 (PDT)
Subject: Re: [PATCH 6/6] nvme: wire up completion batching for the IRQ path
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-7-axboe@kernel.dk> <YW1K7RR2F+dL9ntI@infradead.org>
 <458fdc6d-e006-48fb-b66c-c4c2b631b236@kernel.dk>
 <YW2PULGTYHdb/PoP@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2540b8f1-7cf4-e688-3a4e-8b88fee1cfff@kernel.dk>
Date:   Mon, 18 Oct 2021 09:25:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YW2PULGTYHdb/PoP@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/18/21 9:14 AM, Christoph Hellwig wrote:
> On Mon, Oct 18, 2021 at 07:41:30AM -0600, Jens Axboe wrote:
>>> Ok, here the splitt makes sense.  That being said I'd rather only add
>>> what is nvme_poll_cq as a separate function here, and I'd probably
>>> name it __nvme_process_cq as the poll name could create some confusion.
>>
>> Sure, I can shuffle that around. Can I add your reviewed/acked by with
>> that for those two, or do you want the series resent?
> 
> I'm fine with that change included:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Great, thanks.

-- 
Jens Axboe

