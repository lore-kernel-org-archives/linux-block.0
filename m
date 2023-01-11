Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54467C46467
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 19:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjAKTFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Jan 2023 14:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjAKTFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 14:05:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011910545
        for <linux-block@vger.kernel.org>; Wed, 11 Jan 2023 11:04:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso21041301pjp.4
        for <linux-block@vger.kernel.org>; Wed, 11 Jan 2023 11:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlzAnfauG/SrWpxzD/HFqmo0bekDwT+PiGFDCinqA6o=;
        b=07Nh4WTyDbwyfZzqhJ1UkQq0uAGvOjeK8lUiAK9rY289VOkv2sr8xYob6lNWPt8PuU
         ZPtIjprgFW1QCoxkSp0QLCobk/RY7yTOZPDzL3IkNEJ6wmXfMj7E3z5nFtVP46JyyEtY
         nLJ1On0cPoobJox9yphhx+0qNHP0q6mnV0Z3kuc2yFj0AKJpFVpu8mET3I7GVGG7Hvc5
         E1b1uJ25DO5jWpmgVO2ve4txrl65ZVgDjjTWsaBytLKXz9sv2ikLVsAPHzFsq01vaaCA
         RRYHvr5pZoZ5cV5nkNYoz0iycxNFaqFueUdoleRXzah1OBUHRcwguOUcA3gagrmYWnNe
         ZyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlzAnfauG/SrWpxzD/HFqmo0bekDwT+PiGFDCinqA6o=;
        b=guJTalYWDVyYhNAbT3n3gJghR5G6smU3E9/KxWFivY3sv6+bygpNncPv67b2xsBCEf
         zvpmyS1kK7kwdVtbdIJz/AuEh6hPhLBfxnfCIWJfjUwSr73Q/2pp6AJZ2590z5Tump48
         j8A3sdz+9M3/jF3fvItYDI5VGoqbd+nJycbgqlbu+rhrG16zQU5XXJOHn9zh5rNocLNt
         dUU2Kzt576g+OT5RS/3aLFZ0CN9EksnyhEOFlPCsexUm5yFkmZCDiDOqlvFtM987jedr
         RiN+MMclnelb/wQVRasKZQ6axKYb7WLJLcJLwykSIiy1kbNphalBd/jRcI20LttaeIDy
         07/g==
X-Gm-Message-State: AFqh2kquNaH1Z0E9RnG9XHKiQ/9r/8VQWmjfT1cNfYBiMW+9U8ux28ll
        OGh9iz/84KMCVFPpz8DH8FDQdA==
X-Google-Smtp-Source: AMrXdXtzU+Q4Jj1NUJ0JrAuhndnIFmQRonwPtkOc39sQrciDCIM0yuPytaaqKIZACwMwK3j+qLLeKg==
X-Received: by 2002:a17:902:6acb:b0:191:40a9:60f6 with SMTP id i11-20020a1709026acb00b0019140a960f6mr16988537plt.0.1673463897989;
        Wed, 11 Jan 2023 11:04:57 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00189f2fdc178sm10529771plg.177.2023.01.11.11.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 11:04:57 -0800 (PST)
Message-ID: <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
Date:   Wed, 11 Jan 2023 12:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y74cXN4SP7FNtSl3@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 7:18 PM, Ming Lei wrote:
> Hello Thomas, Jens and guys,

I took a look and it looks good to me, no immediate issues spotted.

-- 
Jens Axboe


