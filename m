Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3CFC43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 17:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498B122419
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 17:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nenrvZxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498B122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeKMDa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:30:57 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44858 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMDa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 22:30:57 -0500
Received: by mail-pg1-f172.google.com with SMTP id w3-v6so4355820pgs.11
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 09:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y096qYXCGV/OjoLwcLM7T3Y8gMBeQ6yFYq0XT8xD+yw=;
        b=nenrvZxb0Q6pUIMvAIqJ5FXhax6Xa/fY4Sz2gwcMCCAGokIlTMFPZacO5rjpFgr2k6
         cRIKGe3VEN0cSg2f+R83Oqkp6SP83HlB/N4kaf2EZ3riFLZDxypYVgGK3Ibn3oOgnAsj
         2KmEZAvYZZwnhgrR75mA2g96j+/osv4VHGiOWKCSd1tMSXXYPeMTvyAoIj+M2JNuwDKv
         9PhqIh69gPQXyN47ew5s6JfIsXfqe0gj5c7J9DEFCDuE1HQ1ltWzmeL2M1AnKTlC749u
         V5NMK+A3IhMxCPgzOuBmgB6e21gQ5WXfMKAsaK1Bz5i+E+TmwweogM3a6gW8Uy95BJYk
         MWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y096qYXCGV/OjoLwcLM7T3Y8gMBeQ6yFYq0XT8xD+yw=;
        b=j62aZxzr8COtg21yk3KQOMGGjvCAB56T5R7AeV9Fd/6EYeSKOx8tyDHTX4NdmjiXMc
         Xkf3HomqNa44jj/rlPkWcIZiGV2k7AzLT4l2sTxlDu4a5cdG0WhYB0X6qAeVDvUfTU1C
         VMan8oFiVGRT2Q15KbzbnaaD7MyJOgjyOhG9iUkx8YzZb23EVNXUBflyI7J4LLMNCChK
         yG4Sv5mgcIKvqyRHFjb/QHY7ZyNrIxaD/K7bNrnxJnX7haRk5ie41QSDIWw5TNuQoIZp
         C/9b/bn4OvH3FwLSW7JzG1o03GsAr6duipzYP1xeF44Wwp2X0oIdZU/YQtrEir88LmNh
         ZPeQ==
X-Gm-Message-State: AGRZ1gJ7SDep396psXEVyNSB8GlbTZCGQ6bk5vzk7gjSnl4vTpyqpq0x
        fKEa0/H4fnl5KzLi8JFzoLg+Aw==
X-Google-Smtp-Source: AJdET5cQG9ihJ0R0sHZxSr3NcKe0oJN2cBje/XGN7u4Yf1caCLc3LYiZeG9IkI1ev5Yu8ZWRX2ftlg==
X-Received: by 2002:a62:5285:: with SMTP id g127-v6mr1741441pfb.128.1542044203601;
        Mon, 12 Nov 2018 09:36:43 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m85-v6sm11626975pfj.171.2018.11.12.09.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:36:42 -0800 (PST)
Subject: Re: [PATCH v3] block: copy ioprio in __bio_clone_fast()
To:     Jean Delvare <jdelvare@suse.de>, linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.com>
References: <20181112102959.6d2f4984@endymion>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7121866c-f3d7-bcc7-be0f-2d12a62ebcd0@kernel.dk>
Date:   Mon, 12 Nov 2018 10:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112102959.6d2f4984@endymion>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/18 2:29 AM, Jean Delvare wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> We need to copy the io priority, too; otherwise the clone will run
> with a different priority than the original one.

Applied, thanks.

-- 
Jens Axboe

