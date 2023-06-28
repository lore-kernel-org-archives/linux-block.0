Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC759EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 07:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjF1Hz1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 03:55:27 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39122 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF1Hx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 03:53:56 -0400
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso1306813a12.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 00:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938835; x=1690530835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llewhcCw1fZpqsM1XkiLEtifsi3NiIC5iPdwF149TWY=;
        b=Vi1DZJ7Sz5R2M4Bapjxs1vXWK0Qpsqbhp+QQJBsiBTgqfMT0vsPoj7XS/vf/YNy1iy
         /j07cEfTyTRN9kzk0xpQ+f6LPqFStllteR2K5PuXS4PzRMmRibd2tSRw8h2KM5GsiN+t
         iG7WmeSo6J/r79HSlp2PukdIHkfkJ3oXi7ckMUcyodLPhppzcy9+xFh1t7Rc0w+41PqT
         pMnvNFtrRCWbkSxREDO6owOgHmvN4O+kKKRkd9BiqBef70gghix8LGCMDzmbqXSzzv35
         j2J+eNbIY4pC4OMXDLJRp3X+QuzdW+yEdrkuZrjtAuICJcJMg9BQB+4Mh9ogk6J5o0wU
         sRqw==
X-Gm-Message-State: AC+VfDxbAc4y7hEe9FkQSOOm4HlAF7FnZ8duI9DHPFYBx06YRkovvVH5
        VWOtEihOgowlGH1RjqUATqildhV4kCo=
X-Google-Smtp-Source: ACHHUZ6vt52UNX0JVWreukdXEYWnjtFEifQC7U+lp1BtAOwBCfHoLlkuQq++v+xSyHeI/U82bqHOVg==
X-Received: by 2002:ac2:4543:0:b0:4f9:5ffe:87f5 with SMTP id j3-20020ac24543000000b004f95ffe87f5mr9684309lfm.0.1687934813673;
        Tue, 27 Jun 2023 23:46:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b003fb5e3710d3sm4874498wmc.43.2023.06.27.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 23:46:53 -0700 (PDT)
Message-ID: <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
Date:   Wed, 28 Jun 2023 09:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi,

Do you have hostnqn and hostid files in your /etc/nvme directory?
