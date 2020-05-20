Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DDEC433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52629207D8
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pp/2eka3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETNis (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgETNis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 09:38:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4EC061A0E
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 06:38:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so1341314plo.7
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c0UczDjGmsoQKWTYkQ9GsSxcjBFSUOEscG+hKv4JHkY=;
        b=pp/2eka3I1/J28zKnbj7vEtsVNX1IjY/XsFmyAPa/FMdW3PHvQet1nKyhWzpMn3llM
         bmCakezOlGzvj+MPDaDAkU4ob/Z3R28LZi7mJGt9fUs79ExSJ9+AnJVkgyw+jDAWp4xU
         loxwYXT+OAmF2rWWHdNbH44ZcDVtXJ3TZPJdNI2w3GQFWO3WIkoXM3Mi02854ntriNAa
         YBzUygZcaRPxIkfooQITANMcZRF8ac3jdZuu0+C3sVJq+lIkPJhgt9QhhBzwUh1SFY9c
         rH7bUl/e4UuY/R/YSicVviwYTvxRWSp6XFHY7AJ7dx8xi2hTE8VobVajwuVpYg8DScTB
         SQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0UczDjGmsoQKWTYkQ9GsSxcjBFSUOEscG+hKv4JHkY=;
        b=gQRAcCDoiB7dV/11rxSa0HzXkJLyBIEwbmTysBFhoOfQXe/VGUnl0m9p3W5JqZER2P
         Z8Ngxhlfg/9jJI1T7P/A/D6uWiVrO++QnECCJzgEgKNvvMploUFH8MxfR2ZgSh9ACFAO
         cDddnIYtSsYertgl4hqM3oTpUlJwvoUHU21RXHyoxGWmA7pYKyJtBqj0orMnPyJLCWao
         2JUv7dYOD5JCVG7wpf9QDWJ3o6wojGRrwJqRqJMJIWi3ujuL8ZfYsAj0oRw6kPXS2/6r
         P8Hiv4fwX6FD/rVzGNZOOEkyfZrDOTEdKMITq++s1ka8Nwr6dTxb02lMQhRsADop8bQ9
         R20A==
X-Gm-Message-State: AOAM531wmvReS7xE0ttzj143kQr2yoPe+178AiWoV2+iFI6iDqCy44yn
        1W6f1Z+6fCC+miBVyCTUuPOXYCJgwLM=
X-Google-Smtp-Source: ABdhPJzL7fvYBmJ075EVfBXEJBjnNGjQ4SiQSNF6fiotC/r/XyPvYywXd6W8kXcGq8vzUyYOPvf1zQ==
X-Received: by 2002:a17:902:b618:: with SMTP id b24mr4683400pls.155.1589981927446;
        Wed, 20 May 2020 06:38:47 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id p190sm2221118pfp.207.2020.05.20.06.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 06:38:46 -0700 (PDT)
Subject: Re: [PATCH] blkparse: Print PID information for TN_MESSAGE events
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
References: <20200513160402.8050-1-jack@suse.cz>
 <d82a514e-390e-b268-dc19-45cb7be51ac7@kernel.dk>
 <20200520132039.GB30597@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f07d206-0771-5920-b625-8561ad486484@kernel.dk>
Date:   Wed, 20 May 2020 07:38:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520132039.GB30597@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:20 AM, Jan Kara wrote:
> On Tue 19-05-20 09:53:23, Jens Axboe wrote:
>> On 5/13/20 10:04 AM, Jan Kara wrote:
>>> The kernel now provides PID information for TN_MESSAGE events. Print it.
>>> Old kernels fill 0 there so the behavior is unaffected for them.
>>
>> Doesn't apply to the current repo, can you resend?
> 
> Likely because it is based on top of my blkparse fixes to deal with cgroup
> information in blktrace events. Did you pick up those? Rebasing this
> on-liner is simple enough but I'm just wondering...

Indeed, applied this one too. Thanks!

-- 
Jens Axboe

