Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2517C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA78610EA
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 18:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhDOSRP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhDOSRO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 14:17:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73AFC061574
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 11:16:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a12so16603517pfc.7
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EmddyHEcT+NsvuTUCO/46rQDysacIjAC5yzv7qkl4H8=;
        b=DiSuzCu7p5LOVQb1enqyFF8sF2CvJpyL75hzdVH46hpe7J75yM5jC5x8PZXBRb4Grr
         AHzVJJKdqsVDjHYcFcsyTRqV9Wi+SDjcG2XqSYrRqv+Z1Xbx/utNB6M5BXfH3LFaJfUP
         agWHO18GBKboiEQ7YYN2Nr1g16s5ZIImC9XK3iyiQdbwscXROEb6ARR1qP2RW4PlLTHM
         nRf/adis8WzMh/VdYj6TMaq+r5Xw7yUEzmM4cKL8JSD3vc+1AWzOkdOlOTY3ffEUTVO2
         n/YD2tXm0WXer8njO+F+k5uAC+1m0TJ4MvZL9X+Hcr3Eqfq1a1M2MCgZd2QyEXSpKSy9
         DONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EmddyHEcT+NsvuTUCO/46rQDysacIjAC5yzv7qkl4H8=;
        b=a2dM9YqwOU5kzFss7gykt6UrDgbFax7TT4uWLtMHCXLNnNKqC5nA/eLYuBkM5bHJz0
         luW+iUZxmVPrlVrQxU+gAANz4OjUmRRCs7xHykD2lD6VnBDc+sa61k8duQKNrspdI2H1
         qFedbqrrtq4nJotkAi8XA/4E5Rqp+GvTml9f1k+9TWloM01oj0j0hb4I5s+kVINQrdPx
         GtpycZNkqdIsOnW9FTjAPwq/aqBImmXZiB5yl2XQzqa99E1zDWHf+IQTh9F8S27T80+3
         ZlAGJlQWnhHf4RIyi4nhv0OWtLkzJFgbhbg3mxx/Q0rAjpYyYan9UtJADlEuBJOKO4oz
         zTjA==
X-Gm-Message-State: AOAM533TfHNj/VC2TCXLuPVOCQfoEXC1dtvdyjDh4JwnxzlGSSpaK6x9
        c3SP+PWEw9fAMZt/F6thn50DXA==
X-Google-Smtp-Source: ABdhPJzTUF9dDEKKdhXPG7UohtSD6ib3Kqkry2sYMGrjzMn2nPwEHYuoqcQVjwPLskstYV5ak3SCdA==
X-Received: by 2002:a05:6a00:2303:b029:249:b91e:72f0 with SMTP id h3-20020a056a002303b0290249b91e72f0mr4328105pfh.80.1618510610047;
        Thu, 15 Apr 2021 11:16:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::1638? ([2620:10d:c090:400::5:6df0])
        by smtp.gmail.com with ESMTPSA id g12sm2671670pfo.114.2021.04.15.11.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:16:49 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YHhVrZD7/Q4qtFjL@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01993453-41bf-8e1a-4b26-cb194e6b8e86@kernel.dk>
Date:   Thu, 15 Apr 2021 12:16:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHhVrZD7/Q4qtFjL@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/21 9:03 AM, Christoph Hellwig wrote:
> The following changes since commit f8ee34a929a4adf6d29a7ef2145393e6865037ad:
> 
>   lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15 (2021-04-13 09:16:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-15

Pulled, thanks.

-- 
Jens Axboe

