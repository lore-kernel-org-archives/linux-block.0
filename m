Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08AC41621
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A64B20714
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GuHVyfLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCXN6e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:58:34 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:55976 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgCXN6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 09:58:34 -0400
Received: by mail-pj1-f43.google.com with SMTP id mj6so1516519pjb.5
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 06:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x5fXAGIMuTapier1gsbREHE5uidSK9jkxwBjZYaSvro=;
        b=GuHVyfLtEaQS6ua0IdE6tBWddbpDehK1t8pnI71T5sIFDkffsobUKQ4A4ckdACJlzi
         PerQQX9Qo6BJLQXl5vXmyumu2j+Oo/6WJgUeRrWlcScm6FdOlDNkXyueSmJJW7WrQY7X
         ZgkNC/Ym/lLm264Jbgd1w3jrXs/Sjbv+FeVrpPu8GQziZ+l2HH/bAuwdBIMts78UKzu2
         PgLG8T99SXdT7U7Ea6n9HF/10Yfbcw3mSga8g2/gdmzOcr5YJs5Rw/kHSGUnPGIm0M3i
         0Ft6bu+IiOn2ReSIc1tPlou6GSLa/FdCbHTrWDNLhJMPg2455K1qJihwbRXTKnklQn4e
         Njqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5fXAGIMuTapier1gsbREHE5uidSK9jkxwBjZYaSvro=;
        b=NJUOslL9r0+Cq4V9TpuLDURqaeBSl2bPWmXVpphLpT6IP8MqnpgdYHl1P0Qo+jJbZ0
         7b9v1/ENyzOtKWQ+nwS19EfA8/ZNhBxS3p3jFVHg3z34+cYdjRufFKSRR23xJqe3hQ+u
         PY6PHRo5YX6wYwAqSPnNmy1Ic2tgzsnBirBkRS69lRuTKSuL2HrZhmZ/oEJVOcGB+kZ/
         7gIj9VTBIXiUZYsIDBh5rPgaOEO+zerYV96mP4cIT1Uf3HTXYuv2giCBG1g4oNb4drE3
         EYtF+uRF0jTUPkjbuSI3Tf1HGJMI8qqXl49Pljj/lqHvjmGBsJDXRlwzZajth81V03E7
         nJXA==
X-Gm-Message-State: ANhLgQ0cn4pJJ4FK/TB1cnl3wNOhUI777t9kADXQyq3kSyIr7AiWT/kF
        ajolCNUeBPitYOnRgzSk1pV/VQ==
X-Google-Smtp-Source: ADFU+vsaJGMoiCAPmnmgto+goF4pP8bLqDaR5wU/oSKkxBsKicj5W2+zA/ckcACIUVr+G6j5uxGbPQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr5523042pjb.79.1585058311952;
        Tue, 24 Mar 2020 06:58:31 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 141sm761887pfu.174.2020.03.24.06.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 06:58:31 -0700 (PDT)
Subject: Re: cleanup the partitioning code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, reiserfs-devel@vger.kernel.org
References: <20200324072530.544483-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bafcc626-16bc-baeb-a0fe-2c2fe4cda14b@kernel.dk>
Date:   Tue, 24 Mar 2020 07:58:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324072530.544483-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 1:25 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the partitioning code.
> 
> Changes sinve v1:
>  - rebased to for-5.7/block

Applied, thanks.

-- 
Jens Axboe

