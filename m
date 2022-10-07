Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A096C433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 20:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGUex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJGUev (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 16:34:51 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEA11161
        for <linux-block@vger.kernel.org>; Fri,  7 Oct 2022 13:34:43 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8212014pjq.3
        for <linux-block@vger.kernel.org>; Fri, 07 Oct 2022 13:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9asvsQjLWyfgW9btnkCjW+SGbfmB1KCmQ/6zSqzCFk=;
        b=iB0/6AvKojLEiFLRQeLdvvnYvwcpFsXtY7DcC9pn6goagNXIons0YBwaXkw2nuszVG
         BSDVDIZh6FHPhCPz+Xudm8b3+48Gj1k44ADmWoeoydLuTOCWZKoNMPgKfdFrqSB2EHvC
         iZUGXmSI0jg8+4SYhs9+UGeXu3lT2brRYb4Q93lT7Xb2/fA5x1hn7WftB1CdiERe9bGw
         PQF/ywo3euyKzN3zeLDnwIiaNdKdoH6N8mu7axt3jNLYF2ungh46tw5e5H9+ACh9Ok0m
         vsHFhAkeftRXQY38bfFZn6hsyUqVYRDX959unm//q5exEiNAqo/s3VyFCYPIo5aLiNay
         sUmQ==
X-Gm-Message-State: ACrzQf1tYCQjwmf8ZRdqUER6oJA6Y3Xw7Wkrqo9526ltle/DfvjRi1sg
        pItZtSQgOsauFgmG1GHV4rNtEhHxjIQ=
X-Google-Smtp-Source: AMsMyM6BydEaYApF1kpvkydkwGqiz5MHQsEACQXWJZCuF58fkcCQA0BB2Q/t6WtpTKbSDnviD8UTiA==
X-Received: by 2002:a17:90b:3b86:b0:20c:705a:dcdf with SMTP id pc6-20020a17090b3b8600b0020c705adcdfmr940188pjb.205.1665174882265;
        Fri, 07 Oct 2022 13:34:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b72:b06c:f943:31d5? ([2620:15c:211:201:b72:b06c:f943:31d5])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b0017d0e793932sm533297pll.215.2022.10.07.13.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 13:34:41 -0700 (PDT)
Message-ID: <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
Date:   Fri, 7 Oct 2022 13:34:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/22 08:28, Keith Busch wrote:
> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>
>> BTW, I came up to another question during code read. I found nvme_reset_work()
>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>> controller is already disabled when the reset work calls nvme_sync_queues().
> 
> Right, everything previously outstanding has been reclaimed, and the queues are
> quiesced at this point. There's nothing for timeout work to wait for, and the
> sync is just ensuring every timeout work has returned.
> 
> It looks like a timeout is required in order to hit this reported deadlock, but
> the driver ensures there's nothing to timeout prior to syncing the queues. I
> don't think lockdep could reasonably know that, though.

Hi Keith,

Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
function. Has it been considered to invoke these two calls asynchronously
instead of synchronously from the NVMe timeout handler (queue_work())?
Although it may require some work to make sure that this approach does not
trigger any race conditions, do you agree that this should be sufficient to
make lockdep happy?

Thanks,

Bart.
