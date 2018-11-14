Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74DC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 04:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DC32145D
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 04:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hMXekelz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DC32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeKNOhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:37:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46036 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNOhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 09:37:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so6748299pgc.12
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 20:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=14aqRMXHUzmh8MaY6T0TYYXxIjG0HLvTmbYMOmqP/1A=;
        b=hMXekelzsjdy/O0oUpY034KEQwUHbGV7/CscTxpDvNRVDid0cVvOCX8T2W4Y5gnCVq
         ODAqevjbiaUFrR3lOK49LZmhqk9wxh/9P7mueLUFji55X0fSgWewVLI1CirzuNz4MIpA
         tcpVa+7YdtAO2OAgE4AqYdSwW520MoKMOgmALHezSOx2yNf4X0kHed9pHa2NhYoe00Jr
         gKsCEGgclsB96hM5ZY7ybJ+ueY/Zgz6262Y4ad4gfGQFKIwMG/X7f/nKZfmXkPJSNOZN
         ehS7uaEBXyQwXRCFP3sFysEQ/AUoWxMjV7KVE1VLzM4cJM9wDAfkwKVImqLU3ij/+w1Q
         4+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14aqRMXHUzmh8MaY6T0TYYXxIjG0HLvTmbYMOmqP/1A=;
        b=KlneTiptLMfOgu6NAraQ9jrfyZXspBozivFVQSGDuJHAl2oiWhkkJVgtd7uM3Htk8T
         5F0jB+FaWoUy6KbyAJEkG8YRmAQtiwb49ra3urwx6435m/kmJg9bn+IYPxta3CTs9HK8
         YcuBVQ7Ma6hY4oyZVAKZ4bAEIF5za5FwB2PShPp+v20sduM2xX4xlCVrCGYEsSX3UYyx
         KjHHoGW2wMHF1HaQpBlMyldZgWA5aRlWIfARQiOAxONwaYBUuvfxyLnhUPquHEEd0+GF
         mNww9Iw+0isCF0dhhi5I6zfJ4ZciraAqW99Qn2g894mbZnhEsw1T7TYMapEnKjapMDbL
         4qjw==
X-Gm-Message-State: AGRZ1gLQw7T0PO+SsBZAm0DGpD4OzjUxaA67lPnrUwMwkFL0wfZeGdbC
        LpB5Ja9cbgHYABP2z887wg29FmxqeyM=
X-Google-Smtp-Source: AJdET5f8Kll/sTdxTpIyBQbdsxd09zFyuDdpn7emyYa61uZnifKqUAIycJkJ6cE6QL8uiXO02Ckf7w==
X-Received: by 2002:a62:e704:: with SMTP id s4mr168293pfh.124.1542170149241;
        Tue, 13 Nov 2018 20:35:49 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e23sm17836523pfh.68.2018.11.13.20.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:35:48 -0800 (PST)
Subject: Re: [PATCH 1/2] scsi: Do not rely on blk-mq for double completions
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20181113185712.10063-1-keith.busch@intel.com>
 <b2d9c646-3311-9f85-6e8b-de3ddf295899@kernel.dk>
 <20181113194517.GA10134@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03c3227d-7eed-2797-8589-3a57488a3171@kernel.dk>
Date:   Tue, 13 Nov 2018 21:35:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113194517.GA10134@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/13/18 12:45 PM, Keith Busch wrote:
> On Tue, Nov 13, 2018 at 12:20:46PM -0700, Jens Axboe wrote:
>> On 11/13/18 11:57 AM, Keith Busch wrote:
>>>  static void scsi_mq_done(struct scsi_cmnd *cmd)
>>>  {
>>> +	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
>>> +		return;
>>>  	trace_scsi_dispatch_cmd_done(cmd);
>>>  	blk_mq_complete_request(cmd->request);
>>> +
>>> +#ifdef CONFIG_FAIL_IO_TIMEOUT
>>> +	/*
>>> +	 * Clearing complete here serves only to allow the desired recovery to
>>> +	 * escalate on blk_rq_should_fake_timeout()'s error injection.
>>> +	 */
>>> +	clear_bit(__SCMD_COMPLETE, &cmd->flags);
>>> +#endif
>>>  }
>>
>> We could have this be:
>>
>> static void scsi_mq_done(struct scsi_cmnd *cmd)
>> {
>> 	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
>> 		return;
>>  	trace_scsi_dispatch_cmd_done(cmd);
>>
>>  	if (blk_mq_complete_request(cmd->request)) {
>> 		/*
>> 		 * Clearing complete here serves only to allow the
>> 		 * desired recovery to escalate on
>> 		 * blk_rq_should_fake_timeout()'s error injection.
>> 		 */
>> 		clear_bit(__SCMD_COMPLETE, &cmd->flags);
>> 	}
>> }
>>
>> with
>>
>> bool blk_mq_complete_request(struct request *rq)
>> {
>> 	if (unlikely(blk_should_fake_timeout(rq->q)))
>> 		return true;
>> 	__blk_mq_complete_request(rq);
>> 	return false;
>> }
>>
>> and not have this CONFIG_FAIL_IO_TIMEOUT dependency, but that'd be a bit
>> more expensive.
> 
> I was trying to avoid every cost no matter how negligable (those are the
> only types of costs left as far as I can see), but I think your proposal
> might actually be necessary: if a timeout wasn't faked, clearing the
> completion flag unconditionally might have a problem with a real timeout
> racing with the real completion. :(

Yep, I think you are right... No way around it then. Are you going to
resend it with the fix?

-- 
Jens Axboe

