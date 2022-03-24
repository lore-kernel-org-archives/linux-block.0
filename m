Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 00:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiCXA0j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCXA0j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 20:26:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB97C791
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 17:25:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t13so1282872pgn.8
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 17:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DLXwEQVoWDDsKhgb9WrIVEN4Frk4SugcJXU3mLlQoa8=;
        b=MEF6krUU5iNpWW5KDt12I/WImTmZC81tdTGXK1zQY2QVo7Ju2vbhLSU1NOz7Syw5Ye
         VWMJ6FEaTRHA+TrrBaGsKHwVCASruOWIU0BtaO2I6OyUHFp43fNH2gwlWq1zEA65djOi
         /uo/TDF47f8P7p9O5XfjMUAcBTXDQTbzrdiM7nBcBaqqzpGMDolZNZTbD6gAXNnR6y+i
         gcULbmlJa7tVVCOnPj14sfbWeHqNY5CuOzfbAJxIc0+bJnZERgsI0+9m6Fa29TkDkNl4
         TkPR+V1ovjlNtnHyEGKtSFH/jG4RA4UE6aHgQ7jg+as1Fazj2zTx5aQdhBS2m4ZyOloh
         +6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DLXwEQVoWDDsKhgb9WrIVEN4Frk4SugcJXU3mLlQoa8=;
        b=Gm9whMxOmGe6pfsvKvLFRvc59U4fD5kHeljQkAmwXPp/YU0gw5XrFBDTMKsFNy7FlK
         MpZyDrWwG1jZPJj5CoEJQ1cc3KDYWbegYJbyTMyf54Psrw1HDAtXVKRomoAP4/wSm/9u
         P+ctxuiU87H+tuc4xbWZgz53QU/knlWoMnV663ScT7xBgGQsRCJ+GJ9h7eePuCSu6E4V
         rxmKsSY0AuTON0D+pPcTc5AtEoHsa/j4o/u4vthVarL8xd+w9FXBt7DWmoGIJwRC6G80
         KqaTIWn6a2tONNy8DhZJbXltaYScPIR2Y4XVHzE2ue4G8+uqBB1cr4VZch59p6jL6m/1
         gKRQ==
X-Gm-Message-State: AOAM532O9DzUjnCtQHZ73XodCz/WJ7HagLmSQ3XnDr9cTMK1sQBd+zEy
        afczTxN3S1fPVFt8A58GWc0AUg==
X-Google-Smtp-Source: ABdhPJxpUJvas/aHL0BqsaaE+UmpRki4f4WUW7prIIy8r1Nmg/onImt86e4hrZ6A4wbAnPuHrWxKyw==
X-Received: by 2002:a63:4e26:0:b0:386:1839:3bde with SMTP id c38-20020a634e26000000b0038618393bdemr1928819pgb.603.1648081507485;
        Wed, 23 Mar 2022 17:25:07 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ep2-20020a17090ae64200b001c6a7c22aedsm730331pjb.37.2022.03.23.17.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 17:25:07 -0700 (PDT)
Message-ID: <30acea65-293a-7049-2dad-9e81e025ce61@kernel.dk>
Date:   Wed, 23 Mar 2022 18:25:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] block/dm: use BIOSET_PERCPU_CACHE from
 bio_alloc_bioset
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220323194524.5900-1-snitzer@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220323194524.5900-1-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/22 1:45 PM, Mike Snitzer wrote:
> Hi Jens,
> 
> I ran with your suggestion and DM now sees a ~7% improvement in hipri
> bio polling with io_uring (using dm-linear on null_blk, IOPS went from
> 900K to 966K).
> 
> Christoph,
> 
> I tried to address your review of the previous set. Patch 1 and 2 can
> obviously be folded but I left them split out for review purposes.
> Feel free to see if these changes are meaningful for nvme's use.
> Happy for either you to take on iterating on these block changes
> further or you letting me know what changes you'd like made.

Ran the usual peak testing, and it's good for about a 20% improvement
for me. 5.6M -> 6.6M IOPS on a single core, dm-linear.

-- 
Jens Axboe

