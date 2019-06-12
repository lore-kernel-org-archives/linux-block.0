Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABECC31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 15:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B43020874
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 15:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFLPVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:21:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42274 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfFLPVx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 11:21:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so6751698plb.9
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 08:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W47l/KEr1lc/kexfbmWyqLDHi1zDPdGkaSeil5fBQnw=;
        b=SCt+JuqoP4X9a7/cekvlCGDsNCB1/uJvD427YKX9ePzPHHqdKX3Q6sRTzFhoZcjiVj
         o2kXbLuiXV8UOKIrPuLCrVwE66+8yXNQto7Btryk5v6rsaQZX1oCG4UrKtO9rv5+j+i9
         AeWw/cHRhvgQAfiBp2ss/Uh43JrWx4vkbpt/rAxSkn2DANMK8XNoiSkntYxqG2RdvxnM
         aKGfc/k+x6QeLcJu4qBKG23354XoygJn4fdTLYzMq6QgextM5Jgj/n0rK1KvzfUXl0oL
         lPkWuVIFwyicOG/k1eO6Fz+WH/j4Q3PuXFVLbMNv519CpoparUQpkg75wUnvG9XouLHx
         77pw==
X-Gm-Message-State: APjAAAUdPD/ElJJWosZtGSUUtQIqyTnpuvtfm1NtEuA0idk1ldGYFaJL
        IuJ4GNKRdhOSKkfHxAJJEZc=
X-Google-Smtp-Source: APXvYqww9Jo3huLQtmkA38D/bEnmam+rtHuSRG3o5rbjOQEaCBq4byEw0+3RDOlTYqL9y4L7+zkuBA==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89mr2411550pld.77.1560352912809;
        Wed, 12 Jun 2019 08:21:52 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id m13sm3645996pgv.89.2019.06.12.08.21.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:21:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: add more debug data to print_req_err
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, hare@suse.com
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
 <20190611200210.4819-3-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3ab93dfa-523a-c5e8-05fc-2c974fc8778e@acm.org>
Date:   Wed, 12 Jun 2019 08:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611200210.4819-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/19 1:02 PM, Chaitanya Kulkarni wrote:
> +static inline const char *req_op_str(struct request *req)
> +{
> +       char *ret;
> +
> +       switch (req_op(req)) {
> +       case REQ_OP_READ:
> +               ret = "read";
> +               break;
> +       case REQ_OP_WRITE:
> +               ret = "write";
> +               break;
> +       case REQ_OP_FLUSH:
> +               ret = "flush";
> +               break;
> +       case REQ_OP_DISCARD:
> +               ret = "discard";
> +               break;
> +       case REQ_OP_SECURE_ERASE:
> +               ret = "secure_erase";
> +               break;
> +       case REQ_OP_ZONE_RESET:
> +               ret = "zone_reset";
> +               break;
> +       case REQ_OP_WRITE_SAME:
> +               ret = "write_same";
> +               break;
> +       case REQ_OP_WRITE_ZEROES:
> +               ret = "write_zeroes";
> +               break;
> +       case REQ_OP_SCSI_IN:
> +               ret = "scsi_in";
> +               break;
> +       case REQ_OP_SCSI_OUT:
> +               ret = "scsi_out";
> +               break;
> +       case REQ_OP_DRV_IN:
> +               ret = "drv_in";
> +               break;
> +       case REQ_OP_DRV_OUT:
> +               ret = "drv_out";
> +               break;
> +       default:
> +               ret = "unknown";
> +       }
> +
> +       return ret;
> +}
Please use an array instead of a switch/case statement to do this 
conversion. See also blk-mq-debugfs.c for examples.

Please also make show_bio_op(op) in include/trace/events/f2fs.h call the 
above function.

Thanks,

Bart.
