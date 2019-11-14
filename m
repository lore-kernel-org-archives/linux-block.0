Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D718C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EF420718
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 14:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Iukl2JLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNOI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:08:59 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:42723 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKNOI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:08:59 -0500
Received: by mail-io1-f47.google.com with SMTP id k13so6891192ioa.9
        for <linux-block@vger.kernel.org>; Thu, 14 Nov 2019 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IZwgKmH1FAobFu9aPkm4pTqaHcl3j2dKrzm5t8hdzjU=;
        b=Iukl2JLyDAGQkDzizJVV2gUe2YbuO3Z1oIbf49qui0lo5aL4YQhQPouOICeJ9J3qGN
         LZIYYHpFxRug60xT64uDxL9yMfi5v1r3z4LYSM2qGjNyEj240dq5YA51lyB0asKYTov3
         0DIKCYhDpaKWiUXrWkHOr1dUJ68IceGTAXMlZXi9FRexq3slQNJOshFhcPAF3JlxPRQW
         2R2/OFGBY+pOJarlI20JQtsvmHy7QntH9U4E8/MnJ0g3UV9/4J5OyZ+PwGWWJX7PXsx2
         6T0F+yOFDmBV/Yv0KAp2yLjUom+dK8matPex6XovhUPsXJAjKn3Y03DzDNwhtFK1DijQ
         sWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZwgKmH1FAobFu9aPkm4pTqaHcl3j2dKrzm5t8hdzjU=;
        b=dok95Vvh8+E3Jh+0PLkUdkeqc2fAuJbe6CO6cY6bwvxJ6M0rRztY3NktVL8iG92hyz
         ehf1UXUpubNLxI9fYKh2JIEqJ1U0XGepn+G8Y/mTWyGqdBfKmOh/VArmEwRfbQrOXrn3
         i8DVI/nj9myf3q5X/YeBd5TGgNzFhNW6JlSh0mcXWqy1Z1P0hG56+i8x7jW6C/soqg8Y
         NmGmLJeD0ehz9BoW9wbc/eIzyKvtpHJj9bKzr5OrQbtLnPYW2IYQVgKRkf8in356EtFB
         XumOeKKDAXGfr90xqTGMDw7LGgq7iP5Pd1A4lcH1Sxccw71X+184kGMg9iCrCIv/IUF2
         tDxA==
X-Gm-Message-State: APjAAAWuDYMug9nfT5jTIYP/vKPhL1UxcJNdYcd+F0mCimO3nJPqDTNG
        KA+vnQxkMbcnZ/aDCksQepJs9bTGXTI=
X-Google-Smtp-Source: APXvYqzq6/rW5qb0q4xiD0FoGvfebxZDSkHTSEkxFe2ku3aIsU4BhGp4FmozblzIlkV9S21Tmem+Ww==
X-Received: by 2002:a5d:80d5:: with SMTP id h21mr8292113ior.298.1573740536951;
        Thu, 14 Nov 2019 06:08:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t18sm573258ioc.41.2019.11.14.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 06:08:56 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191106151439.30056-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
Date:   Thu, 14 Nov 2019 07:08:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 8:14 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 

Were you going to re-send this on top of the other stuff for 5.5?
If so, should probably get queued up...

-- 
Jens Axboe

