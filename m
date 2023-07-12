Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30CBEB64D9
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 13:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGLNnX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 09:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGLNnW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 09:43:22 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60BE4D
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 06:43:21 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b9e8e5b12dso20939295ad.3
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 06:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169401; x=1691761401;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBDXN5qGAHr3Y2llTUXMDhJDJQirL10EjAvh0C4nMkE=;
        b=i64ihqqwFA0c1qOv9OhpiPeqBd7GK84wHixIH1JYu+EpF9GQ6AxZ9Tv5qLINvuYSpD
         DyQCXHcDu5U3HFe8XGH1lgkXXt85Q22VcTz4wTe2JYiGvrD+7DctgY/0KJGQ1fwnxj/9
         VXna6UYFOMLzIGAnjyo/bC9fMs5ZpkrcXOOLmfSk63s4zrd8WAjgnjlgBhKBk5WKV+T3
         Pr4XQgXK6CkpnY7uN1luyy4YvONM6uXf67+IYk6qY310Wzk+gsTaDYcfunmU0ApRIQ9+
         PS4YGhCMXc2v5QudAe+9KAjweJAmyp3xeKgqONJhSYduHibfdswk/YA1lN+wjH+4q/CS
         Il4A==
X-Gm-Message-State: ABy/qLbh4BsRSo2WBJXj5l6V69/DDDze9Z8qWzeFfokbNs6ioxHn/hlk
        p0p9bh8offw9sbSpYL16eOvbpP0AyOY=
X-Google-Smtp-Source: APBJJlHD5CweBzRVEOGy5jWux8OSemH/VjoP+LnMbB0eLaJqJddFn+5rXyTLOgU8JhJqt6jF0bsyNQ==
X-Received: by 2002:a17:902:dac7:b0:1b8:a56b:989d with SMTP id q7-20020a170902dac700b001b8a56b989dmr23720856plx.6.1689169400885;
        Wed, 12 Jul 2023 06:43:20 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b001a6a6169d45sm3966609plr.168.2023.07.12.06.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:43:20 -0700 (PDT)
Message-ID: <1cf96e3b-e5e0-bcdb-df2b-ef9cbe51f9ca@acm.org>
Date:   Wed, 12 Jul 2023 06:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ea29d76f-99c0-fcf2-09a3-4cc2e18f87da@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/23 03:12, Jaco Kroon wrote:
> Ideas/Suggestions?

How about manually increasing the workload, e.g. by using fio to 
randomly read 4 KiB fragments with a high queue depth?

Bart.

