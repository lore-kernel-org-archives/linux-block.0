Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBBC10DCE
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 02:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3030A2067C
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 02:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K9clpEC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCICRG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:17:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41917 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgCICRG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Mar 2020 22:17:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so4104153pfz.8
        for <linux-block@vger.kernel.org>; Sun, 08 Mar 2020 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sah9gLZTqUqU0I81LxravMIHbnOhX63QQcmQKAkQUow=;
        b=K9clpEC4mqCP5m3LggsyttZ5WLsNeKIvPLMMUCLdxJZB+8pDr5uWeG3j6p2+ShXZZY
         lU45Nx0lqjLQePc8KH+C4xw7Hg59WYZnDVhmi2GwfH9+4zIRXAWeQ/wzzhDxJLR8zaRu
         fH3/z0wchAbfhXgEmkf4AipB/eJ2quqZ7qJmh18STmzHcLjhBaQlRxqL1TAVAkPH2/Sa
         g+CRXoP3ARKEOj/slFdjrSMQgJANqhs7AAJ8gAtKK0JSUUZlc2ajd/bUs8i7CZmzl5VL
         q+vtjr+ELeDmqlFq+rw5jaDEzDJxMkYAWpElVNV9CJMWqZ127Mtdw9QcdaqghrmxXpDp
         5cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sah9gLZTqUqU0I81LxravMIHbnOhX63QQcmQKAkQUow=;
        b=gdWwk3HRgPbqRr3Lr4cDUFAXko8bTR7v3hkV1/Mr+QrS7FfxBVjrAkZOCtZKoPwHFH
         goKTma6fkzlpf5r0ijdYqfP51gqZD7foERGon2eENrVpiPF7vzWo2WfHoQsUtDggRqbW
         3gsY+UjR9wADwUKvSM6CnxtD20beCIZekg9nuKdtOtaqXQWUxG9C+c6tkFPpWoCIK6rR
         3eZhY5u+ICCMkPo0B5w+NsFcnfm49O+0BrvxCU+4sQ4at3aDGzYoM9VaS6fPTy5NbFhF
         7oY1EcPTPrwmINZrYyHecXN6KaYR2Xv81xu7/eULVxYACl7wh0in5dZxTslKYzidZfv1
         qIlA==
X-Gm-Message-State: ANhLgQ2CdxhIZaQ6AbQiX4H7/zyiKJqTRO5bHd1BP+XryilhE73oKNQS
        e/bQQCTH8ze5ZupoHWvaG1FlBA==
X-Google-Smtp-Source: ADFU+vtj6VW9hZWcmopICbuUwylcQpDz8olJjzSn1kttXjJQyLEfzRLL3i3XgayuL2ashk5MbeohIg==
X-Received: by 2002:a63:485f:: with SMTP id x31mr12381883pgk.347.1583720223731;
        Sun, 08 Mar 2020 19:17:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o19sm15830487pjr.2.2020.03.08.19.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2020 19:17:03 -0700 (PDT)
Subject: Re: general protection fault in __queue_work (2)
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+889cc963ed79ee90f74f@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        schatzberg.dan@gmail.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
References: <20200308094448.15320-1-hdanton@sina.com>
 <20200309020900.16756-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <092fab4c-5308-4a14-ab3d-e63707efa2f6@kernel.dk>
Date:   Sun, 8 Mar 2020 20:17:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309020900.16756-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/20 8:09 PM, Hillf Danton wrote:
> 
> On Sun, 8 Mar 2020 10:17:33 -0600 Jens Axboe wrote:
>> On 3/8/20 3:44 AM, Hillf Danton wrote:
>>> @@ -1208,8 +1211,16 @@ static int __loop_clr_fd(struct loop_dev
>>>  	 *
>>>  	 * 3) unlock, del_timer_sync so if timer raced it will be a no-op
>>>  	 */
>>> -	loop_unprepare_queue(lo);
>>>  	spin_lock_irq(&lo->lo_lock);
>>> +	do {
>>> +		struct workqueue_struct *wq = lo->workqueue;
>>> +
>>> +		lo->workqueue = ERR_PTR(-EINVAL);
>>> +		spin_unlock_irq(&lo->lo_lock);
>>> +		destroy_workqueue(wq);
>>> +		spin_lock_irq(&lo->lo_lock);
>>> +	} while (0);
>>
>> This looks highly suspicious, what's the point of this loop?
> 
> It is a while(0) loop that just gives me the chance for adding the
> transient local variable wq.

I think that adds more confusion than what is necessary, and I don't think
the approach is great to begin with as you now need various checks as well
for the workqueue pointer.

We're freezing the queue right after anyway, which will ensure that
nobody is going to hit an invalid workqueue pointer in terms of queueing.
This looks more like an ordering issue.

>> Also think this series a) might not be fully cooked, and b) really
>> should have gone through the block tree.
> 
> Gavel in your hand, Sir.

Andrew, can you please drop this series so we can work out the kinks and
get it properly queued up after?

-- 
Jens Axboe

