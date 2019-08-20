Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F688C3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A6F22DCC
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 13:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LVOmETGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfHTNq5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:46:57 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:32873 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfHTNq4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 09:46:56 -0400
Received: by mail-io1-f45.google.com with SMTP id z3so12276901iog.0
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ne+94cPFo/SkN/NTN2diba+DfBaSFsxhXIBcFFBIymE=;
        b=LVOmETGZdoxOWuIIcU/xeonAnLl3Jq4E1oVF8NHLupSyOdqXsrLnT3OxFeK2mq37/x
         zUjG36vDI80CvpR5nmcip2ws7BsqweW4xO9J+xOU4D1uSgCjoLkdWuMVx0sfS9wCn4Md
         7GC+ldB0+xRhA3USETZvjsz5qgk9MITdOQcoCyurO9LIE+ft9uAA5RQIB3/hPkNlcloI
         nokJq6EEivhPgL0pl7a8jQnCnPg7zN1IH5dFzquWr+DqxC5VCHHepuwE4/RUCsfnbJJr
         5HOTvy+3/xVoMVdtcmHcTqcEYxwa0U2jGaMWWqpQxa0smsD46vWoBo2MmeM6oF+h8vaH
         cVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ne+94cPFo/SkN/NTN2diba+DfBaSFsxhXIBcFFBIymE=;
        b=ebPTp9T+om3/rvTMagV6HUUKK4YeHj0ct1+8A3k9sgbs9YEG/dSkJx85Nbj2Xf17iL
         Lvl1CgsMsaEfxvtPCYQ5Mz6qOJBuzSC/7f6syeGBQYZDhCk3/vtbFjP8xELVDtoUDmGG
         +mrDpqrLuorv/MiVLGMHdYrkT2cmaWKzkd7CGzgunlpDFiUWlJ2y5s2xuRAxoexoHZqT
         rW3Xj9arvzDj2R5KdR6EBDTMKx+2o6X3MkT4RiOwPLNeYJQlYZQ67TMN+JZeKBfnk5Sx
         uOSbLoFvdQzKYiGnpM0rZpPHS4Zx1b8UWT/b7Fru2jBC7UYGzKta9Qrb1guALaigyASe
         btNg==
X-Gm-Message-State: APjAAAVjDx3h8b8fW1rLXJ7YeuvpiS9iWiGX9FnBJfs56EfjOfQEEj6D
        umunKWnzUnfe54SxUqcLLwA7TRtMfoxU/A==
X-Google-Smtp-Source: APXvYqyAkqaXqMXGYnHyhCgPvDB1GiMeNUd/9hIYwnE2bL5itK4SlnzYXMvUGdtHya3xjUcde8gHeQ==
X-Received: by 2002:a5d:8352:: with SMTP id q18mr30274898ior.154.1566308815536;
        Tue, 20 Aug 2019 06:46:55 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v13sm23975564iol.60.2019.08.20.06.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:46:54 -0700 (PDT)
Subject: Re: [PATCH] liburing/barrier.h: Add prefix to arm barriers
To:     Julia Suvorova <jusual@redhat.com>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>
References: <20190820124236.19608-1-jusual@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf1ef25a-9048-4aa8-9bae-f5b7ec94e4a9@kernel.dk>
Date:   Tue, 20 Aug 2019 07:46:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820124236.19608-1-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/19 6:42 AM, Julia Suvorova wrote:
> Rename the newly added arm barriers and READ/WRITE_ONCE
> to avoid using popular names.

Applied, thanks. I missed this when I applied yours.

-- 
Jens Axboe

