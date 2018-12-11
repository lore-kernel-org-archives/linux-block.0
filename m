Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D4C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819DD2054F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZymVH9XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819DD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLKOk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:40:26 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38376 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeLKOk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 09:40:26 -0500
Received: by mail-pg1-f180.google.com with SMTP id g189so6736961pgc.5
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 06:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iWCpYwztWbHVh/IwYrmpadXIxfIP89wjB7DLmKhNn50=;
        b=ZymVH9XWoZOqwYxhoNQlQBIjtg7XPlVUgZ6qEq55TWrkR2PnlVl3nN1c7ItrnbT0y4
         uXEGt+UsrSIYFIuHJ5mc2aKI981Opl8QvvReB99gbmMqAkHj4P8cONEO+8NnGVy4JiFw
         iNqCnH5i0GPITG0oYIQCkWEFHA7UY+9yA2S4E0G856OkZ5VVtMGn4X75sD+DtqVz5VUZ
         FCey0TM/GDB6fTvwJZTT4x5fQs8Ld9B+AY9oG6vED236AYwwIIyJBhwZM8aoATJSdgHY
         u02tiq3bFp2vECanSbu0owkDHeTgM/eymRjvZaH00LmLQwpYN0pk9YDjdPQT2b4A+Nbu
         WNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWCpYwztWbHVh/IwYrmpadXIxfIP89wjB7DLmKhNn50=;
        b=EmGb6PzViBgROaz9tpk2wIvX0SWuTiUHVFAH6JCy+fzrWif+hVR/ytBjiytXuXUDad
         mC5lsyNE9IbHTg4SIxgjxuPdSlAwk3BUbIADJjq1MiOcDm1PySANnLHGJpsNe4Psmfi0
         34Lf6nnkVj5M8T6fPlaqIM7arh+XN/rc5RqHWjmg5Pgo03oH7xv4tvVIiV3L1U2XkywK
         q3DMaDtUhUhCnrT3WnmfpT3s4m9/FjIRox8bW5xSNXMQWwpmP9w5OfPVRQL5Gb4CRQTk
         vN4bZTS2vhgN8eGO8L7skjQDzD58LM8mC5tOguZq/jIc6fRGf6DxbTK5d0+tpTrYxGKy
         0/xw==
X-Gm-Message-State: AA+aEWZfuM4zCuGp6uvRNOlBM/iHW9V0yTDHQutvsfk7IcnGiegvCX/5
        //Y13oMCbNCvjKEClld0IWAFzMut/fL2aQ==
X-Google-Smtp-Source: AFSGD/U0hl6TkOFQfLxW8tTN+x3ggyjJNiunn1Bwixo5ZM2ZoVX4H+DhjHKNO+nuFdSS9TUmRGDcWg==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr15108031pgc.3.1544539225899;
        Tue, 11 Dec 2018 06:40:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p7sm34770484pfj.72.2018.12.11.06.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:40:24 -0800 (PST)
Subject: Re: [PATCH] dm: fix request-based dm's use of dm_wait_for_completion
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20181211141026.30174-1-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f005f3db-a281-1de8-08c1-89464e28b375@kernel.dk>
Date:   Tue, 11 Dec 2018 07:40:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211141026.30174-1-snitzer@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 7:10 AM, Mike Snitzer wrote:
> The md->wait waitqueue is used by both bio-based and request-based DM.
> Commit dbd3bbd291 ("dm rq: leverage blk_mq_queue_busy() to check for
> outstanding IO") lost sight of the requirement that
> dm_wait_for_completion() must work with all types of DM devices.
> 
> Fix md_in_flight() to call the blk-mq or bio-based method accordingly.

Applied, thanks.

-- 
Jens Axboe

