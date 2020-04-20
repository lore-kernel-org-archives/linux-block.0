Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC5C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7258F21473
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDTNnh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:43:37 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:34894 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgDTNnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 09:43:37 -0400
Received: by mail-pj1-f50.google.com with SMTP id ms17so4448420pjb.0;
        Mon, 20 Apr 2020 06:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JoL7larpzyH5iX/rf4Vk7J7BF8Tz5qYtFapR4pOM/Bk=;
        b=JO1Lg60Oha4cxftq7yQ0DuhPEPWuhHEvs86YmITKggtosz3+T0A6SMsefv6pxct+8j
         3HkO9RLvPdfqRZUDK84pMklsY7uxuIc5bc94iMzayGe/TbZ9SpX27DXpWWTWIfe8mhba
         dNasX2vDZqn0GMxPQQIb0f7uT6KjlX4oaJlpNw2apDH5OCvhds3477PMMleytVdTAp44
         jNLc4JjfEu87368jctWOJtsVGYJHWWghMtvI+rVQKJyo3aE6RTVpl51QT1tRqFsfEmpS
         mTxhPZmKNIWaRFc7RQSVek+Hq4PBnzqBPAnXhXaCl8eThNswETQ41UIceTVb7x6rfKZY
         7U1w==
X-Gm-Message-State: AGi0PuaJyRO9y+hRB/xs6T5QczwP/PCFC8VvLIJxK9x9wLVhi85m4c1q
        gA0ryspd8hSEmBmL2bQhjFE=
X-Google-Smtp-Source: APiQypLjLUEKZwjnKvQUj7O4uM3XDSaudjkn+w90Nf3N0Q0zgj93rWKm9sIw8dDU6imKQoS9X3qycw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr16602371plo.306.1587390216410;
        Mon, 20 Apr 2020 06:43:36 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.198.219])
        by smtp.gmail.com with ESMTPSA id j23sm1247267pjz.13.2020.04.20.06.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 06:43:35 -0700 (PDT)
Subject: Re: [PATCH 3/4] loop: Move loop_set_from_status() and friends up.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, Chaitanya.Kulkarni@wdc.com
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-4-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <df62d742-9e43-b6ed-580e-99b7675a885f@acm.org>
Date:   Mon, 20 Apr 2020 06:43:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420080409.111693-4-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 1:04 AM, Martijn Coenen wrote:
> So we can use it without forward declaration. This is a separate commit
> to make it easier to verify that this is just a move, without functional
> modifications.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
