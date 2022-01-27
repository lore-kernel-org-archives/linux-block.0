Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DFC433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiA0OoO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242538AbiA0OoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:13 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BACC061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 06:44:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id p37so2819849pfh.4
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXUUPQa1aUv+YBHhpXUraTxpOw9EvSTI8Y9qQN6SCis=;
        b=Nz6tExmq7RyTSsHC/6qD1f1o4nViCCtTuKQFK27QzpkOPANQB2MqT1LUhILQue8adp
         llmNpcEWpwrYNxj01XYateYIsqVJNInOoL3JDYxMARIp5Td8Rw9WvCWcyDk70MBOcjCZ
         NRNm8+N06Au3lu3VSoBrqtXivtPkMVES0CthJG5ZIwvNrhhBjZcEnC/9L8EtlC4RSQTG
         PriUaFABeUrtG1OFH+mFEqNzErkzw29Jf79HrLJ0r43UyDz7LNkgx2ux13yi5MNn/bCU
         XcyTB1N8n2dMfCaxeyghUvDjzdFhqZ4fM2NkUd3cZlccJ6bATJHIJ/+NjrO0gwif6r9s
         gfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXUUPQa1aUv+YBHhpXUraTxpOw9EvSTI8Y9qQN6SCis=;
        b=vSHQUaud8QQ2g3EiLwKyrZ5XKznLx9XadU7o6OjDbSJKm8VCefjrP5atstHtM6jYZe
         GGhRHx6pPHXVPYmZ3WB/wCy9r6/v4rxqgXbUllvYNWXz1qtt9k6KilqMuXMR8B9vgJzy
         kNIqDgWpPErUVwApYz8SZAjEN03UGD8uKP0yJ2qrHf6MfDcxKafMIreIpyKItw7h7cGa
         iB47VCPDMULh/5IZX0aG1mYoWq+gnFaB1q3ZSzaGBCSAlqE4px+C3gA/j42TD0LUtBBG
         JM2nAaE/+ifdlrnDU0gtxFdGy4onZFF9tw9E7ujpCw8LLDD/kVqnHJP8eS/iriNT2OZT
         HT0Q==
X-Gm-Message-State: AOAM531ad7L/WcncukfmmG1GDCUPPAj1mi/n2S4H/ieQyLawrL+U7pth
        0Uj4QIiouskJwg6zUjomQKma1yFDHq2kTTQNpbQ=
X-Google-Smtp-Source: ABdhPJxWzybUYiMCznLtPeYdZtDVjf2rDOfAX9Rrw9FX8v6dAynvxlT2Ud9pJ95Cf5o1uUp3soNb7gIcInF0CGbVFCw=
X-Received: by 2002:a63:6cc9:: with SMTP id h192mr2920360pgc.486.1643294652441;
 Thu, 27 Jan 2022 06:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20220127082536.7243-1-joshi.k@samsung.com> <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com>
 <20220127082536.7243-3-joshi.k@samsung.com> <20220127092921.GB14431@lst.de>
In-Reply-To: <20220127092921.GB14431@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Thu, 27 Jan 2022 20:13:46 +0530
Message-ID: <CA+1E3r+tZH4AtnHduTTZenbJTzn1pC9HuDcYNaZUVX4+umyk5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: add vectored-io support for user passthru
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 2:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 27, 2022 at 01:55:36PM +0530, Kanchan Joshi wrote:
> > wire up support for passthru that takes an array of buffers (using
> > iovec). Enable it for NVME_IOCTL_IO64_CMD; same ioctl code to be used
> > with following differences -
>
> Flags overloading for a completely different ABI is a bad idea.
> Please add a separate ioctl instead.

Hope "NVME_IOCTL_IO64_VEC_CMD" sounds fine for the new one?

-- 
Kanchan
