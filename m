Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE180C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7184022CEC
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 21:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X50zwJdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHSViQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:38:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42771 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSViQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:38:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so1924213pgb.9
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Zb99Tz+O4J7Hw47tmBw4czl01TlbOvzcMFKzsiPXAc=;
        b=X50zwJdR9cUmZ6LkaIjJIewbt7wJeDuwlO6LjU3D/qGQj6NO2DXBU6QMaIYwX0LLHG
         NDHwwcdr8/cno94MywblLMoI3m31peUCkB2Y4vX6k5evWlBYrrwSMwHUYDzhTrLu1HuR
         EAj2f+nyum/hL/VjLu5IxwVa/n7T1LKmrnwREphJDrsPrFjjA8KlItlg2YQdChlVwNzG
         FwBKSJxjyRo/i/l8XQcEP00OoUvzMMBOFY03luSM6YO974tYtKreUnw9UCbRKC1B03O8
         4sFsvJgS2CbtJ3kdOm9XufvUqj+L6bZ3/18hEZhGbEfe0/16kqUzDSM75aMIpRx1jQSg
         UF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Zb99Tz+O4J7Hw47tmBw4czl01TlbOvzcMFKzsiPXAc=;
        b=UwbCkQ0xh/vcyl0Z5zzBg6cLMX+XeG0P007SuWUyCTEM3rYtvw/X16svUe8sX9Aass
         2dMQB44a4MYtIi05gsI98I6Jia4Y+Bf3pM5kWvQBK9vwj0Oqwaowuca/3nqubPduBhsS
         i3VSBwie0h3MebwflRMdPklI3PitGUqiwCE3Z9SGQjXt8Zp3GxIzHk9aWaIhfUfEHvB7
         10im3crdlH+4yfZU5fU4sFYA6zb3IQdw1OFLlIXeXl3qZ3RqgOTtm1aWInL6md3+yhXe
         ziI/RkF2A9HArWEC4/NRV3hq42atxZst/2OwIdZ3uT/Qunhwkt+Qf8qZz2ZIpb6WTX+o
         me4Q==
X-Gm-Message-State: APjAAAVrZJa3SDfxtsZyTH1riIYTj6pxTbf3KH4Gzt8k3TKplC9daeRG
        nJIO2eZkQZa4IhpCH1F2h4HO6w==
X-Google-Smtp-Source: APXvYqyxp8QB5MVOlHZLaMOnvJ2oTYVz7w/M0F3nvsaUPwm8UliPSqVzvkK8/SGwlTT9cdL/mzeZEg==
X-Received: by 2002:a17:90a:ad84:: with SMTP id s4mr23482448pjq.32.1566250695769;
        Mon, 19 Aug 2019 14:38:15 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id p10sm19006567pff.132.2019.08.19.14.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 14:38:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] block: sed-opal: Code Cleanup Patches
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
References: <20190819213506.14788-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11e2801f-bcc5-bb66-d34f-8a4307ef7362@kernel.dk>
Date:   Mon, 19 Aug 2019 15:38:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819213506.14788-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/19 3:35 PM, Revanth Rajashekar wrote:
> This series of patch is a cleanup for sed-opal in kernel 5.4. It
> 1. Adds/removes spaces.
> 2. Removes an always false conditional statement.
> 3. Removes duplicate OPAL_METHOD_LENGTH definition.
> 
> These cleanup patches are submitted with the intend to submit a new feature
> after this.

Why are you not adding the reviewed-by's from the previous series?

And what's new in v2?

-- 
Jens Axboe

