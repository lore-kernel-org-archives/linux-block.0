Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77886C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA212085B
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKXDXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:23:55 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41406 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKXDXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:23:55 -0500
Received: by mail-pf1-f182.google.com with SMTP id t8so17064052pfg.8
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 19:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXkjvDpid20zr1AMjWrezgoJu7BUsnH8wicWuxP+PC0=;
        b=HBiQdb1T3DVoF6hEMv3UFOP0wo+pi5PeUgU/s4CBwkcw+fiiccIVzU/UUmvBtjjNgP
         UCPTXPTW2m0gQJR2hj7blGuPPUx324+JQjBm0P/Qg9RhHpxTzdaZljReEuu0w4q1ndnB
         pqjjIJfrS5FBy8TuaQebgwyhl02WSbrx9HrGdGgzbfKhoE9UqoG4Gq9YLB+nLdnR6ocJ
         XGb4OI1Zz8O4yNXHLttOFvPDuXim+WT9CKWjcWIkmVqXas+MZ8G7c+ezFqHID/P/PId8
         8q8HGehiN4LGed6HdRBYTJowkB7v6qrMEnF5ByxnM3XJIQbIHz5i8dZ2VJMHoPPP1V1X
         Gxrg==
X-Gm-Message-State: AOAM532GFLtmn/ncK55s6056Til+fH5yBkAa2iDVx4Ui9lmh31JVTQKv
        yNRTsS6iQ5JJ6r7KXgtuX2M=
X-Google-Smtp-Source: ABdhPJxzf0jknZnzjNudUmEEQiSvjT+xGaYIFP0Nmrj75T6klNXYVWji/TSaYPIgQmjKcgNuyv2TNg==
X-Received: by 2002:a63:4623:: with SMTP id t35mr2075311pga.270.1606188234495;
        Mon, 23 Nov 2020 19:23:54 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h7sm13290845pgi.90.2020.11.23.19.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:23:53 -0800 (PST)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
Date:   Mon, 23 Nov 2020 19:23:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-2-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> -	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
> +	insmod "$(ls /lib/modules/"$(uname -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" || return $?

Is 'ls' needed here or is 'echo' sufficient?

Thanks,

Bart.
