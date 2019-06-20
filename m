Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D9C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66CB206BF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ug1/ChKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFTQcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:32:48 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35215 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFTQcs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 12:32:48 -0400
Received: by mail-ed1-f45.google.com with SMTP id p26so5613689edr.2
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lWaahTvqeFpcpOtko+DL9aqqDWntV26lpwBJ5O+GW9Q=;
        b=Ug1/ChKVDzZOYIsyHhPlKIGz91/Caw12cOGtM3k4qGRp0QUaNpaZajCdz1zUwJVnUU
         7hrEBLN5/30FS9zP1pmuXFOeTOFVTWQv6iudmJr2WyzkGjk/jBIgpLHR5Hb7Hp9GwxAq
         iVNNU/nNvttkOibLuAO8CYjoTxQTFLqMWrNGki6x3KloaUI4L/P42naGG2d1RXzD92nS
         utDAceIRT21JKaiDyEJwfXUG0u4F5Z6UU798naR+FLS7p932QPO1usvR/BG+CHz26Ind
         NV5+qAwaZYvaYBM1V4c/jK0cYw81pun9SmNQEg58GsmqfIXyBRIjiMCUiIrfZIkqrLwe
         cLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lWaahTvqeFpcpOtko+DL9aqqDWntV26lpwBJ5O+GW9Q=;
        b=RhR6EbQNrJgRBv12EPlQ7tQOwwQAFsWF90hmlkAXWozI5MHd56VI3eswLP92PlIIKl
         3t2itqFJdgckM440ZaIHy3cr8OXUvgP9tI5RZSCq5wYSSZQcIckUhxsiafuKNQdU7FTn
         9vBUkgUuGX7ARCiqPikeSFGt5bHtUe7XN+qjFLHcfduroy8CpEr8IBNYJrptfjHMvA9B
         8WvSTvvQYqVmvYlh6rxrKmQE3rAYKSlsymieZws+3b/33GbWgYozN0fcreY+si1WkuVr
         QYz/bS8EoM/XT8mE6QbmFq14cXSJcdpOY7otJ/zDjdGKFMlEE7N8k1s/3yYe2LloCit1
         rJLw==
X-Gm-Message-State: APjAAAVGKewKJVzDQt4RuAyGvFF2NYKbdv04gZYff/SsBqBMIFAvQ5Zs
        UKPUAm2Gmrd/CRsQI7K4sRD6nA==
X-Google-Smtp-Source: APXvYqyUXASWweDho/JuDfLx0BFLxa/LvWX2vKj9OspUCh/7y6SIk9wCcu7jn9dzMR3d1xj/+9Smqw==
X-Received: by 2002:a50:9203:: with SMTP id i3mr123016558eda.302.1561048366254;
        Thu, 20 Jun 2019 09:32:46 -0700 (PDT)
Received: from [192.168.1.208] (ip-5-186-115-204.cgn.fibianet.dk. [5.186.115.204])
        by smtp.gmail.com with ESMTPSA id d3sm8925edd.88.2019.06.20.09.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 09:32:45 -0700 (PDT)
Subject: Re: blk-cgroup cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190606102624.3847-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2afccbe4-ef5e-6a74-551d-d91b2d1a267a@kernel.dk>
Date:   Thu, 20 Jun 2019 10:32:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 4:26 AM, Christoph Hellwig wrote:
> Hi all,
> 
> below are a couple of cleanups I came up with when trying to understand
> the blk-cgroup code.

Applied, thanks.

-- 
Jens Axboe

