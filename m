Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC1C4CEC9
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 23:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655C20693
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jJaYVqrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfINXJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 19:09:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37499 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfINXJM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 19:09:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so14901406plr.4
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2019 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jjy7WLC06UabcXJGEnoewA0bcwHmtjb9bGun5d6rqTU=;
        b=jJaYVqrILukIB8ADX6eZySnQWWNzGOMu1wZW0WB/QLImCkBdWRzw8evvQWySKdI7VD
         UPdggLUQem2WYaWgIDgqrz8Uz77pGmw6DfvpNsor/gcsJ5THBryT3OC4b/avUnHyGgUK
         Aqbkix0FFUWnuyeb6dzOwfbi44Zp3QZmK0DcUsFcSFYn4stGhTmuAEVsy6vAiPUrPxwV
         4E2IPqDa60uR6Rz0aYDijDW9twPFntFHDDuxNYBNbQ2iEEbS/cY6jnZ5h4xjjs9E4LB5
         aEOP22xLumrOVQ+oxlFDzrcKatd6cM2FwPaS/dZgclZqlEUY9TmyJ2VW2KbSLbtLsHH5
         ORNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jjy7WLC06UabcXJGEnoewA0bcwHmtjb9bGun5d6rqTU=;
        b=QdG1hrnobLnAllGOo2Yad1VwYM1T/dX5D5Q3LnsHVa38PQ5nLYHU9xAcUKwOuyehtb
         56UBJ/AVINYbtlMRvuQ8f44iYeitJvT1nsRYxK7Kc7JDP6x5vOyYyIX4t9cHOKAqaabG
         RJSoEYsa6t1E7rq+ovKDR77MyBAKFUYGob14G/49TyrHmnif9aWf1FW1+vW5mDYVJgWC
         8LuucwhQK/yiBmuZU8rffYV4WkjWdzZOpUzc/GtyZxBOPFtKrMVy/mOS6FFTLw4Zpb9L
         ecbtuJ2qPP5FOu87ruJ8x9wYRH3yo9FLKgeXueEPXVfaZVFWBsL0bt51JXAOsPPfZErJ
         rMOw==
X-Gm-Message-State: APjAAAWX5dbXZHwQuZLTx6gzj9tzbZqPFeXozs9wlUkEKzGz6W2ARXoU
        dWpKVsWtwmqw3/cxxggRDMusBQ==
X-Google-Smtp-Source: APXvYqxVipQbqNQpJ+KF/0o/4/71U1IZJYn97hTwEzEkdhAPOH3WHKKCF/sCDOm9xuCY9iQBkDVSaQ==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr4635692plc.62.1568502551031;
        Sat, 14 Sep 2019 16:09:11 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:f871:451d:4a26:44d6? ([2605:e000:100e:83a1:f871:451d:4a26:44d6])
        by smtp.gmail.com with ESMTPSA id u7sm26287556pgr.94.2019.09.14.16.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 16:09:09 -0700 (PDT)
Subject: Re: [PATCH] io_uring: increase IORING_MAX_ENTRIES to 32K
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     linux-block@vger.kernel.org, dmm@fb.com
References: <20190914212345.23861-1-dxu@dxuuu.xyz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff5ab7dc-f6c6-14a6-18f0-dbf94a1a9be4@kernel.dk>
Date:   Sat, 14 Sep 2019 17:09:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190914212345.23861-1-dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/19 3:23 PM, Daniel Xu wrote:
> Some workloads can require far more than 4K oustanding entries. For
> example memcached can have ~300K sockets over ~40 cores. Bumping the max
> to 32K seems to work pretty well.

Should clarify that this is for poll entries, not actual pending IO.
But makes sense, thanks, applied. We've got rlimit in place for mem
usage, so there's really no reason to put anything else in place before
bumping this (arbitrary) limit.

-- 
Jens Axboe

