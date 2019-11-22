Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76522C432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 01:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF442068D
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 01:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxDbIDPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKVB2Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:28:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44930 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVB2Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 20:28:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so2306322pjh.11;
        Thu, 21 Nov 2019 17:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jz0EfbEsNQAkLV1wwCUeENwLvrycSeRUXKL40gy/RCM=;
        b=gxDbIDPYIbaftf7A4iOgIRzb23HlGkbLpGLUuAq4rCDqhPb8h/RIvKtQNc12FC2idM
         7nn/5LsyE4zA5Cdz7WrlYcjWvxUTgH4Wi/LwLB3/MJhsQcVDUY3IkbA3s689X7Efgfmk
         vg0WKi4KJLHFmo52alK5yzza58kJGm7Qh/xinCfrgxsg9BXzv19+PHY/7+K4XbXqza5j
         LeMBreu9a1MBTqOkSKKwjRWpl3+EpdgF9kPMj1sTUcjpNkprJQ8SO2Zw6Z+XA6QeZwUi
         9v1jFB4RSP0sArRWdnawWXddEbm2iRGau2s0CjBuFmkiVTZ/XiVaLRqp6sSNLOaPD5V9
         3JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jz0EfbEsNQAkLV1wwCUeENwLvrycSeRUXKL40gy/RCM=;
        b=lP1gAM0riOxtEh/mKPol+ua77XiGNtt7VswRW48akFprqFwf/kevxEw5h1Zn+ozqNi
         hQ88Fi/yAj5vXtMUPvX+tyD42VBraMz0rp1f2vU9jcHrJA2RNmhR3vFzi6ux8xomSCNj
         HwianDgQrZZusxfUyUVNhRpqoG68QDjkE9GaLmOuw4HLEQ3msudRx2buNxKfXtFEamYZ
         tglqrbwi8rCAl1lDcjPmIaKFL/wKxTF+Kv9sDSJ/8sQbx21jYDGUeCY8jWnNbJHG8YiP
         mlFGBZe3hChdhZY5sbTO4J7bRFi5SbTTJhX2vyvKaZrlqDZXvKA+TYGHneNPvpKXjp1k
         eYmg==
X-Gm-Message-State: APjAAAVk0d+LQgzFP2UzR02lRA+ye52m6zY3U8MxHEMQgZDOAR5rg1BI
        KnzvAWRSW9om2G2lnLcrH1I=
X-Google-Smtp-Source: APXvYqwQ0a8d7FAp9NIk01KOrDsBzyhRPEoCvYfC3bVx5KzdzXfAszdCqSwZKauFekRinPKYyfVQbg==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr11876690pla.158.1574386095677;
        Thu, 21 Nov 2019 17:28:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id y4sm4404935pgy.27.2019.11.21.17.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:28:14 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:28:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: Fix Kconfig indentation
Message-ID: <20191122012812.GA161597@google.com>
References: <20191121132935.29604-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121132935.29604-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cc-ing Andrew

id: 20191121132935.29604-1-krzk@kernel.org

On (19/11/21 21:29), Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
