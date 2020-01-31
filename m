Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE8C35240
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F071215A4
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gg6arANk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgAaREO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:04:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37223 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAaREN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 12:04:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so3645334pfn.4
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/mexr6QxywWf7SyyCZ/1qPELsIC6fZwcFBl68p0go0A=;
        b=Gg6arANkQecrnwiS0ssiZ+ogKlxeHoTs1rBaRbrfl88qKEMNvvkrRDW7AC6S5VVAH7
         k/G9Ccv/9VnMaU8m1KuVvJmqieI4IozsVhwR5n+IlMSX1vhuVtnVTyJfBxJwNz6LMdmK
         wW8OnrR3CKna8kkcxoDvoZMmFl6mg4v+lGPbrcre4cKp0SULZKb3iQZdL9HOdVh+qLSS
         CHKaHcfGu+kABU4Ru/6EKIHAMUwivt3a8nuHuTDhkggi+7AddSZYvNBf63vW9nANUwz2
         3yNeccnt9+FgSfE2sRUmcf9GNr1cTnwRAyC5lySCURJ7UHE43Ya8hH910yRe51/NhOcA
         n94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mexr6QxywWf7SyyCZ/1qPELsIC6fZwcFBl68p0go0A=;
        b=loFPwKem7PVc9EIxLBygIDB45of23ADNt0l8iyZfCf945sPsV36bc3PZSXkWYkgIFA
         KmtZqC8vj55aCyaEhdwSAUtckqi9yQLU+ZF3fl2yeLZf0xLDddVc1iA54kgN70Lihq+T
         DZqxWiQgZ/mr7r8je8sYGaiVXy1O9dL65/zfY0h270VdKd1d1au80zF+TM58eEz9SeC4
         lMrQ3K5ZikIE6JlbtSUOqY2T3h6IatgMu7rDtxJEXp9VjUzcqJWyC0khjT8YpMOgreO2
         5nhc1IKUpeHyMXLfaXdWE2rCKhMkRoJKSfD+NKJ+EZi5NxWfp9tobFhyxv9o2UyIYi0u
         Gz2A==
X-Gm-Message-State: APjAAAUZCVTYn2CQwALOihl7sgLzypmmtePYQfY9wxpXoVUubTd1BSIU
        k+jmS/EJAyePwzMu7txl2lwwCw==
X-Google-Smtp-Source: APXvYqzugkrNDN1dVqfcUPo751wL1S4sm+GCpT133MZqLi4TplgGregCwMah+gB4XJze8st1JMMaEQ==
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr11601678pgf.247.1580490253195;
        Fri, 31 Jan 2020 09:04:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1371? ([2620:10d:c090:180::d1ba])
        by smtp.gmail.com with ESMTPSA id v25sm10808615pfe.147.2020.01.31.09.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 09:04:12 -0800 (PST)
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
Date:   Fri, 31 Jan 2020 10:04:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131165421.GB29820@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
>> Hi Doug, Hi Jason, Hi Jens, Hi All,
>>
>> since we didn't get any new comments for the V8 prepared by Jack a
>> week ago do you think rnbd/rtrs could be merged in the current merge
>> window?
> 
> No, the cut off for something large like this would be rc4ish

Since it's been around for a while, I would have taken it in a bit
later than that. But not now, definitely too late. If folks are
happy with it, we can get it queued for 5.7.

-- 
Jens Axboe

