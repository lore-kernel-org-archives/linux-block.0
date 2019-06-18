Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BCCC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6472085A
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 15:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfFRP0v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:26:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36239 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfFRP0u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 11:26:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so4887113plt.3
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 08:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PioQj1fkubygKIAJeTnw28JSAXBFxh3SheFIVr9X/LU=;
        b=PNxHKRmdGsps0D4eQ/yPx79ovx06ZRYPv48YZyHU/rx7ZrI6D9ORsElBkFZx/li/U2
         ntSxbOM8pov5+E+IILL4O7TfWNTLV4MvJQekWoFNwsRiMx4ZkaMZ90drMyhvnOcADak1
         cv+FLzqgY7qHnF9zo1jM3e7y2KLps61jT7jnZdL8Lpz2sXiDnTA7PmCRyg/K6E7GyPYu
         tRiNIWl2YWarh2BDXSMtu3dsl/lc6PCZrgYpL5ieIGcLLOBaMOJQo3hX5Ui2XJ7MXWxQ
         wD3zDSnde8CTVvdLqkuILV0biFALIp9py6wKIS2MYple5qqcL444PSHUQ3X9wZhEH2oZ
         KxjA==
X-Gm-Message-State: APjAAAX/Lc+V8fjKjkHikSjL0zIb8isv0sWrxmxGIsEUNVHbyaCqLoel
        IBwLRqgWvc323pDTVmE1jAg=
X-Google-Smtp-Source: APXvYqyS6ljFYIhMS12e2jqupJ28owHg6fmu9gcwQOKIQsaeZ0Bjh+deGVyDZyTMnsw8eDVTWaqBrw==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr4768069plb.329.1560871609713;
        Tue, 18 Jun 2019 08:26:49 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t7sm2683420pjq.20.2019.06.18.08.26.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:26:48 -0700 (PDT)
Subject: Re: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <97487a45-0a53-970a-8237-86eebfbe7ad9@acm.org>
Date:   Tue, 18 Jun 2019 08:26:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:
> +inline const char *blk_op_str(int op)
> +{
> +	const char *op_str = "UNKNOWN";
> +
> +	if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])
> +		op_str = blk_op_name[op];
> +
> +	return op_str;
> +}

This won't work correctly if op < 0. If you have another look at the 
block layer debugfs code you will see that 'op' is has an unsigned type 
in that code. Please either change the type of 'op' from 'int' to 
'unsigned int' or change 'op < ARRAY_SIZE(blk_op_name)' into 
'(unsigned)op < ARRAY_SIZE(blk_op_name)'.

Thanks,

Bart.
