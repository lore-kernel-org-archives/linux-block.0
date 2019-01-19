Return-Path: <SRS0=VL3J=P3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECBC61CE8
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FAB205C9
	for <linux-block@archiver.kernel.org>; Sat, 19 Jan 2019 16:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfASQJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:09:22 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:36336 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfASQJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jan 2019 11:09:22 -0500
Received: by mail-pg1-f172.google.com with SMTP id n2so7494587pgm.3;
        Sat, 19 Jan 2019 08:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YI5TAgB3x52pZUXceSPCArmwrCLFnhqH5a/HNw5S2PM=;
        b=NOv3d2mbz9nidf3xXVlxOMvCmXZALu3WyXotWg6SSinB8BpP0uf5vfbYUtmkFI3WLE
         zBrYwaoPYb5JlxlLqvZX4PeqomgL+soqV4RZMZ4zeXmLDBjyJPbbs5Al7NXIjtj4qovS
         HLQN8LL4EIQpUYdm+eABq6jXOgC80h4Ukd9rGJiSgr5Ee3k3fcvfgty4HwxRwQBltytG
         rtv+AMa/bgNtG31XM42ryjEMw4CIXJpABL5DTFB4uonNxAjxJFbqEQc/WXXeINEMKOEf
         8caljq9d8K/RL/1B3YKW6AeeMJiYqMTvJ7jlFGj4J1tpq3C+RZUx8q4+prfJ/jLnyXp+
         6M6w==
X-Gm-Message-State: AJcUukcCYTllt60mAhXdxoFHyivFVRGWY4PjFeNPhpANf6dTc0c0Xs2b
        BahHCwnvjHr3lVlenvrYl6JA9kUC
X-Google-Smtp-Source: ALg8bN59DJwOYsWWcxMU+I/zonKpT99b7PN4qnrdVeINK+CaUM/rMh1Iem8H1dwZB6fSWcVD0Uejmw==
X-Received: by 2002:a62:931a:: with SMTP id b26mr24692286pfe.65.1547914161353;
        Sat, 19 Jan 2019 08:09:21 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id v5sm17090668pgn.5.2019.01.19.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:09:20 -0800 (PST)
Subject: Re: dd hangs when reading large partitions
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ea0ebc4b-2634-1f6b-b5cf-0dc1bbb83749@acm.org>
Date:   Sat, 19 Jan 2019 08:09:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190119095601.GA7440@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/19 1:56 AM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 10:48:15AM -0700, Jens Axboe wrote:
>> It's UFS that totally buggy, if you look at its queuecommand, it does:
>>
>>          if (!down_read_trylock(&hba->clk_scaling_lock))
>>                  return SCSI_MLQUEUE_HOST_BUSY;
>>
>> UFS either needs to get fixed up, or we'll want a way to do something like
>> the below.
> 
> I think the right answer is to just revert the offending patch instead
> of papering over it in the SCSI code.
> .

Hi Christoph,

Which patch are you referring to?

Thanks,

Bart.


