Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD47C07E99
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 01:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEAA608FE
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 01:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGFBD5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 21:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhGFBD4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 21:03:56 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D44C061574;
        Mon,  5 Jul 2021 18:01:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v7so19863960pgl.2;
        Mon, 05 Jul 2021 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W2+AYYofJ+i/1cuwRg61KlRr9Zka6oqIudL2SUcZpBE=;
        b=No6NE/548bzly3HYgmlVYu9tCB7/LM6hGfO04rBB75EJ15NDkWjcKzRbInlqQvei1D
         VteBFJEIPqCH7k5z+KEgf3JNATEuHqKJedwM3wtt6O7xUiqWHMqwEWdFgh6Xz75AWeNP
         9CsVoT/sP5Wy76VKaFOOYJclrJLX/mBJp77wVna/ar2W9ohxVO2GoUdHmwSkWRm2hCv6
         JVmSVhVx+z7+AG31it+rGbolw4tSE9bAK2UYtrIOHZtJ1vFYSVXrMLcyxJmuQe1E3otq
         37JlO6ggRL/+CilEFkSHD7lTGiR7sot2h2liHZ3/8j07gt1ML6J3Tayh1KXz1PZegGmI
         aw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W2+AYYofJ+i/1cuwRg61KlRr9Zka6oqIudL2SUcZpBE=;
        b=ZnSJQ6BkwVdilaY12t2u1yaHOkvj8syFbdRiQDYDI80zAGIKTMjvzx9CjpxPR0qw8E
         F3AYafcMhQYt8FkfLSSXjLtQseuFawQoDzrveDAXRuQN3Z96Ah0dTNbrMAiENl2zbdsZ
         ow93S4y3MWJBVtu1OosnrYzYWNay1j3yiyuo/qHOuW8PgCqPYqwbzRMF9On51Hanq9mI
         YOoutMfdmuN68+EHXDABTO17q3ZCo4vPMKKaKScQwRHtHvdxQDksZ0h2Iv99NAVRy49B
         Ea28sGiRiydErdMPhk8sGiEikO12VueNcxP1U53JucLwItDbiq0TYV990IS9OwIB+6j/
         0euw==
X-Gm-Message-State: AOAM530LeVzPNE6sdmX0f8/laPg1rDZyd8/VPysI7pv0qInKRnz9G1/Q
        giNa4GwLB6RMLmhXU+HxQL8=
X-Google-Smtp-Source: ABdhPJyakDnYiSU123gmIaGGm2KFblaAwv8xMnHUd2dRdan+8hvomba5FWnMECWaEJ3UPdHxAZoZxA==
X-Received: by 2002:a62:34c7:0:b029:28e:addf:f17a with SMTP id b190-20020a6234c70000b029028eaddff17amr17864664pfa.62.1625533278750;
        Mon, 05 Jul 2021 18:01:18 -0700 (PDT)
Received: from [192.168.1.18] ([122.163.155.135])
        by smtp.gmail.com with ESMTPSA id g12sm664919pjk.25.2021.07.05.18.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 18:01:18 -0700 (PDT)
Subject: Re: [PATCH] block: Avoid accessing an already freed kobject in
 delete_partition
To:     Christoph Hellwig <hch@infradead.org>,
        Rajat Asthana <rajatasthana4@gmail.com>
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com, jack@suse.cz,
        rafael@kernel.org,
        syzbot+7d6c5587ec9cff5be65c@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, hare@suse.de,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210702231228.261460-1-rajatasthana4@gmail.com>
 <YN/1DOeSA5ODf1AV@infradead.org>
From:   Rajat Asthana <thisisrast7@gmail.com>
Message-ID: <0c623d71-6d99-2e0d-4d8b-63a1ff814dc1@gmail.com>
Date:   Tue, 6 Jul 2021 06:31:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YN/1DOeSA5ODf1AV@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/07/21 10:56 am, Christoph Hellwig wrote:
> This should be fixed properly by:
> 
> "block: check disk exist before trying to add partition"

Hi Christoph, thanks a lot for suggesting this fix. I have been
working on implementing this and have tried the following:
- I checked if the the kobject of device structure embedded in
   gendisk structure is not NULL, to add the partition.
   This didn't work.

- Then I checked the if kobject of the block_device struct (part0)
   embedded in the gendisk struct is not NULL, to add the partition.
   This also didn't work.

- Then I checked the i_state of the bd_inode field of block_device
   struct embedded in the gendisk struct. I checked if the I_FREEING or
   I_WILL_FREE fields are not set. The reason behind doing this was
   to confirm that we only create partition on the disks which are not
   being freed.

Am I going in the right direction? Can you point me to the correct
direction if I am not?

thanks
-- Rajat
