Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38807C27C40
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 17:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHXRNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjHXRNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 13:13:12 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C105199D
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 10:13:10 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so1236055ad.0
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 10:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692897190; x=1693501990;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuzIfkc/gKFONXNez27bvtN7SeJQ//bCcBHbgY6hUtw=;
        b=WLThRSwGRByL93Rok8hLzVg6gYSmgLQBXXviMrRpUUKExoqpRn36cRST/iRoU9GaPc
         Z9z6DF3QbMNt815BqzsQSBb83zqcgrPfVe9d5DE8YZPSQ0fdN0VKmnrLWiSRSFGv7oKb
         liobC7jCgEuXwPlF5hv6u6oT0gnrc/N3IMIl/10sdSIFcbZjBWJD1Ks2PG/f+u8Fonu9
         rdma2Vco4TJrnJ65gaTGS/9eVJ7KCEgrt8sBAZr5iI94svKbfu+fKsdCIeLRLD0IPS++
         h4lB8lHUKRoRQwB8Sk0H19/RCXJ7nBAAZzYstRu/7QWA0GZJNZcwEoVIOYuESuBkqstT
         SIBQ==
X-Gm-Message-State: AOJu0YxGAmosvtjXb4BZ+/3gffz3vJfSOAqhW2jfdyt8DnzTD+hnVfbl
        yvdIDXUB+X+wAHS15xGhFQUcg5jPAe0=
X-Google-Smtp-Source: AGHT+IGXyjGoOt2nQvswjkKYG43YgLOsvzh2Axcs6KrjfBdMkAzXm44ziam6kCAd0j+1YSR+MLlHiw==
X-Received: by 2002:a17:902:eccf:b0:1c0:bcbc:d78 with SMTP id a15-20020a170902eccf00b001c0bcbc0d78mr4429271plh.14.1692897189710;
        Thu, 24 Aug 2023 10:13:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e6ec:4683:972:2d78? ([2620:15c:211:201:e6ec:4683:972:2d78])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b001b8af7f632asm13023476plg.176.2023.08.24.10.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 10:13:09 -0700 (PDT)
Message-ID: <01b46e84-39f6-ec74-88d3-5735d7ac4a47@acm.org>
Date:   Thu, 24 Aug 2023 10:13:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-US
To:     Jaco Kroon <jaco@uls.co.za>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
 <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
 <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
 <ea29d76f-99c0-fcf2-09a3-4cc2e18f87da@uls.co.za>
 <1cf96e3b-e5e0-bcdb-df2b-ef9cbe51f9ca@acm.org>
 <ef2812b4-7853-9dda-85dd-210636840a59@uls.co.za>
 <d4b1c5d7-020b-7ef9-ee43-e78891649a3c@uls.co.za>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d4b1c5d7-020b-7ef9-ee43-e78891649a3c@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/23 00:29, Jaco Kroon wrote:
> We're definitely seeing the same thing on another host using an ahci 
> controller.  This seems to hint that it's not a firmware issue, as does 
> the fact that this happens much less frequently with the none scheduler.

That is unexpected. I don't think there is enough data available yet to
conclude whether these issues are identical or not?

> I will make a plan to action the firmware updates on the raid controller 
> over the weekend regardless, just in order to eliminate that.  I will 
> then revert to mq-deadline.  Assuming this does NOT fix it, how would I 
> go about assessing if this is a controller firmware issue or a Linux 
> kernel issue?

If the root cause would be an issue in the mq-deadline scheduler or in
the core block layer then there would be many more reports about I/O
lockups. For this case I think that it's very likely that the root cause 
is either the I/O controller driver or the I/O controller firmware.

Thanks,

Bart.



