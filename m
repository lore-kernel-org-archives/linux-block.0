Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF9EC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FA5206DD
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 19:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="tm7Ll0mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDZTyB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:54:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45256 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDZTyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 15:54:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id k92so1642167edc.12
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2019 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CclSjEmiXiSlhJvEM0nCka2oVLetq2OrybfVhVCKkf4=;
        b=tm7Ll0mqO6L7BLKjJljJoeSgMHTudSSJLpPCj2pF4XYHMU+RzGfje9567zd4y/B9N0
         d+3wDh77oIH3DBKRTD1wDd4v6Jeyi8s+1r0hyO4x7Ej3V0YjckFsR7vaxQD3xQL3Mt3s
         47AygZ3kOby78oWs1zLLZ6UN31eoaDR1W7wwxxZgO8WLdr/TNE3gClkow5BZnPYL7jgv
         +ysWa/QJktlj6PgduM/CJZayTVs/m7+RfZ6QQKUfXSkRtusffvcsb1J+ERzejhhYLR13
         dK9CPeH0e9KNq7W7VlBzaEBQxInLpE7aEut5h80xw5/7koSJioR54P5GCMVYU9a5s1gC
         gTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CclSjEmiXiSlhJvEM0nCka2oVLetq2OrybfVhVCKkf4=;
        b=JLFiP0v7ImK6LZ1qo/WgtwibI3tuEKPbaj9dIWj1jtKM6S9DT2PKWGUoDDOVqukMOU
         6NyPZq9URqiFlUnNuMnUNkc3bBVae6AhSHE/gREBMSDYBafOrGrN1GQY55oySc2ygFY/
         Tf5pnGFFBpmd7PFWzxtjqSgjVhiMrPdHy/Z0BqS4gf9ytHHs3REE/i5yV9gkou76fnMS
         RybKVNBfsSXfdXt68D4IoQU7WLJVA9HeLSKUOk6u/fzK6HhIubsU2MFqL4SbwKTXRm/z
         vfAjgJEWdM/Ybd7PCfHTVIQN3PLv5dVH/Ip/2PndzJRX/t5Rm1+dGZG8dRmE9dIGklSV
         dusw==
X-Gm-Message-State: APjAAAXLWVJWEbIJJxajVrwEupmEXjBqWVMMlLFfmym0P/XXwxdzL4yl
        DuQVrfikyL0zTAOGYRSnsFCvv6fksMM=
X-Google-Smtp-Source: APXvYqyTBFVEZXdtmhErdUBXpgG4farfeWxxxbedcaNrBP2506cJHQXTE639LatmoqCoo7jeNTmg+w==
X-Received: by 2002:a17:906:6312:: with SMTP id p18mr2142505ejk.143.1556308439031;
        Fri, 26 Apr 2019 12:53:59 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id q24sm1296980eda.25.2019.04.26.12.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 12:53:58 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] lightnvm: next set of improvements for 5.2
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190426133513.23966-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <087e8d6e-8cdc-87ff-6e2f-cb1fa2fd0396@lightnvm.io>
Date:   Fri, 26 Apr 2019 21:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190426133513.23966-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Igor. I've picked up 1 + 2.

The third I'm still noodling on. I think maybe one should bump the disk 
format, since it's changed. Also, if it is, it should be a static setup 
(i.e., 1,2,3), and not user configurable. Although, I do expect the 
separate parallel units to have enough device-side redundancy to provide 
adequate UBER.



On 4/26/19 3:35 PM, Igor Konopko wrote:
> This is another set of fixes and improvements to both pblk and lightnvm
> core.
> 
> Changes v4 -> v5:
> -dropped patches which were already pulled into for-5.2/core branch
> -rebasing of other patches
> -multiple copies of smeta patch moved into last position in series
> so it would be easier to pull only previous patches if needed
> 
> Changes v3 -> v4:
> -dropped patches which were already pulled into for-5.2/core branch
> -major changes for patch #2 based on code review
> -patch #6 modified to use krefs
> -new patch #7 which extends the patch #6
> 
> Changes v2 -> v3:
> -dropped some not needed patches
> -dropped patches which were already pulled into for-5.2/core branch
> -commit messages cleanup
> 
> Changes v1 -> v2:
> -dropped some not needed patches
> -review feedback incorporated for some of the patches
> -partial read path changes patch splited into two patches
> 
> 
> Igor Konopko (3):
>    lightnvm: pblk: simplify partial read path
>    lightnvm: pblk: use nvm_rq_to_ppa_list()
>    lightnvm: pblk: store multiple copies of smeta
> 
>   drivers/lightnvm/pblk-core.c     | 159 ++++++++++++++----
>   drivers/lightnvm/pblk-init.c     |  23 ++-
>   drivers/lightnvm/pblk-rb.c       |  11 +-
>   drivers/lightnvm/pblk-read.c     | 339 ++++++++++-----------------------------
>   drivers/lightnvm/pblk-recovery.c |  27 ++--
>   drivers/lightnvm/pblk-rl.c       |   3 +-
>   drivers/lightnvm/pblk.h          |  19 +--
>   7 files changed, 252 insertions(+), 329 deletions(-)
> 

