Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A91DC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489412083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u1ZnMbPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489412083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLGAdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:33:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGAdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 19:33:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so968348plz.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZutUDj/MIQXA/swQy1/uZPux59TjEkpEXBSqVaQdOoY=;
        b=u1ZnMbPhOykyh2zvcOrRUqTf3vj3z6HHrISyRkWQPe7ifu2ry963urChM5lN0BFBgu
         Z99Qix5i2d0sbihnqDtSDpIMBLv4k7cUDr27k2FWTdqsUdbyZcz/tnwAhXkjH85C2a/5
         uBQvF6pgbTw/+7rtZwm+t69YX5GWYYfpJkXZXQoH/wAMSKGf28ft/REQqeGgYn1qXhpO
         UG5x22MJ8b18W6IRFv3FPPVZlMqA7qoJmuqpRol3jYkwo1Po271pMC5x9GqqJd93MPSG
         w5eoTTnPI9llaz4qNbaFoFcn9U1XFrGrF4yudtQN+rx8Yl82AirdCGmUlfWaJZZWHdB7
         RTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZutUDj/MIQXA/swQy1/uZPux59TjEkpEXBSqVaQdOoY=;
        b=eHT34xoGZr7qq8/Zb2R1Bwxvzf7tQ17oKYw8KXO2i7lH3B2cAV47N4sQMuuOBm9vOA
         6scwwmUnj7YnmYYHBSLJJNyEx/6hXQZjJI6o/RqyeNFQz12lswCNahX8j19DA1iqjYHq
         FfcHIbds4vGMdd2rsy1t9zgEtrw9aTD7x/vRX12pLZwgiopwT1tnhM6gCtKB0zFUYkYD
         P8YvIZdVItJuZpwfzWqz4UA9Iok4yXxu6gpgUji1gsej8KeK0PBnIaTfKHXlwwEM9bjI
         ZZjimdoQGhIBwOyGuKCuSPcxEhr/W2O/eUeazzM6XN3Hbpl3+Xx5O1kmeDeaggiHHmL+
         q6Gw==
X-Gm-Message-State: AA+aEWa18mlBLYHqNF4+yVvcMjDGFb2C3/IRnkGya6QFqnAxhQeW2+/T
        4ZLsQQBal3qbstGmD+gvThVoQXVMYVE=
X-Google-Smtp-Source: AFSGD/WjwJDic3ppk5B1Amo7M+s5tXdPD541uvQdfjWXS55r1YhB8mBwdNG7c7anVJtcoFLR1QfcDA==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr105797plx.232.1544142799494;
        Thu, 06 Dec 2018 16:33:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f62sm2806532pgc.67.2018.12.06.16.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 16:33:18 -0800 (PST)
Subject: Re: [GIT PULL] Follow up block fix
To:     Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
 <1544142034.185366.293.camel@acm.org>
 <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
 <1544142690.185366.296.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f48f48f-10c0-07db-4e90-b310c87554b6@kernel.dk>
Date:   Thu, 6 Dec 2018 17:33:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544142690.185366.296.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 5:31 PM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 17:26 -0700, Jens Axboe wrote:
>> On 12/6/18 5:20 PM, Bart Van Assche wrote:
>>> Which branch does that tag correspond to? Even after having run git fetch
>>> --tags I can't find that tag in your repository.
>>
>> I pushed it before I sent the email, where are you looking?
>>
>> http://git.kernel.dk/cgit/linux-block/tag/?h=for-linus-20181206
> 
> On my development system git has been configured to fetch from the following repository:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/
> 
> Should I fetch your branches from the git.kernel.dk repository instead?

Ah I see, I always push to git.kernel.dk, and that syncs to git.kernel.org
only every hour or so. So either one will work, but you might be a bit
behind if you use git.kernel.org.

-- 
Jens Axboe

