Return-Path: <SRS0=/IjG=WH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C8C433FF
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 03:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79960208C2
	for <linux-block@archiver.kernel.org>; Sun, 11 Aug 2019 03:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dEYhpeOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfHKDmd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Aug 2019 23:42:33 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:34173 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKDmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Aug 2019 23:42:33 -0400
Received: by mail-pg1-f181.google.com with SMTP id n9so41596378pgc.1
        for <linux-block@vger.kernel.org>; Sat, 10 Aug 2019 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgsuYxiLoGK874FRLcdnMRboQnW+LHJZCrpaesp3KQA=;
        b=dEYhpeOm5qL+q+JRfzEGAOIurMo8YXGbve4fsJQ3YSjA60qHwxOrDVTrU3DLraGQHf
         qsc47u8JNaF+sOKhn4CU3XqZWEQQtuP9TtVJK+QEAmoWC4WVKkj1NmcX9N/h/IgOC/sD
         YZvCnUCrOSy08OZzYgm15uqwc+yxoPXKx+0rXMxtlFII22ac49yW5qKm7Kxks7JaGOYi
         T4gCWWfdFere442wz1iTqIgZI6EXKSTbRa76BVwSk7pT+5BX0I+zdfbV6xvCDsN+uM2Q
         9mS7JA1hMEMmcZnMzgA98P5Iy7j5UJzUpRZRflv/a6fRzU5F+1AeGHpg+lo3CrNEQ8GX
         OiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgsuYxiLoGK874FRLcdnMRboQnW+LHJZCrpaesp3KQA=;
        b=PIe5ukvgos5wK5xKZDacTD4+A8PFNZWlLQNilCtWyTBOjEARm45TZP7NX7j6HXAfdW
         ikpSoQiFUOgz4rsHwU6YwNYnq7r8f7dYZ9S1OvxFM2IS6bzwvja445d1VH4FI16gfSwQ
         NqqrdLznqXx6FeqIACgk+eJbDBi1dZoP7IT0XQXu5rWbpiPlvUMeqn8r5Z1CVbDCYX/r
         4HyrTQRDOq1ImNXYS61URQ4U3frlHyib5T7L6VpVUkplIUwZ9FsbM7iBYQOMTCiiWwpm
         BjEKEQ0VU5kOpTjfdLgj7z/ra+uQZsMiLSDt5RrHvuubUQIt4TcIEQhabneTssQ2NRJY
         igLg==
X-Gm-Message-State: APjAAAV1pd6FtkRn90xvuVPl04PQN4EguIYGTFz8VSZsNUoK083clvxl
        Nd7okGp+m+y2l7U509n43d61PrYYJqQ+tQ==
X-Google-Smtp-Source: APXvYqxZX2jyTF5PKPzqF2IK2XdCkET093y28kEoHcLuA8UyScUBAoB8KAwq20TDoTutPEL3ApyCcg==
X-Received: by 2002:aa7:92cb:: with SMTP id k11mr30121089pfa.126.1565494952137;
        Sat, 10 Aug 2019 20:42:32 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 97sm9368266pjz.12.2019.08.10.20.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 20:42:31 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for the next round of 5.3-rc
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190809180412.26392-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e49babd9-ed35-20e5-7826-a3d0a8ea9107@kernel.dk>
Date:   Sat, 10 Aug 2019 20:42:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809180412.26392-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/19 11:04 AM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Few nvme fixes for the next rc round.
> - detect capacity changes on the mpath disk from Anthony
> - probe/remove fix from Keith
> - various fixes to pass blktests from Logan
> - deadlock in reset/scan race fix
> - nvme-rdma use-after-free fix
> - deadlock fix when passthru commands race mpath disk info update

Pulled, thanks Sagi.

-- 
Jens Axboe

