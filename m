Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E09C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC0220868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a5/TS7rF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC0220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLFPWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:22:23 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40637 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFPWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:22:22 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so1973247ita.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIcNE0qExtQ7XdOd9lxbE8Pm9ZafrOGEfrkAmfXOOSQ=;
        b=a5/TS7rFWB/BXzyHu6XBKlE7o4Rj+cSA7gRV3F+wBzhdnecNBjjQ6S791NNCxDzs/W
         uA+peGx6+D29VCtwDE/1mqwDUiK3W4kohdh5hjDDwdejqnH/K5BcBA82c6vk+Q97yWZa
         Fz9N17HTlJYFQ44qSeot2E27nyQvy8Br6LLtu+vhj8ixC7MSYEwDI+0eXxDhYU+X1vJr
         l8zjHijqNljrI3/Zaej66r9lbof3XBBVY+d2DV8v6r2qHTDfV5M7xjfMxehyJlTLilLu
         TgkW7wceUvscPSJeK/veSWOfxuhd8SxhXCTOKquYKCTfK7lVQAep+0mtELN3KRJLBPDE
         uwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIcNE0qExtQ7XdOd9lxbE8Pm9ZafrOGEfrkAmfXOOSQ=;
        b=k1FVoFW1gwv+MQJaNuyU2W2J5PlZM20l4l2nhHmhxKf+TCT0XkPs1XWzJoCSSeL8a+
         XkSQ8cFqYCl7RsVYqfeVcY04HZnk7y27dzQnec8PwlXS6AfFaQ8MXNbdnrW8RDZJjK09
         xKxvpVWARArIFeiHTVgfBHW6k0r48Ssy+IpXyuqQQXfjViPYDgjnR9vkiJ+Nhd+Pld7V
         fDpe7mRwJVR27DyKC4ZAa+zfPgmbLuSS2SK8NGrBwu+Tb2b/zxc6qmw0UtLWQUAKGsTn
         t0kvifrJlCpNuXCtcbrWkIdicwQa9ukIpCSxZ1XxmcnHqxb8QA8IYsCfBlZnoxu5N1IG
         oOsg==
X-Gm-Message-State: AA+aEWYHbxlomg7HW6POSR4vNYw0vP4/9MRt8AWApgZDwgtMOvAXrGzM
        8zXpLZxyEIhy36Gm6zPcuS6MCA==
X-Google-Smtp-Source: AFSGD/UAC3s+ssKun+IvKkHjkvfU+IyNa6u8cW9BeCN9HyDSGoBmN/TNG9b6IqV8ObyiiZLjiz6V5A==
X-Received: by 2002:a24:9005:: with SMTP id x5mr18420978itd.102.1544109741218;
        Thu, 06 Dec 2018 07:22:21 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i78sm523834itb.6.2018.12.06.07.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:22:20 -0800 (PST)
Subject: Re: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in
 blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <1543943674.185366.194.camel@acm.org>
 <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
 <20181206003323.GB3015@ming.t460p>
 <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7a44ebf-8996-aee3-3aaf-2ca18622d161@kernel.dk>
Date:   Thu, 6 Dec 2018 08:22:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9e57309d7f40c35c1096b6f932c02f68@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 10:45 PM, Kashyap Desai wrote:
>>
>> If the 'tag' passed to scsi_host_find_tag() is valid, I think there
>> shouldn't have such issue.
>>
>> If you want to find outstanding IOs, maybe you can try
>> blk_mq_queue_tag_busy_iter()
>> or blk_mq_tagset_busy_iter(), because you may not know if the passed
> 'tag'
>> to
>> scsi_host_find_tag() is valid or not.
> 
> We tried quick change in mpt3sas driver using blk_mq_tagset_busy_iter and
> it returns/callback for valid requests (no stale entries are returned).
> Expected.
> Above two APIs are only for blk-mq.  What about non-mq case ? Driver
> should use scsi_host_find_tag for non-mq and blk_mq_tagset_busy_iter for
> blk-mq case ?
> I don't see that will be good interface. Also, blk_mq_tagset_busy_iter API
> does not provide control if driver wants to quit in-between or do some
> retry logic etc.
> 
> Why can't we add single API which provides the correct output.

From 4.21 and forward, there will only be blk/scsi-mq. This is exactly
the problem with having to maintain two stacks, it's a huge pain.

-- 
Jens Axboe

