Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B36C433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DB26144B
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhD2QVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 12:21:14 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46825 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhD2QVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 12:21:14 -0400
Received: by mail-pf1-f169.google.com with SMTP id d124so3674356pfa.13
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 09:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=COFP3FkG7wCZ9Q7qjD+oYcbCyfgxSbMKoarlA1biSQg=;
        b=B3v/Bzfdr+++C9J0gyAuboyRmx9JVkVfuiDbgjm+HE8743Ug2+YBeWVs1oKjBvnWiT
         CzEzgPAF/ywBlr0ugG+XEk74cDv8mH9fMkSNsx8M9YGiReGG6s5kxziANsT+QG4gQoJy
         c/Xd4hDsaH/lxli3On1+mEvawDOlDHaLDcQwwqiFqS4I2yz+zs9bkMFET1HKQ8qCcpld
         B2RztpLQ9qYeseU9xzx4MimCDqDHWs7Hb2ZLYoaOgTQIcgAoAem44Q2+DnuANhu3gxSb
         oSV3izaGrZMbK6wZTqDpZlTkTgIAOlx3boy2cIaPzESr7wxHXRe/3/r9mmPUZ5c8lpOQ
         IZDw==
X-Gm-Message-State: AOAM530XLUOUBCxBqvxg4RCp79y1xEI3KdnWQJ2AnjN863zKAbn8WS1L
        mWAmaQul1xjOhedkezAHGzXOEG7T+5YHtg==
X-Google-Smtp-Source: ABdhPJyp4eINbI2edHrZic2B2jw1Ivn+vMkb0GULEekk+q9VxPLPXTHNr6KNtEMdotd0IijKcW4spw==
X-Received: by 2002:aa7:9f5d:0:b029:265:e8b5:ecd0 with SMTP id h29-20020aa79f5d0000b0290265e8b5ecd0mr463836pfr.26.1619713227106;
        Thu, 29 Apr 2021 09:20:27 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h20sm2828418pfh.192.2021.04.29.09.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 09:20:26 -0700 (PDT)
Subject: Re: [dm-devel] [RFC PATCH v2 1/2] scsi: convert
 scsi_result_to_blk_status() to inline
To:     mwilck@suse.com, Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210429155024.4947-1-mwilck@suse.com>
 <20210429155024.4947-2-mwilck@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <08440651-6e8f-734a-ef43-561d9c2596a6@acm.org>
Date:   Thu, 29 Apr 2021 09:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429155024.4947-2-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/21 8:50 AM, mwilck@suse.com wrote:
> This makes it possible to use scsi_result_to_blk_status() from
> code that shouldn't depend on scsi_mod (e.g. device mapper).

I think that's the wrong reason to make a function inline. Please
consider moving scsi_result_to_blk_status() into one of the block layer
source code files that already deals with SG I/O, e.g. block/scsi_ioctl.c.

> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 83f7e520be48..ba1e69d3bed9 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -311,24 +311,44 @@ static inline struct scsi_data_buffer *scsi_prot(struct scsi_cmnd *cmd)
>  #define scsi_for_each_prot_sg(cmd, sg, nseg, __i)		\
>  	for_each_sg(scsi_prot_sglist(cmd), sg, nseg, __i)
>  
> +static inline void __set_status_byte(int *result, char status)
> +{
> +	*result = (*result & 0xffffff00) | status;
> +}
> +
>  static inline void set_status_byte(struct scsi_cmnd *cmd, char status)
>  {
> -	cmd->result = (cmd->result & 0xffffff00) | status;
> +	__set_status_byte(&cmd->result, status);
> +}
> +
> +static inline void __set_msg_byte(int *result, char status)
> +{
> +	*result = (*result & 0xffff00ff) | (status << 8);
>  }
>  
>  static inline void set_msg_byte(struct scsi_cmnd *cmd, char status)
>  {
> -	cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
> +	__set_msg_byte(&cmd->result, status);
> +}
> +
> +static inline void __set_host_byte(int *result, char status)
> +{
> +	*result = (*result & 0xff00ffff) | (status << 16);
>  }
>  
>  static inline void set_host_byte(struct scsi_cmnd *cmd, char status)
>  {
> -	cmd->result = (cmd->result & 0xff00ffff) | (status << 16);
> +	__set_host_byte(&cmd->result, status);
> +}
> +
> +static inline void __set_driver_byte(int *result, char status)
> +{
> +	*result = (*result & 0x00ffffff) | (status << 24);
>  }
>  
>  static inline void set_driver_byte(struct scsi_cmnd *cmd, char status)
>  {
> -	cmd->result = (cmd->result & 0x00ffffff) | (status << 24);
> +	__set_driver_byte(&cmd->result, status);
>  }

The layout of the SCSI result won't change since it is used in multiple
UAPI data structures. I'd prefer to open-code host_byte() in
scsi_result_to_blk_status() instead of making the above changes.

Thanks,

Bart.
