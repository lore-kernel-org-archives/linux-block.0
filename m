Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D103C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317E261353
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhKQPrT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhKQPrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 10:47:19 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BBC061570
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:44:20 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m9so3829257iop.0
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3lOhuo6z/rVD3RlXyyeGA0+4XQewjEckULyD1yDlkbY=;
        b=T436eaIKUXzBWbYBiKzJ3tFHNW5GQSAKTNCNhd4G5Hgp0HrGd7k/8/nKtsIE+4xxg4
         7oiAPuanT4kLA15JsLNJLz6RxUjCRqN4C7/bz7Jb3iW4j/fpcC6nxYFY4VRA7YxaOHwQ
         zShGiWUnQGFAKpi9qdqIlIkYKAwi88CUrc/BY+RJEPVHAX9AUyFvqDh6WBn32q4lIi0B
         MWMuyUoFbYlzGb5ogPdRuw2OZQfv7Hp4zuK0F2UT3FWSCaEisQlMe1HZhmpx7ZkeTqUK
         RfShhzNEeZX9+QbZrDN+TcawwCXHkrO/sE2J6hsLjA79oL+37owxNNfn1AiwB9LVplxl
         8rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3lOhuo6z/rVD3RlXyyeGA0+4XQewjEckULyD1yDlkbY=;
        b=oIth3fOcgrR/h2v9L3OZvQ5dh+fewdkgpoIFoA1bEgm/KUsAKCM2GvSywyTlXAL3vf
         D5F0pQAsrImsd0bIk5eI8aG4uoqNN6HyZH573EIGZwTgu8ULvf05cE+vruugtgh/a0wI
         Ya0tg8YFZXSfxb+C4gNul01Vsuy742tdSn2KGmclHMPVLT49lLuTUNISwH7MfwUJSR3Z
         zZOh82E8t148ihehO1QcjDQ5n4skAlsmSwHPeS71K21rUo93CRmEA7gyx4NRXn1hSIGR
         sxPuzao2XyLV318rG27r2haO8djaVJCfPOhvb38dsQdL9hiCAONy8uYoBaiWuupPGwsY
         cjFg==
X-Gm-Message-State: AOAM533ENnU0RQ5AW3zP6vDDwrfiIKxqf4bYD8bkwMjUDID3aLJcaB8u
        F4NfakPhmVaSXJnQj1wwGXmevne6/dSAcuR1
X-Google-Smtp-Source: ABdhPJyz4UE/UvbxccV9mHKdNkWY8SQN3MlO4SqI1qCYdU89DOosA5Gh0h77DHHTE5nxaBIgdzaqfQ==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr12193584iok.182.1637163859730;
        Wed, 17 Nov 2021 07:44:19 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g4sm195853ila.78.2021.11.17.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:44:19 -0800 (PST)
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-3-axboe@kernel.dk> <YZSeBFhNvkYsiA2T@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c88b3bac-084f-ed8f-969a-3f6542cb2f58@kernel.dk>
Date:   Wed, 17 Nov 2021 08:44:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZSeBFhNvkYsiA2T@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 11:15 PM, Christoph Hellwig wrote:
> On Tue, Nov 16, 2021 at 08:38:05PM -0700, Jens Axboe wrote:
>>  /**
>>   * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
>>   * @nvmeq: The queue to use
>> @@ -511,10 +520,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>>  			    bool write_sq)
>>  {
>>  	spin_lock(&nvmeq->sq_lock);
>> -	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>> -	       cmd, sizeof(*cmd));
>> -	if (++nvmeq->sq_tail == nvmeq->q_depth)
>> -		nvmeq->sq_tail = 0;
>> +	nvme_copy_cmd(nvmeq, cmd);
>>  	nvme_write_sq_db(nvmeq, write_sq);
>>  	spin_unlock(&nvmeq->sq_lock);
> 
> Given that nvme_submit_cmd only has two callers, I'd be tempted to just
> open code in the callers rather than creating a deep callchain here.

It's inlined, but if you prefer duplicating the code, then I can just
drop this patch.

-- 
Jens Axboe

