Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:50650 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdKBDKE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2017 23:10:04 -0400
Received: by mail-vk0-f47.google.com with SMTP id h142so2699697vkf.7
        for <linux-block@vger.kernel.org>; Wed, 01 Nov 2017 20:10:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509588931-25262-1-git-send-email-tang.junhui@zte.com.cn>
References: <1509588931-25262-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Date: Wed, 1 Nov 2017 20:10:03 -0700
Message-ID: <CAJ+L6qcWFHDv0ur5QhY++BE=4_LtqcmbDiPo2H0SjzRxTt5mXw@mail.gmail.com>
Subject: Re: Re: [PATCH] bcache: correct journal bucket reading
To: Junhui Tang <tang.junhui@zte.com.cn>
Cc: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang--

On Wed, Nov 1, 2017 at 7:15 PM,  <tang.junhui@zte.com.cn> wrote:
> I read the the code again, and found that find_next_bit() would return 7 in this
> scenario, but the bucket number begin with 0, so the 7th bucket's number is 6,
> so it will take the last bucket as the first bucket to read journal,
> so the 7the bucket would not be lost. I will change this patch to a annotation patch,
> other readers would be easy to understand these codes.

Thank you.  It is way too complicated/tricky :)

Mike
