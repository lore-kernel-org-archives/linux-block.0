Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC2C432BE
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A07F60EFF
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhHPQvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHPQvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:51:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47116C061292
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:51:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t35so27586389oiw.9
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
        b=2M7PsQmoW0m68H0tIVJvrAROv1UoWp/uy48nnzobRrc03mo4J/lqcPLEQEF1kpJUHw
         HQBa4gX5fuTsQap76AZD/5O7VV8iT7vusfHhUAUKN78fP0BZSnTbz5bFFrpuEHica0IG
         vNOnPFWucI7QTNpQA0kxldWWTEaok+vCXtpMF9OBhganoAYTPaU0jWc3pk2ipYfiP3qw
         KJv7dYM9ZKsD48MEvHmMnjHIhntqyqYB/aLy5wa1Nk3VqVwfnK6sD7DQ+glML2iy7RW5
         8bKOFtNVZE+7XBNUsAmXKRXSN7yXiZDUd4eqzd5A6g+KiYc52tKP/BJj3qVXfxUmmZ/Y
         b/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
        b=ebyJmW29cnP8b2LOYqiUBPnfB1rSfJg5t6NwVUgWShmPm2lDYmdG94d2k/HSC5YdwX
         yLnO4P8O3vfGdIVbI9kh8uno2OcHeDpKTGWhBu1TRcQk6iYg5WFQMUe5y4JlDklb1lBQ
         Crt7NvFRZOAn/kEhxQAdf6yqVLAbPuSR8Mh7G2BK+olbi4hj7XhyEHmOWi0PkviyMckX
         XB5cV+BH5ORQraoa0gtotOPhSAYszqN4B6GFyhuPeDn90T1ip9CEu+Evc+r1hnSnAjAM
         5YH9CTlg+oJOR2WljqLCnRz1WC4E8uN5U6OzhwAayjgLIk9OSRJ6161vBt2l0YAwzqdn
         a7kg==
X-Gm-Message-State: AOAM531LmG0JNJe6IoVs490smpIoQ5N3f9xgCqujtmiASaGSqHIRoXGP
        rVToqr5qK+xAip2xcAauDMSJOg==
X-Google-Smtp-Source: ABdhPJwPiJZucbHV+gTb5R7I/kfPLblHKKXb+EIub7hcvBOP41sFKxi/Q6epHu0YRXyVvO62JSl/PA==
X-Received: by 2002:a54:4619:: with SMTP id p25mr42850oip.5.1629132675579;
        Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u18sm2018498ooi.40.2021.08.16.09.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Subject: Re: add a bvec_virt helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
        Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20210804095634.460779-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4e321dab-188d-ca0a-a98c-4a587e7b5f27@kernel.dk>
Date:   Mon, 16 Aug 2021 10:51:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/21 3:56 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series adds a bvec_virt helper to return the virtual address of the
> data in bvec to replace the open coded calculation, and as a reminder
> that generall bio/bvec data can be in high memory unless it is caller
> controller or in an architecture specific driver where highmem is
> impossible.

Applied, thanks.

-- 
Jens Axboe

