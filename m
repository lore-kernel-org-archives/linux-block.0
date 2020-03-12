Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D0EC1975A
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FE32067C
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DzQ9/h9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCLNqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:46:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42840 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNqs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:46:48 -0400
Received: by mail-io1-f67.google.com with SMTP id q128so5711121iof.9
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hJ+ATkEu8GxBychJwyqdIrUUimw66/0QzhGlKQfCGg8=;
        b=DzQ9/h9m9MTe7O73jLHzE541Ixwy9UldwhMuvb3SkLqCeNOJFsjEug1CcdmNbsEwUR
         /ZzRylcm9G32rUaHbyqWh/VkFB59Uyo9xIECvHZP9hglYIi58Q7yjjjIAe9BZ0Ze2CrO
         IuT9Bxmmat8cl3Ariy2fYQtzMMcOTw2GNcdID8K6JLT6tf52VzHGahDeExpoo/6a0KA6
         GYskvOzD2moqtD5dpbqgSw7YCM8VQ+7KabK4P5Gfqd7Z7urYrr09RemuMz3WEHOyvjKq
         ABlU+qmYmBr3jMt3wF0aBLoEkLDJ1ehi5ge2QuJo2Z3/WYFRI/Psoyjv+OAaTEcu2Buh
         EdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hJ+ATkEu8GxBychJwyqdIrUUimw66/0QzhGlKQfCGg8=;
        b=GQbyE9l3z0UfSVJ63PjPDb7kJMatVZHfUPPhskcxP3fSkyjYAL0w+BYCyC8YtFfvRP
         Ixbaycbd1L9llKEqb0T+zIUsUtWQmhDjX3j9+uZXyqEGQ90cFSgeLRXiujq21MTQoRwJ
         51mVhALC5BXsBSNJczXtpPAydnyv5LVYiYqJQlPMRiT6r0YyNkHggHnTH/cKIpStwSkK
         SyoDa9Y5o/Zgkfe+OZnSwUpKfx7tzoElFG1tuc9whaMC/ex2NGVjJ8fCl9gFKvhZEcV1
         1LzbvP8lEnaYz/cmCZyit7mqztmOursGSNtbDXxpM2KMmnS+YjXVniQMn5PS/cfSLdGX
         v4Zw==
X-Gm-Message-State: ANhLgQ1/XJvTCnVD3pKkXzBPQVdsDrBOYkIZeWEol1rQGgA5NQEgmveX
        0WB2g41SAWE/acDIKAOlo4JQ3B2Jdq2rlQ==
X-Google-Smtp-Source: ADFU+vtOmkwaye+t+VXsmPdYJ3nxxnzRONtt/njMEbHJDRUFORPKsPihGKER7sjxq5nR6FjaXHDCyg==
X-Received: by 2002:a02:700a:: with SMTP id f10mr8076498jac.120.1584020806529;
        Thu, 12 Mar 2020 06:46:46 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 4sm6108184ill.46.2020.03.12.06.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:46:46 -0700 (PDT)
Subject: Re: [Bug Report] block: integer overflow in blk_ioctl_discard
To:     Changming Liu <liu.changm@northeastern.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <BL0PR06MB454833C4DFF442D4F61C4783E5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <be5fb01e-1aa9-415e-6ec6-a4b842b624fd@kernel.dk>
Date:   Thu, 12 Mar 2020 07:46:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BL0PR06MB454833C4DFF442D4F61C4783E5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/20 8:52 PM, Changming Liu wrote:
> Hi Jens,
> Greetings, I'm a first-year PhD student who is interested in the usage
> of UBSan in linux kernel. With some experiments, I found that in
> /block/ioctl.c function blk_ioctl_discard. 
> 
> Two uint64 integers, namely, start and len, are directly from user
> space, so the sum of these two can overflow and wrap around. As a
> consequence, the check of the sum against function i_size_read at if
> (start + len > i_size_read(bdev->bd_inode)) can be skipped due to the
> unsigned wrap around, the overflown sum is passed to the 3rd parameter
> of function truncate_inode_pages_range, which might cause undesired
> issue. This still exists in the latest version, i.e. linux-5.5.8.
> 
> It's well worth noting that, a very similar pattern can be witnessed
> in function blk_ioctl_zeroout where there are also two uint64
> variables with the same name from user space, and the sum of the two
> variables are passed to function truncate_inode_pages_range too.
> However in this case, the wrap around is check at line 262, thus the
> value passed to truncate_inode_pages_range cannot overflow.
> 
> So it looks like the issue in blk_ioctl_zeroout was discussed and
> fixed in http://lkml.iu.edu/hypermail/linux/kernel/1511.1/04403.html
> But since in blk_ioctl_discard has the same issue, I wonder if it's
> worth fixing the issue in blk_ioctl_discard as well. If not, I would
> appreciate it if I can know the reason, this can help me understand
> the system a lot.
> 
> I cc my colleague on the experiment here to keep him updated.
> 
> It's a great honor to reach out to you hardcore linux kernel
> developer, you guys have been the hero ever since I started learning
> CS. Looking forward to your valuable response!

Looks like your analysis is correct, care to send a patch to fix it up?

-- 
Jens Axboe

