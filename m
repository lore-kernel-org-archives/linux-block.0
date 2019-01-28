Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E057EC282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A716C2147A
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cbPNMJtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387897AbfA1Qys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:54:48 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:34617 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388492AbfA1Qyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:54:45 -0500
Received: by mail-io1-f54.google.com with SMTP id b16so14082427ior.1
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qn545jIUA/UiJGCesK3Wt23HR0JM/M4iCNnNsRn8yGU=;
        b=cbPNMJtYqFehBOTzLi6k8rZBCihN+8Mc3XvyKe/8P6dHhpZJMvz0oJvdxJM9KpaRFU
         65tXUXUs3XXLwoR+S71hnmcsakVolLNzDcQkRaSXVoha/DEO7SA/dQyuf1uuSGTa7rLq
         7ru6UUJ3BotzTTtpyFsuzhnTT3xL0x1NAECqqBb3FTThNgXE6VeCgyei5KHH+ZlAP8w4
         MEHcfn4zwswfLnLW8uu9K4vKeUhvdiV2DUpv6xcXzNAt69LBmHwc9mfZauQSCZVMPv1g
         dr4MNJuuAaIS/ogChPSrqVsrmh8TXuWseqgl2jzdR5jrpSeSu9k3v6lbvDJO+iCsgnsG
         yGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qn545jIUA/UiJGCesK3Wt23HR0JM/M4iCNnNsRn8yGU=;
        b=SLVaHAKHrX1yMjbDf1hn7eCg0lsGa1/lwFhsISkiAaICwlCMJAGtfVTvBGoha61+N/
         eIxaBiM+dZ3SZbEJoJKrdaCIuQDFkx0GtTyV2OnPV+TsJP84dZCIX7UIUvekrkx2dKuW
         P56V3UaKfVTKJBgMW4YerjJW6qIKXxlWJzJaI1jDb48JbnzE/1SEmzy9570mr/jEt9sm
         haoVe24elLFs/f88RSBrJljDxTrm1jtR1u5L1N1Xkz9yXm5QwSs3cjL/nY1oz9v4bv37
         zjDQdqCMA7scnzIKGvIWQjbLD+zWoWVj3NeBSR4CZqI9ZCaz63EVtq3pQVBP2PuIjrg+
         HdkA==
X-Gm-Message-State: AHQUAuYjZ+q74O+WJqu2M7SNE7LeK1TVMjSHcjUCDoRkvIsDqWH4LDyX
        XrYFbdONMHYKW8IQz8txBxPRALo707E=
X-Google-Smtp-Source: AHgI3IbikfwrnIykjtJpSr4rl6LZWTjeyvHM9jRW63T9GdZosSb+Jsxbpla7J11xlATjI3UdN5E/Ag==
X-Received: by 2002:a6b:d318:: with SMTP id s24mr13206950iob.6.1548694484300;
        Mon, 28 Jan 2019 08:54:44 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c13sm14951097iom.57.2019.01.28.08.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:54:42 -0800 (PST)
Subject: Re: [PATCH 11/18] block: implement bio helper to add iter bvec pages
 to bio
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-16-axboe@kernel.dk> <20190128143109.GD9563@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49621932-3f7e-943d-6a31-0c2c5c75f637@kernel.dk>
Date:   Mon, 28 Jan 2019 09:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128143109.GD9563@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:31 AM, Christoph Hellwig wrote:
>> +#define BIO_HOLD_PAGES	0	/* don't put O_DIRECT pages */
> 
> They don't really have to be O_DIRECT pages, just something with
> a permanent reference.  Maybe rename this to something BIO_NO_PAGE_REF?

That is a better name, thanks. I'll make the change.

-- 
Jens Axboe

