Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2700EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 00:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFUAe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUAe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 20:34:59 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52229173F
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 17:34:58 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-543cc9541feso2935500a12.2
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 17:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307698; x=1689899698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzlI3MFX/r7ovZ2N/fAUP6XCzNgOIV+lhVolLoXNEyk=;
        b=SwgFOK+1S4a10Vue3n93kfxVoLNv1aMUBEDbPOT3G2nzVDDd6HoAwROGXoA/VDcFMb
         CtYb78ob2398i7TlVtGFSqUAJXfi37YO2t/lydi0LGRi3PXkmYm66+5ML8HXkxA3j1rP
         3VMQawLMypgREn/IsPrCU34Ta58Xmn16ZFD2cA/EtqqGgTNPf+iBsgm1plcXB6dTb/9y
         LjOXb/kOUmZnn+0TSgrxWwKqdjx14g7z09VqCQIZptJ4TElq78h86QG423D9RjzpPyKq
         pTb3jWSy/hwBIU7mjRqgG3osftORgea2pIC1Ik9K9P/hVRGsN7uSQgFepuJitELFC6M0
         d1jg==
X-Gm-Message-State: AC+VfDyF1BDhl8AIU728dUE55FPKYcrzXokkpOdoSwRwZmlnXGWoyxVp
        vGDXWe2wgh30jHVtRHXnZZw=
X-Google-Smtp-Source: ACHHUZ6hxq30HPwFmhezRQUqG2ri459FLBqBuo4h4F5wEUY7bhCV/ZnH+kW6+RJGep8kaUp5GlEO/w==
X-Received: by 2002:a17:902:b28c:b0:1b5:2c0b:22d3 with SMTP id u12-20020a170902b28c00b001b52c0b22d3mr11253416plr.14.1687307697640;
        Tue, 20 Jun 2023 17:34:57 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b001b176d96da0sm2149445plk.78.2023.06.20.17.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 17:34:56 -0700 (PDT)
Message-ID: <43cc01f3-c1fa-84c4-c3a0-5a1b62982bcd@acm.org>
Date:   Tue, 20 Jun 2023 17:34:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
 <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
 <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
 <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/23 16:06, Damien Le Moal wrote:
> When mq-deadline is used, the scheduler lba reordering *may* reorder writes,
> thus hiding potential bugs in the user write sequence for a zone. That is fine.
> However, once a write request is dispatched, we should keep the assumption that
> it is a well formed one, namely directed at the zone write pointer. So any
> consideration of requeue solving write ordering issues is moot to me.
> 
> Furthermore, when the requeue happens, the target zone is still locked and the
> only write request that can be in flight for that target zones is that one being
> requeued. Add to that the above assumption that the request is the one we must
> dispatch first, there are absolutely zero chances of seeing a reordering happen
> for writes to a particular zone. I really do not see the point of requeuing that
> request through the IO scheduler at all.

I will drop the changes from this patch that send requeued dispatched 
requests to the I/O scheduler instead of back to the dispatch list. It 
took me considerable effort to find all the potential causes of 
reordering. As you may have noticed I also came up with some changes 
that are not essential. I should have realized myself that this change 
is not essential.

> As long as we keep zone write locking for zoned devices, requeue to the head of
> the dispatch queue is fine. But maybe this work is preparatory to removing zone
> write locking ? If that is the case, I would like to see that as well to get the
> big picture. Otherwise, the latency concerns I raised above are in my opinion, a
> blocker for this change.

Regarding removing zone write locking, would it be acceptable to 
implement a solution for SCSI devices before it is clear how to 
implement a solution for NVMe devices? I think a potential solution for 
SCSI devices is to send requests that should be requeued to the SCSI 
error handler instead of to the block layer requeue list. The SCSI error 
handler waits until all pending requests have timed out or have been 
sent to the error handler. The SCSI error handler can be modified such 
that requests are sorted in LBA order before being resubmitted. This 
would solve the nasty issues that would otherwise arise when requeuing 
requests if multiple write requests for the same zone are pending.

Thanks,

Bart.
