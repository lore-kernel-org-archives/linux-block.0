Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 18:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbiFMScn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiFMScQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 14:32:16 -0400
Received: from resdmta-c1p-023852.sys.comcast.net (resdmta-c1p-023852.sys.comcast.net [IPv6:2001:558:fd00:56::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA9C3674
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 07:50:17 -0700 (PDT)
Received: from resomta-c1p-023269.sys.comcast.net ([96.102.18.227])
        by resdmta-c1p-023852.sys.comcast.net with ESMTP
        id 0jy5oNA8G76j10lORogoaH; Mon, 13 Jun 2022 14:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1655131815;
        bh=pSfJ4sxdG1vpIY6izypHze2+EKPLMDx2R4V2f+sHpIo=;
        h=Received:Received:Message-ID:Date:MIME-Version:Subject:To:From:
         Content-Type;
        b=nX1XovlTULmoXWM5RYBZpEH04UwI9Ndc9CZBGtWgSaVPmDC5GkNO+mZtExCYazIhz
         g/WlCqBBkOD4J00Jzzmy2uZSwNoWTHjNOZlRYabW3FMpifkws4GPRTNlxyT9NVvyhw
         RfJbwSvZKF0jQUqfwFXBXY3FKWY8gMVDPqJRi4p5u8b6MIoio/PH6SK3J/KOL8z37y
         xRcUr/tRZn9z/EQe0JvKJ79NgbeqYOHmnBUF29kabTZADGLjN+WcgJJeKxiuL8zY2x
         5l/yOYzPfgjoAFdHQjWDBaLib9FT1zwdJ8pDGHKPSaOJaDe5luFwYRDWgTRrKj0EMk
         FBH/VHfFg5qCg==
Received: from [IPV6:2601:647:4700:284:aefb:677c:684d:580a]
 ([IPv6:2601:647:4700:284:aefb:677c:684d:580a])
        by resomta-c1p-023269.sys.comcast.net with ESMTPSA
        id 0lOPo0S0lU9CF0lOQoPbqH; Mon, 13 Jun 2022 14:50:15 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Message-ID: <368afc66-3781-4f56-134e-e08210ad6c93@comcast.net>
Date:   Mon, 13 Jun 2022 07:50:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: loop device failure on 5.19-rc1 RISC-V
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <849cea40-4665-14fe-fa46-e555af730214@comcast.net>
 <20220613143210.GB4110@lst.de>
From:   Ron Economos <w6rz@comcast.net>
In-Reply-To: <20220613143210.GB4110@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/22 07:32, Christoph Hellwig wrote:
> On Sat, Jun 11, 2022 at 02:46:33AM -0700, Ron Economos wrote:
>> The following error messages occur on 5.19-rc1 RISC-V Ubuntu 22.04:
>>
>> Jun 08 21:00:20 riscv64 kernel: Dev loop0: unable to read RDB block 8
>> Jun 08 21:00:20 riscv64 kernel:  loop0: unable to read partition table
>> Jun 08 21:00:20 riscv64 kernel: loop0: partition table beyond EOD, truncated
>>
>> This happens when the snapd daemon tries to mount loop0.
>>
>> Reverting commit b9684a71fca793213378dd410cd11675d973eaa1
>>
>> block, loop: support partitions without scanning
> In which case the snapd daemon explicitly asks for a partitions scan,
> and we fixed a regression that makes it behave like it did in 5.16
> and earlier.  But why do you have support for Amiga partitions enabled
> on RISC-V anyway?

I'm using the kernel config file from Ubuntu 22.04 for RISC-V. It has 
Amiga partitions enabled. I'll just disable it.

