Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED9C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9848E21929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gB/pOVSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbeLUTZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:25:10 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:33029 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeLUTZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:25:09 -0500
Received: by mail-io1-f46.google.com with SMTP id t24so4520220ioi.0
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1fY/u2LihyrsGpFpycU0YdxYfkBoJNuQ5vx08+YHK18=;
        b=gB/pOVSudKAcqRGKoHBJL+HtiCTnlm8TPoDE4f1qPAzkepDPbedObkiRjIa4mKB5gq
         hc1Dnc2lHtALsV2OaswJWqjI+jNXpY1w2OLTojgAHWQvLgsWr2eFeFYHv9OiB/io8mHz
         0Es2+syG8/Kbm6767sAMJGQVZs5UxnZNJAQ/JXgyMyURrg+hlUem6nXVN31fiYDzpzzf
         g1Qbb/NAiym5hNOiWU31FzpmGJLFch83zWuRd8HqOtZZWswpR4oKgIsFNwEixr1h+8Ni
         IWiCo3/3vV0npmIt+WZha/SJU5EbOjRcsJyILBAEYf5XoTPKuIC26xLiyWZm4vVpDZmU
         zCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fY/u2LihyrsGpFpycU0YdxYfkBoJNuQ5vx08+YHK18=;
        b=QlTQ6AoFdiaIVTRfdafNQcSjdfu905FxAJcN0uebKIBvaTg2QnAf1qYqRItQocNkXg
         6jOuM+OHLcAJI1faNs60gTx/fTwX4/mgvfZQ3exKzqbnAgjubw4Nwqa2NyEI4tWGXZme
         jcYLlL6T6i2kyxS35puaSuuJ+WYBgwUXTOCpUj+pf8rPMjSSGesYK0VRhIQTCBHni4iz
         t7wYCXFtuoR7cpRqaki1qjfJ7tivWRKfO1Q3vxtZAeTCz4sz/UjxUlFyKMZpKw3eGlMw
         6b+QLQI2uVhW+6vSJY0c0CSLpt1hHlJWEpYe+88QBx02whmMw+SD6Wx/to9UbBIt9K7s
         u7Nw==
X-Gm-Message-State: AJcUukcMciQ74kTJ5GtF6/8WyJQfMRZ+4M+3w6nMgc8ticx674kkbbaV
        uY+ZUcKCRFMDVmSeFrrvdC3j/g==
X-Google-Smtp-Source: ALg8bN5t4bL5yQf0HyVeYPqkj5mBjeUmo3SnjeLuc7EUkMyXYWacx0Quj9GyPHSql/NGwEkvoy6gNg==
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr2672879iob.100.1545420309140;
        Fri, 21 Dec 2018 11:25:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u20sm630259ioc.44.2018.12.21.11.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:25:08 -0800 (PST)
Subject: Re: [PATCH 04/22] block: use REQ_HIPRI_ASYNC for non-sync polled IO
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-5-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c34a6e3a-1142-4763-dfbe-9fa1b3579211@kernel.dk>
Date:   Fri, 21 Dec 2018 12:25:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221192236.12866-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/21/18 12:22 PM, Jens Axboe wrote:
> Tell the block layer if it's a sync or async polled request, so it can
> do the right thing.

Forgot to drop this one, please disregard it as it's super ceded by the
next patch anyway...

-- 
Jens Axboe

