Return-Path: <SRS0=0UXK=Q7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0BFC43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AA720842
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KKfxsmKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfBXPPd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:15:33 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:44549 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 10:15:32 -0500
Received: by mail-pl1-f177.google.com with SMTP id c4so3266408pls.11
        for <linux-block@vger.kernel.org>; Sun, 24 Feb 2019 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjcZEKAtKvbeEfJDUWDF8ciIQZpuvBY8FQNPfjWkxbg=;
        b=KKfxsmKoDgquHF3vsUs/9gLMQnE+1Pizw8yCClatrIJv+zPWU9dxaVvXICqExmJ0vb
         kGMb7yWfCwBB2dpYXNth20Mn5oqA2WTwpwLJuiVtclpUZnQa8hfnVZ7llb4tqRAQE1Lr
         YG43WYst2uhgN9WG3YPuS95HOi5HqWc/X+lEqKB90iOQFu7pL1h30xWNPQT3K3dx4IzX
         qj2eXvmSptKm7xryBDwxPX0EwauYELoNldlqd4SCnEz5X0AMvS0sBtOrzrjCjY376rWH
         8DaVAslOusW9ItF6bsOudogE7RdhqMKFBXqE5LEXxklF2dNQoKRxyJqefMP7kqZ930XV
         mbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjcZEKAtKvbeEfJDUWDF8ciIQZpuvBY8FQNPfjWkxbg=;
        b=oVZgumu77LYe+aYC41EV0dfVduLkkmT28F/1VYfkXK2CmXrqE54wmSNfuWB+zIkech
         ROY4HxfD3/hv7597zsHMVjQsQlt8GALt3v53fhEL2w7SocW4mfDHJGvr5YM/rauk3XlA
         aBOgRMEf1GOoiCd9oZnxLbLEfDPuqGo5mg0GPVH5HgP1aFlJyD8xQS+T5ww/eIWk1z1L
         zPuAF2j9/cH1VBeyR3Xcww12pikCci6g/3u+bNv3qOMftKP69ZwJGHE6jey8Hx3OsxTD
         ZpXUkV7FDg8g8aNWNu6MHvFWdnVSqCAnJ1rHZ4sXZxEbtuWu9TdK//cJu1NS9Qx67SeD
         eiGA==
X-Gm-Message-State: AHQUAublKWetq7OQfvqcefmustz0Scaee2PH9Vs/tda6qwnln4nPVZEN
        wkofUXrHjykggWDeIvpHMWSjPg==
X-Google-Smtp-Source: AHgI3IZhcZTQYPNR3eIVFbN41lmu50agTY6tMKIoYk/GXNHsJKyQj0KoGpF7K0RPOXyzpSjIY8/q+Q==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr14814920plb.169.1551021332087;
        Sun, 24 Feb 2019 07:15:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f14sm7909517pgv.23.2019.02.24.07.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:15:31 -0800 (PST)
Subject: Re: [PATCH] badblocks: Prefer unsigned int over unsigned
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190224141952.GA3653@bharath12345-Inspiron-5559>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk>
Date:   Sun, 24 Feb 2019 08:15:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190224141952.GA3653@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/19 7:19 AM, Bharath Vedartham wrote:
> Replace unsigned with unsigned int to improve readability.

Frivolous change, would make a lot more sense to get checkpatch
to stop complaining about this.

-- 
Jens Axboe

