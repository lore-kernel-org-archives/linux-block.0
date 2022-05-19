Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD21C433F5
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiESNgh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiESNgf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 09:36:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2634CD75
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 06:36:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso5322531pjg.0
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/UPD8ZwuMs9z0E/L/pcyjiHnRKl0RiCwEg0dM50KlCQ=;
        b=BaIRv+TBV5PyUUbeoDc4Lu3YKY/1YGngkOYMGIz1j24u4jviRLCYAoo6pDP5JBxv5F
         DQAjjpJLAY4O5dhtZ5B1IFDUIeS9o0IQOmbJiPv82RKSVCrlQ2dtB8hG7lhq1LjojiYh
         hM9enfC4/qJiB0tKncZ/NOsN5DWSJDRjnN9lWKXCFX4ctJ+xVnph2ad4JO64X/Znu7Bk
         SCkIevVL8QQ71AXp+6KZCEUOofEls8jbQnxhA0Rbk0+OGVhv/+UW9cQqvtVQjGRCsVSG
         vDYGVzYUMJ0KICFdyecJRZu+U5rGvn/8LvzUlJ9b3VBY0OmbCctIvIq8UuAuywPz8GKo
         roNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/UPD8ZwuMs9z0E/L/pcyjiHnRKl0RiCwEg0dM50KlCQ=;
        b=cTx61xEC+zCV6FPTH/qfCeR4AslN/U4Aj843qWKYdFtjkNvaO6QpT20ZkpjTVLlGtV
         aLZT3WTydZFQm35wTNzsyX42aSuRXEfha5U2uAvOo7tnWbvcoaCJs1kuAnNp12YTBOCd
         hmxNSvaG7xvEd+LeGOjFx/fhKdLxNCiq00AbzqLE1Ev43K1sC10kVlsg8QKPneLmm1tZ
         2GDuWSBB5KH8xYCiw6hylOIBNHfsNXrtbnuHiHuexwk/WRqvQqZILD9S/EDTe/J27+en
         fiwE62yBbRNY4utfmMdjVsW5PCuIUZeKRLjUsFebun+22SQJFCGPZ9/cXQFFxhoMebqE
         bWbA==
X-Gm-Message-State: AOAM530u8NWsBhUCL4ffulu8qfZedZ0zhmwOjh6GmJUr4k+jwbb54SwA
        YMQJMEIuaV+k5X1mp6x4RPPnKELJrx8Yyg==
X-Google-Smtp-Source: ABdhPJyMrejerSWIYyizZ4TikgtH95cnKIl6MEmMLJeuW1uZyWpRl9K1ZVGVQcXYptPVnsyPZRS48A==
X-Received: by 2002:a17:902:ce8a:b0:161:af5e:a7b9 with SMTP id f10-20020a170902ce8a00b00161af5ea7b9mr4617438plg.167.1652967392691;
        Thu, 19 May 2022 06:36:32 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p40-20020a056a000a2800b0050dc76281ccsm569435pfh.166.2022.05.19.06.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 06:36:31 -0700 (PDT)
Message-ID: <5acb0323-a895-d4d9-77ab-edace723074e@kernel.dk>
Date:   Thu, 19 May 2022 07:36:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] blk-cgroup: provide stubs for blkcg_get_fc_appid()
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org
References: <20220519130207.6492-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519130207.6492-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 7:02 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.de>

This needs both an actual commit message and a Fixes tag.

-- 
Jens Axboe

