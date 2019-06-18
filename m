Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCACC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7572D2085A
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfFRP2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:28:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfFRP2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 11:28:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3236389pgj.7
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 08:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVbXG/QSn5LE6BCqRkJMT0aMHbmHeDO2PuDhSJtzl9A=;
        b=JxQUcxhMj/a5ceFySNJIOMfZCK9XzNUBOlS1Zazu4SABZM/BmtUSQfVsfV6y29fF5p
         1HPIFb1vD+dFB06gjqvozSyGmMlsuHCIQ4zxotGy1lBJfKcIY6zi7jAERo8kYkWVZJ03
         MRvhJYHSAXiQD54FsRlhFBDZVbZxylH4bQwKM8UGZmY2iIP4rxTaEQ5bDCB0fTbxKy0F
         Owo7YnY7CJBQPsh04UlmAHmcsUkSwpFrWIx/7HIEIMRdOiqfUN4y47g7zpoENdH0g/oB
         qtyiBgd+OyM7VyiDInv7Ixf89V1LsAEa3fxZIVIZlnU4Z6w4qkH8KoWs5SaNOKpTI82i
         s02w==
X-Gm-Message-State: APjAAAXf7k2yFFUQAKgP+IKUHv0jEGN5Xyd2dCbqQlTckjIJubv2yhTj
        e8bKhk5s+oxlDTnpTX+Tcg0=
X-Google-Smtp-Source: APXvYqwK9pYKWdIV/cy+Fi/ERGiQAKvS5AwO3okJgbXUB/48McS8KcTHbX/Rnr8lCmHXN4cuF1LUzw==
X-Received: by 2002:a63:161b:: with SMTP id w27mr3184923pgl.338.1560871712112;
        Tue, 18 Jun 2019 08:28:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 133sm19128477pfa.92.2019.06.18.08.28.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:28:31 -0700 (PDT)
Subject: Re: [PATCH V3 3/6] block: use blk_op_str() in blk-mq-debugfs.c
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-4-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9a254a22-8669-1ac4-87ba-71e9a64ad5c0@acm.org>
Date:   Tue, 18 Jun 2019 08:28:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618054224.25985-4-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:
> +	if (strcmp(op_str, "UNKNOWN") == 0)
>   		seq_printf(m, "%d", op);
> +	else
> +		seq_printf(m, "%s", op_str);

My opinion about using strcmp() to check whether or not 
req_opf-to-string conversion succeeded is that this is ugly ...

Bart.
