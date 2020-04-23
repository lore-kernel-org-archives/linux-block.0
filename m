Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FFC55186
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB1CC2077D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDWAQV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:16:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38570 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDWAQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 20:16:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id p8so1962916pgi.5;
        Wed, 22 Apr 2020 17:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80U7FiQ/VOZTn6gJNwfrWeqPkJLJYk8IXdQdWNgGo+8=;
        b=NgI4WKNw99ZBBNy+8teqol4kQgLk7qFgHMpFOVs6+Bne/9m+OW4qj54TK0vke0p5eU
         4he6NAJlmxPXBSsCfI/jd1vnruNuNsCY2eUoxaVvxU5g/HcESMO5SACkCw6mnNHc87JD
         kW8Am8RCJVDDEvC2CnfpEnrvsZ2CKq3mGpV1JCmujvycBy6T66b2lJ9M0QqJRwhsTgnd
         Itl9BmjXmmN7po995L+6XMK403UkEG3z8/ManVPyquLmAyZyrznAMvWVwjIRMPUOy42K
         XrFqAtxXJMgLrbROs+i1LYPglBceYJS9n5gUu75690BcuLvEzex384KRKi/E5AsammD8
         Pwxw==
X-Gm-Message-State: AGi0PuYKKkU3CNpTynWrWZoNDlYw3b4T9XYH1ewAoASGUROFtmU1zHx+
        xKDG1LmaDZBIhJ3kWHU9KYtjPVm+VN0=
X-Google-Smtp-Source: APiQypIx4f3UV2QI9DVUNYkPi71sBcWbAjL5vYvbMIt7MpPZw81/sWrXLySA3kZSe6Yi0gQu3lo96Q==
X-Received: by 2002:a63:5724:: with SMTP id l36mr1506470pgb.317.1587600978791;
        Wed, 22 Apr 2020 17:16:18 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.222])
        by smtp.gmail.com with ESMTPSA id t80sm703268pfc.23.2020.04.22.17.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:16:18 -0700 (PDT)
Subject: Re: [PATCH 9/9] bdi: remove the name field in struct backing_dev_info
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-10-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cecec426-b2cf-9b9a-f2d6-43ea94ef25ae@acm.org>
Date:   Wed, 22 Apr 2020 17:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> The name is only printed for a not registered bdi in writeback.  Use the
> device name there as is more useful anyway for the unlike case that the
> warning triggers.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

