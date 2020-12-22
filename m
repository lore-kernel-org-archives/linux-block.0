Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C21C433E0
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F4E22B3B
	for <linux-block@archiver.kernel.org>; Tue, 22 Dec 2020 02:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLVCNp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Dec 2020 21:13:45 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33690 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLVCNp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Dec 2020 21:13:45 -0500
Received: by mail-pf1-f171.google.com with SMTP id h186so7587398pfe.0;
        Mon, 21 Dec 2020 18:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktaJOPLdx7KbKAhrChNKMTdd4WLo3ab5PljsYO04KSI=;
        b=BYj6N2nAv+6lr9rwwVTzgJzwiORvQcz6Lmuh9doG84ZFcdQnBPpR8W0F2qUVVcwJmR
         1jYyFymX+RBmnrjV4o6ZrisZeMvtqWrH7jwcJIEZugemn/6xF/FOtapW4z0cRH07LtBY
         r0YXNlZ5IeJSVsNMOkiCaDrpgqyCHQcvx2G5t8ALEbZgfjFZ65ccjkrDmBwLW3PkM3in
         hn/BjPpiozU6SHESijkGWgc1QkDdltPk6d21j6WBz/fdQcNzJoLg6vu04YxZYDmDMv+H
         lcBw8Ihjv0pzkTVTheEgF7LlegsEzeFzfFyeBB9m5MYJZGvxg4g9V8UosgDQ4FF2RvKh
         RfIA==
X-Gm-Message-State: AOAM532czLAueoIadzwnbhoS5TNkh4OzDc0BVStFJehJKpKOAOGP6NbD
        Ohg1VLiJeJgF6y2PUx9BWs0=
X-Google-Smtp-Source: ABdhPJzBQHc7rK8XtJVOGQB8AnH4ayiDz325B/0erk8X4jzjqNKhiQh/+khT3EpYMrI/3yX9hzK9vw==
X-Received: by 2002:a63:1401:: with SMTP id u1mr6048718pgl.229.1608603184210;
        Mon, 21 Dec 2020 18:13:04 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b12sm17620492pft.114.2020.12.21.18.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 18:13:02 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, ppvk@codeaurora.org,
        kashyap.desai@broadcom.com, linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
Date:   Mon, 21 Dec 2020 18:13:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/21/20 10:47 AM, John Garry wrote:
> Yes, I agree, and I'm not sure what I wrote to give that impression.
> 
> About "root partition", above, I'm just saying that / is mounted on a
> sda partition:
> 
> root@ubuntu:/home/john# mount | grep sda
> /dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro,stripe=32)
> /dev/sda1 on /boot/efi type vfat
> (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

Hi John,

Thanks for the clarification. I want to take back my suggestion about
adding rcu_read_lock() / rcu_read_unlock() in blk_mq_tagset_busy_iter()
since it is not allowed to sleep inside an RCU read-side critical
section, since blk_mq_tagset_busy_iter() is used in request timeout
handling and since there may be blk_mq_ops.timeout implementations that
sleep.

Ming's suggestion to serialize blk_mq_tagset_busy_iter() and
blk_mq_free_rqs() looks interesting to me.

Thanks,

Bart.
