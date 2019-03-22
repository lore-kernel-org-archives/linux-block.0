Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8012EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9442190A
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0cT8dR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCVQVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:21:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33562 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCVQVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 12:21:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id v14so1880327lfi.0
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/QaJioJPH1D1AsosdJ0jjFgPDgmVkmWIuGoUhzENwi8=;
        b=J0cT8dR1vuMLqVOmeJ2VNJFwUW5ixHoRLekaJCgd9esvGhRPQdcinq+kqaNvU9o+XW
         AzqXPcA6n6KiFJoBb3nC4JtcUHe4rZy0SoswvStoFJIXwPXiwCKIjAL0Y6+IfyfBT8Cy
         yPYXUpHgO4W7qMSc723y7z7vDATIggKlCcnn+Y1jhIKk50WF4RTSuIgyt059s/SxDgfx
         QpHlIsHQNfoP1FBnmRr195m1IecduyChaMqwZCxN0JGoTYtOqM4cAAO0gYNEnnPT975I
         cEHWDzS40vANYOYirz4xvTn69uc4WgKu9GvndQJEvIUUcueyqlHa+sBRRahDmSrfX5OD
         NdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/QaJioJPH1D1AsosdJ0jjFgPDgmVkmWIuGoUhzENwi8=;
        b=Erf0y+NCUtDxxLEFvEf49W1fqcwAU9tfpiZqa8UPvNCvAmE9zrZi8al3MFqiQXCSNo
         IskMtNJKjCdoGyuZIJV6IAwtgEPmCVk/uberKNfrzocyy4SaC64ldRPMD5uI6IP92bY6
         WyLb0vcbJOBKRbVdHjqNChlSiso98zQJQbhWwtc6ZHSHJBJQ2Ox+FguRjZTF/Qz/Z4RA
         TtJWOXWRdHBqMFoomL8NwZ8HLLCtUUZS1D4KfZiQFSbOt4aFAMNPv/wACp0VwQg09Zk+
         4FW3dRDtSDs8yxcOlKWZtSTqF2y0EPbZTt65iU0V9uZeZyyhwJXAg05MhJIg7C+e7BmO
         1/cw==
X-Gm-Message-State: APjAAAWcyQhvuowLi8Ae+IaA9dYQqSjW+V6NXYvf7X7XgTnp8uugxr5B
        rZMqtfLnf9LJIoiaKlBgOX8eXefW
X-Google-Smtp-Source: APXvYqyF1KHVWDabRApldnkdRT61YZS5xAlbgZ/UPYJZqoQv4XkeTlhQgm4IAMzOGLz4d+bV3Rp7sw==
X-Received: by 2002:ac2:5638:: with SMTP id b24mr5893961lff.18.1553271712910;
        Fri, 22 Mar 2019 09:21:52 -0700 (PDT)
Received: from [192.168.0.160] (ppp89-110-13-118.pppoe.avangarddsl.ru. [89.110.13.118])
        by smtp.gmail.com with ESMTPSA id q2sm1768695lfj.58.2019.03.22.09.21.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:21:52 -0700 (PDT)
Subject: Re: Read data to kernel buffer by blkdev_read_iter
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
 <98dec559-60bf-2463-7b0b-0cc2dd57db7d@acm.org>
 <1a5a1b81-49c0-2817-73d9-d58716c44b0a@gmail.com>
 <1553269013.65329.147.camel@acm.org>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <40b7870e-9fc4-0cdc-00f8-e9259bcadb8f@gmail.com>
Date:   Fri, 22 Mar 2019 19:24:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1553269013.65329.147.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 6:36 PM, Bart Van Assche wrote:
> On Fri, 2019-03-22 at 17:57 +0300, Ivan Safonov wrote:
>> In the previous message I misled you: iov_iter has ITER_KVEC type only
>> if set_fs(get_ds()) present before iov_iter_init(). In this case
>> _without_ IOCB_DIRECT blkdev_read_iter() work fine. With IOCB_DIRECT
>> blkdev_read_iter() return -EFAULT.
> 
> Have you tried to store a physical address in iov_base instead of a virtual
> address?
I tried: already -EFAULT.

vm_area_struct description says: ranges consist of virtual addresses:
/*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */

So, the physical addresses could not solve this problem.

I think there should be no memory checks for the kernel allocated 
memory, or the blkdev_read_iter() is not available to work with 
vmalloc'ed memory at all.

--
Ivan Safonov.
