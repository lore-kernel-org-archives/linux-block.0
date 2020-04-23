Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6887C55185
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D022075A
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDWAN0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:13:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43875 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDWAN0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 20:13:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id z6so1604527plk.10;
        Wed, 22 Apr 2020 17:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYu/22GmEqT6kkwt/S8fDcT6RlUYoDKf22bwaCHmIUI=;
        b=ISXsMUvTW/UOfljniBD4686JP1GTydlrjP+LmXhZDGEXMnhoMpSCarRYD8sJcQvwAU
         ri/IfG/uNTOHTm/1RSgrUIVAOEveCoc1LmH7ulEUfczFl0Todwm/KTXKENDXg/zoQPU6
         HPS5EZPpZbIsdGnYEM38zNiMdKoAVnI3Wqjy8vKilv0wqr6DMmDA9q2A9nKIspToORn6
         gotltNmWzvuG9ekCRjiGpxLeI3YOyN6F+2gbUIXDCq5NL7F5Ha3tRyNPQe6El5m1jar+
         AoGe7SO/bCQ0DUYaw9TfVHkQdVPCSa0amMYiJkSd6Si7DQPsK6VLncpRIKa+ksiecj1i
         Sp/Q==
X-Gm-Message-State: AGi0PubZBZitIcvJvJo93zw6Wyb5iNK0gY+gONQvuCWbp0/9PTv58P3r
        z7b9Ug5Cx1la3mdYrAGX06X+wSD9ggk=
X-Google-Smtp-Source: APiQypJZfSm+mNlMZoypfnx84TojTJg/zxXwWNx1CxIBN7ZSq/3mGlg1JnjKPtGEKtgNO/4VFeEB9w==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr717872pll.97.1587600805297;
        Wed, 22 Apr 2020 17:13:25 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id j26sm368817pgm.20.2020.04.22.17.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:13:24 -0700 (PDT)
Subject: Re: [PATCH 7/9] bdi: remove bdi_register_owner
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-8-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b803da7d-3811-22fd-33b2-a39c863268fd@acm.org>
Date:   Wed, 22 Apr 2020 17:13:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> Split out a new bdi_set_owner helper to set the owner, and move the policy
> for creating the bdi name back into genhd.c, where it belongs.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

