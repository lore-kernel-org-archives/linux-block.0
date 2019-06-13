Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD71C31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AD92054F
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfFMPRh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:17:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34987 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfFMPRh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 11:17:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so12053337pfd.2
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 08:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BkazCgibnfJRrHJLk1Kh1WQeyQ1tIOgDWROfBotni2c=;
        b=YFTWNhh3emtNjXCITAQ9Ogp7VkRTOgysXWi9Kr/5+kg0iLO3tgJxur14N8rKgh54ye
         tB77mo667NNXFiloWiaZ+jodLpV+Na/FZOmDjjTfvpAR/2d2qv8kGActbLPL/wEf5Foi
         Rci5yMJoyu9LkMwoSRtGEsBTHRdV9Y2O/DFr137W0m/LBVsQS1O6DZsW/0UVtPo5lgzQ
         VrEtVrmXXkUtMiEtsdAN1cUOKH0HbSwIwJrK0MHzYmk7Y2H2p7FQ1i2AzjvST4SQ4f02
         S0ryGOv6BzrCzOye6Sd9AcHVZ+pXRHjSHSI4OdYHTsRAjYxEivP5z+qRECpuupsNQG3N
         NPQg==
X-Gm-Message-State: APjAAAUW/gTbbjxhG+SBBhagBF/hzcULKZx5ehWIBxLxmz0/hvjLgAf3
        CUJFgNT8I0i8tghIG+F125k=
X-Google-Smtp-Source: APXvYqz6mVXyl46teMVmAoKi5xUmOIadmjpF51Wa+rpEyQbCQg6AQgz2ikdgWz70WEpnAh6pBrtFzg==
X-Received: by 2002:a63:ed06:: with SMTP id d6mr28801120pgi.267.1560439056586;
        Thu, 13 Jun 2019 08:17:36 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w197sm38747pfd.41.2019.06.13.08.17.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:17:35 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] block: add more debug data to print_req_err
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
 <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d369fbbd-0d98-b804-619b-23049ee12398@acm.org>
Date:   Thu, 13 Jun 2019 08:17:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 7:16 AM, Chaitanya Kulkarni wrote:
> +#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
> +static const char *const op_name[] = {
> +	REQ_OP_NAME(READ),
> +	REQ_OP_NAME(WRITE),
> +	REQ_OP_NAME(FLUSH),
> +	REQ_OP_NAME(DISCARD),
> +	REQ_OP_NAME(SECURE_ERASE),
> +	REQ_OP_NAME(ZONE_RESET),
> +	REQ_OP_NAME(WRITE_SAME),
> +	REQ_OP_NAME(WRITE_ZEROES),
> +	REQ_OP_NAME(SCSI_IN),
> +	REQ_OP_NAME(SCSI_OUT),
> +	REQ_OP_NAME(DRV_IN),
> +	REQ_OP_NAME(DRV_OUT),
> +};
> +
> +static inline const char *op_str(int op)
> +{
> +	const char *op_str = "REQ_OP_UNKNOWN";
> +
> +	if (op < ARRAY_SIZE(op_name) && op_name[op])
> +		op_str = op_name[op];
> +
> +	return op_str;
> +}

If this patch gets applied there will be three copies in the upstream 
code that convert a REQ_OP_* constant into a string: one in blk-core.c, 
one in blk-mq-debugfs.c and one in include/trace/events/f2fs.h. Is it 
possible to avoid that duplication and have only one function that does 
the number-to-string conversion?

Bart.
