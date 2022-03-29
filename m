Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5481C433F5
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 12:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiC2M0I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiC2M0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 08:26:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BAE4D9C3
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:24:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d30so217185pjk.0
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 05:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DbHeqBmeub3IXNgpNpXwxQEP5KJEOmozlPFdl+jrVb4=;
        b=3IFSkxrjEY0kgqIH5AF3jinprwQV6MupXoDqc/cYBqfY/yqMU2lDyZr+OhQlFdBOia
         Eh0BHSWzVdlKCoTUtRr/AgxhqKc4QuskCaWi156M7MIb1FZH/ZDQL7JHuwo2/THS7h1F
         gvT0YF9WHeBDrkKFKloBRzvigQdr4tqYq2NeTXDWFFKrjAhJkofGN5MY0Wq8wHIjewF8
         CVKZniazVDjsqUtjnQtNoxDUNK633AMJJGlk2Q8lMBGty9VlgXvr7+4GHWBVb2YJT5mR
         d+v4+33oMH71tiIo/WLEcyvteR/DV1jwQwI1pb9cqPY6h2C/Iov3z4tHiY2onEHygIKf
         Xp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DbHeqBmeub3IXNgpNpXwxQEP5KJEOmozlPFdl+jrVb4=;
        b=MVQqNtUIOIunJE0ul/oAEVFwKTaXCORFDbQLImZPH/sfW13B7E7VnqZeff58grsyhV
         MincKRBb0CVCKSwDZRJ9qpB2JqcBEE2Mi972/9KAYt4w5BNOskHUwRS9yOjoP0HrPYbP
         mpx+bKrXrctNEmUX6gkQ+g9c4ZtRddoKl0+DnNjGTZ2w1v6nTzZ6duScfl12c8pOR4Lz
         POZIgHEm+lQXSZSLJ2FjyMXz8Z5oyucnR+JHC38Yp/kBESIZp9ZvPRwxSzCA6QcQvFhW
         Drqy8+O+f5xrvwo/N5piPBu6gqcSQriCJIxcSab0wqA38R1G8lr6COXnJw/ROK8ssNe2
         i5ew==
X-Gm-Message-State: AOAM533JM476UYhUeO12wAbPUHx2zqEDbhaAOH7WEr96gQO8WjkK6UJB
        JEcIBr0dRXIDDG9F2RFgY/xl8+OA9IFvbVad
X-Google-Smtp-Source: ABdhPJwpVnKb/gfRQoAuLbAhnBEbGdj5ibalqQ5j3N6zvFHH5YG7i9hzQst4uYti3ZHYMUZUmWvwZw==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr29253372plo.76.1648556662491;
        Tue, 29 Mar 2022 05:24:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t34-20020a056a0013a200b004faa8346e83sm20386224pfg.2.2022.03.29.05.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 05:24:21 -0700 (PDT)
Message-ID: <69c1b01b-df24-d6b3-c1ca-06f3f3f850c0@kernel.dk>
Date:   Tue, 29 Mar 2022 06:24:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.18
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YkK14fRnn3GVpGxQ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkK14fRnn3GVpGxQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/22 1:31 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-29

Pulled, thanks.

-- 
Jens Axboe

