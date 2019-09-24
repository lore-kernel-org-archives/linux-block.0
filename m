Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA24C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 18:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9F8214DA
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436907AbfIXShM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:37:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35247 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392031AbfIXShM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 14:37:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id y10so1357818plp.2
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 11:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAY+ds3dfWxeV13mdIh2AuaWwKXNhUyuoas49om+Ry4=;
        b=Zm5O0w8HvMj58USiCbYkZ4EGR6gVDFeAqHLJtOYA6zDHqUSO11oaBFFecHJcy3bsl4
         9ovmx8k/pCW8XKmQ57VkVdbxx5VlHbZS7tJKL49enCwj1Hv6HiNH1hVoqY24YIeAwydR
         yTYtJOUGkfw48/47bWt5szEb6przuuJcIK1rA6WUFUHUP7gtzdJqH7t/BSjJT+KKe1UR
         g/zxNomRRtQsgNWPmpYZOHRLncW7A55FcsSHbJCdXvcUrzuScgBPgmsy5fwTN5gi90fl
         3HY1PhEFXBD+x/CGsS/bymdPz4eDFTudmiOxm07RCwK9IxE59L0ejYD0UFy8RqZKdUqH
         Cafg==
X-Gm-Message-State: APjAAAVUWGCZiSp5veK1yW/4SwO+WHMRkEB3OaX3kp1WMzs1AARIK4gh
        T6tw/W4RNfmXCR54V0MAEV8=
X-Google-Smtp-Source: APXvYqy2c63gIoavr2qejQCIepmuwWHTodOzwsXejI6gY1X/NFi6TmR9SGYwmVlk8Ny9pr4K7T4s3w==
X-Received: by 2002:a17:902:a985:: with SMTP id bh5mr4439387plb.107.1569350231501;
        Tue, 24 Sep 2019 11:37:11 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j16sm2480089pgi.64.2019.09.24.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 11:37:10 -0700 (PDT)
Subject: Re: [PATCH] block: don't release queue's sysfs lock during switching
 elevator
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190923151209.7466-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bc5864cd-a62b-d6d5-2d69-6ec03983508b@acm.org>
Date:   Tue, 24 Sep 2019 11:37:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923151209.7466-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/19 8:12 AM, Ming Lei wrote:
> @@ -523,11 +521,9 @@ void elv_unregister_queue(struct request_queue *q)
>   		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>   		kobject_del(&e->kobj);
>   
> -		mutex_lock(&q->sysfs_lock);
>   		e->registered = 0;
>   		/* Re-enable throttling in case elevator disabled it */
>   		wbt_enable_default(q);
> -		mutex_unlock(&q->sysfs_lock);
>   	}
>   }

Does this patch cause sysfs_lock to be held around 
kobject_del(&e->kobj)? Since sysfs_lock is locked from inside 
elv_attr_show() and elv_attr_store(), does this mean that this patch 
reintroduces the lock inversion problem that was fixed recently?

Thanks,

Bart.
