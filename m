Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C5C282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F124218FE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UsBzIi6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfDXOGf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:06:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43520 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDXOGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 10:06:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so9430983pgu.10
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjZfbcUF3XtfiqL6Cc1MdpcoozBCFudzLOgDgYiM6TQ=;
        b=UsBzIi6p3b1VxwdAYGNlXLJkl5GZMNVpAgrvQQlpRJFZwrDeg2OeIho9+eawsO8nqo
         7/H6kCp+Ui9KdAYYaNV5rpMRsCVhqK+kJPAdRclpaWXtfXVAKc/0GbkzdGbMPK/Ux2PU
         kldKVQMuWaCuRNUlLAtT+QlnXdLozGJ6pOy5wUdTl4grOTkKFWOJWS3v1hOQCFxCaazy
         pMgRh+eHEwF+ni3dRhIWAKm3bvq6yoK2oov5DDvbkM0MZKqttn6fO8OSDeAtF/Wo1lwk
         pB1r4MgHGhQE4uu0kv/oV0s0B8g4YP1Cr4e3+XJdHruSDJuNtf6TTvtM68tf9RajZK1j
         blWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjZfbcUF3XtfiqL6Cc1MdpcoozBCFudzLOgDgYiM6TQ=;
        b=CsQeVaxXoPcI8rf5GSFGgTprK1/ZiqhJIYzvL4PlTsfyvVBRdaWrulvCAV7ZY7Nexj
         bGws5rpubLnRRz7DYT6vsk6q8WjSCupC70mRJoenLT8XpFQSjwhFwyZJ7qfjQgeuWsFh
         ftLuaB7Fl+I9/TRiZGM3h0yEzkIrqPKQ/4mdpt5OZ7hZXzDy9zYfDom8qfK9bWWVrf8U
         R6FVGZCuufNw7Aq2vAu6o38G1vi1chP9pERz392L7W3YAuzBSFo0ocGJk/DjxyIof0KN
         ZKudnb+K03+2/CoNa2E1YQCsdl/uKN01bRKx6q+yz6xFWGn7ijq5tkxEholqitLMgH7c
         DJKg==
X-Gm-Message-State: APjAAAWpf+ezOSnbfCF9hyOn0etTDzsstLdYJPNrp/F5hzYkJ3uUkMUy
        6NHFcdmvWqq3tJZxyli6SdpluA==
X-Google-Smtp-Source: APXvYqwcPETa1xWpvfcuadi1LFIajDRrh39vHqobmCMd9Q9TiRQlPx/OYBzvk3+E0CgjjS/zgpsqCw==
X-Received: by 2002:a63:2c4c:: with SMTP id s73mr30843054pgs.42.1556114794225;
        Wed, 24 Apr 2019 07:06:34 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u5sm28322259pfm.121.2019.04.24.07.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 07:06:33 -0700 (PDT)
Subject: Re: [PATCH] block: don't run get_page() on pages from non-bvec iov
 iter
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190424110146.17343-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73bc6dd4-20e9-0136-673f-1f92d6d84f51@kernel.dk>
Date:   Wed, 24 Apr 2019 08:06:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424110146.17343-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 5:01 AM, Ming Lei wrote:
> The refcount has been increased for pages retrieved from non-bvec iov iter
> via __bio_iov_iter_get_pages(), so don't need to do that again.
> 
> Otherwise, IO pages are leaked easily.

Thanks Ming, applied.

-- 
Jens Axboe

