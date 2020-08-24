Return-Path: <SRS0=iUg4=CC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6DFC433E1
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BC620738
	for <linux-block@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgHXI0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:26:10 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:40300 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXI0H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Aug 2020 04:26:07 -0400
Received: by mail-pj1-f50.google.com with SMTP id d4so3816719pjx.5;
        Mon, 24 Aug 2020 01:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mkt3rcFCxED3Tw9DF+WLBW8MGX4QpUnA95wmoM9QugeNU2BT9I1ChTCb45SQIRtmj+
         vQXDjfKu+IPRgv6SBt3BAUZBJgHWloB2PbNYBKfCzlWI90WhZXxZYLOOgwySGO8Z970Z
         cqIm9peHwMr3I5b0LRQTIUlHyIeKrJ/IwK8dbioWnHNm+VSGzS3LltQ3QvhhnQ6t+YGB
         yso3zRm4371J5GpeB2lbk/7bthuNSOULkSobuUMNQ/i34jsPPI9YYJqmyHkUAmhNUyMY
         cKqRdZxv4qO8x4bzTF8IjilbggbE5qbtPkLdT0j2/YdA17Doz8RevwdjO4sJr7EOKiX5
         jCCQ==
X-Gm-Message-State: AOAM533ElI6QefvPs+Rf0XDdOUxY5cTkFtNzrUSSbdgbdz77BxcB4mm+
        LcWJBEdFJ2Uc75TwkirjrCQ=
X-Google-Smtp-Source: ABdhPJwX8zNdc7jFiZkEPKaTs4v/SLmNt0Dx7a+U6l+UKbsqW6vA00T1N6wB/78LH4C1jRnOhLPIPg==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr3156325plt.128.1598257566796;
        Mon, 24 Aug 2020 01:26:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id k5sm9452366pjq.5.2020.08.24.01.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:26:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] block: fix locking for struct block_device size
 updates
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Justin Sanders <justin@coraid.com>,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>,
        nbd@other.debian.org
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4021e83a-b107-df28-2266-38648c769c9d@grimberg.me>
Date:   Mon, 24 Aug 2020 01:26:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
