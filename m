Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04804C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA5C20831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JSO9XVVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA5C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeKTBlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:41:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52516 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbeKTBlf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:41:35 -0500
Received: by mail-it1-f193.google.com with SMTP id i7so2569891iti.2
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H80n0JVjSD4pzYcESRVssj/QPi/ROGqXIm0S+YWO+9Q=;
        b=JSO9XVVIVW3URCzEfd2SFzdrrldU5kDIw/SZYq7C8y/wmF4e7emG/YcDIWcX80s4eh
         tqDW69+ULSnQEvEbkMFjLuEmJsgrh0GynPWqcKlIGpckLPrwO4AUZXIYL4ayEy0wJ8LL
         QhS+p6f8jcN38YEuLiSxBJrDcRKP/gGJ/3mcXN3EwQ27jnRWRYzWmwVSR7HFsMdr21QR
         dbw2kp0ejAcG6WcQK17J+xosLFCE0JrQrrXNmq3gIbFbH1dK+KBsP7l2Y/IbOe8qj9pT
         06OYlVmqSTTiMJPGjYzNpQHX+HXS999aNHsNPWctcc8G+W4lPz0/syQn3jmv2E9S2qli
         p7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H80n0JVjSD4pzYcESRVssj/QPi/ROGqXIm0S+YWO+9Q=;
        b=ekAIveudGQNEM70sV5QzAtA61WX3hCHD10mdHzjHcieXdBHHM/X8RlroE9BNWV3BQq
         hw9+AA6RlvYMDV1W1yIwJYt3gCC+1HXw9zpHP6A1PDJ8TQZxgud5VkBO2QvFHLP635cP
         r/JCbN8FzYcyTmoqKcC1+H5qR8ocOwcQg5qpCRHbAZzCe0mzosUEXdooQAuc7sOjaybn
         GLTxXf5gFq688Y+i0bgBXiozBaubQ9eLlTSgcPtx5J12r+cIxrtrHH8vc2yb7W1ATBjR
         PfXIUY+AjBGqm4qK0bhIsK/0CkNwu7oABt46ORsbELoVOvq3Ogl32De3EegBeO59HvbR
         hSrA==
X-Gm-Message-State: AA+aEWZyC9jgZ8gv8d5yJRUEok7jN+LKB1k0ts0V8fNR8jvop2AjO7sG
        M7xZ/iUiw4ohN193Yj8sMil+nw==
X-Google-Smtp-Source: AFSGD/XUWDi05cfTsZzbBBnjz/kueLYRUkH5LLG9YGX+ooJPHsD9EAUKdvdhJLQ8sMzqztD02R4awA==
X-Received: by 2002:a24:aa04:: with SMTP id b4-v6mr8320340itf.127.1542640660735;
        Mon, 19 Nov 2018 07:17:40 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z1sm3255618iog.57.2018.11.19.07.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:17:39 -0800 (PST)
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
To:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
 <20181119085815.GB29626@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fbd6800f-e3c2-a8cd-7f20-fb448a8b71d1@kernel.dk>
Date:   Mon, 19 Nov 2018 08:17:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119085815.GB29626@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 1:58 AM, Christoph Hellwig wrote:
>> index 5d83a162d03b..c1d5e4e36125 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
>>  
>>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>>  {
>> +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
>> +		return;
>>  	trace_scsi_dispatch_cmd_done(cmd);
>> -	blk_mq_complete_request(cmd->request);
>> +	if (unlikely(!blk_mq_complete_request(cmd->request)))
>> +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
>>  }
> 
> This looks a little odd to me.  If we didn't complete the command
> someone else did.  Why would we clear the bit in this case?

It's strictly for the fake timeout, it didn't complete it, it just
ignored it. This is an artifact of the weird way that works.


-- 
Jens Axboe

