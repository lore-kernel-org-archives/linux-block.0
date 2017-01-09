Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.147]:49216 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763537AbdAITfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 14:35:55 -0500
Received: from cm2.websitewelcome.com (cm2.websitewelcome.com [192.185.178.13])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 97012400E5764
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2017 13:35:47 -0600 (CST)
Message-ID: <ff097f797ae58a7ba3deaba8ba55d036.squirrel@webmail.raithlin.com>
In-Reply-To: <aead4ef4-4fbf-10a1-c307-24abbc3fe9d6@fb.com>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
    <aead4ef4-4fbf-10a1-c307-24abbc3fe9d6@fb.com>
Date: Mon, 9 Jan 2017 13:35:46 -0600
Subject: Re: [PATCH 0/2] nvme: Improvements in sysfs entry for NVMe CMBs
From: "Stephen Bates" <sbates@raithlin.com>
To: "Jens Axboe" <axboe@fb.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sagi@grimberg.me,
        james_p_freyensee@linux.intel.com, jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>
> I have added 1/2, since that one is a no-brainer. For 2/2, not so sure.
> Generally we try to avoid having sysfs file that aren't single value
> output. That isn't a super hard rule, but it is preferable.
>
> --
> Jens Axboe
>

Thanks Jens and sorry for the delay (extended vacation). Thanks for
pulling 1/2. I will go take a look at 2/2.

Stephen
