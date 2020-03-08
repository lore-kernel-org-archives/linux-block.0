Return-Path: <SRS0=O/R4=4Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F6CC10DCE
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 16:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B08206D5
	for <linux-block@archiver.kernel.org>; Sun,  8 Mar 2020 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QoHwCUSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgCHQRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:17:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36277 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHQRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Mar 2020 12:17:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id d9so3583674pgu.3
        for <linux-block@vger.kernel.org>; Sun, 08 Mar 2020 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WCkD2GCSn4fdPzhz3uAykC3W9XDlvidafgBD2tiPQpo=;
        b=QoHwCUSv4rJBDXa2itzwaIu3wRYYX2GUVK9uHnslsV1YKP3XSaRMv0NfUG+PeE9K3p
         oHkz2NCH1gKTgAsB/GuazLIDUe6Pb5QHVZ2oB+85KOUN38qVhhFNKmfsQ8d1bjkfOsrW
         ougpE2ICCbm9Y/DSIyrsC0GbhTaMijJ/HVD5wDghADsvU+rtv9AcX/4k/O11IQ0MgMez
         35Ip3dALn2vmKIuV5cemUp9K5V9nsZAoDbeirJFT9kl9f9KEwzcI3VJ5TVh+2P3AJDre
         UCnUDluEjITs1dLsFhlic/Qpvj0SkPbBiKleJZwQe3VkIYvKrB30MuA+StsLrtm7UAX+
         o40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WCkD2GCSn4fdPzhz3uAykC3W9XDlvidafgBD2tiPQpo=;
        b=ePNX1P7fJwBAiiyNjcDS5Sq3Gpxo4ke4u6d6knXWcpQCRtTO+1ofHbiQBbVsFsqzy5
         1uLRXqnRMq+V+NWvz5jtH+XdlZ/FQb0MDC0/BiZpbw65LROZQCX7N0QvcAv0aBaQvahc
         6NBkdzr6IOANNrJUpnRDeU03wweuvVaJcakpBmwM20b+hEAogYx5MoS4sPDobAyUY/Cc
         6n/T8LoHGyoPei4t22MW+Szr4E0x5+EB1umdIQuPXOWNAGjwT+JjuUSQMo6FrABzcbeb
         SzO1Di2SD5aWetDRvkNNd9GIw55tiEKzAcX6G7pOC4u+pKfloycZmAENMST5/5IEp2q6
         1yVg==
X-Gm-Message-State: ANhLgQ37HqtBk5pYTXgbEIJ8JFAsoqC6othrbr5fk2LniU6Br639mYfs
        mDNkQtErdYuV9dFz5E64ZVn8Dw==
X-Google-Smtp-Source: ADFU+vvD6ZfzpxybygFl/1F6qmMKjdEn6yiOT7FGJmbzufWw8rlwU4yrKqONxYhhpX9EHIaEqdqWmw==
X-Received: by 2002:a62:c543:: with SMTP id j64mr12936023pfg.129.1583684255347;
        Sun, 08 Mar 2020 09:17:35 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id b10sm15542888pjo.32.2020.03.08.09.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 09:17:34 -0700 (PDT)
Subject: Re: general protection fault in __queue_work (2)
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        schatzberg.dan@gmail.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
References: <20200308094448.15320-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <407fcb3f-4380-e965-d19c-e57990711d3e@kernel.dk>
Date:   Sun, 8 Mar 2020 10:17:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200308094448.15320-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/20 3:44 AM, Hillf Danton wrote:
> @@ -1208,8 +1211,16 @@ static int __loop_clr_fd(struct loop_dev
>  	 *
>  	 * 3) unlock, del_timer_sync so if timer raced it will be a no-op
>  	 */
> -	loop_unprepare_queue(lo);
>  	spin_lock_irq(&lo->lo_lock);
> +	do {
> +		struct workqueue_struct *wq = lo->workqueue;
> +
> +		lo->workqueue = ERR_PTR(-EINVAL);
> +		spin_unlock_irq(&lo->lo_lock);
> +		destroy_workqueue(wq);
> +		spin_lock_irq(&lo->lo_lock);
> +	} while (0);

This looks highly suspicious, what's the point of this loop?

Also think this series a) might not be fully cooked, and b) really
should have gone through the block tree.

-- 
Jens Axboe

