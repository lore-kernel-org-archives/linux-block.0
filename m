Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77313ECAAA1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 14:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiH3OAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiH3N77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:59:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE35B2CEC
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:59:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v15so3213982iln.6
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KUO2x6GMyJ0E32QWlRjYyOMdCN2D/9InXcZ/H9pOtPc=;
        b=tOaXpq9hQc/TYnVfkq7TPBt9SgMvSWjMwdoXvBNyYVfru9NA3E2ZQGDoQjOCIRoZuc
         vjyGTlSQRIK01ePOH5dPTrG5/0px6ZTbrPGP/IewB+UQfPCYlYjhRaBISFcruZgT/6BK
         LUcBRxtC948e7gtSInWMlBwdoEkkDLAumHkkUaK28u1g0sPNCdzkI8+sXM5230C8dgOr
         fF0K+shBY/+h/Q7lvk2B4NB2dvG6YTYbngeSnE3MtwKtRE9H0mraVSpHwDGSGvFNqELm
         RniNTGBp0zLX3z+RYq4Rfi6C5Ov8X/DY/bPg7exuyhsy5gfAZB9ypV0JhlN4kMsqRazj
         Zmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KUO2x6GMyJ0E32QWlRjYyOMdCN2D/9InXcZ/H9pOtPc=;
        b=NM61wYgfqy/AwRQQ0VYIdYFQgG/Jg2SENaeal7lxZkcNF13Nio7uCYXdDRJw7yqFBi
         2PYZ2gbGbteZhQoXFlB2ghnPLj/eilVqfdYW3pg60dlLHHuDy8nhfB3xvjtaL426eY1m
         RBQDFElAgjiIjXI1Vz/QPk/8CdjLrmQjg6RqSVxaFTN7GfB4vakrIdPruHihH6AWOqx0
         BFdHbFLO61RRLpY+f8B/ktN0aym/3XExSEFzdR+l63dFQZcQSDselPyXBJRJBMakKYn5
         +0VdB4ExuWyLPGcGQlDzfq86CYObyb58/AuvLz/xqZYpgGCJd67ioeTiAcDWbZIuVxW6
         ctJA==
X-Gm-Message-State: ACgBeo3GOR9I24nAv0qHY3I1PHZhGeJ9+v5rnW/tc6a5fho/YbolJW0U
        I3CeWxmJZP9OxhtwCsyCiRF4Jg==
X-Google-Smtp-Source: AA6agR42v0TIOtplOU5TgHzx+J3kxMBrfiH/yz8vc+Bl4yxoZCRoBHh/kl1SGEU+NZj6IWwIE7kajg==
X-Received: by 2002:a92:dcc2:0:b0:2e4:38f2:a9f6 with SMTP id b2-20020a92dcc2000000b002e438f2a9f6mr12641429ilr.130.1661867973804;
        Tue, 30 Aug 2022 06:59:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j22-20020a02a696000000b00349da92944bsm5548637jam.176.2022.08.30.06.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:59:33 -0700 (PDT)
Message-ID: <908d464e-e695-3a27-56f6-1ceabd727989@kernel.dk>
Date:   Tue, 30 Aug 2022 07:59:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/22 3:45 AM, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> Change "bio_set_ioprio" to inline to avoid calling overhead.

Let's not try to 2nd guess the compiler here. Most things that are
marked inline should not be.

-- 
Jens Axboe


